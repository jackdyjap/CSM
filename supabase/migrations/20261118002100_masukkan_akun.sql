-- =====================================================================
-- 21 · MEMASUKKAN AKUN YANG BELUM TERGABUNG KE SEBUAH KELOMPOK (keputusan 35)
--
-- Akun "belum tergabung" = akun tanpa profil anggota (anggota_id kosong):
-- dibuat Admin, kelompoknya dihapus, atau profilnya terhapus otomatis.
-- Akun pengurus juga boleh dimasukkan sebagai anggota.
--
-- * Pemimpin/Wakil : ke kelompoknya sendiri.
-- * Ketua Tim      : ke kelompok mana pun di timnya.
-- * Admin          : ke kelompok mana pun.
-- * Mencari akun: Pemimpin/Ketua Tim mengetik nama pengguna, email, atau
--   nomor HP yang PERSIS; Admin juga bisa melihat daftar lengkap.
-- * Langsung masuk (tanpa konfirmasi pemilik akun); tercatat di log. Data
--   pribadinya tetap baru bisa diisi setelah persetujuan data.
-- =====================================================================

-- Bolehkah saya memasukkan anggota ke kelompok ini?
create function bantu.boleh_masukkan_ke_kelompok(p_kelompok uuid)
returns boolean
language sql stable security definer set search_path = ''
as $$
  select p_kelompok is not null and (
       bantu.saya_admin()
    or p_kelompok in (select bantu.kelompok_dipimpin_langsung())
    or exists (select 1 from public.kelompok k
               where k.id = p_kelompok and k.tim_id in (select bantu.tim_diketuai()))
  );
$$;
revoke all on function bantu.boleh_masukkan_ke_kelompok(uuid) from public, anon;
grant execute on function bantu.boleh_masukkan_ke_kelompok(uuid) to authenticated;


-- 1. Mencari SATU akun yang belum tergabung dengan isian persis
--    (nama pengguna, email, atau nomor HP). Hanya untuk pengurus.
create function public.cari_akun_belum_tergabung(p_isian text)
returns table (akun_id uuid, nama text, login text)
language plpgsql stable security definer set search_path = ''
as $$
declare
  v    text := lower(trim(coalesce(p_isian, '')));
  v_hp text;
begin
  if auth.uid() is null or not (
       bantu.saya_admin()
    or exists (select 1 from public.penugasan_peran p
               where p.akun_id = auth.uid() and p.peran in ('pemimpin', 'ketua_tim'))) then
    raise exception 'Hanya pemimpin kelompok, ketua tim, atau Admin yang bisa mencari akun.' using errcode = '42501';
  end if;
  if v = '' then return; end if;
  v_hp := case when v not like '%@%' then internal.normal_hp(v) end;

  return query
    select ak.id, ak.nama_tampilan, ak.login
    from public.akun ak
    where ak.anggota_id is null
      and (ak.email = v or ak.nama_pengguna = v or (v_hp is not null and ak.nomor_hp = v_hp));
end;
$$;

-- 2. Daftar lengkap akun yang belum tergabung (khusus Admin).
create function public.akun_belum_tergabung()
returns table (akun_id uuid, nama text, login text, peran text, dibuat_pada timestamptz)
language plpgsql stable security definer set search_path = ''
as $$
begin
  if not bantu.saya_admin() then
    raise exception 'Daftar lengkap hanya untuk Admin.' using errcode = '42501';
  end if;
  return query
    select ak.id, ak.nama_tampilan, ak.login,
           (select string_agg(distinct case p.peran when 'admin' then 'Admin' when 'ketua_tim' then 'Ketua Tim'
                                       else case p.jabatan when 'wakil' then 'Wakil' else 'Pemimpin' end end, ', ')
            from public.penugasan_peran p where p.akun_id = ak.id),
           ak.dibuat_pada
    from public.akun ak
    where ak.anggota_id is null
    order by ak.nama_tampilan;
end;
$$;

-- 3. Memasukkan akun ke kelompok: profil anggota baru dibuat dan
--    disambungkan ke akun itu.
create function public.masukkan_akun_ke_kelompok(p_akun uuid, p_kelompok uuid)
returns uuid
language plpgsql security definer set search_path = ''
as $$
declare
  v_akun    public.akun;
  v_anggota uuid;
begin
  if auth.uid() is null or not bantu.boleh_masukkan_ke_kelompok(p_kelompok) then
    raise exception 'Anda tidak berhak memasukkan anggota ke kelompok ini.' using errcode = '42501';
  end if;
  select * into v_akun from public.akun where id = p_akun for update;
  if v_akun.id is null then
    raise exception 'Akun tidak ditemukan.' using errcode = '22023';
  end if;
  if v_akun.anggota_id is not null then
    raise exception 'Akun ini sudah tergabung di sebuah kelompok. Gunakan Pindah kelompok di profil anggotanya.'
      using errcode = '22023';
  end if;

  insert into public.anggota (kelompok_id, nama_lengkap)
  values (p_kelompok, v_akun.nama_tampilan)
  returning id into v_anggota;

  update public.akun set anggota_id = v_anggota where id = p_akun;

  perform internal.catat_log('masukkan_akun_ke_kelompok',
    jsonb_build_object('akun_id', p_akun, 'anggota_id', v_anggota, 'kelompok_id', p_kelompok));
  return v_anggota;
end;
$$;

revoke all on function public.cari_akun_belum_tergabung(text)            from public, anon;
revoke all on function public.akun_belum_tergabung()                     from public, anon;
revoke all on function public.masukkan_akun_ke_kelompok(uuid, uuid)      from public, anon;
grant execute on function public.cari_akun_belum_tergabung(text)         to authenticated;
grant execute on function public.akun_belum_tergabung()                  to authenticated;
grant execute on function public.masukkan_akun_ke_kelompok(uuid, uuid)   to authenticated;

revoke all on all functions in schema internal from public, anon, authenticated;
