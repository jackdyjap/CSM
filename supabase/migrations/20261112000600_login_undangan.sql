-- =====================================================================
-- 06 · LOGIN, UNDANGAN, DAN TAUTAN ATUR ULANG KATA SANDI (Fase 2)
--
-- Cara login yang dipilih (Cara B):
--   * Email + kata sandi, ATAU nomor HP + kata sandi (tanpa kode SMS).
--   * Akun hanya dibuat lewat tautan undangan dari pemimpin, atau oleh Admin.
--   * Lupa kata sandi: pemimpin/Admin membuat tautan atur ulang sekali pakai.
--
-- Fungsi bernama "layanan_..." hanya bisa dipanggil oleh server aplikasi
-- (memakai kunci service_role yang rahasia), tidak oleh pengguna.
-- =====================================================================


-- ---------------------------------------------------------------------
-- 1. AKUN OTOMATIS TERCATAT
-- Setiap kali sistem login (Supabase Auth) membuat pengguna baru,
-- satu baris di tabel akun ikut dibuat.
-- ---------------------------------------------------------------------
alter table public.akun add column login text;
comment on column public.akun.login is 'Email atau nomor HP yang dipakai untuk masuk (untuk ditampilkan).';

create function internal.akun_baru()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  insert into public.akun (id, nama_tampilan, login)
  values (
    new.id,
    coalesce(nullif(trim(new.raw_user_meta_data ->> 'nama'), ''),
             split_part(coalesce(new.email, new.phone, 'Pengguna'), '@', 1)),
    coalesce(nullif(trim(new.raw_user_meta_data ->> 'login'), ''), new.email, new.phone)
  )
  on conflict (id) do nothing;
  return new;
end;
$$;

create trigger akun_baru after insert on auth.users
  for each row execute function internal.akun_baru();

-- Pengguna yang sudah terlanjur dibuat sebelum file ini dijalankan.
insert into public.akun (id, nama_tampilan, login)
select u.id,
       coalesce(nullif(trim(u.raw_user_meta_data ->> 'nama'), ''),
                split_part(coalesce(u.email, u.phone, 'Pengguna'), '@', 1)),
       coalesce(nullif(trim(u.raw_user_meta_data ->> 'login'), ''), u.email, u.phone)
from auth.users u
on conflict (id) do nothing;

update public.akun a
   set login = coalesce(nullif(trim(u.raw_user_meta_data ->> 'login'), ''), u.email, u.phone)
  from auth.users u
 where u.id = a.id and a.login is null;


-- ---------------------------------------------------------------------
-- 2. TAUTAN ATUR ULANG KATA SANDI
-- Disimpan di ruang internal. Yang disimpan hanya "sidik jari" (hash)
-- tokennya, jadi token aslinya tidak bisa dibaca dari database.
-- ---------------------------------------------------------------------
create table internal.tautan_atur_ulang (
  id               uuid primary key default gen_random_uuid(),
  akun_id          uuid not null references public.akun(id) on delete cascade,
  token_hash       text not null unique,
  dibuat_oleh      uuid,
  kedaluwarsa_pada timestamptz not null default now() + interval '24 hours',
  dipakai_pada     timestamptz,
  dibuat_pada      timestamptz not null default now()
);
alter table internal.tautan_atur_ulang enable row level security;

create function internal.hash_token(p_token text)
returns text language sql immutable set search_path = ''
as $$ select encode(extensions.digest(coalesce(p_token, ''), 'sha256'), 'hex') $$;


-- ---------------------------------------------------------------------
-- 3. LOKET UNTUK PENGGUNA YANG SUDAH LOGIN
-- ---------------------------------------------------------------------

-- 3a. Siapa saya dan apa saja peran saya (untuk menyusun menu aplikasi).
create function public.peran_saya()
returns jsonb
language sql stable security definer set search_path = ''
as $$
  select jsonb_build_object(
    'akun_id', ak.id,
    'nama',    ak.nama_tampilan,
    'login',   ak.login,
    'admin',   bantu.saya_admin(),
    'ketua_tim', coalesce((
        select jsonb_agg(jsonb_build_object('tim_id', t.id, 'nama', t.nama) order by t.nama)
        from public.penugasan_peran p join public.tim t on t.id = p.tim_id
        where p.akun_id = ak.id and p.peran = 'ketua_tim'), '[]'::jsonb),
    'pemimpin', coalesce((
        select jsonb_agg(jsonb_build_object(
                 'kelompok_id', k.id, 'nama', k.nama, 'tim_nama', t.nama, 'jabatan', p.jabatan)
               order by k.nama)
        from public.penugasan_peran p
        join public.kelompok k on k.id = p.kelompok_id
        join public.tim t on t.id = k.tim_id
        where p.akun_id = ak.id and p.peran = 'pemimpin'), '[]'::jsonb),
    'anggota', (
        select jsonb_build_object('anggota_id', a.id, 'nama', a.nama_lengkap,
                                  'kelompok_id', k.id, 'kelompok_nama', k.nama)
        from public.anggota a join public.kelompok k on k.id = a.kelompok_id
        where a.id = ak.anggota_id)
  )
  from public.akun ak
  where ak.id = auth.uid();
