// Membaca pengaturan dari file .env.local (lokal) atau dari pengaturan Vercel.
// Nilai NEXT_PUBLIC_* boleh terlihat di browser; SUPABASE_SECRET_KEY TIDAK.

function wajib(nama: string, nilai: string | undefined): string {
  if (!nilai) {
    throw new Error(
      `Pengaturan ${nama} belum diisi. Lihat panduan di README.md bagian "Menjalankan aplikasi".`,
    );
  }
  return nilai;
}

export const supabaseUrl = () =>
  wajib("NEXT_PUBLIC_SUPABASE_URL", process.env.NEXT_PUBLIC_SUPABASE_URL);

export const supabaseKunciPublik = () =>
  wajib(
    "NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY",
    process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY,
  );
