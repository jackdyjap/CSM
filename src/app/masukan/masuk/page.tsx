import { redirect } from "next/navigation";
import { FormAksi } from "@/components/form-aksi";
import { GrafikBatangTeduh, GrafikDonat } from "@/components/grafik-saat-teduh";
import { bacaGrafik, FormLaporanTeduh } from "@/components/laporan-saat-teduh";
import { LabelStatus } from "@/components/masukan";
import { IsianPanjang, Judul, Kotak, Lipatan, Pilihan, TautanTombol } from "@/components/ui";
import { tanggapiMasukan } from "@/lib/aksi-masukan";
import { waktuWib } from "@/lib/format";
import {
  JENIS_MASUKAN,
  PANJANG_ISI_MAKS,
  STATUS_MASUKAN,
  TUJUAN_MASUKAN,
  type JenisMasukan,
  type StatusMasukan,
  type TujuanMasukan,
} from "@/lib/masukan";
import { bacaBulan, labelBulan, persen } from "@/lib/saat-teduh";
import { wajibMasuk } from "@/lib/sesi";

type MasukanMasuk = {
  id: string;
  tujuan: TujuanMasukan;
  kelompok_nama: string | null;
  tim_nama: string | null;
  jenis: JenisMasukan;
  judul: string;
  isi: string;
  anonim: boolean;
  pengirim_nama: string | null;
  status: StatusMasukan;
  balasan: string | null;
  dibalas_oleh_nama: string | null;
  dibalas_pada: string | null;
  dibuat_pada: string;
};

const URUTAN_STATUS: StatusMasukan[] = ["baru", "ditangani", "selesai"];
/** Warna mengikuti label status: Baru jingga, Sedang ditangani biru, Selesai hijau (lolos uji buta warna). */
const WARNA_STATUS: Record<StatusMasukan, string> = {
  baru: "var(--kat-4)",
  ditangani: "var(--kat-1)",
  selesai: "var(--kat-3)",
};

const bulanWib = (waktu: string) =>
  new Intl.DateTimeFormat("en-CA", { timeZone: "Asia/Jakarta" }).format(new Date(waktu)).slice(0, 7);

/**
 * Masukan yang ditujukan kepada saya: pemimpin/wakil (kelompoknya), ketua tim
 * (timnya), Admin (semua). Nama pengirim anonim hanya terlihat oleh Admin (keputusan 28).
 * Ringkasan per bulan + grafik, lalu list per status (terbaru dulu); ketuk untuk rincian (keputusan 63).
 */
export default async function HalamanMasukanMasuk({ searchParams }: PageProps<"/masukan/masuk">) {
  const { supabase, peran } = await wajibMasuk();
  if (!peran.admin && peran.ketua_tim.length === 0 && peran.pemimpin.length === 0) redirect("/masukan");

  const sp = await searchParams;
  const bulan = bacaBulan(sp.bulan);
  const grafik = bacaGrafik(sp.g);

  const { data } = await supabase.rpc("masukan_masuk");
  const semua = ((data ?? []) as MasukanMasuk[]).sort((x, y) => y.dibuat_pada.localeCompare(x.dibuat_pada));

  const diBulan = semua.filter((m) => bulanWib(m.dibuat_pada) === bulan);
  const hitung = Object.fromEntries(
    URUTAN_STATUS.map((st) => [st, diBulan.filter((m) => m.status === st).length]),
  ) as Record<StatusMasukan, number>;

  return (
    <main>
      <Judul kecil={peran.admin ? "Admin: semua masukan" : undefined}>Masukan masuk</Judul>
      <div className="mb-4 flex flex-wrap gap-2">
        <TautanTombol href="/beranda">← Beranda</TautanTombol>
        <TautanTombol href="/masukan">Kirim masukan</TautanTombol>
      </div>

      <FormLaporanTeduh bulan={bulan} grafik={grafik} />

      <Kotak judul={`Ringkasan · ${labelBulan(bulan)}`}>
        <p className="text-lg">
          Diterima: <strong>{diBulan.length}</strong> masukan
        </p>
        <ul className="mb-3 mt-1 flex flex-wrap gap-x-4 gap-y-1 text-sm">
          {URUTAN_STATUS.map((st) => (
            <li key={st} className="flex items-center gap-1.5">
              <span aria-hidden className="inline-block h-3 w-3 rounded-sm" style={{ background: WARNA_STATUS[st] }} />
              {STATUS_MASUKAN[st]}: <strong className="tabular-nums">{hitung[st]}</strong>{" "}
              <span className="opacity-70">({persen(hitung[st], diBulan.length)})</span>
            </li>
          ))}
        </ul>
        {diBulan.length === 0 || grafik === "tanpa" ? null : grafik === "pie" ? (
          <GrafikDonat
            satuan="masukan"
            tengah={String(diBulan.length)}
            teksTengah="diterima"
            bagian={URUTAN_STATUS.map((st) => ({
              kunci: st,
              label: STATUS_MASUKAN[st],
              total: hitung[st],
              warna: WARNA_STATUS[st],
            }))}
          />
        ) : (
          <GrafikBatangTeduh
            skala={diBulan.length}
            batang={URUTAN_STATUS.map((st) => ({
              kunci: st,
              label: STATUS_MASUKAN[st],
              nilai: hitung[st],
              teks: `${hitung[st]} · ${persen(hitung[st], diBulan.length)}`,
              warna: WARNA_STATUS[st],
            }))}
          />
        )}
        {diBulan.length === 0 ? <p className="text-sm opacity-70">Belum ada masukan di bulan ini.</p> : null}
        <p className="mt-2 text-xs opacity-70">
          Dihitung dari masukan yang dikirim di bulan itu, menurut statusnya sekarang.
        </p>
      </Kotak>

      <p className="mb-2 text-sm opacity-70">
        Semua masukan ({semua.length}), terbaru dulu. Ketuk judul untuk rincian dan tanggapan.
      </p>
      {URUTAN_STATUS.map((st) => {
        const daftar = semua.filter((m) => m.status === st);
        return (
          <details key={st} open={st !== "selesai"} className="group/kel mb-4 rounded-xl border border-black/10 bg-white p-4 shadow-sm dark:border-white/10 dark:bg-white/5">
            <summary className="flex min-h-11 cursor-pointer list-none items-center gap-2 text-lg font-semibold [&::-webkit-details-marker]:hidden">
              <span aria-hidden className="inline-block h-3 w-3 rounded-sm" style={{ background: WARNA_STATUS[st] }} />
              <span className="flex-1">
                {STATUS_MASUKAN[st]} ({daftar.length})
              </span>
              <span className="text-sm font-normal opacity-60" aria-hidden>
                <span className="group-open/kel:hidden">▾</span>
                <span className="hidden group-open/kel:inline">▴</span>
              </span>
            </summary>
            {daftar.length === 0 ? (
              <p className="mt-2 text-sm opacity-70">Tidak ada.</p>
            ) : (
              <ul className="mt-2 divide-y divide-black/10 dark:divide-white/10">
                {daftar.map((m) => (
                  <ButirMasukan key={m.id} m={m} />
                ))}
              </ul>
            )}
          </details>
        );
      })}
    </main>
  );
}

