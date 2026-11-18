import { FormAksi } from "@/components/form-aksi";
import { Isian, Judul, Kotak, Lipatan, Pilihan, TautanTombol } from "@/components/ui";
import { wajibAdmin } from "@/lib/sesi";
import { hapusBerkasSekarang, hapusTim, tambahKelompok, tambahTim, ubahNamaTim } from "./aksi";

export default async function HalamanAdmin() {
  const { supabase } = await wajibAdmin();
  const { data: daftarTim } = await supabase
    .from("tim")
    .select("id, nama, kelompok(id, nama)")
    .order("nama");
  const tim = daftarTim ?? [];
  const { data: antrean } = await supabase.rpc("jumlah_antrean_berkas");

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
                <div className="flex flex-wrap items-center justify-between gap-2">
                  <p className="font-semibold">{t.nama}</p>
                  <TautanTombol href={`/tim/${t.id}`} className="min-h-9 py-1 text-sm">
                    Dashboard →
                  </TautanTombol>
                </div>
                {t.kelompok.length === 0 ? (
                  <p className="text-sm opacity-70">Belum ada kelompok.</p>
                ) : (
                  <ul className="mt-1 space-y-1">
                    {[...t.kelompok]
                      .sort((a, b) => a.nama.localeCompare(b.nama, "id"))
                      .map((k) => (
                        <li key={k.id}>
                          <TautanTombol href={`/kelompok/${k.id}`} className="w-full justify-between">
                            <span>{k.nama}</span>
                            <span className="text-sm opacity-70">Buka →</span>
                          </TautanTombol>
                        </li>
                      ))}
                  </ul>
                )}
                <Lipatan judul={`Ubah / hapus tim ${t.nama}`}>
                  <FormAksi aksi={ubahNamaTim.bind(null, t.id)} tombol="Simpan nama" jenisTombol="biasa" tanpaReset>
                    <Isian label="Nama tim" name="nama" defaultValue={t.nama} required />
                  </FormAksi>
                  <FormAksi
                    aksi={hapusTim.bind(null, t.id)}
                    tombol="Hapus tim"
                    jenisTombol="bahaya"
                    konfirmasi={`Hapus tim ${t.nama}? Tim hanya bisa dihapus bila tidak punya kelompok.`}
                  />
                </Lipatan>
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
      <Kotak judul="Pembersihan berkas">
        <p className="mb-3 text-sm opacity-70">
          Foto, bukti transfer, dan bahan diskusi yang datanya sudah dihapus menunggu dihapus dari penyimpanan:{" "}
          <strong>{typeof antrean === "number" ? antrean : "?"} berkas</strong>. Dihapus otomatis setiap malam pukul
          02.00 WIB; berkas yang masih dipakai tidak pernah ikut terhapus.
        </p>
        <FormAksi aksi={hapusBerkasSekarang} tombol="Hapus sekarang" jenisTombol="biasa" />
      </Kotak>
    </main>
  );
}
