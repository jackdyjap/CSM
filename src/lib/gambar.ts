// Pengecil foto di peramban (HP), dipakai sebelum mengunggah supaya hemat kuota dan cepat.
// Memakai elemen <img> (bukan createImageBitmap) supaya jalan juga di HP lama;
// peramban modern otomatis memutar foto sesuai posisi kamera (EXIF).

/** Mengecilkan foto menjadi JPEG dengan sisi terpanjang `sisiMaks` piksel. */
export async function kecilkanFoto(berkas: Blob, sisiMaks: number, mutu = 0.85): Promise<Blob> {
  const alamat = URL.createObjectURL(berkas);
  const kanvas = document.createElement("canvas");
  try {
    const gambar = new Image();
    gambar.src = alamat;
    await gambar.decode();
    const lebar = gambar.naturalWidth;
    const tinggi = gambar.naturalHeight;
    if (!lebar || !tinggi) throw new Error("bukan gambar");
    const skala = Math.min(1, sisiMaks / Math.max(lebar, tinggi));
    kanvas.width = Math.round(lebar * skala);
    kanvas.height = Math.round(tinggi * skala);
    const kuas = kanvas.getContext("2d")!;
    kuas.fillStyle = "#fff"; // latar putih untuk PNG transparan
    kuas.fillRect(0, 0, kanvas.width, kanvas.height);
    kuas.drawImage(gambar, 0, 0, kanvas.width, kanvas.height);
  } finally {
    URL.revokeObjectURL(alamat);
  }
  return new Promise((selesai, gagal) =>
    kanvas.toBlob((b) => (b ? selesai(b) : gagal(new Error("gagal"))), "image/jpeg", mutu),
  );
}
