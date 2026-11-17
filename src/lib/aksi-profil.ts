"use server";

import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { pesanGalat } from "@/lib/galat";
import type { HasilAksi } from "@/lib/hasil";
import {
  hitungUsia,
  PILIHAN_GENDER,
  PILIHAN_NIKAH,
  PILIHAN_PEKERJAAN,
  PILIHAN_PENDIDIKAN,
  USIA_DEWASA,
} from "@/lib/profil";
import { bolehKelola, wajibMasuk } from "@/lib/sesi";

// Hak akses SELALU diperiksa database (aturan akses + penjaga jaga_anggota).
// Pemeriksaan di sini hanya untuk pesan yang lebih jelas.

const BUCKET_FOTO = "foto-anggota";
const UKURAN_FOTO_MAKS = 2 * 1024 * 1024;
const JENIS_FOTO = ["image/jpeg", "image/png", "image/webp"];

const teks = (fd: FormData, nama: string) => {
  const nilai = String(fd.get(nama) ?? "").trim();
  return nilai === "" ? null : nilai;
};

function pilihan<T extends Record<string, string>>(fd: FormData, nama: string, daftar: T) {
  const nilai = teks(fd, nama);
  return nilai && nilai in daftar ? (nilai as keyof T) : null;
}

function segarkan(anggotaId: string, kelompokId: string) {
  revalidatePath("/profil");
  revalidatePath(`/kelompok/${kelompokId}`);
  revalidatePath(`/kelompok/${kelompokId}/anggota/${anggotaId}`);
}

/** Mengambil kelompok anggota (sekaligus memastikan anggota bisa dibaca). */
async function kelompokAnggota(anggotaId: string) {
  const { supabase } = await wajibMasuk();
  const { data } = await supabase
    .from("anggota")
    .select("kelompok_id")
    .eq("id", anggotaId)
    .maybeSingle();
  return { supabase, kelompokId: data?.kelompok_id as string | undefined };
}

// ---------------------------------------------------------------- Wilayah

export type Wilayah = { kode: string; nama: string };

/** Daftar wilayah di bawah kode induk (null = daftar provinsi). */
export async function ambilWilayah(indukKode: string | null): Promise<Wilayah[]> {
  const { supabase } = await wajibMasuk();
  let kueri = supabase.from("wilayah").select("kode, nama").order("nama");
  kueri = indukKode ? kueri.eq("induk_kode", indukKode) : kueri.eq("tingkat", "provinsi");
  const { data } = await kueri;
  return data ?? [];
}

// ---------------------------------------------------------------- Persetujuan

export async function catatPersetujuan(anggotaId: string, _: HasilAksi, fd: FormData): Promise<HasilAksi> {
  if (fd.get("setuju") !== "ya") {
    return { galat: "Centang kotak persetujuan terlebih dahulu." };
  }
  const { supabase, kelompokId } = await kelompokAnggota(anggotaId);
  if (!kelompokId) return { galat: "Anggota tidak ditemukan." };

  // Waktu dan pencatat diisi otomatis oleh database.
  const { data, error } = await supabase
    .from("anggota")
    .update({ persetujuan_pada: new Date().toISOString() })
    .eq("id", anggotaId)
    .is("persetujuan_pada", null)
    .select("id");
  if (error) return { galat: pesanGalat(error) };
  if (!data?.length) return { galat: "Persetujuan tidak bisa dicatat. Mungkin sudah tercatat sebelumnya." };

  segarkan(anggotaId, kelompokId);
  return { sukses: "Persetujuan tercatat. Sekarang profil bisa diisi." };
}

// ---------------------------------------------------------------- Profil

