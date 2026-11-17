// Tujuan setelah login (?lanjut=...). Hanya jalur DI DALAM aplikasi yang
// diterima, supaya tautan login tidak bisa dipakai untuk mengarahkan orang
// ke situs lain (open redirect).
export function tujuanAman(nilai: unknown, cadangan = "/beranda"): string {
  if (typeof nilai !== "string") return cadangan;
  if (!nilai.startsWith("/") || nilai.startsWith("//") || nilai.startsWith("/\\")) return cadangan;
  if (/[\r\n\t]/.test(nilai) || nilai.length > 500) return cadangan;
  if (nilai.startsWith("/masuk")) return cadangan;
  return nilai;
}
