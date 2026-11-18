"use server";

// Atur profil sendiri untuk semua peran (keputusan 27): kata sandi, nama,
// dan profil staf (Admin/Ketua Tim/Pemimpin yang bukan anggota kelompok).
// Hak akses SELALU diperiksa database; pemeriksaan di sini untuk pesan yang jelas.

import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { pesanGalat } from "@/lib/galat";
import type { HasilAksi } from "@/lib/hasil";
import { PANJANG_SANDI_MINIMAL } from "@/lib/identitas";
import { baptis as bacaBaptis, pilihan, teks } from "@/lib/isian";
import { PILIHAN_GENDER, PILIHAN_NIKAH, PILIHAN_PEKERJAAN, PILIHAN_PENDIDIKAN } from "@/lib/profil";
import { wajibMasuk } from "@/lib/sesi";
import { buatClientAdmin } from "@/lib/supabase/admin";

const BUCKET_FOTO = "foto-anggota";
const UKURAN_FOTO_MAKS = 2 * 1024 * 1024;
const JENIS_FOTO = ["image/jpeg", "image/png", "image/webp"];

// ---------------------------------------------------------------- Kata sandi

export async function gantiSandi(_: HasilAksi, fd: FormData): Promise<HasilAksi> {
  const sandi = String(fd.get("sandi") ?? "");
  const ulang = String(fd.get("sandi_ulang") ?? "");
  if (sandi.length < PANJANG_SANDI_MINIMAL) return { galat: `Kata sandi minimal ${PANJANG_SANDI_MINIMAL} karakter.` };
  if (sandi !== ulang) return { galat: "Kedua kata sandi tidak sama." };

  const { supabase, peran } = await wajibMasuk();
  const { error } = await supabase.auth.updateUser({ password: sandi });
  if (error) {
    if (error.code === "same_password") return { galat: "Kata sandi baru harus berbeda dari kata sandi sekarang." };
    if (error.code === "weak_password") return { galat: "Kata sandi terlalu lemah. Pakai kombinasi huruf dan angka." };
    return { galat: "Kata sandi gagal diubah. Coba lagi." };
  }

  // Kata sandi sementara dari Admin sudah diganti.
  if (peran.sandi_sementara) {
    await buatClientAdmin().rpc("layanan_tandai_sandi", { p_akun: peran.akun_id, p_sementara: false });
  }
  revalidatePath("/profil");
  return { sukses: "Kata sandi diubah. Pakai kata sandi baru saat masuk berikutnya." };
}

// ---------------------------------------------------------------- Nama (akun tanpa profil anggota)

export async function ubahNamaSaya(_: HasilAksi, fd: FormData): Promise<HasilAksi> {
  const nama = teks(fd, "nama");
  if (!nama) return { galat: "Nama belum diisi." };
  const { supabase, peran } = await wajibMasuk();
  const { data, error } = await supabase
    .from("akun")
    .update({ nama_tampilan: nama })
    .eq("id", peran.akun_id)
    .select("id");
  if (error) return { galat: pesanGalat(error) };
  if (!data?.length) return { galat: "Nama gagal diubah." };
  revalidatePath("/profil");
  revalidatePath("/beranda");
  return { sukses: "Nama tersimpan." };
}

// ---------------------------------------------------------------- Selesai Atur profil

export async function selesaiAturProfil(): Promise<HasilAksi> {
  const { supabase } = await wajibMasuk();
  const { error } = await supabase.rpc("selesai_atur_profil");
  if (error) return { galat: pesanGalat(error) };
  revalidatePath("/", "layout");
  redirect("/beranda");
}

// ---------------------------------------------------------------- Profil staf

export async function catatPersetujuanStaf(_: HasilAksi, fd: FormData): Promise<HasilAksi> {
  if (fd.get("setuju") !== "ya") return { galat: "Centang kotak persetujuan terlebih dahulu." };
  const { supabase, peran } = await wajibMasuk();
  // Waktu persetujuan diisi otomatis oleh database.
  const { error } = await supabase.from("profil_staf").insert({ akun_id: peran.akun_id });
  if (error) return { galat: pesanGalat(error, "Persetujuan tidak bisa dicatat. Coba lagi.") };
  revalidatePath("/profil");
  return { sukses: "Persetujuan tercatat. Sekarang profil bisa diisi." };
}

