-- =====================================================================
-- 10 · BUKTI TRANSFER PERSEMBAHAN (keputusan 16, 17 November 2026)
--   * Opsional; boleh diunggah menyusul.
--   * Foto (jpeg/png/webp) atau PDF, maksimal 5 MB per berkas,
--     maksimal 5 berkas per pertemuan.
--   * Dilihat oleh pemimpin/wakil, Ketua Tim terkait, dan Admin.
--     Diunggah/dihapus oleh pemimpin/wakil dan Admin. Anggota tidak melihat.
--   * Lokasi berkas: bukti-persembahan/<id pertemuan>/<nama berkas>
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1. Antrean hapus berkas kini mencatat foldernya (bucket), karena tidak
--    hanya berisi foto anggota lagi.
-- ---------------------------------------------------------------------
alter table internal.antrean_hapus_foto
  add column bucket text not null default 'foto-anggota';


-- ---------------------------------------------------------------------
-- 2. Folder penyimpanan privat
-- ---------------------------------------------------------------------
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('bukti-persembahan', 'bukti-persembahan', false, 5242880,
        array['image/jpeg', 'image/png', 'image/webp', 'application/pdf'])
on conflict (id) do update
  set public = false,
      file_size_limit = excluded.file_size_limit,
      allowed_mime_types = excluded.allowed_mime_types;


-- ---------------------------------------------------------------------
-- 3. Daftar bukti per pertemuan
-- ---------------------------------------------------------------------
create table public.bukti_persembahan (
  id            uuid primary key default gen_random_uuid(),
  pertemuan_id  uuid not null references public.pertemuan(id) on delete cascade,
  kelompok_id   uuid not null references public.kelompok(id),  -- diisi otomatis dari pertemuan
  lokasi        text not null unique,
  nama_berkas   text not null check (length(trim(nama_berkas)) > 0),
  jenis         text not null check (jenis in ('image/jpeg', 'image/png', 'image/webp', 'application/pdf')),
  ukuran        integer not null check (ukuran > 0 and ukuran <= 5242880),
  diunggah_oleh uuid references public.akun(id) on delete set null default auth.uid(),
  dibuat_pada   timestamptz not null default now(),
  constraint bukti_di_folder_pertemuan check (lokasi like pertemuan_id::text || '/%')
);
create index on public.bukti_persembahan (pertemuan_id);
create index on public.bukti_persembahan (kelompok_id);
comment on table public.bukti_persembahan is 'Bukti transfer persembahan (berkas di folder privat bukti-persembahan).';

alter table public.bukti_persembahan enable row level security;
revoke all on public.bukti_persembahan from anon;
revoke update on public.bukti_persembahan from authenticated;
grant select, insert, delete on public.bukti_persembahan to authenticated;

create policy "bukti: baca sesuai peran" on public.bukti_persembahan
  for select to authenticated
  using (kelompok_id in (select bantu.kelompok_terbaca()));
create policy "bukti: pemimpin/admin menambah" on public.bukti_persembahan
  for insert to authenticated
  with check (kelompok_id in (select bantu.kelompok_dipimpin()));
create policy "bukti: pemimpin/admin menghapus" on public.bukti_persembahan
  for delete to authenticated
  using (kelompok_id in (select bantu.kelompok_dipimpin()));


-- ---------------------------------------------------------------------
-- 4. Penjaga: kelompok diisi dari pertemuan, berkasnya harus benar-benar
--    sudah diunggah, dan paling banyak 5 bukti per pertemuan.
-- ---------------------------------------------------------------------
create function internal.jaga_bukti_persembahan()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  select p.kelompok_id into new.kelompok_id
  from public.pertemuan p where p.id = new.pertemuan_id;

  if not exists (select 1 from storage.objects o
                 where o.bucket_id = 'bukti-persembahan' and o.name = new.lokasi) then
    raise exception 'Berkas bukti belum terunggah. Coba unggah ulang.' using errcode = '23514';
  end if;

  perform 1 from public.pertemuan p where p.id = new.pertemuan_id for update;
  if (select count(*) from public.bukti_persembahan b where b.pertemuan_id = new.pertemuan_id) >= 5 then
    raise exception 'Maksimal 5 bukti per pertemuan. Hapus yang tidak perlu terlebih dahulu.'
      using errcode = '23514';
  end if;
  return new;
end;
$$;

create trigger jaga_bukti_persembahan before insert on public.bukti_persembahan
  for each row execute function internal.jaga_bukti_persembahan();

-- Saat bukti dihapus (termasuk ikut terhapus bersama pertemuan/kelompok),
-- berkasnya masuk antrean hapus.
create function internal.setelah_bukti_dihapus()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  insert into internal.antrean_hapus_foto (foto_path, bucket) values (old.lokasi, 'bukti-persembahan');
  return old;
end;
$$;

create trigger setelah_bukti_dihapus after delete on public.bukti_persembahan
  for each row execute function internal.setelah_bukti_dihapus();

revoke all on function internal.jaga_bukti_persembahan() from public, anon, authenticated;
revoke all on function internal.setelah_bukti_dihapus()  from public, anon, authenticated;


-- ---------------------------------------------------------------------
-- 5. Aturan akses berkas di folder bukti-persembahan.
--    Folder pertama pada lokasi berkas = id pertemuan.
-- ---------------------------------------------------------------------
create function bantu.kelompok_pertemuan(p_pertemuan uuid)
returns uuid
language sql stable security definer
set search_path = ''
as $$
  select kelompok_id from public.pertemuan where id = p_pertemuan;
$$;
revoke all on function bantu.kelompok_pertemuan(uuid) from public, anon;
grant execute on function bantu.kelompok_pertemuan(uuid) to authenticated;

create policy "bukti persembahan: lihat" on storage.objects
  for select to authenticated
  using (bucket_id = 'bukti-persembahan'
         and bantu.kelompok_pertemuan(bantu.teks_ke_uuid((storage.foldername(name))[1]))
             in (select bantu.kelompok_terbaca()));

create policy "bukti persembahan: unggah" on storage.objects
  for insert to authenticated
  with check (bucket_id = 'bukti-persembahan'
              and bantu.kelompok_pertemuan(bantu.teks_ke_uuid((storage.foldername(name))[1]))
                  in (select bantu.kelompok_dipimpin()));

create policy "bukti persembahan: hapus" on storage.objects
  for delete to authenticated
  using (bucket_id = 'bukti-persembahan'
         and bantu.kelompok_pertemuan(bantu.teks_ke_uuid((storage.foldername(name))[1]))
             in (select bantu.kelompok_dipimpin()));
