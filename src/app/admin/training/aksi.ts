"use server";

import { revalidatePath } from "next/cache";
import { pesanGalat } from "@/lib/galat";
import type { HasilAksi } from "@/lib/hasil";
import { wajibAdmin } from "@/lib/sesi";
import { BUCKET_TRAINING, kodeYoutube, UKURAN_TRAINING_MAKS } from "@/lib/training";

function segarkan() {
  revalidatePath("/admin/training");
  revalidatePath("/training", "layout");
  revalidatePath("/beranda");
}

type Peruntukan = { semua: boolean; ketuaTim: boolean; pemimpin: boolean; anggota: boolean };

function kolomPeruntukan(p: Peruntukan) {
  return {
    untuk_semua: p.semua,
    untuk_ketua_tim: !p.semua && p.ketuaTim,
    untuk_pemimpin: !p.semua && p.pemimpin,
    untuk_anggota: !p.semua && p.anggota,
  };
}

const adaPeruntukan = (p: Peruntukan) => p.semua || p.ketuaTim || p.pemimpin || p.anggota;
const PESAN_PERUNTUKAN = "Pilih peruntukan: Semua, atau minimal satu peran.";

/** Mencatat bahan training: PDF yang SUDAH diunggah dari peramban Admin, atau video YouTube. */
export async function catatTraining(isi: {
  id: string;
  judul: string;
  keterangan: string;
  peruntukan: Peruntukan;
  pdf?: { lokasi: string; nama: string; ukuran: number };
  tautanVideo?: string;
}): Promise<HasilAksi> {
  const { supabase } = await wajibAdmin();
  const judul = isi.judul.trim();
  const hapusBerkas = async () => {
    if (isi.pdf) await supabase.storage.from(BUCKET_TRAINING).remove([isi.pdf.lokasi]);
  };
  if (!judul) {
    await hapusBerkas();
    return { galat: "Judul wajib diisi." };
  }
  if (!adaPeruntukan(isi.peruntukan)) {
    await hapusBerkas();
    return { galat: PESAN_PERUNTUKAN };
  }

  let isiJenis;
  if (isi.pdf) {
    if (isi.pdf.ukuran > UKURAN_TRAINING_MAKS) {
      await hapusBerkas();
      return { galat: "Berkas lebih dari 10 MB." };
    }
    isiJenis = { jenis: "pdf", lokasi: isi.pdf.lokasi, nama_berkas: isi.pdf.nama, ukuran: isi.pdf.ukuran };
  } else {
    const kode = kodeYoutube(isi.tautanVideo ?? "");
    if (!kode) return { galat: "Tautan video tidak dikenali. Tempel tautan YouTube, mis. https://youtu.be/…" };
    isiJenis = { jenis: "video", video_id: kode };
  }

  const { error } = await supabase.from("bahan_training").insert({
    id: isi.id,
    judul,
    keterangan: isi.keterangan.trim() || null,
    ...isiJenis,
    ...kolomPeruntukan(isi.peruntukan),
  });
  if (error) {
    await hapusBerkas();
    return { galat: pesanGalat(error, "Bahan gagal dicatat. Coba lagi.") };
  }
  segarkan();
  return { sukses: `Bahan "${judul}" tersimpan.` };
}

function bacaPeruntukan(fd: FormData): Peruntukan {
  return {
    semua: fd.get("untuk_semua") === "ya",
    ketuaTim: fd.get("untuk_ketua_tim") === "ya",
    pemimpin: fd.get("untuk_pemimpin") === "ya",
    anggota: fd.get("untuk_anggota") === "ya",
  };
}

/** Mengubah judul, keterangan, dan peruntukan (berkas/video tetap). */
export async function ubahTraining(id: string, _: HasilAksi, fd: FormData): Promise<HasilAksi> {
  const { supabase } = await wajibAdmin();
  const judul = String(fd.get("judul") ?? "").trim();
  if (!judul) return { galat: "Judul wajib diisi." };
  const p = bacaPeruntukan(fd);
  if (!adaPeruntukan(p)) return { galat: PESAN_PERUNTUKAN };
  const { error } = await supabase
    .from("bahan_training")
    .update({ judul, keterangan: String(fd.get("keterangan") ?? "").trim() || null, ...kolomPeruntukan(p) })
    .eq("id", id);
  if (error) return { galat: pesanGalat(error) };
  segarkan();
  return { sukses: "Perubahan tersimpan." };
}

export async function hapusTraining(id: string, lokasi: string | null): Promise<HasilAksi> {
  const { supabase } = await wajibAdmin();
  const { error } = await supabase.from("bahan_training").delete().eq("id", id);
  if (error) return { galat: pesanGalat(error) };
  // Berkas juga masuk antrean hapus otomatis; dihapus langsung supaya ruang segera kosong.
  if (lokasi) await supabase.storage.from(BUCKET_TRAINING).remove([lokasi]);
  segarkan();
  return { sukses: "Bahan dihapus." };
}
