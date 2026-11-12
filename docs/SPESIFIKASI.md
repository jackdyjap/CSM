# Spesifikasi Sistem Absensi Kelompok Kecil

Versi 1 · 12 November 2026 · Dokumen acuan untuk membangun sistem bersama Claude Code

## 1. Tujuan

Sistem web (bisa dibuka di HP) untuk mendata anggota kelompok kecil, mencatat kehadiran dan persembahan mingguan, membantu pemimpin menindaklanjuti anggota, dan memberi tim gambaran tentang kelompok di bawahnya. Struktur: satu **Tim** membawahi beberapa **Kelompok Kecil**, dan tiap kelompok memiliki **Anggota**.

Sebagian besar anggota masih perlu dibantu pemimpinnya, sehingga alur utama sistem adalah alur **pemimpin kelompok**. Jalur mandiri untuk anggota bersifat tambahan.

## 2. Peran dan hak akses

| Peran | Dapat melihat | Dapat mengubah |
| --- | --- | --- |
| Admin | Semua tim dan kelompok, isi catatan khusus, laporan demografi, daftar akun | Membuat tim, kelompok, akun, dan peran |
| Ketua Tim | Semua kelompok di timnya: anggota, absensi, persembahan, dan isi catatan khusus anggota | Hanya membaca (tidak mengubah absensi atau catatan) |
| Pemimpin Kelompok | Anggota, absensi, persembahan, dan catatan kelompoknya sendiri | Anggota, absensi, persembahan, catatan, dan proyek ketaatan kelompoknya |
| Anggota | Profil dan riwayat kehadiran dirinya sendiri | Profil dirinya sendiri, check-in lewat QR |

Catatan: anggota tidak dapat melihat catatan khusus tentang dirinya. Admin dan Ketua Tim dapat membaca isi catatan khusus.

## 3. Data yang disimpan

**Struktur**

- Tim: nama
- Kelompok: nama, tim induk
- Pengguna (akun): email atau nomor HP, peran, tim atau kelompok yang dikaitkan, anggota yang dikaitkan (bila peran Anggota)

**Anggota (profil)**

- Nama lengkap
- Gender: Laki-laki, Perempuan
- Foto
- Tempat lahir dan tanggal lahir (usia dihitung otomatis)
- Alamat lengkap (teks bebas)
- Lokasi terstruktur: Provinsi, Kota/Kabupaten, Kecamatan, Kelurahan (pilihan bertingkat)
- Status pernikahan: Single, Menikah, Duda, Janda
- Pendidikan terakhir: Tidak sekolah, SD, SMP, SMA/SMK, D3, S1, S2 ke atas
- Pekerjaan: Tidak bekerja, IRT, Karyawan, Wiraswasta, Pensiunan, Freelancer, Profesional
- Nomor HP (opsional), kode QR pribadi, kelompok
- Persetujuan data: tanggal persetujuan dan siapa yang mencatat (anggota sendiri atau pemimpin); status aktif atau tidak aktif beserta tanggal dinonaktifkan (ditandai otomatis setelah 3 bulan berturut-turut tidak hadir)

**Pertemuan dan kehadiran**

- Pertemuan: kelompok, tanggal, jumlah persembahan, catatan, jam buka dan tutup, kode QR pertemuan
- Kehadiran: pertemuan, anggota, status hadir atau tidak, waktu, cara (scan sendiri, scan pemimpin, manual), alasan tidak hadir

**Catatan dan proyek ketaatan**

- Catatan khusus: anggota, penulis, tanggal, jenis (alasan absen, proyek, umum), isi
- Proyek ketaatan: kelompok, judul, tanggal diberikan, tenggat
- Status proyek per anggota: belum, sedang dikerjakan, selesai, tidak dikerjakan, plus keterangan

**Log aktivitas:** siapa, kapan, dan apa untuk tindakan sensitif (membuat atau mengekspor laporan, membaca catatan, mengubah peran).

## 4. Fitur

### 4.1 Login dan undangan

- Login dengan email atau nomor HP dan kata sandi, dengan opsi pemulihan akun.
- Admin membuat tim, kelompok, dan akun pemimpin. Pemimpin mengundang anggota lewat tautan.
- Anggota tanpa HP tidak perlu akun. Pemimpin membuat dan mengelola profilnya.

