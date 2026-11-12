-- =====================================================================
-- 05 · TUGAS OTOMATIS ("petugas yang berkeliling tiap malam")
-- Keduanya disimpan di ruang internal, jadi pengguna tidak bisa
-- memanggilnya; hanya penjadwal database (pg_cron) yang menjalankannya.
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1. Tandai anggota TIDAK AKTIF bila tidak hadir 3 bulan berturut-turut.
--    Syarat (semua harus terpenuhi):
--      * saat ini masih aktif;
--      * sudah bergabung minimal 3 bulan (anggota baru tidak ikut diperiksa);
--      * kelompoknya mengadakan minimal satu pertemuan dalam 3 bulan terakhir
--        (bila kelompok sedang libur, anggotanya tidak dianggap absen);
--      * tidak tercatat hadir sekali pun dalam 3 bulan terakhir.
--    Anggota otomatis aktif kembali saat ditandai hadir (penjaga A7, file 04).
-- ---------------------------------------------------------------------
create function internal.tandai_tidak_aktif()
returns integer
language plpgsql security definer set search_path = ''
as $$
declare
  v_hari_ini date := bantu.hari_ini_wib();
  v_batas    date := (bantu.hari_ini_wib() - interval '3 months')::date;
  v_jumlah   integer;
begin
  update public.anggota a
     set aktif = false, dinonaktifkan_pada = now()
   where a.aktif
     and a.bergabung_pada <= v_batas
     and exists (
           select 1 from public.pertemuan p
           where p.kelompok_id = a.kelompok_id
             and p.tanggal > v_batas and p.tanggal <= v_hari_ini)
     and not exists (
           select 1 from public.kehadiran h
           join public.pertemuan p on p.id = h.pertemuan_id
           where h.anggota_id = a.id and h.hadir and p.tanggal > v_batas);

  get diagnostics v_jumlah = row_count;
  if v_jumlah > 0 then
    perform internal.catat_log('nonaktif_otomatis', jsonb_build_object('jumlah', v_jumlah));
  end if;
  return v_jumlah;
end;
$$;

-- ---------------------------------------------------------------------
-- 2. Hapus data anggota yang sudah TIDAK AKTIF LEBIH DARI 1 TAHUN.
--    Ikut terhapus otomatis (lewat sambungan "on delete cascade"):
--    kehadiran, catatan khusus, status proyek, dan undangan.
--    Foto masuk antrean hapus (penjaga A3, file 04).
--    Akun login yang terhubung dilepas dari profil (anggota_id menjadi kosong).
-- ---------------------------------------------------------------------
create function internal.hapus_data_kedaluwarsa()
returns integer
language plpgsql security definer set search_path = ''
as $$
declare
  v_jumlah integer;
begin
  delete from public.anggota
   where not aktif
     and dinonaktifkan_pada < now() - interval '1 year';

  get diagnostics v_jumlah = row_count;
  if v_jumlah > 0 then
    perform internal.catat_log('hapus_otomatis', jsonb_build_object('jumlah', v_jumlah));
  end if;
  return v_jumlah;
end;
$$;

revoke all on function internal.tandai_tidak_aktif()     from public, anon, authenticated;
revoke all on function internal.hapus_data_kedaluwarsa() from public, anon, authenticated;

-- ---------------------------------------------------------------------
-- 3. Jadwal: setiap malam pukul 01.00 dan 01.30 WIB.
--    (pg_cron memakai jam UTC: 18.00 UTC = 01.00 WIB.)
--    Bila pg_cron belum tersedia, bagian ini dilewati dengan pemberitahuan.
-- ---------------------------------------------------------------------
do $$
begin
  if exists (select 1 from pg_available_extensions where name = 'pg_cron') then
    create extension if not exists pg_cron;
    perform cron.schedule('tandai-anggota-tidak-aktif', '0 18 * * *',
                          'select internal.tandai_tidak_aktif()');
    perform cron.schedule('hapus-data-kedaluwarsa',     '30 18 * * *',
                          'select internal.hapus_data_kedaluwarsa()');
  else
    raise notice 'pg_cron tidak tersedia di database ini; jadwal otomatis dilewati.';
  end if;
end;
$$;
