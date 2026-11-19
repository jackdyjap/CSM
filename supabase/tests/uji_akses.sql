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
  tests.baris_terkena($q$ update public.anggota set no_hp = '0812 9999 0001' where id = tests.id('asep') $q$) = 1);
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
-- UJI FASE 6 · RINGKASAN TIM (dashboard Ketua Tim, keputusan 20)
-- Empat kelompok baru di Tim A dengan tanggal relatif terhadap Senin pekan ini:
--   R1: pertemuan Senin ini DITUTUP (1 hadir, 1 tidak) + pertemuan 40 hari lalu -> sudah, 50%
--   R2: pertemuan Senin ini BELUM ditutup                                     -> berlangsung
--   R3: 3 pertemuan pekan-pekan lalu, satu anggota selalu absen               -> belum, tindak lanjut 1
--   R4: persembahan hari ini 100.000 dan bulan lalu 50.000                    -> bulan ini 100.000
-- =====================================================================
select tests.keluar();
create temporary table tgl as select
  date_trunc('week', bantu.hari_ini_wib())::date as senin,
  date_trunc('month', bantu.hari_ini_wib())::date as awal_bulan;
grant select on tgl to authenticated;
insert into tests.ids (nama, id) values
  ('kel_r1', '77777777-0000-0000-0000-0000000000a1'), ('kel_r2', '77777777-0000-0000-0000-0000000000a2'),
  ('kel_r3', '77777777-0000-0000-0000-0000000000a3'), ('kel_r4', '77777777-0000-0000-0000-0000000000a4'),
  ('r1a', '77777777-0000-0000-0000-0000000000b1'), ('r1b', '77777777-0000-0000-0000-0000000000b2'),
  ('r3a', '77777777-0000-0000-0000-0000000000b3');
insert into public.kelompok (id, tim_id, nama) values
  (tests.id('kel_r1'), tests.id('tim_a'), 'R1'), (tests.id('kel_r2'), tests.id('tim_a'), 'R2'),
  (tests.id('kel_r3'), tests.id('tim_a'), 'R3'), (tests.id('kel_r4'), tests.id('tim_a'), 'R4');
insert into public.anggota (id, kelompok_id, nama_lengkap, bergabung_pada) values
  (tests.id('r1a'), tests.id('kel_r1'), 'R1 A', bantu.hari_ini_wib() - 100),
  (tests.id('r1b'), tests.id('kel_r1'), 'R1 B', bantu.hari_ini_wib() - 100),
  (tests.id('r3a'), tests.id('kel_r3'), 'R3 A', bantu.hari_ini_wib() - 100);
-- R1
insert into public.pertemuan (id, kelompok_id, tanggal, dibuka_pada, ditutup_pada) values
  ('77777777-0000-0000-0000-0000000000c1', tests.id('kel_r1'), (select senin from tgl), now(), now()),
  ('77777777-0000-0000-0000-0000000000c2', tests.id('kel_r1'), (select senin from tgl) - 40, now(), now());
insert into public.kehadiran (pertemuan_id, anggota_id, hadir) values
  ('77777777-0000-0000-0000-0000000000c1', tests.id('r1a'), true),
  ('77777777-0000-0000-0000-0000000000c1', tests.id('r1b'), false),
  ('77777777-0000-0000-0000-0000000000c2', tests.id('r1a'), true),
  ('77777777-0000-0000-0000-0000000000c2', tests.id('r1b'), true);
-- R2
insert into public.pertemuan (kelompok_id, tanggal, dibuka_pada) values (tests.id('kel_r2'), (select senin from tgl), now());
-- R3
insert into public.pertemuan (id, kelompok_id, tanggal, dibuka_pada, ditutup_pada) values
  ('77777777-0000-0000-0000-0000000000d1', tests.id('kel_r3'), (select senin from tgl) - 1,  now(), now()),
  ('77777777-0000-0000-0000-0000000000d2', tests.id('kel_r3'), (select senin from tgl) - 8,  now(), now()),
  ('77777777-0000-0000-0000-0000000000d3', tests.id('kel_r3'), (select senin from tgl) - 15, now(), now());
insert into public.kehadiran (pertemuan_id, anggota_id, hadir)
select id, tests.id('r3a'), false from public.pertemuan where kelompok_id = tests.id('kel_r3');
-- R4
insert into public.pertemuan (kelompok_id, tanggal, dibuka_pada, ditutup_pada, persembahan) values
  (tests.id('kel_r4'), bantu.hari_ini_wib(), now(), now(), 100000),
  (tests.id('kel_r4'), (select awal_bulan from tgl) - 1, now(), now(), 50000);

select tests.masuk_sebagai('ketua_a');
select tests.harus_berhasil('Ketua Tim A: membuka ringkasan Tim A',
  $q$ create temporary table rk as select * from public.ringkasan_tim(tests.id('tim_a')) $q$);
select tests.periksa('Ringkasan: hanya kelompok Tim A',
  (select count(*) from rk where kelompok_id in (tests.id('kel_r1'), tests.id('kel_r2'), tests.id('kel_r3'), tests.id('kel_r4'))) = 4 and
  (select count(*) from rk where kelompok_id = tests.id('kel_b1')) = 0);
select tests.periksa('R1: sudah lapor, 2 anggota aktif, pertemuan terakhir Senin ini',
  (select status_lapor = 'sudah' and anggota_aktif = 2 and pertemuan_terakhir = (select senin from tgl)
     from rk where kelompok_id = tests.id('kel_r1')));
select tests.periksa('R1: kehadiran 4 pekan 50% (pertemuan 40 hari lalu tidak dihitung)',
  (select hadir_4_pekan = 50 from rk where kelompok_id = tests.id('kel_r1')));
select tests.periksa('R2: pertemuan pekan ini belum ditutup -> sedang berlangsung, tanpa angka kehadiran',
  (select status_lapor = 'berlangsung' and hadir_4_pekan is null from rk where kelompok_id = tests.id('kel_r2')));
select tests.periksa('R3: belum lapor pekan ini, kehadiran 0%, 1 anggota perlu ditindaklanjuti',
  (select status_lapor = 'belum' and hadir_4_pekan = 0 and tindak_lanjut = 1 from rk where kelompok_id = tests.id('kel_r3')));
select tests.periksa('R4: persembahan bulan ini 100.000 (bulan lalu tidak dihitung)',
  (select persembahan_bulan_ini = 100000 from rk where kelompok_id = tests.id('kel_r4')));
select tests.periksa('R2: kelompok tanpa persembahan bernilai 0, bukan kosong',
  (select persembahan_bulan_ini = 0 from rk where kelompok_id = tests.id('kel_r2')));

select tests.harus_gagal('Ketua Tim A: tidak bisa membuka ringkasan Tim B',
  $q$ select * from public.ringkasan_tim(tests.id('tim_b')) $q$);
select tests.masuk_sebagai('admin');
select tests.periksa('Admin: membuka ringkasan Tim A dan Tim B',
  (select count(*) from public.ringkasan_tim(tests.id('tim_a'))) >= 4 and
  (select count(*) from public.ringkasan_tim(tests.id('tim_b'))) >= 1);
select tests.masuk_sebagai('budi');
select tests.harus_gagal('Budi (pemimpin A1): tidak bisa membuka ringkasan Tim A',
  $q$ select * from public.ringkasan_tim(tests.id('tim_a')) $q$);
select tests.masuk_sebagai('u_andi');
select tests.harus_gagal('Andi (anggota): tidak bisa membuka ringkasan tim',
  $q$ select * from public.ringkasan_tim(tests.id('tim_a')) $q$);
select tests.masuk_sebagai_tamu();
select tests.harus_gagal('Tamu: tidak bisa membuka ringkasan tim',
  $q$ select * from public.ringkasan_tim(tests.id('tim_a')) $q$);
select tests.keluar();


-- =====================================================================
-- UJI FASE 7 · QR KARTU ANGGOTA (keputusan 22)
-- Memakai Kelompok T1 (pemimpin Budi): t01 = pertemuan kemarin yang BELUM
-- ditutup, t07 = pertemuan 7 hari lalu yang sudah ditutup.
-- =====================================================================
select tests.keluar();
select tests.simpan('kartu_m3_lama', (select kode_qr from public.anggota where id = tests.id('m3')));

select tests.masuk_sebagai('budi');
select tests.periksa('Budi: scan kartu M Tiga di pertemuan yang masih terbuka -> hadir',
  (select not sudah_tercatat and nama_lengkap = 'M Tiga'
     from public.scan_kartu_anggota(tests.id('t01'), (select teks from tests.nilai where nama = 'kartu_m3_lama'))));
select tests.periksa('Kehadiran M Tiga tercatat dengan cara scan pemimpin',
  (select hadir and cara = 'scan_pemimpin' from public.kehadiran
    where pertemuan_id = tests.id('t01') and anggota_id = tests.id('m3')));
select tests.periksa('Budi: scan kartu yang sama lagi -> sudah tercatat (tidak ganda)',
  (select sudah_tercatat from public.scan_kartu_anggota(tests.id('t01'),
     upper(' ' || (select teks from tests.nilai where nama = 'kartu_m3_lama') || ' '))));
select tests.harus_gagal('Budi: scan kartu di pertemuan yang absensinya sudah ditutup ditolak',
  $q$ select * from public.scan_kartu_anggota(tests.id('t07'), (select teks from tests.nilai where nama = 'kartu_m3_lama')) $q$);

-- Buat ulang kode kartu
select tests.masuk_sebagai('dewi');
select tests.harus_gagal('Dewi (pemimpin B1): tidak bisa membuat ulang kartu anggota T1',
  $q$ select public.buat_ulang_kode_kartu(tests.id('m3')) $q$);
select tests.masuk_sebagai('ketua_a');
select tests.harus_gagal('Ketua Tim A: tidak bisa membuat ulang kartu',
  $q$ select public.buat_ulang_kode_kartu(tests.id('m3')) $q$);
select tests.masuk_sebagai('u_andi');
select tests.harus_gagal('Andi (anggota): tidak bisa membuat ulang kartunya sendiri',
  $q$ select public.buat_ulang_kode_kartu(tests.id('andi')) $q$);
select tests.masuk_sebagai('budi');
select tests.harus_berhasil('Budi: membuat ulang kartu M Tiga (kartu hilang)',
  $q$ select public.buat_ulang_kode_kartu(tests.id('m3')) $q$);
select tests.keluar();
select tests.periksa('Kode kartu M Tiga berganti',
  (select kode_qr <> (select teks from tests.nilai where nama = 'kartu_m3_lama') and length(kode_qr) = 32
     from public.anggota where id = tests.id('m3')));
update public.kehadiran set hadir = false, cara = null where pertemuan_id = tests.id('t01') and anggota_id = tests.id('m3');
select tests.masuk_sebagai('budi');
select tests.harus_gagal('Kartu lama M Tiga ditolak setelah dibuat ulang',
  $q$ select * from public.scan_kartu_anggota(tests.id('t01'), (select teks from tests.nilai where nama = 'kartu_m3_lama')) $q$);
select tests.periksa('Kartu baru M Tiga diterima',
  (select not sudah_tercatat from public.scan_kartu_anggota(tests.id('t01'),
     (select kode_qr from public.anggota where id = tests.id('m3')))));
select tests.masuk_sebagai('admin');
select tests.harus_berhasil('Admin: membuat ulang kartu anggota kelompok mana pun',
  $q$ select public.buat_ulang_kode_kartu(tests.id('bima')) $q$);
select tests.keluar();
select tests.periksa('Pembuatan ulang kartu tercatat di log',
  (select count(*) from public.log_aktivitas where tindakan = 'buat_ulang_kode_kartu') = 2);


