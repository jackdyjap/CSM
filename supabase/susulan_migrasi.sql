-- =====================================================================
-- SUSULAN MIGRASI · menjalankan file migrasi yang TERLEWAT, sekaligus
--
-- Cara pakai: salin SELURUH isi file ini ke Supabase → SQL Editor → Run.
-- File ini memeriksa satu per satu (…0600 sampai …2600) apakah sudah
-- pernah dijalankan, lalu hanya menjalankan yang belum, berurutan.
-- Aman dijalankan berulang kali. Bila ada galat, semuanya dibatalkan
-- (tidak ada yang setengah jadi).
--
-- Hanya untuk database yang sudah menjalankan fase1_sekali_jalan.sql.
-- Dibuat otomatis oleh tests/lokal/buat_susulan.py; jangan diubah dengan tangan.
-- =====================================================================
do $susulan$
declare
  v_dijalankan text[] := '{}';
begin
  if to_regprocedure('internal.jaga_anggota()') is null then
    raise exception 'Jalankan fase1_sekali_jalan.sql terlebih dahulu.';
  end if;

  -- 20261112000600_login_undangan.sql
  if not (exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'internal' and p.proname = 'akun_baru')) then
    execute $mig0600$
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

$mig0600$;
    v_dijalankan := v_dijalankan || '20261112000600_login_undangan.sql'::text;
  end if;

  -- 20261117000700_mode_pertemuan.sql
  if not (exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'internal' and p.proname = 'jaga_tanggal_pertemuan')) then
    execute $mig0700$
-- =====================================================================
-- 07 · MODE PERTEMUAN (Fase 4)
--   1. Tanggal pertemuan tidak boleh di masa depan (hari ini atau yang lalu).
--   2. Loket tutup_pertemuan(): menutup absensi dan menandai TIDAK HADIR
--      anggota aktif yang belum ditandai hadir.
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1. Penjaga tanggal pertemuan
-- ---------------------------------------------------------------------
create function internal.jaga_tanggal_pertemuan()
returns trigger language plpgsql set search_path = ''
as $$
begin
  if new.tanggal > bantu.hari_ini_wib() then
    raise exception 'Tanggal pertemuan tidak boleh di masa depan.' using errcode = '23514';
  end if;
  return new;
end;
$$;

create trigger jaga_tanggal_pertemuan before insert or update of tanggal on public.pertemuan
  for each row execute function internal.jaga_tanggal_pertemuan();


-- ---------------------------------------------------------------------
-- 2. Menutup absensi
--   * Hanya pemimpin/wakil kelompok pertemuan tersebut.
--   * Anggota yang ditandai tidak hadir: masih aktif, sudah bergabung pada
--     tanggal pertemuan, dan belum punya catatan kehadiran di pertemuan itu.
--     Anggota yang sudah tidak aktif tidak ikut ditandai.
--   * Aman dipanggil berulang (setelah dibuka kembali): tidak ada data ganda.
--   Mengembalikan jumlah anggota yang ditandai tidak hadir.
-- ---------------------------------------------------------------------
create function public.tutup_pertemuan(p_pertemuan uuid)
returns integer
language plpgsql security definer set search_path = ''
as $$
declare
  v_kelompok uuid;
  v_tanggal  date;
  v_jumlah   integer;
begin
  select p.kelompok_id, p.tanggal into v_kelompok, v_tanggal
  from public.pertemuan p
  where p.id = p_pertemuan and p.kelompok_id in (select bantu.kelompok_dipimpin());

  if v_kelompok is null then
    raise exception 'Pertemuan tidak ditemukan atau bukan kelompok Anda.' using errcode = '42501';
  end if;

  insert into public.kehadiran (pertemuan_id, anggota_id, hadir, dicatat_oleh)
  select p_pertemuan, a.id, false, auth.uid()
  from public.anggota a
  where a.kelompok_id = v_kelompok
    and a.aktif
    and a.bergabung_pada <= v_tanggal
    and not exists (select 1 from public.kehadiran h
                    where h.pertemuan_id = p_pertemuan and h.anggota_id = a.id)
  on conflict on constraint kehadiran_unik do nothing;
  get diagnostics v_jumlah = row_count;

  update public.pertemuan
     set dibuka_pada  = coalesce(dibuka_pada, now()),
         ditutup_pada = now()
   where id = p_pertemuan;

  return v_jumlah;
end;
$$;

revoke all on function public.tutup_pertemuan(uuid) from public, anon;
grant execute on function public.tutup_pertemuan(uuid) to authenticated;

$mig0700$;
    v_dijalankan := v_dijalankan || '20261117000700_mode_pertemuan.sql'::text;
  end if;

  -- 20261117000800_admin_kelola_semua.sql
  if not (exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'bantu' and p.proname = 'kelompok_dipimpin_langsung')) then
    execute $mig0800$
-- =====================================================================
-- 08 · ADMIN MENGELOLA SEMUA KELOMPOK (keputusan 12, 17 November 2026)
--
-- Admin kini boleh MELIHAT dan MENGUBAH anggota, foto, undangan,
-- pertemuan, absensi, persembahan, dan proyek ketaatan di SEMUA kelompok,
-- seperti pemimpin kelompok tersebut.
--
-- Caranya: bantu.kelompok_dipimpin() — dipakai oleh semua aturan akses dan
-- fungsi "khusus pemimpin" — kini juga mengembalikan semua kelompok bila
-- pengguna adalah Admin.
--
-- PENGECUALIAN: catatan khusus tetap hanya DITULIS oleh pemimpin/wakil
-- kelompoknya sendiri (Admin dan Ketua Tim hanya membaca). Untuk itu ada
-- pemeriksa baru bantu.boleh_tulis_catatan() yang dipakai ketiga fungsi
-- tulis/ubah/hapus catatan.
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1. Kelompok yang dikelola: dipimpin langsung + semua kelompok bila Admin.
-- ---------------------------------------------------------------------
create or replace function bantu.kelompok_dipimpin()
returns setof uuid
language sql stable security definer
set search_path = ''
as $$
  select kelompok_id from public.penugasan_peran
  where akun_id = auth.uid() and peran = 'pemimpin'
  union
  select k.id from public.kelompok k
  where bantu.saya_admin();
$$;
comment on function bantu.kelompok_dipimpin() is
  'Kelompok yang boleh saya kelola: yang saya pimpin (pemimpin/wakil), atau semua kelompok bila saya Admin.';

-- Kelompok yang saya pimpin LANGSUNG (tanpa perluasan Admin).
create function bantu.kelompok_dipimpin_langsung()
returns setof uuid
language sql stable security definer
set search_path = ''
as $$
  select kelompok_id from public.penugasan_peran
  where akun_id = auth.uid() and peran = 'pemimpin';
$$;

-- Bolehkah saya MENULIS catatan khusus tentang anggota ini?
-- Hanya pemimpin/wakil kelompoknya, dan tidak tentang diri sendiri.
create function bantu.boleh_tulis_catatan(p_anggota uuid)
returns boolean
language sql stable security definer
set search_path = ''
as $$
  select p_anggota is distinct from bantu.anggota_saya()
     and exists (
       select 1 from public.anggota a
       where a.id = p_anggota
         and a.kelompok_id in (select bantu.kelompok_dipimpin_langsung())
     );
$$;

revoke all on function bantu.kelompok_dipimpin_langsung() from public, anon;
revoke all on function bantu.boleh_tulis_catatan(uuid)     from public, anon;
grant execute on function bantu.kelompok_dipimpin_langsung() to authenticated;
grant execute on function bantu.boleh_tulis_catatan(uuid)     to authenticated;


-- ---------------------------------------------------------------------
-- 2. Fungsi catatan: tetap khusus pemimpin/wakil (isi lainnya tidak berubah).
-- ---------------------------------------------------------------------
create or replace function public.tulis_catatan(
  p_anggota uuid,
  p_jenis   public.jenis_catatan,
  p_isi     text,
  p_tanggal date default null
)
returns uuid
language plpgsql security definer set search_path = ''
as $$
declare
  v_id uuid;
begin
  if not bantu.boleh_tulis_catatan(p_anggota) then
    raise exception 'Anda tidak berhak menulis catatan untuk anggota ini.' using errcode = '42501';
  end if;

  insert into public.catatan_khusus (anggota_id, penulis_id, tanggal, jenis, isi)
  values (p_anggota, auth.uid(), coalesce(p_tanggal, bantu.hari_ini_wib()), p_jenis, trim(p_isi))
  returning id into v_id;

  perform internal.catat_log('tulis_catatan',
    jsonb_build_object('catatan_id', v_id, 'anggota_id', p_anggota));
  return v_id;
end;
$$;

create or replace function public.ubah_catatan(
  p_catatan uuid,
  p_isi     text,
  p_jenis   public.jenis_catatan default null
)
returns void
language plpgsql security definer set search_path = ''
as $$
declare
  v_anggota uuid;
begin
  select c.anggota_id into v_anggota from public.catatan_khusus c where c.id = p_catatan;
  if v_anggota is null or not bantu.boleh_tulis_catatan(v_anggota) then
    raise exception 'Catatan tidak ditemukan atau Anda tidak berhak mengubahnya.' using errcode = '42501';
  end if;

  update public.catatan_khusus
     set isi = trim(p_isi), jenis = coalesce(p_jenis, jenis)
   where id = p_catatan;

  perform internal.catat_log('ubah_catatan',
    jsonb_build_object('catatan_id', p_catatan, 'anggota_id', v_anggota));
end;
$$;

create or replace function public.hapus_catatan(p_catatan uuid)
returns void
language plpgsql security definer set search_path = ''
as $$
declare
  v_anggota uuid;
begin
  select c.anggota_id into v_anggota from public.catatan_khusus c where c.id = p_catatan;
  if v_anggota is null or not bantu.boleh_tulis_catatan(v_anggota) then
    raise exception 'Catatan tidak ditemukan atau Anda tidak berhak menghapusnya.' using errcode = '42501';
  end if;

  delete from public.catatan_khusus where id = p_catatan;

  perform internal.catat_log('hapus_catatan',
    jsonb_build_object('catatan_id', p_catatan, 'anggota_id', v_anggota));
end;
$$;

$mig0800$;
    v_dijalankan := v_dijalankan || '20261117000800_admin_kelola_semua.sql'::text;
  end if;

  -- 20261117000900_koreksi_data.sql
  if not (exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'public' and p.proname = 'hapus_kelompok_total')) then
    execute $mig0900$
-- =====================================================================
-- 09 · KOREKSI DATA (keputusan 13–15, 17 November 2026)
--   1. Admin boleh mengubah nama tampilan akun siapa pun.
--   2. Admin boleh menghapus kelompok BESERTA seluruh isinya, setelah
--      mengetik nama kelompok persis (loket hapus_kelompok_total).
--   3. Catatan khusus yang salah tulis boleh diubah/dihapus oleh pemimpin
--      kelompoknya DAN Admin. Menulis catatan baru tetap khusus pemimpin.
-- Perbaikan lain (nama tim/kelompok, pindah tim, hapus/pindah anggota,
-- ubah tanggal pertemuan) sudah diizinkan aturan akses sebelumnya.
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1. Admin mengubah nama akun. Hak kolom tetap hanya nama_tampilan
--    (lihat file 03), jadi penghubung akun ke profil tidak bisa diubah.
-- ---------------------------------------------------------------------
create policy "akun: admin mengubah nama" on public.akun
  for update to authenticated
  using ((select bantu.saya_admin())) with check ((select bantu.saya_admin()));


-- ---------------------------------------------------------------------
-- 2. Hapus kelompok beserta seluruh isinya (khusus Admin).
--    Terhapus: pertemuan (+ absensi, kunci QR), proyek ketaatan
--    (+ status), anggota (+ catatan khusus, status, foto masuk antrean
--    hapus), undangan, dan penugasan pemimpin/wakil kelompok itu.
--    Akun login anggota TIDAK dihapus; hanya dilepas dari profilnya.
-- ---------------------------------------------------------------------
create function public.hapus_kelompok_total(p_kelompok uuid, p_konfirmasi text)
returns jsonb
language plpgsql security definer set search_path = ''
as $$
declare
  v_nama     text;
  v_hasil    jsonb;
  v_anggota  integer;
  v_pertemuan integer;
  v_proyek   integer;
begin
  if not bantu.saya_admin() then
    raise exception 'Hanya Admin yang boleh menghapus kelompok.' using errcode = '42501';
  end if;

  select k.nama into v_nama from public.kelompok k where k.id = p_kelompok;
  if v_nama is null then
    raise exception 'Kelompok tidak ditemukan.' using errcode = '22023';
  end if;
  if coalesce(trim(p_konfirmasi), '') <> trim(v_nama) then
    raise exception 'Nama yang diketik tidak sama dengan nama kelompok. Tidak ada yang dihapus.'
      using errcode = '22023';
  end if;

  delete from public.pertemuan       where kelompok_id = p_kelompok;
  get diagnostics v_pertemuan = row_count;
  delete from public.proyek_ketaatan where kelompok_id = p_kelompok;
  get diagnostics v_proyek = row_count;
  delete from public.anggota         where kelompok_id = p_kelompok;
  get diagnostics v_anggota = row_count;
  delete from public.kelompok        where id = p_kelompok;

  v_hasil := jsonb_build_object('kelompok', v_nama, 'anggota', v_anggota,
                                'pertemuan', v_pertemuan, 'proyek', v_proyek);
  perform internal.catat_log('hapus_kelompok_total', v_hasil || jsonb_build_object('kelompok_id', p_kelompok));
  return v_hasil;
end;
$$;

revoke all on function public.hapus_kelompok_total(uuid, text) from public, anon;
grant execute on function public.hapus_kelompok_total(uuid, text) to authenticated;


-- ---------------------------------------------------------------------
-- 3. Koreksi catatan khusus: pemimpin kelompoknya atau Admin,
--    dan tidak pernah tentang diri sendiri.
-- ---------------------------------------------------------------------
create function bantu.boleh_koreksi_catatan(p_anggota uuid)
returns boolean
language sql stable security definer
set search_path = ''
as $$
  select bantu.boleh_tulis_catatan(p_anggota)
      or (bantu.saya_admin() and p_anggota is distinct from bantu.anggota_saya()
          and exists (select 1 from public.anggota a where a.id = p_anggota));
$$;
revoke all on function bantu.boleh_koreksi_catatan(uuid) from public, anon;
grant execute on function bantu.boleh_koreksi_catatan(uuid) to authenticated;

create or replace function public.ubah_catatan(
  p_catatan uuid,
  p_isi     text,
  p_jenis   public.jenis_catatan default null
)
returns void
language plpgsql security definer set search_path = ''
as $$
declare
  v_anggota uuid;
begin
  select c.anggota_id into v_anggota from public.catatan_khusus c where c.id = p_catatan;
  if v_anggota is null or not bantu.boleh_koreksi_catatan(v_anggota) then
    raise exception 'Catatan tidak ditemukan atau Anda tidak berhak mengubahnya.' using errcode = '42501';
  end if;
  if length(trim(coalesce(p_isi, ''))) = 0 then
    raise exception 'Isi catatan tidak boleh kosong.' using errcode = '23514';
  end if;

  update public.catatan_khusus
     set isi = trim(p_isi), jenis = coalesce(p_jenis, jenis)
   where id = p_catatan;

  perform internal.catat_log('ubah_catatan',
    jsonb_build_object('catatan_id', p_catatan, 'anggota_id', v_anggota));
end;
$$;

create or replace function public.hapus_catatan(p_catatan uuid)
returns void
language plpgsql security definer set search_path = ''
as $$
declare
  v_anggota uuid;
begin
  select c.anggota_id into v_anggota from public.catatan_khusus c where c.id = p_catatan;
  if v_anggota is null or not bantu.boleh_koreksi_catatan(v_anggota) then
    raise exception 'Catatan tidak ditemukan atau Anda tidak berhak menghapusnya.' using errcode = '42501';
  end if;

  delete from public.catatan_khusus where id = p_catatan;

  perform internal.catat_log('hapus_catatan',
    jsonb_build_object('catatan_id', p_catatan, 'anggota_id', v_anggota));
end;
$$;

$mig0900$;
    v_dijalankan := v_dijalankan || '20261117000900_koreksi_data.sql'::text;
  end if;

  -- 20261117001000_bukti_persembahan.sql
  if not (to_regclass('public.bukti_persembahan') is not null) then
    execute $mig1000$
-- =====================================================================
-- 10 · BUKTI TRANSFER PERSEMBAHAN (keputusan 16, 17 November 2026)
--   * Opsional; boleh diunggah menyusul.
--   * Foto (jpeg/png/webp) atau PDF, maksimal 5 MB per berkas,
--     maksimal 5 berkas per pertemuan.
--   * Dilihat oleh pemimpin/wakil, Ketua Tim terkait, dan Admin.
--     Diunggah/dihapus oleh pemimpin/wakil dan Admin. Anggota tidak melihat.
--   * Lokasi berkas: bukti-persembahan/<id pertemuan>/<nama berkas>
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1. Antrean hapus berkas kini mencatat foldernya (bucket), karena tidak
--    hanya berisi foto anggota lagi.
-- ---------------------------------------------------------------------
alter table internal.antrean_hapus_foto
  add column bucket text not null default 'foto-anggota';


-- ---------------------------------------------------------------------
-- 2. Folder penyimpanan privat
-- ---------------------------------------------------------------------
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('bukti-persembahan', 'bukti-persembahan', false, 5242880,
        array['image/jpeg', 'image/png', 'image/webp', 'application/pdf'])
on conflict (id) do update
  set public = false,
      file_size_limit = excluded.file_size_limit,
      allowed_mime_types = excluded.allowed_mime_types;


