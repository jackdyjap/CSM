import "server-only";
import { headers } from "next/headers";
import { redirect } from "next/navigation";
import { buatClientServer } from "@/lib/supabase/server";

export type PeranSaya = {
  akun_id: string;
  nama: string;
  login: string | null;
  /** Belum menyelesaikan Atur profil (login pertama, keputusan 27). */
  perlu_atur_profil: boolean;
  /** Kata sandi dibuat Admin dan belum diganti. */
  sandi_sementara: boolean;
  admin: boolean;
  ketua_tim: { tim_id: string; nama: string }[];
  pemimpin: {
    kelompok_id: string;
    nama: string;
    tim_nama: string;
    jabatan: "pemimpin" | "wakil";
  }[];
  anggota: {
    anggota_id: string;
    nama: string;
    kelompok_id: string;
    kelompok_nama: string;
  } | null;
};

/** Mengambil data peran pengguna yang sedang login, atau null bila belum login. */
export async function ambilPeranSaya() {
  const supabase = await buatClientServer();
  const { data: klaim } = await supabase.auth.getClaims();
  if (!klaim?.claims) return { supabase, peran: null };

  const { data } = await supabase.rpc("peran_saya");
  return { supabase, peran: (data as PeranSaya | null) ?? null };
}

/**
 * Untuk halaman yang wajib login. Bila belum login, diarahkan ke /masuk.
 * Pengguna yang belum menyelesaikan Atur profil (login pertama) diarahkan ke
 * /profil, kecuali halaman yang memberi `bolehBelumAtur` (Atur profil sendiri
 * dan check-in). Aksi formulir tidak diarahkan, supaya Atur profil bisa disimpan.
 */
export async function wajibMasuk(opsi: { bolehBelumAtur?: boolean } = {}) {
  const { supabase, peran } = await ambilPeranSaya();
  if (!peran) redirect("/masuk");
  if (peran.perlu_atur_profil && !opsi.bolehBelumAtur && !(await headers()).get("next-action")) {
    redirect("/profil");
  }
  return { supabase, peran };
}

/** Untuk halaman khusus Admin. */
export async function wajibAdmin() {
  const hasil = await wajibMasuk();
  if (!hasil.peran.admin) redirect("/beranda");
  return hasil;
}

/** Bolehkah saya mengelola kelompok ini? (pemimpin/wakilnya, atau Admin — keputusan 12) */
export function bolehKelola(peran: PeranSaya, kelompokId: string) {
  return peran.admin || peran.pemimpin.some((k) => k.kelompok_id === kelompokId);
}

export type KelompokKelolaan = {
  kelompok_id: string;
  nama: string;
  tim_nama: string;
  /** Label peran di kelompok ini: "Pemimpin", "Wakil", atau "Admin". */
  sebagai: string;
};

/**
 * Data kelompok yang saya kelola, atau null bila saya tidak berhak.
 * Hak sebenarnya tetap diperiksa database (aturan akses).
 */
export async function kelompokKelolaan(
  supabase: Awaited<ReturnType<typeof buatClientServer>>,
  peran: PeranSaya,
  kelompokId: string,
): Promise<KelompokKelolaan | null> {
  const dipimpin = peran.pemimpin.find((k) => k.kelompok_id === kelompokId);
  if (dipimpin) {
    return {
      kelompok_id: dipimpin.kelompok_id,
      nama: dipimpin.nama,
      tim_nama: dipimpin.tim_nama,
      sebagai: dipimpin.jabatan === "wakil" ? "Wakil" : "Pemimpin",
    };
  }
  if (!peran.admin) return null;

  const { data } = await supabase
    .from("kelompok")
    .select("id, nama, tim(nama)")
    .eq("id", kelompokId)
    .maybeSingle();
  if (!data) return null;
  const tim = data.tim as unknown as { nama: string } | null;
  return { kelompok_id: data.id, nama: data.nama, tim_nama: tim?.nama ?? "", sebagai: "Admin" };
}

export type AksesKelompok = KelompokKelolaan & {
  /** true = pemimpin/wakil/Admin (boleh mengubah); false = Ketua Tim (baca saja). */
  bolehUbah: boolean;
};

/**
 * Akses ke halaman kelompok: pengelola (pemimpin/wakil/Admin) atau Ketua Tim
 * dari tim kelompok itu (baca saja, Fase 6). Null bila tidak berhak.
 * Hak sebenarnya tetap diperiksa database (aturan akses).
 */
export async function aksesKelompok(
  supabase: Awaited<ReturnType<typeof buatClientServer>>,
  peran: PeranSaya,
  kelompokId: string,
): Promise<AksesKelompok | null> {
  const kelola = await kelompokKelolaan(supabase, peran, kelompokId);
  if (kelola) return { ...kelola, bolehUbah: true };
  if (peran.ketua_tim.length === 0) return null;

  const { data } = await supabase
    .from("kelompok")
    .select("id, nama, tim_id, tim(nama)")
    .eq("id", kelompokId)
    .maybeSingle();
  if (!data || !peran.ketua_tim.some((t) => t.tim_id === data.tim_id)) return null;
  const tim = data.tim as unknown as { nama: string } | null;
  return { kelompok_id: data.id, nama: data.nama, tim_nama: tim?.nama ?? "", sebagai: "Ketua Tim", bolehUbah: false };
}