-- =====================================================================
-- UJI FASE 8 · CHECK-IN MANDIRI DENGAN QR PERTEMUAN (keputusan 23)
-- Pertemuan A1 HARI INI yang baru (rapat lama A1 sudah dihapus di uji bukti).
-- =====================================================================
select tests.keluar();
insert into tests.ids (nama, id) values ('rapat_ci', '88888888-0000-0000-0000-0000000000a1');
insert into public.pertemuan (id, kelompok_id, tanggal, dibuka_pada) values (tests.id('rapat_ci'), tests.id('kel_a1'), bantu.hari_ini_wib(), now());
-- Kode jendela sebelumnya (masih diterima) dan dua jendela lalu (harus ditolak: QR difoto lalu dipakai belakangan).
select tests.simpan('kode_ci_sebelum',
  internal.kode_qr_pertemuan(tests.id('rapat_ci'), (select rahasia from internal.pertemuan_rahasia where pertemuan_id = tests.id('rapat_ci')), internal.jendela_qr() - 1));
select tests.simpan('kode_ci_foto_lama',
  internal.kode_qr_pertemuan(tests.id('rapat_ci'), (select rahasia from internal.pertemuan_rahasia where pertemuan_id = tests.id('rapat_ci')), internal.jendela_qr() - 2));
-- Kode yang SAH untuk pertemuan A1 KEMARIN (dibuat Sari di Uji 2; tidak boleh diterima).
select tests.simpan('kode_kemarin',
  (select internal.kode_qr_pertemuan(p.id, s.rahasia, internal.jendela_qr())
     from public.pertemuan p join internal.pertemuan_rahasia s on s.pertemuan_id = p.id
    where p.kelompok_id = tests.id('kel_a1') and p.tanggal = bantu.hari_ini_wib() - 1));
update public.kehadiran set hadir = false, cara = null
 where anggota_id in (tests.id('andi'), tests.id('cici')) and pertemuan_id = tests.id('rapat_ci');

select tests.masuk_sebagai('budi');
select tests.harus_berhasil('Budi: menampilkan QR pertemuan A1 hari ini',
  $q$ select tests.simpan('kode_ci', (select kode from public.token_qr_pertemuan(tests.id('rapat_ci')))) $q$);
select tests.periksa('QR pertemuan: kode 20 karakter dan sisa waktu 1–45 detik',
  (select length(kode) = 20 and sisa_detik between 1 and 45 from public.token_qr_pertemuan(tests.id('rapat_ci'))));
select tests.harus_gagal('Budi: QR untuk pertemuan kemarin tidak bisa ditampilkan',
  $q$ select * from public.token_qr_pertemuan((select id from public.pertemuan
        where kelompok_id = tests.id('kel_a1') and tanggal = bantu.hari_ini_wib() - 1)) $q$);

select tests.masuk_sebagai('u_cici');
select tests.harus_gagal('Cici: QR yang difoto dan dipakai lebih dari 2 jendela kemudian ditolak',
  $q$ select * from public.check_in((select teks from tests.nilai where nama = 'kode_ci_foto_lama')) $q$);
select tests.harus_gagal('Cici: kode sah untuk pertemuan KEMARIN ditolak',
  $q$ select * from public.check_in((select teks from tests.nilai where nama = 'kode_kemarin')) $q$);
select tests.periksa('Cici: kode jendela sebelumnya masih diterima (jeda koneksi lambat)',
  (select kelompok_nama is not null from public.check_in(upper((select teks from tests.nilai where nama = 'kode_ci_sebelum')))));
select tests.keluar();
select tests.periksa('Kehadiran Cici tercatat "scan sendiri" oleh akunnya sendiri',
  (select hadir and cara = 'scan_sendiri' and dicatat_oleh = tests.id('u_cici') from public.kehadiran
    where pertemuan_id = tests.id('rapat_ci') and anggota_id = tests.id('cici')));

select tests.masuk_sebagai('budi');
select tests.harus_berhasil('Budi: menutup absensi pertemuan hari ini',
  $q$ select public.tutup_pertemuan(tests.id('rapat_ci')) $q$);
select tests.masuk_sebagai('u_andi');
select tests.harus_gagal('Andi: check-in setelah absensi ditutup ditolak',
  $q$ select * from public.check_in((select teks from tests.nilai where nama = 'kode_ci')) $q$);
select tests.masuk_sebagai('budi');
select tests.harus_gagal('Budi: QR tidak bisa ditampilkan setelah absensi ditutup',
  $q$ select * from public.token_qr_pertemuan(tests.id('rapat_ci')) $q$);
select tests.masuk_sebagai('sari');
select tests.harus_gagal('Sari (wakil, bukan anggota): tidak bisa check-in',
  $q$ select * from public.check_in((select teks from tests.nilai where nama = 'kode_ci')) $q$);
select tests.keluar();


-- =====================================================================
-- UJI FASE 9 · LAPORAN DEMOGRAFI (keputusan 24)
-- Angka laporan harus sama dengan jumlah anggota sebenarnya.
-- =====================================================================
select tests.keluar();
select tests.simpan('n_aktif_semua', (select count(*)::text from public.anggota where aktif));
select tests.simpan('n_semua',       (select count(*)::text from public.anggota));
select tests.simpan('n_aktif_tim_a', (select count(*)::text from public.anggota a join public.kelompok k on k.id = a.kelompok_id
                                       where a.aktif and k.tim_id = tests.id('tim_a')));
select tests.simpan('n_aktif_t1',    (select count(*)::text from public.anggota where aktif and kelompok_id = tests.id('kel_t1')));

select tests.masuk_sebagai('admin');
select tests.periksa('Laporan semua tim: jumlah = anggota aktif sebenarnya (tiap dimensi)',
  (select bool_and(n = (select teks::bigint from tests.nilai where nama = 'n_aktif_semua'))
     from (select d, (select sum(jumlah) from public.laporan_demografi(d)) as n
             from unnest(array['gender','rentang_usia','pendidikan','status_nikah','pekerjaan','provinsi','kota','kecamatan','kelurahan']) as d) x));
select tests.periksa('Laporan termasuk anggota tidak aktif: jumlah = semua anggota',
  (select sum(jumlah) from public.laporan_demografi('gender', 'semua', null, false))
   = (select teks::bigint from tests.nilai where nama = 'n_semua'));
select tests.periksa('Laporan satu tim: jumlah = anggota aktif Tim A, dan hanya kelompok Tim A',
  (select sum(jumlah) from public.laporan_demografi('pekerjaan', 'tim', tests.id('tim_a')))
   = (select teks::bigint from tests.nilai where nama = 'n_aktif_tim_a') and
  not exists (select 1 from public.laporan_demografi('pekerjaan', 'tim', tests.id('tim_a')) where tim_nama <> 'Tim A Baru'));
select tests.periksa('Laporan satu kelompok: hanya kelompok itu, jumlah benar',
  (select count(distinct kelompok_id) = 1 and sum(jumlah) = (select teks::bigint from tests.nilai where nama = 'n_aktif_t1')
     from public.laporan_demografi('status_nikah', 'kelompok', tests.id('kel_t1'))));
select tests.periksa('Persen per kelompok berjumlah sekitar 100 (yang sudah mengisi)',
  (select bool_and(abs(t - 100) <= 0.5) from (
     select kelompok_id, sum(persen) as t from public.laporan_demografi('gender')
      where kunci is not null group by kelompok_id) x));
select tests.periksa('Baris "Belum diisi" tanpa persen',
  (select bool_and(persen is null and label = 'Belum diisi') from public.laporan_demografi('pendidikan') where kunci is null));
select tests.harus_gagal('Cakupan tim tanpa id ditolak',
  $q$ select * from public.laporan_demografi('gender', 'tim', null) $q$);
select tests.harus_berhasil('Admin: mencatat ekspor PDF',
  $q$ select public.catat_ekspor_laporan('pdf', '{"dimensi":"gender"}') $q$);
select tests.harus_gagal('Format ekspor tidak dikenal ditolak',
  $q$ select public.catat_ekspor_laporan('docx') $q$);

select tests.masuk_sebagai('ketua_a');
select tests.harus_gagal('Ketua Tim A: tidak bisa membuka laporan demografi timnya',
  $q$ select * from public.laporan_demografi('gender', 'tim', tests.id('tim_a')) $q$);
select tests.harus_gagal('Ketua Tim A: tidak bisa mencatat ekspor laporan',
  $q$ select public.catat_ekspor_laporan('xlsx') $q$);
select tests.masuk_sebagai('budi');
select tests.harus_gagal('Budi (pemimpin): tidak bisa membuka laporan kelompoknya',
  $q$ select * from public.laporan_demografi('gender', 'kelompok', tests.id('kel_a1')) $q$);
select tests.keluar();
select tests.periksa('Ekspor PDF tercatat di log',
  exists (select 1 from public.log_aktivitas where tindakan = 'ekspor_laporan' and detail ->> 'format' = 'pdf'));


-- =====================================================================
-- UJI LOGIN FLEKSIBEL · NAMA PENGGUNA, EMAIL, ATAU NOMOR HP (keputusan 25)
-- =====================================================================
select tests.keluar();
select tests.periksa('Nomor HP dirapikan: 0812-3456-7890, +62 812 3456 7890, 812 3456 7890 -> 6281234567890',
  internal.normal_hp('0812-3456-7890') = '6281234567890' and internal.normal_hp('+62 812 3456 7890') = '6281234567890'
  and internal.normal_hp('812 3456 7890') = '6281234567890');
select tests.periksa('Nomor HP tidak sah dikenali (telepon rumah, huruf, terlalu pendek)',
  internal.normal_hp('021555123') is null and internal.normal_hp('abc') is null and internal.normal_hp('0812') is null);

insert into tests.ids values
  ('u_rina', '33333333-0000-0000-0000-00000000000d'),
  ('sari_p', '44444444-0000-0000-0000-00000000aa01'),
  ('tono',   '44444444-0000-0000-0000-00000000aa02');
-- Tono: profil di T1 dengan nomor HP, belum punya akun.
insert into public.anggota (id, kelompok_id, nama_lengkap, persetujuan_pada, no_hp)
values (tests.id('tono'), tests.id('kel_t1'), 'Tono', now(), '0812-7777-0001');
select tests.periksa('Nomor HP profil disimpan dalam bentuk baku 628..',
  (select no_hp = '6281277770001' from public.anggota where id = tests.id('tono')));
insert into auth.users (id, email, raw_user_meta_data) values
  (tests.id('u_rina'), 'rina@contoh.test',
   '{"nama":"Rina","nama_pengguna":"Rina.K","email":"Rina@Contoh.test","nomor_hp":"0812-3333-0001"}');
select tests.periksa('Akun baru: nama pengguna, email, nomor HP tersimpan rapi (huruf kecil, 628..) dan ringkasannya benar',
  (select nama_pengguna = 'rina.k' and email = 'rina@contoh.test' and nomor_hp = '6281233330001'
          and login = 'rina.k · rina@contoh.test · 081233330001' from public.akun where id = tests.id('u_rina')));
select tests.harus_gagal('Akun baru dengan nama pengguna yang sama (huruf besar) ditolak',
  $q$ insert into auth.users (email, raw_user_meta_data) values ('x1@contoh.test', '{"nama_pengguna":"RINA.K"}') $q$);
select tests.harus_gagal('Akun baru dengan email yang sama (huruf besar) ditolak',
  $q$ insert into auth.users (email, raw_user_meta_data) values ('x2@contoh.test', '{"email":"RINA@contoh.test"}') $q$);
select tests.harus_gagal('Akun baru dengan nomor HP yang sama (format lain) ditolak',
  $q$ insert into auth.users (email, raw_user_meta_data) values ('x3@contoh.test', '{"nomor_hp":"+62 812 3333 0001"}') $q$);
select tests.harus_gagal('Akun baru dengan nomor HP milik profil anggota lain (Tono) ditolak',
  $q$ insert into auth.users (email, raw_user_meta_data) values ('x4@contoh.test', '{"nomor_hp":"081277770001"}') $q$);

-- Server: mencari alamat login dan memeriksa isian pendaftaran
select tests.masuk_sebagai_layanan();
select tests.periksa('Server: masuk dengan nama pengguna (huruf besar pun) menemukan akun Rina',
  public.layanan_cari_login(' RINA.K ') = 'rina@contoh.test');
