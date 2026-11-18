"use server";

import { redirect } from "next/navigation";
import { buatAkunLogin } from "@/lib/buat-akun";
import type { HasilAksi } from "@/lib/hasil";
import { bacaDataLogin, PANJANG_SANDI_MINIMAL } from "@/lib/identitas";
import { buatClientAdmin } from "@/lib/supabase/admin";
import { buatClientServer } from "@/lib/supabase/server";

const PESAN_TIDAK_BERLAKU = "Tautan undangan sudah tidak berlaku. Minta tautan baru kepada pemimpin kelompok.";

export async function daftarLewatUndangan(
  token: string,
  _: HasilAksi,
  fd: FormData,
): Promise<HasilAksi> {
  const nama = String(fd.get("nama") ?? "").trim();
  const login = bacaDataLogin(fd);
  const sandi = String(fd.get("sandi") ?? "");
  const ulang = String(fd.get("sandi_ulang") ?? "");

  if (!nama) return { galat: "Nama belum diisi." };
  if (sandi.length < PANJANG_SANDI_MINIMAL) {
    return { galat: `Kata sandi minimal ${PANJANG_SANDI_MINIMAL} karakter.` };
  }
  if (sandi !== ulang) return { galat: "Kedua kata sandi tidak sama." };

  const admin = buatClientAdmin();

  // 1. Pastikan undangan masih berlaku.
  const { data: cek } = await admin.rpc("layanan_cek_undangan", { p_token: token });
  if (!Array.isArray(cek) || !cek[0]?.berlaku) return { galat: PESAN_TIDAK_BERLAKU };
  // Undangan untuk profil yang sudah dibuat pemimpin: nomor HP di profil itu boleh dipakai.
  const { data: undangan } = await admin.from("undangan").select("anggota_id").eq("token", token).maybeSingle();

  // 2. Buat akun login (isian diperiksa dulu: sah dan belum dipakai).
  const dibuat = await buatAkunLogin({ nama, login, sandi, anggotaId: undangan?.anggota_id ?? null });
  if ("galat" in dibuat) return { galat: dibuat.galat };

  // 3. Sambungkan akun ke kelompok. Bila gagal, akun yang baru dibuat dihapus lagi.
  const { error: galatPakai } = await admin.rpc("layanan_pakai_undangan", {
    p_token: token,
    p_akun: dibuat.akunId,
    p_nama: nama,
  });
  if (galatPakai) {
    await admin.auth.admin.deleteUser(dibuat.akunId);
    return { galat: PESAN_TIDAK_BERLAKU };
  }

  // 4. Langsung masuk.
  const supabase = await buatClientServer();
  await supabase.auth.signInWithPassword({ email: dibuat.alamat, password: sandi });
  redirect("/beranda");
}
