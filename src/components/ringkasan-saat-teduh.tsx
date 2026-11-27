import Link from "next/link";
import { daftarBulan, labelBulan, persen, type BarisRingkasanTeduh } from "@/lib/saat-teduh";
import { Kotak, Tombol } from "./ui";

/** Pilihan bulan (formulir GET, tanpa JavaScript). */
export function PilihBulan({ bulan }: { bulan: string }) {
  return (
    <form method="get" className="mb-4 flex items-end gap-2">
      <label className="block flex-1">
        <span className="mb-1 block text-sm font-medium">Bulan</span>
        <select
          name="bulan"
          defaultValue={bulan}
          className="min-h-11 w-full rounded-lg border border-black/20 bg-white px-3 py-2 text-base dark:border-white/20 dark:bg-black/30"
        >
          {daftarBulan().map((b) => (
            <option key={b} value={b}>
              {labelBulan(b)}
            </option>
          ))}
        </select>
      </label>
      <Tombol type="submit" jenis="biasa">
        Tampilkan
      </Tombol>
    </form>
  );
}

type Jumlah = Pick<BarisRingkasanTeduh, "anggota_aktif" | "punya_akun" | "bersaat_teduh" | "jumlah_catatan">;

function jumlahkan(baris: Jumlah[]): Jumlah {
  return baris.reduce(
    (t, b) => ({
      anggota_aktif: t.anggota_aktif + b.anggota_aktif,
      punya_akun: t.punya_akun + b.punya_akun,
      bersaat_teduh: t.bersaat_teduh + b.bersaat_teduh,
      jumlah_catatan: t.jumlah_catatan + b.jumlah_catatan,
    }),
    { anggota_aktif: 0, punya_akun: 0, bersaat_teduh: 0, jumlah_catatan: 0 },
  );
}

/** "8 dari 12 anggota (67%) bersaat teduh · 95 catatan" + catatan tanpa akun. */
export function KalimatRingkasan({ j, besar = false }: { j: Jumlah; besar?: boolean }) {
  const tanpaAkun = j.anggota_aktif - j.punya_akun;
  return (
    <div>
      <p className={besar ? "text-lg" : "text-sm"}>
        <strong>
          {j.bersaat_teduh} dari {j.punya_akun}
        </strong>{" "}
        anggota ({persen(j.bersaat_teduh, j.punya_akun)}) bersaat teduh · {j.jumlah_catatan} catatan
      </p>
      {tanpaAkun > 0 ? (
        <p className="text-xs opacity-70">{tanpaAkun} anggota aktif belum punya akun (tidak dihitung).</p>
      ) : null}
    </div>
  );
}

/**
 * Ringkasan saat teduh sebulan: total, lalu per tim, lalu per kelompok
 * (jumlah dan persentase anggota aktif ber-akun yang bersaat teduh).
 */
export function RingkasanSaatTeduh({
  baris,
  bulan,
  totalSemua = true,
}: {
  baris: BarisRingkasanTeduh[];
  bulan: string;
  totalSemua?: boolean;
}) {
  const perTim = new Map<string, { nama: string; kelompok: BarisRingkasanTeduh[] }>();
  for (const b of baris) {
    const t = perTim.get(b.tim_id) ?? { nama: b.tim_nama, kelompok: [] };
    t.kelompok.push(b);
    perTim.set(b.tim_id, t);
  }

  if (baris.length === 0) return <p className="opacity-70">Belum ada kelompok.</p>;

  return (
    <>
      {totalSemua ? (
        <Kotak judul={`Semua tim · ${labelBulan(bulan)}`}>
          <KalimatRingkasan j={jumlahkan(baris)} besar />
        </Kotak>
      ) : null}
      {[...perTim.entries()].map(([timId, t]) => (
        <Kotak key={timId} judul={`Tim ${t.nama}`}>
          <div className="mb-3">
            <KalimatRingkasan j={jumlahkan(t.kelompok)} besar={!totalSemua} />
          </div>
          <ul className="divide-y divide-black/10 dark:divide-white/10">
            {t.kelompok.map((k) => (
              <li key={k.kelompok_id}>
                <Link
                  href={`/kelompok/${k.kelompok_id}/saat-teduh?bulan=${bulan}`}
                  className="-mx-2 flex min-h-11 items-center gap-3 rounded-lg px-2 py-2 hover:bg-black/5 dark:hover:bg-white/10"
                >
                  <span className="min-w-0 flex-1">
                    <span className="block truncate font-medium">{k.kelompok_nama}</span>
                    <span className="block text-xs opacity-70">
                      {k.bersaat_teduh} dari {k.punya_akun} anggota · {k.jumlah_catatan} catatan
                      {k.anggota_aktif > k.punya_akun ? ` · ${k.anggota_aktif - k.punya_akun} tanpa akun` : ""}
                    </span>
                  </span>
                  <span className="flex-none text-lg font-semibold tabular-nums">
                    {persen(k.bersaat_teduh, k.punya_akun)}
                  </span>
                  <span className="text-sm opacity-60" aria-hidden>
                    →
                  </span>
                </Link>
              </li>
            ))}
          </ul>
        </Kotak>
      ))}
    </>
  );
}
