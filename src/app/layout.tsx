import type { Metadata, Viewport } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "CSM — Absensi Kelompok",
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
        <div className="mx-auto w-full max-w-xl px-4 py-6">{children}</div>
      </body>
    </html>
  );
}
