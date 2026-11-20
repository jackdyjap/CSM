import Link from "next/link";
import type { ComponentProps, ReactNode } from "react";

// Komponen tampilan sederhana yang dipakai di semua halaman.

export function Judul({ children, kecil }: { children: ReactNode; kecil?: ReactNode }) {
  return (
    <header className="mb-5">
      <h1 className="text-2xl font-bold">{children}</h1>
      {kecil ? <p className="mt-1 text-sm opacity-70">{kecil}</p> : null}
    </header>
  );
}

export function Kotak({ children, judul }: { children: ReactNode; judul?: ReactNode }) {
  return (
    <section className="mb-4 rounded-xl border border-black/10 bg-white p-4 shadow-sm dark:border-white/10 dark:bg-white/5">
      {judul ? <h2 className="mb-3 text-lg font-semibold">{judul}</h2> : null}
      {children}
    </section>
  );
}

const gayaTombol = {
  utama: "bg-utama text-white hover:opacity-90",
  biasa: "border border-black/15 bg-transparent hover:bg-black/5 dark:border-white/20 dark:hover:bg-white/10",
  bahaya: "border border-red-600/40 text-red-700 hover:bg-red-50 dark:text-red-400 dark:hover:bg-red-950",
};

export function Tombol({
  jenis = "utama",
  className = "",
  ...props
}: ComponentProps<"button"> & { jenis?: keyof typeof gayaTombol }) {
  return (
    <button
      className={`min-h-11 rounded-lg px-4 py-2 font-medium transition-transform duration-75 active:scale-[0.97] active:opacity-80 disabled:opacity-50 disabled:active:scale-100 ${gayaTombol[jenis]} ${className}`}
      {...props}
    />
  );
}

export function TautanTombol({
  jenis = "biasa",
  className = "",
  ...props
}: ComponentProps<typeof Link> & { jenis?: keyof typeof gayaTombol }) {
  return (
    <Link
      className={`inline-flex min-h-11 items-center rounded-lg px-4 py-2 font-medium transition-transform duration-75 active:scale-[0.97] active:opacity-80 ${gayaTombol[jenis]} ${className}`}
      {...props}
    />
  );
}

export function Isian({
  label,
  keterangan,
  ...props
}: ComponentProps<"input"> & { label: string; keterangan?: string }) {
  return (
    <label className="mb-3 block">
      <span className="mb-1 block text-sm font-medium">{label}</span>
      <input
        className="min-h-11 w-full rounded-lg border border-black/20 bg-white px-3 py-2 text-base dark:border-white/20 dark:bg-black/30"
        {...props}
      />
      {keterangan ? <span className="mt-1 block text-xs opacity-70">{keterangan}</span> : null}
    </label>
  );
}

export function IsianPanjang({
  label,
  ...props
}: ComponentProps<"textarea"> & { label: string }) {
  return (
    <label className="mb-3 block">
      <span className="mb-1 block text-sm font-medium">{label}</span>
      <textarea
        rows={3}
        className="w-full rounded-lg border border-black/20 bg-white px-3 py-2 text-base dark:border-white/20 dark:bg-black/30"
        {...props}
      />
    </label>
  );
}

export function Pilihan({
  label,
  children,
  ...props
}: ComponentProps<"select"> & { label: string }) {
  return (
    <label className="mb-3 block">
      <span className="mb-1 block text-sm font-medium">{label}</span>
      <select
        className="min-h-11 w-full rounded-lg border border-black/20 bg-white px-3 py-2 text-base dark:border-white/20 dark:bg-black/30"
        {...props}
      >
        {children}
      </select>
    </label>
  );
}

export function Pesan({ jenis, children }: { jenis: "galat" | "sukses" | "info"; children: ReactNode }) {
  const gaya = {
    galat: "border-red-600/30 bg-red-50 text-red-800 dark:bg-red-950 dark:text-red-200",
    sukses: "border-green-600/30 bg-green-50 text-green-800 dark:bg-green-950 dark:text-green-200",
    info: "border-blue-600/30 bg-blue-50 text-blue-900 dark:bg-blue-950 dark:text-blue-100",
  }[jenis];
  return (
    <p role={jenis === "galat" ? "alert" : "status"} className={`mb-3 rounded-lg border px-3 py-2 text-sm ${gaya}`}>
      {children}
    </p>
  );
}

/** Lipatan berisi alat koreksi data, tertutup secara bawaan supaya layar tetap rapi. */
export function Lipatan({ judul, children }: { judul: string; children: ReactNode }) {
  return (
    <details className="group mt-3 rounded-lg border border-black/10 dark:border-white/10">
      <summary className="flex min-h-11 cursor-pointer list-none items-center justify-between px-3 text-sm font-medium">
        {judul}
        <span aria-hidden className="opacity-60 transition-transform group-open:rotate-180">
          ▾
        </span>
      </summary>
      <div className="space-y-4 border-t border-black/10 p-3 dark:border-white/10">{children}</div>
    </details>
  );
}
