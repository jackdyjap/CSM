"use client";

import { useActionState, useState } from "react";
import { simpanAlasan } from "@/app/kelompok/[id]/pertemuan/aksi";
import type { HasilAksi } from "@/lib/hasil";
import { PILIHAN_ALASAN, type Alasan } from "@/lib/pertemuan";
import { Tombol } from "./ui";

/** Alasan tidak hadir untuk satu anggota: pilihan cepat + catatan singkat. */
export function FormAlasan({
  kelompokId,
  pertemuanId,
  anggotaId,
  nama,
  alasanAwal,
  catatanAwal,
}: {
  kelompokId: string;
  pertemuanId: string;
  anggotaId: string;
  nama: string;
  alasanAwal: Alasan | null;
  catatanAwal: string | null;
}) {
  const [alasan, setAlasan] = useState<string>(alasanAwal ?? "");
  const [catatan, setCatatan] = useState(catatanAwal ?? "");
  const [hasil, jalankan, sedangProses] = useActionState<HasilAksi, FormData>(
    simpanAlasan.bind(null, kelompokId, pertemuanId, anggotaId),
    {},
  );
  const berubah = alasan !== (alasanAwal ?? "") || catatan !== (catatanAwal ?? "");

  return (
    <form action={jalankan} className="py-3">
      <fieldset>
        <legend className="mb-2 font-semibold">{nama}</legend>
        <input type="hidden" name="alasan" value={alasan} />
        <div className="mb-2 flex flex-wrap gap-2">
          {Object.entries(PILIHAN_ALASAN).map(([k, label]) => (
            <button
              key={k}
              type="button"
              aria-pressed={alasan === k}
              onClick={() => setAlasan(alasan === k ? "" : k)}
              className={`min-h-10 rounded-full border px-3 text-sm ${
                alasan === k
                  ? "border-utama bg-utama text-white dark:text-black"
                  : "border-black/15 hover:bg-black/5 dark:border-white/20 dark:hover:bg-white/10"
              }`}
            >
              {label}
            </button>
          ))}
        </div>
        <label className="mb-2 block">
          <span className="sr-only">Catatan untuk {nama}, hanya terlihat oleh pengurus</span>
          <input
            name="alasan_catatan"
            value={catatan}
            onChange={(e) => setCatatan(e.target.value)}
            maxLength={500}
            placeholder="Catatan (opsional)"
            className="min-h-11 w-full rounded-lg border border-black/20 bg-white px-3 py-2 text-base dark:border-white/20 dark:bg-black/30"
          />
        </label>
      </fieldset>
      <div className="flex items-center gap-3">
        <Tombol type="submit" jenis="biasa" disabled={sedangProses || !berubah}>
          {sedangProses ? "Menyimpan…" : "Simpan"}
        </Tombol>
        {hasil.galat ? (
          <span role="alert" className="text-sm text-red-700 dark:text-red-400">
            {hasil.galat}
          </span>
        ) : !berubah && hasil.sukses ? (
          <span role="status" className="text-sm text-green-700 dark:text-green-400">
            {hasil.sukses}
          </span>
        ) : null}
      </div>
    </form>
  );
}
