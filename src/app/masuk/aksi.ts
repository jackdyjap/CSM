"use server";

import { redirect } from "next/navigation";
import { tujuanAman } from "@/lib/tujuan";
import { buatClientAdmin } from "@/lib/supabase/admin";
import { buatClientServer } from "@/lib/supabase/server";

export type HasilMasuk = { galat?: string; identitas?: string };

// Pesan yang sama untuk "tidak terdaftar" dan "kata sandi salah", supaya
// orang lain tidak bisa menebak nama pengguna/email/nomor HP mana yang terdaftar.
const PESAN_GAGAL =
  "Nama pengguna/email/nomor HP atau kata sandi salah. Periksa lagi, atau hubungi pemimpin kelompok Anda.";

export async function masuk(_sebelumnya: HasilMasuk, formData: FormData): Promise<HasilMasuk> {
  const isian = String(formData.get("identitas") ?? "").trim();
  const sandi = String(formData.get("sandi") ?? "");

  if (!isian) return { galat: "Isi nama pengguna, email, atau nomor HP Anda.", identitas: isian };
  if (!sandi) return { galat: "Kata sandi belum diisi.", identitas: isian };

  // Cari alamat login Supabase Auth dari nama pengguna / email / nomor HP.
  const { data: alamat, error: galatCari } = await buatClientAdmin().rpc("layanan_cari_login", { p_isian: isian });
  if (galatCari) return { galat: "Belum bisa masuk. Coba lagi sebentar lagi.", identitas: isian };
  if (typeof alamat !== "string" || !alamat) return { galat: PESAN_GAGAL, identitas: isian };

  const supabase = await buatClientServer();
  const { error } = await supabase.auth.signInWithPassword({ email: alamat, password: sandi });
  if (error) return { galat: PESAN_GAGAL, identitas: isian };

  redirect(tujuanAman(formData.get("lanjut")));
}