-- ---------------------------------------------------------------------
-- 3. Daftar bukti per pertemuan
-- ---------------------------------------------------------------------
create table public.bukti_persembahan (
  id            uuid primary key default gen_random_uuid(),
  pertemuan_id  uuid not null references public.pertemuan(id) on delete cascade,
  kelompok_id   uuid not null references public.kelompok(id),  -- diisi otomatis dari pertemuan
  lokasi        text not null unique,
  nama_berkas   text not null check (length(trim(nama_berkas)) > 0),
  jenis         text not null check (jenis in ('image/jpeg', 'image/png', 'image/webp', 'application/pdf')),
  ukuran        integer not null check (ukuran > 0 and ukuran <= 5242880),
  diunggah_oleh uuid references public.akun(id) on delete set null default auth.uid(),
  dibuat_pada   timestamptz not null default now(),
  constraint bukti_di_folder_pertemuan check (lokasi like pertemuan_id::text || '/%')
);
create index on public.bukti_persembahan (pertemuan_id);
create index on public.bukti_persembahan (kelompok_id);
comment on table public.bukti_persembahan is 'Bukti transfer persembahan (berkas di folder privat bukti-persembahan).';

alter table public.bukti_persembahan enable row level security;
revoke all on public.bukti_persembahan from anon;
revoke update on public.bukti_persembahan from authenticated;
grant select, insert, delete on public.bukti_persembahan to authenticated;

create policy "bukti: baca sesuai peran" on public.bukti_persembahan
  for select to authenticated
  using (kelompok_id in (select bantu.kelompok_terbaca()));
create policy "bukti: pemimpin/admin menambah" on public.bukti_persembahan
  for insert to authenticated
  with check (kelompok_id in (select bantu.kelompok_dipimpin()));
create policy "bukti: pemimpin/admin menghapus" on public.bukti_persembahan
  for delete to authenticated
  using (kelompok_id in (select bantu.kelompok_dipimpin()));


-- ---------------------------------------------------------------------
-- 4. Penjaga: kelompok diisi dari pertemuan, berkasnya harus benar-benar
--    sudah diunggah, dan paling banyak 5 bukti per pertemuan.
-- ---------------------------------------------------------------------
create function internal.jaga_bukti_persembahan()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  select p.kelompok_id into new.kelompok_id
  from public.pertemuan p where p.id = new.pertemuan_id;

  if not exists (select 1 from storage.objects o
                 where o.bucket_id = 'bukti-persembahan' and o.name = new.lokasi) then
    raise exception 'Berkas bukti belum terunggah. Coba unggah ulang.' using errcode = '23514';
  end if;

  perform 1 from public.pertemuan p where p.id = new.pertemuan_id for update;
  if (select count(*) from public.bukti_persembahan b where b.pertemuan_id = new.pertemuan_id) >= 5 then
    raise exception 'Maksimal 5 bukti per pertemuan. Hapus yang tidak perlu terlebih dahulu.'
      using errcode = '23514';
  end if;
  return new;
end;
$$;

create trigger jaga_bukti_persembahan before insert on public.bukti_persembahan
  for each row execute function internal.jaga_bukti_persembahan();

-- Saat bukti dihapus (termasuk ikut terhapus bersama pertemuan/kelompok),
-- berkasnya masuk antrean hapus.
create function internal.setelah_bukti_dihapus()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  insert into internal.antrean_hapus_foto (foto_path, bucket) values (old.lokasi, 'bukti-persembahan');
  return old;
end;
$$;

create trigger setelah_bukti_dihapus after delete on public.bukti_persembahan
  for each row execute function internal.setelah_bukti_dihapus();

revoke all on function internal.jaga_bukti_persembahan() from public, anon, authenticated;
revoke all on function internal.setelah_bukti_dihapus()  from public, anon, authenticated;


-- ---------------------------------------------------------------------
-- 5. Aturan akses berkas di folder bukti-persembahan.
--    Folder pertama pada lokasi berkas = id pertemuan.
-- ---------------------------------------------------------------------
create function bantu.kelompok_pertemuan(p_pertemuan uuid)
returns uuid
language sql stable security definer
set search_path = ''
as $$
  select kelompok_id from public.pertemuan where id = p_pertemuan;
$$;
revoke all on function bantu.kelompok_pertemuan(uuid) from public, anon;
grant execute on function bantu.kelompok_pertemuan(uuid) to authenticated;

create policy "bukti persembahan: lihat" on storage.objects
  for select to authenticated
  using (bucket_id = 'bukti-persembahan'
         and bantu.kelompok_pertemuan(bantu.teks_ke_uuid((storage.foldername(name))[1]))
             in (select bantu.kelompok_terbaca()));

create policy "bukti persembahan: unggah" on storage.objects
  for insert to authenticated
  with check (bucket_id = 'bukti-persembahan'
              and bantu.kelompok_pertemuan(bantu.teks_ke_uuid((storage.foldername(name))[1]))
                  in (select bantu.kelompok_dipimpin()));

create policy "bukti persembahan: hapus" on storage.objects
  for delete to authenticated
  using (bucket_id = 'bukti-persembahan'
         and bantu.kelompok_pertemuan(bantu.teks_ke_uuid((storage.foldername(name))[1]))
             in (select bantu.kelompok_dipimpin()));

$mig1000$;
    v_dijalankan := v_dijalankan || '20261117001000_bukti_persembahan.sql'::text;
  end if;

  -- 20261117001100_tindak_lanjut.sql
  if not (exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'public' and p.proname = 'tindak_lanjut')) then
    execute $mig1100$
-- =====================================================================
-- 11 · TINDAK LANJUT (Fase 5, keputusan 17)
--   Daftar anggota yang perlu ditindaklanjuti dalam satu kelompok:
--   * ABSEN : anggota aktif yang tidak hadir di 3 pertemuan terakhir
--             (yang sudah ditutup) secara berturut-turut;
--   * PROYEK: proyek ketaatan yang tenggatnya sudah lewat tetapi belum
--             selesai, atau yang ditandai "tidak dikerjakan".
--   Dihitung di database; dipakai halaman tindak lanjut (Fase 5) dan
--   dashboard Ketua Tim (Fase 6).
-- =====================================================================

create function public.tindak_lanjut(p_kelompok uuid, p_batas_absen integer default 3)
returns table (
  anggota_id      uuid,
  nama_lengkap    text,
  jenis           text,                      -- 'absen' | 'proyek'
  absen_beruntun  integer,                   -- untuk jenis 'absen'
  terakhir_hadir  date,                      -- untuk jenis 'absen' (null = belum pernah)
  alasan_terakhir public.alasan_absen,       -- untuk jenis 'absen'
  proyek_id       uuid,                      -- untuk jenis 'proyek'
  proyek_judul    text,
  tenggat         date,
  status          public.status_pengerjaan
)
language plpgsql stable security definer set search_path = ''
as $$
#variable_conflict use_column
declare
  v_hari_ini date := bantu.hari_ini_wib();
begin
  if p_kelompok is null or p_kelompok not in (select bantu.kelompok_terbaca()) then
    raise exception 'Anda tidak berhak melihat tindak lanjut kelompok ini.' using errcode = '42501';
  end if;

  return query
  -- 1. Absen berturut-turut di pertemuan yang sudah ditutup.
  with riwayat as (
    select h.anggota_id, h.hadir, h.alasan, p.tanggal,
           row_number() over (partition by h.anggota_id order by p.tanggal desc) as urutan
    from public.kehadiran h
    join public.pertemuan p on p.id = h.pertemuan_id
    where p.kelompok_id = p_kelompok and p.ditutup_pada is not null
  ),
  ringkas as (
    select r.anggota_id,
           coalesce(min(r.urutan) filter (where r.hadir) - 1, count(*))::integer as beruntun,
           max(r.tanggal) filter (where r.hadir)                               as terakhir_hadir,
           (array_agg(r.alasan order by r.urutan))[1]                         as alasan_terakhir
    from riwayat r
    group by r.anggota_id
  )
  select a.id, a.nama_lengkap, 'absen'::text, rk.beruntun, rk.terakhir_hadir, rk.alasan_terakhir,
         null::uuid, null::text, null::date, null::public.status_pengerjaan
  from ringkas rk
  join public.anggota a on a.id = rk.anggota_id
  where a.aktif and a.kelompok_id = p_kelompok
    and rk.beruntun >= greatest(coalesce(p_batas_absen, 3), 1)

  union all

  -- 2. Proyek ketaatan yang belum selesai setelah tenggat, atau "tidak dikerjakan".
  select a.id, a.nama_lengkap, 'proyek'::text, null::integer, null::date, null::public.alasan_absen,
         pk.id, pk.judul, pk.tenggat, coalesce(sp.status, 'belum'::public.status_pengerjaan)
  from public.proyek_ketaatan pk
  join public.anggota a on a.kelompok_id = pk.kelompok_id and a.aktif
  left join public.status_proyek sp on sp.proyek_id = pk.id and sp.anggota_id = a.id
  where pk.kelompok_id = p_kelompok
    -- anggota yang bergabung setelah proyek diberikan hanya dihitung bila sudah diberi status
    and (a.bergabung_pada <= pk.diberikan_pada or sp.anggota_id is not null)
    and (
          coalesce(sp.status, 'belum') = 'tidak_dikerjakan'
       or (pk.tenggat is not null and pk.tenggat < v_hari_ini
           and coalesce(sp.status, 'belum') <> 'selesai')
        )
  order by 3, 2;
end;
$$;

revoke all on function public.tindak_lanjut(uuid, integer) from public, anon;
grant execute on function public.tindak_lanjut(uuid, integer) to authenticated;

$mig1100$;
    v_dijalankan := v_dijalankan || '20261117001100_tindak_lanjut.sql'::text;
  end if;

  -- 20261117001200_admin_tulis_catatan.sql
  if not (exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'public' and p.proname = 'ringkasan_tim')) then
    execute $mig1200$
-- =====================================================================
-- 12 · ADMIN BOLEH MENULIS CATATAN KHUSUS (keputusan 18, 17 November 2026)
-- Sebelumnya (keputusan 12 dan 15) Admin hanya membaca dan mengoreksi.
-- Kini Admin juga boleh menulis catatan baru di semua kelompok.
-- Tetap berlaku: Ketua Tim hanya membaca; tidak seorang pun boleh menulis
-- atau membaca catatan tentang dirinya sendiri.
-- =====================================================================
create or replace function bantu.boleh_tulis_catatan(p_anggota uuid)
returns boolean
language sql stable security definer
set search_path = ''
as $$
  -- kelompok_dipimpin() mencakup semua kelompok bila Admin (migrasi 0800).
  select p_anggota is distinct from bantu.anggota_saya()
     and exists (
       select 1 from public.anggota a
       where a.id = p_anggota
         and a.kelompok_id in (select bantu.kelompok_dipimpin())
     );
$$;

$mig1200$;
    v_dijalankan := v_dijalankan || '20261117001200_admin_tulis_catatan.sql'::text;
  end if;

  -- 20261117001300_ringkasan_tim.sql
  if not (exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'public' and p.proname = 'ringkasan_tim')) then
    execute $mig1300$
-- =====================================================================
-- 13 · RINGKASAN TIM UNTUK DASHBOARD KETUA TIM (Fase 6, keputusan 20)
--   Satu baris per kelompok di tim:
--   * anggota aktif;
--   * status lapor PEKAN INI (Senin–Minggu WIB):
--       'sudah'       = ada pertemuan pekan ini yang absensinya DITUTUP,
--       'berlangsung' = ada pertemuan pekan ini tapi absensinya belum ditutup,
--       'belum'       = belum ada pertemuan pekan ini;
--   * tanggal pertemuan terakhir;
--   * rata-rata kehadiran 4 pekan (28 hari terakhir, pertemuan yang ditutup),
--     dalam persen: jumlah hadir / jumlah tercatat;
--   * total persembahan BULAN INI (bulan kalender WIB);
--   * jumlah anggota yang perlu ditindaklanjuti (fungsi tindak_lanjut).
--   Hanya untuk Ketua Tim dari tim itu dan Admin.
-- =====================================================================

create function public.ringkasan_tim(p_tim uuid)
returns table (
  kelompok_id         uuid,
  nama                text,
  anggota_aktif       integer,
  status_lapor        text,
  pertemuan_terakhir  date,
  hadir_4_pekan       numeric,
  persembahan_bulan_ini numeric,
  tindak_lanjut       integer
)
language plpgsql stable security definer set search_path = ''
as $$
#variable_conflict use_column
declare
  v_hari_ini   date := bantu.hari_ini_wib();
  v_senin      date := date_trunc('week', bantu.hari_ini_wib())::date;   -- minggu dimulai Senin
  v_awal_bulan date := date_trunc('month', bantu.hari_ini_wib())::date;
begin
  if p_tim is null or not (bantu.saya_admin() or p_tim in (select bantu.tim_diketuai())) then
    raise exception 'Anda tidak berhak melihat ringkasan tim ini.' using errcode = '42501';
  end if;

  return query
  select
    k.id,
    k.nama,
    (select count(*)::integer from public.anggota a where a.kelompok_id = k.id and a.aktif),
    case
      when exists (select 1 from public.pertemuan p
                   where p.kelompok_id = k.id and p.tanggal between v_senin and v_senin + 6
                     and p.ditutup_pada is not null) then 'sudah'
      when exists (select 1 from public.pertemuan p
                   where p.kelompok_id = k.id and p.tanggal between v_senin and v_senin + 6) then 'berlangsung'
      else 'belum'
    end,
    (select max(p.tanggal) from public.pertemuan p where p.kelompok_id = k.id),
    (select round(100.0 * count(*) filter (where h.hadir) / nullif(count(*), 0), 0)
       from public.kehadiran h
       join public.pertemuan p on p.id = h.pertemuan_id
      where p.kelompok_id = k.id and p.ditutup_pada is not null
        and p.tanggal > v_hari_ini - 28),
    (select coalesce(sum(p.persembahan), 0) from public.pertemuan p
      where p.kelompok_id = k.id and p.tanggal >= v_awal_bulan and p.tanggal <= v_hari_ini),
    (select count(distinct t.anggota_id)::integer from public.tindak_lanjut(k.id) t)
  from public.kelompok k
  where k.tim_id = p_tim
  order by k.nama;
end;
$$;

revoke all on function public.ringkasan_tim(uuid) from public, anon;
grant execute on function public.ringkasan_tim(uuid) to authenticated;

$mig1300$;
    v_dijalankan := v_dijalankan || '20261117001300_ringkasan_tim.sql'::text;
  end if;

  -- 20261117001400_kartu_qr.sql
  if not (exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'public' and p.proname = 'buat_ulang_kode_kartu')) then
    execute $mig1400$
-- =====================================================================
-- 14 · QR KARTU ANGGOTA (Fase 7, keputusan 22)
--   1. buat_ulang_kode_kartu(): kartu hilang -> kode baru; kartu lama
--      otomatis tidak berlaku. Pemimpin/wakil kelompoknya dan Admin.
--   2. scan_kartu_anggota(): kini menolak pertemuan yang absensinya sudah
--      ditutup (isi lainnya sama dengan file 04).
-- =====================================================================

create function public.buat_ulang_kode_kartu(p_anggota uuid)
returns void
language plpgsql security definer set search_path = ''
as $$
begin
  if not bantu.boleh_kelola_anggota(p_anggota) then
    raise exception 'Anda tidak berhak membuat ulang kartu anggota ini.' using errcode = '42501';
  end if;

  update public.anggota
     set kode_qr = replace(gen_random_uuid()::text, '-', '')
   where id = p_anggota;

  perform internal.catat_log('buat_ulang_kode_kartu', jsonb_build_object('anggota_id', p_anggota));
end;
$$;

revoke all on function public.buat_ulang_kode_kartu(uuid) from public, anon;
grant execute on function public.buat_ulang_kode_kartu(uuid) to authenticated;


create or replace function public.scan_kartu_anggota(p_pertemuan uuid, p_kode_kartu text)
returns table (anggota_id uuid, nama_lengkap text, sudah_tercatat boolean)
language plpgsql security definer set search_path = ''
as $$
#variable_conflict use_column
declare
  v_kelompok uuid;
  v_ditutup  timestamptz;
  v_anggota  uuid;
  v_nama     text;
  v_sudah    boolean;
begin
  select p.kelompok_id, p.ditutup_pada into v_kelompok, v_ditutup
  from public.pertemuan p
  where p.id = p_pertemuan and p.kelompok_id in (select bantu.kelompok_dipimpin());

  if v_kelompok is null then
    raise exception 'Pertemuan tidak ditemukan atau bukan kelompok Anda.' using errcode = '42501';
  end if;
  if v_ditutup is not null then
    raise exception 'Absensi pertemuan ini sudah ditutup. Buka kembali untuk men-scan kartu.' using errcode = '22023';
  end if;

  select a.id, a.nama_lengkap into v_anggota, v_nama
  from public.anggota a
  where a.kode_qr = lower(trim(p_kode_kartu)) and a.kelompok_id = v_kelompok;

  if v_anggota is null then
    raise exception 'Kartu tidak dikenal atau bukan anggota kelompok ini.' using errcode = '22023';
  end if;

  select coalesce(bool_or(k.hadir), false) into v_sudah
  from public.kehadiran k where k.pertemuan_id = p_pertemuan and k.anggota_id = v_anggota;

  if not v_sudah then
    insert into public.kehadiran (pertemuan_id, anggota_id, hadir, waktu, cara, dicatat_oleh)
    values (p_pertemuan, v_anggota, true, now(), 'scan_pemimpin', auth.uid())
    on conflict on constraint kehadiran_unik do update
      set hadir = true, waktu = now(), cara = 'scan_pemimpin',
          alasan = null, alasan_catatan = null, dicatat_oleh = auth.uid();
  end if;

  return query select v_anggota, v_nama, v_sudah;
end;
$$;

$mig1400$;
    v_dijalankan := v_dijalankan || '20261117001400_kartu_qr.sql'::text;
  end if;

  -- 20261118001500_login_fleksibel.sql
  if not (exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'internal' and p.proname = 'normal_hp')) then
    execute $mig1500$
