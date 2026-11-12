# CSM — Sistem Absensi Kelompok Kecil

Aplikasi web (nyaman dibuka di HP) untuk mendata anggota kelompok kecil, mencatat kehadiran dan persembahan mingguan, membantu pemimpin menindaklanjuti anggota, dan memberi tim gambaran tentang kelompok di bawahnya.

Teknologi: **Next.js** (tampilan) + **Supabase** (login, database PostgreSQL, aturan akses, penyimpanan foto).

- Spesifikasi lengkap: [`docs/SPESIFIKASI.md`](docs/SPESIFIKASI.md)
- Keputusan yang sudah diambil: [`docs/KEPUTUSAN.md`](docs/KEPUTUSAN.md)
- Database dan cara menjalankannya: [`supabase/README.md`](supabase/README.md)

## Kemajuan

| Fase | Isi | Status |
|---|---|---|
| 1 | Tabel, peran, dan aturan akses (RLS) | ✅ Selesai: 112 uji lulus, sudah berjalan di Supabase (data wilayah menyusul di Fase 3) |
| 2 | Login, pengaturan peran, undangan | ⏳ |
| 3 | Profil anggota (foto, wilayah), profil yang dibuat pemimpin | ⏳ |
| 4 | Mode pertemuan: absensi manual, alasan tidak hadir, persembahan | ⏳ |
| 5 | Catatan khusus, proyek ketaatan, halaman tindak lanjut | ⏳ |
| 6 | Dashboard Ketua Tim | ⏳ |
| 7 | QR kartu anggota | ⏳ |
| 8 | QR pertemuan yang berganti otomatis, akun mandiri anggota | ⏳ |
| 9 | Laporan demografi dan ekspor | ⏳ |
| 10 | Uji akses dengan akun tiap peran, lalu pilot | ⏳ |
