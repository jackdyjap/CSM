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

## Diputuskan saat Fase 9 (17 November 2026)

24. **Laporan demografi** (`/admin/laporan`, khusus Admin):
    - Dimensi: gender, rentang usia, pendidikan, status pernikahan, pekerjaan, provinsi, kota, kecamatan, kelurahan. Cakupan: semua tim, satu tim, atau satu kelompok. Anggota aktif saja atau semua. Tampilan jumlah atau persen.
    - Angka dihitung di database (`laporan_demografi`, per kelompok); aplikasi hanya menjumlahkan. "Belum diisi" dipisah; persen dihitung dari yang sudah mengisi.
    - Tampilan: grafik batang horizontal satu warna (biru `#2a78d6`, gelap `#3987e5`, divalidasi kontras ≥ 3:1) dengan nilai di ujung batang dan tooltip; tabel silang kategori × kelompok dengan gradasi satu warna.
    - Ekspor **Excel (.xlsx)**: lembar Ringkasan, Tabel silang (jumlah), Tabel silang (persen). Dipilih .xlsx, bukan CSV, karena Excel berbahasa Indonesia sering salah membaca pemisah CSV. **PDF** lewat Cetak / Simpan PDF. Setiap pembuatan dan ekspor tercatat di log.
    - Pustaka `exceljs` 4.4.0 (MIT). Ketergantungannya `uuid` dipaksa ke 11.1.1 (`overrides` di package.json) untuk menutup GHSA-w5hq-g745-h8pq; exceljs hanya memakai `uuid.v4`, dan pembuatan/pembacaan xlsx sudah diuji dengan versi itu.

## Diputuskan 18 November 2026

25. **Masuk dengan nama pengguna, email, ATAU nomor HP** (memperluas keputusan 6; tetap tanpa SMS).
    - Satu akun boleh punya ketiganya; masuk cukup dengan salah satunya. **Minimal satu** harus ada. Nama pengguna **tidak wajib**.
    - Ketiganya **unik**. Huruf besar/kecil dianggap sama; nomor HP disimpan dalam bentuk baku `628…`, jadi `0812…`, `+62 812…`, dan `812…` dihitung sama.
    - Nama pengguna: 3–30 karakter, huruf kecil/angka/titik/garis bawah, **diawali huruf** (sehingga tidak tertukar dengan email atau nomor HP).
    - Diisi saat daftar lewat undangan, saat Admin membuat akun, dan bisa diubah sendiri di **Profil saya → Cara masuk** (staf tanpa profil: **Akun saya**). Admin bisa mengubahnya di Akun & peran.
    - **Nomor HP login = nomor HP di profil anggota** (disamakan). Mengubah salah satunya ikut mengubah yang lain. Nomor HP profil juga unik dan tidak boleh sama dengan nomor login akun orang lain.
        - Nomor HP yang dipakai masuk tidak bisa dihapus bila akun tidak punya email/nama pengguna.
        - Nomor HP login seorang **pemimpin/staf** hanya bisa diubah orangnya sendiri atau Admin.
        - Saat migrasi: nomor dobel di profil dikosongkan kecuali satu (yang terhubung ke akun, lalu yang paling lama) dan dicatat di log (`hp_ganda_dikosongkan`); bila nomor profil dan nomor login berbeda, nomor login yang dipakai.
    - Server mencari alamat login lewat `layanan_cari_login` (khusus server). Pesan gagal masuk sama untuk "tidak terdaftar" dan "kata sandi salah". Migrasi `…1500`.
