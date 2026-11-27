import { redirect } from "next/navigation";
import { FormAksi } from "@/components/form-aksi";
import { IsianSaatTeduh } from "@/components/isian-saat-teduh";
import { Judul, Kotak, TautanTombol } from "@/components/ui";
import { hariIniWib, KOLOM_SAAT_TEDUH, type CatatanSaatTeduh } from "@/lib/saat-teduh";
import { wajibMasuk } from "@/lib/sesi";
import { simpanSaatTeduh } from "../aksi";

/** Mengubah catatan saat teduh MILIK SAYA (catatan orang lain tidak bisa dibuka di sini). */
export default async function HalamanUbahSaatTeduh({ params }: PageProps<"/saat-teduh/[id]">) {
  const { id } = await params;
  const { supabase, peran } = await wajibMasuk();
  const { data } = await supabase
    .from("saat_teduh")
    .select(KOLOM_SAAT_TEDUH)
    .eq("id", id)
    .eq("akun_id", peran.akun_id)
    .maybeSingle();
  if (!data) redirect("/saat-teduh");
  const catatan = data as CatatanSaatTeduh;

  return (
    <main>
      <Judul>Ubah catatan saat teduh</Judul>
      <div className="mb-4">
        <TautanTombol href="/saat-teduh">← Saat Teduh</TautanTombol>
      </div>
      <Kotak>
        <FormAksi aksi={simpanSaatTeduh.bind(null, id)} tombol="Simpan perubahan" tanpaReset kembali="/saat-teduh">
          <IsianSaatTeduh awal={catatan} hariIni={hariIniWib()} />
        </FormAksi>
      </Kotak>
    </main>
  );
}
