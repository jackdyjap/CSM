import type { ReactNode } from "react";
import Link from "next/link";
import { labelPeruntukan, type BarisTraining } from "@/lib/training";

/**
 * Satu butir daftar bahan training (halaman pengguna dan Admin): hanya judul
 * dan jenis. Ketuk untuk rincian dan tombol Buka/Putar; `aksi` = tombol tambahan
 * (Admin: Hapus), `children` = isi tambahan di bawahnya (Admin: lipatan Ubah).
 */
export function ButirTraining({
  b,
  admin,
  aksi,
  children,
}: {
  b: BarisTraining;
  admin?: boolean;
  aksi?: ReactNode;
  children?: ReactNode;
}) {
  const jenis = b.jenis === "pdf" ? "PDF" : "Video";
  const cari = [b.judul, b.keterangan, jenis, admin ? labelPeruntukan(b) : ""].filter(Boolean).join(" ").toLowerCase();
  return (
    <li data-cari={cari}>
      <details className="group/butir">
        <summary className="-mx-2 flex min-h-11 cursor-pointer list-none items-center gap-2 rounded-lg px-2 py-1 hover:bg-black/5 dark:hover:bg-white/10 [&::-webkit-details-marker]:hidden">
          <span className="min-w-0 flex-1">
            <span className="block font-medium">{b.judul}</span>
            <span className="block text-xs opacity-70">
              {jenis}
              {admin ? ` · untuk ${labelPeruntukan(b)}` : ""}
            </span>
          </span>
          <span className="text-sm opacity-60" aria-hidden>
            <span className="group-open/butir:hidden">▾</span>
            <span className="hidden group-open/butir:inline">▴</span>
          </span>
        </summary>
        <div className="mb-3 ml-1 mt-1 space-y-2 border-l-2 border-black/10 pl-3 dark:border-white/15">
          {b.keterangan ? <p className="text-sm whitespace-pre-wrap">{b.keterangan}</p> : null}
          <div className="flex flex-wrap items-start gap-2">
            <Link
              href={`/training/${b.id}`}
              className="inline-flex min-h-11 items-center rounded-lg bg-utama px-4 py-2 font-medium text-white hover:opacity-90 dark:text-black"
            >
              {b.jenis === "pdf" ? "Buka" : "Putar"}
            </Link>
            {aksi}
          </div>
          {children}
        </div>
      </details>
    </li>
  );
}
