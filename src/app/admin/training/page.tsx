import { ButirTraining } from "@/components/butir-training";
import { FormAksi } from "@/components/form-aksi";
import { IsianPeruntukan } from "@/components/isian-peruntukan";
import { SaringCari } from "@/components/saring-cari";
import { Isian, IsianPanjang, Judul, Kotak, Lipatan, Pesan, TautanTombol } from "@/components/ui";
import { UnggahTraining } from "@/components/unggah-training";
import { pesanBacaGagal } from "@/lib/galat";
import { wajibAdmin } from "@/lib/sesi";
import { KOLOM_TRAINING, type BarisTraining } from "@/lib/training";
import { hapusTraining, ubahTraining } from "./aksi";

/** Admin: tambah, ubah, hapus bahan training (keputusan 54). */
export default async function HalamanAdminTraining() {
  const { supabase } = await wajibAdmin();
  const { data, error } = await supabase.from("bahan_training").select(KOLOM_TRAINING).order("dibuat_pada", { ascending: false });
  const bahan = (data ?? []) as BarisTraining[];

  return (
    <main>
      <Judul kecil="Admin">Bahan training</Judul>
      <div className="mb-4 flex flex-wrap gap-2">
        <TautanTombol href="/beranda">← Beranda</TautanTombol>
      </div>

      <Kotak>
        <Lipatan judul="+ Tambah bahan training">
          <UnggahTraining />
        </Lipatan>
      </Kotak>

      <Kotak judul={`Semua bahan (${bahan.length})`}>
        {error ? <Pesan jenis="galat">{pesanBacaGagal(error, "Bahan training")}</Pesan> : null}
        {bahan.length === 0 ? (
          <p className="text-sm opacity-70">Belum ada bahan training.</p>
        ) : (
          <SaringCari label="Cari judul, keterangan, atau peruntukan…" jumlah={bahan.length}>
            <ul className="divide-y divide-black/10 dark:divide-white/10">
              {bahan.map((b) => (
                <ButirTraining key={b.id} b={b} admin>
                  <Lipatan judul="Ubah / hapus">
                    <FormAksi aksi={ubahTraining.bind(null, b.id)} tombol="Simpan perubahan" jenisTombol="biasa" tanpaReset>
                      <Isian label="Judul" name="judul" defaultValue={b.judul} maxLength={150} required />
                      <IsianPanjang label="Keterangan (opsional)" name="keterangan" defaultValue={b.keterangan ?? ""} maxLength={1000} />
                      <IsianPeruntukan awal={b} />
                    </FormAksi>
                    <FormAksi
                      aksi={hapusTraining.bind(null, b.id, b.lokasi)}
                      tombol="Hapus bahan"
                      jenisTombol="bahaya"
                      konfirmasi={`Hapus bahan "${b.judul}"? Tindakan ini tidak bisa dibatalkan.`}
                    />
                  </Lipatan>
                </ButirTraining>
              ))}
            </ul>
          </SaringCari>
        )}
      </Kotak>
    </main>
  );
}
