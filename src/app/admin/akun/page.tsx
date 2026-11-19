import { FormAksi } from "@/components/form-aksi";
import { Isian, Judul, Kotak, Lipatan, Pilihan, TautanTombol } from "@/components/ui";
import { FormBuatAkun } from "@/components/form-buat-akun";
import { IsianLogin } from "@/components/isian-login";
import { tampilHp } from "@/lib/identitas";
import { wajibAdmin } from "@/lib/sesi";
import { beriPeran, buatTautanAturUlang, hapusAkun, hapusPeran, ubahLoginAkun, ubahNamaAkun } from "../aksi";

const NAMA_PERAN = { admin: "Admin", ketua_tim: "Ketua Tim", pemimpin: "Pemimpin" } as const;

type BarisAkun = {
  id: string;
  nama_tampilan: string;
  login: string | null;
  nama_pengguna: string | null;
  email: string | null;
  nomor_hp: string | null;
  anggota_id: string | null;
  penugasan_peran: {
    id: string;
    peran: keyof typeof NAMA_PERAN;
    jabatan: "pemimpin" | "wakil" | null;
    tim: { nama: string } | null;
    kelompok: { nama: string } | null;
  }[];
};
type BarisKelompok = { id: string; nama: string; tim: { nama: string } | null };

export default async function HalamanAkun() {
  const { supabase, peran } = await wajibAdmin();
  const saya = peran.akun_id;

  const [{ data: dataAkun }, { data: tim }, { data: dataKelompok }] = await Promise.all([
    supabase
      .from("akun")
      .select(
        "id, nama_tampilan, login, nama_pengguna, email, nomor_hp, anggota_id, penugasan_peran(id, peran, jabatan, tim(nama), kelompok(nama))",
      )
      .order("nama_tampilan"),
    supabase.from("tim").select("id, nama").order("nama"),
    supabase.from("kelompok").select("id, nama, tim(nama)").order("nama"),
  ]);
  // Relasi satu-ke-satu (tim, kelompok) dikembalikan Supabase sebagai objek tunggal.
  const akun = (dataAkun ?? []) as unknown as BarisAkun[];
  const kelompok = (dataKelompok ?? []) as unknown as BarisKelompok[];

  return (
    <main>
      <Judul kecil="Admin">Akun &amp; peran</Judul>
      <div className="mb-4 flex gap-2">
        <TautanTombol href="/beranda">← Beranda</TautanTombol>
        <TautanTombol href="/admin">Tim &amp; kelompok</TautanTombol>
      </div>

      <Kotak judul="Buat akun baru">
        <p className="mb-3 text-sm opacity-70">
          Akun langsung dijadikan anggota, Pemimpin, atau Wakil kelompok yang dipilih, Ketua Tim untuk tim yang
          dipilih, atau Admin. Peran lain bisa ditambah lewat <em>Beri peran</em> di bawah.
        </p>
        <FormBuatAkun
          tujuan={["anggota", "pemimpin", "wakil", "ketua_tim", "admin", "tanpa"]}
          kelompok={kelompok.map((k) => ({ id: k.id, nama: k.nama, tim_nama: k.tim?.nama }))}
          tim={tim ?? []}
        />
      </Kotak>

      <Kotak judul="Beri peran">
        <FormAksi aksi={beriPeran} tombol="Beri peran">
          <Pilihan label="Akun" name="akun_id" required defaultValue="">
            <option value="" disabled>
              Pilih akun…
            </option>
            {akun.map((a) => (
              <option key={a.id} value={a.id}>
                {a.nama_tampilan} ({a.login ?? "-"})
              </option>
            ))}
          </Pilihan>
          <Pilihan label="Peran" name="peran" required defaultValue="">
            <option value="" disabled>
              Pilih peran…
            </option>
            <option value="pemimpin">Pemimpin / Wakil kelompok</option>
            <option value="ketua_tim">Ketua Tim</option>
            <option value="admin">Admin</option>
          </Pilihan>
          <Pilihan label="Kelompok (untuk Pemimpin/Wakil)" name="kelompok_id" defaultValue="">
            <option value="">—</option>
            {kelompok.map((k) => (
              <option key={k.id} value={k.id}>
                {k.nama} · {k.tim?.nama}
              </option>
            ))}
          </Pilihan>
          <Pilihan label="Jabatan (untuk Pemimpin/Wakil)" name="jabatan" defaultValue="pemimpin">
            <option value="pemimpin">Pemimpin</option>
            <option value="wakil">Wakil</option>
          </Pilihan>
          <Pilihan label="Tim (untuk Ketua Tim)" name="tim_id" defaultValue="">
            <option value="">—</option>
            {(tim ?? []).map((t) => (
              <option key={t.id} value={t.id}>
                {t.nama}
              </option>
            ))}
          </Pilihan>
        </FormAksi>
      </Kotak>

      <Kotak judul="Daftar akun">
        <ul className="divide-y divide-black/10 dark:divide-white/10">
          {akun.map((a) => (
            <li key={a.id} className="py-3">
              <p className="font-semibold">{a.nama_tampilan}</p>
              <p className="text-sm opacity-70">
                {a.login ?? "-"}
                {a.anggota_id ? " · terhubung ke profil anggota" : ""}
              </p>
              {a.penugasan_peran.length > 0 ? (
                <ul className="mt-2 space-y-2">
                  {a.penugasan_peran.map((p) => (
                    <li key={p.id} className="flex flex-wrap items-center gap-2 text-sm">
                      <span>
                        {p.peran === "pemimpin" && p.jabatan === "wakil" ? "Wakil" : NAMA_PERAN[p.peran]}
                        {p.tim ? ` · ${p.tim.nama}` : ""}
                        {p.kelompok ? ` · ${p.kelompok.nama}` : ""}
                      </span>
                      <FormAksi aksi={hapusPeran.bind(null, p.id)} tombol="Cabut" jenisTombol="bahaya" />
                    </li>
                  ))}
                </ul>
              ) : null}
              <div className="mt-2">
                <FormAksi
                  aksi={buatTautanAturUlang.bind(null, a.id, a.nama_tampilan)}
                  tombol="Buat tautan atur ulang kata sandi"
                  jenisTombol="biasa"
                />
              </div>
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
              {a.id !== saya ? (
                <Lipatan judul="Hapus akun">
                  <FormAksi
                    aksi={hapusAkun.bind(null, a.id)}
                    tombol="Hapus akun ini"
                    jenisTombol="bahaya"
                    konfirmasi={`Hapus akun ${a.nama_tampilan}? Tindakan ini tidak bisa dibatalkan.`}
                  >
                    <p className="mb-3 text-sm opacity-70">
                      Akun login dan semua perannya dihapus; orang ini tidak bisa masuk lagi.
                    </p>
                    {a.anggota_id ? (
                      <label className="mb-3 flex items-start gap-3">
                        <input type="checkbox" name="hapus_profil" value="ya" className="mt-1 h-5 w-5 flex-none" />
                        <span className="text-sm">
                          Hapus juga profil anggotanya (riwayat hadir, proyek, dan catatan ikut terhapus). Bila tidak
                          dicentang, profilnya tetap ada sebagai anggota tanpa akun.
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
                </Lipatan>
              ) : null}
            </li>
          ))}
        </ul>
      </Kotak>
    </main>
  );
}
