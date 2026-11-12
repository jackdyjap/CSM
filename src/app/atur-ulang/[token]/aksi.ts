"use server";

import { redirect } from "next/navigation";
import type { HasilAksi } from "@/lib/hasil";
import { PANJANG_SANDI_MINIMAL } from "@/lib/identitas";
import { buatClientAdmin } from "@/lib/supabase/admin";

export async function aturUlangSandi(token: string, _: HasilAksi, fd: FormData): Promise<HasilAksi> {
  const sandi = String(fd.get("sandi") ?? "");
  const ulang = String(fd.get("sandi_ulang") ?? "");
  if (sandi.length < PANJANG_SANDI_MINIMAL) {
    return { galat: `Kata sandi minimal ${PANJANG_SANDI_MINIMAL} karakter.` };
  }
  if (sandi !== ulang) return { galat: "Kedua kata sandi tidak sama." };

  const admin = buatClientAdmin();
  const { data: akunId, error } = await admin.rpc("layanan_pakai_tautan_atur_ulang", { p_token: token });
  if (error || !akunId) {
    return { galat: "Tautan sudah tidak berlaku. Minta tautan baru kepada pemimpin kelompok." };
  }

  const { error: galatUbah } = await admin.auth.admin.updateUserById(akunId as string, { password: sandi });
  if (galatUbah) {
    return { galat: "Kata sandi gagal diubah. Minta tautan baru kepada pemimpin kelompok." };
  }
  redirect("/masuk?pesan=sandi-diubah");
}
