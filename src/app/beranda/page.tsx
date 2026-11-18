import { Judul, Kotak, Pesan, TautanTombol, Tombol } from "@/components/ui";
import { keluar } from "@/lib/aksi-umum";
import { wajibMasuk } from "@/lib/sesi";

export default async function HalamanBeranda() {
  const { peran } = await wajibMasuk();
  const tanpaPeran =
    !peran.admin && peran.ketua_tim.length === 0 && peran.pemimpin.length === 0 && !peran.anggota;

  return (
    <main>
      <Judul kecil={peran.login ?? undefined}>Halo, {peran.nama}</Judul>

      {tanpaPeran ? (
        <Pesan jenis="info">
          Akun Anda belum diberi peran. Hubungi Admin atau pemimpin kelompok Anda.
        </Pesan>
      ) : null}

      {peran.admin ? (
        <Kotak judul="Admin">
          <div className="flex flex-wrap gap-2">
            <TautanTombol href="/admin">Tim &amp; kelompok</TautanTombol>
            <TautanTombol href="/admin/akun">Akun &amp; peran</TautanTombol>
            <TautanTombol href="/admin/laporan">Laporan demografi</TautanTombol>
          </div>
        </Kotak>
      ) : null}

      {peran.pemimpin.length > 0 ? (
        <Kotak judul="Kelompok yang saya pimpin">
          <ul className="space-y-2">
            {peran.pemimpin.map((k) => (
              <li key={k.kelompok_id}>
                <TautanTombol href={`/kelompok/${k.kelompok_id}`} className="w-full justify-between">
                  <span>{k.nama}</span>
                  <span className="text-sm opacity-70">
                    {k.jabatan === "wakil" ? "Wakil" : "Pemimpin"} · {k.tim_nama}
                  </span>
                </TautanTombol>
              </li>
            ))}
          </ul>
        </Kotak>
      ) : null}

      {peran.ketua_tim.length > 0 ? (
        <Kotak judul="Tim yang saya ketuai">
          <ul className="space-y-2">
            {peran.ketua_tim.map((t) => (
              <li key={t.tim_id}>
                <TautanTombol href={`/tim/${t.tim_id}`} className="w-full justify-between">
                  <span>{t.nama}</span>
                  <span className="text-sm opacity-70">Dashboard →</span>
                </TautanTombol>
              </li>
            ))}
          </ul>
        </Kotak>
      ) : null}

      {peran.anggota ? (
        <Kotak judul="Keanggotaan saya">
          <p>
            Anggota <strong>{peran.anggota.kelompok_nama}</strong>
          </p>
          <div className="mt-3 grid grid-cols-2 gap-2">
            <TautanTombol href="/hadir" jenis="utama" className="justify-center">
              Check-in pertemuan
            </TautanTombol>
            <TautanTombol href="/profil" className="justify-center">
              Profil &amp; kartu saya
            </TautanTombol>
          </div>
          <p className="mt-2 text-sm opacity-70">
            Saat pertemuan, scan QR di layar pemimpin dengan kamera HP. Riwayat kehadiran ada di Profil saya.
          </p>
        </Kotak>
      ) : null}

      <div className="flex flex-wrap gap-2">
        {peran.anggota ? null : <TautanTombol href="/profil">Atur profil</TautanTombol>}
        <form action={keluar}>
          <Tombol type="submit" jenis="biasa">
            Keluar
          </Tombol>
        </form>
      </div>
    </main>
  );
}
