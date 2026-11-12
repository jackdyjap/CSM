"use server";

import { revalidatePath } from "next/cache";
import { alamatSitus } from "@/lib/alamat";
import { pesanGalat } from "@/lib/galat";
import type { HasilAksi } from "@/lib/hasil";
import { bacaIdentitas, PANJANG_SANDI_MINIMAL, PESAN_IDENTITAS_SALAH } from "@/lib/identitas";
import { wajibAdmin } from "@/lib/sesi";
import { buatClientAdmin } from "@/lib/supabase/admin";

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

export async function buatAkun(_: HasilAksi, fd: FormData): Promise<HasilAksi> {
  await wajibAdmin();
  const nama = teks(fd, "nama");
  const identitas = bacaIdentitas(teks(fd, "identitas"));
  const sandi = String(fd.get("sandi") ?? "");

  if (!nama) return { galat: "Nama belum diisi." };
  if (!identitas) return { galat: PESAN_IDENTITAS_SALAH };
  if (sandi.length < PANJANG_SANDI_MINIMAL) {
    return { galat: `Kata sandi minimal ${PANJANG_SANDI_MINIMAL} karakter.` };
  }

  const admin = buatClientAdmin();
  const { error } = await admin.auth.admin.createUser({
    email: identitas.emailLogin,
    password: sandi,
    email_confirm: true,
    user_metadata: { nama, login: identitas.tampil },
  });

  if (error) {
    if (error.code === "email_exists" || /already/i.test(error.message)) {
      return { galat: `${identitas.tampil} sudah terdaftar.` };
    }
    return { galat: "Akun gagal dibuat. Coba lagi." };
  }

  revalidatePath("/admin/akun");
  return {
    sukses: `Akun ${nama} (${identitas.tampil}) dibuat. Sampaikan kata sandinya secara pribadi, lalu beri perannya di bawah.`,
  };
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
  revalidatePath("/admin/akun");
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
  revalidatePath("/admin/akun");
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
