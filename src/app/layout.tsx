import type { Metadata, Viewport } from "next";
import { PelacakRiwayat } from "@/components/pelacak-riwayat";
import "./globals.css";

export const metadata: Metadata = {
  title: "Absensi CSM",
  description: "Absensi dan pendataan anggota kelompok kecil.",
};

export const viewport: Viewport = {
  width: "device-width",
  initialScale: 1,
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
