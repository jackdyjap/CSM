import { redirect } from "next/navigation";
import { ProfilUbah } from "@/components/profil";
import { Judul, TautanTombol } from "@/components/ui";
import { bacaProfil } from "@/lib/profil-server";
import { wajibMasuk } from "@/lib/sesi";

export default async function HalamanProfilSaya() {
  const { supabase, peran } = await wajibMasuk();
  if (!peran.anggota) redirect("/beranda");

  const profil = await bacaProfil(supabase, peran.anggota.anggota_id);
  if (!profil) redirect("/beranda");

  return (
    <main>
      <Judul kecil={`Anggota ${peran.anggota.kelompok_nama}`}>Profil saya</Judul>
      <div className="mb-4">
        <TautanTombol href="/beranda">← Beranda</TautanTombol>
      </div>
      <ProfilUbah supabase={supabase} profil={profil} olehPemimpin={false} />
    </main>
  );
}
