-- =====================================================================
-- 25 · PENGHAPUS BERKAS OTOMATIS (keputusan 40)
--
-- Foto, bukti transfer, dan bahan diskusi yang datanya sudah dihapus
-- dicatat di internal.antrean_hapus_foto (lokasi + folder). Berkasnya
-- dihapus dari penyimpanan oleh server aplikasi (setiap malam lewat
-- Vercel Cron, atau tombol Admin), memakai loket di bawah.
--
-- Pengaman: berkas yang ternyata MASIH dipakai data mana pun tidak
-- dihapus; barisnya hanya dikeluarkan dari antrean.
-- =====================================================================

-- Apakah berkas ini masih dipakai?
create function internal.berkas_masih_dipakai(p_bucket text, p_lokasi text)
returns boolean
language sql stable security definer set search_path = ''
as $$
  select case p_bucket
    when 'foto-anggota' then
         exists (select 1 from public.anggota where foto_path = p_lokasi)
      or exists (select 1 from public.profil_staf where foto_path = p_lokasi)
    when 'bukti-persembahan' then
         exists (select 1 from public.bukti_persembahan where lokasi = p_lokasi)
    when 'bahan-diskusi' then
         exists (select 1 from public.bahan_diskusi where lokasi = p_lokasi)
    else true  -- folder tidak dikenal: jangan dihapus
  end;
$$;

-- 1. (server) Mengambil berkas yang siap dihapus, paling banyak p_batas.
--    Baris untuk berkas yang masih dipakai langsung dikeluarkan dari antrean.
create function public.layanan_ambil_antrean_berkas(p_batas integer default 500)
returns table (id bigint, bucket text, lokasi text)
language plpgsql security definer set search_path = ''
as $$
begin
  delete from internal.antrean_hapus_foto a
   where internal.berkas_masih_dipakai(a.bucket, a.foto_path);

  return query
    select a.id, a.bucket, a.foto_path
    from internal.antrean_hapus_foto a
    order by a.id
    limit greatest(1, least(coalesce(p_batas, 500), 1000));
end;
$$;

-- 2. (server) Menandai berkas sudah dihapus dari penyimpanan.
create function public.layanan_selesai_antrean_berkas(p_id bigint[])
returns integer
language plpgsql security definer set search_path = ''
as $$
declare
  n integer;
begin
  delete from internal.antrean_hapus_foto where id = any (coalesce(p_id, '{}'));
  get diagnostics n = row_count;
  if n > 0 then
    perform internal.catat_log('hapus_berkas_antrean', jsonb_build_object('jumlah', n));
  end if;
  return n;
end;
$$;

-- 3. Jumlah berkas yang menunggu dihapus (untuk halaman Admin).
create function public.jumlah_antrean_berkas()
returns integer
language plpgsql stable security definer set search_path = ''
as $$
begin
  if not bantu.saya_admin() then
    raise exception 'Hanya Admin.' using errcode = '42501';
  end if;
  return (select count(*)::integer from internal.antrean_hapus_foto);
end;
$$;

revoke all on function public.layanan_ambil_antrean_berkas(integer)   from public, anon, authenticated;
revoke all on function public.layanan_selesai_antrean_berkas(bigint[]) from public, anon, authenticated;
revoke all on function public.jumlah_antrean_berkas()                  from public, anon;
grant execute on function public.layanan_ambil_antrean_berkas(integer)   to service_role;
grant execute on function public.layanan_selesai_antrean_berkas(bigint[]) to service_role;
grant execute on function public.jumlah_antrean_berkas()                  to authenticated;

revoke all on all functions in schema internal from public, anon, authenticated;
