-- =====================================================================
-- 04 · PENJAGA DAN LOKET KHUSUS
--
-- Bagian A: "penjaga" (trigger) yang otomatis memeriksa/merapikan data
--           setiap kali ada perubahan.
-- Bagian B: "loket" (fungsi) untuk tindakan yang harus diperiksa ketat
--           dan/atau dicatat: catatan khusus, check-in QR, laporan demografi.
-- =====================================================================


-- =====================================================================
-- BAGIAN A · PENJAGA
-- =====================================================================

-- A1. Isi kolom diubah_pada otomatis.
create function internal.isi_diubah_pada()
returns trigger language plpgsql set search_path = ''
as $$
begin
  new.diubah_pada := now();
  return new;
end;
$$;

create trigger isi_diubah_pada before update on public.anggota
  for each row execute function internal.isi_diubah_pada();
create trigger isi_diubah_pada before update on public.pertemuan
  for each row execute function internal.isi_diubah_pada();
create trigger isi_diubah_pada before update on public.catatan_khusus
  for each row execute function internal.isi_diubah_pada();
create trigger isi_diubah_pada before update on public.status_proyek
  for each row execute function internal.isi_diubah_pada();


-- A2. Penjaga profil anggota.
--   * Anggota yang mengubah profilnya sendiri TIDAK boleh mengubah:
--     kelompok, kode QR, status aktif, tanggal bergabung, atau persetujuan
--     yang sudah tercatat.
--   * Persetujuan: siapa dan kapan dicatat otomatis (tidak bisa dipalsukan).
--   * Anggota di bawah 18 tahun wajib ada persetujuan orang tua/wali.
--   * Status aktif dan tanggal dinonaktifkan selalu dirapikan.
create function internal.jaga_anggota()
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
    new.persetujuan_dicatat_akun := old.persetujuan_dicatat_akun;
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

create trigger jaga_anggota before insert or update on public.anggota
  for each row execute function internal.jaga_anggota();


-- A3. Saat anggota dihapus atau fotonya diganti: masukkan foto lama ke
--     antrean hapus, dan catat penghapusan anggota di log (tanpa nama).
create function internal.setelah_anggota_berubah()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  if tg_op = 'DELETE' then
    if old.foto_path is not null then
      insert into internal.antrean_hapus_foto (foto_path) values (old.foto_path);
    end if;
    perform internal.catat_log('hapus_anggota', jsonb_build_object('anggota_id', old.id));
    return old;
  end if;

  if old.foto_path is not null and new.foto_path is distinct from old.foto_path then
    insert into internal.antrean_hapus_foto (foto_path) values (old.foto_path);
  end if;
  return new;
end;
$$;

create trigger setelah_anggota_berubah after update or delete on public.anggota
  for each row execute function internal.setelah_anggota_berubah();


-- A4. Pertemuan baru otomatis mendapat kunci rahasia QR.
create function internal.buat_rahasia_pertemuan()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  insert into internal.pertemuan_rahasia (pertemuan_id, rahasia)
  values (new.id, encode(extensions.gen_random_bytes(32), 'hex'));
  return new;
end;
$$;

create trigger buat_rahasia_pertemuan after insert on public.pertemuan
  for each row execute function internal.buat_rahasia_pertemuan();


-- A5. Pertemuan dan proyek tidak boleh dipindah ke kelompok lain.
create function internal.cegah_pindah_kelompok()
returns trigger language plpgsql set search_path = ''
as $$
begin
  if new.kelompok_id is distinct from old.kelompok_id then
    raise exception 'Data ini tidak boleh dipindah ke kelompok lain.' using errcode = '42501';
  end if;
  return new;
end;
$$;

create trigger cegah_pindah_kelompok before update on public.pertemuan
  for each row execute function internal.cegah_pindah_kelompok();
create trigger cegah_pindah_kelompok before update on public.proyek_ketaatan
  for each row execute function internal.cegah_pindah_kelompok();


-- A6. Penjaga kehadiran:
--   * anggota harus berasal dari kelompok yang sama dengan pertemuannya;
--   * kelompok_id diisi otomatis dari pertemuan (tidak bisa dipalsukan);
--   * isian hadir/tidak hadir dirapikan.
create function internal.jaga_kehadiran()
returns trigger language plpgsql security definer set search_path = ''
as $$
declare
  v_kelompok_pertemuan uuid;
  v_kelompok_anggota   uuid;
