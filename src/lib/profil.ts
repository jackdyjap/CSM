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
  d3: "Diploma",
  s1: "S1",
  s2_ke_atas: "S2 ke atas",
} as const;

/** Baptis (keputusan 29). Disimpan sebagai true/false; "" = belum diisi. */
export const PILIHAN_BAPTIS = {
  sudah: "Sudah",
  belum: "Belum",
} as const;

/** Status jemaat (keputusan 30). Diatur pemimpin, Ketua Tim, atau Admin. */
export const PILIHAN_STATUS_JEMAAT = {
  tamu: "Tamu",
  member: "Member",
  pelayan: "Pelayan",
  leader: "Leader",
} as const;

/** true/false/null -> "sudah"/"belum"/null */
export function kunciBaptis(baptis: boolean | null | undefined): keyof typeof PILIHAN_BAPTIS | null {
  return baptis === true ? "sudah" : baptis === false ? "belum" : null;
}

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
  "id, kelompok_id, nama_lengkap, gender, foto_path, tahun_lahir, " +
  "provinsi_kode, kota_kode, status_nikah, pendidikan, pekerjaan, baptis, status_jemaat, " +
  "no_hp, wali_nama, wali_hubungan, persetujuan_pada, persetujuan_dicatat_oleh, aktif";

export type Profil = {
  id: string;
  kelompok_id: string;
  nama_lengkap: string;
  gender: keyof typeof PILIHAN_GENDER | null;
  foto_path: string | null;
  /** Tahun lahir saja (keputusan 46). */
  tahun_lahir: number | null;
  provinsi_kode: string | null;
  kota_kode: string | null;
  status_nikah: keyof typeof PILIHAN_NIKAH | null;
  pendidikan: keyof typeof PILIHAN_PENDIDIKAN | null;
  pekerjaan: keyof typeof PILIHAN_PEKERJAAN | null;
  baptis: boolean | null;
  status_jemaat: keyof typeof PILIHAN_STATUS_JEMAAT | null;
  no_hp: string | null;
  wali_nama: string | null;
  wali_hubungan: string | null;
  persetujuan_pada: string | null;
  persetujuan_dicatat_oleh: "anggota_sendiri" | "pemimpin" | null;
  aktif: boolean;
};

type KolomKelengkapan = Pick<
  Profil,
  | "nama_lengkap" | "gender" | "foto_path" | "tahun_lahir"
  | "kota_kode" | "status_nikah" | "pendidikan" | "pekerjaan" | "baptis"
>;

// Profil lengkap = semua isian terisi, kecuali nomor HP (opsional).
// Wilayah dianggap terisi bila sudah sampai kota/kabupaten (keputusan 46).
const SYARAT_LENGKAP: [keyof KolomKelengkapan, string][] = [
  ["nama_lengkap", "Nama"],
  ["gender", "Gender"],
  ["foto_path", "Foto"],
  ["tahun_lahir", "Tahun lahir"],
  ["kota_kode", "Wilayah"],
  ["status_nikah", "Status pernikahan"],
  ["pendidikan", "Pendidikan"],
  ["pekerjaan", "Pekerjaan"],
  ["baptis", "Baptis"],
];

/** Kolom yang perlu dibaca untuk menghitung kelengkapan. */
export const KOLOM_KELENGKAPAN = SYARAT_LENGKAP.map(([k]) => k).join(", ");

/** Daftar isian yang masih kosong. Array kosong = profil lengkap. */
export function isianKosong(p: KolomKelengkapan): string[] {
  // Baptis "Belum" (false) dihitung sudah diisi; yang kosong hanya null/"".
  return SYARAT_LENGKAP.filter(([k]) => p[k] === null || p[k] === undefined || p[k] === "").map(([, label]) => label);
}

/** Tahun ini (WIB). */
export function tahunIni(): number {
  return Number(hariIniWib().slice(0, 4));
}

/** Usia kira-kira dari tahun lahir: tahun ini - tahun lahir (keputusan 46). */
export function usiaDariTahun(tahunLahir: number | null | undefined, tahun = tahunIni()): number | null {
  return tahunLahir ? tahun - tahunLahir : null;
}

/** Tanggal hari ini (YYYY-MM-DD) di WIB. */
export function hariIniWib(): string {
  return new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Jakarta" }).format(new Date());
}

/** Anggota berusia 18 tahun ke bawah: isian orang tua/wali ditampilkan (tidak wajib, keputusan 46). */
export const BATAS_USIA_WALI = 18;
export const TAHUN_LAHIR_MIN = 1900;
