"use client";

import { useEffect } from "react";
import { Judul, Pesan, Tombol } from "@/components/ui";

/**
 * Halaman pengganti bila sebuah halaman gagal dimuat (menggantikan layar
 * bawaan "This page couldn't load"). Kode kesalahan bisa dicocokkan di Logs Vercel.
 */
export default function HalamanGalat({ error, retry }: { error: unknown; retry: () => void }) {
  const kode = error instanceof Error && "digest" in error ? String(error.digest ?? "") : "";

  useEffect(() => {
    console.error(error);
  }, [error]);

  return (
    <main>
      <Judul>Halaman belum bisa dibuka</Judul>
      <Pesan jenis="galat">
        Terjadi kesalahan saat memuat halaman ini. Coba lagi, atau kembali ke Beranda.
        {kode ? ` Bila terus terjadi, sampaikan kode ini kepada Admin: ${kode}` : ""}
      </Pesan>
      <div className="mt-4 flex flex-wrap gap-2">
        <Tombol type="button" onClick={() => retry()}>
          Coba lagi
        </Tombol>
        {/* Tautan biasa (muat ulang penuh), supaya halaman benar-benar dimuat bersih. */}
        <a
          href="/beranda"
          className="inline-flex min-h-11 items-center rounded-lg border border-black/15 px-4 py-2 font-medium hover:bg-black/5 dark:border-white/20 dark:hover:bg-white/10"
        >
          Ke Beranda
        </a>
      </div>
    </main>
  );
}
