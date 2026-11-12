-- =====================================================================
-- FASE 1 · SEMUA FILE DATABASE DALAM SATU FILE
-- Gabungan otomatis dari kelima file di folder migrations/ (urutan 01-05).
-- Cukup salin SELURUH isi file ini ke SQL Editor Supabase, lalu klik Run.
-- Hanya dijalankan SEKALI pada proyek Supabase yang masih kosong.
-- =====================================================================


-- >>>>>>>>>> 20261112000100_tabel.sql <<<<<<<<<<
-- =====================================================================
-- 01 · TABEL
-- Membuat "map-map" (tabel) di lemari arsip beserta daftar pilihannya.
-- File ini BELUM memasang satpam (aturan akses). Satpam dipasang di file 03.
-- =====================================================================

-- Alat enkripsi bawaan Supabase (dipakai untuk QR pertemuan).
create extension if not exists pgcrypto with schema extensions;

-- Dua "ruang" tambahan di luar ruang utama (public):
--   bantu    : fungsi-fungsi kecil yang dipakai satpam untuk memeriksa peran.
--   internal : barang yang sama sekali tidak boleh disentuh pengguna
--              (kunci rahasia QR, antrean hapus foto, tugas otomatis, log).
create schema if not exists bantu;
create schema if not exists internal;
revoke all on schema internal from public;

-- Tanggal hari ini menurut WIB (Asia/Jakarta). Dipakai di banyak tempat.
create function bantu.hari_ini_wib()
returns date
language sql stable
set search_path = ''
as $$ select (now() at time zone 'Asia/Jakarta')::date $$;


-- ---------------------------------------------------------------------
-- DAFTAR PILIHAN (enum). Database menolak isian di luar daftar ini.
-- ---------------------------------------------------------------------
create type public.peran_staf       as enum ('admin', 'ketua_tim', 'pemimpin');
create type public.jabatan_kelompok as enum ('pemimpin', 'wakil');
create type public.gender           as enum ('laki_laki', 'perempuan');
create type public.status_nikah     as enum ('single', 'menikah', 'duda', 'janda');
create type public.pendidikan       as enum ('tidak_sekolah', 'sd', 'smp', 'sma_smk', 'd3', 's1', 's2_ke_atas');
create type public.pekerjaan        as enum ('tidak_bekerja', 'irt', 'karyawan', 'wiraswasta', 'pensiunan', 'freelancer', 'profesional');
create type public.pencatat_persetujuan as enum ('anggota_sendiri', 'pemimpin');
create type public.cara_absen       as enum ('scan_sendiri', 'scan_pemimpin', 'manual');
create type public.alasan_absen     as enum ('sakit', 'bekerja', 'keluarga', 'bepergian', 'tanpa_kabar', 'lainnya');
create type public.jenis_catatan    as enum ('alasan_absen', 'proyek', 'umum');
create type public.status_pengerjaan as enum ('belum', 'sedang', 'selesai', 'tidak_dikerjakan');
create type public.tingkat_wilayah  as enum ('provinsi', 'kota', 'kecamatan', 'kelurahan');


-- ---------------------------------------------------------------------
-- STRUKTUR ORGANISASI
-- ---------------------------------------------------------------------
create table public.tim (
  id          uuid primary key default gen_random_uuid(),
  nama        text not null check (length(trim(nama)) > 0),
  dibuat_pada timestamptz not null default now()
);
comment on table public.tim is 'Tim yang membawahi beberapa kelompok kecil.';

create table public.kelompok (
  id          uuid primary key default gen_random_uuid(),
  tim_id      uuid not null references public.tim(id) on delete restrict,
  nama        text not null check (length(trim(nama)) > 0),
  dibuat_pada timestamptz not null default now()
);
create index on public.kelompok (tim_id);
comment on table public.kelompok is 'Kelompok kecil. Tim tidak bisa dihapus selama masih punya kelompok.';

-- Akun = orang yang bisa login. Email/HP dan kata sandi disimpan oleh
-- Supabase Auth (auth.users), bukan di sini.
create table public.akun (
  id            uuid primary key references auth.users(id) on delete cascade,
  nama_tampilan text not null,
  anggota_id    uuid unique,          -- diisi bila akun ini milik seorang anggota
  dibuat_pada   timestamptz not null default now()
);
comment on table public.akun is 'Akun login. anggota_id terisi = orang ini berperan sebagai Anggota.';

-- Tugas staf. Satu akun boleh punya beberapa baris (peran ganda).
create table public.penugasan_peran (
  id          uuid primary key default gen_random_uuid(),
  akun_id     uuid not null references public.akun(id) on delete cascade,
  peran       public.peran_staf not null,
  tim_id      uuid references public.tim(id) on delete cascade,
  kelompok_id uuid references public.kelompok(id) on delete cascade,
  jabatan     public.jabatan_kelompok,  -- hanya untuk peran 'pemimpin' (label tampilan)
  dibuat_pada timestamptz not null default now(),
  -- Pastikan isian cocok dengan perannya:
  constraint penugasan_sesuai_peran check (
       (peran = 'admin'     and tim_id is null     and kelompok_id is null     and jabatan is null)
    or (peran = 'ketua_tim' and tim_id is not null and kelompok_id is null     and jabatan is null)
    or (peran = 'pemimpin'  and tim_id is null     and kelompok_id is not null and jabatan is not null)
  )
);
-- Tidak boleh ada tugas yang sama dua kali.
create unique index penugasan_unik on public.penugasan_peran
  (akun_id, peran, coalesce(tim_id, kelompok_id, '00000000-0000-0000-0000-000000000000'::uuid));
create index on public.penugasan_peran (kelompok_id);
create index on public.penugasan_peran (tim_id);


-- ---------------------------------------------------------------------
-- WILAYAH (rujukan Kemendagri). Contoh kode: 31 / 31.71 / 31.71.01 / 31.71.01.1001
-- ---------------------------------------------------------------------
create table public.wilayah (
  kode       text primary key,
  nama       text not null,
  tingkat    public.tingkat_wilayah not null,
  induk_kode text references public.wilayah(kode)
);
create index on public.wilayah (induk_kode);


