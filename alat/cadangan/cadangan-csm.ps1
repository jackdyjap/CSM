# =====================================================================
# Cadangan data aplikasi absensi CSM (Supabase) ke komputer Windows.
#
# Persiapan SEKALI (PowerShell, di folder tempat skrip ini disimpan):
#   powershell -ExecutionPolicy Bypass -File .\cadangan-csm.ps1 -Siapkan
# Lalu skrip berjalan sendiri setiap Minggu pukul 21.00 (Task Scheduler).
#
# Membuat cadangan sekarang juga:
#   powershell -ExecutionPolicy Bypass -File .\cadangan-csm.ps1
#
# Yang dicadangkan: DATA aplikasi (skema public dan internal) beserta akun
# login (auth.users, auth.identities). Struktur tabel ada di GitHub
# (supabase/migrations). Berkas foto/PDF tidak termasuk.
# Berkas .dump berisi data pribadi: simpan dengan aman, jangan dibagikan.
# =====================================================================
param(
  [switch]$Siapkan
)

$ErrorActionPreference = "Stop"
$Folder      = Join-Path $HOME "Documents\cadangan-csm"
$Pengaturan  = Join-Path $Folder "pengaturan.txt"   # berisi alamat sambungan (tanpa kata sandi)
$Log         = Join-Path $Folder "cadangan.log"
$JumlahSimpan = 4
$NamaTugas   = "Cadangan CSM mingguan"

function Tulis-Log([string]$pesan) {
  $baris = "{0}  {1}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $pesan
  Add-Content -Path $Log -Value $baris -Encoding UTF8
  Write-Host $baris
}

function Cari-PgBin {
  $semua = Get-ChildItem "C:\Program Files\PostgreSQL" -Directory -ErrorAction SilentlyContinue |
    Where-Object { Test-Path (Join-Path $_.FullName "bin\pg_dump.exe") } |
    Sort-Object { [int]($_.Name -replace '\D', '') } -Descending
  if (-not $semua) { throw "pg_dump.exe tidak ditemukan. Pasang 'Command Line Tools' PostgreSQL dulu (Bagian A2)." }
  return (Join-Path $semua[0].FullName "bin")
}

New-Item -ItemType Directory -Force -Path $Folder | Out-Null

