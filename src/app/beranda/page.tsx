import { TombolKirim } from "@/components/tombol-kirim";
import { Judul, Kotak, Pesan, TautanTombol } from "@/components/ui";
import { KotakProyekSaya } from "@/components/proyek-saya";
import { keluar } from "@/lib/aksi-umum";
import { wajibMasuk } from "@/lib/sesi";

export default async function HalamanBeranda() {
  const { supabase, peran } = await wajibMasuk();
  const penerimaMasukan = peran.admin || peran.ketua_tim.length > 0 || peran.pemimpin.length > 0;
  const [{ data: masukanBaru }, { count: jumlahTraining }] = await Promise.all([
    penerimaMasukan ? supabase.rpc("jumlah_masukan_baru") : Promise.resolve({ data: 0 }),
    // Aturan akses database hanya menghitung bahan training yang ditujukan untuk saya (keputusan 54).
    supabase.from("bahan_training").select("id", { count: "exact", head: true }),
  ]);
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
            <TautanTombol href="/admin/laporan-proyek">Laporan proyek ketaatan</TautanTombol>
            <TautanTombol href="/admin/laporan-saat-teduh">Laporan saat teduh</TautanTombol>
            <TautanTombol href="/admin/bahan">Bahan diskusi</TautanTombol>
            <TautanTombol href="/admin/training">Bahan training</TautanTombol>
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

      {peran.anggota && !peran.perlu_atur_profil ? <KotakProyekSaya supabase={supabase} beranda /> : null}

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

      <Kotak judul="Saat Teduh">
        <p className="mb-3 text-sm opacity-70">Catat tanggal, waktu, bacaan Alkitab, dan tuntunan dari saat teduh Anda.</p>
        <div className="flex flex-wrap gap-2">
          <TautanTombol href="/saat-teduh/baru" jenis="utama">
            + Catat saat teduh
          </TautanTombol>
          <TautanTombol href="/saat-teduh">Riwayat saya</TautanTombol>
        </div>
      </Kotak>

      {!peran.admin && (peran.ketua_tim.length > 0 || peran.pemimpin.length > 0) ? (
        <Kotak judul="Bahan diskusi">
          <p className="mb-3 text-sm opacity-70">Bahan diskusi PDF dari Admin untuk pengurus.</p>
          <TautanTombol href="/bahan">Buka bahan diskusi</TautanTombol>
        </Kotak>
      ) : null}

      {!peran.admin && (jumlahTraining ?? 0) > 0 ? (
        <Kotak judul="Bahan training">
          <p className="mb-3 text-sm opacity-70">
            {jumlahTraining} bahan training (PDF dan video) untuk Anda, dibuka di dalam aplikasi.
          </p>
          <TautanTombol href="/training">Buka bahan training</TautanTombol>
        </Kotak>
      ) : null}

      <Kotak judul="Masukan">
        <p className="mb-3 text-sm opacity-70">Keluhan, permasalahan, atau usulan perbaikan.</p>
        <div className="flex flex-wrap gap-2">
          <TautanTombol href="/masukan">Kirim masukan</TautanTombol>
          {penerimaMasukan ? (
            <TautanTombol href="/masukan/masuk" jenis={masukanBaru ? "utama" : "biasa"}>
              Masukan masuk{masukanBaru ? ` (${masukanBaru} baru)` : ""}
            </TautanTombol>
          ) : null}
        </div>
      </Kotak>

      <div className="flex flex-wrap gap-2">
        {peran.anggota ? null : <TautanTombol href="/profil">Atur profil</TautanTombol>}
        <form action={keluar}>
          <TombolKirim jenis="biasa" teksProses="Keluar…">
            Keluar
          </TombolKirim>
        </form>
      </div>
    </main>
  );
}