-- ---------------------------------------------------------------------
-- ANGGOTA (profil)
-- ---------------------------------------------------------------------
create table public.anggota (
  id              uuid primary key default gen_random_uuid(),
  kelompok_id     uuid not null references public.kelompok(id) on delete restrict,
  nama_lengkap    text not null check (length(trim(nama_lengkap)) > 0),

  gender          public.gender,
  foto_path       text,             -- lokasi file di penyimpanan privat, bukan tautan publik
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
  no_hp           text,

  -- Kode acak untuk kartu QR. Tidak berisi data pribadi.
  kode_qr         text not null unique default replace(gen_random_uuid()::text, '-', ''),

  -- Persetujuan pencatatan data (UU PDP). Diisi otomatis oleh penjaga (file 04).
  persetujuan_pada         timestamptz,
  persetujuan_dicatat_oleh public.pencatat_persetujuan,
  persetujuan_dicatat_akun uuid references public.akun(id) on delete set null,
  -- Untuk anggota di bawah 18 tahun:
  wali_nama                text,
  wali_hubungan            text,
  wali_persetujuan_pada    timestamptz,

  aktif             boolean not null default true,
  dinonaktifkan_pada timestamptz,
  bergabung_pada    date not null default bantu.hari_ini_wib(),
  dibuat_pada       timestamptz not null default now(),
  diubah_pada       timestamptz not null default now(),

  -- Aktif/tidak aktif harus konsisten dengan tanggal dinonaktifkan.
  constraint anggota_status_aktif check (
    (aktif and dinonaktifkan_pada is null) or (not aktif and dinonaktifkan_pada is not null)
  ),
  -- Data pribadi hanya boleh diisi setelah ada persetujuan.
  constraint anggota_perlu_persetujuan check (
    persetujuan_pada is not null or (
      gender is null and foto_path is null and tempat_lahir is null and tanggal_lahir is null
      and alamat is null and provinsi_kode is null and kota_kode is null
      and kecamatan_kode is null and kelurahan_kode is null and status_nikah is null
      and pendidikan is null and pekerjaan is null and no_hp is null
    )
  ),
  -- Pilihan wilayah harus nyambung: kota di dalam provinsi yang dipilih,
  -- kecamatan di dalam kota, kelurahan di dalam kecamatan.
  constraint anggota_wilayah_bertingkat check (
        (provinsi_kode  is null or provinsi_kode ~ '^[0-9]{2}$')
    and (kota_kode      is null or (provinsi_kode  is not null and kota_kode      like provinsi_kode  || '.__'))
    and (kecamatan_kode is null or (kota_kode      is not null and kecamatan_kode like kota_kode      || '.__'))
    and (kelurahan_kode is null or (kecamatan_kode is not null and kelurahan_kode like kecamatan_kode || '.____'))
  ),
  -- Foto harus berada di folder milik anggota ini sendiri.
  constraint anggota_foto_milik_sendiri check (
    foto_path is null or foto_path like id::text || '/%'
  )
);
create index on public.anggota (kelompok_id);
comment on table public.anggota is 'Profil anggota. Usia tidak disimpan; dihitung dari tanggal_lahir.';

-- Sambungan akun -> anggota (dibuat setelah tabel anggota ada).
alter table public.akun
  add constraint akun_anggota_fk foreign key (anggota_id)
  references public.anggota(id) on delete set null;


-- ---------------------------------------------------------------------
-- UNDANGAN (tautan undangan dari pemimpin)
-- ---------------------------------------------------------------------
create table public.undangan (
  id               uuid primary key default gen_random_uuid(),
  kelompok_id      uuid not null references public.kelompok(id) on delete cascade,
  anggota_id       uuid references public.anggota(id) on delete cascade, -- bila profil sudah dibuat pemimpin
  token            text not null unique default replace(gen_random_uuid()::text, '-', ''),
  dibuat_oleh      uuid references public.akun(id) on delete set null default auth.uid(),
  kedaluwarsa_pada timestamptz not null default now() + interval '7 days',
  dipakai_pada     timestamptz,
  dipakai_oleh     uuid references public.akun(id) on delete set null,
  dibuat_pada      timestamptz not null default now()
);
create index on public.undangan (kelompok_id);


-- ---------------------------------------------------------------------
-- PERTEMUAN DAN KEHADIRAN
-- ---------------------------------------------------------------------
create table public.pertemuan (
  id           uuid primary key default gen_random_uuid(),
  kelompok_id  uuid not null references public.kelompok(id) on delete restrict,
  tanggal      date not null default bantu.hari_ini_wib(),
  persembahan  numeric(14,2) check (persembahan >= 0),
  catatan      text,
  dibuka_pada  timestamptz,
  ditutup_pada timestamptz,
  dibuat_oleh  uuid references public.akun(id) on delete set null default auth.uid(),
  dibuat_pada  timestamptz not null default now(),
  diubah_pada  timestamptz not null default now(),
  constraint pertemuan_satu_per_hari unique (kelompok_id, tanggal),
  constraint pertemuan_urutan_jam check (
    ditutup_pada is null or (dibuka_pada is not null and ditutup_pada >= dibuka_pada)
  )
);

-- Kunci rahasia QR pertemuan disimpan terpisah di ruang internal,
-- sehingga tidak pernah terkirim ke aplikasi.
create table internal.pertemuan_rahasia (
  pertemuan_id uuid primary key references public.pertemuan(id) on delete cascade,
  rahasia      text not null
);

create table public.kehadiran (
  id             uuid primary key default gen_random_uuid(),
  pertemuan_id   uuid not null references public.pertemuan(id) on delete cascade,
  anggota_id     uuid not null references public.anggota(id) on delete cascade,
  kelompok_id    uuid not null references public.kelompok(id),  -- diisi otomatis dari pertemuan
  hadir          boolean not null,
  waktu          timestamptz not null default now(),
  cara           public.cara_absen,     -- hanya bila hadir
  alasan         public.alasan_absen,   -- hanya bila tidak hadir
  alasan_catatan text,
  dicatat_oleh   uuid references public.akun(id) on delete set null,
  constraint kehadiran_unik unique (pertemuan_id, anggota_id),  -- satu anggota, satu kali per pertemuan
  constraint kehadiran_isian_sesuai check (
    (hadir and cara is not null and alasan is null) or (not hadir and cara is null)
  )
);
create index on public.kehadiran (anggota_id);
create index on public.kehadiran (kelompok_id);


-- ---------------------------------------------------------------------
-- CATATAN KHUSUS DAN PROYEK KETAATAN
-- ---------------------------------------------------------------------
create table public.catatan_khusus (
  id          uuid primary key default gen_random_uuid(),
  anggota_id  uuid not null references public.anggota(id) on delete cascade,
  penulis_id  uuid references public.akun(id) on delete set null,
  tanggal     date not null default bantu.hari_ini_wib(),
  jenis       public.jenis_catatan not null,
  isi         text not null check (length(trim(isi)) > 0),
  dibuat_pada timestamptz not null default now(),
  diubah_pada timestamptz not null default now()
);
create index on public.catatan_khusus (anggota_id);

create table public.proyek_ketaatan (
  id             uuid primary key default gen_random_uuid(),
  kelompok_id    uuid not null references public.kelompok(id) on delete restrict,
  judul          text not null check (length(trim(judul)) > 0),
  keterangan     text,
  diberikan_pada date not null default bantu.hari_ini_wib(),
  tenggat        date,
  dibuat_oleh    uuid references public.akun(id) on delete set null default auth.uid(),
  dibuat_pada    timestamptz not null default now(),
  constraint proyek_tenggat_masuk_akal check (tenggat is null or tenggat >= diberikan_pada)
);
create index on public.proyek_ketaatan (kelompok_id);

create table public.status_proyek (
  proyek_id   uuid not null references public.proyek_ketaatan(id) on delete cascade,
  anggota_id  uuid not null references public.anggota(id) on delete cascade,
  kelompok_id uuid not null references public.kelompok(id),  -- diisi otomatis dari proyek
  status      public.status_pengerjaan not null default 'belum',
  keterangan  text,
  diubah_pada timestamptz not null default now(),
  primary key (proyek_id, anggota_id)
);
create index on public.status_proyek (anggota_id);
create index on public.status_proyek (kelompok_id);


-- ---------------------------------------------------------------------
-- LOG AKTIVITAS (hanya bisa ditambah lewat fungsi sistem)
-- ---------------------------------------------------------------------
create table public.log_aktivitas (
  id       bigint generated always as identity primary key,
  akun_id  uuid,   -- sengaja tanpa sambungan ke tabel akun: log tetap utuh walau akun dihapus
  waktu    timestamptz not null default now(),
  tindakan text not null,
  detail   jsonb not null default '{}'::jsonb
);
create index on public.log_aktivitas (waktu desc);


