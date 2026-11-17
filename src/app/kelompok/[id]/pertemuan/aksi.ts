"use server";

import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { pesanGalat } from "@/lib/galat";
import type { HasilAksi } from "@/lib/hasil";
import { bacaRupiah, PILIHAN_ALASAN } from "@/lib/pertemuan";
import { hariIniWib } from "@/lib/profil";
import { bolehKelola, wajibMasuk } from "@/lib/sesi";

// Hak akses SELALU diperiksa database (aturan akses + tutup_pertemuan).
// Pemeriksaan di sini hanya untuk pesan yang lebih jelas.

const teks = (fd: FormData, nama: string) => String(fd.get(nama) ?? "").trim();

function segarkan(kelompokId: string, pertemuanId?: string) {
  revalidatePath(`/kelompok/${kelompokId}/pertemuan`);
  if (pertemuanId) revalidatePath(`/kelompok/${kelompokId}/pertemuan/${pertemuanId}`);
}

/** Pertemuan milik kelompok ini (sekaligus memastikan bisa dibaca). */
async function ambilPertemuan(kelompokId: string, pertemuanId: string) {
  const { supabase, peran } = await wajibMasuk();
  const pemimpin = bolehKelola(peran, kelompokId);
  const { data } = await supabase
    .from("pertemuan")
    .select("id, ditutup_pada")
    .eq("id", pertemuanId)
    .eq("kelompok_id", kelompokId)
    .maybeSingle();
  return { supabase, pemimpin, pertemuan: data };
}

// ---------------------------------------------------------------- Mulai

export async function mulaiPertemuan(kelompokId: string, _: HasilAksi, fd: FormData): Promise<HasilAksi> {
  const { supabase, peran } = await wajibMasuk();
  if (!bolehKelola(peran, kelompokId)) {
    return { galat: "Anda tidak berhak mengelola kelompok ini." };
  }
  const tanggal = teks(fd, "tanggal") || hariIniWib();
  if (!/^\d{4}-\d{2}-\d{2}$/.test(tanggal)) return { galat: "Tanggal tidak sah." };
  if (tanggal > hariIniWib()) return { galat: "Tanggal pertemuan tidak boleh di masa depan." };

  // Satu kelompok hanya satu pertemuan per tanggal: bila sudah ada, buka yang itu.
  const { data: ada } = await supabase
    .from("pertemuan")
    .select("id")
    .eq("kelompok_id", kelompokId)
    .eq("tanggal", tanggal)
    .maybeSingle();

  let id = ada?.id as string | undefined;
  if (!id) {
    const { data, error } = await supabase
      .from("pertemuan")
      .insert({ kelompok_id: kelompokId, tanggal, dibuka_pada: new Date().toISOString() })
      .select("id")
      .single();
    if (error || !data) return { galat: pesanGalat(error) };
    id = data.id as string;
    segarkan(kelompokId);
  }
  redirect(`/kelompok/${kelompokId}/pertemuan/${id}`);
}

// ---------------------------------------------------------------- Tandai hadir

export async function tandaiHadir(
  kelompokId: string,
  pertemuanId: string,
  anggotaId: string,
  hadir: boolean,
): Promise<HasilAksi> {
  const { supabase, pemimpin, pertemuan } = await ambilPertemuan(kelompokId, pertemuanId);
  if (!pemimpin || !pertemuan) return { galat: "Anda tidak berhak mengubah absensi ini." };
  if (pertemuan.ditutup_pada) return { galat: "Absensi sudah ditutup. Buka kembali untuk mengubah." };

  const { error } = hadir
    ? await supabase.from("kehadiran").upsert(
        {
          pertemuan_id: pertemuanId,
          anggota_id: anggotaId,
          kelompok_id: kelompokId,
          hadir: true,
          cara: "manual",
          alasan: null,
          alasan_catatan: null,
          waktu: new Date().toISOString(),
        },
        { onConflict: "pertemuan_id,anggota_id" },
      )
    : await supabase.from("kehadiran").delete().eq("pertemuan_id", pertemuanId).eq("anggota_id", anggotaId);

  if (error) return { galat: pesanGalat(error) };
  segarkan(kelompokId, pertemuanId);
  return {};
}