26. **Kartu anggota memuat foto dan nomor HP** selain nama, kelompok, dan QR (mengubah keputusan 22), baik kartu cetak maupun Kartu saya di HP. Isi QR tetap kode acak tanpa data pribadi. Karena kartu kini memuat data pribadi, halaman cetak mengingatkan agar kartu disimpan dan dibagikan dengan hati-hati.
27. **Atur profil sendiri untuk semua peran** (halaman `/profil`, migrasi `…1600`).
    - Setiap akun mengubah sendiri: **kata sandi** (tanpa kata sandi lama), **nama**, **cara masuk** (keputusan 25), **foto**, dan **data pribadi**.
    - **Login pertama**: semua akun (termasuk akun lama) diarahkan ke Atur profil sampai menekan **Selesai**. Akun yang dibuat Admin memakai **kata sandi sementara** yang wajib diganti dulu. Data pribadi boleh dilengkapi nanti. Halaman check-in (`/hadir`) tetap bisa dibuka.
    - **Profil staf** (tabel `profil_staf`): Admin, Ketua Tim, dan Pemimpin yang bukan anggota kelompok punya foto dan data pribadi sendiri (isian sama dengan profil anggota, nomor HP ada di cara masuk). Diisi setelah menyetujui pencatatan data; hanya dibaca orangnya sendiri dan Admin; tidak ikut absensi atau laporan demografi. Foto di `foto-anggota/staf/<id akun>/`.
    - Anggota mengubah nama lewat Nama lengkap di profilnya; **nama akun mengikuti** nama lengkap itu.
28. **Masukan: keluhan, permasalahan, usulan perbaikan** (`/masukan`, `/masukan/masuk`, migrasi `…1700`).
    - Semua peran bisa mengirim. Pengirim memilih **jenis** (Keluhan, Permasalahan, Usulan perbaikan) dan **tujuan**:
        - **Pemimpin kelompok**: hanya anggota kelompok itu.
        - **Ketua tim** dari kelompoknya: anggota, atau pemimpin/wakil kelompok itu.
        - **Admin**: siapa saja.
    - Boleh **tanpa nama**: penerima tidak melihat nama pengirim, tetapi pengirim tetap membaca balasan. Database tetap mencatat pengirimnya; hanya Admin yang bisa melihatnya (untuk menangani penyalahgunaan).
    - Penerima memberi **status** (Baru, Sedang ditangani, Selesai) dan **balasan** yang dibaca pengirim. Pemimpin/wakil menerima masukan untuk kelompoknya, ketua tim untuk timnya. **Admin membaca dan menanggapi semua masukan.**
    - Tabel `masukan` tidak bisa dibaca langsung; semua lewat loket database, supaya pengirim anonim tidak bocor. Pengiriman dan tanggapan tercatat di log (tanpa isi).
    - Beranda: kotak **Masukan**, dengan jumlah masukan baru untuk penerima.
29. **Isian Baptis (Sudah/Belum)** di profil anggota dan profil staf, tanpa tanggal atau tempat (migrasi `…1800`).
    - Termasuk data pribadi: diisi setelah persetujuan. **Wajib** untuk label "Lengkap"; pilihan "Belum" dihitung sudah diisi.
    - Menjadi dimensi **Laporan demografi** (Sudah, Belum, Belum diisi).
    - Label pendidikan **D3 diganti "Diploma"** (nilai tersimpan tetap `d3`, jadi data lama tidak berubah). Pilihan status pernikahan tetap: Single, Menikah, Duda, Janda.
30. **Status jemaat dan data jemaat oleh Ketua Tim** (mengubah keputusan 21).
    - Isian baru **Status jemaat**: Tamu, Member, Pelayan, Leader. Juga menjadi dimensi Laporan demografi.
    - Kotak **Data jemaat** di profil anggota berisi **Status jemaat, Gender, dan Aktif/Tidak aktif**. Bisa diubah oleh **Pemimpin/Wakil** kelompok itu, **Ketua Tim** dari tim itu, dan **Admin** (loket `ubah_data_jemaat`, tercatat di log). Tombol "Tandai tidak aktif" yang lama dipindah ke kotak ini.
    - Ketua Tim tetap **hanya membaca** isian profil yang lain.
    - Anggota **tidak bisa** mengubah status jemaatnya sendiri. Gender tetap baru bisa diisi setelah persetujuan data.
