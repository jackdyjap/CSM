-- =====================================================================
-- 06 · UJI AKSES ("mencoba membobol, untuk memastikan satpam bekerja")
--
-- Membuat data dan akun palsu untuk setiap peran, lalu mencoba berbagai
-- tindakan yang BOLEH dan yang TIDAK BOLEH. Semuanya berjalan di dalam
-- satu transaksi yang dibatalkan (rollback) di akhir, sehingga TIDAK ADA
-- data uji yang tertinggal di database.
--
-- Hasil: tabel berisi setiap uji dengan status LULUS / GAGAL.
-- =====================================================================
begin;

-- ---------------------------------------------------------------------
-- Alat bantu uji
-- ---------------------------------------------------------------------
create schema tests;
grant usage on schema tests to anon, authenticated, service_role;

create table tests.hasil (no serial primary key, nama text, lulus boolean, info text);
create table tests.ids   (nama text primary key, id uuid not null);
create table tests.nilai (nama text primary key, teks text);
grant select on tests.ids, tests.nilai to anon, authenticated, service_role;

create function tests.id(p_nama text) returns uuid language sql stable as $$
  select id from tests.ids where nama = p_nama
$$;

create function tests.periksa(p_nama text, p_kondisi boolean, p_info text default null)
returns void language plpgsql security definer as $$
begin
  insert into tests.hasil (nama, lulus, info) values (p_nama, coalesce(p_kondisi, false), p_info);
end $$;

create function tests.simpan(p_nama text, p_teks text)
returns void language plpgsql security definer as $$
begin
  insert into tests.nilai values (p_nama, p_teks)
  on conflict (nama) do update set teks = excluded.teks;
end $$;

-- Uji yang HARUS ditolak database.
create function tests.harus_gagal(p_nama text, p_sql text)
returns void language plpgsql as $$
begin
  execute p_sql;
  perform tests.periksa(p_nama, false, 'TIDAK DITOLAK (seharusnya ditolak)');
exception when others then
  perform tests.periksa(p_nama, true, 'ditolak: ' || sqlerrm);
end $$;

-- Uji yang HARUS berhasil.
create function tests.harus_berhasil(p_nama text, p_sql text)
returns void language plpgsql as $$
begin
  execute p_sql;
  perform tests.periksa(p_nama, true, null);
exception when others then
  perform tests.periksa(p_nama, false, 'error: ' || sqlerrm);
end $$;

-- Jumlah baris yang terkena perintah ubah/hapus.
create function tests.baris_terkena(p_sql text)
returns bigint language plpgsql as $$
declare n bigint;
begin
  execute p_sql;
  get diagnostics n = row_count;
  return n;
end $$;

create function tests.masuk_sebagai(p_nama text)
returns void language plpgsql as $$
begin
  execute 'reset role';
  perform set_config('request.jwt.claims',
                     json_build_object('sub', tests.id(p_nama), 'role', 'authenticated')::text, true);
  execute 'set local role authenticated';
end $$;

create function tests.masuk_sebagai_tamu()
returns void language plpgsql as $$
begin
  execute 'reset role';
  perform set_config('request.jwt.claims', '', true);
  execute 'set local role anon';
end $$;

create function tests.keluar()
returns void language plpgsql as $$
begin
  execute 'reset role';
  perform set_config('request.jwt.claims', '', true);
end $$;

-- ---------------------------------------------------------------------
-- Data palsu
--   Tim A: Kelompok A1 (pemimpin Budi, wakil Sari), Kelompok A2
--   Tim B: Kelompok B1 (pemimpin Dewi)
--   Ketua Tim A juga pemimpin Kelompok A2 (peran ganda).
-- ---------------------------------------------------------------------
insert into tests.ids values
  ('tim_a',  '11111111-0000-0000-0000-00000000000a'),
  ('tim_b',  '11111111-0000-0000-0000-00000000000b'),
  ('kel_a1', '22222222-0000-0000-0000-0000000000a1'),
  ('kel_a2', '22222222-0000-0000-0000-0000000000a2'),
  ('kel_b1', '22222222-0000-0000-0000-0000000000b1'),
  ('admin',   '33333333-0000-0000-0000-000000000001'),
  ('ketua_a', '33333333-0000-0000-0000-000000000002'),
  ('ketua_b', '33333333-0000-0000-0000-000000000003'),
  ('budi',    '33333333-0000-0000-0000-000000000004'),
  ('sari',    '33333333-0000-0000-0000-000000000005'),
  ('dewi',    '33333333-0000-0000-0000-000000000006'),
  ('u_andi',  '33333333-0000-0000-0000-000000000007'),
  ('u_bima',  '33333333-0000-0000-0000-000000000008'),
  ('u_cici',  '33333333-0000-0000-0000-000000000009'),
  ('tanpa_peran', '33333333-0000-0000-0000-00000000000a'),
  ('andi',   '44444444-0000-0000-0000-0000000000a1'),
  ('ani',    '44444444-0000-0000-0000-0000000000a2'),
  ('asep',   '44444444-0000-0000-0000-0000000000a3'),
  ('lama',   '44444444-0000-0000-0000-0000000000a4'),
  ('jarang', '44444444-0000-0000-0000-0000000000a5'),
  ('cici',   '44444444-0000-0000-0000-0000000000a6'),
  ('bima',   '44444444-0000-0000-0000-0000000000b1'),
  ('rapat_a1', '55555555-0000-0000-0000-0000000000a1'),
  ('rapat_b1', '55555555-0000-0000-0000-0000000000b1');

insert into public.tim (id, nama) values
  (tests.id('tim_a'), 'Tim A'), (tests.id('tim_b'), 'Tim B');
insert into public.kelompok (id, tim_id, nama) values
  (tests.id('kel_a1'), tests.id('tim_a'), 'Kelompok A1'),
  (tests.id('kel_a2'), tests.id('tim_a'), 'Kelompok A2'),
  (tests.id('kel_b1'), tests.id('tim_b'), 'Kelompok B1');

-- Akun dibuat otomatis oleh sistem saat pengguna login dibuat (Fase 2).
insert into auth.users (id, email, raw_user_meta_data)
  select id, nama || '@contoh.test', jsonb_build_object('nama', initcap(nama))
  from tests.ids where id::text like '33333333%';

insert into public.penugasan_peran (akun_id, peran, tim_id, kelompok_id, jabatan) values
  (tests.id('admin'),   'admin',     null,              null,               null),
  (tests.id('ketua_a'), 'ketua_tim', tests.id('tim_a'), null,               null),
  (tests.id('ketua_a'), 'pemimpin',  null,              tests.id('kel_a2'), 'pemimpin'),
  (tests.id('ketua_b'), 'ketua_tim', tests.id('tim_b'), null,               null),
  (tests.id('budi'),    'pemimpin',  null,              tests.id('kel_a1'), 'pemimpin'),
  (tests.id('sari'),    'pemimpin',  null,              tests.id('kel_a1'), 'wakil'),
  (tests.id('dewi'),    'pemimpin',  null,              tests.id('kel_b1'), 'pemimpin');

insert into public.anggota (id, kelompok_id, nama_lengkap, persetujuan_pada, gender, tanggal_lahir, pendidikan, foto_path) values
  (tests.id('andi'), tests.id('kel_a1'), 'Andi', now(), 'laki_laki', '1990-01-01', 's1',     tests.id('andi') || '/foto.jpg'),
  (tests.id('ani'),  tests.id('kel_a1'), 'Ani',  null,  null,        null,         null,     null),
  (tests.id('cici'), tests.id('kel_a1'), 'Cici', null,  null,        null,         null,     null),
  (tests.id('asep'), tests.id('kel_a2'), 'Asep', now(), 'laki_laki', '1985-05-05', 'sma_smk', null),
  (tests.id('bima'), tests.id('kel_b1'), 'Bima', now(), 'laki_laki', '1992-02-02', 'd3',     tests.id('bima') || '/foto.jpg');

-- Anggota yang sudah tidak aktif 13 bulan (harus terhapus otomatis).
insert into public.anggota (id, kelompok_id, nama_lengkap, persetujuan_pada, foto_path, aktif, dinonaktifkan_pada)
values (tests.id('lama'), tests.id('kel_a1'), 'Lama', now(), tests.id('lama') || '/foto.jpg',
        false, now() - interval '13 months');
-- Anggota yang bergabung 4 bulan lalu dan tidak pernah hadir (harus dinonaktifkan).
insert into public.anggota (id, kelompok_id, nama_lengkap, bergabung_pada)
values (tests.id('jarang'), tests.id('kel_a1'), 'Jarang', bantu.hari_ini_wib() - 120);

update public.akun set anggota_id = tests.id('andi') where id = tests.id('u_andi');
update public.akun set anggota_id = tests.id('bima') where id = tests.id('u_bima');
update public.akun set anggota_id = tests.id('cici') where id = tests.id('u_cici');

insert into public.pertemuan (id, kelompok_id, tanggal, dibuka_pada, persembahan) values
  (tests.id('rapat_a1'), tests.id('kel_a1'), bantu.hari_ini_wib(), now(), 150000),
  (tests.id('rapat_b1'), tests.id('kel_b1'), bantu.hari_ini_wib(), now(), 200000);

insert into public.catatan_khusus (anggota_id, penulis_id, jenis, isi) values
  (tests.id('andi'), tests.id('budi'), 'umum',         'Catatan tentang Andi'),
  (tests.id('bima'), tests.id('dewi'), 'alasan_absen', 'Catatan tentang Bima'),
  (tests.id('lama'), tests.id('budi'), 'umum',         'Catatan tentang Lama');

insert into storage.objects (bucket_id, name) values
  ('foto-anggota', tests.id('andi') || '/foto.jpg'),
  ('foto-anggota', tests.id('bima') || '/foto.jpg');

select tests.simpan('catatan_bima', (select id::text from public.catatan_khusus where anggota_id = tests.id('bima') limit 1));

-- Kode kartu QR Bima (untuk uji: pemimpin A1 men-scan kartu anggota B1).
select tests.simpan('kartu_bima', (select kode_qr from public.anggota where id = tests.id('bima')));

-- Kode QR kedaluwarsa (3 jendela = lebih dari 2 menit yang lalu).
select tests.simpan('kode_a1_kedaluwarsa',
  internal.kode_qr_pertemuan(tests.id('rapat_a1'),
    (select rahasia from internal.pertemuan_rahasia where pertemuan_id = tests.id('rapat_a1')),
    internal.jendela_qr() - 3));


-- =====================================================================
-- UJI 1 · TAMU (belum login)
-- =====================================================================
select tests.masuk_sebagai_tamu();
select tests.harus_gagal('Tamu: tidak bisa membaca anggota', $q$ select * from public.anggota $q$);
select tests.harus_gagal('Tamu: tidak bisa membaca tim',     $q$ select * from public.tim $q$);
select tests.harus_gagal('Tamu: tidak bisa check-in',        $q$ select * from public.check_in('abc') $q$);
select tests.harus_gagal('Tamu: tidak bisa membuka laporan', $q$ select * from public.laporan_demografi('gender') $q$);
select tests.harus_gagal('Tamu: tidak bisa melihat riwayat kehadiran', $q$ select * from public.riwayat_kehadiran_saya() $q$);