select tests.periksa('Server: masuk dengan email menemukan akun Rina',
  public.layanan_cari_login('Rina@Contoh.Test') = 'rina@contoh.test');
select tests.periksa('Server: masuk dengan nomor HP (0812.., +62.., 812..) menemukan akun Rina',
  public.layanan_cari_login('081233330001') = 'rina@contoh.test'
  and public.layanan_cari_login('+62 812-3333-0001') = 'rina@contoh.test'
  and public.layanan_cari_login('81233330001') = 'rina@contoh.test');
select tests.periksa('Server: isian yang tidak terdaftar atau kosong -> tidak ditemukan',
  public.layanan_cari_login('tidakada') is null and public.layanan_cari_login('') is null
  and public.layanan_cari_login('089999999999') is null);
select tests.periksa('Server: cek pendaftaran mengembalikan isian yang sudah dirapikan',
  (select nama_pengguna = 'rina_baru' and email = 'rb@contoh.test' and nomor_hp = '6281233330009'
   from public.layanan_cek_login_baru('Rina_Baru', 'RB@contoh.test', '0812 3333 0009')));
select tests.harus_gagal('Server: cek pendaftaran menolak nama pengguna yang sudah dipakai',
  $q$ select * from public.layanan_cek_login_baru('rina.k', null, null) $q$);
select tests.harus_gagal('Server: cek pendaftaran menolak nama pengguna diawali angka',
  $q$ select * from public.layanan_cek_login_baru('1rina', null, null) $q$);
select tests.harus_gagal('Server: cek pendaftaran menolak nama pengguna berspasi',
  $q$ select * from public.layanan_cek_login_baru('rina k', null, null) $q$);
select tests.harus_gagal('Server: cek pendaftaran menolak nama pengguna 2 huruf',
  $q$ select * from public.layanan_cek_login_baru('ri', null, null) $q$);
select tests.harus_gagal('Server: cek pendaftaran menolak isian kosong semua',
  $q$ select * from public.layanan_cek_login_baru('', ' ', null) $q$);
select tests.harus_gagal('Server: cek pendaftaran menolak alamat .invalid',
  $q$ select * from public.layanan_cek_login_baru(null, '6281@hp.invalid', null) $q$);
select tests.harus_gagal('Server: cek pendaftaran menolak nomor HP profil Tono (anggota baru)',
  $q$ select * from public.layanan_cek_login_baru(null, null, '081277770001') $q$);
select tests.harus_berhasil('Server: nomor HP profil Tono boleh dipakai bila mendaftar untuk profil Tono',
  $q$ select * from public.layanan_cek_login_baru(null, null, '081277770001', tests.id('tono')) $q$);

select tests.masuk_sebagai_tamu();
select tests.harus_gagal('Tamu: tidak bisa mencari alamat login',
  $q$ select public.layanan_cari_login('rina.k') $q$);
select tests.harus_gagal('Tamu: tidak bisa mengubah cara masuk',
  $q$ select public.ubah_login(tests.id('u_rina'), 'x', null, null) $q$);

-- Mengubah cara masuk sendiri
select tests.masuk_sebagai('u_rina');
select tests.harus_gagal('Rina: tidak bisa memanggil loket pencarian login (khusus server)',
  $q$ select public.layanan_cari_login('budi@contoh.test') $q$);
select tests.harus_berhasil('Rina: mengganti nama pengguna sendiri',
  $q$ select public.ubah_login(tests.id('u_rina'), 'rina2', 'rina@contoh.test', '081233330001') $q$);
select tests.periksa('Rina: membaca data loginnya sendiri (nomor HP tampil 08..)',
  (select nama_pengguna = 'rina2' and nomor_hp = '081233330001' from public.data_login(tests.id('u_rina'))));
select tests.harus_gagal('Rina: tidak bisa mengosongkan semua cara masuk',
  $q$ select public.ubah_login(tests.id('u_rina'), '', '', '') $q$);
select tests.harus_gagal('Rina: tidak bisa memakai email akun Budi',
  $q$ select public.ubah_login(tests.id('u_rina'), 'rina2', 'budi@contoh.test', null) $q$);
select tests.harus_gagal('Rina: tidak bisa memakai nomor HP yang tidak sah',
  $q$ select public.ubah_login(tests.id('u_rina'), 'rina2', null, '12345') $q$);
select tests.harus_gagal('Rina: tidak bisa mengubah cara masuk akun Budi',
  $q$ select public.ubah_login(tests.id('budi'), 'budi_palsu', null, null) $q$);
select tests.harus_gagal('Rina: tidak bisa membaca data login Budi',
  $q$ select * from public.data_login(tests.id('budi')) $q$);
select tests.harus_gagal('Rina: tidak bisa mengubah kolom email akun langsung',
  $q$ update public.akun set email = 'x@contoh.test' where id = tests.id('u_rina') $q$);

select tests.masuk_sebagai_layanan();
select tests.periksa('Server: nama pengguna lama Rina tidak berlaku lagi, yang baru berlaku',
  public.layanan_cari_login('rina.k') is null and public.layanan_cari_login('rina2') = 'rina@contoh.test');

-- Admin mengubah cara masuk akun lain
select tests.masuk_sebagai('admin');
select tests.harus_berhasil('Admin: memberi nama pengguna untuk akun Budi',
  $q$ select public.ubah_login(tests.id('budi'), 'Budi', 'budi@contoh.test', null) $q$);
select tests.periksa('Admin: membaca data login Budi',
  (select nama_pengguna = 'budi' from public.data_login(tests.id('budi'))));
select tests.harus_berhasil('Admin: akun Bima hanya memakai nomor HP',
  $q$ select public.ubah_login(tests.id('u_bima'), null, null, '081255550001') $q$);
select tests.periksa('Nomor HP login Bima ikut tersimpan di profil Bima',
  (select no_hp = '6281255550001' from public.anggota where id = tests.id('bima')));

-- Nomor HP login = nomor HP profil (disamakan)
select tests.masuk_sebagai('u_andi');
select tests.harus_berhasil('Andi: mengisi nama pengguna dan nomor HP login sendiri',
  $q$ select public.ubah_login(tests.id('u_andi'), 'andi', 'u_andi@contoh.test', '0812 4444 0001') $q$);
select tests.periksa('Nomor HP login Andi ikut tersimpan di profil Andi',
  (select no_hp = '6281244440001' from public.anggota where id = tests.id('andi')));

select tests.masuk_sebagai('budi');
select tests.periksa('Budi: mengubah nomor HP di profil Andi (1 baris)',
  tests.baris_terkena($q$ update public.anggota set no_hp = '081244440002' where id = tests.id('andi') $q$) = 1);
select tests.harus_gagal('Budi: nomor HP profil yang sama dengan profil Tono ditolak',
  $q$ update public.anggota set no_hp = '081277770001' where id = tests.id('andi') $q$);
select tests.harus_gagal('Budi: nomor HP profil yang sama dengan nomor login Rina ditolak',
  $q$ update public.anggota set no_hp = '081233330001' where id = tests.id('andi') $q$);
select tests.harus_gagal('Budi: nomor HP profil yang tidak sah ditolak',
  $q$ update public.anggota set no_hp = '12345' where id = tests.id('andi') $q$);
select tests.harus_gagal('Budi: anggota baru dengan nomor HP Tono ditolak',
  $q$ insert into public.anggota (kelompok_id, nama_lengkap, persetujuan_pada, no_hp)
      values (tests.id('kel_a1'), 'Dobel', now(), '0812 7777 0001') $q$);
select tests.harus_berhasil('Budi: mencatat persetujuan Ani (akunnya mendaftar dengan nomor HP)',
  $q$ update public.anggota set persetujuan_pada = now() where id = tests.id('ani') $q$);
select tests.keluar();
select tests.periksa('Nomor HP login Andi ikut berubah setelah profil diubah pemimpin',
  (select nomor_hp = '6281244440002' from public.akun where id = tests.id('u_andi')));
select tests.periksa('Profil Ani otomatis berisi nomor HP loginnya setelah persetujuan',
  (select no_hp = '6281234567890' from public.anggota where id = tests.id('ani')));

select tests.masuk_sebagai_layanan();
select tests.periksa('Server: masuk dengan nomor HP baru Andi berhasil, nomor lama tidak',
  public.layanan_cari_login('081244440002') = 'u_andi@contoh.test'
  and public.layanan_cari_login('081244440001') is null);

select tests.masuk_sebagai('dewi');
select tests.harus_gagal('Dewi: tidak bisa menghapus nomor HP Bima (satu-satunya cara masuk Bima)',
  $q$ update public.anggota set no_hp = null where id = tests.id('bima') $q$);

-- Nomor HP login staf hanya diubah orangnya sendiri atau Admin
select tests.keluar();
insert into public.anggota (id, kelompok_id, nama_lengkap, persetujuan_pada)
values (tests.id('sari_p'), tests.id('kel_t1'), 'Sari', now());
update public.akun set anggota_id = tests.id('sari_p') where id = tests.id('sari');
select tests.masuk_sebagai('budi');
select tests.harus_gagal('Budi (pemimpin T1): tidak bisa mengganti nomor HP profil Sari (staf)',
  $q$ update public.anggota set no_hp = '081266660001' where id = tests.id('sari_p') $q$);
select tests.masuk_sebagai('sari');
select tests.harus_berhasil('Sari: mengganti nomor HP di profilnya sendiri',
  $q$ update public.anggota set no_hp = '081266660001' where id = tests.id('sari_p') $q$);
select tests.keluar();
select tests.periksa('Nomor HP login Sari ikut berubah',
  (select nomor_hp = '6281266660001' from public.akun where id = tests.id('sari')));
select tests.periksa('Perubahan cara masuk tercatat di log',
  exists (select 1 from public.log_aktivitas where tindakan = 'ubah_login' and akun_id = tests.id('admin')));


-- =====================================================================
-- UJI ATUR PROFIL · PROFIL STAF DAN LOGIN PERTAMA (keputusan 27)
-- =====================================================================
select tests.keluar();
select tests.periksa('Akun baru: wajib Atur profil, kata sandi tidak sementara',
  (select profil_diatur_pada is null and not sandi_sementara from public.akun where id = tests.id('u_rina')));

select tests.masuk_sebagai_layanan();
select tests.harus_berhasil('Server: menandai kata sandi Rina sebagai sementara (dibuat Admin)',
  $q$ select public.layanan_tandai_sandi(tests.id('u_rina'), true) $q$);

select tests.masuk_sebagai('u_rina');
select tests.periksa('Rina: peran_saya menyebut perlu Atur profil dan kata sandi sementara',
  (select (r ->> 'perlu_atur_profil')::boolean and (r ->> 'sandi_sementara')::boolean
   from (select public.peran_saya() as r) x));
select tests.harus_gagal('Rina: tidak bisa menyelesaikan Atur profil sebelum mengganti kata sandi sementara',
  $q$ select public.selesai_atur_profil() $q$);
select tests.harus_gagal('Rina: tidak bisa melepas sendiri penanda kata sandi sementara',
  $q$ select public.layanan_tandai_sandi(tests.id('u_rina'), false) $q$);

select tests.masuk_sebagai('budi');
select tests.harus_berhasil('Budi: menyelesaikan Atur profil',
  $q$ select public.selesai_atur_profil() $q$);
select tests.periksa('Budi: peran_saya tidak lagi meminta Atur profil',
  (select not (r ->> 'perlu_atur_profil')::boolean from (select public.peran_saya() as r) x));
select tests.periksa('Budi: mengubah nama tampilannya sendiri (1 baris)',
  tests.baris_terkena($q$ update public.akun set nama_tampilan = 'Budi Santoso' where id = tests.id('budi') $q$) = 1);
select tests.harus_gagal('Budi: nama tampilan kosong ditolak',
  $q$ update public.akun set nama_tampilan = '  ' where id = tests.id('budi') $q$);

