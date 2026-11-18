import { redirect } from "next/navigation";
import { FormAksi } from "@/components/form-aksi";
import { StatusProyekAnggota } from "@/components/status-proyek";
import { Isian, IsianPanjang, Judul, Kotak, Lipatan, TautanTombol } from "@/components/ui";
import { tanggalPanjang } from "@/lib/pertemuan";
import { PILIHAN_STATUS_PROYEK, type StatusProyek } from "@/lib/pilihan-fase5";
import { aksesKelompok, wajibMasuk } from "@/lib/sesi";
import { hapusProyek, ubahProyek } from "../aksi";

type Status = { anggota_id: string; status: StatusProyek; keterangan: string | null };

export default async function HalamanDetailProyek({ params }: PageProps<"/kelompok/[id]/proyek/[proyek]">) {
  const { id, proyek: proyekId } = await params;
  const { supabase, peran } = await wajibMasuk();
  const kelompok = await aksesKelompok(supabase, peran, id);
  if (!kelompok) redirect("/beranda");

  const [{ data: proyek }, { data: dataAnggota }, { data: dataStatus }] = await Promise.all([
    supabase
      .from("proyek_ketaatan")
      .select("id, judul, keterangan, diberikan_pada, tenggat")
      .eq("id", proyekId)
      .eq("kelompok_id", id)
      .maybeSingle(),
    supabase.from("anggota").select("id, nama_lengkap, aktif").eq("kelompok_id", id).order("nama_lengkap"),
    supabase.from("status_proyek").select("anggota_id, status, keterangan").eq("proyek_id", proyekId),
  ]);
  if (!proyek) redirect(`/kelompok/${id}/proyek`);

  const status = new Map(((dataStatus ?? []) as Status[]).map((s) => [s.anggota_id, s]));
  // Anggota aktif, ditambah anggota tidak aktif yang sudah punya status di proyek ini.
  const anggota = (dataAnggota ?? []).filter((a) => a.aktif || status.has(a.id));
  const selesai = [...status.values()].filter((s) => s.status === "selesai").length;

  return (
    <main>
      <Judul kecil={kelompok.nama}>{proyek.judul}</Judul>
      <div className="mb-4">
        <TautanTombol href={`/kelompok/${id}/proyek`}>← Daftar proyek</TautanTombol>
      </div>

      <Kotak>
        <p className="text-sm opacity-80">
          Diberikan {tanggalPanjang(proyek.diberikan_pada)} ·{" "}
          {proyek.tenggat ? `tenggat ${tanggalPanjang(proyek.tenggat)}` : "tanpa tenggat"}
        </p>
        {proyek.keterangan ? <p className="mt-2 whitespace-pre-wrap">{proyek.keterangan}</p> : null}
        <p className="mt-2 font-semibold">
          Selesai {selesai} dari {anggota.length}
        </p>
      </Kotak>

      <Kotak judul="Status anggota">
        {kelompok.bolehUbah ? <p className="mb-1 text-sm opacity-70">Ketuk status; langsung tersimpan.</p> : null}
        {anggota.length === 0 ? (
          <p className="opacity-70">Belum ada anggota aktif.</p>
        ) : (
          <div className="divide-y divide-black/10 dark:divide-white/10">
            {anggota.map((a) =>
              !kelompok.bolehUbah ? (
                <div key={a.id} className="py-3">
                  <p className="font-semibold">{a.nama_lengkap}</p>
                  <p className="text-sm">
                    Status: <strong>{PILIHAN_STATUS_PROYEK[status.get(a.id)?.status ?? "belum"]}</strong>
                    {status.get(a.id)?.keterangan ? ` · ${status.get(a.id)?.keterangan}` : ""}
                  </p>
                </div>
              ) : (
              <StatusProyekAnggota
                key={a.id}
                kelompokId={id}
                proyekId={proyekId}
                anggotaId={a.id}
                nama={a.aktif ? a.nama_lengkap : `${a.nama_lengkap} (tidak aktif)`}
                statusAwal={status.get(a.id)?.status ?? "belum"}
                keteranganAwal={status.get(a.id)?.keterangan ?? null}
              />
              ),
            )}
          </div>
        )}
      </Kotak>

      {kelompok.bolehUbah ? (
      <Lipatan judul="Ubah / hapus proyek">
        <FormAksi aksi={ubahProyek.bind(null, id, proyekId)} tombol="Simpan perubahan" jenisTombol="biasa" tanpaReset kembali={`/kelompok/${id}/proyek`}>
          <Isian label="Judul" name="judul" defaultValue={proyek.judul} required />
          <IsianPanjang label="Keterangan (opsional)" name="keterangan" defaultValue={proyek.keterangan ?? ""} />
          <Isian label="Tanggal diberikan" name="diberikan_pada" type="date" defaultValue={proyek.diberikan_pada} required />
          <Isian label="Tenggat (opsional)" name="tenggat" type="date" defaultValue={proyek.tenggat ?? ""} />
        </FormAksi>
        <FormAksi
          aksi={hapusProyek.bind(null, id, proyekId)}
          tombol="Hapus proyek"
          jenisTombol="bahaya"
          konfirmasi={`Hapus proyek "${proyek.judul}" beserta status semua anggota?`}
        />
      </Lipatan>
      ) : null}
    </main>
  );
}
