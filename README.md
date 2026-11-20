# Absensi CSM — Sistem Absensi Kelompok Kecil

Aplikasi web (nyaman dibuka di HP) untuk mendata anggota kelompok kecil, mencatat kehadiran dan persembahan mingguan, membantu pemimpin menindaklanjuti anggota, dan memberi tim gambaran tentang kelompok di bawahnya.

Teknologi: **Next.js** (tampilan) + **Supabase** (login, database PostgreSQL, aturan akses, penyimpanan foto).

- Spesifikasi lengkap: [`docs/SPESIFIKASI.md`](docs/SPESIFIKASI.md)
- Keputusan yang sudah diambil: [`docs/KEPUTUSAN.md`](docs/KEPUTUSAN.md)
- Database dan cara menjalankannya: [`supabase/README.md`](supabase/README.md)

## Kemajuan

| Fase | Isi | Status |
|---|---|---|
| 1 | Tabel, peran, dan aturan akses (RLS) | ✅ Selesai: sudah berjalan di Supabase (data wilayah menyusul di Fase 3) |
| 2 | Login, pengaturan peran, undangan | ✅ Berjalan di aplikasi (teruji 17 Nov 2026) |
| 3 | Profil anggota (foto, wilayah), profil yang dibuat pemimpin | ✅ Berjalan di aplikasi (teruji 17 Nov 2026) |
| 4 | Mode pertemuan: absensi manual, alasan tidak hadir, persembahan (+ bukti transfer) | ✅ Berjalan di aplikasi (teruji 17 Nov 2026) |
| 5 | Catatan khusus, proyek ketaatan, halaman tindak lanjut | ✅ Berjalan di aplikasi (teruji 17 Nov 2026) |
| 6 | Dashboard Ketua Tim | 🔧 Kode selesai, 291 uji database lulus; belum dicoba di Supabase |
| 7 | QR kartu anggota | 🔧 Kode selesai, 304 uji database lulus; belum dicoba di Supabase |
| 8 | QR pertemuan yang berganti otomatis, akun mandiri anggota | 🔧 Kode selesai, 315 uji database lulus; belum dicoba di Supabase |
| 9 | Laporan demografi dan ekspor | 🔧 Kode selesai, 328 uji database lulus; belum dicoba di Supabase |
| 10 | Uji akses dengan akun tiap peran, lalu pilot | ⏳ |

## Struktur folder

| Folder | Isi |
|---|---|
| `src/app/` | Halaman aplikasi (masuk, beranda, profil, admin, dashboard tim, kelompok: anggota, pertemuan, proyek, tindak lanjut; undangan, atur ulang) |
| `src/lib/` | Sambungan ke Supabase, pengolah email/nomor HP, pemeriksa login, aksi dan pilihan profil |
| `src/components/` | Komponen tampilan (tombol, isian, kotak, formulir profil, pilihan wilayah, unggah foto) |
| `src/proxy.ts` | Mengarahkan pengunjung yang belum login ke halaman masuk |
| `supabase/` | Database: migrasi, data wilayah, dan uji akses |

## Menjalankan aplikasi di komputer

1. Pasang Node.js versi 22.
2. Salin `.env.example` menjadi `.env.local`, lalu isi tiga nilai pertamanya dari Supabase. `CRON_SECRET` hanya diperlukan di Vercel (lihat bagian *Penghapus berkas otomatis*).
3. Jalankan:

```bash
npm install
```

```bash
npm run dev
```

4. Buka http://localhost:3000.

## Memulihkan akses Admin

Pemilik proyek Supabase (yang bisa masuk ke dasbor supabase.com) selalu bisa memulihkan akses, karena aplikasi tidak bisa menghapus akun dasbor itu. Tombol hapus di aplikasi hanya menghapus isi data; tabel, aturan akses, dan fungsi tetap ada.

Bila tidak ada lagi akun dengan peran Admin di aplikasi:

0. **Pilih proyek Supabase yang benar: `CSM`** (organisasi GBI Daan Mogot). Akun Supabase yang sama bisa punya beberapa proyek; bila ragu, cocokkan **Project URL** (Project Settings → Data API) dengan `NEXT_PUBLIC_SUPABASE_URL` di Vercel. Akun yang dibuat atau diubah di proyek lain tidak akan terbaca aplikasi.
1. **Buat akun** (lewati bila akunnya sudah ada): dasbor Supabase → **Authentication → Users → Add user → Create new user**. Isi email dan kata sandi, centang **Auto Confirm User**.
2. **Jadikan Admin**: di **SQL Editor** jalankan perintah ini. Ganti **hanya alamat email**; kata `'admin'` adalah nama peran dan harus persis seperti ini.

```sql
insert into public.penugasan_peran (akun_id, peran)
select id, 'admin' from public.akun where email = 'email-anda@gmail.com'
on conflict do nothing;
```

3. **Periksa**: perintah ini harus menampilkan **tepat satu baris** dengan `peran = admin`. Perintah di langkah 2 tetap menulis "Success" walaupun tidak ada yang diubah, jadi langkah ini wajib. Bila hasilnya kosong ("No rows returned"), akun dengan email itu belum ada **di proyek ini**: periksa langkah 0, lalu ulangi langkah 1.

```sql
select ak.nama_tampilan, ak.email, p.peran
from public.akun ak
join public.penugasan_peran p on p.akun_id = ak.id
where ak.email = 'email-anda@gmail.com';
```

4. Masuk ke aplikasi dengan akun itu. Saat login pertama, akun dibawa ke **Atur profil**; tekan **Selesai, ke Beranda** dan menu Admin muncul.

Saran: selalu punya minimal **2 akun Admin** di aplikasi, dan lindungi login dasbor Supabase dengan kata sandi kuat serta verifikasi dua langkah (2FA).

## Penghapus berkas otomatis

Foto, bukti transfer, dan bahan diskusi yang datanya sudah dihapus akan dihapus dari penyimpanan Supabase **setiap malam pukul 02.00 WIB** (Vercel Cron, `vercel.json`). Supaya berjalan, isi satu pengaturan di Vercel:

1. Buka proyek di vercel.com → **Settings → Environment Variables**.
2. Tambahkan **`CRON_SECRET`** dengan isi teks acak panjang (minimal 16 karakter, mis. buat di https://1password.com/password-generator), untuk lingkungan **Production**.
3. Buka **Deployments** → deployment terbaru → **Redeploy**, supaya pengaturan baru terbaca.

Jumlah berkas yang menunggu dihapus terlihat di Admin → Tim & kelompok, beserta tombol **Hapus sekarang**.
