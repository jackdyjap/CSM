-- =====================================================================
-- 12 · ADMIN BOLEH MENULIS CATATAN KHUSUS (keputusan 18, 17 November 2026)
-- Sebelumnya (keputusan 12 dan 15) Admin hanya membaca dan mengoreksi.
-- Kini Admin juga boleh menulis catatan baru di semua kelompok.
-- Tetap berlaku: Ketua Tim hanya membaca; tidak seorang pun boleh menulis
-- atau membaca catatan tentang dirinya sendiri.
-- =====================================================================
create or replace function bantu.boleh_tulis_catatan(p_anggota uuid)
returns boolean
language sql stable security definer
set search_path = ''
as $$
  -- kelompok_dipimpin() mencakup semua kelompok bila Admin (migrasi 0800).
  select p_anggota is distinct from bantu.anggota_saya()
     and exists (
       select 1 from public.anggota a
       where a.id = p_anggota
         and a.kelompok_id in (select bantu.kelompok_dipimpin())
     );
$$;
