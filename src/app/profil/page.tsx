import { redirect } from "next/navigation";
import { KotakNama, KotakSandi, KotakSelesai, ProfilStafUbah } from "@/components/atur-akun";
import { KotakKartu } from "@/components/kotak-kartu";
import { KotakLogin } from "@/components/kotak-login";
import { ProfilUbah } from "@/components/profil";
import { RiwayatKehadiran } from "@/components/riwayat-kehadiran";
import { Judul, Pesan, TautanTombol } from "@/components/ui";
import { bacaProfil } from "@/lib/profil-server";
import { wajibMasuk } from "@/lib/sesi";

/**
 * Atur profil (keputusan 27): setiap akun mengubah sendiri kata sandi, nama,
 * cara masuk, foto, dan data pribadinya. Saat login pertama, semua akun
 * diarahkan ke sini sampai menekan "Selesai".
 */
export default async function HalamanAturProfil() {
  const { supabase, peran } = await wajibMasuk({ bolehBelumAtur: true });
  const awal = peran.perlu_atur_profil;

  const sambutan = awal ? (
    <Pesan jenis="info">
      Selamat datang! Periksa dan atur akun Anda dulu: kata sandi, nama, cara masuk, foto, dan data pribadi.
      {peran.sandi_sementara ? " Kata sandi sementara dari Admin wajib diganti." : ""} Setelah itu tekan{" "}
      <strong>Selesai</strong> di bagian bawah.
    </Pesan>
  ) : null;

  // Admin/Ketua Tim/Pemimpin yang bukan anggota kelompok: profil staf.
  if (!peran.anggota) {
    return (
      <main>
        <Judul kecil={peran.login ?? undefined}>Atur profil</Judul>
        {awal ? null : (
          <div className="mb-4 flex flex-wrap gap-2">
            <TautanTombol href="/beranda">← Beranda</TautanTombol>
          </div>
        )}
        {sambutan}
        {peran.sandi_sementara ? <KotakSandi sementara /> : null}
        <KotakNama nama={peran.nama} />
        <KotakLogin supabase={supabase} akunId={peran.akun_id} punyaProfil={false} />
        <ProfilStafUbah supabase={supabase} akunId={peran.akun_id} nama={peran.nama} />
        {peran.sandi_sementara ? null : <KotakSandi sementara={false} />}
        {awal ? <KotakSelesai sandiSementara={peran.sandi_sementara} /> : null}
      </main>
    );
  }

  const profil = await bacaProfil(supabase, peran.anggota.anggota_id);
  if (!profil) redirect("/beranda");

  return (
    <main>
      <Judul kecil={`Anggota ${peran.anggota.kelompok_nama}`}>{awal ? "Atur profil" : "Profil saya"}</Judul>
      {awal ? null : (
        <div className="mb-4 flex flex-wrap gap-2">
          <TautanTombol href="/beranda">← Beranda</TautanTombol>
          <TautanTombol href="/hadir" jenis="utama">
            Check-in pertemuan
          </TautanTombol>
        </div>
      )}
      {sambutan}
      {peran.sandi_sementara ? <KotakSandi sementara /> : null}
      {awal ? null : (
        <>
          <KotakKartu
            supabase={supabase}
            anggotaId={profil.id}
            nama={profil.nama_lengkap}
            kelompokId={profil.kelompok_id}
            mode="diri"
          />
          <RiwayatKehadiran supabase={supabase} />
        </>
      )}
      <ProfilUbah supabase={supabase} profil={profil} olehPemimpin={false} />
      <KotakLogin supabase={supabase} akunId={peran.akun_id} punyaProfil />
      {peran.sandi_sementara ? null : <KotakSandi sementara={false} />}
      {awal ? <KotakSelesai sandiSementara={peran.sandi_sementara} /> : null}
    </main>
  );
}
