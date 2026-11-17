-- =====================================================================
-- 08 · ADMIN MENGELOLA SEMUA KELOMPOK (keputusan 12, 17 November 2026)
--
-- Admin kini boleh MELIHAT dan MENGUBAH anggota, foto, undangan,
-- pertemuan, absensi, persembahan, dan proyek ketaatan di SEMUA kelompok,
-- seperti pemimpin kelompok tersebut.
--
-- Caranya: bantu.kelompok_dipimpin() — dipakai oleh semua aturan akses dan
-- fungsi "khusus pemimpin" — kini juga mengembalikan semua kelompok bila
-- pengguna adalah Admin.
--
-- PENGECUALIAN: catatan khusus tetap hanya DITULIS oleh pemimpin/wakil
-- kelompoknya sendiri (Admin dan Ketua Tim hanya membaca). Untuk itu ada
-- pemeriksa baru bantu.boleh_tulis_catatan() yang dipakai ketiga fungsi
-- tulis/ubah/hapus catatan.
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1. Kelompok yang dikelola: dipimpin langsung + semua kelompok bila Admin.
-- ---------------------------------------------------------------------
create or replace function bantu.kelompok_dipimpin()
returns setof uuid
language sql stable security definer
set search_path = ''
as $$
  select kelompok_id from public.penugasan_peran
  where akun_id = auth.uid() and peran = 'pemimpin'
  union
  select k.id from public.kelompok k
  where bantu.saya_admin();
$$;
comment on function bantu.kelompok_dipimpin() is
  'Kelompok yang boleh saya kelola: yang saya pimpin (pemimpin/wakil), atau semua kelompok bila saya Admin.';

-- Kelompok yang saya pimpin LANGSUNG (tanpa perluasan Admin).
create function bantu.kelompok_dipimpin_langsung()
returns setof uuid
language sql stable security definer
set search_path = ''
as $$
  select kelompok_id from public.penugasan_peran
  where akun_id = auth.uid() and peran = 'pemimpin';
$$;

-- Bolehkah saya MENULIS catatan khusus tentang anggota ini?
-- Hanya pemimpin/wakil kelompoknya, dan tidak tentang diri sendiri.
create function bantu.boleh_tulis_catatan(p_anggota uuid)
returns boolean
language sql stable security definer
set search_path = ''
as $$
  select p_anggota is distinct from bantu.anggota_saya()
     and exists (
       select 1 from public.anggota a
       where a.id = p_anggota
         and a.kelompok_id in (select bantu.kelompok_dipimpin_langsung())
     );
$$;

revoke all on function bantu.kelompok_dipimpin_langsung() from public, anon;
revoke all on function bantu.boleh_tulis_catatan(uuid)     from public, anon;
grant execute on function bantu.kelompok_dipimpin_langsung() to authenticated;
grant execute on function bantu.boleh_tulis_catatan(uuid)     to authenticated;


-- ---------------------------------------------------------------------
-- 2. Fungsi catatan: tetap khusus pemimpin/wakil (isi lainnya tidak berubah).
-- ---------------------------------------------------------------------
create or replace function public.tulis_catatan(
  p_anggota uuid,
  p_jenis   public.jenis_catatan,
  p_isi     text,
  p_tanggal date default null
)
returns uuid
language plpgsql security definer set search_path = ''
as $$
declare
  v_id uuid;
begin
  if not bantu.boleh_tulis_catatan(p_anggota) then
    raise exception 'Anda tidak berhak menulis catatan untuk anggota ini.' using errcode = '42501';
  end if;

  insert into public.catatan_khusus (anggota_id, penulis_id, tanggal, jenis, isi)
  values (p_anggota, auth.uid(), coalesce(p_tanggal, bantu.hari_ini_wib()), p_jenis, trim(p_isi))
  returning id into v_id;

  perform internal.catat_log('tulis_catatan',
    jsonb_build_object('catatan_id', v_id, 'anggota_id', p_anggota));
  return v_id;
end;
$$;

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
  if v_anggota is null or not bantu.boleh_tulis_catatan(v_anggota) then
    raise exception 'Catatan tidak ditemukan atau Anda tidak berhak mengubahnya.' using errcode = '42501';
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
  if v_anggota is null or not bantu.boleh_tulis_catatan(v_anggota) then
    raise exception 'Catatan tidak ditemukan atau Anda tidak berhak menghapusnya.' using errcode = '42501';
  end if;

  delete from public.catatan_khusus where id = p_catatan;

  perform internal.catat_log('hapus_catatan',
    jsonb_build_object('catatan_id', p_catatan, 'anggota_id', v_anggota));
end;
$$;
