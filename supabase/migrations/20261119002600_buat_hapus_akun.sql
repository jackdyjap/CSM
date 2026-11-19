-- =====================================================================
-- 26 · MEMBUAT AKUN OLEH PENGURUS & MENGHAPUS AKUN OLEH ADMIN
--      (keputusan 41 dan 42)
--
-- A. Membuat akun baru langsung dengan tujuannya (keputusan 42):
--    * Pemimpin/Wakil : anggota kelompoknya sendiri.
--    * Ketua Tim      : anggota, Pemimpin, atau Wakil kelompok di timnya.
--    * Admin          : semua di atas untuk kelompok mana pun, Ketua Tim
--                       tim mana pun, Admin, atau tanpa tujuan.
--    Kata sandinya sementara (wajib diganti saat login pertama).
--
--    Langkahnya (akun login hanya bisa dibuat server dengan kunci rahasia):
--    1. izin_buat_akun(...)   : pengurus meminta izin; hak diperiksa di sini.
--                               Hasilnya kode izin (berlaku 15 menit, sekali).
--    2. Server membuat akun login, kode izin ikut disimpan di data akun.
--    3. pasang_akun_baru(...) : pengurus yang sama memasang tujuannya
--                               (profil anggota atau peran). Hak diperiksa lagi.
--
-- B. Menghapus akun (keputusan 41): hanya Admin, setelah mengetik nama akun
--    persis. Admin memilih apakah profil anggotanya ikut dihapus. Admin
--    tidak bisa menghapus akunnya sendiri.
-- =====================================================================

create table internal.izin_buat_akun (
  id           uuid primary key default gen_random_uuid(),
  pembuat      uuid not null references public.akun(id) on delete cascade,
  tujuan       text not null check (tujuan in ('anggota', 'pemimpin', 'wakil', 'ketua_tim', 'admin', 'tanpa')),
  kelompok_id  uuid references public.kelompok(id) on delete cascade,
  tim_id       uuid references public.tim(id) on delete cascade,
  akun_id      uuid references public.akun(id) on delete cascade,
  dibuat_pada  timestamptz not null default now(),
  dipakai_pada timestamptz
);
comment on table internal.izin_buat_akun is 'Izin sekali pakai untuk membuat akun dengan tujuannya (keputusan 42).';
revoke all on internal.izin_buat_akun from public, anon, authenticated;


-- Bolehkah saya membuat akun dengan tujuan ini?
create function bantu.boleh_buat_akun(p_tujuan text, p_kelompok uuid, p_tim uuid)
returns boolean
language sql stable security definer set search_path = ''
as $$
  select case p_tujuan
    when 'anggota' then bantu.boleh_masukkan_ke_kelompok(p_kelompok)
    when 'pemimpin' then p_kelompok is not null and (
         bantu.saya_admin()
      or exists (select 1 from public.kelompok k
                 where k.id = p_kelompok and k.tim_id in (select bantu.tim_diketuai())))
    when 'wakil' then p_kelompok is not null and (
         bantu.saya_admin()
      or exists (select 1 from public.kelompok k
                 where k.id = p_kelompok and k.tim_id in (select bantu.tim_diketuai())))
    when 'ketua_tim' then p_tim is not null and bantu.saya_admin()
    when 'admin' then bantu.saya_admin()
    when 'tanpa' then bantu.saya_admin()
    else false
  end;
$$;
revoke all on function bantu.boleh_buat_akun(text, uuid, uuid) from public, anon;
grant execute on function bantu.boleh_buat_akun(text, uuid, uuid) to authenticated;


-- A1. Meminta izin membuat akun.
create function public.izin_buat_akun(p_tujuan text, p_kelompok uuid default null, p_tim uuid default null)
returns uuid
language plpgsql security definer set search_path = ''
as $$
declare
  v_tujuan   text := coalesce(nullif(trim(p_tujuan), ''), 'tanpa');
  v_kelompok uuid := case when v_tujuan in ('anggota', 'pemimpin', 'wakil') then p_kelompok end;
  v_tim      uuid := case when v_tujuan = 'ketua_tim' then p_tim end;
  v_izin     uuid;
