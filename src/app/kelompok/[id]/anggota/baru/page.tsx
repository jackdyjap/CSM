import { redirect } from "next/navigation";
import { FormAksi } from "@/components/form-aksi";
import { PenjelasanData } from "@/components/profil";
import { Isian, Judul, Kotak, TautanTombol } from "@/components/ui";
import { tambahAnggota } from "@/lib/aksi-profil";
import { wajibMasuk } from "@/lib/sesi";

export default async function HalamanTambahAnggota({ params }: PageProps<"/kelompok/[id]/anggota/baru">) {
  const { id } = await params;
  const { peran } = await wajibMasuk();
  const kelompok = peran.pemimpin.find((k) => k.kelompok_id === id);
  if (!kelompok) redirect("/beranda");

  return (
    <main>
      <Judul kecil={kelompok.nama}>Tambah anggota</Judul>
      <div className="mb-4">
        <TautanTombol href={`/kelompok/${id}`}>← Kembali</TautanTombol>
      </div>

      <Kotak>
        <p className="mb-3 text-sm opacity-70">
          Untuk anggota yang tidak punya HP atau perlu dibantu. Anggota yang punya HP bisa juga
          diundang lewat tautan agar mengisi profilnya sendiri.
        </p>
        <FormAksi aksi={tambahAnggota.bind(null, id)} tombol="Tambah lalu isi profil">
          <Isian label="Nama lengkap" name="nama_lengkap" required autoComplete="off" />
          <div className="mb-3 rounded-lg border border-black/10 p-3 dark:border-white/10">
            <p className="mb-2 font-medium">Persetujuan data</p>
            <PenjelasanData />
            <label className="flex items-start gap-3">
              <input type="checkbox" name="setuju" value="ya" className="mt-1 h-5 w-5 flex-none" />
              <span className="text-sm">
                Penjelasan di atas sudah saya sampaikan, dan anggota ini menyetujui datanya dicatat.
              </span>
            </label>
            <p className="mt-2 text-xs opacity-70">
              Tanpa persetujuan, hanya nama yang disimpan. Persetujuan bisa dicatat nanti.
            </p>
          </div>
        </FormAksi>
      </Kotak>
    </main>
  );
}
