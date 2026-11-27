"use client";

import { useState } from "react";
import { Tombol } from "./ui";

const gaya =
  "min-h-11 w-full rounded-lg border border-black/20 bg-white px-3 py-2 text-base dark:border-white/20 dark:bg-black/30";

/**
 * Pilihan periode ringkasan Saat Teduh pribadi (GET): per bulan atau per tahun,
 * bulan/tahunnya, dan grafik. Hanya pilihan yang sesuai periode yang ditampilkan.
 */
export function FormPeriodeTeduh({
  periode,
  bulan,
  tahun,
  grafik,
  daftarBulan,
  daftarTahun,
}: {
  periode: "bulan" | "tahun";
  bulan: string;
  tahun: number;
  grafik: string;
  daftarBulan: { nilai: string; label: string }[];
  daftarTahun: number[];
}) {
  const [p, setP] = useState(periode);
  return (
    <form method="get" className="grid grid-cols-2 gap-x-3 gap-y-3">
      <label className="block">
        <span className="mb-1 block text-sm font-medium">Periode</span>
        <select name="p" value={p} onChange={(e) => setP(e.target.value as "bulan" | "tahun")} className={gaya}>
          <option value="bulan">Per bulan</option>
          <option value="tahun">Per tahun</option>
        </select>
      </label>
      {p === "bulan" ? (
        <label className="block">
          <span className="mb-1 block text-sm font-medium">Bulan</span>
          <select name="bulan" defaultValue={bulan} className={gaya}>
            {daftarBulan.map((b) => (
              <option key={b.nilai} value={b.nilai}>
                {b.label}
              </option>
            ))}
          </select>
        </label>
      ) : (
        <label className="block">
          <span className="mb-1 block text-sm font-medium">Tahun</span>
          <select name="tahun" defaultValue={tahun} className={gaya}>
            {daftarTahun.map((t) => (
              <option key={t} value={t}>
                {t}
              </option>
            ))}
          </select>
        </label>
      )}
      <label className="col-span-2 block">
        <span className="mb-1 block text-sm font-medium">Grafik</span>
        <select name="g" defaultValue={grafik} className={gaya}>
          <option value="batang">Batang</option>
          <option value="pie">Pie</option>
          <option value="tanpa">Tanpa grafik</option>
        </select>
      </label>
      <Tombol type="submit" className="col-span-2">
        Tampilkan
      </Tombol>
    </form>
  );
}
