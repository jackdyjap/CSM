# Catatan untuk Claude

- Pemilik proyek adalah pemula. Jelaskan dalam **bahasa Indonesia sederhana**, kerjakan **satu fase per satu waktu** (lihat `docs/SPESIFIKASI.md` bagian 8), dan **minta persetujuan sebelum menulis kode atau mengubah file**.
- Baca `docs/KEPUTUSAN.md` sebelum mengubah rancangan. Jangan mengubah keputusan yang sudah diambil tanpa bertanya.
- Database: setiap perubahan dibuat sebagai file migrasi **baru** di `supabase/migrations/`. Jangan mengubah migrasi yang sudah dijalankan di Supabase.
- Setiap tabel baru di `public` wajib diberi `enable row level security`, aturan akses, dan uji di `supabase/tests/uji_akses.sql`.
- Jalankan uji sebelum menyimpan perubahan: `bash supabase/tests/lokal/jalankan.sh` (memakai PostgreSQL 16 lokal). Semua uji harus LULUS.
