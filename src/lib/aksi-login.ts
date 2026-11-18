"use server";

import type { HasilAksi } from "@/lib/hasil";
import { bacaDataLogin } from "@/lib/identitas";
import { simpanLogin } from "@/lib/login-server";
import { wajibMasuk } from "@/lib/sesi";

/** Pengguna mengubah nama pengguna, email, dan nomor HP untuk masuk (keputusan 25). */
export async function ubahLoginSaya(_: HasilAksi, fd: FormData): Promise<HasilAksi> {
  const { supabase, peran } = await wajibMasuk();
  return simpanLogin(supabase, peran.akun_id, bacaDataLogin(fd), ["/profil", "/beranda"]);
}
