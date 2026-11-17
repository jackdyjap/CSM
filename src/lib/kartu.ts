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

// ---------------------------------------------------------------- QR pertemuan (Fase 8)
// QR pertemuan berisi alamat halaman check-in, supaya bisa dipindai dengan
// kamera HP biasa: <situs>/hadir?k=<kode 20 karakter>. Kode berganti tiap 45 detik.

export function alamatCheckIn(situs: string, kode: string) {
  return `${situs}/hadir?k=${kode}`;
}

/** Kode pertemuan dari teks hasil scan (alamat check-in atau kode saja), atau null. */
export function kodePertemuanDariQr(teks: string): string | null {
  const t = teks.trim();
  let kode = t;
  try {
    const url = new URL(t);
    if (!url.pathname.endsWith("/hadir")) return null;
    kode = url.searchParams.get("k") ?? "";
  } catch {
    // bukan alamat; anggap kode saja
  }
  kode = kode.trim().toLowerCase();
  return /^[0-9a-f]{20}$/.test(kode) ? kode : null;
}