-- Profil staf
select tests.harus_berhasil('Budi (staf tanpa profil anggota): membuat profil staf sendiri',
  $q$ insert into public.profil_staf (akun_id, gender, pendidikan) values (tests.id('budi'), 'laki_laki', 's1') $q$);
select tests.periksa('Profil staf Budi: waktu persetujuan terisi otomatis',
  (select persetujuan_pada is not null from public.profil_staf where akun_id = tests.id('budi')));
select tests.harus_gagal('Budi: tidak bisa membuat profil staf untuk Dewi',
  $q$ insert into public.profil_staf (akun_id) values (tests.id('dewi')) $q$);
select tests.periksa('Budi: mengubah profil stafnya (1 baris)',
  tests.baris_terkena($q$ update public.profil_staf set tempat_lahir = 'Medan', provinsi_kode = '12' where akun_id = tests.id('budi') $q$) = 1);
select tests.harus_gagal('Budi: wilayah yang tidak nyambung ditolak',
  $q$ update public.profil_staf set kota_kode = '31.71' where akun_id = tests.id('budi') $q$);
select tests.harus_gagal('Budi: foto di folder orang lain ditolak',
  $q$ update public.profil_staf set foto_path = 'staf/' || tests.id('dewi') || '/a.jpg' where akun_id = tests.id('budi') $q$);
select tests.harus_berhasil('Budi: mengunggah foto ke folder stafnya sendiri',
  $q$ insert into storage.objects (bucket_id, name) values ('foto-anggota', 'staf/' || tests.id('budi') || '/1.jpg') $q$);
select tests.harus_gagal('Budi: tidak bisa mengunggah foto ke folder staf Dewi',
  $q$ insert into storage.objects (bucket_id, name) values ('foto-anggota', 'staf/' || tests.id('dewi') || '/1.jpg') $q$);
select tests.periksa('Budi: memasang dan mengganti foto stafnya',
  tests.baris_terkena($q$ update public.profil_staf set foto_path = 'staf/' || tests.id('budi') || '/1.jpg' where akun_id = tests.id('budi') $q$) = 1
  and tests.baris_terkena($q$ update public.profil_staf set foto_path = 'staf/' || tests.id('budi') || '/2.jpg' where akun_id = tests.id('budi') $q$) = 1);
select tests.periksa('Budi: mengubah akun_id profil staf tidak berpengaruh (tetap milik Budi)',
  tests.baris_terkena($q$ update public.profil_staf set akun_id = tests.id('dewi') where akun_id = tests.id('budi') $q$) <= 1
  and exists (select 1 from public.profil_staf where akun_id = tests.id('budi')));

select tests.masuk_sebagai('dewi');
select tests.periksa('Dewi: tidak bisa membaca profil staf Budi',
  not exists (select 1 from public.profil_staf where akun_id = tests.id('budi')));
select tests.periksa('Dewi: tidak bisa melihat foto staf Budi',
  not exists (select 1 from storage.objects where name like 'staf/' || tests.id('budi') || '/%'));
select tests.periksa('Dewi: tidak bisa menghapus profil staf Budi (0 baris)',
  tests.baris_terkena($q$ delete from public.profil_staf where akun_id = tests.id('budi') $q$) = 0);

select tests.masuk_sebagai('u_andi');
select tests.harus_gagal('Andi (punya profil anggota): tidak bisa membuat profil staf',
  $q$ insert into public.profil_staf (akun_id) values (tests.id('u_andi')) $q$);

select tests.masuk_sebagai('admin');
select tests.periksa('Admin: membaca profil staf Budi',
  exists (select 1 from public.profil_staf where akun_id = tests.id('budi') and tempat_lahir = 'Medan'));
select tests.periksa('Admin: melihat foto staf Budi',
  exists (select 1 from storage.objects where name like 'staf/' || tests.id('budi') || '/%'));
select tests.periksa('Admin: tidak bisa mengubah profil staf Budi (0 baris)',
  tests.baris_terkena($q$ update public.profil_staf set alamat = 'x' where akun_id = tests.id('budi') $q$) = 0);

select tests.masuk_sebagai_tamu();
select tests.harus_gagal('Tamu: tidak bisa membaca profil staf', $q$ select * from public.profil_staf $q$);

select tests.keluar();
select tests.periksa('Foto staf lama Budi masuk antrean hapus',
  exists (select 1 from internal.antrean_hapus_foto where foto_path = 'staf/' || tests.id('budi') || '/1.jpg'));

-- Nama akun mengikuti nama lengkap profil anggota
select tests.masuk_sebagai('budi');
select tests.periksa('Budi: mengganti nama lengkap profil Andi (1 baris)',
  tests.baris_terkena($q$ update public.anggota set nama_lengkap = 'Andi Pratama' where id = tests.id('andi') $q$) = 1);
select tests.keluar();
select tests.periksa('Nama akun Andi ikut berubah',
  (select nama_tampilan = 'Andi Pratama' from public.akun where id = tests.id('u_andi')));


-- =====================================================================
-- UJI MASUKAN · KELUHAN, PERMASALAHAN, USULAN (keputusan 28)
-- Andi = anggota A1 (Tim A). Budi = pemimpin A1, Sari = wakil A1,
-- Ketua A = ketua Tim A, Dewi = pemimpin B1, Ketua B = ketua Tim B.
-- =====================================================================
select tests.masuk_sebagai('u_andi');
select tests.harus_berhasil('Andi: kirim keluhan TANPA NAMA ke pemimpin kelompoknya',
  $q$ select tests.simpan('m1', public.kirim_masukan('pemimpin', tests.id('kel_a1'), 'keluhan', 'Jadwal', 'Pertemuan sering mulai terlambat', true)::text) $q$);
select tests.harus_berhasil('Andi: kirim usulan ke ketua tim kelompoknya',
  $q$ select tests.simpan('m2', public.kirim_masukan('ketua_tim', tests.id('kel_a1'), 'usulan', 'Retret', 'Usul retret gabungan')::text) $q$);
select tests.harus_berhasil('Andi: kirim permasalahan ke Admin',
  $q$ select tests.simpan('m3', public.kirim_masukan('admin', null, 'permasalahan', 'Aplikasi', 'Foto tidak terunggah')::text) $q$);
select tests.harus_gagal('Andi: tidak bisa mengirim ke pemimpin kelompok lain (B1)',
  $q$ select public.kirim_masukan('pemimpin', tests.id('kel_b1'), 'keluhan', 'x', 'x') $q$);
select tests.harus_gagal('Andi: tidak bisa mengirim ke ketua tim lain (lewat B1)',
  $q$ select public.kirim_masukan('ketua_tim', tests.id('kel_b1'), 'keluhan', 'x', 'x') $q$);
select tests.harus_gagal('Andi: judul kosong ditolak',
  $q$ select public.kirim_masukan('admin', null, 'usulan', '  ', 'isi') $q$);
select tests.harus_gagal('Andi: tidak bisa membaca tabel masukan langsung',
  $q$ select * from public.masukan $q$);
select tests.harus_gagal('Andi: tidak bisa menulis tabel masukan langsung',
  $q$ insert into public.masukan (tujuan, jenis, judul, isi) values ('admin', 'usulan', 'x', 'x') $q$);
select tests.periksa('Andi: melihat 3 masukan yang dikirimnya',
  (select count(*) from public.masukan_saya()) = 3);
select tests.periksa('Andi: masukan yang ditujukan ke orang lain tidak bisa ia tanggapi',
  not exists (select 1 from public.masukan_masuk()));
select tests.harus_gagal('Andi: tidak bisa menanggapi masukannya sendiri',
  $q$ select public.tanggapi_masukan((select teks::uuid from tests.nilai where nama = 'm1'), 'selesai', 'x') $q$);

select tests.masuk_sebagai('budi');
select tests.harus_gagal('Budi (bukan anggota A1): tidak bisa mengirim ke "pemimpin" A1',
  $q$ select public.kirim_masukan('pemimpin', tests.id('kel_a1'), 'keluhan', 'x', 'x') $q$);
select tests.harus_berhasil('Budi (pemimpin A1): kirim permasalahan ke ketua timnya',
  $q$ select tests.simpan('m4', public.kirim_masukan('ketua_tim', tests.id('kel_a1'), 'permasalahan', 'Tempat', 'Butuh ruang pertemuan')::text) $q$);
select tests.periksa('Budi: menerima keluhan anonim untuk A1 tanpa nama pengirim',
  (select pengirim_nama is null and anonim from public.masukan_masuk()
    where id = (select teks::uuid from tests.nilai where nama = 'm1')));
select tests.periksa('Budi: tidak menerima masukan untuk ketua tim atau Admin',
  not exists (select 1 from public.masukan_masuk()
               where id in (select teks::uuid from tests.nilai where nama in ('m2','m3','m4'))));
select tests.periksa('Budi: jumlah masukan baru tampil',
  public.jumlah_masukan_baru() >= 1);
select tests.harus_berhasil('Budi: menanggapi keluhan (sedang ditangani + balasan)',
  $q$ select public.tanggapi_masukan((select teks::uuid from tests.nilai where nama = 'm1'), 'ditangani', 'Terima kasih, akan kami perbaiki.') $q$);
select tests.harus_gagal('Budi: tidak bisa menanggapi masukan untuk ketua tim',
  $q$ select public.tanggapi_masukan((select teks::uuid from tests.nilai where nama = 'm2'), 'selesai', 'x') $q$);

select tests.masuk_sebagai('sari');
select tests.periksa('Sari (wakil A1): juga menerima keluhan untuk A1',
  exists (select 1 from public.masukan_masuk() where id = (select teks::uuid from tests.nilai where nama = 'm1')));

select tests.masuk_sebagai('dewi');
select tests.periksa('Dewi (pemimpin B1): tidak menerima masukan A1',
  not exists (select 1 from public.masukan_masuk()
               where id in (select teks::uuid from tests.nilai where nama in ('m1','m2','m3','m4'))));
select tests.harus_gagal('Dewi: tidak bisa menanggapi keluhan A1',
  $q$ select public.tanggapi_masukan((select teks::uuid from tests.nilai where nama = 'm1'), 'selesai', 'x') $q$);

select tests.masuk_sebagai('ketua_a');
select tests.periksa('Ketua A: menerima usulan Andi (dengan nama) dan permasalahan Budi',
  (select count(*) from public.masukan_masuk()
    where id in (select teks::uuid from tests.nilai where nama in ('m2','m4'))) = 2
  and (select pengirim_nama is not null from public.masukan_masuk()
        where id = (select teks::uuid from tests.nilai where nama = 'm2')));
select tests.periksa('Ketua A: tidak menerima masukan untuk pemimpin atau Admin',
  not exists (select 1 from public.masukan_masuk()
               where id in (select teks::uuid from tests.nilai where nama in ('m1','m3'))));
select tests.harus_berhasil('Ketua A: menandai usulan selesai',
  $q$ select public.tanggapi_masukan((select teks::uuid from tests.nilai where nama = 'm2'), 'selesai', 'Sudah dijadwalkan.') $q$);

select tests.masuk_sebagai('ketua_b');
select tests.periksa('Ketua B: tidak menerima masukan Tim A',
  not exists (select 1 from public.masukan_masuk()
               where id in (select teks::uuid from tests.nilai where nama in ('m1','m2','m3','m4'))));

select tests.masuk_sebagai('admin');
select tests.periksa('Admin: membaca keempat masukan',
  (select count(*) from public.masukan_masuk()
    where id in (select teks::uuid from tests.nilai where nama in ('m1','m2','m3','m4'))) = 4);
select tests.periksa('Admin: melihat pengirim masukan anonim',
  (select pengirim_nama is not null from public.masukan_masuk()
    where id = (select teks::uuid from tests.nilai where nama = 'm1')));
select tests.harus_berhasil('Admin: menanggapi permasalahan',
  $q$ select public.tanggapi_masukan((select teks::uuid from tests.nilai where nama = 'm3'), 'selesai', 'Sudah diperbaiki.') $q$);

