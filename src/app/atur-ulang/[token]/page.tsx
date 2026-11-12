import { Judul, Kotak, Pesan, TautanTombol } from "@/components/ui";
import { buatClientAdmin } from "@/lib/supabase/admin";
import { FormAturUlang } from "./form-atur-ulang";

export default async function HalamanAturUlang({ params }: PageProps<"/atur-ulang/[token]">) {
  const { token } = await params;
  const { data } = await buatClientAdmin().rpc("layanan_cek_tautan_atur_ulang", { p_token: token });
  const tautan = (Array.isArray(data) ? data[0] : null) as { berlaku: boolean; nama: string } | null;

  if (!tautan?.berlaku) {
    return (
      <main>
        <Judul>Atur ulang kata sandi</Judul>
        <Pesan jenis="galat">
          Tautan ini tidak berlaku: mungkin sudah dipakai atau sudah lewat 24 jam. Minta tautan baru
          kepada pemimpin kelompok Anda.
        </Pesan>
        <TautanTombol href="/masuk">Ke halaman masuk</TautanTombol>
      </main>
    );
  }

  return (
    <main>
      <Judul kecil={`Untuk ${tautan.nama}`}>Buat kata sandi baru</Judul>
      <Kotak>
        <FormAturUlang token={token} />
      </Kotak>
    </main>
  );
}
