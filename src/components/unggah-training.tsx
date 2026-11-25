"use client";

import { useRef, useState, useTransition } from "react";
import { catatTraining } from "@/app/admin/training/aksi";
import { buatClientPeramban } from "@/lib/supabase/browser";
import { BUCKET_TRAINING, kodeYoutube, namaBerkasTraining, UKURAN_TRAINING_MAKS } from "@/lib/training";
import { IsianPeruntukan } from "./isian-peruntukan";
import { Isian, IsianPanjang, Pesan, Tombol } from "./ui";

/**
 * Admin menambah bahan training (keputusan 54): PDF dikirim langsung dari
 * peramban ke penyimpanan privat (maks 10 MB) lalu dicatat; video cukup tautan YouTube.
 */
export function UnggahTraining() {
  const form = useRef<HTMLFormElement>(null);
  const [jenis, setJenis] = useState<"pdf" | "video">("pdf");
  const [pesan, setPesan] = useState<{ galat?: string; sukses?: string }>({});
  const [sedangProses, mulai] = useTransition();
  const [kunciForm, setKunciForm] = useState(0);

  function kirim(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();
    const fd = new FormData(e.currentTarget);
    const judul = String(fd.get("judul") ?? "").trim();
    const peruntukan = {
      semua: fd.get("untuk_semua") === "ya",
      ketuaTim: fd.get("untuk_ketua_tim") === "ya",
      pemimpin: fd.get("untuk_pemimpin") === "ya",
      anggota: fd.get("untuk_anggota") === "ya",
    };
    if (!judul) return setPesan({ galat: "Judul wajib diisi." });
    if (!peruntukan.semua && !peruntukan.ketuaTim && !peruntukan.pemimpin && !peruntukan.anggota) {
      return setPesan({ galat: "Pilih peruntukan: Semua, atau minimal satu peran." });
    }
    const dasar = { id: crypto.randomUUID(), judul, keterangan: String(fd.get("keterangan") ?? ""), peruntukan };

    if (jenis === "video") {
      const tautan = String(fd.get("tautan_video") ?? "");
      if (!kodeYoutube(tautan)) return setPesan({ galat: "Tautan video tidak dikenali. Tempel tautan YouTube, mis. https://youtu.be/…" });
      setPesan({});
      mulai(async () => {
        const h = await catatTraining({ ...dasar, tautanVideo: tautan });
        setPesan(h);
        if (!h.galat) setKunciForm((k) => k + 1);
      });
      return;
    }

    const berkas = fd.get("berkas");
    if (!(berkas instanceof File) || berkas.size === 0) return setPesan({ galat: "Pilih berkas PDF." });
    if (berkas.type !== "application/pdf" && !/\.pdf$/i.test(berkas.name)) {
      return setPesan({ galat: "Berkas harus berformat PDF." });
    }
    if (berkas.size > UKURAN_TRAINING_MAKS) return setPesan({ galat: "Berkas lebih dari 10 MB. Kecilkan dulu PDF-nya." });

    setPesan({});
    mulai(async () => {
      const lokasi = `${dasar.id}/${namaBerkasTraining(berkas.name)}`;
      const { error } = await buatClientPeramban()
        .storage.from(BUCKET_TRAINING)
        .upload(lokasi, berkas, { contentType: "application/pdf", upsert: false });
      if (error) {
        setPesan({ galat: "Berkas gagal diunggah. Periksa koneksi lalu coba lagi." });
        return;
      }
      const h = await catatTraining({ ...dasar, pdf: { lokasi, nama: berkas.name, ukuran: berkas.size } });
      setPesan(h);
      if (!h.galat) setKunciForm((k) => k + 1);
    });
  }

  return (
    <form ref={form} key={kunciForm} onSubmit={kirim}>
      <Isian label="Judul" name="judul" maxLength={150} required placeholder="Contoh: Dasar-dasar memimpin kelompok" />
      <IsianPanjang label="Keterangan (opsional)" name="keterangan" maxLength={1000} />
      <fieldset className="mb-3">
        <legend className="mb-1 text-sm font-medium">Jenis bahan</legend>
        <div className="flex gap-4">
          {(
            [
              ["pdf", "PDF"],
              ["video", "Video YouTube"],
            ] as const
          ).map(([nilai, label]) => (
            <label key={nilai} className="flex min-h-10 items-center gap-2">
              <input
                type="radio"
                name="jenis"
                value={nilai}
                checked={jenis === nilai}
                onChange={() => setJenis(nilai)}
                className="h-5 w-5"
              />
              {label}
            </label>
          ))}
        </div>
      </fieldset>
      {jenis === "pdf" ? (
        <Isian label="Berkas PDF (maksimal 10 MB)" name="berkas" type="file" accept="application/pdf,.pdf" required />
      ) : (
        <Isian
          label="Tautan video YouTube"
          name="tautan_video"
          type="url"
          inputMode="url"
          placeholder="https://youtu.be/…"
          keterangan="Unggah video ke YouTube sebagai “Tidak publik” (unlisted), lalu tempel tautannya di sini."
          required
        />
      )}
      <IsianPeruntukan />
      {pesan.galat ? <Pesan jenis="galat">{pesan.galat}</Pesan> : null}
      {pesan.sukses ? <Pesan jenis="sukses">{pesan.sukses}</Pesan> : null}
      <Tombol type="submit" disabled={sedangProses}>
        {sedangProses ? (jenis === "pdf" ? "Mengunggah…" : "Menyimpan…") : "Simpan bahan"}
      </Tombol>
    </form>
  );
}
