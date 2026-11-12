const formatWaktu = new Intl.DateTimeFormat("id-ID", {
  dateStyle: "medium",
  timeStyle: "short",
  timeZone: "Asia/Jakarta",
});

/** Contoh: "19 Nov 2026, 14.30 WIB" */
export function waktuWib(nilai: string | Date) {
  return `${formatWaktu.format(new Date(nilai))} WIB`;
}