begin
  select p.kelompok_id into v_kelompok_pertemuan
  from public.pertemuan p where p.id = new.pertemuan_id;

  if tg_op = 'INSERT'
     or new.pertemuan_id is distinct from old.pertemuan_id
     or new.anggota_id   is distinct from old.anggota_id then
    select a.kelompok_id into v_kelompok_anggota
    from public.anggota a where a.id = new.anggota_id;

    if v_kelompok_anggota is distinct from v_kelompok_pertemuan then
      raise exception 'Anggota ini bukan anggota kelompok pertemuan tersebut.' using errcode = '23514';
    end if;
  end if;

  new.kelompok_id := v_kelompok_pertemuan;

  if new.hadir then
    new.cara := coalesce(new.cara, 'manual');
    new.alasan := null;
    new.alasan_catatan := null;
  else
    new.cara := null;
  end if;

  if tg_op = 'INSERT' then
    new.dicatat_oleh := coalesce(new.dicatat_oleh, auth.uid());
  end if;
  return new;
end;
$$;

create trigger jaga_kehadiran before insert or update on public.kehadiran
  for each row execute function internal.jaga_kehadiran();


-- A7. Anggota tidak aktif yang hadir kembali otomatis menjadi aktif.
create function internal.aktifkan_kembali()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  if new.hadir then
    update public.anggota
       set aktif = true, dinonaktifkan_pada = null
     where id = new.anggota_id and not aktif;
  end if;
  return new;
end;
$$;

create trigger aktifkan_kembali after insert or update of hadir on public.kehadiran
  for each row execute function internal.aktifkan_kembali();


-- A8. Penjaga status proyek: anggota harus dari kelompok proyek tersebut.
create function internal.jaga_status_proyek()
returns trigger language plpgsql security definer set search_path = ''
as $$
declare
  v_kelompok_proyek  uuid;
  v_kelompok_anggota uuid;
begin
  select p.kelompok_id into v_kelompok_proyek
  from public.proyek_ketaatan p where p.id = new.proyek_id;

  if tg_op = 'INSERT'
     or new.proyek_id  is distinct from old.proyek_id
     or new.anggota_id is distinct from old.anggota_id then
    select a.kelompok_id into v_kelompok_anggota
    from public.anggota a where a.id = new.anggota_id;

    if v_kelompok_anggota is distinct from v_kelompok_proyek then
      raise exception 'Anggota ini bukan anggota kelompok proyek tersebut.' using errcode = '23514';
    end if;
  end if;

  new.kelompok_id := v_kelompok_proyek;
  return new;
end;
$$;

create trigger jaga_status_proyek before insert or update on public.status_proyek
  for each row execute function internal.jaga_status_proyek();


-- A9. Setiap perubahan peran dicatat di log.
create function internal.log_perubahan_peran()
returns trigger language plpgsql security definer set search_path = ''
as $$
declare
  v_baris public.penugasan_peran := case when tg_op = 'DELETE' then old else new end;
begin
  perform internal.catat_log('ubah_peran', jsonb_build_object(
    'aksi',        lower(tg_op),
    'akun_id',     v_baris.akun_id,
    'peran',       v_baris.peran,
    'jabatan',     v_baris.jabatan,
    'tim_id',      v_baris.tim_id,
    'kelompok_id', v_baris.kelompok_id
  ));
  return v_baris;
end;
$$;

create trigger log_perubahan_peran after insert or update or delete on public.penugasan_peran
  for each row execute function internal.log_perubahan_peran();


-- =====================================================================
-- BAGIAN B · LOKET KHUSUS (dipanggil dari aplikasi)
-- =====================================================================

-- ---------------------------------------------------------------------
-- B1. CATATAN KHUSUS
-- Aturan: pemimpin/wakil menulis untuk kelompoknya; pemimpin, ketua tim
-- terkait, dan Admin membaca. Tidak seorang pun bisa membaca atau menulis
-- catatan tentang dirinya sendiri. Setiap tindakan dicatat di log.
-- ---------------------------------------------------------------------
create function public.tulis_catatan(
  p_anggota uuid,
  p_jenis   public.jenis_catatan,
  p_isi     text,
  p_tanggal date default null
)
returns uuid
language plpgsql security definer set search_path = ''
as $$
declare
  v_id uuid;
