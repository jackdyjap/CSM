"use client";

import { useActionState, type ReactNode } from "react";
import type { AksiForm, HasilAksi } from "@/lib/hasil";
import { BagikanTautan } from "./bagikan-tautan";
import { Pesan, Tombol } from "./ui";

/**
 * Formulir yang menjalankan aksi di server, lalu menampilkan hasilnya
 * (pesan galat, pesan sukses, atau tautan yang perlu dibagikan).
 */
export function FormAksi({
  aksi,
  tombol,
  jenisTombol = "utama",
  children,
  className = "",
}: {
  aksi: AksiForm;
  tombol: string;
  jenisTombol?: "utama" | "biasa" | "bahaya";
  children?: ReactNode;
  className?: string;
}) {
  const [hasil, jalankan, sedangProses] = useActionState<HasilAksi, FormData>(aksi, {});

  return (
    <form action={jalankan} className={className}>
      {children}
      {hasil.galat ? <Pesan jenis="galat">{hasil.galat}</Pesan> : null}
      {hasil.sukses ? <Pesan jenis="sukses">{hasil.sukses}</Pesan> : null}
      {hasil.tautan ? <BagikanTautan tautan={hasil.tautan} teksWa={hasil.teksWa} /> : null}
      <Tombol type="submit" jenis={jenisTombol} disabled={sedangProses}>
        {sedangProses ? "Memproses…" : tombol}
      </Tombol>
    </form>
  );
}
