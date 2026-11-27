import { hapusBahan, ubahBahan } from "@/app/admin/bahan/aksi";
import { FormAksi } from "@/components/form-aksi";
import { SaringCari } from "@/components/saring-cari";
import { Isian, IsianPanjang, Lipatan, Pilihan } from "@/components/ui";
import { BUCKET_BAHAN, ukuranTerbaca, type BarisBahan } from "@/lib/bahan";
import { tanggalPanjang } from "@/lib/pertemuan";
import type { buatClientServer } from "@/lib/supabase/server";

type Supabase = Awaited<ReturnType<typeof buatClientServer>>;
const UMUR_TAUTAN = 60 * 60; // 1 jam

/**
 * Daftar bahan diskusi yang ringkas (judul + tanggal/tim) dengan pencarian.
 * Ketuk judul untuk rincian dan tombol Buka/Unduh (tautan sementara 1 jam);
 * Admin (`kelola`) juga mendapat Ubah dan Hapus.
 */
export async function DaftarBahan({
  supabase,
  bahan,
  kelola,
  tim = [],
}: {
  supabase: Supabase;
  bahan: BarisBahan[];
  /** Admin: tampilkan ubah dan hapus. */
  kelola?: boolean;
  tim?: { id: string; nama: string }[];
}) {
  if (bahan.length === 0) return <p className="opacity-70">Belum ada bahan diskusi.</p>;

  const lokasi = bahan.map((b) => b.lokasi);
  const [{ data: buka }, unduh] = await Promise.all([
    supabase.storage.from(BUCKET_BAHAN).createSignedUrls(lokasi, UMUR_TAUTAN),
    Promise.all(
      bahan.map((b) =>
        supabase.storage.from(BUCKET_BAHAN).createSignedUrl(b.lokasi, UMUR_TAUTAN, { download: b.nama_berkas }),
      ),
    ),
  ]);
  const tautanBuka = new Map((buka ?? []).map((t) => [t.path, t.signedUrl]));

  return (
    <SaringCari label="Cari judul, keterangan, atau tim…" jumlah={bahan.length}>
      <ul className="divide-y divide-black/10 dark:divide-white/10">
        {bahan.map((b, i) => {
          const urlBuka = tautanBuka.get(b.lokasi);
          const urlUnduh = unduh[i]?.data?.signedUrl;
          const untuk = b.tim ? `Tim ${b.tim.nama}` : "Semua tim";
          const cari = [b.judul, b.keterangan, untuk].filter(Boolean).join(" ").toLowerCase();
          return (
            <li key={b.id} data-cari={cari}>
              {/* Ketuk judul untuk rincian dan tombol; ketuk lagi untuk menutup. */}
              <details className="group/butir">
                <summary className="-mx-2 flex min-h-11 cursor-pointer list-none items-center gap-2 rounded-lg px-2 py-1 hover:bg-black/5 dark:hover:bg-white/10 [&::-webkit-details-marker]:hidden">
                  <span className="min-w-0 flex-1">
                    <span className="block font-medium">{b.judul}</span>
                    <span className="block text-xs opacity-70">
                      {b.tanggal_pakai ? `Dipakai ${tanggalPanjang(b.tanggal_pakai)} · ` : ""}
                      {untuk}
                    </span>
                  </span>
                  <span className="text-sm opacity-60" aria-hidden>
                    <span className="group-open/butir:hidden">▾</span>
                    <span className="hidden group-open/butir:inline">▴</span>
                  </span>
                </summary>
                <div className="mb-3 ml-1 mt-1 space-y-2 border-l-2 border-black/10 pl-3 dark:border-white/15">
                  {b.keterangan ? <p className="text-sm whitespace-pre-line">{b.keterangan}</p> : null}
                  <p className="text-xs opacity-70">
                    PDF · {ukuranTerbaca(b.ukuran)} · untuk {untuk}
                  </p>
                  <div className="flex flex-wrap items-start gap-2">
                    {urlBuka ? (
                      <a
                        href={urlBuka}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="inline-flex min-h-11 items-center rounded-lg bg-utama px-4 py-2 font-medium text-white hover:opacity-90 dark:text-black"
                      >
                        Buka PDF
                      </a>
                    ) : null}
                    {urlUnduh ? (
                      <a
                        href={urlUnduh}
                        className="inline-flex min-h-11 items-center rounded-lg border border-black/20 px-4 py-2 font-medium hover:bg-black/5 dark:border-white/20 dark:hover:bg-white/10"
                      >
                        Unduh
                      </a>
                    ) : null}
                    {kelola ? (
                      <FormAksi
                        aksi={hapusBahan.bind(null, b.id, b.lokasi)}
                        tombol="Hapus"
                        jenisTombol="bahaya"
                        konfirmasi={`Hapus bahan "${b.judul}"? Berkas PDF-nya ikut terhapus.`}
                      />
                    ) : null}
                  </div>
                  {!urlBuka && !urlUnduh ? (
                    <p className="text-sm opacity-70">Berkas belum bisa dibuka. Muat ulang halaman.</p>
                  ) : null}
                  {kelola ? (
                    <Lipatan judul="Ubah judul, tanggal, keterangan, atau tim">
                      <FormAksi aksi={ubahBahan.bind(null, b.id)} tombol="Simpan perubahan" jenisTombol="biasa" tanpaReset>
                        <Isian label="Judul" name="judul" defaultValue={b.judul} maxLength={150} required />
                        <Isian label="Tanggal dipakai (opsional)" name="tanggal_pakai" type="date" defaultValue={b.tanggal_pakai ?? ""} />
                        <IsianPanjang label="Keterangan (opsional)" name="keterangan" defaultValue={b.keterangan ?? ""} maxLength={1000} />
                        <Pilihan label="Untuk" name="tim_id" defaultValue={b.tim_id ?? ""}>
                          <option value="">Semua tim</option>
                          {tim.map((t) => (
                            <option key={t.id} value={t.id}>
                              Tim {t.nama} saja
                            </option>
                          ))}
                        </Pilihan>
                      </FormAksi>
                    </Lipatan>
                  ) : null}
                </div>
              </details>
            </li>
          );
        })}
      </ul>
    </SaringCari>
  );
}
