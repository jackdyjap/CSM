"use client";

import { useRef, useState, useTransition } from "react";
import { hapusFoto, unggahFoto } from "@/lib/aksi-profil";
import { kecilkanFoto } from "@/lib/gambar";
import type { HasilAksi } from "@/lib/hasil";
import { Pesan, Tombol } from "./ui";

const SISI_MAKS = 800; // piksel

export function UnggahFoto({
  anggotaId,
  tautanFoto,
  nama,
  kamera,
}: {
  anggotaId: string;
  /** Tautan sementara foto saat ini, atau null bila belum ada foto. */
  tautanFoto: string | null;
  nama: string;
  /** Kamera yang dibuka: "user" (depan, foto diri) atau "environment" (belakang, memotret orang lain). */
  kamera: "user" | "environment";
}) {
  const kameraRef = useRef<HTMLInputElement>(null);
  const galeriRef = useRef<HTMLInputElement>(null);
  const [pratinjau, setPratinjau] = useState<string | null>(null);
  const [hasil, setHasil] = useState<HasilAksi>({});
  const [sedangProses, mulai] = useTransition();

  function kirim(berkas: File | undefined) {
    if (!berkas) return;
    setHasil({});
    mulai(async () => {
      let kecil: Blob;
      try {
        kecil = await kecilkanFoto(berkas, SISI_MAKS);
      } catch {
        setHasil({ galat: "Berkas ini tidak bisa dibaca sebagai foto. Coba foto lain." });
        return;
      }
      setPratinjau(URL.createObjectURL(kecil));
      const fd = new FormData();
      fd.set("foto", new File([kecil], "foto.jpg", { type: "image/jpeg" }));
      const h = await unggahFoto(anggotaId, fd);
      setHasil(h);
      if (h.galat) setPratinjau(null);
    });
  }

  function hapus() {
    if (!confirm(`Hapus foto ${nama}?`)) return;
    mulai(async () => {
      const h = await hapusFoto(anggotaId);
      setHasil(h);
      if (!h.galat) setPratinjau(null);
    });
  }

  const tampil = pratinjau ?? tautanFoto;

  return (
    <div>
      <div className="mb-3 flex items-center gap-4">
        {tampil ? (
          // eslint-disable-next-line @next/next/no-img-element -- tautan sementara dari penyimpanan privat
          <img
            src={tampil}
            alt={`Foto ${nama}`}
            className="h-24 w-24 rounded-full border border-black/10 object-cover dark:border-white/10"
          />
        ) : (
          <div
            aria-hidden
            className="flex h-24 w-24 items-center justify-center rounded-full bg-black/5 text-3xl font-semibold opacity-60 dark:bg-white/10"
          >
            {nama.trim().charAt(0).toUpperCase() || "?"}
          </div>
        )}
        <p className="text-sm opacity-70">
          {sedangProses ? "Memproses foto…" : tampil ? "Foto tersimpan secara privat." : "Belum ada foto."}
        </p>
      </div>

      {hasil.galat ? <Pesan jenis="galat">{hasil.galat}</Pesan> : null}
      {hasil.sukses ? <Pesan jenis="sukses">{hasil.sukses}</Pesan> : null}

      <input
        ref={kameraRef}
        type="file"
        accept="image/*"
        capture={kamera}
        className="hidden"
        onChange={(e) => {
          kirim(e.target.files?.[0]);
          e.target.value = "";
        }}
      />
      <input
        ref={galeriRef}
        type="file"
        accept="image/jpeg,image/png,image/webp"
        className="hidden"
        onChange={(e) => {
          kirim(e.target.files?.[0]);
          e.target.value = "";
        }}
      />
      <div className="flex flex-wrap gap-2">
        <Tombol type="button" onClick={() => kameraRef.current?.click()} disabled={sedangProses}>
          Ambil foto
        </Tombol>
        <Tombol type="button" jenis="biasa" onClick={() => galeriRef.current?.click()} disabled={sedangProses}>
          Pilih dari galeri
        </Tombol>
        {tampil ? (
          <Tombol type="button" jenis="bahaya" onClick={hapus} disabled={sedangProses}>
            Hapus foto
          </Tombol>
        ) : null}
      </div>
    </div>
  );
}
