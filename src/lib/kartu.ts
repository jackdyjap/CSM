// Isi QR kartu anggota. Awalan khusus supaya tidak tertukar dengan QR
// pertemuan (Fase 8). Kode kartu hanyalah kode acak tanpa data pribadi.

export const AWALAN_KARTU = "CSM-K:";

export function isiQrKartu(kode: string) {
  return `${AWALAN_KARTU}${kode}`;
}

/** Kode kartu dari teks hasil scan, atau null bila bukan kartu anggota. */
export function kodeDariQr(teks: string): string | null {
  const t = teks.trim();
  if (!t.toUpperCase().startsWith(AWALAN_KARTU)) return null;
  const kode = t.slice(AWALAN_KARTU.length).trim().toLowerCase();
  return /^[0-9a-f]{32}$/.test(kode) ? kode : null;
}
