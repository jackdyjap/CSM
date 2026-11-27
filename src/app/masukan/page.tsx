import { FormAksi } from "@/components/form-aksi";
import { LabelStatus } from "@/components/masukan";
import { Isian, IsianPanjang, Judul, Kotak, Pilihan, TautanTombol } from "@/components/ui";
import { kirimMasukan } from "@/lib/aksi-masukan";
import { waktuWib } from "@/lib/format";
import {
  JENIS_MASUKAN,
  PANJANG_ISI_MAKS,
  PANJANG_JUDUL_MAKS,
  pilihanTujuan,
  TUJUAN_MASUKAN,
  type JenisMasukan,
  type StatusMasukan,
  type TujuanMasukan,
} from "@/lib/masukan";
import { wajibMasuk } from "@/lib/sesi";

type MasukanSaya = {
  id: string;
  tujuan: TujuanMasukan;
  kelompok_nama: string | null;
  tim_nama: string | null;
  jenis: JenisMasukan;
  judul: string;
  isi: string;
  anonim: boolean;
  status: StatusMasukan;
  balasan: string | null;
  dibalas_pada: string | null;
  dibuat_pada: string;
};

/** Kirim masukan (keluhan, permasalahan, usulan) dan lihat tanggapannya (keputusan 28). */
export default async function HalamanMasukan() {
  const { supabase, peran } = await wajibMasuk();
  const { data } = await supabase.rpc("masukan_saya");
  const daftar = (data ?? []) as MasukanSaya[];
  const tujuan = pilihanTujuan(peran);
  const bisaMenerima = peran.admin || peran.ketua_tim.length > 0 || peran.pemimpin.length > 0;

  return (
    <main>
      <Judul>Masukan</Judul>
      <div className="mb-4 flex flex-wrap gap-2">
        <TautanTombol href="/beranda">← Beranda</TautanTombol>
        {bisaMenerima ? <TautanTombol href="/masukan/masuk">Laporan Masukan →</TautanTombol> : null}
      </div>

      <Kotak judul="Kirim masukan">
        <p className="mb-3 text-sm opacity-70">
          Sampaikan keluhan, permasalahan, atau usulan perbaikan. Anda bisa melihat status dan balasannya di
          halaman ini.
        </p>
        <FormAksi aksi={kirimMasukan} tombol="Kirim masukan" kembali="/beranda">
          <Pilihan label="Ditujukan kepada" name="tujuan" required defaultValue="">
            <option value="" disabled>
              Pilih…
            </option>
            {tujuan.map((t) => (
              <option key={t.nilai} value={t.nilai}>
                {t.label}
              </option>
            ))}
          </Pilihan>
          <Pilihan label="Jenis" name="jenis" required defaultValue="">
            <option value="" disabled>
              Pilih…
            </option>
            {Object.entries(JENIS_MASUKAN).map(([k, v]) => (
              <option key={k} value={k}>
                {v}
              </option>
            ))}
          </Pilihan>
          <Isian label="Judul singkat" name="judul" maxLength={PANJANG_JUDUL_MAKS} required />
          <IsianPanjang label="Isi masukan" name="isi" rows={5} maxLength={PANJANG_ISI_MAKS} required />
          <label className="mb-3 flex items-start gap-3">
            <input type="checkbox" name="anonim" value="ya" className="mt-1 h-5 w-5 flex-none" />
            <span className="text-sm">
              <strong>Kirim tanpa nama.</strong> Penerima tidak melihat nama Anda, tetapi Anda tetap bisa
              membaca balasannya. Nama pengirim hanya bisa dilihat Admin bila ada penyalahgunaan.
            </span>
          </label>
        </FormAksi>
      </Kotak>

      <Kotak judul="Masukan yang saya kirim">
        {daftar.length === 0 ? (
          <p className="opacity-70">Belum ada.</p>
        ) : (
          <ul className="divide-y divide-black/10 dark:divide-white/10">
            {daftar.map((m) => (
              <li key={m.id} className="py-3">
                <div className="flex items-start justify-between gap-2">
                  <p className="font-semibold">{m.judul}</p>
                  <LabelStatus status={m.status} />
                </div>
                <p className="text-xs opacity-70">
                  {JENIS_MASUKAN[m.jenis]} · untuk {TUJUAN_MASUKAN[m.tujuan]}
                  {m.tujuan === "pemimpin" && m.kelompok_nama ? ` ${m.kelompok_nama}` : ""}
                  {m.tujuan === "ketua_tim" && m.tim_nama ? ` ${m.tim_nama}` : ""}
                  {m.anonim ? " · tanpa nama" : ""} · {waktuWib(m.dibuat_pada)}
                </p>
                <p className="mt-1 text-sm whitespace-pre-line">{m.isi}</p>
                {m.balasan ? (
                  <div className="mt-2 rounded-lg bg-black/5 p-2 text-sm dark:bg-white/10">
                    <p className="text-xs font-semibold opacity-70">
                      Balasan{m.dibalas_pada ? ` · ${waktuWib(m.dibalas_pada)}` : ""}
                    </p>
                    <p className="whitespace-pre-line">{m.balasan}</p>
                  </div>
                ) : null}
              </li>
            ))}
          </ul>
        )}
      </Kotak>
    </main>
  );
}
