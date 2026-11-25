"use client";

import { useState } from "react";
import { BATAS_USIA_WALI, TAHUN_LAHIR_MIN, tahunIni, usiaDariTahun } from "@/lib/profil";
import { Isian } from "./ui";

/**
 * Tahun lahir dengan usia kira-kira (keputusan 46). Untuk anggota berusia
 * 18 tahun ke bawah, isian orang tua/wali muncul, tetapi TIDAK wajib.
 */
export function IsianLahir({
  tahunAwal,
  waliNamaAwal = null,
  waliHubunganAwal = null,
  denganWali = true,
}: {
  tahunAwal: number | null;
  waliNamaAwal?: string | null;
  waliHubunganAwal?: string | null;
  /** Profil staf tidak punya isian wali. */
  denganWali?: boolean;
}) {
  const [tahun, setTahun] = useState(tahunAwal ? String(tahunAwal) : "");
  const sekarang = tahunIni();
  const angka = /^\d{4}$/.test(tahun) ? Number(tahun) : null;
  const usia = angka && angka >= TAHUN_LAHIR_MIN && angka <= sekarang ? usiaDariTahun(angka, sekarang) : null;
  const tampilWali = denganWali && usia !== null && usia <= BATAS_USIA_WALI;

  return (
    <>
      <Isian
        label="Tahun lahir"
        name="tahun_lahir"
        type="number"
        inputMode="numeric"
        min={TAHUN_LAHIR_MIN}
        max={sekarang}
        placeholder="Contoh: 1990"
        value={tahun}
        onChange={(e) => setTahun(e.target.value)}
        keterangan={usia !== null ? `Usia sekitar ${usia} tahun` : "Cukup tahunnya saja (4 angka)."}
      />
      {tampilWali ? (
        <div className="mb-3 rounded-lg border border-amber-600/40 p-3">
          <p className="mb-2 text-sm">
            Untuk anggota 18 tahun ke bawah, catat nama orang tua/wali bila ada (tidak wajib). Pastikan orang
            tua/wali sudah setuju datanya dicatat.
          </p>
          <Isian label="Nama orang tua/wali (tidak wajib)" name="wali_nama" defaultValue={waliNamaAwal ?? ""} />
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
