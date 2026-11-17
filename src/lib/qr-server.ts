import "server-only";
import QRCode from "qrcode";

/** Gambar QR sebagai SVG (dibuat di server, tajam saat dicetak). */
export function svgQr(teks: string) {
  return QRCode.toString(teks, { type: "svg", margin: 1, errorCorrectionLevel: "M" });
}