begin
  if auth.uid() is null then
    raise exception 'Silakan masuk terlebih dahulu.' using errcode = '42501';
  end if;
  if v_tujuan not in ('anggota', 'pemimpin', 'wakil', 'ketua_tim', 'admin', 'tanpa') then
    raise exception 'Tujuan akun tidak dikenal.' using errcode = '22023';
  end if;
  if v_tujuan in ('anggota', 'pemimpin', 'wakil') and v_kelompok is null then
    raise exception 'Pilih kelompoknya.' using errcode = '22023';
  end if;
  if v_tujuan = 'ketua_tim' and v_tim is null then
    raise exception 'Pilih timnya.' using errcode = '22023';
  end if;
  if not bantu.boleh_buat_akun(v_tujuan, v_kelompok, v_tim) then
    raise exception 'Anda tidak berhak membuat akun dengan tujuan ini.' using errcode = '42501';
  end if;

  -- Bersihkan izin lama milik saya yang tidak terpakai.
  delete from internal.izin_buat_akun
   where pembuat = auth.uid() and dipakai_pada is null and dibuat_pada < now() - interval '15 minutes';

  insert into internal.izin_buat_akun (pembuat, tujuan, kelompok_id, tim_id)
  values (auth.uid(), v_tujuan, v_kelompok, v_tim)
  returning id into v_izin;
  return v_izin;
end;
$$;


-- A3. Memasang tujuan pada akun yang baru dibuat dengan izin itu.
--     Mengembalikan id profil anggota bila tujuannya anggota.
create function public.pasang_akun_baru(p_izin uuid, p_akun uuid)
returns uuid
language plpgsql security definer set search_path = ''
as $$
declare
  v_izin    internal.izin_buat_akun;
  v_akun    public.akun;
  v_anggota uuid;
begin
  if auth.uid() is null then
    raise exception 'Silakan masuk terlebih dahulu.' using errcode = '42501';
  end if;

  select * into v_izin from internal.izin_buat_akun where id = p_izin for update;
  if v_izin.id is null or v_izin.pembuat <> auth.uid() then
    raise exception 'Izin membuat akun tidak ditemukan.' using errcode = '42501';
  end if;
  if v_izin.dipakai_pada is not null or v_izin.dibuat_pada < now() - interval '15 minutes' then
    raise exception 'Izin membuat akun sudah dipakai atau kedaluwarsa. Ulangi dari awal.' using errcode = '22023';
  end if;
  -- Hak diperiksa lagi (mungkin peran saya baru saja dicabut).
  if not bantu.boleh_buat_akun(v_izin.tujuan, v_izin.kelompok_id, v_izin.tim_id) then
    raise exception 'Anda tidak berhak membuat akun dengan tujuan ini.' using errcode = '42501';
  end if;

  -- Akunnya harus benar-benar dibuat dengan izin ini (kode izin tersimpan
  -- di data akun login oleh server), masih baru, dan belum punya apa-apa.
  if not exists (select 1 from auth.users u
                 where u.id = p_akun and u.raw_user_meta_data ->> 'izin' = p_izin::text) then
    raise exception 'Akun ini tidak dibuat dengan izin tersebut.' using errcode = '42501';
  end if;
  select * into v_akun from public.akun where id = p_akun for update;
  if v_akun.id is null then
    raise exception 'Akun tidak ditemukan.' using errcode = '22023';
  end if;
  if v_akun.anggota_id is not null
     or exists (select 1 from public.penugasan_peran where akun_id = p_akun) then
    raise exception 'Akun ini sudah punya kelompok atau peran.' using errcode = '22023';
  end if;

  update internal.izin_buat_akun set dipakai_pada = now(), akun_id = p_akun where id = p_izin;

  if v_izin.tujuan = 'anggota' then
    insert into public.anggota (kelompok_id, nama_lengkap)
    values (v_izin.kelompok_id, v_akun.nama_tampilan)
    returning id into v_anggota;
    update public.akun set anggota_id = v_anggota where id = p_akun;
  elsif v_izin.tujuan in ('pemimpin', 'wakil') then
    insert into public.penugasan_peran (akun_id, peran, kelompok_id, jabatan)
    values (p_akun, 'pemimpin', v_izin.kelompok_id, v_izin.tujuan::public.jabatan_kelompok);
  elsif v_izin.tujuan = 'ketua_tim' then
    insert into public.penugasan_peran (akun_id, peran, tim_id)
    values (p_akun, 'ketua_tim', v_izin.tim_id);
  elsif v_izin.tujuan = 'admin' then
    insert into public.penugasan_peran (akun_id, peran) values (p_akun, 'admin');
  end if;

  perform internal.catat_log('buat_akun', jsonb_build_object(
    'akun_id', p_akun, 'tujuan', v_izin.tujuan, 'kelompok_id', v_izin.kelompok_id,
    'tim_id', v_izin.tim_id, 'anggota_id', v_anggota));
  return v_anggota;