-- =====================================================================
-- 15 · LOGIN DENGAN NAMA PENGGUNA, EMAIL, ATAU NOMOR HP (keputusan 25)
--
-- * Satu akun boleh punya ketiganya: nama pengguna, email, nomor HP.
--   Masuk cukup dengan SALAH SATUNYA + kata sandi. Minimal satu harus ada.
-- * Ketiganya UNIK di seluruh aplikasi (huruf besar/kecil dianggap sama;
--   nomor HP disimpan dalam bentuk baku 628xxxx, jadi 0812.., +62812..,
--   dan 62812.. dihitung sama).
-- * Nomor HP login = nomor HP di profil anggota ("disamakan"):
--   mengubah salah satunya ikut mengubah yang lain. Nomor HP di profil
--   juga unik, dan tidak boleh sama dengan nomor HP login akun orang lain.
-- * Alamat login di Supabase Auth (auth.users.email) tetap dipakai di
--   belakang layar. Server mencarinya lewat layanan_cari_login().
-- =====================================================================


-- ---------------------------------------------------------------------
-- 1. ALAT BANTU: merapikan isian
-- ---------------------------------------------------------------------

-- Nomor HP Indonesia -> bentuk baku 628xxxxxxxxx. NULL bila tidak sah.
create function internal.normal_hp(p text)
returns text language plpgsql immutable set search_path = ''
as $$
declare
  v text := regexp_replace(coalesce(p, ''), '[[:space:]().-]', '', 'g');
begin
  if v like '+%' then v := substr(v, 2); end if;
  if v !~ '^[0-9]+$' then return null; end if;
  if v like '0%' then v := '62' || substr(v, 2);
  elsif v like '8%' then v := '62' || v;
  end if;
  if v !~ '^628[0-9]{7,11}$' then return null; end if;
  return v;
end;
$$;

-- 6281234567890 -> 081234567890 (untuk ditampilkan).
create function internal.tampil_hp(p text)
returns text language sql immutable set search_path = ''
as $$ select case when p like '62%' then '0' || substr(p, 3) else p end $$;

create function internal.email_sah(p text)
returns boolean language sql immutable set search_path = ''
as $$
  select p ~ '^[^[:space:]@]+@[^[:space:]@]+\.[^[:space:]@]{2,}$' and p !~ '\.invalid$'
$$;

-- Huruf kecil, angka, titik, garis bawah; 3-30 karakter; diawali huruf.
-- Karena diawali huruf dan tanpa @, nama pengguna tidak pernah tertukar
-- dengan email atau nomor HP.
create function internal.nama_pengguna_sah(p text)
returns boolean language sql immutable set search_path = ''
as $$ select p ~ '^[a-z][a-z0-9._]{2,29}$' $$;

revoke all on function internal.normal_hp(text)         from public, anon, authenticated;
revoke all on function internal.tampil_hp(text)         from public, anon, authenticated;
revoke all on function internal.email_sah(text)         from public, anon, authenticated;
revoke all on function internal.nama_pengguna_sah(text) from public, anon, authenticated;


-- ---------------------------------------------------------------------
-- 2. KOLOM BARU DI TABEL AKUN
-- ---------------------------------------------------------------------
alter table public.akun
  add column nama_pengguna text,
  add column email         text,
  add column nomor_hp      text;

comment on column public.akun.nama_pengguna is 'Nama pengguna untuk masuk (huruf kecil, unik).';
comment on column public.akun.email         is 'Email untuk masuk (huruf kecil, unik).';
comment on column public.akun.nomor_hp      is 'Nomor HP untuk masuk, bentuk baku 628xxx (unik). Sama dengan anggota.no_hp bila akun terhubung ke profil.';
comment on column public.akun.login         is 'Ringkasan cara masuk untuk ditampilkan (diisi otomatis).';

-- Mengisi akun yang sudah ada dari data Supabase Auth.
-- Aplikasi selama ini menyimpan isian login di user_metadata.login
-- (email atau nomor HP 08xx); bila tidak ada, dipakai alamat auth.
update public.akun a
   set email    = case when x.isian like '%@%' and internal.email_sah(lower(x.isian)) then lower(x.isian) end,
       nomor_hp = case when x.isian not like '%@%' then internal.normal_hp(x.isian) end
  from (
    select u.id,
           coalesce(nullif(trim(u.raw_user_meta_data ->> 'login'), ''),
                    case when u.email like '%@hp.invalid' then split_part(u.email, '@', 1) else u.email end) as isian
    from auth.users u
  ) x
 where x.id = a.id;

alter table public.akun
  -- Pola ditulis langsung (bukan memanggil fungsi internal), karena aturan
  -- ini juga diperiksa saat pengguna biasa mengubah akunnya.
  add constraint akun_nama_pengguna_sah check (nama_pengguna is null or nama_pengguna ~ '^[a-z][a-z0-9._]{2,29}$'),
  add constraint akun_email_sah         check (email is null or (email = lower(email)
                                               and email ~ '^[^[:space:]@]+@[^[:space:]@]+\.[^[:space:]@]{2,}$'
                                               and email !~ '\.invalid$')),
  add constraint akun_nomor_hp_sah      check (nomor_hp is null or nomor_hp ~ '^628[0-9]{7,11}$'),
  add constraint akun_nama_pengguna_unik unique (nama_pengguna),
  add constraint akun_email_unik         unique (email),
  add constraint akun_nomor_hp_unik      unique (nomor_hp);


-- ---------------------------------------------------------------------
-- 3. NOMOR HP DI PROFIL ANGGOTA: dirapikan dan dibuat unik
-- ---------------------------------------------------------------------

-- 3a. Rapikan nomor yang sudah ada. Nomor yang tidak bisa dibaca dibiarkan
--     apa adanya (akan diminta diperbaiki saat profil diubah).
update public.anggota
   set no_hp = internal.normal_hp(no_hp)
 where no_hp is not null and internal.normal_hp(no_hp) is not null
   and no_hp <> internal.normal_hp(no_hp);

-- 3b. Akun yang terhubung ke profil (dengan persetujuan): samakan nomornya.
--     Bila keduanya terisi dan berbeda, nomor login yang dipakai.
update public.anggota g
   set no_hp = ak.nomor_hp
  from public.akun ak
 where ak.anggota_id = g.id and ak.nomor_hp is not null
   and g.persetujuan_pada is not null and g.no_hp is distinct from ak.nomor_hp;

update public.akun ak
   set nomor_hp = g.no_hp
  from public.anggota g
 where ak.anggota_id = g.id and ak.nomor_hp is null
   and g.no_hp ~ '^628[0-9]{7,11}$'
   and not exists (select 1 from public.akun lain where lain.nomor_hp = g.no_hp);

-- 3c. Nomor ganda: yang dipertahankan adalah milik akun pemilik nomor
--     login itu, lalu yang terhubung ke akun, lalu profil yang paling lama.
--     Sisanya dikosongkan dan dicatat di log (tanpa nomornya).
with urut as (
  select g.id,
         row_number() over (
           partition by g.no_hp
           order by (exists (select 1 from public.akun ak where ak.anggota_id = g.id and ak.nomor_hp = g.no_hp)) desc,
                    (exists (select 1 from public.akun ak where ak.anggota_id = g.id)) desc,
                    g.dibuat_pada, g.id) as n,
         exists (select 1 from public.akun ak
                 where ak.nomor_hp = g.no_hp
                   and ak.anggota_id is distinct from g.id) as dipakai_akun_lain
  from public.anggota g
  where g.no_hp is not null
), dikosongkan as (
  update public.anggota g
     set no_hp = null
    from urut
   where urut.id = g.id and (urut.n > 1 or urut.dipakai_akun_lain)
  returning g.id
)
insert into public.log_aktivitas (akun_id, tindakan, detail)
select null, 'hp_ganda_dikosongkan', jsonb_build_object('anggota_id', id) from dikosongkan;

create unique index anggota_no_hp_unik on public.anggota (no_hp) where no_hp is not null;


-- ---------------------------------------------------------------------
-- 4. PENJAGA TABEL AKUN
-- ---------------------------------------------------------------------
create function internal.jaga_login_akun()
returns trigger language plpgsql security definer set search_path = ''
as $$
declare
  v_hp_profil text;
begin
  new.nama_pengguna := nullif(lower(trim(new.nama_pengguna)), '');
  new.email         := nullif(lower(trim(new.email)), '');
  if nullif(trim(new.nomor_hp), '') is null then
    new.nomor_hp := null;
  else
    new.nomor_hp := internal.normal_hp(new.nomor_hp);
    if new.nomor_hp is null then
      raise exception 'Nomor HP tidak sah. Contoh yang benar: 081234567890.' using errcode = '22023';
    end if;
  end if;

  if new.nama_pengguna is not null and not internal.nama_pengguna_sah(new.nama_pengguna) then
    raise exception 'Nama pengguna harus 3-30 karakter: huruf kecil, angka, titik, atau garis bawah, dan diawali huruf.'
      using errcode = '22023';
  end if;
  if new.email is not null and not internal.email_sah(new.email) then
    raise exception 'Email tidak sah. Contoh yang benar: nama@gmail.com.' using errcode = '22023';
  end if;

  -- Baru tersambung ke profil dan belum punya nomor HP login: ambil dari profil.
  if new.anggota_id is not null and new.nomor_hp is null
     and (tg_op = 'INSERT' or old.anggota_id is distinct from new.anggota_id) then
    select g.no_hp into v_hp_profil from public.anggota g
     where g.id = new.anggota_id and g.no_hp ~ '^628[0-9]{7,11}$';
    if v_hp_profil is not null
       and not exists (select 1 from public.akun ak where ak.nomor_hp = v_hp_profil and ak.id <> new.id) then
      new.nomor_hp := v_hp_profil;
    end if;
  end if;

  if tg_op = 'UPDATE'
     and num_nonnulls(old.nama_pengguna, old.email, old.nomor_hp) > 0
     and num_nonnulls(new.nama_pengguna, new.email, new.nomor_hp) = 0 then
    raise exception 'Akun harus punya minimal satu cara masuk: nama pengguna, email, atau nomor HP.'
      using errcode = '22023';
  end if;

  -- Keunikan, dengan pesan yang mudah dipahami.
  if new.nama_pengguna is not null and exists (
       select 1 from public.akun ak where ak.nama_pengguna = new.nama_pengguna and ak.id <> new.id) then
    raise exception 'Nama pengguna "%" sudah dipakai. Pilih nama lain.', new.nama_pengguna using errcode = '23505';
  end if;
  if new.email is not null and exists (
       select 1 from public.akun ak where ak.email = new.email and ak.id <> new.id) then
    raise exception 'Email % sudah terdaftar di akun lain.', new.email using errcode = '23505';
  end if;
  if new.nomor_hp is not null and (
       exists (select 1 from public.akun ak where ak.nomor_hp = new.nomor_hp and ak.id <> new.id)
    or exists (select 1 from public.anggota g
               where g.no_hp = new.nomor_hp and g.id is distinct from new.anggota_id)) then
    raise exception 'Nomor HP % sudah terdaftar atas nama orang lain.', internal.tampil_hp(new.nomor_hp)
      using errcode = '23505';
  end if;

  new.login := nullif(concat_ws(' · ', new.nama_pengguna, new.email, internal.tampil_hp(new.nomor_hp)), '');
  return new;
end;
$$;

create trigger jaga_login_akun before insert or update on public.akun
  for each row execute function internal.jaga_login_akun();

-- Nomor HP login berubah -> nomor HP di profil ikut berubah.
create function internal.setelah_login_akun()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  if new.anggota_id is not null then
    update public.anggota g
       set no_hp = new.nomor_hp
     where g.id = new.anggota_id
       and g.persetujuan_pada is not null
       and g.no_hp is distinct from new.nomor_hp;
  end if;
  return null;
end;
$$;

create trigger setelah_login_akun after insert or update of nomor_hp, anggota_id on public.akun
  for each row execute function internal.setelah_login_akun();


-- ---------------------------------------------------------------------
-- 5. PENJAGA NOMOR HP DI PROFIL ANGGOTA
-- (nama diawali "zz_" supaya berjalan setelah penjaga anggota yang lain)
-- ---------------------------------------------------------------------
create function internal.jaga_hp_anggota()
returns trigger language plpgsql security definer set search_path = ''
as $$
declare
  v_akun public.akun;
  v_uid  uuid := auth.uid();
begin
  select * into v_akun from public.akun ak where ak.anggota_id = new.id;

  if tg_op = 'INSERT' or new.no_hp is distinct from old.no_hp then
    if nullif(trim(new.no_hp), '') is null then
      new.no_hp := null;
    else
      new.no_hp := internal.normal_hp(new.no_hp);
      if new.no_hp is null then
        raise exception 'Nomor HP tidak sah. Contoh yang benar: 081234567890.' using errcode = '22023';
      end if;
    end if;
  end if;

  -- Profil baru disetujui dan belum ada nomor HP: ambil nomor HP login.
  if tg_op = 'UPDATE' and new.no_hp is null and old.no_hp is null
     and new.persetujuan_pada is not null and v_akun.nomor_hp is not null then
    new.no_hp := v_akun.nomor_hp;
  end if;

  if tg_op = 'UPDATE' and new.no_hp is not distinct from old.no_hp then
    return new;
  end if;

  if v_akun.id is not null and v_akun.nomor_hp is distinct from new.no_hp then
    -- Nomor HP ini dipakai untuk masuk: jangan sampai akun tidak bisa masuk.
    if new.no_hp is null and v_akun.nama_pengguna is null and v_akun.email is null then
      raise exception 'Nomor HP ini dipakai untuk masuk ke aplikasi. Tambahkan email atau nama pengguna dulu sebelum menghapusnya.'
        using errcode = '22023';
    end if;
    -- Nomor HP login staf hanya boleh diubah oleh dirinya sendiri atau Admin.
    if v_uid is not null and pg_trigger_depth() = 1 and v_uid <> v_akun.id and not bantu.saya_admin()
       and exists (select 1 from public.penugasan_peran p where p.akun_id = v_akun.id) then
      raise exception 'Nomor HP ini dipakai untuk masuk oleh seorang pemimpin/staf. Hanya orangnya sendiri atau Admin yang bisa mengubahnya.'
        using errcode = '42501';
    end if;
  end if;

  if new.no_hp is not null and (
       exists (select 1 from public.anggota g where g.no_hp = new.no_hp and g.id <> new.id)
    or exists (select 1 from public.akun ak
               where ak.nomor_hp = new.no_hp and ak.anggota_id is distinct from new.id)) then
    raise exception 'Nomor HP % sudah terdaftar atas nama orang lain.', internal.tampil_hp(new.no_hp)
      using errcode = '23505';
  end if;
  return new;
end;
$$;

create trigger zz_jaga_hp_anggota before insert or update on public.anggota
  for each row execute function internal.jaga_hp_anggota();

-- Nomor HP di profil berubah -> nomor HP login ikut berubah.
create function internal.setelah_hp_anggota()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  update public.akun ak
     set nomor_hp = new.no_hp
   where ak.anggota_id = new.id
     and ak.nomor_hp is distinct from new.no_hp;
  return null;
end;
$$;

create trigger setelah_hp_anggota after update of no_hp on public.anggota
  for each row when (new.no_hp is distinct from old.no_hp)
  execute function internal.setelah_hp_anggota();


-- ---------------------------------------------------------------------
-- 6. AKUN BARU: isi cara masuk dari data pendaftaran
-- user_metadata berisi nama_pengguna / email / nomor_hp (aplikasi baru),
-- atau login (aplikasi lama), atau tidak ada (dipakai alamat auth).
-- ---------------------------------------------------------------------
create or replace function internal.akun_baru()
returns trigger language plpgsql security definer set search_path = ''
as $$
declare
  m        jsonb := coalesce(new.raw_user_meta_data, '{}'::jsonb);
  v_nama   text;
  v_email  text;
  v_hp     text;
  v_isian  text;
begin
  if m ?| array['nama_pengguna', 'email', 'nomor_hp'] then
    v_nama  := nullif(trim(m ->> 'nama_pengguna'), '');
    v_email := nullif(trim(m ->> 'email'), '');
    v_hp    := nullif(trim(m ->> 'nomor_hp'), '');
  else
    v_isian := coalesce(nullif(trim(m ->> 'login'), ''),
                        case when new.email like '%@hp.invalid' then split_part(new.email, '@', 1) else new.email end);
    if v_isian like '%@%' then
      v_email := case when internal.email_sah(lower(v_isian)) then v_isian end;
    else
      v_hp := internal.normal_hp(v_isian);
    end if;
  end if;

  insert into public.akun (id, nama_tampilan, nama_pengguna, email, nomor_hp)
  values (
    new.id,
    coalesce(nullif(trim(m ->> 'nama'), ''),
             split_part(coalesce(new.email, new.phone, 'Pengguna'), '@', 1)),
    v_nama, v_email, v_hp
  )
  on conflict (id) do nothing;
  return new;
end;
$$;


-- ---------------------------------------------------------------------
-- 7. LOKET
-- ---------------------------------------------------------------------

-- 7a. Mengubah cara masuk. Pengguna untuk akunnya sendiri; Admin untuk
--     akun siapa saja. Isian kosong = dihapus. Minimal satu harus ada.
create function public.ubah_login(
  p_akun uuid, p_nama_pengguna text, p_email text, p_nomor_hp text)
returns text
language plpgsql security definer set search_path = ''
as $$
declare
  v_login text;
begin
  if auth.uid() is null or p_akun is null
     or (p_akun <> auth.uid() and not bantu.saya_admin()) then
    raise exception 'Anda hanya bisa mengubah cara masuk akun Anda sendiri.' using errcode = '42501';
  end if;
  if num_nonnulls(nullif(trim(p_nama_pengguna), ''), nullif(trim(p_email), ''), nullif(trim(p_nomor_hp), '')) = 0 then
    raise exception 'Isi minimal satu: nama pengguna, email, atau nomor HP.' using errcode = '22023';
  end if;

  update public.akun
     set nama_pengguna = p_nama_pengguna, email = p_email, nomor_hp = p_nomor_hp
   where id = p_akun
  returning login into v_login;
  if not found then
    raise exception 'Akun tidak ditemukan.' using errcode = '22023';
  end if;

  perform internal.catat_log('ubah_login', jsonb_build_object('akun_id', p_akun));
  return v_login;
