# Data wilayah versi ringkas (untuk SQL Editor Supabase)

SQL Editor Supabase menolak query di atas sekitar 1 MB ("Query is too large"),
sedangkan `../wilayah_01..04.sql` berukuran 0,9–1,3 MB per file.

File di folder ini berisi **data yang sama persis** (91.599 wilayah), dalam bentuk
`kode|nama` per baris. Tingkat dan kode induk dihitung otomatis dari kode.
Ukurannya ±450 KB per file.

Cara memakai: jalankan `wilayah_ringkas_1.sql` sampai `wilayah_ringkas_5.sql`
**berurutan** di SQL Editor, satu per satu. Aman dijalankan ulang.

Sudah diuji: hasilnya identik baris demi baris dengan `../wilayah_01..04.sql`,
aman dijalankan dua kali, dan aman ditempel dengan akhiran baris Windows.
