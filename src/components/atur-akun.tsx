import { FormAksi } from "@/components/form-aksi";
import { IsianLahir } from "@/components/isian-lahir";
import { IsianSandi } from "@/components/isian-sandi";
import { PilihWilayah } from "@/components/pilih-wilayah";
import { PilihanEnum } from "@/components/profil";
import { Isian, IsianPanjang, Kotak, Pesan } from "@/components/ui";
import { UnggahFoto } from "@/components/unggah-foto";
import {
  catatPersetujuanStaf,
  gantiSandi,
  hapusFotoStaf,
  selesaiAturProfil,
  simpanProfilStaf,
  ubahNamaSaya,
  unggahFotoStaf,
} from "@/lib/aksi-akun";
import { PANJANG_SANDI_MINIMAL } from "@/lib/identitas";
import {
  kunciBaptis,
  PILIHAN_BAPTIS,
  PILIHAN_GENDER,
  PILIHAN_NIKAH,
  PILIHAN_PEKERJAAN,
  PILIHAN_PENDIDIKAN,
  type Profil,
} from "@/lib/profil";
import { daftarWilayahAwal, tautanFoto } from "@/lib/profil-server";
import type { buatClientServer } from "@/lib/supabase/server";

type Supabase = Awaited<ReturnType<typeof buatClientServer>>;

/** Ganti kata sandi sendiri (tanpa kata sandi lama, keputusan 27). */
export function KotakSandi({ sementara, kembali }: { sementara: boolean; kembali?: string }) {
  return (
    <Kotak judul={sementara ? "Ganti kata sandi sementara" : "Ganti kata sandi"}>
      {sementara ? (
        <Pesan jenis="info">Kata sandi Anda dibuat oleh Admin. Ganti dengan kata sandi pilihan Anda sendiri.</Pesan>
      ) : null}
      <FormAksi
        aksi={gantiSandi}
        tombol="Simpan kata sandi baru"
        jenisTombol={sementara ? "utama" : "biasa"}
        kembali={kembali}
      >
        <IsianSandi
          label="Kata sandi baru"
          name="sandi"
          minLength={PANJANG_SANDI_MINIMAL}
          autoComplete="new-password"
          keterangan={`Minimal ${PANJANG_SANDI_MINIMAL} karakter.`}
          required
        />
        <IsianSandi
          label="Ulangi kata sandi baru"
          name="sandi_ulang"
          minLength={PANJANG_SANDI_MINIMAL}
          autoComplete="new-password"
          required
        />
      </FormAksi>
    </Kotak>
  );
}

/** Nama untuk akun tanpa profil anggota (anggota mengubah nama di Data diri). */
export function KotakNama({ nama, kembali }: { nama: string; kembali?: string }) {
  return (
    <Kotak judul="Nama">
      <FormAksi aksi={ubahNamaSaya} tombol="Simpan nama" jenisTombol="biasa" tanpaReset kembali={kembali}>
        <Isian label="Nama lengkap" name="nama" defaultValue={nama} autoComplete="name" required />
      </FormAksi>
    </Kotak>
  );
}

/** Tombol penutup Atur profil saat login pertama. */
export function KotakSelesai({ sandiSementara }: { sandiSementara: boolean }) {
  return (
    <Kotak judul="Selesai">
      <p className="mb-3 text-sm">
        {sandiSementara
          ? "Ganti kata sandi sementara di atas dulu, lalu tekan Selesai."
          : "Data pribadi boleh dilengkapi nanti lewat Atur profil di Beranda."}
      </p>
      <FormAksi aksi={selesaiAturProfil} tombol="Selesai, ke Beranda" />
    </Kotak>
  );
}

type ProfilStaf = Pick<
  Profil,
  | "gender" | "foto_path" | "tempat_lahir" | "tanggal_lahir" | "alamat" | "provinsi_kode" | "kota_kode"
  | "kecamatan_kode" | "kelurahan_kode" | "status_nikah" | "pendidikan" | "pekerjaan" | "baptis"
