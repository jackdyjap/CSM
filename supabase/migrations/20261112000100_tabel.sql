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
