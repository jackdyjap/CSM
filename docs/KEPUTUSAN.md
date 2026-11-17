# Keputusan Proyek

Daftar keputusan yang sudah disetujui pemilik proyek, sebagai pelengkap `SPESIFIKASI.md`.

## Dari spesifikasi (bagian 11)

- Anggota tidak dapat melihat catatan khusus tentang dirinya.
- Admin dan Ketua Tim dapat membaca isi catatan khusus.
- Anggota otomatis ditandai tidak aktif setelah 3 bulan berturut-turut tidak hadir.
- Data anggota tidak aktif disimpan paling lama 1 tahun.

## Diputuskan saat Fase 1 (12 November 2026)

1. **Peran ganda boleh.** Satu orang boleh, misalnya, menjadi ketua tim sekaligus pemimpin kelompok. Haknya digabung.
2. **Pemimpin dan wakil.** Satu kelompok boleh punya pemimpin dan wakil, dengan **hak yang sama persis**. Kolom `jabatan` hanya untuk label tampilan.
3. **Aktif kembali otomatis.** Anggota tidak aktif yang ditandai hadir otomatis aktif lagi.
4. **Hapus total.** Setelah 1 tahun tidak aktif, data anggota dihapus total, termasuk riwayat kehadiran, catatan khusus, status proyek, dan foto.
5. **Zona waktu WIB** (Asia/Jakarta) untuk semua kelompok.

## Keputusan teknis (Fase 1)

- **Catatan khusus** hanya bisa diakses lewat fungsi (`tulis_catatan`, `ubah_catatan`, `hapus_catatan`, `baca_catatan`), supaya setiap pembacaan tercatat di log. **Tidak seorang pun** bisa membaca atau menulis catatan tentang dirinya sendiri, termasuk pemimpin yang juga terdaftar sebagai anggota.
- **Riwayat kehadiran anggota** dilihat lewat `riwayat_kehadiran_saya()`. Catatan alasan absen yang ditulis pemimpin tidak ditampilkan kepada anggota.
- **Persetujuan data (UU PDP).** Data pribadi baru bisa diisi setelah persetujuan tercatat. Siapa yang mencatat (anggota sendiri atau pemimpin) diisi otomatis. Anggota di bawah 18 tahun wajib memiliki nama wali.
- **QR pertemuan** berganti setiap 45 detik. Kode yang sedang tampil dan satu kode sebelumnya diterima, untuk memberi jeda bagi koneksi lambat. QR hanya berlaku untuk kelompok sendiri, pada hari pertemuan, selama pertemuan dibuka, dan sekali per anggota.
- **Penandaan tidak aktif** tidak berlaku bila kelompok sama sekali tidak mengadakan pertemuan dalam 3 bulan terakhir, dan tidak berlaku untuk anggota yang bergabung kurang dari 3 bulan.
- **Foto** disimpan di bucket privat `foto-anggota/<id anggota>/…` (maksimal 2 MB, jpeg/png/webp). Foto yang harus dihapus dicatat di `internal.antrean_hapus_foto`. Penghapusnya (Edge Function) belum dibuat.

## Diputuskan saat Fase 2 (12 November 2026)

6. **Login dengan email ATAU nomor HP, tanpa kode SMS (Cara B).**
   - Nomor HP diubah di belakang layar menjadi alamat pengganti `62xxxx@hp.invalid` (akhiran `.invalid` tidak pernah menerima email). Pengguna cukup mengetik nomor HP-nya.
   - Akun hanya dibuat lewat **tautan undangan** dari pemimpin (berlaku 7 hari, sekali pakai) atau oleh **Admin**.
   - **Lupa kata sandi:** pemimpin/wakil membuat **tautan atur ulang** (berlaku 24 jam, sekali pakai) untuk anggotanya, lalu mengirimkannya lewat WhatsApp. Admin bisa membuatnya untuk akun siapa saja. Pemimpin tidak bisa membuatnya untuk sesama staf, supaya tidak ada pengambilalihan akun pemimpin.
   - Verifikasi lewat SMS/WhatsApp (Cara A) bisa ditambahkan nanti.
   - Pemulihan mandiri lewat email belum diaktifkan, karena pengiriman email bawaan Supabase terbatas. Bila diperlukan, pasang layanan email sendiri (SMTP) terlebih dahulu.
7. **Kata sandi minimal 8 karakter.**

## Diputuskan saat Fase 3 (17 November 2026)

8. **Profil dianggap lengkap** bila semua isian terisi **kecuali nomor HP** (opsional): nama, gender, foto, tempat dan tanggal lahir, alamat, wilayah **sampai kelurahan**, status pernikahan, pendidikan, dan pekerjaan.
9. **Pemimpin bisa menambah anggota tanpa akun** (untuk yang tidak punya HP). Bila persetujuan belum dicatat saat itu, hanya nama yang disimpan; persetujuan bisa dicatat kemudian dari halaman profil anggota.