### 4.2 Profil anggota

- Anggota mengubah profilnya sendiri, termasuk unggah foto (dikecilkan otomatis, maksimal 2 MB, disimpan privat).
- Pemimpin mengisi atau memperbarui profil anggotanya, termasuk mengambil foto langsung dengan kamera.
- Isian berupa menu pilihan untuk gender, status pernikahan, pendidikan, pekerjaan, dan wilayah.
- Penanda kelengkapan profil, dan pemimpin bisa melihat siapa yang datanya belum lengkap.

### 4.3 Absensi mingguan

- **Mode pertemuan (HP pemimpin):** daftar anggota, ketuk nama untuk menandai hadir.
- **QR kartu anggota:** pemimpin men-scan QR pribadi anggota (bisa dicetak sebagai kartu atau stiker).
- **QR pertemuan:** layar menampilkan QR yang berganti tiap 30 sampai 60 detik; anggota yang sudah login men-scan sendiri.
- Satu anggota hanya tercatat satu kali per pertemuan, dan hanya untuk kelompoknya sendiri.
- Setelah absensi ditutup, anggota yang tidak hadir muncul dengan pilihan alasan cepat (sakit, bekerja, keluarga, bepergian, tanpa kabar, lainnya) dan kolom catatan.
- Pekan dihitung Senin sampai Minggu.

### 4.4 Persembahan

- Jumlah persembahan diisi per pertemuan oleh pemimpin kelompok.
- Ringkasan per kelompok, per tim, dan per bulan tampil di dashboard tim.

### 4.5 Catatan khusus dan proyek ketaatan

- Pemimpin menulis catatan per anggota (alasan tidak hadir, proyek ketaatan yang tidak dikerjakan, catatan umum).
- Pemimpin membuat proyek ketaatan dengan tenggat, lalu menandai status tiap anggota.
- **Halaman tindak lanjut:** menampilkan anggota yang absen 2 sampai 3 pekan berturut-turut atau yang proyeknya belum selesai.
- Ketua tim dapat **membaca** isi catatan anggota di timnya. Admin dapat membaca isi catatan semua kelompok. Pemimpin kelompok menulis dan membaca catatan kelompoknya. Anggota tidak dapat melihat catatan tentang dirinya.

### 4.6 Dashboard Ketua Tim

- Daftar kelompok di bawah tim: jumlah anggota, status sudah atau belum lapor pekan ini, pertemuan terakhir, rata-rata kehadiran 4 pekan, total persembahan bulan ini.
- Dapat membuka detail kelompok: anggota, riwayat kehadiran, catatan.

### 4.7 Laporan demografi (khusus Admin)

- Cakupan: satu kelompok, satu tim, atau seluruh tim.
- Dimensi: gender, pendidikan terakhir, status pernikahan, pekerjaan, lokasi tempat tinggal, dan rentang usia.
- Tampilan: jumlah atau persentase (dapat dipilih), tabel dan grafik, tabel silang antar kelompok.
- Baris "Belum diisi" ditampilkan terpisah; persentase dihitung dari yang sudah mengisi.
- Ekspor ke Excel/CSV atau PDF. Setiap pembuatan dan ekspor laporan dicatat di log.
- Perhitungan dilakukan di database; layar hanya menerima angka ringkasan.

## 5. Aturan akses data (diterapkan di database)

Pembatasan akses wajib dipasang di database (Row Level Security), bukan hanya disembunyikan di tampilan.

- Anggota hanya dapat membaca dan mengubah baris profilnya sendiri, dan membaca kehadirannya sendiri.
- Pemimpin kelompok hanya dapat membaca dan menulis data dengan kelompok yang sama dengan miliknya.
- Ketua tim hanya dapat membaca data kelompok yang berada di bawah timnya.
- Catatan khusus: dapat dibaca oleh pemimpin kelompok terkait, ketua tim terkait, dan Admin; hanya pemimpin kelompok yang dapat menulis; anggota yang bersangkutan tidak dapat membacanya.
- Laporan demografi: hanya Admin.
- Foto disimpan di penyimpanan privat dengan tautan sementara, bukan tautan publik.