-- =====================================================================
-- UJI 2 · PEMIMPIN KELOMPOK A1 (Budi)
-- =====================================================================
select tests.masuk_sebagai('budi');
select tests.periksa('Budi: melihat 5 anggota kelompok A1 saja',
  (select count(*) from public.anggota) = 5 and
  (select bool_and(kelompok_id = tests.id('kel_a1')) from public.anggota));
select tests.periksa('Budi: tidak bisa membuka profil Bima (B1) walau tahu id-nya',
  (select count(*) from public.anggota where id = tests.id('bima')) = 0);
select tests.periksa('Budi: tidak melihat pertemuan B1',
  (select count(*) from public.pertemuan where kelompok_id = tests.id('kel_b1')) = 0);
select tests.periksa('Budi: tidak bisa mengubah profil Bima (0 baris)',
  tests.baris_terkena($q$ update public.anggota set alamat = 'x' where id = tests.id('bima') $q$) = 0);
select tests.periksa('Budi: tidak bisa menghapus profil Bima (0 baris)',
  tests.baris_terkena($q$ delete from public.anggota where id = tests.id('bima') $q$) = 0);
select tests.harus_gagal('Budi: tidak bisa menambah anggota ke kelompok B1',
  $q$ insert into public.anggota (kelompok_id, nama_lengkap) values (tests.id('kel_b1'), 'Penyusup') $q$);
select tests.harus_gagal('Budi: tidak bisa memindahkan Andi ke kelompok B1',
  $q$ update public.anggota set kelompok_id = tests.id('kel_b1') where id = tests.id('andi') $q$);
select tests.harus_berhasil('Budi: bisa menambah anggota baru di A1',
  $q$ insert into public.anggota (kelompok_id, nama_lengkap) values (tests.id('kel_a1'), 'Anggota Baru') $q$);
select tests.harus_gagal('Budi: tidak bisa mengisi data pribadi Ani sebelum ada persetujuan',
  $q$ update public.anggota set alamat = 'Jl. Mawar 1' where id = tests.id('ani') $q$);
select tests.harus_berhasil('Budi: bisa mencatat persetujuan Ani sekaligus mengisi alamat',
  $q$ update public.anggota set persetujuan_pada = now(), alamat = 'Jl. Mawar 1' where id = tests.id('ani') $q$);
select tests.periksa('Budi: persetujuan Ani tercatat "pemimpin" oleh akun Budi',
  (select persetujuan_dicatat_oleh = 'pemimpin' and persetujuan_dicatat_akun = tests.id('budi')
   from public.anggota where id = tests.id('ani')));
select tests.harus_gagal('Budi: anggota < 18 tahun tanpa wali ditolak',
  $q$ insert into public.anggota (kelompok_id, nama_lengkap, persetujuan_pada, tanggal_lahir)
      values (tests.id('kel_a1'), 'Remaja', now(), bantu.hari_ini_wib() - 365 * 15) $q$);
select tests.harus_berhasil('Budi: anggota < 18 tahun dengan wali diterima',
  $q$ insert into public.anggota (kelompok_id, nama_lengkap, persetujuan_pada, tanggal_lahir, wali_nama, wali_hubungan)
      values (tests.id('kel_a1'), 'Remaja', now(), bantu.hari_ini_wib() - 365 * 15, 'Ibu Remaja', 'ibu') $q$);

select tests.harus_gagal('Budi: pilihan wilayah yang tidak nyambung ditolak (kota Bandung di provinsi DKI)',
  $q$ update public.anggota set provinsi_kode = '31', kota_kode = '32.73' where id = tests.id('andi') $q$);
select tests.harus_berhasil('Budi: pilihan wilayah yang nyambung diterima',
  $q$ update public.anggota set provinsi_kode = '31', kota_kode = '31.71', kecamatan_kode = '31.71.01'
      where id = tests.id('andi') $q$);

-- Catatan khusus
select tests.harus_gagal('Budi: tidak bisa membaca tabel catatan secara langsung',
  $q$ select * from public.catatan_khusus $q$);
select tests.periksa('Budi: bisa membaca catatan Andi lewat loket',
  (select count(*) from public.baca_catatan(tests.id('andi'))) = 1);
select tests.harus_gagal('Budi: tidak bisa membaca catatan Bima (kelompok B1)',
  $q$ select * from public.baca_catatan(tests.id('bima')) $q$);
select tests.harus_gagal('Budi: tidak bisa membaca catatan Asep (kelompok A2)',
  $q$ select * from public.baca_catatan(tests.id('asep')) $q$);
select tests.harus_berhasil('Budi: bisa menulis catatan untuk Andi',
  $q$ select public.tulis_catatan(tests.id('andi'), 'alasan_absen', 'Sakit demam') $q$);
select tests.harus_gagal('Budi: tidak bisa menulis catatan untuk Bima',
  $q$ select public.tulis_catatan(tests.id('bima'), 'umum', 'Coba-coba') $q$);

-- Foto
select tests.periksa('Budi: bisa melihat foto Andi',
  (select count(*) from storage.objects where name like tests.id('andi') || '/%') = 1);
select tests.periksa('Budi: tidak bisa melihat foto Bima',
  (select count(*) from storage.objects where name like tests.id('bima') || '/%') = 0);
select tests.harus_gagal('Budi: tidak bisa mengunggah foto ke folder Bima',
  $q$ insert into storage.objects (bucket_id, name) values ('foto-anggota', tests.id('bima') || '/palsu.jpg') $q$);
select tests.harus_berhasil('Budi: bisa mengunggah foto Ani',
  $q$ insert into storage.objects (bucket_id, name) values ('foto-anggota', tests.id('ani') || '/foto.jpg') $q$);

-- Absensi
select tests.harus_gagal('Budi: tidak bisa mengabsen Bima di pertemuan A1',
  $q$ insert into public.kehadiran (pertemuan_id, anggota_id, hadir) values (tests.id('rapat_a1'), tests.id('bima'), true) $q$);
select tests.harus_gagal('Budi: tidak bisa mengisi absensi pertemuan B1',
  $q$ insert into public.kehadiran (pertemuan_id, anggota_id, hadir) values (tests.id('rapat_b1'), tests.id('bima'), true) $q$);
select tests.harus_berhasil('Budi: bisa men-scan kartu QR Ani',
  $q$ select * from public.scan_kartu_anggota(tests.id('rapat_a1'),
        (select kode_qr from public.anggota where id = tests.id('ani'))) $q$);
select tests.harus_gagal('Budi: kartu QR Bima ditolak di pertemuan A1',
  $q$ select * from public.scan_kartu_anggota(tests.id('rapat_a1'),
        (select teks from tests.nilai where nama = 'kartu_bima')) $q$);
select tests.harus_gagal('Budi: tidak bisa mengintip kunci rahasia QR',
  $q$ select * from internal.pertemuan_rahasia $q$);
select tests.harus_berhasil('Budi: bisa menampilkan QR pertemuan A1',
  $q$ select tests.simpan('kode_a1', (select kode from public.token_qr_pertemuan(tests.id('rapat_a1')))) $q$);
select tests.harus_gagal('Budi: tidak bisa menampilkan QR pertemuan B1',
  $q$ select * from public.token_qr_pertemuan(tests.id('rapat_b1')) $q$);

-- Area admin
select tests.harus_gagal('Budi: tidak bisa membuka laporan demografi',
  $q$ select * from public.laporan_demografi('gender') $q$);
select tests.harus_gagal('Budi: tidak bisa memberi dirinya peran admin',
  $q$ insert into public.penugasan_peran (akun_id, peran) values (tests.id('budi'), 'admin') $q$);
select tests.periksa('Budi: tidak bisa membaca log aktivitas',
  (select count(*) from public.log_aktivitas) = 0);
select tests.harus_gagal('Budi: tidak bisa menjalankan tugas otomatis',
  $q$ select internal.hapus_data_kedaluwarsa() $q$);


-- =====================================================================
-- UJI 3 · WAKIL KELOMPOK A1 (Sari): haknya sama dengan pemimpin
-- =====================================================================
select tests.masuk_sebagai('sari');
select tests.periksa('Sari (wakil): melihat anggota A1',
  (select count(*) from public.anggota where kelompok_id = tests.id('kel_a1')) > 0);
select tests.harus_berhasil('Sari (wakil): bisa membuat pertemuan A1 kemarin',
  $q$ insert into public.pertemuan (kelompok_id, tanggal) values (tests.id('kel_a1'), bantu.hari_ini_wib() - 1) $q$);
select tests.harus_berhasil('Sari (wakil): bisa mengisi persembahan',
  $q$ update public.pertemuan set persembahan = 175000 where id = tests.id('rapat_a1') $q$);
select tests.harus_berhasil('Sari (wakil): bisa menulis catatan untuk Ani',
  $q$ select public.tulis_catatan(tests.id('ani'), 'umum', 'Baru pindah rumah') $q$);
select tests.periksa('Sari (wakil): bisa membaca catatan Andi',
  (select count(*) from public.baca_catatan(tests.id('andi'))) = 2);


-- =====================================================================
-- UJI 4 · ANGGOTA (Andi, kelompok A1)
-- =====================================================================
select tests.masuk_sebagai('u_andi');
select tests.periksa('Andi: hanya melihat profilnya sendiri',
  (select count(*) from public.anggota) = 1 and
  (select id from public.anggota) = tests.id('andi'));
select tests.periksa('Andi: hanya melihat kelompoknya sendiri',
  (select count(*) from public.kelompok) = 1);
select tests.periksa('Andi: tidak melihat data pertemuan/persembahan',
  (select count(*) from public.pertemuan) = 0);
select tests.periksa('Andi: bisa mengubah alamatnya sendiri',
  tests.baris_terkena($q$ update public.anggota set alamat = 'Jl. Melati 2' where id = tests.id('andi') $q$) = 1);
select tests.periksa('Andi: tidak bisa mengubah profil Ani (0 baris)',
  tests.baris_terkena($q$ update public.anggota set alamat = 'x' where id = tests.id('ani') $q$) = 0);
select tests.harus_gagal('Andi: tidak bisa memindahkan dirinya ke kelompok lain',
  $q$ update public.anggota set kelompok_id = tests.id('kel_a2') where id = tests.id('andi') $q$);
select tests.harus_gagal('Andi: tidak bisa mengubah status aktifnya',
  $q$ update public.anggota set aktif = false where id = tests.id('andi') $q$);
select tests.harus_gagal('Andi: tidak bisa mengganti kode QR-nya',
  $q$ update public.anggota set kode_qr = 'abc' where id = tests.id('andi') $q$);