## Keputusan teknis (Fase 3)

- **Foto dikecilkan di HP** sebelum dikirim (sisi terpanjang 800 piksel, JPEG mutu 85%, biasanya 100–300 KB), lalu disimpan lewat server. Foto ditampilkan lewat tautan sementara yang berlaku 1 jam.
- Tombol **Ambil foto** membuka kamera depan untuk anggota (foto diri) dan kamera belakang untuk pemimpin (memotret anggota).
- **Ketua Tim dan Admin** melihat profil anggota dalam bentuk baca-saja.
- Daftar wilayah diambil per tingkat (provinsi → kota → kecamatan → kelurahan) hanya saat dibutuhkan, supaya ringan di koneksi lambat.

## Diputuskan saat Fase 4 (17 November 2026)

10. **Menutup absensi** menandai otomatis **tidak hadir** setiap anggota aktif yang belum ditandai hadir. Alasan boleh diisi belakangan. Anggota tidak aktif, dan anggota yang bergabung setelah tanggal pertemuan, tidak ikut ditandai.
11. **Tanggal pertemuan** boleh hari ini atau tanggal yang lalu (untuk mengejar catatan yang terlewat). Tanggal masa depan ditolak database.

## Keputusan teknis (Fase 4)

- Ketukan nama di mode pertemuan langsung tersimpan satu per satu, supaya tidak ada data hilang bila koneksi putus di tengah pertemuan.
- Absensi yang sudah ditutup bisa **dibuka kembali**. Menutup ulang tidak menggandakan data, dan alasan yang sudah diisi tetap tersimpan.
- Membatalkan tanda hadir saat absensi terbuka menghapus catatan kehadiran anggota itu; saat ditutup ia akan tercatat tidak hadir.
- Catatan alasan tidak hadir hanya terlihat oleh pengurus (bukan oleh anggota), sesuai aturan Fase 1.
- Halaman pertemuan saat ini khusus pemimpin/wakil. Tampilan untuk Ketua Tim menyusul di Fase 6.

## Diputuskan 17 November 2026 (setelah uji coba pertama)

12. **Admin mengelola semua kelompok.** Admin boleh melihat **dan mengubah** anggota, profil, foto, undangan, pertemuan, absensi, persembahan, dan proyek ketaatan di semua tim dan kelompok, tanpa harus diberi peran pemimpin. Ini mengubah tabel peran di spesifikasi bagian 2, yang sebelumnya hanya memberi Admin hak membuat tim, kelompok, akun, dan peran.
    - **Catatan khusus tidak berubah:** hanya pemimpin/wakil kelompoknya yang menulis. Admin dan Ketua Tim membaca saja.
    - **Ketua Tim tidak berubah:** hanya melihat kelompok di timnya.
    - Teknis: `bantu.kelompok_dipimpin()` kini juga mengembalikan semua kelompok bila pengguna Admin (migrasi `…0800`). Fungsi catatan memakai pemeriksa terpisah `bantu.boleh_tulis_catatan()`.
13. **Setiap salah input bisa dikoreksi** oleh Admin dan pemimpin/wakil (Ketua Tim tetap hanya melihat):
    - Admin: ubah nama/hapus **tim** (hapus hanya bila tidak punya kelompok); ubah nama/**pindah tim**/hapus **kelompok**; ubah **nama akun**; **pindah anggota** ke kelompok mana pun.
    - Admin dan pemimpin: **hapus anggota**, tandai **aktif/tidak aktif** secara manual, **ubah tanggal** dan hapus pertemuan.
14. **Hapus kelompok beserta isinya** (anggota, pertemuan, absensi, persembahan, proyek, catatan) hanya oleh Admin, setelah **mengetik nama kelompok persis**. Akun login anggota tidak ikut terhapus. Tercatat di log (`hapus_kelompok_total`).
15. **Catatan khusus yang salah tulis** boleh diubah/dihapus oleh pemimpin kelompoknya **dan Admin**. Menulis catatan baru tetap hanya pemimpin/wakil.
16. **Bukti transfer persembahan**: opsional (boleh menyusul); foto atau PDF, maksimal 5 berkas per pertemuan dan 5 MB per berkas; dilihat pemimpin/wakil, Ketua Tim terkait, dan Admin; diunggah/dihapus oleh pemimpin/wakil dan Admin; anggota tidak melihat. Disimpan di folder privat `bukti-persembahan/<id pertemuan>/`, dibuka lewat tautan sementara 1 jam. Foto dikecilkan di HP (sisi terpanjang 1600 piksel) dan berkas dikirim **langsung dari peramban ke Supabase Storage** (batas kiriman lewat server Vercel sekitar 4,5 MB); server hanya mencatat daftarnya. Daftar pertemuan menandai "Bukti belum ada" bila ada persembahan tanpa bukti.

## Diputuskan saat Fase 5 (17 November 2026)

