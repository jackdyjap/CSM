-- =====================================================================
-- 27 · MENGURANGI DATA SENSITIF (keputusan 46)
--
-- * Tanggal lahir diganti TAHUN LAHIR; tanggal dan bulan lama dibuang.
-- * Tempat lahir, alamat lengkap, kecamatan, dan kelurahan DIHAPUS
--   (anggota dan profil staf). Wilayah cukup Provinsi dan Kota/Kabupaten.
-- * Nama wali untuk anggota 18 tahun ke bawah tidak lagi wajib.
-- * Laporan rentang usia dan generasi dihitung dari tahun lahir
--   (usia kira-kira = tahun ini - tahun lahir).
--
-- PERHATIAN: data yang dihapus tidak bisa dikembalikan dari aplikasi.
-- =====================================================================

-- 1. Kolom tahun lahir, diisi dari tanggal lahir lama.
alter table public.anggota     add column tahun_lahir smallint
  constraint anggota_tahun_lahir_wajar check (tahun_lahir between 1900 and 2100);
alter table public.profil_staf add column tahun_lahir smallint
  constraint profil_staf_tahun_lahir_wajar check (tahun_lahir between 1900 and 2100);
comment on column public.anggota.tahun_lahir is 'Tahun lahir saja (keputusan 46). Usia = tahun ini - tahun lahir (kira-kira).';

do $$
declare
  n_anggota int;
  n_staf    int;
begin
  select count(*) into n_anggota from public.anggota
   where tanggal_lahir is not null or tempat_lahir is not null or alamat is not null
      or kecamatan_kode is not null or kelurahan_kode is not null;
  select count(*) into n_staf from public.profil_staf
   where tanggal_lahir is not null or tempat_lahir is not null or alamat is not null
      or kecamatan_kode is not null or kelurahan_kode is not null;

  -- Isi tahun lahir, lalu kosongkan data yang dibuang (sebelum kolomnya dihapus).
  update public.anggota
     set tahun_lahir = extract(year from tanggal_lahir)::smallint,
         tanggal_lahir = null, tempat_lahir = null, alamat = null,
         kecamatan_kode = null, kelurahan_kode = null
   where tanggal_lahir is not null or tempat_lahir is not null or alamat is not null
      or kecamatan_kode is not null or kelurahan_kode is not null;
  update public.profil_staf
     set tahun_lahir = extract(year from tanggal_lahir)::smallint,
         tanggal_lahir = null, tempat_lahir = null, alamat = null,
         kecamatan_kode = null, kelurahan_kode = null
   where tanggal_lahir is not null or tempat_lahir is not null or alamat is not null
      or kecamatan_kode is not null or kelurahan_kode is not null;

  perform internal.catat_log('hapus_data_sensitif', jsonb_build_object(
    'anggota', n_anggota, 'profil_staf', n_staf,
    'dihapus', 'tanggal & bulan lahir, tempat lahir, alamat, kecamatan, kelurahan'));
end;
$$;

-- 2. Aturan lama yang menyebut kolom-kolom itu dilepas, kolomnya dihapus,
--    lalu aturannya dipasang lagi tanpa kolom tersebut.
alter table public.anggota drop constraint anggota_perlu_persetujuan;
alter table public.anggota drop constraint anggota_wilayah_bertingkat;
alter table public.anggota
  drop column tempat_lahir,
  drop column tanggal_lahir,
  drop column alamat,
  drop column kecamatan_kode,
  drop column kelurahan_kode;

alter table public.anggota add constraint anggota_perlu_persetujuan check (
  persetujuan_pada is not null or (
    gender is null and foto_path is null and tahun_lahir is null
    and provinsi_kode is null and kota_kode is null and status_nikah is null
    and pendidikan is null and pekerjaan is null and no_hp is null and baptis is null
  )
);
alter table public.anggota add constraint anggota_wilayah_bertingkat check (
      (provinsi_kode is null or provinsi_kode ~ '^[0-9]{2}$')
  and (kota_kode     is null or (provinsi_kode is not null and kota_kode like provinsi_kode || '.__'))
);
comment on table public.anggota is 'Profil anggota. Usia tidak disimpan; dihitung kira-kira dari tahun_lahir.';

alter table public.profil_staf drop constraint profil_staf_wilayah_bertingkat;
alter table public.profil_staf
  drop column tempat_lahir,
  drop column tanggal_lahir,
  drop column alamat,
  drop column kecamatan_kode,
  drop column kelurahan_kode;
alter table public.profil_staf add constraint profil_staf_wilayah_bertingkat check (
      (provinsi_kode is null or provinsi_kode ~ '^[0-9]{2}$')
  and (kota_kode     is null or (provinsi_kode is not null and kota_kode like provinsi_kode || '.__'))
);


-- 3. Penjaga profil anggota: tanpa kewajiban wali; tahun lahir tidak di masa depan.
create or replace function internal.jaga_anggota()
returns trigger language plpgsql security definer set search_path = ''
as $$
declare
  v_uid      uuid := auth.uid();
  v_diri     boolean := false;
  v_pemimpin boolean := false;
