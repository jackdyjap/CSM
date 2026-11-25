import { notFound } from "next/navigation";
import { PenampilPdf } from "@/components/penampil-pdf";
import { Judul, Kotak, Pesan, TautanTombol } from "@/components/ui";
import { pesanBacaGagal } from "@/lib/galat";
import { wajibMasuk } from "@/lib/sesi";
import { BUCKET_TRAINING, KOLOM_TRAINING, UMUR_TAUTAN_TRAINING, type BarisTraining } from "@/lib/training";

/** Membuka satu bahan training di dalam aplikasi (keputusan 54). */
export default async function HalamanBukaTraining({ params }: PageProps<"/training/[id]">) {
  const { id } = await params;
  if (!/^[0-9a-f-]{36}$/.test(id)) notFound();
  const { supabase, peran } = await wajibMasuk();
  // Aturan akses database: hanya peruntukannya (dan Admin) yang bisa membaca baris ini.
  const { data, error } = await supabase.from("bahan_training").select(KOLOM_TRAINING).eq("id", id).maybeSingle();
  const b = data as BarisTraining | null;
  const kembali = peran.admin ? "/admin/training" : "/training";

  if (error) {
    return (
      <main>
        <Judul>Bahan training</Judul>
        <Pesan jenis="galat">{pesanBacaGagal(error, "Bahan training")}</Pesan>
        <TautanTombol href={kembali}>← Kembali</TautanTombol>
      </main>
    );
  }
  if (!b) notFound();

  let tautanPdf: string | null = null;
  if (b.jenis === "pdf" && b.lokasi) {
    const { data: t } = await supabase.storage.from(BUCKET_TRAINING).createSignedUrl(b.lokasi, UMUR_TAUTAN_TRAINING);
    tautanPdf = t?.signedUrl ?? null;
  }

  return (
    <main>
      <Judul kecil={b.jenis === "pdf" ? "Bahan training · PDF" : "Bahan training · Video"}>{b.judul}</Judul>
      <div className="mb-4">
        <TautanTombol href={kembali}>← Daftar bahan</TautanTombol>
      </div>
      {b.keterangan ? <p className="mb-4 text-sm whitespace-pre-wrap">{b.keterangan}</p> : null}

      {b.jenis === "video" && b.video_id ? (
        <Kotak>
          <div className="relative w-full overflow-hidden rounded-lg bg-black" style={{ aspectRatio: "16 / 9" }}>
            <iframe
              src={`https://www.youtube-nocookie.com/embed/${b.video_id}?rel=0&modestbranding=1&playsinline=1`}
              title={b.judul}
              className="absolute inset-0 h-full w-full"
              allow="accelerometer; encrypted-media; gyroscope; picture-in-picture"
              referrerPolicy="strict-origin-when-cross-origin"
              allowFullScreen
            />
          </div>
        </Kotak>
      ) : null}

      {b.jenis === "pdf" ? (
        tautanPdf ? (
          <PenampilPdf tautan={tautanPdf} />
        ) : (
          <Pesan jenis="galat">Berkas PDF belum bisa dibuka. Muat ulang halaman, atau sampaikan kepada Admin.</Pesan>
        )
      ) : null}

      <p className="mt-2 text-xs opacity-70">Bahan ini hanya untuk dibaca dan ditonton di aplikasi. Mohon tidak disebarkan ke luar.</p>
    </main>
  );
}
