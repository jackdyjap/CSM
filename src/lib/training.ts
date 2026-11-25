// Bahan training: PDF privat atau video YouTube, dengan peruntukan per peran (keputusan 54).

export const BUCKET_TRAINING = "bahan-training";
export const UKURAN_TRAINING_MAKS = 10 * 1024 * 1024;
/** Tautan sementara berkas PDF: cukup untuk memuat, lalu kedaluwarsa. */
export const UMUR_TAUTAN_TRAINING = 300;

export type BarisTraining = {
  id: string;
  judul: string;
  keterangan: string | null;
  jenis: "pdf" | "video";
  lokasi: string | null;
  nama_berkas: string | null;
  ukuran: number | null;
  video_id: string | null;
  untuk_semua: boolean;
  untuk_ketua_tim: boolean;
  untuk_pemimpin: boolean;
  untuk_anggota: boolean;
  dibuat_pada: string;
};

export const KOLOM_TRAINING =
  "id, judul, keterangan, jenis, lokasi, nama_berkas, ukuran, video_id, untuk_semua, untuk_ketua_tim, untuk_pemimpin, untuk_anggota, dibuat_pada";

export const PILIHAN_PERUNTUKAN = [
  ["untuk_ketua_tim", "Ketua Tim"],
  ["untuk_pemimpin", "Pemimpin/Wakil kelompok"],
  ["untuk_anggota", "Anggota"],
] as const;

export function labelPeruntukan(b: Pick<BarisTraining, "untuk_semua" | "untuk_ketua_tim" | "untuk_pemimpin" | "untuk_anggota">) {
  if (b.untuk_semua) return "Semua";
  return PILIHAN_PERUNTUKAN.filter(([k]) => b[k]).map(([, l]) => l).join(", ");
}

/**
 * Kode video (11 karakter) dari tautan YouTube: youtu.be/…, youtube.com/watch?v=…,
 * /shorts/…, /embed/…, /live/…. Null bila bukan tautan YouTube yang sah.
 */
export function kodeYoutube(teks: string): string | null {
  const t = teks.trim();
  if (/^[A-Za-z0-9_-]{11}$/.test(t)) return t;
  let u: URL;
  try {
    u = new URL(t);
  } catch {
    return null;
  }
  const host = u.hostname.replace(/^(www\.|m\.|music\.)/, "");
  let kode: string | null = null;
  if (host === "youtu.be") kode = u.pathname.slice(1).split("/")[0];
  else if (host === "youtube.com" || host === "youtube-nocookie.com") {
    if (u.pathname === "/watch") kode = u.searchParams.get("v");
    else {
      const m = u.pathname.match(/^\/(shorts|embed|live|v)\/([^/]+)/);
      kode = m ? m[2] : null;
    }
  }
  return kode && /^[A-Za-z0-9_-]{11}$/.test(kode) ? kode : null;
}

/** Nama berkas aman untuk lokasi penyimpanan. */
export function namaBerkasTraining(nama: string) {
  const dasar = nama.replace(/\.pdf$/i, "").normalize("NFKD").replace(/[^\w.-]+/g, "-").replace(/-+/g, "-");
  return `${dasar.slice(0, 80) || "bahan"}.pdf`;
}
