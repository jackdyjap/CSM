-- =====================================================================
-- 20 · ATUR ULANG KATA SANDI OLEH KETUA TIM (keputusan 34)
--
-- Siapa boleh membuat tautan atur ulang kata sandi untuk siapa:
--   * Admin          : semua akun (kecuali dirinya sendiri; ganti sendiri di Atur profil).
--   * Ketua Tim      : anggota DAN pemimpin/wakil kelompok di timnya.
--                      Tidak untuk Admin, Ketua Tim (mana pun), atau pengurus
--                      yang juga memegang peran di luar timnya.
--   * Pemimpin/Wakil : anggota kelompoknya yang bukan pengurus (seperti
--                      sebelumnya; sesama pengurus tidak saling reset).
-- Cara tetap: tautan 24 jam sekali pakai (keputusan 6).
-- =====================================================================

-- Bolehkah saya membuat tautan atur ulang untuk akun ini?
create function bantu.boleh_atur_ulang_sandi(p_akun uuid)
returns boolean
language sql stable security definer set search_path = ''
as $$
  select p_akun is not null and auth.uid() is not null and p_akun <> auth.uid()
     and exists (select 1 from public.akun where id = p_akun)
     and (
       bantu.saya_admin()
       -- Ketua Tim: target terhubung ke timnya (anggota atau pengurus kelompok di timnya) ...
       or ((exists (select 1 from public.akun ak
                    join public.anggota a on a.id = ak.anggota_id
                    join public.kelompok k on k.id = a.kelompok_id
                    where ak.id = p_akun and k.tim_id in (select bantu.tim_diketuai()))
            or exists (select 1 from public.penugasan_peran p
                       join public.kelompok k on k.id = p.kelompok_id
                       where p.akun_id = p_akun and p.peran = 'pemimpin'
                         and k.tim_id in (select bantu.tim_diketuai())))
           -- ... dan tidak memegang peran apa pun di luar pengurus kelompok timnya.
           and not exists (select 1 from public.penugasan_peran p
                           left join public.kelompok k on k.id = p.kelompok_id
                           where p.akun_id = p_akun
                             and (p.peran <> 'pemimpin'
                                  or k.tim_id is null
                                  or k.tim_id not in (select bantu.tim_diketuai()))))
       -- Pemimpin/Wakil: anggota kelompoknya yang bukan pengurus.
       or (not exists (select 1 from public.penugasan_peran p where p.akun_id = p_akun)
           and exists (select 1 from public.akun ak
                       join public.anggota a on a.id = ak.anggota_id
                       where ak.id = p_akun
                         and a.kelompok_id in (select bantu.kelompok_dipimpin_langsung())))
     );
$$;
revoke all on function bantu.boleh_atur_ulang_sandi(uuid) from public, anon;
grant execute on function bantu.boleh_atur_ulang_sandi(uuid) to authenticated;


-- Membuat tautan atur ulang (isi sama dengan file 06, aturan hak diganti).
create or replace function public.buat_tautan_atur_ulang(p_akun uuid)
returns table (token text, kedaluwarsa_pada timestamptz)
language plpgsql security definer set search_path = ''
as $$
#variable_conflict use_column
declare
  v_token text := encode(extensions.gen_random_bytes(24), 'hex');
  v_kedaluwarsa timestamptz;
begin
  if not bantu.boleh_atur_ulang_sandi(p_akun) then
    raise exception 'Anda tidak berhak membuat tautan atur ulang untuk akun ini.' using errcode = '42501';
  end if;

  delete from internal.tautan_atur_ulang t where t.akun_id = p_akun and t.dipakai_pada is null;

  insert into internal.tautan_atur_ulang as t (akun_id, token_hash, dibuat_oleh)
  values (p_akun, internal.hash_token(v_token), auth.uid())
  returning t.kedaluwarsa_pada into v_kedaluwarsa;

  perform internal.catat_log('buat_tautan_atur_ulang', jsonb_build_object('akun_id', p_akun));
  return query select v_token, v_kedaluwarsa;
end;
$$;


-- Akun di satu kelompok yang boleh saya atur ulang kata sandinya
-- (untuk daftar di halaman kelompok, terutama bagi Ketua Tim).
create function public.akun_bisa_atur_ulang(p_kelompok uuid)
returns table (akun_id uuid, nama text, keterangan text, login text)
language sql stable security definer set search_path = ''
as $$
  with calon as (
    select ak.id, ak.nama_tampilan, ak.login, 'Anggota'::text as ket, 2 as urut
    from public.akun ak join public.anggota a on a.id = ak.anggota_id
    where a.kelompok_id = p_kelompok
    union
    select ak.id, ak.nama_tampilan, ak.login,
           case p.jabatan when 'wakil' then 'Wakil' else 'Pemimpin' end, 1
    from public.penugasan_peran p join public.akun ak on ak.id = p.akun_id
    where p.kelompok_id = p_kelompok and p.peran = 'pemimpin'
  )
  select distinct on (c.id) c.id, c.nama_tampilan, c.ket, c.login
  from calon c
  where bantu.boleh_atur_ulang_sandi(c.id)
  order by c.id, c.urut;
$$;
revoke all on function public.akun_bisa_atur_ulang(uuid) from public, anon;
grant execute on function public.akun_bisa_atur_ulang(uuid) to authenticated;

revoke all on all functions in schema internal from public, anon, authenticated;
