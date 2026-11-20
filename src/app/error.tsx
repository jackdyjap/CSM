"use client";

import { useEffect, useSyncExternalStore } from "react";
import { Judul, Pesan, Tombol } from "@/components/ui";

/**
 * Halaman pengganti bila sebuah halaman gagal dimuat (menggantikan layar
 * bawaan "This page couldn't load"). Kode kesalahan bisa dicocokkan di Logs Vercel.
 */
export default function HalamanGalat({ error, retry }: { error: unknown; retry: () => void }) {
  const kode = error instanceof Error && "digest" in error ? String(error.digest ?? "") : "";
  // Galat dari HP (bukan dari server) tidak punya kode dan tidak tercatat di Logs
  // Vercel; pesannya tidak memuat data rahasia, jadi ditampilkan untuk dilaporkan.
  const detail = kode
    ? ""
    : error instanceof Error
      ? `${error.name}: ${error.message}`.slice(0, 300)
      : String(error).slice(0, 300);

  // Jenis peramban/HP, hanya dibaca di HP (kosong saat dibuat di server).
  const peramban = useSyncExternalStore(
    () => () => {},
    () => navigator.userAgent,
    () => "",
  );
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
      {detail ? (
        <p className="mt-3 rounded-lg bg-black/5 p-2 font-mono text-xs break-words opacity-80 dark:bg-white/10">
          Detail untuk Admin: {detail}
          {peramban ? ` · ${peramban}` : ""}
        </p>
      ) : null}
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
