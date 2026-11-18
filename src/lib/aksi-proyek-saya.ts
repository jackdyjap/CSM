"use server";

import { revalidatePath } from "next/cache";
import { pesanGalat } from "@/lib/galat";
import type { HasilAksi } from "@/lib/hasil";
import { pilihan, teks } from "@/lib/isian";
import { PILIHAN_LAPOR_PROYEK } from "@/lib/pilihan-fase5";
import { wajibMasuk } from "@/lib/sesi";

/** Anggota melaporkan proyek ketaatannya sendiri (keputusan 36). Diperiksa database. */
export async function laporProyekSaya(proyekId: string, _: HasilAksi, fd: FormData): Promise<HasilAksi> {
  const status = pilihan(fd, "status", PILIHAN_LAPOR_PROYEK);
  const alasan = teks(fd, "alasan");
  const hasil = teks(fd, "hasil");
  if (!status) return { galat: "Pilih status proyek." };
  if (status === "belum" && !alasan) return { galat: "Tuliskan alasan belum menjalankan proyek ini." };
  if (status === "selesai" && !hasil) return { galat: "Tuliskan hasil yang didapat dari menjalankan proyek ini." };

  const { supabase } = await wajibMasuk();
  const { error } = await supabase.rpc("lapor_proyek_saya", {
    p_proyek: proyekId,
    p_status: status,
    p_alasan: alasan,
    p_hasil: hasil,
  });
  if (error) return { galat: pesanGalat(error) };
  revalidatePath("/profil");
  revalidatePath("/beranda");
  return { sukses: "Laporan proyek tersimpan." };
}
