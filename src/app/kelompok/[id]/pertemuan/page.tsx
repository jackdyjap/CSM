import Link from "next/link";
import { redirect } from "next/navigation";
import { FormAksi } from "@/components/form-aksi";
import { Isian, Judul, Kotak, TautanTombol } from "@/components/ui";
import { rupiah, tanggalPanjang } from "@/lib/pertemuan";
import { hariIniWib } from "@/lib/profil";
import { kelompokKelolaan, wajibMasuk } from "@/lib/sesi";
import { mulaiPertemuan } from "./aksi";

type BarisPertemuan = {
  id: string;
  tanggal: string;
  persembahan: number | null;
  ditutup_pada: string | null;
  kehadiran: { hadir: boolean }[];
};

export default async function HalamanDaftarPertemuan({ params }: PageProps<"/kelompok/[id]/pertemuan">) {
  const { id } = await params;
  const { supabase, peran } = await wajibMasuk();
  const kelompok = await kelompokKelolaan(supabase, peran, id);
  if (!kelompok) redirect("/beranda");

  const hariIni = hariIniWib();
  const { data } = await supabase
    .from("pertemuan")
    .select("id, tanggal, persembahan, ditutup_pada, kehadiran(hadir)")
    .eq("kelompok_id", id)
    .order("tanggal", { ascending: false })
    .limit(26);
  const daftar = (data ?? []) as unknown as BarisPertemuan[];
  const hariIniAda = daftar.find((p) => p.tanggal === hariIni);

  return (
    <main>
      <Judul kecil={kelompok.nama}>Pertemuan &amp; absensi</Judul>
      <div className="mb-4">
        <TautanTombol href={`/kelompok/${id}`}>← Kelompok</TautanTombol>
      </div>

      <Kotak judul="Pertemuan hari ini">
        {hariIniAda ? (
          <TautanTombol href={`/kelompok/${id}/pertemuan/${hariIniAda.id}`} jenis="utama" className="w-full justify-center">
            {hariIniAda.ditutup_pada ? "Lihat pertemuan hari ini" : "Lanjutkan absensi hari ini"}
          </TautanTombol>
        ) : (
          <FormAksi aksi={mulaiPertemuan.bind(null, id)} tombol="Mulai pertemuan hari ini">
            <input type="hidden" name="tanggal" value={hariIni} />
            <p className="mb-3 text-sm opacity-70">{tanggalPanjang(hariIni)}</p>
          </FormAksi>
        )}
      </Kotak>

      <Kotak judul="Riwayat pertemuan">
        {daftar.length === 0 ? (
          <p className="opacity-70">Belum ada pertemuan tercatat.</p>
        ) : (
          <ul className="divide-y divide-black/10 dark:divide-white/10">
            {daftar.map((p) => {
              const hadir = p.kehadiran.filter((k) => k.hadir).length;
              return (
                <li key={p.id}>
                  <Link
                    href={`/kelompok/${id}/pertemuan/${p.id}`}
                    className="-mx-2 flex min-h-14 flex-wrap items-center gap-x-3 gap-y-1 rounded-lg px-2 py-2 hover:bg-black/5 dark:hover:bg-white/10"
                  >
                    <span className="font-semibold">{tanggalPanjang(p.tanggal)}</span>
                    {!p.ditutup_pada ? (
                      <span className="rounded-md border border-amber-700/50 px-2 py-0.5 text-xs font-semibold text-amber-800 dark:text-amber-300">
                        Belum ditutup
                      </span>
                    ) : null}
                    <span className="w-full text-sm opacity-70">
                      Hadir {hadir}
                      {p.ditutup_pada ? ` dari ${p.kehadiran.length}` : ""} · Persembahan{" "}
                      {p.persembahan === null ? "belum diisi" : rupiah(p.persembahan)}
                    </span>
                  </Link>
                </li>
              );
            })}
          </ul>
        )}
      </Kotak>

      <Kotak judul="Catat pertemuan yang terlewat">
        <FormAksi aksi={mulaiPertemuan.bind(null, id)} tombol="Buka pertemuan tanggal ini" jenisTombol="biasa">
          <Isian
            label="Tanggal pertemuan"
            name="tanggal"
            type="date"
            max={hariIni}
            required
            keterangan="Hanya hari ini atau tanggal yang lalu. Bila tanggal itu sudah tercatat, pertemuan itu yang dibuka."
          />
        </FormAksi>
      </Kotak>
    </main>
  );
}
