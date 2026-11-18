import { redirect } from "next/navigation";
import { FormAksi } from "@/components/form-aksi";
import { Isian, Judul, Kotak, Pesan, TautanTombol, Tombol } from "@/components/ui";
import { aksesKelompok, wajibMasuk } from "@/lib/sesi";
import { masukkanAkun } from "../aksi";

type Akun = { akun_id: string; nama: string; login: string | null; peran?: string | null };

/**
 * Memasukkan akun yang belum tergabung di kelompok mana pun ke kelompok ini
 * (keputusan 35). Pemimpin/Ketua Tim mencari dengan isian persis; Admin juga
 * melihat daftar lengkap.
 */
export default async function HalamanMasukkanAkun({ params, searchParams }: PageProps<"/kelompok/[id]/masukkan-akun">) {
  const { id } = await params;
  const c = (await searchParams).cari;
  const cari = typeof c === "string" ? c.trim() : "";
  const { supabase, peran } = await wajibMasuk();
  const kelompok = await aksesKelompok(supabase, peran, id);
  if (!kelompok) redirect("/beranda");

  const [{ data: dataCari, error: galatCari }, { data: dataSemua }] = await Promise.all([
    cari ? supabase.rpc("cari_akun_belum_tergabung", { p_isian: cari }) : Promise.resolve({ data: null, error: null }),
    peran.admin ? supabase.rpc("akun_belum_tergabung") : Promise.resolve({ data: null }),
  ]);
  const hasil = (dataCari ?? []) as Akun[];
  const semua = (dataSemua ?? []) as Akun[];

  return (
    <main>
      <Judul kecil={kelompok.nama}>Masukkan akun yang sudah ada</Judul>
      <div className="mb-4">
        <TautanTombol href={`/kelompok/${id}`}>← Kembali</TautanTombol>
      </div>

      <Kotak judul="Cari akun">
        <p className="mb-3 text-sm opacity-70">
          Untuk orang yang sudah punya akun tetapi belum tergabung di kelompok mana pun. Ketik nama pengguna, email,
          atau nomor HP-nya <strong>persis</strong>.
        </p>
        <form method="get">
          <Isian
            label="Nama pengguna, email, atau nomor HP"
            name="cari"
            defaultValue={cari}
            autoCapitalize="none"
            spellCheck={false}
            required
          />
          <Tombol type="submit">Cari</Tombol>
        </form>
      </Kotak>

      {cari ? (
        galatCari ? (
          <Pesan jenis="galat">{galatCari.message}</Pesan>
        ) : hasil.length === 0 ? (
          <Pesan jenis="info">
            Tidak ada akun yang belum tergabung dengan isian &ldquo;{cari}&rdquo;. Periksa ejaannya. Bila orang itu
            sudah tergabung di kelompok lain, minta pemimpinnya atau Admin memakai <em>Pindah ke kelompok lain</em> di
            profil anggotanya.
          </Pesan>
        ) : (
          <Kotak judul="Ditemukan">
            <DaftarAkun akun={hasil} kelompokId={id} namaKelompok={kelompok.nama} />
          </Kotak>
        )
      ) : null}

      {peran.admin ? (
        <Kotak judul={`Semua akun yang belum tergabung (${semua.length})`}>
          {semua.length === 0 ? (
            <p className="opacity-70">Semua akun sudah tergabung di sebuah kelompok.</p>
          ) : (
            <DaftarAkun akun={semua} kelompokId={id} namaKelompok={kelompok.nama} />
          )}
        </Kotak>
      ) : null}
    </main>
  );
}

function DaftarAkun({ akun, kelompokId, namaKelompok }: { akun: Akun[]; kelompokId: string; namaKelompok: string }) {
  return (
    <ul className="divide-y divide-black/10 dark:divide-white/10">
      {akun.map((a) => (
        <li key={a.akun_id} className="py-3">
          <p className="font-semibold">{a.nama}</p>
          <p className="mb-2 text-sm opacity-70">
            {a.login ?? "-"}
            {a.peran ? ` · ${a.peran}` : ""}
          </p>
          <FormAksi
            aksi={masukkanAkun.bind(null, kelompokId, a.akun_id)}
            tombol={`Masukkan ke ${namaKelompok}`}
            konfirmasi={`Masukkan ${a.nama} sebagai anggota ${namaKelompok}?`}
          />
        </li>
      ))}
    </ul>
  );
}