select tests.masuk_sebagai('u_andi');
select tests.periksa('Andi: melihat status dan balasan atas keluhannya',
  (select status = 'ditangani' and balasan = 'Terima kasih, akan kami perbaiki.' and dibalas_pada is not null
   from public.masukan_saya() where id = (select teks::uuid from tests.nilai where nama = 'm1')));

select tests.masuk_sebagai_tamu();
select tests.harus_gagal('Tamu: tidak bisa membaca masukan', $q$ select * from public.masukan_masuk() $q$);
select tests.harus_gagal('Tamu: tidak bisa mengirim masukan',
  $q$ select public.kirim_masukan('admin', null, 'usulan', 'x', 'x') $q$);
select tests.keluar();
select tests.periksa('Pengiriman dan tanggapan masukan tercatat di log',
  exists (select 1 from public.log_aktivitas where tindakan = 'kirim_masukan')
  and exists (select 1 from public.log_aktivitas where tindakan = 'tanggapi_masukan'));


-- =====================================================================
-- UJI BAPTIS, STATUS JEMAAT, DATA JEMAAT OLEH KETUA TIM (keputusan 29, 30)
-- Andi = anggota A1 (Tim A), Ani = anggota A1, Bima = anggota B1 (Tim B).
-- =====================================================================
select tests.keluar();
insert into tests.ids values ('tanpa_setuju', '44444444-0000-0000-0000-00000000aa03');
insert into public.anggota (id, kelompok_id, nama_lengkap)
values (tests.id('tanpa_setuju'), tests.id('kel_a1'), 'Belum Setuju');

select tests.masuk_sebagai('u_andi');
select tests.periksa('Andi: mengisi Baptis di profilnya sendiri (1 baris)',
  tests.baris_terkena($q$ update public.anggota set baptis = true where id = tests.id('andi') $q$) = 1);
select tests.harus_gagal('Andi: tidak bisa mengubah status jemaatnya sendiri',
  $q$ update public.anggota set status_jemaat = 'leader' where id = tests.id('andi') $q$);
select tests.harus_gagal('Andi: tidak bisa memakai loket data jemaat',
  $q$ select public.ubah_data_jemaat(tests.id('andi'), 'laki_laki', true, 'leader') $q$);

select tests.masuk_sebagai('ketua_a');
select tests.harus_berhasil('Ketua Tim A: mengatur gender, aktif, dan status jemaat Andi (A1)',
  $q$ select public.ubah_data_jemaat(tests.id('andi'), 'laki_laki', true, 'pelayan') $q$);
select tests.harus_berhasil('Ketua Tim A: menandai Ani tidak aktif',
  $q$ select public.ubah_data_jemaat(tests.id('ani'), null, false, 'tamu') $q$);
select tests.harus_gagal('Ketua Tim A: tidak bisa mengatur anggota Tim B (Bima)',
  $q$ select public.ubah_data_jemaat(tests.id('bima'), 'laki_laki', true, 'member') $q$);
select tests.harus_gagal('Ketua Tim A: gender anggota tanpa persetujuan ditolak',
  $q$ select public.ubah_data_jemaat(tests.id('tanpa_setuju'), 'perempuan', true, 'tamu') $q$);
select tests.harus_berhasil('Ketua Tim A: status jemaat boleh diatur walau persetujuan belum ada',
  $q$ select public.ubah_data_jemaat(tests.id('tanpa_setuju'), null, true, 'tamu') $q$);
select tests.periksa('Ketua Tim A: tetap tidak bisa mengubah isian lain profil Andi (0 baris)',
  tests.baris_terkena($q$ update public.anggota set alamat = 'x' where id = tests.id('andi') $q$) = 0);

select tests.masuk_sebagai('ketua_b');
select tests.harus_gagal('Ketua Tim B: tidak bisa mengatur anggota Tim A',
  $q$ select public.ubah_data_jemaat(tests.id('andi'), 'laki_laki', true, 'member') $q$);

select tests.masuk_sebagai('budi');
select tests.harus_berhasil('Budi (pemimpin A1): mengatur status jemaat dan mengaktifkan Ani',
  $q$ select public.ubah_data_jemaat(tests.id('ani'), null, true, 'member') $q$);
select tests.periksa('Budi: mengubah status jemaat langsung di profil Andi (1 baris)',
  tests.baris_terkena($q$ update public.anggota set status_jemaat = 'leader' where id = tests.id('andi') $q$) = 1);
select tests.harus_berhasil('Budi: menambah anggota baru dengan status jemaat Tamu',
  $q$ insert into public.anggota (kelompok_id, nama_lengkap, status_jemaat) values (tests.id('kel_a1'), 'Tamu Baru', 'tamu') $q$);
select tests.harus_gagal('Budi: Baptis anggota tanpa persetujuan ditolak',
  $q$ update public.anggota set baptis = false where id = tests.id('tanpa_setuju') $q$);

select tests.masuk_sebagai('dewi');
select tests.harus_gagal('Dewi (pemimpin B1): tidak bisa mengatur anggota A1',
  $q$ select public.ubah_data_jemaat(tests.id('andi'), 'laki_laki', true, 'member') $q$);

select tests.masuk_sebagai('admin');
select tests.harus_berhasil('Admin: mengatur data jemaat Bima',
  $q$ select public.ubah_data_jemaat(tests.id('bima'), 'laki_laki', true, 'member') $q$);
select tests.periksa('Laporan Baptis: jumlah = anggota aktif, kategori sudah/belum',
  (select sum(jumlah) from public.laporan_demografi('baptis'))
    = (select count(*) from public.anggota where aktif)
  and not exists (select 1 from public.laporan_demografi('baptis') where kunci not in ('sudah','belum')));
select tests.periksa('Laporan Status jemaat: jumlah = anggota aktif, Andi tercatat leader',
  (select sum(jumlah) from public.laporan_demografi('status_jemaat'))
    = (select count(*) from public.anggota where aktif)
  and exists (select 1 from public.laporan_demografi('status_jemaat') where kunci = 'leader'));
select tests.harus_gagal('Laporan: dimensi tidak dikenal tetap ditolak',
  $q$ select * from public.laporan_demografi('agama') $q$);

select tests.masuk_sebagai('budi');
select tests.periksa('Budi (staf): mengisi Baptis di profil stafnya (1 baris)',
  tests.baris_terkena($q$ update public.profil_staf set baptis = true where akun_id = tests.id('budi') $q$) = 1);

select tests.keluar();
select tests.periksa('Data Andi: pelayan lalu leader, laki-laki, baptis',
  (select status_jemaat = 'leader' and gender = 'laki_laki' and baptis from public.anggota where id = tests.id('andi')));
select tests.periksa('Perubahan data jemaat tercatat di log',
  exists (select 1 from public.log_aktivitas where tindakan = 'ubah_data_jemaat' and akun_id = tests.id('ketua_a')));


-- =====================================================================
-- UJI LAPORAN GENERASI (keputusan 31)
-- =====================================================================
select tests.keluar();
select tests.periksa('Generasi: batas tahun lahir tepat (1945/1946, 1964/1965, 1980/1981, 1996/1997, 2012/2013, 2024/2025)',
  internal.generasi('1945-12-31') = 'silent'  and internal.generasi('1946-01-01') = 'boomers'
  and internal.generasi('1964-12-31') = 'boomers' and internal.generasi('1965-01-01') = 'x'
  and internal.generasi('1980-12-31') = 'x'     and internal.generasi('1981-01-01') = 'y'
  and internal.generasi('1996-12-31') = 'y'     and internal.generasi('1997-01-01') = 'z'
  and internal.generasi('2012-12-31') = 'z'     and internal.generasi('2013-01-01') = 'alpha'
  and internal.generasi('2024-12-31') = 'alpha' and internal.generasi('2025-01-01') = 'beta'
  and internal.generasi('1920-05-05') = 'silent' and internal.generasi(null) is null);

select tests.masuk_sebagai('admin');
select tests.periksa('Laporan Generasi: jumlah = anggota aktif; Andi (lahir 1990) di Gen Y',
  (select sum(jumlah) from public.laporan_demografi('generasi'))
    = (select count(*) from public.anggota where aktif)
  and exists (select 1 from public.laporan_demografi('generasi') where kunci = 'y'));
select tests.masuk_sebagai('ketua_a');
select tests.harus_gagal('Ketua Tim A: tidak bisa membuka laporan generasi',
  $q$ select * from public.laporan_demografi('generasi') $q$);
select tests.keluar();


-- =====================================================================
-- UJI ATUR ULANG KATA SANDI OLEH KETUA TIM (keputusan 34)
-- Tim A: kelompok A1 (Budi pemimpin, Sari wakil, anggota Andi) dan T1 (Budi).
-- Tim B: kelompok B1 (Dewi pemimpin, anggota Bima). Ketua A / Ketua B.
-- =====================================================================
select tests.masuk_sebagai('ketua_a');
select tests.harus_berhasil('Ketua A: atur ulang kata sandi anggota timnya (Andi)',
  $q$ select * from public.buat_tautan_atur_ulang(tests.id('u_andi')) $q$);
select tests.harus_berhasil('Ketua A: atur ulang kata sandi Pemimpin kelompok di timnya (Budi)',
  $q$ select * from public.buat_tautan_atur_ulang(tests.id('budi')) $q$);
select tests.harus_berhasil('Ketua A: atur ulang kata sandi Wakil kelompok di timnya (Sari)',
  $q$ select * from public.buat_tautan_atur_ulang(tests.id('sari')) $q$);
select tests.harus_gagal('Ketua A: tidak bisa untuk anggota tim lain (Bima)',
  $q$ select * from public.buat_tautan_atur_ulang(tests.id('u_bima')) $q$);
select tests.harus_gagal('Ketua A: tidak bisa untuk pemimpin tim lain (Dewi)',
  $q$ select * from public.buat_tautan_atur_ulang(tests.id('dewi')) $q$);
select tests.harus_gagal('Ketua A: tidak bisa untuk Admin',
  $q$ select * from public.buat_tautan_atur_ulang(tests.id('admin')) $q$);
select tests.harus_gagal('Ketua A: tidak bisa untuk Ketua Tim lain',
  $q$ select * from public.buat_tautan_atur_ulang(tests.id('ketua_b')) $q$);
select tests.harus_gagal('Ketua A: tidak bisa untuk dirinya sendiri',
  $q$ select * from public.buat_tautan_atur_ulang(tests.id('ketua_a')) $q$);
select tests.periksa('Ketua A: daftar A1 berisi Budi (Pemimpin), Sari (Wakil), dan Andi (Anggota)',
  (select count(*) from public.akun_bisa_atur_ulang(tests.id('kel_a1'))
    where (akun_id = tests.id('budi') and keterangan = 'Pemimpin')
       or (akun_id = tests.id('sari') and keterangan = 'Wakil')
       or (akun_id = tests.id('u_andi') and keterangan = 'Anggota')) = 3);
select tests.periksa('Ketua A: daftar B1 kosong',
  not exists (select 1 from public.akun_bisa_atur_ulang(tests.id('kel_b1'))));

-- Pengurus yang juga memegang peran di tim lain: hanya Admin.
select tests.keluar();
insert into public.penugasan_peran (akun_id, peran, kelompok_id, jabatan)
values (tests.id('budi'), 'pemimpin', tests.id('kel_b1'), 'wakil');
select tests.masuk_sebagai('ketua_a');
select tests.harus_gagal('Ketua A: tidak bisa untuk Budi bila Budi juga pengurus di tim B',
  $q$ select * from public.buat_tautan_atur_ulang(tests.id('budi')) $q$);
select tests.keluar();
delete from public.penugasan_peran where akun_id = tests.id('budi') and kelompok_id = tests.id('kel_b1');

select tests.masuk_sebagai('ketua_b');
select tests.harus_gagal('Ketua B: tidak bisa untuk anggota Tim A (Andi)',
  $q$ select * from public.buat_tautan_atur_ulang(tests.id('u_andi')) $q$);