export async function simpanProfil(anggotaId: string, _: HasilAksi, fd: FormData): Promise<HasilAksi> {
  const nama = teks(fd, "nama_lengkap");
  if (!nama) return { galat: "Nama lengkap wajib diisi." };

  const tanggalLahir = teks(fd, "tanggal_lahir");
  if (tanggalLahir && !/^\d{4}-\d{2}-\d{2}$/.test(tanggalLahir)) {
    return { galat: "Tanggal lahir tidak sah." };
  }
  const usia = tanggalLahir ? hitungUsia(tanggalLahir) : null;
  if (usia !== null && (usia < 0 || usia > 120)) {
    return { galat: "Tanggal lahir tidak masuk akal. Periksa kembali tahunnya." };
  }
  const perluWali = usia !== null && usia < USIA_DEWASA;
  const waliNama = perluWali ? teks(fd, "wali_nama") : null;
  if (perluWali && !waliNama) {
    return { galat: "Anggota di bawah 18 tahun memerlukan persetujuan orang tua/wali. Isi nama wali." };
  }

  // Wilayah: simpan sampai tingkat terdalam yang dipilih, tanpa celah.
  const provinsi = teks(fd, "provinsi_kode");
  const kota = provinsi ? teks(fd, "kota_kode") : null;
  const kecamatan = kota ? teks(fd, "kecamatan_kode") : null;
  const kelurahan = kecamatan ? teks(fd, "kelurahan_kode") : null;

  const noHp = teks(fd, "no_hp");
  if (noHp && !/^[0-9+\-\s]{8,20}$/.test(noHp)) {
    return { galat: "Nomor HP hanya boleh berisi angka, spasi, tanda + atau -." };
  }

  const { supabase, kelompokId } = await kelompokAnggota(anggotaId);
  if (!kelompokId) return { galat: "Anggota tidak ditemukan." };

  const { data, error } = await supabase
    .from("anggota")
    .update({
      nama_lengkap: nama,
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
      no_hp: noHp,
      wali_nama: waliNama,
      wali_hubungan: perluWali ? teks(fd, "wali_hubungan") : null,
    })
    .eq("id", anggotaId)
    .select("id");

  if (error) {
    if (error.code === "23514" && error.message.includes("anggota_perlu_persetujuan")) {
      return { galat: "Catat persetujuan data terlebih dahulu sebelum mengisi profil." };
    }
    if (error.code === "23514" && error.message.includes("wilayah")) {
      return { galat: "Pilihan wilayah tidak nyambung. Pilih ulang dari provinsi." };
    }
    return { galat: pesanGalat(error) };
  }
  if (!data?.length) return { galat: "Anda tidak berhak mengubah profil ini." };

  segarkan(anggotaId, kelompokId);
  return { sukses: "Profil tersimpan." };
}

// ---------------------------------------------------------------- Tambah anggota (oleh pemimpin)

export async function tambahAnggota(kelompokId: string, _: HasilAksi, fd: FormData): Promise<HasilAksi> {
  const { supabase, peran } = await wajibMasuk();
  if (!bolehKelola(peran, kelompokId)) {
    return { galat: "Anda tidak berhak mengelola kelompok ini." };
  }
  const nama = teks(fd, "nama_lengkap");
  if (!nama) return { galat: "Nama lengkap wajib diisi." };
  const setuju = fd.get("setuju") === "ya";

  const { data, error } = await supabase
    .from("anggota")
    .insert({
      kelompok_id: kelompokId,
      nama_lengkap: nama,
      persetujuan_pada: setuju ? new Date().toISOString() : null,
    })
    .select("id")
    .single();
  if (error || !data) return { galat: pesanGalat(error) };

  revalidatePath(`/kelompok/${kelompokId}`);
  redirect(`/kelompok/${kelompokId}/anggota/${data.id}`);
}

// ---------------------------------------------------------------- Foto

/**
 * Menerima foto yang SUDAH dikecilkan di HP (lihat komponen UnggahFoto),
 * menyimpannya di folder privat anggota, lalu memasangnya di profil.
 */
export async function unggahFoto(anggotaId: string, fd: FormData): Promise<HasilAksi> {
  const foto = fd.get("foto");
  if (!(foto instanceof File) || foto.size === 0) return { galat: "Foto belum dipilih." };
  if (!JENIS_FOTO.includes(foto.type)) return { galat: "Foto harus berformat JPG, PNG, atau WEBP." };
  if (foto.size > UKURAN_FOTO_MAKS) return { galat: "Ukuran foto lebih dari 2 MB." };

  const { supabase, kelompokId } = await kelompokAnggota(anggotaId);
  if (!kelompokId) return { galat: "Anggota tidak ditemukan." };

  const ekstensi = foto.type.split("/")[1].replace("jpeg", "jpg");
  const lokasi = `${anggotaId}/${Date.now()}.${ekstensi}`;
  const { error: galatUnggah } = await supabase.storage
    .from(BUCKET_FOTO)
    .upload(lokasi, foto, { contentType: foto.type, upsert: false });
  if (galatUnggah) return { galat: "Foto gagal diunggah. Anda mungkin tidak berhak, atau coba lagi." };

  // Foto lama otomatis masuk antrean hapus (penjaga di database).
  const { data, error } = await supabase
    .from("anggota")
    .update({ foto_path: lokasi })
    .eq("id", anggotaId)
    .select("id");
  if (error || !data?.length) {
    await supabase.storage.from(BUCKET_FOTO).remove([lokasi]);
    if (error?.code === "23514") return { galat: "Catat persetujuan data terlebih dahulu sebelum memasang foto." };
    return { galat: error ? pesanGalat(error) : "Anda tidak berhak mengubah foto ini." };
  }

  segarkan(anggotaId, kelompokId);
  return { sukses: "Foto tersimpan." };
}

