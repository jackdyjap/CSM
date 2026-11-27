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

// ---------------------------------------------------------------- Ringkasan bulanan (keputusan 59)

/** Bulan ini di WIB, format YYYY-MM. */
export const bulanIni = () => hariIniWib().slice(0, 7);

const formatBulan = new Intl.DateTimeFormat("id-ID", { month: "long", year: "numeric", timeZone: "UTC" });

/** "2026-11" -> "November 2026" */
export const labelBulan = (bulan: string) => formatBulan.format(new Date(`${bulan}-01T00:00:00Z`));

/** Bulan dari parameter alamat; bila kosong/salah/di masa depan, bulan ini. */
export function bacaBulan(nilai: unknown) {
  const kini = bulanIni();
  return typeof nilai === "string" && /^\d{4}-(0[1-9]|1[0-2])$/.test(nilai) && nilai <= kini && nilai >= "2000-01"
    ? nilai
    : kini;
}

/** 12 bulan terakhir (terbaru dulu) untuk pilihan bulan. */
export function daftarBulan(jumlah = 12) {
  const [t, b] = bulanIni().split("-").map(Number);
  return Array.from({ length: jumlah }, (_, i) => {
    const d = new Date(Date.UTC(t, b - 1 - i, 1));
    return `${d.getUTCFullYear()}-${String(d.getUTCMonth() + 1).padStart(2, "0")}`;
  });
}

/** Tanggal pertama bulan berikutnya, YYYY-MM-DD (batas atas, tidak termasuk). */
export function awalBulanBerikut(bulan: string) {
  const [t, b] = bulan.split("-").map(Number);
  const d = new Date(Date.UTC(t, b, 1));
  return `${d.getUTCFullYear()}-${String(d.getUTCMonth() + 1).padStart(2, "0")}-01`;
}

/** 8 dari 12 -> "67%"; tanpa pembagi -> "-". */
export const persen = (bagian: number, dari: number) => (dari > 0 ? `${Math.round((bagian / dari) * 100)}%` : "-");

export type BarisRingkasanTeduh = {
  tim_id: string;
  tim_nama: string;
  kelompok_id: string;
  kelompok_nama: string;
  anggota_aktif: number;
  punya_akun: number;
  bersaat_teduh: number;
  jumlah_catatan: number;
  total_menit: number;
};

// ---------------------------------------------------------------- Ringkasan pribadi (keputusan 66)

/** Jumlah hari dalam bulan "YYYY-MM". */
export function hariDalamBulan(bulan: string) {
  const [t, b] = bulan.split("-").map(Number);
  return new Date(Date.UTC(t, b, 0)).getUTCDate();
}

/** Jumlah hari dalam tahun. */
export const hariDalamTahun = (tahun: number) => (new Date(Date.UTC(tahun, 1, 29)).getUTCMonth() === 1 ? 366 : 365);

/** Selisih hari (inklusif) dari tanggal awal sampai akhir, format YYYY-MM-DD. */
export function jumlahHariInklusif(awal: string, akhir: string) {
  return Math.round((Date.parse(`${akhir}T00:00:00Z`) - Date.parse(`${awal}T00:00:00Z`)) / 86_400_000) + 1;
}
