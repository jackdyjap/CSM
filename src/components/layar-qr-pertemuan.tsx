"use client";

import { useCallback, useEffect, useRef, useState } from "react";
import { useRouter } from "next/navigation";
import type { HasilTokenQr } from "@/app/kelompok/[id]/pertemuan/aksi";
import { Tombol } from "./ui";

const LAMA_JENDELA = 45; // detik; sama dengan database (internal.jendela_qr)

/**
 * Layar penuh berisi QR pertemuan yang berganti otomatis (Fase 8).
 * Anggota memindainya dengan kamera HP biasa untuk check-in sendiri.
 */
export function LayarQrPertemuan({
  ambilToken,
  ambilJumlah,
}: {
  ambilToken: () => Promise<HasilTokenQr>;
  ambilJumlah: () => Promise<{ hadir: number; total: number }>;
}) {
  const router = useRouter();
  const [buka, setBuka] = useState(false);
  const [svg, setSvg] = useState<string | null>(null);
  const [sisa, setSisa] = useState(0);
  const [jumlah, setJumlah] = useState<{ hadir: number; total: number } | null>(null);
  const [galat, setGalat] = useState<string | null>(null);
  const berakhirPada = useRef(0);

  const segarkanQr = useCallback(async () => {
    try {
      const h = await ambilToken();
      if (h.galat || !h.svg) {
        setGalat(h.galat ?? "QR belum bisa ditampilkan.");
        setSvg(null);
        return;
      }
      setGalat(null);
      setSvg(h.svg);
      berakhirPada.current = Date.now() + (h.sisaDetik ?? LAMA_JENDELA) * 1000;
    } catch {
      setGalat("Koneksi terputus. Mencoba lagi…");
      berakhirPada.current = Date.now() + 3000;
    }
  }, [ambilToken]);

  // Hitung mundur; ambil QR baru tepat setelah jendela berganti.
  useEffect(() => {
    if (!buka) return;
    const t = setInterval(() => {
      const s = Math.max(0, Math.ceil((berakhirPada.current - Date.now()) / 1000));
      setSisa(s);
      if (s === 0 && berakhirPada.current !== 0) {
        berakhirPada.current = 0;
        setTimeout(() => void segarkanQr(), 600);
      }
    }, 250);
    return () => clearInterval(t);
  }, [buka, segarkanQr]);

  // Penghitung hadir diperbarui tiap 5 detik.
  useEffect(() => {
    if (!buka) return;
    let hidup = true;
    const muat = () => ambilJumlah().then((j) => hidup && setJumlah(j)).catch(() => {});
    void muat();
    const t = setInterval(muat, 5000);
    return () => {
      hidup = false;
      clearInterval(t);
    };
  }, [buka, ambilJumlah]);

  // Layar tetap menyala selama QR ditampilkan (bila peramban mendukung).
  useEffect(() => {
    if (!buka || !("wakeLock" in navigator)) return;
    let kunci: WakeLockSentinel | null = null;
    navigator.wakeLock.request("screen").then((k) => (kunci = k)).catch(() => {});
    return () => void kunci?.release();
  }, [buka]);

  function tutup() {
    setBuka(false);
    setSvg(null);
    router.refresh();
  }

  if (!buka) {
    return (
      <Tombol
        type="button"
        jenis="biasa"
        className="mb-2 w-full"
        onClick={() => {
          setBuka(true);
          void segarkanQr();
        }}
      >
        Tampilkan QR pertemuan (check-in mandiri)
      </Tombol>
    );
  }

  return (
    <div className="fixed inset-0 z-50 flex flex-col items-center justify-center overflow-y-auto bg-white p-4 text-black">
      <p className="mb-1 text-center text-lg font-semibold">Scan untuk check-in</p>
      <p className="mb-3 text-center text-sm opacity-70">Buka kamera HP, arahkan ke QR, lalu ketuk tautannya.</p>
      <div
        className="aspect-square w-[min(80vw,60vh)] [&>svg]:h-full [&>svg]:w-full"
        // SVG dibuat pustaka qrcode di server dari alamat check-in; tidak berisi masukan pengguna.
        dangerouslySetInnerHTML={{ __html: svg ?? "" }}
      />
      <div className="mt-3 h-2 w-[min(80vw,60vh)] overflow-hidden rounded-full bg-black/10" aria-hidden>
        <div className="h-full bg-[#1d5fbf] transition-[width] duration-200" style={{ width: `${(sisa / LAMA_JENDELA) * 100}%` }} />
      </div>
      <p className="mt-1 text-sm opacity-70" aria-live="polite">
        {galat ?? (svg ? `QR berganti dalam ${sisa} detik` : "Memuat QR…")}
      </p>
      <p className="mt-4 text-3xl font-bold" aria-live="polite">
        {jumlah ? `Hadir ${jumlah.hadir} dari ${jumlah.total}` : " "}
      </p>
      <Tombol type="button" className="mt-6" onClick={tutup}>
        Tutup layar QR
      </Tombol>
    </div>
  );
}
