# Database — Fase 1

Isi folder ini:

| File | Isi |
|---|---|
| `migrations/…0100_tabel.sql` | Semua tabel dan daftar pilihan |
| `migrations/…0200_fungsi_pembantu.sql` | Fungsi pengecek peran yang dipakai aturan akses |
| `migrations/…0300_aturan_akses.sql` | Aturan akses (RLS) di setiap tabel dan folder foto |
| `migrations/…0400_fungsi_khusus.sql` | Penjaga data (trigger) dan loket khusus: catatan, check-in QR, laporan demografi |
| `migrations/…0500_tugas_otomatis.sql` | Penandaan tidak aktif dan penghapusan data setelah 1 tahun, tiap malam |
| `data/wilayah_01..04.sql` | Data wilayah Indonesia (Kepmendagri 2025) |
| `tests/uji_akses.sql` | 112 uji akses untuk semua peran (data uji dibatalkan otomatis di akhir) |
| `tests/lokal/` | Alat untuk menjalankan uji di komputer tanpa Supabase |

## Menjalankan di proyek Supabase

1. Buka proyek di supabase.com, lalu buka **SQL Editor**.
2. Salin-tempel dan jalankan **satu per satu, berurutan**: lima file di `migrations/`, lalu `data/wilayah_01.sql` sampai `wilayah_04.sql`.
3. Jangan jalankan file di `tests/lokal/`. Isinya hanya tiruan Supabase untuk pengujian.

## Menjalankan uji di komputer (PostgreSQL 16)

```bash
bash supabase/tests/lokal/jalankan.sh
```

## Hal yang perlu diingat untuk fase berikutnya

- Setiap tabel baru di `public` wajib diberi `enable row level security` dan `revoke all … from anon`.
- Catatan khusus hanya bisa diakses lewat fungsi `tulis_catatan`, `ubah_catatan`, `hapus_catatan`, dan `baca_catatan`.
- Lokasi foto yang harus dihapus menumpuk di `internal.antrean_hapus_foto`. Penghapus filenya (Edge Function) belum dibuat.
