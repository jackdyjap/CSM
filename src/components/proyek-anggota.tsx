import Link from "next/link";
import { PILIHAN_STATUS_PROYEK, type StatusProyek } from "@/lib/pilihan-fase5";
import { tanggalPanjang } from "@/lib/pertemuan";
import { hariIniWib } from "@/lib/profil";
import type { buatClientServer } from "@/lib/supabase/server";
import { LaporanProyek } from "./laporan-proyek";
import { StatusProyekAnggota } from "./status-proyek";
import { Kotak } from "./ui";

type Supabase = Awaited<ReturnType<typeof buatClientServer>>;

type Proyek = { id: string; judul: string; tenggat: string | null; diberikan_pada: string };
type Status = {
  proyek_id: string;
  status: StatusProyek;
  keterangan: string | null;
  alasan: string | null;
  hasil: string | null;
  dilaporkan_sendiri: boolean;
};

/**
 * Status semua proyek ketaatan kelompok untuk SATU anggota (keputusan 18).
 * Pengelola (pemimpin/wakil/Admin) bisa langsung mengubah; Ketua Tim membaca saja.
 */
export async function ProyekAnggota({
  supabase,
  kelompokId,
  anggotaId,
  bolehUbah,
}: {
  supabase: Supabase;
  kelompokId: string;
  anggotaId: string;
  bolehUbah: boolean;
}) {
  const [{ data: dataProyek }, { data: dataStatus }] = await Promise.all([
    supabase
      .from("proyek_ketaatan")
      .select("id, judul, tenggat, diberikan_pada")
      .eq("kelompok_id", kelompokId)
      .order("diberikan_pada", { ascending: false }),
    supabase.from("status_proyek").select("proyek_id, status, keterangan, alasan, hasil, dilaporkan_sendiri").eq("anggota_id", anggotaId),
  ]);
  const proyek = (dataProyek ?? []) as Proyek[];
  const status = new Map(((dataStatus ?? []) as Status[]).map((s) => [s.proyek_id, s]));
  const hariIni = hariIniWib();
  const selesai = proyek.filter((p) => status.get(p.id)?.status === "selesai").length;

  return (
    <section id="proyek">
      <Kotak judul={proyek.length ? `Proyek ketaatan (selesai ${selesai} dari ${proyek.length})` : "Proyek ketaatan"}>
        {proyek.length === 0 ? (
          <p className="opacity-70">
            Kelompok ini belum punya proyek ketaatan.{" "}
            {bolehUbah ? (
              <Link href={`/kelompok/${kelompokId}/proyek`} className="underline">
                Buat proyek
              </Link>
            ) : null}
          </p>
        ) : (
          <div className="divide-y divide-black/10 dark:divide-white/10">
            {proyek.map((p) => {
              const s = status.get(p.id);
              const lewat = p.tenggat !== null && p.tenggat < hariIni && s?.status !== "selesai";
              const judul = `${p.judul}${p.tenggat ? ` · tenggat ${tanggalPanjang(p.tenggat)}` : ""}${lewat ? " (lewat)" : ""}`;
              return bolehUbah ? (
                <StatusProyekAnggota
                  key={p.id}
                  kelompokId={kelompokId}
                  proyekId={p.id}
                  anggotaId={anggotaId}
                  nama={judul}
                  statusAwal={s?.status ?? "belum"}
                  keteranganAwal={s?.keterangan ?? null}
                  laporan={{ alasan: s?.alasan ?? null, hasil: s?.hasil ?? null, sendiri: s?.dilaporkan_sendiri ?? false }}
                />
              ) : (
                <div key={p.id} className="py-3">
                  <p className="font-semibold">{judul}</p>
                  <p className="text-sm">
                    Status: <strong>{PILIHAN_STATUS_PROYEK[s?.status ?? "belum"]}</strong>
                    {s?.keterangan ? ` · ${s.keterangan}` : ""}
                  </p>
                  <LaporanProyek alasan={s?.alasan ?? null} hasil={s?.hasil ?? null} sendiri={s?.dilaporkan_sendiri ?? false} />
                </div>
              );
            })}
          </div>
        )}
      </Kotak>
    </section>
  );
}
