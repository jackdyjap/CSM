import "server-only";
import type { buatClientServer } from "@/lib/supabase/server";
import type { Wilayah } from "@/lib/aksi-profil";
import { KOLOM_PROFIL, type Profil } from "@/lib/profil";

type Supabase = Awaited<ReturnType<typeof buatClientServer>>;

/** Lama tautan sementara foto berlaku (detik). */
const UMUR_TAUTAN_FOTO = 60 * 60;

/** Membaca satu profil. Null bila tidak ada atau tidak berhak dibaca (aturan akses). */
export async function bacaProfil(supabase: Supabase, anggotaId: string) {
  const { data } = await supabase.from("anggota").select(KOLOM_PROFIL).eq("id", anggotaId).maybeSingle();
  return (data as Profil | null) ?? null;
}

/** Tautan sementara (1 jam) untuk foto di penyimpanan privat. */
export async function tautanFoto(supabase: Supabase, lokasi: string | null) {
  if (!lokasi) return null;
  const { data } = await supabase.storage.from("foto-anggota").createSignedUrl(lokasi, UMUR_TAUTAN_FOTO);
  return data?.signedUrl ?? null;
}

/** Banyak tautan sementara sekaligus (untuk daftar anggota). */
export async function tautanFotoBanyak(supabase: Supabase, lokasi: string[]) {
  const peta = new Map<string, string>();
  if (lokasi.length === 0) return peta;
  const { data } = await supabase.storage.from("foto-anggota").createSignedUrls(lokasi, UMUR_TAUTAN_FOTO);
  for (const d of data ?? []) if (d.path && d.signedUrl) peta.set(d.path, d.signedUrl);
  return peta;
}

/**
 * Daftar pilihan wilayah (provinsi, kota/kabupaten) sesuai kode yang tersimpan,
 * supaya menu langsung terisi saat halaman dibuka.
 */
export async function daftarWilayahAwal(
  supabase: Supabase,
  p: Pick<Profil, "provinsi_kode">,
): Promise<Wilayah[][]> {
  const induk = [null, p.provinsi_kode];
  return Promise.all(
    induk.map(async (kode, i) => {
      if (i > 0 && !kode) return [];
      let kueri = supabase.from("wilayah").select("kode, nama").order("nama");
      kueri = kode ? kueri.eq("induk_kode", kode) : kueri.eq("tingkat", "provinsi");
      const { data } = await kueri;
      return data ?? [];
    }),
  );
}

/** Nama wilayah untuk tampilan baca-saja, contoh: "Jakarta Pusat, DKI Jakarta". */
export async function namaWilayah(
  supabase: Supabase,
  p: Pick<Profil, "provinsi_kode" | "kota_kode">,
) {
  const kode = [p.kota_kode, p.provinsi_kode].filter(Boolean) as string[];
  if (kode.length === 0) return null;
  const { data } = await supabase.from("wilayah").select("kode, nama").in("kode", kode);
  const peta = new Map((data ?? []).map((w) => [w.kode, w.nama]));
  return kode.map((k) => peta.get(k) ?? k).join(", ");
}