select tests.harus_gagal('Andi: tidak bisa membaca tabel catatan',
  $q$ select * from public.catatan_khusus $q$);
select tests.harus_gagal('Andi: tidak bisa membaca catatan tentang dirinya lewat loket',
  $q$ select * from public.baca_catatan(tests.id('andi')) $q$);
select tests.harus_gagal('Andi: tidak bisa menulis catatan',
  $q$ select public.tulis_catatan(tests.id('ani'), 'umum', 'iseng') $q$);
select tests.harus_gagal('Andi: tidak bisa mengisi kehadiran langsung',
  $q$ insert into public.kehadiran (pertemuan_id, anggota_id, hadir) values (tests.id('rapat_a1'), tests.id('andi'), true) $q$);
select tests.harus_gagal('Andi: tidak bisa membuka laporan demografi',
  $q$ select * from public.laporan_demografi('gender') $q$);
select tests.harus_gagal('Andi: tidak bisa mengunggah foto ke folder Ani',
  $q$ insert into storage.objects (bucket_id, name) values ('foto-anggota', tests.id('ani') || '/foto2.jpg') $q$);
select tests.harus_berhasil('Andi: bisa mengunggah fotonya sendiri',
  $q$ insert into storage.objects (bucket_id, name) values ('foto-anggota', tests.id('andi') || '/baru.jpg') $q$);
select tests.periksa('Andi: tidak bisa melihat foto Bima',
  (select count(*) from storage.objects where name like tests.id('bima') || '/%') = 0);

-- Check-in QR pertemuan
select tests.harus_gagal('Andi: kode QR asal-asalan ditolak',
  $q$ select * from public.check_in('0123456789abcdef0123') $q$);
select tests.harus_gagal('Andi: kode QR kedaluwarsa ditolak',
  $q$ select * from public.check_in((select teks from tests.nilai where nama = 'kode_a1_kedaluwarsa')) $q$);
select tests.harus_berhasil('Andi: check-in dengan QR yang berlaku',
  $q$ select * from public.check_in((select teks from tests.nilai where nama = 'kode_a1')) $q$);
select tests.harus_gagal('Andi: tidak bisa check-in dua kali',
  $q$ select * from public.check_in((select teks from tests.nilai where nama = 'kode_a1')) $q$);
select tests.periksa('Andi: tidak bisa membaca tabel kehadiran langsung (berisi catatan pemimpin)',
  (select count(*) from public.kehadiran) = 0);
select tests.periksa('Andi: melihat riwayat kehadirannya sendiri lewat loket (1 baris, scan sendiri)',
  (select count(*) from public.riwayat_kehadiran_saya()) = 1 and
  (select hadir and cara = 'scan_sendiri' and tanggal = bantu.hari_ini_wib()
   from public.riwayat_kehadiran_saya()));


-- =====================================================================
-- UJI 5 · ANGGOTA KELOMPOK LAIN (Bima, B1) dan anggota baru (Cici)
-- =====================================================================
select tests.masuk_sebagai('u_bima');
select tests.harus_gagal('Bima: tidak bisa check-in ke kelompok A1 dengan QR A1',
  $q$ select * from public.check_in((select teks from tests.nilai where nama = 'kode_a1')) $q$);
select tests.periksa('Bima: tidak bisa melihat profil anggota A1',
  (select count(*) from public.anggota where kelompok_id = tests.id('kel_a1')) = 0);

select tests.masuk_sebagai('u_cici');
select tests.harus_berhasil('Cici: memberi persetujuan sendiri sambil mengisi profil',
  $q$ update public.anggota set persetujuan_pada = now(), gender = 'perempuan', pendidikan = 'smp'
      where id = tests.id('cici') $q$);
select tests.periksa('Cici: persetujuan tercatat "anggota_sendiri"',
  (select persetujuan_dicatat_oleh = 'anggota_sendiri' from public.anggota where id = tests.id('cici')));
select tests.harus_gagal('Cici: tidak bisa menghapus persetujuan yang sudah tercatat',
  $q$ update public.anggota set persetujuan_pada = null, gender = null, pendidikan = null
      where id = tests.id('cici') $q$);


-- =====================================================================
-- UJI 6 · KETUA TIM A (juga pemimpin A2: peran ganda)
-- =====================================================================
select tests.masuk_sebagai('ketua_a');
select tests.periksa('Ketua A: melihat anggota A1 dan A2, bukan B1',
  (select count(*) from public.anggota where kelompok_id in (tests.id('kel_a1'), tests.id('kel_a2'))) >= 7 and
  (select count(*) from public.anggota where kelompok_id = tests.id('kel_b1')) = 0);
select tests.periksa('Ketua A: melihat pertemuan dan persembahan A1',
  (select persembahan from public.pertemuan where id = tests.id('rapat_a1')) = 175000);
select tests.periksa('Ketua A: tidak melihat pertemuan B1',
  (select count(*) from public.pertemuan where id = tests.id('rapat_b1')) = 0);
select tests.periksa('Ketua A: melihat kehadiran A1',
  (select count(*) from public.kehadiran where kelompok_id = tests.id('kel_a1')) >= 2);
select tests.periksa('Ketua A: hanya membaca A1, tidak bisa mengubah profil Andi (0 baris)',
  tests.baris_terkena($q$ update public.anggota set alamat = 'x' where id = tests.id('andi') $q$) = 0);
select tests.harus_gagal('Ketua A: tidak bisa membuat pertemuan untuk A1',
  $q$ insert into public.pertemuan (kelompok_id, tanggal) values (tests.id('kel_a1'), bantu.hari_ini_wib() + 7) $q$);
select tests.periksa('Ketua A: bisa membaca catatan Andi (A1)',
  (select count(*) from public.baca_catatan(tests.id('andi'))) = 2);
select tests.harus_gagal('Ketua A: tidak bisa menulis catatan untuk Andi (A1)',
  $q$ select public.tulis_catatan(tests.id('andi'), 'umum', 'x') $q$);
select tests.harus_gagal('Ketua A: tidak bisa membaca catatan Bima (tim B)',
  $q$ select * from public.baca_catatan(tests.id('bima')) $q$);
select tests.periksa('Ketua A (peran ganda): bisa mengubah profil Asep di A2',
  tests.baris_terkena($q$ update public.anggota set no_hp = '0812' where id = tests.id('asep') $q$) = 1);
select tests.harus_berhasil('Ketua A (peran ganda): bisa menulis catatan untuk Asep di A2',
  $q$ select public.tulis_catatan(tests.id('asep'), 'umum', 'Rajin') $q$);
select tests.harus_gagal('Ketua A: tidak bisa membuka laporan demografi',
  $q$ select * from public.laporan_demografi('gender') $q$);


-- =====================================================================
-- UJI 7 · KETUA TIM B
-- =====================================================================
select tests.masuk_sebagai('ketua_b');
select tests.periksa('Ketua B: hanya melihat anggota tim B',
  (select count(*) from public.anggota) = 1 and
  (select id from public.anggota) = tests.id('bima'));
select tests.harus_gagal('Ketua B: tidak bisa membaca catatan Andi (tim A)',
  $q$ select * from public.baca_catatan(tests.id('andi')) $q$);
select tests.periksa('Ketua B: tidak bisa melihat foto Andi',
  (select count(*) from storage.objects where name like tests.id('andi') || '/%') = 0);


-- =====================================================================
-- UJI 8 · AKUN TANPA PERAN
-- =====================================================================
select tests.masuk_sebagai('tanpa_peran');
select tests.periksa('Tanpa peran: tidak melihat anggota, tim, atau kelompok apa pun',
  (select count(*) from public.anggota) = 0 and
  (select count(*) from public.tim) = 0 and
  (select count(*) from public.kelompok) = 0);


-- =====================================================================
-- UJI 9 · ADMIN
-- =====================================================================
select tests.masuk_sebagai('admin');
select tests.periksa('Admin: melihat anggota semua tim',
  (select count(*) from public.anggota where kelompok_id = tests.id('kel_b1')) = 1 and
  (select count(*) from public.anggota where kelompok_id = tests.id('kel_a1')) >= 6);
select tests.periksa('Admin: bisa membaca catatan Bima',
  (select count(*) from public.baca_catatan(tests.id('bima'))) = 1);
select tests.periksa('Admin: bisa mengubah profil anggota kelompok mana pun (keputusan 12)',
  tests.baris_terkena($q$ update public.anggota set alamat = 'x' where id = tests.id('bima') $q$) = 1);
select tests.harus_berhasil('Admin: bisa menulis catatan (keputusan 18)',
  $q$ select public.tulis_catatan(tests.id('bima'), 'umum', 'x') $q$);
select tests.harus_berhasil('Admin: bisa membuat tim baru',
  $q$ insert into public.tim (nama) values ('Tim C') $q$);
select tests.harus_berhasil('Admin: bisa memberi peran',
  $q$ insert into public.penugasan_peran (akun_id, peran, tim_id) values (tests.id('dewi'), 'ketua_tim', tests.id('tim_b')) $q$);
select tests.periksa('Admin: laporan demografi pendidikan A1 (persen 100%, "Belum diisi" terpisah)',
  (select round(sum(persen)) = 100 and bool_or(label = 'Belum diisi')
   from public.laporan_demografi('pendidikan', 'kelompok', tests.id('kel_a1'))));
select tests.harus_berhasil('Admin: laporan demografi rentang usia semua tim',
  $q$ select * from public.laporan_demografi('rentang_usia') $q$);
select tests.harus_gagal('Admin: dimensi laporan yang tidak dikenal ditolak',
  $q$ select * from public.laporan_demografi('agama') $q$);
select tests.harus_berhasil('Admin: mencatat ekspor laporan',
  $q$ select public.catat_ekspor_laporan('xlsx', '{"dimensi":"gender"}') $q$);
select tests.periksa('Admin: bisa membaca log aktivitas',
  (select count(*) from public.log_aktivitas) > 0);
select tests.harus_gagal('Admin: log tidak bisa dihapus',
  $q$ delete from public.log_aktivitas $q$);


-- =====================================================================
-- UJI 10 · LOG dan TUGAS OTOMATIS (dijalankan sebagai sistem)
-- =====================================================================
select tests.keluar();
select tests.periksa('Log: setiap pembacaan catatan tercatat',
  (select count(*) from public.log_aktivitas where tindakan = 'baca_catatan') = 4);
select tests.periksa('Log: pembuatan & ekspor laporan tercatat',
  exists (select 1 from public.log_aktivitas where tindakan = 'buat_laporan_demografi') and
  exists (select 1 from public.log_aktivitas where tindakan = 'ekspor_laporan'));
select tests.periksa('Log: perubahan peran tercatat',
  exists (select 1 from public.log_aktivitas where tindakan = 'ubah_peran' and akun_id = tests.id('admin')));

