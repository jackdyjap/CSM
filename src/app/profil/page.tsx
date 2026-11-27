import { redirect } from "next/navigation";
import { KotakNama, KotakSandi, KotakSelesai, ProfilStafUbah } from "@/components/atur-akun";
import { KotakKartu } from "@/components/kotak-kartu";
import { KotakLogin } from "@/components/kotak-login";
import { ProfilUbah } from "@/components/profil";
import { KotakProyekSaya } from "@/components/proyek-saya";
import { RiwayatKehadiran } from "@/components/riwayat-kehadiran";
import { TombolKirim } from "@/components/tombol-kirim";
import { Judul, Pesan, TautanTombol } from "@/components/ui";
import { keluar } from "@/lib/aksi-umum";
import { bacaProfilAman } from "@/lib/profil-server";
import { wajibMasuk } from "@/lib/sesi";

/**
 * Atur profil (keputusan 27): setiap akun mengubah sendiri kata sandi, nama,
 * cara masuk, foto, dan data pribadinya. Saat login pertama, semua akun
 * diarahkan ke sini sampai menekan "Selesai".
 */
export default async function HalamanAturProfil() {
  const { supabase, peran } = await wajibMasuk({ bolehBelumAtur: true });
  const awal = peran.perlu_atur_profil;
  // Setelah menyimpan, kembali ke layar sebelumnya; tidak saat login pertama (masih harus menekan Selesai).
  const kembali = awal ? undefined : "/beranda";

  // Login pertama: belum bisa ke Beranda, tetapi boleh keluar dan melanjutkan lain kali.
  const tombolKeluar = (
    <form action={keluar} className="mb-4">
      <TombolKirim jenis="biasa" teksProses="Keluar…">
        Keluar
      </TombolKirim>
      <span className="ml-2 text-xs opacity-70">Bisa dilanjutkan saat masuk berikutnya.</span>
    </form>
  );

  const sambutan = awal ? (
    <Pesan jenis="info">
      Selamat datang! Periksa dan atur akun Anda dulu: kata sandi, nama, cara masuk, foto, dan data pribadi.
      {peran.sandi_sementara ? " Kata sandi sementara dari Admin wajib diganti." : ""} Setelah itu tekan{" "}
      <strong>Selesai</strong> di bagian bawah. Belum sempat? Ketuk <strong>Keluar</strong>; halaman ini muncul lagi saat
      Anda masuk berikutnya.
    </Pesan>
  ) : null;

  // Admin/Ketua Tim/Pemimpin yang bukan anggota kelompok: profil staf.
  if (!peran.anggota) {
    return (
      <main>
        <Judul kecil={peran.login ?? undefined}>Atur profil</Judul>
        {awal ? (
          tombolKeluar
        ) : (
          <div className="mb-4 flex flex-wrap gap-2">
            <TautanTombol href="/beranda">← Beranda</TautanTombol>
          </div>
        )}
        {sambutan}
        {peran.sandi_sementara ? <KotakSandi sementara kembali={kembali} /> : null}
        <KotakNama nama={peran.nama} kembali={kembali} />
        <KotakLogin supabase={supabase} akunId={peran.akun_id} punyaProfil={false} kembali={kembali} />
        <ProfilStafUbah supabase={supabase} akunId={peran.akun_id} nama={peran.nama} kembali={kembali} />
        {peran.sandi_sementara ? null : <KotakSandi sementara={false} kembali={kembali} />}
        {awal ? <KotakSelesai sandiSementara={peran.sandi_sementara} /> : null}
      </main>
    );
  }

  const { profil, galat } = await bacaProfilAman(supabase, peran.anggota.anggota_id);
  if (galat) {
    return (
      <main>
        <Judul>Profil saya</Judul>
        <Pesan jenis="galat">{galat}</Pesan>
        <TautanTombol href="/beranda">← Beranda</TautanTombol>
      </main>
    );
  }
  if (!profil) redirect("/beranda");

  return (
    <main>
      <Judul kecil={`Anggota ${peran.anggota.kelompok_nama}`}>{awal ? "Atur profil" : "Profil saya"}</Judul>
      {awal ? (
        tombolKeluar
      ) : (
        <div className="mb-4 flex flex-wrap gap-2">
          <TautanTombol href="/beranda">← Beranda</TautanTombol>
          <TautanTombol href="/hadir" jenis="utama">
            Check-in pertemuan
          </TautanTombol>
        </div>
      )}
      {sambutan}
      {peran.sandi_sementara ? <KotakSandi sementara kembali={kembali} /> : null}
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
          <KotakProyekSaya supabase={supabase} />
        </>
      )}
      <ProfilUbah supabase={supabase} profil={profil} olehPemimpin={false} kembali={kembali} />
      <KotakLogin supabase={supabase} akunId={peran.akun_id} punyaProfil kembali={kembali} />
      {peran.sandi_sementara ? null : <KotakSandi sementara={false} kembali={kembali} />}
      {awal ? <KotakSelesai sandiSementara={peran.sandi_sementara} /> : null}
    </main>
  );
}