select tests.harus_berhasil('Ketua B: atur ulang kata sandi anggota timnya (Bima)',
  $q$ select * from public.buat_tautan_atur_ulang(tests.id('u_bima')) $q$);
select tests.harus_gagal('Ketua B: tidak bisa untuk Dewi, karena Dewi juga Ketua Tim (diberi di uji Admin)',
  $q$ select * from public.buat_tautan_atur_ulang(tests.id('dewi')) $q$);

select tests.masuk_sebagai('budi');
select tests.periksa('Budi (pemimpin A1): daftar A1 berisi Andi tetapi bukan Sari',
  exists (select 1 from public.akun_bisa_atur_ulang(tests.id('kel_a1')) where akun_id = tests.id('u_andi'))
  and not exists (select 1 from public.akun_bisa_atur_ulang(tests.id('kel_a1')) where akun_id = tests.id('sari')));
select tests.harus_gagal('Budi: tetap tidak bisa untuk Wakilnya (Sari)',
  $q$ select * from public.buat_tautan_atur_ulang(tests.id('sari')) $q$);

select tests.masuk_sebagai('admin');
select tests.harus_berhasil('Admin: atur ulang kata sandi Ketua Tim A',
  $q$ select * from public.buat_tautan_atur_ulang(tests.id('ketua_a')) $q$);
select tests.harus_gagal('Admin: tidak lewat tautan untuk dirinya sendiri (ganti di Atur profil)',
  $q$ select * from public.buat_tautan_atur_ulang(tests.id('admin')) $q$);
select tests.keluar();


-- =====================================================================
-- UJI MEMASUKKAN AKUN YANG BELUM TERGABUNG (keputusan 35)
-- Belum tergabung: Rina (nama pengguna rina2), Tanpa Peran, Dewi, Budi, dll.
-- =====================================================================
select tests.masuk_sebagai('u_andi');
select tests.harus_gagal('Andi (anggota biasa): tidak bisa mencari akun',
  $q$ select * from public.cari_akun_belum_tergabung('rina2') $q$);

select tests.masuk_sebagai('budi');
select tests.periksa('Budi: menemukan Rina dengan nama pengguna persis (huruf besar pun)',
  (select count(*) from public.cari_akun_belum_tergabung(' RINA2 ') where akun_id = tests.id('u_rina')) = 1);
select tests.periksa('Budi: menemukan Rina dengan nomor HP format lain',
  exists (select 1 from public.cari_akun_belum_tergabung('+62 812-3333-0001') where akun_id = tests.id('u_rina')));
select tests.periksa('Budi: sebagian nama pengguna tidak menemukan apa pun (harus persis)',
  not exists (select 1 from public.cari_akun_belum_tergabung('rina')));
select tests.periksa('Budi: akun yang sudah tergabung (Andi) tidak muncul',
  not exists (select 1 from public.cari_akun_belum_tergabung('u_andi@contoh.test')));
select tests.harus_gagal('Budi: tidak bisa melihat daftar lengkap (khusus Admin)',
  $q$ select * from public.akun_belum_tergabung() $q$);
select tests.harus_berhasil('Budi: memasukkan Rina ke kelompoknya (A1)',
  $q$ select public.masukkan_akun_ke_kelompok(tests.id('u_rina'), tests.id('kel_a1')) $q$);
select tests.harus_gagal('Budi: Rina yang sudah tergabung tidak bisa dimasukkan lagi',
  $q$ select public.masukkan_akun_ke_kelompok(tests.id('u_rina'), tests.id('kel_t1')) $q$);
select tests.harus_gagal('Budi: tidak bisa memasukkan akun ke kelompok tim lain (B1)',
  $q$ select public.masukkan_akun_ke_kelompok(tests.id('tanpa_peran'), tests.id('kel_b1')) $q$);

select tests.keluar();
select tests.periksa('Rina kini anggota A1 dengan nama akunnya, persetujuan belum ada',
  (select a.kelompok_id = tests.id('kel_a1') and a.nama_lengkap = 'Rina' and a.persetujuan_pada is null
   from public.akun ak join public.anggota a on a.id = ak.anggota_id where ak.id = tests.id('u_rina')));

select tests.masuk_sebagai('ketua_a');
select tests.harus_berhasil('Ketua A: memasukkan akun tanpa peran ke kelompok di timnya (T1)',
  $q$ select public.masukkan_akun_ke_kelompok(tests.id('tanpa_peran'), tests.id('kel_t1')) $q$);
select tests.harus_gagal('Ketua A: tidak bisa memasukkan ke kelompok tim lain (B1)',
  $q$ select public.masukkan_akun_ke_kelompok(tests.id('dewi'), tests.id('kel_b1')) $q$);

select tests.masuk_sebagai('ketua_b');
select tests.harus_berhasil('Ketua B: memasukkan akun pengurus (Dewi) sebagai anggota B1',
  $q$ select public.masukkan_akun_ke_kelompok(tests.id('dewi'), tests.id('kel_b1')) $q$);

select tests.masuk_sebagai('admin');
select tests.periksa('Admin: daftar lengkap berisi Budi (Pemimpin) dan tidak berisi Rina',
  exists (select 1 from public.akun_belum_tergabung() where akun_id = tests.id('budi') and peran like '%Pemimpin%')
  and not exists (select 1 from public.akun_belum_tergabung() where akun_id = tests.id('u_rina')));
select tests.harus_berhasil('Admin: memasukkan Pemimpin (Budi) sebagai anggota A1',
  $q$ select public.masukkan_akun_ke_kelompok(tests.id('budi'), tests.id('kel_a1')) $q$);
select tests.keluar();
select tests.periksa('Budi: punya profil anggota di A1 dan peran Pemimpin A1 tetap ada',
  exists (select 1 from public.akun ak join public.anggota a on a.id = ak.anggota_id
          where ak.id = tests.id('budi') and a.kelompok_id = tests.id('kel_a1'))
  and exists (select 1 from public.penugasan_peran where akun_id = tests.id('budi') and kelompok_id = tests.id('kel_a1')));
select tests.periksa('Memasukkan akun tercatat di log',
  (select count(*) from public.log_aktivitas where tindakan = 'masukkan_akun_ke_kelompok') = 4);


-- =====================================================================
-- UJI LAPORAN PROYEK KETAATAN OLEH ANGGOTA SENDIRI (keputusan 36)
-- A1: Andi, Rina, dan Budi (pemimpin yang kini juga anggota A1).
-- =====================================================================
select tests.keluar();
insert into tests.ids values
  ('pr_a1', '77777777-0000-0000-0000-0000000000a1'),
  ('pr_b1', '77777777-0000-0000-0000-0000000000b1');
insert into public.proyek_ketaatan (id, kelompok_id, judul) values
  (tests.id('pr_a1'), tests.id('kel_a1'), 'Baca Injil Markus'),
  (tests.id('pr_b1'), tests.id('kel_b1'), 'Proyek B1');

select tests.masuk_sebagai('u_andi');
select tests.periksa('Andi: melihat proyek kelompoknya (A1), bukan proyek B1',
  exists (select 1 from public.proyek_saya() where proyek_id = tests.id('pr_a1') and status = 'belum')
  and not exists (select 1 from public.proyek_saya() where proyek_id = tests.id('pr_b1')));
select tests.harus_gagal('Andi: "Belum dijalankan" tanpa alasan ditolak',
  $q$ select public.lapor_proyek_saya(tests.id('pr_a1'), 'belum', '  ') $q$);
select tests.harus_berhasil('Andi: "Belum dijalankan" dengan alasan',
  $q$ select public.lapor_proyek_saya(tests.id('pr_a1'), 'belum', 'Sedang sakit minggu ini') $q$);
select tests.periksa('Andi: alasan tersimpan dan tercatat dilaporkan sendiri',
  (select alasan = 'Sedang sakit minggu ini' and dilaporkan_sendiri from public.proyek_saya() where proyek_id = tests.id('pr_a1')));
select tests.harus_gagal('Andi: "Sudah selesai" tanpa hasil ditolak',
  $q$ select public.lapor_proyek_saya(tests.id('pr_a1'), 'selesai', null, '') $q$);
select tests.harus_berhasil('Andi: "Sudah selesai" dengan hasil',
  $q$ select public.lapor_proyek_saya(tests.id('pr_a1'), 'selesai', null, 'Lebih sabar kepada keluarga') $q$);
select tests.periksa('Andi: hasil tersimpan, alasan lama dihapus',
  (select status = 'selesai' and hasil = 'Lebih sabar kepada keluarga' and alasan is null
   from public.proyek_saya() where proyek_id = tests.id('pr_a1')));
select tests.harus_gagal('Andi: tidak bisa melapor "Tidak dikerjakan" (khusus pemimpin)',
  $q$ select public.lapor_proyek_saya(tests.id('pr_a1'), 'tidak_dikerjakan') $q$);
select tests.harus_gagal('Andi: tidak bisa melapor proyek kelompok lain',
  $q$ select public.lapor_proyek_saya(tests.id('pr_b1'), 'sedang') $q$);
select tests.periksa('Andi: tidak bisa membaca tabel status proyek (laporan anggota lain tertutup)',
  not exists (select 1 from public.status_proyek));

select tests.masuk_sebagai('u_rina');
select tests.periksa('Rina: hanya melihat statusnya sendiri (belum), bukan hasil Andi',
  (select status = 'belum' and hasil is null from public.proyek_saya() where proyek_id = tests.id('pr_a1')));
select tests.harus_berhasil('Rina: "Sedang dijalankan" tanpa keterangan',
  $q$ select public.lapor_proyek_saya(tests.id('pr_a1'), 'sedang') $q$);

select tests.masuk_sebagai('ketua_a');
select tests.periksa('Ketua A: membaca hasil yang dilaporkan Andi',
  (select hasil = 'Lebih sabar kepada keluarga' and dilaporkan_sendiri from public.status_proyek
   where proyek_id = tests.id('pr_a1') and anggota_id = tests.id('andi')));
select tests.harus_gagal('Ketua A (bukan anggota kelompok): tidak bisa melapor',
  $q$ select public.lapor_proyek_saya(tests.id('pr_a1'), 'sedang') $q$);

select tests.masuk_sebagai('budi');
select tests.harus_berhasil('Budi (pemimpin yang juga anggota A1): melaporkan proyeknya sendiri',
  $q$ select public.lapor_proyek_saya(tests.id('pr_a1'), 'sedang') $q$);
select tests.periksa('Budi: mengubah status Andi menjadi Sedang (1 baris)',
  tests.baris_terkena($q$ update public.status_proyek set status = 'sedang'
                         where proyek_id = tests.id('pr_a1') and anggota_id = tests.id('andi') $q$) = 1);
select tests.periksa('Status Andi kini diisi pemimpin: tidak dilaporkan sendiri, hasil dihapus, pengubah Budi',
  (select not dilaporkan_sendiri and hasil is null and diubah_oleh = tests.id('budi') from public.status_proyek
   where proyek_id = tests.id('pr_a1') and anggota_id = tests.id('andi')));

select tests.masuk_sebagai_tamu();
select tests.harus_gagal('Tamu: tidak bisa membaca proyek', $q$ select * from public.proyek_saya() $q$);
select tests.keluar();
select tests.periksa('Laporan Budi tercatat dilaporkan sendiri',
  (select dilaporkan_sendiri from public.status_proyek s join public.akun ak on ak.anggota_id = s.anggota_id
   where s.proyek_id = tests.id('pr_a1') and ak.id = tests.id('budi')));
select tests.periksa('Laporan proyek tercatat di log',
  (select count(*) from public.log_aktivitas where tindakan = 'lapor_proyek') = 4);


-- =====================================================================
-- UJI LAPORAN PROYEK KETAATAN UNTUK ADMIN (keputusan 38)
-- Proyek A1 "Baca Injil Markus" (pr_a1) dan B1 (pr_b1) dari uji sebelumnya.
-- =====================================================================
select tests.masuk_sebagai('admin');
select tests.periksa('Admin: laporan semua tim memuat proyek A1 dan B1',
  exists (select 1 from public.laporan_proyek() where proyek_id = tests.id('pr_a1'))
  and exists (select 1 from public.laporan_proyek() where proyek_id = tests.id('pr_b1')));
