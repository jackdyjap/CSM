import "server-only";
import Link from "next/link";
import { pesanBacaGagal } from "@/lib/galat";
import {
  awalBulanBerikut,
  daftarBulan,
  KOLOM_SAAT_TEDUH,
  labelBulan,
  persen,
  type BarisRingkasanTeduh,
  type CatatanSaatTeduh,
} from "@/lib/saat-teduh";
import type { buatClientServer } from "@/lib/supabase/server";
import { DaftarSaatTeduh } from "./daftar-saat-teduh";
import { GrafikBatangTeduh, GrafikPelaksana } from "./grafik-saat-teduh";
import { Kotak, Pesan, Tombol } from "./ui";

// Laporan Saat Teduh (keputusan 61): list ringkas yang hanya memuat yang
// MELAKSANAKAN, info jumlah pelaksana sesuai cakupan, dan grafik batang/pie.

type Supabase = Awaited<ReturnType<typeof buatClientServer>>;

export const PILIHAN_GRAFIK = { batang: "Batang", pie: "Pie", tanpa: "Tanpa grafik" } as const;
export type Grafik = keyof typeof PILIHAN_GRAFIK;
export const bacaGrafik = (v: unknown): Grafik => (v === "pie" || v === "tanpa" ? v : "batang");

export type Jumlah = { anggota_aktif: number; punya_akun: number; bersaat_teduh: number; jumlah_catatan: number };

export function jumlahkan(baris: Jumlah[]): Jumlah {
  return baris.reduce(
    (t, b) => ({
      anggota_aktif: t.anggota_aktif + b.anggota_aktif,
      punya_akun: t.punya_akun + b.punya_akun,
      bersaat_teduh: t.bersaat_teduh + b.bersaat_teduh,
      jumlah_catatan: t.jumlah_catatan + b.jumlah_catatan,
    }),
    { anggota_aktif: 0, punya_akun: 0, bersaat_teduh: 0, jumlah_catatan: 0 },
  );
}

const pilihGaya =
  "min-h-11 w-full rounded-lg border border-black/20 bg-white px-3 py-2 text-base dark:border-white/20 dark:bg-black/30";

/** Formulir pilihan (GET): bulan, cakupan (bila ada), dan grafik. */
export function FormLaporanTeduh({
  bulan,
  grafik,
  cakupan,
}: {
  bulan: string;
  grafik: Grafik;
  cakupan?: { nilai: string; pilihan: { kelompok?: string; isi: { nilai: string; label: string }[] }[] };
}) {
  return (
    <Kotak>
      <form method="get" className="grid grid-cols-2 gap-x-3 gap-y-3">
        <label className="block">
          <span className="mb-1 block text-sm font-medium">Bulan</span>
          <select name="bulan" defaultValue={bulan} className={pilihGaya}>
            {daftarBulan().map((b) => (
              <option key={b} value={b}>
                {labelBulan(b)}
              </option>
            ))}
          </select>
        </label>
        <label className="block">
          <span className="mb-1 block text-sm font-medium">Grafik</span>
          <select name="g" defaultValue={grafik} className={pilihGaya}>
            {Object.entries(PILIHAN_GRAFIK).map(([k, v]) => (
              <option key={k} value={k}>
                {v}
              </option>
            ))}
          </select>
        </label>
        {cakupan ? (
          <label className="col-span-2 block">
            <span className="mb-1 block text-sm font-medium">Cakupan</span>
            <select name="cak" defaultValue={cakupan.nilai} className={pilihGaya}>
              {cakupan.pilihan.map((g, i) =>
                g.kelompok ? (
                  <optgroup key={g.kelompok} label={g.kelompok}>
                    {g.isi.map((o) => (
                      <option key={o.nilai} value={o.nilai}>
                        {o.label}
                      </option>
                    ))}
                  </optgroup>
                ) : (
                  g.isi.map((o) => (
                    <option key={`${i}-${o.nilai}`} value={o.nilai}>
                      {o.label}
                    </option>
                  ))
                ),
              )}
            </select>
          </label>
        ) : null}
        <Tombol type="submit" className="col-span-2">
          Tampilkan
        </Tombol>
      </form>
    </Kotak>
  );
}

/** "Pelaksana saat teduh: 16 dari 24 anggota (67%) · 176 catatan" + keterangan tanpa akun. */
export function InfoPelaksana({ j }: { j: Jumlah }) {
  const tanpaAkun = j.anggota_aktif - j.punya_akun;
  return (
    <div className="mb-3">
      <p className="text-sm opacity-70">Pelaksana saat teduh</p>
      <p className="text-lg">
        <strong>
          {j.bersaat_teduh} dari {j.punya_akun}
        </strong>{" "}
        anggota ({persen(j.bersaat_teduh, j.punya_akun)}) · {j.jumlah_catatan} catatan
      </p>
      {tanpaAkun > 0 ? (
        <p className="text-xs opacity-70">{tanpaAkun} anggota aktif belum punya akun (tidak dihitung).</p>
      ) : null}
    </div>
  );
}