## 6. Privasi dan keamanan

- Data yang dicatat termasuk data pribadi (tanggal lahir, alamat, status pernikahan, foto, catatan). Perhatikan UU Pelindungan Data Pribadi (UU PDP).
- Minta persetujuan anggota saat profil pertama kali diisi, dengan penjelasan tujuan pencatatan. Untuk anggota yang dibantu pemimpin, catat bahwa persetujuan sudah diberikan.
- Untuk anggota di bawah 18 tahun, minta persetujuan orang tua atau wali.
- Sediakan cara memperbaiki atau menghapus data dan foto atas permintaan anggota. Data anggota yang tidak aktif disimpan paling lama satu tahun sejak dinonaktifkan, lalu dihapus otomatis beserta foto dan catatan khususnya.
- QR hanya berisi kode acak, tanpa data pribadi. QR pertemuan berganti berkala dan hanya berlaku selama pertemuan.
- Semua akses lewat HTTPS. Cadangan data berkala. Tinjauan keamanan oleh developer atau ahli sebelum dipakai luas.

## 7. Teknologi yang disarankan

- **Supabase:** login, database PostgreSQL, aturan akses (RLS), dan penyimpanan foto.
- **Next.js (web, responsif untuk HP):** tampilan dan scan QR lewat kamera peramban.
- **Hosting:** Vercel atau setara.
- Aplikasi mobile native bisa menyusul setelah versi web berjalan baik; Expo (React Native) adalah jalur yang paling mudah.

## 8. Urutan pembangunan

1. Proyek Supabase, tabel, peran, dan aturan akses.
2. Login, pengaturan peran, dan undangan.
3. Profil anggota (termasuk foto dan wilayah terstruktur) dan profil yang dibuat pemimpin.
4. Mode pertemuan pemimpin: absensi manual, alasan tidak hadir, dan persembahan.
5. Catatan khusus, proyek ketaatan, dan halaman tindak lanjut.
6. Dashboard Ketua Tim.
7. QR kartu anggota (pemimpin men-scan).
8. QR pertemuan yang berganti otomatis dan akun mandiri anggota.
9. Laporan demografi untuk Admin dan ekspor.
10. Uji akses dengan akun tiap peran, lalu pilot di satu tim sebelum dipakai luas.

## 9. Kriteria uji

- Pemimpin kelompok A tidak dapat membuka data, foto, atau catatan kelompok B, termasuk bila mencoba lewat alamat atau permintaan langsung.
- Ketua tim dapat membaca semua kelompok di timnya dan tidak dapat membaca kelompok tim lain.
- Anggota hanya dapat mengubah profil sendiri dan tidak dapat melihat catatan khusus tentang dirinya.
- Hanya Admin yang dapat membuka laporan demografi.
- Anggota tidak dapat check-in dua kali atau check-in ke kelompok lain.
- QR pertemuan yang sudah kedaluwarsa atau difoto dari layar tidak dapat dipakai.
- Anggota yang tidak hadir 3 bulan berturut-turut ditandai tidak aktif otomatis, dan datanya terhapus otomatis setelah satu tahun, termasuk foto dan catatan khususnya. Aplikasi nyaman dipakai di HP dengan koneksi lambat.

## 10. Prompt awal untuk Claude Code

> Saya pemula dan ingin membangun aplikasi web absensi kelompok kecil dengan Next.js dan Supabase. Baca dokumen spesifikasi ini terlebih dahulu. Mulai dengan rencana dan skema database lengkap dengan aturan akses (Row Level Security) untuk empat peran: admin, ketua tim, pemimpin kelompok, dan anggota. Jelaskan setiap langkah dengan bahasa sederhana, kerjakan satu fase per satu waktu sesuai bagian Urutan pembangunan, dan tunggu persetujuan saya sebelum menulis kode.

## 11. Keputusan yang sudah diambil

- Diputuskan: anggota tidak dapat melihat catatan khusus tentang dirinya.
- Diputuskan: Admin dan Ketua Tim dapat membaca isi catatan khusus; data anggota tidak aktif disimpan paling lama satu tahun.
- Diputuskan: sistem menandai anggota tidak aktif secara otomatis setelah tidak hadir selama 3 bulan berturut-turut.
