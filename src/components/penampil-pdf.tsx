"use client";

import { useEffect, useRef, useState } from "react";

/**
 * Menampilkan PDF halaman demi halaman di dalam aplikasi (pdf.js), tanpa tombol
 * unduh atau cetak (keputusan 54). Tautan berkas hanya berlaku beberapa menit.
 * Catatan: tangkapan layar tetap tidak bisa dicegah.
 */
export function PenampilPdf({ tautan }: { tautan: string }) {
  const wadah = useRef<HTMLDivElement>(null);
  const [status, setStatus] = useState<{ memuat: boolean; galat?: string; halaman?: number }>({ memuat: true });

  useEffect(() => {
    let batal = false;
    const el = wadah.current;
    (async () => {
      try {
        const pdfjs = await import("pdfjs-dist");
        pdfjs.GlobalWorkerOptions.workerSrc = new URL("pdfjs-dist/build/pdf.worker.min.mjs", import.meta.url).toString();
        const dok = await pdfjs.getDocument({ url: tautan, isEvalSupported: false }).promise;
        if (batal || !el) return;
        el.replaceChildren();
        const lebar = el.clientWidth || 360;
        const rasio = Math.min(window.devicePixelRatio || 1, 2);
        for (let i = 1; i <= dok.numPages; i++) {
          const hal = await dok.getPage(i);
          if (batal) return;
          const dasar = hal.getViewport({ scale: 1 });
          const skala = lebar / dasar.width;
          const vp = hal.getViewport({ scale: skala * rasio });
          const kanvas = document.createElement("canvas");
          kanvas.width = Math.floor(vp.width);
          kanvas.height = Math.floor(vp.height);
          kanvas.style.width = "100%";
          kanvas.className = "mb-3 block rounded border border-black/10 bg-white shadow-sm dark:border-white/10";
          kanvas.setAttribute("aria-label", `Halaman ${i} dari ${dok.numPages}`);
          kanvas.oncontextmenu = (e) => e.preventDefault();
          el.appendChild(kanvas);
          await hal.render({ canvasContext: kanvas.getContext("2d")!, viewport: vp }).promise;
          if (i === 1) setStatus({ memuat: true, halaman: dok.numPages });
        }
        if (!batal) setStatus({ memuat: false, halaman: dok.numPages });
      } catch (e) {
        if (!batal) {
          setStatus({
            memuat: false,
            galat: `PDF belum bisa ditampilkan. Muat ulang halaman, lalu coba lagi. (${e instanceof Error ? e.message : String(e)})`.slice(0, 300),
          });
        }
      }
    })();
    return () => {
      batal = true;
    };
  }, [tautan]);

  return (
    <div className="select-none" style={{ WebkitTouchCallout: "none" }}>
      {status.galat ? (
        <p role="alert" className="mb-3 rounded-lg border border-red-600/40 p-3 text-sm text-red-800 dark:text-red-300">
          {status.galat}
        </p>
      ) : null}
      {status.memuat ? (
        <p className="mb-3 text-sm opacity-70" aria-live="polite">
          {status.halaman ? `Memuat ${status.halaman} halaman…` : "Memuat PDF…"}
        </p>
      ) : null}
      <div ref={wadah} />
    </div>
  );
}
