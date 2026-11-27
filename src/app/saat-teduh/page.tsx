import { DaftarSaatTeduh } from "@/components/daftar-saat-teduh";
import { FormPeriodeTeduh } from "@/components/form-periode-teduh";
import { GrafikBatangTeduh, GrafikDonat, type BatangTeduh } from "@/components/grafik-saat-teduh";
import { bacaGrafik } from "@/components/laporan-saat-teduh";
import { Judul, Kotak, Pesan, TautanTombol } from "@/components/ui";
import { pesanBacaGagal } from "@/lib/galat";
import {
  awalBulanBerikut,
  bacaBulan,
  bulanIni,
  daftarBulan,
  hariDalamBulan,
  hariDalamTahun,
  hariIniWib,
  jumlahHariInklusif,
  KOLOM_SAAT_TEDUH,
  labelBulan,
  persen,
  type CatatanSaatTeduh,
} from "@/lib/saat-teduh";
import { wajibMasuk } from "@/lib/sesi";

const NAMA_BULAN = ["Jan", "Feb", "Mar", "Apr", "Mei", "Jun", "Jul", "Agu", "Sep", "Okt", "Nov", "Des"];

/**
 * Saat Teduh pribadi: ringkasan per bulan atau per tahun (hari bersaat teduh
 * dan persentasenya, dengan grafik batang/pie), lalu riwayat periode itu
 * (keputusan 58, 66). Hanya catatan milik saya.
 */
