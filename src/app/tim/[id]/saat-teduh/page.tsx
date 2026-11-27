import { redirect } from "next/navigation";
import { PilihBulan, RingkasanSaatTeduh } from "@/components/ringkasan-saat-teduh";
import { Judul, Pesan, TautanTombol } from "@/components/ui";
import { pesanBacaGagal } from "@/lib/galat";
import { bacaBulan, type BarisRingkasanTeduh } from "@/lib/saat-teduh";
import { wajibMasuk } from "@/lib/sesi";

/** Ringkasan saat teduh sebulan untuk satu tim: total tim, lalu per kelompok (Ketua Tim/Admin). */
export default async function HalamanSaatTeduhTim({ params, searchParams }: PageProps<"/tim/[id]/saat-teduh">) {
  const { id } = await params;
  const bulan = bacaBulan((await searchParams).bulan);
  const { supabase, peran } = await wajibMasuk();
  if (!peran.admin && !peran.ketua_tim.some((t) => t.tim_id === id)) redirect("/beranda");

  const [{ data: tim }, { data, error }] = await Promise.all([
    supabase.from("tim").select("nama").eq("id", id).maybeSingle(),
    supabase.rpc("ringkasan_saat_teduh", { p_bulan: `${bulan}-01` }),
  ]);
  if (!tim) redirect("/beranda");
  const baris = ((data ?? []) as BarisRingkasanTeduh[]).filter((b) => b.tim_id === id);

  return (
    <main>
      <Judul kecil={peran.admin ? "Admin · saat teduh" : "Ketua Tim · saat teduh"}>Saat teduh · {tim.nama}</Judul>
      <div className="mb-4">
        <TautanTombol href={`/tim/${id}`}>← Dashboard tim</TautanTombol>
      </div>
      <PilihBulan bulan={bulan} />
      <p className="mb-3 text-xs opacity-70">
        Dihitung dari anggota aktif yang punya akun; bersaat teduh = minimal 1 catatan di bulan itu. Ketuk kelompok
        untuk melihat per anggota.
      </p>
      {error ? (
        <Pesan jenis="galat">{pesanBacaGagal(error, "Ringkasan saat teduh")}</Pesan>
      ) : (
        <RingkasanSaatTeduh baris={baris} bulan={bulan} totalSemua={false} />
      )}
    </main>
  );
}
