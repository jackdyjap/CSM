"use client";

import { useRef, useState, type ReactNode } from "react";

/**
 * Kotak pencarian yang menyaring daftar di bawahnya saat mengetik.
 * Setiap butir daftar memberi atribut data-cari berisi teks yang bisa dicari.
 */
export function SaringCari({
  children,
  label,
  jumlah,
  satuan = "bahan",
}: {
  children: ReactNode;
  label: string;
  jumlah: number;
  /** Kata benda untuk hitungan, mis. "bahan" atau "anggota". */
  satuan?: string;
}) {
  const [cari, setCari] = useState("");
  const [cocok, setCocok] = useState(jumlah);
  const wadah = useRef<HTMLDivElement>(null);

  function ubah(nilai: string) {
    setCari(nilai);
    const kata = nilai.trim().toLowerCase().split(/\s+/).filter(Boolean);
    let n = 0;
    wadah.current?.querySelectorAll<HTMLElement>("[data-cari]").forEach((el) => {
      const tampil = kata.every((k) => (el.dataset.cari ?? "").includes(k));
      el.hidden = !tampil;
      if (tampil) n += 1;
    });
    setCocok(n);
  }

  return (
    <div>
      <input
        type="search"
        value={cari}
        onChange={(e) => ubah(e.target.value)}
        placeholder={label}
        aria-label={label}
        autoComplete="off"
        className="mb-2 min-h-11 w-full rounded-lg border border-black/20 bg-white px-3 py-2 text-base dark:border-white/20 dark:bg-black/30"
      />
      <p className="mb-2 text-xs opacity-70" aria-live="polite">
        {cari.trim() ? `${cocok} dari ${jumlah} ${satuan} cocok.` : `${jumlah} ${satuan}.`}
      </p>
      <div ref={wadah}>{children}</div>
      {cari.trim() && cocok === 0 ? (
        <p className="py-3 text-sm opacity-70">Tidak ada {satuan} yang cocok dengan &ldquo;{cari.trim()}&rdquo;.</p>
      ) : null}
    </div>
  );
}
