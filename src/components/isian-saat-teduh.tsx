"use client";

import { useState } from "react";
import { jumlahAyat, jumlahPasal, KITAB, NAMA_VERSI, tautanBaca, type VersiAlkitab } from "@/lib/alkitab";
import { DURASI_MAKS, TUNTUNAN_MAKS, type CatatanSaatTeduh } from "@/lib/saat-teduh";
import { Isian, IsianPanjang, Pilihan } from "./ui";

const urutan = (n: number) => Array.from({ length: n }, (_, i) => i + 1);

/**
 * Isian formulir Saat Teduh. Pilihan pasal dan ayat menyesuaikan kitab yang
 * dipilih, jadi tidak bisa memilih pasal/ayat yang tidak ada. Teks ayat tidak
 * dimuat (hak cipta); tombol "Baca ayat" membuka alkitab.sabda.org.
 */
export function IsianSaatTeduh({ awal, hariIni }: { awal?: CatatanSaatTeduh; hariIni: string }) {
  const [versi, setVersi] = useState<VersiAlkitab>(awal?.versi ?? "tb");
  const [kitab, setKitab] = useState(awal?.kitab ?? 0);
  const [pasal, setPasal] = useState(awal?.pasal ?? 0);
  const [ayatAwal, setAyatAwal] = useState(awal?.ayat_awal ?? 0);
  const [ayatAkhir, setAyatAkhir] = useState(awal?.ayat_akhir ?? 0);

  const pasalMaks = kitab ? jumlahPasal(kitab) : 0;
  const ayatMaks = kitab && pasal ? jumlahAyat(kitab, pasal) : 0;
  const bacaan = {
    kitab,
    pasal,
    ayat_awal: ayatAwal || ayatAkhir || null,
    ayat_akhir: ayatAkhir || ayatAwal || null,
  };

  return (
    <div>
      <Isian
        label="Tanggal saat teduh"
        name="tanggal"
        type="date"
        defaultValue={awal?.tanggal ?? hariIni}
        max={hariIni}
        required
        keterangan="Boleh tanggal lampau, tidak boleh tanggal yang akan datang."
      />
      <div className="grid grid-cols-2 gap-3">
        <Isian label="Jam mulai" name="jam_mulai" type="time" defaultValue={awal?.jam_mulai.slice(0, 5)} required />
        <Isian
          label="Durasi (menit)"
          name="durasi_menit"
          type="number"
          inputMode="numeric"
          min={1}
          max={DURASI_MAKS}
          defaultValue={awal?.durasi_menit}
          required
        />
      </div>

      <fieldset className="mb-3 rounded-lg border border-black/10 p-3 dark:border-white/10">
        <legend className="px-1 text-sm font-medium">Ayat Alkitab yang dibaca</legend>
        <Pilihan label="Versi" name="versi" value={versi} onChange={(e) => setVersi(e.target.value as VersiAlkitab)}>
          {(Object.keys(NAMA_VERSI) as VersiAlkitab[]).map((v) => (
            <option key={v} value={v}>
              {NAMA_VERSI[v]}
            </option>
          ))}
        </Pilihan>
        <Pilihan
          label="Kitab"
          name="kitab"
          value={kitab || ""}
          required
          onChange={(e) => {
            setKitab(Number(e.target.value));
            setPasal(0);
            setAyatAwal(0);
            setAyatAkhir(0);
          }}
        >
          <option value="" disabled>
            Pilih kitab…
          </option>
          <optgroup label="Perjanjian Lama">
            {KITAB.slice(0, 39).map(([nama], i) => (
              <option key={nama} value={i + 1}>
                {nama}
              </option>
            ))}
          </optgroup>
          <optgroup label="Perjanjian Baru">
            {KITAB.slice(39).map(([nama], i) => (
              <option key={nama} value={i + 40}>
                {nama}
              </option>
            ))}
          </optgroup>
        </Pilihan>
        <Pilihan
          label="Pasal"
          name="pasal"
          value={pasal || ""}
          required
          disabled={!kitab}
          onChange={(e) => {
            setPasal(Number(e.target.value));
            setAyatAwal(0);
            setAyatAkhir(0);
          }}
        >
          <option value="" disabled>
            {kitab ? "Pilih pasal…" : "Pilih kitab dulu"}
          </option>
          {urutan(pasalMaks).map((p) => (
            <option key={p} value={p}>
              {p}
            </option>
          ))}
        </Pilihan>
        <div className="grid grid-cols-2 gap-3">
          <Pilihan
            label="Ayat dari"
            name="ayat_awal"
            value={ayatAwal || ""}
            disabled={!ayatMaks}
            onChange={(e) => {
              const n = Number(e.target.value);
              setAyatAwal(n);
              if (n && ayatAkhir && ayatAkhir < n) setAyatAkhir(n);
            }}
          >
            <option value="">Satu pasal</option>
            {urutan(ayatMaks).map((a) => (
              <option key={a} value={a}>
                {a}
              </option>
            ))}
          </Pilihan>
          <Pilihan
            label="Ayat sampai"
            name="ayat_akhir"
            value={ayatAkhir || ""}
            disabled={!ayatMaks || !ayatAwal}
            onChange={(e) => setAyatAkhir(Number(e.target.value))}
          >
            <option value="">{ayatAwal ? `${ayatAwal} saja` : "-"}</option>
            {urutan(ayatMaks)
              .filter((a) => a > (ayatAwal || 0))
              .map((a) => (
                <option key={a} value={a}>
                  {a}
                </option>
              ))}
          </Pilihan>
        </div>
        {kitab && pasal ? (
          <a
            href={tautanBaca(versi, bacaan)}
            target="_blank"
            rel="noopener noreferrer"
            className="inline-flex min-h-11 items-center text-sm font-medium text-utama underline underline-offset-2"
          >
            Baca ayat ↗
          </a>
        ) : null}
        <p className="text-xs opacity-70">
          Teks ayat dibuka di alkitab.sabda.org; aplikasi ini hanya mencatat kitab, pasal, dan ayatnya.
        </p>
      </fieldset>

      <IsianPanjang
        label="Tuntunan yang didapat (tidak wajib)"
        name="tuntunan"
        rows={5}
        maxLength={TUNTUNAN_MAKS}
        defaultValue={awal?.tuntunan ?? ""}
      />
      <p className="mb-3 text-xs opacity-70">
        Catatan ini bisa dibaca Pemimpin kelompok, Ketua Tim, dan Admin, tetapi hanya Anda yang bisa mengubah atau
        menghapusnya.
      </p>
    </div>
  );
}
