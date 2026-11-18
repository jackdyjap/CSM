"use client";

import { useRef, useState, useTransition } from "react";
import { catatBahan } from "@/app/admin/bahan/aksi";
import { BUCKET_BAHAN, namaBerkasAman, UKURAN_BAHAN_MAKS } from "@/lib/bahan";
import { buatClientPeramban } from "@/lib/supabase/browser";
import { Isian, IsianPanjang, Pesan, Pilihan, Tombol } from "./ui";

/**
 * Admin mengunggah bahan diskusi PDF (keputusan 39). Berkas dikirim langsung
 * dari peramban ke penyimpanan privat (bisa sampai 10 MB), lalu dicatat.
 */
export function UnggahBahan({ tim }: { tim: { id: string; nama: string }[] }) {
  const form = useRef<HTMLFormElement>(null);
  const [pesan, setPesan] = useState<{ galat?: string; sukses?: string }>({});
  const [sedangProses, mulai] = useTransition();

  function kirim(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();
    const fd = new FormData(e.currentTarget);
    const berkas = fd.get("berkas");
    const judul = String(fd.get("judul") ?? "").trim();
    if (!(berkas instanceof File) || berkas.size === 0) return setPesan({ galat: "Pilih berkas PDF." });
    if (berkas.type !== "application/pdf" && !/\.pdf$/i.test(berkas.name)) {
      return setPesan({ galat: "Berkas harus berformat PDF." });
    }
    if (berkas.size > UKURAN_BAHAN_MAKS) return setPesan({ galat: "Berkas lebih dari 10 MB. Kecilkan dulu PDF-nya." });
    if (!judul) return setPesan({ galat: "Judul wajib diisi." });

    setPesan({});
    mulai(async () => {
      const id = crypto.randomUUID();
      const lokasi = `${id}/${namaBerkasAman(berkas.name)}`;
      const { error } = await buatClientPeramban()
        .storage.from(BUCKET_BAHAN)
        .upload(lokasi, berkas, { contentType: "application/pdf", upsert: false });
      if (error) {
        setPesan({ galat: "Berkas gagal diunggah. Periksa koneksi lalu coba lagi." });
        return;
      }
      const h = await catatBahan({
        id,
        lokasi,
        nama: berkas.name,
        ukuran: berkas.size,
        judul,
        keterangan: String(fd.get("keterangan") ?? ""),
        tanggalPakai: String(fd.get("tanggal_pakai") ?? ""),
        timId: String(fd.get("tim_id") ?? ""),
      });
      setPesan(h);
      if (!h.galat) form.current?.reset();
    });
  }

  return (
    <form ref={form} onSubmit={kirim}>
      <Isian label="Judul" name="judul" maxLength={150} required placeholder="Contoh: Bahan diskusi pekan 1 Desember" />
      <Isian label="Tanggal dipakai (opsional)" name="tanggal_pakai" type="date" />
      <IsianPanjang label="Keterangan (opsional)" name="keterangan" maxLength={1000} />
      <Pilihan label="Untuk" name="tim_id" defaultValue="">
        <option value="">Semua tim</option>
        {tim.map((t) => (
          <option key={t.id} value={t.id}>
            Tim {t.nama} saja
          </option>
        ))}
      </Pilihan>
      <Isian label="Berkas PDF (maksimal 10 MB)" name="berkas" type="file" accept="application/pdf,.pdf" required />
      {pesan.galat ? <Pesan jenis="galat">{pesan.galat}</Pesan> : null}
      {pesan.sukses ? <Pesan jenis="sukses">{pesan.sukses}</Pesan> : null}
      <Tombol type="submit" disabled={sedangProses}>
        {sedangProses ? "Mengunggah…" : "Unggah bahan"}
      </Tombol>
    </form>
  );
}
