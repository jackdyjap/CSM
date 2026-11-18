-- =====================================================================
-- 16 · ATUR PROFIL SENDIRI UNTUK SEMUA PERAN (keputusan 27)
--
-- * Profil staf: Admin, Ketua Tim, dan Pemimpin yang BUKAN anggota
--   kelompok punya profil sendiri (foto dan data pribadi), terpisah dari
--   profil anggota. Tidak ikut absensi atau laporan demografi anggota.
--   Hanya dibaca orangnya sendiri dan Admin.
-- * Login pertama: semua akun diarahkan ke halaman Atur profil sampai
--   menekan "Selesai". Akun yang dibuat Admin (kata sandi sementara)
--   wajib mengganti kata sandi dulu.
-- * Nama akun mengikuti nama lengkap di profil anggota.
-- =====================================================================


-- ---------------------------------------------------------------------
-- 1. PENANDA LOGIN PERTAMA DI TABEL AKUN
-- ---------------------------------------------------------------------
alter table public.akun
  add column sandi_sementara    boolean not null default false,
  add column profil_diatur_pada timestamptz;

comment on column public.akun.sandi_sementara    is 'true = kata sandi dibuat Admin; wajib diganti saat login pertama.';
comment on column public.akun.profil_diatur_pada is 'Kapan pengguna menyelesaikan Atur profil. NULL = belum (diarahkan ke Atur profil).';


-- ---------------------------------------------------------------------
-- 2. PROFIL STAF
-- Baris dibuat saat orangnya menyetujui pencatatan data (UU PDP),
-- jadi persetujuan_pada selalu terisi. Nomor HP ada di akun (cara masuk).
-- ---------------------------------------------------------------------
create table public.profil_staf (
  akun_id         uuid primary key references public.akun(id) on delete cascade,
  gender          public.gender,
  foto_path       text,
  tempat_lahir    text,
  tanggal_lahir   date check (tanggal_lahir > date '1900-01-01'),
  alamat          text,
  provinsi_kode   text references public.wilayah(kode),
  kota_kode       text references public.wilayah(kode),
  kecamatan_kode  text references public.wilayah(kode),
  kelurahan_kode  text references public.wilayah(kode),
  status_nikah    public.status_nikah,
  pendidikan      public.pendidikan,
  pekerjaan       public.pekerjaan,
  persetujuan_pada timestamptz not null default now(),
  dibuat_pada     timestamptz not null default now(),
  diubah_pada     timestamptz not null default now(),

  constraint profil_staf_wilayah_bertingkat check (
        (provinsi_kode  is null or provinsi_kode ~ '^[0-9]{2}$')
    and (kota_kode      is null or (provinsi_kode  is not null and kota_kode      like provinsi_kode  || '.__'))
    and (kecamatan_kode is null or (kota_kode      is not null and kecamatan_kode like kota_kode      || '.__'))
    and (kelurahan_kode is null or (kecamatan_kode is not null and kelurahan_kode like kecamatan_kode || '.____'))
  ),
  -- Foto harus berada di folder milik akun ini sendiri: staf/<id akun>/...
  constraint profil_staf_foto_milik_sendiri check (
    foto_path is null or foto_path like 'staf/' || akun_id::text || '/%'
  )
);
comment on table public.profil_staf is
  'Profil pribadi Admin/Ketua Tim/Pemimpin yang bukan anggota kelompok. Hanya dibaca orangnya sendiri dan Admin.';

alter table public.profil_staf enable row level security;

revoke all on public.profil_staf from anon;
grant select, insert, update, delete on public.profil_staf to authenticated;

create policy "profil staf: baca milik sendiri, admin baca semua" on public.profil_staf
  for select to authenticated
  using (akun_id = (select auth.uid()) or (select bantu.saya_admin()));

-- Hanya akun yang TIDAK punya profil anggota (orang itu memakai profil anggotanya).
create policy "profil staf: buat milik sendiri" on public.profil_staf
  for insert to authenticated
  with check (akun_id = (select auth.uid())
              and not exists (select 1 from public.akun ak
                              where ak.id = (select auth.uid()) and ak.anggota_id is not null));

create policy "profil staf: ubah milik sendiri" on public.profil_staf
  for update to authenticated
  using (akun_id = (select auth.uid())) with check (akun_id = (select auth.uid()));

-- Menghapus profil = menarik persetujuan (oleh orangnya) atau koreksi oleh Admin.
create policy "profil staf: hapus milik sendiri atau admin" on public.profil_staf
  for delete to authenticated
  using (akun_id = (select auth.uid()) or (select bantu.saya_admin()));

create trigger isi_diubah_pada before update on public.profil_staf
  for each row execute function internal.isi_diubah_pada();

-- Waktu persetujuan tidak bisa dipalsukan; foto lama masuk antrean hapus.
create function internal.jaga_profil_staf()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  if tg_op = 'INSERT' then
    new.persetujuan_pada := now();
  elsif tg_op = 'UPDATE' then
    new.persetujuan_pada := old.persetujuan_pada;
    new.akun_id := old.akun_id;
  end if;
  return new;
end;
$$;

create trigger jaga_profil_staf before insert or update on public.profil_staf
  for each row execute function internal.jaga_profil_staf();

create function internal.setelah_profil_staf_berubah()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  if tg_op = 'DELETE' then
    if old.foto_path is not null then
      insert into internal.antrean_hapus_foto (foto_path) values (old.foto_path);
    end if;
    perform internal.catat_log('hapus_profil_staf', jsonb_build_object('akun_id', old.akun_id));
    return old;
  end if;
  if old.foto_path is not null and new.foto_path is distinct from old.foto_path then
    insert into internal.antrean_hapus_foto (foto_path) values (old.foto_path);
  end if;
  return new;
