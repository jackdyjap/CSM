"use client";

import { usePathname } from "next/navigation";
import { useEffect } from "react";

// Menghitung halaman yang dibuka DI DALAM aplikasi sejak aplikasi dimuat,
// supaya "kembali ke layar sebelumnya" (FormAksi) tidak membawa pengguna
// keluar dari aplikasi bila halaman dibuka langsung dari tautan.
let jumlahHalaman = 0;
let jalurTerakhir: string | null = null;

/** Ada layar sebelumnya di dalam aplikasi? */
export function adaLayarSebelumnya() {
  return jumlahHalaman > 1;
}

/** Dipasang sekali di tata letak utama. */
export function PelacakRiwayat() {
  const jalur = usePathname();
  useEffect(() => {
    // Hanya perpindahan ke halaman lain yang dihitung (efek bisa berjalan dua kali).
    if (jalur === jalurTerakhir) return;
    jalurTerakhir = jalur;
    jumlahHalaman += 1;
  }, [jalur]);
  return null;
}
