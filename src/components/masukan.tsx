import { STATUS_MASUKAN, type StatusMasukan } from "@/lib/masukan";

/** Label status masukan: Baru / Sedang ditangani / Selesai. */
export function LabelStatus({ status }: { status: StatusMasukan }) {
  const gaya = {
    baru: "border-amber-700/50 text-amber-800 dark:text-amber-300",
    ditangani: "border-blue-700/50 text-blue-800 dark:text-blue-300",
    selesai: "border-green-700/50 text-green-800 dark:text-green-300",
  }[status];
  return (
    <span className={`rounded-md border px-2 py-0.5 text-xs font-semibold whitespace-nowrap ${gaya}`}>
      {STATUS_MASUKAN[status]}
    </span>
  );
}
