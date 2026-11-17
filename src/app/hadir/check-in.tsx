"use client";

import { useCallback, useEffect, useRef, useState } from "react";
import type QrScanner from "qr-scanner";
import { Pesan, TautanTombol, Tombol } from "@/components/ui";
import { kodePertemuanDariQr } from "@/lib/kartu";
import { tanggalPanjang } from "@/lib/pertemuan";
import type { HasilCheckIn } from "./aksi";

/**
 * Check-in mandiri. Bila halaman dibuka dari QR (?k=...), pencatatan
 * dijalankan otomatis SETELAH halaman terbuka di HP (bukan saat alamat
 * dimuat), supaya pratinjau tautan tidak ikut mencatat kehadiran.
 */
export function CheckIn({
  kodeAwal,
  aksi,
}: {
  kodeAwal: string | null;
  /** Aksi server check-in (src/app/hadir/aksi.ts). */
  aksi: (kode: string) => Promise<HasilCheckIn>;
}) {
  const [hasil, setHasil] = useState<HasilCheckIn | null>(null);
  const [proses, setProses] = useState(Boolean(kodeAwal));
  const [scan, setScan] = useState(false);
  const sudahJalan = useRef(false);
  const video = useRef<HTMLVideoElement>(null);
  const pemindai = useRef<QrScanner | null>(null);

  const kirim = useCallback(
    async (kode: string) => {
      setProses(true);
      try {
        setHasil(await aksi(kode));
      } catch {
        setHasil({ galat: "Koneksi terputus. Scan ulang QR di layar." });
      } finally {
        setProses(false);
      }
    },
    [aksi],
  );

  useEffect(() => {
    if (!kodeAwal || sudahJalan.current) return;
    sudahJalan.current = true;
    aksi(kodeAwal)
      .then(setHasil)
      .catch(() => setHasil({ galat: "Koneksi terputus. Scan ulang QR di layar." }))
      .finally(() => setProses(false));
  }, [kodeAwal, aksi]);

  useEffect(() => {
    if (!scan || !video.current) return;
    let batal = false;
    (async () => {
      const { default: Pemindai } = await import("qr-scanner");
      if (batal || !video.current) return;
      const p = new Pemindai(
        video.current,
        (r) => {
          const kode = kodePertemuanDariQr(r.data);
          if (!kode) return;
          p.stop();
          setScan(false);
          void kirim(kode);
        },
        { preferredCamera: "environment", highlightScanRegion: true, maxScansPerSecond: 8, returnDetailedScanResult: true },
      );
      pemindai.current = p;
      try {
        await p.start();
      } catch {
        setHasil({ galat: "Kamera tidak bisa dibuka. Izinkan akses kamera, atau pindai QR dengan kamera HP biasa." });
        setScan(false);
      }
    })();
    return () => {
      batal = true;
      pemindai.current?.destroy();
      pemindai.current = null;
    };
  }, [scan, kirim]);

  if (proses) return <p className="py-8 text-center text-lg">Mencatat kehadiran…</p>;

  const berhasil = hasil && !hasil.galat;
  return (
    <div>
      {berhasil ? (
        <div className="mb-4 rounded-xl border border-green-700/40 bg-green-50 p-6 text-center text-green-900 dark:bg-green-950 dark:text-green-100">
          <p className="text-5xl" aria-hidden>
            ✓
          </p>
          <p className="mt-2 text-xl font-bold">{hasil.sudah ? "Anda sudah tercatat hadir" : "Anda tercatat hadir"}</p>
          <p className="mt-1">
            {hasil.kelompok}
            {hasil.tanggal ? ` · ${tanggalPanjang(hasil.tanggal)}` : ""}
          </p>
        </div>
      ) : hasil?.galat ? (
        <Pesan jenis="galat">{hasil.galat}</Pesan>
      ) : null}

      {scan ? (
        <div>
          <div className="overflow-hidden rounded-xl bg-black">
            <video ref={video} className="aspect-square w-full object-cover" muted playsInline />
          </div>
          <Tombol type="button" jenis="biasa" className="mt-2 w-full" onClick={() => setScan(false)}>
            Batal
          </Tombol>
        </div>
      ) : berhasil ? (
        <TautanTombol href="/beranda" className="w-full justify-center">
          Ke beranda
        </TautanTombol>
      ) : (
        <>
          <Tombol type="button" className="w-full" onClick={() => { setHasil(null); setScan(true); }}>
            {hasil?.galat ? "Scan ulang QR pertemuan" : "Scan QR pertemuan"}
          </Tombol>
          <p className="mt-3 text-center text-sm opacity-70">
            Bisa juga dengan kamera HP biasa: arahkan ke QR di layar pemimpin, lalu ketuk tautannya.
          </p>
        </>
      )}
    </div>
  );
}
