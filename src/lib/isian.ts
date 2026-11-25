// Membaca isian formulir (dipakai aksi server).

/** Teks isian yang sudah dirapikan, atau null bila kosong. */
export function teks(fd: FormData, nama: string) {
  const nilai = String(fd.get(nama) ?? "").trim();
  return nilai === "" ? null : nilai;
}

/** Nilai pilihan yang ada di daftar, atau null. */
export function pilihan<T extends Record<string, string>>(fd: FormData, nama: string, daftar: T) {
  const nilai = teks(fd, nama);
  return nilai && nilai in daftar ? (nilai as keyof T) : null;
}

/** Isian Baptis: "sudah" -> true, "belum" -> false, kosong -> null. */
export function baptis(fd: FormData): boolean | null {
  const nilai = teks(fd, "baptis");
  return nilai === "sudah" ? true : nilai === "belum" ? false : null;
}

/**
 * Isian Tahun lahir (keputusan 46): null bila kosong, "salah" bila bukan
 * 4 angka antara 1900 dan tahun ini, selain itu tahunnya.
 */
export function tahunLahir(fd: FormData): number | null | "salah" {
  const nilai = teks(fd, "tahun_lahir");
  if (!nilai) return null;
  if (!/^\d{4}$/.test(nilai)) return "salah";
  const tahun = Number(nilai);
  const sekarang = Number(new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Jakarta" }).format(new Date()).slice(0, 4));
  return tahun >= 1900 && tahun <= sekarang ? tahun : "salah";
}
