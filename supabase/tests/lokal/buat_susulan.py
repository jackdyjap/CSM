import glob, os, sys
root = sys.argv[1]
M = [
 ("0600","proc","internal","akun_baru"),
 ("0700","proc","internal","jaga_tanggal_pertemuan"),
 ("0800","proc","bantu","kelompok_dipimpin_langsung"),
 ("0900","proc","public","hapus_kelompok_total"),
 ("1000","rel","public","bukti_persembahan"),
 ("1100","proc","public","tindak_lanjut"),
 ("1200","proc","public","ringkasan_tim"),   # hanya create or replace: dijalankan bila 1300 belum
 ("1300","proc","public","ringkasan_tim"),
 ("1400","proc","public","buat_ulang_kode_kartu"),
 ("1500","proc","internal","normal_hp"),
 ("1600","proc","public","selesai_atur_profil"),
 ("1700","proc","public","kirim_masukan"),
 ("1800","proc","public","ubah_data_jemaat"),
 ("1900","proc","internal","generasi"),
 ("2000","proc","public","akun_bisa_atur_ulang"),
 ("2100","proc","bantu","boleh_masukkan_ke_kelompok"),
 ("2200","proc","public","lapor_proyek_saya"),
 ("2300","proc","public","laporan_proyek"),
 ("2400","proc","bantu","boleh_baca_bahan"),
 ("2500","proc","public","layanan_ambil_antrean_berkas"),
 ("2600","proc","public","hapus_akun"),
 ("2700","proc","internal","usia_dari_tahun"),
 ("2800","rel","public","bahan_training"),
 ("2900","rel","public","saat_teduh"),
]
out = ["""-- =====================================================================
-- SUSULAN MIGRASI · menjalankan file migrasi yang TERLEWAT, sekaligus
--
-- Cara pakai: salin SELURUH isi file ini ke Supabase → SQL Editor → Run.
-- File ini memeriksa satu per satu (…0600 sampai …2900) apakah sudah
-- pernah dijalankan, lalu hanya menjalankan yang belum, berurutan.
-- Aman dijalankan berulang kali. Bila ada galat, semuanya dibatalkan
-- (tidak ada yang setengah jadi).
--
-- Hanya untuk database yang sudah menjalankan fase1_sekali_jalan.sql.
-- Dibuat otomatis oleh tests/lokal/buat_susulan.py; jangan diubah dengan tangan.
-- =====================================================================
do $susulan$
declare
  v_dijalankan text[] := '{}';
begin
  if to_regprocedure('internal.jaga_anggota()') is null then
    raise exception 'Jalankan fase1_sekali_jalan.sql terlebih dahulu.';
  end if;
"""]
def ada(jenis, skema, nama):
    if jenis == "rel":
        return f"to_regclass('{skema}.{nama}') is not null"
    return (f"exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace "
            f"where n.nspname = '{skema}' and p.proname = '{nama}')")
for kode, jenis, skema, nama in M:
    f = glob.glob(os.path.join(root, f"supabase/migrations/*{kode}_*.sql"))
    assert len(f) == 1, kode
    isi = open(f[0]).read()
    tag = f"$mig{kode}$"
    assert tag not in isi and "$susulan$" not in isi
    base = os.path.basename(f[0])
    out.append(f"""
  -- {base}
  if not ({ada(jenis, skema, nama)}) then
    execute {tag}
{isi}
{tag};
    v_dijalankan := v_dijalankan || '{base}'::text;
  end if;
""")
out.append("""
  if cardinality(v_dijalankan) = 0 then
    raise notice 'Semua migrasi sudah dijalankan sebelumnya. Tidak ada yang diubah.';
  else
    raise notice 'Berhasil dijalankan: %', array_to_string(v_dijalankan, ', ');
  end if;
end
$susulan$;

-- Hasil pemeriksaan: semua baris harus "sudah".
select m.file,
       case when exists (select 1 from pg_proc p join pg_namespace n on n.oid = p.pronamespace
                         where n.nspname = m.skema and p.proname = m.fungsi)
                 or to_regclass(m.skema || '.' || m.fungsi) is not null
            then 'sudah' else 'BELUM' end as status
from (values
""")
rows=[]
for kode, jenis, skema, nama in M:
    if kode=="1200": continue
    base=os.path.basename(glob.glob(os.path.join(root, f"supabase/migrations/*{kode}_*.sql"))[0])
    rows.append(f"  ('{base}', '{skema}', '{nama}')")
out.append(",\n".join(rows)+"\n) as m(file, skema, fungsi);\n")
open(os.path.join(root,"supabase/susulan_migrasi.sql"),"w").write("".join(out))