end;
$$;


-- B0. Penjaga profil anggota: "siapa yang mencatat persetujuan" tetap tidak
--     bisa diubah, tetapi boleh kosong bila akun pencatatnya sudah dihapus.
--     (Sebelumnya penghapusan akun seperti itu ditolak database.)
create or replace function internal.jaga_anggota()
returns trigger language plpgsql security definer set search_path = ''
as $$
declare
  v_uid      uuid := auth.uid();
  v_diri     boolean := false;
  v_pemimpin boolean := false;
begin
  -- Perubahan oleh sistem (tugas otomatis, penjaga lain, SQL editor Supabase)
  -- tidak diperiksa haknya, hanya dirapikan.
  if v_uid is not null and pg_trigger_depth() = 1 then
    v_diri := new.id = bantu.anggota_saya();
    if tg_op = 'UPDATE' then
      v_pemimpin := old.kelompok_id in (select bantu.kelompok_dipimpin());
    else
      v_pemimpin := new.kelompok_id in (select bantu.kelompok_dipimpin());
    end if;

    if tg_op = 'UPDATE' and v_diri and not v_pemimpin then
      if new.kelompok_id        is distinct from old.kelompok_id
      or new.kode_qr            is distinct from old.kode_qr
      or new.aktif              is distinct from old.aktif
      or new.dinonaktifkan_pada is distinct from old.dinonaktifkan_pada
      or new.bergabung_pada     is distinct from old.bergabung_pada then
        raise exception 'Anda tidak boleh mengubah kelompok, kode QR, status aktif, atau tanggal bergabung.'
          using errcode = '42501';
      end if;
      if old.persetujuan_pada is not null
         and new.persetujuan_pada is distinct from old.persetujuan_pada then
        raise exception 'Persetujuan yang sudah tercatat hanya bisa diubah oleh pemimpin kelompok.'
          using errcode = '42501';
      end if;
    end if;
  end if;

  -- Rapikan data persetujuan.
  if new.persetujuan_pada is null then
    new.persetujuan_dicatat_oleh := null;
    new.persetujuan_dicatat_akun := null;
  elsif tg_op = 'INSERT' or old.persetujuan_pada is null
        or new.persetujuan_pada is distinct from old.persetujuan_pada then
    new.persetujuan_pada := now();
    if v_uid is not null then
      new.persetujuan_dicatat_akun := v_uid;
      new.persetujuan_dicatat_oleh := case when v_diri and not v_pemimpin
                                           then 'anggota_sendiri' else 'pemimpin' end;
    else
      new.persetujuan_dicatat_oleh := coalesce(new.persetujuan_dicatat_oleh, 'pemimpin');
    end if;
  else
    -- Siapa yang mencatat tidak boleh diubah-ubah.
    new.persetujuan_dicatat_oleh := old.persetujuan_dicatat_oleh;
    -- Kecuali akun pencatatnya dihapus (keputusan 41): kolomnya dikosongkan.
    new.persetujuan_dicatat_akun := case
      when new.persetujuan_dicatat_akun is null
       and not exists (select 1 from public.akun where id = old.persetujuan_dicatat_akun) then null
      else old.persetujuan_dicatat_akun end;
  end if;

  -- Tanggal persetujuan wali diisi otomatis saat nama wali pertama kali diisi.
  if new.wali_nama is null then
    new.wali_persetujuan_pada := null;
  elsif new.wali_persetujuan_pada is null then
    new.wali_persetujuan_pada := now();
  end if;

  -- Anggota di bawah 18 tahun wajib ada persetujuan wali.
  if v_uid is not null and pg_trigger_depth() = 1
     and new.tanggal_lahir is not null
     and age(bantu.hari_ini_wib(), new.tanggal_lahir) < interval '18 years'
     and new.wali_nama is null then
    raise exception 'Anggota di bawah 18 tahun memerlukan persetujuan orang tua/wali (isi nama wali).'
      using errcode = '23514';
  end if;

  -- Rapikan status aktif.
  if new.aktif then
    new.dinonaktifkan_pada := null;
  elsif new.dinonaktifkan_pada is null then
    new.dinonaktifkan_pada := now();
  end if;

  return new;
