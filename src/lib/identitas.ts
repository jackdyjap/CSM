// Mengubah isian "Email atau nomor HP" menjadi alamat login.
//
// Nomor HP tidak memakai SMS (Cara B). Di belakang layar nomor HP diubah
// menjadi alamat email pengganti, misalnya 081234567890 -> 6281234567890@hp.invalid.
// Akhiran ".invalid" disediakan khusus untuk alamat yang tidak nyata, sehingga
// tidak akan pernah ada email yang terkirim ke alamat ini.

export const DOMAIN_HP = "hp.invalid";

export type Identitas = {
  jenis: "email" | "hp";
  /** Alamat yang dipakai untuk login ke Supabase. */
  emailLogin: string;
  /** Yang ditampilkan ke pengguna, misalnya 081234567890 atau nama@contoh.com. */
  tampil: string;
};

const POLA_EMAIL = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/;

export function bacaIdentitas(masukan: string): Identitas | null {
  const teks = masukan.trim();
  if (!teks) return null;

  if (teks.includes("@")) {
    const email = teks.toLowerCase();
    if (!POLA_EMAIL.test(email) || email.endsWith(`@${DOMAIN_HP}`)) return null;
    return { jenis: "email", emailLogin: email, tampil: email };
  }

  // Nomor HP: buang spasi, tanda hubung, titik, dan kurung.
  let angka = teks.replace(/[\s\-.()]/g, "");
  if (angka.startsWith("+")) angka = angka.slice(1);
  if (!/^\d+$/.test(angka)) return null;

  if (angka.startsWith("0")) angka = "62" + angka.slice(1);
  else if (angka.startsWith("8")) angka = "62" + angka;

  // Nomor Indonesia: 62 + 8 + 7 sampai 11 angka.
  if (!/^628\d{7,11}$/.test(angka)) return null;

  return {
    jenis: "hp",
    emailLogin: `${angka}@${DOMAIN_HP}`,
    tampil: "0" + angka.slice(2),
  };
}

export const PESAN_IDENTITAS_SALAH =
  "Tulis email yang benar (contoh: nama@gmail.com) atau nomor HP Indonesia (contoh: 081234567890).";

export const PANJANG_SANDI_MINIMAL = 8;
