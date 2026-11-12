"use server";

import { redirect } from "next/navigation";
import { bacaIdentitas, PESAN_IDENTITAS_SALAH } from "@/lib/identitas";
import { buatClientServer } from "@/lib/supabase/server";

export type HasilMasuk = { galat?: string; identitas?: string };

export async function masuk(_sebelumnya: HasilMasuk, formData: FormData): Promise<HasilMasuk> {
  const isian = String(formData.get("identitas") ?? "");
  const sandi = String(formData.get("sandi") ?? "");

  const identitas = bacaIdentitas(isian);
  if (!identitas) return { galat: PESAN_IDENTITAS_SALAH, identitas: isian };
  if (!sandi) return { galat: "Kata sandi belum diisi.", identitas: isian };

  const supabase = await buatClientServer();
  const { error } = await supabase.auth.signInWithPassword({
    email: identitas.emailLogin,
    password: sandi,
  });

  if (error) {
    return {
      galat: "Email/nomor HP atau kata sandi salah. Periksa lagi, atau hubungi pemimpin kelompok Anda.",
      identitas: isian,
    };
  }
  redirect("/beranda");
}
