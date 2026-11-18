# Cadangan data otomatis (Windows)

Skrip `cadangan-csm.ps1` mencadangkan **data** aplikasi absensi CSM dari Supabase ke komputer Windows, **setiap Minggu pukul 21.00**, dan menyimpan **4 cadangan terakhir** di `Documents\cadangan-csm`. Struktur tabel tidak ikut (sudah ada di `supabase/migrations`); berkas foto/PDF tidak ikut.

## Persiapan (sekali)

1. Pasang **Command Line Tools** PostgreSQL (versi sama atau lebih baru dari database Supabase; cek dengan `select version();`) dari https://www.enterprisedb.com/downloads/postgres-postgresql-downloads. Saat memasang, centang hanya *Command Line Tools*.
2. Simpan `cadangan-csm.ps1`, `PASANG-CADANGAN.bat`, dan `CADANGKAN-SEKARANG.bat` di satu folder, mis. `Documents\cadangan-csm`.
3. **Klik dua kali `PASANG-CADANGAN.bat`.** (Atau, lewat PowerShell:)

```powershell
cd "$HOME\Documents\cadangan-csm"
```

```powershell
powershell -ExecutionPolicy Bypass -File .\cadangan-csm.ps1 -Siapkan
```

4. Tempel alamat **Session pooler** (Supabase proyek **CSM** → **Connect** → Connection String → URI → Session pooler), lalu ketik kata sandi database. Skrip menyimpan kata sandi di `%APPDATA%\postgresql\pgpass.conf` (hanya untuk pengguna Windows ini), mendaftarkan tugas terjadwal **"Cadangan CSM mingguan"**, dan langsung membuat cadangan pertama.

Hasil yang benar: baris `BERHASIL: ...csm-....dump (NN tabel, NN KB)`.

## Sehari-hari

- Riwayat ada di `Documents\cadangan-csm\cadangan.log` (cari `BERHASIL` atau `GAGAL`).
- Bila komputer mati atau tidur pada Minggu malam, cadangan dibuat saat komputer menyala berikutnya.
- Membuat cadangan sekarang juga: klik dua kali `CADANGKAN-SEKARANG.bat`.
- Mengganti kata sandi database: jalankan lagi dengan `-Siapkan`.
- Menghentikan: buka **Task Scheduler**, hapus tugas "Cadangan CSM mingguan".

## Keamanan

Berkas `.dump` berisi data pribadi jemaat dan sandi akun yang sudah diacak. Simpan salinan kedua di Google Drive pribadi atau flashdisk; jangan dikirim lewat WhatsApp/email dan jangan diunggah ke GitHub.
