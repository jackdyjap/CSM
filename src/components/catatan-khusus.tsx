import { hapusCatatan, tulisCatatan, ubahCatatan } from "@/lib/aksi-catatan";
import { PILIHAN_JENIS_CATATAN, type JenisCatatan } from "@/lib/pilihan-fase5";
import { tanggalPanjang } from "@/lib/pertemuan";
import type { buatClientServer } from "@/lib/supabase/server";
import { FormAksi } from "./form-aksi";
import { IsianPanjang, Kotak, Lipatan, Pilihan } from "./ui";

type Supabase = Awaited<ReturnType<typeof buatClientServer>>;

type Catatan = {
  id: string;
  tanggal: string;
  jenis: JenisCatatan;
  isi: string;
  penulis_nama: string | null;
  diubah_pada: string;
  dibuat_pada: string;
};

function PilihJenis({ nilai }: { nilai?: JenisCatatan }) {
  return (
    <Pilihan label="Jenis catatan" name="jenis" defaultValue={nilai ?? "umum"} required>
      {Object.entries(PILIHAN_JENIS_CATATAN).map(([k, v]) => (
        <option key={k} value={k}>
          {v}
        </option>
      ))}
    </Pilihan>
  );
}

/**
 * Catatan khusus tentang seorang anggota. Dibaca lewat fungsi baca_catatan
 * (tercatat di log). Bila pengguna tidak berhak (termasuk catatan tentang
 * dirinya sendiri), bagian ini tidak ditampilkan sama sekali.
 */
export async function CatatanKhusus({
  supabase,
  kelompokId,
  anggotaId,
  nama,
  bolehTulis,
  bolehKoreksi,
}: {
  supabase: Supabase;
  kelompokId: string;
  anggotaId: string;
  nama: string;
  /** Pemimpin/wakil kelompok ini atau Admin (keputusan 18). */
  bolehTulis: boolean;
  /** Pemimpin/wakil kelompok ini atau Admin (keputusan 15). */
  bolehKoreksi: boolean;
}) {
  const { data, error } = await supabase.rpc("baca_catatan", { p_anggota: anggotaId });
  if (error) return null;
  const catatan = (data ?? []) as Catatan[];

  return (
    <section id="catatan">
      <Kotak judul={`Catatan khusus (${catatan.length})`}>
        <p className="mb-3 text-xs opacity-70">
          Hanya terlihat oleh pemimpin kelompok, Ketua Tim, dan Admin. {nama} tidak bisa melihat
          catatan ini. Setiap pembacaan tercatat.
        </p>

        {catatan.length === 0 ? (
          <p className="mb-3 opacity-70">Belum ada catatan.</p>
        ) : (
          <ul className="mb-3 divide-y divide-black/10 dark:divide-white/10">
            {catatan.map((c) => (
              <li key={c.id} className="py-3">
                <p className="mb-1 text-xs opacity-70">
                  {tanggalPanjang(c.tanggal)} · {PILIHAN_JENIS_CATATAN[c.jenis]} · {c.penulis_nama ?? "—"}
                  {c.diubah_pada !== c.dibuat_pada ? " · diubah" : ""}
                </p>
                <p className="whitespace-pre-wrap">{c.isi}</p>
                {bolehKoreksi ? (
                  <Lipatan judul="Ubah / hapus catatan">
                    <FormAksi
                      aksi={ubahCatatan.bind(null, kelompokId, anggotaId, c.id)}
                      tombol="Simpan perubahan"
                      jenisTombol="biasa"
                      tanpaReset
                      kembali={`/kelompok/${kelompokId}`}
                    >
                      <PilihJenis nilai={c.jenis} />
                      <IsianPanjang label="Isi catatan" name="isi" defaultValue={c.isi} required maxLength={2000} />
                    </FormAksi>
                    <FormAksi
                      aksi={hapusCatatan.bind(null, kelompokId, anggotaId, c.id)}
                      tombol="Hapus catatan"
                      jenisTombol="bahaya"
                      konfirmasi="Hapus catatan ini?"
                    />
                  </Lipatan>
                ) : null}
              </li>
            ))}
          </ul>
        )}

        {bolehTulis ? (
          <Lipatan judul="Tulis catatan baru">
            <FormAksi
              aksi={tulisCatatan.bind(null, kelompokId, anggotaId)}
              tombol="Simpan catatan"
              kembali={`/kelompok/${kelompokId}`}
            >
              <PilihJenis />
              <IsianPanjang
                label="Isi catatan"
                name="isi"
                required
                maxLength={2000}
                placeholder="Contoh: sudah dihubungi lewat WA, sedang sakit; akan dikunjungi Sabtu."
              />
            </FormAksi>
          </Lipatan>
        ) : (
          <p className="text-xs opacity-70">Catatan baru ditulis oleh pemimpin/wakil kelompok atau Admin.</p>
        )}
      </Kotak>
    </section>
  );
}
