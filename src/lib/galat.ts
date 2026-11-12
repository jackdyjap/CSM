// Menerjemahkan pesan galat database menjadi kalimat yang mudah dipahami.
type GalatDb = { code?: string; message?: string } | null | undefined;

export function pesanGalat(galat: GalatDb, cadangan = "Terjadi kesalahan. Coba lagi."): string {
  if (!galat) return cadangan;
  switch (galat.code) {
    case "23505":
      return "Data yang sama sudah ada.";
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
