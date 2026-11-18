-- =====================================================================
-- 23 · LAPORAN PELAKSANAAN PROYEK KETAATAN UNTUK ADMIN (keputusan 38)
--
-- Satu baris per (proyek × anggota) dalam cakupan: semua tim, satu tim,
-- atau satu kelompok. Anggota yang dihitung: anggota aktif, ditambah
-- anggota tidak aktif yang sudah punya status di proyek itu (sama seperti
-- halaman proyek). Aplikasi menyusun ringkasan dan tabelnya.
--   dilaporkan = false -> "Belum dilaporkan" (belum ada status sama sekali)
-- Khusus Admin; setiap pembuatan tercatat di log.
-- =====================================================================
create function public.laporan_proyek(p_cakupan text default 'semua', p_cakupan_id uuid default null)
returns table (
  tim_nama text, kelompok_id uuid, kelompok_nama text,
  proyek_id uuid, judul text, diberikan_pada date, tenggat date,
  anggota_id uuid, anggota_nama text, anggota_aktif boolean,
  status public.status_pengerjaan, dilaporkan boolean,
  alasan text, hasil text, keterangan text, dilaporkan_sendiri boolean, diubah_pada timestamptz)
language plpgsql security definer set search_path = ''
as $$
begin
  if not bantu.saya_admin() then
    raise exception 'Laporan proyek ketaatan hanya dapat dibuka oleh Admin.' using errcode = '42501';
  end if;
  if p_cakupan not in ('semua', 'tim', 'kelompok') or (p_cakupan <> 'semua' and p_cakupan_id is null) then
    raise exception 'Cakupan laporan tidak valid.' using errcode = '22023';
  end if;

  perform internal.catat_log('buat_laporan_proyek',
    jsonb_build_object('cakupan', p_cakupan, 'cakupan_id', p_cakupan_id));

  return query
    select t.nama, k.id, k.nama,
           p.id, p.judul, p.diberikan_pada, p.tenggat,
           a.id, a.nama_lengkap, a.aktif,
           coalesce(s.status, 'belum'), s.proyek_id is not null,
           s.alasan, s.hasil, s.keterangan, coalesce(s.dilaporkan_sendiri, false), s.diubah_pada
    from public.proyek_ketaatan p
    join public.kelompok k on k.id = p.kelompok_id
    join public.tim t      on t.id = k.tim_id
    join public.anggota a  on a.kelompok_id = k.id
    left join public.status_proyek s on s.proyek_id = p.id and s.anggota_id = a.id
    where (a.aktif or s.proyek_id is not null)
      and (p_cakupan = 'semua'
           or (p_cakupan = 'tim'      and k.tim_id = p_cakupan_id)
           or (p_cakupan = 'kelompok' and k.id     = p_cakupan_id))
    order by t.nama, k.nama, p.diberikan_pada desc, p.judul, a.nama_lengkap;
end;
$$;

revoke all on function public.laporan_proyek(text, uuid) from public, anon;
grant execute on function public.laporan_proyek(text, uuid) to authenticated;
