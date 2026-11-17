import Link from "next/link";
import { rupiah, tanggalPanjang } from "@/lib/pertemuan";
import { Kotak } from "./ui";

export type Baris = {
  kelompok_id: string;
  nama: string;
  anggota_aktif: number;
  status_lapor: "sudah" | "berlangsung" | "belum";
  pertemuan_terakhir: string | null;
  hadir_4_pekan: number | null;
  persembahan_bulan_ini: number;
  tindak_lanjut: number;
};

const LABEL_LAPOR = {
  sudah: { teks: "Sudah lapor", gaya: "border-green-700/50 text-green-800 dark:text-green-300" },
  berlangsung: { teks: "Sedang berlangsung", gaya: "border-amber-700/50 text-amber-800 dark:text-amber-300" },
  belum: { teks: "Belum lapor", gaya: "border-red-700/50 text-red-800 dark:text-red-300" },
} as const;

const formatBulan = new Intl.DateTimeFormat("id-ID", { month: "long", year: "numeric", timeZone: "UTC" });
const formatTanggalPendek = new Intl.DateTimeFormat("id-ID", { day: "numeric", month: "short", timeZone: "UTC" });
const tanggalPendek = (t: string) => formatTanggalPendek.format(new Date(`${t}T00:00:00Z`));

/** Tampilan ringkasan tim (dashboard Ketua Tim). Data dari fungsi database ringkasan_tim. */
export function RingkasanTim({ baris, hariIni }: { baris: Baris[]; hariIni: string }) {
  const senin = (() => {
    const d = new Date(`${hariIni}T00:00:00Z`);
    d.setUTCDate(d.getUTCDate() - ((d.getUTCDay() + 6) % 7));
    return d.toISOString().slice(0, 10);
  })();
  const sudah = baris.filter((b) => b.status_lapor === "sudah").length;
  const totalPersembahan = baris.reduce((n, b) => n + Number(b.persembahan_bulan_ini ?? 0), 0);
  const totalTindakLanjut = baris.reduce((n, b) => n + (b.tindak_lanjut ?? 0), 0);
  const bulan = formatBulan.format(new Date(`${hariIni}T00:00:00Z`));

  return (
    <>
      <Kotak>
        <dl className="grid grid-cols-2 gap-3">
          <div className="rounded-lg bg-black/5 p-3 dark:bg-white/10">
            <dt className="text-xs opacity-70">Sudah lapor pekan ini</dt>
            <dd className="text-2xl font-bold">
              {sudah}
              <span className="text-base font-normal opacity-70"> / {baris.length} kelompok</span>
            </dd>
          </div>
          <div className="rounded-lg bg-black/5 p-3 dark:bg-white/10">
            <dt className="text-xs opacity-70">Perlu tindak lanjut</dt>
            <dd className="text-2xl font-bold">
              {totalTindakLanjut}
              <span className="text-base font-normal opacity-70"> anggota</span>
            </dd>
          </div>
          <div className="col-span-2 rounded-lg bg-black/5 p-3 dark:bg-white/10">
            <dt className="text-xs opacity-70">Total persembahan {bulan}</dt>
            <dd className="text-2xl font-bold">{rupiah(totalPersembahan)}</dd>
          </div>
        </dl>
        <p className="mt-3 text-xs opacity-70">
          Pekan ini: {tanggalPanjang(senin)} – Minggu. &ldquo;Sudah lapor&rdquo; = ada pertemuan pekan ini yang
          absensinya sudah ditutup. Kehadiran dihitung dari pertemuan 4 pekan terakhir.
        </p>
      </Kotak>

      <Kotak judul={`Kelompok (${baris.length})`}>
        {baris.length === 0 ? (
          <p className="opacity-70">Tim ini belum punya kelompok.</p>
        ) : (
          <ul className="divide-y divide-black/10 dark:divide-white/10">
            {baris.map((b) => {
              const lapor = LABEL_LAPOR[b.status_lapor];
              return (
                <li key={b.kelompok_id}>
                  <Link
                    href={`/kelompok/${b.kelompok_id}`}
                    className="-mx-2 block rounded-lg px-2 py-3 hover:bg-black/5 dark:hover:bg-white/10"
                  >
                    <span className="flex flex-wrap items-center gap-2">
                      <span className="font-semibold">{b.nama}</span>
                      <span className={`rounded-md border px-2 py-0.5 text-xs font-semibold ${lapor.gaya}`}>{lapor.teks}</span>
                      {b.tindak_lanjut > 0 ? (
                        <span className="rounded-md border border-black/20 px-2 py-0.5 text-xs font-semibold dark:border-white/20">
                          Tindak lanjut {b.tindak_lanjut}
                        </span>
                      ) : null}
                      <span className="ml-auto text-sm opacity-60" aria-hidden>
                        Buka →
                      </span>
                    </span>
                    <span className="mt-1 grid grid-cols-2 gap-x-3 text-sm opacity-80">
                      <span>{b.anggota_aktif} anggota aktif</span>
                      <span>Hadir 4 pekan: {b.hadir_4_pekan === null ? "—" : `${b.hadir_4_pekan}%`}</span>
                      <span>
                        Terakhir: <span className="whitespace-nowrap">{b.pertemuan_terakhir ? tanggalPendek(b.pertemuan_terakhir) : "belum ada"}</span>
                      </span>
                      <span>
                        Persembahan: <span className="whitespace-nowrap">{rupiah(b.persembahan_bulan_ini)}</span>
                      </span>
                    </span>
                  </Link>
                </li>
              );
            })}
          </ul>
        )}
      </Kotak>
    </>
  );
}