export default async function HalamanSaatTeduh({ searchParams }: PageProps<"/saat-teduh">) {
  const sp = await searchParams;
  const { supabase, peran } = await wajibMasuk();
  const hariIni = hariIniWib();
  const tahunIni = Number(hariIni.slice(0, 4));

  // Tahun yang bisa dipilih: sejak catatan pertama saya sampai tahun ini.
  const { data: pertama } = await supabase
    .from("saat_teduh")
    .select("tanggal")
    .eq("akun_id", peran.akun_id)
    .order("tanggal")
    .limit(1)
    .maybeSingle();
  const tahunAwal = Math.min(tahunIni, pertama ? Number(String(pertama.tanggal).slice(0, 4)) : tahunIni);
  const daftarTahun = Array.from({ length: tahunIni - tahunAwal + 1 }, (_, i) => tahunIni - i);

  const periode = sp.p === "tahun" ? "tahun" : "bulan";
  const bulan = bacaBulan(sp.bulan);
  const tahunDiminta = Number(sp.tahun);
  const tahun = daftarTahun.includes(tahunDiminta) ? tahunDiminta : tahunIni;
  const grafik = bacaGrafik(sp.g);

  const awal = periode === "bulan" ? `${bulan}-01` : `${tahun}-01-01`;
  const akhirLebih = periode === "bulan" ? awalBulanBerikut(bulan) : `${tahun + 1}-01-01`;
  const { data, error } = await supabase
    .from("saat_teduh")
    .select(KOLOM_SAAT_TEDUH)
    .eq("akun_id", peran.akun_id)
    .gte("tanggal", awal)
    .lt("tanggal", akhirLebih)
    .order("tanggal", { ascending: false })
    .order("jam_mulai", { ascending: false })
    .limit(2000);
  const catatan = (data ?? []) as CatatanSaatTeduh[];

  // Hitungan: HARI unik (dua catatan di hari yang sama = 1 hari).
  const hariUnik = new Set(catatan.map((c) => c.tanggal));
  const totalHari = periode === "bulan" ? hariDalamBulan(bulan) : hariDalamTahun(tahun);
  const berjalan = periode === "bulan" ? bulan === bulanIni() : tahun === tahunIni;
  const sampaiHariIni = berjalan ? jumlahHariInklusif(awal, hariIni) : totalHari;
  const totalMenit = catatan.reduce((n, c) => n + c.durasi_menit, 0);
  const rataRata = catatan.length ? Math.round(totalMenit / catatan.length) : 0;
  const judulPeriode = periode === "bulan" ? labelBulan(bulan) : `Tahun ${tahun}`;

  // Batang: per minggu (bulan) atau per bulan (tahun).
  let batang: BatangTeduh[] = [];
  let skala = 7;
  if (periode === "bulan") {
    const n = hariDalamBulan(bulan);
    for (let m = 0; m * 7 < n; m++) {
      const dari = m * 7 + 1;
      const sampai = Math.min(n, dari + 6);
      let ada = 0;
      for (let h = dari; h <= sampai; h++) if (hariUnik.has(`${bulan}-${String(h).padStart(2, "0")}`)) ada++;
      batang.push({
        kunci: `m${m}`,
        label: `Minggu ${m + 1}`,
        nilai: ada,
        teks: `${ada}/${sampai - dari + 1} hari (tgl ${dari}–${sampai})`,
      });
    }
  } else {
    skala = 100;
    batang = NAMA_BULAN.map((nama, i) => {
      const b = `${tahun}-${String(i + 1).padStart(2, "0")}`;
      const n = hariDalamBulan(b);
      const ada = [...hariUnik].filter((t) => t.startsWith(b)).length;
      return {
        kunci: b,
        label: nama,
        nilai: (ada / n) * 100,
        teks: `${ada}/${n} · ${persen(ada, n)}`,
        href: b <= bulanIni() ? `/saat-teduh?p=bulan&bulan=${b}&g=${grafik}` : undefined,
      };
    });
  }

  return (
    <main>
      <Judul kecil="Catatan pribadi Anda">Saat Teduh</Judul>
      <div className="mb-4 flex flex-wrap gap-2">
        <TautanTombol href="/beranda">← Beranda</TautanTombol>
        <TautanTombol href="/saat-teduh/baru" jenis="utama">
          + Catat saat teduh
        </TautanTombol>
      </div>

      <Kotak>
        <FormPeriodeTeduh
          periode={periode}
          bulan={bulan}
          tahun={tahun}
          grafik={grafik}
          daftarBulan={daftarBulan().map((b) => ({ nilai: b, label: labelBulan(b) }))}
          daftarTahun={daftarTahun}
        />
      </Kotak>

      {error ? (
        <Pesan jenis="galat">{pesanBacaGagal(error, "Catatan saat teduh")}</Pesan>
      ) : (
        <>
          <Kotak judul={`Ringkasan · ${judulPeriode}`}>
            <p className="text-lg">
              <strong>
                {hariUnik.size} dari {totalHari} hari
              </strong>{" "}
              ({persen(hariUnik.size, totalHari)}) bersaat teduh
            </p>
            {berjalan ? (
              <p className="text-sm">
                Sampai hari ini: {hariUnik.size} dari {sampaiHariIni} hari ({persen(hariUnik.size, sampaiHariIni)})
              </p>
            ) : null}
            <p className="mb-3 text-sm opacity-70">
              {catatan.length} catatan · total {totalMenit} menit
              {catatan.length ? ` · rata-rata ${rataRata} menit per catatan` : ""}
            </p>
            {grafik === "pie" ? (
              <GrafikDonat
                satuan="hari"
                tengah={persen(hariUnik.size, sampaiHariIni)}
                teksTengah={berjalan ? "sampai hari ini" : "bersaat teduh"}
                bagian={[
                  { kunci: "ya", label: "Bersaat teduh", total: hariUnik.size, warna: "var(--kat-1)" },
                  {
                    kunci: "belum",
                    label: berjalan ? "Belum (sampai hari ini)" : "Belum",
                    total: Math.max(0, sampaiHariIni - hariUnik.size),
                    warna: "var(--kat-lain)",
                  },
                ]}
              />
            ) : grafik === "batang" ? (
              <>
                <p className="mb-2 text-xs opacity-70">
                  {periode === "bulan"
                    ? "Hari bersaat teduh per minggu"
                    : "Hari bersaat teduh per bulan (ketuk bulan untuk ringkasannya)"}
                </p>
                <GrafikBatangTeduh batang={batang} skala={skala} />
              </>
            ) : null}
            <p className="mt-2 text-xs opacity-70">Dua catatan di hari yang sama dihitung satu hari.</p>
          </Kotak>

          <Kotak judul={`Riwayat · ${judulPeriode} (${catatan.length})`}>
            {catatan.length === 0 ? (
              <p className="opacity-70">Belum ada catatan di periode ini.</p>
            ) : (
              <>
                <p className="mb-2 text-xs opacity-70">Ketuk sebuah catatan untuk melihat detailnya.</p>
                <DaftarSaatTeduh catatan={catatan} bolehUbah />
              </>
            )}
          </Kotak>
        </>
      )}
      <p className="text-xs opacity-70">
        Catatan Anda bisa dibaca Pemimpin kelompok, Ketua Tim, dan Admin, tetapi hanya Anda yang bisa mengubah atau
        menghapusnya.
      </p>
    </main>
  );
}
