import { type NextRequest } from "next/server";
import { bacaPilihan } from "@/lib/laporan";
import type ExcelJS from "exceljs";
import { buatExcelLaporan, buatExcelRingkasan } from "@/lib/laporan-excel";
import { ambilLaporan, ambilRingkasan, judulLaporan, namaCakupan } from "@/lib/laporan-server";
import { hariIniWib } from "@/lib/profil";
import { ambilPeranSaya } from "@/lib/sesi";

/** Unduhan laporan demografi sebagai Excel (.xlsx). Khusus Admin; tercatat di log. */
export async function GET(request: NextRequest) {
  const { supabase, peran } = await ambilPeranSaya();
  if (!peran?.admin) return new Response("Hanya Admin yang dapat mengekspor laporan.", { status: 403 });

  const pilihan = bacaPilihan(Object.fromEntries(request.nextUrl.searchParams));
  const cakupan = await namaCakupan(supabase, pilihan);
  const judul = judulLaporan(pilihan, cakupan);

  let isi: ExcelJS.Buffer;
  if (pilihan.ringkasan) {
    const { bagian, galat } = await ambilRingkasan(supabase, pilihan);
    if (!bagian) return new Response(galat ?? "Laporan gagal dibuat.", { status: 400 });
    isi = await buatExcelRingkasan(bagian, judul);
  } else {
    const { laporan, galat } = await ambilLaporan(supabase, pilihan);
    if (!laporan) return new Response(galat ?? "Laporan gagal dibuat.", { status: 400 });
    isi = await buatExcelLaporan(laporan, pilihan, judul);
  }

  const { error } = await supabase.rpc("catat_ekspor_laporan", {
    p_format: "xlsx",
    p_parameter: {
      dimensi: pilihan.ringkasan ? "ringkasan" : pilihan.dimensi,
      cakupan: pilihan.cakupan,
      cakupan_id: pilihan.cakupanId,
      hanya_aktif: pilihan.hanyaAktif,
    },
  });
  if (error) return new Response("Ekspor tidak diizinkan.", { status: 403 });

  const namaBerkas = `laporan-${pilihan.ringkasan ? "ringkasan" : pilihan.dimensi}-${hariIniWib()}.xlsx`;
  return new Response(isi, {
    headers: {
      "Content-Type": "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
      "Content-Disposition": `attachment; filename="${namaBerkas}"`,
      "Cache-Control": "no-store",
    },
  });
}
