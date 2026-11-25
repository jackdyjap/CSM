import { ButirTraining } from "@/components/butir-training";
import { SaringCari } from "@/components/saring-cari";
import { Judul, Kotak, Pesan, TautanTombol } from "@/components/ui";
import { pesanBacaGagal } from "@/lib/galat";
import { wajibMasuk } from "@/lib/sesi";
import { KOLOM_TRAINING, type BarisTraining } from "@/lib/training";

/** Bahan training sesuai peran saya (keputusan 54); aturan akses database yang menyaring. */
export default async function HalamanTraining() {
  const { supabase } = await wajibMasuk();
  const { data, error } = await supabase.from("bahan_training").select(KOLOM_TRAINING).order("dibuat_pada", { ascending: false });
  const bahan = (data ?? []) as BarisTraining[];

  return (
    <main>
      <Judul>Bahan training</Judul>
      <div className="mb-4">
        <TautanTombol href="/beranda">← Beranda</TautanTombol>
      </div>
      <Kotak>
        {error ? <Pesan jenis="galat">{pesanBacaGagal(error, "Bahan training")}</Pesan> : null}
        {bahan.length === 0 ? (
          <p className="text-sm opacity-70">Belum ada bahan training untuk Anda.</p>
        ) : (
          <SaringCari label="Cari judul atau keterangan…" jumlah={bahan.length}>
            <ul className="divide-y divide-black/10 dark:divide-white/10">
              {bahan.map((b) => (
                <ButirTraining key={b.id} b={b} />
              ))}
            </ul>
          </SaringCari>
        )}
        <p className="mt-3 text-xs opacity-70">
          Bahan hanya untuk dibaca dan ditonton di aplikasi ini. Mohon tidak disebarkan ke luar.
        </p>
      </Kotak>
    </main>
  );
}
