import "server-only";
import { pesanGalat } from "@/lib/galat";
import { DIMENSI, susunLaporan, type BarisDb, type Pilihan } from "@/lib/laporan";
import type { buatClientServer } from "@/lib/supabase/server";

type Supabase = Awaited<ReturnType<typeof buatClientServer>>;

/** Mengambil laporan dari database (khusus Admin; setiap pembuatan tercatat di log). */
export async function ambilLaporan(supabase: Supabase, p: Pilihan) {
  const { data, error } = await supabase.rpc("laporan_demografi", {
    p_dimensi: p.dimensi,
    p_cakupan: p.cakupan,
    p_cakupan_id: p.cakupanId,
    p_hanya_aktif: p.hanyaAktif,
  });
  if (error) return { galat: pesanGalat(error, "Laporan belum bisa dibuat."), laporan: null };
  return { galat: null, laporan: susunLaporan((data ?? []) as BarisDb[], p.dimensi) };
}

/** Nama cakupan untuk judul laporan, mis. "Tim HG 1" atau "Kelompok COOL Apen Rivai". */
export async function namaCakupan(supabase: Supabase, p: Pilihan) {
  if (p.cakupan === "semua" || !p.cakupanId) return "Semua tim";
  const tabel = p.cakupan === "tim" ? "tim" : "kelompok";
  const { data } = await supabase.from(tabel).select("nama").eq("id", p.cakupanId).maybeSingle();
  return `${p.cakupan === "tim" ? "Tim" : "Kelompok"} ${data?.nama ?? "?"}`;
}

export function judulLaporan(p: Pilihan, cakupan: string) {
  return `${DIMENSI[p.dimensi]} · ${cakupan} · ${p.hanyaAktif ? "anggota aktif" : "semua anggota"}`;
}
