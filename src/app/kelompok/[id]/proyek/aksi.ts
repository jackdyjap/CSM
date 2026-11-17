"use server";

import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { pesanGalat } from "@/lib/galat";
import type { HasilAksi } from "@/lib/hasil";
import { PILIHAN_STATUS_PROYEK, type StatusProyek } from "@/lib/pilihan-fase5";
import { hariIniWib } from "@/lib/profil";
import { bolehKelola, wajibMasuk } from "@/lib/sesi";

// Hak akses SELALU diperiksa database (aturan akses proyek_ketaatan dan
// status_proyek: pemimpin/wakil kelompok itu dan Admin).

const teks = (fd: FormData, nama: string) => String(fd.get(nama) ?? "").trim();
const tanggalSah = (t: string) => /^\d{4}-\d{2}-\d{2}$/.test(t);

function segarkan(kelompokId: string, proyekId?: string) {
  revalidatePath(`/kelompok/${kelompokId}/proyek`);
  revalidatePath(`/kelompok/${kelompokId}/tindak-lanjut`);
  if (proyekId) revalidatePath(`/kelompok/${kelompokId}/proyek/${proyekId}`);
}

function bacaIsian(fd: FormData) {
  const judul = teks(fd, "judul");
  const keterangan = teks(fd, "keterangan") || null;
  const diberikan = teks(fd, "diberikan_pada") || hariIniWib();
  const tenggat = teks(fd, "tenggat") || null;
  if (!judul) return { galat: "Judul proyek belum diisi." } as const;
  if (!tanggalSah(diberikan) || (tenggat && !tanggalSah(tenggat))) return { galat: "Tanggal tidak sah." } as const;
  if (tenggat && tenggat < diberikan) return { galat: "Tenggat tidak boleh sebelum tanggal diberikan." } as const;
  return { isi: { judul, keterangan, diberikan_pada: diberikan, tenggat } } as const;
}

export async function buatProyek(kelompokId: string, _: HasilAksi, fd: FormData): Promise<HasilAksi> {
  const { supabase, peran } = await wajibMasuk();
  if (!bolehKelola(peran, kelompokId)) return { galat: "Anda tidak berhak mengelola kelompok ini." };
  const hasil = bacaIsian(fd);
  if ("galat" in hasil) return { galat: hasil.galat };

  const { data, error } = await supabase
    .from("proyek_ketaatan")
    .insert({ ...hasil.isi, kelompok_id: kelompokId })
    .select("id")
    .single();
  if (error || !data) return { galat: pesanGalat(error) };
  segarkan(kelompokId);
  redirect(`/kelompok/${kelompokId}/proyek/${data.id}`);
}

export async function ubahProyek(kelompokId: string, proyekId: string, _: HasilAksi, fd: FormData): Promise<HasilAksi> {
  const hasil = bacaIsian(fd);
  if ("galat" in hasil) return { galat: hasil.galat };
  const { supabase } = await wajibMasuk();
  const { data, error } = await supabase
    .from("proyek_ketaatan")
    .update(hasil.isi)
    .eq("id", proyekId)
    .eq("kelompok_id", kelompokId)
    .select("id");
  if (error) return { galat: pesanGalat(error) };
  if (!data?.length) return { galat: "Anda tidak berhak mengubah proyek ini." };
  segarkan(kelompokId, proyekId);
  return { sukses: "Proyek diperbarui." };
}

export async function hapusProyek(kelompokId: string, proyekId: string): Promise<HasilAksi> {
  const { supabase } = await wajibMasuk();
  const { data, error } = await supabase
    .from("proyek_ketaatan")
    .delete()
    .eq("id", proyekId)
    .eq("kelompok_id", kelompokId)
    .select("id");
  if (error) return { galat: pesanGalat(error) };
  if (!data?.length) return { galat: "Anda tidak berhak menghapus proyek ini." };
  segarkan(kelompokId);
  redirect(`/kelompok/${kelompokId}/proyek`);
}

/**
 * Menyimpan status satu anggota, dan keterangannya bila diberikan.
 * Dipanggil dari layar dengan status TERKINI, supaya tidak menimpa ketukan terakhir.
 */
export async function setelStatus(
  kelompokId: string,
  proyekId: string,
  anggotaId: string,
  status: StatusProyek,
  keterangan?: string,
): Promise<HasilAksi> {
  if (!(status in PILIHAN_STATUS_PROYEK)) return { galat: "Status tidak dikenal." };
  const baris: Record<string, unknown> = { proyek_id: proyekId, anggota_id: anggotaId, kelompok_id: kelompokId, status };
  if (keterangan !== undefined) {
    const k = keterangan.trim();
    if (k.length > 500) return { galat: "Keterangan terlalu panjang (maksimal 500 huruf)." };
    baris.keterangan = k || null;
  }
  const { supabase } = await wajibMasuk();
  const { error } = await supabase.from("status_proyek").upsert(baris, { onConflict: "proyek_id,anggota_id" });
  if (error) return { galat: pesanGalat(error) };
  segarkan(kelompokId, proyekId);
  return keterangan !== undefined ? { sukses: "Tersimpan." } : {};
}
