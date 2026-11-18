"use client";

import { useState, type ComponentProps } from "react";

/**
 * Isian kata sandi dengan tombol ikon mata untuk menampilkan/menyembunyikan
 * yang diketik, supaya tidak salah ketik. Tampilannya sama dengan Isian.
 */
export function IsianSandi({
  label,
  keterangan,
  ...props
}: Omit<ComponentProps<"input">, "type"> & { label: string; keterangan?: string }) {
  const [tampil, setTampil] = useState(false);

  return (
    <label className="mb-3 block">
      <span className="mb-1 block text-sm font-medium">{label}</span>
      <span className="relative block">
        <input
          className="min-h-11 w-full rounded-lg border border-black/20 bg-white py-2 pr-12 pl-3 text-base dark:border-white/20 dark:bg-black/30"
          type={tampil ? "text" : "password"}
          autoCapitalize="none"
          autoCorrect="off"
          spellCheck={false}
          {...props}
        />
        <button
          type="button"
          onClick={() => setTampil((t) => !t)}
          aria-label={tampil ? "Sembunyikan kata sandi" : "Tampilkan kata sandi"}
          aria-pressed={tampil}
          title={tampil ? "Sembunyikan kata sandi" : "Tampilkan kata sandi"}
          className="absolute inset-y-0 right-0 flex w-11 items-center justify-center rounded-r-lg opacity-70 hover:opacity-100"
        >
          {tampil ? <IkonMataTertutup /> : <IkonMata />}
        </button>
      </span>
      {keterangan ? <span className="mt-1 block text-xs opacity-70">{keterangan}</span> : null}
    </label>
  );
}

function IkonMata() {
  return (
    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" aria-hidden>
      <path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7S2 12 2 12z" />
      <circle cx="12" cy="12" r="3" />
    </svg>
  );
}

function IkonMataTertutup() {
  return (
    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" aria-hidden>
      <path d="M10.6 5.1A10.9 10.9 0 0 1 12 5c6.5 0 10 7 10 7a17.6 17.6 0 0 1-3.2 4.2M6.6 6.6C3.9 8.4 2 12 2 12s3.5 7 10 7a9.8 9.8 0 0 0 5.4-1.6" />
      <path d="M9.9 9.9a3 3 0 0 0 4.2 4.2" />
      <path d="M3 3l18 18" />
    </svg>
  );
}
