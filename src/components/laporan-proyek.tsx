/** Alasan/hasil yang dilaporkan anggota untuk satu proyek (keputusan 36). */
export function LaporanProyek({
  alasan,
  hasil,
  sendiri,
}: {
  alasan: string | null;
  hasil: string | null;
  sendiri: boolean;
}) {
  if (!alasan && !hasil) return sendiri ? <p className="mt-1 text-xs opacity-70">Dilaporkan sendiri.</p> : null;
  return (
    <div className="mt-2 rounded-lg bg-black/5 p-2 text-sm dark:bg-white/10">
      <p className="text-xs font-semibold opacity-70">
        {hasil ? "Hasil yang didapat" : "Alasan belum dijalankan"}
        {sendiri ? " · dilaporkan sendiri" : ""}
      </p>
      <p className="whitespace-pre-line">{hasil ?? alasan}</p>
    </div>
  );
}
