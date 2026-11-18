// Cara masuk ke aplikasi (keputusan 6 dan 25).
//
// Satu akun boleh punya nama pengguna, email, dan nomor HP sekaligus; masuk
// cukup dengan salah satunya. Ketiganya unik dan diperiksa di database
// (migrasi …1500). Server mencari alamat login Supabase Auth lewat
// layanan_cari_login().
//
// Nomor HP tidak memakai SMS (Cara B). Akun yang dibuat tanpa email memakai
// alamat pengganti berakhiran ".invalid", yang tidak akan pernah menerima email.

export const DOMAIN_HP = "hp.invalid";
export const PANJANG_SANDI_MINIMAL = 8;

export type DataLogin = { nama_pengguna: string; email: string; nomor_hp: string };

/** Ketiga isian cara masuk dari formulir (boleh kosong; dirapikan di database). */
export function bacaDataLogin(fd: FormData): DataLogin {
  const ambil = (nama: string) => String(fd.get(nama) ?? "").trim();
  return { nama_pengguna: ambil("nama_pengguna"), email: ambil("email"), nomor_hp: ambil("nomor_hp") };
}

export const PESAN_LOGIN_KOSONG = "Isi minimal satu: nama pengguna, email, atau nomor HP.";

export function adaDataLogin(d: DataLogin) {
  return Boolean(d.nama_pengguna || d.email || d.nomor_hp);
}

/**
 * Alamat login Supabase Auth untuk akun baru, dari isian yang SUDAH dirapikan
 * database (huruf kecil; nomor HP 628xxx). Email asli dipakai bila ada.
 */
export function alamatAuthBaru(d: { nama_pengguna: string | null; email: string | null; nomor_hp: string | null }) {
  if (d.email) return d.email;
  if (d.nomor_hp) return `${d.nomor_hp}@${DOMAIN_HP}`;
  return `${d.nama_pengguna}@nama.invalid`;
}

/** Alamat cadangan bila alamat di atas ternyata masih tercatat di Supabase Auth. */
export function alamatAuthCadangan() {
  return `${crypto.randomUUID()}@akun.invalid`;
}

/** 6281234567890 -> 081234567890 (nomor HP yang tersimpan di database). */
export function tampilHp(hp: string | null | undefined) {
  if (!hp) return "";
  return hp.startsWith("62") ? "0" + hp.slice(2) : hp;
}
