-- =====================================================================
-- 13 · RINGKASAN TIM UNTUK DASHBOARD KETUA TIM (Fase 6, keputusan 20)
--   Satu baris per kelompok di tim:
--   * anggota aktif;
--   * status lapor PEKAN INI (Senin–Minggu WIB):
--       'sudah'       = ada pertemuan pekan ini yang absensinya DITUTUP,
--       'berlangsung' = ada pertemuan pekan ini tapi absensinya belum ditutup,
--       'belum'       = belum ada pertemuan pekan ini;
--   * tanggal pertemuan terakhir;
--   * rata-rata kehadiran 4 pekan (28 hari terakhir, pertemuan yang ditutup),
--     dalam persen: jumlah hadir / jumlah tercatat;
--   * total persembahan BULAN INI (bulan kalender WIB);
--   * jumlah anggota yang perlu ditindaklanjuti (fungsi tindak_lanjut).
--   Hanya untuk Ketua Tim dari tim itu dan Admin.
-- =====================================================================

create function public.ringkasan_tim(p_tim uuid)
returns table (
  kelompok_id         uuid,
  nama                text,
  anggota_aktif       integer,
  status_lapor        text,
  pertemuan_terakhir  date,
  hadir_4_pekan       numeric,
  persembahan_bulan_ini numeric,
  tindak_lanjut       integer
)
language plpgsql stable security definer set search_path = ''
as $$
#variable_conflict use_column
declare
  v_hari_ini   date := bantu.hari_ini_wib();
  v_senin      date := date_trunc('week', bantu.hari_ini_wib())::date;   -- minggu dimulai Senin
  v_awal_bulan date := date_trunc('month', bantu.hari_ini_wib())::date;
begin
  if p_tim is null or not (bantu.saya_admin() or p_tim in (select bantu.tim_diketuai())) then
    raise exception 'Anda tidak berhak melihat ringkasan tim ini.' using errcode = '42501';
  end if;

  return query
  select
    k.id,
    k.nama,
    (select count(*)::integer from public.anggota a where a.kelompok_id = k.id and a.aktif),
    case
      when exists (select 1 from public.pertemuan p
                   where p.kelompok_id = k.id and p.tanggal between v_senin and v_senin + 6
                     and p.ditutup_pada is not null) then 'sudah'
      when exists (select 1 from public.pertemuan p
                   where p.kelompok_id = k.id and p.tanggal between v_senin and v_senin + 6) then 'berlangsung'
      else 'belum'
    end,
    (select max(p.tanggal) from public.pertemuan p where p.kelompok_id = k.id),
    (select round(100.0 * count(*) filter (where h.hadir) / nullif(count(*), 0), 0)
       from public.kehadiran h
       join public.pertemuan p on p.id = h.pertemuan_id
      where p.kelompok_id = k.id and p.ditutup_pada is not null
        and p.tanggal > v_hari_ini - 28),
    (select coalesce(sum(p.persembahan), 0) from public.pertemuan p
      where p.kelompok_id = k.id and p.tanggal >= v_awal_bulan and p.tanggal <= v_hari_ini),
    (select count(distinct t.anggota_id)::integer from public.tindak_lanjut(k.id) t)
  from public.kelompok k
  where k.tim_id = p_tim
  order by k.nama;
end;
$$;

revoke all on function public.ringkasan_tim(uuid) from public, anon;
grant execute on function public.ringkasan_tim(uuid) to authenticated;
