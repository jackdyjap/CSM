"use client";

import { useState } from "react";
import { PILIHAN_PERUNTUKAN } from "@/lib/training";

type Awal = { untuk_semua: boolean; untuk_ketua_tim: boolean; untuk_pemimpin: boolean; untuk_anggota: boolean };

/** Peruntukan bahan training: "Semua", atau satu/lebih peran (keputusan 54). */
export function IsianPeruntukan({ awal }: { awal?: Awal }) {
  const [semua, setSemua] = useState(awal?.untuk_semua ?? true);
  return (
    <fieldset className="mb-3 rounded-lg border border-black/10 p-3 dark:border-white/10">
      <legend className="px-1 text-sm font-medium">Untuk</legend>
      <label className="flex min-h-10 items-center gap-3">
        <input
          type="checkbox"
          name="untuk_semua"
          value="ya"
          checked={semua}
          onChange={(e) => setSemua(e.target.checked)}
          className="h-5 w-5 flex-none"
        />
        <span>Semua</span>
      </label>
      {PILIHAN_PERUNTUKAN.map(([nama, label]) => (
        <label key={nama} className={`flex min-h-10 items-center gap-3 pl-4 ${semua ? "opacity-50" : ""}`}>
          <input
            type="checkbox"
            name={nama}
            value="ya"
            defaultChecked={awal ? awal[nama] : false}
            disabled={semua}
            className="h-5 w-5 flex-none"
          />
          <span>{label}</span>
        </label>
      ))}
      <p className="mt-1 text-xs opacity-70">Hapus centang &ldquo;Semua&rdquo; untuk memilih satu atau beberapa peran.</p>
    </fieldset>
  );
}