end;
$$;


-- B. Menghapus akun (khusus Admin).
create function public.hapus_akun(p_akun uuid, p_konfirmasi text, p_hapus_profil boolean default false)
returns void
language plpgsql security definer set search_path = ''
as $$
declare
  v_akun public.akun;
  v_profil_dihapus boolean := false;
begin
  if auth.uid() is null or not bantu.saya_admin() then
    raise exception 'Hanya Admin yang bisa menghapus akun.' using errcode = '42501';
  end if;
  if p_akun = auth.uid() then
    raise exception 'Anda tidak bisa menghapus akun Anda sendiri.' using errcode = '42501';
  end if;
  select * into v_akun from public.akun where id = p_akun for update;
  if v_akun.id is null then
    raise exception 'Akun tidak ditemukan.' using errcode = '22023';
  end if;
  if coalesce(trim(p_konfirmasi), '') <> trim(v_akun.nama_tampilan) then
    raise exception 'Nama akun yang diketik tidak sama. Akun tidak dihapus.' using errcode = '22023';
  end if;

  if coalesce(p_hapus_profil, false) and v_akun.anggota_id is not null then
    delete from public.anggota where id = v_akun.anggota_id;
    v_profil_dihapus := true;
  end if;

  perform internal.catat_log('hapus_akun', jsonb_build_object(
    'akun_id', p_akun, 'anggota_id', v_akun.anggota_id, 'profil_dihapus', v_profil_dihapus));

  -- Menghapus akun login; baris akun, peran, profil staf, dan tautan atur
  -- ulangnya ikut terhapus. Profil anggota yang tidak dihapus tetap ada
  -- sebagai anggota tanpa akun.
  delete from auth.users where id = p_akun;
end;
$$;

revoke all on function public.izin_buat_akun(text, uuid, uuid)        from public, anon;
revoke all on function public.pasang_akun_baru(uuid, uuid)             from public, anon;
revoke all on function public.hapus_akun(uuid, text, boolean)          from public, anon;
grant execute on function public.izin_buat_akun(text, uuid, uuid)     to authenticated;
grant execute on function public.pasang_akun_baru(uuid, uuid)          to authenticated;
grant execute on function public.hapus_akun(uuid, text, boolean)       to authenticated;

revoke all on all functions in schema internal from public, anon, authenticated;
