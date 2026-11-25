"use client";

import { useState, useTransition } from "react";
import { ambilWilayah, type Wilayah } from "@/lib/aksi-profil";
import { Pilihan } from "./ui";

const TINGKAT = [
  { nama: "provinsi_kode", label: "Provinsi" },
  { nama: "kota_kode", label: "Kota/Kabupaten" },
] as const;

/**
 * Dua menu pilihan wilayah yang saling bergantung: provinsi lalu kota/kabupaten
 * (keputusan 46: tanpa kecamatan dan kelurahan).
 * Daftar tingkat berikutnya baru diambil setelah tingkat di atasnya dipilih,
 * supaya ringan di koneksi lambat.
 */
export function PilihWilayah({
  awal,
  daftarAwal,
}: {
  /** Kode yang sudah tersimpan: [provinsi, kota/kabupaten]. */
  awal: (string | null)[];
  /** Daftar pilihan untuk tiap tingkat sesuai kode yang tersimpan. */
  daftarAwal: Wilayah[][];
}) {
  const [kode, setKode] = useState<string[]>(TINGKAT.map((_, i) => awal[i] ?? ""));
  const [daftar, setDaftar] = useState<Wilayah[][]>(TINGKAT.map((_, i) => daftarAwal[i] ?? []));
  const [memuat, setMemuat] = useState<number | null>(null);
  const [, mulai] = useTransition();

  function pilih(tingkat: number, nilai: string) {
    // Kosongkan semua tingkat di bawahnya.
    const kodeBaru = kode.map((k, i) => (i < tingkat ? k : i === tingkat ? nilai : ""));
    setKode(kodeBaru);
    setDaftar((d) => d.map((x, i) => (i <= tingkat ? x : [])));

    const berikut = tingkat + 1;
    if (!nilai || berikut >= TINGKAT.length) return;
    setMemuat(berikut);
    mulai(async () => {
      const hasil = await ambilWilayah(nilai);
      setDaftar((d) => d.map((x, i) => (i === berikut ? hasil : x)));
      setMemuat(null);
    });
  }

  return (
    <fieldset className="mb-1">
      <legend className="mb-2 text-sm font-medium">Wilayah tempat tinggal</legend>
      {TINGKAT.map((t, i) => {
        const nonaktif = i > 0 && !kode[i - 1];
        return (
          <Pilihan
            key={t.nama}
            label={t.label}
            name={t.nama}
            value={kode[i]}
            onChange={(e) => pilih(i, e.target.value)}
            disabled={nonaktif || memuat === i}
          >
            <option value="">
              {memuat === i ? "Memuat…" : nonaktif ? `Pilih ${TINGKAT[i - 1].label.toLowerCase()} dulu` : "— Pilih —"}
            </option>
            {daftar[i].map((w) => (
              <option key={w.kode} value={w.kode}>
                {w.nama}
              </option>
            ))}
          </Pilihan>
        );
      })}
      {daftar[0].length === 0 ? (
        <p className="mb-3 text-xs opacity-70">
          Daftar wilayah belum tersedia. Admin perlu menjalankan data wilayah di Supabase.
        </p>
      ) : null}
    </fieldset>
  );
}
