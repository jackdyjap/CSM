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
