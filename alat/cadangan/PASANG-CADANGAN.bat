@echo off
rem Klik dua kali berkas ini (sekali saja) untuk menyiapkan cadangan otomatis CSM.
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0cadangan-csm.ps1" -Siapkan
echo.
echo Selesai. Ambil tangkapan layar jendela ini lalu kirim ke Claude.
pause
