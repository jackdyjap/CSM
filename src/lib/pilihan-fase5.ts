// Label pilihan untuk catatan khusus dan proyek ketaatan (Fase 5).

export const PILIHAN_JENIS_CATATAN = {
  umum: "Umum",
  alasan_absen: "Alasan absen",
  proyek: "Proyek ketaatan",
} as const;
export type JenisCatatan = keyof typeof PILIHAN_JENIS_CATATAN;

export const PILIHAN_STATUS_PROYEK = {
  belum: "Belum",
  sedang: "Sedang",
  selesai: "Selesai",
  tidak_dikerjakan: "Tidak dikerjakan",
} as const;
export type StatusProyek = keyof typeof PILIHAN_STATUS_PROYEK;

/** Batas absen berturut-turut untuk daftar tindak lanjut (keputusan 17). */
export const BATAS_ABSEN = 3;
