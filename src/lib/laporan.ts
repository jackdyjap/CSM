// Laporan demografi (Fase 9). Angka dihitung di database (laporan_demografi),
// per kelompok; di sini hanya dijumlahkan dan disusun untuk tampilan/ekspor.

import {
  PILIHAN_BAPTIS,
  PILIHAN_GENDER,
  PILIHAN_NIKAH,
  PILIHAN_PEKERJAAN,
  PILIHAN_PENDIDIKAN,
  PILIHAN_STATUS_JEMAAT,
} from "@/lib/profil";

export const DIMENSI = {
  gender: "Gender",
  rentang_usia: "Rentang usia",
  generasi: "Generasi",
  pendidikan: "Pendidikan terakhir",
  status_nikah: "Status pernikahan",
  pekerjaan: "Pekerjaan",
  baptis: "Baptis",
  status_jemaat: "Status jemaat",
  provinsi: "Provinsi",
  kota: "Kota/Kabupaten",
  kecamatan: "Kecamatan",
  kelurahan: "Kelurahan/Desa",
} as const;
export type Dimensi = keyof typeof DIMENSI;

/** Urutan dan label kategori untuk dimensi berdaftar tetap (wilayah diurutkan menurut nama). */
const URUTAN: Partial<Record<Dimensi, Record<string, string>>> = {
  gender: PILIHAN_GENDER,
  pendidikan: PILIHAN_PENDIDIKAN,
  status_nikah: PILIHAN_NIKAH,
  pekerjaan: PILIHAN_PEKERJAAN,
  baptis: PILIHAN_BAPTIS,
  status_jemaat: PILIHAN_STATUS_JEMAAT,
  // Urut dari yang termuda (keputusan 31; batas tahun di internal.generasi).
  generasi: {
    beta: "Gen Beta (2025–)",
    alpha: "Gen Alpha (2013–2024)",
    z: "Gen Z (1997–2012)",
    y: "Gen Y / Milenial (1981–1996)",
    x: "Gen X (1965–1980)",
    boomers: "Baby Boomers (1946–1964)",
    silent: "Silent Generation (≤1945)",
  },
  rentang_usia: {
    "0-12": "0–12 tahun",
    "13-17": "13–17 tahun",
    "18-24": "18–24 tahun",
    "25-34": "25–34 tahun",
    "35-44": "35–44 tahun",
    "45-54": "45–54 tahun",
    "55-64": "55–64 tahun",
    "65+": "65 tahun ke atas",
  },
};

export type BarisDb = {
  tim_nama: string;
  kelompok_id: string;
  kelompok_nama: string;
  kunci: string | null;
  label: string;
  jumlah: number;
  persen: number | null;
};

export type Kategori = { kunci: string; label: string; total: number; persen: number };
export type KolomKelompok = {
  id: string;
  nama: string;
  tim: string;
  jumlah: Map<string, number>;
  belum: number;
  terisi: number;
};
export type Laporan = {
  kategori: Kategori[];
  belum: number;
  terisi: number;
  kelompok: KolomKelompok[];
};

/** Persen 1 desimal; null bila penyebut 0. */
export function persen(n: number, dari: number): number {
  return dari > 0 ? Math.round((1000 * n) / dari) / 10 : 0;
}

export function formatPersen(p: number) {
  return `${p.toLocaleString("id-ID", { maximumFractionDigits: 1 })}%`;
}

/** Menyusun baris database menjadi ringkasan total + tabel silang per kelompok. */
export function susunLaporan(baris: BarisDb[], dimensi: Dimensi): Laporan {
  const peta = new Map<string, KolomKelompok>();
  const total = new Map<string, number>();
  const label = new Map<string, string>();
  let belum = 0;

  for (const b of baris) {
    let k = peta.get(b.kelompok_id);
    if (!k) {
      k = { id: b.kelompok_id, nama: b.kelompok_nama, tim: b.tim_nama, jumlah: new Map(), belum: 0, terisi: 0 };
      peta.set(b.kelompok_id, k);
    }
    const n = Number(b.jumlah);
    if (b.kunci === null) {
      k.belum += n;
      belum += n;
    } else {
      k.jumlah.set(b.kunci, (k.jumlah.get(b.kunci) ?? 0) + n);
      k.terisi += n;
      total.set(b.kunci, (total.get(b.kunci) ?? 0) + n);
      label.set(b.kunci, b.label);
    }
  }

  const terisi = [...total.values()].reduce((a, b) => a + b, 0);
  const daftar = URUTAN[dimensi];
  const kunciUrut = daftar
    ? Object.keys(daftar).filter((k) => total.has(k))
    : [...total.keys()].sort((a, b) => (label.get(a) ?? a).localeCompare(label.get(b) ?? b, "id"));

  return {
    kategori: kunciUrut.map((k) => ({
      kunci: k,
      label: daftar?.[k] ?? label.get(k) ?? k,
      total: total.get(k) ?? 0,
      persen: persen(total.get(k) ?? 0, terisi),
    })),
    belum,
    terisi,
    kelompok: [...peta.values()].sort((a, b) => a.tim.localeCompare(b.tim, "id") || a.nama.localeCompare(b.nama, "id")),
  };
}

export type Pilihan = {
  dimensi: Dimensi;
  cakupan: "semua" | "tim" | "kelompok";
  cakupanId: string | null;
  hanyaAktif: boolean;
  tampil: "jumlah" | "persen";
};

/** Membaca pilihan laporan dari parameter alamat (?d=&c=&id=&aktif=&t=). */
export function bacaPilihan(p: Record<string, string | string[] | undefined>): Pilihan {
  const s = (k: string) => (typeof p[k] === "string" ? (p[k] as string) : "");
  const dimensi = (s("d") in DIMENSI ? s("d") : "gender") as Dimensi;
  // Menu cakupan mengirim satu nilai "cak" = semua | tim:<id> | kelompok:<id>
  const [cakJenis, cakId] = s("cak").split(":");
  const c = cakJenis || s("c");
  const idMentah = cakId || s("id");
  const cakupanId = /^[0-9a-f-]{36}$/.test(idMentah) ? idMentah : null;
  const cakupan = (c === "tim" || c === "kelompok") && cakupanId ? c : "semua";
  return {
    dimensi,
    cakupan,
    cakupanId: cakupan === "semua" ? null : cakupanId,
    hanyaAktif: s("aktif") !== "0",
    tampil: s("t") === "persen" ? "persen" : "jumlah",
  };
}

export function parameterAlamat(p: Pilihan, tambahan: Record<string, string> = {}) {
  const q = new URLSearchParams({ d: p.dimensi, c: p.cakupan, aktif: p.hanyaAktif ? "1" : "0", t: p.tampil, ...tambahan });
  if (p.cakupanId) q.set("id", p.cakupanId);
  return q.toString();
}
