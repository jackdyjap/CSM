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
