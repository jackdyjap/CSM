import "server-only";
import { createServerClient } from "@supabase/ssr";
import { cookies } from "next/headers";
import { supabaseKunciPublik, supabaseUrl } from "@/lib/env";

/**
 * Sambungan ke Supabase atas nama PENGGUNA YANG SEDANG LOGIN.
 * Semua aturan akses (RLS) di database berlaku penuh.
 */
export async function buatClientServer() {
  const cookieStore = await cookies();

  return createServerClient(supabaseUrl(), supabaseKunciPublik(), {
    cookies: {
      getAll() {
        return cookieStore.getAll();
      },
      setAll(cookiesToSet) {
        try {
          cookiesToSet.forEach(({ name, value, options }) =>
            cookieStore.set(name, value, options),
          );
        } catch {
          // Dipanggil dari Server Component (tidak boleh menulis cookie).
          // Aman diabaikan: proxy.ts yang menyegarkan sesi di setiap permintaan.
        }
      },
    },
  });
}
