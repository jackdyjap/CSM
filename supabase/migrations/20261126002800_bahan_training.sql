-- =====================================================================
-- 28 · BAHAN TRAINING (PDF atau video YouTube) (keputusan 54)
--
-- * Hanya Admin yang menambah, mengubah, dan menghapus.
-- * Jenis: PDF (berkas privat di folder bahan-training/<id bahan>/, maks
--   10 MB) atau video YouTube (yang disimpan hanya kode videonya).
-- * Peruntukan: "semua", atau satu/lebih dari Ketua Tim, Pemimpin/Wakil
--   kelompok, Anggota (akun yang punya profil anggota). Peran ganda =
--   gabungan.
-- * Dibuka hanya di dalam aplikasi (tanpa tombol unduh); aturan akses di
--   database dan penyimpanan memastikan hanya peruntukannya yang bisa membaca.
-- =====================================================================

-- 1. Folder penyimpanan privat untuk PDF
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('bahan-training', 'bahan-training', false, 10485760, array['application/pdf'])
on conflict (id) do update
  set public = false,
      file_size_limit = excluded.file_size_limit,
      allowed_mime_types = excluded.allowed_mime_types;


-- 2. Tabel bahan training
create table public.bahan_training (
  id               uuid primary key default gen_random_uuid(),
  judul            text not null check (length(trim(judul)) between 1 and 150),
  keterangan       text check (keterangan is null or length(keterangan) <= 1000),
  jenis            text not null check (jenis in ('pdf', 'video')),
  -- PDF
  lokasi           text unique,
  nama_berkas      text,
  ukuran           integer check (ukuran is null or (ukuran > 0 and ukuran <= 10485760)),
  -- Video YouTube: kode video 11 karakter
  video_id         text check (video_id is null or video_id ~ '^[A-Za-z0-9_-]{11}$'),
  -- Peruntukan
  untuk_semua      boolean not null default false,
  untuk_ketua_tim  boolean not null default false,
  untuk_pemimpin   boolean not null default false,
  untuk_anggota    boolean not null default false,
  diunggah_oleh    uuid references public.akun(id) on delete set null default auth.uid(),
  dibuat_pada      timestamptz not null default now(),
  diubah_pada      timestamptz not null default now(),

  constraint training_isi_sesuai_jenis check (
       (jenis = 'pdf'   and lokasi is not null and nama_berkas is not null and ukuran is not null
                        and video_id is null and lokasi like id::text || '/%')
    or (jenis = 'video' and video_id is not null and lokasi is null and nama_berkas is null and ukuran is null)
  ),
  constraint training_ada_peruntukan check (
    untuk_semua or untuk_ketua_tim or untuk_pemimpin or untuk_anggota
  )
);
comment on table public.bahan_training is
  'Bahan training (PDF privat atau video YouTube) dari Admin, dengan peruntukan per peran (keputusan 54).';

create trigger isi_diubah_pada before update on public.bahan_training
  for each row execute function internal.isi_diubah_pada();

-- Bolehkah saya membuka bahan dengan peruntukan ini?
create function bantu.boleh_baca_training(p_semua boolean, p_ketua_tim boolean, p_pemimpin boolean, p_anggota boolean)
returns boolean
language sql stable security definer set search_path = ''
as $$
  select auth.uid() is not null and (
       bantu.saya_admin()
    or p_semua
    or (p_ketua_tim and exists (select 1 from public.penugasan_peran
                                where akun_id = auth.uid() and peran = 'ketua_tim'))
    or (p_pemimpin  and exists (select 1 from public.penugasan_peran
                                where akun_id = auth.uid() and peran = 'pemimpin'))
    or (p_anggota   and exists (select 1 from public.akun
                                where id = auth.uid() and anggota_id is not null))
  );
$$;

-- Untuk aturan berkas: lokasi berkas -> boleh dibaca?
create function bantu.boleh_baca_berkas_training(p_lokasi text)
returns boolean
language sql stable security definer set search_path = ''
as $$
  select exists (select 1 from public.bahan_training b
                 where b.lokasi = p_lokasi
                   and bantu.boleh_baca_training(b.untuk_semua, b.untuk_ketua_tim, b.untuk_pemimpin, b.untuk_anggota));
