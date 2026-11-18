import {
  Judul,
  Kotak,
  Pesan,
  Pilihan,
  TautanTombol,
  Tombol,
} from "@/components/ui";
import { pesanGalat } from "@/lib/galat";
import { IsiLaporanProyek } from "@/components/isi-laporan-proyek";
import { susunLaporanProyek, type BarisProyekDb } from "@/lib/laporan-proyek";
import { wajibAdmin } from "@/lib/sesi";

/** Laporan pelaksanaan proyek ketaatan (keputusan 38, khusus Admin). */
export default async function HalamanLaporanProyek({
  searchParams,
}: PageProps<"/admin/laporan-proyek">) {
  const { supabase } = await wajibAdmin();
  const cak = (await searchParams).cak;
  const [jenis, idMentah] = (typeof cak === "string" ? cak : "semua").split(
    ":",
  );
  const cakupanId = /^[0-9a-f-]{36}$/.test(idMentah ?? "") ? idMentah : null;
  const cakupan =
    (jenis === "tim" || jenis === "kelompok") && cakupanId ? jenis : "semua";

  const [{ data: dataTim }, { data: dataKelompok }, { data, error }] =
    await Promise.all([
      supabase.from("tim").select("id, nama").order("nama"),
      supabase.from("kelompok").select("id, nama, tim_id").order("nama"),
      supabase.rpc("laporan_proyek", {
        p_cakupan: cakupan,
        p_cakupan_id: cakupan === "semua" ? null : cakupanId,
      }),
    ]);
  const tim = dataTim ?? [];
  const kelompok = dataKelompok ?? [];
  const namaCakupan =
    cakupan === "tim"
      ? `Tim ${tim.find((t) => t.id === cakupanId)?.nama ?? "?"}`
      : cakupan === "kelompok"
        ? `Kelompok ${kelompok.find((k) => k.id === cakupanId)?.nama ?? "?"}`
        : "Semua tim";
  const laporan = error
    ? null
    : susunLaporanProyek((data ?? []) as BarisProyekDb[]);

  return (
    <main className="laporan">
      <div className="jangan-cetak">
        <Judul kecil="Admin">Laporan proyek ketaatan</Judul>
        <div className="mb-4 flex flex-wrap gap-2">
          <TautanTombol href="/beranda">← Beranda</TautanTombol>
          <TautanTombol href="/admin/laporan">Laporan demografi</TautanTombol>
        </div>
        <Kotak>
          <form method="get">
            <Pilihan
              label="Cakupan"
              name="cak"
              defaultValue={
                cakupan === "semua" ? "semua" : `${cakupan}:${cakupanId}`
              }
            >
              <option value="semua">Semua tim</option>
              <optgroup label="Satu tim">
                {tim.map((t) => (
                  <option key={t.id} value={`tim:${t.id}`}>
                    Tim {t.nama}
                  </option>
                ))}
              </optgroup>
              <optgroup label="Satu kelompok">
                {kelompok.map((k) => (
                  <option key={k.id} value={`kelompok:${k.id}`}>
                    {k.nama} ({tim.find((t) => t.id === k.tim_id)?.nama ?? "?"})
                  </option>
                ))}
              </optgroup>
            </Pilihan>
            <Tombol type="submit">Tampilkan laporan</Tombol>
          </form>
        </Kotak>
      </div>

      {error ? (
        <Pesan jenis="galat">
          {pesanGalat(error, "Laporan belum bisa dibuat.")}
        </Pesan>
      ) : null}

      {laporan ? (
        <IsiLaporanProyek
          laporan={laporan}
          namaCakupan={namaCakupan}
          cakupan={cakupan}
          cakupanId={cakupanId}
        />
      ) : null}
    </main>
  );
}
