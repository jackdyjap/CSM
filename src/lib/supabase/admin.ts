import "server-only";
import { createClient } from "@supabase/supabase-js";
import { supabaseUrl } from "@/lib/env";

/**
 * Sambungan ke Supabase dengan KUNCI RAHASIA (service_role).
 * Melewati aturan akses, jadi HANYA dipakai di server untuk:
 *   - membuat akun login baru (undangan, Admin),
 *   - memakai tautan undangan / tautan atur ulang kata sandi.
 * Jangan pernah dipakai untuk membaca data atas nama pengguna.
 */
export function buatClientAdmin() {
  const kunci = process.env.SUPABASE_SECRET_KEY;
  if (!kunci) {
    throw new Error(
      'Pengaturan SUPABASE_SECRET_KEY belum diisi. Lihat panduan di README.md bagian "Menjalankan aplikasi".',
    );
  }
  return createClient(supabaseUrl(), kunci, {
    auth: { persistSession: false, autoRefreshToken: false },
  });
}
