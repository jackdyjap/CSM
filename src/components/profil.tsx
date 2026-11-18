import { catatPersetujuan, hapusFoto, simpanProfil, unggahFoto } from "@/lib/aksi-profil";
import { tampilHp } from "@/lib/identitas";
import {
  hitungUsia,
  isianKosong,
  kunciBaptis,
  PILIHAN_BAPTIS,
  PILIHAN_STATUS_JEMAAT,
  PILIHAN_GENDER,
  PILIHAN_NIKAH,
  PILIHAN_PEKERJAAN,
  PILIHAN_PENDIDIKAN,
  type Profil,
} from "@/lib/profil";
import { daftarWilayahAwal, namaWilayah, tautanFoto } from "@/lib/profil-server";
import type { buatClientServer } from "@/lib/supabase/server";
import { FormAksi } from "./form-aksi";
import { IsianLahir } from "./isian-lahir";
import { PilihWilayah } from "./pilih-wilayah";
import { Isian, IsianPanjang, Kotak, Pesan, Pilihan } from "./ui";
import { UnggahFoto } from "./unggah-foto";

type Supabase = Awaited<ReturnType<typeof buatClientServer>>;

/** Penjelasan tujuan pencatatan data (UU PDP). */
export function PenjelasanData() {
  return (
    <div className="mb-3 space-y-2 text-sm">
      <p>Data profil dicatat untuk:</p>
      <ul className="list-disc space-y-1 pl-5">
        <li>membantu pemimpin kelompok mengenal dan memperhatikan anggota,</li>
        <li>mencatat kehadiran pertemuan mingguan,</li>
        <li>laporan jumlah anggota (tanpa nama) untuk pengurus.</li>
      </ul>
      <p>
        Data hanya dapat dilihat oleh pemimpin kelompok, ketua tim, dan admin. Foto disimpan secara
        privat. Data bisa diperbaiki atau dihapus atas permintaan anggota. Bila anggota tidak aktif
        selama satu tahun, datanya dihapus otomatis.
      </p>
    </div>
  );
}

/** Label kelengkapan profil: "Lengkap" atau "Belum lengkap (3)". */
export function LabelKelengkapan({ kosong }: { kosong: string[] }) {
  return kosong.length === 0 ? (
    <span className="rounded-md border border-green-700/50 px-2 py-0.5 text-xs font-semibold text-green-800 dark:text-green-300">
      Lengkap
    </span>
  ) : (
    <span className="rounded-md border border-amber-700/50 px-2 py-0.5 text-xs font-semibold text-amber-800 dark:text-amber-300">
      Belum lengkap ({kosong.length})
    </span>
  );
}

function KotakKelengkapan({ profil }: { profil: Profil }) {
  const kosong = isianKosong(profil);
  return kosong.length === 0 ? (
    <Pesan jenis="sukses">Profil sudah lengkap.</Pesan>
  ) : (
    <Pesan jenis="info">Belum diisi: {kosong.join(", ")}.</Pesan>
  );
}

/**
 * Halaman profil yang bisa diubah (oleh anggota sendiri atau pemimpinnya).
 * Bila persetujuan belum tercatat, yang tampil hanya layar persetujuan.
 */
export async function ProfilUbah({
  supabase,
  profil,
  olehPemimpin,
  kembali,
}: {
  supabase: Supabase;
  profil: Profil;
  olehPemimpin: boolean;
  /** Halaman tujuan setelah profil tersimpan (lihat FormAksi). */
  kembali?: string;
}) {
  if (!profil.persetujuan_pada) {
    return (
      <Kotak judul="Persetujuan data">
        <PenjelasanData />
        <FormAksi aksi={catatPersetujuan.bind(null, profil.id)} tombol="Catat persetujuan">
          <label className="mb-3 flex items-start gap-3">
            <input type="checkbox" name="setuju" value="ya" required className="mt-1 h-5 w-5 flex-none" />
            <span className="text-sm">
              {olehPemimpin
                ? `${profil.nama_lengkap} sudah saya jelaskan tentang tujuan pencatatan di atas dan menyetujui datanya dicatat.`
                : "Saya sudah membaca penjelasan di atas dan menyetujui data saya dicatat."}
            </span>
          </label>
        </FormAksi>
      </Kotak>
    );
  }

  const [foto, wilayah] = await Promise.all([
    tautanFoto(supabase, profil.foto_path),
    daftarWilayahAwal(supabase, profil),
  ]);

  return (
    <>
      <KotakKelengkapan profil={profil} />

      <Kotak judul="Foto">
        <UnggahFoto
          unggah={unggahFoto.bind(null, profil.id)}
          hapus={hapusFoto.bind(null, profil.id)}
          tautanFoto={foto}
          nama={profil.nama_lengkap}
          kamera={olehPemimpin ? "environment" : "user"}
        />
      </Kotak>

      <Kotak judul="Data diri">
        <FormAksi aksi={simpanProfil.bind(null, profil.id)} tombol="Simpan profil" tanpaReset kembali={kembali}>
          <Isian label="Nama lengkap" name="nama_lengkap" defaultValue={profil.nama_lengkap} required />
          <PilihanEnum label="Gender" name="gender" daftar={PILIHAN_GENDER} nilai={profil.gender} />
          <Isian label="Tempat lahir" name="tempat_lahir" defaultValue={profil.tempat_lahir ?? ""} />
          <IsianLahir
            tanggalAwal={profil.tanggal_lahir}
            waliNamaAwal={profil.wali_nama}
            waliHubunganAwal={profil.wali_hubungan}
          />
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
          <Isian
            label="Nomor HP (opsional)"
            keterangan="Bila orang ini punya akun, nomor ini juga dipakai untuk masuk ke aplikasi."
            name="no_hp"
            type="tel"
            inputMode="tel"
            defaultValue={tampilHp(profil.no_hp)}
            placeholder="08xxxxxxxxxx"
          />
        </FormAksi>
      </Kotak>

      <p className="mb-4 text-xs opacity-70">
        Persetujuan data dicatat oleh {profil.persetujuan_dicatat_oleh === "anggota_sendiri" ? "anggota sendiri" : "pemimpin"}.
      </p>
    </>
  );
}