-- ---------------------------------------------------------------------
-- ANTREAN HAPUS FOTO
-- File foto tidak boleh dihapus langsung lewat SQL di Supabase, jadi
-- lokasi foto yang harus dihapus dicatat di sini, lalu dihapus oleh
-- tugas terjadwal (Edge Function) yang dibuat di fase berikutnya.
-- ---------------------------------------------------------------------
create table internal.antrean_hapus_foto (
  id          bigint generated always as identity primary key,
  foto_path   text not null,
  dibuat_pada timestamptz not null default now()
);


-- >>>>>>>>>> 20261112000200_fungsi_pembantu.sql <<<<<<<<<<
-- =====================================================================
-- 02 · FUNGSI PEMBANTU ("buku panduan satpam")
-- Fungsi-fungsi kecil yang menjawab pertanyaan seperti "apakah saya admin?"
-- atau "kelompok mana yang boleh saya baca?". Semua aturan akses di file 03
-- memakai fungsi ini, jadi logikanya ditulis sekali dan konsisten.
--
-- Catatan teknis:
--   security definer  = fungsi berjalan dengan hak pemilik database, supaya
--                       pengecekan peran tidak terhalang aturan aksesnya sendiri.
--   search_path = ''  = semua nama ditulis lengkap (public.xxx) supaya tidak
--                       bisa dikelabui objek palsu dengan nama yang sama.
--   auth.uid()        = id akun yang sedang login (disediakan Supabase).
-- =====================================================================

-- Apakah saya Admin?
create function bantu.saya_admin()
returns boolean
language sql stable security definer
set search_path = ''
as $$
  select exists (
    select 1 from public.penugasan_peran
    where akun_id = auth.uid() and peran = 'admin'
  );
$$;

-- Kelompok yang saya pimpin (sebagai pemimpin ATAU wakil; haknya sama).
create function bantu.kelompok_dipimpin()
returns setof uuid
language sql stable security definer
set search_path = ''
as $$
  select kelompok_id from public.penugasan_peran
  where akun_id = auth.uid() and peran = 'pemimpin';
$$;

-- Tim yang saya ketuai.
create function bantu.tim_diketuai()
returns setof uuid
language sql stable security definer
set search_path = ''
as $$
  select tim_id from public.penugasan_peran
  where akun_id = auth.uid() and peran = 'ketua_tim';
$$;

-- Profil anggota milik saya (null bila akun saya bukan anggota).
create function bantu.anggota_saya()
returns uuid
language sql stable security definer
set search_path = ''
as $$
  select anggota_id from public.akun where id = auth.uid();
$$;

-- Kelompok tempat saya terdaftar sebagai anggota.
create function bantu.kelompok_saya_sebagai_anggota()
returns uuid
language sql stable security definer
set search_path = ''
as $$
  select a.kelompok_id
  from public.akun ak
  join public.anggota a on a.id = ak.anggota_id
  where ak.id = auth.uid();
$$;

-- Semua kelompok yang datanya boleh saya BACA sebagai staf:
--   Admin: semua kelompok · Ketua Tim: kelompok di timnya · Pemimpin/Wakil: kelompoknya.
-- (Peran ganda otomatis tergabung.)
create function bantu.kelompok_terbaca()
returns setof uuid
language sql stable security definer
set search_path = ''
as $$
  select k.id from public.kelompok k
  where bantu.saya_admin()
     or k.id     in (select bantu.kelompok_dipimpin())
     or k.tim_id in (select bantu.tim_diketuai());
$$;

-- Semua tim yang namanya boleh saya lihat.
create function bantu.tim_terbaca()
returns setof uuid
language sql stable security definer
set search_path = ''
as $$
  select t.id from public.tim t
  where bantu.saya_admin()
     or t.id in (select bantu.tim_diketuai())
     or t.id in (select k.tim_id from public.kelompok k
                 where k.id in (select bantu.kelompok_dipimpin())
                    or k.id = bantu.kelompok_saya_sebagai_anggota());
$$;

-- Bolehkah saya MELIHAT data (dan foto) anggota ini?
create function bantu.boleh_baca_anggota(p_anggota uuid)
returns boolean
language sql stable security definer
set search_path = ''
as $$
  select exists (
    select 1 from public.anggota a
    where a.id = p_anggota
      and (a.kelompok_id in (select bantu.kelompok_terbaca())
           or a.id = bantu.anggota_saya())
  );
$$;

-- Bolehkah saya MENGUBAH data anggota ini sebagai pemimpin/wakil kelompoknya?
create function bantu.boleh_kelola_anggota(p_anggota uuid)
returns boolean
language sql stable security definer
set search_path = ''
as $$
  select exists (
    select 1 from public.anggota a
    where a.id = p_anggota
      and a.kelompok_id in (select bantu.kelompok_dipimpin())
  );
$$;

-- Mengubah teks menjadi uuid dengan aman (null bila bukan uuid yang sah).
-- Dipakai untuk membaca nama folder foto.
create function bantu.teks_ke_uuid(p_teks text)
returns uuid
language plpgsql immutable
set search_path = ''
as $$
begin
  return p_teks::uuid;
exception when others then
  return null;
end;
$$;

-- Hanya pengguna yang sudah login yang boleh memakai fungsi-fungsi ini.
revoke all on all functions in schema bantu from public;
grant usage on schema bantu to authenticated;
grant execute on all functions in schema bantu to authenticated;


-- ---------------------------------------------------------------------
-- Pencatat log (ruang internal: pengguna tidak bisa memanggilnya langsung,
-- sehingga log tidak bisa dipalsukan).
-- ---------------------------------------------------------------------
create function internal.catat_log(p_tindakan text, p_detail jsonb default '{}'::jsonb)
returns void
language sql security definer
set search_path = ''
as $$
  insert into public.log_aktivitas (akun_id, tindakan, detail)
  values (auth.uid(), p_tindakan, coalesce(p_detail, '{}'::jsonb));
$$;
revoke all on function internal.catat_log(text, jsonb) from public;


-- >>>>>>>>>> 20261112000300_aturan_akses.sql <<<<<<<<<<
-- =====================================================================
-- 03 · ATURAN AKSES (Row Level Security / "satpam di setiap map")
--
-- Cara membaca aturan:
--   for select  = boleh MEMBACA baris yang memenuhi syarat "using"
--   for insert  = boleh MENAMBAH baris yang memenuhi syarat "with check"
--   for update  = boleh MENGUBAH baris (syarat lama "using", hasil "with check")
--   for delete  = boleh MENGHAPUS baris
--   to authenticated = hanya untuk pengguna yang sudah login
-- Bila tidak ada aturan yang cocok, database menolak / menyembunyikan data.
-- =====================================================================

-- 1. Nyalakan satpam di SEMUA tabel.
alter table public.tim             enable row level security;
alter table public.kelompok        enable row level security;
alter table public.akun            enable row level security;
alter table public.penugasan_peran enable row level security;
alter table public.wilayah         enable row level security;
alter table public.anggota         enable row level security;
alter table public.undangan        enable row level security;
alter table public.pertemuan       enable row level security;
alter table public.kehadiran       enable row level security;
alter table public.catatan_khusus  enable row level security;
alter table public.proyek_ketaatan enable row level security;
alter table public.status_proyek   enable row level security;
alter table public.log_aktivitas   enable row level security;
alter table internal.pertemuan_rahasia  enable row level security;
alter table internal.antrean_hapus_foto enable row level security;

-- 2. Tamu yang belum login (anon) tidak boleh menyentuh apa pun.
revoke all on all tables    in schema public from anon;
revoke all on all sequences in schema public from anon;

-- 3. Map yang HANYA boleh dibuka lewat loket (fungsi di file 04):
--    catatan khusus (setiap pembacaan wajib tercatat di log) dan log itu sendiri.
revoke all on public.catatan_khusus from authenticated;
revoke all on public.log_aktivitas  from authenticated;
grant select on public.log_aktivitas to authenticated;   -- dibatasi untuk Admin di bawah

