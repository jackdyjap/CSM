/**
 * Kartu anggota seukuran KTP (85,6 × 54 mm): foto, nama, nomor HP, kelompok, dan QR
 * (keputusan 22 dan 26). QR hanya berisi kode acak (lihat src/lib/kartu.ts).
 */
export function KartuAnggota({
  nama,
  kelompok,
  svg,
  foto,
  noHp,
}: {
  nama: string;
  kelompok: string;
  svg: string;
  /** Tautan sementara ke foto (penyimpanan privat), atau null bila belum ada foto. */
  foto: string | null;
  /** Nomor HP untuk ditampilkan (08xx), atau kosong. */
  noHp: string;
}) {
  return (
    <div
      className="kartu flex overflow-hidden rounded-[3mm] border border-dashed border-black/40 bg-white text-black"
      style={{ width: "85.6mm", height: "54mm" }}
    >
      <div className="flex min-w-0 flex-1 flex-col p-[3mm] pr-0">
        <p className="text-[2.4mm] font-semibold tracking-wider text-[#1d5fbf] uppercase">Kartu Anggota</p>
        <p className="truncate text-[2.4mm] opacity-70">{kelompok}</p>
        <div className="mt-[1.5mm] h-[22mm] w-[18mm] overflow-hidden rounded-[1.5mm] bg-black/10">
          {foto ? (
            // eslint-disable-next-line @next/next/no-img-element -- tautan sementara dari penyimpanan privat
            <img src={foto} alt="" className="h-full w-full object-cover" />
          ) : (
            <span className="flex h-full items-center justify-center text-center text-[2mm] opacity-60">
              Belum ada foto
            </span>
          )}
        </div>
        <p className="mt-[1.5mm] line-clamp-2 text-[3.4mm] leading-tight font-bold break-words">{nama}</p>
        {noHp ? <p className="text-[2.6mm]">{noHp}</p> : null}
      </div>
      <div
        className="flex shrink-0 items-center p-[2.5mm] [&>svg]:h-[40mm] [&>svg]:w-[40mm]"
        // SVG dibuat oleh pustaka qrcode dari kode acak; tidak berisi masukan pengguna.
        dangerouslySetInnerHTML={{ __html: svg }}
      />
    </div>
  );
}
