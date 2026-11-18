import Link from "next/link";
import { redirect } from "next/navigation";
import { FormAksi } from "@/components/form-aksi";
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

const SARINGAN = { semua: "Semua", ...STATUS_MASUKAN } as const;

/**
 * Masukan yang ditujukan kepada saya: pemimpin/wakil (kelompoknya), ketua tim
 * (timnya), Admin (semua). Nama pengirim anonim hanya terlihat oleh Admin (keputusan 28).
 */
export default async function HalamanMasukanMasuk({ searchParams }: PageProps<"/masukan/masuk">) {
  const { supabase, peran } = await wajibMasuk();
  if (!peran.admin && peran.ketua_tim.length === 0 && peran.pemimpin.length === 0) redirect("/masukan");

  const s = (await searchParams).status;
  const saring = typeof s === "string" && s in SARINGAN ? (s as keyof typeof SARINGAN) : "semua";

  const { data } = await supabase.rpc("masukan_masuk");
  const semua = (data ?? []) as MasukanMasuk[];
  const daftar = saring === "semua" ? semua : semua.filter((m) => m.status === saring);

  return (
    <main>
      <Judul kecil={peran.admin ? "Admin: semua masukan" : undefined}>Masukan masuk</Judul>
      <div className="mb-4 flex flex-wrap gap-2">
        <TautanTombol href="/beranda">← Beranda</TautanTombol>
        <TautanTombol href="/masukan">Kirim masukan</TautanTombol>
      </div>

      <nav className="mb-4 flex flex-wrap gap-2 text-sm" aria-label="Saring status">
        {Object.entries(SARINGAN).map(([k, v]) => {
          const n = k === "semua" ? semua.length : semua.filter((m) => m.status === k).length;
          return (
            <Link
              key={k}
              href={k === "semua" ? "/masukan/masuk" : `/masukan/masuk?status=${k}`}
              aria-current={saring === k ? "page" : undefined}
              className={`rounded-full border px-3 py-1 ${
                saring === k ? "border-current font-semibold" : "border-black/20 opacity-70 dark:border-white/20"
              }`}
            >
              {v} ({n})
            </Link>
          );
        })}
      </nav>

      {daftar.length === 0 ? (
        <Kotak>
          <p className="opacity-70">Tidak ada masukan.</p>
        </Kotak>
      ) : (
        daftar.map((m) => (
          <Kotak key={m.id}>
            <div className="flex items-start justify-between gap-2">
              <p className="font-semibold">{m.judul}</p>
              <LabelStatus status={m.status} />
            </div>
            <p className="text-xs opacity-70">
              {JENIS_MASUKAN[m.jenis]} · untuk {TUJUAN_MASUKAN[m.tujuan]}
              {m.tujuan === "pemimpin" && m.kelompok_nama ? ` ${m.kelompok_nama}` : ""}
              {m.tujuan === "ketua_tim" && m.tim_nama ? ` ${m.tim_nama}` : ""} · {waktuWib(m.dibuat_pada)}
            </p>
            <p className="text-xs opacity-70">
              Dari:{" "}
              {m.anonim
                ? m.pengirim_nama
                  ? `tanpa nama (pengirim: ${m.pengirim_nama}, hanya terlihat oleh Admin)`
                  : "tanpa nama"
                : (m.pengirim_nama ?? "akun sudah dihapus")}
              {m.tujuan !== "pemimpin" && m.kelompok_nama ? ` · kelompok ${m.kelompok_nama}` : ""}
            </p>
            <p className="mt-2 text-sm whitespace-pre-line">{m.isi}</p>
            {m.balasan ? (
              <div className="mt-2 rounded-lg bg-black/5 p-2 text-sm dark:bg-white/10">
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
          </Kotak>
        ))
      )}
    </main>
  );
}