select tests.simpan('jumlah_nonaktif', internal.tandai_tidak_aktif()::text);
select tests.periksa('Otomatis: anggota yang 3 bulan tidak hadir ditandai tidak aktif',
  (select teks from tests.nilai where nama = 'jumlah_nonaktif') = '1' and
  (select not aktif and dinonaktifkan_pada is not null from public.anggota where id = tests.id('jarang')));
select tests.periksa('Otomatis: anggota baru dan yang hadir tetap aktif',
  (select bool_and(aktif) from public.anggota where id in (tests.id('andi'), tests.id('ani'), tests.id('cici'))));

select tests.masuk_sebagai('budi');
select tests.harus_berhasil('Otomatis: pemimpin menandai hadir anggota tidak aktif',
  $q$ insert into public.kehadiran (pertemuan_id, anggota_id, hadir) values (tests.id('rapat_a1'), tests.id('jarang'), true) $q$);
select tests.keluar();
select tests.periksa('Otomatis: anggota tidak aktif yang hadir menjadi aktif kembali',
  (select aktif and dinonaktifkan_pada is null from public.anggota where id = tests.id('jarang')));

select tests.simpan('jumlah_dihapus', internal.hapus_data_kedaluwarsa()::text);
select tests.periksa('Otomatis: data tidak aktif > 1 tahun terhapus',
  (select teks from tests.nilai where nama = 'jumlah_dihapus') = '1' and
  not exists (select 1 from public.anggota where id = tests.id('lama')));
select tests.periksa('Otomatis: catatan khusus anggota terhapus ikut hilang',
  not exists (select 1 from public.catatan_khusus where anggota_id = tests.id('lama')));
select tests.periksa('Otomatis: foto anggota terhapus masuk antrean hapus',
  exists (select 1 from internal.antrean_hapus_foto where foto_path like tests.id('lama') || '/%'));

select tests.harus_gagal('Data: satu anggota tidak bisa tercatat dua kali di satu pertemuan',
  $q$ insert into public.kehadiran (pertemuan_id, anggota_id, hadir) values (tests.id('rapat_a1'), tests.id('andi'), true) $q$);


-- =====================================================================
-- UJI 11 · FASE 2: AKUN OTOMATIS, UNDANGAN, TAUTAN ATUR ULANG
-- =====================================================================
select tests.keluar();
create function tests.masuk_sebagai_layanan()
returns void language plpgsql as $$
begin
  execute 'reset role';
  perform set_config('request.jwt.claims', '{"role":"service_role"}', true);
  execute 'set local role service_role';
end $$;

select tests.periksa('Akun: tercatat otomatis saat pengguna login dibuat (nama & login)',
  (select nama_tampilan = 'Budi' and login = 'budi@contoh.test' from public.akun where id = tests.id('budi')));

-- Pemimpin A1 (Budi)
select tests.masuk_sebagai('budi');
select tests.periksa('Peran saya (Budi): pemimpin Kelompok A1, bukan admin',
  (select (r -> 'pemimpin' -> 0 ->> 'nama') = 'Kelompok A1' and not (r ->> 'admin')::boolean
   from (select public.peran_saya() as r) x));
select tests.harus_berhasil('Budi: membuat undangan anggota baru untuk A1',
  $q$ select tests.simpan('undangan_baru', (select token from public.buat_undangan(tests.id('kel_a1')))) $q$);
select tests.harus_berhasil('Budi: membuat undangan untuk profil Ani',
  $q$ select tests.simpan('undangan_ani', (select token from public.buat_undangan(tests.id('kel_a1'), tests.id('ani')))) $q$);
select tests.harus_gagal('Budi: tidak bisa membuat undangan untuk kelompok B1',
  $q$ select * from public.buat_undangan(tests.id('kel_b1')) $q$);
select tests.harus_gagal('Budi: tidak bisa mengundang Andi (sudah punya akun)',
  $q$ select * from public.buat_undangan(tests.id('kel_a1'), tests.id('andi')) $q$);
select tests.harus_gagal('Budi: tidak bisa mengundang Bima ke A1 (bukan anggota A1)',
  $q$ select * from public.buat_undangan(tests.id('kel_a1'), tests.id('bima')) $q$);
select tests.periksa('Budi: melihat status akun anggota A1 (Andi punya, Ani belum)',
  (select punya_akun from public.status_akun_anggota(tests.id('kel_a1')) where anggota_id = tests.id('andi')) and
  not (select punya_akun from public.status_akun_anggota(tests.id('kel_a1')) where anggota_id = tests.id('ani')));
select tests.harus_gagal('Budi: tidak bisa melihat status akun kelompok B1',
  $q$ select * from public.status_akun_anggota(tests.id('kel_b1')) $q$);
select tests.harus_gagal('Budi: tidak bisa memanggil loket khusus server',
  $q$ select public.layanan_pakai_undangan('x', tests.id('budi'), 'x') $q$);
select tests.harus_berhasil('Budi: membuat tautan atur ulang untuk Andi (anggota A1)',
  $q$ select tests.simpan('reset_andi', (select token from public.buat_tautan_atur_ulang(tests.id('u_andi')))) $q$);
select tests.harus_gagal('Budi: tidak bisa membuat tautan atur ulang untuk Sari (sesama staf)',
  $q$ select * from public.buat_tautan_atur_ulang(tests.id('sari')) $q$);
select tests.harus_gagal('Budi: tidak bisa membuat tautan atur ulang untuk Bima (kelompok lain)',
  $q$ select * from public.buat_tautan_atur_ulang(tests.id('u_bima')) $q$);
select tests.harus_gagal('Budi: tidak bisa mengintip tabel tautan atur ulang',
  $q$ select * from internal.tautan_atur_ulang $q$);

-- Ketua Tim A (juga pemimpin A2)
select tests.masuk_sebagai('ketua_a');
select tests.periksa('Peran saya (Ketua A): ketua 1 tim dan pemimpin 1 kelompok',
  (select jsonb_array_length(r -> 'ketua_tim') = 1 and jsonb_array_length(r -> 'pemimpin') = 1
   from (select public.peran_saya() as r) x));
select tests.harus_gagal('Ketua A: tidak bisa membuat undangan untuk A1 (hanya membaca)',
  $q$ select * from public.buat_undangan(tests.id('kel_a1')) $q$);
select tests.harus_berhasil('Ketua A (peran ganda): bisa membuat undangan untuk A2',
  $q$ select tests.simpan('undangan_a2', (select token from public.buat_undangan(tests.id('kel_a2')))) $q$);

-- Anggota (Andi)
select tests.masuk_sebagai('u_andi');
select tests.periksa('Peran saya (Andi): anggota Kelompok A1, tanpa peran staf',
  (select (r -> 'anggota' ->> 'kelompok_nama') = 'Kelompok A1' and jsonb_array_length(r -> 'pemimpin') = 0
   from (select public.peran_saya() as r) x));
select tests.harus_gagal('Andi: tidak bisa membuat undangan',
  $q$ select * from public.buat_undangan(tests.id('kel_a1')) $q$);
select tests.harus_gagal('Andi: tidak bisa membuat tautan atur ulang',
  $q$ select * from public.buat_tautan_atur_ulang(tests.id('u_andi')) $q$);

-- Admin
select tests.masuk_sebagai('admin');
select tests.harus_berhasil('Admin: bisa membuat tautan atur ulang untuk pemimpin (Budi)',
  $q$ select * from public.buat_tautan_atur_ulang(tests.id('budi')) $q$);

-- Pengguna login baru dibuat oleh sistem (satu lewat nomor HP, satu lewat email)
select tests.keluar();
insert into tests.ids values
  ('u_ani',  '33333333-0000-0000-0000-00000000000b'),
  ('u_baru', '33333333-0000-0000-0000-00000000000c');
insert into auth.users (id, email, raw_user_meta_data) values
  (tests.id('u_ani'),  '6281234567890@hp.contoh.test', '{"nama":"Ani","login":"081234567890"}'),
  (tests.id('u_baru'), 'baru@contoh.test',             '{"nama":"Anggota Lewat Undangan"}');
select tests.periksa('Akun: pengguna nomor HP tercatat dengan login nomor HP-nya',
  (select login = '081234567890' and nama_tampilan = 'Ani' from public.akun where id = tests.id('u_ani')));

-- Server aplikasi (service_role)
select tests.masuk_sebagai_layanan();
select tests.periksa('Server: undangan Ani berlaku dan menyebut nama & kelompoknya',
  (select berlaku and nama_anggota = 'Ani' and kelompok_nama = 'Kelompok A1'
   from public.layanan_cek_undangan((select teks from tests.nilai where nama = 'undangan_ani'))));
select tests.harus_berhasil('Server: memakai undangan Ani untuk akun barunya',
  $q$ select public.layanan_pakai_undangan((select teks from tests.nilai where nama = 'undangan_ani'), tests.id('u_ani'), 'Ani') $q$);
select tests.periksa('Server: akun baru Ani tersambung ke profil Ani',
  (select anggota_id = tests.id('ani') from public.akun where id = tests.id('u_ani')));
select tests.harus_gagal('Server: undangan yang sudah dipakai tidak bisa dipakai lagi',
  $q$ select public.layanan_pakai_undangan((select teks from tests.nilai where nama = 'undangan_ani'), tests.id('u_baru'), 'X') $q$);
select tests.harus_berhasil('Server: memakai undangan anggota baru',
  $q$ select public.layanan_pakai_undangan((select teks from tests.nilai where nama = 'undangan_baru'), tests.id('u_baru'), 'Anggota Lewat Undangan') $q$);
select tests.periksa('Server: profil anggota baru dibuat di A1 dan tersambung ke akunnya',
  (select a.kelompok_id = tests.id('kel_a1') and a.nama_lengkap = 'Anggota Lewat Undangan'
   from public.akun ak join public.anggota a on a.id = ak.anggota_id where ak.id = tests.id('u_baru')));
select tests.harus_gagal('Server: token undangan asal-asalan ditolak',
  $q$ select public.layanan_pakai_undangan('tidak-ada', tests.id('tanpa_peran'), 'X') $q$);
select tests.periksa('Server: tautan atur ulang Andi berlaku',
  (select berlaku from public.layanan_cek_tautan_atur_ulang((select teks from tests.nilai where nama = 'reset_andi'))));
select tests.harus_berhasil('Server: memakai tautan atur ulang Andi',
  $q$ select tests.simpan('reset_andi_akun',
        public.layanan_pakai_tautan_atur_ulang((select teks from tests.nilai where nama = 'reset_andi'))::text) $q$);
select tests.periksa('Server: tautan atur ulang menunjuk ke akun Andi',
  (select teks from tests.nilai where nama = 'reset_andi_akun') = tests.id('u_andi')::text);
select tests.harus_gagal('Server: tautan atur ulang tidak bisa dipakai dua kali',
  $q$ select public.layanan_pakai_tautan_atur_ulang((select teks from tests.nilai where nama = 'reset_andi')) $q$);

