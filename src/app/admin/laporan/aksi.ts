"use server";

import { pesanGalat } from "@/lib/galat";
import type { HasilAksi } from "@/lib/hasil";
import { wajibAdmin } from "@/lib/sesi";

/** Mencatat ekspor PDF di log (dipanggil sebelum dialog cetak dibuka). */
export async function catatEksporPdf(parameter: Record<string, string>): Promise<HasilAksi> {
  const { supabase } = await wajibAdmin();
  const { error } = await supabase.rpc("catat_ekspor_laporan", { p_format: "pdf", p_parameter: parameter });
  return error ? { galat: pesanGalat(error) } : {};
}