end;
$$;

-- 7b. (server) Sebelum membuat akun baru: pastikan isian sah dan belum
--     dipakai. p_anggota = profil yang akan disambungkan (undangan untuk
--     profil yang sudah ada), supaya nomor HP di profil itu boleh dipakai.
--     Mengembalikan isian yang sudah dirapikan.
create function public.layanan_cek_login_baru(
  p_nama_pengguna text, p_email text, p_nomor_hp text, p_anggota uuid default null)
returns table (nama_pengguna text, email text, nomor_hp text)
language plpgsql stable security definer set search_path = ''
as $$
declare
  v_nama  text := nullif(lower(trim(p_nama_pengguna)), '');
  v_email text := nullif(lower(trim(p_email)), '');
  v_hp    text := nullif(trim(p_nomor_hp), '');
begin
  if num_nonnulls(v_nama, v_email, v_hp) = 0 then
    raise exception 'Isi minimal satu: nama pengguna, email, atau nomor HP.' using errcode = '22023';
  end if;
  if v_nama is not null and not internal.nama_pengguna_sah(v_nama) then
    raise exception 'Nama pengguna harus 3-30 karakter: huruf kecil, angka, titik, atau garis bawah, dan diawali huruf.'
      using errcode = '22023';
  end if;
  if v_email is not null and not internal.email_sah(v_email) then
    raise exception 'Email tidak sah. Contoh yang benar: nama@gmail.com.' using errcode = '22023';
  end if;
  if v_hp is not null then
    v_hp := internal.normal_hp(v_hp);
    if v_hp is null then
      raise exception 'Nomor HP tidak sah. Contoh yang benar: 081234567890.' using errcode = '22023';
    end if;
  end if;

  if v_nama is not null and exists (select 1 from public.akun ak where ak.nama_pengguna = v_nama) then
    raise exception 'Nama pengguna "%" sudah dipakai. Pilih nama lain.', v_nama using errcode = '23505';
  end if;
  if v_email is not null and exists (select 1 from public.akun ak where ak.email = v_email) then
    raise exception 'Email % sudah terdaftar. Silakan masuk, atau minta tautan atur ulang kata sandi.', v_email
      using errcode = '23505';
  end if;
  if v_hp is not null and (
       exists (select 1 from public.akun ak where ak.nomor_hp = v_hp)
    or exists (select 1 from public.anggota g where g.no_hp = v_hp and g.id is distinct from p_anggota)) then
    raise exception 'Nomor HP % sudah terdaftar. Silakan masuk, atau minta tautan atur ulang kata sandi.',
      internal.tampil_hp(v_hp) using errcode = '23505';
  end if;

  return query select v_nama, v_email, v_hp;
end;
$$;

-- 7c. (server) Mencari alamat login Supabase Auth dari isian halaman masuk:
--     nama pengguna, email, atau nomor HP. NULL bila tidak ditemukan.
create function public.layanan_cari_login(p_isian text)
returns text
language plpgsql stable security definer set search_path = ''
as $$
declare
  v   text := lower(trim(coalesce(p_isian, '')));
  v_hp text;
  v_email text;
begin
  if v = '' then return null; end if;
  if v like '%@%' then
    select u.email into v_email from public.akun ak join auth.users u on u.id = ak.id where ak.email = v;
  else
    v_hp := internal.normal_hp(v);
    if v_hp is not null then
      select u.email into v_email from public.akun ak join auth.users u on u.id = ak.id where ak.nomor_hp = v_hp;
    else
      select u.email into v_email from public.akun ak join auth.users u on u.id = ak.id where ak.nama_pengguna = v;
    end if;
  end if;
  return v_email;
end;
$$;

-- 7d. Admin dan pengguna sendiri membaca cara masuk (nama pengguna, email,
--     nomor HP dalam bentuk 08xx) untuk formulir ubah.
create function public.data_login(p_akun uuid)
returns table (nama_pengguna text, email text, nomor_hp text)
language plpgsql stable security definer set search_path = ''
as $$
begin
  if auth.uid() is null or p_akun is null
     or (p_akun <> auth.uid() and not bantu.saya_admin()) then
    raise exception 'Anda tidak berhak melihat data ini.' using errcode = '42501';
  end if;
  return query
    select ak.nama_pengguna, ak.email, internal.tampil_hp(ak.nomor_hp)
    from public.akun ak where ak.id = p_akun;
end;
$$;

revoke all on function public.ubah_login(uuid, text, text, text)                   from public, anon;
revoke all on function public.data_login(uuid)                                     from public, anon;
revoke all on function public.layanan_cek_login_baru(text, text, text, uuid)       from public, anon, authenticated;
revoke all on function public.layanan_cari_login(text)                             from public, anon, authenticated;
grant execute on function public.ubah_login(uuid, text, text, text)                to authenticated;
grant execute on function public.data_login(uuid)                                  to authenticated;
grant execute on function public.layanan_cek_login_baru(text, text, text, uuid)    to service_role;
grant execute on function public.layanan_cari_login(text)                          to service_role;

revoke all on all functions in schema internal from public, anon, authenticated;

-- Isi ulang ringkasan login untuk akun lama (dijalankan penjaga di atas).
update public.akun set nama_pengguna = nama_pengguna;

$mig1500$;
    v_dijalankan := v_dijalankan || '20261118001500_login_fleksibel.sql'::text;
  end if;

  -- 20261118001600_atur_profil.sql
  if not (exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'public' and p.proname = 'selesai_atur_profil')) then
    execute $mig1600$
-- =====================================================================
-- 16 · ATUR PROFIL SENDIRI UNTUK SEMUA PERAN (keputusan 27)
--
-- * Profil staf: Admin, Ketua Tim, dan Pemimpin yang BUKAN anggota
--   kelompok punya profil sendiri (foto dan data pribadi), terpisah dari
--   profil anggota. Tidak ikut absensi atau laporan demografi anggota.
--   Hanya dibaca orangnya sendiri dan Admin.
-- * Login pertama: semua akun diarahkan ke halaman Atur profil sampai
--   menekan "Selesai". Akun yang dibuat Admin (kata sandi sementara)
--   wajib mengganti kata sandi dulu.
-- * Nama akun mengikuti nama lengkap di profil anggota.
-- =====================================================================


-- ---------------------------------------------------------------------
-- 1. PENANDA LOGIN PERTAMA DI TABEL AKUN
-- ---------------------------------------------------------------------
alter table public.akun
  add column sandi_sementara    boolean not null default false,
  add column profil_diatur_pada timestamptz;

comment on column public.akun.sandi_sementara    is 'true = kata sandi dibuat Admin; wajib diganti saat login pertama.';
comment on column public.akun.profil_diatur_pada is 'Kapan pengguna menyelesaikan Atur profil. NULL = belum (diarahkan ke Atur profil).';


-- ---------------------------------------------------------------------
-- 2. PROFIL STAF
-- Baris dibuat saat orangnya menyetujui pencatatan data (UU PDP),
-- jadi persetujuan_pada selalu terisi. Nomor HP ada di akun (cara masuk).
-- ---------------------------------------------------------------------
create table public.profil_staf (
  akun_id         uuid primary key references public.akun(id) on delete cascade,
  gender          public.gender,
  foto_path       text,
  tempat_lahir    text,
  tanggal_lahir   date check (tanggal_lahir > date '1900-01-01'),
  alamat          text,
  provinsi_kode   text references public.wilayah(kode),
  kota_kode       text references public.wilayah(kode),
  kecamatan_kode  text references public.wilayah(kode),
  kelurahan_kode  text references public.wilayah(kode),
  status_nikah    public.status_nikah,
  pendidikan      public.pendidikan,
  pekerjaan       public.pekerjaan,
  persetujuan_pada timestamptz not null default now(),
  dibuat_pada     timestamptz not null default now(),
  diubah_pada     timestamptz not null default now(),

  constraint profil_staf_wilayah_bertingkat check (
        (provinsi_kode  is null or provinsi_kode ~ '^[0-9]{2}$')
    and (kota_kode      is null or (provinsi_kode  is not null and kota_kode      like provinsi_kode  || '.__'))
    and (kecamatan_kode is null or (kota_kode      is not null and kecamatan_kode like kota_kode      || '.__'))
    and (kelurahan_kode is null or (kecamatan_kode is not null and kelurahan_kode like kecamatan_kode || '.____'))
  ),
  -- Foto harus berada di folder milik akun ini sendiri: staf/<id akun>/...
  constraint profil_staf_foto_milik_sendiri check (
    foto_path is null or foto_path like 'staf/' || akun_id::text || '/%'
  )
);
comment on table public.profil_staf is
  'Profil pribadi Admin/Ketua Tim/Pemimpin yang bukan anggota kelompok. Hanya dibaca orangnya sendiri dan Admin.';

alter table public.profil_staf enable row level security;

revoke all on public.profil_staf from anon;
grant select, insert, update, delete on public.profil_staf to authenticated;

create policy "profil staf: baca milik sendiri, admin baca semua" on public.profil_staf
  for select to authenticated
  using (akun_id = (select auth.uid()) or (select bantu.saya_admin()));

-- Hanya akun yang TIDAK punya profil anggota (orang itu memakai profil anggotanya).
create policy "profil staf: buat milik sendiri" on public.profil_staf
  for insert to authenticated
  with check (akun_id = (select auth.uid())
              and not exists (select 1 from public.akun ak
                              where ak.id = (select auth.uid()) and ak.anggota_id is not null));

create policy "profil staf: ubah milik sendiri" on public.profil_staf
  for update to authenticated
  using (akun_id = (select auth.uid())) with check (akun_id = (select auth.uid()));

-- Menghapus profil = menarik persetujuan (oleh orangnya) atau koreksi oleh Admin.
create policy "profil staf: hapus milik sendiri atau admin" on public.profil_staf
  for delete to authenticated
  using (akun_id = (select auth.uid()) or (select bantu.saya_admin()));

create trigger isi_diubah_pada before update on public.profil_staf
  for each row execute function internal.isi_diubah_pada();

-- Waktu persetujuan tidak bisa dipalsukan; foto lama masuk antrean hapus.
create function internal.jaga_profil_staf()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  if tg_op = 'INSERT' then
    new.persetujuan_pada := now();
  elsif tg_op = 'UPDATE' then
    new.persetujuan_pada := old.persetujuan_pada;
    new.akun_id := old.akun_id;
  end if;
  return new;
end;
$$;

create trigger jaga_profil_staf before insert or update on public.profil_staf
  for each row execute function internal.jaga_profil_staf();

create function internal.setelah_profil_staf_berubah()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  if tg_op = 'DELETE' then
    if old.foto_path is not null then
      insert into internal.antrean_hapus_foto (foto_path) values (old.foto_path);
    end if;
    perform internal.catat_log('hapus_profil_staf', jsonb_build_object('akun_id', old.akun_id));
    return old;
  end if;
  if old.foto_path is not null and new.foto_path is distinct from old.foto_path then
    insert into internal.antrean_hapus_foto (foto_path) values (old.foto_path);
  end if;
  return new;
end;
$$;

create trigger setelah_profil_staf_berubah after update or delete on public.profil_staf
  for each row execute function internal.setelah_profil_staf_berubah();


-- ---------------------------------------------------------------------
-- 3. FOTO STAF: folder foto-anggota/staf/<id akun>/
-- ---------------------------------------------------------------------
create policy "foto staf: lihat" on storage.objects
  for select to authenticated
  using (bucket_id = 'foto-anggota' and (storage.foldername(name))[1] = 'staf'
         and ((storage.foldername(name))[2] = (select auth.uid())::text or (select bantu.saya_admin())));

create policy "foto staf: unggah" on storage.objects
  for insert to authenticated
  with check (bucket_id = 'foto-anggota' and (storage.foldername(name))[1] = 'staf'
              and (storage.foldername(name))[2] = (select auth.uid())::text);

create policy "foto staf: ganti" on storage.objects
  for update to authenticated
  using      (bucket_id = 'foto-anggota' and (storage.foldername(name))[1] = 'staf'
              and (storage.foldername(name))[2] = (select auth.uid())::text)
  with check (bucket_id = 'foto-anggota' and (storage.foldername(name))[1] = 'staf'
              and (storage.foldername(name))[2] = (select auth.uid())::text);

create policy "foto staf: hapus" on storage.objects
  for delete to authenticated
  using (bucket_id = 'foto-anggota' and (storage.foldername(name))[1] = 'staf'
         and (storage.foldername(name))[2] = (select auth.uid())::text);


-- ---------------------------------------------------------------------
-- 4. NAMA AKUN MENGIKUTI NAMA LENGKAP DI PROFIL ANGGOTA
-- ---------------------------------------------------------------------
create function internal.samakan_nama_akun()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  update public.akun ak
     set nama_tampilan = new.nama_lengkap
   where ak.anggota_id = new.id and ak.nama_tampilan is distinct from new.nama_lengkap;
  return null;
end;
$$;

create trigger samakan_nama_akun after update of nama_lengkap on public.anggota
  for each row when (new.nama_lengkap is distinct from old.nama_lengkap)
  execute function internal.samakan_nama_akun();

-- Nama tampilan tidak boleh kosong.
alter table public.akun
  add constraint akun_nama_tampilan_isi check (length(trim(nama_tampilan)) > 0) not valid;


-- ---------------------------------------------------------------------
-- 5. LOKET
-- ---------------------------------------------------------------------

-- 5a. Menyelesaikan Atur profil (login pertama).
create function public.selesai_atur_profil()
returns void
language plpgsql security definer set search_path = ''
as $$
begin
  if auth.uid() is null then
    raise exception 'Silakan masuk terlebih dahulu.' using errcode = '42501';
  end if;
  if exists (select 1 from public.akun where id = auth.uid() and sandi_sementara) then
    raise exception 'Ganti kata sandi sementara dari Admin terlebih dahulu.' using errcode = '22023';
  end if;
  update public.akun set profil_diatur_pada = coalesce(profil_diatur_pada, now()) where id = auth.uid();
end;
$$;

-- 5b. Siapa saya: ditambah penanda login pertama.
create or replace function public.peran_saya()
returns jsonb
language sql stable security definer set search_path = ''
as $$
  select jsonb_build_object(
    'akun_id', ak.id,
    'nama',    ak.nama_tampilan,
    'login',   ak.login,
    'perlu_atur_profil', ak.profil_diatur_pada is null,
    'sandi_sementara',   ak.sandi_sementara,
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

-- 5c. (server) Penanda kata sandi sementara: dipasang saat Admin membuat
--     akun, dilepas saat pengguna mengganti kata sandinya.
create function public.layanan_tandai_sandi(p_akun uuid, p_sementara boolean)
returns void
language sql security definer set search_path = ''
as $$
  update public.akun set sandi_sementara = coalesce(p_sementara, false) where id = p_akun;
$$;

revoke all on function public.selesai_atur_profil()               from public, anon;
revoke all on function public.peran_saya()                        from public, anon;
revoke all on function public.layanan_tandai_sandi(uuid, boolean) from public, anon, authenticated;
grant execute on function public.selesai_atur_profil()            to authenticated;
grant execute on function public.peran_saya()                     to authenticated;
grant execute on function public.layanan_tandai_sandi(uuid, boolean) to service_role;

revoke all on all functions in schema internal from public, anon, authenticated;

$mig1600$;
    v_dijalankan := v_dijalankan || '20261118001600_atur_profil.sql'::text;
  end if;

  -- 20261118001700_masukan.sql
  if not (exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'public' and p.proname = 'kirim_masukan')) then
    execute $mig1700$
-- =====================================================================
-- 17 · MASUKAN: KELUHAN, PERMASALAHAN, USULAN PERBAIKAN (keputusan 28)
--
-- * Pengirim memilih tujuan:
--     - pemimpin  : pemimpin/wakil kelompoknya (pengirim anggota kelompok itu)
--     - ketua_tim : ketua tim dari kelompoknya (anggota, atau pemimpin kelompok itu)
--     - admin     : Admin
-- * Boleh dikirim tanpa nama (anonim): penerima tidak melihat nama
--   pengirim; database tetap mencatatnya dan hanya Admin yang bisa melihat.
-- * Penerima memberi status (baru, sedang ditangani, selesai) dan balasan
--   yang dibaca pengirim. Admin membaca dan menanggapi semua masukan.
-- * Tabel tidak bisa dibaca langsung; semua lewat loket di bawah, supaya
--   pengirim masukan anonim tidak bocor.
-- =====================================================================

create type public.tujuan_masukan as enum ('pemimpin', 'ketua_tim', 'admin');
create type public.jenis_masukan  as enum ('keluhan', 'permasalahan', 'usulan');
create type public.status_masukan as enum ('baru', 'ditangani', 'selesai');

create table public.masukan (
  id           uuid primary key default gen_random_uuid(),
  pengirim_id  uuid references public.akun(id) on delete set null,
  tujuan       public.tujuan_masukan not null,
  kelompok_id  uuid references public.kelompok(id) on delete cascade,
  tim_id       uuid references public.tim(id) on delete cascade,
  jenis        public.jenis_masukan not null,
  judul        text not null check (length(trim(judul)) between 1 and 120),
  isi          text not null check (length(trim(isi)) between 1 and 2000),
  anonim       boolean not null default false,
  status       public.status_masukan not null default 'baru',
  balasan      text check (balasan is null or length(balasan) <= 2000),
  dibalas_oleh uuid references public.akun(id) on delete set null,
  dibalas_pada timestamptz,
  dibuat_pada  timestamptz not null default now(),
  diubah_pada  timestamptz not null default now(),
  constraint masukan_alamat_tujuan check (
       (tujuan = 'pemimpin'  and kelompok_id is not null)
    or (tujuan = 'ketua_tim' and tim_id is not null)
    or (tujuan = 'admin')
  )
);
create index on public.masukan (pengirim_id);
create index on public.masukan (kelompok_id);
create index on public.masukan (tim_id);
comment on table public.masukan is
  'Masukan (keluhan/permasalahan/usulan). Hanya lewat loket: kirim_masukan, masukan_saya, masukan_masuk, tanggapi_masukan.';

