import { DaftarBahan } from "@/components/daftar-bahan";
import { Judul, Kotak, Lipatan, TautanTombol } from "@/components/ui";
import { UnggahBahan } from "@/components/unggah-bahan";
import { KOLOM_BAHAN, type BarisBahan } from "@/lib/bahan";
import { wajibAdmin } from "@/lib/sesi";

/** Admin mengelola bahan diskusi PDF untuk pengurus (keputusan 39). */
export default async function HalamanKelolaBahan() {
  const { supabase } = await wajibAdmin();
  const [{ data: dataTim }, { data }] = await Promise.all([
    supabase.from("tim").select("id, nama").order("nama"),
    supabase
      .from("bahan_diskusi")
      .select(KOLOM_BAHAN)
      .order("tanggal_pakai", { ascending: false, nullsFirst: false })
      .order("dibuat_pada", { ascending: false }),
  ]);
  const tim = dataTim ?? [];

  return (
    <main>
      <Judul kecil="Admin">Bahan diskusi</Judul>
      <div className="mb-4 flex flex-wrap gap-2">
        <TautanTombol href="/beranda">← Beranda</TautanTombol>
      </div>
      <Kotak>
        <Lipatan judul="+ Unggah bahan diskusi">
          <p className="text-sm opacity-70">
            Bahan bisa dibuka dan diunduh oleh Ketua Tim serta Pemimpin/Wakil kelompok (semua tim, atau satu tim yang
            dipilih). Anggota tidak bisa membukanya.
          </p>
          <UnggahBahan tim={tim} />
        </Lipatan>
      </Kotak>
      <Kotak judul={`Semua bahan (${(data ?? []).length})`}>
        <DaftarBahan supabase={supabase} bahan={(data ?? []) as unknown as BarisBahan[]} kelola tim={tim} />
      </Kotak>
    </main>
  );
}