$$;

revoke all on function bantu.boleh_baca_training(boolean, boolean, boolean, boolean) from public, anon;
revoke all on function bantu.boleh_baca_berkas_training(text)                         from public, anon;
grant execute on function bantu.boleh_baca_training(boolean, boolean, boolean, boolean) to authenticated;
grant execute on function bantu.boleh_baca_berkas_training(text)                         to authenticated;

alter table public.bahan_training enable row level security;
revoke all on public.bahan_training from anon;
grant select, insert, update, delete on public.bahan_training to authenticated;

create policy "training: baca sesuai peruntukan" on public.bahan_training
  for select to authenticated
  using ((select bantu.boleh_baca_training(untuk_semua, untuk_ketua_tim, untuk_pemimpin, untuk_anggota)));
create policy "training: admin menambah" on public.bahan_training
  for insert to authenticated
  with check ((select bantu.saya_admin()));
create policy "training: admin mengubah" on public.bahan_training
  for update to authenticated
  using ((select bantu.saya_admin())) with check ((select bantu.saya_admin()));
create policy "training: admin menghapus" on public.bahan_training
  for delete to authenticated
  using ((select bantu.saya_admin()));

-- Pengunggah, jenis, dan isi (berkas/video) tidak bisa dipalsukan atau diganti.
create function internal.jaga_bahan_training()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  -- "Semua" berarti semua peran: pilihan per peran dikosongkan supaya rapi.
  if new.untuk_semua then
    new.untuk_ketua_tim := false;
    new.untuk_pemimpin  := false;
    new.untuk_anggota   := false;
  end if;
  if tg_op = 'INSERT' then
    new.diunggah_oleh := coalesce(auth.uid(), new.diunggah_oleh);
    perform internal.catat_log('unggah_bahan_training', jsonb_build_object('bahan_id', new.id, 'jenis', new.jenis));
  else
    new.jenis         := old.jenis;
    new.lokasi        := old.lokasi;
    new.nama_berkas   := old.nama_berkas;
    new.ukuran        := old.ukuran;
    new.video_id      := old.video_id;
    new.diunggah_oleh := old.diunggah_oleh;
  end if;
  return new;
end;
$$;
create trigger jaga_bahan_training before insert or update on public.bahan_training
  for each row execute function internal.jaga_bahan_training();

-- Bahan dihapus: berkas PDF-nya masuk antrean hapus.
create function internal.setelah_training_dihapus()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  if old.lokasi is not null then
    insert into internal.antrean_hapus_foto (foto_path, bucket) values (old.lokasi, 'bahan-training');
  end if;
  perform internal.catat_log('hapus_bahan_training', jsonb_build_object('bahan_id', old.id, 'jenis', old.jenis));
  return old;
end;
$$;
create trigger setelah_training_dihapus after delete on public.bahan_training
  for each row execute function internal.setelah_training_dihapus();


-- 3. Aturan berkas di folder bahan-training
create policy "bahan training: lihat" on storage.objects
  for select to authenticated
  using (bucket_id = 'bahan-training'
         and ((select bantu.saya_admin()) or (select bantu.boleh_baca_berkas_training(name))));
create policy "bahan training: admin unggah" on storage.objects
  for insert to authenticated
  with check (bucket_id = 'bahan-training' and (select bantu.saya_admin()));
create policy "bahan training: admin hapus" on storage.objects
  for delete to authenticated
  using (bucket_id = 'bahan-training' and (select bantu.saya_admin()));


-- 4. Penghapus berkas otomatis mengenal folder baru ini.
create or replace function internal.berkas_masih_dipakai(p_bucket text, p_lokasi text)
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
    when 'bahan-training' then
         exists (select 1 from public.bahan_training where lokasi = p_lokasi)
    else true  -- folder tidak dikenal: jangan dihapus
  end;
$$;

revoke all on all functions in schema internal from public, anon, authenticated;