// ---------------------------------------------------------------- Persembahan & catatan

export async function simpanRingkasan(
  kelompokId: string,
  pertemuanId: string,
  _: HasilAksi,
  fd: FormData,
): Promise<HasilAksi> {
  const persembahan = bacaRupiah(teks(fd, "persembahan"));
  if (Number.isNaN(persembahan)) return { galat: "Persembahan hanya boleh berisi angka, contoh: 150.000" };

  const { supabase, pemimpin, pertemuan } = await ambilPertemuan(kelompokId, pertemuanId);
  if (!pemimpin || !pertemuan) return { galat: "Anda tidak berhak mengubah pertemuan ini." };

  const { error } = await supabase
    .from("pertemuan")
    .update({ persembahan, catatan: teks(fd, "catatan") || null })
    .eq("id", pertemuanId);
  if (error) return { galat: pesanGalat(error) };

  segarkan(kelompokId, pertemuanId);
  return { sukses: "Persembahan dan catatan tersimpan." };
}

// ---------------------------------------------------------------- Tutup / buka kembali

export async function tutupAbsensi(kelompokId: string, pertemuanId: string): Promise<HasilAksi> {
  const { supabase } = await wajibMasuk();
  const { data, error } = await supabase.rpc("tutup_pertemuan", { p_pertemuan: pertemuanId });
  if (error) return { galat: pesanGalat(error) };
  segarkan(kelompokId, pertemuanId);
  const n = Number(data ?? 0);
  return {
    sukses:
      n > 0
        ? `Absensi ditutup. ${n} anggota tercatat tidak hadir; isi alasannya di bawah.`
        : "Absensi ditutup.",
  };
}

export async function bukaKembali(kelompokId: string, pertemuanId: string): Promise<HasilAksi> {
  const { supabase, pemimpin, pertemuan } = await ambilPertemuan(kelompokId, pertemuanId);
  if (!pemimpin || !pertemuan) return { galat: "Anda tidak berhak mengubah pertemuan ini." };
  const { error } = await supabase.from("pertemuan").update({ ditutup_pada: null }).eq("id", pertemuanId);
  if (error) return { galat: pesanGalat(error) };
  segarkan(kelompokId, pertemuanId);
  return { sukses: "Absensi dibuka kembali." };
}

// ---------------------------------------------------------------- Alasan tidak hadir

export async function simpanAlasan(
  kelompokId: string,
  pertemuanId: string,
  anggotaId: string,
  _: HasilAksi,
  fd: FormData,
): Promise<HasilAksi> {
  const alasan = teks(fd, "alasan");
  if (alasan && !(alasan in PILIHAN_ALASAN)) return { galat: "Alasan tidak dikenal." };
  const catatan = teks(fd, "alasan_catatan");
  if (catatan.length > 500) return { galat: "Catatan terlalu panjang (maksimal 500 huruf)." };

  const { supabase, pemimpin, pertemuan } = await ambilPertemuan(kelompokId, pertemuanId);
  if (!pemimpin || !pertemuan) return { galat: "Anda tidak berhak mengubah absensi ini." };

  const { data, error } = await supabase
    .from("kehadiran")
    .update({ alasan: alasan || null, alasan_catatan: catatan || null })
    .eq("pertemuan_id", pertemuanId)
    .eq("anggota_id", anggotaId)
    .eq("hadir", false)
    .select("anggota_id");
  if (error) return { galat: pesanGalat(error) };
  if (!data?.length) return { galat: "Data tidak hadir untuk anggota ini tidak ditemukan." };

  segarkan(kelompokId, pertemuanId);
  return { sukses: "Tersimpan." };
}

// ---------------------------------------------------------------- Hapus

export async function hapusPertemuan(kelompokId: string, pertemuanId: string): Promise<HasilAksi> {
  const { supabase, pemimpin, pertemuan } = await ambilPertemuan(kelompokId, pertemuanId);
  if (!pemimpin || !pertemuan) return { galat: "Anda tidak berhak menghapus pertemuan ini." };
  const { error } = await supabase.from("pertemuan").delete().eq("id", pertemuanId);
  if (error) return { galat: pesanGalat(error) };
  segarkan(kelompokId);
  redirect(`/kelompok/${kelompokId}/pertemuan`);
}
