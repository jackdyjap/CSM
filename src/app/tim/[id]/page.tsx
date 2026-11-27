import { redirect } from "next/navigation";
import { RingkasanTim, type Baris } from "@/components/ringkasan-tim";
import { Judul, Pesan, TautanTombol } from "@/components/ui";
import { hariIniWib } from "@/lib/profil";
import { wajibMasuk } from "@/lib/sesi";

/** Dashboard Ketua Tim (Fase 6): ringkasan semua kelompok di satu tim. */
export default async function HalamanDashboardTim({ params }: PageProps<"/tim/[id]">) {
  const { id } = await params;
  const { supabase, peran } = await wajibMasuk();
  if (!peran.admin && !peran.ketua_tim.some((t) => t.tim_id === id)) redirect("/beranda");

  const [{ data: tim }, { data, error }] = await Promise.all([
    supabase.from("tim").select("nama").eq("id", id).maybeSingle(),
    supabase.rpc("ringkasan_tim", { p_tim: id }),
  ]);
  if (!tim) redirect("/beranda");

  return (
    <main>
      <Judul kecil={peran.admin ? "Admin · dashboard tim" : "Ketua Tim · dashboard"}>{tim.nama}</Judul>
      <div className="mb-4">
        <TautanTombol href={peran.admin ? "/admin" : "/beranda"}>← {peran.admin ? "Tim & kelompok" : "Beranda"}</TautanTombol>
      </div>
      <div className="mb-4">
        <TautanTombol href={`/tim/${id}/saat-teduh`}>Saat teduh per kelompok →</TautanTombol>
      </div>

      {error ? <Pesan jenis="galat">Ringkasan belum bisa dimuat. Coba muat ulang halaman.</Pesan> : null}

      <RingkasanTim baris={(data ?? []) as Baris[]} hariIni={hariIniWib()} />
    </main>
  );
}
