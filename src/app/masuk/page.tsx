import { redirect } from "next/navigation";
import { Judul, Kotak, Pesan } from "@/components/ui";
import { ambilPeranSaya } from "@/lib/sesi";
import { tujuanAman } from "@/lib/tujuan";
import { FormMasuk } from "./form-masuk";

const PESAN: Record<string, string> = {
  "sandi-diubah": "Kata sandi berhasil diubah. Silakan masuk dengan kata sandi baru.",
};

export default async function HalamanMasuk({ searchParams }: PageProps<"/masuk">) {
  const { pesan, lanjut } = await searchParams;
  const tujuan = tujuanAman(lanjut);
  const { peran } = await ambilPeranSaya();
  if (peran) redirect(tujuan);

  const teksPesan = typeof pesan === "string" ? PESAN[pesan] : undefined;

  return (
    <main>
      <Judul kecil="Absensi kelompok kecil">Masuk</Judul>
      <Kotak>
        {teksPesan ? <Pesan jenis="sukses">{teksPesan}</Pesan> : null}
        {tujuan.startsWith("/hadir") ? (
          <Pesan jenis="info">Masuk dulu untuk mencatat kehadiran Anda.</Pesan>
        ) : null}
        <FormMasuk lanjut={tujuan === "/beranda" ? undefined : tujuan} />
      </Kotak>
      <p className="text-center text-sm opacity-70">
        Belum punya akun? Minta tautan undangan kepada pemimpin kelompok Anda.
      </p>
    </main>
  );
}
