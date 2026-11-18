-- =====================================================================
-- 22 · ANGGOTA MELAPORKAN SENDIRI PROYEK KETAATANNYA (keputusan 36)
--
-- * Setiap anggota (termasuk pemimpin yang terdaftar sebagai anggota)
--   melaporkan proyek kelompoknya:
--     belum   = Belum dijalankan  + ALASAN (wajib)
--     sedang  = Sedang dijalankan
--     selesai = Sudah selesai     + HASIL yang didapat (wajib)
-- * Anggota hanya membaca proyek kelompoknya dan status MILIKNYA sendiri
--   (lewat loket; tabel tetap tidak bisa dibaca anggota).
-- * Pemimpin/Wakil dan Admin tetap boleh mengubah status (termasuk
--   "Tidak dikerjakan"). Tercatat siapa yang terakhir mengubah dan
--   apakah dilaporkan sendiri.
-- =====================================================================

alter table public.status_proyek
  add column alasan             text check (alasan is null or length(alasan) <= 1000),
  add column hasil              text check (hasil  is null or length(hasil)  <= 2000),
  add column dilaporkan_sendiri boolean not null default false,
  add column diubah_oleh        uuid references public.akun(id) on delete set null;

comment on column public.status_proyek.alasan is 'Alasan belum dijalankan (dilaporkan anggota).';
comment on column public.status_proyek.hasil  is 'Hasil yang didapat setelah selesai (dilaporkan anggota).';
comment on column public.status_proyek.dilaporkan_sendiri is 'true = perubahan status terakhir dilakukan anggota itu sendiri.';

-- Siapa yang terakhir mengubah; alasan/hasil hanya disimpan untuk status yang cocok.
create function internal.catat_pelapor_proyek()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  if new.status <> 'belum'   then new.alasan := null; end if;
  if new.status <> 'selesai' then new.hasil  := null; end if;

  if tg_op = 'INSERT'
     or new.status is distinct from old.status
     or new.alasan is distinct from old.alasan
     or new.hasil  is distinct from old.hasil then
    new.diubah_oleh := coalesce(auth.uid(), new.diubah_oleh);
    new.dilaporkan_sendiri := auth.uid() is not null and exists (
      select 1 from public.akun ak where ak.id = auth.uid() and ak.anggota_id = new.anggota_id);
  end if;
  return new;
end;
$$;

create trigger catat_pelapor_proyek before insert or update on public.status_proyek
  for each row execute function internal.catat_pelapor_proyek();


-- ---------------------------------------------------------------------
-- 1. Proyek kelompok saya beserta status MILIK SAYA
-- ---------------------------------------------------------------------
create function public.proyek_saya()
returns table (
  proyek_id uuid, judul text, keterangan text, diberikan_pada date, tenggat date,
  status public.status_pengerjaan, alasan text, hasil text,
  dilaporkan_sendiri boolean, diubah_pada timestamptz)
language sql stable security definer set search_path = ''
as $$
  select p.id, p.judul, p.keterangan, p.diberikan_pada, p.tenggat,
         coalesce(s.status, 'belum'), s.alasan, s.hasil,
         coalesce(s.dilaporkan_sendiri, false), s.diubah_pada
  from public.anggota a
  join public.proyek_ketaatan p on p.kelompok_id = a.kelompok_id
  left join public.status_proyek s on s.proyek_id = p.id and s.anggota_id = a.id
  where a.id = bantu.anggota_saya()
  order by p.diberikan_pada desc, p.judul;
$$;


-- ---------------------------------------------------------------------
-- 2. Melaporkan proyek sendiri
-- ---------------------------------------------------------------------
create function public.lapor_proyek_saya(
  p_proyek uuid, p_status public.status_pengerjaan, p_alasan text default null, p_hasil text default null)
returns void
language plpgsql security definer set search_path = ''
as $$
declare
  v_anggota uuid := bantu.anggota_saya();
  v_alasan  text := nullif(trim(coalesce(p_alasan, '')), '');
  v_hasil   text := nullif(trim(coalesce(p_hasil, '')), '');
begin
  if v_anggota is null then
    raise exception 'Hanya anggota kelompok yang bisa melaporkan proyek ketaatan.' using errcode = '42501';
  end if;
  if not exists (select 1 from public.proyek_ketaatan p join public.anggota a on a.kelompok_id = p.kelompok_id
                 where p.id = p_proyek and a.id = v_anggota) then
    raise exception 'Proyek ini bukan proyek kelompok Anda.' using errcode = '42501';
  end if;
  if p_status is null or p_status not in ('belum', 'sedang', 'selesai') then
    raise exception 'Pilih: belum dijalankan, sedang dijalankan, atau sudah selesai.' using errcode = '22023';
  end if;
  if p_status = 'belum' and v_alasan is null then
    raise exception 'Tuliskan alasan belum menjalankan proyek ini.' using errcode = '22023';
  end if;
  if p_status = 'selesai' and v_hasil is null then
    raise exception 'Tuliskan hasil yang didapat dari menjalankan proyek ini.' using errcode = '22023';
  end if;
  if length(coalesce(v_alasan, '')) > 1000 or length(coalesce(v_hasil, '')) > 2000 then
    raise exception 'Alasan maksimal 1000 karakter dan hasil maksimal 2000 karakter.' using errcode = '22023';
  end if;

  insert into public.status_proyek (proyek_id, anggota_id, status, alasan, hasil)
  values (p_proyek, v_anggota, p_status, v_alasan, v_hasil)
  on conflict (proyek_id, anggota_id)
  do update set status = excluded.status, alasan = excluded.alasan, hasil = excluded.hasil;

  perform internal.catat_log('lapor_proyek', jsonb_build_object('proyek_id', p_proyek, 'status', p_status));
end;
$$;

revoke all on function public.proyek_saya() from public, anon;
revoke all on function public.lapor_proyek_saya(uuid, public.status_pengerjaan, text, text) from public, anon;
grant execute on function public.proyek_saya() to authenticated;
grant execute on function public.lapor_proyek_saya(uuid, public.status_pengerjaan, text, text) to authenticated;

revoke all on all functions in schema internal from public, anon, authenticated;