31. **Laporan demografi: dimensi Generasi** menurut tahun lahir (migrasi `…1900`). Gen Beta 2025–, Gen Alpha 2013–2024, Gen Z 1997–2012, Gen Y/Milenial 1981–1996, Gen X 1965–1980, Baby Boomers 1946–1964, Silent Generation ≤1945 (Pew Research; Alpha dan Beta menurut McCrindle). Diurutkan dari yang termuda. Batas tahun cukup diubah di `internal.generasi`.
32. **Laporan demografi: tampilan Ringkasan** (bawaan saat laporan dibuka). Lima info sekaligus, masing-masing dengan grafik dan jumlah "sudah mengisi/belum diisi": **Baptis, Pendidikan terakhir, Status pernikahan, Status jemaat, Generasi**. Cakupan, anggota aktif/semua, dan jumlah/persen berlaku untuk kelimanya. Ekspor Excel berisi satu lembar per info (ringkasan + jumlah per kelompok). Dimensi lain tetap bisa dipilih satu per satu dengan tabel silang. Tidak ada perubahan database.
33. **Kembali otomatis setelah menyimpan.** Di halaman detail, setelah input/update berhasil, pesan "tersimpan" tampil sekitar 1 detik lalu layar kembali ke layar sebelumnya. Berlaku untuk: profil anggota (Data diri), Data jemaat, Atur profil (nama, cara masuk, data pribadi, kata sandi), catatan khusus (tulis/ubah), ubah proyek, kirim masukan, dan tanggapi masukan.
    - **Tetap di halaman**: pembuatan tautan undangan/atur ulang (tautannya harus dibagikan dulu), mode pertemuan, daftar Admin (tim, kelompok, akun, peran), persetujuan data (formulir profil baru muncul sesudahnya), dan Atur profil saat login pertama (harus menekan Selesai).
    - Bila halaman dibuka langsung dari tautan (tidak ada layar sebelumnya di aplikasi), tujuan cadangannya Beranda, halaman kelompok, atau daftar proyek.
34. **Atur ulang kata sandi per peran** (memperluas keputusan 6; migrasi `…2000`). Caranya tetap tautan 24 jam sekali pakai.
    - **Admin**: semua akun (untuk dirinya sendiri lewat Atur profil → Ganti kata sandi).
    - **Ketua Tim**: anggota **dan** Pemimpin/Wakil kelompok di timnya; lewat kotak **Atur ulang kata sandi** di halaman kelompok. Tidak untuk Admin, Ketua Tim mana pun, atau pengurus yang juga memegang peran di luar timnya.
    - **Pemimpin/Wakil**: anggota kelompoknya yang bukan pengurus (seperti sebelumnya); sesama pengurus kelompok tidak saling reset. Tombol hanya tampil untuk akun yang boleh di-reset.
35. **Memasukkan akun yang belum tergabung ke kelompok** (migrasi `…2100`). Akun belum tergabung = akun tanpa profil anggota (dibuat Admin, kelompoknya dihapus, atau profilnya terhapus otomatis); akun pengurus juga boleh dimasukkan sebagai anggota.
    - Tombol **"+ Masukkan akun yang sudah ada"** di halaman kelompok. **Pemimpin/Wakil**: ke kelompoknya; **Ketua Tim**: ke kelompok di timnya; **Admin**: ke kelompok mana pun.
    - Pemimpin dan Ketua Tim mencari dengan **nama pengguna, email, atau nomor HP yang persis** (data kontak tidak bisa dijelajah); **Admin** juga melihat daftar lengkap.
    - **Langsung masuk** tanpa konfirmasi pemilik akun; profil anggota dibuat dengan nama akunnya dan tercatat di log. Data pribadi tetap baru bisa diisi setelah persetujuan data. Akun yang sudah tergabung dipindah lewat *Pindah ke kelompok lain*.
36. **Anggota melaporkan sendiri proyek ketaatannya** (migrasi `…2200`). Pilihan: **Belum dijalankan** + alasan (wajib), **Sedang dijalankan**, atau **Sudah selesai** + hasil yang didapat (wajib).
    - Berlaku untuk setiap anggota, termasuk pemimpin yang terdaftar sebagai anggota kelompoknya (lewat *Masukkan akun yang sudah ada*, keputusan 35).
    - Anggota hanya membaca proyek kelompoknya dan laporan **miliknya sendiri**. Alasan/hasil dibaca pemimpin/wakil, Ketua Tim, dan Admin di halaman proyek dan profil anggota, dengan tanda "dilaporkan sendiri".
    - Pemimpin/Wakil dan Admin **tetap boleh mengubah** status (termasuk "Tidak dikerjakan"); yang terakhir mengubah tercatat. Alasan hanya disimpan untuk status Belum, hasil hanya untuk Selesai.
