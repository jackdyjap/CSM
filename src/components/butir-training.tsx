import type { ReactNode } from "react";
import Link from "next/link";
import { labelPeruntukan, type BarisTraining } from "@/lib/training";

/** Satu butir daftar bahan training (dipakai halaman pengguna dan Admin). */
export function ButirTraining({ b, admin, children }: { b: BarisTraining; admin?: boolean; children?: ReactNode }) {
  const jenis = b.jenis === "pdf" ? "PDF" : "Video";
  const cari = [b.judul, b.keterangan, jenis, admin ? labelPeruntukan(b) : ""].filter(Boolean).join(" ").toLowerCase();
  return (
    <li data-cari={cari} className="py-3">
      <div className="flex items-start gap-3">
        <span className="min-w-0 flex-1">
          <span className="block font-medium">{b.judul}</span>
          <span className="block text-xs opacity-70">
            {jenis}
            {admin ? ` · untuk ${labelPeruntukan(b)}` : ""}
          </span>
          {b.keterangan ? <span className="mt-1 block text-sm whitespace-pre-wrap opacity-90">{b.keterangan}</span> : null}
        </span>
        <Link
          href={`/training/${b.id}`}
          className="inline-flex min-h-10 flex-none items-center rounded-lg border border-black/15 px-3 text-sm font-medium hover:bg-black/5 active:scale-[0.98] dark:border-white/20 dark:hover:bg-white/10"
        >
          {b.jenis === "pdf" ? "Buka" : "Putar"}
        </Link>
      </div>
      {children}
    </li>
  );
}
