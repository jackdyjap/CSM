"use server";

import { revalidatePath } from "next/cache";
import { BUCKET_BAHAN, UKURAN_BAHAN_MAKS } from "@/lib/bahan";
import { pesanGalat } from "@/lib/galat";
import type { HasilAksi } from "@/lib/hasil";
import { wajibAdmin } from "@/lib/sesi";

function segarkan() {
  revalidatePath("/admin/bahan");
  revalidatePath("/bahan");
  revalidatePath("/beranda");
}

/** Mencatat bahan yang berkasnya SUDAH diunggah dari peramban Admin. */
export async function catatBahan(isi: {
  id: string;
  lokasi: string;
  nama: string;
  ukuran: number;
  judul: string;
  keterangan: string;
  tanggalPakai: string;
  timId: string;
}): Promise<HasilAksi> {
  const { supabase } = await wajibAdmin();
  const judul = isi.judul.trim();
  if (!judul) return { galat: "Judul wajib diisi." };
  if (isi.ukuran > UKURAN_BAHAN_MAKS) return { galat: "Berkas lebih dari 10 MB." };
  if (isi.tanggalPakai && !/^\d{4}-\d{2}-\d{2}$/.test(isi.tanggalPakai)) return { galat: "Tanggal tidak sah." };

  const { error } = await supabase.from("bahan_diskusi").insert({
    id: isi.id,
    judul,
    keterangan: isi.keterangan.trim() || null,
    tanggal_pakai: isi.tanggalPakai || null,
    tim_id: isi.timId || null,
    lokasi: isi.lokasi,
    nama_berkas: isi.nama,
    ukuran: isi.ukuran,
  });
  if (error) {
    await supabase.storage.from(BUCKET_BAHAN).remove([isi.lokasi]);
    return { galat: pesanGalat(error, "Bahan gagal dicatat. Coba lagi.") };
  }
  segarkan();
  return { sukses: `Bahan "${judul}" tersimpan.` };
}

/** Mengubah judul, keterangan, tanggal, dan tujuan (berkas tetap). */
export async function ubahBahan(id: string, _: HasilAksi, fd: FormData): Promise<HasilAksi> {
  const { supabase } = await wajibAdmin();
  const judul = String(fd.get("judul") ?? "").trim();
  const tanggal = String(fd.get("tanggal_pakai") ?? "").trim();
  if (!judul) return { galat: "Judul wajib diisi." };
  const { error } = await supabase
    .from("bahan_diskusi")
    .update({
      judul,
      keterangan: String(fd.get("keterangan") ?? "").trim() || null,
      tanggal_pakai: tanggal || null,
      tim_id: String(fd.get("tim_id") ?? "") || null,
    })
    .eq("id", id);
  if (error) return { galat: pesanGalat(error) };
  segarkan();
  return { sukses: "Perubahan tersimpan." };
}

export async function hapusBahan(id: string, lokasi: string): Promise<HasilAksi> {
  const { supabase } = await wajibAdmin();
  const { error } = await supabase.from("bahan_diskusi").delete().eq("id", id);
  if (error) return { galat: pesanGalat(error) };
  // Berkas juga masuk antrean hapus otomatis; dihapus langsung supaya ruang segera kosong.
  await supabase.storage.from(BUCKET_BAHAN).remove([lokasi]);
  segarkan();
  return { sukses: "Bahan dihapus." };
}
