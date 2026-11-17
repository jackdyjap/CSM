import { redirect } from "next/navigation";
import { BuktiPersembahan, type BarisBukti } from "@/components/bukti-persembahan";
import { DaftarHadir, type BarisHadir } from "@/components/daftar-hadir";
import { PemindaiKartu } from "@/components/pemindai-kartu";
import { FormAksi } from "@/components/form-aksi";
import { FormAlasan } from "@/components/form-alasan";
import { Isian, IsianPanjang, Judul, Kotak, Lipatan, TautanTombol } from "@/components/ui";
import { waktuWib } from "@/lib/format";
import { PILIHAN_ALASAN, rupiah, tanggalPanjang, type Alasan } from "@/lib/pertemuan";
import { hariIniWib } from "@/lib/profil";
import { aksesKelompok, wajibMasuk } from "@/lib/sesi";
import { bukaKembali, hapusPertemuan, scanKartu, simpanRingkasan, tutupAbsensi, ubahTanggal } from "../aksi";

type Kehadiran = {
  anggota_id: string;
  hadir: boolean;
  alasan: Alasan | null;
  alasan_catatan: string | null;
};

export default async function HalamanPertemuan({ params }: PageProps<"/kelompok/[id]/pertemuan/[pertemuan]">) {
  const { id, pertemuan: pertemuanId } = await params;
  const { supabase, peran } = await wajibMasuk();
  const kelompok = await aksesKelompok(supabase, peran, id);
  if (!kelompok) redirect("/beranda");

  const [{ data: pertemuan }, { data: dataAnggota }, { data: dataHadir }, { data: dataBukti }] = await Promise.all([
    supabase
      .from("pertemuan")
      .select("id, tanggal, persembahan, catatan, ditutup_pada")
      .eq("id", pertemuanId)
      .eq("kelompok_id", id)
      .maybeSingle(),
    supabase.from("anggota").select("id, nama_lengkap, aktif").eq("kelompok_id", id).order("nama_lengkap"),
    supabase
      .from("kehadiran")
      .select("anggota_id, hadir, alasan, alasan_catatan")
      .eq("pertemuan_id", pertemuanId),
    supabase
      .from("bukti_persembahan")
      .select("id, lokasi, nama_berkas, jenis, ukuran")
      .eq("pertemuan_id", pertemuanId)
      .order("dibuat_pada"),
  ]);
  if (!pertemuan) redirect(`/kelompok/${id}/pertemuan`);

  const anggota = dataAnggota ?? [];
  const nama = new Map(anggota.map((a) => [a.id, a.nama_lengkap as string]));
  const kehadiran = new Map(((dataHadir ?? []) as Kehadiran[]).map((k) => [k.anggota_id, k]));
  const tertutup = Boolean(pertemuan.ditutup_pada);

  // Tautan sementara (1 jam) untuk membuka bukti di folder privat.
  const barisBukti = dataBukti ?? [];
  const { data: tautanBukti } = barisBukti.length
    ? await supabase.storage.from("bukti-persembahan").createSignedUrls(barisBukti.map((b) => b.lokasi), 3600)
    : { data: [] };
  const petaTautan = new Map((tautanBukti ?? []).map((t) => [t.path, t.signedUrl]));
  const bukti: BarisBukti[] = barisBukti.map((b) => ({
    id: b.id,
    nama_berkas: b.nama_berkas,
    jenis: b.jenis,
    ukuran: b.ukuran,
    tautan: petaTautan.get(b.lokasi) ?? null,
  }));
  const judul = tanggalPanjang(pertemuan.tanggal);

  if (!kelompok.bolehUbah) {
    const hadirNama = [...kehadiran.values()]
      .filter((k) => k.hadir)
      .map((k) => nama.get(k.anggota_id) ?? "?")
      .sort((a, b) => a.localeCompare(b, "id"));
    const tidakHadir = [...kehadiran.values()]
      .filter((k) => !k.hadir)
      .map((k) => ({ ...k, nama: nama.get(k.anggota_id) ?? "?" }))
      .sort((a, b) => a.nama.localeCompare(b.nama, "id"));
    return (
      <main>
        <Judul kecil={`${kelompok.nama} · baca saja`}>{judul}</Judul>
        <div className="mb-4">
          <TautanTombol href={`/kelompok/${id}/pertemuan`}>← Daftar pertemuan</TautanTombol>
        </div>
        <Kotak judul={tertutup ? `Hadir ${hadirNama.length} dari ${kehadiran.size}` : `Hadir ${hadirNama.length} (absensi belum ditutup)`}>
          {tertutup ? (
            <p className="mb-3 text-sm opacity-70">Absensi ditutup {waktuWib(pertemuan.ditutup_pada as string)}.</p>
          ) : null}
          <p>{hadirNama.length ? hadirNama.join(", ") : <span className="opacity-70">Belum ada yang ditandai hadir.</span>}</p>
          {tidakHadir.length > 0 ? (
            <>
              <h3 className="mt-4 mb-1 font-semibold">Tidak hadir ({tidakHadir.length})</h3>
              <ul className="divide-y divide-black/10 dark:divide-white/10">
                {tidakHadir.map((k) => (
                  <li key={k.anggota_id} className="py-2">
                    <span className="font-medium">{k.nama}</span>
                    <span className="text-sm opacity-80">
                      {" · "}
                      {k.alasan ? PILIHAN_ALASAN[k.alasan] : "alasan belum diisi"}
                      {k.alasan_catatan ? ` · ${k.alasan_catatan}` : ""}
                    </span>
                  </li>
                ))}
              </ul>
            </>
          ) : null}
        </Kotak>
        <Kotak judul="Persembahan & catatan">
          <p className="text-lg font-semibold">
            {pertemuan.persembahan === null ? <span className="font-normal opacity-70">Persembahan belum diisi</span> : rupiah(pertemuan.persembahan)}
          </p>
          {pertemuan.catatan ? <p className="mt-2 whitespace-pre-wrap">{pertemuan.catatan}</p> : null}
          <div className="mt-4 border-t border-black/10 pt-3 dark:border-white/10">
            <BuktiPersembahan kelompokId={id} pertemuanId={pertemuanId} daftar={bukti} bolehUbah={false} />
          </div>
        </Kotak>
      </main>
    );
  }

  return (
    <main>
      <Judul kecil={kelompok.nama}>{judul}</Judul>
      <div className="mb-4">
        <TautanTombol href={`/kelompok/${id}/pertemuan`}>← Daftar pertemuan</TautanTombol>
      </div>

      {tertutup ? (
        <SetelahDitutup
          kelompokId={id}
          pertemuanId={pertemuanId}
          ditutupPada={pertemuan.ditutup_pada as string}
          hadir={[...kehadiran.values()].filter((k) => k.hadir).map((k) => nama.get(k.anggota_id) ?? "?")}
          tidakHadir={[...kehadiran.values()]
            .filter((k) => !k.hadir)
            .map((k) => ({ ...k, nama: nama.get(k.anggota_id) ?? "?" }))
            .sort((a, b) => a.nama.localeCompare(b.nama, "id"))}
        />
      ) : (
        <Kotak>
          <PemindaiKartu aksi={scanKartu.bind(null, id, pertemuanId)} />
          <DaftarHadir
            // dipasang ulang saat data hadir dari server berubah (mis. setelah scan kartu)
            key={[...kehadiran.values()].filter((k) => k.hadir).map((k) => k.anggota_id).sort().join(",")}
            kelompokId={id}
            pertemuanId={pertemuanId}
            anggota={anggota.map(
              (a): BarisHadir => ({
                id: a.id,
                nama: a.nama_lengkap,
                hadir: Boolean(kehadiran.get(a.id)?.hadir),
                aktif: a.aktif,
              }),
            )}
          />
          <div className="mt-5 border-t border-black/10 pt-4 dark:border-white/10">
            <p className="mb-3 text-sm opacity-70">
              Setelah semua yang hadir ditandai, tutup absensi. Anggota aktif yang belum ditandai akan
              tercatat tidak hadir, lalu alasannya bisa diisi.
            </p>
            <FormAksi
              aksi={tutupAbsensi.bind(null, id, pertemuanId)}
              tombol="Tutup absensi"
              konfirmasi="Tutup absensi sekarang? Anggota yang belum ditandai akan tercatat tidak hadir."
            />
          </div>
        </Kotak>
      )}

      <Kotak judul="Persembahan & catatan">
        <FormAksi aksi={simpanRingkasan.bind(null, id, pertemuanId)} tombol="Simpan" tanpaReset>
          <Isian
            label="Persembahan (Rp)"
            name="persembahan"
            inputMode="numeric"
            autoComplete="off"
            placeholder="Contoh: 150.000"
            defaultValue={pertemuan.persembahan === null ? "" : rupiah(pertemuan.persembahan).replace("Rp ", "")}
            keterangan={pertemuan.persembahan === null ? "Belum diisi." : `Tersimpan: ${rupiah(pertemuan.persembahan)}`}
          />
          <IsianPanjang
            label="Catatan pertemuan (opsional)"
            name="catatan"
            defaultValue={pertemuan.catatan ?? ""}
            placeholder="Contoh: bahan yang dibahas"
          />
        </FormAksi>
        <div className="mt-4 border-t border-black/10 pt-3 dark:border-white/10">
          <BuktiPersembahan kelompokId={id} pertemuanId={pertemuanId} daftar={bukti} bolehUbah />
        </div>
      </Kotak>

      <Lipatan judul="Ubah tanggal / hapus pertemuan">
        <FormAksi aksi={ubahTanggal.bind(null, id, pertemuanId)} tombol="Simpan tanggal" jenisTombol="biasa" tanpaReset>
          <Isian label="Tanggal pertemuan" name="tanggal" type="date" max={hariIniWib()} defaultValue={pertemuan.tanggal} required />
        </FormAksi>
        <p className="text-sm opacity-70">
          Hapus hanya bila pertemuan ini salah dicatat. Semua data kehadirannya ikut terhapus.
        </p>
        <FormAksi
          aksi={hapusPertemuan.bind(null, id, pertemuanId)}
          tombol="Hapus pertemuan ini"
          jenisTombol="bahaya"
          konfirmasi={`Hapus pertemuan ${judul} beserta seluruh data kehadirannya?`}
        />
      </Lipatan>
    </main>
  );
}

