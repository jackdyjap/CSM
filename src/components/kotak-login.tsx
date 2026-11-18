import { FormAksi } from "@/components/form-aksi";
import { IsianLogin } from "@/components/isian-login";
import { Kotak } from "@/components/ui";
import { ubahLoginSaya } from "@/lib/aksi-login";
import { bacaDataLoginAkun } from "@/lib/login-server";
import type { buatClientServer } from "@/lib/supabase/server";

type Supabase = Awaited<ReturnType<typeof buatClientServer>>;

/** Pengguna mengatur nama pengguna, email, dan nomor HP untuk masuk (keputusan 25). */
export async function KotakLogin({
  supabase,
  akunId,
  punyaProfil,
}: {
  supabase: Supabase;
  akunId: string;
  punyaProfil: boolean;
}) {
  const data = await bacaDataLoginAkun(supabase, akunId);
  return (
    <Kotak judul="Cara masuk">
      <FormAksi aksi={ubahLoginSaya} tombol="Simpan cara masuk" jenisTombol="biasa" tanpaReset>
        <IsianLogin
          awal={data ?? undefined}
          keterangan={
            punyaProfil
              ? "Masuk cukup dengan salah satunya. Isi minimal satu. Nomor HP di sini sama dengan nomor HP di profil Anda."
              : "Masuk cukup dengan salah satunya. Isi minimal satu."
          }
        />
      </FormAksi>
    </Kotak>
  );
}
