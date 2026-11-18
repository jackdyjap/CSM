-- =====================================================================
-- 17 · MASUKAN: KELUHAN, PERMASALAHAN, USULAN PERBAIKAN (keputusan 28)
--
-- * Pengirim memilih tujuan:
--     - pemimpin  : pemimpin/wakil kelompoknya (pengirim anggota kelompok itu)
--     - ketua_tim : ketua tim dari kelompoknya (anggota, atau pemimpin kelompok itu)
--     - admin     : Admin
-- * Boleh dikirim tanpa nama (anonim): penerima tidak melihat nama
--   pengirim; database tetap mencatatnya dan hanya Admin yang bisa melihat.
-- * Penerima memberi status (baru, sedang ditangani, selesai) dan balasan
--   yang dibaca pengirim. Admin membaca dan menanggapi semua masukan.
-- * Tabel tidak bisa dibaca langsung; semua lewat loket di bawah, supaya
--   pengirim masukan anonim tidak bocor.
-- =====================================================================

create type public.tujuan_masukan as enum ('pemimpin', 'ketua_tim', 'admin');
create type public.jenis_masukan  as enum ('keluhan', 'permasalahan', 'usulan');
create type public.status_masukan as enum ('baru', 'ditangani', 'selesai');

create table public.masukan (
  id           uuid primary key default gen_random_uuid(),
  pengirim_id  uuid references public.akun(id) on delete set null,
  tujuan       public.tujuan_masukan not null,
  kelompok_id  uuid references public.kelompok(id) on delete cascade,
  tim_id       uuid references public.tim(id) on delete cascade,
  jenis        public.jenis_masukan not null,
  judul        text not null check (length(trim(judul)) between 1 and 120),
  isi          text not null check (length(trim(isi)) between 1 and 2000),
  anonim       boolean not null default false,
  status       public.status_masukan not null default 'baru',
  balasan      text check (balasan is null or length(balasan) <= 2000),
  dibalas_oleh uuid references public.akun(id) on delete set null,
  dibalas_pada timestamptz,
  dibuat_pada  timestamptz not null default now(),
  diubah_pada  timestamptz not null default now(),
  constraint masukan_alamat_tujuan check (
       (tujuan = 'pemimpin'  and kelompok_id is not null)
    or (tujuan = 'ketua_tim' and tim_id is not null)
    or (tujuan = 'admin')
  )
);
create index on public.masukan (pengirim_id);
create index on public.masukan (kelompok_id);
create index on public.masukan (tim_id);
comment on table public.masukan is
  'Masukan (keluhan/permasalahan/usulan). Hanya lewat loket: kirim_masukan, masukan_saya, masukan_masuk, tanggapi_masukan.';

alter table public.masukan enable row level security;
-- Tidak ada aturan akses = tidak ada yang bisa membaca/menulis langsung.
revoke all on public.masukan from anon, authenticated;

create trigger isi_diubah_pada before update on public.masukan
  for each row execute function internal.isi_diubah_pada();


-- ---------------------------------------------------------------------
-- Bolehkah saya menanggapi masukan ini? (penerima, atau Admin)
-- ---------------------------------------------------------------------
create function internal.boleh_tanggapi_masukan(p public.masukan)
returns boolean
language sql stable security definer set search_path = ''
as $$
  select bantu.saya_admin()
      or (p.tujuan = 'pemimpin'  and p.kelompok_id in (select bantu.kelompok_dipimpin_langsung()))
      or (p.tujuan = 'ketua_tim' and p.tim_id in (select bantu.tim_diketuai()));
$$;


-- ---------------------------------------------------------------------
-- 1. Mengirim masukan
-- ---------------------------------------------------------------------
create function public.kirim_masukan(
  p_tujuan public.tujuan_masukan, p_kelompok uuid, p_jenis public.jenis_masukan,
  p_judul text, p_isi text, p_anonim boolean default false)
