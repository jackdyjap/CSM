-- =====================================================================
-- 14 · QR KARTU ANGGOTA (Fase 7, keputusan 22)
--   1. buat_ulang_kode_kartu(): kartu hilang -> kode baru; kartu lama
--      otomatis tidak berlaku. Pemimpin/wakil kelompoknya dan Admin.
--   2. scan_kartu_anggota(): kini menolak pertemuan yang absensinya sudah
--      ditutup (isi lainnya sama dengan file 04).
-- =====================================================================

create function public.buat_ulang_kode_kartu(p_anggota uuid)
returns void
language plpgsql security definer set search_path = ''
as $$
begin
  if not bantu.boleh_kelola_anggota(p_anggota) then
    raise exception 'Anda tidak berhak membuat ulang kartu anggota ini.' using errcode = '42501';
  end if;

  update public.anggota
     set kode_qr = replace(gen_random_uuid()::text, '-', '')
   where id = p_anggota;

  perform internal.catat_log('buat_ulang_kode_kartu', jsonb_build_object('anggota_id', p_anggota));
end;
$$;

revoke all on function public.buat_ulang_kode_kartu(uuid) from public, anon;
grant execute on function public.buat_ulang_kode_kartu(uuid) to authenticated;


create or replace function public.scan_kartu_anggota(p_pertemuan uuid, p_kode_kartu text)
returns table (anggota_id uuid, nama_lengkap text, sudah_tercatat boolean)
language plpgsql security definer set search_path = ''
as $$
#variable_conflict use_column
declare
  v_kelompok uuid;
  v_ditutup  timestamptz;
  v_anggota  uuid;
  v_nama     text;
  v_sudah    boolean;
begin
  select p.kelompok_id, p.ditutup_pada into v_kelompok, v_ditutup
  from public.pertemuan p
  where p.id = p_pertemuan and p.kelompok_id in (select bantu.kelompok_dipimpin());

  if v_kelompok is null then
    raise exception 'Pertemuan tidak ditemukan atau bukan kelompok Anda.' using errcode = '42501';
  end if;
  if v_ditutup is not null then
    raise exception 'Absensi pertemuan ini sudah ditutup. Buka kembali untuk men-scan kartu.' using errcode = '22023';
  end if;

  select a.id, a.nama_lengkap into v_anggota, v_nama
  from public.anggota a
  where a.kode_qr = lower(trim(p_kode_kartu)) and a.kelompok_id = v_kelompok;

  if v_anggota is null then
    raise exception 'Kartu tidak dikenal atau bukan anggota kelompok ini.' using errcode = '22023';
  end if;

  select coalesce(bool_or(k.hadir), false) into v_sudah
  from public.kehadiran k where k.pertemuan_id = p_pertemuan and k.anggota_id = v_anggota;

  if not v_sudah then
    insert into public.kehadiran (pertemuan_id, anggota_id, hadir, waktu, cara, dicatat_oleh)
    values (p_pertemuan, v_anggota, true, now(), 'scan_pemimpin', auth.uid())
    on conflict on constraint kehadiran_unik do update
      set hadir = true, waktu = now(), cara = 'scan_pemimpin',
          alasan = null, alasan_catatan = null, dicatat_oleh = auth.uid();
  end if;

  return query select v_anggota, v_nama, v_sudah;
end;
$$;