begin
  -- Perubahan oleh sistem (tugas otomatis, penjaga lain, SQL editor Supabase)
  -- tidak diperiksa haknya, hanya dirapikan.
  if v_uid is not null and pg_trigger_depth() = 1 then
    v_diri := new.id = bantu.anggota_saya();
    if tg_op = 'UPDATE' then
      v_pemimpin := old.kelompok_id in (select bantu.kelompok_dipimpin());
    else
      v_pemimpin := new.kelompok_id in (select bantu.kelompok_dipimpin());
    end if;

    if tg_op = 'UPDATE' and v_diri and not v_pemimpin then
      if new.kelompok_id        is distinct from old.kelompok_id
      or new.kode_qr            is distinct from old.kode_qr
      or new.aktif              is distinct from old.aktif
      or new.dinonaktifkan_pada is distinct from old.dinonaktifkan_pada
      or new.bergabung_pada     is distinct from old.bergabung_pada then
        raise exception 'Anda tidak boleh mengubah kelompok, kode QR, status aktif, atau tanggal bergabung.'
          using errcode = '42501';
      end if;
      if old.persetujuan_pada is not null
         and new.persetujuan_pada is distinct from old.persetujuan_pada then
        raise exception 'Persetujuan yang sudah tercatat hanya bisa diubah oleh pemimpin kelompok.'
          using errcode = '42501';
      end if;
    end if;
  end if;

  -- Rapikan data persetujuan.
  if new.persetujuan_pada is null then
    new.persetujuan_dicatat_oleh := null;
    new.persetujuan_dicatat_akun := null;
  elsif tg_op = 'INSERT' or old.persetujuan_pada is null
        or new.persetujuan_pada is distinct from old.persetujuan_pada then
    new.persetujuan_pada := now();
    if v_uid is not null then
      new.persetujuan_dicatat_akun := v_uid;
      new.persetujuan_dicatat_oleh := case when v_diri and not v_pemimpin
                                           then 'anggota_sendiri' else 'pemimpin' end;
    else
      new.persetujuan_dicatat_oleh := coalesce(new.persetujuan_dicatat_oleh, 'pemimpin');
    end if;
  else
    -- Siapa yang mencatat tidak boleh diubah-ubah.
    new.persetujuan_dicatat_oleh := old.persetujuan_dicatat_oleh;
    -- Kecuali akun pencatatnya dihapus (keputusan 41): kolomnya dikosongkan.
    new.persetujuan_dicatat_akun := case
      when new.persetujuan_dicatat_akun is null
       and not exists (select 1 from public.akun where id = old.persetujuan_dicatat_akun) then null
      else old.persetujuan_dicatat_akun end;
  end if;

  -- Tanggal persetujuan wali diisi otomatis saat nama wali pertama kali diisi.
  if new.wali_nama is null then
    new.wali_persetujuan_pada := null;
  elsif new.wali_persetujuan_pada is null then
    new.wali_persetujuan_pada := now();
  end if;

  -- Tahun lahir tidak boleh di masa depan. Nama wali tidak wajib (keputusan 46).
  if new.tahun_lahir is not null
     and new.tahun_lahir > extract(year from bantu.hari_ini_wib())::int then
    raise exception 'Tahun lahir tidak boleh lebih dari tahun ini.' using errcode = '23514';
  end if;

  -- Rapikan status aktif.
  if new.aktif then
    new.dinonaktifkan_pada := null;
  elsif new.dinonaktifkan_pada is null then
    new.dinonaktifkan_pada := now();
  end if;

  return new;
end;
$$;

-- Profil staf: tahun lahir tidak di masa depan.
create or replace function internal.jaga_profil_staf()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  if tg_op = 'INSERT' then
    new.persetujuan_pada := now();
  elsif tg_op = 'UPDATE' then
    new.persetujuan_pada := old.persetujuan_pada;
    new.akun_id := old.akun_id;
  end if;
  if new.tahun_lahir is not null
     and new.tahun_lahir > extract(year from bantu.hari_ini_wib())::int then
    raise exception 'Tahun lahir tidak boleh lebih dari tahun ini.' using errcode = '23514';
  end if;
  return new;
end;
$$;


-- 4. Usia, rentang usia, dan generasi dari tahun lahir.
create function internal.usia_dari_tahun(p_tahun int)
returns int
language sql stable set search_path = ''
as $$
  select case when p_tahun is null then null
              else extract(year from bantu.hari_ini_wib())::int - p_tahun end;
$$;

drop function internal.rentang_usia(date);
create function internal.rentang_usia(p_tahun int)
returns text
language sql stable set search_path = ''
as $$
  select case
    when u is null then null
    when u < 13 then '0-12'
    when u < 18 then '13-17'
    when u < 25 then '18-24'
    when u < 35 then '25-34'
    when u < 45 then '35-44'
    when u < 55 then '45-54'
    when u < 65 then '55-64'
    else '65+'
  end
  from (select internal.usia_dari_tahun(p_tahun) as u) x;
$$;

drop function internal.generasi(date);
create function internal.generasi(p_tahun int)
returns text
language sql immutable set search_path = ''
as $$
  select case
    when p_tahun is null then null
    when p_tahun >= 2025 then 'beta'
    when p_tahun >= 2013 then 'alpha'
    when p_tahun >= 1997 then 'z'
    when p_tahun >= 1981 then 'y'
    when p_tahun >= 1965 then 'x'
    when p_tahun >= 1946 then 'boomers'
    else 'silent'
  end;
$$;


-- 5. Laporan demografi: tanpa kecamatan/kelurahan; usia dari tahun lahir.
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
                       'provinsi','kota','rentang_usia',
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
        when 'rentang_usia'  then internal.rentang_usia(a.tahun_lahir)
        when 'baptis'        then case a.baptis when true then 'sudah' when false then 'belum' end
        when 'status_jemaat' then a.status_jemaat::text
        when 'generasi'      then internal.generasi(a.tahun_lahir)
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
              when p_dimensi in ('provinsi','kota') then coalesce(w.nama, h.v)
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
