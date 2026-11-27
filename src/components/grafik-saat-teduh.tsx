// Grafik progres Saat Teduh (keputusan 61). Warna memakai token yang sama dengan
// laporan demografi: --kat-1 (biru) untuk "Melaksanakan", --kat-lain (abu-abu,
// netral) untuk "Belum". Identitas tidak bergantung warna saja: setiap bagian
// berlabel nama, jumlah, dan persen; tooltip saat disentuh/diarahkan.

const PUSAT = 90;
const R_LUAR = 80;
const R_DALAM = 50;

function titik(r: number, sudut: number) {
  return [PUSAT + r * Math.sin(sudut), PUSAT - r * Math.cos(sudut)];
}

function jalur(awal: number, akhir: number) {
  const besar = akhir - awal > Math.PI ? 1 : 0;
  const [x1, y1] = titik(R_LUAR, awal);
  const [x2, y2] = titik(R_LUAR, akhir);
  const [x3, y3] = titik(R_DALAM, akhir);
  const [x4, y4] = titik(R_DALAM, awal);
  const f = (n: number) => n.toFixed(2);
  return (
    `M${f(x1)} ${f(y1)} A${R_LUAR} ${R_LUAR} 0 ${besar} 1 ${f(x2)} ${f(y2)} ` +
    `L${f(x3)} ${f(y3)} A${R_DALAM} ${R_DALAM} 0 ${besar} 0 ${f(x4)} ${f(y4)} Z`
  );
}

const pct = (a: number, b: number) => (b > 0 ? Math.round((a / b) * 100) : 0);

/** Donat dua bagian: anggota ber-akun yang melaksanakan saat teduh vs belum. */
export function GrafikPelaksana({ pelaksana, dari }: { pelaksana: number; dari: number }) {
  if (dari === 0) return <p className="text-sm opacity-70">Belum ada anggota ber-akun untuk digambarkan.</p>;
  const bagian = [
    { kunci: "ya", label: "Melaksanakan", total: pelaksana, warna: "var(--kat-1)" },
    { kunci: "belum", label: "Belum", total: dari - pelaksana, warna: "var(--kat-lain)" },
  ].filter((b) => b.total > 0);
  const teks = (n: number) => `${n} anggota · ${pct(n, dari)}%`;
  let sudut = 0;

  return (
    <div className="grid items-center gap-4 sm:grid-cols-[160px_1fr]">
      <svg
        viewBox="0 0 180 180"
        className="mx-auto block w-full max-w-[160px]"
        role="img"
        aria-label={bagian.map((b) => `${b.label}: ${teks(b.total)}`).join("; ")}
      >
        {bagian.length === 1 ? (
          <circle
            cx={PUSAT}
            cy={PUSAT}
            r={(R_LUAR + R_DALAM) / 2}
            fill="none"
            stroke={bagian[0].warna}
            strokeWidth={R_LUAR - R_DALAM}
          >
            <title>{`${bagian[0].label}: ${teks(bagian[0].total)}`}</title>
          </circle>
        ) : (
          bagian.map((b) => {
            const awal = sudut;
            sudut += (b.total / dari) * Math.PI * 2;
            return (
              <path
                key={b.kunci}
                d={jalur(awal, sudut)}
                fill={b.warna}
                stroke="var(--kartu)"
                strokeWidth={2}
                className="transition-opacity hover:opacity-80"
              >
                <title>{`${b.label}: ${teks(b.total)}`}</title>
              </path>
            );
          })
        )}
        <text x={PUSAT} y={PUSAT + 2} textAnchor="middle" className="fill-current text-[26px] font-bold">
          {pct(pelaksana, dari)}%
        </text>
        <text x={PUSAT} y={PUSAT + 20} textAnchor="middle" className="fill-current text-[11px] opacity-70">
          melaksanakan
        </text>
      </svg>
      <ul className="space-y-1 text-sm">
        {[
          { label: "Melaksanakan", total: pelaksana, warna: "var(--kat-1)" },
          { label: "Belum", total: dari - pelaksana, warna: "var(--kat-lain)" },
        ].map((b) => (
          <li key={b.label} className="flex items-center gap-2">
            <span aria-hidden className="inline-block h-3 w-3 flex-none rounded-sm" style={{ background: b.warna }} />
            <span className="flex-1">{b.label}</span>
            <span className="tabular-nums">{teks(b.total)}</span>
          </li>
        ))}
      </ul>
    </div>
  );
}

export type BatangTeduh = { kunci: string; label: string; nilai: number; teks: string };

/**
 * Batang horizontal satu seri (tanpa legenda; judul kotak menyebut isinya).
 * `skala` = nilai penuh (100 untuk persen; jumlah hari terbanyak untuk anggota).
 */
export function GrafikBatangTeduh({ batang, skala }: { batang: BatangTeduh[]; skala: number }) {
  const maks = Math.max(1, skala);
  return (
    <ul className="space-y-2" role="list">
      {batang.map((b) => (
        <li
          key={b.kunci}
          tabIndex={0}
          aria-label={`${b.label}: ${b.teks}`}
          className="group relative grid grid-cols-[minmax(5rem,30%)_1fr] items-center gap-2 rounded outline-offset-2"
        >
          <span className="truncate text-sm leading-tight">{b.label}</span>
          <span className="flex items-center gap-2">
            <span
              aria-hidden
              className="block h-5 rounded-r-[4px] bg-seri transition-opacity group-hover:opacity-80"
              style={{ width: `max(2px, calc((100% - 5.5rem) * ${Math.min(b.nilai, maks) / maks}))` }}
            />
            <span className="text-sm whitespace-nowrap tabular-nums">{b.teks}</span>
          </span>
          <span
            role="tooltip"
            className="pointer-events-none absolute -top-9 right-0 z-10 hidden rounded-md border border-black/10 bg-white px-2 py-1 text-xs whitespace-nowrap text-black shadow-md group-hover:block group-focus:block dark:border-white/15 dark:bg-[#24282d] dark:text-white"
          >
            <strong>{b.label}</strong> · {b.teks}
          </span>
        </li>
      ))}
    </ul>
  );
}
