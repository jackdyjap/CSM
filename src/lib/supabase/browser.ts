"use client";

import { createBrowserClient } from "@supabase/ssr";

/**
 * Sambungan ke Supabase dari PERAMBAN, atas nama pengguna yang sedang login
 * (sesi dibaca dari cookie). Semua aturan akses (RLS) tetap berlaku.
 * Dipakai hanya untuk mengunggah berkas besar (bukti transfer) langsung ke
 * penyimpanan, karena kiriman lewat server Vercel dibatasi sekitar 4,5 MB.
 */
export function buatClientPeramban() {
  return createBrowserClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY!,
  );
}
