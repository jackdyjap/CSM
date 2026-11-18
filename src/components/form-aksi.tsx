"use client";

import { useRouter } from "next/navigation";
import { startTransition, useActionState, useEffect, type ReactNode } from "react";
import type { AksiForm, HasilAksi } from "@/lib/hasil";
import { BagikanTautan } from "./bagikan-tautan";
import { adaLayarSebelumnya } from "./pelacak-riwayat";
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
  tanpaReset = false,
  konfirmasi,
  kembali,
}: {
  aksi: AksiForm;
  tombol: string;
  jenisTombol?: "utama" | "biasa" | "bahaya";
  children?: ReactNode;
  className?: string;
  /**
   * Jangan kosongkan isian setelah berhasil (untuk formulir ubah data, mis. profil).
   * Bawaan React mengosongkan formulir setelah aksi selesai.
   */
  tanpaReset?: boolean;
  /** Pertanyaan yang harus dijawab "OK" sebelum aksi dijalankan. */
  konfirmasi?: string;
  /**
   * Setelah berhasil disimpan, kembali otomatis ke layar sebelumnya (keputusan 33).
   * Nilainya = halaman tujuan bila tidak ada layar sebelumnya (mis. dibuka dari tautan).
   */
  kembali?: string;
}) {
  const [hasil, jalankan, sedangProses] = useActionState<HasilAksi, FormData>(aksi, {});
  const router = useRouter();

  useEffect(() => {
    if (!kembali || !hasil.sukses || hasil.tautan) return;
    // Pesan "tersimpan" sempat terbaca sebentar, lalu kembali.
    const waktu = setTimeout(() => {
      if (adaLayarSebelumnya()) router.back();
      else router.push(kembali);
    }, 1000);
    return () => clearTimeout(waktu);
  }, [hasil, kembali, router]);

  return (
    <form
      action={tanpaReset ? undefined : jalankan}
      onSubmit={(e) => {
        if (konfirmasi && !confirm(konfirmasi)) {
          e.preventDefault();
          return;
        }
        if (tanpaReset) {
          e.preventDefault();
          const data = new FormData(e.currentTarget);
          startTransition(() => jalankan(data));
        }
      }}
      className={className}
    >
      {children}
      {hasil.galat ? <Pesan jenis="galat">{hasil.galat}</Pesan> : null}
      {hasil.sukses ? (
        <Pesan jenis="sukses">
          {hasil.sukses}
          {kembali && !hasil.tautan ? " Kembali ke layar sebelumnya…" : ""}
        </Pesan>
      ) : null}
      {hasil.tautan ? <BagikanTautan tautan={hasil.tautan} teksWa={hasil.teksWa} /> : null}
      <Tombol type="submit" jenis={jenisTombol} disabled={sedangProses}>
        {sedangProses ? "Memproses…" : tombol}
      </Tombol>
    </form>
  );
}
