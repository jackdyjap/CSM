import Link from "next/link";
import { redirect } from "next/navigation";
import { FormAksi } from "@/components/form-aksi";
import { Isian, IsianPanjang, Judul, Kotak, Lipatan, TautanTombol } from "@/components/ui";
import { tanggalPanjang } from "@/lib/pertemuan";
import { hariIniWib } from "@/lib/profil";
import { aksesKelompok, wajibMasuk } from "@/lib/sesi";
import { buatProyek } from "./aksi";

type BarisProyek = {
  id: string;
  judul: string;
  diberikan_pada: string;
  tenggat: string | null;
  status_proyek: { status: string }[];
};

export default async function HalamanProyek({ params }: PageProps<"/kelompok/[id]/proyek">) {
  const { id } = await params;
  const { supabase, peran } = await wajibMasuk();
  const kelompok = await aksesKelompok(supabase, peran, id);
  if (!kelompok) redirect("/beranda");

  const [{ data }, { count: jumlahAktif }] = await Promise.all([
    supabase
      .from("proyek_ketaatan")
      .select("id, judul, diberikan_pada, tenggat, status_proyek(status)")
      .eq("kelompok_id", id)
      .order("diberikan_pada", { ascending: false }),
    supabase.from("anggota").select("id", { count: "exact", head: true }).eq("kelompok_id", id).eq("aktif", true),
  ]);
  const proyek = (data ?? []) as unknown as BarisProyek[];
  const hariIni = hariIniWib();

  return (
    <main>
      <Judul kecil={kelompok.nama}>Proyek ketaatan</Judul>
      <div className="mb-4">
        <TautanTombol href={`/kelompok/${id}`}>← Kelompok</TautanTombol>
      </div>

      <Kotak judul="Proyek">
        {proyek.length === 0 ? (
          <p className="opacity-70">Belum ada proyek ketaatan.</p>
        ) : (
          <ul className="divide-y divide-black/10 dark:divide-white/10">
            {proyek.map((p) => {
              const selesai = p.status_proyek.filter((s) => s.status === "selesai").length;
              const lewat = p.tenggat !== null && p.tenggat < hariIni;
              return (
                <li key={p.id}>
                  <Link
                    href={`/kelompok/${id}/proyek/${p.id}`}
                    className="-mx-2 flex min-h-14 flex-wrap items-center gap-x-3 gap-y-1 rounded-lg px-2 py-2 hover:bg-black/5 dark:hover:bg-white/10"
                  >
                    <span className="font-semibold">{p.judul}</span>
                    {lewat ? (
                      <span className="rounded-md border border-amber-700/50 px-2 py-0.5 text-xs font-semibold text-amber-800 dark:text-amber-300">
                        Tenggat lewat
                      </span>
                    ) : null}
                    <span className="w-full text-sm opacity-70">
                      Selesai {selesai} dari {jumlahAktif ?? 0} ·{" "}
                      {p.tenggat ? `tenggat ${tanggalPanjang(p.tenggat)}` : "tanpa tenggat"}
                    </span>
                  </Link>
                </li>
              );
            })}
          </ul>
        )}
      </Kotak>

      {kelompok.bolehUbah ? (
      <Kotak>
        <Lipatan judul="+ Buat proyek baru">
          <p className="text-sm opacity-70">
            Setiap anggota kelompok langsung melihat proyek baru di Beranda (ditandai &ldquo;Baru&rdquo;) dan bisa
            melaporkan perkembangannya di sana.
            {peran.pemimpin.some((k) => k.kelompok_id === id) && !peran.anggota ? (
              <>
                {" "}Supaya Anda sendiri juga ikut melapor, daftarkan akun Anda sebagai anggota lewat{" "}
                <a href={`/kelompok/${id}/masukkan-akun`} className="underline">
                  Masukkan akun yang sudah ada
                </a>
                .
              </>
            ) : null}
          </p>
          <FormAksi aksi={buatProyek.bind(null, id)} tombol="Buat proyek">
            <Isian label="Judul" name="judul" required placeholder="Contoh: Baca Injil Yohanes" />
            <IsianPanjang label="Keterangan (opsional)" name="keterangan" placeholder="Contoh: satu pasal setiap hari" />
            <Isian label="Tanggal diberikan" name="diberikan_pada" type="date" defaultValue={hariIni} required />
            <Isian
              label="Tenggat (opsional)"
              name="tenggat"
              type="date"
              keterangan="Setelah tenggat lewat, yang belum selesai muncul di halaman Tindak lanjut."
            />
          </FormAksi>
        </Lipatan>
      </Kotak>
      ) : null}
    </main>
  );
}
