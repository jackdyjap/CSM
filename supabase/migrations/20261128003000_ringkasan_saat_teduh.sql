-- =====================================================================
-- 30 · RINGKASAN SAAT TEDUH PER BULAN (keputusan 59, Tahap 2 dari 58)
--
-- * Untuk Pemimpin/Wakil (kelompoknya), Ketua Tim (kelompok di timnya),
--   dan Admin (semua): hanya kelompok di bantu.kelompok_terbaca().
-- * Yang dihitung: anggota AKTIF yang PUNYA AKUN (hanya mereka yang bisa
--   mencatat). "Bersaat teduh" = minimal 1 catatan di bulan itu.
--   Anggota aktif tanpa akun dihitung terpisah.
-- * Catatan dihitung menurut keanggotaan SAAT INI (kelompok anggota sekarang).
-- =====================================================================

-- Ringkasan per kelompok untuk satu bulan (p_bulan = tanggal mana pun di bulan itu).
create function public.ringkasan_saat_teduh(p_bulan date)
returns table (
  tim_id          uuid,
  tim_nama        text,
  kelompok_id     uuid,
  kelompok_nama   text,
  anggota_aktif   integer,
  punya_akun      integer,
  bersaat_teduh   integer,
  jumlah_catatan  integer,
  total_menit     integer
)
language sql stable security definer set search_path = ''
as $$
  with b as (
    select date_trunc('month', coalesce(p_bulan, bantu.hari_ini_wib()))::date as awal
  ),
  ang as (
    select a.id, a.kelompok_id, k.id as akun_id
    from public.anggota a
    left join public.akun k on k.anggota_id = a.id
    where a.aktif
      and a.kelompok_id in (select bantu.kelompok_terbaca())
  ),
  cat as (
    select s.akun_id, count(*)::integer as n, sum(s.durasi_menit)::integer as menit
    from public.saat_teduh s, b
    where s.tanggal >= b.awal and s.tanggal < (b.awal + interval '1 month')::date
      and s.akun_id in (select akun_id from ang where akun_id is not null)
    group by s.akun_id
  )
  select t.id, t.nama, k.id, k.nama,
         count(ang.id)::integer,
         count(ang.akun_id)::integer,
         count(cat.akun_id)::integer,
         coalesce(sum(cat.n), 0)::integer,
         coalesce(sum(cat.menit), 0)::integer
  from public.kelompok k
  join public.tim t on t.id = k.tim_id
  left join ang on ang.kelompok_id = k.id
  left join cat on cat.akun_id = ang.akun_id
  where k.id in (select bantu.kelompok_terbaca())
  group by t.id, t.nama, k.id, k.nama
  order by t.nama, k.nama;
$$;

-- Rincian per anggota aktif satu kelompok untuk satu bulan.
create function public.saat_teduh_per_anggota(p_kelompok uuid, p_bulan date)
returns table (
  anggota_id      uuid,
  nama_lengkap    text,
  akun_id         uuid,
  jumlah_hari     integer,
  jumlah_catatan  integer,
  total_menit     integer
)
language plpgsql stable security definer set search_path = ''
as $$
#variable_conflict use_column
declare
  v_awal date := date_trunc('month', coalesce(p_bulan, bantu.hari_ini_wib()))::date;
begin
  if p_kelompok is null or p_kelompok not in (select bantu.kelompok_terbaca()) then
    raise exception 'Anda tidak berhak melihat ringkasan saat teduh kelompok ini.' using errcode = '42501';
  end if;

  return query
  select a.id, a.nama_lengkap, k.id,
         count(distinct s.tanggal)::integer,
         count(s.id)::integer,
         coalesce(sum(s.durasi_menit), 0)::integer
  from public.anggota a
  left join public.akun k on k.anggota_id = a.id
  left join public.saat_teduh s
         on s.akun_id = k.id
        and s.tanggal >= v_awal and s.tanggal < (v_awal + interval '1 month')::date
  where a.kelompok_id = p_kelompok and a.aktif
  group by a.id, a.nama_lengkap, k.id
  order by a.nama_lengkap;
end;
$$;

revoke all on function public.ringkasan_saat_teduh(date)              from public, anon;
revoke all on function public.saat_teduh_per_anggota(uuid, date)      from public, anon;
grant execute on function public.ringkasan_saat_teduh(date)           to authenticated;
grant execute on function public.saat_teduh_per_anggota(uuid, date)   to authenticated;
