import { buatUlangKartu } from "@/lib/aksi-profil";
import { tampilHp } from "@/lib/identitas";
import { isiQrKartu } from "@/lib/kartu";
import { tautanFoto } from "@/lib/profil-server";
import { svgQr } from "@/lib/qr-server";
import type { buatClientServer } from "@/lib/supabase/server";
import { FormAksi } from "./form-aksi";
import { Kotak, Lipatan, TautanTombol } from "./ui";

type Supabase = Awaited<ReturnType<typeof buatClientServer>>;

/**
 * QR kartu anggota.
 *  mode "diri"   : Profil saya — QR besar untuk ditunjukkan ke pemimpin.
 *  mode "kelola" : profil anggota (pemimpin/Admin) — cetak & buat ulang kode.
 */
export async function KotakKartu({
  supabase,
  anggotaId,
  nama,
  kelompokId,
  mode,
}: {
  supabase: Supabase;
  anggotaId: string;
  nama: string;
  kelompokId: string;
  mode: "diri" | "kelola";
}) {
  const { data } = await supabase
    .from("anggota")
    .select("kode_qr, foto_path, no_hp")
    .eq("id", anggotaId)
    .maybeSingle();
  if (!data?.kode_qr) return null;
  const [svg, foto] = await Promise.all([svgQr(isiQrKartu(data.kode_qr)), tautanFoto(supabase, data.foto_path)]);
  const noHp = tampilHp(data.no_hp);

  return (
    <section id="kartu">
      <Kotak judul={mode === "diri" ? "Kartu saya" : "Kartu QR"}>
        <div className="flex flex-col items-center">
          <div
            className={`rounded-lg bg-white p-2 ${mode === "diri" ? "[&>svg]:h-64 [&>svg]:w-64" : "[&>svg]:h-36 [&>svg]:w-36"}`}
            // SVG dibuat pustaka qrcode dari kode acak; tidak berisi masukan pengguna.
            dangerouslySetInnerHTML={{ __html: svg }}
          />
          <div className="mt-3 flex items-center gap-3">
            {foto ? (
              // eslint-disable-next-line @next/next/no-img-element -- tautan sementara dari penyimpanan privat
              <img src={foto} alt="" className="h-16 w-14 rounded-md bg-black/10 object-cover" />
            ) : null}
            <div>
              <p className="font-semibold">{nama}</p>
              {noHp ? <p className="text-sm opacity-80">{noHp}</p> : null}
            </div>
          </div>
        </div>
        {mode === "diri" ? (
          <p className="mt-3 text-center text-sm opacity-70">
            Tunjukkan QR ini kepada pemimpin kelompok saat absensi. Naikkan kecerahan layar bila sulit terbaca.
          </p>
        ) : (
          <>
            <div className="mt-3 flex flex-wrap justify-center gap-2">
              <TautanTombol href={`/kelompok/${kelompokId}/kartu?anggota=${anggotaId}`}>Cetak kartu ini</TautanTombol>
            </div>
            <Lipatan judul="Kartu hilang? Buat ulang kode">
              <p className="text-sm">
                Kode baru membuat kartu lama (cetakan maupun di HP) tidak berlaku lagi. Setelah itu cetak kartu baru.
              </p>
              <FormAksi
                aksi={buatUlangKartu.bind(null, anggotaId)}
                tombol="Buat ulang kode kartu"
                jenisTombol="bahaya"
                konfirmasi={`Buat ulang kode kartu ${nama}? Kartu lama tidak bisa dipakai lagi.`}
              />
            </Lipatan>
          </>
        )}
      </Kotak>
    </section>
  );
}