alter table public.masukan enable row level security;
-- Tidak ada aturan akses = tidak ada yang bisa membaca/menulis langsung.
revoke all on public.masukan from anon, authenticated;

create trigger isi_diubah_pada before update on public.masukan
  for each row execute function internal.isi_diubah_pada();


-- ---------------------------------------------------------------------
-- Bolehkah saya menanggapi masukan ini? (penerima, atau Admin)
-- ---------------------------------------------------------------------
create function internal.boleh_tanggapi_masukan(p public.masukan)
returns boolean
language sql stable security definer set search_path = ''
as $$
  select bantu.saya_admin()
      or (p.tujuan = 'pemimpin'  and p.kelompok_id in (select bantu.kelompok_dipimpin_langsung()))
      or (p.tujuan = 'ketua_tim' and p.tim_id in (select bantu.tim_diketuai()));
$$;


-- ---------------------------------------------------------------------
-- 1. Mengirim masukan
-- ---------------------------------------------------------------------
create function public.kirim_masukan(
  p_tujuan public.tujuan_masukan, p_kelompok uuid, p_jenis public.jenis_masukan,
  p_judul text, p_isi text, p_anonim boolean default false)
returns uuid
language plpgsql security definer set search_path = ''
as $$
declare
  v_saya     uuid := auth.uid();
  v_kelompok_anggota uuid := bantu.kelompok_saya_sebagai_anggota();
  v_kelompok uuid;
  v_tim      uuid;
  v_id       uuid;
begin
  if v_saya is null then
    raise exception 'Silakan masuk terlebih dahulu.' using errcode = '42501';
  end if;
  if p_tujuan is null or p_jenis is null then
    raise exception 'Pilih tujuan dan jenis masukan.' using errcode = '22023';
  end if;
  if length(trim(coalesce(p_judul, ''))) = 0 or length(trim(coalesce(p_isi, ''))) = 0 then
    raise exception 'Judul dan isi masukan wajib diisi.' using errcode = '22023';
  end if;
  if length(trim(p_judul)) > 120 or length(trim(p_isi)) > 2000 then
    raise exception 'Judul maksimal 120 karakter dan isi maksimal 2000 karakter.' using errcode = '22023';
  end if;

  if p_tujuan = 'pemimpin' then
    -- Hanya anggota kelompok itu yang bisa mengirim ke pemimpinnya.
    if p_kelompok is null or p_kelompok is distinct from v_kelompok_anggota then
      raise exception 'Masukan untuk pemimpin hanya bisa dikirim ke pemimpin kelompok Anda sendiri.'
        using errcode = '42501';
    end if;
    v_kelompok := p_kelompok;
  elsif p_tujuan = 'ketua_tim' then
    if p_kelompok is null or not (p_kelompok is not distinct from v_kelompok_anggota
                                  or p_kelompok in (select bantu.kelompok_dipimpin_langsung())) then
      raise exception 'Masukan untuk ketua tim hanya bisa dikirim ke ketua tim dari kelompok Anda.'
        using errcode = '42501';
    end if;
    v_kelompok := p_kelompok;
    select k.tim_id into v_tim from public.kelompok k where k.id = p_kelompok;
  else
    -- Untuk Admin: kelompok hanya sebagai keterangan, bila memang kelompok saya.
    if p_kelompok is not null and (p_kelompok is not distinct from v_kelompok_anggota
                                   or p_kelompok in (select bantu.kelompok_dipimpin_langsung())) then
      v_kelompok := p_kelompok;
    end if;
  end if;

  insert into public.masukan (pengirim_id, tujuan, kelompok_id, tim_id, jenis, judul, isi, anonim)
  values (v_saya, p_tujuan, v_kelompok, v_tim, p_jenis, trim(p_judul), trim(p_isi), coalesce(p_anonim, false))
  returning id into v_id;

  perform internal.catat_log('kirim_masukan', jsonb_build_object('masukan_id', v_id, 'tujuan', p_tujuan));
  return v_id;
end;
$$;


-- ---------------------------------------------------------------------
-- 2. Masukan yang saya kirim (beserta status dan balasan)
-- ---------------------------------------------------------------------
create function public.masukan_saya()
returns table (
  id uuid, tujuan public.tujuan_masukan, kelompok_nama text, tim_nama text,
  jenis public.jenis_masukan, judul text, isi text, anonim boolean,
  status public.status_masukan, balasan text, dibalas_pada timestamptz, dibuat_pada timestamptz)
language sql stable security definer set search_path = ''
as $$
  select m.id, m.tujuan, k.nama, t.nama, m.jenis, m.judul, m.isi, m.anonim,
         m.status, m.balasan, m.dibalas_pada, m.dibuat_pada
  from public.masukan m
  left join public.kelompok k on k.id = m.kelompok_id
  left join public.tim t      on t.id = m.tim_id
  where m.pengirim_id = auth.uid() and auth.uid() is not null
  order by m.dibuat_pada desc;
$$;


-- ---------------------------------------------------------------------
-- 3. Masukan yang masuk ke saya (penerima; Admin: semua)
--    Nama pengirim anonim hanya terlihat oleh Admin.
-- ---------------------------------------------------------------------
create function public.masukan_masuk()
returns table (
  id uuid, tujuan public.tujuan_masukan, kelompok_nama text, tim_nama text,
  jenis public.jenis_masukan, judul text, isi text, anonim boolean, pengirim_nama text,
  status public.status_masukan, balasan text, dibalas_oleh_nama text, dibalas_pada timestamptz,
  dibuat_pada timestamptz)
language sql stable security definer set search_path = ''
as $$
  select m.id, m.tujuan, k.nama, t.nama, m.jenis, m.judul, m.isi, m.anonim,
         case when m.anonim and not bantu.saya_admin() then null else pg.nama_tampilan end,
         m.status, m.balasan, pb.nama_tampilan, m.dibalas_pada, m.dibuat_pada
  from public.masukan m
  left join public.kelompok k on k.id = m.kelompok_id
  left join public.tim t      on t.id = m.tim_id
  left join public.akun pg    on pg.id = m.pengirim_id
  left join public.akun pb    on pb.id = m.dibalas_oleh
  where auth.uid() is not null and internal.boleh_tanggapi_masukan(m)
  order by (m.status = 'baru') desc, m.dibuat_pada desc;
$$;

-- Jumlah masukan baru yang perlu ditanggapi (untuk Beranda).
create function public.jumlah_masukan_baru()
returns integer
language sql stable security definer set search_path = ''
as $$
  select count(*)::integer from public.masukan m
  where auth.uid() is not null and m.status = 'baru' and internal.boleh_tanggapi_masukan(m);
$$;


-- ---------------------------------------------------------------------
-- 4. Menanggapi: status dan balasan
-- ---------------------------------------------------------------------
create function public.tanggapi_masukan(p_id uuid, p_status public.status_masukan, p_balasan text)
returns void
language plpgsql security definer set search_path = ''
as $$
declare
  v public.masukan;
  v_balasan text := nullif(trim(coalesce(p_balasan, '')), '');
begin
  select * into v from public.masukan where id = p_id for update;
  if v.id is null or auth.uid() is null or not internal.boleh_tanggapi_masukan(v) then
    raise exception 'Anda tidak berhak menanggapi masukan ini.' using errcode = '42501';
  end if;
  if p_status is null then
    raise exception 'Pilih status masukan.' using errcode = '22023';
  end if;
  if length(v_balasan) > 2000 then
    raise exception 'Balasan maksimal 2000 karakter.' using errcode = '22023';
  end if;

  update public.masukan
     set status = p_status,
         balasan = v_balasan,
         dibalas_oleh = case when v_balasan is distinct from v.balasan then auth.uid() else dibalas_oleh end,
         dibalas_pada = case when v_balasan is distinct from v.balasan then
                          (case when v_balasan is null then null else now() end) else dibalas_pada end
   where id = p_id;

  perform internal.catat_log('tanggapi_masukan', jsonb_build_object('masukan_id', p_id, 'status', p_status));
end;
$$;

revoke all on function public.kirim_masukan(public.tujuan_masukan, uuid, public.jenis_masukan, text, text, boolean) from public, anon;
revoke all on function public.masukan_saya()        from public, anon;
revoke all on function public.masukan_masuk()       from public, anon;
revoke all on function public.jumlah_masukan_baru() from public, anon;
revoke all on function public.tanggapi_masukan(uuid, public.status_masukan, text) from public, anon;
grant execute on function public.kirim_masukan(public.tujuan_masukan, uuid, public.jenis_masukan, text, text, boolean) to authenticated;
grant execute on function public.masukan_saya()        to authenticated;
grant execute on function public.masukan_masuk()       to authenticated;
grant execute on function public.jumlah_masukan_baru() to authenticated;
grant execute on function public.tanggapi_masukan(uuid, public.status_masukan, text) to authenticated;

revoke all on all functions in schema internal from public, anon, authenticated;

$mig1700$;
    v_dijalankan := v_dijalankan || '20261118001700_masukan.sql'::text;
  end if;

  -- 20261118001800_baptis_status_jemaat.sql
  if not (exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'public' and p.proname = 'ubah_data_jemaat')) then
    execute $mig1800$
-- =====================================================================
-- 18 · BAPTIS, STATUS JEMAAT, DAN DATA JEMAAT OLEH KETUA TIM
--      (keputusan 29 dan 30)
--
-- * Isian baru Baptis (sudah/belum) di profil anggota dan profil staf.
--   Termasuk data pribadi: hanya boleh diisi setelah persetujuan.
--   Wajib untuk label "Lengkap" (dihitung aplikasi) dan menjadi dimensi
--   laporan demografi.
-- * Isian baru Status jemaat (tamu, member, pelayan, leader) di profil
--   anggota. Diatur oleh pemimpin/wakil, Ketua Tim dari tim itu, dan
--   Admin; anggota tidak bisa mengubah status jemaatnya sendiri.
--   Juga menjadi dimensi laporan demografi.
-- * Ketua Tim (sebelumnya hanya membaca, keputusan 21) kini boleh
--   mengubah TIGA hal untuk anggota di timnya: gender, aktif/tidak aktif,
--   dan status jemaat. Lewat loket ubah_data_jemaat.
-- =====================================================================

create type public.status_jemaat as enum ('tamu', 'member', 'pelayan', 'leader');

alter table public.anggota
  add column baptis        boolean,
  add column status_jemaat public.status_jemaat;
comment on column public.anggota.baptis        is 'Sudah dibaptis (true) / belum (false); NULL = belum diisi.';
comment on column public.anggota.status_jemaat is 'Tamu, member, pelayan, atau leader. Diatur pemimpin/Ketua Tim/Admin.';

alter table public.profil_staf add column baptis boolean;

-- Baptis termasuk data pribadi: ikut aturan persetujuan.
alter table public.anggota drop constraint anggota_perlu_persetujuan;
alter table public.anggota add constraint anggota_perlu_persetujuan check (
  persetujuan_pada is not null or (
    gender is null and foto_path is null and tempat_lahir is null and tanggal_lahir is null
    and alamat is null and provinsi_kode is null and kota_kode is null
    and kecamatan_kode is null and kelurahan_kode is null and status_nikah is null
    and pendidikan is null and pekerjaan is null and no_hp is null and baptis is null
  )
);


-- ---------------------------------------------------------------------
-- 1. Siapa yang boleh mengatur data jemaat (gender, aktif, status jemaat)
-- ---------------------------------------------------------------------
create function bantu.boleh_atur_jemaat(p_anggota uuid)
returns boolean
language sql stable security definer set search_path = ''
as $$
  select bantu.boleh_kelola_anggota(p_anggota)
      or exists (select 1 from public.anggota a
                 join public.kelompok k on k.id = a.kelompok_id
                 where a.id = p_anggota and k.tim_id in (select bantu.tim_diketuai()));
$$;
revoke all on function bantu.boleh_atur_jemaat(uuid) from public, anon;
grant execute on function bantu.boleh_atur_jemaat(uuid) to authenticated;

-- Anggota tidak bisa mengubah status jemaatnya sendiri.
create function internal.jaga_status_jemaat()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  if auth.uid() is not null
     and (tg_op = 'INSERT' or new.status_jemaat is distinct from old.status_jemaat)
     and new.status_jemaat is not null
     and not bantu.boleh_atur_jemaat(new.id)
     and not (tg_op = 'INSERT' and new.kelompok_id in (select bantu.kelompok_dipimpin())) then
    raise exception 'Status jemaat hanya bisa diatur oleh pemimpin kelompok, ketua tim, atau Admin.'
      using errcode = '42501';
  end if;
  return new;
end;
$$;

create trigger jaga_status_jemaat before insert or update on public.anggota
  for each row execute function internal.jaga_status_jemaat();


-- ---------------------------------------------------------------------
-- 2. Loket: mengubah gender, aktif, dan status jemaat
--    (pemimpin/wakil, Ketua Tim dari tim itu, Admin)
-- ---------------------------------------------------------------------
create function public.ubah_data_jemaat(
  p_anggota uuid, p_gender public.gender, p_aktif boolean, p_status_jemaat public.status_jemaat)
returns void
language plpgsql security definer set search_path = ''
as $$
declare
  v public.anggota;
begin
  select * into v from public.anggota where id = p_anggota for update;
  if v.id is null or auth.uid() is null or not bantu.boleh_atur_jemaat(p_anggota) then
    raise exception 'Anda tidak berhak mengubah data jemaat anggota ini.' using errcode = '42501';
  end if;
  if p_gender is not null and v.persetujuan_pada is null then
    raise exception 'Gender baru bisa diisi setelah persetujuan data anggota ini dicatat oleh pemimpin kelompok.'
      using errcode = '22023';
  end if;

  update public.anggota
     set gender = p_gender,
         aktif = coalesce(p_aktif, v.aktif),
         status_jemaat = p_status_jemaat
   where id = p_anggota;

  perform internal.catat_log('ubah_data_jemaat', jsonb_build_object(
    'anggota_id', p_anggota,
    'aktif_berubah', coalesce(p_aktif, v.aktif) is distinct from v.aktif,
    'status_jemaat', p_status_jemaat));
end;
$$;
revoke all on function public.ubah_data_jemaat(uuid, public.gender, boolean, public.status_jemaat) from public, anon;
grant execute on function public.ubah_data_jemaat(uuid, public.gender, boolean, public.status_jemaat) to authenticated;


-- ---------------------------------------------------------------------
-- 3. Laporan demografi: dimensi baptis dan status_jemaat
--    (isi sama dengan file 04, ditambah dua dimensi)
-- ---------------------------------------------------------------------
create or replace function public.laporan_demografi(
  p_dimensi     text,
  p_cakupan     text    default 'semua',
  p_cakupan_id  uuid    default null,
  p_hanya_aktif boolean default true
)
returns table (
  tim_nama      text,
  kelompok_id   uuid,
  kelompok_nama text,
  kunci         text,
  label         text,
  jumlah        bigint,
  persen        numeric
)
language plpgsql security definer set search_path = ''
as $$
#variable_conflict use_column
begin
  if not bantu.saya_admin() then
    raise exception 'Laporan demografi hanya dapat dibuka oleh Admin.' using errcode = '42501';
  end if;
  if p_dimensi not in ('gender','pendidikan','status_nikah','pekerjaan',
                       'provinsi','kota','kecamatan','kelurahan','rentang_usia',
                       'baptis','status_jemaat') then
    raise exception 'Dimensi tidak dikenal: %', p_dimensi using errcode = '22023';
  end if;
  if p_cakupan not in ('semua','tim','kelompok')
     or (p_cakupan <> 'semua' and p_cakupan_id is null) then
    raise exception 'Cakupan laporan tidak valid.' using errcode = '22023';
  end if;

  perform internal.catat_log('buat_laporan_demografi', jsonb_build_object(
    'dimensi', p_dimensi, 'cakupan', p_cakupan,
    'cakupan_id', p_cakupan_id, 'hanya_aktif', p_hanya_aktif));

  return query
  with data as (
    select t.nama as t_nama, k.id as k_id, k.nama as k_nama,
      case p_dimensi
        when 'gender'        then a.gender::text
        when 'pendidikan'    then a.pendidikan::text
        when 'status_nikah'  then a.status_nikah::text
        when 'pekerjaan'     then a.pekerjaan::text
        when 'provinsi'      then a.provinsi_kode
        when 'kota'          then a.kota_kode
        when 'kecamatan'     then a.kecamatan_kode
        when 'kelurahan'     then a.kelurahan_kode
        when 'rentang_usia'  then internal.rentang_usia(a.tanggal_lahir)
        when 'baptis'        then case a.baptis when true then 'sudah' when false then 'belum' end
        when 'status_jemaat' then a.status_jemaat::text
      end as v
    from public.anggota a
    join public.kelompok k on k.id = a.kelompok_id
    join public.tim t      on t.id = k.tim_id
    where (not p_hanya_aktif or a.aktif)
      and (p_cakupan = 'semua'
           or (p_cakupan = 'tim'      and k.tim_id = p_cakupan_id)
           or (p_cakupan = 'kelompok' and k.id     = p_cakupan_id))
  ),
  hitung as (
    select d.t_nama, d.k_id, d.k_nama, d.v, count(*) as n
    from data d group by d.t_nama, d.k_id, d.k_nama, d.v
  )
  select h.t_nama, h.k_id, h.k_nama, h.v,
         case when h.v is null then 'Belum diisi'
              when p_dimensi in ('provinsi','kota','kecamatan','kelurahan')
                then coalesce(w.nama, h.v)
              else h.v end,
         h.n,
         case when h.v is null then null
              else round(100.0 * h.n / nullif(sum(h.n) filter (where h.v is not null)
                                              over (partition by h.k_id), 0), 1) end
  from hitung h
  left join public.wilayah w on w.kode = h.v
  order by h.t_nama, h.k_nama, (h.v is null), h.v;
