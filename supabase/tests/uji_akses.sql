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
select tests.harus_berhasil('Sari (wakil): bisa membuat pertemuan A1 besok',
  $q$ insert into public.pertemuan (kelompok_id, tanggal) values (tests.id('kel_a1'), bantu.hari_ini_wib() + 1) $q$);
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
select tests.periksa('Admin: hanya membaca, tidak bisa mengubah profil anggota (0 baris)',
  tests.baris_terkena($q$ update public.anggota set alamat = 'x' where id = tests.id('bima') $q$) = 0);
select tests.harus_gagal('Admin: tidak bisa menulis catatan',
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
-- RINGKASAN
-- =====================================================================
select no, case when lulus then 'LULUS' else 'GAGAL' end as hasil, nama, info
from tests.hasil order by no;

select count(*) filter (where lulus)     as lulus,
       count(*) filter (where not lulus) as gagal,
       count(*)                          as total
from tests.hasil;

rollback;
