"use client";

import { useState } from "react";

/** Membuka/menutup semua rincian proyek per kelompok (mis. sebelum Cetak / simpan PDF). */
export function TombolBukaSemua() {
  const [terbuka, setTerbuka] = useState(false);
  return (
    <button
      type="button"
      onClick={() => {
        const buka = !terbuka;
        document.querySelectorAll<HTMLDetailsElement>("details.rincian-proyek").forEach((d) => (d.open = buka));
        setTerbuka(buka);
      }}
      className="jangan-cetak inline-flex min-h-10 items-center rounded-lg border border-black/15 px-3 text-sm font-medium hover:bg-black/5 active:scale-[0.98] dark:border-white/20 dark:hover:bg-white/10"
    >
      {terbuka ? "Tutup semua" : "Buka semua"}
    </button>
  );
}
