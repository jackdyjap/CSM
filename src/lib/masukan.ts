// Masukan: keluhan, permasalahan, usulan perbaikan (keputusan 28).

export const JENIS_MASUKAN = {
  keluhan: "Keluhan",
  permasalahan: "Permasalahan",
  usulan: "Usulan perbaikan",
} as const;

export const STATUS_MASUKAN = {
  baru: "Baru",
  ditangani: "Sedang ditangani",
  selesai: "Selesai",
} as const;

export const TUJUAN_MASUKAN = {
  pemimpin: "Pemimpin kelompok",
  ketua_tim: "Ketua tim",
  admin: "Admin",
} as const;

export type JenisMasukan = keyof typeof JENIS_MASUKAN;
export type StatusMasukan = keyof typeof STATUS_MASUKAN;
export type TujuanMasukan = keyof typeof TUJUAN_MASUKAN;

export const PANJANG_JUDUL_MAKS = 120;
export const PANJANG_ISI_MAKS = 2000;

/** Pilihan tujuan untuk pengirim ini: nilai "tujuan|id kelompok". */
export function pilihanTujuan(peran: {
  anggota: { kelompok_id: string; kelompok_nama: string } | null;
  pemimpin: { kelompok_id: string; nama: string; tim_nama: string }[];
}): { nilai: string; label: string }[] {
  const daftar: { nilai: string; label: string }[] = [];
  if (peran.anggota) {
    daftar.push({
      nilai: `pemimpin|${peran.anggota.kelompok_id}`,
      label: `Pemimpin kelompok ${peran.anggota.kelompok_nama}`,
    });
    daftar.push({
      nilai: `ketua_tim|${peran.anggota.kelompok_id}`,
      label: `Ketua tim dari kelompok ${peran.anggota.kelompok_nama}`,
    });
  }
  const timSudah = new Set<string>();
  for (const k of peran.pemimpin) {
    if (k.kelompok_id === peran.anggota?.kelompok_id || timSudah.has(k.tim_nama)) continue;
    timSudah.add(k.tim_nama);
    daftar.push({ nilai: `ketua_tim|${k.kelompok_id}`, label: `Ketua tim ${k.tim_nama}` });
  }
  daftar.push({ nilai: "admin|", label: "Admin" });
  return daftar;
}
