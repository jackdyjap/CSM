"use client";

import Link from "next/link";
import { useMemo, useState } from "react";
import type { KelompokDaftar } from "@/lib/akun-admin";

/**
 * Daftar akun ringkas per tim → kelompok, dengan kotak pencarian yang
 * langsung menyaring saat mengetik. Tindakan ada di halaman detail (Pilih).
 */
export function DaftarAkun({ daftar, jumlah }: { daftar: KelompokDaftar[]; jumlah: number }) {
  const [cari, setCari] = useState("");
  const kata = cari.trim().toLowerCase().split(/\s+/).filter(Boolean);

  const tersaring = useMemo(() => {
    if (kata.length === 0) return daftar;
    return daftar
      .map((g) => ({
        ...g,
        bagian: g.bagian
          .map((b) => ({ ...b, akun: b.akun.filter((a) => kata.every((k) => a.cari.includes(k))) }))
          .filter((b) => b.akun.length > 0),
      }))
      .filter((g) => g.bagian.length > 0);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [daftar, cari]);

  const jumlahCocok = new Set(tersaring.flatMap((g) => g.bagian.flatMap((b) => b.akun.map((a) => a.id)))).size;

  return (
    <div>
      <label className="mb-3 block">
        <span className="sr-only">Cari akun</span>
        <input
          type="search"
          value={cari}
          onChange={(e) => setCari(e.target.value)}
          placeholder="Cari nama, cara masuk, tim, kelompok…"
          aria-label="Cari akun: nama, nama pengguna, email, nomor HP, tim, atau kelompok"
          autoComplete="off"
          className="min-h-11 w-full rounded-lg border border-black/20 bg-white px-3 py-2 text-base dark:border-white/20 dark:bg-black/30"
        />
      </label>
      <p className="mb-3 text-xs opacity-70" aria-live="polite">
        {kata.length ? `${jumlahCocok} dari ${jumlah} akun cocok.` : `${jumlah} akun.`}
      </p>

      {tersaring.length === 0 ? (
        <p className="py-4 text-sm opacity-70">Tidak ada akun yang cocok dengan &ldquo;{cari.trim()}&rdquo;.</p>
      ) : (
        <div className="space-y-5">
          {tersaring.map((g) => (
            <section key={g.kunci}>
              <h3 className="mb-1 border-b border-black/15 pb-1 font-semibold dark:border-white/15">{g.judul}</h3>
              {g.bagian.map((b, i) => (
                <div key={b.judul ?? i} className="mt-2">
                  {b.judul ? <h4 className="mb-1 pl-1 text-sm font-medium opacity-80">{b.judul}</h4> : null}
                  <ul className="divide-y divide-black/10 dark:divide-white/10">
                    {b.akun.map((a) => (
                      <li key={a.id} className={`flex items-center gap-3 py-2 ${b.judul ? "pl-3" : "pl-1"}`}>
                        <span className="min-w-0 flex-1">
                          <span className="block truncate font-medium">{a.nama}</span>
                          <span className="block truncate text-xs opacity-70">
                            {a.login}
                            {a.label ? ` · ${a.label}` : ""}
                          </span>
                        </span>
                        <Link
                          href={`/admin/akun/${a.id}`}
                          className="inline-flex min-h-10 flex-none items-center rounded-lg border border-black/15 px-3 text-sm font-medium hover:bg-black/5 active:bg-black/10 dark:border-white/20 dark:hover:bg-white/10"
                          aria-label={`Pilih ${a.nama}`}
                        >
                          Pilih
                        </Link>
                      </li>
                    ))}
                  </ul>
                </div>
              ))}
            </section>
          ))}
        </div>
      )}
    </div>
  );
}
