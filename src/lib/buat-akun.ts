import "server-only";
import { pesanGalat } from "@/lib/galat";
import { adaDataLogin, alamatAuthBaru, alamatAuthCadangan, PESAN_LOGIN_KOSONG, type DataLogin } from "@/lib/identitas";
import { buatClientAdmin } from "@/lib/supabase/admin";

type Rapi = { nama_pengguna: string | null; email: string | null; nomor_hp: string | null };

/**
 * Membuat akun login baru (dipakai pendaftaran lewat undangan dan Admin).
 * 1. Database memeriksa isian: sah dan belum dipakai siapa pun.
 * 2. Akun dibuat di Supabase Auth. Baris di tabel akun (dengan nama pengguna,
 *    email, nomor HP) dibuat otomatis oleh database dari user_metadata.
 *
 * anggotaId = profil yang akan disambungkan (undangan untuk profil yang sudah
 * dibuat pemimpin), supaya nomor HP di profil itu boleh dipakai.
 *
 * izin = kode izin dari izin_buat_akun (akun dibuat pengurus, keputusan 42),
 * disimpan di data akun supaya database bisa memastikan akun ini memang
 * dibuat dengan izin itu.
 */
export async function buatAkunLogin({
  nama,
  login,
  sandi,
  anggotaId = null,
  izin = null,
}: {
  nama: string;
  login: DataLogin;
  sandi: string;
  anggotaId?: string | null;
  izin?: string | null;
}): Promise<{ galat: string } | { akunId: string; alamat: string; rapi: Rapi }> {
  if (!adaDataLogin(login)) return { galat: PESAN_LOGIN_KOSONG };

  const admin = buatClientAdmin();
  const { data, error } = await admin.rpc("layanan_cek_login_baru", {
    p_nama_pengguna: login.nama_pengguna || null,
    p_email: login.email || null,
    p_nomor_hp: login.nomor_hp || null,
    p_anggota: anggotaId,
  });
  if (error) return { galat: pesanGalat(error, "Isian cara masuk belum bisa diperiksa. Coba lagi.") };
  const rapi = (Array.isArray(data) ? data[0] : data) as Rapi | undefined;
  if (!rapi) return { galat: "Isian cara masuk belum bisa diperiksa. Coba lagi." };

  const buat = (alamat: string) =>
    admin.auth.admin.createUser({
      email: alamat,
      password: sandi,
      email_confirm: true,
      user_metadata: {
        nama,
        nama_pengguna: rapi.nama_pengguna,
        email: rapi.email,
        nomor_hp: rapi.nomor_hp,
        ...(izin ? { izin } : {}),
      },
    });

  let alamat = alamatAuthBaru(rapi);
  let hasil = await buat(alamat);
  // Alamat itu masih tercatat di Supabase Auth (mis. pemiliknya sudah mengganti
  // email/nomor HP-nya): pakai alamat pengganti. Pengguna tetap masuk dengan isiannya.
  if (hasil.error && (hasil.error.code === "email_exists" || /already/i.test(hasil.error.message))) {
    alamat = alamatAuthCadangan();
    hasil = await buat(alamat);
  }
  if (hasil.error || !hasil.data.user) {
    // Alasan asli dicatat di Logs Vercel supaya bisa dilacak.
    console.error("Supabase Auth menolak pembuatan akun:", {
      kode: hasil.error?.code,
      status: hasil.error?.status,
      pesan: hasil.error?.message,
      alamatPengganti: alamat.endsWith(".invalid"),
    });
    return { galat: pesanGagalBuat(hasil.error, alamat) };
  }

  return { akunId: hasil.data.user.id, alamat, rapi };
}

/** Pesan yang jelas untuk penolakan dari Supabase Auth (bukan sekadar "Coba lagi"). */
function pesanGagalBuat(galat: { code?: string; message?: string } | null, alamat: string): string {
  const kode = galat?.code ?? "";
  const pesan = galat?.message ?? "";
  if (kode === "weak_password" || /password/i.test(pesan)) {
    return "Kata sandi ditolak karena terlalu lemah. Pakai minimal 8 karakter campuran huruf dan angka (mis. Rembrant2026).";
  }
  if (kode === "email_address_invalid" || /email.*invalid|invalid.*email/i.test(pesan)) {
    return alamat.endsWith(".invalid")
      ? "Akun belum bisa dibuat hanya dengan nama pengguna atau nomor HP. Isi juga email Anda, lalu coba lagi."
      : "Alamat email tidak diterima. Periksa penulisannya, atau pakai email lain.";
  }
  if (kode === "over_request_rate_limit" || /rate limit/i.test(pesan)) {
    return "Terlalu banyak percobaan. Tunggu beberapa menit, lalu coba lagi.";
  }
  if (kode === "unexpected_failure" || /database error/i.test(pesan)) {
    return "Akun gagal dibuat karena ada masalah di database. Hubungi pemimpin kelompok atau Admin.";
  }
  return "Akun gagal dibuat. Coba lagi beberapa saat lagi; bila tetap gagal, hubungi pemimpin kelompok.";
}
