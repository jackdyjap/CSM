import { redirect } from "next/navigation";
import { ProfilBaca, ProfilUbah } from "@/components/profil";
import { Judul, TautanTombol } from "@/components/ui";
import { bacaProfil } from "@/lib/profil-server";
import { kelompokKelolaan, wajibMasuk } from "@/lib/sesi";

export default async function HalamanAnggota({ params }: PageProps<"/kelompok/[id]/anggota/[anggota]">) {
  const { id, anggota } = await params;
  const { supabase, peran } = await wajibMasuk();

  // Aturan akses database menentukan siapa yang boleh membaca profil ini.
  const profil = await bacaProfil(supabase, anggota);
  if (!profil || profil.kelompok_id !== id) redirect("/beranda");

  const kelompok = await kelompokKelolaan(supabase, peran, id);
  const bolehUbah = Boolean(kelompok);

  return (
    <main>
      <Judul kecil={profil.aktif ? kelompok?.nama : `${kelompok?.nama ?? ""} · tidak aktif`}>
        {profil.nama_lengkap}
      </Judul>
      <div className="mb-4">
        <TautanTombol href={bolehUbah ? `/kelompok/${id}` : "/beranda"}>← Kembali</TautanTombol>
      </div>
      {bolehUbah ? (
        <ProfilUbah supabase={supabase} profil={profil} olehPemimpin />
      ) : (
        <ProfilBaca supabase={supabase} profil={profil} />
      )}
    </main>
  );
}