export async function simpanProfilStaf(_: HasilAksi, fd: FormData): Promise<HasilAksi> {
  const tanggalLahir = teks(fd, "tanggal_lahir");
  if (tanggalLahir && !/^\d{4}-\d{2}-\d{2}$/.test(tanggalLahir)) return { galat: "Tanggal lahir tidak sah." };

  // Wilayah: simpan sampai tingkat terdalam yang dipilih, tanpa celah.
  const provinsi = teks(fd, "provinsi_kode");
  const kota = provinsi ? teks(fd, "kota_kode") : null;
  const kecamatan = kota ? teks(fd, "kecamatan_kode") : null;
  const kelurahan = kecamatan ? teks(fd, "kelurahan_kode") : null;

  const { supabase, peran } = await wajibMasuk();
  const { data, error } = await supabase
    .from("profil_staf")
    .update({
      gender: pilihan(fd, "gender", PILIHAN_GENDER),
      tempat_lahir: teks(fd, "tempat_lahir"),
      tanggal_lahir: tanggalLahir,
      alamat: teks(fd, "alamat"),
      provinsi_kode: provinsi,
      kota_kode: kota,
      kecamatan_kode: kecamatan,
      kelurahan_kode: kelurahan,
      status_nikah: pilihan(fd, "status_nikah", PILIHAN_NIKAH),
      pendidikan: pilihan(fd, "pendidikan", PILIHAN_PENDIDIKAN),
      pekerjaan: pilihan(fd, "pekerjaan", PILIHAN_PEKERJAAN),
      baptis: bacaBaptis(fd),
    })
    .eq("akun_id", peran.akun_id)
    .select("akun_id");
  if (error) {
    if (error.code === "23514" && error.message.includes("wilayah")) {
      return { galat: "Pilihan wilayah tidak nyambung. Pilih ulang dari provinsi." };
    }
    return { galat: pesanGalat(error) };
  }
  if (!data?.length) return { galat: "Catat persetujuan data terlebih dahulu sebelum mengisi profil." };
  revalidatePath("/profil");
  return { sukses: "Profil tersimpan." };
}

/** Menerima foto yang SUDAH dikecilkan di HP, menyimpannya di folder privat staf/<id akun>/. */
export async function unggahFotoStaf(fd: FormData): Promise<HasilAksi> {
  const foto = fd.get("foto");
  if (!(foto instanceof File) || foto.size === 0) return { galat: "Foto belum dipilih." };
  if (!JENIS_FOTO.includes(foto.type)) return { galat: "Foto harus berformat JPG, PNG, atau WEBP." };
  if (foto.size > UKURAN_FOTO_MAKS) return { galat: "Ukuran foto lebih dari 2 MB." };

  const { supabase, peran } = await wajibMasuk();
  const ekstensi = foto.type.split("/")[1].replace("jpeg", "jpg");
  const lokasi = `staf/${peran.akun_id}/${Date.now()}.${ekstensi}`;
  const { error: galatUnggah } = await supabase.storage
    .from(BUCKET_FOTO)
    .upload(lokasi, foto, { contentType: foto.type, upsert: false });
  if (galatUnggah) return { galat: "Foto gagal diunggah. Coba lagi." };

  // Foto lama otomatis masuk antrean hapus (penjaga di database).
  const { data, error } = await supabase
    .from("profil_staf")
    .update({ foto_path: lokasi })
    .eq("akun_id", peran.akun_id)
    .select("akun_id");
  if (error || !data?.length) {
    await supabase.storage.from(BUCKET_FOTO).remove([lokasi]);
    return { galat: error ? pesanGalat(error) : "Catat persetujuan data terlebih dahulu sebelum memasang foto." };
  }
  revalidatePath("/profil");
  return { sukses: "Foto tersimpan." };
}

export async function hapusFotoStaf(): Promise<HasilAksi> {
  const { supabase, peran } = await wajibMasuk();
  const { error } = await supabase.from("profil_staf").update({ foto_path: null }).eq("akun_id", peran.akun_id);
  if (error) return { galat: pesanGalat(error) };
  revalidatePath("/profil");
  return { sukses: "Foto dihapus." };
}