-- Undangan kedaluwarsa
select tests.keluar();
update public.undangan set kedaluwarsa_pada = now() - interval '1 day'
 where token = (select teks from tests.nilai where nama = 'undangan_a2');
select tests.masuk_sebagai_layanan();
select tests.periksa('Server: undangan kedaluwarsa dinyatakan tidak berlaku',
  not (select berlaku from public.layanan_cek_undangan((select teks from tests.nilai where nama = 'undangan_a2'))));
select tests.harus_gagal('Server: undangan kedaluwarsa tidak bisa dipakai',
  $q$ select public.layanan_pakai_undangan((select teks from tests.nilai where nama = 'undangan_a2'), tests.id('tanpa_peran'), 'X') $q$);

-- Ani sekarang bisa login sebagai anggota
select tests.masuk_sebagai('u_ani');
select tests.periksa('Ani (akun baru): hanya melihat profilnya sendiri',
  (select count(*) from public.anggota) = 1 and (select id from public.anggota) = tests.id('ani'));

select tests.keluar();
select tests.periksa('Log: pemakaian undangan dan tautan atur ulang tercatat',
  (select count(*) from public.log_aktivitas where tindakan = 'pakai_undangan') = 2 and
  (select count(*) from public.log_aktivitas where tindakan = 'buat_tautan_atur_ulang') = 2 and
  (select count(*) from public.log_aktivitas where tindakan = 'pakai_tautan_atur_ulang') = 1);


-- =====================================================================
-- UJI FASE 3 · PROFIL ANGGOTA (perilaku yang diandalkan halaman profil)
-- =====================================================================

-- Cici (anggota, persetujuannya sudah tercatat di uji sebelumnya) mengisi profilnya sendiri.
select tests.masuk_sebagai('u_cici');
select tests.harus_berhasil('Cici: mengisi profil lengkap dengan wilayah bertingkat',
  $q$ update public.anggota set nama_lengkap = 'Cici Lestari', gender = 'perempuan', tempat_lahir = 'Bogor',
        tanggal_lahir = '1995-03-04', alamat = 'Jl. Kenanga 3', provinsi_kode = '32', kota_kode = '32.71',
        kecamatan_kode = '32.71.01', kelurahan_kode = '32.71.01.1001', status_nikah = 'single',
        pendidikan = 's1', pekerjaan = 'karyawan'
      where id = tests.id('cici') $q$);
select tests.harus_gagal('Cici: tidak bisa menghapus persetujuan yang sudah tercatat',
  $q$ update public.anggota set persetujuan_pada = null where id = tests.id('cici') $q$);
select tests.harus_gagal('Cici: wilayah yang tidak nyambung ditolak',
  $q$ update public.anggota set kecamatan_kode = '31.71.01' where id = tests.id('cici') $q$);
select tests.harus_berhasil('Cici: mengunggah foto ke foldernya sendiri',
  $q$ insert into storage.objects (bucket_id, name) values ('foto-anggota', tests.id('cici') || '/1.jpg') $q$);
select tests.harus_berhasil('Cici: memasang foto dari foldernya sendiri',
  $q$ update public.anggota set foto_path = tests.id('cici') || '/1.jpg' where id = tests.id('cici') $q$);
select tests.harus_gagal('Cici: tidak bisa memasang foto dari folder anggota lain',
  $q$ update public.anggota set foto_path = tests.id('andi') || '/foto.jpg' where id = tests.id('cici') $q$);
select tests.harus_berhasil('Cici: mengganti foto',
  $q$ update public.anggota set foto_path = tests.id('cici') || '/2.jpg' where id = tests.id('cici') $q$);
select tests.keluar();
select tests.periksa('Foto lama Cici masuk antrean hapus',
  exists (select 1 from internal.antrean_hapus_foto where foto_path = tests.id('cici') || '/1.jpg'));

-- Ketua Tim hanya membaca profil; Admin boleh mengubah (keputusan 12).
select tests.masuk_sebagai('ketua_a');
select tests.periksa('Ketua Tim A: membaca profil Cici',
  (select count(*) from public.anggota where id = tests.id('cici')) = 1);
select tests.periksa('Ketua Tim A: tidak bisa mengubah profil anggota A1',
  tests.baris_terkena($q$ update public.anggota set alamat = 'x' where id = tests.id('cici') $q$) = 0);
select tests.harus_gagal('Ketua Tim A: tidak bisa mengunggah foto anggota A1',
  $q$ insert into storage.objects (bucket_id, name) values ('foto-anggota', tests.id('cici') || '/k.jpg') $q$);
select tests.masuk_sebagai('admin');
select tests.periksa('Admin: bisa mengubah profil anggota A1 (keputusan 12)',
  tests.baris_terkena($q$ update public.anggota set alamat = 'x' where id = tests.id('cici') $q$) = 1);

-- Pemimpin menambah anggota tanpa HP, sekaligus mencatat persetujuan.
select tests.masuk_sebagai('sari');
select tests.harus_berhasil('Sari (wakil): menambah anggota dengan persetujuan dan profil',
  $q$ insert into public.anggota (id, kelompok_id, nama_lengkap, persetujuan_pada, gender, pekerjaan)
      values ('44444444-0000-0000-0000-0000000000c1', tests.id('kel_a1'), 'Oma Rut', now(), 'perempuan', 'pensiunan') $q$);
select tests.periksa('Sari: persetujuan Oma Rut tercatat oleh pemimpin',
  (select persetujuan_dicatat_oleh = 'pemimpin' and persetujuan_dicatat_akun = tests.id('sari')
     from public.anggota where id = '44444444-0000-0000-0000-0000000000c1'));
select tests.harus_berhasil('Sari: mengunggah foto Oma Rut (kamera pemimpin)',
  $q$ insert into storage.objects (bucket_id, name)
      values ('foto-anggota', '44444444-0000-0000-0000-0000000000c1/1.jpg') $q$);
select tests.keluar();


-- =====================================================================
-- UJI FASE 4 · MODE PERTEMUAN (tanggal, tutup absensi)
-- =====================================================================

-- Anggota A1 yang sudah lama tidak aktif (tidak boleh ikut ditandai tidak hadir).
select tests.keluar();
insert into public.anggota (id, kelompok_id, nama_lengkap, bergabung_pada, aktif, dinonaktifkan_pada)
values ('44444444-0000-0000-0000-0000000000d1', tests.id('kel_a1'), 'Pasif', bantu.hari_ini_wib() - 400,
        false, now() - interval '2 months');

select tests.masuk_sebagai('budi');
select tests.harus_gagal('Budi: pertemuan bertanggal besok ditolak',
  $q$ insert into public.pertemuan (kelompok_id, tanggal) values (tests.id('kel_a1'), bantu.hari_ini_wib() + 1) $q$);
select tests.harus_berhasil('Budi: mencatat pertemuan yang lalu (3 hari lalu)',
  $q$ insert into public.pertemuan (id, kelompok_id, tanggal, dibuka_pada)
      values ('55555555-0000-0000-0000-0000000000c1', tests.id('kel_a1'), bantu.hari_ini_wib() - 3, now()) $q$);
select tests.harus_gagal('Budi: tanggal pertemuan tidak bisa diubah ke masa depan',
  $q$ update public.pertemuan set tanggal = bantu.hari_ini_wib() + 2
      where id = '55555555-0000-0000-0000-0000000000c1' $q$);
select tests.harus_berhasil('Budi: menandai Andi hadir',
  $q$ insert into public.kehadiran (pertemuan_id, anggota_id, hadir)
      values ('55555555-0000-0000-0000-0000000000c1', tests.id('andi'), true) $q$);

select tests.masuk_sebagai('dewi');
select tests.harus_gagal('Dewi (pemimpin B1): tidak bisa menutup pertemuan A1',
  $q$ select public.tutup_pertemuan('55555555-0000-0000-0000-0000000000c1') $q$);
select tests.masuk_sebagai('ketua_a');
select tests.harus_gagal('Ketua Tim A: tidak bisa menutup pertemuan A1',
  $q$ select public.tutup_pertemuan('55555555-0000-0000-0000-0000000000c1') $q$);
select tests.masuk_sebagai('u_andi');
select tests.harus_gagal('Andi (anggota): tidak bisa menutup pertemuan',
  $q$ select public.tutup_pertemuan('55555555-0000-0000-0000-0000000000c1') $q$);

select tests.masuk_sebagai('budi');
select tests.harus_berhasil('Budi: menutup absensi',
  $q$ select tests.simpan('tutup_1', public.tutup_pertemuan('55555555-0000-0000-0000-0000000000c1')::text) $q$);
select tests.periksa('Tutup: waktu tutup tercatat',
  (select ditutup_pada is not null from public.pertemuan where id = '55555555-0000-0000-0000-0000000000c1'));
select tests.periksa('Tutup: Andi tetap hadir',
  (select hadir from public.kehadiran
    where pertemuan_id = '55555555-0000-0000-0000-0000000000c1' and anggota_id = tests.id('andi')));
select tests.periksa('Tutup: Jarang (aktif, bergabung 120 hari lalu, belum ditandai) tercatat tidak hadir',
  (select not hadir and alasan is null from public.kehadiran
    where pertemuan_id = '55555555-0000-0000-0000-0000000000c1' and anggota_id = tests.id('jarang')));
select tests.periksa('Tutup: Ani (bergabung hari ini) tidak ikut ditandai untuk pertemuan 3 hari lalu',
  not exists (select 1 from public.kehadiran where pertemuan_id = '55555555-0000-0000-0000-0000000000c1'
              and anggota_id = tests.id('ani')));
select tests.periksa('Tutup: anggota tidak aktif tidak ikut ditandai',
  not exists (select 1 from public.kehadiran where pertemuan_id = '55555555-0000-0000-0000-0000000000c1'
              and anggota_id = '44444444-0000-0000-0000-0000000000d1'));
select tests.periksa('Tutup: anggota yang bergabung setelah tanggal pertemuan tidak ikut ditandai',
  not exists (select 1 from public.kehadiran where pertemuan_id = '55555555-0000-0000-0000-0000000000c1'
              and anggota_id = '44444444-0000-0000-0000-0000000000c1'));
select tests.periksa('Tutup: hanya anggota kelompok A1 yang tercatat',
  (select bool_and(kelompok_id = tests.id('kel_a1')) from public.kehadiran
    where pertemuan_id = '55555555-0000-0000-0000-0000000000c1'));
select tests.periksa('Tutup: jumlah yang ditandai = jumlah baris tidak hadir',
  (select teks::int from tests.nilai where nama = 'tutup_1') =
  (select count(*) from public.kehadiran
    where pertemuan_id = '55555555-0000-0000-0000-0000000000c1' and not hadir));
select tests.harus_berhasil('Budi: mengisi alasan tidak hadir Jarang',
  $q$ update public.kehadiran set alasan = 'sakit', alasan_catatan = 'Demam'
      where pertemuan_id = '55555555-0000-0000-0000-0000000000c1' and anggota_id = tests.id('jarang') $q$);
