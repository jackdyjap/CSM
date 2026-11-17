"use client";

import { useState } from "react";
import { hariIniWib, hitungUsia, USIA_DEWASA } from "@/lib/profil";
import { Isian } from "./ui";

/**
 * Tanggal lahir dengan usia otomatis. Bila usia di bawah 18 tahun,
 * isian persetujuan orang tua/wali muncul (diwajibkan database).
 */
export function IsianLahir({
  tanggalAwal,
  waliNamaAwal,
  waliHubunganAwal,
}: {
  tanggalAwal: string | null;
  waliNamaAwal: string | null;
  waliHubunganAwal: string | null;
}) {
  const [tanggal, setTanggal] = useState(tanggalAwal ?? "");
  const hariIni = hariIniWib();
  const usia = tanggal ? hitungUsia(tanggal, hariIni) : null;
  const perluWali = usia !== null && usia >= 0 && usia < USIA_DEWASA;

  return (
    <>
      <Isian
        label="Tanggal lahir"
        name="tanggal_lahir"
        type="date"
        max={hariIni}
        min="1900-01-02"
        value={tanggal}
        onChange={(e) => setTanggal(e.target.value)}
        keterangan={usia !== null && usia >= 0 ? `Usia: ${usia} tahun` : undefined}
      />
      {perluWali ? (
        <div className="mb-3 rounded-lg border border-amber-600/40 p-3">
          <p className="mb-2 text-sm">
            Anggota di bawah 18 tahun memerlukan persetujuan orang tua atau wali.
          </p>
          <Isian label="Nama orang tua/wali" name="wali_nama" defaultValue={waliNamaAwal ?? ""} required />
          <Isian
            label="Hubungan"
            name="wali_hubungan"
            defaultValue={waliHubunganAwal ?? ""}
            placeholder="Contoh: Ibu, Ayah, Paman"
          />
        </div>
      ) : null}
    </>
  );
}
