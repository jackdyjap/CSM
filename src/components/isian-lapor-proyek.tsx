"use client";

import { useState } from "react";
import { PILIHAN_LAPOR_PROYEK, type LaporProyek } from "@/lib/pilihan-fase5";
import { IsianPanjang } from "./ui";

/** Pilihan status + alasan (belum) atau hasil (selesai) untuk laporan proyek sendiri. */
export function IsianLaporProyek({
  statusAwal,
  alasanAwal,
  hasilAwal,
}: {
  statusAwal: LaporProyek | null;
  alasanAwal: string | null;
  hasilAwal: string | null;
}) {
  const [status, setStatus] = useState<LaporProyek | null>(statusAwal);
  return (
    <>
      <fieldset className="mb-3">
        <legend className="mb-1 text-sm font-medium">Status</legend>
        <div className="flex flex-wrap gap-2">
          {(Object.keys(PILIHAN_LAPOR_PROYEK) as LaporProyek[]).map((k) => (
            <label
              key={k}
              className={`flex min-h-11 cursor-pointer items-center gap-2 rounded-full border px-3 text-sm ${
                status === k ? "border-current font-semibold" : "border-black/15 dark:border-white/20"
              }`}
            >
              <input
                type="radio"
                name="status"
                value={k}
                checked={status === k}
                onChange={() => setStatus(k)}
                required
                className="h-4 w-4"
              />
              {PILIHAN_LAPOR_PROYEK[k]}
            </label>
          ))}
        </div>
      </fieldset>
      {status === "belum" ? (
        <IsianPanjang label="Alasan belum dijalankan (wajib)" name="alasan" defaultValue={alasanAwal ?? ""} maxLength={1000} required />
      ) : null}
      {status === "selesai" ? (
        <IsianPanjang
          label="Hasil yang didapat dari menjalankan proyek ini (wajib)"
          name="hasil"
          defaultValue={hasilAwal ?? ""}
          maxLength={2000}
          rows={4}
          required
        />
      ) : null}
    </>
  );
}
