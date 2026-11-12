-- =====================================================================
-- 02 · FUNGSI PEMBANTU ("buku panduan satpam")
-- Fungsi-fungsi kecil yang menjawab pertanyaan seperti "apakah saya admin?"
-- atau "kelompok mana yang boleh saya baca?". Semua aturan akses di file 03
-- memakai fungsi ini, jadi logikanya ditulis sekali dan konsisten.
--
-- Catatan teknis:
--   security definer  = fungsi berjalan dengan hak pemilik database, supaya
--                       pengecekan peran tidak terhalang aturan aksesnya sendiri.
--   search_path = ''  = semua nama ditulis lengkap (public.xxx) supaya tidak
--                       bisa dikelabui objek palsu dengan nama yang sama.
--   auth.uid()        = id akun yang sedang login (disediakan Supabase).
-- =====================================================================

-- Apakah saya Admin?
create function bantu.saya_admin()
returns boolean
language sql stable security definer
set search_path = ''
as $$
  select exists (
    select 1 from public.penugasan_peran
    where akun_id = auth.uid() and peran = 'admin'
  );
$$;

-- Kelompok yang saya pimpin (sebagai pemimpin ATAU wakil; haknya sama).
create function bantu.kelompok_dipimpin()
returns setof uuid
language sql stable security definer
set search_path = ''
as $$
  select kelompok_id from public.penugasan_peran
  where akun_id = auth.uid() and peran = 'pemimpin';
$$;

-- Tim yang saya ketuai.
create function bantu.tim_diketuai()
returns setof uuid
language sql stable security definer
set search_path = ''
as $$
  select tim_id from public.penugasan_peran
  where akun_id = auth.uid() and peran = 'ketua_tim';
$$;

-- Profil anggota milik saya (null bila akun saya bukan anggota).
create function bantu.anggota_saya()
returns uuid
language sql stable security definer
set search_path = ''
as $$
  select anggota_id from public.akun where id = auth.uid();
$$;

-- Kelompok tempat saya terdaftar sebagai anggota.
create function bantu.kelompok_saya_sebagai_anggota()
returns uuid
language sql stable security definer
set search_path = ''
as $$
  select a.kelompok_id
  from public.akun ak
  join public.anggota a on a.id = ak.anggota_id
  where ak.id = auth.uid();
$$;

-- Semua kelompok yang datanya boleh saya BACA sebagai staf:
--   Admin: semua kelompok · Ketua Tim: kelompok di timnya · Pemimpin/Wakil: kelompoknya.
-- (Peran ganda otomatis tergabung.)
create function bantu.kelompok_terbaca()
returns setof uuid
language sql stable security definer
set search_path = ''
as $$
  select k.id from public.kelompok k
  where bantu.saya_admin()
     or k.id     in (select bantu.kelompok_dipimpin())
     or k.tim_id in (select bantu.tim_diketuai());
$$;

-- Semua tim yang namanya boleh saya lihat.
create function bantu.tim_terbaca()
returns setof uuid
language sql stable security definer
set search_path = ''
as $$
  select t.id from public.tim t
  where bantu.saya_admin()
     or t.id in (select bantu.tim_diketuai())
     or t.id in (select k.tim_id from public.kelompok k
                 where k.id in (select bantu.kelompok_dipimpin())
                    or k.id = bantu.kelompok_saya_sebagai_anggota());
$$;

-- Bolehkah saya MELIHAT data (dan foto) anggota ini?
create function bantu.boleh_baca_anggota(p_anggota uuid)
returns boolean
language sql stable security definer
set search_path = ''
as $$
  select exists (
    select 1 from public.anggota a
    where a.id = p_anggota
      and (a.kelompok_id in (select bantu.kelompok_terbaca())
           or a.id = bantu.anggota_saya())
  );
$$;

-- Bolehkah saya MENGUBAH data anggota ini sebagai pemimpin/wakil kelompoknya?
create function bantu.boleh_kelola_anggota(p_anggota uuid)
returns boolean
language sql stable security definer
set search_path = ''
as $$
  select exists (
    select 1 from public.anggota a
    where a.id = p_anggota
      and a.kelompok_id in (select bantu.kelompok_dipimpin())
  );
$$;

-- Mengubah teks menjadi uuid dengan aman (null bila bukan uuid yang sah).
-- Dipakai untuk membaca nama folder foto.
create function bantu.teks_ke_uuid(p_teks text)
returns uuid
language plpgsql immutable
set search_path = ''
as $$
begin
  return p_teks::uuid;
exception when others then
  return null;
end;
$$;

-- Hanya pengguna yang sudah login yang boleh memakai fungsi-fungsi ini.
revoke all on all functions in schema bantu from public;
grant usage on schema bantu to authenticated;
grant execute on all functions in schema bantu to authenticated;


-- ---------------------------------------------------------------------
-- Pencatat log (ruang internal: pengguna tidak bisa memanggilnya langsung,
-- sehingga log tidak bisa dipalsukan).
-- ---------------------------------------------------------------------
create function internal.catat_log(p_tindakan text, p_detail jsonb default '{}'::jsonb)
returns void
language sql security definer
set search_path = ''
as $$
  insert into public.log_aktivitas (akun_id, tindakan, detail)
  values (auth.uid(), p_tindakan, coalesce(p_detail, '{}'::jsonb));
$$;
revoke all on function internal.catat_log(text, jsonb) from public;
