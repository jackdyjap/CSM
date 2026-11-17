import { redirect } from "next/navigation";
import { CatatanKhusus } from "@/components/catatan-khusus";
import { ProyekAnggota } from "@/components/proyek-anggota";
import { ProfilBaca, ProfilUbah } from "@/components/profil";
import { FormAksi } from "@/components/form-aksi";
import { Judul, Kotak, Lipatan, Pilihan, TautanTombol } from "@/components/ui";
import { hapusAnggota, pindahKelompok, ubahStatusAktif } from "@/lib/aksi-profil";
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

  // Kelompok tujuan pindah: Admin semua kelompok; pemimpin hanya kelompok lain yang dipimpinnya.
  let tujuan: { id: string; nama: string }[] = [];
  if (bolehUbah && peran.admin) {
    const { data } = await supabase.from("kelompok").select("id, nama, tim(nama)").order("nama");
    tujuan = ((data ?? []) as unknown as { id: string; nama: string; tim: { nama: string } | null }[]).map((k) => ({
      id: k.id,
      nama: k.tim ? `${k.nama} · ${k.tim.nama}` : k.nama,
    }));
  } else if (bolehUbah) {
    tujuan = peran.pemimpin.map((k) => ({ id: k.kelompok_id, nama: `${k.nama} · ${k.tim_nama}` }));
  }
  tujuan = tujuan.filter((k) => k.id !== id);

  return (
    <main>
      <Judul kecil={profil.aktif ? kelompok?.nama : `${kelompok?.nama ?? ""} · tidak aktif`}>
        {profil.nama_lengkap}
      </Judul>
      <div className="mb-4">
        <TautanTombol href={bolehUbah ? `/kelompok/${id}` : "/beranda"}>← Kembali</TautanTombol>
      </div>
      {bolehUbah ? (
        <>
          <ProfilUbah supabase={supabase} profil={profil} olehPemimpin />
          <KelolaAnggota
            anggotaId={profil.id}
            nama={profil.nama_lengkap}
            aktif={profil.aktif}
            tujuan={tujuan}
          />
        </>
      ) : (
        <ProfilBaca supabase={supabase} profil={profil} />
      )}
      <ProyekAnggota supabase={supabase} kelompokId={id} anggotaId={profil.id} bolehUbah={bolehUbah} />
      <CatatanKhusus
        supabase={supabase}
        kelompokId={id}
        anggotaId={profil.id}
        nama={profil.nama_lengkap}
        bolehTulis={peran.admin || peran.pemimpin.some((k) => k.kelompok_id === id)}
        bolehKoreksi={peran.admin || peran.pemimpin.some((k) => k.kelompok_id === id)}
      />
    </main>
  );
}

function KelolaAnggota({
  anggotaId,
  nama,
  aktif,
  tujuan,
}: {
  anggotaId: string;
  nama: string;
  aktif: boolean;
  tujuan: { id: string; nama: string }[];
}) {
  return (
    <Kotak judul="Kelola anggota">
      <p className="text-sm opacity-70">
        Status: <strong>{aktif ? "aktif" : "tidak aktif"}</strong>. Anggota tidak aktif tidak ikut ditandai
        tidak hadir; bila ditandai hadir, otomatis aktif kembali.
      </p>
      <div className="mt-3">
        <FormAksi
          aksi={ubahStatusAktif.bind(null, anggotaId, !aktif)}
          tombol={aktif ? "Tandai tidak aktif" : "Aktifkan kembali"}
          jenisTombol="biasa"
        />
      </div>
      {tujuan.length > 0 ? (
        <Lipatan judul="Pindah ke kelompok lain">
          <FormAksi aksi={pindahKelompok.bind(null, anggotaId)} tombol="Pindahkan" jenisTombol="biasa">
            <Pilihan label="Kelompok tujuan" name="kelompok_id" required defaultValue="">
              <option value="" disabled>
                Pilih kelompok…
              </option>
              {tujuan.map((k) => (
                <option key={k.id} value={k.id}>
                  {k.nama}
                </option>
              ))}
            </Pilihan>
            <p className="mb-3 text-xs opacity-70">
              Riwayat kehadiran lama tetap tercatat di kelompok asal.
            </p>
          </FormAksi>
        </Lipatan>
      ) : null}
      <Lipatan judul="Hapus anggota">
        <p className="text-sm">
          Hapus hanya bila salah input. Profil, foto, riwayat kehadiran, dan catatan khusus {nama} ikut
          terhapus permanen. Untuk anggota yang berhenti datang, pilih <em>Tandai tidak aktif</em>.
        </p>
        <FormAksi
          aksi={hapusAnggota.bind(null, anggotaId)}
          tombol={`Hapus ${nama}`}
          jenisTombol="bahaya"
          konfirmasi={`Hapus ${nama} beserta seluruh riwayatnya? Tindakan ini tidak bisa dibatalkan.`}
        />
      </Lipatan>
    </Kotak>
  );
}
