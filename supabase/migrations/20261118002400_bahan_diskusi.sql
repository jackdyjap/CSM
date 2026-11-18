-- =====================================================================
-- 24 · BAHAN DISKUSI (PDF) UNTUK PENGURUS (keputusan 39)
--
-- * Hanya Admin yang mengunggah, mengubah, dan menghapus.
-- * Dibuka dan diunduh oleh Ketua Tim serta Pemimpin/Wakil kelompok:
--     tim_id kosong  = untuk semua tim (semua pengurus)
--     tim_id terisi  = hanya pengurus di tim itu
-- * Anggota biasa tidak punya akses (tabel maupun berkas).
-- * Berkas PDF maksimal 10 MB di folder privat bahan-diskusi/<id bahan>/.
-- =====================================================================

-- 1. Folder penyimpanan privat
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('bahan-diskusi', 'bahan-diskusi', false, 10485760, array['application/pdf'])
on conflict (id) do update
  set public = false,
      file_size_limit = excluded.file_size_limit,
      allowed_mime_types = excluded.allowed_mime_types;


-- 2. Tabel bahan diskusi
create table public.bahan_diskusi (
  id            uuid primary key default gen_random_uuid(),
  judul         text not null check (length(trim(judul)) between 1 and 150),
  keterangan    text check (keterangan is null or length(keterangan) <= 1000),
  tanggal_pakai date,
  tim_id        uuid references public.tim(id) on delete cascade,  -- kosong = semua tim
  lokasi        text not null unique,
  nama_berkas   text not null check (length(trim(nama_berkas)) > 0),
  ukuran        integer not null check (ukuran > 0 and ukuran <= 10485760),
  diunggah_oleh uuid references public.akun(id) on delete set null default auth.uid(),
  dibuat_pada   timestamptz not null default now(),
  constraint bahan_di_foldernya check (lokasi like id::text || '/%')
);
create index on public.bahan_diskusi (tim_id);
comment on table public.bahan_diskusi is
  'Bahan diskusi PDF dari Admin untuk Ketua Tim dan Pemimpin/Wakil (berkas di folder privat bahan-diskusi).';

-- Bolehkah saya membuka bahan untuk tim ini? (kosong = semua tim)
create function bantu.boleh_baca_bahan(p_tim uuid)
returns boolean
language sql stable security definer set search_path = ''
as $$
  select bantu.saya_admin()
      or (p_tim is null and exists (select 1 from public.penugasan_peran p
                                    where p.akun_id = auth.uid() and p.peran in ('ketua_tim', 'pemimpin')))
      or p_tim in (select bantu.tim_diketuai())
      or p_tim in (select k.tim_id from public.kelompok k
                   where k.id in (select bantu.kelompok_dipimpin_langsung()));
$$;

-- Untuk aturan berkas: lokasi berkas -> boleh dibaca?
create function bantu.boleh_baca_berkas_bahan(p_lokasi text)
returns boolean
language sql stable security definer set search_path = ''
as $$
  select exists (select 1 from public.bahan_diskusi b
                 where b.lokasi = p_lokasi and bantu.boleh_baca_bahan(b.tim_id));
$$;

revoke all on function bantu.boleh_baca_bahan(uuid)        from public, anon;
revoke all on function bantu.boleh_baca_berkas_bahan(text) from public, anon;
grant execute on function bantu.boleh_baca_bahan(uuid)        to authenticated;
grant execute on function bantu.boleh_baca_berkas_bahan(text) to authenticated;

alter table public.bahan_diskusi enable row level security;
revoke all on public.bahan_diskusi from anon;
grant select, insert, update, delete on public.bahan_diskusi to authenticated;

create policy "bahan: baca pengurus sesuai tim" on public.bahan_diskusi
  for select to authenticated
  using ((select bantu.boleh_baca_bahan(tim_id)));
create policy "bahan: admin menambah" on public.bahan_diskusi
  for insert to authenticated
  with check ((select bantu.saya_admin()));
create policy "bahan: admin mengubah" on public.bahan_diskusi
  for update to authenticated
  using ((select bantu.saya_admin())) with check ((select bantu.saya_admin()));
create policy "bahan: admin menghapus" on public.bahan_diskusi
  for delete to authenticated
  using ((select bantu.saya_admin()));

-- Pengunggah dan lokasi berkas tidak bisa dipalsukan / dipindah.
create function internal.jaga_bahan_diskusi()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  if tg_op = 'INSERT' then
    new.diunggah_oleh := coalesce(auth.uid(), new.diunggah_oleh);
    perform internal.catat_log('unggah_bahan_diskusi', jsonb_build_object('bahan_id', new.id, 'tim_id', new.tim_id));
  else
    new.lokasi := old.lokasi;
    new.nama_berkas := old.nama_berkas;
    new.ukuran := old.ukuran;
    new.diunggah_oleh := old.diunggah_oleh;
  end if;
  return new;
end;
$$;
create trigger jaga_bahan_diskusi before insert or update on public.bahan_diskusi
  for each row execute function internal.jaga_bahan_diskusi();

-- Bahan dihapus (atau ikut terhapus bersama timnya): berkasnya masuk antrean hapus.
create function internal.setelah_bahan_dihapus()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  insert into internal.antrean_hapus_foto (foto_path, bucket) values (old.lokasi, 'bahan-diskusi');
  perform internal.catat_log('hapus_bahan_diskusi', jsonb_build_object('bahan_id', old.id));
  return old;
end;
$$;
create trigger setelah_bahan_dihapus after delete on public.bahan_diskusi
  for each row execute function internal.setelah_bahan_dihapus();


-- 3. Aturan berkas di folder bahan-diskusi
create policy "bahan diskusi: lihat" on storage.objects
  for select to authenticated
  using (bucket_id = 'bahan-diskusi'
         and ((select bantu.saya_admin()) or (select bantu.boleh_baca_berkas_bahan(name))));
create policy "bahan diskusi: admin unggah" on storage.objects
  for insert to authenticated
  with check (bucket_id = 'bahan-diskusi' and (select bantu.saya_admin()));
create policy "bahan diskusi: admin hapus" on storage.objects
  for delete to authenticated
  using (bucket_id = 'bahan-diskusi' and (select bantu.saya_admin()));

revoke all on all functions in schema internal from public, anon, authenticated;
