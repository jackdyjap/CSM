import { formatPersen, type Kategori } from "@/lib/laporan";

/**
 * Grafik batang horizontal satu seri (jumlah per kategori).
 * Batang <= 20px, ujung data membulat 4px dan pangkal persegi; nilai di ujung batang.
 * Satu seri tidak memerlukan legenda; judul kotak sudah menyebut isinya.
 * Tooltip saat disentuh/diarahkan; tabel silang di bawahnya menjadi tampilan tabel.
 */
export function GrafikBatang({ kategori, tampil }: { kategori: Kategori[]; tampil: "jumlah" | "persen" }) {
  const maks = Math.max(1, ...kategori.map((k) => (tampil === "jumlah" ? k.total : k.persen)));
  return (
    <ul className="space-y-2" role="list">
      {kategori.map((k) => {
        const nilai = tampil === "jumlah" ? k.total : k.persen;
        const lebar = (nilai / maks) * 100;
        const teks = tampil === "jumlah" ? `${k.total.toLocaleString("id-ID")}` : formatPersen(k.persen);
        return (
          <li
            key={k.kunci}
            tabIndex={0}
            aria-label={`${k.label}: ${k.total} orang, ${formatPersen(k.persen)}`}
            className="group relative grid grid-cols-[minmax(6rem,38%)_1fr] items-center gap-2 rounded outline-offset-2"
          >
            <span className="text-sm leading-tight">{k.label}</span>
            <span className="flex items-center gap-2">
              <span
                aria-hidden
                className="block h-5 rounded-r-[4px] bg-seri transition-opacity group-hover:opacity-80"
                style={{ width: `max(2px, calc((100% - 4rem) * ${lebar / 100}))` }}
              />
              <span className="text-sm whitespace-nowrap tabular-nums">{teks}</span>
            </span>
            <span
              role="tooltip"
              className="pointer-events-none absolute -top-9 right-0 z-10 hidden rounded-md border border-black/10 bg-white px-2 py-1 text-xs whitespace-nowrap text-black shadow-md group-hover:block group-focus:block dark:border-white/15 dark:bg-[#24282d] dark:text-white"
            >
              <strong>{k.label}</strong> · {k.total.toLocaleString("id-ID")} orang · {formatPersen(k.persen)}
            </span>
          </li>
        );
      })}
    </ul>
  );
}
