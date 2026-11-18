// Bahan diskusi PDF untuk pengurus (keputusan 39).

export const BUCKET_BAHAN = "bahan-diskusi";
export const UKURAN_BAHAN_MAKS = 10 * 1024 * 1024;

export type BarisBahan = {
  id: string;
  judul: string;
  keterangan: string | null;
  tanggal_pakai: string | null;
  tim_id: string | null;
  lokasi: string;
  nama_berkas: string;
  ukuran: number;
  dibuat_pada: string;
  tim: { nama: string } | null;
};

export const KOLOM_BAHAN = "id, judul, keterangan, tanggal_pakai, tim_id, lokasi, nama_berkas, ukuran, dibuat_pada, tim(nama)";

export function ukuranTerbaca(b: number) {
  return b >= 1024 * 1024 ? `${(b / 1024 / 1024).toFixed(1)} MB` : `${Math.max(1, Math.round(b / 1024))} KB`;
}

/** Nama berkas aman untuk lokasi penyimpanan (huruf, angka, titik, garis). */
export function namaBerkasAman(nama: string) {
  const dasar = nama.replace(/\.pdf$/i, "").normalize("NFKD").replace(/[^\w.-]+/g, "-").replace(/-+/g, "-");
  return `${dasar.slice(0, 80) || "bahan"}.pdf`;
}
