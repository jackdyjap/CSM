-- =====================================================================
-- 09 · KOREKSI DATA (keputusan 13–15, 17 November 2026)
--   1. Admin boleh mengubah nama tampilan akun siapa pun.
--   2. Admin boleh menghapus kelompok BESERTA seluruh isinya, setelah
--      mengetik nama kelompok persis (loket hapus_kelompok_total).
--   3. Catatan khusus yang salah tulis boleh diubah/dihapus oleh pemimpin
--      kelompoknya DAN Admin. Menulis catatan baru tetap khusus pemimpin.
-- Perbaikan lain (nama tim/kelompok, pindah tim, hapus/pindah anggota,
-- ubah tanggal pertemuan) sudah diizinkan aturan akses sebelumnya.
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1. Admin mengubah nama akun. Hak kolom tetap hanya nama_tampilan
--    (lihat file 03), jadi penghubung akun ke profil tidak bisa diubah.
-- ---------------------------------------------------------------------
create policy "akun: admin mengubah nama" on public.akun
  for update to authenticated
  using ((select bantu.saya_admin())) with check ((select bantu.saya_admin()));


-- ---------------------------------------------------------------------
-- 2. Hapus kelompok beserta seluruh isinya (khusus Admin).
--    Terhapus: pertemuan (+ absensi, kunci QR), proyek ketaatan
--    (+ status), anggota (+ catatan khusus, status, foto masuk antrean
--    hapus), undangan, dan penugasan pemimpin/wakil kelompok itu.
--    Akun login anggota TIDAK dihapus; hanya dilepas dari profilnya.
-- ---------------------------------------------------------------------
create function public.hapus_kelompok_total(p_kelompok uuid, p_konfirmasi text)
returns jsonb
language plpgsql security definer set search_path = ''
as $$
declare
  v_nama     text;
  v_hasil    jsonb;
  v_anggota  integer;
  v_pertemuan integer;
  v_proyek   integer;
begin
  if not bantu.saya_admin() then
    raise exception 'Hanya Admin yang boleh menghapus kelompok.' using errcode = '42501';
  end if;

  select k.nama into v_nama from public.kelompok k where k.id = p_kelompok;
  if v_nama is null then
    raise exception 'Kelompok tidak ditemukan.' using errcode = '22023';
  end if;
  if coalesce(trim(p_konfirmasi), '') <> trim(v_nama) then
    raise exception 'Nama yang diketik tidak sama dengan nama kelompok. Tidak ada yang dihapus.'
      using errcode = '22023';
  end if;

  delete from public.pertemuan       where kelompok_id = p_kelompok;
  get diagnostics v_pertemuan = row_count;
  delete from public.proyek_ketaatan where kelompok_id = p_kelompok;
  get diagnostics v_proyek = row_count;
  delete from public.anggota         where kelompok_id = p_kelompok;
  get diagnostics v_anggota = row_count;
  delete from public.kelompok        where id = p_kelompok;

  v_hasil := jsonb_build_object('kelompok', v_nama, 'anggota', v_anggota,
                                'pertemuan', v_pertemuan, 'proyek', v_proyek);
  perform internal.catat_log('hapus_kelompok_total', v_hasil || jsonb_build_object('kelompok_id', p_kelompok));
  return v_hasil;
end;
$$;

revoke all on function public.hapus_kelompok_total(uuid, text) from public, anon;
grant execute on function public.hapus_kelompok_total(uuid, text) to authenticated;


-- ---------------------------------------------------------------------
-- 3. Koreksi catatan khusus: pemimpin kelompoknya atau Admin,
--    dan tidak pernah tentang diri sendiri.
-- ---------------------------------------------------------------------
create function bantu.boleh_koreksi_catatan(p_anggota uuid)
returns boolean
language sql stable security definer
set search_path = ''
as $$
  select bantu.boleh_tulis_catatan(p_anggota)
      or (bantu.saya_admin() and p_anggota is distinct from bantu.anggota_saya()
          and exists (select 1 from public.anggota a where a.id = p_anggota));
$$;
revoke all on function bantu.boleh_koreksi_catatan(uuid) from public, anon;
grant execute on function bantu.boleh_koreksi_catatan(uuid) to authenticated;

create or replace function public.ubah_catatan(
  p_catatan uuid,
  p_isi     text,
  p_jenis   public.jenis_catatan default null
)
returns void
language plpgsql security definer set search_path = ''
as $$
declare
  v_anggota uuid;
begin
  select c.anggota_id into v_anggota from public.catatan_khusus c where c.id = p_catatan;
  if v_anggota is null or not bantu.boleh_koreksi_catatan(v_anggota) then
    raise exception 'Catatan tidak ditemukan atau Anda tidak berhak mengubahnya.' using errcode = '42501';
  end if;
  if length(trim(coalesce(p_isi, ''))) = 0 then
    raise exception 'Isi catatan tidak boleh kosong.' using errcode = '23514';
  end if;

  update public.catatan_khusus
     set isi = trim(p_isi), jenis = coalesce(p_jenis, jenis)
   where id = p_catatan;

  perform internal.catat_log('ubah_catatan',
    jsonb_build_object('catatan_id', p_catatan, 'anggota_id', v_anggota));
end;
$$;

create or replace function public.hapus_catatan(p_catatan uuid)
returns void
language plpgsql security definer set search_path = ''
as $$
declare
  v_anggota uuid;
begin
  select c.anggota_id into v_anggota from public.catatan_khusus c where c.id = p_catatan;
  if v_anggota is null or not bantu.boleh_koreksi_catatan(v_anggota) then
    raise exception 'Catatan tidak ditemukan atau Anda tidak berhak menghapusnya.' using errcode = '42501';
  end if;

  delete from public.catatan_khusus where id = p_catatan;

  perform internal.catat_log('hapus_catatan',
    jsonb_build_object('catatan_id', p_catatan, 'anggota_id', v_anggota));
end;
$$;
