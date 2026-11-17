"use client";

import { useEffect, useRef, useState } from "react";
import type QrScanner from "qr-scanner";
import type { HasilScan } from "@/app/kelompok/[id]/pertemuan/aksi";
import { kodeDariQr } from "@/lib/kartu";
import { Tombol } from "./ui";

type Riwayat = { id: number; teks: string; jenis: "ok" | "info" | "galat" };

/**
 * Pemindai kartu QR anggota untuk mode pertemuan (Fase 7).
 * Kamera tetap menyala untuk kartu berikutnya; kartu yang sama diabaikan
 * selama beberapa detik supaya tidak terkirim berulang-ulang.
 */
export function PemindaiKartu({
  aksi,
}: {
  /** Aksi server yang menandai hadir dari kode kartu (scanKartu yang sudah diikat ke pertemuan). */
  aksi: (kode: string) => Promise<HasilScan>;
}) {
  const video = useRef<HTMLVideoElement>(null);
  const pemindai = useRef<QrScanner | null>(null);
  const terakhir = useRef<{ kode: string; waktu: number }>({ kode: "", waktu: 0 });
  const sibuk = useRef(false);
  const [aktif, setAktif] = useState(false);
  const [galatKamera, setGalatKamera] = useState<string | null>(null);
  const [riwayat, setRiwayat] = useState<Riwayat[]>([]);

  function catat(teks: string, jenis: Riwayat["jenis"]) {
    setRiwayat((r) => [{ id: Date.now() + Math.random(), teks, jenis }, ...r].slice(0, 6));
    if (jenis === "ok" && "vibrate" in navigator) navigator.vibrate?.(80);
  }

  async function terbaca(teks: string) {
    const kode = kodeDariQr(teks);
    const sekarang = Date.now();
    const kunci = kode ?? teks;
    if (kunci === terakhir.current.kode && sekarang - terakhir.current.waktu < 4000) return;
    terakhir.current = { kode: kunci, waktu: sekarang };
    if (!kode) {
      catat("Ini bukan kartu anggota.", "galat");
      return;
    }
    if (sibuk.current) return;
    sibuk.current = true;
    try {
      const h = await aksi(kode);
      if (h.galat) catat(h.galat, "galat");
      else if (h.sudah) catat(`${h.nama} sudah tercatat hadir`, "info");
      else catat(`✓ ${h.nama} hadir`, "ok");
    } catch {
      catat("Koneksi terputus. Arahkan kartu sekali lagi.", "galat");
      terakhir.current = { kode: "", waktu: 0 };
    } finally {
      sibuk.current = false;
    }
  }

  useEffect(() => {
    if (!aktif || !video.current) return;
    let batal = false;
    (async () => {
      const { default: Pemindai } = await import("qr-scanner");
      if (batal || !video.current) return;
      const p = new Pemindai(video.current, (hasil) => void terbaca(hasil.data), {
        preferredCamera: "environment",
        highlightScanRegion: true,
        maxScansPerSecond: 8,
        returnDetailedScanResult: true,
      });
      pemindai.current = p;
      try {
        await p.start();
      } catch {
        setGalatKamera(
          "Kamera tidak bisa dibuka. Izinkan akses kamera untuk situs ini di pengaturan peramban, lalu coba lagi.",
        );
        setAktif(false);
      }
    })();
    return () => {
      batal = true;
      pemindai.current?.destroy();
      pemindai.current = null;
    };
    // terbaca memakai ref, aman tidak dimasukkan sebagai dependensi
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [aktif]);

  return (
    <div className="mb-4">
      {aktif ? (
        <div>
          <div className="relative overflow-hidden rounded-xl bg-black">
            <video ref={video} className="aspect-square w-full object-cover" muted playsInline />
          </div>
          <div className="mt-2 flex items-center justify-between gap-2">
            <p className="text-sm opacity-70">Arahkan kamera ke QR di kartu atau di HP anggota.</p>
            <Tombol type="button" jenis="biasa" onClick={() => setAktif(false)}>
              Selesai scan
            </Tombol>
          </div>
        </div>
      ) : (
        <Tombol
          type="button"
          className="w-full"
          onClick={() => {
            setGalatKamera(null);
            setAktif(true);
          }}
        >
          Scan kartu QR
        </Tombol>
      )}
      {galatKamera ? (
        <p role="alert" className="mt-2 text-sm text-red-700 dark:text-red-400">
          {galatKamera}
        </p>
      ) : null}
      {riwayat.length > 0 ? (
        <ul className="mt-2 space-y-1" aria-live="polite">
          {riwayat.map((r) => (
            <li
              key={r.id}
              className={`rounded-lg px-3 py-2 text-sm ${
                r.jenis === "ok"
                  ? "bg-green-50 text-green-900 dark:bg-green-950 dark:text-green-100"
                  : r.jenis === "info"
                    ? "bg-black/5 dark:bg-white/10"
                    : "bg-red-50 text-red-800 dark:bg-red-950 dark:text-red-200"
              }`}
            >
              {r.teks}
            </li>
          ))}
        </ul>
      ) : null}
    </div>
  );
}
