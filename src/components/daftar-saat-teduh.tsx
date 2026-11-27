import { hapusSaatTeduh } from "@/app/saat-teduh/aksi";
import { tautanBaca, teksBacaan } from "@/lib/alkitab";
import { jamPendek, tanggalPendek, type CatatanSaatTeduh } from "@/lib/saat-teduh";
import { FormAksi } from "./form-aksi";
import { TautanTombol } from "./ui";

/**
 * Daftar catatan Saat Teduh yang ringkas (terbaru di atas). Ketuk satu baris
 * untuk melihat detailnya; ketuk lagi untuk menutup. Tombol Ubah/Hapus hanya
 * untuk pemiliknya (`bolehUbah`); pengurus hanya membaca.
 */
export function DaftarSaatTeduh({ catatan, bolehUbah = false }: { catatan: CatatanSaatTeduh[]; bolehUbah?: boolean }) {
  return (
    <ul className="divide-y divide-black/10 dark:divide-white/10">
      {catatan.map((c) => (
        <li key={c.id}>
          <details className="group/catatan">
            <summary className="-mx-2 flex min-h-11 cursor-pointer list-none items-center gap-2 rounded-lg px-2 py-1 hover:bg-black/5 dark:hover:bg-white/10 [&::-webkit-details-marker]:hidden">
              <span className="min-w-0 flex-1">
                <span className="block truncate font-medium">{teksBacaan(c)}</span>
                <span className="block text-xs opacity-70">
                  {tanggalPendek(c.tanggal)} · {jamPendek(c.jam_mulai)} · {c.durasi_menit} menit
                </span>
              </span>
              <span className="text-sm opacity-60" aria-hidden>
                <span className="group-open/catatan:hidden">▾</span>
                <span className="hidden group-open/catatan:inline">▴</span>
              </span>
            </summary>
            <div className="mb-3 ml-1 mt-1 space-y-2 border-l-2 border-black/10 pl-3 text-sm dark:border-white/15">
              <p>
                <span className="opacity-70">Bacaan:</span> {teksBacaan(c)} ({c.versi.toUpperCase()}) ·{" "}
                <a
                  href={tautanBaca(c.versi, c)}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="font-medium text-utama underline underline-offset-2"
                >
                  Baca ayat ↗
                </a>
              </p>
              <p>
                <span className="opacity-70">Waktu:</span> {tanggalPendek(c.tanggal)}, mulai {jamPendek(c.jam_mulai)},{" "}
                {c.durasi_menit} menit
              </p>
              <div>
                <p className="opacity-70">Tuntunan yang didapat:</p>
                <p className="whitespace-pre-line">{c.tuntunan || <span className="opacity-60">(tidak diisi)</span>}</p>
              </div>
              {bolehUbah ? (
                <div className="flex flex-wrap items-start gap-2">
                  <TautanTombol href={`/saat-teduh/${c.id}`}>Ubah</TautanTombol>
                  <FormAksi
                    aksi={hapusSaatTeduh.bind(null, c.id)}
                    tombol="Hapus"
                    jenisTombol="bahaya"
                    konfirmasi={`Hapus catatan saat teduh ${tanggalPendek(c.tanggal)} (${teksBacaan(c)})?`}
                  />
                </div>
              ) : null}
            </div>
          </details>
        </li>
      ))}
    </ul>
  );
}
