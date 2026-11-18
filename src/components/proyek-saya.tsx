import { FormAksi } from "@/components/form-aksi";
import { IsianLaporProyek } from "@/components/isian-lapor-proyek";
import { LaporanProyek } from "@/components/laporan-proyek";
import { Kotak, Lipatan } from "@/components/ui";
import { laporProyekSaya } from "@/lib/aksi-proyek-saya";
import { tanggalPanjang } from "@/lib/pertemuan";
import { PILIHAN_LAPOR_PROYEK, PILIHAN_STATUS_PROYEK, type StatusProyek } from "@/lib/pilihan-fase5";
import { hariIniWib } from "@/lib/profil";
import type { buatClientServer } from "@/lib/supabase/server";

type Supabase = Awaited<ReturnType<typeof buatClientServer>>;

type ProyekSaya = {
  proyek_id: string;
  judul: string;
  keterangan: string | null;
  diberikan_pada: string;
  tenggat: string | null;
  status: StatusProyek;
  alasan: string | null;
  hasil: string | null;
  dilaporkan_sendiri: boolean;
  diubah_pada: string | null;
};

/**
 * Proyek ketaatan kelompok dan laporan milik sendiri (keputusan 36).
 *  - Profil saya: semua proyek.
 *  - Beranda (notifikasi, keputusan 37): hanya yang belum "Sudah selesai"; yang
 *    belum pernah dilaporkan ditandai "Baru". Laporan bisa langsung diisi di sana.
 */
export async function KotakProyekSaya({ supabase, beranda = false }: { supabase: Supabase; beranda?: boolean }) {
  const { data } = await supabase.rpc("proyek_saya");
  const semua = (data ?? []) as ProyekSaya[];
  const proyek = beranda ? semua.filter((p) => p.status !== "selesai") : semua;
  if (proyek.length === 0) return null;
  const jumlahBaru = proyek.filter((p) => !p.diubah_pada).length;
  const hariIni = hariIniWib();
  const label = (s: StatusProyek) => (s in PILIHAN_LAPOR_PROYEK ? PILIHAN_LAPOR_PROYEK[s as keyof typeof PILIHAN_LAPOR_PROYEK] : PILIHAN_STATUS_PROYEK[s]);

  return (
    <Kotak
      judul={
        beranda
          ? `Proyek ketaatan${jumlahBaru ? ` · ${jumlahBaru} baru` : ""}`
          : "Proyek ketaatan saya"
      }
    >
      <p className="mb-2 text-sm opacity-70">
        {beranda
          ? "Proyek dari pemimpin kelompok yang belum selesai. Laporkan perkembangannya di sini; riwayat lengkap ada di Profil saya."
          : "Laporkan perkembangan setiap proyek. Laporan Anda hanya dibaca pemimpin kelompok, ketua tim, dan Admin."}
      </p>
      <ul className="divide-y divide-black/10 dark:divide-white/10">
        {proyek.map((p) => {
          const lewat = p.tenggat !== null && p.tenggat < hariIni && p.status !== "selesai";
          const bisaLapor = p.status === "belum" || p.status === "sedang" || p.status === "selesai";
          return (
            <li key={p.proyek_id} className="py-3">
              <p className="font-semibold">
                {p.judul}
                {!p.diubah_pada ? (
                  <span className="ml-2 rounded-md bg-utama px-1.5 py-0.5 text-xs font-semibold text-white dark:text-black">
                    Baru
                  </span>
                ) : null}
              </p>
              <p className="text-xs opacity-70">
                Diberikan {tanggalPanjang(p.diberikan_pada)}
                {p.tenggat ? ` · tenggat ${tanggalPanjang(p.tenggat)}` : ""}
                {lewat ? " (lewat)" : ""}
              </p>
              {p.keterangan ? <p className="mt-1 text-sm whitespace-pre-wrap">{p.keterangan}</p> : null}
              <p className="mt-1 text-sm">
                Status: <strong>{p.diubah_pada ? label(p.status) : "Belum dilaporkan"}</strong>
                {p.diubah_pada && !p.dilaporkan_sendiri ? " (diisi pemimpin)" : ""}
              </p>
              <LaporanProyek alasan={p.alasan} hasil={p.hasil} sendiri={false} />
              <Lipatan judul={p.diubah_pada ? "Perbarui laporan" : "Laporkan"}>
                <FormAksi aksi={laporProyekSaya.bind(null, p.proyek_id)} tombol="Simpan laporan" tanpaReset>
                  <IsianLaporProyek
                    statusAwal={p.diubah_pada && bisaLapor ? (p.status as keyof typeof PILIHAN_LAPOR_PROYEK) : null}
                    alasanAwal={p.alasan}
                    hasilAwal={p.hasil}
                  />
                </FormAksi>
              </Lipatan>
            </li>
          );
        })}
      </ul>
    </Kotak>
  );
}