-- 4. Pada tabel akun, pengguna hanya boleh mengubah nama tampilannya.
revoke insert, update, delete on public.akun from authenticated;
grant update (nama_tampilan) on public.akun to authenticated;

-- 5. Data wilayah hanya untuk dibaca.
revoke insert, update, delete on public.wilayah from authenticated;

-- 6. Pengaman masa depan: tabel/fungsi yang dibuat nanti juga otomatis
--    tertutup untuk tamu (anon). Aturan RLS tetap wajib dipasang per tabel.
alter default privileges in schema public revoke all on tables    from anon;
alter default privileges in schema public revoke all on sequences from anon;
alter default privileges in schema public revoke all on functions from anon;


-- ---------------------------------------------------------------------
-- TIM
-- ---------------------------------------------------------------------
create policy "tim: baca sesuai peran" on public.tim
  for select to authenticated
  using (id in (select bantu.tim_terbaca()));

create policy "tim: admin menambah" on public.tim
  for insert to authenticated with check ((select bantu.saya_admin()));
create policy "tim: admin mengubah" on public.tim
  for update to authenticated using ((select bantu.saya_admin())) with check ((select bantu.saya_admin()));
create policy "tim: admin menghapus" on public.tim
  for delete to authenticated using ((select bantu.saya_admin()));

-- ---------------------------------------------------------------------
-- KELOMPOK
-- ---------------------------------------------------------------------
create policy "kelompok: baca sesuai peran" on public.kelompok
  for select to authenticated
  using (id in (select bantu.kelompok_terbaca())
         or id = (select bantu.kelompok_saya_sebagai_anggota()));

create policy "kelompok: admin menambah" on public.kelompok
  for insert to authenticated with check ((select bantu.saya_admin()));
create policy "kelompok: admin mengubah" on public.kelompok
  for update to authenticated using ((select bantu.saya_admin())) with check ((select bantu.saya_admin()));
create policy "kelompok: admin menghapus" on public.kelompok
  for delete to authenticated using ((select bantu.saya_admin()));

-- ---------------------------------------------------------------------
-- AKUN dan PENUGASAN PERAN
-- (Pembuatan akun dilakukan sistem login di Fase 2.)
-- ---------------------------------------------------------------------
create policy "akun: baca milik sendiri, admin baca semua" on public.akun
  for select to authenticated
  using (id = (select auth.uid()) or (select bantu.saya_admin()));

create policy "akun: ubah nama sendiri" on public.akun
  for update to authenticated
  using (id = (select auth.uid())) with check (id = (select auth.uid()));

create policy "peran: baca milik sendiri, admin baca semua" on public.penugasan_peran
  for select to authenticated
  using (akun_id = (select auth.uid()) or (select bantu.saya_admin()));

create policy "peran: admin menambah" on public.penugasan_peran
  for insert to authenticated with check ((select bantu.saya_admin()));
create policy "peran: admin mengubah" on public.penugasan_peran
  for update to authenticated using ((select bantu.saya_admin())) with check ((select bantu.saya_admin()));
create policy "peran: admin menghapus" on public.penugasan_peran
  for delete to authenticated using ((select bantu.saya_admin()));

-- ---------------------------------------------------------------------
-- WILAYAH: semua pengguna yang login boleh membaca (untuk menu pilihan).
-- ---------------------------------------------------------------------
create policy "wilayah: baca" on public.wilayah
  for select to authenticated using (true);

-- ---------------------------------------------------------------------
-- ANGGOTA
--   Baca : staf sesuai cakupannya + anggota itu sendiri.
--   Tulis: pemimpin/wakil kelompoknya. Anggota boleh mengubah profilnya
--          sendiri; kolom yang dikunci untuk anggota dijaga di file 04.
--   Ketua Tim dan Admin: hanya membaca.
-- ---------------------------------------------------------------------
create policy "anggota: baca sesuai peran" on public.anggota
  for select to authenticated
  using (kelompok_id in (select bantu.kelompok_terbaca())
         or id = (select bantu.anggota_saya()));

create policy "anggota: pemimpin menambah" on public.anggota
  for insert to authenticated
  with check (kelompok_id in (select bantu.kelompok_dipimpin()));

create policy "anggota: pemimpin atau diri sendiri mengubah" on public.anggota
  for update to authenticated
  using      (kelompok_id in (select bantu.kelompok_dipimpin()) or id = (select bantu.anggota_saya()))
  with check (kelompok_id in (select bantu.kelompok_dipimpin()) or id = (select bantu.anggota_saya()));

create policy "anggota: pemimpin menghapus" on public.anggota
  for delete to authenticated
  using (kelompok_id in (select bantu.kelompok_dipimpin()));

-- ---------------------------------------------------------------------
-- UNDANGAN: hanya pemimpin/wakil kelompok terkait (dan Admin membaca).
-- ---------------------------------------------------------------------
create policy "undangan: baca" on public.undangan
  for select to authenticated
  using (kelompok_id in (select bantu.kelompok_dipimpin()) or (select bantu.saya_admin()));

create policy "undangan: pemimpin membuat" on public.undangan
  for insert to authenticated
  with check (
    kelompok_id in (select bantu.kelompok_dipimpin())
    and dibuat_oleh = (select auth.uid())
    and (anggota_id is null or exists (
          select 1 from public.anggota a
          where a.id = undangan.anggota_id and a.kelompok_id = undangan.kelompok_id))
  );

create policy "undangan: pemimpin menghapus" on public.undangan
  for delete to authenticated
  using (kelompok_id in (select bantu.kelompok_dipimpin()));

-- ---------------------------------------------------------------------
-- PERTEMUAN (termasuk persembahan)
-- Anggota tidak membaca tabel ini; check-in lewat loket check_in().
-- ---------------------------------------------------------------------
create policy "pertemuan: baca sesuai peran" on public.pertemuan
  for select to authenticated
  using (kelompok_id in (select bantu.kelompok_terbaca()));

create policy "pertemuan: pemimpin menambah" on public.pertemuan
  for insert to authenticated
  with check (kelompok_id in (select bantu.kelompok_dipimpin()));
create policy "pertemuan: pemimpin mengubah" on public.pertemuan
  for update to authenticated
  using      (kelompok_id in (select bantu.kelompok_dipimpin()))
  with check (kelompok_id in (select bantu.kelompok_dipimpin()));
create policy "pertemuan: pemimpin menghapus" on public.pertemuan
  for delete to authenticated
  using (kelompok_id in (select bantu.kelompok_dipimpin()));

-- ---------------------------------------------------------------------
-- KEHADIRAN
--   Anggota TIDAK membaca tabel ini langsung (karena berisi catatan alasan
--   absen dari pemimpin). Riwayatnya dilihat lewat loket
--   riwayat_kehadiran_saya() (file 04), dan check-in lewat check_in().
-- ---------------------------------------------------------------------
create policy "kehadiran: baca sesuai peran" on public.kehadiran
  for select to authenticated
  using (kelompok_id in (select bantu.kelompok_terbaca()));

create policy "kehadiran: pemimpin menambah" on public.kehadiran
  for insert to authenticated
  with check (kelompok_id in (select bantu.kelompok_dipimpin()));
create policy "kehadiran: pemimpin mengubah" on public.kehadiran
  for update to authenticated
  using      (kelompok_id in (select bantu.kelompok_dipimpin()))
  with check (kelompok_id in (select bantu.kelompok_dipimpin()));
