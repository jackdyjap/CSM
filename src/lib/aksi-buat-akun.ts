"use server";

// Membuat akun baru langsung dengan tujuannya (keputusan 42):
//   Pemimpin/Wakil : anggota kelompoknya sendiri.
//   Ketua Tim      : anggota, Pemimpin, atau Wakil kelompok di timnya.
//   Admin          : semuanya, termasuk Ketua Tim, Admin, atau tanpa tujuan.
// Hak akses SELALU diperiksa database (izin_buat_akun & pasang_akun_baru).

import { revalidatePath } from "next/cache";
import { buatAkunLogin } from "@/lib/buat-akun";
import { pesanGalat } from "@/lib/galat";
import type { HasilAksi } from "@/lib/hasil";
import { bacaDataLogin, PANJANG_SANDI_MINIMAL, tampilHp } from "@/lib/identitas";
import { wajibMasuk } from "@/lib/sesi";
import { buatClientAdmin } from "@/lib/supabase/admin";

const teks = (fd: FormData, nama: string) => String(fd.get(nama) ?? "").trim();

const LABEL_TUJUAN: Record<string, string> = {
  anggota: "anggota kelompok",
  pemimpin: "Pemimpin kelompok",
  wakil: "Wakil kelompok",
  ketua_tim: "Ketua Tim",
  admin: "Admin",
  tanpa: "akun tanpa kelompok/peran",
};

export async function buatAkunBaru(_: HasilAksi, fd: FormData): Promise<HasilAksi> {
  const { supabase } = await wajibMasuk();
  const nama = teks(fd, "nama");
  const login = bacaDataLogin(fd);
  const sandi = String(fd.get("sandi") ?? "");
  const tujuan = teks(fd, "tujuan") || "anggota";
  const kelompokId = teks(fd, "kelompok_id") || null;
  const timId = teks(fd, "tim_id") || null;

  if (!nama) return { galat: "Nama belum diisi." };
  if (sandi.length < PANJANG_SANDI_MINIMAL) {
    return { galat: `Kata sandi minimal ${PANJANG_SANDI_MINIMAL} karakter.` };
  }

  // 1. Minta izin: database memeriksa hak saya untuk tujuan ini.
  const { data: izin, error: galatIzin } = await supabase.rpc("izin_buat_akun", {
    p_tujuan: tujuan,
    p_kelompok: kelompokId,
    p_tim: timId,
  });
  if (galatIzin || !izin) return { galat: pesanGalat(galatIzin) };

  // 2. Buat akun login (hanya bisa dengan kunci rahasia server).
  const dibuat = await buatAkunLogin({ nama, login, sandi, izin: String(izin) });
  if ("galat" in dibuat) return { galat: dibuat.galat };
  const admin = buatClientAdmin();

  // 3. Pasang tujuannya (profil anggota atau peran). Bila gagal, akun dibatalkan.
  const { error: galatPasang } = await supabase.rpc("pasang_akun_baru", { p_izin: izin, p_akun: dibuat.akunId });
  if (galatPasang) {
    await admin.auth.admin.deleteUser(dibuat.akunId);
    return { galat: pesanGalat(galatPasang) };
  }

  // Kata sandi dari pembuat = sementara; wajib diganti saat login pertama (keputusan 27).
  await admin.rpc("layanan_tandai_sandi", { p_akun: dibuat.akunId, p_sementara: true });

  if (kelompokId) revalidatePath(`/kelompok/${kelompokId}`);
  revalidatePath("/admin/akun", "layout");
  const caraMasuk = [dibuat.rapi.nama_pengguna, dibuat.rapi.email, tampilHp(dibuat.rapi.nomor_hp)]
    .filter(Boolean)
    .join(" / ");
  return {
    sukses: `Akun ${nama} dibuat sebagai ${LABEL_TUJUAN[tujuan] ?? tujuan}. Masuk dengan ${caraMasuk}. Sampaikan kata sandi sementaranya secara pribadi; wajib diganti saat login pertama.`,
  };
}
