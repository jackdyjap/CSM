-- =====================================================================
-- 19 · LAPORAN DEMOGRAFI: KELOMPOK GENERASI (keputusan 31)
--
-- Dimensi baru "generasi" menurut TAHUN lahir:
--   beta    2025 ke atas      alpha   2013-2024     z  1997-2012
--   y       1981-1996         x       1965-1980
--   boomers 1946-1964         silent  1945 ke bawah
-- (Pew Research; Alpha dan Beta menurut McCrindle.)
-- Batas tahun cukup diubah di fungsi internal.generasi.
-- =====================================================================

create function internal.generasi(p_lahir date)
returns text
language sql immutable set search_path = ''
as $$
  select case
    when p_lahir is null then null
    when y >= 2025 then 'beta'
    when y >= 2013 then 'alpha'
    when y >= 1997 then 'z'
    when y >= 1981 then 'y'
    when y >= 1965 then 'x'
    when y >= 1946 then 'boomers'
    else 'silent'
  end
  from (select extract(year from p_lahir)::int as y) t;
$$;


-- Laporan demografi (isi sama dengan file 18, ditambah dimensi generasi).
create or replace function public.laporan_demografi(
  p_dimensi     text,
  p_cakupan     text    default 'semua',
  p_cakupan_id  uuid    default null,
  p_hanya_aktif boolean default true
)
returns table (
  tim_nama      text,
  kelompok_id   uuid,
  kelompok_nama text,
  kunci         text,
  label         text,
  jumlah        bigint,
  persen        numeric
)
language plpgsql security definer set search_path = ''
as $$
#variable_conflict use_column
begin
  if not bantu.saya_admin() then
    raise exception 'Laporan demografi hanya dapat dibuka oleh Admin.' using errcode = '42501';
  end if;
  if p_dimensi not in ('gender','pendidikan','status_nikah','pekerjaan',
                       'provinsi','kota','kecamatan','kelurahan','rentang_usia',
                       'baptis','status_jemaat','generasi') then
    raise exception 'Dimensi tidak dikenal: %', p_dimensi using errcode = '22023';
  end if;
  if p_cakupan not in ('semua','tim','kelompok')
     or (p_cakupan <> 'semua' and p_cakupan_id is null) then
    raise exception 'Cakupan laporan tidak valid.' using errcode = '22023';
  end if;

  perform internal.catat_log('buat_laporan_demografi', jsonb_build_object(
    'dimensi', p_dimensi, 'cakupan', p_cakupan,
    'cakupan_id', p_cakupan_id, 'hanya_aktif', p_hanya_aktif));

  return query
  with data as (
    select t.nama as t_nama, k.id as k_id, k.nama as k_nama,
      case p_dimensi
        when 'gender'        then a.gender::text
        when 'pendidikan'    then a.pendidikan::text
        when 'status_nikah'  then a.status_nikah::text
        when 'pekerjaan'     then a.pekerjaan::text
        when 'provinsi'      then a.provinsi_kode
        when 'kota'          then a.kota_kode
        when 'kecamatan'     then a.kecamatan_kode
        when 'kelurahan'     then a.kelurahan_kode
        when 'rentang_usia'  then internal.rentang_usia(a.tanggal_lahir)
        when 'baptis'        then case a.baptis when true then 'sudah' when false then 'belum' end
        when 'status_jemaat' then a.status_jemaat::text
        when 'generasi'      then internal.generasi(a.tanggal_lahir)
      end as v
    from public.anggota a
    join public.kelompok k on k.id = a.kelompok_id
    join public.tim t      on t.id = k.tim_id
    where (not p_hanya_aktif or a.aktif)
      and (p_cakupan = 'semua'
           or (p_cakupan = 'tim'      and k.tim_id = p_cakupan_id)
           or (p_cakupan = 'kelompok' and k.id     = p_cakupan_id))
  ),
  hitung as (
    select d.t_nama, d.k_id, d.k_nama, d.v, count(*) as n
    from data d group by d.t_nama, d.k_id, d.k_nama, d.v
  )
  select h.t_nama, h.k_id, h.k_nama, h.v,
         case when h.v is null then 'Belum diisi'
              when p_dimensi in ('provinsi','kota','kecamatan','kelurahan')
                then coalesce(w.nama, h.v)
              else h.v end,
         h.n,
         case when h.v is null then null
              else round(100.0 * h.n / nullif(sum(h.n) filter (where h.v is not null)
                                              over (partition by h.k_id), 0), 1) end
  from hitung h
  left join public.wilayah w on w.kode = h.v
  order by h.t_nama, h.k_nama, (h.v is null), h.v;
end;
$$;

revoke all on all functions in schema internal from public, anon, authenticated;
