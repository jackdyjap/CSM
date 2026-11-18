import { GrafikBatang } from "@/components/grafik-batang";
import { TabelSilang } from "@/components/tabel-silang";
import { Judul, Kotak, Pesan, Pilihan, TautanTombol, Tombol } from "@/components/ui";
import { bacaPilihan, DIMENSI, formatPersen, NAMA_RINGKASAN, parameterAlamat, type Pilihan as PilihanLaporan } from "@/lib/laporan";
import { ambilLaporan, ambilRingkasan, judulLaporan, namaCakupan } from "@/lib/laporan-server";
import { hariIniWib } from "@/lib/profil";
import { wajibAdmin } from "@/lib/sesi";
import { TombolPdf } from "./tombol-pdf";

/** Laporan demografi (Fase 9, khusus Admin). */
export default async function HalamanLaporan({ searchParams }: PageProps<"/admin/laporan">) {
  const { supabase } = await wajibAdmin();
  const p = bacaPilihan(await searchParams);

  const [{ data: dataTim }, { data: dataKelompok }, satu, ringkasan, cakupan] = await Promise.all([
    supabase.from("tim").select("id, nama").order("nama"),
    supabase.from("kelompok").select("id, nama, tim_id").order("nama"),
    p.ringkasan ? null : ambilLaporan(supabase, p),
    p.ringkasan ? ambilRingkasan(supabase, p) : null,
    namaCakupan(supabase, p),
  ]);
  const laporan = satu?.laporan ?? null;
  const galat = satu?.galat ?? ringkasan?.galat ?? null;
  const tim = dataTim ?? [];
  const kelompok = dataKelompok ?? [];
  const nilaiCakupan = p.cakupan === "semua" ? "semua" : `${p.cakupan}:${p.cakupanId}`;
  const judul = judulLaporan(p, cakupan);

  return (
    <main className="laporan">
      <div className="jangan-cetak">
        <Judul kecil="Admin">Laporan demografi</Judul>
        <div className="mb-4 flex flex-wrap gap-2">
          <TautanTombol href="/beranda">← Beranda</TautanTombol>
          <TautanTombol href="/admin">Tim &amp; kelompok</TautanTombol>
          <TautanTombol href="/admin/laporan-proyek">Laporan proyek ketaatan</TautanTombol>
        </div>

        <Kotak>
          <form method="get" className="grid grid-cols-2 gap-x-3">
            <Pilihan label="Dimensi" name="d" defaultValue={p.ringkasan ? "ringkasan" : p.dimensi}>
              <option value="ringkasan">{NAMA_RINGKASAN}</option>
              {Object.entries(DIMENSI).map(([k, v]) => (
                <option key={k} value={k}>
                  {v}
                </option>
              ))}
            </Pilihan>
            <Pilihan label="Cakupan" name="cak" defaultValue={nilaiCakupan}>
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
            <Pilihan label="Anggota" name="aktif" defaultValue={p.hanyaAktif ? "1" : "0"}>
              <option value="1">Aktif saja</option>
              <option value="0">Semua (termasuk tidak aktif)</option>
            </Pilihan>
            <Pilihan label="Tampilkan" name="t" defaultValue={p.tampil}>
              <option value="jumlah">Jumlah orang</option>
              <option value="persen">Persen</option>
            </Pilihan>
            <Tombol type="submit" className="col-span-2">
              Tampilkan laporan
            </Tombol>
          </form>
        </Kotak>
      </div>

      {galat ? <Pesan jenis="galat">{galat}</Pesan> : null}

      {ringkasan?.bagian ? (
        <>
          <h2 className="mb-3 text-lg font-semibold">{judul}</h2>
          <p className="mb-4 text-sm opacity-70">
            Dibuat {hariIniWib()}. Persentase dihitung dari yang sudah mengisi. Pilih satu dimensi di atas untuk
            melihat rincian per kelompok.
          </p>
          {ringkasan.bagian.map(({ dimensi, laporan: l }) => (
            <Kotak key={dimensi} judul={DIMENSI[dimensi]}>
              <p className="mb-3 text-sm opacity-70">
                {l.terisi.toLocaleString("id-ID")} orang sudah mengisi
                {l.belum ? `, ${l.belum.toLocaleString("id-ID")} belum diisi` : ""}.
              </p>
              {l.kategori.length === 0 ? (
                <p className="opacity-70">Belum ada data.</p>
              ) : (
                <GrafikBatang kategori={l.kategori} tampil={p.tampil} />
              )}
            </Kotak>
          ))}
          <TombolEkspor p={p} />
        </>
      ) : null}

      {laporan ? (
        <>
          <Kotak judul={judul}>
            <p className="mb-3 text-sm opacity-70">
              {laporan.terisi.toLocaleString("id-ID")} orang sudah mengisi
              {laporan.belum ? `, ${laporan.belum.toLocaleString("id-ID")} belum diisi` : ""} · dibuat {hariIniWib()}.
              Persentase dihitung dari yang sudah mengisi.
            </p>
            {laporan.kategori.length === 0 ? (
              <p className="opacity-70">Belum ada data untuk dimensi ini.</p>
            ) : (
              <GrafikBatang kategori={laporan.kategori} tampil={p.tampil} />
            )}
            {laporan.belum > 0 ? (
              <p className="mt-3 text-sm opacity-70">
                Belum diisi: {laporan.belum.toLocaleString("id-ID")} orang (tidak dihitung dalam persen;{" "}
                {formatPersen(Math.round((1000 * laporan.belum) / (laporan.belum + laporan.terisi)) / 10)} dari seluruh
                anggota dalam cakupan).
              </p>
            ) : null}
          </Kotak>

          {laporan.kelompok.length > 0 && laporan.kategori.length > 0 ? (
            <Kotak judul={`Per kelompok (${p.tampil === "jumlah" ? "jumlah orang" : "persen dalam kelompok"})`}>
              <TabelSilang laporan={laporan} tampil={p.tampil} namaDimensi={DIMENSI[p.dimensi]} />
            </Kotak>
          ) : null}

          <TombolEkspor p={p} />
        </>
      ) : null}
    </main>
  );
}

/** Unduh Excel dan Cetak/PDF (tercatat di log). */
function TombolEkspor({ p }: { p: PilihanLaporan }) {
  return (
    <div className="jangan-cetak mb-6 flex flex-wrap items-center gap-2">
      <a
        href={`/admin/laporan/ekspor?${parameterAlamat(p)}`}
        className="inline-flex min-h-11 items-center rounded-lg bg-utama px-4 py-2 font-medium text-white hover:opacity-90 dark:text-black"
      >
        Unduh Excel (.xlsx)
      </a>
      <TombolPdf
        parameter={{
          dimensi: p.ringkasan ? "ringkasan" : p.dimensi,
          cakupan: p.cakupan,
          cakupan_id: p.cakupanId ?? "",
          hanya_aktif: String(p.hanyaAktif),
        }}
      />
      <span className="text-xs opacity-70">Setiap pembuatan dan ekspor laporan tercatat di log.</span>
    </div>
  );
}