returns uuid
language plpgsql security definer set search_path = ''
as $$
declare
  v_saya     uuid := auth.uid();
  v_kelompok_anggota uuid := bantu.kelompok_saya_sebagai_anggota();
  v_kelompok uuid;
  v_tim      uuid;
  v_id       uuid;
begin
  if v_saya is null then
    raise exception 'Silakan masuk terlebih dahulu.' using errcode = '42501';
  end if;
  if p_tujuan is null or p_jenis is null then
    raise exception 'Pilih tujuan dan jenis masukan.' using errcode = '22023';
  end if;
  if length(trim(coalesce(p_judul, ''))) = 0 or length(trim(coalesce(p_isi, ''))) = 0 then
    raise exception 'Judul dan isi masukan wajib diisi.' using errcode = '22023';
  end if;
  if length(trim(p_judul)) > 120 or length(trim(p_isi)) > 2000 then
    raise exception 'Judul maksimal 120 karakter dan isi maksimal 2000 karakter.' using errcode = '22023';
  end if;

  if p_tujuan = 'pemimpin' then
    -- Hanya anggota kelompok itu yang bisa mengirim ke pemimpinnya.
    if p_kelompok is null or p_kelompok is distinct from v_kelompok_anggota then
      raise exception 'Masukan untuk pemimpin hanya bisa dikirim ke pemimpin kelompok Anda sendiri.'
        using errcode = '42501';
    end if;
    v_kelompok := p_kelompok;
  elsif p_tujuan = 'ketua_tim' then
    if p_kelompok is null or not (p_kelompok is not distinct from v_kelompok_anggota
                                  or p_kelompok in (select bantu.kelompok_dipimpin_langsung())) then
      raise exception 'Masukan untuk ketua tim hanya bisa dikirim ke ketua tim dari kelompok Anda.'
        using errcode = '42501';
    end if;
    v_kelompok := p_kelompok;
    select k.tim_id into v_tim from public.kelompok k where k.id = p_kelompok;
  else
    -- Untuk Admin: kelompok hanya sebagai keterangan, bila memang kelompok saya.
    if p_kelompok is not null and (p_kelompok is not distinct from v_kelompok_anggota
                                   or p_kelompok in (select bantu.kelompok_dipimpin_langsung())) then
      v_kelompok := p_kelompok;
    end if;
  end if;

  insert into public.masukan (pengirim_id, tujuan, kelompok_id, tim_id, jenis, judul, isi, anonim)
  values (v_saya, p_tujuan, v_kelompok, v_tim, p_jenis, trim(p_judul), trim(p_isi), coalesce(p_anonim, false))
  returning id into v_id;

  perform internal.catat_log('kirim_masukan', jsonb_build_object('masukan_id', v_id, 'tujuan', p_tujuan));
  return v_id;
end;
$$;


-- ---------------------------------------------------------------------
-- 2. Masukan yang saya kirim (beserta status dan balasan)
-- ---------------------------------------------------------------------
create function public.masukan_saya()
returns table (
  id uuid, tujuan public.tujuan_masukan, kelompok_nama text, tim_nama text,
  jenis public.jenis_masukan, judul text, isi text, anonim boolean,
  status public.status_masukan, balasan text, dibalas_pada timestamptz, dibuat_pada timestamptz)
language sql stable security definer set search_path = ''
as $$
  select m.id, m.tujuan, k.nama, t.nama, m.jenis, m.judul, m.isi, m.anonim,
         m.status, m.balasan, m.dibalas_pada, m.dibuat_pada
  from public.masukan m
  left join public.kelompok k on k.id = m.kelompok_id
  left join public.tim t      on t.id = m.tim_id
  where m.pengirim_id = auth.uid() and auth.uid() is not null
  order by m.dibuat_pada desc;
$$;


