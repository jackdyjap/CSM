"use client";

import { useState, useTransition } from "react";
import { tandaiHadir } from "@/app/kelompok/[id]/pertemuan/aksi";
import { Pesan } from "./ui";

export type BarisHadir = { id: string; nama: string; hadir: boolean; aktif: boolean };

/**
 * Mode pertemuan: ketuk nama untuk menandai hadir. Setiap ketukan
 * langsung tersimpan; tampilan berubah seketika dan dikembalikan bila gagal.
 */
export function DaftarHadir({
  kelompokId,
  pertemuanId,
  anggota,
}: {
  kelompokId: string;
  pertemuanId: string;
  anggota: BarisHadir[];
}) {
  const [hadir, setHadir] = useState<Record<string, boolean>>(() =>
    Object.fromEntries(anggota.map((a) => [a.id, a.hadir])),
  );
  const [menyimpan, setMenyimpan] = useState<Record<string, boolean>>({});
  const [galat, setGalat] = useState<string | null>(null);
  const [, mulai] = useTransition();

  function ketuk(id: string) {
    if (menyimpan[id]) return;
    const baru = !hadir[id];
    setGalat(null);
    setHadir((h) => ({ ...h, [id]: baru }));
    setMenyimpan((m) => ({ ...m, [id]: true }));
    mulai(async () => {
      let pesan: string | undefined;
      try {
        pesan = (await tandaiHadir(kelompokId, pertemuanId, id, baru)).galat;
      } catch {
        pesan = "Koneksi terputus. Ketuk sekali lagi.";
      }
      if (pesan) {
        setHadir((h) => ({ ...h, [id]: !baru }));
        setGalat(pesan);
      }
      setMenyimpan((m) => ({ ...m, [id]: false }));
    });
  }

  const aktif = anggota.filter((a) => a.aktif);
  const tidakAktif = anggota.filter((a) => !a.aktif);
  const jumlahHadir = aktif.filter((a) => hadir[a.id]).length;
  const sedangMenyimpan = Object.values(menyimpan).some(Boolean);

  const tombol = (a: BarisHadir) => (
    <li key={a.id}>
      <button
        type="button"
        aria-pressed={hadir[a.id]}
        onClick={() => ketuk(a.id)}
        className={`flex min-h-14 w-full items-center gap-3 rounded-xl border px-4 py-2 text-left text-lg transition-colors ${
          hadir[a.id]
            ? "border-green-700/50 bg-green-50 dark:border-green-400/40 dark:bg-green-950"
            : "border-black/15 bg-white dark:border-white/15 dark:bg-white/5"
        }`}
      >
        <span
          aria-hidden
          className={`flex h-7 w-7 flex-none items-center justify-center rounded-md border-2 text-base font-bold ${
            hadir[a.id]
              ? "border-green-700 bg-green-700 text-white dark:border-green-400 dark:bg-green-400 dark:text-black"
              : "border-black/30 dark:border-white/30"
          }`}
        >
          {hadir[a.id] ? "✓" : ""}
        </span>
        <span className="flex-1">{a.nama}</span>
        <span className="text-sm opacity-70">{menyimpan[a.id] ? "menyimpan…" : hadir[a.id] ? "Hadir" : ""}</span>
      </button>
    </li>
  );

  return (
    <div>
      <div
        className="sticky top-0 z-10 -mx-4 mb-3 flex items-center justify-between bg-white/95 px-4 py-2 backdrop-blur dark:bg-[#1d2024]/95"
        aria-live="polite"
      >
        <span className="text-lg font-semibold">
          Hadir {jumlahHadir} dari {aktif.length}
        </span>
        <span className="text-sm opacity-70">{sedangMenyimpan ? "Menyimpan…" : "Tersimpan otomatis"}</span>
      </div>
      {galat ? <Pesan jenis="galat">{galat}</Pesan> : null}
      {aktif.length === 0 ? (
        <p className="opacity-70">Belum ada anggota aktif. Tambahkan anggota di halaman kelompok.</p>
      ) : (
        <ul className="space-y-2">{aktif.map(tombol)}</ul>
      )}
      {tidakAktif.length > 0 ? (
        <details className="mt-4">
          <summary className="cursor-pointer py-2 text-sm opacity-80">
            Anggota tidak aktif ({tidakAktif.length}). Bila hadir, otomatis aktif kembali.
          </summary>
          <ul className="mt-2 space-y-2">{tidakAktif.map(tombol)}</ul>
        </details>
      ) : null}
    </div>
  );
}