end;
$$;

revoke all on all functions in schema internal from public, anon, authenticated;

$mig1800$;
    v_dijalankan := v_dijalankan || '20261118001800_baptis_status_jemaat.sql'::text;
  end if;

  -- 20261118001900_laporan_generasi.sql
  if not (exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'internal' and p.proname = 'generasi')) then
    execute $mig1900$
-- =====================================================================
-- 19 · LAPORAN DEMOGRAFI: KELOMPOK GENERASI (keputusan 31)
--
-- Dimensi baru "generasi" menurut TAHUN lahir:
--   beta    2025 ke atas      alpha   2013-2024     z  1997-2012
--   y       1981-1996         x       1965-1980
--   boomers 1946-1964         silent  1945 ke bawah
-- (Pew Research; Alpha dan Beta menurut McCrindle.)
-- Batas tahun cukup diubah di fungsi internal.generasi.
-- =====================================================================

create function internal.generasi(p_lahir date)
returns text
language sql immutable set search_path = ''
as $$
  select case
    when p_lahir is null then null
    when y >= 2025 then 'beta'
    when y >= 2013 then 'alpha'
    when y >= 1997 then 'z'
    when y >= 1981 then 'y'
    when y >= 1965 then 'x'
    when y >= 1946 then 'boomers'
    else 'silent'
  end
  from (select extract(year from p_lahir)::int as y) t;
$$;


-- Laporan demografi (isi sama dengan file 18, ditambah dimensi generasi).
create or replace function public.laporan_demografi(
  p_dimensi     text,
  p_cakupan     text    default 'semua',
  p_cakupan_id  uuid    default null,
  p_hanya_aktif boolean default true
)
returns table (
  tim_nama      text,
  kelompok_id   uuid,
  kelompok_nama text,
  kunci         text,
  label         text,
  jumlah        bigint,
  persen        numeric
)
language plpgsql security definer set search_path = ''
as $$
#variable_conflict use_column
begin
  if not bantu.saya_admin() then
    raise exception 'Laporan demografi hanya dapat dibuka oleh Admin.' using errcode = '42501';
  end if;
  if p_dimensi not in ('gender','pendidikan','status_nikah','pekerjaan',
                       'provinsi','kota','kecamatan','kelurahan','rentang_usia',
                       'baptis','status_jemaat','generasi') then
    raise exception 'Dimensi tidak dikenal: %', p_dimensi using errcode = '22023';
  end if;
  if p_cakupan not in ('semua','tim','kelompok')
     or (p_cakupan <> 'semua' and p_cakupan_id is null) then
    raise exception 'Cakupan laporan tidak valid.' using errcode = '22023';
  end if;

  perform internal.catat_log('buat_laporan_demografi', jsonb_build_object(
    'dimensi', p_dimensi, 'cakupan', p_cakupan,
    'cakupan_id', p_cakupan_id, 'hanya_aktif', p_hanya_aktif));

  return query
  with data as (
    select t.nama as t_nama, k.id as k_id, k.nama as k_nama,
      case p_dimensi
        when 'gender'        then a.gender::text
        when 'pendidikan'    then a.pendidikan::text
        when 'status_nikah'  then a.status_nikah::text
        when 'pekerjaan'     then a.pekerjaan::text
        when 'provinsi'      then a.provinsi_kode
        when 'kota'          then a.kota_kode
        when 'kecamatan'     then a.kecamatan_kode
        when 'kelurahan'     then a.kelurahan_kode
        when 'rentang_usia'  then internal.rentang_usia(a.tanggal_lahir)
        when 'baptis'        then case a.baptis when true then 'sudah' when false then 'belum' end
        when 'status_jemaat' then a.status_jemaat::text
        when 'generasi'      then internal.generasi(a.tanggal_lahir)
      end as v
    from public.anggota a
    join public.kelompok k on k.id = a.kelompok_id
    join public.tim t      on t.id = k.tim_id
    where (not p_hanya_aktif or a.aktif)
      and (p_cakupan = 'semua'
           or (p_cakupan = 'tim'      and k.tim_id = p_cakupan_id)
           or (p_cakupan = 'kelompok' and k.id     = p_cakupan_id))
  ),
  hitung as (
    select d.t_nama, d.k_id, d.k_nama, d.v, count(*) as n
    from data d group by d.t_nama, d.k_id, d.k_nama, d.v
  )
  select h.t_nama, h.k_id, h.k_nama, h.v,
         case when h.v is null then 'Belum diisi'
              when p_dimensi in ('provinsi','kota','kecamatan','kelurahan')
                then coalesce(w.nama, h.v)
              else h.v end,
         h.n,
         case when h.v is null then null
              else round(100.0 * h.n / nullif(sum(h.n) filter (where h.v is not null)
                                              over (partition by h.k_id), 0), 1) end
  from hitung h
  left join public.wilayah w on w.kode = h.v
  order by h.t_nama, h.k_nama, (h.v is null), h.v;
end;
$$;

revoke all on all functions in schema internal from public, anon, authenticated;

$mig1900$;
    v_dijalankan := v_dijalankan || '20261118001900_laporan_generasi.sql'::text;
  end if;

  -- 20261118002000_reset_ketua_tim.sql
  if not (exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'public' and p.proname = 'akun_bisa_atur_ulang')) then
    execute $mig2000$
-- =====================================================================
-- 20 · ATUR ULANG KATA SANDI OLEH KETUA TIM (keputusan 34)
--
-- Siapa boleh membuat tautan atur ulang kata sandi untuk siapa:
--   * Admin          : semua akun (kecuali dirinya sendiri; ganti sendiri di Atur profil).
--   * Ketua Tim      : anggota DAN pemimpin/wakil kelompok di timnya.
--                      Tidak untuk Admin, Ketua Tim (mana pun), atau pengurus
--                      yang juga memegang peran di luar timnya.
--   * Pemimpin/Wakil : anggota kelompoknya yang bukan pengurus (seperti
--                      sebelumnya; sesama pengurus tidak saling reset).
-- Cara tetap: tautan 24 jam sekali pakai (keputusan 6).
-- =====================================================================

-- Bolehkah saya membuat tautan atur ulang untuk akun ini?
create function bantu.boleh_atur_ulang_sandi(p_akun uuid)
returns boolean
language sql stable security definer set search_path = ''
as $$
  select p_akun is not null and auth.uid() is not null and p_akun <> auth.uid()
     and exists (select 1 from public.akun where id = p_akun)
     and (
       bantu.saya_admin()
       -- Ketua Tim: target terhubung ke timnya (anggota atau pengurus kelompok di timnya) ...
       or ((exists (select 1 from public.akun ak
                    join public.anggota a on a.id = ak.anggota_id
                    join public.kelompok k on k.id = a.kelompok_id
                    where ak.id = p_akun and k.tim_id in (select bantu.tim_diketuai()))
            or exists (select 1 from public.penugasan_peran p
                       join public.kelompok k on k.id = p.kelompok_id
                       where p.akun_id = p_akun and p.peran = 'pemimpin'
                         and k.tim_id in (select bantu.tim_diketuai())))
           -- ... dan tidak memegang peran apa pun di luar pengurus kelompok timnya.
           and not exists (select 1 from public.penugasan_peran p
                           left join public.kelompok k on k.id = p.kelompok_id
                           where p.akun_id = p_akun
                             and (p.peran <> 'pemimpin'
                                  or k.tim_id is null
                                  or k.tim_id not in (select bantu.tim_diketuai()))))
       -- Pemimpin/Wakil: anggota kelompoknya yang bukan pengurus.
       or (not exists (select 1 from public.penugasan_peran p where p.akun_id = p_akun)
           and exists (select 1 from public.akun ak
                       join public.anggota a on a.id = ak.anggota_id
                       where ak.id = p_akun
                         and a.kelompok_id in (select bantu.kelompok_dipimpin_langsung())))
     );
$$;
revoke all on function bantu.boleh_atur_ulang_sandi(uuid) from public, anon;
grant execute on function bantu.boleh_atur_ulang_sandi(uuid) to authenticated;


-- Membuat tautan atur ulang (isi sama dengan file 06, aturan hak diganti).
create or replace function public.buat_tautan_atur_ulang(p_akun uuid)
returns table (token text, kedaluwarsa_pada timestamptz)
language plpgsql security definer set search_path = ''
as $$
#variable_conflict use_column
declare
  v_token text := encode(extensions.gen_random_bytes(24), 'hex');
  v_kedaluwarsa timestamptz;
begin
  if not bantu.boleh_atur_ulang_sandi(p_akun) then
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


-- Akun di satu kelompok yang boleh saya atur ulang kata sandinya
-- (untuk daftar di halaman kelompok, terutama bagi Ketua Tim).
create function public.akun_bisa_atur_ulang(p_kelompok uuid)
returns table (akun_id uuid, nama text, keterangan text, login text)
language sql stable security definer set search_path = ''
as $$
  with calon as (
    select ak.id, ak.nama_tampilan, ak.login, 'Anggota'::text as ket, 2 as urut
    from public.akun ak join public.anggota a on a.id = ak.anggota_id
    where a.kelompok_id = p_kelompok
    union
    select ak.id, ak.nama_tampilan, ak.login,
           case p.jabatan when 'wakil' then 'Wakil' else 'Pemimpin' end, 1
    from public.penugasan_peran p join public.akun ak on ak.id = p.akun_id
    where p.kelompok_id = p_kelompok and p.peran = 'pemimpin'
  )
  select distinct on (c.id) c.id, c.nama_tampilan, c.ket, c.login
  from calon c
  where bantu.boleh_atur_ulang_sandi(c.id)
  order by c.id, c.urut;
$$;
revoke all on function public.akun_bisa_atur_ulang(uuid) from public, anon;
grant execute on function public.akun_bisa_atur_ulang(uuid) to authenticated;

revoke all on all functions in schema internal from public, anon, authenticated;

$mig2000$;
    v_dijalankan := v_dijalankan || '20261118002000_reset_ketua_tim.sql'::text;
  end if;

  -- 20261118002100_masukkan_akun.sql
  if not (exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'bantu' and p.proname = 'boleh_masukkan_ke_kelompok')) then
    execute $mig2100$
-- =====================================================================
-- 21 · MEMASUKKAN AKUN YANG BELUM TERGABUNG KE SEBUAH KELOMPOK (keputusan 35)
--
-- Akun "belum tergabung" = akun tanpa profil anggota (anggota_id kosong):
-- dibuat Admin, kelompoknya dihapus, atau profilnya terhapus otomatis.
-- Akun pengurus juga boleh dimasukkan sebagai anggota.
--
-- * Pemimpin/Wakil : ke kelompoknya sendiri.
-- * Ketua Tim      : ke kelompok mana pun di timnya.
-- * Admin          : ke kelompok mana pun.
-- * Mencari akun: Pemimpin/Ketua Tim mengetik nama pengguna, email, atau
--   nomor HP yang PERSIS; Admin juga bisa melihat daftar lengkap.
-- * Langsung masuk (tanpa konfirmasi pemilik akun); tercatat di log. Data
--   pribadinya tetap baru bisa diisi setelah persetujuan data.
-- =====================================================================

-- Bolehkah saya memasukkan anggota ke kelompok ini?
create function bantu.boleh_masukkan_ke_kelompok(p_kelompok uuid)
returns boolean
language sql stable security definer set search_path = ''
as $$
  select p_kelompok is not null and (
       bantu.saya_admin()
    or p_kelompok in (select bantu.kelompok_dipimpin_langsung())
    or exists (select 1 from public.kelompok k
               where k.id = p_kelompok and k.tim_id in (select bantu.tim_diketuai()))
  );
$$;
revoke all on function bantu.boleh_masukkan_ke_kelompok(uuid) from public, anon;
grant execute on function bantu.boleh_masukkan_ke_kelompok(uuid) to authenticated;


-- 1. Mencari SATU akun yang belum tergabung dengan isian persis
--    (nama pengguna, email, atau nomor HP). Hanya untuk pengurus.
create function public.cari_akun_belum_tergabung(p_isian text)
returns table (akun_id uuid, nama text, login text)
language plpgsql stable security definer set search_path = ''
as $$
declare
  v    text := lower(trim(coalesce(p_isian, '')));
  v_hp text;
begin
  if auth.uid() is null or not (
       bantu.saya_admin()
    or exists (select 1 from public.penugasan_peran p
               where p.akun_id = auth.uid() and p.peran in ('pemimpin', 'ketua_tim'))) then
    raise exception 'Hanya pemimpin kelompok, ketua tim, atau Admin yang bisa mencari akun.' using errcode = '42501';
  end if;
  if v = '' then return; end if;
  v_hp := case when v not like '%@%' then internal.normal_hp(v) end;

  return query
    select ak.id, ak.nama_tampilan, ak.login
    from public.akun ak
    where ak.anggota_id is null
      and (ak.email = v or ak.nama_pengguna = v or (v_hp is not null and ak.nomor_hp = v_hp));
end;
$$;

-- 2. Daftar lengkap akun yang belum tergabung (khusus Admin).
create function public.akun_belum_tergabung()
returns table (akun_id uuid, nama text, login text, peran text, dibuat_pada timestamptz)
language plpgsql stable security definer set search_path = ''
as $$
begin
  if not bantu.saya_admin() then
    raise exception 'Daftar lengkap hanya untuk Admin.' using errcode = '42501';
  end if;
  return query
    select ak.id, ak.nama_tampilan, ak.login,
           (select string_agg(distinct case p.peran when 'admin' then 'Admin' when 'ketua_tim' then 'Ketua Tim'
                                       else case p.jabatan when 'wakil' then 'Wakil' else 'Pemimpin' end end, ', ')
            from public.penugasan_peran p where p.akun_id = ak.id),
           ak.dibuat_pada
    from public.akun ak
    where ak.anggota_id is null
    order by ak.nama_tampilan;
end;
$$;

-- 3. Memasukkan akun ke kelompok: profil anggota baru dibuat dan
--    disambungkan ke akun itu.
create function public.masukkan_akun_ke_kelompok(p_akun uuid, p_kelompok uuid)
returns uuid
language plpgsql security definer set search_path = ''
as $$
declare
  v_akun    public.akun;
  v_anggota uuid;
begin
  if auth.uid() is null or not bantu.boleh_masukkan_ke_kelompok(p_kelompok) then
    raise exception 'Anda tidak berhak memasukkan anggota ke kelompok ini.' using errcode = '42501';
  end if;
  select * into v_akun from public.akun where id = p_akun for update;
  if v_akun.id is null then
    raise exception 'Akun tidak ditemukan.' using errcode = '22023';
  end if;
  if v_akun.anggota_id is not null then
    raise exception 'Akun ini sudah tergabung di sebuah kelompok. Gunakan Pindah kelompok di profil anggotanya.'
      using errcode = '22023';
  end if;

  insert into public.anggota (kelompok_id, nama_lengkap)
  values (p_kelompok, v_akun.nama_tampilan)
  returning id into v_anggota;

  update public.akun set anggota_id = v_anggota where id = p_akun;

  perform internal.catat_log('masukkan_akun_ke_kelompok',
    jsonb_build_object('akun_id', p_akun, 'anggota_id', v_anggota, 'kelompok_id', p_kelompok));
  return v_anggota;
end;
$$;

revoke all on function public.cari_akun_belum_tergabung(text)            from public, anon;
revoke all on function public.akun_belum_tergabung()                     from public, anon;
revoke all on function public.masukkan_akun_ke_kelompok(uuid, uuid)      from public, anon;
grant execute on function public.cari_akun_belum_tergabung(text)         to authenticated;
grant execute on function public.akun_belum_tergabung()                  to authenticated;
grant execute on function public.masukkan_akun_ke_kelompok(uuid, uuid)   to authenticated;

revoke all on all functions in schema internal from public, anon, authenticated;

$mig2100$;
    v_dijalankan := v_dijalankan || '20261118002100_masukkan_akun.sql'::text;
  end if;

  -- 20261118002200_laporan_proyek.sql
  if not (exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'public' and p.proname = 'lapor_proyek_saya')) then
    execute $mig2200$
-- =====================================================================
-- 22 · ANGGOTA MELAPORKAN SENDIRI PROYEK KETAATANNYA (keputusan 36)
--
-- * Setiap anggota (termasuk pemimpin yang terdaftar sebagai anggota)
--   melaporkan proyek kelompoknya:
--     belum   = Belum dijalankan  + ALASAN (wajib)
--     sedang  = Sedang dijalankan
--     selesai = Sudah selesai     + HASIL yang didapat (wajib)
-- * Anggota hanya membaca proyek kelompoknya dan status MILIKNYA sendiri
--   (lewat loket; tabel tetap tidak bisa dibaca anggota).
-- * Pemimpin/Wakil dan Admin tetap boleh mengubah status (termasuk
--   "Tidak dikerjakan"). Tercatat siapa yang terakhir mengubah dan
--   apakah dilaporkan sendiri.
-- =====================================================================

alter table public.status_proyek
  add column alasan             text check (alasan is null or length(alasan) <= 1000),
  add column hasil              text check (hasil  is null or length(hasil)  <= 2000),
  add column dilaporkan_sendiri boolean not null default false,
  add column diubah_oleh        uuid references public.akun(id) on delete set null;

comment on column public.status_proyek.alasan is 'Alasan belum dijalankan (dilaporkan anggota).';
comment on column public.status_proyek.hasil  is 'Hasil yang didapat setelah selesai (dilaporkan anggota).';
comment on column public.status_proyek.dilaporkan_sendiri is 'true = perubahan status terakhir dilakukan anggota itu sendiri.';