-- ---------------------------------------------------------------------
-- 3. Masukan yang masuk ke saya (penerima; Admin: semua)
--    Nama pengirim anonim hanya terlihat oleh Admin.
-- ---------------------------------------------------------------------
create function public.masukan_masuk()
returns table (
  id uuid, tujuan public.tujuan_masukan, kelompok_nama text, tim_nama text,
  jenis public.jenis_masukan, judul text, isi text, anonim boolean, pengirim_nama text,
  status public.status_masukan, balasan text, dibalas_oleh_nama text, dibalas_pada timestamptz,
  dibuat_pada timestamptz)
language sql stable security definer set search_path = ''
as $$
  select m.id, m.tujuan, k.nama, t.nama, m.jenis, m.judul, m.isi, m.anonim,
         case when m.anonim and not bantu.saya_admin() then null else pg.nama_tampilan end,
         m.status, m.balasan, pb.nama_tampilan, m.dibalas_pada, m.dibuat_pada
  from public.masukan m
  left join public.kelompok k on k.id = m.kelompok_id
  left join public.tim t      on t.id = m.tim_id
  left join public.akun pg    on pg.id = m.pengirim_id
  left join public.akun pb    on pb.id = m.dibalas_oleh
  where auth.uid() is not null and internal.boleh_tanggapi_masukan(m)
  order by (m.status = 'baru') desc, m.dibuat_pada desc;
$$;

-- Jumlah masukan baru yang perlu ditanggapi (untuk Beranda).
create function public.jumlah_masukan_baru()
returns integer
language sql stable security definer set search_path = ''
as $$
  select count(*)::integer from public.masukan m
  where auth.uid() is not null and m.status = 'baru' and internal.boleh_tanggapi_masukan(m);
$$;


-- ---------------------------------------------------------------------
-- 4. Menanggapi: status dan balasan
-- ---------------------------------------------------------------------
create function public.tanggapi_masukan(p_id uuid, p_status public.status_masukan, p_balasan text)
returns void
language plpgsql security definer set search_path = ''
as $$
declare
  v public.masukan;
  v_balasan text := nullif(trim(coalesce(p_balasan, '')), '');
begin
  select * into v from public.masukan where id = p_id for update;
  if v.id is null or auth.uid() is null or not internal.boleh_tanggapi_masukan(v) then
    raise exception 'Anda tidak berhak menanggapi masukan ini.' using errcode = '42501';
  end if;
  if p_status is null then
    raise exception 'Pilih status masukan.' using errcode = '22023';
  end if;
  if length(v_balasan) > 2000 then
    raise exception 'Balasan maksimal 2000 karakter.' using errcode = '22023';
  end if;

  update public.masukan
     set status = p_status,
         balasan = v_balasan,
         dibalas_oleh = case when v_balasan is distinct from v.balasan then auth.uid() else dibalas_oleh end,
         dibalas_pada = case when v_balasan is distinct from v.balasan then
                          (case when v_balasan is null then null else now() end) else dibalas_pada end
   where id = p_id;

  perform internal.catat_log('tanggapi_masukan', jsonb_build_object('masukan_id', p_id, 'status', p_status));
end;
$$;

revoke all on function public.kirim_masukan(public.tujuan_masukan, uuid, public.jenis_masukan, text, text, boolean) from public, anon;
revoke all on function public.masukan_saya()        from public, anon;
revoke all on function public.masukan_masuk()       from public, anon;
revoke all on function public.jumlah_masukan_baru() from public, anon;
revoke all on function public.tanggapi_masukan(uuid, public.status_masukan, text) from public, anon;
grant execute on function public.kirim_masukan(public.tujuan_masukan, uuid, public.jenis_masukan, text, text, boolean) to authenticated;
grant execute on function public.masukan_saya()        to authenticated;
grant execute on function public.masukan_masuk()       to authenticated;
grant execute on function public.jumlah_masukan_baru() to authenticated;
grant execute on function public.tanggapi_masukan(uuid, public.status_masukan, text) to authenticated;

revoke all on all functions in schema internal from public, anon, authenticated;
