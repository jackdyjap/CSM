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
