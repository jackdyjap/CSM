-- =====================================================================
-- 07 · MODE PERTEMUAN (Fase 4)
--   1. Tanggal pertemuan tidak boleh di masa depan (hari ini atau yang lalu).
--   2. Loket tutup_pertemuan(): menutup absensi dan menandai TIDAK HADIR
--      anggota aktif yang belum ditandai hadir.
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1. Penjaga tanggal pertemuan
-- ---------------------------------------------------------------------
create function internal.jaga_tanggal_pertemuan()
returns trigger language plpgsql set search_path = ''
as $$
begin
  if new.tanggal > bantu.hari_ini_wib() then
    raise exception 'Tanggal pertemuan tidak boleh di masa depan.' using errcode = '23514';
  end if;
  return new;
end;
$$;

create trigger jaga_tanggal_pertemuan before insert or update of tanggal on public.pertemuan
  for each row execute function internal.jaga_tanggal_pertemuan();


-- ---------------------------------------------------------------------
-- 2. Menutup absensi
--   * Hanya pemimpin/wakil kelompok pertemuan tersebut.
--   * Anggota yang ditandai tidak hadir: masih aktif, sudah bergabung pada
--     tanggal pertemuan, dan belum punya catatan kehadiran di pertemuan itu.
--     Anggota yang sudah tidak aktif tidak ikut ditandai.
--   * Aman dipanggil berulang (setelah dibuka kembali): tidak ada data ganda.
--   Mengembalikan jumlah anggota yang ditandai tidak hadir.
-- ---------------------------------------------------------------------
create function public.tutup_pertemuan(p_pertemuan uuid)
returns integer
language plpgsql security definer set search_path = ''
as $$
declare
  v_kelompok uuid;
  v_tanggal  date;
  v_jumlah   integer;
begin
  select p.kelompok_id, p.tanggal into v_kelompok, v_tanggal
  from public.pertemuan p
  where p.id = p_pertemuan and p.kelompok_id in (select bantu.kelompok_dipimpin());

  if v_kelompok is null then
    raise exception 'Pertemuan tidak ditemukan atau bukan kelompok Anda.' using errcode = '42501';
  end if;

  insert into public.kehadiran (pertemuan_id, anggota_id, hadir, dicatat_oleh)
  select p_pertemuan, a.id, false, auth.uid()
  from public.anggota a
  where a.kelompok_id = v_kelompok
    and a.aktif
    and a.bergabung_pada <= v_tanggal
    and not exists (select 1 from public.kehadiran h
                    where h.pertemuan_id = p_pertemuan and h.anggota_id = a.id)
  on conflict on constraint kehadiran_unik do nothing;
  get diagnostics v_jumlah = row_count;

  update public.pertemuan
     set dibuka_pada  = coalesce(dibuka_pada, now()),
         ditutup_pada = now()
   where id = p_pertemuan;

  return v_jumlah;
end;
$$;

revoke all on function public.tutup_pertemuan(uuid) from public, anon;
grant execute on function public.tutup_pertemuan(uuid) to authenticated;
