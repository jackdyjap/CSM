/**
 * Kartu anggota seukuran KTP (85,6 × 54 mm): nama, kelompok, dan QR.
 * QR hanya berisi kode acak (lihat src/lib/kartu.ts).
 */
export function KartuAnggota({ nama, kelompok, svg }: { nama: string; kelompok: string; svg: string }) {
  return (
    <div
      className="kartu flex overflow-hidden rounded-[3mm] border border-dashed border-black/40 bg-white text-black"
      style={{ width: "85.6mm", height: "54mm" }}
    >
      <div className="flex flex-1 flex-col justify-between p-[4mm]">
        <div>
          <p className="text-[2.6mm] font-semibold tracking-wider text-[#1d5fbf] uppercase">Kartu Anggota</p>
          <p className="text-[2.6mm] opacity-70">{kelompok}</p>
        </div>
        <p className="text-[4.2mm] leading-tight font-bold break-words">{nama}</p>
        <p className="text-[2.2mm] opacity-60">Tunjukkan kartu ini saat absensi.</p>
      </div>
      <div
        className="flex items-center p-[3mm] [&>svg]:h-[44mm] [&>svg]:w-[44mm]"
        // SVG dibuat oleh pustaka qrcode dari kode acak; tidak berisi masukan pengguna.
        dangerouslySetInnerHTML={{ __html: svg }}
      />
    </div>
  );
}
