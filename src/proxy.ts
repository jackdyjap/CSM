import { createServerClient } from "@supabase/ssr";
import { NextResponse, type NextRequest } from "next/server";

// Halaman yang boleh dibuka tanpa login.
const HALAMAN_PUBLIK = ["/masuk", "/lupa-sandi", "/undangan/", "/atur-ulang/"];

/**
 * Berjalan sebelum setiap halaman dibuka:
 *   1. menyegarkan sesi login (supaya tidak tiba-tiba keluar),
 *   2. mengarahkan pengunjung yang belum login ke halaman /masuk.
 * Pemeriksaan hak akses yang sebenarnya tetap dilakukan database (RLS).
 */
export async function proxy(request: NextRequest) {
  let response = NextResponse.next({ request });

  const supabase = createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY!,
    {
      cookies: {
        getAll() {
          return request.cookies.getAll();
        },
        setAll(cookiesToSet, headers) {
          cookiesToSet.forEach(({ name, value }) => request.cookies.set(name, value));
          response = NextResponse.next({ request });
          cookiesToSet.forEach(({ name, value, options }) =>
            response.cookies.set(name, value, options),
          );
          Object.entries(headers ?? {}).forEach(([kunci, nilai]) =>
            response.headers.set(kunci, nilai),
          );
        },
      },
    },
  );

  const { data } = await supabase.auth.getClaims();
  const sudahMasuk = Boolean(data?.claims);
  const jalur = request.nextUrl.pathname;
  const publik = HALAMAN_PUBLIK.some((h) => jalur === h || jalur.startsWith(h));

  if (!sudahMasuk && !publik) {
    const url = request.nextUrl.clone();
    url.pathname = "/masuk";
    url.search = "";
    return NextResponse.redirect(url);
  }

  return response;
}

export const config = {
  matcher: [
    "/((?!_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp|ico)$).*)",
  ],
};
