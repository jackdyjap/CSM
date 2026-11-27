-- =====================================================================
-- 29 · SAAT TEDUH (keputusan 58)
--
-- * Setiap akun mencatat saat teduhnya sendiri: tanggal (hari ini atau
--   lampau, tidak boleh tanggal yang akan datang), jam mulai, durasi
--   (menit), bacaan Alkitab (versi TB/AMD, kitab 1-66, pasal, ayat
--   dari-sampai yang boleh kosong), dan tuntunan (tidak wajib).
-- * Hanya PEMILIK yang menambah, mengubah, dan menghapus.
-- * Pemimpin/Wakil kelompok, Ketua Tim, dan Admin hanya MEMBACA catatan
--   anggota di kelompok yang boleh mereka lihat (bantu.kelompok_terbaca).
--   Admin membaca semua catatan, termasuk pengurus yang bukan anggota.
-- * Teks ayat TIDAK disimpan (hak cipta LAI/SABDA); hanya letaknya.
-- =====================================================================

create table public.saat_teduh (
  id            uuid primary key default gen_random_uuid(),
  akun_id       uuid not null default auth.uid() references public.akun(id) on delete cascade,
  tanggal       date not null default bantu.hari_ini_wib()
                check (tanggal >= date '2000-01-01'),
  jam_mulai     time not null,
  durasi_menit  smallint not null check (durasi_menit between 1 and 600),
  versi         text not null check (versi in ('tb', 'amd')),
  kitab         smallint not null check (kitab between 1 and 66),
  pasal         smallint not null check (pasal between 1 and 150),
  ayat_awal     smallint check (ayat_awal between 1 and 176),
  ayat_akhir    smallint check (ayat_akhir between 1 and 176),
  tuntunan      text check (tuntunan is null or length(tuntunan) <= 2000),
  dibuat_pada   timestamptz not null default now(),
  diubah_pada   timestamptz not null default now(),

  constraint saat_teduh_ayat_urut check (
       (ayat_awal is null and ayat_akhir is null)
    or (ayat_awal is not null and ayat_akhir is not null and ayat_akhir >= ayat_awal)
  )
);
comment on table public.saat_teduh is
  'Catatan saat teduh per akun. Diubah hanya oleh pemiliknya; dibaca pengurus kelompoknya dan Admin (keputusan 58).';

create index saat_teduh_akun_tanggal on public.saat_teduh (akun_id, tanggal desc, jam_mulai desc);

create trigger isi_diubah_pada before update on public.saat_teduh
  for each row execute function internal.isi_diubah_pada();

-- Pemilik tidak bisa dipalsukan/dipindah; tanggal tidak boleh di masa depan (WIB).
create function internal.jaga_saat_teduh()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  if tg_op = 'INSERT' then
    new.akun_id := coalesce(auth.uid(), new.akun_id);
  else
    new.akun_id := old.akun_id;
  end if;
  if new.tanggal > bantu.hari_ini_wib() then
    raise exception 'Tanggal saat teduh tidak boleh tanggal yang akan datang.' using errcode = '23514';
  end if;
  return new;
end;
$$;
create trigger jaga_saat_teduh before insert or update on public.saat_teduh
  for each row execute function internal.jaga_saat_teduh();

-- Bolehkah saya MEMBACA catatan saat teduh milik akun ini?
create function bantu.boleh_baca_saat_teduh(p_akun uuid)
returns boolean
language sql stable security definer set search_path = ''
as $$
  select auth.uid() is not null and (
       p_akun = auth.uid()
    or bantu.saya_admin()
    or exists (select 1
               from public.akun k
               join public.anggota a on a.id = k.anggota_id
               where k.id = p_akun
                 and a.kelompok_id in (select bantu.kelompok_terbaca()))
  );
$$;
revoke all on function bantu.boleh_baca_saat_teduh(uuid) from public, anon;
grant execute on function bantu.boleh_baca_saat_teduh(uuid) to authenticated;

alter table public.saat_teduh enable row level security;
revoke all on public.saat_teduh from anon;
grant select, insert, update, delete on public.saat_teduh to authenticated;

create policy "saat teduh: baca pemilik, pengurus, admin" on public.saat_teduh
  for select to authenticated
  using (bantu.boleh_baca_saat_teduh(akun_id));
create policy "saat teduh: pemilik menambah" on public.saat_teduh
  for insert to authenticated
  with check (akun_id = (select auth.uid()));
create policy "saat teduh: pemilik mengubah" on public.saat_teduh
  for update to authenticated
  using (akun_id = (select auth.uid())) with check (akun_id = (select auth.uid()));
create policy "saat teduh: pemilik menghapus" on public.saat_teduh
  for delete to authenticated
  using (akun_id = (select auth.uid()));

-- Catatan saat teduh seorang ANGGOTA, untuk profil anggota yang dibuka pengurus.
-- Pengurus tidak bisa membaca tabel akun, jadi akun anggota dicari lewat fungsi
-- ini; aturan baca saat_teduh di atas tetap berlaku (security invoker).
create function bantu.akun_dari_anggota(p_anggota uuid)
returns uuid
language sql stable security definer set search_path = ''
as $$
  select k.id from public.akun k
  where k.anggota_id = p_anggota and bantu.boleh_baca_anggota(p_anggota);
$$;
create function public.saat_teduh_anggota(p_anggota uuid, p_batas integer default 100)
returns setof public.saat_teduh
language sql stable security invoker set search_path = ''
as $$
  select s.*
  from public.saat_teduh s
  where s.akun_id = (select bantu.akun_dari_anggota(p_anggota))
  order by s.tanggal desc, s.jam_mulai desc
  limit least(greatest(coalesce(p_batas, 100), 1), 500);
$$;

revoke all on function bantu.akun_dari_anggota(uuid) from public, anon;
grant execute on function bantu.akun_dari_anggota(uuid) to authenticated;
revoke all on function public.saat_teduh_anggota(uuid, integer) from public, anon;
grant execute on function public.saat_teduh_anggota(uuid, integer) to authenticated;

revoke all on all functions in schema internal from public, anon, authenticated;