create policy "kehadiran: pemimpin menghapus" on public.kehadiran
  for delete to authenticated
  using (kelompok_id in (select bantu.kelompok_dipimpin()));

-- ---------------------------------------------------------------------
-- CATATAN KHUSUS: TIDAK ADA aturan baca/tulis langsung sama sekali.
-- Semua akses lewat loket tulis_catatan / ubah_catatan / hapus_catatan /
-- baca_catatan (file 04), yang memeriksa hak dan mencatat ke log.
-- ---------------------------------------------------------------------

-- ---------------------------------------------------------------------
-- PROYEK KETAATAN dan STATUS PROYEK
-- ---------------------------------------------------------------------
create policy "proyek: baca sesuai peran" on public.proyek_ketaatan
  for select to authenticated
  using (kelompok_id in (select bantu.kelompok_terbaca()));
create policy "proyek: pemimpin menambah" on public.proyek_ketaatan
  for insert to authenticated
  with check (kelompok_id in (select bantu.kelompok_dipimpin()));
create policy "proyek: pemimpin mengubah" on public.proyek_ketaatan
  for update to authenticated
  using      (kelompok_id in (select bantu.kelompok_dipimpin()))
  with check (kelompok_id in (select bantu.kelompok_dipimpin()));
create policy "proyek: pemimpin menghapus" on public.proyek_ketaatan
  for delete to authenticated
  using (kelompok_id in (select bantu.kelompok_dipimpin()));

create policy "status proyek: baca sesuai peran" on public.status_proyek
  for select to authenticated
  using (kelompok_id in (select bantu.kelompok_terbaca()));
create policy "status proyek: pemimpin menambah" on public.status_proyek
  for insert to authenticated
  with check (kelompok_id in (select bantu.kelompok_dipimpin()));
create policy "status proyek: pemimpin mengubah" on public.status_proyek
  for update to authenticated
  using      (kelompok_id in (select bantu.kelompok_dipimpin()))
  with check (kelompok_id in (select bantu.kelompok_dipimpin()));
create policy "status proyek: pemimpin menghapus" on public.status_proyek
  for delete to authenticated
  using (kelompok_id in (select bantu.kelompok_dipimpin()));

-- ---------------------------------------------------------------------
-- LOG AKTIVITAS: hanya Admin yang membaca. Tidak ada yang bisa menulis,
-- mengubah, atau menghapus log secara langsung.
-- ---------------------------------------------------------------------
create policy "log: admin membaca" on public.log_aktivitas
  for select to authenticated
  using ((select bantu.saya_admin()));


-- ---------------------------------------------------------------------
-- FOTO ANGGOTA (penyimpanan privat Supabase Storage)
--   Lokasi file: foto-anggota/<id anggota>/<nama file>
--   Maksimal 2 MB, hanya gambar. Tidak ada tautan publik.
-- ---------------------------------------------------------------------
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('foto-anggota', 'foto-anggota', false, 2097152,
        array['image/jpeg', 'image/png', 'image/webp'])
on conflict (id) do update
  set public = false,
      file_size_limit = excluded.file_size_limit,
      allowed_mime_types = excluded.allowed_mime_types;

create policy "foto anggota: lihat" on storage.objects
  for select to authenticated
  using (bucket_id = 'foto-anggota'
         and bantu.boleh_baca_anggota(bantu.teks_ke_uuid((storage.foldername(name))[1])));

create policy "foto anggota: unggah" on storage.objects
  for insert to authenticated
  with check (bucket_id = 'foto-anggota'
              and (bantu.boleh_kelola_anggota(bantu.teks_ke_uuid((storage.foldername(name))[1]))
                   or bantu.teks_ke_uuid((storage.foldername(name))[1]) = bantu.anggota_saya()));

create policy "foto anggota: ganti" on storage.objects
  for update to authenticated
  using      (bucket_id = 'foto-anggota'
              and (bantu.boleh_kelola_anggota(bantu.teks_ke_uuid((storage.foldername(name))[1]))
                   or bantu.teks_ke_uuid((storage.foldername(name))[1]) = bantu.anggota_saya()))
  with check (bucket_id = 'foto-anggota'
              and (bantu.boleh_kelola_anggota(bantu.teks_ke_uuid((storage.foldername(name))[1]))
                   or bantu.teks_ke_uuid((storage.foldername(name))[1]) = bantu.anggota_saya()));

create policy "foto anggota: hapus" on storage.objects
  for delete to authenticated
  using (bucket_id = 'foto-anggota'
         and (bantu.boleh_kelola_anggota(bantu.teks_ke_uuid((storage.foldername(name))[1]))
              or bantu.teks_ke_uuid((storage.foldername(name))[1]) = bantu.anggota_saya()));


-- >>>>>>>>>> 20261112000400_fungsi_khusus.sql <<<<<<<<<<
-- =====================================================================
-- 04 · PENJAGA DAN LOKET KHUSUS
--
-- Bagian A: "penjaga" (trigger) yang otomatis memeriksa/merapikan data
--           setiap kali ada perubahan.
-- Bagian B: "loket" (fungsi) untuk tindakan yang harus diperiksa ketat
--           dan/atau dicatat: catatan khusus, check-in QR, laporan demografi.
-- =====================================================================


-- =====================================================================
-- BAGIAN A · PENJAGA
-- =====================================================================

-- A1. Isi kolom diubah_pada otomatis.
create function internal.isi_diubah_pada()
returns trigger language plpgsql set search_path = ''
as $$
begin
  new.diubah_pada := now();
  return new;
end;
$$;

create trigger isi_diubah_pada before update on public.anggota
  for each row execute function internal.isi_diubah_pada();
create trigger isi_diubah_pada before update on public.pertemuan
  for each row execute function internal.isi_diubah_pada();
create trigger isi_diubah_pada before update on public.catatan_khusus
  for each row execute function internal.isi_diubah_pada();
create trigger isi_diubah_pada before update on public.status_proyek
  for each row execute function internal.isi_diubah_pada();


-- A2. Penjaga profil anggota.
--   * Anggota yang mengubah profilnya sendiri TIDAK boleh mengubah:
--     kelompok, kode QR, status aktif, tanggal bergabung, atau persetujuan
--     yang sudah tercatat.
--   * Persetujuan: siapa dan kapan dicatat otomatis (tidak bisa dipalsukan).
--   * Anggota di bawah 18 tahun wajib ada persetujuan orang tua/wali.
--   * Status aktif dan tanggal dinonaktifkan selalu dirapikan.
create function internal.jaga_anggota()
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
    new.persetujuan_dicatat_akun := old.persetujuan_dicatat_akun;
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

create trigger jaga_anggota before insert or update on public.anggota
  for each row execute function internal.jaga_anggota();


-- A3. Saat anggota dihapus atau fotonya diganti: masukkan foto lama ke
--     antrean hapus, dan catat penghapusan anggota di log (tanpa nama).
create function internal.setelah_anggota_berubah()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  if tg_op = 'DELETE' then
    if old.foto_path is not null then
      insert into internal.antrean_hapus_foto (foto_path) values (old.foto_path);
    end if;
    perform internal.catat_log('hapus_anggota', jsonb_build_object('anggota_id', old.id));
    return old;
  end if;

  if old.foto_path is not null and new.foto_path is distinct from old.foto_path then
    insert into internal.antrean_hapus_foto (foto_path) values (old.foto_path);
  end if;
  return new;
end;
$$;

create trigger setelah_anggota_berubah after update or delete on public.anggota
  for each row execute function internal.setelah_anggota_berubah();


