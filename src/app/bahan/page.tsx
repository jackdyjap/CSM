import { redirect } from "next/navigation";
import { DaftarBahan } from "@/components/daftar-bahan";
import { Judul, Kotak, TautanTombol } from "@/components/ui";
import { KOLOM_BAHAN, type BarisBahan } from "@/lib/bahan";
import { wajibMasuk } from "@/lib/sesi";

/** Bahan diskusi untuk Ketua Tim dan Pemimpin/Wakil (keputusan 39). Anggota tidak punya akses. */
export default async function HalamanBahan() {
  const { supabase, peran } = await wajibMasuk();
  if (!peran.admin && peran.ketua_tim.length === 0 && peran.pemimpin.length === 0) redirect("/beranda");

  // Aturan akses database hanya mengembalikan bahan yang boleh saya buka.
  const { data } = await supabase
    .from("bahan_diskusi")
    .select(KOLOM_BAHAN)
    .order("tanggal_pakai", { ascending: false, nullsFirst: false })
    .order("dibuat_pada", { ascending: false });

  return (
    <main>
      <Judul kecil="Untuk pengurus">Bahan diskusi</Judul>
      <div className="mb-4 flex flex-wrap gap-2">
        <TautanTombol href="/beranda">← Beranda</TautanTombol>
        {peran.admin ? <TautanTombol href="/admin/bahan">Kelola bahan</TautanTombol> : null}
      </div>
      <Kotak>
        <DaftarBahan supabase={supabase} bahan={(data ?? []) as unknown as BarisBahan[]} />
      </Kotak>
      <p className="text-xs opacity-70">Tautan Buka/Unduh berlaku 1 jam; muat ulang halaman bila sudah lewat.</p>
    </main>
  );
}
