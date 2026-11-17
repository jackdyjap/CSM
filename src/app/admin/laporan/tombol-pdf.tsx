"use client";

import { useState } from "react";
import { Tombol } from "@/components/ui";
import { catatEksporPdf } from "./aksi";

/** Mencatat ekspor PDF di log, lalu membuka dialog cetak (pilih "Simpan sebagai PDF"). */
export function TombolPdf({ parameter }: { parameter: Record<string, string> }) {
  const [galat, setGalat] = useState<string | null>(null);
  return (
    <>
      <Tombol
        type="button"
        jenis="biasa"
        onClick={async () => {
          setGalat(null);
          const h = await catatEksporPdf(parameter);
          if (h.galat) setGalat(h.galat);
          else window.print();
        }}
      >
        Cetak / simpan PDF
      </Tombol>
      {galat ? <span role="alert" className="text-sm text-red-700 dark:text-red-400">{galat}</span> : null}
    </>
  );
}
