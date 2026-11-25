"use server";

import { revalidatePath } from "next/cache";
import { redirect } from "next/navigation";
import { alamatSitus } from "@/lib/alamat";
import { pesanGalat } from "@/lib/galat";
import type { HasilAksi } from "@/lib/hasil";
import { bacaDataLogin } from "@/lib/identitas";
import { jalankanPenghapusBerkas } from "@/lib/hapus-berkas";
import { simpanLogin } from "@/lib/login-server";
import { wajibAdmin } from "@/lib/sesi";

const teks = (fd: FormData, nama: string) => String(fd.get(nama) ?? "").trim();

// ---------------------------------------------------------------- Tim & kelompok

export async function tambahTim(_: HasilAksi, fd: FormData): Promise<HasilAksi> {
  const { supabase } = await wajibAdmin();
  const nama = teks(fd, "nama");
  if (!nama) return { galat: "Nama tim belum diisi." };

  const { error } = await supabase.from("tim").insert({ nama });
  if (error) return { galat: pesanGalat(error) };
  revalidatePath("/admin");
  return { sukses: `Tim "${nama}" ditambahkan.` };
}

export async function tambahKelompok(_: HasilAksi, fd: FormData): Promise<HasilAksi> {
  const { supabase } = await wajibAdmin();
  const nama = teks(fd, "nama");
  const timId = teks(fd, "tim_id");
  if (!nama || !timId) return { galat: "Nama kelompok dan tim wajib diisi." };

  const { error } = await supabase.from("kelompok").insert({ nama, tim_id: timId });
  if (error) return { galat: pesanGalat(error) };
  revalidatePath("/admin");
  return { sukses: `Kelompok "${nama}" ditambahkan.` };
}

// ---------------------------------------------------------------- Akun & peran

/** Admin mengubah nama pengguna, email, dan nomor HP sebuah akun (keputusan 25). */
export async function ubahLoginAkun(akunId: string, _: HasilAksi, fd: FormData): Promise<HasilAksi> {
  const { supabase } = await wajibAdmin();
  return simpanLogin(supabase, akunId, bacaDataLogin(fd), ["/admin/akun", `/admin/akun/${akunId}`]);
}

export async function beriPeran(_: HasilAksi, fd: FormData): Promise<HasilAksi> {
  const { supabase } = await wajibAdmin();
  const akunId = teks(fd, "akun_id");
  const peran = teks(fd, "peran");
  const timId = teks(fd, "tim_id");
  const kelompokId = teks(fd, "kelompok_id");
  const jabatan = teks(fd, "jabatan") || "pemimpin";

  if (!akunId) return { galat: "Pilih akun terlebih dahulu." };

  let baris;
  if (peran === "admin") {
    baris = { akun_id: akunId, peran, tim_id: null, kelompok_id: null, jabatan: null };
  } else if (peran === "ketua_tim") {
    if (!timId) return { galat: "Untuk Ketua Tim, pilih timnya." };
    baris = { akun_id: akunId, peran, tim_id: timId, kelompok_id: null, jabatan: null };
  } else if (peran === "pemimpin") {
    if (!kelompokId) return { galat: "Untuk Pemimpin/Wakil, pilih kelompoknya." };
    baris = { akun_id: akunId, peran, tim_id: null, kelompok_id: kelompokId, jabatan };
  } else {
    return { galat: "Pilih peran." };
  }

  const { error } = await supabase.from("penugasan_peran").insert(baris);
  if (error) {
    return { galat: error.code === "23505" ? "Akun ini sudah memiliki peran tersebut." : pesanGalat(error) };
  }
  revalidatePath("/admin/akun", "layout");
  return { sukses: "Peran diberikan." };
}

export async function hapusPeran(penugasanId: string): Promise<HasilAksi> {
  const { supabase, peran } = await wajibAdmin();

  const { data: baris } = await supabase
    .from("penugasan_peran")
    .select("akun_id, peran")
    .eq("id", penugasanId)
    .maybeSingle();
  if (baris?.akun_id === peran.akun_id && baris.peran === "admin") {
    return { galat: "Anda tidak bisa mencabut peran Admin milik Anda sendiri." };
  }

  const { error } = await supabase.from("penugasan_peran").delete().eq("id", penugasanId);
  if (error) return { galat: pesanGalat(error) };
  revalidatePath("/admin/akun", "layout");
  return { sukses: "Peran dicabut." };
}

