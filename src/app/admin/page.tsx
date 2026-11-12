import { FormAksi } from "@/components/form-aksi";
import { Isian, Judul, Kotak, Pilihan, TautanTombol } from "@/components/ui";
import { wajibAdmin } from "@/lib/sesi";
import { tambahKelompok, tambahTim } from "./aksi";

export default async function HalamanAdmin() {
  const { supabase } = await wajibAdmin();
  const { data: daftarTim } = await supabase
    .from("tim")
    .select("id, nama, kelompok(id, nama)")
    .order("nama");
  const tim = daftarTim ?? [];

  return (
    <main>
      <Judul kecil="Admin">Tim &amp; kelompok</Judul>
      <div className="mb-4 flex gap-2">
        <TautanTombol href="/beranda">← Beranda</TautanTombol>
        <TautanTombol href="/admin/akun">Akun &amp; peran →</TautanTombol>
      </div>

      <Kotak judul="Daftar tim">
        {tim.length === 0 ? (
          <p className="opacity-70">Belum ada tim.</p>
        ) : (
          <ul className="space-y-3">
            {tim.map((t) => (
              <li key={t.id}>
                <p className="font-semibold">{t.nama}</p>
                {t.kelompok.length === 0 ? (
                  <p className="text-sm opacity-70">Belum ada kelompok.</p>
                ) : (
                  <ul className="list-disc pl-5 text-sm">
                    {[...t.kelompok]
                      .sort((a, b) => a.nama.localeCompare(b.nama))
                      .map((k) => (
                        <li key={k.id}>{k.nama}</li>
                      ))}
                  </ul>
                )}
              </li>
            ))}
          </ul>
        )}
      </Kotak>

      <Kotak judul="Tambah tim">
        <FormAksi aksi={tambahTim} tombol="Tambah tim">
          <Isian label="Nama tim" name="nama" required />
        </FormAksi>
      </Kotak>

      <Kotak judul="Tambah kelompok">
        {tim.length === 0 ? (
          <p className="opacity-70">Buat tim terlebih dahulu.</p>
        ) : (
          <FormAksi aksi={tambahKelompok} tombol="Tambah kelompok">
            <Pilihan label="Tim" name="tim_id" required defaultValue="">
              <option value="" disabled>
                Pilih tim…
              </option>
              {tim.map((t) => (
                <option key={t.id} value={t.id}>
                  {t.nama}
                </option>
              ))}
            </Pilihan>
            <Isian label="Nama kelompok" name="nama" required />
          </FormAksi>
        )}
      </Kotak>
    </main>
  );
}
