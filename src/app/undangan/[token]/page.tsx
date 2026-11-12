import { Judul, Kotak, Pesan, TautanTombol } from "@/components/ui";
import { buatClientAdmin } from "@/lib/supabase/admin";
import { FormDaftar } from "./form-daftar";

type Undangan = { berlaku: boolean; kelompok_nama: string; tim_nama: string; nama_anggota: string | null };

export default async function HalamanUndangan({ params }: PageProps<"/undangan/[token]">) {
  const { token } = await params;
  const { data } = await buatClientAdmin().rpc("layanan_cek_undangan", { p_token: token });
  const undangan = (Array.isArray(data) ? data[0] : null) as Undangan | null;

  if (!undangan?.berlaku) {
    return (
      <main>
        <Judul>Undangan</Judul>
        <Pesan jenis="galat">
          Tautan undangan ini tidak berlaku: mungkin sudah dipakai atau sudah lewat 7 hari. Minta
          tautan baru kepada pemimpin kelompok Anda.
        </Pesan>
        <TautanTombol href="/masuk">Ke halaman masuk</TautanTombol>
      </main>
    );
  }

  return (
    <main>
      <Judul kecil={undangan.tim_nama}>Bergabung dengan {undangan.kelompok_nama}</Judul>
      <Kotak>
        <FormDaftar token={token} namaAwal={undangan.nama_anggota ?? ""} />
      </Kotak>
      <p className="text-center text-sm opacity-70">
        Sudah punya akun? <a href="/masuk" className="underline">Masuk di sini</a>.
      </p>
    </main>
  );
}
