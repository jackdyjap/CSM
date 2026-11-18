import { redirect } from "next/navigation";
import { KartuAnggota } from "@/components/kartu-anggota";
import { TombolCetak } from "@/components/tombol-cetak";
import { Judul, TautanTombol } from "@/components/ui";
import { tampilHp } from "@/lib/identitas";
import { isiQrKartu } from "@/lib/kartu";
import { tautanFotoBanyak } from "@/lib/profil-server";
import { svgQr } from "@/lib/qr-server";
import { kelompokKelolaan, wajibMasuk } from "@/lib/sesi";

/** Lembar cetak kartu anggota: 8 kartu seukuran KTP per A4 (keputusan 22). */
export default async function HalamanKartu({ params, searchParams }: PageProps<"/kelompok/[id]/kartu">) {
  const { id } = await params;
  const satu = (await searchParams).anggota;
  const { supabase, peran } = await wajibMasuk();
  const kelompok = await kelompokKelolaan(supabase, peran, id);
  if (!kelompok) redirect("/beranda");

  let kueri = supabase.from("anggota").select("id, nama_lengkap, kode_qr, foto_path, no_hp").eq("kelompok_id", id).order("nama_lengkap");
  kueri = typeof satu === "string" ? kueri.eq("id", satu) : kueri.eq("aktif", true);
  const { data } = await kueri;
  const foto = await tautanFotoBanyak(
    supabase,
    (data ?? []).flatMap((a) => (a.foto_path ? [a.foto_path] : [])),
  );
  const anggota = await Promise.all(
    (data ?? []).map(async (a) => ({
      ...a,
      svg: await svgQr(isiQrKartu(a.kode_qr)),
      foto: a.foto_path ? (foto.get(a.foto_path) ?? null) : null,
    })),
  );

  return (
    <main>
      <div className="jangan-cetak">
        <Judul kecil={kelompok.nama}>Cetak kartu anggota</Judul>
        <div className="mb-4 flex flex-wrap gap-2">
          <TautanTombol href={typeof satu === "string" ? `/kelompok/${id}/anggota/${satu}` : `/kelompok/${id}`}>
            ← Kembali
          </TautanTombol>
          {anggota.length > 0 ? <TombolCetak teks={`Cetak ${anggota.length} kartu`} /> : null}
        </div>
        <p className="mb-4 text-sm opacity-70">
          Ukuran KTP (8,5 × 5,4 cm), 8 kartu per lembar A4. Saat mencetak, pilih ukuran kertas A4 dan skala
          100% (bukan &ldquo;sesuaikan halaman&rdquo;). Gunting di garis putus-putus; boleh dilaminating. Kartu memuat foto dan nomor HP: simpan dan bagikan dengan hati-hati.
          {typeof satu === "string" ? null : " Hanya anggota aktif yang dicetak."}
        </p>
      </div>

      {anggota.length === 0 ? (
        <p className="opacity-70">Tidak ada anggota untuk dicetak.</p>
      ) : (
        <div className="overflow-x-auto">
          <div className="grid w-max grid-cols-[repeat(2,85.6mm)] gap-[4mm] bg-white p-[2mm] print:p-0">
            {anggota.map((a) => (
              <KartuAnggota
                key={a.id}
                nama={a.nama_lengkap}
                kelompok={kelompok.nama}
                svg={a.svg}
                foto={a.foto}
                noHp={tampilHp(a.no_hp)}
              />
            ))}
          </div>
        </div>
      )}
    </main>
  );
}