$$;

-- 3b. Pemimpin membuat tautan undangan.
--     p_anggota kosong  = undangan untuk anggota baru.
--     p_anggota terisi  = undangan untuk profil yang sudah dibuat pemimpin.
create function public.buat_undangan(p_kelompok uuid, p_anggota uuid default null)
returns table (token text, kedaluwarsa_pada timestamptz)
language plpgsql security definer set search_path = ''
as $$
#variable_conflict use_column
begin
  if p_kelompok is null or p_kelompok not in (select bantu.kelompok_dipimpin()) then
    raise exception 'Anda hanya bisa membuat undangan untuk kelompok yang Anda pimpin.'
      using errcode = '42501';
  end if;

  if p_anggota is not null then
    if not exists (select 1 from public.anggota a
                   where a.id = p_anggota and a.kelompok_id = p_kelompok) then
      raise exception 'Anggota ini bukan anggota kelompok tersebut.' using errcode = '22023';
    end if;
    if exists (select 1 from public.akun ak where ak.anggota_id = p_anggota) then
      raise exception 'Anggota ini sudah punya akun.' using errcode = '22023';
    end if;
    -- Undangan lama yang belum dipakai untuk anggota ini dibatalkan.
    delete from public.undangan u where u.anggota_id = p_anggota and u.dipakai_pada is null;
  end if;

  return query
    insert into public.undangan (kelompok_id, anggota_id, dibuat_oleh)
    values (p_kelompok, p_anggota, auth.uid())
    returning undangan.token, undangan.kedaluwarsa_pada;
end;
$$;

-- 3c. Pemimpin melihat anggota mana yang sudah punya akun.
create function public.status_akun_anggota(p_kelompok uuid)
returns table (anggota_id uuid, punya_akun boolean, akun_id uuid, login text)
language plpgsql stable security definer set search_path = ''
as $$
#variable_conflict use_column
begin
  if p_kelompok is null or p_kelompok not in (select bantu.kelompok_dipimpin()) then
    raise exception 'Anda bukan pemimpin kelompok ini.' using errcode = '42501';
  end if;
  return query
    select a.id, ak.id is not null, ak.id, ak.login
    from public.anggota a
    left join public.akun ak on ak.anggota_id = a.id
    where a.kelompok_id = p_kelompok;
end;
$$;

-- 3d. Membuat tautan atur ulang kata sandi (berlaku 24 jam, sekali pakai).
--     Admin: untuk akun siapa saja.
--     Pemimpin/wakil: hanya untuk anggota kelompoknya yang BUKAN staf
--     (supaya pemimpin tidak bisa mengambil alih akun pemimpin lain).
create function public.buat_tautan_atur_ulang(p_akun uuid)
returns table (token text, kedaluwarsa_pada timestamptz)
language plpgsql security definer set search_path = ''
as $$
#variable_conflict use_column
declare
  v_token text := encode(extensions.gen_random_bytes(24), 'hex');
  v_boleh boolean;
  v_kedaluwarsa timestamptz;
begin
  v_boleh := bantu.saya_admin() or (
        p_akun <> auth.uid()
    and not exists (select 1 from public.penugasan_peran p where p.akun_id = p_akun)
    and exists (select 1 from public.akun ak join public.anggota a on a.id = ak.anggota_id
                where ak.id = p_akun and a.kelompok_id in (select bantu.kelompok_dipimpin()))
  );
  if not coalesce(v_boleh, false) or not exists (select 1 from public.akun where id = p_akun) then
    raise exception 'Anda tidak berhak membuat tautan atur ulang untuk akun ini.' using errcode = '42501';
  end if;

  delete from internal.tautan_atur_ulang t where t.akun_id = p_akun and t.dipakai_pada is null;

  insert into internal.tautan_atur_ulang as t (akun_id, token_hash, dibuat_oleh)
  values (p_akun, internal.hash_token(v_token), auth.uid())
  returning t.kedaluwarsa_pada into v_kedaluwarsa;

  perform internal.catat_log('buat_tautan_atur_ulang', jsonb_build_object('akun_id', p_akun));
  return query select v_token, v_kedaluwarsa;
end;
$$;

revoke all on function public.peran_saya()                     from public, anon;
revoke all on function public.buat_undangan(uuid, uuid)        from public, anon;
revoke all on function public.status_akun_anggota(uuid)        from public, anon;
revoke all on function public.buat_tautan_atur_ulang(uuid)     from public, anon;
grant execute on function public.peran_saya()                  to authenticated;
grant execute on function public.buat_undangan(uuid, uuid)     to authenticated;
grant execute on function public.status_akun_anggota(uuid)     to authenticated;
grant execute on function public.buat_tautan_atur_ulang(uuid)  to authenticated;


-- ---------------------------------------------------------------------
-- 4. LOKET KHUSUS SERVER (service_role)
-- Dipanggil server aplikasi saat orang membuka tautan undangan atau
-- tautan atur ulang (orang itu belum/tidak bisa login).
-- ---------------------------------------------------------------------

