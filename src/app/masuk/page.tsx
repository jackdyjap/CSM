import { redirect } from "next/navigation";
import { Judul, Kotak, Pesan } from "@/components/ui";
import { ambilPeranSaya } from "@/lib/sesi";
import { FormMasuk } from "./form-masuk";

const PESAN: Record<string, string> = {
  "sandi-diubah": "Kata sandi berhasil diubah. Silakan masuk dengan kata sandi baru.",
};

export default async function HalamanMasuk({ searchParams }: PageProps<"/masuk">) {
  const { peran } = await ambilPeranSaya();
  if (peran) redirect("/beranda");

  const { pesan } = await searchParams;
  const teksPesan = typeof pesan === "string" ? PESAN[pesan] : undefined;

  return (
    <main>
      <Judul kecil="Absensi kelompok kecil">Masuk</Judul>
      <Kotak>
        {teksPesan ? <Pesan jenis="sukses">{teksPesan}</Pesan> : null}
        <FormMasuk />
      </Kotak>
      <p className="text-center text-sm opacity-70">
        Belum punya akun? Minta tautan undangan kepada pemimpin kelompok Anda.
      </p>
    </main>
  );
}