function SetelahDitutup({
  kelompokId,
  pertemuanId,
  ditutupPada,
  hadir,
  tidakHadir,
}: {
  kelompokId: string;
  pertemuanId: string;
  ditutupPada: string;
  hadir: string[];
  tidakHadir: (Kehadiran & { nama: string })[];
}) {
  const tanpaAlasan = tidakHadir.filter((k) => !k.alasan).length;
  return (
    <>
      <Kotak judul={`Hadir ${hadir.length} dari ${hadir.length + tidakHadir.length}`}>
        <p className="mb-3 text-sm opacity-70">Absensi ditutup {waktuWib(ditutupPada)}.</p>
        {hadir.length > 0 ? (
          <p className="mb-4">{[...hadir].sort((a, b) => a.localeCompare(b, "id")).join(", ")}</p>
        ) : (
          <p className="mb-4 opacity-70">Tidak ada yang ditandai hadir.</p>
        )}
        <FormAksi
          aksi={bukaKembali.bind(null, kelompokId, pertemuanId)}
          tombol="Buka kembali absensi"
          jenisTombol="biasa"
        />
      </Kotak>

      {tidakHadir.length > 0 ? (
        <Kotak judul={`Tidak hadir (${tidakHadir.length})`}>
          <p className="mb-1 text-sm opacity-70">
            {tanpaAlasan > 0
              ? `${tanpaAlasan} belum ada alasannya. Pilih alasan lalu Simpan; boleh diisi belakangan.`
              : "Semua alasan sudah diisi."}
          </p>
          <div className="divide-y divide-black/10 dark:divide-white/10">
            {tidakHadir.map((k) => (
              <FormAlasan
                key={k.anggota_id}
                kelompokId={kelompokId}
                pertemuanId={pertemuanId}
                anggotaId={k.anggota_id}
                nama={k.nama}
                alasanAwal={k.alasan}
                catatanAwal={k.alasan_catatan}
              />
            ))}
          </div>
        </Kotak>
      ) : null}
    </>
  );
}
