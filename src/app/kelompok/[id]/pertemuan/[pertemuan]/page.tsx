import { redirect } from "next/navigation";
import { DaftarHadir, type BarisHadir } from "@/components/daftar-hadir";
import { FormAksi } from "@/components/form-aksi";
import { FormAlasan } from "@/components/form-alasan";
import { Isian, IsianPanjang, Judul, Kotak, Lipatan, TautanTombol } from "@/components/ui";
import { waktuWib } from "@/lib/format";
import { rupiah, tanggalPanjang, type Alasan } from "@/lib/pertemuan";
import { hariIniWib } from "@/lib/profil";
import { kelompokKelolaan, wajibMasuk } from "@/lib/sesi";
import { bukaKembali, hapusPertemuan, simpanRingkasan, tutupAbsensi, ubahTanggal } from "../aksi";

type Kehadiran = {
  anggota_id: string;
  hadir: boolean;
  alasan: Alasan | null;
  alasan_catatan: string | null;
};

export default async function HalamanPertemuan({ params }: PageProps<"/kelompok/[id]/pertemuan/[pertemuan]">) {
  const { id, pertemuan: pertemuanId } = await params;
  const { supabase, peran } = await wajibMasuk();
  const kelompok = await kelompokKelolaan(supabase, peran, id);
  if (!kelompok) redirect("/beranda");

  const [{ data: pertemuan }, { data: dataAnggota }, { data: dataHadir }] = await Promise.all([
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
  ]);
  if (!pertemuan) redirect(`/kelompok/${id}/pertemuan`);

  const anggota = dataAnggota ?? [];
  const nama = new Map(anggota.map((a) => [a.id, a.nama_lengkap as string]));
  const kehadiran = new Map(((dataHadir ?? []) as Kehadiran[]).map((k) => [k.anggota_id, k]));
  const tertutup = Boolean(pertemuan.ditutup_pada);
  const judul = tanggalPanjang(pertemuan.tanggal);

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
          <DaftarHadir
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