select tests.periksa('Admin: satu baris per anggota aktif A1 untuk proyek A1',
  (select count(*) from public.laporan_proyek('kelompok', tests.id('kel_a1')) where proyek_id = tests.id('pr_a1'))
  = (select count(*) from public.anggota a
     where a.kelompok_id = tests.id('kel_a1')
       and (a.aktif or exists (select 1 from public.status_proyek s where s.proyek_id = tests.id('pr_a1') and s.anggota_id = a.id))));
select tests.periksa('Admin: laporan satu tim (Tim A) tidak memuat proyek B1',
  not exists (select 1 from public.laporan_proyek('tim', tests.id('tim_a')) where proyek_id = tests.id('pr_b1')));
select tests.periksa('Admin: anggota tanpa status tampil sebagai belum dilaporkan; Rina tercatat Sedang',
  exists (select 1 from public.laporan_proyek('kelompok', tests.id('kel_b1')) where not dilaporkan and status = 'belum')
  and exists (select 1 from public.laporan_proyek('kelompok', tests.id('kel_a1'))
              where proyek_id = tests.id('pr_a1') and anggota_nama = 'Rina' and status = 'sedang' and dilaporkan));
select tests.harus_gagal('Cakupan tim tanpa id ditolak',
  $q$ select * from public.laporan_proyek('tim', null) $q$);

select tests.masuk_sebagai('ketua_a');
select tests.harus_gagal('Ketua Tim A: tidak bisa membuka laporan proyek Admin',
  $q$ select * from public.laporan_proyek('tim', tests.id('tim_a')) $q$);
select tests.masuk_sebagai('budi');
select tests.harus_gagal('Budi (pemimpin): tidak bisa membuka laporan proyek Admin',
  $q$ select * from public.laporan_proyek('kelompok', tests.id('kel_a1')) $q$);
select tests.keluar();
select tests.periksa('Pembuatan laporan proyek tercatat di log',
  exists (select 1 from public.log_aktivitas where tindakan = 'buat_laporan_proyek'));


-- =====================================================================
-- UJI BAHAN DISKUSI PDF (keputusan 39)
-- Tim A: Ketua A, Budi (pemimpin A1, T1), Sari (wakil A1). Tim B: Ketua B, Dewi.
-- Andi = anggota biasa A1.
-- =====================================================================
select tests.keluar();
insert into tests.ids values
  ('bahan_semua', '88888888-0000-0000-0000-000000000001'),
  ('bahan_a',     '88888888-0000-0000-0000-000000000002'),
  ('bahan_b',     '88888888-0000-0000-0000-000000000003');

select tests.masuk_sebagai('budi');
select tests.harus_gagal('Budi (pemimpin): tidak bisa menambah bahan diskusi',
  $q$ insert into public.bahan_diskusi (judul, lokasi, nama_berkas, ukuran)
      values ('x', gen_random_uuid() || '/x.pdf', 'x.pdf', 10) $q$);
select tests.harus_gagal('Budi: tidak bisa mengunggah berkas ke folder bahan diskusi',
  $q$ insert into storage.objects (bucket_id, name) values ('bahan-diskusi', 'x/x.pdf') $q$);

select tests.masuk_sebagai('admin');
select tests.harus_berhasil('Admin: mengunggah berkas PDF bahan untuk semua tim',
  $q$ insert into storage.objects (bucket_id, name)
      values ('bahan-diskusi', tests.id('bahan_semua') || '/minggu-1.pdf'),
             ('bahan-diskusi', tests.id('bahan_a') || '/tim-a.pdf'),
             ('bahan-diskusi', tests.id('bahan_b') || '/tim-b.pdf') $q$);
select tests.harus_berhasil('Admin: mencatat bahan untuk semua tim, Tim A, dan Tim B',
  $q$ insert into public.bahan_diskusi (id, judul, tanggal_pakai, tim_id, lokasi, nama_berkas, ukuran) values
      (tests.id('bahan_semua'), 'Pekan 1', bantu.hari_ini_wib(), null, tests.id('bahan_semua') || '/minggu-1.pdf', 'minggu-1.pdf', 1000),
      (tests.id('bahan_a'), 'Khusus Tim A', null, tests.id('tim_a'), tests.id('bahan_a') || '/tim-a.pdf', 'tim-a.pdf', 2000),
      (tests.id('bahan_b'), 'Khusus Tim B', null, tests.id('tim_b'), tests.id('bahan_b') || '/tim-b.pdf', 'tim-b.pdf', 3000) $q$);
select tests.harus_gagal('Berkas di luar folder bahannya ditolak',
  $q$ insert into public.bahan_diskusi (judul, lokasi, nama_berkas, ukuran) values ('x', 'lain/x.pdf', 'x.pdf', 10) $q$);
select tests.harus_gagal('Berkas lebih dari 10 MB ditolak',
  $q$ insert into public.bahan_diskusi (id, judul, lokasi, nama_berkas, ukuran)
      values ('88888888-0000-0000-0000-000000000009', 'x', '88888888-0000-0000-0000-000000000009/x.pdf', 'x.pdf', 10485761) $q$);
select tests.periksa('Admin: melihat ketiga bahan',
  (select count(*) from public.bahan_diskusi where id in (tests.id('bahan_semua'), tests.id('bahan_a'), tests.id('bahan_b'))) = 3);

select tests.masuk_sebagai('budi');
select tests.periksa('Budi (pemimpin Tim A): melihat bahan semua tim dan Tim A, bukan Tim B',
  exists (select 1 from public.bahan_diskusi where id = tests.id('bahan_semua'))
  and exists (select 1 from public.bahan_diskusi where id = tests.id('bahan_a'))
  and not exists (select 1 from public.bahan_diskusi where id = tests.id('bahan_b')));
select tests.periksa('Budi: bisa membuka berkas bahan Tim A, tidak berkas Tim B',
  exists (select 1 from storage.objects where bucket_id = 'bahan-diskusi' and name = tests.id('bahan_a') || '/tim-a.pdf')
  and not exists (select 1 from storage.objects where bucket_id = 'bahan-diskusi' and name = tests.id('bahan_b') || '/tim-b.pdf'));
select tests.periksa('Budi: tidak bisa mengubah atau menghapus bahan (0 baris)',
  tests.baris_terkena($q$ update public.bahan_diskusi set judul = 'x' where id = tests.id('bahan_a') $q$) = 0
  and tests.baris_terkena($q$ delete from public.bahan_diskusi where id = tests.id('bahan_a') $q$) = 0);

select tests.masuk_sebagai('sari');
select tests.periksa('Sari (wakil A1): melihat bahan Tim A',
  exists (select 1 from public.bahan_diskusi where id = tests.id('bahan_a')));

select tests.masuk_sebagai('ketua_b');
select tests.periksa('Ketua Tim B: melihat bahan semua tim dan Tim B, bukan Tim A',
  exists (select 1 from public.bahan_diskusi where id = tests.id('bahan_semua'))
  and exists (select 1 from public.bahan_diskusi where id = tests.id('bahan_b'))
  and not exists (select 1 from public.bahan_diskusi where id = tests.id('bahan_a')));

select tests.masuk_sebagai('u_andi');
select tests.periksa('Andi (anggota biasa): tidak melihat bahan apa pun',
  not exists (select 1 from public.bahan_diskusi));
select tests.periksa('Andi: tidak bisa membuka berkas bahan',
  not exists (select 1 from storage.objects where bucket_id = 'bahan-diskusi'));

select tests.masuk_sebagai_tamu();
select tests.harus_gagal('Tamu: tidak bisa membaca bahan diskusi', $q$ select * from public.bahan_diskusi $q$);

select tests.masuk_sebagai('admin');
select tests.periksa('Admin: mengubah judul; lokasi berkas tidak ikut berubah',
  tests.baris_terkena($q$ update public.bahan_diskusi set judul = 'Pekan 1 (revisi)', lokasi = 'x/y.pdf'
                         where id = tests.id('bahan_semua') $q$) = 1
  and (select lokasi = tests.id('bahan_semua') || '/minggu-1.pdf' from public.bahan_diskusi where id = tests.id('bahan_semua')));
select tests.periksa('Admin: menghapus bahan Tim B (1 baris)',
  tests.baris_terkena($q$ delete from public.bahan_diskusi where id = tests.id('bahan_b') $q$) = 1);
select tests.keluar();
select tests.periksa('Berkas bahan yang dihapus masuk antrean hapus',
  exists (select 1 from internal.antrean_hapus_foto where bucket = 'bahan-diskusi' and foto_path = tests.id('bahan_b') || '/tim-b.pdf'));
select tests.periksa('Unggah dan hapus bahan tercatat di log',
  exists (select 1 from public.log_aktivitas where tindakan = 'unggah_bahan_diskusi')
  and exists (select 1 from public.log_aktivitas where tindakan = 'hapus_bahan_diskusi'));


-- =====================================================================
-- UJI PENGHAPUS BERKAS OTOMATIS (keputusan 40)
-- =====================================================================
select tests.keluar();
-- Satu berkas yatim (sudah tidak dipakai) dan satu yang masih dipakai foto Bima.
insert into internal.antrean_hapus_foto (foto_path, bucket) values
  ('yatim/foto-lama.jpg', 'foto-anggota'),
  ((select foto_path from public.anggota where id = tests.id('bima')), 'foto-anggota'),
  ('x/tak-dikenal.bin', 'folder-lain');

select tests.masuk_sebagai('admin');
select tests.periksa('Admin: melihat jumlah berkas di antrean',
  public.jumlah_antrean_berkas() >= 3);
select tests.harus_gagal('Admin: tidak bisa memanggil loket server',
  $q$ select * from public.layanan_ambil_antrean_berkas() $q$);
select tests.masuk_sebagai('budi');
select tests.harus_gagal('Budi: tidak bisa melihat jumlah antrean', $q$ select public.jumlah_antrean_berkas() $q$);

select tests.masuk_sebagai_layanan();
select tests.simpan('n_antrean', (select count(*)::text from public.layanan_ambil_antrean_berkas(1000)));
select tests.periksa('Server: berkas yatim siap dihapus',
  exists (select 1 from public.layanan_ambil_antrean_berkas(1000) where lokasi = 'yatim/foto-lama.jpg'));
select tests.periksa('Server: foto Bima yang masih dipakai TIDAK diberikan untuk dihapus',
  not exists (select 1 from public.layanan_ambil_antrean_berkas(1000) l
              join public.anggota a on a.foto_path = l.lokasi where a.id = tests.id('bima')));
select tests.periksa('Server: berkas di folder tak dikenal tidak diberikan untuk dihapus',
  not exists (select 1 from public.layanan_ambil_antrean_berkas(1000) where bucket = 'folder-lain'));
select tests.periksa('Server: menandai berkas yatim selesai dihapus (1 baris)',
  public.layanan_selesai_antrean_berkas(array(select id from public.layanan_ambil_antrean_berkas(1000)
                                              where lokasi = 'yatim/foto-lama.jpg')) = 1);
select tests.keluar();
select tests.periksa('Antrean: berkas yatim dan foto yang masih dipakai sudah keluar dari antrean',
  not exists (select 1 from internal.antrean_hapus_foto
              where foto_path = 'yatim/foto-lama.jpg'
                 or foto_path = (select foto_path from public.anggota where id = tests.id('bima'))));
select tests.periksa('Penghapusan berkas tercatat di log',
  exists (select 1 from public.log_aktivitas where tindakan = 'hapus_berkas_antrean'));


-- =====================================================================
-- UJI 26 · MEMBUAT AKUN OLEH PENGURUS & MENGHAPUS AKUN (keputusan 41, 42)
-- =====================================================================
select tests.keluar();
insert into tests.ids values
  ('baru_budi',  '66666666-0000-0000-0000-000000000001'),
  ('baru_ketua', '66666666-0000-0000-0000-000000000002'),
  ('baru_liar',  '66666666-0000-0000-0000-000000000003'),
  ('baru_admin', '66666666-0000-0000-0000-000000000004');

