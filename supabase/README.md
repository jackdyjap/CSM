# Database — Fase 1

Isi folder ini:

| File | Isi |
|---|---|
| `migrations/…0100_tabel.sql` | Semua tabel dan daftar pilihan |
| `migrations/…0200_fungsi_pembantu.sql` | Fungsi pengecek peran yang dipakai aturan akses |
| `migrations/…0300_aturan_akses.sql` | Aturan akses (RLS) di setiap tabel dan folder foto |
| `migrations/…0400_fungsi_khusus.sql` | Penjaga data (trigger) dan loket khusus: catatan, check-in QR, laporan demografi |
| `migrations/…0500_tugas_otomatis.sql` | Penandaan tidak aktif dan penghapusan data setelah 1 tahun, tiap malam |
| `migrations/…0600_login_undangan.sql` | Fase 2: akun otomatis, undangan, tautan atur ulang kata sandi |
| `migrations/…0700_mode_pertemuan.sql` | Fase 4: tanggal pertemuan tidak boleh di masa depan, loket `tutup_pertemuan` |
| `migrations/…0800_admin_kelola_semua.sql` | Admin mengelola semua kelompok (kecuali menulis catatan khusus) |
| `migrations/…0900_koreksi_data.sql` | Koreksi data: nama akun oleh Admin, hapus kelompok beserta isinya, koreksi catatan |
| `migrations/…1000_bukti_persembahan.sql` | Bukti transfer persembahan: folder privat, tabel, aturan akses |
| `migrations/…1100_tindak_lanjut.sql` | Fase 5: fungsi `tindak_lanjut` (absen berturut-turut, proyek lewat tenggat) |
| `migrations/…1200_admin_tulis_catatan.sql` | Admin boleh menulis catatan khusus (keputusan 18) |
| `migrations/…1300_ringkasan_tim.sql` | Fase 6: fungsi `ringkasan_tim` untuk dashboard Ketua Tim |
| `migrations/…1400_kartu_qr.sql` | Fase 7: buat ulang kode kartu; scan kartu menolak pertemuan yang sudah ditutup |
| `migrations/…1500_login_fleksibel.sql` | Masuk dengan nama pengguna, email, atau nomor HP (keputusan 25) |
| `migrations/…1600_atur_profil.sql` | Atur profil sendiri, profil staf, login pertama (keputusan 27) |
| `migrations/…1700_masukan.sql` | Masukan: keluhan, permasalahan, usulan (keputusan 28) |
| `migrations/…1800_baptis_status_jemaat.sql` | Baptis, status jemaat, data jemaat oleh Ketua Tim (keputusan 29–30) |
| `migrations/…1900_laporan_generasi.sql` | Laporan demografi: dimensi Generasi (keputusan 31) |
| `migrations/…2000_reset_ketua_tim.sql` | Atur ulang kata sandi oleh Ketua Tim (keputusan 34) |
| `migrations/…2100_masukkan_akun.sql` | Memasukkan akun yang belum tergabung ke kelompok (keputusan 35) |
| `migrations/…2200_laporan_proyek.sql` | Anggota melaporkan sendiri proyek ketaatan (keputusan 36) |
| `migrations/…2300_laporan_proyek_admin.sql` | Laporan proyek ketaatan untuk Admin (keputusan 38) |
| `migrations/…2400_bahan_diskusi.sql` | Bahan diskusi PDF untuk pengurus (keputusan 39) |
| `migrations/…2500_penghapus_berkas.sql` | Penghapus berkas otomatis (keputusan 40) |
| `migrations/…2600_buat_hapus_akun.sql` | Pengurus membuat akun, Admin menghapus akun (keputusan 41–42) |
| `migrations/…2700_kurangi_data_sensitif.sql` | Tahun lahir, wilayah sampai kota/kabupaten; data lama dihapus (keputusan 46) |
| `data/wilayah_01..04.sql` | Data wilayah Indonesia (Kepmendagri 2025) |
| `tests/uji_akses.sql` | 328 uji akses untuk semua peran (data uji dibatalkan otomatis di akhir) |
| `tests/lokal/` | Alat untuk menjalankan uji di komputer tanpa Supabase |

## Menjalankan di proyek Supabase

1. Buka proyek di supabase.com, lalu buka **SQL Editor**.
2. Salin seluruh isi `fase1_sekali_jalan.sql` (gabungan kelima file `migrations/`), tempel, lalu klik Run. Data wilayah dijalankan di langkah 4 (pakai `data/ringkas/` bila SQL Editor menolak file besar).
3. Fase 2: jalankan `migrations/…0600_login_undangan.sql` dengan cara yang sama.
4. Fase 3: jalankan `data/wilayah_01.sql` sampai `wilayah_04.sql` **berurutan**, satu per satu (masing-masing ±1,3 MB). Tidak ada migrasi baru di Fase 3.
5. Fase 4: jalankan `migrations/…0700_mode_pertemuan.sql`.
6. Jalankan `migrations/…0800_admin_kelola_semua.sql` (keputusan 12), lalu `…0900_koreksi_data.sql` (keputusan 13–15), lalu `…1000_bukti_persembahan.sql` (keputusan 16), lalu `…1100_tindak_lanjut.sql` (Fase 5), lalu `…1200_admin_tulis_catatan.sql` (keputusan 18), lalu `…1300_ringkasan_tim.sql` (Fase 6), lalu `…1400_kartu_qr.sql` (Fase 7), lalu `…1500_login_fleksibel.sql` (keputusan 25), lalu `…1600_atur_profil.sql` (keputusan 27), lalu `…1700_masukan.sql` (keputusan 28), lalu `…1800_baptis_status_jemaat.sql` (keputusan 29–30), lalu `…1900_laporan_generasi.sql` (keputusan 31), lalu `…2000_reset_ketua_tim.sql` (keputusan 34), lalu `…2100_masukkan_akun.sql` (keputusan 35), lalu `…2200_laporan_proyek.sql` (keputusan 36), lalu `…2300_laporan_proyek_admin.sql` (keputusan 38), lalu `…2400_bahan_diskusi.sql` (keputusan 39), lalu `…2500_penghapus_berkas.sql` (keputusan 40), lalu `…2600_buat_hapus_akun.sql` (keputusan 41–42), lalu `…2700_kurangi_data_sensitif.sql` (keputusan 46).
   - **Cara mudah:** salin seluruh isi `susulan_migrasi.sql` ke SQL Editor lalu Run. File itu memeriksa sendiri file `…0600` sampai `…2700` mana yang belum dijalankan, menjalankan yang belum saja (berurutan), lalu menampilkan tabel status (semua harus "sudah"). Aman dijalankan berulang kali. Setiap ada migrasi baru, buat ulang dengan `python3 supabase/tests/lokal/buat_susulan.py .`.
7. Jangan jalankan file di `tests/lokal/`. Isinya hanya tiruan Supabase untuk pengujian.

## Menjalankan uji di komputer (PostgreSQL 16)

```bash
bash supabase/tests/lokal/jalankan.sh
```

## Hal yang perlu diingat untuk fase berikutnya

- Setiap tabel baru di `public` wajib diberi `enable row level security` dan `revoke all … from anon`.
- Catatan khusus hanya bisa diakses lewat fungsi `tulis_catatan`, `ubah_catatan`, `hapus_catatan`, dan `baca_catatan`.
- Berkas yang harus dihapus dicatat di `internal.antrean_hapus_foto` dan dihapus setiap malam oleh Vercel Cron (`/api/tugas/hapus-berkas`, keputusan 40). Perlu pengaturan `CRON_SECRET` di Vercel.
