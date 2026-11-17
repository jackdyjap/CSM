import { formatPersen, persen, type Laporan } from "@/lib/laporan";

/**
 * Tabel silang kategori × kelompok. Sel diberi gradasi satu warna menurut
 * persennya dalam kelompok (makin tinggi makin pekat); teks tetap berwarna tinta.
 */
export function TabelSilang({ laporan, tampil, namaDimensi }: { laporan: Laporan; tampil: "jumlah" | "persen"; namaDimensi: string }) {
  const sel = (n: number, dari: number) => {
    const p = persen(n, dari);
    return {
      teks: tampil === "jumlah" ? n.toLocaleString("id-ID") : formatPersen(p),
      gaya: { backgroundColor: `rgb(var(--seri-rgb) / ${n ? 0.06 + (0.4 * p) / 100 : 0})` },
    };
  };
  return (
    <div className="overflow-x-auto">
      <table className="w-full border-collapse text-sm tabular-nums">
        <thead>
          <tr className="border-b border-black/15 dark:border-white/20">
            <th scope="col" className="sticky left-0 bg-white px-2 py-2 text-left font-semibold dark:bg-[#1d2024]">
              {namaDimensi}
            </th>
            {laporan.kelompok.map((k) => (
              <th key={k.id} scope="col" className="px-2 py-2 text-right align-bottom font-semibold">
                <span className="block text-xs font-normal opacity-60">{k.tim}</span>
                {k.nama}
              </th>
            ))}
            <th scope="col" className="px-2 py-2 text-right align-bottom font-semibold">
              Total
            </th>
          </tr>
        </thead>
        <tbody>
          {laporan.kategori.map((kat) => (
            <tr key={kat.kunci} className="border-b border-black/5 dark:border-white/10">
              <th scope="row" className="sticky left-0 bg-white px-2 py-1.5 text-left font-normal dark:bg-[#1d2024]">
                {kat.label}
              </th>
              {laporan.kelompok.map((k) => {
                const c = sel(k.jumlah.get(kat.kunci) ?? 0, k.terisi);
                return (
                  <td key={k.id} className="px-2 py-1.5 text-right" style={c.gaya}>
                    {c.teks}
                  </td>
                );
              })}
              <td className="px-2 py-1.5 text-right font-semibold" style={sel(kat.total, laporan.terisi).gaya}>
                {sel(kat.total, laporan.terisi).teks}
              </td>
            </tr>
          ))}
          <tr className="border-t border-black/15 font-semibold dark:border-white/20">
            <th scope="row" className="sticky left-0 bg-white px-2 py-1.5 text-left dark:bg-[#1d2024]">
              Total terisi
            </th>
            {laporan.kelompok.map((k) => (
              <td key={k.id} className="px-2 py-1.5 text-right">
                {tampil === "jumlah" ? k.terisi.toLocaleString("id-ID") : k.terisi ? "100%" : "—"}
              </td>
            ))}
            <td className="px-2 py-1.5 text-right">{tampil === "jumlah" ? laporan.terisi.toLocaleString("id-ID") : "100%"}</td>
          </tr>
          <tr className="opacity-70">
            <th scope="row" className="sticky left-0 bg-white px-2 py-1.5 text-left font-normal dark:bg-[#1d2024]">
              Belum diisi
            </th>
            {laporan.kelompok.map((k) => (
              <td key={k.id} className="px-2 py-1.5 text-right">
                {k.belum.toLocaleString("id-ID")}
              </td>
            ))}
            <td className="px-2 py-1.5 text-right">{laporan.belum.toLocaleString("id-ID")}</td>
          </tr>
        </tbody>
      </table>
    </div>
  );
}
