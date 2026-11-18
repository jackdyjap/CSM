"use server";

// Masukan (keputusan 28). Hak akses SELALU diperiksa database (loket kirim_masukan,
// tanggapi_masukan); pemeriksaan di sini untuk pesan yang jelas.

import { revalidatePath } from "next/cache";
import { pesanGalat } from "@/lib/galat";
import type { HasilAksi } from "@/lib/hasil";
import { pilihan, teks } from "@/lib/isian";
import { JENIS_MASUKAN, PANJANG_ISI_MAKS, PANJANG_JUDUL_MAKS, STATUS_MASUKAN, TUJUAN_MASUKAN } from "@/lib/masukan";
import { wajibMasuk } from "@/lib/sesi";

export async function kirimMasukan(_: HasilAksi, fd: FormData): Promise<HasilAksi> {
  const [tujuanTeks, kelompok] = String(fd.get("tujuan") ?? "").split("|");
  const tujuan = tujuanTeks in TUJUAN_MASUKAN ? tujuanTeks : null;
  const jenis = pilihan(fd, "jenis", JENIS_MASUKAN);
  const judul = teks(fd, "judul");
  const isi = teks(fd, "isi");
  if (!tujuan) return { galat: "Pilih kepada siapa masukan ini ditujukan." };
  if (!jenis) return { galat: "Pilih jenis masukan." };
  if (!judul || !isi) return { galat: "Judul dan isi masukan wajib diisi." };
  if (judul.length > PANJANG_JUDUL_MAKS) return { galat: `Judul maksimal ${PANJANG_JUDUL_MAKS} karakter.` };
  if (isi.length > PANJANG_ISI_MAKS) return { galat: `Isi maksimal ${PANJANG_ISI_MAKS} karakter.` };

  const { supabase } = await wajibMasuk();
  const { error } = await supabase.rpc("kirim_masukan", {
    p_tujuan: tujuan,
    p_kelompok: kelompok || null,
    p_jenis: jenis,
    p_judul: judul,
    p_isi: isi,
    p_anonim: fd.get("anonim") === "ya",
  });
  if (error) return { galat: pesanGalat(error) };
  revalidatePath("/masukan");
  return { sukses: "Masukan terkirim. Terima kasih! Status dan balasannya bisa dilihat di bawah." };
}

export async function tanggapiMasukan(id: string, _: HasilAksi, fd: FormData): Promise<HasilAksi> {
  const status = pilihan(fd, "status", STATUS_MASUKAN);
  const balasan = teks(fd, "balasan");
  if (!status) return { galat: "Pilih status." };
  if (balasan && balasan.length > PANJANG_ISI_MAKS) return { galat: `Balasan maksimal ${PANJANG_ISI_MAKS} karakter.` };

  const { supabase } = await wajibMasuk();
  const { error } = await supabase.rpc("tanggapi_masukan", { p_id: id, p_status: status, p_balasan: balasan });
  if (error) return { galat: pesanGalat(error) };
  revalidatePath("/masukan/masuk");
  revalidatePath("/beranda");
  return { sukses: "Tanggapan tersimpan." };
}
