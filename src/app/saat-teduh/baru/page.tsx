import { FormAksi } from "@/components/form-aksi";
import { IsianSaatTeduh } from "@/components/isian-saat-teduh";
import { Judul, Kotak, TautanTombol } from "@/components/ui";
import { hariIniWib } from "@/lib/saat-teduh";
import { wajibMasuk } from "@/lib/sesi";
import { simpanSaatTeduh } from "../aksi";

export default async function HalamanCatatSaatTeduh() {
  await wajibMasuk();
  return (
    <main>
      <Judul>Catat saat teduh</Judul>
      <div className="mb-4">
        <TautanTombol href="/saat-teduh">← Saat Teduh</TautanTombol>
      </div>
      <Kotak>
        <FormAksi aksi={simpanSaatTeduh.bind(null, null)} tombol="Simpan" tanpaReset kembali="/saat-teduh">
          <IsianSaatTeduh hariIni={hariIniWib()} />
        </FormAksi>
      </Kotak>
    </main>
  );
}
