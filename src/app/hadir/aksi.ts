"use server";

import { revalidatePath } from "next/cache";
import { pesanGalat } from "@/lib/galat";
import { wajibMasuk } from "@/lib/sesi";

export type HasilCheckIn = { galat?: string; sudah?: boolean; kelompok?: string; tanggal?: string };

/**
 * Check-in mandiri dengan kode QR pertemuan. Database memastikan kode masih
 * berlaku (45 detik + satu jendela sebelumnya), untuk kelompok sendiri,
 * hari ini, selama absensi dibuka, dan sekali per anggota.
 */
export async function checkIn(kode: string): Promise<HasilCheckIn> {
  if (!/^[0-9a-f]{20}$/.test(kode)) return { galat: "Ini bukan QR pertemuan. Scan QR yang tampil di layar pemimpin." };
  const { supabase, peran } = await wajibMasuk();
  if (!peran.anggota) return { galat: "Akun Anda belum terhubung ke profil anggota. Hubungi pemimpin kelompok." };

  const { data, error } = await supabase.rpc("check_in", { p_kode: kode });
  if (error) {
    if (error.code === "23505") return { sudah: true, kelompok: peran.anggota.kelompok_nama };
    return { galat: pesanGalat(error, "Check-in gagal. Coba scan ulang.") };
  }
  const baris = Array.isArray(data) ? data[0] : null;
  revalidatePath("/profil");
  return { kelompok: (baris?.kelompok_nama as string) ?? peran.anggota.kelompok_nama, tanggal: baris?.tanggal as string };
}
