import { formatPersen, persen, urutanTetap, type Dimensi, type Kategori } from "@/lib/laporan";

/** Paling banyak 6 potongan; bila lebih, 5 terbesar + "Lainnya" (aturan dataviz: pie <= 6 bagian). */
const MAKS_POTONGAN = 6;
const WARNA = ["var(--kat-1)", "var(--kat-2)", "var(--kat-3)", "var(--kat-4)", "var(--kat-5)", "var(--kat-6)"];
const WARNA_LAIN = "var(--kat-lain)";

type Potongan = { kunci: string; label: string; total: number; persen: number; warna: string; isi?: Kategori[] };

/**
 * Menyusun potongan pie. Warna mengikuti kategorinya (bukan peringkat) bila dimensi punya
 * daftar tetap <= 6 pilihan (gender, status pernikahan, baptis, status jemaat), sehingga
 * "Menikah" selalu berwarna sama di cakupan mana pun. Dimensi lain memakai urutan tampil.
 */
export function susunPotongan(kategori: Kategori[], dimensi: Dimensi): Potongan[] {
  const terisi = kategori.reduce((n, k) => n + k.total, 0);
  const tetap = urutanTetap(dimensi);
  const warnaTetap = tetap && tetap.length <= MAKS_POTONGAN;

  if (kategori.length <= MAKS_POTONGAN) {
    return kategori.map((k, i) => ({
      ...k,
      warna: WARNA[warnaTetap ? tetap.indexOf(k.kunci) : i] ?? WARNA_LAIN,
    }));
  }

  // Terlalu banyak potongan: 5 terbesar (seri = urutan aslinya), sisanya "Lainnya".
  const urut = kategori
    .map((k, i) => ({ k, i }))
    .sort((a, b) => b.k.total - a.k.total || a.i - b.i);
  const besar = urut.slice(0, MAKS_POTONGAN - 1).sort((a, b) => a.i - b.i).map((x) => x.k);
  const sisa = urut.slice(MAKS_POTONGAN - 1).sort((a, b) => b.k.total - a.k.total || a.i - b.i).map((x) => x.k);
  const totalSisa = sisa.reduce((n, k) => n + k.total, 0);
  return [
    ...besar.map((k, i) => ({ ...k, warna: WARNA[i] })),
    {
      kunci: "__lainnya",
      label: `Lainnya (${sisa.length} kategori)`,
      total: totalSisa,
      persen: persen(totalSisa, terisi),
      warna: WARNA_LAIN,
      isi: sisa,
    },
  ];
}

const R_LUAR = 80;
const R_DALAM = 50;
const PUSAT = 90;

function titik(r: number, sudut: number) {
  // Sudut 0 = arah jam 12, searah jarum jam.
  return [PUSAT + r * Math.sin(sudut), PUSAT - r * Math.cos(sudut)];
}

function jalurPotongan(awal: number, akhir: number) {
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

const teksNilai = (total: number, p: number) => `${total.toLocaleString("id-ID")} orang · ${formatPersen(p)}`;

/**
 * Grafik donat (pie berlubang) untuk satu dimensi, dengan keterangan di sampingnya:
 * warna, nama kategori, jumlah orang, dan persen. Persen dihitung dari yang sudah mengisi.
 * Potongan dipisah garis 2px warna kartu; tooltip bawaan saat disentuh/diarahkan.
 */
export function GrafikPie({ kategori, dimensi }: { kategori: Kategori[]; dimensi: Dimensi }) {
  const potongan = susunPotongan(kategori, dimensi);
  const terisi = potongan.reduce((n, k) => n + k.total, 0);
  let sudut = 0;

  return (
    <div className="grid items-center gap-4 sm:grid-cols-[180px_1fr]">
      <svg
        viewBox="0 0 180 180"
        className="mx-auto block w-full max-w-[180px]"
        role="img"
        aria-label={potongan.map((k) => `${k.label}: ${teksNilai(k.total, k.persen)}`).join("; ")}
      >
        {potongan.length === 1 ? (
          <circle
            cx={PUSAT}
            cy={PUSAT}
            r={(R_LUAR + R_DALAM) / 2}
            fill="none"
            stroke={potongan[0].warna}
            strokeWidth={R_LUAR - R_DALAM}
          >
            <title>{`${potongan[0].label}: ${teksNilai(potongan[0].total, potongan[0].persen)}`}</title>
          </circle>
        ) : (
          potongan.map((k) => {
            const awal = sudut;
            sudut += terisi ? (k.total / terisi) * 2 * Math.PI : 0;
            if (k.total === 0) return null;
            return (
              <path
                key={k.kunci}
                d={jalurPotongan(awal, sudut)}
                fill={k.warna}
                stroke="var(--kartu)"
                strokeWidth={2}
                strokeLinejoin="round"
                className="transition-opacity hover:opacity-80"
              >
                <title>{`${k.label}: ${teksNilai(k.total, k.persen)}`}</title>
              </path>
            );
          })
        )}
        <text x={PUSAT} y={PUSAT - 2} textAnchor="middle" className="fill-current text-[22px] font-semibold">
          {terisi.toLocaleString("id-ID")}
        </text>
        <text x={PUSAT} y={PUSAT + 16} textAnchor="middle" className="fill-current text-[11px] opacity-70">
          orang
        </text>
      </svg>

      <ul className="space-y-1.5" role="list">
        {potongan.map((k) => (
          <li key={k.kunci}>
            <div className="flex items-start gap-2 text-sm">
              <span aria-hidden className="mt-1 size-3 flex-none rounded-sm" style={{ background: k.warna }} />
              <span className="flex-1 leading-tight">{k.label}</span>
              <span className="whitespace-nowrap tabular-nums">{teksNilai(k.total, k.persen)}</span>
            </div>
            {k.isi ? (
              <ul className="mt-1 ml-5 space-y-0.5 text-xs opacity-70" role="list">
                {k.isi.map((s) => (
                  <li key={s.kunci} className="flex gap-2">
                    <span className="flex-1">{s.label}</span>
                    <span className="whitespace-nowrap tabular-nums">{teksNilai(s.total, s.persen)}</span>
                  </li>
                ))}
              </ul>
            ) : null}
          </li>
        ))}
      </ul>
    </div>
  );
}
