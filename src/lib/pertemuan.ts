// Label dan format untuk pertemuan. Dipakai di server dan di browser.

export const PILIHAN_ALASAN = {
  sakit: "Sakit",
  bekerja: "Bekerja",
  keluarga: "Keluarga",
  bepergian: "Bepergian",
  tanpa_kabar: "Tanpa kabar",
  lainnya: "Lainnya",
} as const;

export type Alasan = keyof typeof PILIHAN_ALASAN;

const formatRp = new Intl.NumberFormat("id-ID", { maximumFractionDigits: 0 });

/** Contoh: 150000 -> "Rp 150.000" */
export function rupiah(nilai: number | string | null | undefined) {
  return `Rp ${formatRp.format(Number(nilai ?? 0))}`;
}

/**
 * Membaca isian rupiah yang diketik bebas: "150.000", "Rp150000", "150 000".
 * Kosong -> null. Bukan angka -> NaN.
 */
export function bacaRupiah(teks: string): number | null {
  const bersih = teks.replace(/rp/gi, "").replace(/[\s.]/g, "").replace(/,00$/, "");
  if (bersih === "") return null;
  return /^\d{1,13}$/.test(bersih) ? Number(bersih) : NaN;
}

const formatTanggal = new Intl.DateTimeFormat("id-ID", {
  weekday: "long",
  day: "numeric",
  month: "long",
  year: "numeric",
  timeZone: "UTC",
});

/** Contoh: "2026-11-17" -> "Selasa, 17 November 2026" */
export function tanggalPanjang(tanggal: string) {
  return formatTanggal.format(new Date(`${tanggal}T00:00:00Z`));
}
