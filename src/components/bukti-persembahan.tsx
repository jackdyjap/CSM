"use client";

import { useRef, useState, useTransition } from "react";
import { catatBukti, hapusBukti } from "@/app/kelompok/[id]/pertemuan/aksi";
import { kecilkanFoto } from "@/lib/gambar";
import { buatClientPeramban } from "@/lib/supabase/browser";
import { Pesan, Tombol } from "./ui";

export type BarisBukti = {
  id: string;
  nama_berkas: string;
  jenis: string;
  ukuran: number;
  /** Tautan sementara (1 jam) untuk membuka berkas. */
  tautan: string | null;
};

const MAKS_BERKAS = 5;
const UKURAN_MAKS = 5 * 1024 * 1024;
const SISI_FOTO = 1600; // cukup tajam untuk membaca angka di struk/tangkapan layar

function ukuranTerbaca(b: number) {
  return b >= 1024 * 1024 ? `${(b / 1024 / 1024).toFixed(1)} MB` : `${Math.max(1, Math.round(b / 1024))} KB`;
}

/** Daftar dan unggah bukti transfer persembahan untuk satu pertemuan. */
export function BuktiPersembahan({
  kelompokId,
  pertemuanId,
  daftar,
  bolehUbah,
}: {
  kelompokId: string;
  pertemuanId: string;
  daftar: BarisBukti[];
  bolehUbah: boolean;
}) {
  const masukan = useRef<HTMLInputElement>(null);
  const [pesan, setPesan] = useState<{ galat?: string; sukses?: string }>({});
  const [status, setStatus] = useState<string | null>(null);
  const [sedangProses, mulai] = useTransition();
  const sisa = MAKS_BERKAS - daftar.length;

  function unggah(berkasDipilih: FileList | null) {
    const semua = Array.from(berkasDipilih ?? []);
    if (semua.length === 0) return;
    if (semua.length > sisa) {
      setPesan({ galat: `Hanya bisa menambah ${sisa} bukti lagi (maksimal ${MAKS_BERKAS} per pertemuan).` });
      return;
    }
    setPesan({});
    mulai(async () => {
      const supabase = buatClientPeramban();
      let berhasil = 0;
      for (const [i, berkas] of semua.entries()) {
        setStatus(`Mengunggah ${i + 1} dari ${semua.length}…`);
        let isi: Blob = berkas;
        let jenis = berkas.type;
        if (berkas.type.startsWith("image/")) {
          try {
            isi = await kecilkanFoto(berkas, SISI_FOTO);
            jenis = "image/jpeg";
          } catch {
            setPesan({ galat: `${berkas.name} tidak bisa dibaca sebagai foto.` });
            break;
          }
        } else if (berkas.type !== "application/pdf") {
          setPesan({ galat: `${berkas.name}: bukti harus berupa foto atau PDF.` });
          break;
        }
        if (isi.size > UKURAN_MAKS) {
          setPesan({ galat: `${berkas.name} lebih dari 5 MB.` });
          break;
        }

        const ekstensi = jenis === "application/pdf" ? "pdf" : "jpg";
        const lokasi = `${pertemuanId}/${Date.now()}-${Math.random().toString(36).slice(2, 8)}.${ekstensi}`;
        const { error } = await supabase.storage
          .from("bukti-persembahan")
          .upload(lokasi, isi, { contentType: jenis, upsert: false });
        if (error) {
          setPesan({ galat: `${berkas.name} gagal diunggah. Periksa koneksi lalu coba lagi.` });
          break;
        }
        const h = await catatBukti(kelompokId, pertemuanId, {
          lokasi,
          nama: berkas.name,
          jenis,
          ukuran: isi.size,
        });
        if (h.galat) {
          setPesan({ galat: h.galat });
          break;
        }
        berhasil += 1;
      }
      setStatus(null);
      if (berhasil > 0) setPesan((p) => (p.galat ? p : { sukses: `${berhasil} bukti tersimpan.` }));
    });
  }

  function hapus(b: BarisBukti) {
    if (!confirm(`Hapus bukti "${b.nama_berkas}"?`)) return;
    setPesan({});
    mulai(async () => setPesan(await hapusBukti(kelompokId, pertemuanId, b.id)));
  }

  return (
    <div className="mt-2">
      <p className="mb-2 text-sm font-medium">
        Bukti transfer {daftar.length > 0 ? `(${daftar.length} dari ${MAKS_BERKAS})` : "(opsional)"}
      </p>
      {daftar.length === 0 ? (
        <p className="mb-3 text-sm opacity-70">Belum ada bukti. Boleh diunggah menyusul.</p>
      ) : (
        <ul className="mb-3 grid grid-cols-2 gap-2 sm:grid-cols-3">
          {daftar.map((b) => (
            <li key={b.id} className="overflow-hidden rounded-lg border border-black/10 dark:border-white/10">
              <a
                href={b.tautan ?? undefined}
                target="_blank"
                rel="noopener noreferrer"
                className="block"
                aria-label={`Buka ${b.nama_berkas}`}
              >
                {b.jenis.startsWith("image/") && b.tautan ? (
                  // eslint-disable-next-line @next/next/no-img-element -- tautan sementara dari penyimpanan privat
                  <img src={b.tautan} alt="" className="h-24 w-full bg-black/5 object-cover" />
                ) : (
                  <div className="flex h-24 items-center justify-center bg-black/5 text-lg font-bold opacity-70 dark:bg-white/10">
                    PDF
                  </div>
                )}
              </a>
              <div className="flex items-center justify-between gap-1 px-2 py-1">
                <span className="truncate text-xs opacity-70" title={b.nama_berkas}>
                  {ukuranTerbaca(b.ukuran)}
                </span>
                {bolehUbah ? (
                  <button
                    type="button"
                    onClick={() => hapus(b)}
                    disabled={sedangProses}
                    className="min-h-9 rounded px-2 text-xs text-red-700 hover:bg-red-50 dark:text-red-400 dark:hover:bg-red-950"
                  >
                    Hapus
                  </button>
                ) : null}
              </div>
            </li>
          ))}
        </ul>
      )}
      {pesan.galat ? <Pesan jenis="galat">{pesan.galat}</Pesan> : null}
      {pesan.sukses ? <Pesan jenis="sukses">{pesan.sukses}</Pesan> : null}
      {bolehUbah && sisa > 0 ? (
        <>
          <input
            ref={masukan}
            type="file"
            multiple
            accept="image/*,application/pdf"
            className="hidden"
            onChange={(e) => {
              unggah(e.target.files);
              e.target.value = "";
            }}
          />
          <Tombol type="button" jenis="biasa" disabled={sedangProses} onClick={() => masukan.current?.click()}>
            {status ?? (sedangProses ? "Memproses…" : "Unggah bukti (foto/PDF)")}
          </Tombol>
        </>
      ) : null}
    </div>
  );
}
