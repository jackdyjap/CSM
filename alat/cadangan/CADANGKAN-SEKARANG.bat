@echo off
rem Klik dua kali untuk membuat cadangan CSM sekarang juga.
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0cadangan-csm.ps1"
echo.
pause
