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