begin
  if not bantu.boleh_kelola_anggota(p_anggota) or p_anggota = bantu.anggota_saya() then
    raise exception 'Anda tidak berhak menulis catatan untuk anggota ini.' using errcode = '42501';
  end if;

  insert into public.catatan_khusus (anggota_id, penulis_id, tanggal, jenis, isi)
  values (p_anggota, auth.uid(), coalesce(p_tanggal, bantu.hari_ini_wib()), p_jenis, trim(p_isi))
  returning id into v_id;

  perform internal.catat_log('tulis_catatan',
    jsonb_build_object('catatan_id', v_id, 'anggota_id', p_anggota));
  return v_id;
end;
$$;

create function public.ubah_catatan(
  p_catatan uuid,
  p_isi     text,
  p_jenis   public.jenis_catatan default null
)
returns void
language plpgsql security definer set search_path = ''
as $$
declare
  v_anggota uuid;
begin
  select c.anggota_id into v_anggota from public.catatan_khusus c where c.id = p_catatan;
  if v_anggota is null or not bantu.boleh_kelola_anggota(v_anggota)
     or v_anggota = bantu.anggota_saya() then
    raise exception 'Catatan tidak ditemukan atau Anda tidak berhak mengubahnya.' using errcode = '42501';
  end if;

  update public.catatan_khusus
     set isi = trim(p_isi), jenis = coalesce(p_jenis, jenis)
   where id = p_catatan;

  perform internal.catat_log('ubah_catatan',
    jsonb_build_object('catatan_id', p_catatan, 'anggota_id', v_anggota));
end;
$$;

create function public.hapus_catatan(p_catatan uuid)
returns void
language plpgsql security definer set search_path = ''
as $$
declare
  v_anggota uuid;
begin
  select c.anggota_id into v_anggota from public.catatan_khusus c where c.id = p_catatan;
  if v_anggota is null or not bantu.boleh_kelola_anggota(v_anggota)
     or v_anggota = bantu.anggota_saya() then
    raise exception 'Catatan tidak ditemukan atau Anda tidak berhak menghapusnya.' using errcode = '42501';
  end if;

  delete from public.catatan_khusus where id = p_catatan;

  perform internal.catat_log('hapus_catatan',
    jsonb_build_object('catatan_id', p_catatan, 'anggota_id', v_anggota));
end;
$$;

create function public.baca_catatan(p_anggota uuid)
returns table (
  id           uuid,
  tanggal      date,
  jenis        public.jenis_catatan,
  isi          text,
  penulis_nama text,
  dibuat_pada  timestamptz,
  diubah_pada  timestamptz
)
language plpgsql security definer set search_path = ''
as $$
#variable_conflict use_column
begin
  if p_anggota = bantu.anggota_saya() or not exists (
       select 1 from public.anggota a
       where a.id = p_anggota and a.kelompok_id in (select bantu.kelompok_terbaca())) then
    raise exception 'Anda tidak berhak membaca catatan anggota ini.' using errcode = '42501';
  end if;

  perform internal.catat_log('baca_catatan', jsonb_build_object('anggota_id', p_anggota));

  return query
    select c.id, c.tanggal, c.jenis, c.isi, ak.nama_tampilan, c.dibuat_pada, c.diubah_pada
    from public.catatan_khusus c
    left join public.akun ak on ak.id = c.penulis_id
    where c.anggota_id = p_anggota
    order by c.tanggal desc, c.dibuat_pada desc;
end;
$$;


-- ---------------------------------------------------------------------
-- B2. QR PERTEMUAN YANG BERGANTI OTOMATIS
-- Kode berganti setiap 45 detik. Kode dibuat dari kunci rahasia pertemuan
-- yang tidak pernah keluar dari database, sehingga tidak bisa ditebak.
-- Kode yang sedang tampil dan kode sebelumnya diterima (jeda untuk
-- koneksi lambat); kode yang lebih lama ditolak.
-- ---------------------------------------------------------------------
create function internal.jendela_qr(p_waktu timestamptz default now())
returns bigint
language sql stable set search_path = ''
as $$ select floor(extract(epoch from p_waktu) / 45)::bigint $$;

