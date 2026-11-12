import "server-only";
import { redirect } from "next/navigation";
import { buatClientServer } from "@/lib/supabase/server";

export type PeranSaya = {
  akun_id: string;
  nama: string;
  login: string | null;
  admin: boolean;
  ketua_tim: { tim_id: string; nama: string }[];
  pemimpin: {
    kelompok_id: string;
    nama: string;
    tim_nama: string;
    jabatan: "pemimpin" | "wakil";
  }[];
  anggota: {
    anggota_id: string;
    nama: string;
    kelompok_id: string;
    kelompok_nama: string;
  } | null;
};

/** Mengambil data peran pengguna yang sedang login, atau null bila belum login. */
export async function ambilPeranSaya() {
  const supabase = await buatClientServer();
  const { data: klaim } = await supabase.auth.getClaims();
  if (!klaim?.claims) return { supabase, peran: null };

  const { data } = await supabase.rpc("peran_saya");
  return { supabase, peran: (data as PeranSaya | null) ?? null };
}

/** Untuk halaman yang wajib login. Bila belum login, diarahkan ke /masuk. */
export async function wajibMasuk() {
  const { supabase, peran } = await ambilPeranSaya();
  if (!peran) redirect("/masuk");
  return { supabase, peran };
}

/** Untuk halaman khusus Admin. */
export async function wajibAdmin() {
  const hasil = await wajibMasuk();
  if (!hasil.peran.admin) redirect("/beranda");
  return hasil;
}
