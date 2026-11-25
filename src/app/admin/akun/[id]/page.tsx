import { notFound } from "next/navigation";
import { FormAksi } from "@/components/form-aksi";
import { FormBeriPeran } from "@/components/form-beri-peran";
import { IsianLogin } from "@/components/isian-login";
import { Isian, Judul, Kotak, Lipatan, TautanTombol } from "@/components/ui";
import { ambilAkun, labelPenugasan } from "@/lib/akun-admin";
import { tampilHp } from "@/lib/identitas";
import { wajibAdmin } from "@/lib/sesi";
import { buatTautanAturUlang, hapusAkun, hapusPeran, ubahLoginAkun, ubahNamaAkun } from "../../aksi";

type BarisKelompok = { id: string; nama: string; tim: { nama: string } | null };

/** Detail satu akun: peran, atur ulang kata sandi, cara masuk, nama, hapus akun. */
export default async function HalamanDetailAkun({ params }: PageProps<"/admin/akun/[id]">) {
  const { id } = await params;
  if (!/^[0-9a-f-]{36}$/.test(id)) notFound();
  const { supabase, peran } = await wajibAdmin();

  const [a, { data: tim }, { data: dataKelompok }] = await Promise.all([
    ambilAkun(supabase, id),
    supabase.from("tim").select("id, nama").order("nama"),
    supabase.from("kelompok").select("id, nama, tim(nama)").order("nama"),
  ]);
  if (!a) notFound();
  const kelompok = (dataKelompok ?? []) as unknown as BarisKelompok[];
  const kel = a.anggota?.kelompok;

  return (
    <main>
      <Judul kecil={a.login ?? "Akun"}>{a.nama_tampilan}</Judul>
      <div className="mb-4">
        <TautanTombol href="/admin/akun">← Daftar akun</TautanTombol>
      </div>

      <Kotak judul="Peran dan keanggotaan">
        <ul className="mb-2 space-y-2 text-sm">
          {kel ? (
            <li>
              Anggota · {kel.nama}
              {kel.tim ? ` (${kel.tim.nama})` : ""}
            </li>
          ) : null}
          {a.penugasan_peran.map((p) => (
            <li key={p.id} className="flex flex-wrap items-center gap-2">
              <span>{labelPenugasan(p)}</span>
              <FormAksi aksi={hapusPeran.bind(null, p.id)} tombol="Cabut" jenisTombol="bahaya" />
            </li>
          ))}
          {!kel && a.penugasan_peran.length === 0 ? (
            <li className="opacity-70">Belum ada tim/kelompok dan peran.</li>
          ) : null}
        </ul>
        <Lipatan judul="Beri peran">
          <FormBeriPeran akunTetap={a.id} kelompok={kelompok} tim={tim ?? []} />
        </Lipatan>
      </Kotak>

      <Kotak judul="Kata sandi">
        <FormAksi
          aksi={buatTautanAturUlang.bind(null, a.id, a.nama_tampilan)}
          tombol="Buat tautan atur ulang kata sandi"
          jenisTombol="biasa"
        />
      </Kotak>

      <Kotak judul="Ubah data akun">
        <Lipatan judul="Ubah cara masuk (nama pengguna, email, nomor HP)">
          <FormAksi aksi={ubahLoginAkun.bind(null, a.id)} tombol="Simpan cara masuk" jenisTombol="biasa" tanpaReset>
            <IsianLogin
              awal={{ nama_pengguna: a.nama_pengguna, email: a.email, nomor_hp: tampilHp(a.nomor_hp) }}
              keterangan={
                a.anggota_id
                  ? "Minimal satu. Nomor HP ikut tersimpan di profil anggotanya."
                  : "Minimal satu. Masuk cukup dengan salah satunya."
              }
            />
          </FormAksi>
        </Lipatan>
        <Lipatan judul="Ubah nama akun">
          <FormAksi aksi={ubahNamaAkun.bind(null, a.id)} tombol="Simpan nama" jenisTombol="biasa" tanpaReset>
            <Isian label="Nama tampilan" name="nama" defaultValue={a.nama_tampilan} required />
          </FormAksi>
        </Lipatan>
      </Kotak>

      {a.id !== peran.akun_id ? (
        <Kotak judul="Hapus akun">
          <FormAksi
            aksi={hapusAkun.bind(null, a.id)}
            tombol="Hapus akun ini"
            jenisTombol="bahaya"
            konfirmasi={`Hapus akun ${a.nama_tampilan}? Tindakan ini tidak bisa dibatalkan.`}
          >
            <p className="mb-3 text-sm opacity-70">Akun login dan semua perannya dihapus; orang ini tidak bisa masuk lagi.</p>
            {a.anggota_id ? (
              <label className="mb-3 flex items-start gap-3">
                <input type="checkbox" name="hapus_profil" value="ya" className="mt-1 h-5 w-5 flex-none" />
                <span className="text-sm">
                  Hapus juga profil anggotanya (riwayat hadir, proyek, dan catatan ikut terhapus). Bila tidak dicentang,
                  profilnya tetap ada sebagai anggota tanpa akun.
                </span>
              </label>
            ) : null}
            <Isian
              label={`Ketik nama akun persis untuk memastikan: ${a.nama_tampilan}`}
              name="konfirmasi"
              autoComplete="off"
              required
            />
          </FormAksi>
        </Kotak>
      ) : null}
    </main>
  );
}
