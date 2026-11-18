-- =====================================================================
-- 18 · BAPTIS, STATUS JEMAAT, DAN DATA JEMAAT OLEH KETUA TIM
--      (keputusan 29 dan 30)
--
-- * Isian baru Baptis (sudah/belum) di profil anggota dan profil staf.
--   Termasuk data pribadi: hanya boleh diisi setelah persetujuan.
--   Wajib untuk label "Lengkap" (dihitung aplikasi) dan menjadi dimensi
--   laporan demografi.
-- * Isian baru Status jemaat (tamu, member, pelayan, leader) di profil
--   anggota. Diatur oleh pemimpin/wakil, Ketua Tim dari tim itu, dan
--   Admin; anggota tidak bisa mengubah status jemaatnya sendiri.
--   Juga menjadi dimensi laporan demografi.
-- * Ketua Tim (sebelumnya hanya membaca, keputusan 21) kini boleh
--   mengubah TIGA hal untuk anggota di timnya: gender, aktif/tidak aktif,
--   dan status jemaat. Lewat loket ubah_data_jemaat.
-- =====================================================================

create type public.status_jemaat as enum ('tamu', 'member', 'pelayan', 'leader');

alter table public.anggota
  add column baptis        boolean,
  add column status_jemaat public.status_jemaat;
comment on column public.anggota.baptis        is 'Sudah dibaptis (true) / belum (false); NULL = belum diisi.';
comment on column public.anggota.status_jemaat is 'Tamu, member, pelayan, atau leader. Diatur pemimpin/Ketua Tim/Admin.';

alter table public.profil_staf add column baptis boolean;

-- Baptis termasuk data pribadi: ikut aturan persetujuan.
alter table public.anggota drop constraint anggota_perlu_persetujuan;
alter table public.anggota add constraint anggota_perlu_persetujuan check (
  persetujuan_pada is not null or (
    gender is null and foto_path is null and tempat_lahir is null and tanggal_lahir is null
    and alamat is null and provinsi_kode is null and kota_kode is null
    and kecamatan_kode is null and kelurahan_kode is null and status_nikah is null
    and pendidikan is null and pekerjaan is null and no_hp is null and baptis is null
  )
);


-- ---------------------------------------------------------------------
-- 1. Siapa yang boleh mengatur data jemaat (gender, aktif, status jemaat)
-- ---------------------------------------------------------------------
create function bantu.boleh_atur_jemaat(p_anggota uuid)
returns boolean
language sql stable security definer set search_path = ''
as $$
  select bantu.boleh_kelola_anggota(p_anggota)
      or exists (select 1 from public.anggota a
                 join public.kelompok k on k.id = a.kelompok_id
                 where a.id = p_anggota and k.tim_id in (select bantu.tim_diketuai()));
$$;
revoke all on function bantu.boleh_atur_jemaat(uuid) from public, anon;
grant execute on function bantu.boleh_atur_jemaat(uuid) to authenticated;

-- Anggota tidak bisa mengubah status jemaatnya sendiri.
create function internal.jaga_status_jemaat()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  if auth.uid() is not null
     and (tg_op = 'INSERT' or new.status_jemaat is distinct from old.status_jemaat)
     and new.status_jemaat is not null
     and not bantu.boleh_atur_jemaat(new.id)
     and not (tg_op = 'INSERT' and new.kelompok_id in (select bantu.kelompok_dipimpin())) then
    raise exception 'Status jemaat hanya bisa diatur oleh pemimpin kelompok, ketua tim, atau Admin.'
      using errcode = '42501';
  end if;
  return new;
end;
$$;

create trigger jaga_status_jemaat before insert or update on public.anggota
  for each row execute function internal.jaga_status_jemaat();


-- ---------------------------------------------------------------------
-- 2. Loket: mengubah gender, aktif, dan status jemaat
--    (pemimpin/wakil, Ketua Tim dari tim itu, Admin)
-- ---------------------------------------------------------------------
create function public.ubah_data_jemaat(
  p_anggota uuid, p_gender public.gender, p_aktif boolean, p_status_jemaat public.status_jemaat)
returns void
language plpgsql security definer set search_path = ''
as $$
declare
  v public.anggota;
begin
  select * into v from public.anggota where id = p_anggota for update;
  if v.id is null or auth.uid() is null or not bantu.boleh_atur_jemaat(p_anggota) then
    raise exception 'Anda tidak berhak mengubah data jemaat anggota ini.' using errcode = '42501';
  end if;
  if p_gender is not null and v.persetujuan_pada is null then
    raise exception 'Gender baru bisa diisi setelah persetujuan data anggota ini dicatat oleh pemimpin kelompok.'
      using errcode = '22023';
  end if;

  update public.anggota
     set gender = p_gender,
         aktif = coalesce(p_aktif, v.aktif),
         status_jemaat = p_status_jemaat
   where id = p_anggota;

  perform internal.catat_log('ubah_data_jemaat', jsonb_build_object(
    'anggota_id', p_anggota,
    'aktif_berubah', coalesce(p_aktif, v.aktif) is distinct from v.aktif,
    'status_jemaat', p_status_jemaat));
end;
$$;
revoke all on function public.ubah_data_jemaat(uuid, public.gender, boolean, public.status_jemaat) from public, anon;
grant execute on function public.ubah_data_jemaat(uuid, public.gender, boolean, public.status_jemaat) to authenticated;


-- ---------------------------------------------------------------------
-- 3. Laporan demografi: dimensi baptis dan status_jemaat
--    (isi sama dengan file 04, ditambah dua dimensi)
-- ---------------------------------------------------------------------
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
                       'baptis','status_jemaat') then
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
