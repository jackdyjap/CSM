import { redirect } from "next/navigation";
import { KotakKartu } from "@/components/kotak-kartu";
import { ProfilUbah } from "@/components/profil";
import { RiwayatKehadiran } from "@/components/riwayat-kehadiran";
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
      <div className="mb-4 flex flex-wrap gap-2">
        <TautanTombol href="/beranda">← Beranda</TautanTombol>
        <TautanTombol href="/hadir" jenis="utama">
          Check-in pertemuan
        </TautanTombol>
      </div>
      <KotakKartu
        supabase={supabase}
        anggotaId={profil.id}
        nama={profil.nama_lengkap}
        kelompokId={profil.kelompok_id}
        mode="diri"
      />
      <RiwayatKehadiran supabase={supabase} />
      <ProfilUbah supabase={supabase} profil={profil} olehPemimpin={false} />
    </main>
  );
}