select tests.harus_berhasil('Budi: membuka kembali absensi',
  $q$ update public.pertemuan set ditutup_pada = null where id = '55555555-0000-0000-0000-0000000000c1' $q$);
select tests.periksa('Tutup ulang: tidak ada data ganda, alasan Jarang tetap',
  public.tutup_pertemuan('55555555-0000-0000-0000-0000000000c1') = 0 and
  (select alasan = 'sakit' from public.kehadiran
    where pertemuan_id = '55555555-0000-0000-0000-0000000000c1' and anggota_id = tests.id('jarang')));
select tests.masuk_sebagai('ketua_a');
select tests.periksa('Ketua Tim A: membaca alasan tidak hadir A1',
  (select alasan = 'sakit' from public.kehadiran
    where pertemuan_id = '55555555-0000-0000-0000-0000000000c1' and anggota_id = tests.id('jarang')));
select tests.periksa('Ketua Tim A: tidak bisa mengubah kehadiran A1',
  tests.baris_terkena($q$ update public.kehadiran set alasan = 'lainnya'
    where pertemuan_id = '55555555-0000-0000-0000-0000000000c1' $q$) = 0);
select tests.keluar();


-- =====================================================================
-- UJI · ADMIN MENGELOLA SEMUA KELOMPOK (keputusan 12)
-- =====================================================================
select tests.masuk_sebagai('admin');
select tests.periksa('Admin: tidak otomatis tercatat sebagai pemimpin di peran_saya()',
  jsonb_array_length((public.peran_saya())::jsonb -> 'pemimpin') = 0);
select tests.harus_berhasil('Admin: menambah anggota di kelompok B1 (tanpa jadi pemimpin)',
  $q$ insert into public.anggota (id, kelompok_id, nama_lengkap, persetujuan_pada, gender)
      values ('44444444-0000-0000-0000-0000000000e1', tests.id('kel_b1'), 'Anggota Admin', now(), 'laki_laki') $q$);
select tests.periksa('Admin: persetujuan tercatat oleh pengurus (bukan anggota sendiri)',
  (select persetujuan_dicatat_oleh = 'pemimpin' from public.anggota
    where id = '44444444-0000-0000-0000-0000000000e1'));
select tests.harus_berhasil('Admin: mengunggah foto anggota B1',
  $q$ insert into storage.objects (bucket_id, name)
      values ('foto-anggota', '44444444-0000-0000-0000-0000000000e1/1.jpg') $q$);
select tests.harus_berhasil('Admin: membuat pertemuan B1 (5 hari lalu)',
  $q$ insert into public.pertemuan (id, kelompok_id, tanggal, dibuka_pada, persembahan)
      values ('55555555-0000-0000-0000-0000000000e1', tests.id('kel_b1'), bantu.hari_ini_wib() - 5, now(), 50000) $q$);
select tests.harus_berhasil('Admin: menandai Bima hadir',
  $q$ insert into public.kehadiran (pertemuan_id, anggota_id, hadir)
      values ('55555555-0000-0000-0000-0000000000e1', tests.id('bima'), true) $q$);
select tests.harus_berhasil('Admin: menutup absensi B1',
  $q$ select public.tutup_pertemuan('55555555-0000-0000-0000-0000000000e1') $q$);
select tests.harus_berhasil('Admin: mencatat anggota B1 tidak hadir',
  $q$ insert into public.kehadiran (pertemuan_id, anggota_id, hadir)
      values ('55555555-0000-0000-0000-0000000000e1', '44444444-0000-0000-0000-0000000000e1', false) $q$);
select tests.periksa('Admin: mengisi alasan tidak hadir di B1',
  tests.baris_terkena($q$ update public.kehadiran set alasan = 'bekerja'
      where pertemuan_id = '55555555-0000-0000-0000-0000000000e1' and not hadir $q$) >= 1);
select tests.harus_berhasil('Admin: membuat tautan undangan untuk B1',
  $q$ select * from public.buat_undangan(tests.id('kel_b1'), null) $q$);
select tests.harus_berhasil('Admin: menampilkan QR pertemuan B1',
  $q$ select * from public.token_qr_pertemuan(tests.id('rapat_b1')) $q$);
select tests.harus_berhasil('Admin: bisa menulis catatan khusus di kelompok mana pun (keputusan 18)',
  $q$ select public.tulis_catatan(tests.id('bima'), 'umum', 'x') $q$);
select tests.harus_berhasil('Admin: bisa mengoreksi (mengubah) catatan khusus (keputusan 15)',
  $q$ select public.ubah_catatan((select teks::uuid from tests.nilai where nama = 'catatan_bima'), 'diubah') $q$);
select tests.harus_berhasil('Admin: bisa menghapus catatan khusus yang salah (keputusan 15)',
  $q$ select public.hapus_catatan((select teks::uuid from tests.nilai where nama = 'catatan_bima')) $q$);
select tests.periksa('Admin: menghapus pertemuan B1 yang dibuatnya',
  tests.baris_terkena($q$ delete from public.pertemuan where id = '55555555-0000-0000-0000-0000000000e1' $q$) = 1);

-- Pemimpin tetap bisa menulis catatan; Ketua Tim tetap tidak bisa mengubah.
select tests.masuk_sebagai('dewi');
select tests.harus_berhasil('Dewi (pemimpin B1): tetap bisa menulis catatan',
  $q$ select public.tulis_catatan(tests.id('bima'), 'umum', 'Catatan Dewi') $q$);
select tests.periksa('Dewi: tetap tidak bisa mengubah anggota kelompok A1',
  tests.baris_terkena($q$ update public.anggota set alamat = 'y' where id = tests.id('ani') $q$) = 0);
select tests.masuk_sebagai('ketua_b');
select tests.periksa('Ketua Tim B: tetap tidak bisa mengubah anggota B1',
  tests.baris_terkena($q$ update public.anggota set alamat = 'y' where id = tests.id('bima') $q$) = 0);
select tests.harus_gagal('Ketua Tim B: tetap tidak bisa membuat pertemuan B1',
  $q$ insert into public.pertemuan (kelompok_id, tanggal) values (tests.id('kel_b1'), bantu.hari_ini_wib() - 6) $q$);
select tests.harus_gagal('Ketua Tim B: tetap tidak bisa menulis catatan',
  $q$ select public.tulis_catatan(tests.id('bima'), 'umum', 'x') $q$);
select tests.masuk_sebagai('u_bima');
select tests.harus_gagal('Bima (anggota): tidak bisa menulis catatan tentang dirinya',
  $q$ select public.tulis_catatan(tests.id('bima'), 'umum', 'x') $q$);
select tests.keluar();


-- =====================================================================
-- UJI · KOREKSI DATA (keputusan 13–15)
-- =====================================================================
-- Nama akun
select tests.masuk_sebagai('admin');
select tests.periksa('Admin: mengubah nama akun Budi',
  tests.baris_terkena($q$ update public.akun set nama_tampilan = 'Budi Santoso' where id = tests.id('budi') $q$) = 1);
select tests.masuk_sebagai('budi');
select tests.periksa('Budi: tidak bisa mengubah nama akun Sari',
  tests.baris_terkena($q$ update public.akun set nama_tampilan = 'X' where id = tests.id('sari') $q$) = 0);
select tests.masuk_sebagai('u_andi');
select tests.harus_gagal('Andi: tidak bisa memindahkan akunnya ke profil anggota lain',
  $q$ update public.akun set anggota_id = tests.id('ani') where id = tests.id('u_andi') $q$);

-- Nama tim/kelompok: khusus Admin
select tests.masuk_sebagai('budi');
select tests.periksa('Budi: tidak bisa mengganti nama kelompoknya',
  tests.baris_terkena($q$ update public.kelompok set nama = 'X' where id = tests.id('kel_a1') $q$) = 0);
select tests.masuk_sebagai('admin');
select tests.periksa('Admin: mengganti nama kelompok',
  tests.baris_terkena($q$ update public.kelompok set nama = 'Kelompok A1 Baru' where id = tests.id('kel_a1') $q$) = 1);
select tests.periksa('Admin: mengganti nama tim',
  tests.baris_terkena($q$ update public.tim set nama = 'Tim A Baru' where id = tests.id('tim_a') $q$) = 1);
select tests.harus_gagal('Admin: tim yang masih punya kelompok tidak bisa dihapus',
  $q$ delete from public.tim where id = tests.id('tim_b') $q$);

-- Anggota: pindah kelompok, nonaktifkan, tanggal pertemuan
select tests.masuk_sebagai('budi');
select tests.harus_gagal('Budi: tidak bisa memindahkan anggota ke kelompok yang tidak dipimpinnya',
  $q$ update public.anggota set kelompok_id = tests.id('kel_b1') where id = tests.id('ani') $q$);
select tests.periksa('Budi: menonaktifkan anggota secara manual',
  tests.baris_terkena($q$ update public.anggota set aktif = false where id = '44444444-0000-0000-0000-0000000000c1' $q$) = 1);
select tests.periksa('Budi: tanggal nonaktif terisi otomatis',
  (select dinonaktifkan_pada is not null from public.anggota where id = '44444444-0000-0000-0000-0000000000c1'));
select tests.periksa('Budi: mengubah tanggal pertemuan yang salah',
  tests.baris_terkena($q$ update public.pertemuan set tanggal = bantu.hari_ini_wib() - 10
    where id = '55555555-0000-0000-0000-0000000000c1' $q$) = 1);
select tests.masuk_sebagai('admin');
select tests.periksa('Admin: memindahkan anggota A1 ke kelompok B1',
  tests.baris_terkena($q$ update public.anggota set kelompok_id = tests.id('kel_b1')
    where id = '44444444-0000-0000-0000-0000000000c1' $q$) = 1);

-- Hapus kelompok beserta isinya
select tests.masuk_sebagai('ketua_a');
select tests.harus_gagal('Ketua Tim A (juga pemimpin A2): tidak bisa menghapus kelompok total',
  $q$ select public.hapus_kelompok_total(tests.id('kel_a2'), 'Kelompok A2') $q$);
select tests.masuk_sebagai('admin');
select tests.harus_gagal('Admin: hapus kelompok ditolak bila nama yang diketik salah',
  $q$ select public.hapus_kelompok_total(tests.id('kel_a2'), 'Kelompok A') $q$);
select tests.periksa('Admin: kelompok A2 masih utuh setelah konfirmasi salah',
  (select count(*) from public.kelompok where id = tests.id('kel_a2')) = 1);
select tests.harus_berhasil('Admin: menghapus kelompok A2 beserta isinya (nama diketik benar)',
  $q$ select tests.simpan('hapus_a2', public.hapus_kelompok_total(tests.id('kel_a2'), '  Kelompok A2 ')::text) $q$);
