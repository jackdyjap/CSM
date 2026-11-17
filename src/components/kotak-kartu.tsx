import { buatUlangKartu } from "@/lib/aksi-profil";
import { isiQrKartu } from "@/lib/kartu";
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
  const { data } = await supabase.from("anggota").select("kode_qr").eq("id", anggotaId).maybeSingle();
  if (!data?.kode_qr) return null;
  const svg = await svgQr(isiQrKartu(data.kode_qr));

  return (
    <section id="kartu">
      <Kotak judul={mode === "diri" ? "Kartu saya" : "Kartu QR"}>
        <div className="flex flex-col items-center">
          <div
            className={`rounded-lg bg-white p-2 ${mode === "diri" ? "[&>svg]:h-64 [&>svg]:w-64" : "[&>svg]:h-36 [&>svg]:w-36"}`}
            // SVG dibuat pustaka qrcode dari kode acak; tidak berisi masukan pengguna.
            dangerouslySetInnerHTML={{ __html: svg }}
          />
          <p className="mt-2 font-semibold">{nama}</p>
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
