-- =====================================================================
-- 11 · TINDAK LANJUT (Fase 5, keputusan 17)
--   Daftar anggota yang perlu ditindaklanjuti dalam satu kelompok:
--   * ABSEN : anggota aktif yang tidak hadir di 3 pertemuan terakhir
--             (yang sudah ditutup) secara berturut-turut;
--   * PROYEK: proyek ketaatan yang tenggatnya sudah lewat tetapi belum
--             selesai, atau yang ditandai "tidak dikerjakan".
--   Dihitung di database; dipakai halaman tindak lanjut (Fase 5) dan
--   dashboard Ketua Tim (Fase 6).
-- =====================================================================

create function public.tindak_lanjut(p_kelompok uuid, p_batas_absen integer default 3)
returns table (
  anggota_id      uuid,
  nama_lengkap    text,
  jenis           text,                      -- 'absen' | 'proyek'
  absen_beruntun  integer,                   -- untuk jenis 'absen'
  terakhir_hadir  date,                      -- untuk jenis 'absen' (null = belum pernah)
  alasan_terakhir public.alasan_absen,       -- untuk jenis 'absen'
  proyek_id       uuid,                      -- untuk jenis 'proyek'
  proyek_judul    text,
  tenggat         date,
  status          public.status_pengerjaan
)
language plpgsql stable security definer set search_path = ''
as $$
#variable_conflict use_column
declare
  v_hari_ini date := bantu.hari_ini_wib();
begin
  if p_kelompok is null or p_kelompok not in (select bantu.kelompok_terbaca()) then
    raise exception 'Anda tidak berhak melihat tindak lanjut kelompok ini.' using errcode = '42501';
  end if;

  return query
  -- 1. Absen berturut-turut di pertemuan yang sudah ditutup.
  with riwayat as (
    select h.anggota_id, h.hadir, h.alasan, p.tanggal,
           row_number() over (partition by h.anggota_id order by p.tanggal desc) as urutan
    from public.kehadiran h
    join public.pertemuan p on p.id = h.pertemuan_id
    where p.kelompok_id = p_kelompok and p.ditutup_pada is not null
  ),
  ringkas as (
    select r.anggota_id,
           coalesce(min(r.urutan) filter (where r.hadir) - 1, count(*))::integer as beruntun,
           max(r.tanggal) filter (where r.hadir)                               as terakhir_hadir,
           (array_agg(r.alasan order by r.urutan))[1]                         as alasan_terakhir
    from riwayat r
    group by r.anggota_id
  )
  select a.id, a.nama_lengkap, 'absen'::text, rk.beruntun, rk.terakhir_hadir, rk.alasan_terakhir,
         null::uuid, null::text, null::date, null::public.status_pengerjaan
  from ringkas rk
  join public.anggota a on a.id = rk.anggota_id
  where a.aktif and a.kelompok_id = p_kelompok
    and rk.beruntun >= greatest(coalesce(p_batas_absen, 3), 1)

  union all

  -- 2. Proyek ketaatan yang belum selesai setelah tenggat, atau "tidak dikerjakan".
  select a.id, a.nama_lengkap, 'proyek'::text, null::integer, null::date, null::public.alasan_absen,
         pk.id, pk.judul, pk.tenggat, coalesce(sp.status, 'belum'::public.status_pengerjaan)
  from public.proyek_ketaatan pk
  join public.anggota a on a.kelompok_id = pk.kelompok_id and a.aktif
  left join public.status_proyek sp on sp.proyek_id = pk.id and sp.anggota_id = a.id
  where pk.kelompok_id = p_kelompok
    -- anggota yang bergabung setelah proyek diberikan hanya dihitung bila sudah diberi status
    and (a.bergabung_pada <= pk.diberikan_pada or sp.anggota_id is not null)
    and (
          coalesce(sp.status, 'belum') = 'tidak_dikerjakan'
       or (pk.tenggat is not null and pk.tenggat < v_hari_ini
           and coalesce(sp.status, 'belum') <> 'selesai')
        )
  order by 3, 2;
end;
$$;

revoke all on function public.tindak_lanjut(uuid, integer) from public, anon;
grant execute on function public.tindak_lanjut(uuid, integer) to authenticated;