type Unit = Jumlah & { kunci: string; nama: string; href: string };

/**
 * Cakupan semua tim (unit = tim) atau satu tim (unit = kelompok): info pelaksana,
 * grafik, dan list unit yang punya pelaksana. Unit tanpa pelaksana hanya dihitung.
 */
export function LaporanUnit({
  judul,
  unit,
  jenis,
  grafik,
}: {
  judul: string;
  unit: Unit[];
  jenis: "tim" | "kelompok";
  grafik: Grafik;
}) {
  const total = jumlahkan(unit);
  const ada = unit.filter((u) => u.bersaat_teduh > 0);
  const kosong = unit.length - ada.length;

  return (
    <Kotak judul={judul}>
      <InfoPelaksana j={total} />
      {grafik === "pie" ? (
        <div className="mb-4">
          <GrafikPelaksana pelaksana={total.bersaat_teduh} dari={total.punya_akun} />
        </div>
      ) : grafik === "batang" && ada.length > 0 ? (
        <div className="mb-4">
          <p className="mb-2 text-xs opacity-70">Persentase pelaksana per {jenis}</p>
          <GrafikBatangTeduh
            skala={100}
            batang={ada.map((u) => ({
              kunci: u.kunci,
              label: u.nama,
              nilai: (u.bersaat_teduh / Math.max(1, u.punya_akun)) * 100,
              teks: `${u.bersaat_teduh}/${u.punya_akun} · ${persen(u.bersaat_teduh, u.punya_akun)}`,
            }))}
          />
        </div>
      ) : null}

      {ada.length === 0 ? (
        <p className="text-sm opacity-70">Belum ada pelaksana saat teduh di bulan ini.</p>
      ) : (
        <ul className="divide-y divide-black/10 border-t border-black/10 dark:divide-white/10 dark:border-white/10">
          {ada.map((u) => (
            <li key={u.kunci}>
              <Link
                href={u.href}
                className="-mx-2 flex min-h-11 items-center gap-3 rounded-lg px-2 py-2 hover:bg-black/5 dark:hover:bg-white/10"
              >
                <span className="min-w-0 flex-1">
                  <span className="block truncate font-medium">{u.nama}</span>
                  <span className="block text-xs opacity-70">
                    {u.bersaat_teduh} dari {u.punya_akun} anggota · {u.jumlah_catatan} catatan
                  </span>
                </span>
                <span className="flex-none font-semibold tabular-nums">{persen(u.bersaat_teduh, u.punya_akun)}</span>
                <span className="text-sm opacity-60" aria-hidden>
                  →
                </span>
              </Link>
            </li>
          ))}
        </ul>
      )}
      {kosong > 0 ? (
        <p className="mt-2 text-xs opacity-70">
          {kosong} {jenis} belum ada pelaksana bulan ini (tidak ditampilkan).
        </p>
      ) : null}
    </Kotak>
  );
}

/** Kelompok per tim dari hasil ringkasan_saat_teduh. */
export function unitTim(baris: BarisRingkasanTeduh[], href: (timId: string) => string): Unit[] {
  const per = new Map<string, Unit>();
  for (const b of baris) {
    const u = per.get(b.tim_id) ?? {
      kunci: b.tim_id,
      nama: `Tim ${b.tim_nama}`,
      href: href(b.tim_id),
      anggota_aktif: 0,
      punya_akun: 0,
      bersaat_teduh: 0,
      jumlah_catatan: 0,
    };
    u.anggota_aktif += b.anggota_aktif;
    u.punya_akun += b.punya_akun;
    u.bersaat_teduh += b.bersaat_teduh;
    u.jumlah_catatan += b.jumlah_catatan;
    per.set(b.tim_id, u);
  }
  return [...per.values()];
}

export function unitKelompok(baris: BarisRingkasanTeduh[], href: (kelompokId: string) => string): Unit[] {
  return baris.map((b) => ({ ...b, kunci: b.kelompok_id, nama: b.kelompok_nama, href: href(b.kelompok_id) }));
}

type BarisAnggota = {
  anggota_id: string;
  nama_lengkap: string;
  akun_id: string | null;
  jumlah_hari: number;
  jumlah_catatan: number;
  total_menit: number;
};

/**
 * Cakupan satu kelompok: info pelaksana, grafik, dan list anggota yang
 * melaksanakan (ketuk nama untuk catatannya bulan itu, hanya baca).
 */
