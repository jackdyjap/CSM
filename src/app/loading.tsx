/**
 * Tampil seketika saat pindah halaman, selama data halaman berikutnya
 * diambil dari server. Supaya pengguna tahu ketukannya sudah diterima.
 */
export default function Memuat() {
  return (
    <main aria-busy="true" aria-live="polite" className="flex min-h-[50dvh] flex-col items-center justify-center gap-3">
      <span
        aria-hidden
        className="h-8 w-8 animate-spin rounded-full border-4 border-current border-t-transparent opacity-60"
      />
      <p className="text-sm opacity-70">Memuat…</p>
    </main>
  );
}
