import { PILIHAN_ALASAN, tanggalPanjang, type Alasan } from "@/lib/pertemuan";
import type { buatClientServer } from "@/lib/supabase/server";
import { Kotak } from "./ui";

type Supabase = Awaited<ReturnType<typeof buatClientServer>>;
type Baris = { tanggal: string; kelompok_nama: string; hadir: boolean; cara: string | null; alasan: Alasan | null };

const CARA: Record<string, string> = { scan_sendiri: "check-in QR", scan_pemimpin: "scan kartu", manual: "dicatat pemimpin" };

/**
 * Riwayat kehadiran anggota yang sedang login (fungsi riwayat_kehadiran_saya).
 * Hanya kategori alasan yang tampil; catatan pemimpin tidak pernah ditampilkan.
 */
export async function RiwayatKehadiran({ supabase, jumlah = 12 }: { supabase: Supabase; jumlah?: number }) {
  const { data, error } = await supabase.rpc("riwayat_kehadiran_saya", { p_jumlah: jumlah });
  if (error) return null;
  const baris = (data ?? []) as Baris[];
  const hadir = baris.filter((b) => b.hadir).length;

  return (
    <section id="riwayat">
      <Kotak judul={baris.length ? `Riwayat kehadiran (hadir ${hadir} dari ${baris.length})` : "Riwayat kehadiran"}>
        {baris.length === 0 ? (
          <p className="opacity-70">Belum ada pertemuan yang tercatat.</p>
        ) : (
          <ul className="divide-y divide-black/10 dark:divide-white/10">
            {baris.map((b) => (
              <li key={`${b.tanggal}-${b.kelompok_nama}`} className="flex flex-wrap items-center justify-between gap-x-3 py-2">
                <span>{tanggalPanjang(b.tanggal)}</span>
                <span className={`text-sm font-semibold ${b.hadir ? "text-green-800 dark:text-green-300" : "text-red-800 dark:text-red-300"}`}>
                  {b.hadir
                    ? `Hadir${b.cara ? ` · ${CARA[b.cara] ?? b.cara}` : ""}`
                    : `Tidak hadir${b.alasan ? ` · ${PILIHAN_ALASAN[b.alasan]}` : ""}`}
                </span>
              </li>
            ))}
          </ul>
        )}
        <p className="mt-2 text-xs opacity-70">Menampilkan {jumlah} pertemuan terakhir.</p>
      </Kotak>
    </section>
  );
}
