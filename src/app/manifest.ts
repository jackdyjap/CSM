import type { MetadataRoute } from "next";

/**
 * Manifest PWA (keputusan 55): aplikasi bisa dipasang di layar utama HP
 * dengan nama dan ikon "Absensi CSM", lalu terbuka layar penuh.
 */
export default function manifest(): MetadataRoute.Manifest {
  return {
    id: "/",
    name: "Absensi CSM",
    short_name: "Absensi CSM",
    description: "Absensi dan pendataan anggota kelompok kecil.",
    lang: "id",
    start_url: "/beranda",
    scope: "/",
    display: "standalone",
    orientation: "portrait",
    background_color: "#f6f7f9",
    theme_color: "#1d5fbf",
    icons: [
      { src: "/ikon/ikon-192.png", sizes: "192x192", type: "image/png", purpose: "any" },
      { src: "/ikon/ikon-512.png", sizes: "512x512", type: "image/png", purpose: "any" },
      { src: "/ikon/ikon-maskable-512.png", sizes: "512x512", type: "image/png", purpose: "maskable" },
    ],
  };
}
