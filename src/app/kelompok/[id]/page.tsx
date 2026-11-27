import { redirect } from "next/navigation";
import { FormAksi } from "@/components/form-aksi";
import { LabelKelengkapan } from "@/components/profil";
import { SaringCari } from "@/components/saring-cari";
import { Isian, Judul, Kotak, Lipatan, Pilihan, TautanTombol } from "@/components/ui";
import { hapusKelompokTotal, ubahKelompok } from "@/app/admin/aksi";
import { waktuWib } from "@/lib/format";
import { BATAS_ABSEN } from "@/lib/pilihan-fase5";
import { isianKosong, KOLOM_KELENGKAPAN, type Profil } from "@/lib/profil";
import { aksesKelompok, wajibMasuk } from "@/lib/sesi";
import { batalkanUndangan, buatTautanAturUlang, buatUndangan } from "./aksi";

type BarisUndangan = {
  id: string;
  anggota_id: string | null;
  kedaluwarsa_pada: string;
  anggota: { nama_lengkap: string } | null;
};
type StatusAkun = { anggota_id: string; punya_akun: boolean; akun_id: string | null; login: string | null };

type BarisAnggota = Pick<
  Profil,
  | "id" | "nama_lengkap" | "aktif" | "persetujuan_pada" | "gender" | "foto_path" | "tahun_lahir"
  | "kota_kode" | "status_nikah" | "pendidikan" | "pekerjaan" | "baptis"
>;