# ---------------------------------------------------------------------
# MODE PERSIAPAN
# ---------------------------------------------------------------------
if ($Siapkan) {
  Write-Host "== Persiapan cadangan CSM ==" -ForegroundColor Cyan
  Write-Host "Tempel alamat Session pooler dari Supabase (Connect -> Connection String -> URI -> Session pooler)."
  Write-Host "Boleh dengan atau tanpa bagian :[YOUR-PASSWORD]."
  $alamat = (Read-Host "Alamat").Trim()
  $alamat = $alamat -replace ':\[YOUR-PASSWORD\]@', '@'

  if ($alamat -notmatch '^postgres(ql)?://([^:@/]+)(:[^@]*)?@([^:/]+):(\d+)/([^?]+)') {
    throw "Alamat tidak dikenali. Contoh: postgresql://postgres.abcd@aws-0-ap-southeast-2.pooler.supabase.com:5432/postgres"
  }
  $pengguna = $Matches[2]; $host_ = $Matches[4]; $port = $Matches[5]; $db = $Matches[6]
  # Kata sandi tidak disimpan di alamat.
  $alamatBersih = "postgresql://$pengguna@${host_}:$port/$db"

  $sandiAman = Read-Host "Kata sandi database Supabase (tidak terlihat saat diketik)" -AsSecureString
  $sandi = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($sandiAman))
  $sandi = $sandi -replace '\\', '\\' -replace ':', '\:'

  # pgpass.conf: tempat resmi PostgreSQL menyimpan kata sandi, hanya untuk pengguna Windows ini.
  $folderPg = Join-Path $env:APPDATA "postgresql"
  New-Item -ItemType Directory -Force -Path $folderPg | Out-Null
  $pgpass = Join-Path $folderPg "pgpass.conf"
  $barisLain = @()
  if (Test-Path $pgpass) {
    # @( ) supaya tetap berupa daftar walau berkasnya hanya berisi satu baris.
    $barisLain = @(Get-Content $pgpass | Where-Object { $_ -notlike "${host_}:${port}:${db}:${pengguna}:*" })
  }
  ($barisLain + "${host_}:${port}:${db}:${pengguna}:$sandi") | Set-Content -Path $pgpass -Encoding ASCII
  Set-Content -Path $Pengaturan -Value $alamatBersih -Encoding UTF8

  # Tugas terjadwal: setiap Minggu 21.00; bila komputer mati/tidur, dijalankan saat berikutnya menyala.
  $skrip = $MyInvocation.MyCommand.Path
  $aksi = New-ScheduledTaskAction -Execute "powershell.exe" `
    -Argument "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$skrip`""
  $pemicu = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Sunday -At 9pm
  $setelan = New-ScheduledTaskSettingsSet -StartWhenAvailable -ExecutionTimeLimit (New-TimeSpan -Minutes 30)
  Register-ScheduledTask -TaskName $NamaTugas -Action $aksi -Trigger $pemicu -Settings $setelan `
    -Description "Cadangan data aplikasi absensi CSM (Supabase) ke $Folder" -Force | Out-Null

  Write-Host "Pengaturan tersimpan dan tugas '$NamaTugas' terdaftar (setiap Minggu 21.00)." -ForegroundColor Green
  Write-Host "Membuat cadangan pertama sekarang untuk menguji..." -ForegroundColor Cyan
}

# ---------------------------------------------------------------------
# MEMBUAT CADANGAN
# ---------------------------------------------------------------------
try {
  if (-not (Test-Path $Pengaturan)) { throw "Belum disiapkan. Jalankan dulu dengan -Siapkan." }
  $alamat = (Get-Content $Pengaturan -Raw).Trim()
  $bin = Cari-PgBin
  $berkas = Join-Path $Folder ("csm-{0}.dump" -f (Get-Date -Format "yyyy-MM-dd_HHmm"))

  $env:PGCONNECT_TIMEOUT = "30"
  # pg_dump menulis peringatan (mis. "circular foreign-key constraints", wajar untuk tabel
  # akun <-> anggota) ke stderr. Jangan anggap itu galat; yang menentukan adalah kode keluarnya.
  $ErrorActionPreference = "Continue"
  $keluaran = & (Join-Path $bin "pg_dump.exe") $alamat --no-password --data-only --no-owner --no-privileges -Fc `
    -t "public.*" -t "internal.*" -t "auth.users" -t "auth.identities" -f $berkas 2>&1
  $kode = $LASTEXITCODE
  $ErrorActionPreference = "Stop"
  $keluaran | ForEach-Object { Tulis-Log "pg_dump: $_" }
  if ($kode -ne 0) { throw "pg_dump gagal (kode $kode). Lihat baris pg_dump di atas." }

  # Periksa: berapa tabel yang datanya tercadang.
  $jumlahTabel = (& (Join-Path $bin "pg_restore.exe") --list $berkas | Select-String "TABLE DATA" | Measure-Object).Count
  if ($jumlahTabel -lt 10) { throw "Cadangan mencurigakan: hanya $jumlahTabel tabel. Periksa alamat dan proyek (harus CSM)." }
  $ukuran = [math]::Round((Get-Item $berkas).Length / 1KB)
  Tulis-Log "BERHASIL: $berkas ($jumlahTabel tabel, $ukuran KB)"

  # Simpan hanya cadangan terbaru sebanyak $JumlahSimpan.
  Get-ChildItem $Folder -Filter "csm-*.dump" | Sort-Object LastWriteTime -Descending |
    Select-Object -Skip $JumlahSimpan | ForEach-Object {
      Remove-Item $_.FullName -Force
      Tulis-Log "Dihapus (cadangan lama): $($_.Name)"
    }
}
catch {
  Tulis-Log "GAGAL: $($_.Exception.Message)"
  if ($Siapkan) { Write-Host "Kirim isi pesan GAGAL di atas ke Claude." -ForegroundColor Red }
  exit 1
}
