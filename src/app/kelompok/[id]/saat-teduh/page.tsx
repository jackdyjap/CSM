import { redirect } from "next/navigation";
import { bacaGrafik, FormLaporanTeduh, LaporanAnggota } from "@/components/laporan-saat-teduh";
import { Judul, TautanTombol } from "@/components/ui";
import { bacaBulan, labelBulan } from "@/lib/saat-teduh";
import { aksesKelompok, wajibMasuk } from "@/lib/sesi";

/**
 * Saat teduh anggota satu kelompok (keputusan 61): langsung anggota kelompok
 * ini, hanya yang melaksanakan. Pemimpin/Wakil, Ketua Tim, dan Admin; hanya baca.
 */
export default async function HalamanSaatTeduhKelompok({ params, searchParams }: PageProps<"/kelompok/[id]/saat-teduh">) {
  const { id } = await params;
  const sp = await searchParams;
  const bulan = bacaBulan(sp.bulan);
  const grafik = bacaGrafik(sp.g);
  const { supabase, peran } = await wajibMasuk();
  const kelompok = await aksesKelompok(supabase, peran, id);
  if (!kelompok) redirect("/beranda");

  return (
    <main>
      <Judul kecil={`${kelompok.sebagai} · ${kelompok.tim_nama}`}>Saat teduh · {kelompok.nama}</Judul>
      <div className="mb-4">
        <TautanTombol href={`/kelompok/${id}`}>← Kelompok</TautanTombol>
      </div>
      <FormLaporanTeduh bulan={bulan} grafik={grafik} />
      <p className="mb-3 text-xs opacity-70">
        Dihitung dari anggota aktif yang punya akun; pelaksana = minimal 1 catatan di bulan itu. Hanya yang
        melaksanakan yang ditampilkan.
      </p>
      <LaporanAnggota supabase={supabase} kelompokId={id} bulan={bulan} grafik={grafik} judul={labelBulan(bulan)} />
    </main>
  );
}
