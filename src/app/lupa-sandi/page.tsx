import { Judul, Kotak, TautanTombol } from "@/components/ui";

export default function HalamanLupaSandi() {
  return (
    <main>
      <Judul>Lupa kata sandi</Judul>
      <Kotak>
        <ol className="list-decimal space-y-2 pl-5">
          <li>Hubungi <strong>pemimpin kelompok</strong> Anda (atau Admin bila Anda pemimpin).</li>
          <li>Mereka akan mengirim <strong>tautan atur ulang</strong> lewat WhatsApp. Tautan berlaku 24 jam.</li>
          <li>Buka tautan itu, lalu buat kata sandi baru.</li>
        </ol>
      </Kotak>
      <TautanTombol href="/masuk">← Kembali ke halaman masuk</TautanTombol>
    </main>
  );
}
