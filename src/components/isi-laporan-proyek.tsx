import { TombolPdf } from "@/app/admin/laporan/tombol-pdf";
import { Kotak } from "@/components/ui";
import {
  KATEGORI_PROYEK,
  kategori,
  persenBulat,
  type Hitungan,
  type KategoriProyek,
  type susunLaporanProyek,
} from "@/lib/laporan-proyek";
import { tanggalPanjang } from "@/lib/pertemuan";
import { hariIniWib } from "@/lib/profil";

const WARNA: Record<KategoriProyek, string> = {
  selesai: "text-green-800 dark:text-green-300",
  sedang: "text-amber-800 dark:text-amber-300",
  belum: "text-black/80 dark:text-white/80",
  tidak_dikerjakan: "text-red-800 dark:text-red-300",
  belum_dilaporkan: "opacity-60",
};

/** Isi laporan pelaksanaan proyek ketaatan (keputusan 38); juga yang tercetak ke PDF. */
export function IsiLaporanProyek({
  laporan,
  namaCakupan,
  cakupan,
  cakupanId,
}: {
  laporan: ReturnType<typeof susunLaporanProyek>;
  namaCakupan: string;
  cakupan: string;
  cakupanId: string | null;
}) {
  return (
    <>
      <h2 className="mb-1 text-lg font-semibold">
        Pelaksanaan proyek ketaatan · {namaCakupan}
      </h2>
      <p className="mb-4 text-sm opacity-70">
        Dibuat {hariIniWib()}. {laporan.jumlahProyek} proyek,{" "}
        {laporan.total.total} penugasan (proyek × anggota). Persen dihitung dari
        seluruh penugasan.
      </p>

      {laporan.total.total === 0 ? (
        <Kotak>
          <p className="opacity-70">
            Belum ada proyek ketaatan dalam cakupan ini.
          </p>
        </Kotak>
      ) : (
        <>
          <Kotak judul="Ringkasan">
            <Ringkasan h={laporan.total} />
          </Kotak>

          <Kotak judul="Per kelompok">
            <div className="overflow-x-auto">
              <table className="w-full min-w-[34rem] text-sm">
                <thead>
                  <tr className="border-b border-black/20 text-left dark:border-white/20">
                    <th className="py-1 pr-2">Kelompok</th>
                    <th className="py-1 pr-2 text-right">Proyek</th>
                    <th className="py-1 pr-2 text-right">Selesai</th>
                    <th className="py-1 pr-2 text-right">Sedang</th>
                    <th className="py-1 pr-2 text-right">Belum</th>
                    <th className="py-1 pr-2 text-right">Tidak dik.</th>
                    <th className="py-1 text-right">Belum lapor</th>
                  </tr>
                </thead>
                <tbody>
                  {laporan.kelompok.map((k) => (
                    <tr
                      key={k.id}
                      className="border-b border-black/10 dark:border-white/10"
                    >
                      <td className="py-1 pr-2">
                        {k.nama}
                        <span className="block text-xs opacity-60">
                          {k.tim}
                        </span>
                      </td>
                      <td className="py-1 pr-2 text-right tabular-nums">
                        {k.proyek}
                      </td>
                      <td className="py-1 pr-2 text-right font-semibold tabular-nums">
                        {persenBulat(k.hitungan.selesai, k.hitungan.total)}%
                        <span className="block text-xs font-normal opacity-60">
                          {k.hitungan.selesai}/{k.hitungan.total}
                        </span>
                      </td>
                      <td className="py-1 pr-2 text-right tabular-nums">
                        {k.hitungan.sedang}
                      </td>
                      <td className="py-1 pr-2 text-right tabular-nums">
                        {k.hitungan.belum}
                      </td>
                      <td className="py-1 pr-2 text-right tabular-nums">
                        {k.hitungan.tidak_dikerjakan}
                      </td>
                      <td className="py-1 text-right tabular-nums">
                        {k.hitungan.belum_dilaporkan}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </Kotak>

          <h2 className="mb-3 text-lg font-semibold">Per proyek</h2>
          {laporan.proyek.map((p) => (
            <Kotak key={p.id} judul={p.judul}>
              <p className="text-xs opacity-70">
                {p.kelompok} · {p.tim} · diberikan{" "}
                {tanggalPanjang(p.diberikan_pada)}
                {p.tenggat ? ` · tenggat ${tanggalPanjang(p.tenggat)}` : ""}
              </p>
              <p className="mb-2 text-sm">
                Selesai <strong>{p.hitungan.selesai}</strong> dari{" "}
                {p.hitungan.total} (
                {persenBulat(p.hitungan.selesai, p.hitungan.total)}%)
              </p>
              <ul className="divide-y divide-black/10 text-sm dark:divide-white/10">
                {p.anggota.map((a) => {
                  const k = kategori(a);
                  return (
                    <li key={a.anggota_id} className="py-1.5">
                      <span className="font-medium">{a.anggota_nama}</span>
                      {a.anggota_aktif ? (
                        ""
                      ) : (
                        <span className="text-xs opacity-60">
                          {" "}
                          (tidak aktif)
                        </span>
                      )}
                      {" · "}
                      <span className={`font-semibold ${WARNA[k]}`}>
                        {KATEGORI_PROYEK[k]}
                      </span>
                      {a.dilaporkan && !a.dilaporkan_sendiri ? (
                        <span className="text-xs opacity-60">
                          {" "}
                          (diisi pemimpin)
                        </span>
                      ) : null}
                      {a.hasil ? (
                        <p className="mt-0.5 whitespace-pre-line opacity-90">
                          Hasil: {a.hasil}
                        </p>
                      ) : null}
                      {a.alasan ? (
                        <p className="mt-0.5 whitespace-pre-line opacity-90">
                          Alasan: {a.alasan}
                        </p>
                      ) : null}
                      {a.keterangan ? (
                        <p className="mt-0.5 text-xs opacity-70">
                          Catatan pemimpin: {a.keterangan}
                        </p>
                      ) : null}
                    </li>
                  );
                })}
              </ul>
            </Kotak>
          ))}
        </>
      )}

      <div className="jangan-cetak mb-6 flex flex-wrap items-center gap-2">
        <TombolPdf
          parameter={{
            laporan: "proyek",
            cakupan,
            cakupan_id: cakupanId ?? "",
          }}
        />
        <span className="text-xs opacity-70">
          Pilih &ldquo;Simpan sebagai PDF&rdquo; di dialog cetak. Tercatat di
          log.
        </span>
      </div>
    </>
  );
}

function Ringkasan({ h }: { h: Hitungan }) {
  return (
    <dl className="grid grid-cols-2 gap-2 sm:grid-cols-3">
      {(Object.keys(KATEGORI_PROYEK) as KategoriProyek[]).map((k) => (
        <div
          key={k}
          className="rounded-lg border border-black/10 p-2 dark:border-white/10"
        >
          <dt className="text-xs opacity-70">{KATEGORI_PROYEK[k]}</dt>
          <dd className={`text-xl font-bold tabular-nums ${WARNA[k]}`}>
            {h[k]}{" "}
            <span className="text-sm font-normal opacity-70">
              ({persenBulat(h[k], h.total)}%)
            </span>
          </dd>
        </div>
      ))}
    </dl>
  );
}