create function internal.kode_qr_pertemuan(p_pertemuan uuid, p_rahasia text, p_jendela bigint)
returns text
language sql immutable set search_path = ''
as $$
  select left(encode(extensions.hmac(p_pertemuan::text || ':' || p_jendela::text,
                                     p_rahasia, 'sha256'), 'hex'), 20)
$$;

-- Dipanggil layar pemimpin untuk menampilkan QR yang sedang berlaku.
create function public.token_qr_pertemuan(p_pertemuan uuid)
returns table (kode text, sisa_detik integer)
language plpgsql security definer set search_path = ''
as $$
declare
  v_rahasia text;
begin
  select s.rahasia into v_rahasia
  from public.pertemuan p
  join internal.pertemuan_rahasia s on s.pertemuan_id = p.id
  where p.id = p_pertemuan
    and p.kelompok_id in (select bantu.kelompok_dipimpin())
    and p.tanggal = bantu.hari_ini_wib()
    and p.dibuka_pada is not null
    and p.ditutup_pada is null;

  if v_rahasia is null then
    raise exception 'Pertemuan tidak ditemukan, bukan hari ini, belum dibuka, atau sudah ditutup.'
      using errcode = '42501';
  end if;

  return query select
    internal.kode_qr_pertemuan(p_pertemuan, v_rahasia, internal.jendela_qr()),
    (45 - (floor(extract(epoch from now()))::bigint % 45))::integer;
end;
$$;

-- Dipanggil HP anggota setelah men-scan QR di layar.
create function public.check_in(p_kode text)
returns table (pertemuan_id uuid, tanggal date, kelompok_nama text)
language plpgsql security definer set search_path = ''
as $$
#variable_conflict use_column
declare
  v_anggota  uuid := bantu.anggota_saya();
  v_kelompok uuid;
  v_jendela  bigint := internal.jendela_qr();
  v_kode     text := lower(trim(coalesce(p_kode, '')));
  v_ketemu   uuid;
  r          record;
begin
  if v_anggota is null then
    raise exception 'Akun Anda belum terhubung ke profil anggota.' using errcode = '42501';
  end if;

  select a.kelompok_id into v_kelompok from public.anggota a where a.id = v_anggota;

  -- Hanya pertemuan KELOMPOK SENDIRI, HARI INI, yang SEDANG DIBUKA.
  for r in
    select p.id, s.rahasia
    from public.pertemuan p
    join internal.pertemuan_rahasia s on s.pertemuan_id = p.id
    where p.kelompok_id = v_kelompok
      and p.tanggal = bantu.hari_ini_wib()
      and p.dibuka_pada is not null
      and p.ditutup_pada is null
  loop
    if v_kode in (internal.kode_qr_pertemuan(r.id, r.rahasia, v_jendela),
                  internal.kode_qr_pertemuan(r.id, r.rahasia, v_jendela - 1)) then
      v_ketemu := r.id;
      exit;
    end if;
  end loop;

  if v_ketemu is null then
    raise exception 'Kode QR tidak berlaku atau sudah kedaluwarsa. Silakan scan ulang QR di layar.'
      using errcode = '22023';
  end if;

  if exists (select 1 from public.kehadiran k
             where k.pertemuan_id = v_ketemu and k.anggota_id = v_anggota and k.hadir) then
    raise exception 'Anda sudah tercatat hadir di pertemuan ini.' using errcode = '23505';
  end if;

  insert into public.kehadiran (pertemuan_id, anggota_id, hadir, waktu, cara, dicatat_oleh)
  values (v_ketemu, v_anggota, true, now(), 'scan_sendiri', auth.uid())
  on conflict on constraint kehadiran_unik do update
    set hadir = true, waktu = now(), cara = 'scan_sendiri',
        alasan = null, alasan_catatan = null, dicatat_oleh = auth.uid();

  return query
    select p.id, p.tanggal, k.nama
    from public.pertemuan p join public.kelompok k on k.id = p.kelompok_id
    where p.id = v_ketemu;
end;
$$;


