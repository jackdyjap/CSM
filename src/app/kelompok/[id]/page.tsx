import { redirect } from "next/navigation";
import { FormAksi } from "@/components/form-aksi";
import { Judul, Kotak, TautanTombol } from "@/components/ui";
import { waktuWib } from "@/lib/format";
import { wajibMasuk } from "@/lib/sesi";
import { batalkanUndangan, buatTautanAturUlang, buatUndangan } from "./aksi";

type BarisUndangan = {
  id: string;
  anggota_id: string | null;
  kedaluwarsa_pada: string;
  anggota: { nama_lengkap: string } | null;
};
type StatusAkun = { anggota_id: string; punya_akun: boolean; akun_id: string | null; login: string | null };

export default async function HalamanKelompok({ params }: PageProps<"/kelompok/[id]">) {
  const { id } = await params;
  const { supabase, peran } = await wajibMasuk();

  const kelompok = peran.pemimpin.find((k) => k.kelompok_id === id);
  if (!kelompok) redirect("/beranda");

  const [{ data: anggota }, { data: status }, { data: dataUndangan }] = await Promise.all([
    supabase
      .from("anggota")
      .select("id, nama_lengkap, aktif")
      .eq("kelompok_id", id)
      .order("nama_lengkap"),
    supabase.rpc("status_akun_anggota", { p_kelompok: id }),
    supabase
      .from("undangan")
      .select("id, anggota_id, kedaluwarsa_pada, anggota(nama_lengkap)")
      .eq("kelompok_id", id)
      .is("dipakai_pada", null)
      .gt("kedaluwarsa_pada", new Date().toISOString())
      .order("dibuat_pada", { ascending: false }),
  ]);

  const undangan = (dataUndangan ?? []) as unknown as BarisUndangan[];
  const statusPer = new Map(((status ?? []) as StatusAkun[]).map((s) => [s.anggota_id, s]));

  return (
    <main>
      <Judul kecil={`${kelompok.jabatan === "wakil" ? "Wakil" : "Pemimpin"} · ${kelompok.tim_nama}`}>
        {kelompok.nama}
      </Judul>
      <div className="mb-4">
        <TautanTombol href="/beranda">← Beranda</TautanTombol>
      </div>

      <Kotak judul="Undang anggota baru">
        <p className="mb-3 text-sm opacity-70">
          Buat tautan, lalu kirim lewat WhatsApp. Orang yang membuka tautan bisa membuat akun dan
          otomatis masuk ke kelompok ini. Tautan berlaku 7 hari dan hanya bisa dipakai satu kali.
        </p>
        <FormAksi aksi={buatUndangan.bind(null, id, null, null)} tombol="Buat tautan undangan" />
      </Kotak>

      <Kotak judul={`Anggota (${anggota?.length ?? 0})`}>
        {!anggota || anggota.length === 0 ? (
          <p className="opacity-70">Belum ada anggota.</p>
        ) : (
          <ul className="divide-y divide-black/10 dark:divide-white/10">
            {anggota.map((a) => {
              const s = statusPer.get(a.id);
              return (
                <li key={a.id} className="py-3">
                  <p className="font-semibold">
                    {a.nama_lengkap}
                    {!a.aktif ? <span className="ml-2 text-xs font-normal opacity-70">(tidak aktif)</span> : null}
                  </p>
                  {s?.punya_akun && s.akun_id ? (
                    <>
                      <p className="mb-2 text-sm opacity-70">Punya akun: {s.login ?? "-"}</p>
                      <FormAksi
                        aksi={buatTautanAturUlang.bind(null, s.akun_id, a.nama_lengkap)}
                        tombol="Tautan atur ulang kata sandi"
                        jenisTombol="biasa"
                      />
                    </>
                  ) : (
                    <>
                      <p className="mb-2 text-sm opacity-70">Belum punya akun (tidak wajib).</p>
                      <FormAksi
                        aksi={buatUndangan.bind(null, id, a.id, a.nama_lengkap)}
                        tombol="Buat tautan undangan untuk orang ini"
                        jenisTombol="biasa"
                      />
                    </>
                  )}
                </li>
              );
            })}
          </ul>
        )}
      </Kotak>

      {undangan.length > 0 ? (
        <Kotak judul="Undangan yang belum dipakai">
          <ul className="divide-y divide-black/10 dark:divide-white/10">
            {undangan.map((u) => (
              <li key={u.id} className="flex flex-wrap items-center justify-between gap-2 py-2 text-sm">
                <span>
                  {u.anggota ? `Untuk ${u.anggota.nama_lengkap}` : "Anggota baru"} · berlaku sampai{" "}
                  {waktuWib(u.kedaluwarsa_pada)}
                </span>
                <FormAksi aksi={batalkanUndangan.bind(null, id, u.id)} tombol="Batalkan" jenisTombol="bahaya" />
              </li>
            ))}
          </ul>
        </Kotak>
      ) : null}
    </main>
  );
}
