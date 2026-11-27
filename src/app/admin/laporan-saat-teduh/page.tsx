import { redirect } from "next/navigation";

/** Dipindah ke Laporan saat teduh (keputusan 61); alamat lama tetap berfungsi. */
export default async function AlihLaporanSaatTeduh({ searchParams }: PageProps<"/admin/laporan-saat-teduh">) {
  const bulan = (await searchParams).bulan;
  redirect(`/laporan-saat-teduh${typeof bulan === "string" ? `?bulan=${bulan}` : ""}`);
}