export function PilihanEnum({
  label,
  name,
  daftar,
  nilai,
}: {
  label: string;
  name: string;
  daftar: Record<string, string>;
  nilai: string | null;
}) {
  return (
    <Pilihan label={label} name={name} defaultValue={nilai ?? ""}>
      <option value="">— Pilih —</option>
      {Object.entries(daftar).map(([k, v]) => (
        <option key={k} value={k}>
          {v}
        </option>
      ))}
    </Pilihan>
  );
}

/** Profil baca-saja (untuk Ketua Tim dan Admin). */
export async function ProfilBaca({ supabase, profil }: { supabase: Supabase; profil: Profil }) {
  const [foto, wilayah] = await Promise.all([
    tautanFoto(supabase, profil.foto_path),
    namaWilayah(supabase, profil),
  ]);
  const usia = profil.tanggal_lahir ? hitungUsia(profil.tanggal_lahir) : null;
  const baris: [string, string | null][] = [
    ["Gender", profil.gender ? PILIHAN_GENDER[profil.gender] : null],
    ["Tempat, tanggal lahir", [profil.tempat_lahir, profil.tanggal_lahir].filter(Boolean).join(", ") || null],
    ["Usia", usia !== null ? `${usia} tahun` : null],
    ["Alamat", profil.alamat],
    ["Wilayah", wilayah],
    ["Status pernikahan", profil.status_nikah ? PILIHAN_NIKAH[profil.status_nikah] : null],
    ["Pendidikan terakhir", profil.pendidikan ? PILIHAN_PENDIDIKAN[profil.pendidikan] : null],
    ["Pekerjaan", profil.pekerjaan ? PILIHAN_PEKERJAAN[profil.pekerjaan] : null],
    ["Baptis", profil.baptis === null ? null : PILIHAN_BAPTIS[kunciBaptis(profil.baptis)!]],
    ["Status jemaat", profil.status_jemaat ? PILIHAN_STATUS_JEMAAT[profil.status_jemaat] : null],
    ["Nomor HP", tampilHp(profil.no_hp) || null],
    ["Orang tua/wali", profil.wali_nama ? `${profil.wali_nama}${profil.wali_hubungan ? ` (${profil.wali_hubungan})` : ""}` : null],
  ];

  return (
    <>
      {profil.persetujuan_pada ? (
        <KotakKelengkapan profil={profil} />
      ) : (
        <Pesan jenis="info">Persetujuan data belum dicatat, jadi profil belum bisa diisi.</Pesan>
      )}
      <Kotak>
        {foto ? (
          // eslint-disable-next-line @next/next/no-img-element -- tautan sementara dari penyimpanan privat
          <img
            src={foto}
            alt={`Foto ${profil.nama_lengkap}`}
            className="mb-4 h-24 w-24 rounded-full border border-black/10 object-cover dark:border-white/10"
          />
        ) : null}
        <dl className="divide-y divide-black/10 dark:divide-white/10">
          {baris.map(([label, nilai]) => (
            <div key={label} className="grid grid-cols-[9rem_1fr] gap-2 py-2 text-sm">
              <dt className="opacity-70">{label}</dt>
              <dd>{nilai ?? <span className="opacity-50">Belum diisi</span>}</dd>
            </div>
          ))}
        </dl>
      </Kotak>
    </>
  );
}