-- Pemimpin/Wakil: hanya anggota kelompoknya sendiri.
select tests.masuk_sebagai('budi');
select tests.harus_berhasil('Buat akun: Budi boleh membuat akun anggota di kelompoknya',
  $q$ select tests.simpan('izin_budi', public.izin_buat_akun('anggota', tests.id('kel_a1'))::text) $q$);
select tests.harus_gagal('Buat akun: Budi tidak bisa membuat akun anggota di kelompok lain',
  $q$ select public.izin_buat_akun('anggota', tests.id('kel_b1')) $q$);
select tests.harus_gagal('Buat akun: Budi tidak bisa membuat akun Wakil',
  $q$ select public.izin_buat_akun('wakil', tests.id('kel_a1')) $q$);
select tests.harus_gagal('Buat akun: Budi tidak bisa membuat akun Ketua Tim',
  $q$ select public.izin_buat_akun('ketua_tim', null, tests.id('tim_a')) $q$);
select tests.harus_gagal('Buat akun: Budi tidak bisa membuat akun tanpa tujuan',
  $q$ select public.izin_buat_akun('tanpa') $q$);
select tests.harus_gagal('Buat akun: Budi tidak bisa memanggil pengecek hak dengan tujuan aneh',
  $q$ select public.izin_buat_akun('raja', tests.id('kel_a1')) $q$);

-- Anggota biasa: tidak boleh sama sekali.
select tests.masuk_sebagai('u_andi');
select tests.harus_gagal('Buat akun: anggota biasa tidak bisa membuat akun',
  $q$ select public.izin_buat_akun('anggota', tests.id('kel_a1')) $q$);
select tests.masuk_sebagai_tamu();
select tests.harus_gagal('Buat akun: tamu tidak bisa membuat akun',
  $q$ select public.izin_buat_akun('anggota', tests.id('kel_a1')) $q$);

-- Ketua Tim: anggota/Pemimpin/Wakil di timnya.
select tests.masuk_sebagai('ketua_a');
select tests.harus_berhasil('Buat akun: Ketua Tim A boleh membuat akun anggota di kelompok timnya',
  $q$ select public.izin_buat_akun('anggota', tests.id('kel_a1')) $q$);
select tests.harus_berhasil('Buat akun: Ketua Tim A boleh membuat akun Pemimpin di kelompok timnya',
  $q$ select tests.simpan('izin_ketua', public.izin_buat_akun('pemimpin', tests.id('kel_a1'))::text) $q$);
select tests.harus_berhasil('Buat akun: Ketua Tim A boleh membuat akun Wakil di kelompok timnya',
  $q$ select public.izin_buat_akun('wakil', tests.id('kel_a1')) $q$);
select tests.harus_gagal('Buat akun: Ketua Tim A tidak bisa membuat akun anggota di tim B',
  $q$ select public.izin_buat_akun('anggota', tests.id('kel_b1')) $q$);
select tests.harus_gagal('Buat akun: Ketua Tim A tidak bisa membuat akun Pemimpin di tim B',
  $q$ select public.izin_buat_akun('pemimpin', tests.id('kel_b1')) $q$);
select tests.harus_gagal('Buat akun: Ketua Tim A tidak bisa membuat akun Ketua Tim',
  $q$ select public.izin_buat_akun('ketua_tim', null, tests.id('tim_a')) $q$);
select tests.harus_gagal('Buat akun: Ketua Tim A tidak bisa membuat akun Admin',
  $q$ select public.izin_buat_akun('admin') $q$);

-- Admin: semuanya.
select tests.masuk_sebagai('admin');
select tests.harus_berhasil('Buat akun: Admin boleh membuat akun Ketua Tim untuk tim mana pun',
  $q$ select public.izin_buat_akun('ketua_tim', null, tests.id('tim_b')) $q$);
select tests.harus_berhasil('Buat akun: Admin boleh membuat akun Pemimpin di kelompok mana pun',
  $q$ select public.izin_buat_akun('pemimpin', tests.id('kel_b1')) $q$);
select tests.harus_berhasil('Buat akun: Admin boleh membuat akun Admin',
  $q$ select tests.simpan('izin_admin', public.izin_buat_akun('admin')::text) $q$);
select tests.harus_berhasil('Buat akun: Admin boleh membuat akun tanpa tujuan',
  $q$ select public.izin_buat_akun('tanpa') $q$);
select tests.harus_gagal('Buat akun: Admin tetap wajib memilih kelompok untuk akun anggota',
  $q$ select public.izin_buat_akun('anggota', null) $q$);

-- Server membuat akun login; kode izin tersimpan di data akun.
select tests.keluar();
insert into auth.users (id, email, raw_user_meta_data) values
  (tests.id('baru_budi'),  'baru_budi@contoh.test',
   jsonb_build_object('nama', 'Anggota Baru', 'izin', (select teks from tests.nilai where nama = 'izin_budi'))),
  (tests.id('baru_ketua'), 'baru_ketua@contoh.test',
   jsonb_build_object('nama', 'Pemimpin Baru', 'izin', (select teks from tests.nilai where nama = 'izin_ketua'))),
  (tests.id('baru_liar'),  'baru_liar@contoh.test', jsonb_build_object('nama', 'Akun Lain')),
  (tests.id('baru_admin'), 'baru_admin@contoh.test',
   jsonb_build_object('nama', 'Admin Baru', 'izin', (select teks from tests.nilai where nama = 'izin_admin')));

select tests.masuk_sebagai('ketua_a');
select tests.harus_gagal('Pasang akun: Ketua Tim tidak bisa memakai izin milik Budi',
  $q$ select public.pasang_akun_baru((select teks from tests.nilai where nama = 'izin_budi')::uuid, tests.id('baru_budi')) $q$);

select tests.masuk_sebagai('budi');
select tests.harus_gagal('Pasang akun: izin tidak bisa dipasang ke akun yang tidak dibuat dengannya',
  $q$ select public.pasang_akun_baru((select teks from tests.nilai where nama = 'izin_budi')::uuid, tests.id('baru_liar')) $q$);
select tests.harus_berhasil('Pasang akun: Budi memasang akun baru sebagai anggota kelompoknya',
  $q$ select tests.simpan('anggota_baru', public.pasang_akun_baru((select teks from tests.nilai where nama = 'izin_budi')::uuid, tests.id('baru_budi'))::text) $q$);
select tests.harus_gagal('Pasang akun: izin tidak bisa dipakai dua kali',
  $q$ select public.pasang_akun_baru((select teks from tests.nilai where nama = 'izin_budi')::uuid, tests.id('baru_budi')) $q$);
select tests.keluar();
select tests.periksa('Pasang akun: profil anggota dibuat di Kelompok A1 dan tersambung ke akun',
  exists (select 1 from public.akun ak join public.anggota a on a.id = ak.anggota_id
          where ak.id = tests.id('baru_budi') and a.kelompok_id = tests.id('kel_a1')
            and a.nama_lengkap = 'Anggota Baru'
            and a.id::text = (select teks from tests.nilai where nama = 'anggota_baru')));
select tests.periksa('Pasang akun: pembuatan akun tercatat di log beserta pembuatnya',
  exists (select 1 from public.log_aktivitas where tindakan = 'buat_akun'
          and akun_id = tests.id('budi') and detail ->> 'akun_id' = tests.id('baru_budi')::text));

select tests.masuk_sebagai('ketua_a');
select tests.harus_berhasil('Pasang akun: Ketua Tim memasang akun baru sebagai Pemimpin Kelompok A1',
  $q$ select public.pasang_akun_baru((select teks from tests.nilai where nama = 'izin_ketua')::uuid, tests.id('baru_ketua')) $q$);
select tests.keluar();
select tests.periksa('Pasang akun: akun baru menjadi Pemimpin Kelompok A1',
  exists (select 1 from public.penugasan_peran where akun_id = tests.id('baru_ketua')
          and peran = 'pemimpin' and jabatan = 'pemimpin' and kelompok_id = tests.id('kel_a1')));

-- Izin kedaluwarsa (lebih dari 15 menit).
update internal.izin_buat_akun set dibuat_pada = now() - interval '20 minutes'
 where id = (select teks from tests.nilai where nama = 'izin_admin')::uuid;
select tests.masuk_sebagai('admin');
select tests.harus_gagal('Pasang akun: izin yang sudah lewat 15 menit ditolak',
  $q$ select public.pasang_akun_baru((select teks from tests.nilai where nama = 'izin_admin')::uuid, tests.id('baru_admin')) $q$);

-- Menghapus akun.
select tests.masuk_sebagai('budi');
select tests.harus_gagal('Hapus akun: Pemimpin tidak bisa menghapus akun',
  $q$ select public.hapus_akun(tests.id('u_cici'), 'U_Cici') $q$);
select tests.masuk_sebagai('ketua_a');
select tests.harus_gagal('Hapus akun: Ketua Tim tidak bisa menghapus akun',
  $q$ select public.hapus_akun(tests.id('u_cici'), 'U_Cici') $q$);
select tests.masuk_sebagai('admin');
select tests.harus_gagal('Hapus akun: Admin tidak bisa menghapus akunnya sendiri',
  $q$ select public.hapus_akun(tests.id('admin'), 'Admin') $q$);
select tests.harus_gagal('Hapus akun: nama yang diketik salah ditolak',
  $q$ select public.hapus_akun(tests.id('u_cici'), 'Cici salah') $q$);
select tests.harus_berhasil('Hapus akun: Admin menghapus akun Cici (profil tetap)',
  $q$ select public.hapus_akun(tests.id('u_cici'), (select nama_tampilan from public.akun where id = tests.id('u_cici'))) $q$);
select tests.harus_berhasil('Hapus akun: Admin menghapus akun anggota baru beserta profilnya',
  $q$ select public.hapus_akun(tests.id('baru_budi'), 'Anggota Baru', true) $q$);
select tests.harus_berhasil('Hapus akun: Admin menghapus akun Pemimpin baru',
  $q$ select public.hapus_akun(tests.id('baru_ketua'), 'Pemimpin Baru', true) $q$);
select tests.keluar();
select tests.periksa('Hapus akun: akun login dan baris akun Cici sudah hilang',
  not exists (select 1 from auth.users where id = tests.id('u_cici'))
  and not exists (select 1 from public.akun where id = tests.id('u_cici')));
select tests.periksa('Hapus akun: profil anggota Cici tetap ada (tanpa akun)',
  exists (select 1 from public.anggota where id = tests.id('cici')));
select tests.periksa('Hapus akun: profil anggota baru ikut terhapus bila dipilih',
  not exists (select 1 from public.anggota where id::text = (select teks from tests.nilai where nama = 'anggota_baru')));
select tests.periksa('Hapus akun: peran Pemimpin akun yang dihapus ikut hilang',
  not exists (select 1 from public.penugasan_peran where akun_id = tests.id('baru_ketua')));
select tests.masuk_sebagai('budi');
select tests.harus_berhasil('Penjaga persetujuan: Budi mencoba mengosongkan pencatat persetujuan Ani',
  $q$ update public.anggota set persetujuan_dicatat_akun = null where id = tests.id('andi') $q$);
select tests.keluar();
select tests.periksa('Penjaga persetujuan: pencatat yang akunnya masih ada tidak bisa dikosongkan',
  (select persetujuan_dicatat_akun is not null from public.anggota where id = tests.id('ani')));
select tests.periksa('Hapus akun: pencatat persetujuan Cici dikosongkan karena akunnya dihapus',
  (select persetujuan_dicatat_akun is null and persetujuan_pada is not null from public.anggota where id = tests.id('cici')));
select tests.periksa('Hapus akun: tercatat di log',
  (select count(*) from public.log_aktivitas where tindakan = 'hapus_akun' and akun_id = tests.id('admin')) = 3);


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