export async function LaporanAnggota({
  supabase,
  kelompokId,
  bulan,
  grafik,
  judul,
}: {
  supabase: Supabase;
  kelompokId: string;
  bulan: string;
  grafik: Grafik;
  judul: string;
}) {
  const { data, error } = await supabase.rpc("saat_teduh_per_anggota", {
    p_kelompok: kelompokId,
    p_bulan: `${bulan}-01`,
  });
  if (error) return <Pesan jenis="galat">{pesanBacaGagal(error, "Laporan saat teduh")}</Pesan>;
  const anggota = (data ?? []) as BarisAnggota[];
  const pelaksana = anggota.filter((a) => a.akun_id && a.jumlah_catatan > 0);
  const punyaAkun = anggota.filter((a) => a.akun_id).length;

  const { data: dataCatatan } = pelaksana.length
    ? await supabase
        .from("saat_teduh")
        .select(KOLOM_SAAT_TEDUH)
        .in(
          "akun_id",
          pelaksana.map((a) => a.akun_id!),
        )
        .gte("tanggal", `${bulan}-01`)
        .lt("tanggal", awalBulanBerikut(bulan))
        .order("tanggal", { ascending: false })
        .order("jam_mulai", { ascending: false })
    : { data: [] };
  const perAkun = new Map<string, CatatanSaatTeduh[]>();
  for (const c of (dataCatatan ?? []) as CatatanSaatTeduh[]) {
    perAkun.set(c.akun_id, [...(perAkun.get(c.akun_id) ?? []), c]);
  }

  const j: Jumlah = {
    anggota_aktif: anggota.length,
    punya_akun: punyaAkun,
    bersaat_teduh: pelaksana.length,
    jumlah_catatan: pelaksana.reduce((n, a) => n + a.jumlah_catatan, 0),
  };
  const belum = punyaAkun - pelaksana.length;
  const [t, b] = bulan.split("-").map(Number);
  const hariDalamBulan = new Date(Date.UTC(t, b, 0)).getUTCDate();

  return (
    <Kotak judul={judul}>
      <InfoPelaksana j={j} />
      {grafik === "pie" ? (
        <div className="mb-4">
          <GrafikPelaksana pelaksana={j.bersaat_teduh} dari={j.punya_akun} />
        </div>
      ) : grafik === "batang" && pelaksana.length > 0 ? (
        <div className="mb-4">
          <p className="mb-2 text-xs opacity-70">Jumlah hari saat teduh per anggota (dari {hariDalamBulan} hari)</p>
          <GrafikBatangTeduh
            skala={hariDalamBulan}
            batang={pelaksana.map((a) => ({
              kunci: a.anggota_id,
              label: a.nama_lengkap,
              nilai: a.jumlah_hari,
              teks: `${a.jumlah_hari} hari`,
            }))}
          />
        </div>
      ) : null}

      {pelaksana.length === 0 ? (
        <p className="text-sm opacity-70">Belum ada anggota yang mencatat saat teduh di bulan ini.</p>
      ) : (
        <>
          <p className="mb-1 text-xs opacity-70">Ketuk nama untuk melihat catatannya (hanya baca).</p>
          <ul className="divide-y divide-black/10 border-t border-black/10 dark:divide-white/10 dark:border-white/10">
            {pelaksana.map((a) => (
              <li key={a.anggota_id}>
                <details className="group">
                  <summary className="-mx-2 flex min-h-11 cursor-pointer list-none items-center gap-2 rounded-lg px-2 py-1 hover:bg-black/5 dark:hover:bg-white/10 [&::-webkit-details-marker]:hidden">
                    <span className="min-w-0 flex-1 truncate font-semibold">{a.nama_lengkap}</span>
                    <span className="text-sm tabular-nums opacity-80">
                      {a.jumlah_hari} hari · {a.jumlah_catatan} catatan
                    </span>
                    <span className="text-sm opacity-60" aria-hidden>
                      <span className="group-open:hidden">▾</span>
                      <span className="hidden group-open:inline">▴</span>
                    </span>
                  </summary>
                  <div className="mb-3 ml-1 mt-1 border-l-2 border-black/10 pl-3 dark:border-white/15">
                    <p className="mb-1 text-xs opacity-70">Total {a.total_menit} menit.</p>
                    <DaftarSaatTeduh catatan={perAkun.get(a.akun_id!) ?? []} />
                  </div>
                </details>
              </li>
            ))}
          </ul>
        </>
      )}
      {belum > 0 ? (
        <p className="mt-2 text-xs opacity-70">{belum} anggota belum ada catatan bulan ini (tidak ditampilkan).</p>
      ) : null}
    </Kotak>
  );
}