select tests.periksa('Hapus total: kelompok, anggota, dan peran pemimpinnya hilang',
  (select count(*) from public.kelompok where id = tests.id('kel_a2')) = 0 and
  (select count(*) from public.anggota where id = tests.id('asep')) = 0 and
  (select count(*) from public.penugasan_peran where kelompok_id = tests.id('kel_a2')) = 0);
select tests.periksa('Hapus total: hasil menyebut jumlah anggota yang terhapus',
  ((select teks from tests.nilai where nama = 'hapus_a2')::jsonb ->> 'anggota')::int >= 1);
select tests.periksa('Hapus total: kelompok lain tidak tersentuh',
  (select count(*) from public.anggota where kelompok_id = tests.id('kel_a1')) > 0);
select tests.keluar();
select tests.periksa('Hapus total: tercatat di log',
  exists (select 1 from public.log_aktivitas where tindakan = 'hapus_kelompok_total'));

-- Koreksi catatan (catatan Bima yang lama sudah dihapus Admin; pakai catatan Dewi)
select tests.keluar();
select tests.simpan('catatan_bima', (select id::text from public.catatan_khusus where anggota_id = tests.id('bima') limit 1));
select tests.masuk_sebagai('ketua_b');
select tests.harus_gagal('Ketua Tim B: tidak bisa mengubah catatan',
  $q$ select public.ubah_catatan((select teks::uuid from tests.nilai where nama = 'catatan_bima'), 'x') $q$);
select tests.masuk_sebagai('admin');
select tests.harus_gagal('Admin: isi catatan tidak boleh dikosongkan',
  $q$ select public.ubah_catatan((select teks::uuid from tests.nilai where nama = 'catatan_bima'), '   ') $q$);
select tests.keluar();


-- =====================================================================
-- UJI · BUKTI TRANSFER PERSEMBAHAN (keputusan 16)
-- =====================================================================
select tests.masuk_sebagai('budi');
select tests.harus_berhasil('Budi: mengunggah berkas bukti ke folder pertemuan A1',
  $q$ insert into storage.objects (bucket_id, name) values ('bukti-persembahan', tests.id('rapat_a1') || '/b1.jpg') $q$);
select tests.harus_berhasil('Budi: mencatat bukti pertemuan A1',
  $q$ insert into public.bukti_persembahan (pertemuan_id, lokasi, nama_berkas, jenis, ukuran)
      values (tests.id('rapat_a1'), tests.id('rapat_a1') || '/b1.jpg', 'struk.jpg', 'image/jpeg', 120000) $q$);
select tests.periksa('Bukti: kelompok terisi otomatis dari pertemuan',
  (select kelompok_id = tests.id('kel_a1') from public.bukti_persembahan where lokasi = tests.id('rapat_a1') || '/b1.jpg'));
select tests.harus_gagal('Budi: tidak bisa mencatat bukti yang berkasnya belum terunggah',
  $q$ insert into public.bukti_persembahan (pertemuan_id, lokasi, nama_berkas, jenis, ukuran)
      values (tests.id('rapat_a1'), tests.id('rapat_a1') || '/tidak-ada.jpg', 'x.jpg', 'image/jpeg', 100) $q$);
select tests.harus_gagal('Budi: tidak bisa mengunggah ke folder pertemuan B1',
  $q$ insert into storage.objects (bucket_id, name) values ('bukti-persembahan', tests.id('rapat_b1') || '/b.jpg') $q$);
select tests.harus_gagal('Budi: lokasi berkas harus di folder pertemuannya sendiri',
  $q$ insert into public.bukti_persembahan (pertemuan_id, lokasi, nama_berkas, jenis, ukuran)
      values (tests.id('rapat_a1'), tests.id('rapat_b1') || '/b.jpg', 'x.jpg', 'image/jpeg', 100) $q$);
select tests.harus_gagal('Budi: jenis berkas selain foto/PDF ditolak',
  $q$ insert into public.bukti_persembahan (pertemuan_id, lokasi, nama_berkas, jenis, ukuran)
      values (tests.id('rapat_a1'), tests.id('rapat_a1') || '/b1.jpg', 'x.exe', 'application/x-msdownload', 100) $q$);
select tests.harus_gagal('Budi: berkas di atas 5 MB ditolak',
  $q$ insert into public.bukti_persembahan (pertemuan_id, lokasi, nama_berkas, jenis, ukuran)
      values (tests.id('rapat_a1'), tests.id('rapat_a1') || '/b1.jpg', 'besar.pdf', 'application/pdf', 6000000) $q$);
select tests.harus_gagal('Budi: bukti tidak bisa diubah (hanya tambah/hapus)',
  $q$ update public.bukti_persembahan set nama_berkas = 'x' where pertemuan_id = tests.id('rapat_a1') $q$);

-- Batas 5 berkas per pertemuan
select tests.harus_berhasil('Budi: mengunggah 4 bukti lagi (total 5)',
  $q$ do $d$ begin
        for i in 2..5 loop
          insert into storage.objects (bucket_id, name) values ('bukti-persembahan', tests.id('rapat_a1') || '/b' || i || '.pdf');
          insert into public.bukti_persembahan (pertemuan_id, lokasi, nama_berkas, jenis, ukuran)
            values (tests.id('rapat_a1'), tests.id('rapat_a1') || '/b' || i || '.pdf', 'bukti.pdf', 'application/pdf', 300000);
        end loop;
      end $d$ $q$);
select tests.harus_gagal('Budi: bukti ke-6 ditolak',
  $q$ do $d$ begin
        insert into storage.objects (bucket_id, name) values ('bukti-persembahan', tests.id('rapat_a1') || '/b6.jpg');
        insert into public.bukti_persembahan (pertemuan_id, lokasi, nama_berkas, jenis, ukuran)
          values (tests.id('rapat_a1'), tests.id('rapat_a1') || '/b6.jpg', 'b6.jpg', 'image/jpeg', 100);
      end $d$ $q$);

-- Siapa yang melihat
select tests.masuk_sebagai('ketua_a');
select tests.periksa('Ketua Tim A: melihat 5 bukti pertemuan A1 beserta berkasnya',
  (select count(*) from public.bukti_persembahan where pertemuan_id = tests.id('rapat_a1')) = 5 and
  (select count(*) from storage.objects where bucket_id = 'bukti-persembahan' and name like tests.id('rapat_a1') || '/%') = 5);
select tests.periksa('Ketua Tim A: tidak bisa menghapus bukti',
  tests.baris_terkena($q$ delete from public.bukti_persembahan where pertemuan_id = tests.id('rapat_a1') $q$) = 0);
select tests.harus_gagal('Ketua Tim A: tidak bisa mengunggah bukti',
  $q$ insert into storage.objects (bucket_id, name) values ('bukti-persembahan', tests.id('rapat_a1') || '/k.jpg') $q$);
select tests.masuk_sebagai('dewi');
select tests.periksa('Dewi (pemimpin B1): tidak melihat bukti A1',
  (select count(*) from public.bukti_persembahan where pertemuan_id = tests.id('rapat_a1')) = 0 and
  (select count(*) from storage.objects where bucket_id = 'bukti-persembahan' and name like tests.id('rapat_a1') || '/%') = 0);
select tests.masuk_sebagai('u_andi');
select tests.periksa('Andi (anggota): tidak melihat bukti persembahan',
  (select count(*) from public.bukti_persembahan) = 0 and
  (select count(*) from storage.objects where bucket_id = 'bukti-persembahan') = 0);

-- Admin menghapus, dan ikut terhapus bersama pertemuan
select tests.masuk_sebagai('admin');
select tests.periksa('Admin: menghapus satu bukti A1',
  tests.baris_terkena($q$ delete from public.bukti_persembahan where lokasi = tests.id('rapat_a1') || '/b1.jpg' $q$) = 1);
