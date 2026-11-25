import { FormAksi } from "@/components/form-aksi";
import { Pilihan } from "@/components/ui";
import { beriPeran } from "@/app/admin/aksi";

type Kelompok = { id: string; nama: string; tim: { nama: string } | null };

/** Formulir Beri peran (Admin). `akunTetap` = akun sudah pasti (halaman detail akun). */
export function FormBeriPeran({
  akun,
  akunTetap,
  kelompok,
  tim,
}: {
  akun?: { id: string; nama: string; login: string | null }[];
  akunTetap?: string;
  kelompok: Kelompok[];
  tim: { id: string; nama: string }[];
}) {
  return (
    <FormAksi aksi={beriPeran} tombol="Beri peran">
      {akunTetap ? (
        <input type="hidden" name="akun_id" value={akunTetap} />
      ) : (
        <Pilihan label="Akun" name="akun_id" required defaultValue="">
          <option value="" disabled>
            Pilih akun…
          </option>
          {(akun ?? []).map((a) => (
            <option key={a.id} value={a.id}>
              {a.nama} ({a.login ?? "-"})
            </option>
          ))}
        </Pilihan>
      )}
      <Pilihan label="Peran" name="peran" required defaultValue="">
        <option value="" disabled>
          Pilih peran…
        </option>
        <option value="pemimpin">Pemimpin / Wakil kelompok</option>
        <option value="ketua_tim">Ketua Tim</option>
        <option value="admin">Admin</option>
      </Pilihan>
      <Pilihan label="Kelompok (untuk Pemimpin/Wakil)" name="kelompok_id" defaultValue="">
        <option value="">—</option>
        {kelompok.map((k) => (
          <option key={k.id} value={k.id}>
            {k.nama} · {k.tim?.nama}
          </option>
        ))}
      </Pilihan>
      <Pilihan label="Jabatan (untuk Pemimpin/Wakil)" name="jabatan" defaultValue="pemimpin">
        <option value="pemimpin">Pemimpin</option>
        <option value="wakil">Wakil</option>
      </Pilihan>
      <Pilihan label="Tim (untuk Ketua Tim)" name="tim_id" defaultValue="">
        <option value="">—</option>
        {tim.map((t) => (
          <option key={t.id} value={t.id}>
            {t.nama}
          </option>
        ))}
      </Pilihan>
    </FormAksi>
  );
}
