"use server";

import { revalidatePath } from "next/cache";
import { periksaBacaan, type VersiAlkitab } from "@/lib/alkitab";
import { pesanGalat } from "@/lib/galat";
import type { HasilAksi } from "@/lib/hasil";
import { DURASI_MAKS, hariIniWib, TUNTUNAN_MAKS } from "@/lib/saat-teduh";
import { wajibMasuk } from "@/lib/sesi";

// Hanya pemilik yang bisa menambah/mengubah/menghapus; dijaga aturan akses database (keputusan 58).

const teks = (fd: FormData, nama: string) => String(fd.get(nama) ?? "").trim();
const angka = (fd: FormData, nama: string) => {
  const t = teks(fd, nama);
  return t === "" ? null : Number(t);
};

function bacaIsian(fd: FormData) {
  const tanggal = teks(fd, "tanggal");
  const jam = teks(fd, "jam_mulai");
  const durasi = angka(fd, "durasi_menit");
  const versi = teks(fd, "versi") as VersiAlkitab;
  const kitab = angka(fd, "kitab") ?? 0;
  const pasal = angka(fd, "pasal") ?? 0;
  let ayatAwal = angka(fd, "ayat_awal");
  let ayatAkhir = angka(fd, "ayat_akhir");
  const tuntunan = teks(fd, "tuntunan");

  if (!/^\d{4}-\d{2}-\d{2}$/.test(tanggal)) return { galat: "Isi tanggal saat teduh." };
  if (tanggal > hariIniWib()) return { galat: "Tanggal saat teduh tidak boleh tanggal yang akan datang." };
  if (!/^\d{2}:\d{2}$/.test(jam)) return { galat: "Isi jam mulai." };
  if (durasi == null || !Number.isInteger(durasi) || durasi < 1 || durasi > DURASI_MAKS) {
    return { galat: `Durasi diisi angka menit, 1 sampai ${DURASI_MAKS}.` };
  }
  if (versi !== "tb" && versi !== "amd") return { galat: "Pilih versi Alkitab." };
  // Hanya satu ujung ayat diisi = satu ayat saja.
  if (ayatAwal != null && ayatAkhir == null) ayatAkhir = ayatAwal;
  if (ayatAkhir != null && ayatAwal == null) ayatAwal = ayatAkhir;
  const bacaan = { kitab, pasal, ayat_awal: ayatAwal, ayat_akhir: ayatAkhir };
  const salah = periksaBacaan(bacaan);
  if (salah) return { galat: salah };
  if (tuntunan.length > TUNTUNAN_MAKS) return { galat: `Tuntunan maksimal ${TUNTUNAN_MAKS} karakter.` };

  return {
    isi: {
      tanggal,
      jam_mulai: jam,
      durasi_menit: durasi,
      versi,
      ...bacaan,
      tuntunan: tuntunan || null,
    },
  };
}

function segarkan() {
  revalidatePath("/saat-teduh", "layout");
  revalidatePath("/beranda");
}

/** Menambah (id = null) atau mengubah catatan saat teduh milik saya. */
export async function simpanSaatTeduh(id: string | null, _: HasilAksi, fd: FormData): Promise<HasilAksi> {
  const { supabase } = await wajibMasuk();
  const hasil = bacaIsian(fd);
  if (!hasil.isi) return { galat: hasil.galat };

  if (id) {
    const { data, error } = await supabase.from("saat_teduh").update(hasil.isi).eq("id", id).select("id");
    if (error) return { galat: pesanGalat(error, "Catatan gagal disimpan. Coba lagi.") };
    if (!data?.length) return { galat: "Catatan tidak ditemukan, atau bukan milik Anda." };
    segarkan();
    return { sukses: "Perubahan tersimpan." };
  }

  const { error } = await supabase.from("saat_teduh").insert(hasil.isi);
  if (error) return { galat: pesanGalat(error, "Catatan gagal disimpan. Coba lagi.") };
  segarkan();
  return { sukses: "Saat teduh tercatat." };
}

export async function hapusSaatTeduh(id: string): Promise<HasilAksi> {
  const { supabase } = await wajibMasuk();
  const { data, error } = await supabase.from("saat_teduh").delete().eq("id", id).select("id");
  if (error) return { galat: pesanGalat(error, "Catatan gagal dihapus. Coba lagi.") };
  if (!data?.length) return { galat: "Catatan tidak ditemukan, atau bukan milik Anda." };
  segarkan();
  return { sukses: "Catatan dihapus." };
}