select tests.harus_berhasil('Admin: menghapus pertemuan A1',
  $q$ select tests.simpan('hapus_rapat_a1', tests.baris_terkena('delete from public.pertemuan where id = ''' || tests.id('rapat_a1') || '''')::text) $q$);
select tests.periksa('Admin: pertemuan A1 terhapus (1 baris)',
  (select teks from tests.nilai where nama = 'hapus_rapat_a1') = '1',
  'baris terhapus: ' || coalesce((select teks from tests.nilai where nama = 'hapus_rapat_a1'), 'null'));
select tests.periksa('Admin: bukti A1 lainnya ikut terhapus',
  (select count(*) from public.bukti_persembahan where pertemuan_id = tests.id('rapat_a1')) = 0);
select tests.keluar();
select tests.periksa('Bukti yang terhapus masuk antrean hapus berkas (folder bukti-persembahan)',
  (select count(*) from internal.antrean_hapus_foto
    where bucket = 'bukti-persembahan' and foto_path like tests.id('rapat_a1') || '/%') = 5);
select tests.periksa('Antrean foto anggota lama tetap bertanda folder foto-anggota',
  (select bool_and(bucket = 'foto-anggota') from internal.antrean_hapus_foto where foto_path not like tests.id('rapat_a1') || '/%'));


-- =====================================================================
-- UJI FASE 5 · PROYEK KETAATAN DAN TINDAK LANJUT (keputusan 17)
-- Kelompok baru T1 (Tim A, pemimpin Budi) dengan riwayat yang pasti:
--   4 pertemuan ditutup (28, 21, 14, 7 hari lalu) + 1 pertemuan belum ditutup.
--   m1: tidak pernah hadir            -> absen 4 berturut-turut
--   m2: hadir 28 hari lalu, lalu absen -> absen 3 berturut-turut
--   m3: absen 14, hadir 7 hari lalu    -> tidak masuk daftar
--   m4: TIDAK AKTIF, tidak pernah hadir-> tidak masuk daftar
-- =====================================================================
select tests.keluar();
insert into tests.ids (nama, id) values
  ('kel_t1', '66666666-0000-0000-0000-0000000000f1'),
  ('m1', '66666666-0000-0000-0000-000000000001'), ('m2', '66666666-0000-0000-0000-000000000002'),
  ('m3', '66666666-0000-0000-0000-000000000003'), ('m4', '66666666-0000-0000-0000-000000000004'),
  ('t28', '66666666-0000-0000-0000-000000000028'), ('t21', '66666666-0000-0000-0000-000000000021'),
  ('t14', '66666666-0000-0000-0000-000000000014'), ('t07', '66666666-0000-0000-0000-000000000007'),
  ('t01', '66666666-0000-0000-0000-000000000099');
insert into public.kelompok (id, tim_id, nama) values (tests.id('kel_t1'), tests.id('tim_a'), 'Kelompok T1');
insert into public.penugasan_peran (akun_id, peran, kelompok_id, jabatan) values (tests.id('budi'), 'pemimpin', tests.id('kel_t1'), 'pemimpin');
insert into public.anggota (id, kelompok_id, nama_lengkap, bergabung_pada) values
  (tests.id('m1'), tests.id('kel_t1'), 'M Satu',  bantu.hari_ini_wib() - 60),
  (tests.id('m2'), tests.id('kel_t1'), 'M Dua',   bantu.hari_ini_wib() - 60),
  (tests.id('m3'), tests.id('kel_t1'), 'M Tiga',  bantu.hari_ini_wib() - 60),
  (tests.id('m4'), tests.id('kel_t1'), 'M Empat', bantu.hari_ini_wib() - 60);
update public.anggota set aktif = false where id = tests.id('m4');
insert into public.pertemuan (id, kelompok_id, tanggal, dibuka_pada, ditutup_pada) values
  (tests.id('t28'), tests.id('kel_t1'), bantu.hari_ini_wib() - 28, now(), now()),
  (tests.id('t21'), tests.id('kel_t1'), bantu.hari_ini_wib() - 21, now(), now()),
  (tests.id('t14'), tests.id('kel_t1'), bantu.hari_ini_wib() - 14, now(), now()),
  (tests.id('t07'), tests.id('kel_t1'), bantu.hari_ini_wib() - 7,  now(), now()),
  (tests.id('t01'), tests.id('kel_t1'), bantu.hari_ini_wib() - 1,  now(), null);
insert into public.kehadiran (pertemuan_id, anggota_id, hadir, alasan)
select p.id, m.id,
       (m.id = tests.id('m2') and p.id = tests.id('t28')) or (m.id = tests.id('m3') and p.id = tests.id('t07')),
       case when m.id = tests.id('m2') and p.id = tests.id('t07') then 'bekerja'::public.alasan_absen end
from public.pertemuan p cross join public.anggota m
where p.kelompok_id = tests.id('kel_t1') and p.ditutup_pada is not null and m.kelompok_id = tests.id('kel_t1');
-- m1 juga tidak hadir di pertemuan yang belum ditutup (tidak boleh dihitung)
insert into public.kehadiran (pertemuan_id, anggota_id, hadir) values (tests.id('t01'), tests.id('m1'), false);
-- m4 diaktifkan oleh trigger bila hadir; pastikan tetap tidak aktif
update public.anggota set aktif = false where id = tests.id('m4');

-- Proyek ketaatan (dibuat Budi lewat aturan akses)
select tests.masuk_sebagai('budi');
select tests.harus_berhasil('Budi: membuat proyek ketaatan yang tenggatnya sudah lewat',
  $q$ insert into public.proyek_ketaatan (id, kelompok_id, judul, diberikan_pada, tenggat)
      values ('66666666-0000-0000-0000-0000000000a1', tests.id('kel_t1'), 'Baca Yohanes', bantu.hari_ini_wib() - 30, bantu.hari_ini_wib() - 3) $q$);
select tests.harus_berhasil('Budi: membuat proyek yang tenggatnya belum lewat',
  $q$ insert into public.proyek_ketaatan (id, kelompok_id, judul, diberikan_pada, tenggat)
      values ('66666666-0000-0000-0000-0000000000a2', tests.id('kel_t1'), 'Doa pagi', bantu.hari_ini_wib() - 2, bantu.hari_ini_wib() + 7) $q$);
select tests.harus_gagal('Budi: tenggat sebelum tanggal diberikan ditolak',
  $q$ insert into public.proyek_ketaatan (kelompok_id, judul, diberikan_pada, tenggat)
      values (tests.id('kel_t1'), 'Salah', bantu.hari_ini_wib(), bantu.hari_ini_wib() - 1) $q$);
select tests.harus_berhasil('Budi: menandai status proyek anggotanya',
  $q$ insert into public.status_proyek (proyek_id, anggota_id, status) values
      ('66666666-0000-0000-0000-0000000000a1', tests.id('m1'), 'selesai'),
      ('66666666-0000-0000-0000-0000000000a1', tests.id('m2'), 'sedang'),
      ('66666666-0000-0000-0000-0000000000a2', tests.id('m1'), 'tidak_dikerjakan'),
      ('66666666-0000-0000-0000-0000000000a2', tests.id('m2'), 'belum') $q$);
select tests.periksa('Status proyek: kelompok terisi otomatis dari proyek',
  (select bool_and(kelompok_id = tests.id('kel_t1')) from public.status_proyek
    where proyek_id = '66666666-0000-0000-0000-0000000000a1'));
select tests.harus_gagal('Budi: tidak bisa memberi status proyek T1 kepada anggota kelompok lain',
  $q$ insert into public.status_proyek (proyek_id, anggota_id, status)
      values ('66666666-0000-0000-0000-0000000000a1', tests.id('andi'), 'belum') $q$);
select tests.periksa('Budi: mengubah status dan keterangan proyek',
  tests.baris_terkena($q$ update public.status_proyek set status = 'sedang', keterangan = 'Sudah pasal 3'
    where proyek_id = '66666666-0000-0000-0000-0000000000a1' and anggota_id = tests.id('m2') $q$) = 1);
select tests.periksa('Budi: mengubah judul dan tenggat proyek',
  tests.baris_terkena($q$ update public.proyek_ketaatan set judul = 'Baca Injil Yohanes'
    where id = '66666666-0000-0000-0000-0000000000a1' $q$) = 1);

select tests.masuk_sebagai('dewi');
select tests.periksa('Dewi: tidak melihat proyek T1',
  (select count(*) from public.proyek_ketaatan where kelompok_id = tests.id('kel_t1')) = 0);
select tests.periksa('Dewi: tidak bisa mengubah status proyek T1',
  tests.baris_terkena($q$ update public.status_proyek set status = 'selesai' where kelompok_id = tests.id('kel_t1') $q$) = 0);
select tests.masuk_sebagai('ketua_a');
select tests.periksa('Ketua Tim A: melihat proyek dan statusnya di T1',
  (select count(*) from public.proyek_ketaatan where kelompok_id = tests.id('kel_t1')) = 2 and
  (select count(*) from public.status_proyek where kelompok_id = tests.id('kel_t1')) = 4);
select tests.harus_gagal('Ketua Tim A: tidak bisa membuat proyek',
  $q$ insert into public.proyek_ketaatan (kelompok_id, judul) values (tests.id('kel_t1'), 'X') $q$);
select tests.masuk_sebagai('admin');
select tests.harus_berhasil('Admin: membuat dan menghapus proyek di T1',
  $q$ with p as (insert into public.proyek_ketaatan (kelompok_id, judul) values (tests.id('kel_t1'), 'Sementara') returning id)
      delete from public.proyek_ketaatan where id in (select id from p) $q$);

-- Tindak lanjut
select tests.masuk_sebagai('budi');
select tests.periksa('Tindak lanjut: M Satu absen 4 berturut-turut, belum pernah hadir',
  (select absen_beruntun = 4 and terakhir_hadir is null from public.tindak_lanjut(tests.id('kel_t1'))
    where jenis = 'absen' and anggota_id = tests.id('m1')));
select tests.periksa('Tindak lanjut: M Dua absen 3 berturut-turut, terakhir hadir 28 hari lalu, alasan terakhir bekerja',
  (select absen_beruntun = 3 and terakhir_hadir = bantu.hari_ini_wib() - 28 and alasan_terakhir = 'bekerja'
     from public.tindak_lanjut(tests.id('kel_t1')) where jenis = 'absen' and anggota_id = tests.id('m2')));
select tests.periksa('Tindak lanjut: M Tiga (hadir terakhir) dan M Empat (tidak aktif) tidak masuk daftar absen',
  (select count(*) from public.tindak_lanjut(tests.id('kel_t1'))
    where jenis = 'absen' and anggota_id in (tests.id('m3'), tests.id('m4'))) = 0);
select tests.periksa('Tindak lanjut: batas absen bisa diubah (batas 4 -> hanya M Satu)',
  (select count(*) from public.tindak_lanjut(tests.id('kel_t1'), 4) where jenis = 'absen') = 1);
select tests.periksa('Tindak lanjut proyek lewat tenggat: M Dua (sedang) dan M Tiga (belum diberi status), bukan M Satu (selesai)',
  (select array_agg(nama_lengkap order by nama_lengkap) from public.tindak_lanjut(tests.id('kel_t1'))
    where jenis = 'proyek' and proyek_id = '66666666-0000-0000-0000-0000000000a1') = array['M Dua', 'M Tiga']);
select tests.periksa('Tindak lanjut proyek belum lewat tenggat: hanya yang "tidak dikerjakan" (M Satu)',
  (select array_agg(nama_lengkap) from public.tindak_lanjut(tests.id('kel_t1'))
    where jenis = 'proyek' and proyek_id = '66666666-0000-0000-0000-0000000000a2') = array['M Satu']);
select tests.periksa('Tindak lanjut: total 5 baris (2 absen + 3 proyek)',
  (select count(*) from public.tindak_lanjut(tests.id('kel_t1'))) = 5);

select tests.masuk_sebagai('ketua_a');
select tests.harus_berhasil('Ketua Tim A: melihat tindak lanjut T1 (untuk dashboard Fase 6)',
  $q$ select * from public.tindak_lanjut(tests.id('kel_t1')) $q$);
select tests.masuk_sebagai('admin');
select tests.harus_berhasil('Admin: melihat tindak lanjut T1',
  $q$ select * from public.tindak_lanjut(tests.id('kel_t1')) $q$);
select tests.masuk_sebagai('dewi');
select tests.harus_gagal('Dewi (pemimpin B1): tidak bisa melihat tindak lanjut T1',
  $q$ select * from public.tindak_lanjut(tests.id('kel_t1')) $q$);
select tests.masuk_sebagai('ketua_b');
select tests.harus_gagal('Ketua Tim B: tidak bisa melihat tindak lanjut T1',
  $q$ select * from public.tindak_lanjut(tests.id('kel_t1')) $q$);
select tests.masuk_sebagai('u_andi');
select tests.harus_gagal('Andi (anggota): tidak bisa melihat tindak lanjut',
  $q$ select * from public.tindak_lanjut(tests.id('kel_a1')) $q$);
select tests.masuk_sebagai_tamu();
select tests.harus_gagal('Tamu: tidak bisa melihat tindak lanjut',
  $q$ select * from public.tindak_lanjut(tests.id('kel_t1')) $q$);

-- Menghapus proyek ikut menghapus statusnya
select tests.masuk_sebagai('budi');
select tests.periksa('Budi: menghapus proyek ikut menghapus status anggotanya',
  tests.baris_terkena($q$ delete from public.proyek_ketaatan where id = '66666666-0000-0000-0000-0000000000a2' $q$) = 1);
select tests.keluar();
select tests.periksa('Status proyek yang dihapus ikut hilang',
  (select count(*) from public.status_proyek where proyek_id = '66666666-0000-0000-0000-0000000000a2') = 0);


-- =====================================================================
-- RINGKASAN
-- =====================================================================
select no, case when lulus then 'LULUS' else 'GAGAL' end as hasil, nama, info
from tests.hasil order by no;

select count(*) filter (where lulus)     as lulus,
       count(*) filter (where not lulus) as gagal,
       count(*)                          as total
from tests.hasil;

rollback;
