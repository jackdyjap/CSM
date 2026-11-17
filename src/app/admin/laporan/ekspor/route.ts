import { type NextRequest } from "next/server";
import { bacaPilihan } from "@/lib/laporan";
import { buatExcelLaporan } from "@/lib/laporan-excel";
import { ambilLaporan, judulLaporan, namaCakupan } from "@/lib/laporan-server";
import { hariIniWib } from "@/lib/profil";
import { ambilPeranSaya } from "@/lib/sesi";

/** Unduhan laporan demografi sebagai Excel (.xlsx). Khusus Admin; tercatat di log. */
export async function GET(request: NextRequest) {
  const { supabase, peran } = await ambilPeranSaya();
  if (!peran?.admin) return new Response("Hanya Admin yang dapat mengekspor laporan.", { status: 403 });

  const pilihan = bacaPilihan(Object.fromEntries(request.nextUrl.searchParams));
  const [{ laporan, galat }, cakupan] = await Promise.all([ambilLaporan(supabase, pilihan), namaCakupan(supabase, pilihan)]);
  if (!laporan) return new Response(galat ?? "Laporan gagal dibuat.", { status: 400 });

  const { error } = await supabase.rpc("catat_ekspor_laporan", {
    p_format: "xlsx",
    p_parameter: { dimensi: pilihan.dimensi, cakupan: pilihan.cakupan, cakupan_id: pilihan.cakupanId, hanya_aktif: pilihan.hanyaAktif },
  });
  if (error) return new Response("Ekspor tidak diizinkan.", { status: 403 });

  const isi = await buatExcelLaporan(laporan, pilihan, judulLaporan(pilihan, cakupan));
  const namaBerkas = `laporan-${pilihan.dimensi}-${hariIniWib()}.xlsx`;
  return new Response(isi, {
    headers: {
      "Content-Type": "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
      "Content-Disposition": `attachment; filename="${namaBerkas}"`,
      "Cache-Control": "no-store",
    },
  });
}
