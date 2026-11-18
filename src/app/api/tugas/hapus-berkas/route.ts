import { jalankanPenghapusBerkas } from "@/lib/hapus-berkas";

/**
 * Dijalankan Vercel Cron setiap malam (vercel.json). Hanya menerima permintaan
 * yang membawa kunci rahasia CRON_SECRET (dikirim otomatis oleh Vercel).
 */
export async function GET(request: Request) {
  const kunci = process.env.CRON_SECRET;
  if (!kunci || request.headers.get("authorization") !== `Bearer ${kunci}`) {
    return new Response("Tidak diizinkan.", { status: 401 });
  }
  try {
    const hasil = await jalankanPenghapusBerkas();
    return Response.json(hasil);
  } catch (e) {
    return new Response(e instanceof Error ? e.message : "Gagal.", { status: 500 });
  }
}
