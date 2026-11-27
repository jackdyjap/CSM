import type { VersiAlkitab } from "@/lib/alkitab";

// Catatan Saat Teduh (keputusan 58). Dipakai halaman pemilik dan tampilan baca pengurus.

export type CatatanSaatTeduh = {
  id: string;
  akun_id: string;
  tanggal: string; // YYYY-MM-DD
  jam_mulai: string; // HH:MM:SS
  durasi_menit: number;
  versi: VersiAlkitab;
  kitab: number;
  pasal: number;
  ayat_awal: number | null;
  ayat_akhir: number | null;
  tuntunan: string | null;
};

export const KOLOM_SAAT_TEDUH =
  "id, akun_id, tanggal, jam_mulai, durasi_menit, versi, kitab, pasal, ayat_awal, ayat_akhir, tuntunan";

export const DURASI_MAKS = 600;
export const TUNTUNAN_MAKS = 2000;

/** Tanggal hari ini di WIB, format YYYY-MM-DD. */
export function hariIniWib() {
  return new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Jakarta" }).format(new Date());
}

const formatTanggal = new Intl.DateTimeFormat("id-ID", {
  weekday: "short",
  day: "numeric",
  month: "short",
  year: "numeric",
  timeZone: "UTC",
});

/** "2026-11-26" -> "Kam, 26 Nov 2026" */
export function tanggalPendek(tanggal: string) {
  return formatTanggal.format(new Date(`${tanggal}T00:00:00Z`));
}

/** "05:30:00" -> "05.30" */
export const jamPendek = (jam: string) => jam.slice(0, 5).replace(":", ".");
