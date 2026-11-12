"use server";

import { revalidatePath } from "next/cache";
import { alamatSitus } from "@/lib/alamat";
import { waktuWib } from "@/lib/format";
import { pesanGalat } from "@/lib/galat";
import type { HasilAksi } from "@/lib/hasil";
import { wajibMasuk } from "@/lib/sesi";

// Semua pemeriksaan hak akses dilakukan oleh fungsi database
// (buat_undangan / buat_tautan_atur_ulang), bukan hanya di sini.

export async function buatUndangan(
  kelompokId: string,
  anggotaId: string | null,
  namaAnggota: string | null,
): Promise<HasilAksi> {
  const { supabase } = await wajibMasuk();
  const { data, error } = await supabase.rpc("buat_undangan", {
    p_kelompok: kelompokId,
    p_anggota: anggotaId,
  });
  const baris = Array.isArray(data) ? data[0] : null;
  if (error || !baris) return { galat: pesanGalat(error) };

  revalidatePath(`/kelompok/${kelompokId}`);
  const tautan = `${await alamatSitus()}/undangan/${baris.token}`;
  const sapaan = namaAnggota ? `Halo ${namaAnggota}` : "Halo";
  return {
    tautan,
    teksWa: `${sapaan}, ini tautan untuk bergabung di aplikasi absensi kelompok kita. Buka lalu buat akun (berlaku sampai ${waktuWib(baris.kedaluwarsa_pada)}): ${tautan}`,
  };
}

export async function batalkanUndangan(
  kelompokId: string,
  undanganId: string,
): Promise<HasilAksi> {
  const { supabase } = await wajibMasuk();
  const { error } = await supabase.from("undangan").delete().eq("id", undanganId);
  if (error) return { galat: pesanGalat(error) };
  revalidatePath(`/kelompok/${kelompokId}`);
  return { sukses: "Undangan dibatalkan." };
}

export async function buatTautanAturUlang(
  akunId: string,
  nama: string,
): Promise<HasilAksi> {
  const { supabase } = await wajibMasuk();
  const { data, error } = await supabase.rpc("buat_tautan_atur_ulang", { p_akun: akunId });
  const baris = Array.isArray(data) ? data[0] : null;
  if (error || !baris) return { galat: pesanGalat(error) };

  const tautan = `${await alamatSitus()}/atur-ulang/${baris.token}`;
  return {
    tautan,
    teksWa: `Halo ${nama}, ini tautan untuk membuat kata sandi baru di aplikasi absensi kelompok (berlaku 24 jam, sekali pakai): ${tautan}`,
  };
}