end;
$$;

create trigger setelah_profil_staf_berubah after update or delete on public.profil_staf
  for each row execute function internal.setelah_profil_staf_berubah();


-- ---------------------------------------------------------------------
-- 3. FOTO STAF: folder foto-anggota/staf/<id akun>/
-- ---------------------------------------------------------------------
create policy "foto staf: lihat" on storage.objects
  for select to authenticated
  using (bucket_id = 'foto-anggota' and (storage.foldername(name))[1] = 'staf'
         and ((storage.foldername(name))[2] = (select auth.uid())::text or (select bantu.saya_admin())));

create policy "foto staf: unggah" on storage.objects
  for insert to authenticated
  with check (bucket_id = 'foto-anggota' and (storage.foldername(name))[1] = 'staf'
              and (storage.foldername(name))[2] = (select auth.uid())::text);

create policy "foto staf: ganti" on storage.objects
  for update to authenticated
  using      (bucket_id = 'foto-anggota' and (storage.foldername(name))[1] = 'staf'
              and (storage.foldername(name))[2] = (select auth.uid())::text)
  with check (bucket_id = 'foto-anggota' and (storage.foldername(name))[1] = 'staf'
              and (storage.foldername(name))[2] = (select auth.uid())::text);

create policy "foto staf: hapus" on storage.objects
  for delete to authenticated
  using (bucket_id = 'foto-anggota' and (storage.foldername(name))[1] = 'staf'
         and (storage.foldername(name))[2] = (select auth.uid())::text);


-- ---------------------------------------------------------------------
-- 4. NAMA AKUN MENGIKUTI NAMA LENGKAP DI PROFIL ANGGOTA
-- ---------------------------------------------------------------------
create function internal.samakan_nama_akun()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  update public.akun ak
     set nama_tampilan = new.nama_lengkap
   where ak.anggota_id = new.id and ak.nama_tampilan is distinct from new.nama_lengkap;
  return null;
end;
$$;

create trigger samakan_nama_akun after update of nama_lengkap on public.anggota
  for each row when (new.nama_lengkap is distinct from old.nama_lengkap)
  execute function internal.samakan_nama_akun();

-- Nama tampilan tidak boleh kosong.
alter table public.akun
  add constraint akun_nama_tampilan_isi check (length(trim(nama_tampilan)) > 0) not valid;


-- ---------------------------------------------------------------------
-- 5. LOKET
-- ---------------------------------------------------------------------

-- 5a. Menyelesaikan Atur profil (login pertama).
create function public.selesai_atur_profil()
returns void
language plpgsql security definer set search_path = ''
as $$
begin
  if auth.uid() is null then
    raise exception 'Silakan masuk terlebih dahulu.' using errcode = '42501';
  end if;
  if exists (select 1 from public.akun where id = auth.uid() and sandi_sementara) then
    raise exception 'Ganti kata sandi sementara dari Admin terlebih dahulu.' using errcode = '22023';
  end if;
  update public.akun set profil_diatur_pada = coalesce(profil_diatur_pada, now()) where id = auth.uid();
end;
$$;

-- 5b. Siapa saya: ditambah penanda login pertama.
create or replace function public.peran_saya()
returns jsonb
language sql stable security definer set search_path = ''
as $$
  select jsonb_build_object(
    'akun_id', ak.id,
    'nama',    ak.nama_tampilan,
    'login',   ak.login,
    'perlu_atur_profil', ak.profil_diatur_pada is null,
    'sandi_sementara',   ak.sandi_sementara,
    'admin',   bantu.saya_admin(),
    'ketua_tim', coalesce((
        select jsonb_agg(jsonb_build_object('tim_id', t.id, 'nama', t.nama) order by t.nama)
        from public.penugasan_peran p join public.tim t on t.id = p.tim_id
        where p.akun_id = ak.id and p.peran = 'ketua_tim'), '[]'::jsonb),
    'pemimpin', coalesce((
        select jsonb_agg(jsonb_build_object(
                 'kelompok_id', k.id, 'nama', k.nama, 'tim_nama', t.nama, 'jabatan', p.jabatan)
               order by k.nama)
        from public.penugasan_peran p
        join public.kelompok k on k.id = p.kelompok_id
        join public.tim t on t.id = k.tim_id
        where p.akun_id = ak.id and p.peran = 'pemimpin'), '[]'::jsonb),
    'anggota', (
        select jsonb_build_object('anggota_id', a.id, 'nama', a.nama_lengkap,
                                  'kelompok_id', k.id, 'kelompok_nama', k.nama)
        from public.anggota a join public.kelompok k on k.id = a.kelompok_id
        where a.id = ak.anggota_id)
  )
  from public.akun ak
  where ak.id = auth.uid();
$$;

-- 5c. (server) Penanda kata sandi sementara: dipasang saat Admin membuat
--     akun, dilepas saat pengguna mengganti kata sandinya.
create function public.layanan_tandai_sandi(p_akun uuid, p_sementara boolean)
returns void
language sql security definer set search_path = ''
as $$
  update public.akun set sandi_sementara = coalesce(p_sementara, false) where id = p_akun;
$$;

revoke all on function public.selesai_atur_profil()               from public, anon;
revoke all on function public.peran_saya()                        from public, anon;
revoke all on function public.layanan_tandai_sandi(uuid, boolean) from public, anon, authenticated;
grant execute on function public.selesai_atur_profil()            to authenticated;
grant execute on function public.peran_saya()                     to authenticated;
grant execute on function public.layanan_tandai_sandi(uuid, boolean) to service_role;

revoke all on all functions in schema internal from public, anon, authenticated;
