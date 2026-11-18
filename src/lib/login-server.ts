import "server-only";
import { revalidatePath } from "next/cache";
import { pesanGalat } from "@/lib/galat";
import type { HasilAksi } from "@/lib/hasil";
import { adaDataLogin, PESAN_LOGIN_KOSONG, type DataLogin } from "@/lib/identitas";
import type { buatClientServer } from "@/lib/supabase/server";

type Supabase = Awaited<ReturnType<typeof buatClientServer>>;

export type IsiLogin = { nama_pengguna: string | null; email: string | null; nomor_hp: string | null };

/** Nama pengguna, email, dan nomor HP (08xx) sebuah akun. Hanya untuk diri sendiri atau Admin. */
export async function bacaDataLoginAkun(supabase: Supabase, akunId: string): Promise<IsiLogin | null> {
  const { data } = await supabase.rpc("data_login", { p_akun: akunId });
  return ((Array.isArray(data) ? data[0] : data) as IsiLogin | undefined) ?? null;
}

/**
 * Menyimpan cara masuk lewat loket database ubah_login (keputusan 25).
 * Database memeriksa hak, format, dan keunikan; nomor HP ikut tersimpan
 * di profil anggota bila akun terhubung ke profil.
 */
export async function simpanLogin(
  supabase: Supabase,
  akunId: string,
  login: DataLogin,
  jalurSegarkan: string[],
): Promise<HasilAksi> {
  if (!adaDataLogin(login)) return { galat: PESAN_LOGIN_KOSONG };

  const { data, error } = await supabase.rpc("ubah_login", {
    p_akun: akunId,
    p_nama_pengguna: login.nama_pengguna || null,
    p_email: login.email || null,
    p_nomor_hp: login.nomor_hp || null,
  });
  if (error) return { galat: pesanGalat(error) };

  for (const jalur of jalurSegarkan) revalidatePath(jalur);
  return { sukses: `Cara masuk tersimpan: ${data}.` };
}
