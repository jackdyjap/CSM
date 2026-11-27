import "server-only";
import { pesanBacaGagal } from "@/lib/galat";
import { KOLOM_SAAT_TEDUH, type CatatanSaatTeduh } from "@/lib/saat-teduh";
import type { buatClientServer } from "@/lib/supabase/server";
import { DaftarSaatTeduh } from "./daftar-saat-teduh";
import { Kotak, Pesan } from "./ui";

type Supabase = Awaited<ReturnType<typeof buatClientServer>>;

const BATAS = 60;

/**
 * Catatan Saat Teduh seseorang untuk pengurus (Pemimpin/Wakil, Ketua Tim,
 * Admin): HANYA DIBACA. Isi `anggotaId` (profil anggota) atau `akunId`
 * (halaman akun Admin). Aturan akses database menentukan yang terlihat.
 */
export async function KotakSaatTeduhBaca({
  supabase,
  anggotaId,
  akunId,
}: {
  supabase: Supabase;
  anggotaId?: string;
  akunId?: string;
}) {
  const { data, error } = anggotaId
    ? await supabase.rpc("saat_teduh_anggota", { p_anggota: anggotaId, p_batas: BATAS })
    : await supabase
        .from("saat_teduh")
        .select(KOLOM_SAAT_TEDUH)
        .eq("akun_id", akunId ?? "")
        .order("tanggal", { ascending: false })
        .order("jam_mulai", { ascending: false })
        .limit(BATAS);
  const catatan = (data ?? []) as CatatanSaatTeduh[];

  return (
    <Kotak judul="Saat Teduh">
      {error ? (
        <Pesan jenis="galat">{pesanBacaGagal(error, "Catatan saat teduh")}</Pesan>
      ) : catatan.length === 0 ? (
        <p className="text-sm opacity-70">
          Belum ada catatan saat teduh{anggotaId ? " (atau anggota ini belum punya akun)" : ""}.
        </p>
      ) : (
        <>
          <p className="mb-2 text-xs opacity-70">
            {catatan.length === BATAS ? `${BATAS} catatan terbaru` : `${catatan.length} catatan`}, hanya untuk dibaca.
            Ketuk sebuah catatan untuk melihat detailnya.
          </p>
          <DaftarSaatTeduh catatan={catatan} />
        </>
      )}
    </Kotak>
  );
}