37. **Notifikasi proyek ketaatan di Beranda.** Proyek yang belum "Sudah selesai" tampil di Beranda setiap anggota; yang belum pernah dilaporkan ditandai **"Baru"**, dan laporannya bisa langsung diisi di sana. Ini notifikasi di dalam aplikasi; notifikasi ke HP (push/WhatsApp otomatis) belum ada.
38. **Laporan proyek ketaatan untuk Admin** (`/admin/laporan-proyek`, migrasi `…2300`). Cakupan: semua tim, satu tim, atau satu kelompok.
    - Isi: **Ringkasan** (jumlah dan persen penugasan: Sudah selesai, Sedang dijalankan, Belum dijalankan, Tidak dikerjakan, **Belum dilaporkan**), **Per kelompok** (persen selesai), dan **Per proyek** (setiap anggota dengan statusnya, hasil/alasan, catatan pemimpin, dan tanda "diisi pemimpin").
    - Penugasan = proyek × anggota aktif, ditambah anggota tidak aktif yang sudah punya status. "Belum dilaporkan" = belum ada status sama sekali.
    - **Cetak / simpan PDF** lewat dialog cetak. Pembuatan dan ekspor tercatat di log. Khusus Admin.
39. **Bahan diskusi PDF dari Admin untuk pengurus** (`/admin/bahan` untuk Admin, `/bahan` untuk pengurus; migrasi `…2400`).
    - **Admin** mengunggah, mengubah (judul, tanggal dipakai, keterangan, tujuan), dan menghapus. Berkas PDF maksimal **10 MB**, diunggah langsung dari peramban ke folder privat `bahan-diskusi`.
    - Tujuan per bahan: **semua tim** atau **satu tim**. Dibuka dan diunduh oleh **Ketua Tim** dan **Pemimpin/Wakil** kelompok di tim itu (tautan sementara 1 jam).
    - **Anggota biasa tidak punya akses**, baik daftar maupun berkasnya (diperiksa database dan aturan penyimpanan).
    - Unggah dan hapus tercatat di log; berkas yang dihapus ikut dibersihkan.
40. **Penghapus berkas otomatis** (migrasi `…2500`; melengkapi keputusan 3 dan 4 tentang foto yang belum punya penghapus).
    - Berkas di antrean `internal.antrean_hapus_foto` (foto, bukti transfer, bahan diskusi) dihapus dari penyimpanan **setiap malam pukul 02.00 WIB** oleh Vercel Cron (`vercel.json` → `/api/tugas/hapus-berkas`), setelah tugas tandai-tidak-aktif dan hapus-data-kedaluwarsa.
    - Alamat itu hanya menerima permintaan dengan kunci rahasia **`CRON_SECRET`** (pengaturan Vercel). Tanpa kunci → ditolak.
    - **Pengaman**: database hanya memberikan berkas yang sudah tidak dipakai data mana pun; berkas di folder yang tidak dikenal tidak pernah dihapus. Berkas yang gagal dihapus tetap di antrean dan dicoba lagi.
    - Halaman Admin → Tim & kelompok menampilkan jumlah berkas di antrean dan tombol **Hapus sekarang**. Tercatat di log.

## Diputuskan 19 November 2026

41. **Admin bisa menghapus akun** (Akun & peran → *Hapus akun*; loket `hapus_akun`, migrasi `…2600`).
    - Hanya Admin, setelah **mengetik nama akun persis**. Admin tidak bisa menghapus akunnya sendiri.
    - Akun login, semua perannya, profil staf, dan tautan atur ulangnya ikut terhapus; orangnya tidak bisa masuk lagi.
    - Admin **memilih** lewat kotak centang apakah **profil anggotanya ikut dihapus** (beserta riwayat hadir, proyek, dan catatan). Bila tidak dicentang, profilnya tetap ada sebagai **anggota tanpa akun**.
    - Tercatat di log (`hapus_akun`). "Siapa yang mencatat persetujuan data" di profil anggota dikosongkan bila akun pencatatnya dihapus (tanggal persetujuannya tetap).
