import { DaftarAkun } from "@/components/daftar-akun";
import { FormBeriPeran } from "@/components/form-beri-peran";
import { FormBuatAkun } from "@/components/form-buat-akun";
import { Judul, Kotak, Lipatan, Pesan, TautanTombol } from "@/components/ui";
import { ambilSemuaAkun, susunDaftarAkun } from "@/lib/akun-admin";
import { wajibAdmin } from "@/lib/sesi";

type BarisKelompok = { id: string; nama: string; tim: { nama: string } | null };

/** Admin → Akun & peran: daftar ringkas per tim/kelompok; tindakan ada di halaman detail akun. */
export default async function HalamanAkun({ searchParams }: PageProps<"/admin/akun">) {
  const { supabase } = await wajibAdmin();
  const dihapus = (await searchParams).dihapus === "1";

  const [akun, { data: tim }, { data: dataKelompok }] = await Promise.all([
    ambilSemuaAkun(supabase),
    supabase.from("tim").select("id, nama").order("nama"),
    supabase.from("kelompok").select("id, nama, tim(nama)").order("nama"),
  ]);
  const kelompok = (dataKelompok ?? []) as unknown as BarisKelompok[];

  return (
    <main>
      <Judul kecil="Admin">Akun &amp; peran</Judul>
      <div className="mb-4 flex gap-2">
        <TautanTombol href="/beranda">← Beranda</TautanTombol>
        <TautanTombol href="/admin">Tim &amp; kelompok</TautanTombol>
      </div>

      {dihapus ? <Pesan jenis="sukses">Akun dihapus.</Pesan> : null}

      <Kotak>
        <Lipatan judul="+ Buat akun baru">
          <p className="text-sm opacity-70">
            Akun langsung dijadikan anggota, Pemimpin, atau Wakil kelompok yang dipilih, Ketua Tim untuk tim yang
            dipilih, atau Admin. Peran lain bisa ditambah lewat <em>Beri peran</em>.
          </p>
          <FormBuatAkun
            tujuan={["anggota", "pemimpin", "wakil", "ketua_tim", "admin", "tanpa"]}
            kelompok={kelompok.map((k) => ({ id: k.id, nama: k.nama, tim_nama: k.tim?.nama }))}
            tim={tim ?? []}
          />
        </Lipatan>
        <Lipatan judul="Beri peran">
          <FormBeriPeran
            akun={akun.map((a) => ({ id: a.id, nama: a.nama_tampilan, login: a.login }))}
            kelompok={kelompok}
            tim={tim ?? []}
          />
        </Lipatan>
      </Kotak>

      <Kotak judul="Daftar akun">
        <DaftarAkun daftar={susunDaftarAkun(akun)} jumlah={akun.length} />
      </Kotak>
    </main>
  );
}
