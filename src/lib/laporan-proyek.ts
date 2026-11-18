// Laporan pelaksanaan proyek ketaatan untuk Admin (keputusan 38).
// Database mengembalikan satu baris per (proyek × anggota); di sini disusun.

export type BarisProyekDb = {
  tim_nama: string;
  kelompok_id: string;
  kelompok_nama: string;
  proyek_id: string;
  judul: string;
  diberikan_pada: string;
  tenggat: string | null;
  anggota_id: string;
  anggota_nama: string;
  anggota_aktif: boolean;
  status: "belum" | "sedang" | "selesai" | "tidak_dikerjakan";
  dilaporkan: boolean;
  alasan: string | null;
  hasil: string | null;
  keterangan: string | null;
  dilaporkan_sendiri: boolean;
  diubah_pada: string | null;
};

/** Kategori laporan; "belum_dilaporkan" = belum ada status sama sekali. */
export const KATEGORI_PROYEK = {
  selesai: "Sudah selesai",
  sedang: "Sedang dijalankan",
  belum: "Belum dijalankan",
  tidak_dikerjakan: "Tidak dikerjakan",
  belum_dilaporkan: "Belum dilaporkan",
} as const;
export type KategoriProyek = keyof typeof KATEGORI_PROYEK;

export function kategori(b: Pick<BarisProyekDb, "status" | "dilaporkan">): KategoriProyek {
  return b.dilaporkan ? b.status : "belum_dilaporkan";
}

export type Hitungan = Record<KategoriProyek, number> & { total: number };

function hitunganKosong(): Hitungan {
  return { selesai: 0, sedang: 0, belum: 0, tidak_dikerjakan: 0, belum_dilaporkan: 0, total: 0 };
}

export type ProyekLaporan = {
  id: string;
  judul: string;
  tim: string;
  kelompok: string;
  diberikan_pada: string;
  tenggat: string | null;
  hitungan: Hitungan;
  anggota: BarisProyekDb[];
};

export type KelompokLaporan = { id: string; nama: string; tim: string; proyek: number; hitungan: Hitungan };

export function susunLaporanProyek(baris: BarisProyekDb[]) {
  const total = hitunganKosong();
  const proyek = new Map<string, ProyekLaporan>();
  const kelompok = new Map<string, KelompokLaporan & { idProyek: Set<string> }>();

  for (const b of baris) {
    const kat = kategori(b);
    total[kat] += 1;
    total.total += 1;

    let p = proyek.get(b.proyek_id);
    if (!p) {
      p = {
        id: b.proyek_id,
        judul: b.judul,
        tim: b.tim_nama,
        kelompok: b.kelompok_nama,
        diberikan_pada: b.diberikan_pada,
        tenggat: b.tenggat,
        hitungan: hitunganKosong(),
        anggota: [],
      };
      proyek.set(b.proyek_id, p);
    }
    p.hitungan[kat] += 1;
    p.hitungan.total += 1;
    p.anggota.push(b);

    let k = kelompok.get(b.kelompok_id);
    if (!k) {
      k = { id: b.kelompok_id, nama: b.kelompok_nama, tim: b.tim_nama, proyek: 0, hitungan: hitunganKosong(), idProyek: new Set() };
      kelompok.set(b.kelompok_id, k);
    }
    k.idProyek.add(b.proyek_id);
    k.hitungan[kat] += 1;
    k.hitungan.total += 1;
  }

  return {
    total,
    jumlahProyek: proyek.size,
    proyek: [...proyek.values()],
    kelompok: [...kelompok.values()]
      .map(({ idProyek, ...k }) => ({ ...k, proyek: idProyek.size }))
      .sort((a, b) => a.tim.localeCompare(b.tim, "id") || a.nama.localeCompare(b.nama, "id")),
  };
}

/** Persen dibulatkan, untuk tampilan. */
export function persenBulat(n: number, dari: number) {
  return dari > 0 ? Math.round((100 * n) / dari) : 0;
}
