-- =====================================================================
-- 31 · VERSI ALKITAB SAAT TEDUH DITAMBAH (keputusan 60)
--
-- Selain TB dan AMD: TSI, BIS, BIMK (dibuka di alkitab.sabda.org), serta KJV,
-- NKJV, NLT (dibuka di BibleGateway). Teks ayat tetap TIDAK disimpan.
-- Catatan yang sudah ada tidak berubah.
-- =====================================================================
alter table public.saat_teduh drop constraint if exists saat_teduh_versi_check;
alter table public.saat_teduh add constraint saat_teduh_versi_check
  check (versi in ('tb', 'amd', 'tsi', 'bis', 'bimk', 'kjv', 'nkjv', 'nlt'));
