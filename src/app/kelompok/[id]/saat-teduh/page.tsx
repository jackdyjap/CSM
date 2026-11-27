import { redirect } from "next/navigation";
import { DaftarSaatTeduh } from "@/components/daftar-saat-teduh";
import { KalimatRingkasan, PilihBulan } from "@/components/ringkasan-saat-teduh";
import { Judul, Kotak, Pesan, TautanTombol } from "@/components/ui";
import { pesanBacaGagal } from "@/lib/galat";
import {
  awalBulanBerikut,
  bacaBulan,
  KOLOM_SAAT_TEDUH,
  labelBulan,
  type CatatanSaatTeduh,
} from "@/lib/saat-teduh";
import { aksesKelompok, wajibMasuk } from "@/lib/sesi";

type BarisAnggota = {
  anggota_id: string;
  nama_lengkap: string;
  akun_id: string | null;
  jumlah_hari: number;
  jumlah_catatan: number;
  total_menit: number;
};

/** Ringkasan saat teduh sebulan untuk satu kelompok (Pemimpin/Wakil, Ketua Tim, Admin; hanya baca). */
export default async function HalamanSaatTeduhKelompok({ params, searchParams }: PageProps<"/kelompok/[id]/saat-teduh">) {
  const { id } = await params;
  const bulan = bacaBulan((await searchParams).bulan);
  const { supabase, peran } = await wajibMasuk();
  const kelompok = await aksesKelompok(supabase, peran, id);
  if (!kelompok) redirect("/beranda");

  const { data, error } = await supabase.rpc("saat_teduh_per_anggota", { p_kelompok: id, p_bulan: `${bulan}-01` });
  const anggota = (data ?? []) as BarisAnggota[];
  const akunIds = anggota.flatMap((a) => (a.akun_id ? [a.akun_id] : []));

  // Catatan bulan ini; aturan akses database tetap menentukan yang boleh dibaca.
  const { data: dataCatatan } = akunIds.length
    ? await supabase
        .from("saat_teduh")
        .select(KOLOM_SAAT_TEDUH)
        .in("akun_id", akunIds)
        .gte("tanggal", `${bulan}-01`)
        .lt("tanggal", awalBulanBerikut(bulan))
        .order("tanggal", { ascending: false })
        .order("jam_mulai", { ascending: false })
    : { data: [] };
  const perAkun = new Map<string, CatatanSaatTeduh[]>();
  for (const c of (dataCatatan ?? []) as CatatanSaatTeduh[]) {
    perAkun.set(c.akun_id, [...(perAkun.get(c.akun_id) ?? []), c]);
  }

  const punyaAkun = anggota.filter((a) => a.akun_id);
  const ringkas = {
    anggota_aktif: anggota.length,
    punya_akun: punyaAkun.length,
    bersaat_teduh: punyaAkun.filter((a) => a.jumlah_catatan > 0).length,
    jumlah_catatan: anggota.reduce((n, a) => n + a.jumlah_catatan, 0),
  };

  return (
    <main>
      <Judul kecil={`${kelompok.sebagai} · ${kelompok.tim_nama}`}>Saat teduh · {kelompok.nama}</Judul>
      <div className="mb-4">
        <TautanTombol href={`/kelompok/${id}`}>← Kelompok</TautanTombol>
      </div>
      <PilihBulan bulan={bulan} />

      {error ? (
        <Pesan jenis="galat">{pesanBacaGagal(error, "Ringkasan saat teduh")}</Pesan>
      ) : (
        <>
          <Kotak judul={labelBulan(bulan)}>
            <KalimatRingkasan j={ringkas} besar />
          </Kotak>
          <Kotak judul={`Anggota aktif (${anggota.length})`}>
            {anggota.length === 0 ? (
              <p className="opacity-70">Belum ada anggota aktif.</p>
            ) : (
              <>
                <p className="mb-2 text-xs opacity-70">
                  Ketuk nama untuk melihat catatannya bulan ini (hanya baca).
                </p>
                <ul className="divide-y divide-black/10 dark:divide-white/10">
                  {anggota.map((a) => {
                    const catatan = a.akun_id ? (perAkun.get(a.akun_id) ?? []) : [];
                    return (
                      <li key={a.anggota_id}>
                        <details className="group">
                          <summary className="-mx-2 flex min-h-11 cursor-pointer list-none items-center gap-2 rounded-lg px-2 py-1 hover:bg-black/5 dark:hover:bg-white/10 [&::-webkit-details-marker]:hidden">
                            <span className="min-w-0 flex-1 truncate font-semibold">{a.nama_lengkap}</span>
                            {!a.akun_id ? (
                              <span className="text-xs opacity-70">Belum punya akun</span>
                            ) : a.jumlah_catatan > 0 ? (
                              <span className="rounded-md border border-green-700/50 px-2 py-0.5 text-xs font-semibold text-green-800 dark:text-green-300">
                                {a.jumlah_hari} hari · {a.jumlah_catatan} catatan
                              </span>
                            ) : (
                              <span className="rounded-md border border-amber-700/50 px-2 py-0.5 text-xs font-semibold text-amber-800 dark:text-amber-300">
                                Belum ada
                              </span>
                            )}
                            <span className="text-sm opacity-60" aria-hidden>
                              <span className="group-open:hidden">▾</span>
                              <span className="hidden group-open:inline">▴</span>
                            </span>
                          </summary>
                          <div className="mb-3 ml-1 mt-1 border-l-2 border-black/10 pl-3 dark:border-white/15">
                            {!a.akun_id ? (
                              <p className="text-sm opacity-70">
                                Anggota tanpa akun tidak bisa mencatat saat teduh dan tidak ikut dihitung.
                              </p>
                            ) : catatan.length === 0 ? (
                              <p className="text-sm opacity-70">Belum ada catatan di {labelBulan(bulan)}.</p>
                            ) : (
                              <>
                                <p className="mb-1 text-xs opacity-70">Total {a.total_menit} menit.</p>
                                <DaftarSaatTeduh catatan={catatan} />
                              </>
                            )}
                          </div>
                        </details>
                      </li>
                    );
                  })}
                </ul>
              </>
            )}
          </Kotak>
        </>
      )}
    </main>
  );
}
