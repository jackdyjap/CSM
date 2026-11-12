"use server";

import { redirect } from "next/navigation";
import type { HasilAksi } from "@/lib/hasil";
import { bacaIdentitas, PANJANG_SANDI_MINIMAL, PESAN_IDENTITAS_SALAH } from "@/lib/identitas";
import { buatClientAdmin } from "@/lib/supabase/admin";
import { buatClientServer } from "@/lib/supabase/server";

export async function daftarLewatUndangan(
  token: string,
  _: HasilAksi,
  fd: FormData,
): Promise<HasilAksi> {
  const nama = String(fd.get("nama") ?? "").trim();
  const identitas = bacaIdentitas(String(fd.get("identitas") ?? ""));
  const sandi = String(fd.get("sandi") ?? "");
  const ulang = String(fd.get("sandi_ulang") ?? "");

  if (!nama) return { galat: "Nama belum diisi." };
  if (!identitas) return { galat: PESAN_IDENTITAS_SALAH };
  if (sandi.length < PANJANG_SANDI_MINIMAL) {
    return { galat: `Kata sandi minimal ${PANJANG_SANDI_MINIMAL} karakter.` };
  }
  if (sandi !== ulang) return { galat: "Kedua kata sandi tidak sama." };

  const admin = buatClientAdmin();

  // 1. Pastikan undangan masih berlaku.
  const { data: cek } = await admin.rpc("layanan_cek_undangan", { p_token: token });
  if (!Array.isArray(cek) || !cek[0]?.berlaku) {
    return { galat: "Tautan undangan sudah tidak berlaku. Minta tautan baru kepada pemimpin kelompok." };
  }

  // 2. Buat akun login.
  const { data: dibuat, error: galatAkun } = await admin.auth.admin.createUser({
    email: identitas.emailLogin,
    password: sandi,
    email_confirm: true,
    user_metadata: { nama, login: identitas.tampil },
  });
  if (galatAkun || !dibuat.user) {
    if (galatAkun?.code === "email_exists" || /already/i.test(galatAkun?.message ?? "")) {
      return {
        galat: `${identitas.tampil} sudah terdaftar. Silakan masuk, atau minta tautan atur ulang kata sandi kepada pemimpin kelompok.`,
      };
    }
    return { galat: "Akun gagal dibuat. Coba lagi." };
  }

  // 3. Sambungkan akun ke kelompok. Bila gagal, akun yang baru dibuat dihapus lagi.
  const { error: galatPakai } = await admin.rpc("layanan_pakai_undangan", {
    p_token: token,
    p_akun: dibuat.user.id,
    p_nama: nama,
  });
  if (galatPakai) {
    await admin.auth.admin.deleteUser(dibuat.user.id);
    return { galat: "Tautan undangan sudah tidak berlaku. Minta tautan baru kepada pemimpin kelompok." };
  }

  // 4. Langsung masuk.
  const supabase = await buatClientServer();
  await supabase.auth.signInWithPassword({ email: identitas.emailLogin, password: sandi });
  redirect("/beranda");
}