-- Siapa yang terakhir mengubah; alasan/hasil hanya disimpan untuk status yang cocok.
create function internal.catat_pelapor_proyek()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  if new.status <> 'belum'   then new.alasan := null; end if;
  if new.status <> 'selesai' then new.hasil  := null; end if;

  if tg_op = 'INSERT'
     or new.status is distinct from old.status
     or new.alasan is distinct from old.alasan
     or new.hasil  is distinct from old.hasil then
    new.diubah_oleh := coalesce(auth.uid(), new.diubah_oleh);
    new.dilaporkan_sendiri := auth.uid() is not null and exists (
      select 1 from public.akun ak where ak.id = auth.uid() and ak.anggota_id = new.anggota_id);
  end if;
  return new;
end;
$$;

create trigger catat_pelapor_proyek before insert or update on public.status_proyek
  for each row execute function internal.catat_pelapor_proyek();


-- ---------------------------------------------------------------------
-- 1. Proyek kelompok saya beserta status MILIK SAYA
-- ---------------------------------------------------------------------
create function public.proyek_saya()
returns table (
  proyek_id uuid, judul text, keterangan text, diberikan_pada date, tenggat date,
  status public.status_pengerjaan, alasan text, hasil text,
  dilaporkan_sendiri boolean, diubah_pada timestamptz)
language sql stable security definer set search_path = ''
as $$
  select p.id, p.judul, p.keterangan, p.diberikan_pada, p.tenggat,
         coalesce(s.status, 'belum'), s.alasan, s.hasil,
         coalesce(s.dilaporkan_sendiri, false), s.diubah_pada
  from public.anggota a
  join public.proyek_ketaatan p on p.kelompok_id = a.kelompok_id
  left join public.status_proyek s on s.proyek_id = p.id and s.anggota_id = a.id
  where a.id = bantu.anggota_saya()
  order by p.diberikan_pada desc, p.judul;
$$;


-- ---------------------------------------------------------------------
-- 2. Melaporkan proyek sendiri
-- ---------------------------------------------------------------------
create function public.lapor_proyek_saya(
  p_proyek uuid, p_status public.status_pengerjaan, p_alasan text default null, p_hasil text default null)
returns void
language plpgsql security definer set search_path = ''
as $$
declare
  v_anggota uuid := bantu.anggota_saya();
  v_alasan  text := nullif(trim(coalesce(p_alasan, '')), '');
  v_hasil   text := nullif(trim(coalesce(p_hasil, '')), '');
begin
  if v_anggota is null then
    raise exception 'Hanya anggota kelompok yang bisa melaporkan proyek ketaatan.' using errcode = '42501';
  end if;
  if not exists (select 1 from public.proyek_ketaatan p join public.anggota a on a.kelompok_id = p.kelompok_id
                 where p.id = p_proyek and a.id = v_anggota) then
    raise exception 'Proyek ini bukan proyek kelompok Anda.' using errcode = '42501';
  end if;
  if p_status is null or p_status not in ('belum', 'sedang', 'selesai') then
    raise exception 'Pilih: belum dijalankan, sedang dijalankan, atau sudah selesai.' using errcode = '22023';
  end if;
  if p_status = 'belum' and v_alasan is null then
    raise exception 'Tuliskan alasan belum menjalankan proyek ini.' using errcode = '22023';
  end if;
  if p_status = 'selesai' and v_hasil is null then
    raise exception 'Tuliskan hasil yang didapat dari menjalankan proyek ini.' using errcode = '22023';
  end if;
  if length(coalesce(v_alasan, '')) > 1000 or length(coalesce(v_hasil, '')) > 2000 then
    raise exception 'Alasan maksimal 1000 karakter dan hasil maksimal 2000 karakter.' using errcode = '22023';
  end if;

  insert into public.status_proyek (proyek_id, anggota_id, status, alasan, hasil)
  values (p_proyek, v_anggota, p_status, v_alasan, v_hasil)
  on conflict (proyek_id, anggota_id)
  do update set status = excluded.status, alasan = excluded.alasan, hasil = excluded.hasil;

  perform internal.catat_log('lapor_proyek', jsonb_build_object('proyek_id', p_proyek, 'status', p_status));
end;
$$;

revoke all on function public.proyek_saya() from public, anon;
revoke all on function public.lapor_proyek_saya(uuid, public.status_pengerjaan, text, text) from public, anon;
grant execute on function public.proyek_saya() to authenticated;
grant execute on function public.lapor_proyek_saya(uuid, public.status_pengerjaan, text, text) to authenticated;

revoke all on all functions in schema internal from public, anon, authenticated;

$mig2200$;
    v_dijalankan := v_dijalankan || '20261118002200_laporan_proyek.sql'::text;
  end if;

  -- 20261118002300_laporan_proyek_admin.sql
  if not (exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'public' and p.proname = 'laporan_proyek')) then
    execute $mig2300$
-- =====================================================================
-- 23 · LAPORAN PELAKSANAAN PROYEK KETAATAN UNTUK ADMIN (keputusan 38)
--
-- Satu baris per (proyek × anggota) dalam cakupan: semua tim, satu tim,
-- atau satu kelompok. Anggota yang dihitung: anggota aktif, ditambah
-- anggota tidak aktif yang sudah punya status di proyek itu (sama seperti
-- halaman proyek). Aplikasi menyusun ringkasan dan tabelnya.
--   dilaporkan = false -> "Belum dilaporkan" (belum ada status sama sekali)
-- Khusus Admin; setiap pembuatan tercatat di log.
-- =====================================================================
create function public.laporan_proyek(p_cakupan text default 'semua', p_cakupan_id uuid default null)
returns table (
  tim_nama text, kelompok_id uuid, kelompok_nama text,
  proyek_id uuid, judul text, diberikan_pada date, tenggat date,
  anggota_id uuid, anggota_nama text, anggota_aktif boolean,
  status public.status_pengerjaan, dilaporkan boolean,
  alasan text, hasil text, keterangan text, dilaporkan_sendiri boolean, diubah_pada timestamptz)
language plpgsql security definer set search_path = ''
as $$
begin
  if not bantu.saya_admin() then
    raise exception 'Laporan proyek ketaatan hanya dapat dibuka oleh Admin.' using errcode = '42501';
  end if;
  if p_cakupan not in ('semua', 'tim', 'kelompok') or (p_cakupan <> 'semua' and p_cakupan_id is null) then
    raise exception 'Cakupan laporan tidak valid.' using errcode = '22023';
  end if;

  perform internal.catat_log('buat_laporan_proyek',
    jsonb_build_object('cakupan', p_cakupan, 'cakupan_id', p_cakupan_id));

  return query
    select t.nama, k.id, k.nama,
           p.id, p.judul, p.diberikan_pada, p.tenggat,
           a.id, a.nama_lengkap, a.aktif,
           coalesce(s.status, 'belum'), s.proyek_id is not null,
           s.alasan, s.hasil, s.keterangan, coalesce(s.dilaporkan_sendiri, false), s.diubah_pada
    from public.proyek_ketaatan p
    join public.kelompok k on k.id = p.kelompok_id
    join public.tim t      on t.id = k.tim_id
    join public.anggota a  on a.kelompok_id = k.id
    left join public.status_proyek s on s.proyek_id = p.id and s.anggota_id = a.id
    where (a.aktif or s.proyek_id is not null)
      and (p_cakupan = 'semua'
           or (p_cakupan = 'tim'      and k.tim_id = p_cakupan_id)
           or (p_cakupan = 'kelompok' and k.id     = p_cakupan_id))
    order by t.nama, k.nama, p.diberikan_pada desc, p.judul, a.nama_lengkap;
end;
$$;

revoke all on function public.laporan_proyek(text, uuid) from public, anon;
grant execute on function public.laporan_proyek(text, uuid) to authenticated;

$mig2300$;
    v_dijalankan := v_dijalankan || '20261118002300_laporan_proyek_admin.sql'::text;
  end if;

  -- 20261118002400_bahan_diskusi.sql
  if not (exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'bantu' and p.proname = 'boleh_baca_bahan')) then
    execute $mig2400$
-- =====================================================================
-- 24 · BAHAN DISKUSI (PDF) UNTUK PENGURUS (keputusan 39)
--
-- * Hanya Admin yang mengunggah, mengubah, dan menghapus.
-- * Dibuka dan diunduh oleh Ketua Tim serta Pemimpin/Wakil kelompok:
--     tim_id kosong  = untuk semua tim (semua pengurus)
--     tim_id terisi  = hanya pengurus di tim itu
-- * Anggota biasa tidak punya akses (tabel maupun berkas).
-- * Berkas PDF maksimal 10 MB di folder privat bahan-diskusi/<id bahan>/.
-- =====================================================================

-- 1. Folder penyimpanan privat
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('bahan-diskusi', 'bahan-diskusi', false, 10485760, array['application/pdf'])
on conflict (id) do update
  set public = false,
      file_size_limit = excluded.file_size_limit,
      allowed_mime_types = excluded.allowed_mime_types;


-- 2. Tabel bahan diskusi
create table public.bahan_diskusi (
  id            uuid primary key default gen_random_uuid(),
  judul         text not null check (length(trim(judul)) between 1 and 150),
  keterangan    text check (keterangan is null or length(keterangan) <= 1000),
  tanggal_pakai date,
  tim_id        uuid references public.tim(id) on delete cascade,  -- kosong = semua tim
  lokasi        text not null unique,
  nama_berkas   text not null check (length(trim(nama_berkas)) > 0),
  ukuran        integer not null check (ukuran > 0 and ukuran <= 10485760),
  diunggah_oleh uuid references public.akun(id) on delete set null default auth.uid(),
  dibuat_pada   timestamptz not null default now(),
  constraint bahan_di_foldernya check (lokasi like id::text || '/%')
);
create index on public.bahan_diskusi (tim_id);
comment on table public.bahan_diskusi is
  'Bahan diskusi PDF dari Admin untuk Ketua Tim dan Pemimpin/Wakil (berkas di folder privat bahan-diskusi).';

-- Bolehkah saya membuka bahan untuk tim ini? (kosong = semua tim)
create function bantu.boleh_baca_bahan(p_tim uuid)
returns boolean
language sql stable security definer set search_path = ''
as $$
  select bantu.saya_admin()
      or (p_tim is null and exists (select 1 from public.penugasan_peran p
                                    where p.akun_id = auth.uid() and p.peran in ('ketua_tim', 'pemimpin')))
      or p_tim in (select bantu.tim_diketuai())
      or p_tim in (select k.tim_id from public.kelompok k
                   where k.id in (select bantu.kelompok_dipimpin_langsung()));
$$;

-- Untuk aturan berkas: lokasi berkas -> boleh dibaca?
create function bantu.boleh_baca_berkas_bahan(p_lokasi text)
returns boolean
language sql stable security definer set search_path = ''
as $$
  select exists (select 1 from public.bahan_diskusi b
                 where b.lokasi = p_lokasi and bantu.boleh_baca_bahan(b.tim_id));
$$;

revoke all on function bantu.boleh_baca_bahan(uuid)        from public, anon;
revoke all on function bantu.boleh_baca_berkas_bahan(text) from public, anon;
grant execute on function bantu.boleh_baca_bahan(uuid)        to authenticated;
grant execute on function bantu.boleh_baca_berkas_bahan(text) to authenticated;

alter table public.bahan_diskusi enable row level security;
revoke all on public.bahan_diskusi from anon;
grant select, insert, update, delete on public.bahan_diskusi to authenticated;

create policy "bahan: baca pengurus sesuai tim" on public.bahan_diskusi
  for select to authenticated
  using ((select bantu.boleh_baca_bahan(tim_id)));
create policy "bahan: admin menambah" on public.bahan_diskusi
  for insert to authenticated
  with check ((select bantu.saya_admin()));
create policy "bahan: admin mengubah" on public.bahan_diskusi
  for update to authenticated
  using ((select bantu.saya_admin())) with check ((select bantu.saya_admin()));
create policy "bahan: admin menghapus" on public.bahan_diskusi
  for delete to authenticated
  using ((select bantu.saya_admin()));

-- Pengunggah dan lokasi berkas tidak bisa dipalsukan / dipindah.
create function internal.jaga_bahan_diskusi()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  if tg_op = 'INSERT' then
    new.diunggah_oleh := coalesce(auth.uid(), new.diunggah_oleh);
    perform internal.catat_log('unggah_bahan_diskusi', jsonb_build_object('bahan_id', new.id, 'tim_id', new.tim_id));
  else
    new.lokasi := old.lokasi;
    new.nama_berkas := old.nama_berkas;
    new.ukuran := old.ukuran;
    new.diunggah_oleh := old.diunggah_oleh;
  end if;
  return new;
end;
$$;
create trigger jaga_bahan_diskusi before insert or update on public.bahan_diskusi
  for each row execute function internal.jaga_bahan_diskusi();

-- Bahan dihapus (atau ikut terhapus bersama timnya): berkasnya masuk antrean hapus.
create function internal.setelah_bahan_dihapus()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  insert into internal.antrean_hapus_foto (foto_path, bucket) values (old.lokasi, 'bahan-diskusi');
  perform internal.catat_log('hapus_bahan_diskusi', jsonb_build_object('bahan_id', old.id));
  return old;
end;
$$;
create trigger setelah_bahan_dihapus after delete on public.bahan_diskusi
  for each row execute function internal.setelah_bahan_dihapus();


-- 3. Aturan berkas di folder bahan-diskusi
create policy "bahan diskusi: lihat" on storage.objects
  for select to authenticated
  using (bucket_id = 'bahan-diskusi'
         and ((select bantu.saya_admin()) or (select bantu.boleh_baca_berkas_bahan(name))));
create policy "bahan diskusi: admin unggah" on storage.objects
  for insert to authenticated
  with check (bucket_id = 'bahan-diskusi' and (select bantu.saya_admin()));
create policy "bahan diskusi: admin hapus" on storage.objects
  for delete to authenticated
  using (bucket_id = 'bahan-diskusi' and (select bantu.saya_admin()));

revoke all on all functions in schema internal from public, anon, authenticated;

$mig2400$;
    v_dijalankan := v_dijalankan || '20261118002400_bahan_diskusi.sql'::text;
  end if;

  -- 20261118002500_penghapus_berkas.sql
  if not (exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'public' and p.proname = 'layanan_ambil_antrean_berkas')) then
    execute $mig2500$
-- =====================================================================
-- 25 · PENGHAPUS BERKAS OTOMATIS (keputusan 40)
--
-- Foto, bukti transfer, dan bahan diskusi yang datanya sudah dihapus
-- dicatat di internal.antrean_hapus_foto (lokasi + folder). Berkasnya
-- dihapus dari penyimpanan oleh server aplikasi (setiap malam lewat
-- Vercel Cron, atau tombol Admin), memakai loket di bawah.
--
-- Pengaman: berkas yang ternyata MASIH dipakai data mana pun tidak
-- dihapus; barisnya hanya dikeluarkan dari antrean.
-- =====================================================================

-- Apakah berkas ini masih dipakai?
create function internal.berkas_masih_dipakai(p_bucket text, p_lokasi text)
returns boolean
language sql stable security definer set search_path = ''
as $$
  select case p_bucket
    when 'foto-anggota' then
         exists (select 1 from public.anggota where foto_path = p_lokasi)
      or exists (select 1 from public.profil_staf where foto_path = p_lokasi)
    when 'bukti-persembahan' then
         exists (select 1 from public.bukti_persembahan where lokasi = p_lokasi)
    when 'bahan-diskusi' then
         exists (select 1 from public.bahan_diskusi where lokasi = p_lokasi)
    else true  -- folder tidak dikenal: jangan dihapus
  end;
$$;

-- 1. (server) Mengambil berkas yang siap dihapus, paling banyak p_batas.
--    Baris untuk berkas yang masih dipakai langsung dikeluarkan dari antrean.
create function public.layanan_ambil_antrean_berkas(p_batas integer default 500)
returns table (id bigint, bucket text, lokasi text)
language plpgsql security definer set search_path = ''
as $$
begin
  delete from internal.antrean_hapus_foto a
   where internal.berkas_masih_dipakai(a.bucket, a.foto_path);

  return query
    select a.id, a.bucket, a.foto_path
    from internal.antrean_hapus_foto a
    order by a.id
    limit greatest(1, least(coalesce(p_batas, 500), 1000));
end;
$$;

-- 2. (server) Menandai berkas sudah dihapus dari penyimpanan.
create function public.layanan_selesai_antrean_berkas(p_id bigint[])
returns integer
language plpgsql security definer set search_path = ''
as $$
declare
  n integer;
begin
  delete from internal.antrean_hapus_foto where id = any (coalesce(p_id, '{}'));
  get diagnostics n = row_count;
  if n > 0 then
    perform internal.catat_log('hapus_berkas_antrean', jsonb_build_object('jumlah', n));
  end if;
  return n;
end;
$$;

-- 3. Jumlah berkas yang menunggu dihapus (untuk halaman Admin).
create function public.jumlah_antrean_berkas()
returns integer
language plpgsql stable security definer set search_path = ''
as $$
begin
  if not bantu.saya_admin() then
    raise exception 'Hanya Admin.' using errcode = '42501';
  end if;
  return (select count(*)::integer from internal.antrean_hapus_foto);
end;
$$;

revoke all on function public.layanan_ambil_antrean_berkas(integer)   from public, anon, authenticated;
revoke all on function public.layanan_selesai_antrean_berkas(bigint[]) from public, anon, authenticated;
revoke all on function public.jumlah_antrean_berkas()                  from public, anon;
grant execute on function public.layanan_ambil_antrean_berkas(integer)   to service_role;
grant execute on function public.layanan_selesai_antrean_berkas(bigint[]) to service_role;
grant execute on function public.jumlah_antrean_berkas()                  to authenticated;

revoke all on all functions in schema internal from public, anon, authenticated;

