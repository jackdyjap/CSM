import { redirect } from "next/navigation";

/** Dipindah ke Laporan saat teduh (keputusan 61); alamat lama tetap berfungsi. */
export default async function AlihSaatTeduhTim({ params, searchParams }: PageProps<"/tim/[id]/saat-teduh">) {
  const { id } = await params;
  const bulan = (await searchParams).bulan;
  redirect(`/laporan-saat-teduh?cak=tim:${id}${typeof bulan === "string" ? `&bulan=${bulan}` : ""}`);
}
