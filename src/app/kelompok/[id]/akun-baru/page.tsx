import { redirect } from "next/navigation";
import { FormBuatAkun, type TujuanAkun } from "@/components/form-buat-akun";
import { Judul, Kotak, TautanTombol } from "@/components/ui";
import { aksesKelompok, wajibMasuk } from "@/lib/sesi";

/**
 * Membuat akun baru langsung untuk kelompok ini (keputusan 42).
 * Pemimpin/Wakil: anggota. Ketua Tim dari tim ini dan Admin: anggota, Pemimpin, atau Wakil.
 */
export default async function HalamanAkunBaru({ params }: PageProps<"/kelompok/[id]/akun-baru">) {
  const { id } = await params;
  const { supabase, peran } = await wajibMasuk();
  const kelompok = await aksesKelompok(supabase, peran, id);
  if (!kelompok) redirect("/beranda");

  const { data } = await supabase.from("kelompok").select("tim_id").eq("id", id).maybeSingle();
  const ketuaTimIni = !!data && peran.ketua_tim.some((t) => t.tim_id === data.tim_id);
  const tujuan: TujuanAkun[] = peran.admin || ketuaTimIni ? ["anggota", "pemimpin", "wakil"] : ["anggota"];

  return (
    <main>
      <Judul kecil={kelompok.nama}>Buat akun baru</Judul>
      <div className="mb-4">
        <TautanTombol href={`/kelompok/${id}`}>← Kembali</TautanTombol>
      </div>

      <Kotak>
        <p className="mb-3 text-sm opacity-70">
          Akun langsung tergabung di kelompok {kelompok.nama}
          {tujuan.length > 1 ? " sebagai anggota, Pemimpin, atau Wakil" : " sebagai anggota"}. Sampaikan cara masuk dan
          kata sandi sementaranya secara pribadi. Data pribadi anggota baru bisa diisi setelah persetujuan data dicatat.
        </p>
        <FormBuatAkun tujuan={tujuan} kelompokTetap={id} />
      </Kotak>
    </main>
  );
}