>;

/** Foto dan data pribadi Admin/Ketua Tim/Pemimpin yang bukan anggota kelompok. */
export async function ProfilStafUbah({
  supabase,
  akunId,
  nama,
  kembali,
}: {
  supabase: Supabase;
  akunId: string;
  nama: string;
  kembali?: string;
}) {
  const { data } = await supabase
    .from("profil_staf")
    .select(
      "gender, foto_path, tempat_lahir, tanggal_lahir, alamat, provinsi_kode, kota_kode, kecamatan_kode, " +
        "kelurahan_kode, status_nikah, pendidikan, pekerjaan, baptis",
    )
    .eq("akun_id", akunId)
    .maybeSingle();
  const profil = data as ProfilStaf | null;

  if (!profil) {
    return (
      <Kotak judul="Foto dan data pribadi">
        <div className="mb-3 space-y-2 text-sm">
          <p>
            Foto dan data pribadi (gender, tempat dan tanggal lahir, alamat, status pernikahan, pendidikan,
            pekerjaan) membantu pengurus mengenal para pemimpin.
          </p>
          <p>
            Data ini hanya dapat dilihat oleh Anda sendiri dan Admin, disimpan secara privat, dan tidak masuk
            laporan anggota. Anda bisa mengubah atau menghapusnya kapan saja.
          </p>
        </div>
        <FormAksi aksi={catatPersetujuanStaf} tombol="Setuju dan isi profil">
          <label className="mb-3 flex items-start gap-3">
            <input type="checkbox" name="setuju" value="ya" required className="mt-1 h-5 w-5 flex-none" />
            <span className="text-sm">Saya sudah membaca penjelasan di atas dan menyetujui data saya dicatat.</span>
          </label>
        </FormAksi>
      </Kotak>
    );
  }

  const [foto, wilayah] = await Promise.all([tautanFoto(supabase, profil.foto_path), daftarWilayahAwal(supabase, profil)]);

  return (
    <>
      <Kotak judul="Foto">
        <UnggahFoto unggah={unggahFotoStaf} hapus={hapusFotoStaf} tautanFoto={foto} nama={nama} kamera="user" />
      </Kotak>
      <Kotak judul="Data pribadi">
        <FormAksi aksi={simpanProfilStaf} tombol="Simpan data pribadi" tanpaReset kembali={kembali}>
          <PilihanEnum label="Gender" name="gender" daftar={PILIHAN_GENDER} nilai={profil.gender} />
          <Isian label="Tempat lahir" name="tempat_lahir" defaultValue={profil.tempat_lahir ?? ""} />
          <IsianLahir tanggalAwal={profil.tanggal_lahir} waliNamaAwal={null} waliHubunganAwal={null} />
          <IsianPanjang
            label="Alamat lengkap"
            name="alamat"
            defaultValue={profil.alamat ?? ""}
            placeholder="Nama jalan, nomor rumah, RT/RW"
          />
          <PilihWilayah
            awal={[profil.provinsi_kode, profil.kota_kode, profil.kecamatan_kode, profil.kelurahan_kode]}
            daftarAwal={wilayah}
          />
          <PilihanEnum label="Status pernikahan" name="status_nikah" daftar={PILIHAN_NIKAH} nilai={profil.status_nikah} />
          <PilihanEnum label="Pendidikan terakhir" name="pendidikan" daftar={PILIHAN_PENDIDIKAN} nilai={profil.pendidikan} />
          <PilihanEnum label="Pekerjaan" name="pekerjaan" daftar={PILIHAN_PEKERJAAN} nilai={profil.pekerjaan} />
          <PilihanEnum label="Baptis" name="baptis" daftar={PILIHAN_BAPTIS} nilai={kunciBaptis(profil.baptis)} />
        </FormAksi>
      </Kotak>
    </>
  );
}
