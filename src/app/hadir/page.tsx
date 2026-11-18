import { Judul, Kotak, Pesan, TautanTombol } from "@/components/ui";
import { kodePertemuanDariQr } from "@/lib/kartu";
import { wajibMasuk } from "@/lib/sesi";
import { checkIn } from "./aksi";
import { CheckIn } from "./check-in";

/** Check-in mandiri anggota dengan QR pertemuan (Fase 8). */
export default async function HalamanHadir({ searchParams }: PageProps<"/hadir">) {
  const { k } = await searchParams;
  const { peran } = await wajibMasuk({ bolehBelumAtur: true });
  const kode = typeof k === "string" ? kodePertemuanDariQr(k) : null;

  return (
    <main>
      <Judul kecil={peran.anggota ? `Anggota ${peran.anggota.kelompok_nama}` : undefined}>Check-in pertemuan</Judul>
      {peran.anggota ? (
        <Kotak>
          <CheckIn kodeAwal={kode} aksi={checkIn} />
        </Kotak>
      ) : (
        <Kotak>
          <Pesan jenis="info">
            Check-in mandiri hanya untuk anggota. Akun Anda belum terhubung ke profil anggota; minta pemimpin
            kelompok mengirim tautan undangan untuk profil Anda.
          </Pesan>
          <TautanTombol href="/beranda">← Beranda</TautanTombol>
        </Kotak>
      )}
    </main>
  );
}