17. **Tindak lanjut** (fungsi `tindak_lanjut`, migrasi `…1100`):
    - **Absen**: anggota aktif yang tidak hadir di **3 pertemuan berturut-turut**, dihitung dari pertemuan yang absensinya sudah ditutup. Batasnya bisa diubah (parameter `p_batas_absen`).
    - **Proyek**: masuk daftar **setelah tenggat lewat** bila belum "Selesai"; status "Tidak dikerjakan" langsung masuk daftar. Anggota yang bergabung setelah proyek diberikan hanya dihitung bila sudah diberi status.
    - Dilihat oleh pemimpin/wakil, Ketua Tim terkait, dan Admin (dipakai juga untuk dashboard Fase 6).
18. **Admin boleh menulis catatan khusus** di semua kelompok, tidak hanya membaca dan mengoreksi (mengubah keputusan 12 dan 15). Ketua Tim tetap hanya membaca; tidak seorang pun bisa menulis atau membaca catatan tentang dirinya sendiri. (Migrasi `…1200`.)
19. **Profil anggota menampilkan status semua proyek ketaatan** anggota itu, dan pengelola (pemimpin/wakil/Admin) bisa langsung mengubahnya di sana. Ketua Tim membaca saja. Tampilan per proyek tetap ada.

## Diputuskan saat Fase 6 (17 November 2026)

20. **Dashboard Ketua Tim** (`/tim/[id]`, fungsi `ringkasan_tim`, migrasi `…1300`): per kelompok ditampilkan anggota aktif, status lapor pekan ini, pertemuan terakhir, rata-rata kehadiran 4 pekan, persembahan bulan ini, dan jumlah tindak lanjut.
    - **"Sudah lapor"** = ada pertemuan pekan ini (Senin–Minggu WIB) yang absensinya **sudah ditutup**; pertemuan yang masih terbuka = "Sedang berlangsung".
    - **Kehadiran 4 pekan** = jumlah hadir ÷ jumlah tercatat, dari pertemuan yang ditutup dalam 28 hari terakhir.
    - **Persembahan bulan ini** = bulan kalender WIB.
    - Dibuka oleh Ketua Tim dari tim itu dan Admin.
21. **Ketua Tim membuka detail kelompok di timnya dalam mode baca saja**: anggota dan profil (termasuk catatan dan status proyek), pertemuan (hadir, tidak hadir dan alasannya, persembahan, bukti transfer), proyek, dan tindak lanjut. Semua tombol ubah disembunyikan; database tetap menolak perubahan dari Ketua Tim.

## Diputuskan saat Fase 7 (17 November 2026)

22. **QR kartu anggota**:
    - Kartu **seukuran KTP** (85,6 × 54 mm), **8 per lembar A4**, berisi nama, kelompok, dan QR. Dicetak dari `/kelompok/[id]/kartu` (semua anggota aktif) atau dari profil anggota (satu kartu).
    - Isi QR = `CSM-K:` + kode acak 32 karakter (tanpa data pribadi). Awalan membedakannya dari QR pertemuan (Fase 8).
    - Anggota yang punya akun melihat **Kartu saya** di Profil saya, untuk ditunjukkan dari HP.
    - Pemimpin/wakil dan Admin men-scan di mode pertemuan (**Scan kartu QR**). Kartu kelompok lain ditolak; pertemuan yang absensinya sudah ditutup ditolak (migrasi `…1400`).
    - **Kartu hilang**: pemimpin/wakil atau Admin membuat ulang kode (`buat_ulang_kode_kartu`, tercatat di log); kartu lama langsung tidak berlaku.
    - Pustaka: `qrcode` 1.5.4 (membuat QR, di server) dan `qr-scanner` 1.4.2 (membaca dari kamera, di peramban), keduanya MIT.

## Diputuskan saat Fase 8 (17 November 2026)

23. **QR pertemuan dan check-in mandiri**:
    - Pemimpin/wakil atau Admin menampilkan **QR pertemuan** (layar penuh) dari mode pertemuan **hari ini**. QR berganti tiap 45 detik (aturan Fase 1), dengan hitung mundur dan penghitung "Hadir X dari Y" yang diperbarui tiap 5 detik. Layar dijaga tetap menyala bila peramban mendukung.
    - QR berisi **alamat** `…/hadir?k=<kode>`, sehingga anggota cukup memindainya dengan **kamera HP biasa / Google Lens**. Tombol "Scan QR pertemuan" juga tersedia di aplikasi.
    - Pencatatan dijalankan dari HP **setelah halaman terbuka** (bukan saat alamat dimuat), supaya pratinjau tautan tidak ikut mencatat kehadiran.
    - Pengguna yang belum login diarahkan ke halaman masuk lalu **kembali ke halaman tujuan** (`?lanjut=`). Hanya jalur di dalam aplikasi yang diterima (pencegahan *open redirect*).
    - **Riwayat kehadiran** (12 pertemuan terakhir) tampil di Profil saya: hadir/tidak, cara, dan kategori alasan. Catatan pemimpin tidak ditampilkan.