export async function buatTautanAturUlang(
  akunId: string,
  nama: string,
): Promise<HasilAksi> {
  const { supabase } = await wajibAdmin();
  const { data, error } = await supabase.rpc("buat_tautan_atur_ulang", { p_akun: akunId });
  const baris = Array.isArray(data) ? data[0] : null;
  if (error || !baris) return { galat: pesanGalat(error) };

  const tautan = `${await alamatSitus()}/atur-ulang/${baris.token}`;
  return {
    tautan,
    teksWa: `Halo ${nama}, ini tautan untuk membuat kata sandi baru di aplikasi absensi kelompok (berlaku 24 jam, sekali pakai): ${tautan}`,
  };
}

// ---------------------------------------------------------------- Koreksi data (keputusan 13–14)

export async function ubahNamaTim(timId: string, _: HasilAksi, fd: FormData): Promise<HasilAksi> {
  const { supabase } = await wajibAdmin();
  const nama = teks(fd, "nama");
  if (!nama) return { galat: "Nama tim belum diisi." };
  const { error } = await supabase.from("tim").update({ nama }).eq("id", timId);
  if (error) return { galat: pesanGalat(error) };
  revalidatePath("/admin");
  return { sukses: "Nama tim diubah." };
}

export async function hapusTim(timId: string): Promise<HasilAksi> {
  const { supabase } = await wajibAdmin();
  const { error } = await supabase.from("tim").delete().eq("id", timId);
  if (error) {
    return {
      galat:
        error.code === "23503"
          ? "Tim ini masih punya kelompok. Pindahkan atau hapus kelompoknya terlebih dahulu."
          : pesanGalat(error),
    };
  }
  revalidatePath("/admin");
  return { sukses: "Tim dihapus." };
}

export async function ubahKelompok(kelompokId: string, _: HasilAksi, fd: FormData): Promise<HasilAksi> {
  const { supabase } = await wajibAdmin();
  const nama = teks(fd, "nama");
  const timId = teks(fd, "tim_id");
  if (!nama || !timId) return { galat: "Nama kelompok dan tim wajib diisi." };
  const { error } = await supabase.from("kelompok").update({ nama, tim_id: timId }).eq("id", kelompokId);
  if (error) return { galat: pesanGalat(error) };
  revalidatePath("/admin");
  revalidatePath(`/kelompok/${kelompokId}`);
  return { sukses: "Kelompok diperbarui." };
}

export async function hapusKelompokTotal(kelompokId: string, _: HasilAksi, fd: FormData): Promise<HasilAksi> {
  const { supabase } = await wajibAdmin();
  const { error } = await supabase.rpc("hapus_kelompok_total", {
    p_kelompok: kelompokId,
    p_konfirmasi: teks(fd, "konfirmasi"),
  });
  if (error) return { galat: pesanGalat(error) };
  revalidatePath("/admin");
  redirect("/admin");
}

/**
 * Menghapus akun (keputusan 41): khusus Admin, setelah mengetik nama akun persis.
 * Admin memilih apakah profil anggotanya ikut dihapus. Diperiksa database.
 */
export async function hapusAkun(akunId: string, _: HasilAksi, fd: FormData): Promise<HasilAksi> {
  const { supabase } = await wajibAdmin();
  const { error } = await supabase.rpc("hapus_akun", {
    p_akun: akunId,
    p_konfirmasi: teks(fd, "konfirmasi"),
    p_hapus_profil: fd.get("hapus_profil") === "ya",
  });
  if (error) return { galat: pesanGalat(error) };
  revalidatePath("/admin/akun", "layout");
  redirect("/admin/akun?dihapus=1");
}

export async function ubahNamaAkun(akunId: string, _: HasilAksi, fd: FormData): Promise<HasilAksi> {
  const { supabase } = await wajibAdmin();
  const nama = teks(fd, "nama");
  if (!nama) return { galat: "Nama belum diisi." };
  const { data, error } = await supabase.from("akun").update({ nama_tampilan: nama }).eq("id", akunId).select("id");
  if (error) return { galat: pesanGalat(error) };
  if (!data?.length) return { galat: "Akun tidak ditemukan." };
  revalidatePath("/admin/akun", "layout");
  return { sukses: "Nama akun diubah." };
}

// ---------------------------------------------------------------- Penghapus berkas (keputusan 40)

export async function hapusBerkasSekarang(): Promise<HasilAksi> {
  await wajibAdmin();
  try {
    const { dihapus, gagal } = await jalankanPenghapusBerkas();
    revalidatePath("/admin");
    if (gagal > 0) return { galat: `${dihapus} berkas dihapus, ${gagal} gagal (akan dicoba lagi).` };
    return { sukses: dihapus ? `${dihapus} berkas dihapus dari penyimpanan.` : "Tidak ada berkas yang perlu dihapus." };
  } catch {
    return { galat: "Penghapusan berkas belum bisa dijalankan. Coba lagi nanti." };
  }
}
