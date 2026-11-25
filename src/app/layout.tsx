import type { Metadata, Viewport } from "next";
import { PelacakRiwayat } from "@/components/pelacak-riwayat";
import "./globals.css";

export const metadata: Metadata = {
  title: "Absensi CSM",
  description: "Absensi dan pendataan anggota kelompok kecil.",
  applicationName: "Absensi CSM",
  // Dipasang di layar utama iPhone (Safari → Bagikan → Tambahkan ke Layar Utama): layar penuh, nama tetap.
  appleWebApp: { capable: true, title: "Absensi CSM", statusBarStyle: "default" },
  formatDetection: { telephone: false },
};

export const viewport: Viewport = {
  width: "device-width",
  initialScale: 1,
  themeColor: [
    { media: "(prefers-color-scheme: light)", color: "#1d5fbf" },
    { media: "(prefers-color-scheme: dark)", color: "#111418" },
  ],
};

export default function RootLayout({ children }: LayoutProps<"/">) {
  return (
    <html lang="id">
      <body className="min-h-dvh">
        <PelacakRiwayat />
        <div className="mx-auto w-full max-w-xl px-4 py-6">{children}</div>
      </body>
    </html>
  );
}
