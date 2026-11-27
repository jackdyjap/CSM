import { PilihBulan, RingkasanSaatTeduh } from "@/components/ringkasan-saat-teduh";
import { Judul, Pesan, TautanTombol } from "@/components/ui";
import { pesanBacaGagal } from "@/lib/galat";
import { bacaBulan, type BarisRingkasanTeduh } from "@/lib/saat-teduh";
import { wajibAdmin } from "@/lib/sesi";

/** Laporan saat teduh sebulan untuk Admin: semua tim → per tim → per kelompok (keputusan 59). */
export default async function HalamanLaporanSaatTeduh({ searchParams }: PageProps<"/admin/laporan-saat-teduh">) {
  const bulan = bacaBulan((await searchParams).bulan);
  const { supabase } = await wajibAdmin();
  const { data, error } = await supabase.rpc("ringkasan_saat_teduh", { p_bulan: `${bulan}-01` });

  return (
    <main>
      <Judul kecil="Admin">Laporan saat teduh</Judul>
      <div className="mb-4">
        <TautanTombol href="/beranda">← Beranda</TautanTombol>
      </div>
      <PilihBulan bulan={bulan} />
      <p className="mb-3 text-xs opacity-70">
        Dihitung dari anggota aktif yang punya akun; bersaat teduh = minimal 1 catatan di bulan itu. Ketuk kelompok
        untuk melihat per anggota.
      </p>
      {error ? (
        <Pesan jenis="galat">{pesanBacaGagal(error, "Laporan saat teduh")}</Pesan>
      ) : (
        <RingkasanSaatTeduh baris={(data ?? []) as BarisRingkasanTeduh[]} bulan={bulan} />
      )}
    </main>
  );
}
