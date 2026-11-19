import { FormAksi } from "@/components/form-aksi";
import { IsianLogin } from "@/components/isian-login";
import { Isian, Pilihan } from "@/components/ui";
import { buatAkunBaru } from "@/lib/aksi-buat-akun";
import { PANJANG_SANDI_MINIMAL } from "@/lib/identitas";

export type TujuanAkun = "anggota" | "pemimpin" | "wakil" | "ketua_tim" | "admin" | "tanpa";

const LABEL: Record<TujuanAkun, string> = {
  anggota: "Anggota kelompok",
  pemimpin: "Pemimpin kelompok",
  wakil: "Wakil kelompok",
  ketua_tim: "Ketua Tim",
  admin: "Admin",
  tanpa: "Tanpa kelompok/peran dulu",
};

/**
 * Formulir membuat akun baru beserta tujuannya (keputusan 42).
 * - `kelompokTetap`: dipakai di halaman kelompok; kelompoknya sudah pasti.
 * - `kelompok` / `tim`: pilihan untuk Admin di halaman Akun & peran.
 * Hak sebenarnya tetap diperiksa database.
 */
export function FormBuatAkun({
  tujuan,
  kelompokTetap,
  kelompok,
  tim,
}: {
  tujuan: TujuanAkun[];
  kelompokTetap?: string;
  kelompok?: { id: string; nama: string; tim_nama?: string | null }[];
  tim?: { id: string; nama: string }[];
}) {
  const adaKelompok = tujuan.some((t) => t === "anggota" || t === "pemimpin" || t === "wakil");
  return (
    <FormAksi aksi={buatAkunBaru} tombol="Buat akun">
      <Isian label="Nama lengkap" name="nama" required autoComplete="off" />
      <IsianLogin />
      <Isian
        label="Kata sandi sementara"
        name="sandi"
        type="text"
        minLength={PANJANG_SANDI_MINIMAL}
        autoComplete="off"
        keterangan={`Minimal ${PANJANG_SANDI_MINIMAL} karakter. Sampaikan secara pribadi; wajib diganti saat login pertama.`}
        required
      />
      {tujuan.length === 1 ? (
        <input type="hidden" name="tujuan" value={tujuan[0]} />
      ) : (
        <Pilihan label="Dijadikan sebagai" name="tujuan" defaultValue={tujuan[0]} required>
          {tujuan.map((t) => (
            <option key={t} value={t}>
              {LABEL[t]}
            </option>
          ))}
        </Pilihan>
      )}
      {kelompokTetap ? (
        <input type="hidden" name="kelompok_id" value={kelompokTetap} />
      ) : adaKelompok && kelompok ? (
        <Pilihan label="Kelompok (untuk Anggota, Pemimpin, atau Wakil)" name="kelompok_id" defaultValue="">
          <option value="">—</option>
          {kelompok.map((k) => (
            <option key={k.id} value={k.id}>
              {k.nama}
              {k.tim_nama ? ` · ${k.tim_nama}` : ""}
            </option>
          ))}
        </Pilihan>
      ) : null}
      {tujuan.includes("ketua_tim") && tim ? (
        <Pilihan label="Tim (untuk Ketua Tim)" name="tim_id" defaultValue="">
          <option value="">—</option>
          {tim.map((t) => (
            <option key={t.id} value={t.id}>
              {t.nama}
            </option>
          ))}
        </Pilihan>
      ) : null}
    </FormAksi>
  );
}
