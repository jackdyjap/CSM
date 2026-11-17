import Link from "next/link";
import { redirect } from "next/navigation";
import { Judul, Kotak, TautanTombol } from "@/components/ui";
import { PILIHAN_ALASAN, tanggalPanjang, type Alasan } from "@/lib/pertemuan";
import { BATAS_ABSEN, PILIHAN_STATUS_PROYEK, type StatusProyek } from "@/lib/pilihan-fase5";
import { aksesKelompok, wajibMasuk } from "@/lib/sesi";

type Baris = {
  anggota_id: string;
  nama_lengkap: string;
  jenis: "absen" | "proyek";
  absen_beruntun: number | null;
  terakhir_hadir: string | null;
  alasan_terakhir: Alasan | null;
  proyek_id: string | null;
  proyek_judul: string | null;
  tenggat: string | null;
  status: StatusProyek | null;
};

export default async function HalamanTindakLanjut({ params }: PageProps<"/kelompok/[id]/tindak-lanjut">) {
  const { id } = await params;
  const { supabase, peran } = await wajibMasuk();
  const kelompok = await aksesKelompok(supabase, peran, id);
  if (!kelompok) redirect("/beranda");

  const { data, error } = await supabase.rpc("tindak_lanjut", { p_kelompok: id, p_batas_absen: BATAS_ABSEN });
  const baris = (data ?? []) as Baris[];
  const absen = baris.filter((b) => b.jenis === "absen").sort((a, b) => (b.absen_beruntun ?? 0) - (a.absen_beruntun ?? 0));
  const proyek = baris.filter((b) => b.jenis === "proyek");
  const profil = (anggotaId: string) => `/kelompok/${id}/anggota/${anggotaId}#catatan`;

  return (
    <main>
      <Judul kecil={kelompok.nama}>Tindak lanjut</Judul>
      <div className="mb-4">
        <TautanTombol href={`/kelompok/${id}`}>← Kelompok</TautanTombol>
      </div>

      {error ? (
        <Kotak>
          <p className="opacity-70">Daftar tindak lanjut belum bisa dimuat. Coba muat ulang halaman.</p>
        </Kotak>
      ) : null}

      <Kotak judul={`Absen ${BATAS_ABSEN} pertemuan atau lebih berturut-turut (${absen.length})`}>
        <p className="mb-2 text-sm opacity-70">
          Dihitung dari pertemuan yang absensinya sudah ditutup. Ketuk nama untuk membuka profil dan
          menulis catatan tindak lanjut.
        </p>
        {absen.length === 0 ? (
          <p className="opacity-70">Tidak ada. Semua anggota aktif hadir dalam {BATAS_ABSEN} pertemuan terakhir.</p>
        ) : (
          <ul className="divide-y divide-black/10 dark:divide-white/10">
            {absen.map((b) => (
              <li key={b.anggota_id}>
                <Link href={profil(b.anggota_id)} className="-mx-2 block rounded-lg px-2 py-3 hover:bg-black/5 dark:hover:bg-white/10">
                  <span className="flex flex-wrap items-center gap-2">
                    <span className="font-semibold">{b.nama_lengkap}</span>
                    <span className="rounded-md border border-red-700/50 px-2 py-0.5 text-xs font-semibold text-red-800 dark:text-red-300">
                      Absen {b.absen_beruntun}×
                    </span>
                  </span>
                  <span className="mt-1 block text-sm opacity-70">
                    Terakhir hadir: {b.terakhir_hadir ? tanggalPanjang(b.terakhir_hadir) : "belum pernah tercatat"}
                    {b.alasan_terakhir ? ` · alasan terakhir: ${PILIHAN_ALASAN[b.alasan_terakhir]}` : ""}
                  </span>
                </Link>
              </li>
            ))}
          </ul>
        )}
      </Kotak>

      <Kotak judul={`Proyek ketaatan belum selesai (${proyek.length})`}>
        <p className="mb-2 text-sm opacity-70">
          Proyek yang tenggatnya sudah lewat tetapi belum selesai, dan yang ditandai &ldquo;Tidak dikerjakan&rdquo;.
        </p>
        {proyek.length === 0 ? (
          <p className="opacity-70">Tidak ada.</p>
        ) : (
          <ul className="divide-y divide-black/10 dark:divide-white/10">
            {proyek.map((b) => (
              <li key={`${b.proyek_id}-${b.anggota_id}`}>
                <Link href={profil(b.anggota_id)} className="-mx-2 block rounded-lg px-2 py-3 hover:bg-black/5 dark:hover:bg-white/10">
                  <span className="flex flex-wrap items-center gap-2">
                    <span className="font-semibold">{b.nama_lengkap}</span>
                    <span className="rounded-md border border-amber-700/50 px-2 py-0.5 text-xs font-semibold text-amber-800 dark:text-amber-300">
                      {b.status ? PILIHAN_STATUS_PROYEK[b.status] : "Belum"}
                    </span>
                  </span>
                  <span className="mt-1 block text-sm opacity-70">
                    {b.proyek_judul}
                    {b.tenggat ? ` · tenggat ${tanggalPanjang(b.tenggat)}` : ""}
                  </span>
                </Link>
              </li>
            ))}
          </ul>
        )}
      </Kotak>
    </main>
  );
}
