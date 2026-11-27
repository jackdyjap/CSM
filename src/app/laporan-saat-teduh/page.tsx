import { redirect } from "next/navigation";
import {
  bacaGrafik,
  FormLaporanTeduh,
  LaporanAnggota,
  LaporanUnit,
  unitKelompok,
  unitTim,
} from "@/components/laporan-saat-teduh";
import { Judul, Pesan, TautanTombol } from "@/components/ui";
import { pesanBacaGagal } from "@/lib/galat";
import { bacaBulan, labelBulan, type BarisRingkasanTeduh } from "@/lib/saat-teduh";
import { wajibMasuk } from "@/lib/sesi";

/**
 * Laporan saat teduh (keputusan 61) untuk Admin (semua tim / satu tim / satu
 * kelompok) dan Ketua Tim (semua kelompok di timnya / satu kelompok).
 * Pemimpin/Wakil memakai halaman kelompok → Saat teduh anggota.
 */
export default async function HalamanLaporanSaatTeduh({ searchParams }: PageProps<"/laporan-saat-teduh">) {
  const sp = await searchParams;
  const { supabase, peran } = await wajibMasuk();
  if (!peran.admin && peran.ketua_tim.length === 0) redirect("/beranda");

  const bulan = bacaBulan(sp.bulan);
  const grafik = bacaGrafik(sp.g);
  const { data, error } = await supabase.rpc("ringkasan_saat_teduh", { p_bulan: `${bulan}-01` });
  const timSaya = new Set(peran.ketua_tim.map((t) => t.tim_id));
  // Ketua Tim yang juga pemimpin kelompok di tim lain: laporan ini hanya untuk tim yang diketuainya.
  const baris = ((data ?? []) as BarisRingkasanTeduh[]).filter((b) => peran.admin || timSaya.has(b.tim_id));

  const daftarTim = [...new Map(baris.map((b) => [b.tim_id, b.tim_nama])).entries()];
  const satuTim = !peran.admin && daftarTim.length === 1;
  const bawaan = satuTim ? `tim:${daftarTim[0][0]}` : "semua";

  const pilihan = [
    ...(satuTim ? [] : [{ isi: [{ nilai: "semua", label: peran.admin ? "Semua tim" : "Semua tim saya" }] }]),
    ...daftarTim.map(([id, nama]) => ({
      kelompok: `Tim ${nama}`,
      isi: [
        { nilai: `tim:${id}`, label: `Semua kelompok di Tim ${nama}` },
        ...baris.filter((b) => b.tim_id === id).map((b) => ({ nilai: `kelompok:${b.kelompok_id}`, label: b.kelompok_nama })),
      ],
    })),
  ];
  const sah = new Set(pilihan.flatMap((g) => g.isi.map((o) => o.nilai)));
  const cak = typeof sp.cak === "string" && sah.has(sp.cak) ? sp.cak : bawaan;
  const [jenis, idCak] = cak.split(":");
  const tautan = (c: string) => `/laporan-saat-teduh?bulan=${bulan}&g=${grafik}&cak=${encodeURIComponent(c)}`;

  const kelompokDipilih = jenis === "kelompok" ? baris.find((b) => b.kelompok_id === idCak) : undefined;
  const timDipilih = jenis === "tim" ? daftarTim.find(([id]) => id === idCak) : undefined;

  return (
    <main>
      <Judul kecil={peran.admin ? "Admin" : "Ketua Tim"}>Laporan saat teduh</Judul>
      <div className="mb-4 flex flex-wrap gap-2">
        <TautanTombol href="/beranda">← Beranda</TautanTombol>
        {kelompokDipilih ? (
          <TautanTombol href={tautan(`tim:${kelompokDipilih.tim_id}`)}>← Tim {kelompokDipilih.tim_nama}</TautanTombol>
        ) : timDipilih && !satuTim ? (
          <TautanTombol href={tautan("semua")}>← {peran.admin ? "Semua tim" : "Semua tim saya"}</TautanTombol>
        ) : null}
      </div>

      <FormLaporanTeduh bulan={bulan} grafik={grafik} cakupan={{ nilai: cak, pilihan }} />
      <p className="mb-3 text-xs opacity-70">
        Dihitung dari anggota aktif yang punya akun; pelaksana = minimal 1 catatan di bulan itu. Hanya yang
        melaksanakan yang ditampilkan.
      </p>

      {error ? (
        <Pesan jenis="galat">{pesanBacaGagal(error, "Laporan saat teduh")}</Pesan>
      ) : kelompokDipilih ? (
        <LaporanAnggota
          supabase={supabase}
          kelompokId={kelompokDipilih.kelompok_id}
          bulan={bulan}
          grafik={grafik}
          judul={`${kelompokDipilih.kelompok_nama} (Tim ${kelompokDipilih.tim_nama}) · ${labelBulan(bulan)}`}
        />
      ) : timDipilih ? (
        <LaporanUnit
          judul={`Tim ${timDipilih[1]} · ${labelBulan(bulan)}`}
          jenis="kelompok"
          grafik={grafik}
          unit={unitKelompok(
            baris.filter((b) => b.tim_id === timDipilih[0]),
            (k) => tautan(`kelompok:${k}`),
          )}
        />
      ) : (
        <LaporanUnit
          judul={`${peran.admin ? "Semua tim" : "Semua tim saya"} · ${labelBulan(bulan)}`}
          jenis="tim"
          grafik={grafik}
          unit={unitTim(baris, (t) => tautan(`tim:${t}`))}
        />
      )}
    </main>
  );
}
