"use client";

import { useState } from "react";

/** Menampilkan tautan beserta tombol Salin dan Kirim lewat WhatsApp. */
export function BagikanTautan({ tautan, teksWa }: { tautan: string; teksWa?: string }) {
  const [tersalin, setTersalin] = useState(false);

  async function salin() {
    try {
      await navigator.clipboard.writeText(tautan);
      setTersalin(true);
      setTimeout(() => setTersalin(false), 2000);
    } catch {
      // Peramban lama: pengguna bisa menyalin manual dari kotak di bawah.
    }
  }

  const wa = `https://wa.me/?text=${encodeURIComponent(teksWa ?? tautan)}`;

  return (
    <div className="mb-3 rounded-lg border border-green-600/30 bg-green-50 p-3 dark:bg-green-950">
      <p className="mb-2 text-sm font-medium">Tautan siap dibagikan:</p>
      <input
        readOnly
        value={tautan}
        onFocus={(e) => e.currentTarget.select()}
        className="mb-2 w-full rounded border border-black/20 bg-white px-2 py-1 font-mono text-xs dark:bg-black/30"
        aria-label="Tautan"
      />
      <div className="flex flex-wrap gap-2">
        <button
          type="button"
          onClick={salin}
          className="min-h-11 rounded-lg border border-black/15 px-3 py-2 text-sm font-medium"
        >
          {tersalin ? "Tersalin ✓" : "Salin tautan"}
        </button>
        <a
          href={wa}
          target="_blank"
          rel="noopener noreferrer"
          className="inline-flex min-h-11 items-center rounded-lg bg-green-600 px-3 py-2 text-sm font-medium text-white"
        >
          Kirim lewat WhatsApp
        </a>
      </div>
    </div>
  );
}
