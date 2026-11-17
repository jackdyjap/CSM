// Daftar pilihan profil dan penghitung kelengkapan.
// Dipakai di server dan di browser, jadi tidak boleh memakai rahasia apa pun.

export const PILIHAN_GENDER = {
  laki_laki: "Laki-laki",
  perempuan: "Perempuan",
} as const;

export const PILIHAN_NIKAH = {
  single: "Single",
  menikah: "Menikah",
  duda: "Duda",
  janda: "Janda",
} as const;

export const PILIHAN_PENDIDIKAN = {
  tidak_sekolah: "Tidak sekolah",
  sd: "SD",
  smp: "SMP",
  sma_smk: "SMA/SMK",
  d3: "D3",
  s1: "S1",
  s2_ke_atas: "S2 ke atas",
} as const;

export const PILIHAN_PEKERJAAN = {
  tidak_bekerja: "Tidak bekerja",
  irt: "IRT",
  karyawan: "Karyawan",
  wiraswasta: "Wiraswasta",
  pensiunan: "Pensiunan",
  freelancer: "Freelancer",
  profesional: "Profesional",
} as const;

/** Kolom profil yang dibaca halaman (urutannya sama dengan tabel anggota). */
export const KOLOM_PROFIL =
  "id, kelompok_id, nama_lengkap, gender, foto_path, tempat_lahir, tanggal_lahir, alamat, " +
  "provinsi_kode, kota_kode, kecamatan_kode, kelurahan_kode, status_nikah, pendidikan, pekerjaan, " +
  "no_hp, wali_nama, wali_hubungan, persetujuan_pada, persetujuan_dicatat_oleh, aktif";

export type Profil = {
  id: string;
  kelompok_id: string;
  nama_lengkap: string;
  gender: keyof typeof PILIHAN_GENDER | null;
  foto_path: string | null;
  tempat_lahir: string | null;
  tanggal_lahir: string | null;
  alamat: string | null;
  provinsi_kode: string | null;
  kota_kode: string | null;
  kecamatan_kode: string | null;
  kelurahan_kode: string | null;
  status_nikah: keyof typeof PILIHAN_NIKAH | null;
  pendidikan: keyof typeof PILIHAN_PENDIDIKAN | null;
  pekerjaan: keyof typeof PILIHAN_PEKERJAAN | null;
  no_hp: string | null;
  wali_nama: string | null;
  wali_hubungan: string | null;
  persetujuan_pada: string | null;
  persetujuan_dicatat_oleh: "anggota_sendiri" | "pemimpin" | null;
  aktif: boolean;
};

type KolomKelengkapan = Pick<
  Profil,
  | "nama_lengkap" | "gender" | "foto_path" | "tempat_lahir" | "tanggal_lahir" | "alamat"
  | "kelurahan_kode" | "status_nikah" | "pendidikan" | "pekerjaan"
>;

// Profil lengkap = semua isian terisi, kecuali nomor HP (opsional).
// Wilayah dianggap terisi bila sudah sampai kelurahan.
const SYARAT_LENGKAP: [keyof KolomKelengkapan, string][] = [
  ["nama_lengkap", "Nama"],
  ["gender", "Gender"],
  ["foto_path", "Foto"],
  ["tempat_lahir", "Tempat lahir"],
  ["tanggal_lahir", "Tanggal lahir"],
  ["alamat", "Alamat"],
  ["kelurahan_kode", "Wilayah"],
  ["status_nikah", "Status pernikahan"],
  ["pendidikan", "Pendidikan"],
  ["pekerjaan", "Pekerjaan"],
];

/** Kolom yang perlu dibaca untuk menghitung kelengkapan. */
export const KOLOM_KELENGKAPAN = SYARAT_LENGKAP.map(([k]) => k).join(", ");

/** Daftar isian yang masih kosong. Array kosong = profil lengkap. */
export function isianKosong(p: KolomKelengkapan): string[] {
  return SYARAT_LENGKAP.filter(([k]) => !p[k]).map(([, label]) => label);
}

/** Usia (tahun) menurut tanggal hari ini di WIB. */
export function hitungUsia(tanggalLahir: string, hariIni = hariIniWib()): number | null {
  const [y, m, d] = tanggalLahir.split("-").map(Number);
  const [ty, tm, td] = hariIni.split("-").map(Number);
  if (!y || !m || !d) return null;
  let usia = ty - y;
  if (tm < m || (tm === m && td < d)) usia -= 1;
  return usia;
}

/** Tanggal hari ini (YYYY-MM-DD) di WIB. */
export function hariIniWib(): string {
  return new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Jakarta" }).format(new Date());
}

export const USIA_DEWASA = 18;
