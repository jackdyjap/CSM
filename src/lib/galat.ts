// Menerjemahkan pesan galat database menjadi kalimat yang mudah dipahami.
type GalatDb = { code?: string; message?: string } | null | undefined;

export function pesanGalat(galat: GalatDb, cadangan = "Terjadi kesalahan. Coba lagi."): string {
  if (!galat) return cadangan;
  switch (galat.code) {
    case "23505":
      // Pesan dari fungsi database kita (mis. check-in dua kali) sudah berbahasa Indonesia.
      return galat.message && !galat.message.startsWith("duplicate key") ? galat.message : "Data yang sama sudah ada.";
    case "23503":
      return "Data ini masih dipakai data lain, jadi tidak bisa dihapus/diubah.";
    case "42501":
      // Pesan dari fungsi database kita sudah berbahasa Indonesia.
      return galat.message && !galat.message.startsWith("new row violates")
        ? galat.message
        : "Anda tidak berhak melakukan tindakan ini.";
    case "22023":
    case "23514":
      return galat.message ?? cadangan;
    default:
      return cadangan;
  }
}

/**
 * Pesan untuk data yang GAGAL DIBACA (bukan "tidak ada"), beserta kode dan
 * pesan asli database, supaya penyebabnya langsung terlihat dan bisa
 * dilaporkan (mis. migrasi database yang belum dijalankan).
 */
export function pesanBacaGagal(galat: GalatDb, apa: string): string {
  const asli = [galat?.code, galat?.message].filter(Boolean).join(": ");
  return `${apa} belum bisa dibaca. Sampaikan pesan ini kepada Admin${asli ? ` (${asli})` : ""}.`;
}