-- A4. Pertemuan baru otomatis mendapat kunci rahasia QR.
create function internal.buat_rahasia_pertemuan()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  insert into internal.pertemuan_rahasia (pertemuan_id, rahasia)
  values (new.id, encode(extensions.gen_random_bytes(32), 'hex'));
  return new;
end;
$$;

create trigger buat_rahasia_pertemuan after insert on public.pertemuan
  for each row execute function internal.buat_rahasia_pertemuan();


-- A5. Pertemuan dan proyek tidak boleh dipindah ke kelompok lain.
create function internal.cegah_pindah_kelompok()
returns trigger language plpgsql set search_path = ''
as $$
begin
  if new.kelompok_id is distinct from old.kelompok_id then
    raise exception 'Data ini tidak boleh dipindah ke kelompok lain.' using errcode = '42501';
  end if;
  return new;
end;
$$;

create trigger cegah_pindah_kelompok before update on public.pertemuan
  for each row execute function internal.cegah_pindah_kelompok();
create trigger cegah_pindah_kelompok before update on public.proyek_ketaatan
  for each row execute function internal.cegah_pindah_kelompok();


-- A6. Penjaga kehadiran:
--   * anggota harus berasal dari kelompok yang sama dengan pertemuannya;
--   * kelompok_id diisi otomatis dari pertemuan (tidak bisa dipalsukan);
--   * isian hadir/tidak hadir dirapikan.
create function internal.jaga_kehadiran()
returns trigger language plpgsql security definer set search_path = ''
as $$
declare
  v_kelompok_pertemuan uuid;
  v_kelompok_anggota   uuid;
begin
  select p.kelompok_id into v_kelompok_pertemuan
  from public.pertemuan p where p.id = new.pertemuan_id;

  if tg_op = 'INSERT'
     or new.pertemuan_id is distinct from old.pertemuan_id
     or new.anggota_id   is distinct from old.anggota_id then
    select a.kelompok_id into v_kelompok_anggota
    from public.anggota a where a.id = new.anggota_id;

    if v_kelompok_anggota is distinct from v_kelompok_pertemuan then
      raise exception 'Anggota ini bukan anggota kelompok pertemuan tersebut.' using errcode = '23514';
    end if;
  end if;

  new.kelompok_id := v_kelompok_pertemuan;

  if new.hadir then
    new.cara := coalesce(new.cara, 'manual');
    new.alasan := null;
    new.alasan_catatan := null;
  else
    new.cara := null;
  end if;

  if tg_op = 'INSERT' then
    new.dicatat_oleh := coalesce(new.dicatat_oleh, auth.uid());
  end if;
  return new;
end;
$$;

create trigger jaga_kehadiran before insert or update on public.kehadiran
  for each row execute function internal.jaga_kehadiran();


-- A7. Anggota tidak aktif yang hadir kembali otomatis menjadi aktif.
create function internal.aktifkan_kembali()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  if new.hadir then
    update public.anggota
       set aktif = true, dinonaktifkan_pada = null
     where id = new.anggota_id and not aktif;
  end if;
  return new;
end;
$$;

create trigger aktifkan_kembali after insert or update of hadir on public.kehadiran
  for each row execute function internal.aktifkan_kembali();


-- A8. Penjaga status proyek: anggota harus dari kelompok proyek tersebut.
create function internal.jaga_status_proyek()
returns trigger language plpgsql security definer set search_path = ''
as $$
declare
  v_kelompok_proyek  uuid;
  v_kelompok_anggota uuid;
begin
  select p.kelompok_id into v_kelompok_proyek
  from public.proyek_ketaatan p where p.id = new.proyek_id;

  if tg_op = 'INSERT'
     or new.proyek_id  is distinct from old.proyek_id
     or new.anggota_id is distinct from old.anggota_id then
    select a.kelompok_id into v_kelompok_anggota
    from public.anggota a where a.id = new.anggota_id;

    if v_kelompok_anggota is distinct from v_kelompok_proyek then
      raise exception 'Anggota ini bukan anggota kelompok proyek tersebut.' using errcode = '23514';
    end if;
  end if;

  new.kelompok_id := v_kelompok_proyek;
  return new;
end;
$$;

create trigger jaga_status_proyek before insert or update on public.status_proyek
  for each row execute function internal.jaga_status_proyek();


-- A9. Setiap perubahan peran dicatat di log.
create function internal.log_perubahan_peran()
returns trigger language plpgsql security definer set search_path = ''
as $$
declare
  v_baris public.penugasan_peran := case when tg_op = 'DELETE' then old else new end;
begin
  perform internal.catat_log('ubah_peran', jsonb_build_object(
    'aksi',        lower(tg_op),
    'akun_id',     v_baris.akun_id,
    'peran',       v_baris.peran,
    'jabatan',     v_baris.jabatan,
    'tim_id',      v_baris.tim_id,
    'kelompok_id', v_baris.kelompok_id
  ));
  return v_baris;
end;
$$;

create trigger log_perubahan_peran after insert or update or delete on public.penugasan_peran
  for each row execute function internal.log_perubahan_peran();


-- =====================================================================
-- BAGIAN B · LOKET KHUSUS (dipanggil dari aplikasi)
-- =====================================================================