export default async function HalamanKelompok({ params, searchParams }: PageProps<"/kelompok/[id]">) {
  const { id } = await params;
  const hanyaBelumLengkap = (await searchParams).belum === "1";
  const { supabase, peran } = await wajibMasuk();

  const kelompok = await aksesKelompok(supabase, peran, id);
  if (!kelompok) redirect("/beranda");

  const [{ data: anggota }, { data: status }, { data: dataUndangan }, { data: dataReset }] = await Promise.all([
    supabase
      .from("anggota")
      .select(`id, aktif, persetujuan_pada, ${KOLOM_KELENGKAPAN}`)
      .eq("kelompok_id", id)
      .order("nama_lengkap"),
    kelompok.bolehUbah ? supabase.rpc("status_akun_anggota", { p_kelompok: id }) : Promise.resolve({ data: [] }),
    supabase
      .from("undangan")
      .select("id, anggota_id, kedaluwarsa_pada, anggota(nama_lengkap)")
      .eq("kelompok_id", id)
      .is("dipakai_pada", null)
      .gt("kedaluwarsa_pada", new Date().toISOString())
      .order("dibuat_pada", { ascending: false }),
    // Ketua Tim: akun di kelompok ini yang boleh diatur ulang kata sandinya (keputusan 34).
    supabase.rpc("akun_bisa_atur_ulang", { p_kelompok: id }),
  ]);
  const daftarReset = (dataReset ?? []) as { akun_id: string; nama: string; keterangan: string; login: string | null }[];
  const bolehReset = new Set(daftarReset.map((r) => r.akun_id));
  // Kotak terpisah hanya untuk Ketua Tim (pemimpin/Admin memakai tombol di daftar anggota / Akun & peran).
  const bisaReset = kelompok.bolehUbah ? [] : daftarReset;

  const undangan = (dataUndangan ?? []) as unknown as BarisUndangan[];
  const { data: dataTindakLanjut } = await supabase.rpc("tindak_lanjut", { p_kelompok: id, p_batas_absen: BATAS_ABSEN });
  const jumlahTindakLanjut = new Set(((dataTindakLanjut ?? []) as { anggota_id: string }[]).map((b) => b.anggota_id)).size;
  const adminDiSini = peran.admin;
  const [{ data: dataTim }, { data: dataKelompok }] = adminDiSini
    ? await Promise.all([
        supabase.from("tim").select("id, nama").order("nama"),
        supabase.from("kelompok").select("tim_id").eq("id", id).maybeSingle(),
      ])
    : [{ data: null }, { data: null }];
  const semua = ((anggota ?? []) as unknown as BarisAnggota[]).map((a) => ({ ...a, kosong: isianKosong(a) }));
  const jumlahBelumLengkap = semua.filter((a) => a.kosong.length > 0).length;
  const tampil = hanyaBelumLengkap ? semua.filter((a) => a.kosong.length > 0) : semua;
  const statusPer = new Map(((status ?? []) as StatusAkun[]).map((s) => [s.anggota_id, s]));

  return (
    <main>
      <Judul kecil={`${kelompok.sebagai} · ${kelompok.tim_nama}`}>
        {kelompok.nama}
      </Judul>
      <div className="mb-4">
        {kelompok.sebagai === "Admin" ? (
          <TautanTombol href="/admin">← Tim &amp; kelompok</TautanTombol>
        ) : (
          <TautanTombol href="/beranda">← Beranda</TautanTombol>
        )}
      </div>

      <div className="mb-4 grid grid-cols-2 gap-2">
        <TautanTombol href={`/kelompok/${id}/pertemuan`} jenis="utama" className="col-span-2 justify-center">
          Pertemuan &amp; absensi
        </TautanTombol>
        <TautanTombol href={`/kelompok/${id}/proyek`} className="justify-center">
          Proyek ketaatan
        </TautanTombol>
        <TautanTombol href={`/kelompok/${id}/tindak-lanjut`} className="justify-center">
          Tindak lanjut{jumlahTindakLanjut > 0 ? ` (${jumlahTindakLanjut})` : ""}
        </TautanTombol>
      </div>

      {kelompok.bolehUbah ? (
        <Kotak judul="Undang anggota baru">
          <p className="mb-3 text-sm opacity-70">
            Buat tautan, lalu kirim lewat WhatsApp. Orang yang membuka tautan bisa membuat akun dan
            otomatis masuk ke kelompok ini. Tautan berlaku 7 hari dan hanya bisa dipakai satu kali.
          </p>
          <FormAksi aksi={buatUndangan.bind(null, id, null, null)} tombol="Buat tautan undangan" />
        </Kotak>
      ) : (
        <p className="mb-4 rounded-lg border border-black/10 px-3 py-2 text-sm opacity-80 dark:border-white/10">
          Tampilan baca saja (Ketua Tim). Perubahan dilakukan oleh pemimpin kelompok atau Admin, kecuali Data
          jemaat di profil anggota, atur ulang kata sandi, dan memasukkan akun yang sudah ada.
        </p>
      )}

      {bisaReset.length > 0 ? (
        <Kotak judul="Atur ulang kata sandi">
          <p className="mb-3 text-sm opacity-70">
            Untuk anggota atau pengurus kelompok ini yang lupa kata sandi. Buat tautan, lalu kirim lewat WhatsApp;
            tautan berlaku 24 jam dan hanya bisa dipakai sekali.
          </p>
          <ul className="divide-y divide-black/10 dark:divide-white/10">
            {bisaReset.map((r) => (
              <li key={r.akun_id} className="py-3">
                <p className="font-semibold">
                  {r.nama} <span className="text-sm font-normal opacity-70">· {r.keterangan}</span>
                </p>
                <p className="mb-2 text-sm opacity-70">{r.login ?? "-"}</p>
                <FormAksi
                  aksi={buatTautanAturUlang.bind(null, r.akun_id, r.nama)}
                  tombol="Tautan atur ulang kata sandi"
                  jenisTombol="biasa"
                />
              </li>
            ))}
          </ul>
        </Kotak>
      ) : null}

      <Kotak judul={`Anggota (${semua.length})`}>
        <div className="mb-3 flex flex-wrap gap-2">
          {kelompok.bolehUbah ? (
            <>
              <TautanTombol href={`/kelompok/${id}/anggota/baru`} jenis="utama">
                + Tambah anggota
              </TautanTombol>
              <TautanTombol href={`/kelompok/${id}/kartu`}>Cetak kartu QR</TautanTombol>
            </>
          ) : null}
          <TautanTombol href={`/kelompok/${id}/akun-baru`}>+ Buat akun baru</TautanTombol>
          <TautanTombol href={`/kelompok/${id}/masukkan-akun`}>+ Masukkan akun yang sudah ada</TautanTombol>
          {jumlahBelumLengkap > 0 || hanyaBelumLengkap ? (
            <TautanTombol href={hanyaBelumLengkap ? `/kelompok/${id}` : `/kelompok/${id}?belum=1`}>
              {hanyaBelumLengkap ? "Tampilkan semua" : `Belum lengkap saja (${jumlahBelumLengkap})`}
            </TautanTombol>
          ) : null}
        </div>
        {tampil.length === 0 ? (
          <p className="opacity-70">
            {hanyaBelumLengkap ? "Semua profil anggota sudah lengkap." : "Belum ada anggota."}
          </p>
        ) : (
          <SaringCari label="Cari nama anggota…" jumlah={tampil.length} satuan="anggota">
            <ul className="divide-y divide-black/10 dark:divide-white/10">
              {tampil.map((a) => {
                const s = statusPer.get(a.id);
                return (
                  <li key={a.id} data-cari={a.nama_lengkap.toLowerCase()}>
                    {/* Ketuk nama untuk membuka rincian; ketuk lagi untuk menutup. */}
                    <details className="group">
                      <summary className="-mx-2 flex min-h-11 cursor-pointer list-none flex-wrap items-center gap-2 rounded-lg px-2 py-1 hover:bg-black/5 dark:hover:bg-white/10 [&::-webkit-details-marker]:hidden">
                        <span className="font-semibold">{a.nama_lengkap}</span>
                        {!a.aktif ? <span className="text-xs opacity-70">(tidak aktif)</span> : null}
                        <LabelKelengkapan kosong={a.kosong} />
                        <span className="ml-auto text-sm opacity-60" aria-hidden>
                          <span className="group-open:hidden">▾</span>
                          <span className="hidden group-open:inline">▴</span>
                        </span>
                      </summary>
                      <div className="mb-3 ml-1 mt-1 space-y-2 border-l-2 border-black/10 pl-3 dark:border-white/15">
                        {a.kosong.length > 0 ? (
                          <p className="text-xs opacity-70">
                            {a.persetujuan_pada ? `Belum diisi: ${a.kosong.join(", ")}` : "Persetujuan data belum dicatat"}
                          </p>
                        ) : (
                          <p className="text-xs opacity-70">Profil sudah lengkap.</p>
                        )}
                        {!kelompok.bolehUbah ? null : s?.punya_akun && s.akun_id ? (
                          <>
                            <p className="text-sm opacity-70">Punya akun: {s.login ?? "-"}</p>
                            {bolehReset.has(s.akun_id) ? (
                              <FormAksi
                                aksi={buatTautanAturUlang.bind(null, s.akun_id, a.nama_lengkap)}
                                tombol="Tautan atur ulang kata sandi"
                                jenisTombol="biasa"
                              />
                            ) : (
                              <p className="text-xs opacity-70">Kata sandi pengurus diatur ulang oleh Ketua Tim atau Admin.</p>
                            )}
                          </>
                        ) : (
                          <>
                            <p className="text-sm opacity-70">Belum punya akun (tidak wajib).</p>
                            <FormAksi
                              aksi={buatUndangan.bind(null, id, a.id, a.nama_lengkap)}
                              tombol="Buat tautan undangan untuk orang ini"
                              jenisTombol="biasa"
                            />
                          </>
                        )}
                        <div>
                          <TautanTombol href={`/kelompok/${id}/anggota/${a.id}`}>Buka profil →</TautanTombol>
                        </div>
                      </div>
                    </details>
                  </li>
                );
              })}
            </ul>
          </SaringCari>
        )}
      </Kotak>

      {kelompok.bolehUbah && undangan.length > 0 ? (
        <Kotak judul="Undangan yang belum dipakai">
          <ul className="divide-y divide-black/10 dark:divide-white/10">
            {undangan.map((u) => (
              <li key={u.id} className="flex flex-wrap items-center justify-between gap-2 py-2 text-sm">
                <span>
                  {u.anggota ? `Untuk ${u.anggota.nama_lengkap}` : "Anggota baru"} · berlaku sampai{" "}
                  {waktuWib(u.kedaluwarsa_pada)}
                </span>
                <FormAksi aksi={batalkanUndangan.bind(null, id, u.id)} tombol="Batalkan" jenisTombol="bahaya" />
              </li>
            ))}
          </ul>
        </Kotak>
      ) : null}
      {adminDiSini && dataKelompok ? (
        <Kotak judul="Pengaturan kelompok (Admin)">
          <Lipatan judul="Ubah nama / pindah tim">
            <FormAksi aksi={ubahKelompok.bind(null, id)} tombol="Simpan" jenisTombol="biasa" tanpaReset>
              <Isian label="Nama kelompok" name="nama" defaultValue={kelompok.nama} required />
              <Pilihan label="Berada di bawah tim" name="tim_id" defaultValue={dataKelompok.tim_id} required>
                {(dataTim ?? []).map((t) => (
                  <option key={t.id} value={t.id}>
                    {t.nama}
                  </option>
                ))}
              </Pilihan>
            </FormAksi>
          </Lipatan>
          <Lipatan judul="Hapus kelompok beserta seluruh isinya">
            <p className="text-sm">
              Semua anggota, profil dan foto, pertemuan, absensi, persembahan, proyek, dan catatan
              kelompok ini akan <strong>terhapus permanen</strong>. Akun login anggota tetap ada.
            </p>
            <FormAksi
              aksi={hapusKelompokTotal.bind(null, id)}
              tombol="Hapus kelompok ini"
              jenisTombol="bahaya"
              konfirmasi={`Yakin menghapus ${kelompok.nama} beserta seluruh isinya? Tindakan ini tidak bisa dibatalkan.`}
            >
              <Isian
                label={`Ketik nama kelompok untuk konfirmasi: ${kelompok.nama}`}
                name="konfirmasi"
                autoComplete="off"
                required
              />
            </FormAksi>
          </Lipatan>
        </Kotak>
      ) : null}
    </main>
  );
}
