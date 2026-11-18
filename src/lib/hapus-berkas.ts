import "server-only";
import { buatClientAdmin } from "@/lib/supabase/admin";

type Baris = { id: number; bucket: string; lokasi: string };

/**
 * Menghapus berkas di antrean hapus dari penyimpanan Supabase (keputusan 40).
 * Database hanya memberikan berkas yang sudah tidak dipakai data mana pun.
 * Berkas yang gagal dihapus tetap di antrean dan dicoba lagi lain kali.
 */
export async function jalankanPenghapusBerkas(
  admin: Pick<ReturnType<typeof buatClientAdmin>, "rpc" | "storage"> = buatClientAdmin(),
): Promise<{ dihapus: number; gagal: number }> {
  let dihapus = 0;
  let gagal = 0;

  // Paling banyak 5 putaran × 500 berkas per jalan, supaya selesai dalam batas waktu Vercel.
  for (let putaran = 0; putaran < 5; putaran++) {
    const { data, error } = await admin.rpc("layanan_ambil_antrean_berkas", { p_batas: 500 });
    if (error) throw new Error(`Antrean tidak bisa dibaca: ${error.message}`);
    const baris = (data ?? []) as Baris[];
    if (baris.length === 0) break;

    const perFolder = new Map<string, Baris[]>();
    for (const b of baris) perFolder.set(b.bucket, [...(perFolder.get(b.bucket) ?? []), b]);

    const selesai: number[] = [];
    for (const [bucket, isi] of perFolder) {
      const { error: galat } = await admin.storage.from(bucket).remove(isi.map((b) => b.lokasi));
      if (galat) gagal += isi.length;
      else selesai.push(...isi.map((b) => b.id));
    }
    if (selesai.length === 0) break; // semuanya gagal: berhenti, coba lagi lain kali

    const { error: galatSelesai } = await admin.rpc("layanan_selesai_antrean_berkas", { p_id: selesai });
    if (galatSelesai) throw new Error(`Antrean tidak bisa diperbarui: ${galatSelesai.message}`);
    dihapus += selesai.length;
    if (baris.length < 500) break;
  }
  return { dihapus, gagal };
}