-- ---------------------------------------------------------------------
-- B1. CATATAN KHUSUS
-- Aturan: pemimpin/wakil menulis untuk kelompoknya; pemimpin, ketua tim
-- terkait, dan Admin membaca. Tidak seorang pun bisa membaca atau menulis
-- catatan tentang dirinya sendiri. Setiap tindakan dicatat di log.
-- ---------------------------------------------------------------------
create function public.tulis_catatan(
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
  if not bantu.boleh_kelola_anggota(p_anggota) or p_anggota = bantu.anggota_saya() then
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

create function public.ubah_catatan(
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
  if v_anggota is null or not bantu.boleh_kelola_anggota(v_anggota)
     or v_anggota = bantu.anggota_saya() then
    raise exception 'Catatan tidak ditemukan atau Anda tidak berhak mengubahnya.' using errcode = '42501';
  end if;

  update public.catatan_khusus
     set isi = trim(p_isi), jenis = coalesce(p_jenis, jenis)
   where id = p_catatan;

  perform internal.catat_log('ubah_catatan',
    jsonb_build_object('catatan_id', p_catatan, 'anggota_id', v_anggota));
end;
$$;

create function public.hapus_catatan(p_catatan uuid)
returns void
language plpgsql security definer set search_path = ''
as $$
declare
  v_anggota uuid;
begin
  select c.anggota_id into v_anggota from public.catatan_khusus c where c.id = p_catatan;
  if v_anggota is null or not bantu.boleh_kelola_anggota(v_anggota)
     or v_anggota = bantu.anggota_saya() then
    raise exception 'Catatan tidak ditemukan atau Anda tidak berhak menghapusnya.' using errcode = '42501';
  end if;

  delete from public.catatan_khusus where id = p_catatan;

  perform internal.catat_log('hapus_catatan',
    jsonb_build_object('catatan_id', p_catatan, 'anggota_id', v_anggota));
end;
$$;

create function public.baca_catatan(p_anggota uuid)
returns table (
  id           uuid,
  tanggal      date,
  jenis        public.jenis_catatan,
  isi          text,
  penulis_nama text,
  dibuat_pada  timestamptz,
  diubah_pada  timestamptz
)
language plpgsql security definer set search_path = ''
as $$
#variable_conflict use_column
begin
  if p_anggota = bantu.anggota_saya() or not exists (
       select 1 from public.anggota a
       where a.id = p_anggota and a.kelompok_id in (select bantu.kelompok_terbaca())) then
    raise exception 'Anda tidak berhak membaca catatan anggota ini.' using errcode = '42501';
  end if;

  perform internal.catat_log('baca_catatan', jsonb_build_object('anggota_id', p_anggota));

  return query
    select c.id, c.tanggal, c.jenis, c.isi, ak.nama_tampilan, c.dibuat_pada, c.diubah_pada
    from public.catatan_khusus c
    left join public.akun ak on ak.id = c.penulis_id
    where c.anggota_id = p_anggota
    order by c.tanggal desc, c.dibuat_pada desc;
end;
$$;


-- ---------------------------------------------------------------------
-- B2. QR PERTEMUAN YANG BERGANTI OTOMATIS
-- Kode berganti setiap 45 detik. Kode dibuat dari kunci rahasia pertemuan
-- yang tidak pernah keluar dari database, sehingga tidak bisa ditebak.
-- Kode yang sedang tampil dan kode sebelumnya diterima (jeda untuk
-- koneksi lambat); kode yang lebih lama ditolak.
-- ---------------------------------------------------------------------
create function internal.jendela_qr(p_waktu timestamptz default now())
returns bigint
language sql stable set search_path = ''
as $$ select floor(extract(epoch from p_waktu) / 45)::bigint $$;

create function internal.kode_qr_pertemuan(p_pertemuan uuid, p_rahasia text, p_jendela bigint)
returns text
language sql immutable set search_path = ''
as $$
  select left(encode(extensions.hmac(p_pertemuan::text || ':' || p_jendela::text,
                                     p_rahasia, 'sha256'), 'hex'), 20)
$$;

-- Dipanggil layar pemimpin untuk menampilkan QR yang sedang berlaku.
create function public.token_qr_pertemuan(p_pertemuan uuid)
returns table (kode text, sisa_detik integer)
language plpgsql security definer set search_path = ''
as $$
declare
  v_rahasia text;
begin
  select s.rahasia into v_rahasia
  from public.pertemuan p
  join internal.pertemuan_rahasia s on s.pertemuan_id = p.id
  where p.id = p_pertemuan
    and p.kelompok_id in (select bantu.kelompok_dipimpin())
    and p.tanggal = bantu.hari_ini_wib()
    and p.dibuka_pada is not null
    and p.ditutup_pada is null;

  if v_rahasia is null then
    raise exception 'Pertemuan tidak ditemukan, bukan hari ini, belum dibuka, atau sudah ditutup.'
      using errcode = '42501';
  end if;

  return query select
    internal.kode_qr_pertemuan(p_pertemuan, v_rahasia, internal.jendela_qr()),
    (45 - (floor(extract(epoch from now()))::bigint % 45))::integer;
end;
$$;

-- Dipanggil HP anggota setelah men-scan QR di layar.
create function public.check_in(p_kode text)
returns table (pertemuan_id uuid, tanggal date, kelompok_nama text)
language plpgsql security definer set search_path = ''
as $$
#variable_conflict use_column
declare
  v_anggota  uuid := bantu.anggota_saya();
  v_kelompok uuid;
  v_jendela  bigint := internal.jendela_qr();
  v_kode     text := lower(trim(coalesce(p_kode, '')));
  v_ketemu   uuid;
  r          record;
begin
  if v_anggota is null then
    raise exception 'Akun Anda belum terhubung ke profil anggota.' using errcode = '42501';
  end if;

  select a.kelompok_id into v_kelompok from public.anggota a where a.id = v_anggota;

  -- Hanya pertemuan KELOMPOK SENDIRI, HARI INI, yang SEDANG DIBUKA.
  for r in
    select p.id, s.rahasia
    from public.pertemuan p
    join internal.pertemuan_rahasia s on s.pertemuan_id = p.id
    where p.kelompok_id = v_kelompok
      and p.tanggal = bantu.hari_ini_wib()
      and p.dibuka_pada is not null
      and p.ditutup_pada is null
  loop
    if v_kode in (internal.kode_qr_pertemuan(r.id, r.rahasia, v_jendela),
                  internal.kode_qr_pertemuan(r.id, r.rahasia, v_jendela - 1)) then
      v_ketemu := r.id;
      exit;
    end if;
  end loop;

  if v_ketemu is null then
    raise exception 'Kode QR tidak berlaku atau sudah kedaluwarsa. Silakan scan ulang QR di layar.'
      using errcode = '22023';
  end if;

  if exists (select 1 from public.kehadiran k
             where k.pertemuan_id = v_ketemu and k.anggota_id = v_anggota and k.hadir) then
    raise exception 'Anda sudah tercatat hadir di pertemuan ini.' using errcode = '23505';
  end if;

  insert into public.kehadiran (pertemuan_id, anggota_id, hadir, waktu, cara, dicatat_oleh)
  values (v_ketemu, v_anggota, true, now(), 'scan_sendiri', auth.uid())
  on conflict on constraint kehadiran_unik do update
    set hadir = true, waktu = now(), cara = 'scan_sendiri',
        alasan = null, alasan_catatan = null, dicatat_oleh = auth.uid();

  return query
    select p.id, p.tanggal, k.nama
    from public.pertemuan p join public.kelompok k on k.id = p.kelompok_id
    where p.id = v_ketemu;
end;
$$;


-- ---------------------------------------------------------------------
-- B3. PEMIMPIN MEN-SCAN KARTU QR ANGGOTA
-- ---------------------------------------------------------------------
create function public.scan_kartu_anggota(p_pertemuan uuid, p_kode_kartu text)
returns table (anggota_id uuid, nama_lengkap text, sudah_tercatat boolean)
language plpgsql security definer set search_path = ''
as $$
#variable_conflict use_column
declare
  v_kelompok uuid;
  v_anggota  uuid;
  v_nama     text;
  v_sudah    boolean;
begin
  select p.kelompok_id into v_kelompok
  from public.pertemuan p
  where p.id = p_pertemuan and p.kelompok_id in (select bantu.kelompok_dipimpin());

  if v_kelompok is null then
    raise exception 'Pertemuan tidak ditemukan atau bukan kelompok Anda.' using errcode = '42501';
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


-- ---------------------------------------------------------------------
-- B3b. RIWAYAT KEHADIRAN SAYA (untuk anggota)
-- Menampilkan tanggal, hadir/tidak, cara, dan kategori alasan.
-- Catatan alasan yang ditulis pemimpin TIDAK ditampilkan.
-- ---------------------------------------------------------------------
create function public.riwayat_kehadiran_saya(p_jumlah integer default 52)
returns table (
  tanggal       date,
  kelompok_nama text,
  hadir         boolean,
  cara          public.cara_absen,
  alasan        public.alasan_absen
)
language sql stable security definer set search_path = ''
as $$
  select p.tanggal, k.nama, h.hadir, h.cara, h.alasan
  from public.kehadiran h
  join public.pertemuan p on p.id = h.pertemuan_id
  join public.kelompok  k on k.id = p.kelompok_id
  where h.anggota_id = bantu.anggota_saya()
  order by p.tanggal desc
  limit least(greatest(coalesce(p_jumlah, 52), 1), 520);
$$;


-- ---------------------------------------------------------------------
-- B4. LAPORAN DEMOGRAFI (khusus Admin)
-- Dihitung di database; aplikasi hanya menerima angka ringkasan per
-- kelompok. "Belum diisi" dipisah, dan persentase dihitung dari yang
-- sudah mengisi.
--   p_dimensi : gender | pendidikan | status_nikah | pekerjaan |
--               provinsi | kota | kecamatan | kelurahan | rentang_usia
--   p_cakupan : semua | tim | kelompok  (+ p_cakupan_id untuk tim/kelompok)
-- ---------------------------------------------------------------------
create function internal.rentang_usia(p_lahir date)
returns text
language sql stable set search_path = ''
as $$
  select case
    when p_lahir is null then null
    when u < 13 then '0-12'
    when u < 18 then '13-17'
    when u < 25 then '18-24'
    when u < 35 then '25-34'
    when u < 45 then '35-44'
    when u < 55 then '45-54'
    when u < 65 then '55-64'
    else '65+'
  end
  from (select extract(year from age(bantu.hari_ini_wib(), p_lahir))::int as u) x;
$$;

create function public.laporan_demografi(
  p_dimensi     text,
  p_cakupan     text    default 'semua',
  p_cakupan_id  uuid    default null,
  p_hanya_aktif boolean default true
)
returns table (
  tim_nama      text,
  kelompok_id   uuid,
  kelompok_nama text,
  kunci         text,     -- nilai mentah (mis. 's1' atau kode wilayah)
  label         text,     -- teks tampilan (mis. nama kota); 'Belum diisi' bila kosong
  jumlah        bigint,
  persen        numeric   -- null untuk baris 'Belum diisi'
)
language plpgsql security definer set search_path = ''
as $$
#variable_conflict use_column
begin
  if not bantu.saya_admin() then
    raise exception 'Laporan demografi hanya dapat dibuka oleh Admin.' using errcode = '42501';
  end if;
  if p_dimensi not in ('gender','pendidikan','status_nikah','pekerjaan',
                       'provinsi','kota','kecamatan','kelurahan','rentang_usia') then
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
        when 'gender'       then a.gender::text
        when 'pendidikan'   then a.pendidikan::text
        when 'status_nikah' then a.status_nikah::text
        when 'pekerjaan'    then a.pekerjaan::text
        when 'provinsi'     then a.provinsi_kode
        when 'kota'         then a.kota_kode
        when 'kecamatan'    then a.kecamatan_kode
        when 'kelurahan'    then a.kelurahan_kode
        when 'rentang_usia' then internal.rentang_usia(a.tanggal_lahir)
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

-- Dipanggil aplikasi setiap kali Admin mengekspor laporan (Excel/CSV/PDF).
create function public.catat_ekspor_laporan(p_format text, p_parameter jsonb default '{}'::jsonb)
returns void
language plpgsql security definer set search_path = ''
as $$
begin
  if not bantu.saya_admin() then
    raise exception 'Hanya Admin yang dapat mengekspor laporan.' using errcode = '42501';
  end if;
  if p_format not in ('xlsx', 'csv', 'pdf') then
    raise exception 'Format ekspor tidak dikenal: %', p_format using errcode = '22023';
  end if;
  perform internal.catat_log('ekspor_laporan',
    jsonb_build_object('format', p_format, 'parameter', coalesce(p_parameter, '{}'::jsonb)));
end;
$$;


-- ---------------------------------------------------------------------
-- HAK MEMANGGIL LOKET
-- Hanya pengguna yang sudah login; tamu (anon) tidak bisa memanggil apa pun.
-- Fungsi di ruang internal tidak bisa dipanggil pengguna sama sekali.
-- ---------------------------------------------------------------------
revoke all on all functions in schema public   from public, anon;
grant execute on all functions in schema public to authenticated;
revoke all on all functions in schema internal from public, anon, authenticated;


-- >>>>>>>>>> 20261112000500_tugas_otomatis.sql <<<<<<<<<<
-- =====================================================================
-- 05 · TUGAS OTOMATIS ("petugas yang berkeliling tiap malam")
-- Keduanya disimpan di ruang internal, jadi pengguna tidak bisa
-- memanggilnya; hanya penjadwal database (pg_cron) yang menjalankannya.
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1. Tandai anggota TIDAK AKTIF bila tidak hadir 3 bulan berturut-turut.
--    Syarat (semua harus terpenuhi):
--      * saat ini masih aktif;
--      * sudah bergabung minimal 3 bulan (anggota baru tidak ikut diperiksa);
--      * kelompoknya mengadakan minimal satu pertemuan dalam 3 bulan terakhir
--        (bila kelompok sedang libur, anggotanya tidak dianggap absen);
--      * tidak tercatat hadir sekali pun dalam 3 bulan terakhir.
--    Anggota otomatis aktif kembali saat ditandai hadir (penjaga A7, file 04).
-- ---------------------------------------------------------------------
create function internal.tandai_tidak_aktif()
returns integer
language plpgsql security definer set search_path = ''
as $$
declare
  v_hari_ini date := bantu.hari_ini_wib();
  v_batas    date := (bantu.hari_ini_wib() - interval '3 months')::date;
  v_jumlah   integer;
begin
  update public.anggota a
     set aktif = false, dinonaktifkan_pada = now()
   where a.aktif
     and a.bergabung_pada <= v_batas
     and exists (
           select 1 from public.pertemuan p
           where p.kelompok_id = a.kelompok_id
             and p.tanggal > v_batas and p.tanggal <= v_hari_ini)
     and not exists (
           select 1 from public.kehadiran h
           join public.pertemuan p on p.id = h.pertemuan_id
           where h.anggota_id = a.id and h.hadir and p.tanggal > v_batas);

  get diagnostics v_jumlah = row_count;
  if v_jumlah > 0 then
    perform internal.catat_log('nonaktif_otomatis', jsonb_build_object('jumlah', v_jumlah));
  end if;
  return v_jumlah;
end;
$$;

-- ---------------------------------------------------------------------
-- 2. Hapus data anggota yang sudah TIDAK AKTIF LEBIH DARI 1 TAHUN.
--    Ikut terhapus otomatis (lewat sambungan "on delete cascade"):
--    kehadiran, catatan khusus, status proyek, dan undangan.
--    Foto masuk antrean hapus (penjaga A3, file 04).
--    Akun login yang terhubung dilepas dari profil (anggota_id menjadi kosong).
-- ---------------------------------------------------------------------
create function internal.hapus_data_kedaluwarsa()
returns integer
language plpgsql security definer set search_path = ''
as $$
declare
  v_jumlah integer;
begin
  delete from public.anggota
   where not aktif
     and dinonaktifkan_pada < now() - interval '1 year';

  get diagnostics v_jumlah = row_count;
  if v_jumlah > 0 then
    perform internal.catat_log('hapus_otomatis', jsonb_build_object('jumlah', v_jumlah));
  end if;
  return v_jumlah;
end;
$$;

revoke all on function internal.tandai_tidak_aktif()     from public, anon, authenticated;
revoke all on function internal.hapus_data_kedaluwarsa() from public, anon, authenticated;

-- ---------------------------------------------------------------------
-- 3. Jadwal: setiap malam pukul 01.00 dan 01.30 WIB.
--    (pg_cron memakai jam UTC: 18.00 UTC = 01.00 WIB.)
--    Bila pg_cron belum tersedia, bagian ini dilewati dengan pemberitahuan.
-- ---------------------------------------------------------------------
do $$
begin
  if exists (select 1 from pg_available_extensions where name = 'pg_cron') then
    create extension if not exists pg_cron;
    perform cron.schedule('tandai-anggota-tidak-aktif', '0 18 * * *',
                          'select internal.tandai_tidak_aktif()');
    perform cron.schedule('hapus-data-kedaluwarsa',     '30 18 * * *',
                          'select internal.hapus_data_kedaluwarsa()');
  else
    raise notice 'pg_cron tidak tersedia di database ini; jadwal otomatis dilewati.';
  end if;
end;
$$;