export async function hapusFoto(anggotaId: string): Promise<HasilAksi> {
  const { supabase, kelompokId } = await kelompokAnggota(anggotaId);
  if (!kelompokId) return { galat: "Anggota tidak ditemukan." };

  const { data, error } = await supabase
    .from("anggota")
    .update({ foto_path: null })
    .eq("id", anggotaId)
    .select("id");
  if (error) return { galat: pesanGalat(error) };
  if (!data?.length) return { galat: "Anda tidak berhak menghapus foto ini." };

  segarkan(anggotaId, kelompokId);
  return { sukses: "Foto dihapus." };
}

// ---------------------------------------------------------------- Koreksi anggota (keputusan 13)

export async function ubahStatusAktif(anggotaId: string, aktif: boolean): Promise<HasilAksi> {
  const { supabase, kelompokId } = await kelompokAnggota(anggotaId);
  if (!kelompokId) return { galat: "Anggota tidak ditemukan." };
  const { data, error } = await supabase.from("anggota").update({ aktif }).eq("id", anggotaId).select("id");
  if (error) return { galat: pesanGalat(error) };
  if (!data?.length) return { galat: "Anda tidak berhak mengubah status anggota ini." };
  segarkan(anggotaId, kelompokId);
  return { sukses: aktif ? "Anggota diaktifkan kembali." : "Anggota ditandai tidak aktif." };
}

export async function pindahKelompok(anggotaId: string, _: HasilAksi, fd: FormData): Promise<HasilAksi> {
  const tujuan = teks(fd, "kelompok_id");
  if (!tujuan) return { galat: "Pilih kelompok tujuan." };
  const { supabase, kelompokId } = await kelompokAnggota(anggotaId);
  if (!kelompokId) return { galat: "Anggota tidak ditemukan." };
  if (tujuan === kelompokId) return { galat: "Anggota sudah berada di kelompok itu." };

  const { data, error } = await supabase
    .from("anggota")
    .update({ kelompok_id: tujuan })
    .eq("id", anggotaId)
    .select("id");
  if (error) return { galat: pesanGalat(error) };
  if (!data?.length) return { galat: "Anda tidak berhak memindahkan anggota ini." };

  segarkan(anggotaId, kelompokId);
  revalidatePath(`/kelompok/${tujuan}`);
  redirect(`/kelompok/${tujuan}/anggota/${anggotaId}`);
}

export async function hapusAnggota(anggotaId: string): Promise<HasilAksi> {
  const { supabase, kelompokId } = await kelompokAnggota(anggotaId);
  if (!kelompokId) return { galat: "Anggota tidak ditemukan." };
  const { data, error } = await supabase.from("anggota").delete().eq("id", anggotaId).select("id");
  if (error) return { galat: pesanGalat(error) };
  if (!data?.length) return { galat: "Anda tidak berhak menghapus anggota ini." };
  revalidatePath(`/kelompok/${kelompokId}`);
  redirect(`/kelompok/${kelompokId}`);
}

// ---------------------------------------------------------------- Kartu QR (keputusan 22)

export async function buatUlangKartu(anggotaId: string): Promise<HasilAksi> {
  const { supabase, kelompokId } = await kelompokAnggota(anggotaId);
  if (!kelompokId) return { galat: "Anggota tidak ditemukan." };
  const { error } = await supabase.rpc("buat_ulang_kode_kartu", { p_anggota: anggotaId });
  if (error) return { galat: pesanGalat(error) };
  segarkan(anggotaId, kelompokId);
  return { sukses: "Kode kartu baru dibuat. Kartu lama tidak berlaku lagi; cetak kartu baru." };
}