-- ---------------------------------------------------------------------
-- B3. PEMIMPIN MEN-SCAN KARTU QR ANGGOTA
-- ---------------------------------------------------------------------
create function public.scan_kartu_anggota(p_pertemuan uuid, p_kode_kartu text)
returns table (anggota_id uuid, nama_lengkap text, sudah_tercatat boolean)
language plpgsql security definer set search_path = ''
as $$
#variable_conflict use_column
declare
  v_kelompok uuid;
  v_anggota  uuid;
  v_nama     text;
  v_sudah    boolean;
begin
  select p.kelompok_id into v_kelompok
  from public.pertemuan p
  where p.id = p_pertemuan and p.kelompok_id in (select bantu.kelompok_dipimpin());

  if v_kelompok is null then
    raise exception 'Pertemuan tidak ditemukan atau bukan kelompok Anda.' using errcode = '42501';
  end if;

  select a.id, a.nama_lengkap into v_anggota, v_nama
  from public.anggota a
  where a.kode_qr = lower(trim(p_kode_kartu)) and a.kelompok_id = v_kelompok;

  if v_anggota is null then
    raise exception 'Kartu tidak dikenal atau bukan anggota kelompok ini.' using errcode = '22023';
  end if;

  select coalesce(bool_or(k.hadir), false) into v_sudah
  from public.kehadiran k where k.pertemuan_id = p_pertemuan and k.anggota_id = v_anggota;

  if not v_sudah then
    insert into public.kehadiran (pertemuan_id, anggota_id, hadir, waktu, cara, dicatat_oleh)
    values (p_pertemuan, v_anggota, true, now(), 'scan_pemimpin', auth.uid())
    on conflict on constraint kehadiran_unik do update
      set hadir = true, waktu = now(), cara = 'scan_pemimpin',
          alasan = null, alasan_catatan = null, dicatat_oleh = auth.uid();
  end if;

  return query select v_anggota, v_nama, v_sudah;
end;
$$;


-- ---------------------------------------------------------------------
-- B3b. RIWAYAT KEHADIRAN SAYA (untuk anggota)
-- Menampilkan tanggal, hadir/tidak, cara, dan kategori alasan.
-- Catatan alasan yang ditulis pemimpin TIDAK ditampilkan.
-- ---------------------------------------------------------------------
create function public.riwayat_kehadiran_saya(p_jumlah integer default 52)
returns table (
  tanggal       date,
  kelompok_nama text,
  hadir         boolean,
  cara          public.cara_absen,
  alasan        public.alasan_absen
)
language sql stable security definer set search_path = ''
as $$
  select p.tanggal, k.nama, h.hadir, h.cara, h.alasan
  from public.kehadiran h
  join public.pertemuan p on p.id = h.pertemuan_id
  join public.kelompok  k on k.id = p.kelompok_id
  where h.anggota_id = bantu.anggota_saya()
  order by p.tanggal desc
  limit least(greatest(coalesce(p_jumlah, 52), 1), 520);
$$;


-- ---------------------------------------------------------------------
-- B4. LAPORAN DEMOGRAFI (khusus Admin)
-- Dihitung di database; aplikasi hanya menerima angka ringkasan per
-- kelompok. "Belum diisi" dipisah, dan persentase dihitung dari yang
-- sudah mengisi.
--   p_dimensi : gender | pendidikan | status_nikah | pekerjaan |
--               provinsi | kota | kecamatan | kelurahan | rentang_usia
--   p_cakupan : semua | tim | kelompok  (+ p_cakupan_id untuk tim/kelompok)
-- ---------------------------------------------------------------------
create function internal.rentang_usia(p_lahir date)
returns text
language sql stable set search_path = ''
as $$
  select case
    when p_lahir is null then null
    when u < 13 then '0-12'
    when u < 18 then '13-17'
    when u < 25 then '18-24'
    when u < 35 then '25-34'
    when u < 45 then '35-44'
    when u < 55 then '45-54'
    when u < 65 then '55-64'
    else '65+'
  end
  from (select extract(year from age(bantu.hari_ini_wib(), p_lahir))::int as u) x;
$$;