function ButirMasukan({ m }: { m: MasukanMasuk }) {
  return (
    <li>
      <details className="group/butir">
        <summary className="-mx-2 flex min-h-11 cursor-pointer list-none items-center gap-2 rounded-lg px-2 py-1 hover:bg-black/5 dark:hover:bg-white/10 [&::-webkit-details-marker]:hidden">
          <span className="min-w-0 flex-1">
            <span className="block font-medium">{m.judul}</span>
            <span className="block text-xs opacity-70">
              {JENIS_MASUKAN[m.jenis]} · {waktuWib(m.dibuat_pada)}
            </span>
          </span>
          <span className="text-sm opacity-60" aria-hidden>
            <span className="group-open/butir:hidden">▾</span>
            <span className="hidden group-open/butir:inline">▴</span>
          </span>
        </summary>
        <div className="mb-3 ml-1 mt-1 space-y-2 border-l-2 border-black/10 pl-3 dark:border-white/15">
          <div className="flex flex-wrap items-center gap-2">
            <LabelStatus status={m.status} />
            <span className="text-xs opacity-70">
              untuk {TUJUAN_MASUKAN[m.tujuan]}
              {m.tujuan === "pemimpin" && m.kelompok_nama ? ` ${m.kelompok_nama}` : ""}
              {m.tujuan === "ketua_tim" && m.tim_nama ? ` ${m.tim_nama}` : ""}
            </span>
          </div>
          <p className="text-xs opacity-70">
            Dari:{" "}
            {m.anonim
              ? m.pengirim_nama
                ? `tanpa nama (pengirim: ${m.pengirim_nama}, hanya terlihat oleh Admin)`
                : "tanpa nama"
              : (m.pengirim_nama ?? "akun sudah dihapus")}
            {m.tujuan !== "pemimpin" && m.kelompok_nama ? ` · kelompok ${m.kelompok_nama}` : ""}
          </p>
          <p className="text-sm whitespace-pre-line">{m.isi}</p>
          {m.balasan ? (
            <div className="rounded-lg bg-black/5 p-2 text-sm dark:bg-white/10">
              <p className="text-xs font-semibold opacity-70">
                Balasan{m.dibalas_oleh_nama ? ` dari ${m.dibalas_oleh_nama}` : ""}
                {m.dibalas_pada ? ` · ${waktuWib(m.dibalas_pada)}` : ""}
              </p>
              <p className="whitespace-pre-line">{m.balasan}</p>
            </div>
          ) : null}
          <Lipatan judul={m.balasan ? "Ubah tanggapan" : "Tanggapi"}>
            <FormAksi aksi={tanggapiMasukan.bind(null, m.id)} tombol="Simpan tanggapan" tanpaReset kembali="/beranda">
              <Pilihan label="Status" name="status" defaultValue={m.status === "baru" ? "ditangani" : m.status}>
                {Object.entries(STATUS_MASUKAN).map(([k, v]) => (
                  <option key={k} value={k}>
                    {v}
                  </option>
                ))}
              </Pilihan>
              <IsianPanjang
                label="Balasan untuk pengirim (boleh kosong)"
                name="balasan"
                rows={4}
                maxLength={PANJANG_ISI_MAKS}
                defaultValue={m.balasan ?? ""}
              />
            </FormAksi>
          </Lipatan>
        </div>
      </details>
    </li>
  );
}
