"use client";

import { useState, useTransition } from "react";
import { setelStatus } from "@/app/kelompok/[id]/proyek/aksi";
import { PILIHAN_STATUS_PROYEK, type StatusProyek } from "@/lib/pilihan-fase5";
import { Tombol } from "./ui";

const WARNA: Record<StatusProyek, string> = {
  belum: "border-black/30 bg-black/10 dark:border-white/30 dark:bg-white/15",
  sedang: "border-amber-600 bg-amber-100 text-amber-900 dark:border-amber-400 dark:bg-amber-900 dark:text-amber-100",
  selesai: "border-green-700 bg-green-700 text-white dark:border-green-400 dark:bg-green-400 dark:text-black",
  tidak_dikerjakan: "border-red-700 bg-red-50 text-red-800 dark:border-red-400 dark:bg-red-950 dark:text-red-200",
};

/**
 * Status proyek satu anggota. Ketukan status langsung tersimpan;
 * keterangan disimpan dengan tombol Simpan.
 */
export function StatusProyekAnggota({
  kelompokId,
  proyekId,
  anggotaId,
  nama,
  statusAwal,
  keteranganAwal,
}: {
  kelompokId: string;
  proyekId: string;
  anggotaId: string;
  nama: string;
  statusAwal: StatusProyek;
  keteranganAwal: string | null;
}) {
  const [status, setStatus] = useState<StatusProyek>(statusAwal);
  const [keterangan, setKeterangan] = useState(keteranganAwal ?? "");
  const [tersimpan, setTersimpan] = useState(keteranganAwal ?? "");
  const [pesan, setPesan] = useState<{ galat?: string; sukses?: string }>({});
  const [sedangProses, mulai] = useTransition();

  function pilih(baru: StatusProyek) {
    if (baru === status || sedangProses) return;
    const lama = status;
    setStatus(baru);
    setPesan({});
    mulai(async () => {
      let h;
      try {
        h = await setelStatus(kelompokId, proyekId, anggotaId, baru);
      } catch {
        h = { galat: "Koneksi terputus. Coba lagi." };
      }
      if (h.galat) {
        setStatus(lama);
        setPesan({ galat: h.galat });
      }
    });
  }

  function simpanKeterangan() {
    setPesan({});
    mulai(async () => {
      const h = await setelStatus(kelompokId, proyekId, anggotaId, status, keterangan);
      if (!h.galat) setTersimpan(keterangan);
      setPesan(h);
    });
  }

  return (
    <div className="py-3">
      <p className="mb-2 font-semibold">{nama}</p>
      <div className="mb-2 flex flex-wrap gap-2" role="group" aria-label={`Status ${nama}`}>
        {(Object.keys(PILIHAN_STATUS_PROYEK) as StatusProyek[]).map((k) => (
          <button
            key={k}
            type="button"
            aria-pressed={status === k}
            onClick={() => pilih(k)}
            className={`min-h-10 rounded-full border px-3 text-sm ${
              status === k ? `${WARNA[k]} font-semibold` : "border-black/15 hover:bg-black/5 dark:border-white/20 dark:hover:bg-white/10"
            }`}
          >
            {PILIHAN_STATUS_PROYEK[k]}
          </button>
        ))}
      </div>
      <div className="flex gap-2">
        <label className="flex-1">
          <span className="sr-only">Keterangan untuk {nama}</span>
          <input
            value={keterangan}
            onChange={(e) => setKeterangan(e.target.value)}
            maxLength={500}
            placeholder="Keterangan (opsional)"
            className="min-h-11 w-full rounded-lg border border-black/20 bg-white px-3 py-2 text-base dark:border-white/20 dark:bg-black/30"
          />
        </label>
        {keterangan !== tersimpan ? (
          <Tombol type="button" jenis="biasa" onClick={simpanKeterangan} disabled={sedangProses}>
            Simpan
          </Tombol>
        ) : null}
      </div>
      {pesan.galat ? (
        <p role="alert" className="mt-1 text-sm text-red-700 dark:text-red-400">
          {pesan.galat}
        </p>
      ) : pesan.sukses ? (
        <p role="status" className="mt-1 text-sm text-green-700 dark:text-green-400">
          {pesan.sukses}
        </p>
      ) : null}
    </div>
  );
}