create function public.laporan_demografi(
  p_dimensi     text,
  p_cakupan     text    default 'semua',
  p_cakupan_id  uuid    default null,
  p_hanya_aktif boolean default true
)
returns table (
  tim_nama      text,
  kelompok_id   uuid,
  kelompok_nama text,
  kunci         text,     -- nilai mentah (mis. 's1' atau kode wilayah)
  label         text,     -- teks tampilan (mis. nama kota); 'Belum diisi' bila kosong
  jumlah        bigint,
  persen        numeric   -- null untuk baris 'Belum diisi'
)
language plpgsql security definer set search_path = ''
as $$
#variable_conflict use_column
begin
  if not bantu.saya_admin() then
    raise exception 'Laporan demografi hanya dapat dibuka oleh Admin.' using errcode = '42501';
  end if;
  if p_dimensi not in ('gender','pendidikan','status_nikah','pekerjaan',
                       'provinsi','kota','kecamatan','kelurahan','rentang_usia') then
    raise exception 'Dimensi tidak dikenal: %', p_dimensi using errcode = '22023';
  end if;
  if p_cakupan not in ('semua','tim','kelompok')
     or (p_cakupan <> 'semua' and p_cakupan_id is null) then
    raise exception 'Cakupan laporan tidak valid.' using errcode = '22023';
  end if;

  perform internal.catat_log('buat_laporan_demografi', jsonb_build_object(
    'dimensi', p_dimensi, 'cakupan', p_cakupan,
    'cakupan_id', p_cakupan_id, 'hanya_aktif', p_hanya_aktif));

  return query
  with data as (
    select t.nama as t_nama, k.id as k_id, k.nama as k_nama,
      case p_dimensi
        when 'gender'       then a.gender::text
        when 'pendidikan'   then a.pendidikan::text
        when 'status_nikah' then a.status_nikah::text
        when 'pekerjaan'    then a.pekerjaan::text
        when 'provinsi'     then a.provinsi_kode
        when 'kota'         then a.kota_kode
        when 'kecamatan'    then a.kecamatan_kode
        when 'kelurahan'    then a.kelurahan_kode
        when 'rentang_usia' then internal.rentang_usia(a.tanggal_lahir)
      end as v
    from public.anggota a
    join public.kelompok k on k.id = a.kelompok_id
    join public.tim t      on t.id = k.tim_id
    where (not p_hanya_aktif or a.aktif)
      and (p_cakupan = 'semua'
           or (p_cakupan = 'tim'      and k.tim_id = p_cakupan_id)
           or (p_cakupan = 'kelompok' and k.id     = p_cakupan_id))
  ),
  hitung as (
    select d.t_nama, d.k_id, d.k_nama, d.v, count(*) as n
    from data d group by d.t_nama, d.k_id, d.k_nama, d.v
  )
  select h.t_nama, h.k_id, h.k_nama, h.v,
         case when h.v is null then 'Belum diisi'
              when p_dimensi in ('provinsi','kota','kecamatan','kelurahan')
                then coalesce(w.nama, h.v)
              else h.v end,
         h.n,
         case when h.v is null then null
              else round(100.0 * h.n / nullif(sum(h.n) filter (where h.v is not null)
                                              over (partition by h.k_id), 0), 1) end
  from hitung h
  left join public.wilayah w on w.kode = h.v
  order by h.t_nama, h.k_nama, (h.v is null), h.v;
end;
$$;

-- Dipanggil aplikasi setiap kali Admin mengekspor laporan (Excel/CSV/PDF).
create function public.catat_ekspor_laporan(p_format text, p_parameter jsonb default '{}'::jsonb)
returns void
language plpgsql security definer set search_path = ''
as $$
begin
  if not bantu.saya_admin() then
    raise exception 'Hanya Admin yang dapat mengekspor laporan.' using errcode = '42501';
  end if;
  if p_format not in ('xlsx', 'csv', 'pdf') then
    raise exception 'Format ekspor tidak dikenal: %', p_format using errcode = '22023';
  end if;
  perform internal.catat_log('ekspor_laporan',
    jsonb_build_object('format', p_format, 'parameter', coalesce(p_parameter, '{}'::jsonb)));
end;
$$;


-- ---------------------------------------------------------------------
-- HAK MEMANGGIL LOKET
-- Hanya pengguna yang sudah login; tamu (anon) tidak bisa memanggil apa pun.
-- Fungsi di ruang internal tidak bisa dipanggil pengguna sama sekali.
-- ---------------------------------------------------------------------
revoke all on all functions in schema public   from public, anon;
grant execute on all functions in schema public to authenticated;
revoke all on all functions in schema internal from public, anon, authenticated;