-- 4a. Cek undangan sebelum formulir pendaftaran ditampilkan.
create function public.layanan_cek_undangan(p_token text)
returns table (berlaku boolean, kelompok_nama text, tim_nama text, nama_anggota text)
language sql stable security definer set search_path = ''
as $$
  select (u.dipakai_pada is null and u.kedaluwarsa_pada > now()
          and not exists (select 1 from public.akun ak
                          where u.anggota_id is not null and ak.anggota_id = u.anggota_id)),
         k.nama, t.nama, a.nama_lengkap
  from public.undangan u
  join public.kelompok k on k.id = u.kelompok_id
  join public.tim t      on t.id = k.tim_id
  left join public.anggota a on a.id = u.anggota_id
  where u.token = p_token;
$$;

-- 4b. Memakai undangan: sambungkan akun baru ke profil anggota.
--     Bila undangan untuk anggota baru, profil dibuat (hanya nama; data
--     pribadi diisi setelah persetujuan, di Fase 3).
create function public.layanan_pakai_undangan(p_token text, p_akun uuid, p_nama text)
returns uuid
language plpgsql security definer set search_path = ''
as $$
declare
  v_undangan public.undangan;
  v_anggota  uuid;
begin
  select * into v_undangan from public.undangan u where u.token = p_token for update;

  if v_undangan.id is null or v_undangan.dipakai_pada is not null
     or v_undangan.kedaluwarsa_pada <= now() then
    raise exception 'Tautan undangan tidak berlaku atau sudah dipakai.' using errcode = '22023';
  end if;
  if not exists (select 1 from public.akun where id = p_akun and anggota_id is null) then
    raise exception 'Akun tidak ditemukan atau sudah terhubung ke anggota lain.' using errcode = '22023';
  end if;

  if v_undangan.anggota_id is null then
    insert into public.anggota (kelompok_id, nama_lengkap)
    values (v_undangan.kelompok_id, trim(p_nama))
    returning id into v_anggota;
  else
    v_anggota := v_undangan.anggota_id;
    if exists (select 1 from public.akun where anggota_id = v_anggota) then
      raise exception 'Anggota ini sudah punya akun.' using errcode = '22023';
    end if;
  end if;

  update public.akun set anggota_id = v_anggota where id = p_akun;
  update public.undangan set dipakai_pada = now(), dipakai_oleh = p_akun where id = v_undangan.id;

  perform internal.catat_log('pakai_undangan',
    jsonb_build_object('akun_id', p_akun, 'anggota_id', v_anggota, 'kelompok_id', v_undangan.kelompok_id));
  return v_anggota;
end;
$$;

-- 4c. Cek tautan atur ulang (untuk menampilkan nama di halaman).
create function public.layanan_cek_tautan_atur_ulang(p_token text)
returns table (berlaku boolean, nama text)
language sql stable security definer set search_path = ''
as $$
  select (t.dipakai_pada is null and t.kedaluwarsa_pada > now()), ak.nama_tampilan
  from internal.tautan_atur_ulang t
  join public.akun ak on ak.id = t.akun_id
  where t.token_hash = internal.hash_token(p_token);
$$;

-- 4d. Memakai tautan atur ulang: mengembalikan id akun lalu menandainya
--     sudah dipakai. Penggantian kata sandi dilakukan server lewat Supabase Auth.
create function public.layanan_pakai_tautan_atur_ulang(p_token text)
returns uuid
language plpgsql security definer set search_path = ''
as $$
declare
  v_id   uuid;
  v_akun uuid;
begin
  select t.id, t.akun_id into v_id, v_akun
  from internal.tautan_atur_ulang t
  where t.token_hash = internal.hash_token(p_token)
    and t.dipakai_pada is null and t.kedaluwarsa_pada > now()
  for update;

  if v_id is null then
    raise exception 'Tautan atur ulang tidak berlaku atau sudah dipakai.' using errcode = '22023';
  end if;

  update internal.tautan_atur_ulang set dipakai_pada = now() where id = v_id;
  perform internal.catat_log('pakai_tautan_atur_ulang', jsonb_build_object('akun_id', v_akun));
  return v_akun;
end;
$$;

revoke all on function public.layanan_cek_undangan(text)              from public, anon, authenticated;
revoke all on function public.layanan_pakai_undangan(text, uuid, text) from public, anon, authenticated;
revoke all on function public.layanan_cek_tautan_atur_ulang(text)     from public, anon, authenticated;
revoke all on function public.layanan_pakai_tautan_atur_ulang(text)   from public, anon, authenticated;
grant execute on function public.layanan_cek_undangan(text)              to service_role;
grant execute on function public.layanan_pakai_undangan(text, uuid, text) to service_role;
grant execute on function public.layanan_cek_tautan_atur_ulang(text)     to service_role;
grant execute on function public.layanan_pakai_tautan_atur_ulang(text)   to service_role;

revoke all on all functions in schema internal from public, anon, authenticated;
