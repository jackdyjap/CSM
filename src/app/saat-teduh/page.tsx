import { DaftarSaatTeduh } from "@/components/daftar-saat-teduh";
import { Judul, Kotak, Pesan, TautanTombol } from "@/components/ui";
import { pesanBacaGagal } from "@/lib/galat";
import { KOLOM_SAAT_TEDUH, type CatatanSaatTeduh } from "@/lib/saat-teduh";
import { wajibMasuk } from "@/lib/sesi";

const BATAS = 200;

export default async function HalamanSaatTeduh() {
  const { supabase, peran } = await wajibMasuk();
  const { data, error } = await supabase
    .from("saat_teduh")
    .select(KOLOM_SAAT_TEDUH)
    .eq("akun_id", peran.akun_id)
    .order("tanggal", { ascending: false })
    .order("jam_mulai", { ascending: false })
    .limit(BATAS);
  const catatan = (data ?? []) as CatatanSaatTeduh[];

  return (
    <main>
      <Judul kecil="Catatan pribadi Anda">Saat Teduh</Judul>
      <div className="mb-4 flex flex-wrap gap-2">
        <TautanTombol href="/beranda">← Beranda</TautanTombol>
        <TautanTombol href="/saat-teduh/baru" jenis="utama">
          + Catat saat teduh
        </TautanTombol>
      </div>

      <Kotak judul={`Riwayat (${catatan.length}${catatan.length === BATAS ? "+" : ""})`}>
        {error ? (
          <Pesan jenis="galat">{pesanBacaGagal(error, "Catatan saat teduh")}</Pesan>
        ) : catatan.length === 0 ? (
          <p className="opacity-70">Belum ada catatan. Ketuk + Catat saat teduh untuk memulai.</p>
        ) : (
          <>
            <p className="mb-2 text-xs opacity-70">Ketuk sebuah catatan untuk melihat detailnya.</p>
            <DaftarSaatTeduh catatan={catatan} bolehUbah />
          </>
        )}
      </Kotak>
      <p className="text-xs opacity-70">
        Catatan Anda bisa dibaca Pemimpin kelompok, Ketua Tim, dan Admin, tetapi hanya Anda yang bisa mengubah atau
        menghapusnya.
      </p>
    </main>
  );
}
