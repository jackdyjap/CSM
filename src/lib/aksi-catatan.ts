"use server";

import { revalidatePath } from "next/cache";
import { pesanGalat } from "@/lib/galat";
import type { HasilAksi } from "@/lib/hasil";
import { PILIHAN_JENIS_CATATAN } from "@/lib/pilihan-fase5";
import { wajibMasuk } from "@/lib/sesi";

// Catatan khusus hanya bisa diakses lewat fungsi database (tulis_catatan,
// ubah_catatan, hapus_catatan, baca_catatan), yang memeriksa hak dan
// mencatat setiap tindakan di log. Pemeriksaan di sini hanya untuk pesan.

const teks = (fd: FormData, nama: string) => String(fd.get(nama) ?? "").trim();
const BATAS_ISI = 2000;

function jenisSah(nilai: string) {
  return nilai in PILIHAN_JENIS_CATATAN ? nilai : null;
}

function segarkan(kelompokId: string, anggotaId: string) {
  revalidatePath(`/kelompok/${kelompokId}/anggota/${anggotaId}`);
  revalidatePath(`/kelompok/${kelompokId}/tindak-lanjut`);
}

export async function tulisCatatan(
  kelompokId: string,
  anggotaId: string,
  _: HasilAksi,
  fd: FormData,
): Promise<HasilAksi> {
  const isi = teks(fd, "isi");
  const jenis = jenisSah(teks(fd, "jenis"));
  if (!isi) return { galat: "Isi catatan belum diisi." };
  if (isi.length > BATAS_ISI) return { galat: `Catatan terlalu panjang (maksimal ${BATAS_ISI} huruf).` };
  if (!jenis) return { galat: "Pilih jenis catatan." };

  const { supabase } = await wajibMasuk();
  const { error } = await supabase.rpc("tulis_catatan", { p_anggota: anggotaId, p_jenis: jenis, p_isi: isi });
  if (error) return { galat: pesanGalat(error) };
  segarkan(kelompokId, anggotaId);
  return { sukses: "Catatan tersimpan." };
}

export async function ubahCatatan(
  kelompokId: string,
  anggotaId: string,
  catatanId: string,
  _: HasilAksi,
  fd: FormData,
): Promise<HasilAksi> {
  const isi = teks(fd, "isi");
  const jenis = jenisSah(teks(fd, "jenis"));
  if (!isi) return { galat: "Isi catatan tidak boleh kosong." };
  if (isi.length > BATAS_ISI) return { galat: `Catatan terlalu panjang (maksimal ${BATAS_ISI} huruf).` };

  const { supabase } = await wajibMasuk();
  const { error } = await supabase.rpc("ubah_catatan", { p_catatan: catatanId, p_isi: isi, p_jenis: jenis });
  if (error) return { galat: pesanGalat(error) };
  segarkan(kelompokId, anggotaId);
  return { sukses: "Catatan diubah." };
}

export async function hapusCatatan(kelompokId: string, anggotaId: string, catatanId: string): Promise<HasilAksi> {
  const { supabase } = await wajibMasuk();
  const { error } = await supabase.rpc("hapus_catatan", { p_catatan: catatanId });
  if (error) return { galat: pesanGalat(error) };
  segarkan(kelompokId, anggotaId);
  return { sukses: "Catatan dihapus." };
}
