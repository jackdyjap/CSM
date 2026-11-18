import { FormAksi } from "@/components/form-aksi";
import { PilihanEnum } from "@/components/profil";
import { Kotak, Pilihan } from "@/components/ui";
import { ubahDataJemaat } from "@/lib/aksi-profil";
import { PILIHAN_GENDER, PILIHAN_STATUS_JEMAAT, type Profil } from "@/lib/profil";

/**
 * Gender, aktif/tidak aktif, dan status jemaat (keputusan 30).
 * Untuk pemimpin/wakil, Ketua Tim dari tim itu, dan Admin.
 */
export function KotakDataJemaat({ profil }: { profil: Profil }) {
  return (
    <Kotak judul="Data jemaat">
      <FormAksi
        aksi={ubahDataJemaat.bind(null, profil.id, profil.kelompok_id)}
        tombol="Simpan data jemaat"
        jenisTombol="biasa"
        tanpaReset
      >
        <PilihanEnum
          label="Status jemaat"
          name="status_jemaat"
          daftar={PILIHAN_STATUS_JEMAAT}
          nilai={profil.status_jemaat}
        />
        {profil.persetujuan_pada ? (
          <PilihanEnum label="Gender" name="gender" daftar={PILIHAN_GENDER} nilai={profil.gender} />
        ) : (
          <p className="mb-3 text-sm opacity-70">
            Gender bisa diisi setelah persetujuan data dicatat oleh pemimpin kelompok.
          </p>
        )}
        <Pilihan label="Status keaktifan" name="aktif" defaultValue={profil.aktif ? "ya" : "tidak"}>
          <option value="ya">Aktif</option>
          <option value="tidak">Tidak aktif</option>
        </Pilihan>
        <p className="mb-3 text-xs opacity-70">
          Anggota tidak aktif tidak ikut ditandai tidak hadir; bila ditandai hadir, otomatis aktif kembali.
        </p>
      </FormAksi>
    </Kotak>
  );
}