42. **Pengurus bisa membuat akun baru langsung dengan tujuannya** (mengubah keputusan 8 dan bagian 2 spesifikasi, yang sebelumnya hanya mengizinkan undangan atau Admin; migrasi `…2600`).
    - **Pemimpin/Wakil**: akun anggota untuk **kelompoknya sendiri**.
    - **Ketua Tim**: akun **anggota, Pemimpin, atau Wakil** untuk kelompok di **timnya**.
    - **Admin**: semua di atas untuk kelompok mana pun, **Ketua Tim** untuk tim mana pun, **Admin**, atau **tanpa tujuan dulu**.
    - Tombol **"+ Buat akun baru"** di halaman kelompok; formulir Admin di Akun & peran. Isiannya: nama, cara masuk (minimal satu), dan **kata sandi sementara** yang wajib diganti saat login pertama (keputusan 27).
    - Akun anggota langsung mendapat profil anggota dengan nama akunnya. Data pribadinya tetap baru bisa diisi setelah persetujuan data.
    - Hak diperiksa database dua kali (`izin_buat_akun` sebelum akun dibuat, `pasang_akun_baru` sesudahnya). Kode izin berlaku 15 menit, sekali pakai, dan hanya untuk akun yang dibuat dengannya. Bila pemasangan gagal, akun yang baru dibuat dibatalkan. Tercatat di log (`buat_akun`) beserta pembuatnya.
    - Tautan undangan tetap bisa dipakai seperti sebelumnya.
43. **Laporan demografi: wilayah cukup sampai provinsi** (mengubah daftar dimensi di keputusan 24). Pilihan Kota/Kabupaten, Kecamatan, dan Kelurahan/Desa dihapus dari laporan dan ekspor Excel; tautan lama ke pilihan itu menampilkan laporan Gender. **Isian profil tidak berubah**: wilayah tetap diisi sampai kelurahan dan tetap menjadi syarat profil lengkap (keputusan 8). Database tidak diubah.

## Diputuskan 20 November 2026

44. **Nama aplikasi: "Absensi CSM".** Prototipe lama "Absensi Kelompok Kecil" (data hanya di peramban) dihapus; hanya ada satu aplikasi, yaitu absensi-csm.vercel.app.
45. **Pesan galat yang jelas dan bisa dilacak.**
    - Bila Supabase Auth menolak pembuatan akun (undangan atau dibuat pengurus), alasannya ditampilkan dengan bahasa sederhana (mis. kata sandi terlalu lemah, perlu mengisi email) dan alasan aslinya dicatat di Logs Vercel.
    - Formulir pendaftaran lewat undangan tidak dikosongkan bila gagal.
    - "Selesai, ke Beranda" dan pendaftaran lewat undangan membuka halaman tujuan dengan muat ulang penuh (bukan pengalihan di dalam aksi).
    - Halaman yang gagal dimuat menampilkan layar "Halaman belum bisa dibuka" berbahasa Indonesia dengan tombol Coba lagi, Ke Beranda, dan kode kesalahan untuk dicocokkan di Logs Vercel.
46. **Respons sentuhan lebih cepat terasa.** Tombol dan tautan-tombol langsung mengecil sedikit saat disentuh; jeda ketuk-ganda di HP dimatikan (`touch-action: manipulation`); saat pindah halaman langsung tampil "Memuat…" (`src/app/loading.tsx`); tombol Keluar menampilkan "Keluar…" selama diproses. Server aplikasi Vercel dipindah ke **Sydney (`syd1`)**, sama dengan database Supabase proyek **CSM** (`ap-southeast-2`, Sydney), lewat `regions` di `vercel.json`, supaya setiap bolak-balik ke database tidak menyeberang benua.
47. **Daftar lewat undangan untuk profil yang sudah punya nomor HP.** Bila pemimpin sudah membuat profil anggota beserta nomor HP-nya lalu mengirim undangan, dan anggota mendaftar dengan nomor yang sama, nomor itu **tidak** dikirim saat akun dibuat (`src/lib/buat-akun.ts`). Sebelumnya database menolaknya ("sudah terdaftar atas nama orang lain") karena akun belum tersambung ke profil, sehingga muncul "Akun gagal dibuat karena ada masalah di database". Setelah undangan dipakai, nomor HP akun terisi otomatis dari profil. Database tidak diubah; diuji di `supabase/tests/uji_akses.sql`.