$mig2500$;
    v_dijalankan := v_dijalankan || '20261118002500_penghapus_berkas.sql'::text;
  end if;

  -- 20261119002600_buat_hapus_akun.sql
  if not (exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'public' and p.proname = 'hapus_akun')) then
    execute $mig2600$
-- =====================================================================
-- 26 · MEMBUAT AKUN OLEH PENGURUS & MENGHAPUS AKUN OLEH ADMIN
--      (keputusan 41 dan 42)
--
-- A. Membuat akun baru langsung dengan tujuannya (keputusan 42):
--    * Pemimpin/Wakil : anggota kelompoknya sendiri.
--    * Ketua Tim      : anggota, Pemimpin, atau Wakil kelompok di timnya.
--    * Admin          : semua di atas untuk kelompok mana pun, Ketua Tim
--                       tim mana pun, Admin, atau tanpa tujuan.
--    Kata sandinya sementara (wajib diganti saat login pertama).
--
--    Langkahnya (akun login hanya bisa dibuat server dengan kunci rahasia):
--    1. izin_buat_akun(...)   : pengurus meminta izin; hak diperiksa di sini.
--                               Hasilnya kode izin (berlaku 15 menit, sekali).
--    2. Server membuat akun login, kode izin ikut disimpan di data akun.
--    3. pasang_akun_baru(...) : pengurus yang sama memasang tujuannya
--                               (profil anggota atau peran). Hak diperiksa lagi.
--
-- B. Menghapus akun (keputusan 41): hanya Admin, setelah mengetik nama akun
--    persis. Admin memilih apakah profil anggotanya ikut dihapus. Admin
--    tidak bisa menghapus akunnya sendiri.
-- =====================================================================

create table internal.izin_buat_akun (
  id           uuid primary key default gen_random_uuid(),
  pembuat      uuid not null references public.akun(id) on delete cascade,
  tujuan       text not null check (tujuan in ('anggota', 'pemimpin', 'wakil', 'ketua_tim', 'admin', 'tanpa')),
  kelompok_id  uuid references public.kelompok(id) on delete cascade,
  tim_id       uuid references public.tim(id) on delete cascade,
  akun_id      uuid references public.akun(id) on delete cascade,
  dibuat_pada  timestamptz not null default now(),
  dipakai_pada timestamptz
);
comment on table internal.izin_buat_akun is 'Izin sekali pakai untuk membuat akun dengan tujuannya (keputusan 42).';
revoke all on internal.izin_buat_akun from public, anon, authenticated;


-- Bolehkah saya membuat akun dengan tujuan ini?
create function bantu.boleh_buat_akun(p_tujuan text, p_kelompok uuid, p_tim uuid)
returns boolean
language sql stable security definer set search_path = ''
as $$
  select case p_tujuan
    when 'anggota' then bantu.boleh_masukkan_ke_kelompok(p_kelompok)
    when 'pemimpin' then p_kelompok is not null and (
         bantu.saya_admin()
      or exists (select 1 from public.kelompok k
                 where k.id = p_kelompok and k.tim_id in (select bantu.tim_diketuai())))
    when 'wakil' then p_kelompok is not null and (
         bantu.saya_admin()
      or exists (select 1 from public.kelompok k
                 where k.id = p_kelompok and k.tim_id in (select bantu.tim_diketuai())))
    when 'ketua_tim' then p_tim is not null and bantu.saya_admin()
    when 'admin' then bantu.saya_admin()
    when 'tanpa' then bantu.saya_admin()
    else false
  end;
$$;
revoke all on function bantu.boleh_buat_akun(text, uuid, uuid) from public, anon;
grant execute on function bantu.boleh_buat_akun(text, uuid, uuid) to authenticated;


-- A1. Meminta izin membuat akun.
create function public.izin_buat_akun(p_tujuan text, p_kelompok uuid default null, p_tim uuid default null)
returns uuid
language plpgsql security definer set search_path = ''
as $$
declare
  v_tujuan   text := coalesce(nullif(trim(p_tujuan), ''), 'tanpa');
  v_kelompok uuid := case when v_tujuan in ('anggota', 'pemimpin', 'wakil') then p_kelompok end;
  v_tim      uuid := case when v_tujuan = 'ketua_tim' then p_tim end;
  v_izin     uuid;
begin
  if auth.uid() is null then
    raise exception 'Silakan masuk terlebih dahulu.' using errcode = '42501';
  end if;
  if v_tujuan not in ('anggota', 'pemimpin', 'wakil', 'ketua_tim', 'admin', 'tanpa') then
    raise exception 'Tujuan akun tidak dikenal.' using errcode = '22023';
  end if;
  if v_tujuan in ('anggota', 'pemimpin', 'wakil') and v_kelompok is null then
    raise exception 'Pilih kelompoknya.' using errcode = '22023';
  end if;
  if v_tujuan = 'ketua_tim' and v_tim is null then
    raise exception 'Pilih timnya.' using errcode = '22023';
  end if;
  if not bantu.boleh_buat_akun(v_tujuan, v_kelompok, v_tim) then
    raise exception 'Anda tidak berhak membuat akun dengan tujuan ini.' using errcode = '42501';
  end if;

  -- Bersihkan izin lama milik saya yang tidak terpakai.
  delete from internal.izin_buat_akun
   where pembuat = auth.uid() and dipakai_pada is null and dibuat_pada < now() - interval '15 minutes';

  insert into internal.izin_buat_akun (pembuat, tujuan, kelompok_id, tim_id)
  values (auth.uid(), v_tujuan, v_kelompok, v_tim)
  returning id into v_izin;
  return v_izin;
end;
$$;


-- A3. Memasang tujuan pada akun yang baru dibuat dengan izin itu.
--     Mengembalikan id profil anggota bila tujuannya anggota.
create function public.pasang_akun_baru(p_izin uuid, p_akun uuid)
returns uuid
language plpgsql security definer set search_path = ''
as $$
declare
  v_izin    internal.izin_buat_akun;
  v_akun    public.akun;
  v_anggota uuid;
begin
  if auth.uid() is null then
    raise exception 'Silakan masuk terlebih dahulu.' using errcode = '42501';
  end if;

  select * into v_izin from internal.izin_buat_akun where id = p_izin for update;
  if v_izin.id is null or v_izin.pembuat <> auth.uid() then
    raise exception 'Izin membuat akun tidak ditemukan.' using errcode = '42501';
  end if;
  if v_izin.dipakai_pada is not null or v_izin.dibuat_pada < now() - interval '15 minutes' then
    raise exception 'Izin membuat akun sudah dipakai atau kedaluwarsa. Ulangi dari awal.' using errcode = '22023';
  end if;
  -- Hak diperiksa lagi (mungkin peran saya baru saja dicabut).
  if not bantu.boleh_buat_akun(v_izin.tujuan, v_izin.kelompok_id, v_izin.tim_id) then
    raise exception 'Anda tidak berhak membuat akun dengan tujuan ini.' using errcode = '42501';
  end if;

  -- Akunnya harus benar-benar dibuat dengan izin ini (kode izin tersimpan
  -- di data akun login oleh server), masih baru, dan belum punya apa-apa.
  if not exists (select 1 from auth.users u
                 where u.id = p_akun and u.raw_user_meta_data ->> 'izin' = p_izin::text) then
    raise exception 'Akun ini tidak dibuat dengan izin tersebut.' using errcode = '42501';
  end if;
  select * into v_akun from public.akun where id = p_akun for update;
  if v_akun.id is null then
    raise exception 'Akun tidak ditemukan.' using errcode = '22023';
  end if;
  if v_akun.anggota_id is not null
     or exists (select 1 from public.penugasan_peran where akun_id = p_akun) then
    raise exception 'Akun ini sudah punya kelompok atau peran.' using errcode = '22023';
  end if;

  update internal.izin_buat_akun set dipakai_pada = now(), akun_id = p_akun where id = p_izin;

  if v_izin.tujuan = 'anggota' then
    insert into public.anggota (kelompok_id, nama_lengkap)
    values (v_izin.kelompok_id, v_akun.nama_tampilan)
    returning id into v_anggota;
    update public.akun set anggota_id = v_anggota where id = p_akun;
  elsif v_izin.tujuan in ('pemimpin', 'wakil') then
    insert into public.penugasan_peran (akun_id, peran, kelompok_id, jabatan)
    values (p_akun, 'pemimpin', v_izin.kelompok_id, v_izin.tujuan::public.jabatan_kelompok);
  elsif v_izin.tujuan = 'ketua_tim' then
    insert into public.penugasan_peran (akun_id, peran, tim_id)
    values (p_akun, 'ketua_tim', v_izin.tim_id);
  elsif v_izin.tujuan = 'admin' then
    insert into public.penugasan_peran (akun_id, peran) values (p_akun, 'admin');
  end if;

  perform internal.catat_log('buat_akun', jsonb_build_object(
    'akun_id', p_akun, 'tujuan', v_izin.tujuan, 'kelompok_id', v_izin.kelompok_id,
    'tim_id', v_izin.tim_id, 'anggota_id', v_anggota));
  return v_anggota;
end;
$$;


-- B0. Penjaga profil anggota: "siapa yang mencatat persetujuan" tetap tidak
--     bisa diubah, tetapi boleh kosong bila akun pencatatnya sudah dihapus.
--     (Sebelumnya penghapusan akun seperti itu ditolak database.)
create or replace function internal.jaga_anggota()
returns trigger language plpgsql security definer set search_path = ''
as $$
declare
  v_uid      uuid := auth.uid();
  v_diri     boolean := false;
  v_pemimpin boolean := false;
begin
  -- Perubahan oleh sistem (tugas otomatis, penjaga lain, SQL editor Supabase)
  -- tidak diperiksa haknya, hanya dirapikan.
  if v_uid is not null and pg_trigger_depth() = 1 then
    v_diri := new.id = bantu.anggota_saya();
    if tg_op = 'UPDATE' then
      v_pemimpin := old.kelompok_id in (select bantu.kelompok_dipimpin());
    else
      v_pemimpin := new.kelompok_id in (select bantu.kelompok_dipimpin());
    end if;

    if tg_op = 'UPDATE' and v_diri and not v_pemimpin then
      if new.kelompok_id        is distinct from old.kelompok_id
      or new.kode_qr            is distinct from old.kode_qr
      or new.aktif              is distinct from old.aktif
      or new.dinonaktifkan_pada is distinct from old.dinonaktifkan_pada
      or new.bergabung_pada     is distinct from old.bergabung_pada then
        raise exception 'Anda tidak boleh mengubah kelompok, kode QR, status aktif, atau tanggal bergabung.'
          using errcode = '42501';
      end if;
      if old.persetujuan_pada is not null
         and new.persetujuan_pada is distinct from old.persetujuan_pada then
        raise exception 'Persetujuan yang sudah tercatat hanya bisa diubah oleh pemimpin kelompok.'
          using errcode = '42501';
      end if;
    end if;
  end if;

  -- Rapikan data persetujuan.
  if new.persetujuan_pada is null then
    new.persetujuan_dicatat_oleh := null;
    new.persetujuan_dicatat_akun := null;
  elsif tg_op = 'INSERT' or old.persetujuan_pada is null
        or new.persetujuan_pada is distinct from old.persetujuan_pada then
    new.persetujuan_pada := now();
    if v_uid is not null then
      new.persetujuan_dicatat_akun := v_uid;
      new.persetujuan_dicatat_oleh := case when v_diri and not v_pemimpin
                                           then 'anggota_sendiri' else 'pemimpin' end;
    else
      new.persetujuan_dicatat_oleh := coalesce(new.persetujuan_dicatat_oleh, 'pemimpin');
    end if;
  else
    -- Siapa yang mencatat tidak boleh diubah-ubah.
    new.persetujuan_dicatat_oleh := old.persetujuan_dicatat_oleh;
    -- Kecuali akun pencatatnya dihapus (keputusan 41): kolomnya dikosongkan.
    new.persetujuan_dicatat_akun := case
      when new.persetujuan_dicatat_akun is null
       and not exists (select 1 from public.akun where id = old.persetujuan_dicatat_akun) then null
      else old.persetujuan_dicatat_akun end;
  end if;

  -- Tanggal persetujuan wali diisi otomatis saat nama wali pertama kali diisi.
  if new.wali_nama is null then
    new.wali_persetujuan_pada := null;
  elsif new.wali_persetujuan_pada is null then
    new.wali_persetujuan_pada := now();
  end if;

  -- Anggota di bawah 18 tahun wajib ada persetujuan wali.
  if v_uid is not null and pg_trigger_depth() = 1
     and new.tanggal_lahir is not null
     and age(bantu.hari_ini_wib(), new.tanggal_lahir) < interval '18 years'
     and new.wali_nama is null then
    raise exception 'Anggota di bawah 18 tahun memerlukan persetujuan orang tua/wali (isi nama wali).'
      using errcode = '23514';
  end if;

  -- Rapikan status aktif.
  if new.aktif then
    new.dinonaktifkan_pada := null;
  elsif new.dinonaktifkan_pada is null then
    new.dinonaktifkan_pada := now();
  end if;

  return new;
end;
$$;


-- B. Menghapus akun (khusus Admin).
create function public.hapus_akun(p_akun uuid, p_konfirmasi text, p_hapus_profil boolean default false)
returns void
language plpgsql security definer set search_path = ''
as $$
declare
  v_akun public.akun;
  v_profil_dihapus boolean := false;
begin
  if auth.uid() is null or not bantu.saya_admin() then
    raise exception 'Hanya Admin yang bisa menghapus akun.' using errcode = '42501';
  end if;
  if p_akun = auth.uid() then
    raise exception 'Anda tidak bisa menghapus akun Anda sendiri.' using errcode = '42501';
  end if;
  select * into v_akun from public.akun where id = p_akun for update;
  if v_akun.id is null then
    raise exception 'Akun tidak ditemukan.' using errcode = '22023';
  end if;
  if coalesce(trim(p_konfirmasi), '') <> trim(v_akun.nama_tampilan) then
    raise exception 'Nama akun yang diketik tidak sama. Akun tidak dihapus.' using errcode = '22023';
  end if;

  if coalesce(p_hapus_profil, false) and v_akun.anggota_id is not null then
    delete from public.anggota where id = v_akun.anggota_id;
    v_profil_dihapus := true;
  end if;

  perform internal.catat_log('hapus_akun', jsonb_build_object(
    'akun_id', p_akun, 'anggota_id', v_akun.anggota_id, 'profil_dihapus', v_profil_dihapus));

  -- Menghapus akun login; baris akun, peran, profil staf, dan tautan atur
  -- ulangnya ikut terhapus. Profil anggota yang tidak dihapus tetap ada
  -- sebagai anggota tanpa akun.
  delete from auth.users where id = p_akun;
end;
$$;

revoke all on function public.izin_buat_akun(text, uuid, uuid)        from public, anon;
revoke all on function public.pasang_akun_baru(uuid, uuid)             from public, anon;
revoke all on function public.hapus_akun(uuid, text, boolean)          from public, anon;
grant execute on function public.izin_buat_akun(text, uuid, uuid)     to authenticated;
grant execute on function public.pasang_akun_baru(uuid, uuid)          to authenticated;
grant execute on function public.hapus_akun(uuid, text, boolean)       to authenticated;

revoke all on all functions in schema internal from public, anon, authenticated;

$mig2600$;
    v_dijalankan := v_dijalankan || '20261119002600_buat_hapus_akun.sql'::text;
  end if;

  if cardinality(v_dijalankan) = 0 then
    raise notice 'Semua migrasi sudah dijalankan sebelumnya. Tidak ada yang diubah.';
  else
    raise notice 'Berhasil dijalankan: %', array_to_string(v_dijalankan, ', ');
  end if;
end
$susulan$;

-- Hasil pemeriksaan: semua baris harus "sudah".
select m.file,
       case when exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace
                         where n.nspname = m.skema and p.proname = m.fungsi)
                 or to_regclass(m.skema || '.' || m.fungsi) is not null
            then 'sudah' else 'BELUM' end as status
from (values
  ('20261112000600_login_undangan.sql', 'internal', 'akun_baru'),
  ('20261117000700_mode_pertemuan.sql', 'internal', 'jaga_tanggal_pertemuan'),
  ('20261117000800_admin_kelola_semua.sql', 'bantu', 'kelompok_dipimpin_langsung'),
  ('20261117000900_koreksi_data.sql', 'public', 'hapus_kelompok_total'),
  ('20261117001000_bukti_persembahan.sql', 'public', 'bukti_persembahan'),
  ('20261117001100_tindak_lanjut.sql', 'public', 'tindak_lanjut'),
  ('20261117001300_ringkasan_tim.sql', 'public', 'ringkasan_tim'),
  ('20261117001400_kartu_qr.sql', 'public', 'buat_ulang_kode_kartu'),
  ('20261118001500_login_fleksibel.sql', 'internal', 'normal_hp'),
  ('20261118001600_atur_profil.sql', 'public', 'selesai_atur_profil'),
  ('20261118001700_masukan.sql', 'public', 'kirim_masukan'),
  ('20261118001800_baptis_status_jemaat.sql', 'public', 'ubah_data_jemaat'),
  ('20261118001900_laporan_generasi.sql', 'internal', 'generasi'),
  ('20261118002000_reset_ketua_tim.sql', 'public', 'akun_bisa_atur_ulang'),
  ('20261118002100_masukkan_akun.sql', 'bantu', 'boleh_masukkan_ke_kelompok'),
  ('20261118002200_laporan_proyek.sql', 'public', 'lapor_proyek_saya'),
  ('20261118002300_laporan_proyek_admin.sql', 'public', 'laporan_proyek'),
  ('20261118002400_bahan_diskusi.sql', 'bantu', 'boleh_baca_bahan'),
  ('20261118002500_penghapus_berkas.sql', 'public', 'layanan_ambil_antrean_berkas'),
  ('20261119002600_buat_hapus_akun.sql', 'public', 'hapus_akun')
) as m(file, skema, fungsi);
