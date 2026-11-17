-- Data wilayah Indonesia, versi RINGKAS untuk SQL Editor Supabase: bagian 1 dari 5.
-- Isi sama dengan data/wilayah_01..04.sql (Kepmendagri No 300.2.2-2138 Tahun 2025).
-- Sumber: github.com/cahyadsn/wilayah (Lisensi MIT, (c) 2017-2025 Cahya DSN).
-- Jalankan BERURUTAN mulai bagian 1. Aman dijalankan ulang.
-- Setiap baris: kode|nama. Tingkat dan kode induk dihitung dari kode.
insert into public.wilayah (kode, nama, tingkat, induk_kode)
select kode, nama,
       (case length(kode) when 2 then 'provinsi' when 5 then 'kota'
                          when 8 then 'kecamatan' else 'kelurahan' end)::public.tingkat_wilayah,
       case when length(kode) = 2 then null else regexp_replace(kode, '\.[^.]+$', '') end
from (
  select split_part(baris, '|', 1) as kode, split_part(baris, '|', 2) as nama
  from regexp_split_to_table($wilayah$
11|Aceh
12|Sumatera Utara
13|Sumatera Barat
14|Riau
15|Jambi
16|Sumatera Selatan
17|Bengkulu
18|Lampung
19|Kepulauan Bangka Belitung
21|Kepulauan Riau
31|Daerah Khusus Ibukota Jakarta
32|Jawa Barat
33|Jawa Tengah
34|Daerah Istimewa Yogyakarta
35|Jawa Timur
36|Banten
51|Bali
52|Nusa Tenggara Barat
53|Nusa Tenggara Timur
61|Kalimantan Barat
62|Kalimantan Tengah
63|Kalimantan Selatan
64|Kalimantan Timur
65|Kalimantan Utara
71|Sulawesi Utara
72|Sulawesi Tengah
73|Sulawesi Selatan
74|Sulawesi Tenggara
75|Gorontalo
76|Sulawesi Barat
81|Maluku
82|Maluku Utara
91|Papua
92|Papua Barat
93|Papua Selatan
94|Papua Tengah
95|Papua Pegunungan
96|Papua Barat Daya
11.01|Kabupaten Aceh Selatan
11.02|Kabupaten Aceh Tenggara
11.03|Kabupaten Aceh Timur
11.04|Kabupaten Aceh Tengah
11.05|Kabupaten Aceh Barat
11.06|Kabupaten Aceh Besar
11.07|Kabupaten Pidie
11.08|Kabupaten Aceh Utara
11.09|Kabupaten Simeulue
11.10|Kabupaten Aceh Singkil
11.11|Kabupaten Bireuen
11.12|Kabupaten Aceh Barat Daya
11.13|Kabupaten Gayo Lues
11.14|Kabupaten Aceh Jaya
11.15|Kabupaten Nagan Raya
11.16|Kabupaten Aceh Tamiang
11.17|Kabupaten Bener Meriah
11.18|Kabupaten Pidie Jaya
11.71|Kota Banda Aceh
11.72|Kota Sabang
11.73|Kota Lhokseumawe
11.74|Kota Langsa
11.75|Kota Subulussalam
12.01|Kabupaten Tapanuli Tengah
12.02|Kabupaten Tapanuli Utara
12.03|Kabupaten Tapanuli Selatan
12.04|Kabupaten Nias
12.05|Kabupaten Langkat
12.06|Kabupaten Karo
12.07|Kabupaten Deli Serdang
12.08|Kabupaten Simalungun
12.09|Kabupaten Asahan
12.10|Kabupaten Labuhanbatu
12.11|Kabupaten Dairi
12.12|Kabupaten Toba
12.13|Kabupaten Mandailing Natal
12.14|Kabupaten Nias Selatan
12.15|Kabupaten Pakpak Bharat
12.16|Kabupaten Humbang Hasundutan
12.17|Kabupaten Samosir
12.18|Kabupaten Serdang Bedagai
12.19|Kabupaten Batu Bara
12.20|Kabupaten Padang Lawas Utara
12.21|Kabupaten Padang Lawas
12.22|Kabupaten Labuhanbatu Selatan
12.23|Kabupaten Labuhanbatu Utara
12.24|Kabupaten Nias Utara
12.25|Kabupaten Nias Barat
12.71|Kota Medan
12.72|Kota Pematangsiantar
12.73|Kota Sibolga
12.74|Kota Tanjungbalai
12.75|Kota Binjai
12.76|Kota Tebing Tinggi
12.77|Kota Padangsidimpuan
12.78|Kota Gunungsitoli
13.01|Kabupaten Pesisir Selatan
13.02|Kabupaten Solok
13.03|Kabupaten Sijunjung
13.04|Kabupaten Tanah Datar
13.05|Kabupaten Padang Pariaman
13.06|Kabupaten Agam
13.07|Kabupaten Lima Puluh Kota
13.08|Kabupaten Pasaman
13.09|Kabupaten Kepulauan Mentawai
13.10|Kabupaten Dharmasraya
13.11|Kabupaten Solok Selatan
13.12|Kabupaten Pasaman Barat
13.71|Kota Padang
13.72|Kota Solok
13.73|Kota Sawahlunto
13.74|Kota Padang Panjang
13.75|Kota Bukittinggi
13.76|Kota Payakumbuh
13.77|Kota Pariaman
14.01|Kabupaten Kampar
14.02|Kabupaten Indragiri Hulu
14.03|Kabupaten Bengkalis
14.04|Kabupaten Indragiri Hilir
14.05|Kabupaten Pelalawan
14.06|Kabupaten Rokan Hulu
14.07|Kabupaten Rokan Hilir
14.08|Kabupaten Siak
14.09|Kabupaten Kuantan Singingi
14.10|Kabupaten Kepulauan Meranti
14.71|Kota Pekanbaru
14.72|Kota Dumai
15.01|Kabupaten Kerinci
15.02|Kabupaten Merangin
15.03|Kabupaten Sarolangun
15.04|Kabupaten Batanghari
15.05|Kabupaten Muaro Jambi
15.06|Kabupaten Tanjung Jabung Barat
15.07|Kabupaten Tanjung Jabung Timur
15.08|Kabupaten Bungo
15.09|Kabupaten Tebo
15.71|Kota Jambi
15.72|Kota Sungai Penuh
16.01|Kabupaten Ogan Komering Ulu
16.02|Kabupaten Ogan Komering Ilir
16.03|Kabupaten Muara Enim
16.04|Kabupaten Lahat
16.05|Kabupaten Musi Rawas
16.06|Kabupaten Musi Banyuasin
16.07|Kabupaten Banyuasin
16.08|Kabupaten Ogan Komering Ulu Timur
16.09|Kabupaten Ogan Komering Ulu Selatan
16.10|Kabupaten Ogan Ilir
16.11|Kabupaten Empat Lawang
16.12|Kabupaten Penukal Abab Lematang Ilir
16.13|Kabupaten Musi Rawas Utara
16.71|Kota Palembang
16.72|Kota Pagar Alam
16.73|Kota Lubuk Linggau
16.74|Kota Prabumulih
17.01|Kabupaten Bengkulu Selatan
17.02|Kabupaten Rejang Lebong
17.03|Kabupaten Bengkulu Utara
17.04|Kabupaten Kaur
17.05|Kabupaten Seluma
17.06|Kabupaten Mukomuko
17.07|Kabupaten Lebong
17.08|Kabupaten Kepahiang
17.09|Kabupaten Bengkulu Tengah
17.71|Kota Bengkulu
18.01|Kabupaten Lampung Selatan
18.02|Kabupaten Lampung Tengah
18.03|Kabupaten Lampung Utara
18.04|Kabupaten Lampung Barat
18.05|Kabupaten Tulang Bawang
18.06|Kabupaten Tanggamus
18.07|Kabupaten Lampung Timur
18.08|Kabupaten Way Kanan
18.09|Kabupaten Pesawaran
18.10|Kabupaten Pringsewu
18.11|Kabupaten Mesuji
18.12|Kabupaten Tulang Bawang Barat
18.13|Kabupaten Pesisir Barat
18.71|Kota Bandar Lampung
18.72|Kota Metro
19.01|Kabupaten Bangka
19.02|Kabupaten Belitung
19.03|Kabupaten Bangka Selatan
19.04|Kabupaten Bangka Tengah
19.05|Kabupaten Bangka Barat
19.06|Kabupaten Belitung Timur
19.71|Kota Pangkal Pinang
21.01|Kabupaten Bintan
21.02|Kabupaten Karimun
21.03|Kabupaten Natuna
21.04|Kabupaten Lingga
21.05|Kabupaten Kepulauan Anambas
21.71|Kota Batam
21.72|Kota Tanjung Pinang
31.01|Kabupaten Administrasi Kepulauan Seribu
31.71|Kota Administrasi Jakarta Pusat
31.72|Kota Administrasi Jakarta Utara 
31.73|Kota Administrasi Jakarta Barat
31.74|Kota Administrasi Jakarta Selatan
31.75|Kota Administrasi Jakarta Timur
32.01|Kabupaten Bogor
32.02|Kabupaten Sukabumi
32.03|Kabupaten Cianjur
32.04|Kabupaten Bandung
32.05|Kabupaten Garut
32.06|Kabupaten Tasikmalaya
32.07|Kabupaten Ciamis
32.08|Kabupaten Kuningan
32.09|Kabupaten Cirebon
32.10|Kabupaten Majalengka
32.11|Kabupaten Sumedang
32.12|Kabupaten Indramayu
32.13|Kabupaten Subang
32.14|Kabupaten Purwakarta
32.15|Kabupaten Karawang
32.16|Kabupaten Bekasi
32.17|Kabupaten Bandung Barat
32.18|Kabupaten Pangandaran
32.71|Kota Bogor
32.72|Kota Sukabumi
32.73|Kota Bandung
32.74|Kota Cirebon
32.75|Kota Bekasi
32.76|Kota Depok
32.77|Kota Cimahi
32.78|Kota Tasikmalaya
32.79|Kota Banjar
33.01|Kabupaten Cilacap
33.02|Kabupaten Banyumas
33.03|Kabupaten Purbalingga
33.04|Kabupaten Banjarnegara
33.05|Kabupaten Kebumen
33.06|Kabupaten Purworejo
33.07|Kabupaten Wonosobo
33.08|Kabupaten Magelang
33.09|Kabupaten Boyolali
33.10|Kabupaten Klaten
33.11|Kabupaten Sukoharjo
33.12|Kabupaten Wonogiri
33.13|Kabupaten Karanganyar
33.14|Kabupaten Sragen
33.15|Kabupaten Grobogan
33.16|Kabupaten Blora
33.17|Kabupaten Rembang
33.18|Kabupaten Pati
33.19|Kabupaten Kudus
33.20|Kabupaten Jepara
33.21|Kabupaten Demak
33.22|Kabupaten Semarang
33.23|Kabupaten Temanggung
33.24|Kabupaten Kendal
33.25|Kabupaten Batang
33.26|Kabupaten Pekalongan
33.27|Kabupaten Pemalang
33.28|Kabupaten Tegal
33.29|Kabupaten Brebes
33.71|Kota Magelang
33.72|Kota Surakarta
33.73|Kota Salatiga
33.74|Kota Semarang
33.75|Kota Pekalongan
33.76|Kota Tegal
34.01|Kabupaten Kulon Progo
34.02|Kabupaten Bantul
34.03|Kabupaten Gunungkidul
34.04|Kabupaten Sleman
34.71|Kota Yogyakarta
35.01|Kabupaten Pacitan
35.02|Kabupaten Ponorogo
35.03|Kabupaten Trenggalek
35.04|Kabupaten Tulungagung
35.05|Kabupaten Blitar
35.06|Kabupaten Kediri
35.07|Kabupaten Malang
35.08|Kabupaten Lumajang
35.09|Kabupaten Jember
35.10|Kabupaten Banyuwangi
35.11|Kabupaten Bondowoso
35.12|Kabupaten Situbondo
35.13|Kabupaten Probolinggo
35.14|Kabupaten Pasuruan
35.15|Kabupaten Sidoarjo
35.16|Kabupaten Mojokerto
35.17|Kabupaten Jombang
35.18|Kabupaten Nganjuk
35.19|Kabupaten Madiun
35.20|Kabupaten Magetan
35.21|Kabupaten Ngawi
35.22|Kabupaten Bojonegoro
35.23|Kabupaten Tuban
35.24|Kabupaten Lamongan
35.25|Kabupaten Gresik
35.26|Kabupaten Bangkalan
35.27|Kabupaten Sampang
35.28|Kabupaten Pamekasan
35.29|Kabupaten Sumenep
35.71|Kota Kediri
35.72|Kota Blitar
35.73|Kota Malang
35.74|Kota Probolinggo
35.75|Kota Pasuruan
35.76|Kota Mojokerto
35.77|Kota Madiun
35.78|Kota Surabaya
35.79|Kota Batu
36.01|Kabupaten Pandeglang
36.02|Kabupaten Lebak
36.03|Kabupaten Tangerang
36.04|Kabupaten Serang
36.71|Kota Tangerang
36.72|Kota Cilegon
36.73|Kota Serang
36.74|Kota Tangerang Selatan
51.01|Kabupaten Jembrana
51.02|Kabupaten Tabanan
51.03|Kabupaten Badung
51.04|Kabupaten Gianyar
51.05|Kabupaten Klungkung
51.06|Kabupaten Bangli
51.07|Kabupaten Karangasem
51.08|Kabupaten Buleleng
51.71|Kota Denpasar
52.01|Kabupaten Lombok Barat
52.02|Kabupaten Lombok Tengah
52.03|Kabupaten Lombok Timur
52.04|Kabupaten Sumbawa
52.05|Kabupaten Dompu
52.06|Kabupaten Bima
52.07|Kabupaten Sumbawa Barat
52.08|Kabupaten Lombok Utara
52.71|Kota Mataram
52.72|Kota Bima
53.01|Kabupaten Kupang
53.02|Kabupaten Timor Tengah Selatan
53.03|Kabupaten Timor Tengah Utara
53.04|Kabupaten Belu
53.05|Kabupaten Alor
53.06|Kabupaten Flores Timur
53.07|Kabupaten Sikka
53.08|Kabupaten Ende
53.09|Kabupaten Ngada
53.10|Kabupaten Manggarai
53.11|Kabupaten Sumba Timur
53.12|Kabupaten Sumba Barat
53.13|Kabupaten Lembata
53.14|Kabupaten Rote Ndao
53.15|Kabupaten Manggarai Barat
53.16|Kabupaten Nagekeo
53.17|Kabupaten Sumba Tengah
53.18|Kabupaten Sumba Barat Daya
53.19|Kabupaten Manggarai Timur
53.20|Kabupaten Sabu Raijua
53.21|Kabupaten Malaka
53.71|Kota Kupang
61.01|Kabupaten Sambas
61.02|Kabupaten Mempawah
61.03|Kabupaten Sanggau
61.04|Kabupaten Ketapang
61.05|Kabupaten Sintang
61.06|Kabupaten Kapuas Hulu
61.07|Kabupaten Bengkayang
61.08|Kabupaten Landak
61.09|Kabupaten Sekadau
61.10|Kabupaten Melawi
61.11|Kabupaten Kayong Utara
61.12|Kabupaten Kubu Raya
61.71|Kota Pontianak
61.72|Kota Singkawang
62.01|Kabupaten Kotawaringin Barat
62.02|Kabupaten Kotawaringin Timur
62.03|Kabupaten Kapuas
62.04|Kabupaten Barito Selatan
62.05|Kabupaten Barito Utara
62.06|Kabupaten Katingan
62.07|Kabupaten Seruyan
62.08|Kabupaten Sukamara
62.09|Kabupaten Lamandau
62.10|Kabupaten Gunung Mas
62.11|Kabupaten Pulang Pisau
62.12|Kabupaten Murung Raya
62.13|Kabupaten Barito Timur
62.71|Kota Palangkaraya
63.01|Kabupaten Tanah Laut
63.02|Kabupaten Kotabaru
63.03|Kabupaten Banjar
63.04|Kabupaten Barito Kuala
63.05|Kabupaten Tapin
63.06|Kabupaten Hulu Sungai Selatan
63.07|Kabupaten Hulu Sungai Tengah
63.08|Kabupaten Hulu Sungai Utara
63.09|Kabupaten Tabalong
63.10|Kabupaten Tanah Bumbu
63.11|Kabupaten Balangan
63.71|Kota Banjarmasin
63.72|Kota Banjarbaru
64.01|Kabupaten Paser
64.02|Kabupaten Kutai Kartanegara
64.03|Kabupaten Berau
64.07|Kabupaten Kutai Barat
64.08|Kabupaten Kutai Timur
64.09|Kabupaten Penajam Paser Utara
64.11|Kabupaten Mahakam Ulu
64.71|Kota Balikpapan
64.72|Kota Samarinda
64.74|Kota Bontang
65.01|Kabupaten Bulungan
65.02|Kabupaten Malinau
65.03|Kabupaten Nunukan
65.04|Kabupaten Tana Tidung
65.71|Kota Tarakan
71.01|Kabupaten Bolaang Mongondow
71.02|Kabupaten Minahasa
71.03|Kabupaten Kepulauan Sangihe
71.04|Kabupaten Kepulauan Talaud
71.05|Kabupaten Minahasa Selatan
71.06|Kabupaten Minahasa Utara
71.07|Kabupaten Minahasa Tenggara
71.08|Kabupaten Bolaang Mongondow Utara
71.09|Kabupaten Kep. Siau Tagulandang Biaro
71.10|Kabupaten Bolaang Mongondow Timur
71.11|Kabupaten Bolaang Mongondow Selatan
71.71|Kota Manado
71.72|Kota Bitung
71.73|Kota Tomohon
71.74|Kota Kotamobagu
72.01|Kabupaten Banggai
72.02|Kabupaten Poso
72.03|Kabupaten Donggala
72.04|Kabupaten Toli-Toli
72.05|Kabupaten Buol
72.06|Kabupaten Morowali
72.07|Kabupaten Banggai Kepulauan
72.08|Kabupaten Parigi Moutong
72.09|Kabupaten Tojo Una Una
72.10|Kabupaten Sigi
72.11|Kabupaten Banggai Laut
72.12|Kabupaten Morowali Utara
72.71|Kota Palu
73.01|Kabupaten Kepulauan Selayar
73.02|Kabupaten Bulukumba
73.03|Kabupaten Bantaeng
73.04|Kabupaten Jeneponto
73.05|Kabupaten Takalar
73.06|Kabupaten Gowa
73.07|Kabupaten Sinjai
73.08|Kabupaten Bone
73.09|Kabupaten Maros
73.10|Kabupaten Pangkajene dan Kepulauan
73.11|Kabupaten Barru
73.12|Kabupaten Soppeng
73.13|Kabupaten Wajo
73.14|Kabupaten Sidenreng Rappang
73.15|Kabupaten Pinrang
73.16|Kabupaten Enrekang
73.17|Kabupaten Luwu
73.18|Kabupaten Tana Toraja
73.22|Kabupaten Luwu Utara
73.24|Kabupaten Luwu Timur
73.26|Kabupaten Toraja Utara
73.71|Kota Makassar
73.72|Kota Parepare
73.73|Kota Palopo
74.01|Kabupaten Kolaka
74.02|Kabupaten Konawe
74.03|Kabupaten Muna
74.04|Kabupaten Buton
74.05|Kabupaten Konawe Selatan
74.06|Kabupaten Bombana
74.07|Kabupaten Wakatobi
74.08|Kabupaten Kolaka Utara
74.09|Kabupaten Konawe Utara
74.10|Kabupaten Buton Utara
74.11|Kabupaten Kolaka Timur
74.12|Kabupaten Konawe Kepulauan
74.13|Kabupaten Muna Barat
74.14|Kabupaten Buton Tengah
74.15|Kabupaten Buton Selatan
74.71|Kota Kendari
74.72|Kota Bau Bau
75.01|Kabupaten Gorontalo
75.02|Kabupaten Boalemo
75.03|Kabupaten Bone Bolango
75.04|Kabupaten Pohuwato
75.05|Kabupaten Gorontalo Utara
75.71|Kota Gorontalo
76.01|Kabupaten Pasangkayu
76.02|Kabupaten Mamuju
76.03|Kabupaten Mamasa
76.04|Kabupaten Polewali Mandar
76.05|Kabupaten Majene
76.06|Kabupaten Mamuju Tengah
81.01|Kabupaten Maluku Tengah
81.02|Kabupaten Maluku Tenggara
81.03|Kabupaten Kepulauan Tanimbar
81.04|Kabupaten Buru
81.05|Kabupaten Seram Bagian Timur
81.06|Kabupaten Seram Bagian Barat
81.07|Kabupaten Kepulauan Aru
81.08|Kabupaten Maluku Barat Daya
81.09|Kabupaten Buru Selatan
81.71|Kota Ambon
81.72|Kota Tual
82.01|Kabupaten Halmahera Barat
82.02|Kabupaten Halmahera Tengah
82.03|Kabupaten Halmahera Utara
82.04|Kabupaten Halmahera Selatan
82.05|Kabupaten Kepulauan Sula
82.06|Kabupaten Halmahera Timur
82.07|Kabupaten Pulau Morotai
82.08|Kabupaten Pulau Taliabu
82.71|Kota Ternate
82.72|Kota Tidore Kepulauan
91.03|Kabupaten Jayapura
91.05|Kabupaten Kepulauan Yapen
91.06|Kabupaten Biak Numfor
91.10|Kabupaten Sarmi
91.11|Kabupaten Keerom
91.15|Kabupaten Waropen
91.19|Kabupaten Supiori
91.20|Kabupaten Mamberamo Raya
91.71|Kota Jayapura
92.02|Kabupaten Manokwari
92.03|Kabupaten Fak Fak
92.06|Kabupaten Teluk Bintuni
92.07|Kabupaten Teluk Wondama
92.08|Kabupaten Kaimana
92.11|Kabupaten Manokwari Selatan
92.12|Kabupaten Pegunungan Arfak
93.01|Kabupaten Merauke
93.02|Kabupaten Boven Digoel
93.03|Kabupaten Mappi
93.04|Kabupaten Asmat
94.01|Kabupaten Nabire
94.02|Kabupaten Puncak Jaya
94.03|Kabupaten Paniai
94.04|Kabupaten Mimika
94.05|Kabupaten Puncak
94.06|Kabupaten Dogiyai
94.07|Kabupaten Intan Jaya
94.08|Kabupaten Deiyai
95.01|Kabupaten Jayawijaya
95.02|Kabupaten Pegunungan Bintang
95.03|Kabupaten Yahukimo
95.04|Kabupaten Tolikara
95.05|Kabupaten Mamberamo Tengah
95.06|Kabupaten Yalimo
95.07|Kabupaten Lanny Jaya
95.08|Kabupaten Nduga
96.01|Kabupaten Sorong
96.02|Kabupaten Sorong Selatan
96.03|Kabupaten Raja Ampat
96.04|Kabupaten Tambrauw
96.05|Kabupaten Maybrat
96.71|Kota Sorong
11.01.01|Bakongan
11.01.02|Kluet Utara
11.01.03|Kluet Selatan
11.01.04|Labuhanhaji
11.01.05|Meukek
11.01.06|Samadua
11.01.07|Sawang
11.01.08|Tapaktuan
11.01.09|Trumon
11.01.10|Pasie Raja
11.01.11|Labuhanhaji Timur
11.01.12|Labuhanhaji Barat
11.01.13|Kluet Tengah
11.01.14|Kluet Timur
11.01.15|Bakongan Timur
11.01.16|Trumon Timur
11.01.17|Kota Bahagia
11.01.18|Trumon Tengah
11.02.01|Lawe Alas
11.02.02|Lawe Sigala-Gala
11.02.03|Bambel
11.02.04|Babussalam
11.02.05|Badar
11.02.06|Babul Makmur
11.02.07|Darul Hasanah
11.02.08|Lawe Bulan
11.02.09|Bukit Tusam
11.02.10|Semadam
11.02.11|Babul Rahmah
11.02.12|Ketambe
11.02.13|Deleng Pokhkisen
11.02.14|Lawe Sumur
11.02.15|Tanoh Alas
11.02.16|Leuser
11.03.01|Darul Aman
11.03.02|Julok
11.03.03|Idi Rayeuk
11.03.04|Birem Bayeun
11.03.05|Serbajadi
11.03.06|Nurussalam
11.03.07|Peureulak
11.03.08|Rantau Selamat
11.03.09|Simpang Ulim
11.03.10|Ranto Peureulak
11.03.11|Pante Bidari
11.03.12|Madat
11.03.13|Indra Makmu
11.03.14|Idi Tunong
11.03.15|Banda Alam
11.03.16|Peudawa
11.03.17|Peureulak Timur
11.03.18|Peureulak Barat
11.03.19|Sungai Raya
11.03.20|Simpang Jernih
11.03.21|Darul Ihsan
11.03.22|Darul Falah
11.03.23|Idi Timur
11.03.24|Peunaron
11.04.01|Linge
11.04.02|Silih Nara
11.04.03|Bebesen
11.04.07|Pegasing
11.04.08|Bintang
11.04.10|Ketol
11.04.11|Kebayakan
11.04.12|Kute Panang
11.04.13|Celala
11.04.17|Laut Tawar
11.04.18|Atu Lintang
11.04.19|Jagong Jeget
11.04.20|Bies
11.04.21|Rusip Antara
11.05.01|Johan Pahlawan
11.05.02|Kaway XVI
11.05.03|Sungai Mas
11.05.04|Woyla
11.05.05|Samatiga
11.05.06|Bubon
11.05.07|Arongan Lambalek
11.05.08|Pante Ceureumen
11.05.09|Meureubo
11.05.10|Woyla Barat
11.05.11|Woyla Timur
11.05.12|Panton Reu
11.06.01|Lhoong
11.06.02|Lhoknga
11.06.03|Indrapuri
11.06.04|Seulimeum
11.06.05|Montasik
11.06.06|Sukamakmur
11.06.07|Darul Imarah
11.06.08|Peukan Bada
11.06.09|Mesjid Raya
11.06.10|Ingin Jaya
11.06.11|Kuta Baro
11.06.12|Darussalam
11.06.13|Pulo Aceh
11.06.14|Lembah Seulawah
11.06.15|Kota Jantho
11.06.16|Kuta Cot Glie
11.06.17|Kuta Malaka
11.06.18|Simpang Tiga
11.06.19|Darul Kamal
11.06.20|Baitussalam
11.06.21|Krueng Barona Jaya
11.06.22|Leupung
11.06.23|Blang Bintang
11.07.03|Batee
11.07.04|Delima
11.07.05|Geumpang
11.07.06|Glumpang Tiga
11.07.07|Indrajaya
11.07.08|Kembang Tanjong
11.07.09|Kota Sigli
11.07.11|Mila
11.07.12|Muara Tiga
11.07.13|Mutiara
11.07.14|Padang Tiji
11.07.15|Peukan Baro
11.07.16|Pidie
11.07.17|Sakti
11.07.18|Simpang Tiga
11.07.19|Tangse
11.07.21|Tiro/Truseb
11.07.22|Keumala
11.07.24|Mutiara Timur
11.07.25|Grong-grong
11.07.27|Mane
11.07.29|Glumpang Baro
11.07.31|Titeue
11.08.01|Baktiya
11.08.02|Dewantara
11.08.03|Kuta Makmur
11.08.04|Lhoksukon
11.08.05|Matangkuli
11.08.06|Muara Batu
11.08.07|Meurah Mulia
11.08.08|Samudera
11.08.09|Seunuddon
11.08.10|Syamtalira Aron
11.08.11|Syamtalira Bayu
11.08.12|Tanah Luas
11.08.13|Tanah Pasir
11.08.14|Tanah Jambo Aye
11.08.15|Sawang
11.08.16|Nisam
11.08.17|Cot Girek
11.08.18|Langkahan
11.08.19|Baktiya Barat
11.08.20|Paya Bakong
11.08.21|Nibong
11.08.22|Simpang Keuramat
11.08.23|Lapang
11.08.24|Pirak Timu
11.08.25|Geureudong Pase
11.08.26|Banda Baro
11.08.27|Nisam Antara
11.09.01|Simeulue Tengah
11.09.02|Salang
11.09.03|Teupah Barat
11.09.04|Simeulue Timur
11.09.05|Teluk Dalam
11.09.06|Simeulue Barat
11.09.07|Teupah Selatan
11.09.08|Alafan
11.09.09|Teupah Tengah
11.09.10|Simeulue Cut
11.10.01|Pulau Banyak
11.10.02|Simpang Kanan
11.10.04|Singkil
11.10.06|Gunung Meriah
11.10.09|Kota Baharu
11.10.10|Singkil Utara
11.10.11|Danau Paris
11.10.12|Suro Makmur
11.10.13|Singkohor
11.10.14|Kuala Baru
11.10.16|Pulau Banyak Barat
11.11.01|Samalanga
11.11.02|Jeunieb
11.11.03|Peudada
11.11.04|Jeumpa
11.11.05|Peusangan
11.11.06|Makmur
11.11.07|Gandapura
11.11.08|Pandrah
11.11.09|Juli
11.11.10|Jangka
11.11.11|Simpang Mamplam
11.11.12|Peulimbang
11.11.13|Kota Juang
11.11.14|Kuala
11.11.15|Peusangan Siblah Krueng
11.11.16|Peusangan Selatan
11.11.17|Kuta Blang
11.12.01|Blangpidie
11.12.02|Tangan-Tangan
11.12.03|Manggeng
11.12.04|Susoh
11.12.05|Kuala Batee
11.12.06|Babah Rot
11.12.07|Setia
11.12.08|Jeumpa
11.12.09|Lembah Sabil
11.13.01|Blangkejeren
11.13.02|Kutapanjang
11.13.03|Rikit Gaib
11.13.04|Terangun
11.13.05|Pining
11.13.06|Blangpegayon
11.13.07|Puteri Betung
11.13.08|Dabun Gelang
11.13.09|Blangjerango
11.13.10|Teripe Jaya
11.13.11|Pantan Cuaca
11.14.01|Teunom
11.14.02|Krueng Sabee
11.14.03|Setia Bakti
11.14.04|Sampoi Niet
11.14.05|Jaya
11.14.06|Panga
11.14.07|Indra Jaya
11.14.08|Darul Hikmah
11.14.09|Pasie Raya
11.15.01|Kuala
11.15.02|Seunagan
11.15.03|Seunagan Timur
11.15.04|Beutong
11.15.05|Darul Makmur
11.15.06|Suka Makmue
11.15.07|Kuala Pesisir
11.15.08|Tadu Raya
11.15.09|Tripa Makmur
11.15.10|Beutong Ateuh Banggalang
11.16.01|Manyak Payed
11.16.02|Bendahara
11.16.03|Karang Baru
11.16.04|Seruway
11.16.05|Kota Kualasinpang
11.16.06|Kejuruan Muda
11.16.07|Tamiang Hulu
11.16.08|Rantau
11.16.09|Banda Mulia
11.16.10|Bandar Pusaka
11.16.11|Tenggulun
11.16.12|Sekerak
11.17.01|Pintu Rime Gayo
11.17.02|Permata
11.17.03|Syiah Utama
11.17.04|Bandar
11.17.05|Bukit
11.17.06|Wih Pesam
11.17.07|Timang gajah
11.17.08|Bener Kelipah
11.17.09|Mesidah
11.17.10|Gajah Putih
11.18.01|Meureudu
11.18.02|Ulim
11.18.03|Jangka Buya
11.18.04|Bandar Dua
11.18.05|Meurah Dua
11.18.06|Bandar Baru
11.18.07|Panteraja
11.18.08|Trienggadeng
11.71.01|Baiturrahman
11.71.02|Kuta Alam
11.71.03|Meuraxa
11.71.04|Syiah Kuala
11.71.05|Lueng Bata
11.71.06|Kuta Raja
11.71.07|Banda Raya
11.71.08|Jaya Baru
11.71.09|Ulee Kareng
11.72.01|Sukakarya
11.72.02|Sukajaya
11.72.03|Sukamakmue
11.73.01|Muara Dua
11.73.02|Banda Sakti
11.73.03|Blang Mangat
11.73.04|Muara Satu
11.74.01|Langsa Timur
11.74.02|Langsa Barat
11.74.03|Langsa Kota
11.74.04|Langsa Lama
11.74.05|Langsa Baro
11.75.01|Simpang Kiri
11.75.02|Penanggalan
11.75.03|Rundeng
11.75.04|Sultan Daulat
11.75.05|Longkib
12.01.01|Barus
12.01.02|Sorkam
12.01.03|Pandan
12.01.04|Pinangsori
12.01.05|Manduamas
12.01.06|Kolang
12.01.07|Tapian Nauli
12.01.08|Sibabangun
12.01.09|Sosorgadong
12.01.10|Sorkam Barat
12.01.11|Sirandorung
12.01.12|Andam Dewi
12.01.13|Sitahuis
12.01.14|Tukka
12.01.15|Badiri
12.01.16|Pasaribu Tobing
12.01.17|Barus Utara
12.01.18|Suka Bangun
12.01.19|Lumut
12.01.20|Sarudik
12.02.01|Tarutung
12.02.02|Siatas Barita
12.02.03|Adiankoting
12.02.04|Sipoholon
12.02.05|Pahae Julu
12.02.06|Pahae Jae
12.02.07|Simangumban
12.02.08|Purbatua
12.02.09|Siborongborong
12.02.10|Pagaran
12.02.11|Parmonangan
12.02.12|Sipahutar
12.02.13|Pangaribuan
12.02.14|Garoga
12.02.15|Muara
12.03.01|Angkola Barat
12.03.02|Batang Toru
12.03.03|Angkola Timur
12.03.04|Sipirok
12.03.05|Saipar Dolok Hole
12.03.06|Angkola Selatan
12.03.07|Batang Angkola
12.03.14|Arse
12.03.20|Marancar
12.03.21|Sayur Matinggi
12.03.22|Aek Bilah
12.03.29|Muara Batang Toru
12.03.30|Tano Tombangan Angkola
12.03.31|Angkola Sangkunur
12.03.32|Angkola Muara Tais
12.04.05|Hiliduho
12.04.06|Gido
12.04.10|Idanogawo
12.04.11|Bawolato
12.04.20|Hiliserangkai
12.04.21|Botomuzoi
12.04.27|Ulugawo
12.04.28|Ma'u
12.04.29|Somolo-molo
12.04.35|Sogae'adu
12.05.01|Bahorok
12.05.02|Salapian
12.05.03|Kuala
12.05.04|Sei Bingai
12.05.05|Binjai
12.05.06|Selesai
12.05.07|Stabat
12.05.08|Wampu
12.05.09|Secanggang
12.05.10|Hinai
12.05.11|Tanjung Pura
12.05.12|Padang Tualang
12.05.13|Gebang
12.05.14|Babalan
12.05.15|Pangkalan Susu
12.05.16|Besitang
12.05.17|Sei Lepan
12.05.18|Berandan Barat
12.05.19|Batang Serangan
12.05.20|Sawit Seberang
12.05.21|Sirapit
12.05.22|Kutambaru
12.05.23|Pematang Jaya
12.06.01|Kabanjahe
12.06.02|Berastagi
12.06.03|Barusjahe
12.06.04|Tigapanah
12.06.05|Merek
12.06.06|Munte
12.06.07|Juhar
12.06.08|Tigabinanga
12.06.09|Laubaleng
12.06.10|Mardingding
12.06.11|Payung
12.06.12|Simpang Empat
12.06.13|Kutabuluh
12.06.14|Dolat Rayat
12.06.15|Merdeka
12.06.16|Naman Teran
12.06.17|Tiganderket
12.07.01|Gunung Meriah
12.07.02|Tanjung Morawa
12.07.03|Sibolangit
12.07.04|Kutalimbaru
12.07.05|Pancur Batu
12.07.06|Namo Rambe
12.07.07|Biru-Biru
12.07.08|Sinembah Tanjung Muda Hilir
12.07.09|Bangun Purba
12.07.19|Galang
12.07.20|Sinembah Tanjung Muda Hulu
12.07.21|Patumbak
12.07.22|Deli Tua
12.07.23|Sunggal
12.07.24|Hamparan Perak
12.07.25|Labuhan Deli
12.07.26|Percut Sei Tuan
12.07.27|Batang Kuis
12.07.28|Lubuk Pakam
12.07.31|Pagar Merbau
12.07.32|Pantai Labu
12.07.33|Beringin
12.08.01|Siantar
12.08.02|Gunung Malela
12.08.03|Gunung Maligas
12.08.04|Panei
12.08.05|Panombeian Panei
12.08.06|Jorlang Hataran
12.08.07|Raya Kahean
12.08.08|Bosar Maligas
12.08.09|Sidamanik
12.08.10|Pamatang Sidamanik
12.08.11|Tanah Jawa
12.08.12|Hatonduhan
12.08.13|Dolok Panribuan
12.08.14|Purba
12.08.15|Haranggaol Horisan
12.08.16|Girsang Sipangan Bolon
12.08.17|Dolok Batu Nanggar
12.08.18|Hutabayu Raja
12.08.19|Jawa Maraja Bah Jambi
12.08.20|Dolok Pardamean
12.08.21|Pematang Bandar
12.08.22|Bandar Huluan
12.08.23|Bandar
12.08.24|Bandar Masilam
12.08.25|Silimakuta
12.08.26|Dolok Silao
12.08.27|Silou Kahean
12.08.28|Tapian Dolok
12.08.29|Raya
12.08.30|Ujung Padang
12.08.31|Pamatang Silima Huta
12.08.32|Dolog Masagal
12.09.08|Meranti
12.09.09|Air Joman
12.09.10|Tanjung Balai
12.09.11|Sei Kepayang
12.09.12|Simpang Empat
12.09.13|Air Batu
12.09.14|Pulau Rakyat
12.09.15|Bandar Pulau
12.09.16|Buntu Pane
12.09.17|Bandar Pasir Mandoge
12.09.18|Aek Kuasan
12.09.19|Kota Kisaran Barat
12.09.20|Kota Kisaran Timur
12.09.21|Aek Songsongan
12.09.22|Rahuning
12.09.23|Sei Dadap
12.09.24|Sei Kepayang Barat
12.09.25|Sei Kepayang Timur
12.09.26|Tinggi Raja
12.09.27|Setia Janji
12.09.28|Silau Laut
12.09.29|Rawang Panca Arga
12.09.30|Pulo Bandring
12.09.31|Teluk Dalam
12.09.32|Aek Ledong
12.10.01|Rantau Utara
12.10.02|Rantau Selatan
12.10.07|Bilah Barat
12.10.08|Bilah Hilir
12.10.09|Bilah Hulu
12.10.14|Pangkatan
12.10.18|Panai Tengah
12.10.19|Panai Hilir
12.10.20|Panai Hulu
12.11.01|Sidikalang
12.11.02|Sumbul
12.11.03|Tigalingga
12.11.04|Siempat Nempu
12.11.05|Silima Pungga Pungga
12.11.06|Tanah Pinem
12.11.07|Siempat Nempu Hulu
12.11.08|Siempat Nempu Hilir
12.11.09|Pegagan Hilir
12.11.10|Parbuluan
12.11.11|Lae Parira
12.11.12|Gunung Sitember
12.11.13|Berampu
12.11.14|Silahisabungan
12.11.15|Sitinjo
12.12.01|Balige
12.12.02|Laguboti
12.12.03|Silaen
12.12.04|Habinsaran
12.12.05|Pintu Pohan Meranti
12.12.06|Borbor
12.12.07|Porsea
12.12.08|Ajibata
12.12.09|Lumban Julu
12.12.10|Uluan
12.12.19|Sigumpar
12.12.20|Siantar Narumonda
12.12.21|Nassau
12.12.22|Tampahan
12.12.23|Bonatua Lunasi
12.12.24|Parmaksian
12.13.01|Panyabungan
12.13.02|Panyabungan Utara
12.13.03|Panyabungan Timur
12.13.04|Panyabungan Selatan
12.13.05|Panyabungan Barat
12.13.06|Siabu
12.13.07|Bukit Malintang
12.13.08|Kotanopan
12.13.09|Lembah Sorik Marapi
12.13.10|Tambangan
12.13.11|Ulu Pungkut
12.13.12|Muara Sipongi
12.13.13|Batang Natal
12.13.14|Lingga Bayu
12.13.15|Batahan
12.13.16|Natal
12.13.17|Muara Batang Gadis
12.13.18|Ranto Baek
12.13.19|Huta Bargot
12.13.20|Puncak Sorik Marapi
12.13.21|Pakantan
12.13.22|Sinunukan
12.13.23|Naga Juang
12.14.01|Lolomatua
12.14.02|Gomo
12.14.03|Lahusa
12.14.04|Hibala
12.14.05|Pulau-Pulau Batu
12.14.06|Teluk Dalam
12.14.07|Amandraya
12.14.08|Lolowau
12.14.09|Susua
12.14.10|Maniamolo
12.14.11|Hilimegai
12.14.12|Toma
12.14.13|Mazino
12.14.14|Umbunasi
12.14.15|Aramo
12.14.16|Pulau-Pulau Batu Timur
12.14.17|Mazo
12.14.18|Fanayama
12.14.19|Ulunoyo
12.14.20|Huruna
12.14.21|O'o'u
12.14.22|Onohazumba
12.14.23|Hilisalawa'ahe
12.14.24|Ulususua
12.14.25|Sidua'ori
12.14.26|Somambawa
12.14.27|Boronadu
12.14.28|Simuk
12.14.29|Pulau-Pulau Batu Barat
12.14.30|Pulau-Pulau Batu Utara
12.14.31|Tanah Masa
12.14.32|Luahagundre Maniamolo
12.14.33|Onolalu
12.14.34|Ulu Idanotae
12.14.35|Idanotae
12.15.01|Sitelu Tali Urang Jehe
12.15.02|Kerajaan
12.15.03|Salak
12.15.04|Sitelu Tali Urang Julu
12.15.05|Pergetteng Getteng Sengkut
12.15.06|Pagindar
12.15.07|Tinada
12.15.08|Siempat Rube
12.16.01|Parlilitan
12.16.02|Pollung
12.16.03|Baktiraja
12.16.04|Paranginan
12.16.05|Lintong Nihuta
12.16.06|Dolok Sanggul
12.16.07|Sijamapolang
12.16.08|Onan Ganjang
12.16.09|Pakkat
12.16.10|Tarabintang
12.17.01|Simanindo
12.17.02|Onan Runggu
12.17.03|Nainggolan
12.17.04|Palipi
12.17.05|Harian
12.17.06|Sianjar Mula Mula
12.17.07|Ronggur Nihuta
12.17.08|Pangururan
12.17.09|Sitio-tio
12.18.01|Pantai Cermin
12.18.02|Perbaungan
12.18.03|Teluk Mengkudu
12.18.04|Sei Rampah
12.18.05|Tanjung Beringin
12.18.06|Bandar Khalipah
12.18.07|Dolok Merawan
12.18.08|Sipispis
12.18.09|Dolok Masihul
12.18.10|Kotarih
12.18.11|Silinda
12.18.12|Serba Jadi
12.18.13|Tebing Tinggi
12.18.14|Pegajahan
12.18.15|Sei Bamban
12.18.16|Tebing Syahbandar
12.18.17|Bintang Bayu
12.19.01|Medang Deras
12.19.02|Sei Suka
12.19.03|Air Putih
12.19.04|Lima Puluh
12.19.05|Talawi
12.19.06|Tanjung Tiram
12.19.07|Sei Balai
12.19.08|Laut Tador
12.19.09|Lima Puluh Pesisir
12.19.10|Datuk Lima Puluh
12.19.11|Datuk Tanah Datar
12.19.12|Nibung Hangus
12.20.01|Dolok Sigompulon
12.20.02|Dolok
12.20.03|Halongonan
12.20.04|Padang Bolak
12.20.05|Padang Bolak Julu
12.20.06|Portibi
12.20.07|Batang Onang
12.20.08|Simangambat
12.20.09|Hulu Sihapas
12.20.10|Padang Bolak Tenggara
12.20.11|Halongonan Timur
12.20.12|Ujung Batu
12.21.01|Sosopan
12.21.02|Barumun Tengah
12.21.03|Huristak
12.21.04|Lubuk Barumun
12.21.05|Hutaraja Tinggi
12.21.06|Ulu Barumun
12.21.07|Barumun
12.21.08|Sosa
12.21.09|Batang Lubu Sutam
12.21.10|Barumun Selatan
12.21.11|Aek Nabara Barumun
12.21.12|Sihapas Barumun
12.21.13|Barumun Baru
12.21.14|Ulu Sosa
12.21.15|Sosa Julu
12.21.16|Barumun Barat
12.21.17|Sosa Timur
12.22.01|Kotapinang
12.22.02|Kampung Rakyat
12.22.03|Torgamba
12.22.04|Sungai Kanan
12.22.05|Silangkitang
12.23.01|Kualuh Hulu
12.23.02|Kualuh Leidong
12.23.03|Kualuh Hilir
12.23.04|Aek Kuo
12.23.05|Marbau
12.23.06|Na IX-X
12.23.07|Aek Natas
12.23.08|Kualuh Selatan
12.24.01|Lotu
12.24.02|Sawo
12.24.03|Tuhemberua
12.24.04|Sitolu Ori
12.24.05|Namohalu Esiwa
12.24.06|Alasa Talumuzoi
12.24.07|Alasa
12.24.08|Tugala Oyo
12.24.09|Afulu
12.24.10|Lahewa
12.24.11|Lahewa Timur
12.25.01|Lahomi
12.25.02|Sirombu
12.25.03|Mandrehe Barat
12.25.04|Moro'o
12.25.05|Mandrehe
12.25.06|Mandrehe Utara
12.25.07|Lolofitu Moi
12.25.08|Ulu Moro'o
12.71.01|Medan Kota
12.71.02|Medan Sunggal
12.71.03|Medan Helvetia
12.71.04|Medan Denai
12.71.05|Medan Barat
12.71.06|Medan Deli
12.71.07|Medan Tuntungan
12.71.08|Medan Belawan
12.71.09|Medan Amplas
12.71.10|Medan Area
12.71.11|Medan Johor
12.71.12|Medan Marelan
12.71.13|Medan Labuhan
12.71.14|Medan Tembung
12.71.15|Medan Maimun
12.71.16|Medan Polonia
12.71.17|Medan Baru
12.71.18|Medan Perjuangan
12.71.19|Medan Petisah
12.71.20|Medan Timur
12.71.21|Medan Selayang
12.72.01|Siantar Timur
12.72.02|Siantar Barat
12.72.03|Siantar Utara
12.72.04|Siantar Selatan
12.72.05|Siantar Marihat
12.72.06|Siantar Martoba
12.72.07|Siantar Sitalasari
12.72.08|Siantar Marimbun
12.73.01|Sibolga Utara
12.73.02|Sibolga Kota
12.73.03|Sibolga Selatan
12.73.04|Sibolga Sambas
12.74.01|Tanjungbalai Selatan
12.74.02|Tanjungbalai Utara
12.74.03|Sei Tualang Raso
12.74.04|Teluk Nibung
12.74.05|Datuk Bandar
12.74.06|Datuk Bandar Timur
12.75.01|Binjai Utara
12.75.02|Binjai Kota
12.75.03|Binjai Barat
12.75.04|Binjai Timur
12.75.05|Binjai Selatan
12.76.01|Padang Hulu
12.76.02|Rambutan
12.76.03|Padang Hilir
12.76.04|Bajenis
12.76.05|Tebing Tinggi Kota
12.77.01|Padangsidimpuan Utara
12.77.02|Padangsidimpuan Selatan
12.77.03|Padangsidimpuan Batunadua
12.77.04|Padangsidimpuan Hutaimbaru
12.77.05|Padangsidimpuan Tenggara
12.77.06|Padangsidimpuan Angkola Julu
12.78.01|Gunungsitoli
12.78.02|Gunungsitoli Selatan
12.78.03|Gunungsitoli Utara
12.78.04|Gunungsitoli Idanoi
12.78.05|Gunungsitoli Alo'oa
12.78.06|Gunungsitoli Barat
13.01.01|Pancung Soal
13.01.02|Ranah Pesisir
13.01.03|Lengayang
13.01.04|Batang Kapas
13.01.05|IV Jurai
13.01.06|Bayang
13.01.07|Koto XI Tarusan
13.01.08|Sutera
13.01.09|Linggo Sari Baganti
13.01.10|Lunang
13.01.11|Basa Ampek Balai Tapan
13.01.12|IV Nagari Bayang Utara
13.01.13|Airpura
13.01.14|Ranah Ampek Hulu Tapan
13.01.15|Silaut
13.02.03|Pantai Cermin
13.02.04|Lembah Gumanti
13.02.05|Payung Sekaki
13.02.06|Lembang Jaya
13.02.07|Gunung Talang
13.02.08|Bukit Sundi
13.02.09|IX Koto Sungai Lasi
13.02.10|Kubung
13.02.11|X Koto Singkarak
13.02.12|X Koto Diatas
13.02.13|Junjung Sirih
13.02.17|Hiliran Gumanti
13.02.18|Tigo Lurah
13.02.19|Danau Kembar
13.03.03|Tanjung Gadang
13.03.04|Sijunjung
13.03.05|IV Nagari
13.03.06|Kamang Baru
13.03.07|Lubuk Tarok
13.03.08|Koto VII
13.03.09|Sumpur Kudus
13.03.10|Kupitan
13.04.01|X Koto
13.04.02|Batipuh
13.04.03|Rambatan
13.04.04|Lima Kaum
13.04.05|Tanjung Emas
13.04.06|Lintau Buo
13.04.07|Sungayang
13.04.08|Sungai Tarab
13.04.09|Pariangan
13.04.10|Salimpaung
13.04.11|Padang Ganting
13.04.12|Tanjuang Baru
13.04.13|Lintau Buo Utara
13.04.14|Batipuah Selatan
13.05.01|Lubuak Aluang
13.05.02|Batang Anai
13.05.03|Nan Sabaris
13.05.04|2 x 11 Anam Lingkuang
13.05.05|VII Koto
13.05.06|V Koto
13.05.07|Sungai Garinggiang
13.05.08|Sungai Limau
13.05.09|IV Koto Aua Malintang
13.05.10|Ulakan Tapakih
13.05.11|Sintuak Toboh Gadang
13.05.12|VII Koto Padang Sago
13.05.13|Batang Gasan
13.05.14|V Koto Timur
13.05.15|2 x 11 Kayu Tanam
13.05.16|Koto Patamuan
13.05.17|Anam Lingkuang
13.06.01|Tanjung Mutiara
13.06.02|Lubuk Basung
13.06.03|Tanjung Raya
13.06.04|Matur
13.06.05|IV Koto
13.06.06|Banuhampu
13.06.07|Ampek Angkek
13.06.08|Baso
13.06.09|Tilatang Kamang
13.06.10|Palupuh
13.06.11|Palembayan
13.06.12|Sungai Pua
13.06.13|Ampek Nagari
13.06.14|Candung
13.06.15|Kamang Magek
13.06.16|Malalak
13.07.01|Suliki
13.07.02|Guguak
13.07.03|Payakumbuh
13.07.04|Luak
13.07.05|Harau
13.07.06|Pangkalan Koto Baru
13.07.07|Kapur IX
13.07.08|Gunuang Omeh
13.07.09|Lareh Sago Halaban
13.07.10|Situjuah Limo Nagari
13.07.11|Mungka
13.07.12|Bukik Barisan
13.07.13|Akabiluru
13.08.04|Bonjol
13.08.05|Lubuk Sikaping
13.08.07|Panti
13.08.08|Mapat Tunggul
13.08.12|Duo Koto
13.08.13|Tigo Nagari
13.08.14|Rao
13.08.15|Mapat Tunggul Selatan
13.08.16|Simpang Alahan Mati
13.08.17|Padang Gelugur
13.08.18|Rao Utara
13.08.19|Rao Selatan
13.09.01|Pagai Utara
13.09.02|Sipora Selatan
13.09.03|Siberut Selatan
13.09.04|Siberut Utara
13.09.05|Siberut Barat
13.09.06|Siberut Barat Daya
13.09.07|Siberut Tengah
13.09.08|Sipora Utara
13.09.09|Sikakap
13.09.10|Pagai Selatan
13.10.01|Koto Baru
13.10.02|Pulau Punjung
13.10.03|Sungai Rumbai
13.10.04|Sitiung
13.10.05|Sembilan Koto
13.10.06|Timpeh
13.10.07|Koto Salak
13.10.08|Tiumang
13.10.09|Padang Laweh
13.10.10|Asam Jujuhan
13.10.11|Koto Besar
13.11.01|Sangir
13.11.02|Sungai Pagu
13.11.03|Koto Parik Gadang Diateh
13.11.04|Sangir Jujuan
13.11.05|Sangir Batang Hari
13.11.06|Pauh Duo
13.11.07|Sangir Balai Janggo
13.12.01|Sungai Beremas
13.12.02|Lembah Melintang
13.12.03|Pasaman
13.12.04|Talamau
13.12.05|Kinali
13.12.06|Gunung Tuleh
13.12.07|Ranah Batahan
13.12.08|Koto Balingka
13.12.09|Sungai Aur
13.12.10|Luhak Nan Duo
13.12.11|Sasak Ranah Pasisie
13.71.01|Padang Selatan
13.71.02|Padang Timur
13.71.03|Padang Barat
13.71.04|Padang Utara
13.71.05|Bungus Teluk Kabung
13.71.06|Lubuk Begalung
13.71.07|Lubuk Kilangan
13.71.08|Pauh
13.71.09|Kuranji
13.71.10|Nanggalo
13.71.11|Koto Tangah
13.72.01|Lubuk Sikarah
13.72.02|Tanjung Harapan
13.73.01|Lembah Segar
13.73.02|Barangin
13.73.03|Silungkang
13.73.04|Talawi
13.74.01|Padang Panjang Timur
13.74.02|Padang Panjang Barat
13.75.01|Guguak Panjang
13.75.02|Mandiangin Koto Selayan
13.75.03|Aur Birugo Tigo Baleh
13.76.01|Payakumbuh Barat
13.76.02|Payakumbuh Utara
13.76.03|Payakumbuh Timur
13.76.04|Lamposi Tigo Nagori
13.76.05|Payakumbuh Selatan
13.77.01|Pariaman Tengah
13.77.02|Pariaman Utara
13.77.03|Pariaman Selatan
13.77.04|Pariaman Timur
14.01.01|Bangkinang Kota
14.01.02|Kampar
14.01.03|Tambang
14.01.04|XIII Koto Kampar
14.01.05|Kuok
14.01.06|Siak Hulu
14.01.07|Kampar Kiri
14.01.08|Kampar Kiri Hilir
14.01.09|Kampar Kiri Hulu
14.01.10|Tapung
14.01.11|Tapung Hilir
14.01.12|Tapung Hulu
14.01.13|Salo
14.01.14|Rumbio Jaya
14.01.15|Bangkinang
14.01.16|Perhentian Raja
14.01.17|Kampa
14.01.18|Kampar Utara
14.01.19|Kampar Kiri Tengah
14.01.20|Gunung Sahilan
14.01.21|Koto Kampar Hulu
14.02.01|Rengat
14.02.02|Rengat Barat
14.02.03|Kelayang
14.02.04|Pasir Penyu
14.02.05|Peranap
14.02.06|Seberida
14.02.07|Batang Cenaku
14.02.08|Batang Gansal
14.02.09|Lirik
14.02.10|Kuala Cenaku
14.02.11|Sungai Lala
14.02.12|Lubuk Batu Jaya
14.02.13|Rakit Kulim
14.02.14|Batang Peranap
14.03.01|Bengkalis
14.03.02|Bantan
14.03.03|Bukit Batu
14.03.09|Mandau
14.03.10|Rupat
14.03.11|Rupat Utara
14.03.12|Siak Kecil
14.03.13|Pinggir
14.03.14|Bandar Laksamana
14.03.15|Talang Muandau
14.03.16|Bathin Solapan
14.04.01|Reteh
14.04.02|Enok
14.04.03|Kuala Indragiri
14.04.04|Tembilahan
14.04.05|Tempuling
14.04.06|Gaung Anak Serka
14.04.07|Mandah
14.04.08|Kateman
14.04.09|Keritang
14.04.10|Tanah Merah
14.04.11|Batang Tuaka
14.04.12|Gaung
14.04.13|Tembilahan Hulu
14.04.14|Kemuning
14.04.15|Pelangiran
14.04.16|Teluk Belengkong
14.04.17|Pulau Burung
14.04.18|Concong
14.04.19|Kempas
14.04.20|Sungai Batang
14.05.01|Ukui
14.05.02|Pangkalan Kerinci
14.05.03|Pangkalan Kuras
14.05.04|Pangkalan Lesung
14.05.05|Langgam
14.05.06|Pelalawan
14.05.07|Kerumutan
14.05.08|Bunut
14.05.09|Teluk Meranti
14.05.10|Kuala Kampar
14.05.11|Bandar Sei Kijang
14.05.12|Bandar Petalangan
14.06.01|Ujung Batu
14.06.02|Rokan IV Koto
14.06.03|Rambah
14.06.04|Tambusai
14.06.05|Kepenuhan
14.06.06|Kunto Darussalam
14.06.07|Rambah Samo
14.06.08|Rambah Hilir
14.06.09|Tambusai Utara
14.06.10|Bangun Purba
14.06.11|Tandun
14.06.12|Kabun
14.06.13|Bonai Darussalam
14.06.14|Pagaran Tapah Darussalam
14.06.15|Kepenuhan Hulu
14.06.16|Pendalian IV Koto
14.07.01|Kubu
14.07.02|Bangko
14.07.03|Tanah Putih
14.07.04|Rimba Melintang
14.07.05|Bagansinembah
14.07.06|Pasir Limau Kapas
14.07.07|Sinaboi
14.07.08|Pujud
14.07.09|Tanah Putih Tanjung Melawan
14.07.10|Bangko Pusako
14.07.11|Simpang Kanan
14.07.12|Batu Hampar
14.07.13|Rantau Kopar
14.07.14|Pekaitan
14.07.15|Kubu Babussalam
14.07.16|Tanjung Medan
14.07.17|Bagan Sinembah Raya
14.07.18|Balai Jaya
14.08.01|Siak
14.08.02|Sungai Apit
14.08.03|Minas
14.08.04|Tualang
14.08.05|Sungai Mandau
14.08.06|Dayun
14.08.07|Kerinci Kanan
14.08.08|Bunga Raya
14.08.09|Koto Gasib
14.08.10|Kandis
14.08.11|Lubuk Dalam
14.08.12|Sabak Auh
14.08.13|Mempura
14.08.14|Pusako
14.09.01|Kuantan Mudik
14.09.02|Kuantan Tengah
14.09.03|Singingi
14.09.04|Kuantan Hilir
14.09.05|Cerenti
14.09.06|Benai
14.09.07|Gunungtoar
14.09.08|Singingi Hilir
14.09.09|Pangean
14.09.10|Logas Tanah Darat
14.09.11|Inuman
14.09.12|Hulu Kuantan
14.09.13|Kuantan Hilir Seberang
14.09.14|Sentajo Raya
14.09.15|Pucuk Rantau
14.10.01|Tebing Tinggi
14.10.02|Rangsang Barat
14.10.03|Rangsang
14.10.04|Tebing Tinggi Barat
14.10.05|Merbau
14.10.06|Pulaumerbau
14.10.07|Tebing Tinggi Timur
14.10.08|Tasik Putri Puyu
14.10.09|Rangsang Pesisir
14.71.01|Sukajadi
14.71.02|Pekanbaru Kota
14.71.03|Sail
14.71.04|Limapuluh
14.71.05|Senapelan
14.71.06|Rumbai Barat
14.71.07|Bukit Raya
14.71.08|Binawidya
14.71.09|Marpoyan Damai
14.71.10|Tenayan Raya
14.71.11|Payung Sekaki
14.71.12|Rumbai
14.71.13|Tuahmadani
14.71.14|Kulim
14.71.15|Rumbai Timur
14.72.01|Dumai Barat
14.72.02|Dumai Timur
14.72.03|Bukit Kapur
14.72.04|Sungai Sembilan
14.72.05|Medang Kampai
14.72.06|Dumai Kota
14.72.07|Dumai Selatan
15.01.01|Gunung Raya
15.01.02|Danau Kerinci
15.01.04|Sitinjau Laut
15.01.05|Air Hangat
15.01.06|Gunung Kerinci
15.01.07|Batang Merangin
15.01.08|Keliling Danau
15.01.09|Kayu Aro
15.01.11|Air Hangat Timur
15.01.15|Gunung Tujuh
15.01.16|Siulak
15.01.17|Depati Tujuh
15.01.18|Siulak Mukai
15.01.19|Kayu Aro Barat
15.01.20|Bukit Kerman
15.01.21|Air Hangat Barat
15.01.22|Tanah Cogok
15.01.23|Danau Kerinci Barat
15.02.01|Jangkat
15.02.02|Bangko
15.02.03|Muara Siau
15.02.04|Sungai Manau
15.02.05|Tabir
15.02.06|Pamenang
15.02.07|Tabir Ulu
15.02.08|Tabir Selatan
15.02.09|Lembah Masurai
15.02.10|Bangko Barat
15.02.11|Nalo Tantan
15.02.12|Batang Masumai
15.02.13|Pamenang Barat
15.02.14|Tabir Ilir
15.02.15|Tabir Timur
15.02.16|Renah Pembarap
15.02.17|Pangkalan Jambu
15.02.18|Jangkat Timur
15.02.19|Renah Pamenang
15.02.20|Pamenang Selatan
15.02.21|Margo Tabir
15.02.22|Tabir Lintas
15.02.23|Tabir Barat
15.02.24|Tiang Pumpung
15.03.01|Batang Asai
15.03.02|Limun
15.03.03|Sarolangun
15.03.04|Pauh
15.03.05|Pelawan
15.03.06|Mandiangin
15.03.07|Air Hitam
15.03.08|Bathin VIII
15.03.09|Singkut
15.03.10|Cermin Nan Gedang
15.03.11|Mandiangin Timur
15.04.01|Mersam
15.04.02|Muara Tembesi
15.04.03|Muara Bulian
15.04.04|Batin XXIV
15.04.05|Pemayung
15.04.06|Maro Sebo Ulu
15.04.07|Bajubang
15.04.08|Maro Sebo Ilir
15.05.01|Jambi Luar Kota
15.05.02|Sekernan
15.05.03|Kumpeh
15.05.04|Maro Sebo
15.05.05|Mestong
15.05.06|Kumpeh Ulu
15.05.07|Sungai Bahar
15.05.08|Sungai Gelam
15.05.09|Bahar Utara
15.05.10|Bahar Selatan
15.05.11|Taman Rajo
15.06.01|Tungkal Ulu
15.06.02|Tungkal Ilir
15.06.03|Pengabuan
15.06.04|Betara
15.06.05|Merlung
15.06.06|Tebing Tinggi
15.06.07|Batang Asam
15.06.08|Renah Mendaluh
15.06.09|Muara Papalik
15.06.10|Seberang Kota
15.06.11|Bram Itam
15.06.12|Kuala Betara
15.06.13|Senyerang
15.07.01|Muara Sabak Timur
15.07.02|Nipah Panjang
15.07.03|Mendahara
15.07.04|Rantau Rasau
15.07.05|Sadu
15.07.06|Dendang
15.07.07|Muara Sabak Barat
15.07.08|Kuala Jambi
15.07.09|Mendahara Ulu
15.07.10|Geragai
15.07.11|Berbak
15.08.01|Tanah Tumbuh
15.08.02|Rantau Pandan
15.08.03|Pasar Muaro Bungo
15.08.04|Jujuhan
15.08.05|Tanah Sepenggal
15.08.06|Pelepat
15.08.07|Limbur Lubuk Mengkuang
15.08.08|Muko-muko Bathin VII
15.08.09|Pelepat Ilir
15.08.10|Batin II Babeko
15.08.11|Bathin III
15.08.12|Bungo Dani
15.08.13|Rimbo Tengah
15.08.14|Bathin III Ulu
15.08.15|Bathin II Pelayang
15.08.16|Jujuhan Ilir
15.08.17|Tanah Sepenggal Lintas
15.09.01|Tebo Tengah
15.09.02|Tebo Ilir
15.09.03|Tebo Ulu
15.09.04|Rimbo Bujang
15.09.05|Sumay
15.09.06|VII Koto
15.09.07|Rimbo Ulu
15.09.08|Rimbo Ilir
15.09.09|Tengah Ilir
15.09.10|Serai Serumpun
15.09.11|VII Koto Ilir
15.09.12|Muara Tabir
15.71.01|Telanaipura
15.71.02|Jambi Selatan
15.71.03|Jambi Timur
15.71.04|Pasar Jambi
15.71.05|Pelayangan
15.71.06|Danau Teluk
15.71.07|Kota Baru
15.71.08|Jelutung
15.71.09|Alam Barajo
15.71.10|Danau Sipin
15.71.11|Paal Merah
15.72.01|Sungai Penuh
15.72.02|Pesisir Bukit
15.72.03|Hamparan Rawang
15.72.04|Tanah Kampung
15.72.05|Kumun Debai
15.72.06|Pondok Tinggi
15.72.07|Koto Baru
15.72.08|Sungai Bungkal
16.01.07|Sosoh Buay Rayap
16.01.08|Pengandonan
16.01.09|Peninjauan
16.01.13|Baturaja Barat
16.01.14|Baturaja Timur
16.01.20|Ulu Ogan
16.01.21|Semidang Aji
16.01.22|Lubuk Batang
16.01.28|Lengkiti
16.01.29|Sinar Peninjauan
16.01.30|Lubuk Raja
16.01.31|Muara Jaya
16.01.32|Kedaton Peninjauan Raya
16.02.02|Tanjung Lubuk
16.02.03|Pedamaran
16.02.04|Mesuji
16.02.05|Kayu Agung
16.02.08|Sirah Pulau Padang
16.02.11|Tulung Selapan
16.02.12|Pampangan
16.02.13|Lempuing
16.02.14|Air Sugihan
16.02.15|Sungai Menang
16.02.17|Jejawi
16.02.18|Cengal
16.02.19|Pangkalan Lampam
16.02.20|Mesuji Makmur
16.02.21|Mesuji Raya
16.02.22|Lempuing Jaya
16.02.23|Teluk Gelam
16.02.24|Pedamaran Timur
16.03.01|Tanjung Agung
16.03.02|Muara Enim
16.03.03|Rambang Niru
16.03.04|Gunung Megang
16.03.06|Gelumbang
16.03.07|Lawang Kidul
16.03.08|Semende Darat Laut
16.03.09|Semende Darat Tengah
16.03.10|Semende Darat Ulu
16.03.11|Ujan Mas
16.03.14|Lubai
16.03.15|Rambang
16.03.16|Sungai Rotan
16.03.17|Lembak
16.03.19|Benakat
16.03.21|Kelekar
16.03.22|Muara Belida
16.03.23|Belimbing
16.03.24|Belida Darat
16.03.25|Lubai Ulu
16.03.26|Empat Petulai Dangku
16.03.27|Panang Enim
16.04.01|Tanjungsakti Pumu
16.04.06|Jarai
16.04.07|Kota Agung
16.04.08|Pulau Pinang
16.04.09|Merapi Barat
16.04.10|Lahat
16.04.12|Pajar Bulan
16.04.15|Mulak Ulu
16.04.16|Kikim Selatan
16.04.17|Kikim Timur
16.04.18|Kikim Tengah
16.04.19|Kikim Barat
16.04.20|Pseksu
16.04.21|Gumay Talang
16.04.22|Pagar Gunung
16.04.23|Merapi Timur
16.04.24|Tanjung Sakti Pumi
16.04.25|Gumay Ulu
16.04.26|Merapi Selatan
16.04.27|Tanjungtebat
16.04.28|Muarapayang
16.04.29|Sukamerindu
16.04.30|Mulak Sebingkai
16.04.31|Lahat Selatan
16.05.01|Tugumulyo
16.05.02|Muara Lakitan
16.05.03|Muara Kelingi
16.05.08|Jayaloka
16.05.09|Muara Beliti
16.05.10|STL Ulu Terawas
16.05.11|Selangit
16.05.12|Megang Sakti
16.05.13|Purwodadi
16.05.14|BTS. Ulu
16.05.18|Tiang Pumpung Kepungut
16.05.19|Sumber Harta
16.05.20|Tuah Negeri
16.05.21|Suka Karya
16.06.01|Sekayu
16.06.02|Lais
16.06.03|Sungai Keruh
16.06.04|Batang Hari Leko
16.06.05|Sanga Desa
16.06.06|Babat Toman
16.06.07|Sungai Lilin
16.06.08|Keluang
16.06.09|Bayung Lencir
16.06.10|Plakat Tinggi
16.06.11|Lalan
16.06.12|Tungkal Jaya
16.06.13|Lawan Wetan
16.06.14|Babat Supat
16.06.15|Jirak Jaya
16.07.01|Banyuasin I
16.07.02|Banyuasin II
16.07.03|Banyuasin III
16.07.04|Pulau Rimau
16.07.05|Betung
16.07.06|Rambutan
16.07.07|Muara Padang
16.07.08|Muara Telang
16.07.09|Makarti Jaya
16.07.10|Talang Kelapa
16.07.11|Rantau Bayur
16.07.12|Tanjung Lago
16.07.13|Muara Sugihan
16.07.14|Air Salek
16.07.15|Tungkal Ilir
16.07.16|Suak Tapeh
16.07.17|Sembawa
16.07.18|Sumber Marga Telang
16.07.19|Air Kumbang
16.07.20|Karang Agung Ilir
16.07.21|Selat Penuguan
16.08.01|Martapura
16.08.02|Buay Madang
16.08.03|Belitang
16.08.04|Cempaka
16.08.05|Buay Pemuka Peliung
16.08.06|Madang Suku II
16.08.07|Madang Suku I
16.08.08|Semendawai Suku III
16.08.09|Belitang II
16.08.10|Belitang III
16.08.11|Bunga Mayang
16.08.12|Buay Madang Timur
16.08.13|Madang Suku III
16.08.14|Semendawai Barat
16.08.15|Semendawai Timur
16.08.16|Jayapura
16.08.17|Belitang Jaya
16.08.18|Belitang Madang Raya
16.08.19|Belitang Mulya
16.08.20|Buay Pemuka Bangsa Raja
16.09.01|Muara Dua
16.09.02|Pulau Beringin
16.09.03|Banding Agung
16.09.04|Muara Dua Kisam
16.09.05|Simpang
16.09.06|Buay Sandang Aji
16.09.07|Buay Runjung
16.09.08|Mekakau Ilir
16.09.09|Buay Pemaca
16.09.10|Kisam Tinggi
16.09.11|Kisam Ilir
16.09.12|Buay Pematang Ribu Ranau Tengah
16.09.13|Warkuk Ranau Selatan
16.09.14|Runjung Agung
16.09.15|Sungai Are
16.09.16|Sindang Danau
16.09.17|Buana Pemaca
16.09.18|Tiga Dihaji
16.09.19|Buay Rawan
16.10.01|Muara Kuang
16.10.02|Tanjung Batu
16.10.03|Tanjung Raja
16.10.04|Indralaya
16.10.05|Pemulutan
16.10.06|Rantau Alai
16.10.07|Indralaya Utara
16.10.08|Indralaya Selatan
16.10.09|Pemulutan Selatan
16.10.10|Pemulutan Barat
16.10.11|Rantau Panjang
16.10.12|Sungai Pinang
16.10.13|Kandis
16.10.14|Rambang Kuang
16.10.15|Lubuk Keliat
16.10.16|Payaraman
16.11.01|Muara Pinang
16.11.02|Pendopo
16.11.03|Ulu Musi
16.11.04|Tebing Tinggi
16.11.05|Lintang Kanan
16.11.06|Talang Padang
16.11.07|Pasemah Air Keruh
16.11.08|Sikap Dalam
16.11.09|Saling
16.11.10|Pendopo Barat
16.12.01|Talang Ubi
16.12.02|Penukal Utara
16.12.03|Penukal
16.12.04|Abab
16.12.05|Tanah Abang
16.13.01|Rupit
16.13.02|Rawas Ulu
16.13.03|Nibung
16.13.04|Rawas Ilir
16.13.05|Karang Dapo
16.13.06|Karang Jaya
16.13.07|Ulu Rawas
16.71.01|Ilir Barat Dua
16.71.02|Seberang Ulu Satu
16.71.03|Seberang Ulu Dua
16.71.04|Ilir Barat Satu
16.71.05|Ilir Timur Satu
16.71.06|Ilir Timur Dua
16.71.07|Sukarami
16.71.08|Sako
16.71.09|Kemuning
16.71.10|Kalidoni
16.71.11|Bukitkecil
16.71.12|Gandus
16.71.13|Kertapati
16.71.14|Plaju
16.71.15|Alang-alang Lebar
16.71.16|Sematangborang
16.71.17|Jakabaring
16.71.18|Ilir Timur Tiga
16.72.01|Pagar Alam Utara
16.72.02|Pagar Alam Selatan
16.72.03|Dempo Utara
16.72.04|Dempo Selatan
16.72.05|Dempo Tengah
16.73.01|Lubuk Linggau Timur I
16.73.02|Lubuk Linggau Barat I
16.73.03|Lubuk Linggau Selatan I
16.73.04|Lubuk Linggau Utara I
16.73.05|Lubuk Linggau Timur II
16.73.06|Lubuk Linggau Barat II
16.73.07|Lubuk Linggau Selatan II
16.73.08|Lubuk Linggau Utara II
16.74.01|Prabumulih Barat
16.74.02|Prabumulih Timur
16.74.03|Cambai
16.74.04|Rambang Kapak Tengah
16.74.05|Prabumulih Utara
16.74.06|Prabumulih Selatan
17.01.01|Kedurang
17.01.02|Seginim
17.01.03|Pino
17.01.04|Manna
17.01.05|Kota Manna
17.01.06|Pino Raya
17.01.07|Kedurang Ilir
17.01.08|Air Nipis
17.01.09|Ulu Manna
17.01.10|Bunga Mas
17.01.11|Pasar Manna
17.02.06|Kota Padang
17.02.07|Padang Ulak Tanding
17.02.08|Sindang Kelingi
17.02.09|Curup
17.02.10|Bermani Ulu
17.02.11|Selupu Rejang
17.02.16|Curup Utara
17.02.17|Curup Timur
17.02.18|Curup Selatan
17.02.19|Curup Tengah
17.02.20|Binduriang
17.02.21|Sindang Beliti Ulu
17.02.22|Sindang Dataran
17.02.23|Sindang Beliti Ilir
17.02.24|Bermani Ulu Raya
17.03.01|Enggano
17.03.06|Kerkap
17.03.07|Kota Arga Makmur
17.03.08|Giri Mulya
17.03.09|Padang Jaya
17.03.10|Lais
17.03.11|Batik Nau
17.03.12|Ketahun
17.03.13|Napal Putih
17.03.14|Putri Hijau
17.03.15|Air Besi
17.03.16|Air Napal
17.03.19|Hulu Palik
17.03.20|Air Padang
17.03.21|Arma Jaya
17.03.22|Tanjung Agung Palik
17.03.23|Ulok Kupai
17.03.24|Pinang Raya
17.03.25|Marga Sakti Sebelat
17.04.01|Kinal
17.04.02|Tanjung Kemuning
17.04.03|Kaur Utara
17.04.04|Kaur Tengah
17.04.05|Kaur Selatan
17.04.06|Maje
17.04.07|Nasal
17.04.08|Semidang Gumay
17.04.09|Kelam Tengah
17.04.10|Luas
17.04.11|Muara Sahung
17.04.12|Tetap
17.04.13|Lungkang Kule
17.04.14|Padang Guci Hilir
17.04.15|Padang Guci Hulu
17.05.01|Sukaraja
17.05.02|Seluma
17.05.03|Talo
17.05.04|Semidang Alas
17.05.05|Semidang Alas Maras
17.05.06|Air Periukan
17.05.07|Lubuk Sandi
17.05.08|Seluma Barat
17.05.09|Seluma Timur
17.05.10|Seluma Utara
17.05.11|Seluma Selatan
17.05.12|Talo Kecil
17.05.13|Ulu Talo
17.05.14|Ilir Talo
17.06.01|Lubuk Pinang
17.06.02|Kota Mukomuko
17.06.03|Teras Terunjam
17.06.04|Pondok Suguh
17.06.05|Ipuh
17.06.06|Malin Deman
17.06.07|Air Rami
17.06.08|Teramang Jaya
17.06.09|Selagan Raya
17.06.10|Penarik
17.06.11|XIV Koto
17.06.12|V Koto
17.06.13|Air Manjunto
17.06.14|Air Dikit
17.06.15|Sungai Rumbai
17.07.01|Lebong Utara
17.07.02|Lebong Atas
17.07.03|Lebong Tengah
17.07.04|Lebong Selatan
17.07.05|Rimbo Pengadang
17.07.06|Topos
17.07.07|Bingin Kuning
17.07.08|Lebong Sakti
17.07.09|Tubei
17.07.10|Amen
17.07.11|Uram Jaya
17.07.12|Pinang Belapis
17.08.01|Bermani Ilir
17.08.02|Ujan Mas
17.08.03|Tebat Karai
17.08.04|Kepahiang
17.08.05|Merigi
17.08.06|Kebawetan
17.08.07|Seberang Musi
17.08.08|Muara Kemumu
17.09.01|Karang Tinggi
17.09.02|Talang Empat
17.09.03|Pondok Kelapa
17.09.04|Pematang Tiga
17.09.05|Pagar Jati
17.09.06|Taba Penanjung
17.09.07|Merigi Kelindang
17.09.08|Merigi Sakti
17.09.09|Pondok Kubang
17.09.10|Bang Haji
17.09.11|Semidang Lagan
17.71.01|Selebar
17.71.02|Gading Cempaka
17.71.03|Teluk Segara
17.71.04|Muara Bangka Hulu
17.71.05|Kampung Melayu
17.71.06|Ratu Agung
17.71.07|Ratu Samban
17.71.08|Sungai Serut
17.71.09|Singaran Pati
18.01.04|Natar
18.01.05|Tanjung Bintang
18.01.06|Kalianda
18.01.07|Sidomulyo
18.01.08|Katibung
18.01.09|Penengahan
18.01.10|Palas
18.01.13|Jati Agung
18.01.14|Ketapang
18.01.15|Sragi
18.01.16|Raja Basa
18.01.17|Candipuro
18.01.18|Merbau Mataram
18.01.21|Bakauheni
18.01.22|Tanjung Sari
18.01.23|Way Sulan
18.01.24|Way Panji
18.02.01|Kalirejo
18.02.02|Bangun Rejo
18.02.03|Padang Ratu
18.02.04|Gunung Sugih
18.02.05|Trimurjo
18.02.06|Punggur
18.02.07|Terbanggi Besar
18.02.08|Seputih Raman
18.02.09|Rumbia
18.02.10|Seputih Banyak
18.02.11|Seputih Mataram
18.02.12|Seputih Surabaya
18.02.13|Terusan Nunyai
18.02.14|Bumi Ratu Nuban
18.02.15|Bekri
18.02.16|Seputih Agung
18.02.17|Way Pengubuan
18.02.18|Bandar Mataram
18.02.19|Pubian
18.02.20|Selagai Lingga
18.02.21|Anak Tuha
18.02.22|Sendang Agung
18.02.23|Kota Gajah
18.02.24|Bumi Nabung
18.02.25|Way Seputih
18.02.26|Bandar Surabaya
18.02.27|Anak Ratu Aji
18.02.28|Putra Rumbia
18.03.01|Bukit Kemuning
18.03.02|Kotabumi
18.03.03|Sungkai Selatan
18.03.04|Tanjung Raja
18.03.05|Abung Timur
18.03.06|Abung Barat
18.03.07|Abung Selatan
18.03.08|Sungkai Utara
18.03.09|Kotabumi Utara
18.03.10|Kotabumi Selatan
18.03.11|Abung Tengah
18.03.12|Abung Tinggi
18.03.13|Abung Semuli
18.03.14|Abung Surakarta
18.03.15|Muara Sungkai
18.03.16|Bunga Mayang
18.03.17|Hulu Sungkai
18.03.18|Sungkai Tengah
18.03.19|Abung Pekurun
18.03.20|Sungkai Jaya
18.03.21|Sungkai Barat
18.03.22|Abung Kunang
18.03.23|Blambangan Pagar
18.04.04|Balik Bukit
18.04.05|Sumber Jaya
18.04.06|Belalau
18.04.07|Way Tenong
18.04.08|Sekincau
18.04.09|Suoh
18.04.10|Batu Brak
18.04.11|Sukau
18.04.15|Gedung Surian
18.04.18|Kebun Tebu
18.04.19|Air Hitam
18.04.20|Pagar Dewa
18.04.21|Batu Ketulis
18.04.22|Lumbok Seminung
18.04.23|Bandar Negeri Suoh
18.05.02|Menggala
18.05.06|Gedung Aji
18.05.08|Banjar Agung
18.05.11|Gedung Meneng
18.05.12|Rawa Jitu Selatan
18.05.13|Penawar Tama
18.05.18|Rawa Jitu Timur
18.05.20|Banjar Margo
18.05.22|Rawa Pitu
18.05.23|Penawar Aji
18.05.25|Dente Teladas
18.05.26|Meraksa Aji
18.05.27|Gedung Aji Baru
18.05.29|Banjar Baru
18.05.30|Menggala Timur
18.06.01|Kota Agung
18.06.02|Talang Padang
18.06.03|Wonosobo
18.06.04|Pulau Panggung
18.06.09|Cukuh Balak
18.06.11|Pugung
18.06.12|Semaka
18.06.13|Sumberejo
18.06.15|Ulu Belu
18.06.16|Pematang Sawa
18.06.17|Kelumbayan
18.06.18|Kota Agung Barat
18.06.19|Kota Agung Timur
18.06.20|Gisting
18.06.21|Gunung Alip
18.06.24|Limau
18.06.25|Bandar Negeri Semuong
18.06.26|Air Naningan
18.06.27|Bulok
18.06.28|Kelumbayan Barat
18.07.01|Sukadana
18.07.02|Labuhan Maringgai
18.07.03|Jabung
18.07.04|Pekalongan
18.07.05|Sekampung
18.07.06|Batanghari
18.07.07|Way Jepara
18.07.08|Purbolinggo
18.07.09|Raman Utara
18.07.10|Metro Kibang
18.07.11|Marga Tiga
18.07.12|Sekampung Udik
18.07.13|Batanghari Nuban
18.07.14|Bumi Agung
18.07.15|Bandar Sribhawono
18.07.16|Mataram Baru
18.07.17|Melinting
18.07.18|Gunung Pelindung
18.07.19|Pasir Sakti
18.07.20|Waway Karya
18.07.21|Labuhan Ratu
18.07.22|Braja Selebah
18.07.23|Way Bungur
18.07.24|Marga Sekampung
18.08.01|Blambangan Umpu
18.08.02|Kasui
18.08.03|Banjit
18.08.04|Baradatu
18.08.05|Bahuga
18.08.06|Pakuan Ratu
18.08.07|Negeri Agung
18.08.08|Way Tuba
18.08.09|Rebang Tangkas
18.08.10|Gunung Labuhan
18.08.11|Negara Batin
18.08.12|Negeri Besar
18.08.13|Buay Bahuga
18.08.14|Bumi Agung
18.08.15|Umpu Semenguk
18.09.01|Gedong Tataan
18.09.02|Negeri Katon
18.09.03|Tegineneng
18.09.04|Way Lima
18.09.05|Padang Cermin
18.09.06|Punduh Pidada
18.09.07|Kedondong
18.09.08|Marga Punduh
18.09.09|Way Khilau
18.09.10|Teluk Pandan
18.09.11|Way Ratai
18.10.01|Pringsewu
18.10.02|Gading Rejo
18.10.03|Ambarawa
18.10.04|Pardasuka
18.10.05|Pagelaran
18.10.06|Banyumas
18.10.07|Adiluwih
18.10.08|Sukoharjo
18.10.09|Pagelaran Utara
18.11.01|Mesuji
18.11.02|Mesuji Timur
18.11.03|Rawa Jitu Utara
18.11.04|Way Serdang
18.11.05|Simpang Pematang
18.11.06|Panca Jaya
18.11.07|Tanjung Raya
18.12.01|Tulang Bawang Tengah
18.12.02|Tumijajar
18.12.03|Tulang Bawang Udik
18.12.04|Gunung Terang
18.12.05|Gunung Agung
18.12.06|Way Kenanga
18.12.07|Lambu Kibang
18.12.08|Pagar Dewa
18.12.09|Batu Putih
18.13.01|Pesisir Tengah
18.13.02|Pesisir Selatan
18.13.03|Lemong
18.13.04|Pesisir Utara
18.13.05|Karya Penggawa
18.13.06|Pulau Pisang
18.13.07|Way Krui
18.13.08|Krui Selatan
18.13.09|Ngambur
18.13.10|Ngaras
18.13.11|Bangkunat
18.71.01|Kedaton
18.71.02|Sukarame
18.71.03|Tanjungkarang Barat
18.71.04|Panjang
18.71.05|Tanjungkarang Timur
18.71.06|Tanjungkarang Pusat
18.71.07|Telukbetung Selatan
18.71.08|Telukbetung Barat
18.71.09|Telukbetung Utara
18.71.10|Rajabasa
18.71.11|Tanjung Senang
18.71.12|Sukabumi
18.71.13|Kemiling
18.71.14|Labuhan Ratu
18.71.15|Way Halim
18.71.16|Langkapura
18.71.17|Enggal
18.71.18|Kedamaian
18.71.19|Telukbetung Timur
18.71.20|Bumi Waras
18.72.01|Metro Pusat
18.72.02|Metro Utara
18.72.03|Metro Barat
18.72.04|Metro Timur
18.72.05|Metro Selatan
19.01.01|Sungailiat
19.01.02|Belinyu
19.01.03|Merawang
19.01.04|Mendo Barat
19.01.05|Pemali
19.01.06|Bakam
19.01.07|Riau Silip
19.01.08|Puding Besar
19.02.01|Tanjungpandan
19.02.02|Membalong
19.02.03|Selat Nasik
19.02.04|Sijuk
19.02.05|Badau
19.03.01|Toboali
19.03.02|Lepar
19.03.03|Airgegas
19.03.04|Simpang Rimba
19.03.05|Payung
19.03.06|Tukak Sadai
19.03.07|Pulau Besar
19.03.08|Kepulauan Pongok
19.04.01|Koba
19.04.02|Pangkalan Baru
19.04.03|Sungai Selan
19.04.04|Simpang Katis
19.04.05|Namang
19.04.06|Lubuk Besar
19.05.01|Mentok
19.05.02|Simpang Teritip
19.05.03|Jebus
19.05.04|Kelapa
19.05.05|Tempilang
19.05.06|Parittiga
19.06.01|Manggar
19.06.02|Gantung
19.06.03|Dendang
19.06.04|Kelapa Kampit
19.06.05|Damar
19.06.06|Simpang Renggiang
19.06.07|Simpang Pesak
19.71.01|Bukit Intan
19.71.02|Taman Sari
19.71.03|Pangkal Balam
19.71.04|Rangkui
19.71.05|Gerunggang
19.71.06|Gabek
19.71.07|Girimaya
21.01.04|Gunung Kijang
21.01.06|Bintan Timur
21.01.07|Bintan Utara
21.01.08|Teluk Bintan
21.01.09|Tambelan
21.01.10|Teluk Sebong
21.01.12|Toapaya
21.01.13|Mantang
21.01.14|Bintan Pesisir
21.01.15|Seri Kuala Lobam
21.02.01|Moro
21.02.02|Kundur
21.02.03|Karimun
21.02.04|Meral
21.02.05|Tebing
21.02.06|Buru
21.02.07|Kundur Utara
21.02.08|Kundur Barat
21.02.09|Durai
21.02.10|Meral Barat
21.02.11|Ungar
21.02.12|Belat
21.02.13|Selat Gelam
21.02.14|Sugie Besar
21.03.04|Midai
21.03.05|Bunguran Barat
21.03.06|Serasan
21.03.07|Bunguran Timur
21.03.08|Bunguran Utara
21.03.09|Subi
21.03.10|Pulau Laut
21.03.11|Pulau Tiga
21.03.15|Bunguran Timur Laut
21.03.16|Bunguran Tengah
21.03.18|Bunguran Selatan
21.03.19|Serasan Timur
21.03.20|Bunguran Batubi
21.03.21|Pulau Tiga Barat
21.03.22|Suak Midai
21.03.23|Pulau Panjang
21.03.24|Pulau Seluan
21.04.01|Singkep
21.04.02|Lingga
21.04.03|Senayang
21.04.04|Singkep Barat
21.04.05|Lingga Utara
21.04.06|Singkep Pesisir
21.04.07|Lingga Timur
21.04.08|Selayar
21.04.09|Singkep Selatan
21.04.10|Kepulauan Posek
21.04.11|Katang Bidare
21.04.12|Temiang Pesisir
21.04.13|Bakung Serumpun
21.05.01|Siantan
21.05.02|Palmatak
21.05.03|Siantan Timur
21.05.04|Siantan Selatan
21.05.05|Jemaja Timur
21.05.06|Jemaja
21.05.07|Siantan Tengah
21.05.08|Siantan Utara
21.05.09|Jemaja Barat
21.05.10|Kute Siantan
21.71.01|Belakang Padang
21.71.02|Batu Ampar
21.71.03|Sekupang
21.71.04|Nongsa
21.71.05|Bulang
21.71.06|Lubuk Baja
21.71.07|Sei Beduk
21.71.08|Galang
21.71.09|Bengkong
21.71.10|Batam Kota
21.71.11|Sagulung
21.71.12|Batu Aji
21.72.01|Tanjung Pinang Barat
21.72.02|Tanjung Pinang Timur
21.72.03|Tanjung Pinang Kota
21.72.04|Bukit Bestari
31.01.01|Kepulauan Seribu Utara
31.01.02|Kepulauan Seribu Selatan
31.71.01|Gambir
31.71.02|Sawah Besar
31.71.03|Kemayoran
31.71.04|Senen
31.71.05|Cempaka Putih
31.71.06|Menteng
31.71.07|Tanah Abang
31.71.08|Johar Baru
31.72.01|Penjaringan
31.72.02|Tanjung Priok
31.72.03|Koja
31.72.04|Cilincing
31.72.05|Pademangan
31.72.06|Kelapa Gading
31.73.01|Cengkareng
31.73.02|Grogol Petamburan
31.73.03|Taman Sari
31.73.04|Tambora
31.73.05|Kebon Jeruk
31.73.06|Kalideres
31.73.07|Pal Merah
31.73.08|Kembangan
31.74.01|Tebet
31.74.02|Setiabudi
31.74.03|Mampang Prapatan
31.74.04|Pasar Minggu
31.74.05|Kebayoran Lama
31.74.06|Cilandak
31.74.07|Kebayoran Baru
31.74.08|Pancoran
31.74.09|Jagakarsa
31.74.10|Pesanggrahan
31.75.01|Matraman
31.75.02|Pulogadung
31.75.03|Jatinegara
31.75.04|Kramatjati
31.75.05|Pasar Rebo
31.75.06|Cakung
31.75.07|Duren Sawit
31.75.08|Makasar
31.75.09|Ciracas
31.75.10|Cipayung
32.01.01|Cibinong
32.01.02|Gunungputri
32.01.03|Citeureup
32.01.04|Sukaraja
32.01.05|Babakan Madang
32.01.06|Jonggol
32.01.07|Cileungsi
32.01.08|Cariu
32.01.09|Sukamakmur
32.01.10|Parung
32.01.11|Gunungsindur
32.01.12|Kemang
32.01.13|Bojonggede
32.01.14|Leuwiliang
32.01.15|Ciampea
32.01.16|Cibungbulang
32.01.17|Pamijahan
32.01.18|Rumpin
32.01.19|Jasinga
32.01.20|Parungpanjang
32.01.21|Nanggung
32.01.22|Cigudeg
32.01.23|Tenjo
32.01.24|Ciawi
32.01.25|Cisarua
32.01.26|Megamendung
32.01.27|Caringin
32.01.28|Cijeruk
32.01.29|Ciomas
32.01.30|Dramaga
32.01.31|Tamansari
32.01.32|Klapanunggal
32.01.33|Ciseeng
32.01.34|Rancabungur
32.01.35|Sukajaya
32.01.36|Tanjungsari
32.01.37|Tajurhalang
32.01.38|Cigombong
32.01.39|Leuwisadeng
32.01.40|Tenjolaya
32.02.01|Palabuhanratu
32.02.02|Simpenan
32.02.03|Cikakak
32.02.04|Bantargadung
32.02.05|Cisolok
32.02.06|Cikidang
32.02.07|Lengkong
32.02.08|Jampangtengah
32.02.09|Warungkiara
32.02.10|Cikembar
32.02.11|Cibadak
32.02.12|Nagrak
32.02.13|Parungkuda
32.02.14|Bojonggenteng
32.02.15|Parakansalak
32.02.16|Cicurug
32.02.17|Cidahu
32.02.18|Kalapanunggal
32.02.19|Kabandungan
32.02.20|Waluran
32.02.21|Jampangkulon
32.02.22|Ciemas
32.02.23|Kalibunder
32.02.24|Surade
32.02.25|Cibitung
32.02.26|Ciracap
32.02.27|Gunungguruh
32.02.28|Cicantayan
32.02.29|Cisaat
32.02.30|Kadudampit
32.02.31|Caringin
32.02.32|Sukabumi
32.02.33|Sukaraja
32.02.34|Kebonpedes
32.02.35|Cireunghas
32.02.36|Sukalarang
32.02.37|Pabuaran
32.02.38|Purabaya
32.02.39|Nyalindung
32.02.40|Gegerbitung
32.02.41|Sagaranten
32.02.42|Curugkembar
32.02.43|Cidolog
32.02.44|Cidadap
32.02.45|Tegalbuleud
32.02.46|Cimanggu
32.02.47|Ciambar
32.03.01|Cianjur
32.03.02|Warungkondang
32.03.03|Cibeber
32.03.04|Cilaku
32.03.05|Ciranjang
32.03.06|Bonjogpicung
32.03.07|Karangtengah
32.03.08|Mande
32.03.09|Sukaluyu
32.03.10|Pacet
32.03.11|Cugenang
32.03.12|Cikalongkulon
32.03.13|Sukaresmi
32.03.14|Sukanagara
32.03.15|Campaka
32.03.16|Takokak
32.03.17|Kadupandak
32.03.18|Pagelarang
32.03.19|Tanggeung
32.03.20|Cubinong
32.03.21|Sindangbarang
32.03.22|Agrabinta
32.03.23|Cidaun
32.03.24|Naringgul
32.03.25|Campakamulya
32.03.26|Cikadu
32.03.27|Gekbrong
32.03.28|Cipanas
32.03.29|Cijati
32.03.30|Leles
32.03.31|Haurwangi
32.03.32|Pasirkuda
32.04.05|Cileunyi
32.04.06|Cimenyan
32.04.07|Cilengkrang
32.04.08|Bojongsoang
32.04.09|Margahayu
32.04.10|Margaasih
32.04.11|Katapang
32.04.12|Dayeuhkolot
32.04.13|Banjaran
32.04.14|Pameungpeuk
32.04.15|Pangalengan
32.04.16|Arjasari
32.04.17|Cimaung
32.04.25|Cicalengka
32.04.26|Nagreg
32.04.27|Cikancung
32.04.28|Rancaekek
32.04.29|Ciparay
32.04.30|Pacet
32.04.31|Kertasari
32.04.32|Baleendah
32.04.33|Majalaya
32.04.34|Solokanjeruk
32.04.35|Paseh
32.04.36|Ibun
32.04.37|Soreang
32.04.38|Pasirjambu
32.04.39|Ciwidey
32.04.40|Rancabali
32.04.44|Cangkuang
32.04.46|Kutawaringin
32.05.01|Garut Kota
32.05.02|Karangpawitan
32.05.03|Wanaraja
32.05.04|Tarogong Kaler
32.05.05|Tarogong Kidul
32.05.06|Banyuresmi
32.05.07|Samarang
32.05.08|Pasirwangi
32.05.09|Leles
32.05.10|Kadungora
32.05.11|Leuwigoong
32.05.12|Cibatu
32.05.13|Kersamanah
32.05.14|Malangbong
32.05.15|Sukawening
32.05.16|Karangtengah
32.05.17|Bayongbong
32.05.18|Cigedug
32.05.19|Cilawu
32.05.20|Cisurupan
32.05.21|Sukaresmi
32.05.22|Cikajang
32.05.23|Banjarwangi
32.05.24|Singajaya
32.05.25|Cihurip
32.05.26|Peundeuy
32.05.27|Pameungpeuk
32.05.28|Cisompet
32.05.29|Cibalong
32.05.30|Cikelet
32.05.31|Bungbulang
32.05.32|Mekarmukti
32.05.33|Pakenjeng
32.05.34|Pamulihan
32.05.35|Cisewu
32.05.36|Caringin
32.05.37|Talegong
32.05.38|Limbangan
32.05.39|Selaawi
32.05.40|Cibiuk
32.05.41|Pangatikan
32.05.42|Sucinaraja
32.06.01|Cipatujah
32.06.02|Karangnunggal
32.06.03|Cikalong
32.06.04|Pancatengah
32.06.05|Cikatomas
32.06.06|Cibalong
32.06.07|Parungponteng
32.06.08|Bantarkalong
32.06.09|Bojongasih
32.06.10|Culamega
32.06.11|Bojonggambir
32.06.12|Sodonghilir
32.06.13|Taraju
32.06.14|Salawu
32.06.15|Puspahiang
32.06.16|Tanjungjaya
32.06.17|Sukaraja
32.06.18|Salopa
32.06.19|Jatiwaras
32.06.20|Cineam
32.06.21|Karang Jaya
32.06.22|Manonjaya
32.06.23|Gunung Tanjung
32.06.24|Singaparna
32.06.25|Mangunreja
32.06.26|Sukarame
32.06.27|Cigalontang
32.06.28|Leuwisari
32.06.29|Padakembang
32.06.30|Sariwangi
32.06.31|Sukaratu
32.06.32|Cisayong
32.06.33|Sukahening
32.06.34|Rajapolah
32.06.35|Jamanis
32.06.36|Ciawi
32.06.37|Kadipaten
32.06.38|Pagerageung
32.06.39|Sukaresik
32.07.01|Ciamis
32.07.02|Cikoneng
32.07.03|Cijeungjing
32.07.04|Sadananya
32.07.05|Cidolog
32.07.06|Cihaurbeuti
32.07.07|Panumbangan
32.07.08|Panjalu
32.07.09|Kawali
32.07.10|Panawangan
32.07.11|Cipaku
32.07.12|Jatinagara
32.07.13|Rajadesa
32.07.14|Sukadana
32.07.15|Rancah
32.07.16|Tambaksari
32.07.17|Lakbok
32.07.18|Banjarsari
32.07.19|Pamarican
32.07.29|Cimaragas
32.07.30|Cisaga
32.07.31|Sindangkasih
32.07.32|Baregbeg
32.07.33|Sukamantri
32.07.34|Lumbung
32.07.35|Purwadadi
32.07.37|Banjaranyar
32.08.01|Kadugede
32.08.02|Ciniru
32.08.03|Subang
32.08.04|Ciwaru
32.08.05|Cibingbin
32.08.06|Luragung
32.08.07|Lebakwangi
32.08.08|Garawangi
32.08.09|Kuningan
32.08.10|Ciawigebang
32.08.11|Cidahu
32.08.12|Jalaksana
32.08.13|Cilimus
32.08.14|Mandirancan
32.08.15|Selajambe
32.08.16|Kramatmulya
32.08.17|Darma
32.08.18|Cigugur
32.08.19|Pasawahan
32.08.20|Nusaherang
32.08.21|Cipicung
32.08.22|Pancalang
32.08.23|Japara
32.08.24|Cimahi
32.08.25|Cilebak
32.08.26|Hantara
32.08.27|Kalimanggis
32.08.28|Cibeureum
32.08.29|Karangkancana
32.08.30|Maleber
32.08.31|Sindangagung
32.08.32|Cigandamekar
32.09.01|Waled
32.09.02|Ciledug
32.09.03|Losari
32.09.04|Pabedilan
32.09.05|Babakan
32.09.06|Karangsembung
32.09.07|Lemahabang
32.09.08|Susukan Lebak
32.09.09|Sedong
32.09.10|Astanajapura
32.09.11|Pangenan
32.09.12|Mundu
32.09.13|Beber
32.09.14|Talun
32.09.15|Sumber
32.09.16|Dukupuntang
32.09.17|Palimanan
32.09.18|Plumbon
32.09.19|Weru
32.09.20|Kedawung
32.09.21|Gunung Jati
32.09.22|Kepetakan
32.09.23|Klangenan
32.09.24|Arjawinangun
32.09.25|Panguragan
32.09.26|Ciwaringin
32.09.27|Susukan
32.09.28|Gegesik
32.09.29|Kaliwedi
32.09.30|Gebang
32.09.31|Depok
32.09.32|Pasaleman
32.09.33|Pabuaran
32.09.34|Karangwareng
32.09.35|Tengah Tani
32.09.36|Plered
32.09.37|Gempol
32.09.38|Greged
32.09.39|Suranenggala
32.09.40|Jamblang
32.10.01|Lemahsugih
32.10.02|Bantarujeg
32.10.03|Cikijing
32.10.04|Talaga
32.10.05|Argapura
32.10.06|Maja
32.10.07|Majalengka
32.10.08|Sukahaji
32.10.09|Rajagaluh
32.10.10|Leuwimunding
32.10.11|Jatiwangi
32.10.12|Dawuan
32.10.13|Kadipaten
32.10.14|Kertajati
32.10.15|Jatitujuh
32.10.16|Ligung
32.10.17|Sumberjaya
32.10.18|Panyingkiran
32.10.19|Palasah
32.10.20|Cigasong
32.10.21|Sindangwangi
32.10.22|Banjaran
32.10.23|Cingambul
32.10.24|Kasokandel
32.10.25|Sindang
32.10.26|Malausma
32.11.01|Wado
32.11.02|Jatinunggal
32.11.03|Darmaraja
32.11.04|Cibugel
32.11.05|Cisitu
32.11.06|Situraja
32.11.07|Conggeang
32.11.08|Paseh
32.11.09|Surian
32.11.10|Buahdua
32.11.11|Tanjungsari
32.11.12|Sukasari
32.11.13|Pamulihan
32.11.14|Cimanggung
32.11.15|Jatinangor
32.11.16|Rancakalong
32.11.17|Sumedang Selatan
32.11.18|Sumedang Utara
32.11.19|Ganeas
32.11.20|Tanjungkerta
32.11.21|Tanjungmedar
32.11.22|Cimalaka
32.11.23|Cisarua
32.11.24|Tomo
32.11.25|Ujungjaya
32.11.26|Jatigede
32.12.01|Haurgeulis
32.12.02|Kroya
32.12.03|Gabuswetan
32.12.04|Cikedung
32.12.05|Lelea
32.12.06|Bangodua
32.12.07|Widasari
32.12.08|Kertasemaya
32.12.09|Krangkeng
32.12.10|Karangampel
32.12.11|Juntinyuat
32.12.12|Sliyeg
32.12.13|Jatibarang
32.12.14|Balongan
32.12.15|Indramayu
32.12.16|Sindang
32.12.17|Cantigi
32.12.18|Lohbener
32.12.19|Arahan
32.12.20|Losarang
32.12.21|Kandanghaur
32.12.22|Bongas
32.12.23|Anjatan
32.12.24|Sukra
32.12.25|Gantar
32.12.26|Terisi
32.12.27|Sukagumiwang
32.12.28|Kedokan Bunder
32.12.29|Pasekan
32.12.30|Tukdana
32.12.31|Patrol
32.13.01|Sagalaherang
32.13.02|Cisalak
32.13.03|Subang
32.13.04|Kalijati
32.13.05|Pabuaran
32.13.06|Purwadadi
32.13.07|Pagaden
32.13.08|Binong
32.13.09|Ciasem
32.13.10|Pusakanagara
32.13.11|Pamanukan
32.13.12|Jalancagak
32.13.13|Blanakan
32.13.14|Tanjungsiang
32.13.15|Compreng
32.13.16|Patokbeusi
32.13.17|Cibogo
32.13.18|Cipunagara
32.13.19|Cijambe
32.13.20|Cipeundeuy
32.13.21|Legonkulon
32.13.22|Cikaum
32.13.23|Serangpanjang
32.13.24|Sukasari
32.13.25|Tambakdahan
32.13.26|Kasomalang
32.13.27|Dawuan
32.13.28|Pagaden Barat
32.13.29|Ciater
32.13.30|Pusakajaya
32.14.01|Purwakarta
32.14.02|Campaka
32.14.03|Jatiluhur
32.14.04|Plered
32.14.05|Sukatani
32.14.06|Darangdan
32.14.07|Maniis
32.14.08|Tegalwaru
32.14.09|Wanayasa
32.14.10|Pasawahan
32.14.11|Bojong
32.14.12|Babakancikao
32.14.13|Bungursari
32.14.14|Cibatu
32.14.15|Sukasari
32.14.16|Pondoksalam
32.14.17|Kiarapedes
32.15.01|Karawang Barat
32.15.02|Pangkalan
32.15.03|Telukjambe Timur
32.15.04|Ciampel
32.15.05|Klari
32.15.06|Rengasdengklok
32.15.07|Kutawaluya
32.15.08|Batujaya
32.15.09|Tirtajaya
32.15.10|Pedes
32.15.11|Cibuaya
32.15.12|Pakisjaya
32.15.13|Cikampek
32.15.14|Jatisari
32.15.15|Cilamaya Wetan
32.15.16|Tirtamulya
32.15.17|Telagasari
32.15.18|Rawamerta
32.15.19|Lemahabang
32.15.20|Tempuran
32.15.21|Majalaya
32.15.22|Jayakerta
32.15.23|Cilamaya Kulon
32.15.24|Banyusari
32.15.25|Kota Baru
32.15.26|Karawang Timur
32.15.27|Telukjambe Barat
32.15.28|Tegalwaru
32.15.29|Purwasari
32.15.30|Cilebar
32.16.01|Tarumajaya
32.16.02|Babelan
32.16.03|Sukawangi
32.16.04|Tambelang
32.16.05|Tambun Utara
32.16.06|Tambun Selatan
32.16.07|Cibitung
32.16.08|Cikarang Barat
32.16.09|Cikarang Utara
32.16.10|Karang Bahagia
32.16.11|Cikarang Timur
32.16.12|Kedung Waringin
32.16.13|Pebayuran
32.16.14|Sukakarya
32.16.15|Sukatani
32.16.16|Cabangbungin
32.16.17|Muaragembong
32.16.18|Setu
32.16.19|Cikarang Selatan
32.16.20|Cikarang Pusat
32.16.21|Serang Baru
32.16.22|Cibarusah
32.16.23|Bojongmangu
32.17.01|Lembang
32.17.02|Parongpong
32.17.03|Cisarua
32.17.04|Cikalongwetan
32.17.05|Cipeundeuy
32.17.06|Ngamprah
32.17.07|Cipatat
32.17.08|Padalarang
32.17.09|Batujajar
32.17.10|Cihampelas
32.17.11|Cililin
32.17.12|Cipongkor
32.17.13|Rongga
32.17.14|Sindangkerta
32.17.15|Gununghalu
32.17.16|Saguling
32.18.01|Parigi
32.18.02|Cijulang
32.18.03|Cimerak
32.18.04|Cigugur
32.18.05|Langkaplancar
32.18.06|Mangunjaya
32.18.07|Padaherang
32.18.08|Kalipucang
32.18.09|Pangandaran
32.18.10|Sidamulih
32.71.01|Bogor Selatan
32.71.02|Bogor Timur
32.71.03|Bogor Tengah
32.71.04|Bogor Barat
32.71.05|Bogor Utara
32.71.06|Tanah Sareal
32.72.01|Gunung Puyuh
32.72.02|Cikole
32.72.03|Citamiang
32.72.04|Warudoyong
32.72.05|Baros
32.72.06|Lembursitu
32.72.07|Cibeureum
32.73.01|Sukasari
32.73.02|Coblong
32.73.03|Babakan Ciparay
32.73.04|Bojongloa Kaler
32.73.05|Andir
32.73.06|Cicendo
32.73.07|Sukajadi
32.73.08|Cidadap
32.73.09|Bandung Wetan
32.73.10|Astanaanyar
32.73.11|Regol
32.73.12|Batununggal
32.73.13|Lengkong
32.73.14|Cibeunying Kidul
32.73.15|Bandung Kulon
32.73.16|Kiaracondong
32.73.17|Bojongloa Kidul
32.73.18|Cibeunying Kaler
32.73.19|Sumur Bandung
32.73.20|Antapani
32.73.21|Bandung Kidul
32.73.22|Buahbatu
32.73.23|Rancasari
32.73.24|Arcamanik
32.73.25|Cibiru
32.73.26|Ujungberung
32.73.27|Gedebage
32.73.28|Panyileukan
32.73.29|Cinambo
32.73.30|Mandalajati
32.74.01|Kejaksan
32.74.02|Lemahwungkuk
32.74.03|Harjamukti
32.74.04|Pekalipan
32.74.05|Kesambi
32.75.01|Bekasi Timur
32.75.02|Bekasi Barat
32.75.03|Bekasi Utara
32.75.04|Bekasi Selatan
32.75.05|Rawalumbu
32.75.06|Medansatria
32.75.07|Bantargebang
32.75.08|Pondokgede
32.75.09|Jatiasih
32.75.10|Jatisampurna
32.75.11|Mustikajaya
32.75.12|Pondokmelati
32.76.01|Pancoran Mas
32.76.02|Cimanggis
32.76.03|Sawangan
32.76.04|Limo
32.76.05|Sukmajaya
32.76.06|Beji
32.76.07|Cipayung
32.76.08|Cilodong
32.76.09|Cinere
32.76.10|Tapos
32.76.11|Bojongsari
32.77.01|Cimahi Selatan
32.77.02|Cimahi Tengah
32.77.03|Cimahi Utara
32.78.01|Cihideung
32.78.02|Cipedes
32.78.03|Tawang
32.78.04|Indihiang
32.78.05|Kawalu
32.78.06|Cibeureum
32.78.07|Tamansari
32.78.08|Mangkubumi
32.78.09|Bungursari
32.78.10|Purbaratu
32.79.01|Banjar
32.79.02|Pataruman
32.79.03|Purwaharja
32.79.04|Langensari
33.01.01|Kedungreja
33.01.02|Kesugihan
33.01.03|Adipala
33.01.04|Binangun
33.01.05|Nusawungu
33.01.06|Kroya
33.01.07|Maos
33.01.08|Jeruklegi
33.01.09|Kawunganten
33.01.10|Gandrungmangu
33.01.11|Sidareja
33.01.12|Karangpucung
33.01.13|Cimanggu
33.01.14|Majenang
33.01.15|Wanareja
33.01.16|Dayeuhluhur
33.01.17|Sampang
33.01.18|Cipari
33.01.19|Patimuan
33.01.20|Bantarsari
33.01.21|Cilacap Selatan
33.01.22|Cilacap Tengah
33.01.23|Cilacap Utara
33.01.24|Kampung Laut
33.02.01|Lumbir
33.02.02|Wangon
33.02.03|Jatilawang
33.02.04|Rawalo
33.02.05|Kebasen
33.02.06|Kemranjen
33.02.07|Sumpiuh
33.02.08|Tambak
33.02.09|Somagede
33.02.10|Kalibagor
33.02.11|Banyumas
33.02.12|Patikraja
33.02.13|Purwojati
33.02.14|Ajibarang
33.02.15|Gumelar
33.02.16|Pekuncen
33.02.17|Cilongok
33.02.18|Karanglewas
33.02.19|Sokaraja
33.02.20|Kembaran
33.02.21|Sumbang
33.02.22|Baturraden
33.02.23|Kedungbanteng
33.02.24|Purwokerto Selatan
33.02.25|Purwokerto Barat
33.02.26|Purwokerto Timur
33.02.27|Purwokerto Utara
33.03.01|Kemangkon
33.03.02|Bukateja
33.03.03|Kejobong
33.03.04|Kaligondang
33.03.05|Purbalingga
33.03.06|Kalimanah
33.03.07|Kutasari
33.03.08|Mrebet
33.03.09|Bobotsari
33.03.10|Karangreja
33.03.11|Karanganyar
33.03.12|Karangmoncol
33.03.13|Rembang
33.03.14|Bojongsari
33.03.15|Padamara
33.03.16|Pengadegan
33.03.17|Karangjambu
33.03.18|Kertanegara
33.04.01|Susukan
33.04.02|Purworeja Klampok
33.04.03|Mandiraja
33.04.04|Purwanegara
33.04.05|Bawang
33.04.06|Banjarnegara
33.04.07|Sigaluh
33.04.08|Madukara
33.04.09|Banjarmangu
33.04.10|Wanadadi
33.04.11|Rakit
33.04.12|Punggelan
33.04.13|Karangkobar
33.04.14|Pagentan
33.04.15|Pejawaran
33.04.16|Batur
33.04.17|Wanayasa
33.04.18|Kalibening
33.04.19|Pandanarum
33.04.20|Pagedongan
33.05.01|Ayah
33.05.02|Buayan
33.05.03|Puring
33.05.04|Petanahan
33.05.05|Klirong
33.05.06|Buluspesantren
33.05.07|Ambal
33.05.08|Mirit
33.05.09|Prembun
33.05.10|Kutowinangun
33.05.11|Alian
33.05.12|Kebumen
33.05.13|Pejagoan
33.05.14|Sruweng
33.05.15|Adimulyo
33.05.16|Kuwarasan
33.05.17|Rowokele
33.05.18|Sempor
33.05.19|Gombong
33.05.20|Karanganyar
33.05.21|Karanggayam
33.05.22|Sadang
33.05.23|Bonorowo
33.05.24|Padureso
33.05.25|Poncowarno
33.05.26|Karangsambung
33.06.01|Grabag
33.06.02|Ngombol
33.06.03|Purwodadi
33.06.04|Bagelen
33.06.05|Kaligesing
33.06.06|Purworejo
33.06.07|Banyuurip
33.06.08|Bayan
33.06.09|Kutoarjo
33.06.10|Butuh
33.06.11|Pituruh
33.06.12|Kemiri
33.06.13|Bruno
33.06.14|Gebang
33.06.15|Loano
33.06.16|Bener
33.07.01|Wadaslintang
33.07.02|Kepil
33.07.03|Sapuran
33.07.04|Kaliwiro
33.07.05|Leksono
33.07.06|Selomerto
33.07.07|Kalikajar
33.07.08|Kertek
33.07.09|Wonosobo
33.07.10|Watumalang
33.07.11|Mojotengah
33.07.12|Garung
33.07.13|Kejajar
33.07.14|Sukoharjo
33.07.15|Kalibawang
33.08.01|Salaman
33.08.02|Borobudur
33.08.03|Ngluwar
33.08.04|Salam
33.08.05|Srumbung
33.08.06|Dukun
33.08.07|Sawangan
33.08.08|Muntilan
33.08.09|Mungkid
33.08.10|Mertoyudan
33.08.11|Tempuran
33.08.12|Kajoran
33.08.13|Kaliangkrik
33.08.14|Bandongan
33.08.15|Candimulyo
33.08.16|Pakis
33.08.17|Ngablak
33.08.18|Grabag
33.08.19|Tegalrejo
33.08.20|Secang
33.08.21|Windusari
33.09.01|Selo
33.09.02|Ampel
33.09.03|Cepogo
33.09.04|Musuk
33.09.05|Boyolali
33.09.06|Mojosongo
33.09.07|Teras
33.09.08|Sawit
33.09.09|Banyudono
33.09.10|Sambi
33.09.11|Ngemplak
33.09.12|Nogosari
33.09.13|Simo
33.09.14|Karanggede
33.09.15|Klego
33.09.16|Andong
33.09.17|Kemusu
33.09.18|Wonosegoro
33.09.19|Juwangi
33.09.20|Gladagsari
33.09.21|Tamansari
33.09.22|Wonosamodro
33.10.01|Prambanan
33.10.02|Gantiwarno
33.10.03|Wedi
33.10.04|Bayat
33.10.05|Cawas
33.10.06|Trucuk
33.10.07|Kebonarum
33.10.08|Jogonalan
33.10.09|Manisrenggo
33.10.10|Karangnongko
33.10.11|Ceper
33.10.12|Pedan
33.10.13|Karangdowo
33.10.14|Juwiring
33.10.15|Wonosari
33.10.16|Delanggu
33.10.17|Polanharjo
33.10.18|Karanganom
33.10.19|Tulung
33.10.20|Jatinom
33.10.21|Kemalang
33.10.22|Ngawen
33.10.23|Kalikotes
33.10.24|Klaten Utara
33.10.25|Klaten Tengah
33.10.26|Klaten Selatan
33.11.01|Weru
33.11.02|Bulu
33.11.03|Tawangsari
33.11.04|Sukoharjo
33.11.05|Nguter
33.11.06|Bendosari
33.11.07|Polokarto
33.11.08|Mojolaban
33.11.09|Grogol
33.11.10|Baki
33.11.11|Gatak
33.11.12|Kartasura
33.12.01|Pracimantoro
33.12.02|Giritontro
33.12.03|Giriwoyo
33.12.04|Batuwarno
33.12.05|Tirtomoyo
33.12.06|Nguntoronadi
33.12.07|Baturetno
33.12.08|Eromoko
33.12.09|Wuryantoro
33.12.10|Manyaran
33.12.11|Selogiri
33.12.12|Wonogiri
33.12.13|Ngadirojo
33.12.14|Sidoharjo
33.12.15|Jatiroto
33.12.16|Kismantoro
33.12.17|Purwantoro
33.12.18|Bulukerto
33.12.19|Slogohimo
33.12.20|Jatisrono
33.12.21|Jatipurno
33.12.22|Girimarto
33.12.23|Karangtengah
33.12.24|Paranggupito
33.12.25|Puhpelem
33.13.01|Jatipuro
33.13.02|Jatiyoso
33.13.03|Jumapolo
33.13.04|Jumantono
33.13.05|Matesih
33.13.06|Tawangmangu
33.13.07|Ngargoyoso
33.13.08|Karangpandan
33.13.09|Karanganyar
33.13.10|Tasikmadu
33.13.11|Jaten
33.13.12|Colomadu
33.13.13|Gondangrejo
33.13.14|Kebakkramat
33.13.15|Mojogedang
33.13.16|Kerjo
33.13.17|Jenawi
33.14.01|Kalijambe
33.14.02|Plupuh
33.14.03|Masaran
33.14.04|Kedawung
33.14.05|Sambirejo
33.14.06|Gondang
33.14.07|Sambungmacan
33.14.08|Ngrampal
33.14.09|Karangmalang
33.14.10|Sragen
33.14.11|Sidoharjo
33.14.12|Tanon
33.14.13|Gemolong
33.14.14|Miri
33.14.15|Sumberlawang
33.14.16|Mondokan
33.14.17|Sukodono
33.14.18|Gesi
33.14.19|Tangen
33.14.20|Jenar
33.15.01|Kedungjati
33.15.02|Karangrayung
33.15.03|Penawangan
33.15.04|Toroh
33.15.05|Geyer
33.15.06|Pulokulon
33.15.07|Kradenan
33.15.08|Gabus
33.15.09|Ngaringan
33.15.10|Wirosari
33.15.11|Tawangharjo
33.15.12|Grobogan
33.15.13|Purwodadi
33.15.14|Brati
33.15.15|Klambu
33.15.16|Godong
33.15.17|Gubug
33.15.18|Tegowanu
33.15.19|Tanggungharjo
33.16.01|Jati
33.16.02|Randublatung
33.16.03|Kradenan
33.16.04|Kedungtuban
33.16.05|Cepu
33.16.06|Sambong
33.16.07|Jiken
33.16.08|Jepon
33.16.09|Blora
33.16.10|Tunjungan
33.16.11|Banjarejo
33.16.12|Ngawen
33.16.13|Kunduran
33.16.14|Todanan
33.16.15|Bogorejo
33.16.16|Japah
33.17.01|Sumber
33.17.02|Bulu
33.17.03|Gunem
33.17.04|Sale
33.17.05|Sarang
33.17.06|Sedan
33.17.07|Pamotan
33.17.08|Sulang
33.17.09|Kaliori
33.17.10|Rembang
33.17.11|Pancur
33.17.12|Kragan
33.17.13|Sluke
33.17.14|Lasem
33.18.01|Sukolilo
33.18.02|Kayen
33.18.03|Tambakromo
33.18.04|Winong
33.18.05|Pucakwangi
33.18.06|Jaken
33.18.07|Batangan
33.18.08|Juwana
33.18.09|Jakenan
33.18.10|Pati
33.18.11|Gabus
33.18.12|Margorejo
33.18.13|Gembong
33.18.14|Tlogowungu
33.18.15|Wedarijaksa
33.18.16|Margoyoso
33.18.17|Gunungwungkal
33.18.18|Cluwak
33.18.19|Tayu
33.18.20|Dukuhseti
33.18.21|Trangkil
33.19.01|Kaliwungu
33.19.02|Kota Kudus
33.19.03|Jati
33.19.04|Undaan
33.19.05|Mejobo
33.19.06|Jekulo
33.19.07|Bae
33.19.08|Gebog
33.19.09|Dawe
33.20.01|Kedung
33.20.02|Pecangaan
33.20.03|Welahan
33.20.04|Mayong
33.20.05|Batealit
33.20.06|Jepara
33.20.07|Mlonggo
33.20.08|Bangsri
33.20.09|Keling
33.20.10|Karimunjawa
33.20.11|Tahunan
33.20.12|Nalumsari
33.20.13|Kalinyamatan
33.20.14|Kembang
33.20.15|Pakis Aji
33.20.16|Donorojo
33.21.01|Mranggen
33.21.02|Karangawen
33.21.03|Guntur
33.21.04|Sayung
33.21.05|Karangtengah
33.21.06|Wonosalam
33.21.07|Dempet
33.21.08|Gajah
33.21.09|Karanganyar
33.21.10|Mijen
33.21.11|Demak
33.21.12|Bonang
33.21.13|Wedung
33.21.14|Kebonagung
33.22.01|Getasan
33.22.02|Tengaran
33.22.03|Susukan
33.22.04|Suruh
33.22.05|Pabelan
33.22.06|Tuntang
33.22.07|Banyubiru
33.22.08|Jambu
33.22.09|Sumowono
33.22.10|Ambarawa
33.22.11|Bawen
33.22.12|Bringin
33.22.13|Bergas
33.22.15|Pringapus
33.22.16|Bancak
33.22.17|Kaliwungu
33.22.18|Ungaran Barat
33.22.19|Ungaran Timur
33.22.20|Bandungan
33.23.01|Bulu
33.23.02|Tembarak
33.23.03|Temanggung
33.23.04|Pringsurat
33.23.05|Kaloran
33.23.06|Kandangan
33.23.07|Kedu
33.23.08|Parakan
33.23.09|Ngadirejo
33.23.10|Jumo
33.23.11|Tretep
33.23.12|Candiroto
33.23.13|Kranggan
33.23.14|Tlogomulyo
33.23.15|Selopampang
33.23.16|Bansari
33.23.17|Kledung
33.23.18|Bejen
33.23.19|Wonoboyo
33.23.20|Gemawang
33.24.01|Plantungan
33.24.02|Pageruyung
33.24.03|Sukorejo
33.24.04|Patean
33.24.05|Singorojo
33.24.06|Limbangan
33.24.07|Boja
33.24.08|Kaliwungu
33.24.09|Brangsong
33.24.10|Pegandon
33.24.11|Gemuh
33.24.12|Weleri
33.24.13|Cepiring
33.24.14|Patebon
33.24.15|Kendal
33.24.16|Rowosari
33.24.17|Kangkung
33.24.18|Ringinarum
33.24.19|Ngampel
33.24.20|Kaliwungu Selatan
33.25.01|Wonotunggal
33.25.02|Bandar
33.25.03|Blado
33.25.04|Reban
33.25.05|Bawang
33.25.06|Tersono
33.25.07|Gringsing
33.25.08|Limpung
33.25.09|Subah
33.25.10|Tulis
33.25.11|Batang
33.25.12|Warungasem
33.25.13|Kandeman
33.25.14|Pecalungan
33.25.15|Banyuputih
33.26.01|Kandangserang
33.26.02|Paninggaran
33.26.03|Lebakbarang
33.26.04|Petungkriyono
33.26.05|Talun
33.26.06|Doro
33.26.07|Karanganyar
33.26.08|Kajen
33.26.09|Kesesi
33.26.10|Sragi
33.26.11|Bojong
33.26.12|Wonopringgo
33.26.13|Kedungwuni
33.26.14|Buaran
33.26.15|Tirto
33.26.16|Wiradesa
33.26.17|Siwalan
33.26.18|Karangdadap
33.26.19|Wonokerto
33.27.01|Moga
33.27.02|Pulosari
33.27.03|Belik
33.27.04|Watukumpul
33.27.05|Bodeh
33.27.06|Bantarbolang
33.27.07|Randudongkal
33.27.08|Pemalang
33.27.09|Taman
33.27.10|Petarukan
33.27.11|Ampelgading
33.27.12|Comal
33.27.13|Ulujami
33.27.14|Warungpring
33.28.01|Margasari
33.28.02|Bumijawa
33.28.03|Bojong
33.28.04|Balapulang
33.28.05|Pagerbarang
33.28.06|Lebaksiu
33.28.07|Jatinegara
33.28.08|Kedungbanteng
33.28.09|Pangkah
33.28.10|Slawi
33.28.11|Adiwerna
33.28.12|Talang
33.28.13|Dukuhturi
33.28.14|Tarub
33.28.15|Kramat
33.28.16|Suradadi
33.28.17|Warureja
33.28.18|Dukuhwaru
33.29.01|Salem
33.29.02|Bantarkawung
33.29.03|Bumiayu
33.29.04|Paguyangan
33.29.05|Sirampog
33.29.06|Tonjong
33.29.07|Jatibarang
33.29.08|Wanasari
33.29.09|Brebes
33.29.10|Songgom
33.29.11|Kersana
33.29.12|Losari
33.29.13|Tanjung
33.29.14|Bulakamba
33.29.15|Larangan
33.29.16|Ketanggungan
33.29.17|Banjarharjo
33.71.01|Magelang Selatan
33.71.02|Magelang Utara
33.71.03|Magelang Tengah
33.72.01|Laweyan
33.72.02|Serengan
33.72.03|Pasar Kliwon
33.72.04|Jebres
33.72.05|Banjarsari
33.73.01|Sidorejo
33.73.02|Tingkir
33.73.03|Argomulyo
33.73.04|Sidomukti
33.74.01|Semarang Tengah
33.74.02|Semarang Utara
33.74.03|Semarang Timur
33.74.04|Gayamsari
33.74.05|Genuk
33.74.06|Pedurungan
33.74.07|Semarang Selatan
33.74.08|Candisari
33.74.09|Gajahmungkur
33.74.10|Tembalang
33.74.11|Banyumanik
33.74.12|Gunungpati
33.74.13|Semarang Barat
33.74.14|Mijen
33.74.15|Ngaliyan
33.74.16|Tugu
33.75.01|Pekalongan Barat
33.75.02|Pekalongan Timur
33.75.03|Pekalongan Utara
33.75.04|Pekalongan Selatan
33.76.01|Tegal Barat
33.76.02|Tegal Timur
33.76.03|Tegal Selatan
33.76.04|Margadana
34.01.01|Temon
34.01.02|Wates
34.01.03|Panjatan
34.01.04|Galur
34.01.05|Lendah
34.01.06|Sentolo
34.01.07|Pengasih
34.01.08|Kokap
34.01.09|Girimulyo
34.01.10|Nanggulan
34.01.11|Samigaluh
34.01.12|Kalibawang
34.02.01|Srandakan
34.02.02|Sanden
34.02.03|Kretek
34.02.04|Pundong
34.02.05|Bambanglipuro
34.02.06|Pandak
34.02.07|Pajangan
34.02.08|Bantul
34.02.09|Jetis
34.02.10|Imogiri
34.02.11|Dlingo
34.02.12|Banguntapan
34.02.13|Pleret
34.02.14|Piyungan
34.02.15|Sewon
34.02.16|Kasihan
34.02.17|Sedayu
34.03.01|Wonosari
34.03.02|Nglipar
34.03.03|Playen
34.03.04|Patuk
34.03.05|Paliyan
34.03.06|Panggang
34.03.07|Tepus
34.03.08|Semanu
34.03.09|Karangmojo
34.03.10|Ponjong
34.03.11|Rongkop
34.03.12|Semin
34.03.13|Ngawen
34.03.14|Gedangsari
34.03.15|Saptosari
34.03.16|Girisubo
34.03.17|Tanjungsari
34.03.18|Purwosari
34.04.01|Gamping
34.04.02|Godean
34.04.03|Moyudan
34.04.04|Minggir
34.04.05|Seyegan
34.04.06|Mlati
34.04.07|Depok
34.04.08|Berbah
34.04.09|Prambanan
34.04.10|Kalasan
34.04.11|Ngemplak
34.04.12|Ngaglik
34.04.13|Sleman
34.04.14|Tempel
34.04.15|Turi
34.04.16|Pakem
34.04.17|Cangkringan
34.71.01|Tegalrejo
34.71.02|Jetis
34.71.03|Gondokusuman
34.71.04|Danurejan
34.71.05|Gedongtengen
34.71.06|Ngampilan
34.71.07|Wirobrajan
34.71.08|Mantrijeron
34.71.09|Kraton
34.71.10|Gondomanan
34.71.11|Pakualaman
34.71.12|Mergangsan
34.71.13|Umbulharjo
34.71.14|Kotagede
35.01.01|Donorojo
35.01.02|Pringkuku
35.01.03|Punung
35.01.04|Pacitan
35.01.05|Kebonagung
35.01.06|Arjosari
35.01.07|Nawangan
35.01.08|Bandar
35.01.09|Tegalombo
35.01.10|Tulakan
35.01.11|Ngadirojo
35.01.12|Sudimoro
35.02.01|Slahung
35.02.02|Ngrayun
35.02.03|Bungkal
35.02.04|Sambit
35.02.05|Sawoo
35.02.06|Sooko
35.02.07|Pulung
35.02.08|Mlarak
35.02.09|Jetis
35.02.10|Siman
35.02.11|Balong
35.02.12|Kauman
35.02.13|Badegan
35.02.14|Sampung
35.02.15|Sukorejo
35.02.16|Babadan
35.02.17|Ponorogo
35.02.18|Jenangan
35.02.19|Ngebel
35.02.20|Jambon
35.02.21|Pudak
35.03.01|Panggul
35.03.02|Munjungan
35.03.03|Pule
35.03.04|Dongko
35.03.05|Tugu
35.03.06|Karangan
35.03.07|Kampak
35.03.08|Watulimo
35.03.09|Bendungan
35.03.10|Gandusari
35.03.11|Trenggalek
35.03.12|Pogalan
35.03.13|Durenan
35.03.14|Suruh
35.04.01|Tulungagung
35.04.02|Boyolangu
35.04.03|Kedungwaru
35.04.04|Ngantru
35.04.05|Kauman
35.04.06|Pagerwojo
35.04.07|Sendang
35.04.08|Karangrejo
35.04.09|Gondang
35.04.10|Sumbergempol
35.04.11|Ngunut
35.04.12|Pucanglaban
35.04.13|Rejotangan
35.04.14|Kalidawir
35.04.15|Besuki
35.04.16|Campurdarat
35.04.17|Bandung
35.04.18|Pakel
35.04.19|Tanggunggunung
35.05.01|Wonodadi
35.05.02|Udanawu
35.05.03|Srengat
35.05.04|Kademangan
35.05.05|Bakung
35.05.06|Ponggok
35.05.07|Sanankulon
35.05.08|Wonotirto
35.05.09|Nglegok
35.05.10|Kanigoro
35.05.11|Garum
35.05.12|Sutojayan
35.05.13|Panggungrejo
35.05.14|Talun
35.05.15|Gandusari
35.05.16|Binangun
35.05.17|Wlingi
35.05.18|Doko
35.05.19|Kesamben
35.05.20|Wates
35.05.21|Selorejo
35.05.22|Selopuro
35.06.01|Semen
35.06.02|Mojo
35.06.03|Kras
35.06.04|Ngadiluwih
35.06.05|Kandat
35.06.06|Wates
35.06.07|Ngancar
35.06.08|Puncu
35.06.09|Plosoklaten
35.06.10|Gurah
35.06.11|Pagu
35.06.12|Gampengrejo
35.06.13|Grogol
35.06.14|Papar
35.06.15|Purwoasri
35.06.16|Plemahan
35.06.17|Pare
35.06.18|Kepung
35.06.19|Kandangan
35.06.20|Tarokan
35.06.21|Kunjang
35.06.22|Banyakan
35.06.23|Ringinrejo
35.06.24|Kayen Kidul
35.06.25|Ngasem
35.06.26|Badas
35.07.01|Donomulyo
35.07.02|Pagak
35.07.03|Bantur
35.07.04|Sumbermanjing Wetan
35.07.05|Dampit
35.07.06|Ampelgading
35.07.07|Poncokusumo
35.07.08|Wajak
35.07.09|Turen
35.07.10|Gondanglegi
35.07.11|Kalipare
35.07.12|Sumberpucung
35.07.13|Kepanjen
35.07.14|Bululawang
35.07.15|Tajinan
35.07.16|Tumpang
35.07.17|Jabung
35.07.18|Pakis
35.07.19|Pakisaji
35.07.20|Ngajum
35.07.21|Wagir
35.07.22|Dau
35.07.23|Karangploso
35.07.24|Singosari
35.07.25|Lawang
35.07.26|Pujon
35.07.27|Ngantang
35.07.28|Kasembon
35.07.29|Gedangan
35.07.30|Tirtoyudo
35.07.31|Kromengan
35.07.32|Wonosari
35.07.33|Pagelaran
35.08.01|Tempursari
35.08.02|Pronojiwo
35.08.03|Candipuro
35.08.04|Pasirian
35.08.05|Tempeh
35.08.06|Kunir
35.08.07|Yosowilangun
35.08.08|Rowokangkung
35.08.09|Tekung
35.08.10|Lumajang
35.08.11|Pasrujambe
35.08.12|Senduro
35.08.13|Gucialit
35.08.14|Padang
35.08.15|Sukodono
35.08.16|Kedungjajang
35.08.17|Jatiroto
35.08.18|Randuagung
35.08.19|Klakah
35.08.20|Ranuyoso
35.08.21|Sumbersuko
35.09.01|Jombang
35.09.02|Kencong
35.09.03|Sumberbaru
35.09.04|Gumukmas
35.09.05|Umbulsari
35.09.06|Tanggul
35.09.07|Semboro
35.09.08|Puger
35.09.09|Bangsalsari
35.09.10|Balung
35.09.11|Wuluhan
35.09.12|Ambulu
35.09.13|Rambipuji
35.09.14|Panti
35.09.15|Sukorambi
35.09.16|Jenggawah
35.09.17|Ajung
35.09.18|Tempurejo
35.09.19|Kaliwates
35.09.20|Patrang
35.09.21|Sumbersari
35.09.22|Arjasa
35.09.23|Mumbulsari
35.09.24|Pakusari
35.09.25|Jelbuk
35.09.26|Mayang
35.09.27|Kalisat
35.09.28|Ledokombo
35.09.29|Sukowono
35.09.30|Silo
35.09.31|Sumberjambe
35.10.01|Pesanggaran
35.10.02|Bangorejo
35.10.03|Purwoharjo
35.10.04|Tegaldlimo
35.10.05|Muncar
35.10.06|Cluring
35.10.07|Gambiran
35.10.08|Srono
35.10.09|Genteng
35.10.10|Glenmore
35.10.11|Kalibaru
35.10.12|Singojuruh
35.10.13|Rogojampi
35.10.14|Kabat
35.10.15|Glagah
35.10.16|Banyuwangi
35.10.17|Giri
35.10.18|Wongsorejo
35.10.19|Songgon
35.10.20|Sempu
35.10.21|Kalipuro
35.10.22|Siliragung
35.10.23|Tegalsari
35.10.24|Licin
35.10.25|Blimbingsari
35.11.01|Maesan
35.11.02|Tamanan
35.11.03|Tlogosari
35.11.04|Sukosari
35.11.05|Pujer
35.11.06|Grujugan
35.11.07|Curahdami
35.11.08|Tenggarang
35.11.09|Wonosari
35.11.10|Tapen
35.11.11|Bondowoso
35.11.12|Wringin
35.11.13|Tegalampel
35.11.14|Klabang
35.11.15|Cermee
35.11.16|Prajekan
35.11.17|Pakem
35.11.18|Sumberwringin
35.11.19|Sempol
35.11.20|Binakal
35.11.21|Taman Krocok
35.11.22|Botolinggo
35.11.23|Jambesari Darus Sholah
35.12.01|Jatibanteng
35.12.02|Besuki
35.12.03|Suboh
35.12.04|Mlandingan
35.12.05|Kendit
35.12.06|Panarukan
35.12.07|Situbondo
35.12.08|Panji
35.12.09|Mangaran
35.12.10|Kapongan
35.12.11|Arjasa
35.12.12|Jangkar
35.12.13|Asembagus
35.12.14|Banyuputih
35.12.15|Sumbermalang
35.12.16|Banyuglugur
35.12.17|Bungatan
35.13.01|Sukapura
35.13.02|Sumber
35.13.03|Kuripan
35.13.04|Bantaran
35.13.05|Leces
35.13.06|Banyuanyar
35.13.07|Tiris
35.13.08|Krucil
35.13.09|Gading
35.13.10|Pakuniran
35.13.11|Kotaanyar
35.13.12|Paiton
35.13.13|Besuk
35.13.14|Kraksaan
35.13.15|Krejengan
35.13.16|Pajarakan
35.13.17|Maron
35.13.18|Gending
35.13.19|Dringu
35.13.20|Tegalsiwalan
35.13.21|Sumberasih
35.13.22|Wonomerto
35.13.23|Tongas
35.13.24|Lumbang
35.14.01|Purwodadi
35.14.02|Tutur
35.14.03|Puspo
35.14.04|Lumbang
35.14.05|Pasrepan
35.14.06|Kejayan
35.14.07|Wonorejo
35.14.08|Purwosari
35.14.09|Sukorejo
35.14.10|Prigen
35.14.11|Pandaan
35.14.12|Gempol
35.14.13|Beji
35.14.14|Bangil
35.14.15|Rembang
35.14.16|Kraton
35.14.17|Pohjentrek
35.14.18|Gondangwetan
35.14.19|Winongan
35.14.20|Grati
35.14.21|Nguling
35.14.22|Lekok
35.14.23|Rejoso
35.14.24|Tosari
35.15.01|Tarik
35.15.02|Prambon
35.15.03|Krembung
35.15.04|Porong
35.15.05|Jabon
35.15.06|Tanggulangin
35.15.07|Candi
35.15.08|Sidoarjo
35.15.09|Tulangan
35.15.10|Wonoayu
35.15.11|Krian
35.15.12|Balongbendo
35.15.13|Taman
35.15.14|Sukodono
35.15.15|Buduran
35.15.16|Gedangan
35.15.17|Sedati
35.15.18|Waru
35.16.01|Jatirejo
35.16.02|Gondang
35.16.03|Pacet
35.16.04|Trawas
35.16.05|Ngoro
35.16.06|Pungging
35.16.07|Kutorejo
35.16.08|Mojosari
35.16.09|Dlanggu
35.16.10|Bangsal
35.16.11|Puri
35.16.12|Trowulan
35.16.13|Sooko
35.16.14|Gedeg
35.16.15|Kemlagi
35.16.16|Jetis
35.16.17|Dawarblandong
35.16.18|Mojoanyar
35.17.01|Perak
35.17.02|Gudo
35.17.03|Ngoro
35.17.04|Bareng
35.17.05|Wonosalam
35.17.06|Mojoagung
35.17.07|Mojowarno
35.17.08|Diwek
35.17.09|Jombang
35.17.10|Peterongan
35.17.11|Sumobito
35.17.12|Kesamben
35.17.13|Tembelang
35.17.14|Ploso
35.17.15|Plandaan
35.17.16|Kabuh
35.17.17|Kudu
35.17.18|Bandarkedungmulyo
35.17.19|Jogoroto
35.17.20|Megaluh
35.17.21|Ngusikan
35.18.01|Sawahan
35.18.02|Ngetos
35.18.03|Berbek
35.18.04|Loceret
35.18.05|Pace
35.18.06|Prambon
35.18.07|Ngronggot
35.18.08|Kertosono
35.18.09|Patianrowo
35.18.10|Baron
35.18.11|Tanjunganom
35.18.12|Sukomoro
35.18.13|Nganjuk
35.18.14|Bagor
35.18.15|Wilangan
35.18.16|Rejoso
35.18.17|Gondang
35.18.18|Ngluyu
35.18.19|Lengkong
35.18.20|Jatikalen
35.19.01|Kebonsari
35.19.02|Dolopo
35.19.03|Geger
35.19.04|Dagangan
35.19.05|Kare
35.19.06|Gemarang
35.19.07|Wungu
35.19.08|Madiun
35.19.09|Jiwan
35.19.10|Balerejo
35.19.11|Mejayan
35.19.12|Saradan
35.19.13|Pilangkenceng
35.19.14|Sawahan
35.19.15|Wonoasri
35.20.01|Poncol
35.20.02|Parang
35.20.03|Lembeyan
35.20.04|Takeran
35.20.05|Kawedanan
35.20.06|Magetan
35.20.07|Plaosan
35.20.08|Panekan
35.20.09|Sukomoro
35.20.10|Bendo
35.20.11|Maospati
35.20.12|Barat
35.20.13|Karangrejo
35.20.14|Karas
35.20.15|Kartoharjo
35.20.16|Ngariboyo
35.20.17|Nguntoronadi
35.20.18|Sidorejo
35.21.01|Sine
35.21.02|Ngrambe
35.21.03|Jogorogo
35.21.04|Kendal
35.21.05|Geneng
35.21.06|Kwadungan
35.21.07|Karangjati
35.21.08|Padas
35.21.09|Ngawi
35.21.10|Paron
35.21.11|Kedunggalar
35.21.12|Widodaren
35.21.13|Mantingan
35.21.14|Pangkur
35.21.15|Bringin
35.21.16|Pitu
35.21.17|Karanganyar
35.21.18|Gerih
35.21.19|Kasreman
35.22.01|Ngraho
35.22.02|Tambakrejo
35.22.03|Ngambon
35.22.04|Ngasem
35.22.05|Bubulan
35.22.06|Dander
35.22.07|Sugihwaras
35.22.08|Kedungadem
35.22.09|Kepohbaru
35.22.10|Baureno
35.22.11|Kanor
35.22.12|Sumberrejo
35.22.13|Balen
35.22.14|Kapas
35.22.15|Bojonegoro
35.22.16|Kalitidu
35.22.17|Malo
35.22.18|Purwosari
35.22.19|Padangan
35.22.20|Kasiman
35.22.21|Temayang
35.22.22|Margomulyo
35.22.23|Trucuk
35.22.24|Sukosewu
35.22.25|Kedewan
35.22.26|Gondang
35.22.27|Sekar
35.22.28|Gayam
35.23.01|Kenduruan
35.23.02|Jatirogo
35.23.03|Bangilan
35.23.04|Bancar
35.23.05|Senori
35.23.06|Tambakboyo
35.23.07|Singgahan
35.23.08|Kerek
35.23.09|Parengan
35.23.10|Montong
35.23.11|Soko
35.23.12|Jenu
35.23.13|Merakurak
35.23.14|Rengel
35.23.15|Semanding
35.23.16|Tuban
35.23.17|Plumpang
35.23.18|Palang
35.23.19|Widang
35.23.20|Grabagan
35.24.01|Sukorame
35.24.02|Bluluk
35.24.03|Modo
35.24.04|Ngimbang
35.24.05|Babat
35.24.06|Kedungpring
35.24.07|Brondong
35.24.08|Laren
35.24.09|Sekaran
35.24.10|Maduran
35.24.11|Sambeng
35.24.12|Sugio
35.24.13|Pucuk
35.24.14|Paciran
35.24.15|Solokuro
35.24.16|Mantup
35.24.17|Sukodadi
35.24.18|Karanggeneng
35.24.19|Kembangbahu
35.24.20|Kalitengah
35.24.21|Turi
35.24.22|Lamongan
35.24.23|Tikung
35.24.24|Karangbinangun
35.24.25|Deket
35.24.26|Glagah
35.24.27|Sarirejo
35.25.01|Dukun
35.25.02|Balongpanggang
35.25.03|Panceng
35.25.04|Benjeng
35.25.05|Duduksampeyan
35.25.06|Wringinanom
35.25.07|Ujungpangkah
35.25.08|Kedamean
35.25.09|Sidayu
35.25.10|Manyar
35.25.11|Cerme
35.25.12|Bungah
35.25.13|Menganti
35.25.14|Kebomas
35.25.15|Driyorejo
35.25.16|Gresik
35.25.17|Sangkapura
35.25.18|Tambak
35.26.01|Bangkalan
35.26.02|Socah
35.26.03|Burneh
35.26.04|Kamal
35.26.05|Arosbaya
35.26.06|Geger
35.26.07|Klampis
35.26.08|Sepulu
35.26.09|Tanjung Bumi
35.26.10|Kokop
35.26.11|Kwanyar
35.26.12|Labang
35.26.13|Tanah Merah
35.26.14|Tragah
35.26.15|Blega
35.26.16|Modung
35.26.17|Konang
35.26.18|Galis
35.27.01|Sreseh
35.27.02|Torjun
35.27.03|Sampang
35.27.04|Camplong
35.27.05|Omben
35.27.06|Kedungdung
35.27.07|Jrengik
35.27.08|Tambelangan
35.27.09|Banyuates
35.27.10|Robatal
35.27.11|Sokobanah
35.27.12|Ketapang
35.27.13|Pangarengan
35.27.14|Karangpenang
35.28.01|Tlanakan
35.28.02|Pademawu
35.28.03|Galis
35.28.04|Pamekasan
35.28.05|Proppo
35.28.06|Palengaan
35.28.07|Pegantenan
35.28.08|Larangan
35.28.09|Pakong
35.28.10|Waru
35.28.11|Batumarmar
35.28.12|Kadur
35.28.13|Pasean
35.29.01|Kota Sumenep
35.29.02|Kalianget
35.29.03|Manding
35.29.04|Talango
35.29.05|Bluto
35.29.06|Saronggi
35.29.07|Lenteng
35.29.08|Giliginting
35.29.09|Guluk-Guluk
35.29.10|Ganding
35.29.11|Pragaan
35.29.12|Ambunten
35.29.13|Pasongsongan
35.29.14|Dasuk
35.29.15|Rubaru
35.29.16|Batang Batang
35.29.17|Batuputih
35.29.18|Dungkek
35.29.19|Gapura
35.29.20|Gayam
35.29.21|Nonggunong
35.29.22|Ra'as
35.29.23|Masalembu
35.29.24|Arjasa
35.29.25|Sapeken
35.29.26|Batuan
35.29.27|Kangayan
35.71.01|Mojoroto
35.71.02|Kota
35.71.03|Pesantren
35.72.01|Kepanjenkidul
35.72.02|Sukorejo
35.72.03|Sananwetan
35.73.01|Blimbing
35.73.02|Klojen
35.73.03|Kedungkandang
35.73.04|Sukun
35.73.05|Lowokwaru
35.74.01|Kademangan
35.74.02|Wonoasih
35.74.03|Mayangan
35.74.04|Kanigaran
35.74.05|Kedopok
35.75.01|Gadingrejo
35.75.02|Purworejo
35.75.03|Bugul Kidul
35.75.04|Panggungrejo
35.76.01|Prajuritkulon
35.76.02|Magersari
35.76.03|Kranggan
35.77.01|Kartoharjo
35.77.02|Manguharjo
35.77.03|Taman
35.78.01|Karang Pilang
35.78.02|Wonocolo
35.78.03|Rungkut
35.78.04|Wonokromo
35.78.05|Tegalsari
35.78.06|Sawahan
35.78.07|Genteng
35.78.08|Gubeng
35.78.09|Sukolilo
35.78.10|Tambaksari
35.78.11|Simokerto
35.78.12|Pabean Cantian
35.78.13|Bubutan
35.78.14|Tandes
35.78.15|Krembangan
35.78.16|Semampir
35.78.17|Kenjeran
35.78.18|Lakarsantri
35.78.19|Benowo
35.78.20|Wiyung
35.78.21|Dukuh Pakis
35.78.22|Gayungan
35.78.23|Jambangan
35.78.24|Tenggilis Mejoyo
35.78.25|Gunung Anyar
35.78.26|Mulyorejo
35.78.27|Sukomanunggal
35.78.28|Asem Rowo
35.78.29|Bulak
35.78.30|Pakal
35.78.31|Sambikerep
35.79.01|Batu
35.79.02|Bumiaji
35.79.03|Junrejo
36.01.01|Sumur
36.01.02|Cimanggu
36.01.03|Cibaliung
36.01.04|Cikeusik
36.01.05|Cigeulis
36.01.06|Panimbang
36.01.07|Angsana
36.01.08|Munjul
36.01.09|Pagelaran
36.01.10|Bojong
36.01.11|Picung
36.01.12|Labuan
36.01.13|Menes
36.01.14|Saketi
36.01.15|Cipeucang
36.01.16|Jiput
36.01.17|Mandalawangi
36.01.18|Cimanuk
36.01.19|Kaduhejo
36.01.20|Banjar
36.01.21|Pandeglang
36.01.22|Cadasari
36.01.23|Cisata
36.01.24|Patia
36.01.25|Karang Tanjung
36.01.26|Cikedal
36.01.27|Cibitung
36.01.28|Carita
36.01.29|Sukaresmi
36.01.30|Mekarjaya
36.01.31|Sindangresmi
36.01.32|Pulosari
36.01.33|Koroncong
36.01.34|Majasari
36.01.35|Sobang
36.02.01|Malingping
36.02.02|Panggarangan
36.02.03|Bayah
36.02.04|Cipanas
36.02.05|Muncang
36.02.06|Leuwidamar
36.02.07|Bojongmanik
36.02.08|Gunungkencana
36.02.09|Banjarsari
36.02.10|Cileles
36.02.11|Cimarga
36.02.12|Sajira
36.02.13|Maja
36.02.14|Rangkasbitung
36.02.15|Warunggunung
36.02.16|Cijaku
36.02.17|Cikulur
36.02.18|Cibadak
36.02.19|Cibeber
36.02.20|Cilograng
36.02.21|Wanasalam
36.02.22|Sobang
36.02.23|Curugbitung
36.02.24|Kalanganyar
36.02.25|Lebakgedong
36.02.26|Cihara
36.02.27|Cirinten
36.02.28|Cigemblong
36.03.01|Balaraja
36.03.02|Jayanti
36.03.03|Tigaraksa
36.03.04|Jambe
36.03.05|Cisoka
36.03.06|Kresek
36.03.07|Kronjo
36.03.08|Mauk
36.03.09|Kemiri
36.03.10|Sukadiri
36.03.11|Rajeg
36.03.12|Pasar Kemis
36.03.13|Teluknaga
36.03.14|Kosambi
36.03.15|Pakuhaji
36.03.16|Sepatan
36.03.17|Curug
36.03.18|Cikupa
36.03.19|Panongan
36.03.20|Legok
36.03.22|Pagedangan
36.03.23|Cisauk
36.03.27|Sukamulya
36.03.28|Kelapa Dua
36.03.29|Sindang Jaya
36.03.30|Sepatan Timur
36.03.31|Solear
36.03.32|Gunung Kaler
36.03.33|Mekar Baru
36.04.05|Kramatwatu
36.04.06|Waringinkurung
36.04.07|Bojonegara
36.04.08|Pulo Ampel
36.04.09|Ciruas
36.04.11|Kragilan
36.04.12|Pontang
36.04.13|Tirtayasa
36.04.14|Tanara
36.04.15|Cikande
36.04.16|Kibin
36.04.17|Carenang
36.04.18|Binuang
36.04.19|Petir
36.04.20|Tunjung Teja
36.04.22|Baros
36.04.23|Cikeusal
36.04.24|Pamarayan
36.04.25|Kopo
36.04.26|Jawilan
36.04.27|Ciomas
36.04.28|Pabuaran
36.04.29|Padarincang
36.04.30|Anyar
36.04.31|Cinangka
36.04.32|Mancak
36.04.33|Gunungsari
36.04.34|Bandung
36.04.35|Lebak Wangi
36.71.01|Tangerang
36.71.02|Jatiuwung
36.71.03|Batuceper
36.71.04|Benda
36.71.05|Cipondoh
36.71.06|Ciledug
36.71.07|Karawaci
36.71.08|Periuk
36.71.09|Cibodas
36.71.10|Neglasari
36.71.11|Pinang
36.71.12|Karang Tengah
36.71.13|Larangan
36.72.01|Cibeber
36.72.02|Cilegon
36.72.03|Pulomerak
36.72.04|Ciwandan
36.72.05|Jombang
36.72.06|Gerogol
36.72.07|Purwakarta
36.72.08|Citangkil
36.73.01|Serang
36.73.02|Kasemen
36.73.03|Walantaka
36.73.04|Curug
36.73.05|Cipocok Jaya
36.73.06|Taktakan
36.74.01|Serpong
36.74.02|Serpong Utara
36.74.03|Pondok Aren
36.74.04|Ciputat
36.74.05|Ciputat Timur
36.74.06|Pamulang
36.74.07|Setu
51.01.01|Negara
51.01.02|Mendoyo
51.01.03|Pekutatan
51.01.04|Melaya
51.01.05|Jembrana
51.02.01|Selemadeg
51.02.02|Selemadeg Timur
51.02.03|Selemadeg Barat
51.02.04|Kerambitan
51.02.05|Tabanan
51.02.06|Kediri
51.02.07|Marga
51.02.08|Penebel
51.02.09|Baturiti
51.02.10|Pupuan
51.03.01|Kuta
51.03.02|Mengwi
51.03.03|Abiansemal
51.03.04|Petang
51.03.05|Kuta Selatan
51.03.06|Kuta Utara
51.04.01|Sukawati
51.04.02|Blahbatuh
51.04.03|Gianyar
51.04.04|Tampaksiring
51.04.05|Ubud
51.04.06|Tegallalang
51.04.07|Payangan
51.05.01|Nusa Penida
51.05.02|Banjarangkan
51.05.03|Klungkung
51.05.04|Dawan
51.06.01|Susut
51.06.02|Bangli
51.06.03|Tembuku
51.06.04|Kintamani
51.07.01|Rendang
51.07.02|Sidemen
51.07.03|Manggis
51.07.04|Karangasem
51.07.05|Abang
51.07.06|Bebandem
51.07.07|Selat
51.07.08|Kubu
51.08.01|Gerokgak
51.08.02|Seririt
51.08.03|Busungbiu
51.08.04|Banjar
51.08.05|Sukasada
51.08.06|Buleleng
51.08.07|Sawan
51.08.08|Kubutambahan
51.08.09|Tejakula
51.71.01|Denpasar Selatan
51.71.02|Denpasar Timur
51.71.03|Denpasar Barat
51.71.04|Denpasar Utara
52.01.01|Gerung
52.01.02|Kediri
52.01.03|Narmada
52.01.07|Sekotong
52.01.08|Labuapi
52.01.09|Gunungsari
52.01.12|Lingsar
52.01.13|Lembar
52.01.14|Batu Layar
52.01.15|Kuripan
52.02.01|Praya
52.02.02|Jonggat
52.02.03|Batukliang
52.02.04|Pujut
52.02.05|Praya Barat
52.02.06|Praya Timur
52.02.07|Janapria
52.02.08|Pringgarata
52.02.09|Kopang
52.02.10|Praya Tengah
52.02.11|Praya Barat Daya
52.02.12|Batukliang Utara
52.03.01|Keruak
52.03.02|Sakra
52.03.03|Terara
52.03.04|Sikur
52.03.05|Masbagik
52.03.06|Sukamulia
52.03.07|Selong
52.03.08|Pringgabaya
52.03.09|Aikmel
52.03.10|Sambelia
52.03.11|Montong Gading
52.03.12|Pringgasela
52.03.13|Suralaga
52.03.14|Wanasaba
52.03.15|Sembalun
52.03.16|Suwela
52.03.17|Labuhan Haji
52.03.18|Sakra Timur
52.03.19|Sakra Barat
52.03.20|Jerowaru
52.03.21|Lenek
52.04.02|Lunyuk
52.04.05|Alas
52.04.06|Utan
52.04.07|Batu Lanteh
52.04.08|Sumbawa
52.04.09|Moyo Hilir
52.04.10|Moyo Hulu
52.04.11|Ropang
52.04.12|Lape
52.04.13|Plampang
52.04.14|Empang
52.04.17|Alas Barat
52.04.18|Labuhan Badas
52.04.19|Labangka
52.04.20|Buer
52.04.21|Rhee
52.04.22|Unter Iwes
52.04.23|Moyo Utara
52.04.24|Maronge
52.04.25|Tarano
52.04.26|Lopok
52.04.27|Lenangguar
52.04.28|Orong Telu
52.04.29|Lantung
52.05.01|Dompu
52.05.02|Kempo
52.05.03|Hu'u
52.05.04|Kilo
52.05.05|Woja
52.05.06|Pekat
52.05.07|Manggalewa
52.05.08|Pajo
52.06.01|Monta
52.06.02|Bolo
52.06.03|Woha
52.06.04|Belo
52.06.05|Wawo
52.06.06|Sape
52.06.07|Wera
52.06.08|Donggo
52.06.09|Sanggar
52.06.10|Ambalawi
52.06.11|Langgudu
52.06.12|Lambu
52.06.13|Madapangga
52.06.14|Tambora
52.06.15|Soromandi
52.06.16|Parado
52.06.17|Lambitu
52.06.18|Palibelo
52.07.01|Jereweh
52.07.02|Taliwang
52.07.03|Seteluk
52.07.04|Sekongkang
52.07.05|Brang Rea
52.07.06|Poto Tano
52.07.07|Brang Ene
52.07.08|Maluk
52.08.01|Tanjung
52.08.02|Gangga
52.08.03|Kayangan
52.08.04|Bayan
52.08.05|Pemenang
52.71.01|Ampenan
52.71.02|Mataram
52.71.03|Cakranegara
52.71.04|Sekarbela
52.71.05|Selaparang
52.71.06|Sandubaya
52.72.01|Rasanae Barat
52.72.02|Rasanae Timur
52.72.03|Asakota
52.72.04|Raba
52.72.05|Mpunda
53.01.04|Semau
53.01.05|Kupang Barat
53.01.06|Kupang Timur
53.01.07|Sulamu
53.01.08|Kupang Tengah
53.01.09|Amarasi
53.01.10|Fatuleu
53.01.11|Takari
53.01.12|Amfoang Selatan
53.01.13|Amfoang Utara
53.01.16|Nekamese
53.01.17|Amarasi Barat
53.01.18|Amarasi Selatan
53.01.19|Amarasi Timur
53.01.20|Amabi Oefeto Timur
53.01.21|Amfoang Barat Daya
53.01.22|Amfoang Barat Laut
53.01.23|Semau Selatan
53.01.24|Taebenu
53.01.25|Amabi Oefeto
53.01.26|Amfoang Timur
53.01.27|Fatuleu Barat
53.01.28|Fatuleu Tengah
53.01.30|Amfoang Tengah
53.02.01|Kota Soe
53.02.02|Mollo Selatan
53.02.03|Mollo Utara
53.02.04|Amanuban Timur
53.02.05|Amanuban Tengah
53.02.06|Amanuban Selatan
53.02.07|Amanuban Barat
53.02.08|Amanatun Selatan
53.02.09|Amanatun Utara
53.02.10|KI'E
53.02.11|Kuanfatu
53.02.12|Fatumnasi
53.02.13|Polen
53.02.14|Batu Putih
53.02.15|Boking
53.02.16|Toianas
53.02.17|Nunkolo
53.02.18|Oenino
53.02.19|Kolbano
53.02.20|Kot olin
53.02.21|Kualin
53.02.22|Mollo Barat
53.02.23|Kok Baun
53.02.24|Noebana
53.02.25|Santian
53.02.26|Noebeba
53.02.27|Kuatnana
53.02.28|Fautmolo
53.02.29|Fatukopa
53.02.30|Mollo Tengah
53.02.31|Tobu
53.02.32|Nunbena
53.03.01|Miomaffo Timur
53.03.02|Miomaffo Barat
53.03.03|Biboki Selatan
53.03.04|Noemuti
53.03.05|Kota Kefamenanu
53.03.06|Biboki Utara
53.03.07|Biboki Anleu
53.03.08|Insana
53.03.09|Insana Utara
53.03.10|Noemuti Timur
53.03.11|Miomaffo Tengah
53.03.12|Musi
53.03.13|Mutis
53.03.14|Bikomi Selatan
53.03.15|Bikomi Tengah
53.03.16|Bikomi Nilulat
53.03.17|Bikomi Utara
53.03.18|Naibenu
53.03.19|Insana Fafinesu
53.03.20|Insana Barat
53.03.21|Insana Tengah
53.03.22|Biboki Tan Pah
53.03.23|Biboki Moenleu
53.03.24|Biboki Feotleu
53.04.01|Lamaknen
53.04.02|Tasifeto Timur
53.04.03|Raihat
53.04.04|Tasifeto Barat
53.04.05|Kakuluk Mesak
53.04.12|Kota Atambua
53.04.13|Raimanuk
53.04.17|Lasiolat
53.04.18|Lamaknen Selatan
53.04.21|Atambua Barat
53.04.22|Atambua Selatan
53.04.23|Nanaet Duabesi
53.05.01|Teluk Mutiara
53.05.02|Alor Barat Laut
53.05.03|Alor Barat Daya
53.05.04|Alor Selatan
53.05.05|Alor Timur
53.05.06|Pantar
53.05.07|Alor Tengah Utara
53.05.08|Alor Timur Laut
53.05.09|Pantar Barat
53.05.10|Kabola
53.05.11|Pulau Pura
53.05.12|Mataru
53.05.13|Pureman
53.05.14|Pantar Timur
53.05.15|Lembur
53.05.16|Pantar Tengah
53.05.17|Pantar Barat Laut
53.05.18|Abad Selatan
53.06.01|Wulanggitang
53.06.02|Titehena
53.06.03|Larantuka
53.06.04|Ile Mandiri
53.06.05|Tanjung Bunga
53.06.06|Solor Barat
53.06.07|Solor Timur
53.06.08|Adonara Barat
53.06.09|Wotan Ulumando
53.06.10|Adonara Timur
53.06.11|Kelubagolit
53.06.12|Witihama
53.06.13|Ile Boleng
53.06.14|Demon Pagong
53.06.15|Lewolema
53.06.16|Ile Bura
53.06.17|Adonara
53.06.18|Adonara Tengah
53.06.19|Solor Selatan
53.07.01|Paga
53.07.02|Mego
53.07.03|Lela
53.07.04|Nita
53.07.05|Alok
53.07.06|Palue
53.07.07|Nelle
53.07.08|Talibura
53.07.09|Waigete
53.07.10|Kewapante
53.07.11|Bola
53.07.12|Magepanda
53.07.13|Waiblama
53.07.14|Alok Barat
53.07.15|Alok Timur
53.07.16|Koting
53.07.17|Tana Wawo
53.07.18|Hewokloang
53.07.19|Kangae
53.07.20|Doreng
53.07.21|Mapitara
53.08.01|Nangapanda
53.08.02|Pulau Ende
53.08.03|Ende
53.08.04|Ende Selatan
53.08.05|Ndona
53.08.06|Detusoko
53.08.07|Wewaria
53.08.08|Wolowaru
53.08.09|Wolojita
53.08.10|Maurole
53.08.11|Maukaro
53.08.12|Lio Timur
53.08.13|Kota Baru
53.08.14|Kelimutu
53.08.15|Detukeli
53.08.16|Ndona Timur
53.08.17|Ndori
53.08.18|Ende Utara
53.08.19|Ende Tengah
53.08.20|Ende Timur
53.08.21|Lepembusu Kelisoke
53.09.01|Aimere
53.09.02|Golewa
53.09.06|Bajawa
53.09.07|Soa
53.09.09|Riung
53.09.12|Jerebuu
53.09.14|Riung Barat
53.09.15|Bajawa Utara
53.09.16|Wolomeze
53.09.18|Golewa Selatan
53.09.19|Golewa Barat
53.09.20|Inerie
53.10.01|Wae Rii
53.10.03|Ruteng
53.10.05|Satar Mese
53.10.06|Cibal
53.10.11|Reok
53.10.12|Langke Rembong
53.10.13|Satar Mese Barat
53.10.14|Rahong Utara
53.10.15|Lelak
53.10.16|Reok Barat
53.10.17|Cibal barat
53.10.18|Satar Mese Utara
53.11.01|Kota Waingapu
53.11.02|Haharu
53.11.03|Lewa
53.11.04|Nggaha Ori Angu
53.11.05|Tabundung
53.11.06|Pinu Pahar
53.11.07|Pandawai
53.11.08|Umalulu
53.11.09|Rindi
53.11.10|Pahunga Lodu
53.11.11|Wulla Waijelu
53.11.12|Paberiwai
53.11.13|Karera
53.11.14|Kahaungu Eti
53.11.15|Matawai La Pawu
53.11.16|Kambera
53.11.17|Kambata Mapambuhang
53.11.18|Lewa Tidahu
53.11.19|Katala Hamu Lingu
53.11.20|Kanatang
53.11.21|Ngadu Ngala
53.11.22|Mahu
53.12.04|Tana Righu
53.12.10|Loli
53.12.11|Wanokaka
53.12.12|Lamboya
53.12.15|Kota Waikabubak
53.12.18|Laboya Barat
53.13.01|Naga Wutung
53.13.02|Atadei
53.13.03|Ile Ape
53.13.04|Lebatukan
53.13.05|Nubatukan
53.13.06|Omesuri
53.13.07|Buyasuri
53.13.08|Wulandoni
53.13.09|Ile Ape Timur
53.14.01|Rote Barat Daya
53.14.02|Rote Barat Laut
53.14.03|Lobalain
53.14.04|Rote Tengah
53.14.05|Pantai Baru
53.14.06|Rote Timur
53.14.07|Rote Barat
53.14.08|Rote Selatan
53.14.09|Ndao Nuse
53.14.10|Landu Leko
53.14.11|Loaholu
53.15.01|Macang Pacar
53.15.02|Kuwus
53.15.03|Lembor
53.15.04|Sano Nggoang
53.15.05|Komodo
53.15.06|Boleng
53.15.07|Welak
53.15.08|Ndoso
53.15.09|Lembor Selatan
53.15.10|Mbeliling
53.15.11|Pacar
53.15.12|Kuwus Barat
53.16.01|Aesesa
53.16.02|Nangaroro
53.16.03|Boawae
53.16.04|Mauponggo
53.16.05|Wolowae
53.16.06|Keo Tengah
53.16.07|Aesesa Selatan
53.17.01|Katiku Tana
53.17.02|Umbu Ratu Nggay Barat
53.17.03|Mamboro
53.17.04|Umbu Ratu Nggay
53.17.05|Katiku Tana Selatan
53.17.06|Umbu Ratu Nggay Tengah
53.18.01|Loura
53.18.02|Wewewa Utara
53.18.03|Wewewa Timur
53.18.04|Wewewa Barat
53.18.05|Wewewa Selatan
53.18.06|Kodi Bangedo
53.18.07|Kodi
53.18.08|Kodi Utara
53.18.09|Kota Tambolaka
53.18.10|Wewewa Tengah
53.18.11|Kodi Balaghar
53.19.01|Borong
53.19.02|Lamba Leda Selatan
53.19.03|Lamba Leda
53.19.04|Sambi Rampas
53.19.05|Elar
53.19.06|Kota Komba
53.19.07|Rana Mese
53.19.08|Lamba Leda Timur
53.19.09|Elar Selatan
53.19.10|Kota Komba Utara
53.19.11|Lamba Leda Utara
53.19.12|Congkar
53.20.01|Sabu Barat
53.20.02|Sabu Tengah
53.20.03|Sabu Timur
53.20.04|Sabu Liae
53.20.05|Hawu Mehara
53.20.06|Raijua
53.21.01|Malaka Tengah
53.21.02|Malaka Barat
53.21.03|Wewiku
53.21.04|Weliman
53.21.05|Rinhat
53.21.06|Io Kufeu
53.21.07|Sasitamean
53.21.08|Laenmanen
53.21.09|Malaka Timur
53.21.10|Kobalima Timur
53.21.11|Kobalima
53.21.12|Botin Leobele
53.71.01|Alak
53.71.02|Maulafa
53.71.03|Kelapa Lima
53.71.04|Oebobo
53.71.05|Kota Raja
53.71.06|Kota Lama
61.01.01|Sambas
61.01.02|Teluk Keramat
61.01.03|Jawai
61.01.04|Tebas
61.01.05|Pemangkat
61.01.06|Sejangkung
61.01.07|Selakau
61.01.08|Paloh
61.01.09|Sajingan Besar
61.01.10|Subah
61.01.11|Galing
61.01.12|Tekarang
61.01.13|Semparuk
61.01.14|Sajad
61.01.15|Sebawi
61.01.16|Jawai Selatan
61.01.17|Tangaran
61.01.18|Salatiga
61.01.19|Selakau Timur
61.02.01|Mempawah Hilir
61.02.06|Toho
61.02.07|Sungai Pinyuh
61.02.08|Jongkat
61.02.12|Sungai Kunyit
61.02.15|Segedong
61.02.16|Anjongan
61.02.17|Sadaniang
61.02.18|Mempawah Timur
61.03.01|Kapuas
61.03.02|Mukok
61.03.03|Noyan
61.03.04|Jangkang
61.03.05|Bonti
61.03.06|Beduai
61.03.07|Sekayam
61.03.08|Kembayan
61.03.09|Parindu
61.03.10|Tayan Hulu
61.03.11|Tayan Hilir
61.03.12|Balai
61.03.13|Toba
61.03.20|Meliau
61.03.21|Entikong
61.04.01|Matan Hilir Utara
61.04.02|Marau
61.04.03|Manis Mata
61.04.04|Kendawangan
61.04.05|Sandai
61.04.07|Sungai Laur
61.04.08|Simpang Hulu
61.04.11|Nanga Tayap
61.04.12|Matan Hilir Selatan
61.04.13|Tumbang Titi
61.04.14|Jelai Hulu
61.04.16|Delta Pawan
61.04.17|Muara Pawan
61.04.18|Benua Kayong
61.04.19|Hulu Sungai
61.04.20|Simpang Dua
61.04.21|Air Upas
61.04.22|Singkup
61.04.24|Pemahan
61.04.25|Sungai Melayu Rayak
61.05.01|Sintang
61.05.02|Tempunak
61.05.03|Sepauk
61.05.04|Ketungau Hilir
61.05.05|Ketungau Tengah
61.05.06|Ketungau Hulu
61.05.07|Dedai
61.05.08|Kayan Hilir
61.05.09|Kayan Hulu
61.05.14|Serawai
61.05.15|Ambalau
61.05.19|Kelam Permai
61.05.20|Sungai Tebelian
61.05.21|Binjai Hulu
61.06.01|Putussibau Utara
61.06.02|Bika
61.06.03|Embaloh Hilir
61.06.04|Embaloh Hulu
61.06.05|Bunut Hilir
61.06.06|Bunut Hulu
61.06.07|Jongkong
61.06.08|Hulu Gurung
61.06.09|Selimbau
61.06.10|Semitau
61.06.11|Seberuang
61.06.12|Batang Lupar
61.06.13|Empanang
61.06.14|Badau
61.06.15|Silat Hilir
61.06.16|Silat Hulu
61.06.17|Putussibau Selatan
61.06.18|Kalis
61.06.19|Boyan Tanjung
61.06.20|Mentebah
61.06.21|Pengkadan
61.06.22|Suhaid
61.06.23|Puring Kencana
61.07.01|Sungai Raya
61.07.02|Samalantan
61.07.03|Ledo
61.07.04|Bengkayang
61.07.05|Seluas
61.07.06|Sanggau Ledo
61.07.07|Jagoi Babang
61.07.08|Monterado
61.07.09|Teriak
61.07.10|Suti Semarang
61.07.11|Capkala
61.07.12|Siding
61.07.13|Lumar
61.07.14|Sungai Betung
61.07.15|Sungai Raya Kepulauan
61.07.16|Lembah Bawang
61.07.17|Tujuh Belas
61.08.01|Ngabang
61.08.02|Mempawah Hulu
61.08.03|Menjalin
61.08.04|Mandor
61.08.05|Air Besar
61.08.06|Menyuke
61.08.07|Sengah Temila
61.08.08|Meranti
61.08.09|Kuala Behe
61.08.10|Sebangki
61.08.11|Jelimpo
61.08.12|Banyuke Hulu
61.08.13|Sompak
61.09.01|Sekadau Hilir
61.09.02|Sekadau Hulu
61.09.03|Nanga Taman
61.09.04|Nanga Mahap
61.09.05|Belitang Hilir
61.09.06|Belitang Hulu
61.09.07|Belitang
61.10.01|Belimbing
61.10.02|Nanga Pinoh
61.10.03|Ella Hilir
61.10.04|Menukung
61.10.05|Sayan
61.10.06|Tanah Pinoh
61.10.07|Sokan
61.10.08|Pinoh Utara
61.10.09|Pinoh Selatan
61.10.10|Belimbing Hulu
61.10.11|Tanah Pinoh Barat
61.11.01|Sukadana
61.11.02|Simpang Hilir
61.11.03|Teluk Batang
61.11.04|Pulau Maya
61.11.05|Seponti
61.11.06|Kepulauan Karimata
61.12.01|Sungai Raya
61.12.02|Kuala Mandor B
61.12.03|Sungai Ambawang
61.12.04|Terentang
61.12.05|Batu Ampar
61.12.06|Kubu
61.12.07|Rasau Jaya
61.12.08|Teluk Pakedai
61.12.09|Sungai Kakap
61.71.01|Pontianak Selatan
61.71.02|Pontianak Timur
61.71.03|Pontianak Barat
61.71.04|Pontianak Utara
61.71.05|Pontianak Kota
61.71.06|Pontianak Tenggara
61.72.01|Singkawang Tengah
61.72.02|Singkawang Barat
61.72.03|Singkawang Timur
61.72.04|Singkawang Utara
61.72.05|Singkawang Selatan
62.01.01|Kumai
62.01.02|Arut Selatan
62.01.03|Kotawaringin Lama
62.01.04|Arut Utara
62.01.05|Pangkalan Lada
62.01.06|Pangkalan Banteng
62.02.01|Kota Besi
62.02.02|Cempaga
62.02.03|Mentaya Hulu
62.02.04|Parenggean
62.02.05|Baamang
62.02.06|Mentawa Baru Ketapang
62.02.07|Mentaya Hilir Utara
62.02.08|Mentaya Hilir Selatan
62.02.09|Pulau Hanaut
62.02.10|Antang Kalang
62.02.11|Teluk Sampit
62.02.12|Seranau
62.02.13|Cempaga Hulu
62.02.14|Telawang
62.02.15|Bukit Santuai
62.02.16|Tualan Hulu
62.02.17|Telaga Antang
62.03.01|Selat
62.03.02|Kapuas Hilir
62.03.03|Kapuas Timur
62.03.04|Kapuas Kuala
62.03.05|Kapuas Barat
62.03.06|Pulau Petak
62.03.07|Kapuas Murung
62.03.08|Basarang
62.03.09|Mantangai
62.03.10|Timpah
62.03.11|Kapuas Tengah
62.03.12|Kapuas Hulu
62.03.13|Tamban Catur
62.03.14|Pasak Talawang
62.03.15|Mandau Talawang
62.03.16|Dadahup
62.03.17|Bataguh
62.04.01|Jenamas
62.04.02|Dusun Hilir
62.04.03|Karau Kuala
62.04.04|Dusun Utara
62.04.05|Gn. Bintang Awai
62.04.06|Dusun Selatan
62.05.01|Montallat
62.05.02|Gunung Timang
62.05.03|Gunung Purei
62.05.04|Teweh Timur
62.05.05|Teweh Tengah
62.05.06|Lahei
62.05.07|Teweh Baru
62.05.08|Teweh Selatan
62.05.09|Lahei Barat
62.06.01|Kamipang
62.06.02|Katingan Hilir
62.06.03|Tewang Sangalang Garing
62.06.04|Pulau Malan
62.06.05|Katingan Tengah
62.06.06|Sanaman Mantikei
62.06.07|Marikit
62.06.08|Katingan Hulu
62.06.09|Mendawai
62.06.10|Katingan Kuala
62.06.11|Tasik Payawan
62.06.12|Petak Malai
62.06.13|Bukit Raya
62.07.01|Seruyan Hilir
62.07.02|Seruyan Tengah
62.07.03|Danau Sembuluh
62.07.04|Hanau
62.07.05|Seruyan Hulu
62.07.06|Seruyan Hilir Timur
62.07.07|Seruyan Raya
62.07.08|Danau Seluluk
62.07.09|Batu Ampar
62.07.10|Suling Tambun
62.08.01|Sukamara
62.08.02|Jelai
62.08.03|Balai Riam
62.08.04|Pantai Lunci
62.08.05|Permata Kecubung
62.09.01|Lamandau
62.09.02|Delang
62.09.03|Bulik
62.09.04|Bulik Timur
62.09.05|Menthobi Raya
62.09.06|Sematu Jaya
62.09.07|Belantikan Raya
62.09.08|Batang Kawa
62.10.01|Sepang
62.10.02|Kurun
62.10.03|Tewah
62.10.04|Kahayan Hulu Utara
62.10.05|Rungan
62.10.06|Manuhing
62.10.07|Mihing Raya
62.10.08|Damang Batu
62.10.09|Miri Manasa
62.10.10|Rungan Hulu
62.10.11|Manuhing Raya
62.10.12|Rungan Barat
62.11.01|Pandih Batu
62.11.02|Kahayan Kuala
62.11.03|Kahayan Tengah
62.11.04|Banama Tingang
62.11.05|Kahayan Hilir
62.11.06|Maliku
62.11.07|Jabiren Raya
62.11.08|Sebangau Kuala
62.12.01|Murung
62.12.02|Tanah Siang
62.12.03|Laung Tuhup
62.12.04|Permata Intan
62.12.05|Sumber Barito
62.12.06|Barito Tuhup Raya
62.12.07|Tanah Siang Selatan
62.12.08|Sungai Babuat
62.12.09|Seribu Riam
62.12.10|Uut Murung
62.13.01|Dusun Timur
62.13.02|Banua Lima
62.13.03|Patangkep Tutui
62.13.04|Awang
62.13.05|Dusun Tengah
62.13.06|Pematang Karau
62.13.07|Paju Epat
62.13.08|Raren Batuah
62.13.09|Paku
62.13.10|Karusen Janang
62.71.01|Pahandut
62.71.02|Bukit Batu
62.71.03|Jekan Raya
62.71.04|Sabangau
62.71.05|Rakumpit
63.01.01|Takisung
63.01.02|Jorong
63.01.03|Pelaihari
63.01.04|Kurau
63.01.05|Bati Bati
63.01.06|Panyipatan
63.01.07|Kintap
63.01.08|Tambang Ulang
63.01.09|Batu Ampar
63.01.10|Bajuin
63.01.11|Bumi Makmur
63.02.01|Pulau Sembilan
63.02.02|Pulau Laut Barat
63.02.03|Pulau Laut Selatan
63.02.04|Pulau Laut Timur
63.02.05|Pulau Sebuku
63.02.06|Pulaulaut Utara
63.02.07|Kelumpang Selatan
63.02.08|Kelumpang Hulu
63.02.09|Kelumpang Tengah
63.02.10|Kelumpang Utara
63.02.11|Pamukan Selatan
63.02.12|Sampanahan
63.02.13|Pamukan Utara
63.02.14|Hampang
63.02.15|Sungai Durian
63.02.16|Pulau Laut Tengah
63.02.17|Kelumpang Hilir
63.02.18|Kelumpang Barat
63.02.19|Pamukan Barat
63.02.20|Pulau Laut Kepulauan
63.02.21|Pulau Laut Tanjung Selayar
63.02.22|Pulaulaut Sigam
63.03.01|Aluh Aluh
63.03.02|Kertak Hanyar
63.03.03|Gambut
63.03.04|Sungai Tabuk
63.03.05|Martapura
63.03.06|Karang Intan
63.03.07|Astambul
63.03.08|Simpang Empat
63.03.09|Pengaron
63.03.10|Sungai Pinang
63.03.11|Aranio
63.03.12|Mataraman
63.03.13|Beruntung Baru
63.03.14|Martapura Barat
63.03.15|Martapura Timur
63.03.16|Sambung Makmur
63.03.17|Paramasan
63.03.18|Telaga Bauntung
63.03.19|Tatah Makmur
63.03.20|Cintapuri Darussalam
63.04.01|Tabunganen
63.04.02|Tamban
63.04.03|Anjir Pasar
63.04.04|Anjir Muara
63.04.05|Alalak
63.04.06|Mandastana
63.04.07|Rantau Badauh
63.04.08|Belawang
63.04.09|Cerbon
63.04.10|Bakumpai
63.04.11|Kuripan
63.04.12|Tabukan
63.04.13|Mekarsari
63.04.14|Barambai
63.04.15|Marabahan
63.04.16|Wanaraya
63.04.17|Jejangkit
63.05.01|Binuang
63.05.02|Tapin Selatan
63.05.03|Tapin Tengah
63.05.04|Tapin Utara
63.05.05|Candi Laras Selatan
63.05.06|Candi Laras Utara
63.05.07|Bakarangan
63.05.08|Piani
63.05.09|Bungur
63.05.10|Lokpaikat
63.05.11|Salam Babaris
63.05.12|Hatungun
63.06.01|Sungai Raya
63.06.02|Padang Batung
63.06.03|Telaga Langsat
63.06.04|Angkinang
63.06.05|Kandangan
63.06.06|Simpur
63.06.07|Daha Selatan
63.06.08|Daha Utara
63.06.09|Kalumpang
63.06.10|Loksado
63.06.11|Daha Barat
63.07.01|Haruyan
63.07.02|Batu Benawa
63.07.03|Labuan Amas Selatan
63.07.04|Labuan Amas Utara
63.07.05|Pandawan
63.07.06|Barabai
63.07.07|Batang Alai Selatan
63.07.08|Batang Alai Utara
63.07.09|Hantakan
63.07.10|Batang Alai Timur
63.07.11|Limpasu
63.08.01|Danau Panggang
63.08.02|Babirik
63.08.03|Sungai Pandan
63.08.04|Amuntai Selatan
63.08.05|Amuntai Tengah
63.08.06|Amuntai Utara
63.08.07|Banjang
63.08.08|Haur Gading
63.08.09|Paminggir
63.08.10|Sungai Tabukan
63.09.01|Banua Lawas
63.09.02|Kelua
63.09.03|Tanta
63.09.04|Tanjung
63.09.05|Haruai
63.09.06|Murung Pudak
63.09.07|Muara Uya
63.09.08|Muara Harus
63.09.09|Pugaan
63.09.10|Upau
63.09.11|Jaro
63.09.12|Bintang Ara
63.10.01|Batu Licin
63.10.02|Kusan Hilir
63.10.03|Sungai Loban
63.10.04|Satui
63.10.05|Kusan Hulu
63.10.06|Simpang Empat
63.10.07|Karang Bintang
63.10.08|Mantewe
63.10.09|Angsana
63.10.10|Kuranji
63.10.11|Kusan Tengah
63.10.12|Teluk Kepayang
63.11.01|Juai
63.11.02|Halong
63.11.03|Awayan
63.11.04|Batu Mandi
63.11.05|Lampihong
63.11.06|Paringin
63.11.07|Paringin Selatan
63.11.08|Tebing Tinggi
63.71.01|Banjarmasin Selatan
63.71.02|Banjarmasin Timur
63.71.03|Banjarmasin Barat
63.71.04|Banjarmasin Utara
63.71.05|Banjarmasin Tengah
63.72.02|Landasan Ulin
63.72.03|Cempaka
63.72.04|Banjarbaru Utara
63.72.05|Banjarbaru Selatan
63.72.06|Liang Anggang
64.01.01|Batu Sopang
64.01.02|Tanjung Harapan
64.01.03|Paser Belengkong
64.01.04|Tanah Grogot
64.01.05|Kuaro
64.01.06|Long Ikis
64.01.07|Muara Komam
64.01.08|Long Kali
64.01.09|Batu Engau
64.01.10|Muara Samu
64.02.01|Muara Muntai
64.02.02|Loa Kulu
64.02.03|Loa Janan
64.02.04|Anggana
64.02.05|Muara Badak
64.02.06|Tenggarong
64.02.07|Sebulu
64.02.08|Kota Bangun
64.02.09|Kenohan
64.02.10|Kembang Janggut
64.02.11|Muara Kaman
64.02.12|Tabang
64.02.13|Samboja
64.02.14|Muara Jawa
64.02.15|Sanga Sanga
64.02.16|Tenggarong Seberang
64.02.17|Marang Kayu
64.02.18|Muara Wis
64.02.19|Kota Bangun Darat
64.02.20|Samboja Barat
64.03.01|Kelay
64.03.02|Talisayan
64.03.03|Sambaliung
64.03.04|Segah
64.03.05|Tanjung Redeb
64.03.06|Gunung Tabur
64.03.07|Pulau Derawan
64.03.08|Biduk-Biduk
64.03.09|Teluk Bayur
64.03.10|Tabalar
64.03.11|Maratua
64.03.12|Batu Putih
64.03.13|Biatan
64.07.05|Long Iram
64.07.06|Melak
64.07.07|Barong Tongkok
64.07.08|Damai
64.07.09|Muara Lawa
64.07.10|Muara Pahu
64.07.11|Jempang
64.07.12|Bongan
64.07.13|Penyinggahan
64.07.14|Bentian Besar
64.07.15|Linggang Bigung
64.07.16|Nyuatan
64.07.17|Siluq Ngurai
64.07.18|Mook Manaar Bulatn
64.07.19|Tering
64.07.20|Sekolaq Darat
64.08.01|Muara Ancalong
64.08.02|Muara Wahau
64.08.03|Muara Bengkal
64.08.04|Sangatta Utara
64.08.05|Sangkulirang
64.08.06|Busang
64.08.07|Telen
64.08.08|Kombeng
64.08.09|Bengalon
64.08.10|Kaliorang
64.08.11|Sandaran
64.08.12|Sangatta Selatan
64.08.13|Teluk Pandan
64.08.14|Rantau Pulung
64.08.15|Kaubun
64.08.16|Karangan
64.08.17|Batu Ampar
64.08.18|Long Mesangat
64.09.01|Penajam
64.09.02|Waru
64.09.03|Babulu
64.09.04|Sepaku
64.11.01|Long Bagun
64.11.02|Long Hubung
64.11.03|Laham
64.11.04|Long Apari
64.11.05|Long Pahangai
64.71.01|Balikpapan Timur
64.71.02|Balikpapan Barat
64.71.03|Balikpapan Utara
64.71.04|Balikpapan Tengah
64.71.05|Balikpapan Selatan
64.71.06|Balikpapan Kota
64.72.01|Palaran
64.72.02|Samarinda Seberang
64.72.03|Samarinda Ulu
64.72.04|Samarinda Ilir
64.72.05|Samarinda Utara
64.72.06|Sungai Kunjang
64.72.07|Sambutan
64.72.08|Sungai Pinang
64.72.09|Samarinda Kota
64.72.10|Loa Janan Ilir
64.74.01|Bontang Utara
64.74.02|Bontang Selatan
64.74.03|Bontang Barat
65.01.01|Tanjung Palas
65.01.02|Tanjung Palas Barat
65.01.03|Tanjung Palas Utara
65.01.04|Tanjung Palas Timur
65.01.05|Tanjung Selor
65.01.06|Tanjung Palas Tengah
65.01.07|Peso
65.01.08|Peso Hilir
65.01.09|Sekatak
65.01.10|Bunyu
65.02.01|Mentarang
65.02.02|Malinau Kota
65.02.03|Pujungan
65.02.04|Kayan Hilir
65.02.05|Kayan Hulu
65.02.06|Malinau Selatan
65.02.07|Malinau Utara
65.02.08|Malinau Barat
65.02.09|Sungai Boh
65.02.10|Kayan Selatan
65.02.11|Bahau Hulu
65.02.12|Mentarang Hulu
65.02.13|Malinau Selatan Hilir
65.02.14|Malinau Selatan Hulu
65.02.15|Sungai Tubu
65.03.01|Sebatik
65.03.02|Nunukan
65.03.03|Sembakung
65.03.04|Lumbis
65.03.05|Krayan
65.03.06|Sebuku
65.03.07|Krayan Selatan
65.03.08|Sebatik Barat
65.03.09|Nunukan Selatan
65.03.10|Sebatik Timur
65.03.11|Sebatik Utara
65.03.12|Sebatik Tengah
65.03.13|Sei Menggaris
65.03.14|Tulin Onsoi
65.03.15|Lumbis Ogong
65.03.16|Sembakung Atulai
65.03.17|Krayan Tengah
65.03.18|Krayan Timur
65.03.19|Krayan Barat
65.03.20|Lumbis Pansiangan
65.03.21|Lumbis Hulu
65.04.01|Sesayap
65.04.02|Sesayap Hilir
65.04.03|Tana Lia
65.04.04|Betayau
65.04.05|Muruk Rian
65.71.01|Tarakan Barat
65.71.02|Tarakan Tengah
65.71.03|Tarakan Timur
65.71.04|Tarakan Utara
71.01.05|Sang Tombolang
71.01.09|Dumoga Barat
71.01.10|Dumoga Timur
71.01.11|Dumoga Utara
71.01.12|Lolak
71.01.13|Bolaang
71.01.14|Lolayan
71.01.19|Passi Barat
71.01.20|Poigar
71.01.22|Passi Timur
71.01.31|Bolaang Timur
71.01.32|Bilalang
71.01.33|Dumoga
71.01.34|Dumoga Tenggara
71.01.35|Dumoga Tengah
71.02.01|Tondano Barat
71.02.02|Tondano Timur
71.02.03|Eris
71.02.04|Kombi
71.02.05|Lembean Timur
71.02.06|Kakas
71.02.07|Tompaso
71.02.08|Remboken
71.02.09|Langowan Timur
71.02.10|Langowan Barat
71.02.11|Sonder
71.02.12|Kawangkoan
71.02.13|Pineleng
71.02.14|Tombulu
71.02.15|Tombariri
71.02.16|Tondano Utara
71.02.17|Langowan Selatan
71.02.18|Tondano Selatan
71.02.19|Langowan Utara
71.02.20|Kakas Barat
71.02.21|Kawangkoan Utara
71.02.22|Kawangkoan Barat
71.02.23|Mandolang
71.02.24|Tombariri Timur
71.02.25|Tompaso Barat
71.03.08|Tabukan Utara
71.03.09|Nusa Tabukan
71.03.10|Manganitu Selatan
71.03.11|Tatoareng
71.03.12|Tamako
71.03.13|Manganitu
71.03.14|Tabukan Tengah
71.03.15|Tabukan Selatan
71.03.16|Kendahe
71.03.17|Tahuna
71.03.19|Tabukan Selatan Tengah
71.03.20|Tabukan Selatan Tenggara
71.03.23|Tahuna Barat
71.03.24|Tahuna Timur
71.03.25|Kepulauan Marore
71.04.01|Lirung
71.04.02|Beo
71.04.03|Rainis
71.04.04|Essang
71.04.05|Nanusa
71.04.06|Kabaruan
71.04.07|Melonguane
71.04.08|Gemeh
71.04.09|Damau
71.04.10|Tampan' Amma
71.04.11|Salibabu
71.04.12|Kalongan
71.04.13|Miangas
71.04.14|Beo Utara
71.04.15|Pulutan
71.04.16|Melonguane Timur
71.04.17|Moronge
71.04.18|Beo Selatan
71.04.19|Essang Selatan
71.05.01|Modoinding
71.05.02|Tompaso Baru
71.05.03|Ranoyapo
71.05.07|Motoling
71.05.08|Sinonsayang
71.05.09|Tenga
71.05.10|Amurang
71.05.12|Tumpaan
71.05.13|Tareran
71.05.15|Kumelembuai
71.05.16|Maesaan
71.05.17|Amurang Barat
71.05.18|Amurang Timur
71.05.19|Tatapaan
71.05.21|Motoling Barat
71.05.22|Motoling Timur
71.05.23|Suluun Tareran
71.06.01|Kema
71.06.02|Kauditan
71.06.03|Airmadidi
71.06.04|Wori
71.06.05|Dimembe
71.06.06|Likupang Barat
71.06.07|Likupang Timur
71.06.08|Kalawat
71.06.09|Talawaan
71.06.10|Likupang Selatan
71.07.01|Ratahan
71.07.02|Pusomaen
71.07.03|Belang
71.07.04|Ratatotok
71.07.05|Tombatu
71.07.06|Touluaan
71.07.07|Touluaan Selatan
71.07.08|Silian Raya
71.07.09|Tombatu Timur
71.07.10|Tombatu Utara
71.07.11|Pasan
71.07.12|Ratahan Timur
71.08.01|Sangkub
71.08.02|Bintauna
71.08.03|Bolangitang Timur
71.08.04|Bolangitang Barat
71.08.05|Kaidipang
71.08.06|Pinogaluman
71.09.01|Siau Timur
71.09.02|Siau Barat
71.09.03|Tagulandang
71.09.04|Siau Timur Selatan
71.09.05|Siau Barat Selatan
71.09.06|Tagulandang Utara
71.09.07|Biaro
71.09.08|Siau Barat Utara
71.09.09|Siau Tengah
71.09.10|Tagulandang Selatan
71.10.01|Tutuyan
71.10.02|Kotabunan
71.10.03|Nuangan
71.10.04|Modayag
71.10.05|Modayag Barat
71.10.06|Motongkad
71.10.07|Mooat
71.11.01|Bolaang Uki
71.11.02|Posigadan
71.11.03|Pinolosian
71.11.04|Pinolosian Tengah
71.11.05|Pinolosian Timur
71.11.06|Helumo
71.11.07|Tomini
71.71.01|Bunaken
71.71.02|Tuminting
71.71.03|Singkil
71.71.04|Wenang
71.71.05|Tikala
71.71.06|Sario
71.71.07|Wanea
71.71.08|Mapanget
71.71.09|Malalayang
71.71.10|Bunaken Kepulauan
71.71.11|Paal Dua
71.72.01|Lembeh Selatan
71.72.02|Madidir
71.72.03|Ranowulu
71.72.04|Aertembaga
71.72.05|Matuari
71.72.06|Girian
71.72.07|Maesa
71.72.08|Lembeh Utara
71.73.01|Tomohon Selatan
71.73.02|Tomohon Tengah
71.73.03|Tomohon Utara
71.73.04|Tomohon Barat
71.73.05|Tomohon Timur
71.74.01|Kotamobagu Utara
71.74.02|Kotamobagu Timur
71.74.03|Kotamobagu Selatan
71.74.04|Kotamobagu Barat
72.01.01|Batui
72.01.02|Bunta
72.01.03|Kintom
72.01.04|Luwuk
72.01.05|Lamala
72.01.06|Balantak
72.01.07|Pagimana
72.01.08|Bualemo
72.01.09|Toili
72.01.10|Masama
72.01.11|Luwuk Timur
72.01.12|Toili Barat
72.01.13|Nuhon
72.01.14|Moilong
72.01.15|Batui Selatan
72.01.16|Lobu
72.01.17|Simpang Raya
72.01.18|Balantak Selatan
72.01.19|Balantak Utara
72.01.20|Luwuk Selatan
72.01.21|Luwuk Utara
72.01.22|Mantoh
72.01.23|Nambo
72.01.24|Toili Jaya
72.02.01|Poso Kota
72.02.02|Poso Pesisir
72.02.03|Lage
72.02.04|Pamona Puselemba
72.02.05|Pamona Timur
72.02.06|Pamona Selatan
72.02.07|Lore Utara
72.02.08|Lore Tengah
72.02.09|Lore Selatan
72.02.18|Poso Pesisir Utara
72.02.19|Poso Pesisir Selatan
72.02.20|Pamona Barat
72.02.21|Poso Kota Selatan
72.02.22|Poso Kota Utara
72.02.23|Lore Barat
72.02.24|Lore Timur
72.02.25|Lore Peore
72.02.26|Pamona Tenggara
72.02.27|Pamona Utara
72.03.04|Rio Pakava
72.03.06|Dampelas
72.03.08|Banawa
72.03.09|Labuan
72.03.10|Sindue
72.03.11|Sirenja
72.03.12|Balaesang
72.03.14|Sojol
72.03.18|Banawa Selatan
72.03.19|Tanantovea
72.03.21|Pinembani
72.03.24|Sindue Tombusabora
72.03.25|Sindue Tobata
72.03.27|Banawa Tengah
72.03.30|Sojol Utara
72.03.31|Balaesang Tanjung
72.04.01|Dampal Selatan
72.04.02|Dampal Utara
72.04.03|Dondo
72.04.04|Basidondo
72.04.05|Ogodeide
72.04.06|Lampasio
72.04.07|Baolan
72.04.08|Galang
72.04.09|Tolitoli Utara
72.04.10|Dako Pemean
72.05.01|Momunu
72.05.02|Lakea
72.05.03|Bokat
72.05.04|Bunobogu
72.05.05|Paleleh
72.05.06|Biau
72.05.07|Tiloan
72.05.08|Bukal
72.05.09|Gadung
72.05.10|Karamat
72.05.11|Paleleh Barat
72.06.05|Bungku Tengah
72.06.06|Bungku Selatan
72.06.07|Menui Kepulauan
72.06.08|Bungku Barat
72.06.09|Bumi Raya
72.06.10|Bahodopi
72.06.12|Wita Ponda
72.06.15|Bungku Pesisir
72.06.18|Bungku Timur
72.06.20|Sombori Kepulauan
72.07.03|Totikum
72.07.04|Tinangkung
72.07.05|Liang
72.07.06|Bulagi
72.07.07|Buko
72.07.09|Bulagi Selatan
72.07.11|Tinangkung Selatan
72.07.15|Totikum Selatan
72.07.16|Peling Tengah
72.07.17|Bulagi Utara
72.07.18|Buko Selatan
72.07.19|Tinangkung Utara
72.08.01|Parigi
72.08.02|Ampibabo
72.08.03|Tinombo
72.08.04|Moutong
72.08.05|Tomini
72.08.06|Sausu
72.08.07|Bolano Lambunu
72.08.08|Kasimbar
72.08.09|Torue
72.08.10|Tinombo Selatan
72.08.11|Parigi Selatan
72.08.12|Mepanga
72.08.13|Toribulu
72.08.14|Taopa
72.08.15|Balinggi
72.08.16|Parigi Barat
72.08.17|Siniu
72.08.18|Palasa
72.08.19|Parigi Utara
72.08.20|Parigi Tengah
72.08.21|Bolano
72.08.22|Ongka Malino
72.08.23|Sidoan
72.09.01|Una Una
72.09.02|Togean
72.09.03|Walea Kepulauan
72.09.04|Ampana Tete
72.09.05|Ampana Kota
72.09.06|Ulubongka
72.09.07|Tojo Barat
72.09.08|Tojo
72.09.09|Walea Besar
72.09.10|Ratolindo
72.09.11|Batudaka
72.09.12|Talatako
72.10.01|Sigi Biromaru
72.10.02|Palolo
72.10.03|Nokilalaki
72.10.04|Lindu
72.10.05|Kulawi
72.10.06|Kulawi Selatan
72.10.07|Pipikoro
72.10.08|Gumbasa
72.10.09|Dolo Selatan
72.10.10|Tanambulava
72.10.11|Dolo Barat
72.10.12|Dolo
72.10.13|Kinovaro
72.10.14|Marawola
72.10.15|Marawola Barat
72.11.01|Banggai
72.11.02|Banggai Utara
72.11.03|Bokan Kepulauan
72.11.04|Bangkurung
72.11.05|Labobo
72.11.06|Banggai Selatan
72.11.07|Banggai Tengah
72.12.01|Petasia
72.12.02|Petasia Timur
72.12.03|Lembo Raya
72.12.04|Lembo
72.12.05|Mori Atas
72.12.06|Mori Utara
72.12.07|Soyo Jaya
72.12.08|Bungku Utara
72.12.09|Mamosalato
72.12.10|Petasia Barat
72.71.01|Palu Timur
72.71.02|Palu Barat
72.71.03|Palu Selatan
72.71.04|Palu Utara
72.71.05|Ulujadi
72.71.06|Tatanga
72.71.07|Tawaeli
72.71.08|Mantikulore
73.01.01|Benteng
73.01.02|Bontoharu
73.01.03|Bontomatene
73.01.04|Bontomanai
73.01.05|Bontosikuyu
73.01.06|Pasimasunggu
73.01.07|Pasimarannu
73.01.08|Taka Bonerate
73.01.09|Pasilambena
73.01.10|Pasimasunggu Timur
73.01.11|Buki
73.02.01|Gantarang
73.02.02|Ujung Bulu
73.02.03|Bonto Bahari
73.02.04|Bonto Tiro
73.02.05|Herlang
73.02.06|Kajang
73.02.07|Bulukumpa
73.02.08|Kindang
73.02.09|Ujungloe
73.02.10|Rilauale
73.03.01|Bissappu
73.03.02|Bantaeng
73.03.03|Eremerasa
73.03.04|Tompo Bulu
73.03.05|Pajukukang
73.03.06|Uluere
73.03.07|Gantarang Keke
73.03.08|Sinoa
73.04.01|Bangkala
73.04.02|Tamalatea
73.04.03|Binamu
73.04.04|Batang
73.04.05|Kelara
73.04.06|Bangkala Barat
73.04.07|Bontoramba
73.04.08|Turatea
73.04.09|Arungkeke
73.04.10|Rumbia
73.04.11|Tarowang
73.05.01|Mappakasunggu
73.05.02|Mangarabombang
73.05.03|Polongbangkeng Selatan
73.05.04|Polongbangkeng Utara
73.05.05|Galesong Selatan
73.05.06|Galesong Utara
73.05.07|Pattallassang
73.05.08|Sanrobone
73.05.09|Galesong
73.05.10|Kepulauan Tanakeke
73.05.11|Polongbangkeng Timur
73.05.12|Laikang
73.06.01|Bontonompo
73.06.02|Bajeng
73.06.03|Tompobulu
73.06.04|Tinggimoncong
73.06.05|Parangloe
73.06.06|Bontomarannu
73.06.07|Pallangga
73.06.08|Somba Opu
73.06.09|Bungaya
73.06.10|Tombolopao
73.06.11|Biringbulu
73.06.12|Barombong
73.06.13|Pattallasang
73.06.14|Manuju
73.06.15|Bontolempangang
73.06.16|Bontonompo Selatan
73.06.17|Parigi
73.06.18|Bajeng Barat
73.07.01|Sinjai Barat
73.07.02|Sinjai Selatan
73.07.03|Sinjai Timur
73.07.04|Sinjai Tengah
73.07.05|Sinjai Utara
73.07.06|Bulupoddo
73.07.07|Sinjai Borong
73.07.08|Tellu Limpoe
73.07.09|Pulau Sembilan
73.08.01|Bontocani
73.08.02|Kahu
73.08.03|Kajuara
73.08.04|Salomekko
73.08.05|Tonra
73.08.06|Libureng
73.08.07|Mare
73.08.08|Sibulue
73.08.09|Barebbo
73.08.10|Cina
73.08.11|Ponre
73.08.12|Lappariaja
73.08.13|Lamuru
73.08.14|Ulaweng
73.08.15|Palakka
73.08.16|Awangpone
73.08.17|Tellu Siattinge
73.08.18|Ajangale
73.08.19|Dua Boccoe
73.08.20|Cenrana
73.08.21|Tanete Riattang
73.08.22|Tanete Riattang Barat
73.08.23|Tanete Riattang Timur
73.08.24|Amali
73.08.25|Tellulimpoe
73.08.26|Bengo
73.08.27|Patimpeng
73.09.01|Mandai
73.09.02|Camba
73.09.03|Bantimurung
73.09.04|Maros Baru
73.09.05|Bontoa
73.09.06|Malllawa
73.09.07|Tanralili
73.09.08|Marusu
73.09.09|Simbang
73.09.10|Cenrana
73.09.11|Tompobulu
73.09.12|Lau
73.09.13|Moncongloe
73.09.14|Turikale
73.10.01|Liukang Tangaya
73.10.02|Liukang Kalmas
73.10.03|Liukang Tupabbiring
73.10.04|Pangkajene
73.10.05|Balocci
73.10.06|Bungoro
73.10.07|Labakkang
73.10.08|Marang
73.10.09|Segeri
73.10.10|Minasate'ne
73.10.11|Mandalle
73.10.12|Tondong Tallasa
73.10.13|Liukang Tupabbiring Utara
73.11.01|Tanete Riaja
73.11.02|Tanete Rilau
73.11.03|Barru
73.11.04|Soppeng Riaja
73.11.05|Mallusetasi
73.11.06|Pujananting
73.11.07|Balusu
73.12.01|Marioriwawo
73.12.02|Liliriaja
73.12.03|Lilirilau
73.12.04|Lalabata
73.12.05|Marioriawa
73.12.06|Donri-Donri
73.12.07|Ganra
73.12.08|Citta
73.13.01|Sabangparu
73.13.02|Pammana
73.13.03|Takkalalla
73.13.04|Sajoanging
73.13.05|Majauleng
73.13.06|Tempe
73.13.07|Belawa
73.13.08|Tanasitolo
73.13.09|Maniangpajo
73.13.10|Pitumpanua
73.13.11|Bola
73.13.12|Penrang
73.13.13|Gilireng
73.13.14|Keera
73.14.01|Panca Lautang
73.14.02|Tellu Limpoe
73.14.03|Watang Pulu
73.14.04|Baranti
73.14.05|Panca Rijang
73.14.06|Kulo
73.14.07|Maritengngae
73.14.08|Watang Sidenreng
73.14.09|Dua Pitue
73.14.10|Pitu Riawa
73.14.11|Pitu Riase
73.15.01|Mattiro Sompe
73.15.02|Suppa
73.15.03|Mattiro Bulu
73.15.04|Watang Sawitto
73.15.05|Patampanua
73.15.06|Duampanua
73.15.07|Lembang
73.15.08|Cempa
73.15.09|Tiroang
73.15.10|Lanrisang
73.15.11|Paleteang
73.15.12|Batulappa
73.16.01|Maiwa
73.16.02|Enrekang
73.16.03|Baraka
73.16.04|Anggeraja
73.16.05|Alla
73.16.06|Bungin
73.16.07|Cendana
73.16.08|Curio
73.16.09|Malua
73.16.10|Buntu Batu
73.16.11|Masalle
73.16.12|Baroko
73.17.01|Basse Sangtempe
73.17.02|Larompong
73.17.03|Suli
73.17.04|Bajo
73.17.05|Bua Ponrang
73.17.06|Walenrang
73.17.07|Belopa
73.17.08|Bua
73.17.09|Lamasi
73.17.10|Larompong Selatan
73.17.11|Ponrang
73.17.12|Latimojong
73.17.13|Kamanre
73.17.14|Belopa Utara
73.17.15|Walenrang Barat
73.17.16|Walenrang Utara
73.17.17|Walenrang Timur
73.17.18|Lamasi Timur
73.17.19|Suli Barat
73.17.20|Bajo Barat
73.17.21|Ponrang Selatan
73.17.22|Basse Sangtempe Utara
73.18.01|Salupputti
73.18.02|Bittuang
73.18.03|Bonggakaradeng
73.18.05|Makale
73.18.09|Simbuang
73.18.11|Rantetayo
73.18.12|Mengkendek
73.18.13|Sangalla'
73.18.19|Gandangbatu Sillanan
73.18.20|Rembon
73.18.27|Makale Utara
73.18.28|Mappak
73.18.29|Makale Selatan
73.18.31|Masanda
73.18.33|Sangalla' Selatan
73.18.34|Sangalla' Utara
73.18.35|Malimbong Balepe'
73.18.37|Rano
73.18.38|Kurra
73.22.01|Malangke
73.22.02|Bone Bone
73.22.03|Masamba
73.22.04|Sabbang
73.22.05|Rongkong
73.22.06|Sukamaju
73.22.07|Seko
73.22.08|Malangke Barat
73.22.09|Rampi
73.22.10|Mappedeceng
73.22.11|Baebunta
73.22.12|Tana Lili
73.22.13|Sukamaju Selatan
73.22.14|Baebunta Selatan
73.22.15|Sabbang Selatan
73.24.01|Mangkutana
73.24.02|Nuha
73.24.03|Towuti
73.24.04|Malili
73.24.05|Angkona
73.24.06|Wotu
73.24.07|Burau
73.24.08|Tomoni
73.24.09|Tomoni Timur
73.24.10|Kalaena
73.24.11|Wasuponda
73.26.01|Rantepao
73.26.02|Sesean
73.26.03|Nanggala
73.26.04|Rindingallo
73.26.05|Buntao
73.26.06|Sa'dan
73.26.07|Sanggalangi
73.26.08|Sopai
73.26.09|Tikala
73.26.10|Balusu
73.26.11|Tallunglipu
73.26.12|Dende' Piongan Napo
73.26.13|Buntu Pepasan
73.26.14|Baruppu
73.26.15|Kesu
73.26.16|Tondon
73.26.17|Bangkelekila
73.26.18|Rantebua
73.26.19|Sesean Suloara
73.26.20|Kapala Pitu
73.26.21|Awan Rante Karua
73.71.01|Mariso
73.71.02|Mamajang
73.71.03|Makassar
73.71.04|Ujung Pandang
73.71.05|Wajo
73.71.06|Bontoala
73.71.07|Tallo
73.71.08|Ujung Tanah
73.71.09|Panakkukang
73.71.10|Tamalate
73.71.11|Biringkanaya
73.71.12|Manggala
73.71.13|Rappocini
73.71.14|Tamalanrea
73.71.15|Kepulauan Sangkarrang
73.72.01|Bacukiki
73.72.02|Ujung
73.72.03|Soreang
73.72.04|Bacukiki Barat
73.73.01|Wara
73.73.02|Wara Utara
73.73.03|Wara Selatan
73.73.04|Telluwanua
73.73.05|Wara Timur
73.73.06|Wara Barat
73.73.07|Sendana
73.73.08|Mungkajang
73.73.09|Bara
74.01.01|Wundulako
74.01.04|Kolaka
74.01.07|Pomalaa
74.01.08|Watubangga
74.01.10|Wolo
74.01.12|Baula
74.01.14|Latambaga
74.01.18|Tanggetada
74.01.20|Samaturu
74.01.24|Toari
74.01.25|Polinggona
74.01.27|Iwoimendaa
74.02.01|Lambuya
74.02.02|Unaaha
74.02.03|Wawotobi
74.02.04|Pondidaha
74.02.05|Sampara
74.02.10|Abuki
74.02.11|Soropia
74.02.15|Tongauna
74.02.16|Latoma
74.02.17|Puriala
74.02.18|Uepai
74.02.19|Wonggeduku
74.02.20|Besulutu
74.02.21|Bondoala
74.02.23|Routa
74.02.24|Anggaberi
74.02.25|Meluhu
74.02.28|Amonggedo
74.02.31|Asinua
74.02.32|Konawe
74.02.33|Kapoiala
74.02.36|Lalonggasumeeto
74.02.37|Onembute
74.02.38|Padangguni
74.02.39|Morosi
74.02.40|Anggalomoare
74.02.41|Wonggeduku Barat
74.02.42|Tongauna Utara
74.03.06|Napabalano
74.03.07|Maligano
74.03.13|Wakorumba Selatan
74.03.14|Lasalepa
74.03.15|Batalaiworu
74.03.16|Katobu
74.03.17|Duruka
74.03.18|Lohia
74.03.19|Watopute
74.03.20|Kontunaga
74.03.23|Kabangka
74.03.24|Kabawo
74.03.25|Parigi
74.03.26|Bone
74.03.27|Tongkuno
74.03.28|Pasir Putih
74.03.30|Kontu Kowuna
74.03.31|Marobo
74.03.32|Tongkuno Selatan
74.03.33|Pasi Kolaga
74.03.34|Batukara
74.03.37|Towea
74.04.11|Pasarwajo
74.04.22|Kapontori
74.04.23|Lasalimu
74.04.24|Lasalimu Selatan
74.04.27|Siotapina
74.04.28|Wolowa
74.04.29|Wabula
74.05.01|Tinanggea
74.05.02|Angata
74.05.03|Andoolo
74.05.04|Palangga
74.05.05|Landono
74.05.06|Lainea
74.05.07|Konda
74.05.08|Ranomeeto
74.05.09|Kolono
74.05.10|Moramo
74.05.11|Laonti
74.05.12|Lalembuu
74.05.13|Benua
74.05.14|Palangga Selatan
74.05.15|Mowila
74.05.16|Moramo Utara
74.05.17|Buke
74.05.18|Wolasi
74.05.19|Laeya
74.05.20|Baito
74.05.21|Basala
74.05.22|Ranomeeto Barat
74.05.23|Kolono Timur
74.05.24|Sabulakoa
74.05.25|Andoolo Barat
74.06.01|Poleang
74.06.02|Poleang Timur
74.06.03|Rarowatu
74.06.04|Rumbia
74.06.05|Kabaena
74.06.06|Kabaena Timur
74.06.07|Poleang Barat
74.06.08|Mata Oleo
74.06.09|Rarowatu Utara
74.06.10|Poleang Utara
74.06.11|Poleang Selatan
74.06.12|Poleang Tenggara
74.06.13|Kabaena Selatan
74.06.14|Kabaena Barat
74.06.15|Kabaena Utara
74.06.16|Kabaena Tengah
74.06.17|Kep. Masaloka Raya
74.06.18|Rumbia Tengah
74.06.19|Poleang Tengah
74.06.20|Tontonunu
74.06.21|Lantari Jaya
74.06.22|Mata Usu
74.07.01|Wangi-Wangi
74.07.02|Kaledupa
74.07.03|Tomia
74.07.04|Binongko
74.07.05|Wangi Wangi Selatan
74.07.06|Kaledupa Selatan
74.07.07|Tomia Timur
74.07.08|Togo Binongko
74.08.01|Lasusua
74.08.02|Pakue
74.08.03|Batu Putih
74.08.04|Rante Angin
74.08.05|Kodeoha
74.08.06|Ngapa
74.08.07|Wawo
74.08.08|Lambai
74.08.09|Watunohu
74.08.10|Pakue Tengah
74.08.11|Pakue Utara
74.08.12|Porehu
74.08.13|Katoi
74.08.14|Tiwu
74.08.15|Tolala
74.09.01|Asera
74.09.02|Wiwirano
74.09.03|Langgikima
74.09.04|Molawe
74.09.05|Lasolo
74.09.06|Lembo
74.09.07|Sawa
74.09.08|Oheo
74.09.09|Andowia
74.09.10|Motui
74.09.11|Wawolesea
74.09.12|Lasolo Kepulauan
74.09.13|Landawe
74.10.01|Kulisusu
74.10.02|Kambowa
74.10.03|Bonegunu
74.10.04|Kulisusu Barat
74.10.05|Kulisusu Utara
74.10.06|Wakorumba Utara
74.11.01|Tirawuta
74.11.02|Loea
74.11.03|Ladongi
74.11.04|Poli Polia
74.11.05|Lambandia
74.11.06|Lalolae
74.11.07|Mowewe
74.11.08|Uluiwoi
74.11.09|Tinondo
74.11.10|Aere
74.11.11|Ueesi
74.11.12|Dangia
74.12.01|Wawonii Barat
74.12.02|Wawonii Utara
74.12.03|Wawonii Timur Laut
74.12.04|Wawonii Timur
74.12.05|Wawonii Tenggara
74.12.06|Wawonii Selatan
74.12.07|Wawonii Tengah
74.13.01|Sawerigadi
74.13.02|Barangka
74.13.03|Lawa
74.13.04|Wadaga
74.13.05|Tiworo Selatan
74.13.06|Maginti
74.13.07|Tiworo Tengah
74.13.08|Tiworo Utara
74.13.09|Tiworo Kepulauan
74.13.10|Kusambi
74.13.11|Napano Kusambi
74.14.01|Lakudo
74.14.02|Mawasangka Timur
74.14.03|Mawasangka Tengah
74.14.04|Mawasangka
74.14.05|Talaga Raya
74.14.06|Gu
74.14.07|Sangia Wambulu
74.15.01|Batauga
74.15.02|Sampolawa
74.15.03|Lapandewa
74.15.04|Batu Atas
74.15.05|Siompu Barat
74.15.06|Siompu
74.15.07|Kadatua
74.71.01|Mandonga
74.71.02|Kendari
74.71.03|Baruga
74.71.04|Poasia
74.71.05|Kendari Barat
74.71.06|Abeli
74.71.07|Wua-Wua
74.71.08|Kadia
74.71.09|Puuwatu
74.71.10|Kambu
74.71.11|Nambo
74.72.01|Betoambari
74.72.02|Wolio
74.72.03|Sorawolio
74.72.04|Bungi
74.72.05|Kokalukuna
74.72.06|Murhum
74.72.07|Lea-Lea
74.72.08|Batupoaro
75.01.01|Limboto
75.01.02|Telaga
75.01.03|Batudaa
75.01.04|Tibawa
75.01.05|Batudaa Pantai
75.01.09|Boliyohuto
75.01.10|Telaga Biru
75.01.11|Bongomeme
75.01.13|Tolangohula
75.01.14|Mootilango
75.01.16|Pulubala
75.01.17|Limboto Barat
75.01.18|Tilango
75.01.19|Tabongo
75.01.20|Biluhu
75.01.21|Asparaga
75.01.22|Talaga Jaya
75.01.23|Bilato
75.01.24|Dungaliyo
75.02.01|Paguyaman
75.02.02|Wonosari
75.02.03|Dulupi
75.02.04|Tilamuta
75.02.05|Mananggu
75.02.06|Botumoito
75.02.07|Paguyaman Pantai
75.03.01|Tapa
75.03.02|Kabila
75.03.03|Suwawa
75.03.04|Bonepantai
75.03.05|Bulango Utara
75.03.06|Tilongkabila
75.03.07|Botupingge
75.03.08|Kabila Bone
75.03.09|Bone
75.03.10|Bone Raya
75.03.11|Suwawa Timur
75.03.12|Suwawa Selatan
75.03.13|Suwawa Tengah
75.03.14|Bulango Ulu
75.03.15|Bulango Selatan
75.03.16|Bulango Timur
75.03.17|Bulawa
75.03.18|Pinogu
75.04.01|Popayato
75.04.02|Lemito
75.04.03|Randangan
75.04.04|Marisa
75.04.05|Paguat
75.04.06|Patilanggio
75.04.07|Taluditi
75.04.08|Dengilo
75.04.09|Buntulia
75.04.10|Duhiadaa
75.04.11|Wanggarasi
75.04.12|Popayato Timur
75.04.13|Popayato Barat
75.05.01|Atinggola
75.05.02|Kwandang
75.05.03|Anggrek
75.05.04|Sumalata
75.05.05|Tolinggula
75.05.06|Gentuma Raya
75.05.07|Tomilito
75.05.08|Ponelo Kepulauan
75.05.09|Monano
75.05.10|Biau
75.05.11|Sumalata Timur
75.71.01|Kota Barat
75.71.02|Kota Selatan
75.71.03|Kota Utara
75.71.04|Dungingi
75.71.05|Kota Timur
75.71.06|Kota Tengah
75.71.07|Sipatana
75.71.08|Dumbo Raya
75.71.09|Hulonthalangi
76.01.01|Bambalamotu
76.01.02|Pasangkayu
76.01.03|Baras
76.01.04|Sarudu
76.01.05|Dapurang
76.01.06|Duripoku
76.01.07|Bulu Taba
76.01.08|Tikke Raya
76.01.09|Pedongga
76.01.10|Bambaira
76.01.11|Sarjo
76.01.12|Lariang
76.02.01|Mamuju
76.02.02|Tapalang
76.02.03|Kalukku
76.02.04|Kalumpang
76.02.07|Papalang
76.02.08|Sampaga
76.02.11|Tommo
76.02.12|Simboro
76.02.13|Tapalang Barat
76.02.15|Bonehau
76.02.16|Kepulauan Bala Balakang
76.03.01|Mambi
76.03.02|Aralle
76.03.03|Mamasa
76.03.04|Pana
76.03.05|Tabulahan
76.03.06|Sumarorong
76.03.07|Messawa
76.03.08|Sesenapadang
76.03.09|Tanduk Kalua
76.03.10|Tabang
76.03.11|Bambang
76.03.12|Balla
76.03.13|Nosu
76.03.14|Tawalian
76.03.15|Rantebulahan Timur
76.03.16|Buntumalangka
76.03.17|Mehalaan
76.04.01|Tinambung
76.04.02|Campalagian
76.04.03|Wonomulyo
76.04.04|Polewali
76.04.05|Tutar
76.04.06|Binuang
76.04.07|Tapango
76.04.08|Mapilli
76.04.09|Matangnga
76.04.10|Luyo
76.04.11|Limboro
76.04.12|Balanipa
76.04.13|Anreapi
76.04.14|Matakali
76.04.15|Allu
76.04.16|Bulo
76.05.01|Banggae
76.05.02|Pamboang
76.05.03|Sendana
76.05.04|Malunda
76.05.05|Ulumanda
76.05.06|Tammerodo Sendana
76.05.07|Tubo Sendana
76.05.08|Banggae Timur
76.06.01|Tobadak
76.06.02|Pangale
76.06.03|Budong-Budong
76.06.04|Topoyo
76.06.05|Karossa
81.01.01|Amahai
81.01.02|Teon Nila Serua
81.01.06|Seram Utara
81.01.09|Banda
81.01.11|Tehoru
81.01.12|Saparua
81.01.13|Pulau Haruku
81.01.14|Salahutu
81.01.15|Leihitu
81.01.16|Nusa Laut
81.01.17|Kota Masohi
81.01.20|Seram Utara Barat
81.01.21|Teluk Elpaputih
81.01.22|Leihitu Barat
81.01.23|Telutih
81.01.24|Seram Utara Timur Seti
81.01.25|Seram Utara Timur Kobi
81.01.26|Saparua Timur
81.02.01|Kei Kecil
81.02.03|Kei Besar
81.02.04|Kei Besar Selatan
81.02.05|Kei Besar Utara Timur
81.02.13|Kei Kecil Timur
81.02.14|Kei Kecil Barat
81.02.15|Manyeuw
81.02.16|Hoat Sorbay
81.02.17|Kei Besar Utara Barat
81.02.18|Kei Besar Selatan Barat
81.02.19|Kei Kecil Timur Selatan
81.03.01|Tanimbar Selatan
81.03.02|Selaru
81.03.03|Wertamrian
81.03.04|Wermaktian
81.03.05|Tanimbar Utara
81.03.06|Fordata
81.03.07|Wuar Labobar
81.03.08|Kormomolin
81.03.09|Nirunmas
81.03.18|Molu Maru
81.04.01|Namlea
81.04.02|Air Buaya
81.04.03|Waeapo
81.04.06|Waplau
81.04.10|Batabual
81.04.11|Lolong Guba
81.04.12|Waelata
81.04.13|Fena Leisela
81.04.14|Teluk Kaiely
81.04.15|Lilialy
81.05.01|Bula
81.05.02|Seram Timur
81.05.03|Werinama
81.05.04|Pulau Gorom
81.05.05|Wakate
81.05.06|Tutuk Tolu
81.05.07|Siwalalat
81.05.08|Kilmury
81.05.09|Pulau Panjang
81.05.10|Teor
81.05.11|Gorom Timur
81.05.12|Bula Barat
81.05.13|Kian Darat
81.05.14|Siritaun Wida Timur
81.05.15|Teluk Waru
81.05.16|Ukar Sengan
81.06.01|Kairatu
81.06.02|Seram Barat
81.06.03|Taniwel
81.06.04|Huamual Belakang
81.06.05|Amalatu
81.06.06|Inamosol
81.06.07|Kairatu Barat
81.06.08|Huamual
81.06.09|Kepulauan Manipa
81.06.10|Taniwel Timur
81.06.11|Elpaputih
81.07.01|Pulau-Pulau Aru
81.07.02|Aru Selatan
81.07.03|Aru Tengah
81.07.04|Aru Utara
81.07.05|Aru Utara Timur Batuley
81.07.06|Sir-Sir
81.07.07|Aru Tengah Timur
81.07.08|Aru Tengah Selatan
81.07.09|Aru Selatan Timur
81.07.10|Aru Selatan Utara
81.08.01|Moa
81.08.02|Damer
81.08.03|Kepulauan Luang Sermata
81.08.04|Babar Barat
81.08.05|Pulau-pulau Babar Timur
81.08.06|Wetar Selatan
81.08.07|Kisar Selatan
81.08.08|Pulau Leti
81.08.09|Pulau Masela
81.08.10|Dawelor Dawera
81.08.11|Pulau Wetang
81.08.12|Pulau Lakor
81.08.13|Wetar Utara
81.08.14|Wetar Barat
81.08.15|Wetar Timur
81.08.16|Kepulauan Roma
81.08.17|Kisar Utara
81.09.01|Namrole
81.09.02|Waesama
81.09.03|Ambalau
81.09.04|Kepala Madan
81.09.05|Leksula
81.09.06|Fena Fafan
81.71.01|Nusaniwe
81.71.02|Sirimau
81.71.03|Baguala
81.71.04|Teluk Ambon
81.71.05|Leitimur Selatan
81.72.01|Pulau Dullah Utara
81.72.02|Pulau Dullah Selatan
81.72.03|Tayando Tam
81.72.04|Pulau-Pulau Kur
81.72.05|Kur Selatan
82.01.01|Jailolo
82.01.02|Loloda
82.01.03|Ibu
82.01.04|Sahu
82.01.05|Jailolo Selatan
82.01.07|Ibu Utara
82.01.08|Ibu Selatan
82.01.09|Sahu Timur
82.01.10|Loloda Tengah
82.02.01|Weda
82.02.02|Patani
82.02.03|Pulau Gebe
82.02.04|Weda Utara
82.02.05|Weda Selatan
82.02.06|Patani Utara
82.02.07|Weda Tengah
82.02.08|Patani Barat
82.02.09|Weda Timur
82.02.10|Patani Timur
82.03.04|Galela
82.03.05|Tobelo
82.03.06|Tobelo Selatan
82.03.07|Kao
82.03.08|Malifut
82.03.09|Loloda Utara
82.03.10|Tobelo Utara
82.03.11|Tobelo Tengah
82.03.12|Tobelo Timur
82.03.13|Tobelo Barat
82.03.14|Galela Barat
82.03.15|Galela Utara
82.03.16|Galela Selatan
82.03.19|Loloda Kepulauan
82.03.20|Kao Utara
82.03.21|Kao Barat
82.03.22|Kao Teluk
82.04.01|Pulau Makian
82.04.02|Kayoa
82.04.03|Gane Timur
82.04.04|Gane Barat
82.04.05|Obi Selatan
82.04.06|Obi
82.04.07|Bacan Timur
82.04.08|Bacan
82.04.09|Bacan Barat
82.04.10|Makian Barat
82.04.11|Kayoa Barat
82.04.12|Kayoa Selatan
82.04.13|Kayoa Utara
82.04.14|Bacan Barat Utara
82.04.15|Kasiruta Barat
82.04.16|Kasiruta Timur
82.04.17|Bacan Selatan
82.04.18|Kepulauan Botanglomang
82.04.19|Mandioli Selatan
82.04.20|Mandioli Utara
82.04.21|Bacan Timur Selatan
82.04.22|Bacan Timur Tengah
82.04.23|Gane Barat Selatan
82.04.24|Gane Barat Utara
82.04.25|Kepulauan Joronga
82.04.26|Gane Timur Selatan
82.04.27|Gane Timur Tengah
82.04.28|Obi Barat
82.04.29|Obi Timur
82.04.30|Obi Utara
82.05.01|Mangoli Timur
82.05.02|Sanana
82.05.03|Sulabesi Barat
82.05.06|Mangoli Barat
82.05.07|Sulabesi Tengah
82.05.08|Sulabesi Timur
82.05.09|Sulabesi Selatan
82.05.10|Mangoli Utara Timur
82.05.11|Mangoli Tengah
82.05.12|Mangoli Selatan
82.05.13|Mangoli Utara
82.05.18|Sanana Utara
82.06.01|Wasile
82.06.02|Maba
82.06.03|Maba Selatan
82.06.04|Wasile Selatan
82.06.05|Wasile Tengah
82.06.06|Wasile Utara
82.06.07|Wasile Timur
82.06.08|Maba Tengah
82.06.09|Maba Utara
82.06.10|Kota Maba
82.07.01|Morotai Selatan
82.07.02|Morotai Selatan Barat
82.07.03|Morotai Jaya
82.07.04|Morotai Utara
82.07.05|Morotai Timur
82.07.06|Pulau Rao
82.08.01|Taliabu Barat
82.08.02|Taliabu Barat Laut
82.08.03|Lede
82.08.04|Taliabu Utara
82.08.05|Taliabu Timur
82.08.06|Taliabu Timur Selatan
82.08.07|Taliabu Selatan
82.08.08|Tabona
82.71.01|Pulau Ternate
82.71.02|Kota Ternate Selatan
82.71.03|Kota Ternate Utara
82.71.04|Moti
82.71.05|Pulau Batang Dua
82.71.06|Kota Ternate Tengah
82.71.07|Pulau Hiri
82.71.08|Ternate Barat
82.72.01|Tidore
82.72.02|Oba Utara
82.72.03|Oba
82.72.04|Tidore Selatan
82.72.05|Tidore Utara
82.72.06|Oba Tengah
82.72.07|Oba Selatan
82.72.08|Tidore Timur
91.03.01|Sentani
91.03.02|Sentani Timur
91.03.03|Depapre
91.03.04|Sentani Barat
91.03.05|Kemtuk
91.03.06|Kemtuk Gresi
91.03.07|Nimboran
91.03.08|Nimbokrang
91.03.09|Unurum Guay
91.03.10|Demta
91.03.11|Kaureh
91.03.12|Ebungfao
91.03.13|Waibu
91.03.14|Nambluong
91.03.15|Yapsi
91.03.16|Airu
91.03.17|Raveni Rara
91.03.18|Gresi Selatan
91.03.19|Yokari
91.05.01|Yapen Selatan
91.05.02|Yapen Barat
91.05.03|Yapen Timur
91.05.04|Angkaisera
91.05.05|Poom
91.05.06|Kosiwo
91.05.07|Yapen Utara
91.05.08|Raimbawi
91.05.09|Teluk Ampimoi
91.05.10|Kepulauan Ambai
91.05.11|Wonawa
91.05.12|Windesi
91.05.13|Pulau Kurudu
91.05.14|Pulau Yerui
91.05.15|Anotaurei
91.05.16|Yawakukat
91.05.17|Nusawani
91.06.01|Biak Kota
91.06.02|Biak Utara
91.06.03|Biak Timur
91.06.04|Numfor Barat
91.06.05|Numfor Timur
91.06.08|Biak Barat
91.06.09|Warsa
91.06.10|Padaido
91.06.11|Yendidori
91.06.12|Samofa
91.06.13|Yawosi
91.06.14|Andey
91.06.15|Swandiwe
91.06.16|Bruyadori
91.06.17|Orkeri
91.06.18|Poiru
91.06.19|Aimando Padaido
91.06.20|Oridek
91.06.21|Bondifuar
91.10.01|Sarmi
91.10.02|Tor Atas
91.10.03|Pantai Barat
91.10.04|Pantai Timur
91.10.05|Bonggo
91.10.09|Apawer Hulu
91.10.12|Sarmi Selatan
91.10.13|Sarmi Timur
91.10.14|Pantai Timur Bagian Barat
91.10.15|Bonggo Timur
91.11.01|Waris
91.11.02|Arso
91.11.03|Senggi
91.11.04|Web
91.11.05|Skanto
91.11.06|Arso Timur
91.11.07|Towe
91.11.08|Arso Barat
91.11.09|Mannem
91.11.10|Yaffi
91.11.11|Kaisenar
91.15.01|Waropen Bawah
91.15.03|Masirei
91.15.07|Risei Sayati
91.15.08|Urei Faisei
91.15.09|Inggerus
91.15.10|Kirihi
91.15.11|Oudate
91.15.12|Wapoga
91.15.13|Demba
91.15.14|Wonti
91.15.15|Soyoi Mambai
91.19.01|Supiori Selatan
91.19.02|Supiori Utara
91.19.03|Supiori Timur
91.19.04|Kepulauan Aruri
91.19.05|Supiori Barat
91.20.01|Mamberamo Tengah
91.20.02|Mamberamo Hulu
91.20.03|Rufaer
91.20.04|Mamberamo Tengah Timur
91.20.05|Mamberamo Hilir
91.20.06|Waropen Atas
91.20.07|Benuki
91.20.08|Sawai
91.71.01|Jayapura Utara
91.71.02|Jayapura Selatan
91.71.03|Abepura
91.71.04|Muara Tami
91.71.05|Heram
92.02.03|Warmare
92.02.04|Prafi
92.02.05|Masni
92.02.12|Manokwari Barat
92.02.13|Manokwari Timur
92.02.14|Manokwari Utara
92.02.15|Manokwari Selatan
92.02.17|Tanah Rubuh
92.02.21|Sidey
92.02.31|Aimasi
92.02.32|Mokwam
92.02.33|Masni Utara
92.02.34|Wasirawi
92.02.35|Moruj Mega
92.03.01|Fak-Fak
92.03.02|Fak-Fak Barat
92.03.03|Fak-Fak Timur
92.03.04|Kokas
92.03.05|Fak-Fak Tengah
92.03.06|Karas
92.03.07|Bomberay
92.03.08|Kramongmongga
92.03.09|Teluk Patipi
92.03.10|Pariwari
92.03.11|Wartutin
92.03.12|Fakfak Timur Tengah
92.03.13|Arguni
92.03.14|Mbahamdandara
92.03.15|Kayauni
92.03.16|Furwagi
92.03.17|Tomage
92.06.01|Bintuni
92.06.02|Merdey
92.06.03|Babo
92.06.04|Aranday
92.06.05|Moskona Selatan
92.06.06|Moskona Utara
92.06.07|Wamesa
92.06.08|Fafurwar
92.06.09|Tembuni
92.06.10|Kuri
92.06.11|Manimeri
92.06.12|Tuhiba
92.06.13|Dataran Beimes
92.06.14|Sumuri
92.06.15|Kaitaro
92.06.16|Aroba
92.06.17|Masyeta
92.06.18|Biscoop
92.06.19|Tomu
92.06.20|Kamundan
92.06.21|Weriagar
92.06.22|Moskona Barat
92.06.23|Meyado
92.06.24|Moskona Timur
92.07.01|Wasior
92.07.02|Windesi
92.07.03|Teluk Duairi
92.07.04|Wondiboy
92.07.05|Wamesa
92.07.06|Rumberpon
92.07.07|Naikere
92.07.08|Rasiei
92.07.09|Kuri Wamesa
92.07.10|Roon
92.07.11|Roswar
92.07.12|Nikiwar
92.07.13|Soug Jaya
92.08.01|Kaimana
92.08.02|Buruway
92.08.03|Teluk Arguni Atas
92.08.04|Teluk Etna
92.08.05|Kambrau
92.08.06|Teluk Arguni Bawah
92.08.07|Yamor
92.11.01|Ransiki
92.11.02|Oransbari
92.11.03|Neney
92.11.04|Dataran Isim
92.11.05|Momi Waren
92.11.06|Tahota
92.12.01|Anggi
92.12.02|Anggi Gida
92.12.03|Membey
92.12.04|Sururey
92.12.05|Didohu
92.12.06|Taige
92.12.07|Catubouw
92.12.08|Testega
92.12.09|Minyambaouw
92.12.10|Hingk
93.01.01|Merauke
93.01.02|Muting
93.01.03|Okaba
93.01.04|Kimaam
93.01.05|Semangga
93.01.06|Tanah Miring
93.01.07|Jagebob
93.01.08|Sota
93.01.09|Ulilin
93.01.10|Elikobal
93.01.11|Kurik
93.01.12|Naukenjerai
93.01.13|Animha
93.01.14|Malind
93.01.15|Tubang
93.01.16|Ngguti
93.01.17|Kaptel
93.01.18|Tabonji
93.01.19|Waan
93.01.20|Ilwayab
93.01.21|Padua
93.01.22|Kontuar
93.02.01|Mandobo
93.02.02|Mindiptana
93.02.03|Waropko
93.02.04|Kouh
93.02.05|Jair
93.02.06|Bomakia
93.02.07|Kombut
93.02.08|Iniyandit
93.02.09|Arimop
93.02.10|Fofi
93.02.11|Ambatkwi
93.02.12|Manggelum
93.02.13|Firiwage
93.02.14|Yaniruma
93.02.15|Subur
93.02.16|Kombay
93.02.17|Ninati
93.02.18|Sesnuk
93.02.19|Ki
93.02.20|Kawagit
93.03.01|Obaa
93.03.02|Mambioman Bapai
93.03.03|Citak-Mitak
93.03.04|Edera
93.03.05|Haju
93.03.06|Assue
93.03.07|Kaibar
93.03.08|Passue
93.03.09|Minyamur
93.03.10|Venaha
93.03.11|Syahcame
93.03.12|Yakomi
93.03.13|Bamgi
93.03.14|Passue Bawah
93.03.15|Ti Zain
93.04.01|Agats
93.04.02|Atsj
93.04.03|Sawa Erma
93.04.04|Akat
93.04.05|Fayit
93.04.06|Pantai Kasuari
93.04.07|Suator
93.04.08|Suru-suru
93.04.09|Kolf Braza
93.04.10|Unir Sirau
93.04.11|Joerat
93.04.12|Pulau Tiga
93.04.13|Jetsy
93.04.14|Der Koumur
93.04.15|Kopay
93.04.16|Safan
93.04.17|Sirets
93.04.18|Ayib
93.04.19|Betcbamu
93.04.20|Joutu
93.04.21|Aswi
93.04.22|Awyu
93.04.23|Koroway Buluanop
93.04.24|Tomor Birip
93.04.25|Sor Ep
94.01.01|Nabire
94.01.02|Napan
94.01.03|Yaur
94.01.04|Uwapa
94.01.05|Wanggar
94.01.06|Siriwo
94.01.07|Makimi
94.01.08|Teluk Umar
94.01.09|Teluk Kimi
94.01.10|Yaro
94.01.11|Wapoga
94.01.12|Nabire Barat
94.01.13|Moora
94.01.14|Dipa
94.01.15|Menou
94.02.01|Mulia
94.02.02|Ilu
94.02.03|Fawi
94.02.04|Mewoluk
94.02.05|Yamo
94.02.06|Nume
94.02.07|Torere
94.02.08|Tingginambut
94.02.09|Pagaleme
94.02.10|Gurage
94.02.11|Irimuli
94.02.12|Muara
94.02.13|Ilamburawi
94.02.14|Yambi
94.02.15|Lumo
94.02.16|Molanikime
94.02.17|Dokome
94.02.18|Kalome
94.02.19|Wanwi
94.02.20|Yamoneri
94.02.21|Waegi
94.02.22|Nioga
94.02.23|Gubume
94.02.24|Taganombak
94.02.25|Dagai
94.02.26|Kiyage
94.03.01|Paniai Timur
94.03.02|Paniai Barat
94.03.03|Aradide
94.03.04|Bogabaida
94.03.05|Bibida
94.03.06|Dumadama
94.03.07|Siriwo
94.03.08|Kebo
94.03.09|Yatamo
94.03.10|Ekadide
94.03.11|Wegee Muka
94.03.12|Wegee Bino
94.03.13|Pugo Dagi
94.03.14|Muye
94.03.15|Nakama
94.03.16|Teluk Deya
94.03.17|Yagai
94.03.18|Youtadi
94.03.19|Baya Biru
94.03.20|Deiyai Miyo
94.03.21|Dogomo
94.03.22|Aweida
94.03.23|Topiyai
94.03.24|Fajar Timur
94.04.01|Mimika Baru
94.04.02|Agimuga
94.04.03|Mimika Timur
94.04.04|Mimika Barat
94.04.05|Jita
94.04.06|Jila
94.04.07|Mimika Timur Jauh
94.04.08|Mimika Tengah
94.04.09|Kuala Kencana
94.04.10|Tembagapura
94.04.11|Mimika Barat Jauh
94.04.12|Mimika Barat Tengah
94.04.13|Kwamki Narama
94.04.14|Hoya
94.04.15|Iwaka
94.04.16|Wania
94.04.17|Amar
94.04.18|Alama
94.05.01|Ilaga
94.05.02|Wangbe
94.05.03|Beoga
94.05.04|Doufo
94.05.05|Pogoma
94.05.06|Sinak
94.05.07|Agandugume
94.05.08|Gome
94.05.09|Dervos
94.05.10|Beoga Barat
94.05.11|Beoga Timur
94.05.12|Ogamanim
94.05.13|Kembru
94.05.14|Bina
94.05.15|Sinak Barat
94.05.16|Mage'abume
94.05.17|Yugumuak
94.05.18|Ilaga Utara
94.05.19|Mabugi
94.05.20|Omukia
94.05.21|Lambewi
94.05.22|Oneri
94.05.23|Amungkalpia
94.05.24|Gome Utara
94.05.25|Erelmakawia
94.06.01|Kamu
94.06.02|Mapia
94.06.03|Piyaiye
94.06.04|Kamu Utara
94.06.05|Sukikai Selatan
94.06.06|Mapia Barat
94.06.07|Kamu Selatan
94.06.08|Kamu Timur
94.06.09|Mapia Tengah
94.06.10|Dogiyai
94.07.01|Sugapa
94.07.02|Homeyo
94.07.03|Wandai
94.07.04|Biandoga
94.07.05|Agisiga
94.07.06|Hitadipa
94.07.07|Ugimba
94.07.08|Tomosiga
94.08.01|Tigi
94.08.02|Tigi Timur
94.08.03|Bowobado
94.08.04|Tigi Barat
94.08.05|Kapiraya
95.01.01|Wamena
95.01.02|Kurulu
95.01.03|Asologaima
95.01.04|Hubikosi
95.01.05|Bolakme
95.01.06|Walelagama
95.01.07|Musatfak
95.01.08|Wolo
95.01.09|Asolokobal
95.01.10|Pelebaga
95.01.11|Yalengga
95.01.12|Trikora
95.01.13|Napua
95.01.14|Walaik
95.01.15|Wouma
95.01.16|Hubikiak
95.01.17|Ibele
95.01.18|Taelarek
95.01.19|Itlay Hisage
95.01.20|Siepkosi
95.01.21|Usilimo
95.01.22|Wita Waya
95.01.23|Libarek
95.01.24|Wadangku
95.01.25|Pisugi
95.01.26|Koragi
95.01.27|Tagime
95.01.28|Molagalome
95.01.29|Tagineri
95.01.30|Silo Karno Doga
95.01.31|Piramid
95.01.32|Muliama
95.01.33|Bugi
95.01.34|Bpiri
95.01.35|Welesi
95.01.36|Asotipo
95.01.37|Maima
95.01.38|Popugoba
95.01.39|Wame
95.01.40|Wesaput
95.02.01|Oksibil
95.02.02|Kiwirok
95.02.03|Okbibab
95.02.04|Iwur
95.02.05|Batom
95.02.06|Borme
95.02.07|Kiwirok Timur
95.02.08|Aboy
95.02.09|Pepera
95.02.10|Bime
95.02.11|Alemsom
95.02.12|Okbape
95.02.13|Kalomdol
95.02.14|Oksop
95.02.15|Serambakon
95.02.16|Ok Aom
95.02.17|Kawor
95.02.18|Awinbon
95.02.19|Tarup
95.02.20|Okhika
95.02.21|Oksamol
95.02.22|Oklip
95.02.23|Okbemtau
95.02.24|Oksebang
95.02.25|Okbab
95.02.26|Batani
95.02.27|Weime
95.02.28|Murkim
95.02.29|Mofinop
95.02.30|Jetfa
95.02.31|Teiraplu
95.02.32|Eipumek
95.02.33|Pamek
95.02.34|Nongme
95.03.01|Kurima
95.03.02|Anggruk
95.03.03|Ninia
95.03.04|Silimo
95.03.05|Samenage
95.03.06|Nalca
95.03.07|Dekai
95.03.08|Obio
95.03.09|Suru Suru
95.03.10|Wusama
95.03.11|Amuma
95.03.12|Musaik
95.03.13|Pasema
95.03.14|Hogio
95.03.15|Mugi
95.03.16|Soba
95.03.17|Werima
95.03.18|Tangma
95.03.19|Ukha
95.03.20|Panggema
95.03.21|Kosarek
95.03.22|Nipsan
95.03.23|Ubahak
95.03.24|Pronggoli
95.03.25|Walma
95.03.26|Yahuliambut
95.03.27|Hereapini
95.03.28|Ubalihi
95.03.29|Talambo
95.03.30|Puldama
95.03.31|Endomen
95.03.32|Kona
95.03.33|Dirwemna
95.03.34|Holuwon
95.03.35|Lolat
95.03.36|Soloikma
95.03.37|Sela
95.03.38|Korupun
95.03.39|Langda
95.03.40|Bomela
95.03.41|Suntamon
95.03.42|Seradala
95.03.43|Sobaham
95.03.44|Kabianggama
95.03.45|Kwelamdua
95.03.46|Kwikma
95.03.47|Hilipuk
95.03.48|Duram
95.03.49|Yogosem
95.03.50|Kayo
95.03.51|Sumo
95.04.01|Karubaga
95.04.02|Bokondini
95.04.03|Kanggime
95.04.04|Kembu
95.04.05|Goyage
95.04.06|Wunim
95.04.07|Wina
95.04.08|Umagi
95.04.09|Panaga
95.04.10|Woniki
95.04.11|Kubu
95.04.12|Konda/Kondaga
95.04.13|Nelawi
95.04.14|Kuari
95.04.15|Bokoneri
95.04.16|Bewani
95.04.17|Nabunage
95.04.18|Gilubandu
95.04.19|Nunggawi
95.04.20|Gundagi
95.04.21|Numba
95.04.22|Timori
95.04.23|Dundu
95.04.24|Geya
95.04.25|Egiam
95.04.26|Poganeri
95.04.27|Kamboneri
95.04.28|Airgaram
95.04.29|Wari/Taiyeve II
95.04.30|Dow
95.04.31|Tagineri
95.04.32|Yuneri
95.04.33|Wakuwo
95.04.34|Gika
95.04.35|Telenggeme
95.04.36|Anawi
95.04.37|Wenam
95.04.38|Wugi
95.04.39|Danime
95.04.40|Tagime
95.04.41|Kai
95.04.42|Aweku
95.04.43|Bogonuk
95.04.44|Li Anogomma
95.04.45|Biuk
95.04.46|Yuko
95.05.01|Kobakma
95.05.02|Kelila
95.05.03|Eragayam
95.05.04|Megambilis
95.05.05|Ilugwa
95.06.01|Elelim
95.06.02|Apalapsili
95.06.03|Abenaho
95.06.04|Benawa
95.06.05|Welarek
95.07.01|Tiom
95.07.02|Pirime
95.07.03|Makki
95.07.04|Gamelia
95.07.05|Dimba
95.07.06|Melagineri
95.07.07|Balingga
95.07.08|Tiomneri
95.07.09|Kuyawage
95.07.10|Poga
95.07.11|Niname
95.07.12|Nogi
95.07.13|Yiginua
95.07.14|Tiom Ollo
95.07.15|Yugungwi
95.07.16|Mokoni
95.07.17|Wereka
95.07.18|Milimbo
95.07.19|Wiringgambut
95.07.20|Gollo
95.07.21|Awina
95.07.22|Ayumnati
95.07.23|Wano Barat
95.07.24|Goa Balim
95.07.25|Bruwa
95.07.26|Balingga Barat
95.07.27|Gupura
95.07.28|Kolawa
95.07.29|Gelok Beam
95.07.30|Kuly Lanny
95.07.31|Lannyna
95.07.32|Karu
95.07.33|Yiluk
95.07.34|Guna
95.07.35|Kelulome
95.07.36|Nikogwe
95.07.37|Muara
95.07.38|Buguk Gona
95.07.39|Melagi
95.08.01|Kenyam
95.08.02|Mapenduma
95.08.03|Yigi
95.08.04|Wosak
95.08.05|Geselma
95.08.06|Mugi
95.08.07|Mbuwa
95.08.08|Gearek
95.08.09|Koroptak
95.08.10|Kegayem
95.08.11|Paro
95.08.12|Mebarok
95.08.13|Yenggelo
95.08.14|Kilmid
95.08.15|Alama
95.08.16|Yal
95.08.17|Mam
95.08.18|Dal
95.08.19|Nirkuri
95.08.20|Inikgal
95.08.21|Iniye
95.08.22|Mbulmu Yalma
95.08.23|Mbua Tengah
95.08.24|Embetpen
95.08.25|Kora
95.08.26|Wusi
95.08.27|Pija
95.08.28|Moba
95.08.29|Wutpaga
95.08.30|Nenggeagin
95.08.31|Krepkuri
95.08.32|Pasir Putih
96.01.01|Makbon
96.01.02|Beraur
96.01.03|Salawati
96.01.04|Seget
96.01.05|Aimas
96.01.06|Klamono
96.01.07|Sayosa
96.01.08|Segun
96.01.09|Mayamuk
96.01.10|Salawati Selatan
96.01.11|Klabot
96.01.12|Klawak
96.01.13|Maudus
96.01.14|Mariat
96.01.15|Klayili
96.01.16|Klaso
96.01.17|Moisegen
96.01.18|Sorong
96.01.19|Bagun
96.01.20|Wemak
96.01.21|Sunook
96.01.22|Buk
96.01.23|Saengkeduk
96.01.24|Malabotom
96.01.25|Konhir
96.01.26|Klasafet
96.01.27|Hobard
96.01.28|Salawati Tengah
96.01.29|Botain
96.01.30|Sayosa Timur
96.02.01|Teminabuan
96.02.02|Inanwatan
96.02.03|Sawiat
96.02.04|Kokoda
96.02.05|Moswaren
96.02.06|Seremuk
96.02.07|Wayer
96.02.08|Kais
96.02.09|Konda
96.02.10|Matemani
96.02.11|Kokoda Utara
96.02.12|Saifi
96.02.13|Fokour
96.02.14|Salkma
96.02.15|Kais Darat
96.03.01|Misool (Misool Utara)
96.03.02|Waigeo Utara
96.03.03|Waigeo Selatan
96.03.04|Salawati Utara
96.03.05|Ayau
96.03.06|Misool Timur
96.03.07|Waigeo Barat
96.03.08|Waigeo Timur
96.03.09|Teluk Mayalibit
96.03.10|Kofiau
96.03.11|Meos Mansar
96.03.12|Misool Selatan
96.03.13|Warwarbomi
96.03.14|Waigeo Barat Kepulauan
96.03.15|Misool Barat
96.03.16|Kepulauan Sembilan
96.03.17|Kota Waisai
96.03.18|Tiplol Mayalibit
96.03.19|Batanta Utara
96.03.20|Salawati Barat
96.03.21|Salawati Tengah
96.03.22|Supnin
96.03.23|Kepulauan Ayau
96.03.24|Batanta Selatan
96.04.01|Fef
96.04.02|Miyah
96.04.03|Yembun
96.04.04|Kwoor
96.04.05|Sausapor
96.04.06|Abun
96.04.07|Syujak
96.04.08|Moraid
96.04.09|Kebar
96.04.10|Amberbaken
96.04.11|Senopi
96.04.12|Mubrani
96.04.13|Bikar
96.04.14|Bamusbama
96.04.15|Ases
96.04.16|Miyah Selatan
96.04.17|Ireres
96.04.18|Tobouw
96.04.19|Wilhem Roumbouts
96.04.20|Tinggouw
96.04.21|Kwesefo
96.04.22|Mawabuan
96.04.23|Kebar Timur
96.04.24|Kebar Selatan
96.04.25|Manekar
96.04.26|Mpur
96.04.27|Amberbaken Barat
96.04.28|Kasi
96.04.29|Selemkai
96.05.01|Aifat
96.05.02|Aifat Utara
96.05.03|Aifat Timur
96.05.04|Aifat Selatan
96.05.05|Aitinyo Barat
96.05.06|Aitinyo
96.05.07|Aitinyo Utara
96.05.08|Ayamaru
96.05.09|Ayamaru Utara
96.05.10|Ayamaru Timur
96.05.11|Mare
96.05.12|Aifat Timur Tengah
96.05.13|Aifat Timur Jauh
96.05.14|Aifat Timur Selatan
96.05.15|Ayamaru Selatan
96.05.16|Ayamaru Jaya
96.05.17|Ayamaru Selatan Jaya
96.05.18|Ayamaru Timur Selatan
96.05.19|Ayamaru Utara Timur
96.05.20|Ayamaru Tengah
96.05.21|Ayamaru Barat
96.05.22|Aitinyo Tengah
96.05.23|Aitinyo Raya
96.05.24|Mare Selatan
96.71.01|Sorong
96.71.02|Sorong Timur
96.71.03|Sorong Barat
96.71.04|Sorong Kepulauan
96.71.05|Sorong Utara
96.71.06|Sorong Manoi
96.71.07|Sorong Kota
96.71.08|Klaurung
96.71.09|Malaimsimsa
96.71.10|Maladum Mes
11.01.01.2001|Keude Bakongan
11.01.01.2002|Ujong Mangki
11.01.01.2003|Ujong Padang
11.01.01.2004|Gampong Drien
11.01.01.2015|Darul Ikhsan
11.01.01.2016|Padang Beurahan
11.01.01.2017|Gampong Baro
11.01.02.2001|Fajar Harapan
11.01.02.2002|Krueng Batee
11.01.02.2003|Pasi Kuala Asahan
11.01.02.2004|Gunong Pulo
11.01.02.2005|Pulo Ie I
11.01.02.2006|Jambo Manyang
11.01.02.2007|Simpang Empat
11.01.02.2008|Limau Purut
11.01.02.2009|Pulo Kambing
11.01.02.2010|Kampung Paya
11.01.02.2011|Krueng Batu
11.01.02.2012|Krueng Kluet
11.01.02.2013|Alur Mas
11.01.02.2014|Kampung Tinggi
11.01.02.2015|Ruak
11.01.02.2016|Simpang Lhee
11.01.02.2017|Suaq Geuringgeng
11.01.02.2018|Pasi Kuala Ba'u
11.01.02.2019|Kedai Padang
11.01.02.2020|Kotafajar
11.01.02.2021|Gunung Pudung
11.01.03.2001|Suaq Bakung
11.01.03.2002|Rantau Binuang
11.01.03.2003|Barat Daya
11.01.03.2004|Sialang
11.01.03.2005|Kapeh
11.01.03.2006|Pulo Ie
11.01.03.2007|Kedai Runding
11.01.03.2008|Kedai Kandang
11.01.03.2009|Gampong Luar
11.01.03.2010|Ujung
11.01.03.2011|Jua
11.01.03.2012|Pasi Meurapat
11.01.03.2013|Ujung Pasir
11.01.03.2014|Geulumbuk
11.01.03.2015|Pasie Lembang
11.01.03.2016|Ujung Padang
11.01.03.2017|Indra Damai
11.01.04.2001|Bakau Hulu
11.01.04.2002|Padang Bakau
11.01.04.2003|Manggis Harapan
11.01.04.2004|Pasar Lama
11.01.04.2005|Apha
11.01.04.2006|Ujung Batu
11.01.04.2007|Pawoh
11.01.04.2008|Dalam
11.01.04.2009|Kota Palak
11.01.04.2010|Cacang
11.01.04.2011|Tengah Pisang
11.01.04.2012|Pisang
11.01.04.2013|Hulu Pisang
11.01.04.2014|Tengah Baru
11.01.04.2015|Lembah Baru
11.01.04.2016|Padang Baru
11.01.05.2001|Kuta Buloh II
11.01.05.2002|Kuta Buloh I
11.01.05.2003|Ie Dingen
11.01.05.2004|Drien Jalo
11.01.05.2005|Jambo Papeun
11.01.05.2006|Buket Meuh
11.01.05.2007|Blang Kuala
11.01.05.2008|Rot Teungoh
11.01.05.2009|Alue Baro
11.01.05.2010|Ladang Tuha
11.01.05.2011|Lhok Mamplam
11.01.05.2012|Arun Tunggai
11.01.05.2013|Blang Teungoh
11.01.05.2014|Blang Bladeh
11.01.05.2015|Ie Buboh
11.01.05.2016|Keude Meukek
11.01.05.2017|Kuta Baro
11.01.05.2018|Tanjung Harapan
11.01.05.2019|Labuhan Tarok
11.01.05.2020|Lhok Aman
11.01.05.2021|Alue Meutuah
11.01.05.2022|Ladang Baro
11.01.05.2023|Labuhan Tarok II
11.01.06.2001|Dalam
11.01.06.2002|Subarang
11.01.06.2003|Kuta Baru
11.01.06.2004|Gunung Ketek
11.01.06.2005|Ladang Panton Luas
11.01.06.2006|Madat
11.01.06.2007|Alur Seumerah
11.01.06.2008|Tengah
11.01.06.2009|Gunung Cut
11.01.06.2010|Alur Pinang
11.01.06.2011|Kuta Blang
11.01.06.2012|Batee Tunggai
11.01.06.2013|Ujung Tanah
11.01.06.2014|Ujung Kampung
11.01.06.2015|Jilatang
11.01.06.2016|Luar
11.01.06.2017|Lubuk Layu
11.01.06.2018|Suaq Hulu
11.01.06.2019|Tampang
11.01.06.2020|Payonan Gadang
11.01.06.2021|Gadang
11.01.06.2022|Baru
11.01.06.2023|Ladang Kasik Putih
11.01.06.2024|Air Sialang Hilir
11.01.06.2025|Air Sialang Hulu
11.01.06.2026|Air Sialang Tengah
11.01.06.2027|Balai
11.01.06.2028|Arafah
11.01.07.2001|Sikulat
11.01.07.2002|Sawang I
11.01.07.2003|Meuligo
11.01.07.2004|Lhok Pawoh
11.01.07.2005|Sawang II
11.01.07.2006|Ujung Karang
11.01.07.2007|Trieng Meuduro Baroh
11.01.07.2008|Trieng Meuduro Tunong
11.01.07.2009|Panton Luas
11.01.07.2010|Simpang Tiga
11.01.07.2011|Kuta Baro
11.01.07.2012|Blang Geulinggang
11.01.07.2013|Mutiara
11.01.07.2014|Ujung Padang
11.01.07.2015|Sawang Ba'u
11.01.08.2001|Lhok Keutapang
11.01.08.2002|Hilir
11.01.08.2003|Padang
11.01.08.2004|Hulu
11.01.08.2005|Jambo Apha
11.01.08.2006|Tepi Air
11.01.08.2007|Pasar
11.01.08.2008|Lhok Bengkuang
11.01.08.2009|Panton Luas
11.01.08.2010|Gunung Kerambil
11.01.08.2011|Air Berudang
11.01.08.2012|Batu Itam
11.01.08.2013|Panjupian
11.01.08.2014|Lhok Rukam
11.01.08.2015|Air Pinang
11.01.08.2016|Lhok Bengkuang Timur
11.01.09.2001|Keude Trumon
11.01.09.2002|Ujong Tanoh
11.01.09.2003|Sigleng
11.01.09.2004|Ie Meudama
11.01.09.2005|Teupin Tinggi
11.01.09.2006|Kuta Baro
11.01.09.2007|Panton Bilie
11.01.09.2012|Kuta Padang
11.01.09.2013|Raket
11.01.09.2014|Gampong Teungoh
11.01.09.2015|Seuneubok Jaya
11.01.09.2016|Padang Harapan
11.01.10.2001|Ladang Teungoh
11.01.10.2002|Pucok Krueng
11.01.10.2003|Silolo
11.01.10.2004|Kampung Baru
11.01.10.2005|Panton Bili
11.01.10.2006|Paya Ateuk
11.01.10.2007|Ladang Tuha
11.01.10.2008|Mata Ie
11.01.10.2009|Ujong Batee
11.01.10.2010|Lhok Sialang Cut
11.01.10.2011|Seuneubok
11.01.10.2012|Ie Mirah
11.01.10.2013|Pasie Rasian
11.01.10.2014|Ujung Padang Rasian
11.01.10.2015|Krueng Kalee
11.01.10.2016|Lhok Sialang Rayeuk
11.01.10.2017|Gampong Baro
11.01.10.2018|Teupin Gajah
11.01.10.2019|Ujung Padang Asahan
11.01.10.2020|Pulo Ie II
11.01.10.2021|Pante Raja
11.01.11.2001|Tengah Peulumat
11.01.11.2002|Paya Peulumat
11.01.11.2003|Padang Peulumat
11.01.11.2004|Aur Peulumat
11.01.11.2005|Limau Saring
11.01.11.2006|Beutong
11.01.11.2007|Peuneulop
11.01.11.2008|Gunung Rotan
11.01.11.2009|Keumumu Hilir
11.01.11.2010|Keumumu Hulu
11.01.11.2011|Keumumu Seberang
11.01.11.2012|Sawang Indah
11.01.12.2001|Tutong
11.01.12.2002|Teungoh Iboh
11.01.12.2003|Peulokan
11.01.12.2004|Kuta Iboh
11.01.12.2005|Ujung Padang
11.01.12.2006|Blang Baru
11.01.12.2007|Blang Poroh
11.01.12.2008|Pulo Ie
11.01.12.2009|Suak Lokan
11.01.12.2010|Iku Lhueng
11.01.12.2011|Kuta Trieng
11.01.12.2012|Pante Geulima
11.01.12.2013|Panton Pawoh
11.01.12.2014|Batee Meucanang
11.01.12.2015|Panton Rubek
11.01.13.2001|Koto
11.01.13.2002|Alur Keujrun
11.01.13.2003|Jambo Papan
11.01.13.2004|Malaka
11.01.13.2005|Koto Indarung
11.01.13.2006|Siurai-Urai
11.01.13.2007|Kampung Sawah
11.01.13.2008|Kampung Padang
11.01.13.2009|Pulo Air
11.01.13.2010|Lawe Melang
11.01.13.2011|Mersak
11.01.13.2012|Simpang Dua
11.01.13.2013|Simpang Tiga
11.01.14.2001|Paya Dapur
11.01.14.2002|Sapik
11.01.14.2003|Alai
11.01.14.2004|Durian Kawan
11.01.14.2005|Lawe Sawah
11.01.14.2006|Lawe Buluh Didi
11.01.14.2007|Pucuk Lembang
11.01.14.2008|Paya Laba
11.01.14.2009|Lawe Cimanok
11.01.15.2001|Pasie Seubadeh
11.01.15.2002|Ladang Rimba
11.01.15.2003|Ujong Pulo Rayeuk
11.01.15.2004|Sawah Tingkeum
11.01.15.2005|Simpang
11.01.15.2006|Ujong Pulo Cut
11.01.15.2008|Seuleukat
11.01.16.2005|Pinto Rimba
11.01.16.2006|Krueng Luas
11.01.16.2007|Jambo Dalem
11.01.16.2008|Kapa Sesak
11.01.16.2009|Seuneubok Punto
11.01.16.2010|Seuneubok Pusaka
11.01.16.2011|Alur Bujok
11.01.16.2012|Titi Poben
11.01.17.2001|Buket Gadeng
11.01.17.2002|Rambong
11.01.17.2003|Seuneubok Keuranji
11.01.17.2004|Seuneubok Alur Buloh
11.01.17.2005|Ujong Tanoh
11.01.17.2006|Ujong Gunong Cut
11.01.17.2007|Ujong Gunung Rayeuk
11.01.17.2008|Beutong
11.01.17.2009|Jambo Keupok
11.01.17.2010|Alurduamas
11.01.18.2001|Ladang Rimba
11.01.18.2002|Gunong Kapho
11.01.18.2003|Kampong Teungoh
11.01.18.2004|Krueng Batee
11.01.18.2005|Pulo Paya
11.01.18.2006|Jambo Papeun
11.01.18.2007|Cot Bayu
11.01.18.2008|Naca
11.01.18.2009|Ie Jeureuneh
11.01.18.2010|Lhok Raya
11.02.01.2001|Engkeran
11.02.01.2002|Rumah Kampung
11.02.01.2004|Pasir Bangun
11.02.01.2006|Kubu
11.02.01.2007|Lawe Kongker
11.02.01.2008|Kuta Cingkam II
11.02.01.2009|Muara Baru
11.02.01.2011|Kuta Batu I
11.02.01.2012|Kuta Cingkam I
11.02.01.2013|Kuta Batu II
11.02.01.2014|Lawe Sempilang
11.02.01.2015|Prapat Batu Nunggul
11.02.01.2016|Pulo Sepang
11.02.01.2017|Rih Mbelang
11.02.01.2018|Kute Batu Baru
11.02.01.2019|Darul Amin
11.02.01.2020|Lawe Lubang Indah
11.02.01.2021|Batu Hamparan
11.02.01.2022|Paye Munje
11.02.01.2023|Pulo Ndadap
11.02.01.2024|Pasir Nunggul
11.02.01.2025|Cingkham Mekhanggun
11.02.01.2026|Pintu Khimbe
11.02.01.2027|Lawe Kongker Hilir
11.02.01.2028|Pulo Gadung
11.02.01.2029|Pasikh Pehkmate
11.02.01.2030|Pasikh Nunang
11.02.01.2031|Deleng Kukusen
11.02.02.2001|Bukit Merdeka
11.02.02.2002|Darul Aman
11.02.02.2003|Lawe Kesumpat
11.02.02.2004|Lawe Tua Gabungan
11.02.02.2005|Lawe Sigala II
11.02.02.2006|Lawe Sigala Timur
11.02.02.2007|Lawe Sigala Barat
11.02.02.2008|Suka Damai
11.02.02.2009|Kute Tengah
11.02.02.2010|Tanah Baru
11.02.02.2011|Kedataran Gabungan
11.02.02.2012|Gabungan Parsaroan
11.02.02.2013|Lawe Loning Gabungan
11.02.02.2014|Lawe Loning Aman
11.02.02.2015|Suka Maju
11.02.02.2016|Lawe Tua Makmur
11.02.02.2017|Lawe Tua Persatuan
11.02.02.2018|Lawe Serke
11.02.02.2019|Lawe Rakat
11.02.02.2020|Suka Jaya
11.02.02.2021|Enmiya Batu Dua Ratus
11.02.02.2022|Sebungke
11.02.02.2023|Bukit Sepakat
11.02.02.2024|Lawe Loning Sepakat
11.02.02.2025|Lawe Loning I
11.02.02.2026|Gaya Jaya
11.02.02.2027|Gelah Musara
11.02.02.2028|Mulie Dame
11.02.02.2029|Lawe Loning Hakhapen
11.02.02.2030|Karya Indah
11.02.02.2031|Kayu Mbelin
11.02.02.2032|Lawe Sigala Barat Jaya
11.02.02.2033|Lawe Pekhidinen
11.02.02.2034|Kertimbang
11.02.02.2035|Ndauh Nitenggo
11.02.03.2001|Bambel Gabungan
11.02.03.2002|Kuta Buluh
11.02.03.2005|Lawe Hijo
11.02.03.2006|Pinding
11.02.03.2009|Terutung Megara Asli
11.02.03.2011|Biak Muli
11.02.03.2012|Kute Lang-Lang
11.02.03.2013|Pedesi
11.02.03.2014|Terutung Payung Hulu
11.02.03.2015|Terutung Payung Hilir
11.02.03.2016|Tualang Sembilar
11.02.03.2017|Kuning I
11.02.03.2018|Kuning II
11.02.03.2019|Cinta Damai
11.02.03.2020|Likat
11.02.03.2021|Rikit
11.02.03.2023|Bambel
11.02.03.2025|Lawe Kihing
11.02.03.2026|Terutung Seperai
11.02.03.2027|Kute Seri
11.02.03.2028|Kuta Antara
11.02.03.2029|Pulo Perengge
11.02.03.2031|Pulo Kendondong
11.02.03.2033|Pancakh Iman
11.02.03.2034|Biak Muli Baru
11.02.03.2035|Biak Muli Pantai Raja
11.02.03.2036|Biak Muli Sejahtera
11.02.03.2037|Lembah Haji
11.02.03.2038|Terutung Payung Gabungan
11.02.03.2039|Lawe Hijo Metuah
11.02.03.2040|Ampera
11.02.03.2041|Tembilakh Mbakhu
11.02.03.2042|Kute Lang-Lang Bakhu
11.02.04.2001|Kota Kutacane
11.02.04.2002|Perapat Hilir
11.02.04.2003|Perapat Hulu
11.02.04.2004|Muara Lawe Bulan
11.02.04.2005|Mbarung
11.02.04.2006|Batu Mbulan Asli
11.02.04.2007|Batu Mbulan I
11.02.04.2008|Batu Mbulan II
11.02.04.2009|Kampung Raja
11.02.04.2010|Pulonas
11.02.04.2011|Kampung Melayu Gabungan
11.02.04.2012|Terutung Pedi
11.02.04.2013|Kute Rih
11.02.04.2014|Gumpang Jaya
11.02.04.2015|Pulo Latong
11.02.04.2016|Kutacane Lama
11.02.04.2017|Batu Mbulan Mbaru
11.02.04.2018|Pulo Peding
11.02.04.2019|Mendabe
11.02.04.2020|Ujung Barat
11.02.04.2021|Pekhapat Titi Panjang
11.02.04.2022|Pekhapat Sepakat
11.02.04.2023|Alas Marancar
11.02.04.2024|Batu Mbulan Sepakat
11.02.04.2025|Pulo Sanggakh
11.02.04.2026|Melayu I
11.02.04.2027|Mbarung Datuk Saudane
11.02.05.2005|Salang Alas
11.02.05.2009|Kuta Pasir
11.02.05.2011|Purwodadi
11.02.05.2012|Kuta Tinggi
11.02.05.2013|Kampung Baru
11.02.05.2014|Peranginan
11.02.05.2015|Natam
11.02.05.2025|Kumbang Jaya
11.02.05.2026|Kumbang Indah
11.02.05.2027|Natam Baru
11.02.05.2029|Deleng Megakhe
11.02.05.2030|Lawe Bekung
11.02.05.2031|Lawe Bekung Tampahan
11.02.05.2032|Badar Indah
11.02.05.2033|Batu Mbekhong
11.02.05.2034|Tanah Merah
11.02.05.2035|Tanoh Megakhe
11.02.05.2036|Lawe Sekerah
11.02.06.2001|Pardomuan II
11.02.06.2002|Lawe Desky I
11.02.06.2003|Lawe Desky Sabas
11.02.06.2004|Pardomuan I
11.02.06.2005|Cinta Damai
11.02.06.2006|Lawe Perbunga
11.02.06.2007|Lawe Desky Tongah
11.02.06.2008|Kute Bakti
11.02.06.2010|Muara Situlen
11.02.06.2011|Sejahtera
11.02.06.2012|Kute Makmur
11.02.06.2013|Pardamean
11.02.06.2014|Lawe Mantik
11.02.06.2015|Cinta Makmur
11.02.06.2016|Muara Setia
11.02.06.2017|Tanoh Alas
11.02.06.2018|Sejahtera Baru
11.02.06.2024|Lawe Tawakh
11.02.06.2025|Sabilussalam
11.02.06.2026|Lawe Desky Jaya
11.02.06.2027|Pintu Alas
11.02.07.2001|Gulo
11.02.07.2002|Pulo Piku
11.02.07.2003|Terutung Kute
11.02.07.2004|Kute Ujung
11.02.07.2005|Lawe Stul
11.02.07.2006|Kite Merangun
11.02.07.2007|Mamas
11.02.07.2008|Tanjung Lama
11.02.07.2009|Tanjung Muda
11.02.07.2010|Rambung Teldak
11.02.07.2011|Tanjung Aman
11.02.07.2012|Sri Muda
11.02.07.2013|Ujung Baru
11.02.07.2014|Kute Rambe
11.02.07.2015|Mamas Baru
11.02.07.2016|Rambung Jaya
11.02.07.2017|Makmur Jaya
11.02.07.2018|Darul Makmur
11.02.07.2019|Tanjung Bakhu
11.02.07.2020|Pulo Gabung
11.02.07.2021|Kokhtan Jaya
11.02.07.2022|Istiqamah
11.02.07.2023|Lawe Mamas Indah
11.02.07.2024|Tanjung Leuser
11.02.07.2025|Simpang IV Tanjung
11.02.07.2026|Lawe Pinis
11.02.07.2027|Buntul Kendawi
11.02.07.2028|Kuning Abadi
11.02.08.2001|Pasir Gala
11.02.08.2002|Pasir Penjengakan
11.02.08.2003|Kutambaru
11.02.08.2004|Lawe Sagu Hulu
11.02.08.2005|Lawe Sagu Hilir
11.02.08.2006|Kute Bantil
11.02.08.2011|Lawe Kolok
11.02.08.2012|Lawe Rutung
11.02.08.2013|Kampung Nangka
11.02.08.2014|Tenembak Juhar
11.02.08.2015|Simpang Empat
11.02.08.2016|Kuta Buluh Botong
11.02.08.2017|Katambaru Becawan
11.02.08.2018|Lawe Kinge
11.02.08.2019|Kandang Mbelang Mandiri
11.02.08.2020|Mbacang Racun
11.02.08.2021|Telaga Mekar
11.02.08.2023|Pulonas Baru
11.02.08.2025|Kuta Genting
11.02.08.2026|Pangguh
11.02.08.2027|Lawe Sagu
11.02.08.2028|Pekhapet Timur
11.02.08.2029|Bahagia
11.02.08.2030|Kute Galuh Asli
11.02.09.2001|Kute Lengat Pangan
11.02.09.2002|Kute Lengat Selian
11.02.09.2003|Tualang Baru
11.02.09.2004|Alur Buluh
11.02.09.2005|Maha Singkil
11.02.09.2006|Tenembak Bintang
11.02.09.2007|Kute Lingga
11.02.09.2008|Rikit Bur
11.02.09.2010|Kerukunan
11.02.09.2011|Lawe Dua
11.02.09.2012|Rema
11.02.09.2013|Bambel Baru
11.02.09.2014|Pejuang
11.02.09.2015|Darussalam
11.02.09.2016|Amaliah
11.02.09.2017|Sebudi Jaya
11.02.09.2018|Gumpang
11.02.09.2019|Kute Gekhat
11.02.09.2020|Paye Khambung
11.02.09.2021|Mbak Sako
11.02.09.2022|Darul Imami
11.02.09.2023|Rikit Bur II
11.02.09.2024|Kute Empat Lima
11.02.10.2001|Simpang Semadam
11.02.10.2002|Semadam Awal
11.02.10.2003|Semadam Asal
11.02.10.2004|Lawe Kinga Gabungan
11.02.10.2005|Lawe Kinga Tebing Tinggi
11.02.10.2006|Kebun Sere
11.02.10.2007|Lawe Beringin Horas
11.02.10.2008|Lawe. Berigin Gayo
11.02.10.2009|Suka Makmur
11.02.10.2010|Pasar Puntung
11.02.10.2011|Titi Pasir
11.02.10.2012|Lawe Petanduk I
11.02.10.2013|Ngkeran Alur Buluh
11.02.10.2014|Kampung Baru
11.02.10.2015|Sepakat Segenap
11.02.10.2016|Selamat Indah
11.02.10.2017|Lawe Kinge Lapter
11.02.10.2018|Lawe Mejile
11.02.10.2019|Lawe Petanduk-II
11.02.11.2004|Titi Mas
11.02.11.2005|Meranti
11.02.11.2006|Kute Lang-Lang
11.02.11.2007|Lawe Sumur
11.02.11.2008|Pardamaian
11.02.11.2009|Salim Pipit
11.02.11.2010|Penguhapan
11.02.11.2011|Lumban Tua
11.02.11.2012|Mutiara Damai
11.02.11.2013|Dolok Nauli
11.02.11.2014|Tuhi Jongkat
11.02.11.2015|Uning Sigugur
11.02.11.2016|Lumban Sitio-tio
11.02.11.2017|Lawe Malum
11.02.11.2018|Alur Baning
11.02.11.2019|Lingga Alas
11.02.11.2020|Khambung Tumbung
11.02.11.2021|Tuah Mesade
11.02.11.2022|Sumukh Alas
11.02.11.2023|Alukh Bakhu
11.02.11.2024|Sepekhinding
11.02.11.2025|Tanoh Subukh
11.02.11.2026|Pinggan Mbelang
11.02.11.2027|Sigai Indah
11.02.11.2028|Ukekh Deleng
11.02.11.2029|Alas Mesikhat
11.02.11.2030|Titi Hakhapen
11.02.12.2001|Aunan Sepakat
11.02.12.2002|Lawe Penanggalan
11.02.12.2003|Lawe Mengkudu
11.02.12.2004|Jambur Lak-lak
11.02.12.2005|Simpang Tiga Jongar
11.02.12.2006|Jongar Asli
11.02.12.2007|Ketambe
11.02.12.2008|Rumah Bundar
11.02.12.2009|Penyeberangan Cingkam
11.02.12.2010|Deleng Damar
11.02.12.2011|Bintang Bener
11.02.12.2012|Suka Rimbun
11.02.12.2013|Lawe Aunan
11.02.12.2014|Bener Bepapah
11.02.12.2015|Penungkunen
11.02.12.2016|Datok Pining
11.02.12.2017|Kati Maju
11.02.12.2018|Leuser
11.02.12.2019|Jati Sara
11.02.12.2020|Bukit Mbakhu
11.02.12.2021|Kayu Metangur
11.02.12.2022|Lawe Sembekan
11.02.12.2023|Lawe Beringin
11.02.12.2024|Lawe Ger-Ger
11.02.12.2025|Simpur Jaya
11.02.13.2001|Salang Baru
11.02.13.2002|Ranto Dior
11.02.13.2003|Lembah Alas
11.02.13.2004|Tenembak Lang-Lang
11.02.13.2005|Salang Sigotom
11.02.13.2006|Tualang Lama
11.02.13.2007|Gusung Batu
11.02.13.2008|Kaya Pangur
11.02.13.2009|Sepakat
11.02.13.2010|Lawe Pangkat
11.02.13.2011|Bunga Melur
11.02.13.2012|Penampaan
11.02.13.2013|Terutung Mbelang
11.02.13.2014|Salang Muara
11.02.13.2015|Lawe Hakhum
11.02.13.2016|Tanoh Khukahen
11.02.13.2017|Tading Ni Ulihi
11.02.13.2018|Peseluk Pesimbe
11.02.13.2019|Kane Lot
11.02.13.2020|Muhajirin
11.02.13.2021|Beriring Naru
11.02.13.2022|Kati Jeroh
11.02.14.2001|Terutung Megara Lawe Pasaran
11.02.14.2002|Kisam Gabungan
11.02.14.2003|Kisam Kute Pasir
11.02.14.2004|Lawe Sumur
11.02.14.2005|Lawe Sumur Baru
11.02.14.2006|Kute Lesung
11.02.14.2007|Berandang
11.02.14.2008|Kute Bunin
11.02.14.2009|Buah Pala
11.02.14.2010|Panosan
11.02.14.2011|Lawe Pasaran Tengku Mbelin
11.02.14.2012|Terutung Megahke MBakhu
11.02.14.2013|Kisam Lestari
11.02.14.2014|Kisam Kute Rambe
11.02.14.2015|Lawe Polak
11.02.14.2016|Lawes Sumur Sepakat
11.02.14.2017|Setia Baru
11.02.14.2018|Teger Miko
11.02.15.2001|Salim Pinim I
11.02.15.2002|Jambur Damar
11.02.15.2003|Alur Langsat
11.02.15.2004|Rambah Sayang
11.02.15.2006|Rumah Luar
11.02.15.2007|Tenembak Alas
11.02.15.2008|Lawe Tungkal
11.02.15.2009|Salim Pinim II
11.02.15.2010|Jambukh Pekhmate
11.02.15.2011|Khutung Mbelang
11.02.15.2012|Timang Rasa
11.02.15.2013|Stambul Jaya
11.02.15.2014|Alur Nangke
11.02.15.2015|Kute Mejile
11.02.16.2001|Bintang Alga Musara
11.02.16.2002|Bintang Bukit Indah
11.02.16.2003|Tanjung Sari
11.02.16.2004|Bun-bun Alas
11.02.16.2005|Naga Timbul
11.02.16.2006|Gunung Pak-Pak
11.02.16.2007|Bukit Meriah
11.02.16.2008|Permata Musara
11.02.16.2009|Laut Tawar
11.02.16.2010|Kane Mende
11.02.16.2011|Lawe Sekhakut
11.02.16.2012|Bunbun Indah
11.02.16.2013|Suka Damai
11.02.16.2014|Tuah Kekhine
11.02.16.2015|Punce Nali
11.02.16.2016|Sade Ate
11.02.16.2017|Akhih Majile
11.02.16.2018|Ukhat Peseluk
11.02.16.2019|Tunas Mude
11.02.16.2020|Gaye Sendah
11.02.16.2021|Kute Hakhapen
11.02.16.2022|Kompas
11.02.16.2023|Sepakat
11.03.01.2001|Alue Luddin Sa
11.03.01.2002|Alue Luddin Dua
11.03.01.2003|Alue Dalam
11.03.01.2004|Dama Pulo Sa
11.03.01.2005|Dama Pulo Dua
11.03.01.2006|Buket Kulam
11.03.01.2007|Seuneubok Teungoh
11.03.01.2008|Jungka Gajah
11.03.01.2009|Seuneubok Simpang
11.03.01.2010|Matang Pineung
11.03.01.2011|Lhok Geulumpang
11.03.01.2012|Blang Buket
11.03.01.2013|Meunasah Keutapang
11.03.01.2014|Buket Rumia
11.03.01.2015|Alue Gadeng
11.03.01.2016|Kapai Baro
11.03.01.2017|Seuneubok Tuha Sa
11.03.01.2018|Seuneubok Tuha Dua
11.03.01.2019|Seuneubok Buloh
11.03.01.2020|Gaseh Sayang
11.03.01.2021|Alue Lhok
11.03.01.2022|Trieng Gadeng
11.03.01.2023|Grong-Grong
11.03.01.2024|Matang Geuto
11.03.01.2025|Alue Merbo
11.03.01.2026|Buket Raya
11.03.01.2027|Gampong Keude
11.03.01.2028|Peukan Idi Cut
11.03.01.2029|Gampong Beunot
11.03.01.2030|Seuneubok Baroh
11.03.01.2031|Teupin Drum
11.03.01.2032|Kuala Idi Cut
11.03.01.2034|Seuneubok Aceh
11.03.01.2035|Gampong Baro
11.03.01.2036|Bagok Panah Sa
11.03.01.2037|Bagok Panah Dua
11.03.01.2038|Bagok Panah Lhee
11.03.01.2039|Bagok Panah Peut
11.03.01.2040|Buket Tualang
11.03.01.2041|Keumuneng Sa
11.03.01.2042|Keumuneng Dua
11.03.01.2043|Keumuneng Lhee
11.03.01.2044|Keumuneng Peut
11.03.01.2045|Keumuneng Limong
11.03.01.2046|Meunasah Blang
11.03.02.2001|Blang Keumahang
11.03.02.2002|Blang Jambee
11.03.02.2003|Keumuneng
11.03.02.2004|Ladang Baro
11.03.02.2005|Buket Panyang
11.03.02.2006|Seuneubok Rambong
11.03.02.2007|Seuneubok Baro
11.03.02.2008|Blang Mideun
11.03.02.2009|Paya Bakong
11.03.02.2010|Teupin Raya
11.03.02.2011|Lhok Rambong
11.03.02.2012|Julok Tunong
11.03.02.2013|Ulee Ateung
11.03.02.2014|Ulee Blang
11.03.02.2015|Labuhan
11.03.02.2016|Naleung
11.03.02.2017|Mane Rampak
11.03.02.2018|Matang
11.03.02.2019|Blang Uyok
11.03.02.2020|Blang Pauh Sa
11.03.02.2021|Blang Pauh Dua
11.03.02.2022|Ulee Tanoh
11.03.02.2023|Keude Kuta Binjei
11.03.02.2024|Bukit Seroja
11.03.02.2025|Kuala Geulumpang
11.03.02.2026|Gampong Baro
11.03.02.2027|Tumpok Teungoh
11.03.02.2028|Seumatang
11.03.02.2029|Ujong Tunong
11.03.02.2030|Bukit Dindeng
11.03.02.2031|Paya Pasi
11.03.02.2032|Alue Cek Doi
11.03.02.2033|Blang Gleum
11.03.02.2034|Tanjong Tok Blang
11.03.02.2035|Buket Makmu
11.03.02.2036|Lhok Seuntang
11.03.02.2037|Simpang Lhee
11.03.03.2001|Gampong Jawa
11.03.03.2002|Keude Blang
11.03.03.2003|Tanoh Anoe
11.03.03.2004|Kuala Peudawa Puntong
11.03.03.2005|Gampong Aceh
11.03.03.2006|Kuta Blang
11.03.03.2007|Gampong Tanjong
11.03.03.2008|Blang Geulumpang
11.03.03.2009|Meunasah Pu'uk
11.03.03.2010|Bantayan Timu
11.03.03.2011|Keutapang Mameh
11.03.03.2012|Seuneubok Rambong
11.03.03.2013|Kuala Idi
11.03.03.2014|Keude Aceh
11.03.03.2023|Seuneubok Bacee
11.03.03.2029|Titi Baro
11.03.03.2047|Tanjong Kapai
11.03.03.2048|Alue Dua Muka O
11.03.03.2049|Alue Dua Muka S
11.03.03.2050|Ulee Blang
11.03.03.2051|Buket Jok
11.03.03.2052|Buket Meulinteung
11.03.03.2053|Gampong Jalan
11.03.03.2054|Teupin Batee
11.03.03.2055|Buket Langa
11.03.03.2056|Buket Pala
11.03.03.2057|Buket Juara
11.03.03.2058|Seuneubok Tutong
11.03.03.2059|Seuneubok Tuha
11.03.03.2060|Sampoimah
11.03.03.2061|Dama pulo
11.03.03.2062|Gureb Blang
11.03.03.2064|Gampong Baro
11.03.03.2065|SeuneubokTeungoh P.Puntong
11.03.03.2067|Kuta Lawah
11.03.04.2001|Jambo Labu
11.03.04.2002|Alue Canang
11.03.04.2003|Alue Drien
11.03.04.2004|Buket Tiga
11.03.04.2005|Benteng
11.03.04.2006|Afeling II Bukit
11.03.04.2007|Keumuneng Hulu
11.03.04.2008|Peutow
11.03.04.2009|Alue Buloh
11.03.04.2010|Alue Teh
11.03.04.2011|Paya Rambong
11.03.04.2012|Alue Gadeng SA
11.03.04.2013|Paya Tampah
11.03.04.2014|Paya Bili Dua
11.03.04.2015|Paya Bili Sa
11.03.04.2016|Paya Peulawi
11.03.04.2017|Keude Birem
11.03.04.2018|Bayeun
11.03.04.2019|Aramiyah
11.03.04.2020|Blang Tualang
11.03.04.2021|Buket Seuleumak
11.03.04.2022|Birem Rayeuk
11.03.04.2023|Alue Gadeng
11.03.04.2024|Alue Gadeng Dua
11.03.04.2025|Alue Sentang
11.03.04.2026|Merbou Dua
11.03.04.2027|Alue Nyamoek
11.03.05.2001|Lokop
11.03.05.2002|Terujak
11.03.05.2003|Tualang
11.03.05.2004|Leles
11.03.05.2005|Ujung Karang
11.03.05.2006|Nalon
11.03.05.2007|Jering
11.03.05.2008|Loot
11.03.05.2009|Seku Alan
11.03.05.2010|Sunti
11.03.05.2011|Umah Taring
11.03.05.2012|Bunin
11.03.05.2013|Sembuang
11.03.05.2014|Seuleumak
11.03.05.2015|Mesir
11.03.05.2016|Rampah
11.03.05.2022|Arul Durin
11.03.06.2001|Keude Bagok Sa
11.03.06.2002|Keude Bagok Dua
11.03.06.2003|Asan Tanjong
11.03.06.2004|Bantayan
11.03.06.2005|Matang Seuleumak
11.03.06.2006|Teupin Pukat
11.03.06.2007|Matang Neuheun
11.03.06.2008|Kuala Bagok
11.03.06.2009|Meunasah Teungoh
11.03.06.2010|Medang Ara
11.03.06.2011|Peulawi
11.03.06.2012|Baroh Bugeng
11.03.06.2013|Seumatang Aron
11.03.06.2014|Blang Panjou
11.03.06.2025|Pulo U
11.03.06.2026|Cot Asan
11.03.06.2027|Paya Enjee
11.03.06.2028|Seuleumak Muda
11.03.06.2029|Matang Panyang
11.03.06.2030|Meunasah Hagu
11.03.06.2031|Matang Kunyet
11.03.06.2032|Buket Panjou
11.03.06.2033|Buket Meurak
11.03.06.2034|Buket Panyang
11.03.06.2035|Seuneubok Dalam
11.03.06.2036|Gampong Mesjid
11.03.06.2037|Alue Siwah Serdang
11.03.06.2038|Gampong Lhee
11.03.06.2039|Beurandang
11.03.06.2040|Gampong Jalan
11.03.06.2041|Seuneubok Rambong
11.03.07.2001|Pasir Putih
11.03.07.2002|Tualang
11.03.07.2003|Keude Peureulak
11.03.07.2004|Leuge
11.03.07.2005|Uteun Dama
11.03.07.2006|Punti
11.03.07.2007|Alue Dua Paya Gajah
11.03.07.2008|Blang Bitra
11.03.07.2009|Kuala Bugak
11.03.07.2010|Paya Lipah
11.03.07.2011|Seumatang Muda Itam
11.03.07.2012|Lhok Dalam
11.03.07.2013|Beusa Meuranoe
11.03.07.2014|Bangka Rimung
11.03.07.2015|Tanoh Rata
11.03.07.2016|Bandrong
11.03.07.2017|Blang Balok
11.03.07.2018|Cot Muda Itam
11.03.07.2019|Keumuneng
11.03.07.2020|Kuala Leuge
11.03.07.2021|Balee Buya
11.03.07.2022|Alue Nibong
11.03.07.2023|Seuneubok Peusangan
11.03.07.2024|Seuneubok Aceh
11.03.07.2025|Seuneubok Pidie
11.03.07.2026|Dama Tutong
11.03.07.2027|Matang Gleum
11.03.07.2028|Lubok Pempeng
11.03.07.2029|Buket Pala
11.03.07.2030|Paya Kalui
11.03.07.2031|Cek Mbon
11.03.07.2032|Paya Meuligou
11.03.07.2033|Blang Simpo
11.03.07.2034|Blang Batee
11.03.07.2035|Matang Peulawi
11.03.07.2036|Cot Geulumpang
11.03.07.2037|Alue Rambong
11.03.07.2038|Cot Keh
11.03.08.2001|Bayeun
11.03.08.2002|Rantau Panjang
11.03.08.2003|Alue Raya
11.03.08.2004|Alue Kumba
11.03.08.2005|Seuneubok Dalam
11.03.08.2006|Alue Seuleumak
11.03.08.2007|Sarah Kayee
11.03.08.2008|Damar Siput
11.03.08.2009|Simpang Peut
11.03.08.2010|Simpang Aneuh
11.03.08.2011|Alue Punti
11.03.08.2012|Alue Kaul
11.03.08.2013|Sarah Teube
11.03.08.2014|Alue Tuwi
11.03.09.2001|Peulalu
11.03.09.2002|Nicah Awe
11.03.09.2003|Alue Buloh Sa
11.03.09.2004|Alue Buloh Dua
11.03.09.2005|Teupin Breuh
11.03.09.2006|Matang Rayeuk
11.03.09.2007|Matang Kumbang
11.03.09.2008|Blang Nie
11.03.09.2010|Bantayan
11.03.09.2011|Matang Weng
11.03.09.2012|Alue Mulieng
11.03.09.2013|Pucok Alue Dua
11.03.09.2014|Gampong Blang
11.03.09.2015|Keude Tuha
11.03.09.2016|Kuala Simpang Ulim
11.03.09.2017|Lampoh Rayeuk
11.03.09.2018|Teupin Mamplam
11.03.09.2019|Titi Baroh
11.03.09.2020|Pucok Alue Sa
11.03.09.2021|Pucok Alue Barat
11.03.09.2022|Arakundo
11.03.09.2023|Gampong Baro
11.03.09.2024|Matang Seupeng
11.03.10.2001|Paya Unou
11.03.10.2002|Seuneubok Johan
11.03.10.2003|Seuneubok Baro
11.03.10.2004|Pulo Blang
11.03.10.2005|Blang Barom
11.03.10.2006|Seuneubok Dalam
11.03.10.2007|Seuleumak Muda
11.03.10.2008|Bhom Lama
11.03.10.2009|Pasi Puteh
11.03.10.2010|Alue Dua
11.03.10.2011|Buket Pala
11.03.10.2012|Mata Ie
11.03.10.2013|Alue Udep
11.03.10.2014|Seumali
11.03.10.2015|Punti Payong
11.03.10.2016|Paya Palas
11.03.10.2017|Tampak
11.03.10.2018|Kliet
11.03.10.2019|Alue Geunteng
11.03.10.2020|Pertamina
11.03.10.2021|Alue Batee
11.03.10.2022|Beurandang
11.03.10.2024|Seumanah Jaya
11.03.11.2001|Blang Seunong
11.03.11.2002|Suka Damai
11.03.11.2003|Pante Labu
11.03.11.2004|Pante Rambong
11.03.11.2005|Alue Ie Mirah
11.03.11.2006|Seuneubok Tuha
11.03.11.2007|Seuneubok Saboh
11.03.11.2008|Buket Kareung
11.03.11.2009|Buket Bata
11.03.11.2010|Meunasah Tunong
11.03.11.2011|Meunasah Teungoh
11.03.11.2012|Keude Baro
11.03.11.2013|Matang Perlak
11.03.11.2014|Grong-grong
11.03.11.2015|Matang Kruet
11.03.11.2016|Meunasah Leubok
11.03.11.2017|Pante Panah
11.03.11.2018|Paya Demam Sa
11.03.11.2019|Paya Demam Dua
11.03.11.2020|Paya Demam Lhee
11.03.11.2021|Matang Pudeng
11.03.11.2022|Putoh Sa
11.03.11.2023|Putoh Dua
11.03.11.2024|Sah Raja
11.03.11.2025|Sijudo
11.03.12.2001|Madat
11.03.12.2002|Matang Keupula Sa
11.03.12.2003|Matang Keupula Dua
11.03.12.2004|Matang Keupula Lhee
11.03.12.2005|Ulee Ateung
11.03.12.2006|Blang Ubit
11.03.12.2007|Matang Guru
11.03.12.2008|Pantee Bayam
11.03.12.2009|Meunasah Asan
11.03.12.2010|Meunasah Tingkeum
11.03.12.2011|Lueng Dua
11.03.12.2012|Lueng Peut
11.03.12.2013|Paya Demam Peut
11.03.12.2014|Abeuk Geulanteu
11.03.12.2015|Rambong Lop
11.03.12.2016|Tanjong Ara
11.03.12.2017|Matang Jrok
11.03.12.2018|Paya Naden
11.03.12.2019|Tanjong Minjei
11.03.12.2020|Pante Merbo
11.03.12.2021|Blang Awe
11.03.12.2022|Bintah
11.03.12.2023|Seuneubok Pidie
11.03.12.2024|Blang Andam
11.03.12.2025|Matang Nibong
11.03.12.2026|Lueng Sa
11.03.13.2001|Seuneubok Bayu
11.03.13.2002|Alue Ie Itam
11.03.13.2003|Blang Nisan
11.03.13.2004|Bandar Baro
11.03.13.2005|Alue Patong
11.03.13.2006|Alue Ie Mirah
11.03.13.2007|Suka Makmur
11.03.13.2008|Jambo Balee
11.03.13.2009|Jambo Lubok
11.03.13.2010|Seuneubok Cina
11.03.13.2011|Pelita Sagop Jaya
11.03.13.2012|Perkebunan Julok Rayeuk Selatan
11.03.13.2013|Perkebunan Julok Rayeuk Utara
11.03.14.2001|Seuneubok Buloh
11.03.14.2002|Seuneubok Baro
11.03.14.2003|Seuneubok Meureudu
11.03.14.2004|Seuneubok Teupin Panah
11.03.14.2005|Teupin Panah
11.03.14.2006|Gampong Keumuneng
11.03.14.2007|Keude Keumuneng
11.03.14.2008|Keumuneng Lhok
11.03.14.2009|Paya Awee
11.03.14.2010|Paya Gaboh
11.03.14.2011|Padang Kasah
11.03.14.2012|Buket Teukuh
11.03.14.2013|Buket Pu'uk
11.03.14.2014|Blang Minjei
11.03.14.2015|Alue Kumbang A
11.03.14.2016|Alue Kumbang M
11.03.14.2017|Alue Lhok
11.03.14.2018|Seuneubok Buya
11.03.14.2019|Seuneubok Drien
11.03.14.2020|Bantayan Barat
11.03.14.2021|Blang Guci
11.03.14.2022|Buket Rumiya
11.03.14.2023|Seuneubok Punti
11.03.14.2024|Seuneubok Jalan
11.03.14.2025|Seuneubok Dalam
11.03.15.2001|Jalan Dua
11.03.15.2002|Jambo Reuhat
11.03.15.2003|Seuneubok Benteng
11.03.15.2004|Seuneubok Pango
11.03.15.2005|Seuneubok Simpang
11.03.15.2006|Seuneubok Kandang
11.03.15.2007|Ulee Jalan
11.03.15.2008|Uram Jalan
11.03.15.2009|Seuneubok Bayu
11.03.15.2010|Blang Rambong
11.03.15.2011|Buket Drien
11.03.15.2012|Panton Rayeuk A
11.03.15.2013|Panton Rayeuk B
11.03.15.2014|Panton Rayeuk M
11.03.15.2015|Panton Rayeuk T
11.03.15.2016|Paya Laman
11.03.16.2001|Gampong Keude
11.03.16.2002|Meunasah Krueng
11.03.16.2003|Kuta Baro
11.03.16.2004|Alue Batee
11.03.16.2005|Matang Rayeuk
11.03.16.2006|Paya Bili Dua
11.03.16.2007|Alue Ie Itam
11.03.16.2008|Asan Rampak
11.03.16.2009|Gampong Kuala
11.03.16.2010|Paya Dua
11.03.16.2011|Seuneubok Teungoh
11.03.16.2012|Buket Kuta
11.03.16.2013|Sama Dua
11.03.16.2014|Blang Kuta
11.03.16.2015|Blang Buket
11.03.16.2016|Seuneubok Peunteut
11.03.16.2017|Paya Bili Sa
11.03.17.2001|Babah Krueng
11.03.17.2002|Kruet Lintang
11.03.17.2003|Jengki
11.03.17.2004|Buket Meriam
11.03.17.2005|Alue Gureb
11.03.17.2006|Seuneubok Teupin
11.03.17.2007|Seuneubok Teungoh
11.03.17.2008|Alue Bugeng
11.03.17.2009|Seuneubok Punti
11.03.17.2010|Seumatang Keude
11.03.17.2011|Seuneubok Jalan
11.03.17.2012|Seuneubok Paya
11.03.17.2013|Alue Tho
11.03.17.2014|Seuneubok Rawang
11.03.17.2015|Alue Bu Alue Nireh
11.03.17.2016|Seuneubok Dalam
11.03.17.2017|Seuneubok Lapang
11.03.17.2018|Gelanggang Meurak
11.03.17.2019|Alue Bu Alue Lhok
11.03.17.2020|Tualang Pateng
11.03.18.2001|Beusa Seberang
11.03.18.2002|Mon Geudong
11.03.18.2003|Paya Seungat
11.03.18.2004|Teumpeun
11.03.18.2005|Alue Bu Tuha
11.03.18.2006|Alue Bu Jalan
11.03.18.2007|Tanjong Tualang
11.03.18.2008|Beringen
11.03.18.2009|Kebon Tempeun
11.03.18.2010|Paya Gajah
11.03.18.2011|Kabu
11.03.18.2012|Paya Biek
11.03.18.2013|Beusa Baroh
11.03.18.2014|Alue Bu Jalan Baroh
11.03.18.2015|Alue Bu Tunong
11.03.19.2001|Alue Rangan
11.03.19.2002|Geulumpang Payong
11.03.19.2003|Labuhan Keudee
11.03.19.2004|Buket Seulamat
11.03.19.2005|Buket Drien
11.03.19.2006|Alue Itam
11.03.19.2007|Paya Keutapang
11.03.19.2008|Gajah Mentah
11.03.19.2009|Seuneubok Pase
11.03.19.2010|Seuneubok Aceh
11.03.19.2011|Krueng Lingka
11.03.19.2012|Sungai Simpang
11.03.19.2013|Kuala Parek
11.03.20.2001|Simpang Jernih
11.03.20.2002|Batu Sumbang
11.03.20.2003|Pante Kera
11.03.20.2004|Rantau Panjang
11.03.20.2005|Melidi
11.03.20.2006|Tampur Paloh
11.03.20.2007|Tampur Boor
11.03.20.2008|HTI Rantau Naro
11.03.21.2001|Meudang Ara
11.03.21.2002|Gunong Putoh
11.03.21.2003|Meunasah Aroen
11.03.21.2004|Keude Dua
11.03.21.2005|Seuneubok Lapang
11.03.21.2006|Alue Jangat
11.03.21.2007|Buket Peulawi
11.03.21.2008|Lhok Panjoe
11.03.21.2009|Seuneubok Aceh Baro
11.03.21.2010|Pulo Blang
11.03.21.2011|Lhok Dalam
11.03.21.2012|Lhok Leumak
11.03.21.2013|Seuneubok Kulam
11.03.21.2014|Panton Meurebo
11.03.21.2015|Seuneubok Teungoh
11.03.21.2016|Lhok Meureu
11.03.22.2001|Tunong Bugeng
11.03.22.2002|Cempeudak
11.03.22.2003|Buket Tufah
11.03.22.2004|Tunong Ulee Gajah
11.03.22.2005|Keudondong
11.03.22.2006|Seuneubok Panton
11.03.22.2007|Buket Teumpeun
11.03.22.2008|Keude Blang
11.03.22.2009|Paya Kruep
11.03.22.2010|Tunong Paya Kruep
11.03.22.2011|Alue Siwah
11.03.23.2001|Keutapang Dua
11.03.23.2002|Matang Rayeuk PP
11.03.23.2003|Meunasah Jeumpa
11.03.23.2004|Lhok Asahan
11.03.23.2005|Tualang Dalam
11.03.23.2006|Seuneubok Kuyun
11.03.23.2007|Ulee Glee
11.03.23.2008|Seuneubok Barat
11.03.23.2009|Seuneubok Teungoh
11.03.23.2010|Seuneubok Timu
11.03.23.2011|Matang Bungong
11.03.23.2012|Matang Rayeuk SMK
11.03.23.2013|Seuneubok Dalam
11.03.24.2001|Arul Pinang
11.03.24.2002|Peunaron Baru
11.03.24.2003|Peunaron Lama
11.03.24.2004|Bukit Tiga
11.03.24.2006|Sri Mulya
11.04.01.2003|Delung Sekinel
11.04.01.2005|Gelampang Gading
11.04.01.2006|Gewat
11.04.01.2008|Jamat
11.04.01.2009|Kemerleng
11.04.01.2010|Kute Baru
11.04.01.2011|Kute Keramil
11.04.01.2012|Kute Rayang
11.04.01.2013|Kute Riyem
11.04.01.2014|Kute Robel
11.04.01.2015|Linge
11.04.01.2016|Lumut
11.04.01.2018|Mungkur
11.04.01.2019|Owaq
11.04.01.2020|Pantan Nangka
11.04.01.2021|Penarun
11.04.01.2022|Simpang Tige Uning
11.04.01.2023|Umang
11.04.01.2024|Despot Linge
11.04.01.2025|Gemboyah
11.04.01.2031|Arul Item
11.04.01.2032|Ise-Ise
11.04.01.2033|Kute Reje
11.04.01.2034|Reje Payung
11.04.01.2035|Pantan Reduk
11.04.01.2036|Antara
11.04.02.2001|Arul Gele
11.04.02.2002|Arul Kumer
11.04.02.2003|Burni Bius
11.04.02.2004|Genting Gerbang
11.04.02.2005|Gunung Singit
11.04.02.2007|Pepayungen Angkup
11.04.02.2008|Remesen
11.04.02.2009|Rutih
11.04.02.2010|Semelit Mutiara
11.04.02.2012|Wih Porak
11.04.02.2013|Wihni Bakong
11.04.02.2014|Wihni Durin
11.04.02.2016|Arul Putih
11.04.02.2017|Arul Relem
11.04.02.2018|Burni Bius Baru
11.04.02.2019|Jerata
11.04.02.2022|Paya Beke
11.04.02.2023|Paya Pelu
11.04.02.2026|Rebe Gedung
11.04.02.2027|Reremal
11.04.02.2029|Sanehen
11.04.02.2030|Simpang Kemili
11.04.02.2031|Tenebuk Kampung Baru
11.04.02.2032|Terang Engon
11.04.02.2033|Wih Pesam
11.04.02.2034|Bius Utama
11.04.02.2035|Mekar Indah
11.04.02.2036|Mulie Jadi
11.04.02.2037|Wih Bersih
11.04.02.2038|Wih Sagi Indah
11.04.02.2039|Arul Kumer Barat
11.04.02.2040|Arul Kumer Timur
11.04.02.2041|Arul Kumer Selatan
11.04.03.2001|Blang Kolak I
11.04.03.2002|Bebesan
11.04.03.2003|Mongal
11.04.03.2004|Daling
11.04.03.2005|Tensaran
11.04.03.2006|Lelabu
11.04.03.2007|Blang Gele
11.04.03.2008|Kemili
11.04.03.2009|Tan Saril
11.04.03.2010|Blang Kolak II
11.04.03.2011|Umang
11.04.03.2012|Simpang IV
11.04.03.2013|Bahgie
11.04.03.2014|Keramat Mupakat
11.04.03.2015|Atu Gajah Reje Guru
11.04.03.2016|Atu Tulu
11.04.03.2017|Burbiah
11.04.03.2018|Empus Talu
11.04.03.2019|Gele Lah
11.04.03.2020|Kebet
11.04.03.2021|Lemah Burbana
11.04.03.2022|Mah Bengi
11.04.03.2023|Nunang Antara
11.04.03.2024|Pendere Saril
11.04.03.2025|Sadong Juru Mudi
11.04.03.2026|Ulu Nuwih
11.04.03.2027|Colo Blang Gele
11.04.03.2028|Kala Kemili
11.04.07.2001|Arul Badak
11.04.07.2004|Berawang Baro
11.04.07.2008|Gelelungi
11.04.07.2009|Ie Relop
11.04.07.2010|Kayu Kul
11.04.07.2011|Kedelah
11.04.07.2012|Kung
11.04.07.2013|Kute Lintang
11.04.07.2014|Lelumu
11.04.07.2016|Paya Jeget
11.04.07.2017|Pedekok
11.04.07.2018|Pegasing
11.04.07.2019|Pepalang
11.04.07.2021|Simpang Kelaping
11.04.07.2024|Tebuk
11.04.07.2025|Terang Ulen
11.04.07.2026|Ujung Gele
11.04.07.2029|Wih Ilang
11.04.07.2030|Wih Nareh
11.04.07.2031|Wih Lah
11.04.07.2032|Jejem
11.04.07.2033|Jurusen
11.04.07.2034|Kala Pegasing
11.04.07.2035|Linung Ayu
11.04.07.2036|Panangan Mata
11.04.07.2037|Pantan Musara
11.04.07.2038|Wih Terjun
11.04.07.2039|Belang Bebangka
11.04.07.2040|Uning
11.04.07.2041|Uring
11.04.07.2042|Suka Damai
11.04.08.2001|Atu Payung
11.04.08.2002|Bale Nosar
11.04.08.2003|Bamil Nosar
11.04.08.2004|Bewang
11.04.08.2005|Dedamar
11.04.08.2006|Genuren
11.04.08.2007|Kala Bintang
11.04.08.2008|Kala Segi
11.04.08.2009|Kejurun Syiah Utama
11.04.08.2010|Kelitu Sintep
11.04.08.2011|Kuala I
11.04.08.2012|Kuala II
11.04.08.2013|Linung Bulen I
11.04.08.2014|Linung Bulen II
11.04.08.2015|Mengaya
11.04.08.2016|Mude Nosar
11.04.08.2017|Serule
11.04.08.2018|Wakil Jalil
11.04.08.2019|Wihlah Setie
11.04.08.2020|Gegarang
11.04.08.2021|Jamur Konyel
11.04.08.2022|Merodot
11.04.08.2023|Sintep
11.04.08.2024|Gele Pulo
11.04.10.2001|Bah
11.04.10.2002|Blang Mancung
11.04.10.2003|Bintang Pepara
11.04.10.2004|Burlah
11.04.10.2005|Buter
11.04.10.2006|Cang Duri
11.04.10.2007|Gelumpang Payung
11.04.10.2008|Jaluk
11.04.10.2009|Kala Ketol
11.04.10.2010|Karang Ampar
11.04.10.2011|Kekuyang
11.04.10.2012|Kute Gelime
11.04.10.2013|Pantan Penyo
11.04.10.2014|Pantan Reduk
11.04.10.2015|Pondok Balik
11.04.10.2016|Rejewali
11.04.10.2017|Serempah
11.04.10.2018|Bergang
11.04.10.2019|Blang Mancung Bawah
11.04.10.2020|Buge Ara
11.04.10.2021|Genting Bulen
11.04.10.2022|Jalan Tengah
11.04.10.2023|Jerata
11.04.10.2024|Simpang Juli
11.04.10.2025|Selon
11.04.11.2001|Bukit Sama
11.04.11.2002|Gunung Bukit
11.04.11.2003|Jongok Meluem
11.04.11.2004|Kelupak Mata
11.04.11.2005|Lot Kala
11.04.11.2006|Mendale
11.04.11.2007|Paya Reje Tami Delem
11.04.11.2008|Paya Tumpi
11.04.11.2009|Pinangan
11.04.11.2010|Bukit
11.04.11.2011|Bukit Ewih Tami Delem
11.04.11.2012|Gunung Bahgie
11.04.11.2013|Gunung Balohen
11.04.11.2014|Jongkok Bathin
11.04.11.2015|Kala Lengkio
11.04.11.2016|Kute Lot
11.04.11.2017|Paya Tumpi Baru
11.04.11.2018|Paya Tumpi I
11.04.11.2019|Timangan Gading
11.04.11.2020|Telege Atu
11.04.12.2001|Atu Gogop
11.04.12.2002|Balik
11.04.12.2003|Buter Balik
11.04.12.2004|Dedingin
11.04.12.2005|Kute Panang
11.04.12.2006|Lukub Sabun
11.04.12.2007|Pantan Sile
11.04.12.2008|Ratawali
11.04.12.2009|Segene Balik
11.04.12.2010|Tapak Moge
11.04.12.2011|Tawar Miko
11.04.12.2012|Tawardi
11.04.12.2013|Timang Rasa
11.04.12.2014|Wih Nongkal
11.04.12.2015|Bukit Rata
11.04.12.2016|Lukub Sabun Barat
11.04.12.2017|Lukub Sabun Tengah
11.04.12.2018|Lukub Sabun Timur
11.04.12.2019|Wih Nongkal Toa
11.04.12.2020|Tapak Moge Timur
11.04.12.2021|Empu Balik
11.04.12.2022|Blang Balik
11.04.12.2023|Kala Nongkal
11.04.12.2024|Pantan Jerik
11.04.13.2001|Arul Gading
11.04.13.2002|Belang Kekumur
11.04.13.2003|Berawang Gading
11.04.13.2004|Celala
11.04.13.2005|Cibro
11.04.13.2006|Kuyun
11.04.13.2007|Kuyun Toa
11.04.13.2008|Kuyun Uken
11.04.13.2009|Makmur
11.04.13.2010|Melala
11.04.13.2011|Paya Kolak
11.04.13.2012|Ramung Ara
11.04.13.2013|Sepakat
11.04.13.2014|Tanoh Depet
11.04.13.2015|Uning Berawang Ramung
11.04.13.2016|Blang Delem
11.04.13.2017|Depet Indah
11.04.17.2001|Takengon Timur
11.04.17.2002|Asir Asir
11.04.17.2003|Asir Asir Asia
11.04.17.2004|Bale Atu
11.04.17.2005|Bujang
11.04.17.2006|Gunung Suku
11.04.17.2007|Hakim Bale Bujang
11.04.17.2008|Kenawat
11.04.17.2009|Kuteni Reje
11.04.17.2010|Pedemun One One
11.04.17.2011|Rawe
11.04.17.2012|Takengon Barat
11.04.17.2013|Toweren Antara
11.04.17.2014|Toweren Toa
11.04.17.2015|Toweren Uken
11.04.17.2016|Teluk One-One
11.04.17.2017|Merah Mersa
11.04.17.2018|Waq Toweren
11.04.18.2001|Atu Lintang
11.04.18.2002|Merah Mege
11.04.18.2003|Merah Pupuk
11.04.18.2004|Merah Muyang
11.04.18.2005|Gayo Murni
11.04.18.2006|Kepala Akal
11.04.18.2007|Tanoh Abu
11.04.18.2008|Bintang Kekelip
11.04.18.2009|Merah Jernang
11.04.18.2010|Damar Mulyo
11.04.18.2011|Pantan Damar
11.04.19.2001|Merah Said
11.04.19.2002|Berawang Dewal
11.04.19.2003|Gegarang
11.04.19.2004|Telege Sari
11.04.19.2005|Jeget Ayu
11.04.19.2006|Paya Tungel
11.04.19.2007|Jagong Jeget
11.04.19.2008|Bukit Sari
11.04.19.2009|Bukit Kemuning
11.04.19.2010|Paya Dedep
11.04.20.2001|Bies Penentanan
11.04.20.2002|Bies Baru
11.04.20.2003|Bies Mulie
11.04.20.2004|Arul Latong
11.04.20.2005|Simpang Lukup Badak
11.04.20.2006|Atang Jungket
11.04.20.2007|Tebes Lues
11.04.20.2008|Pucuk Deku
11.04.20.2009|Lenga
11.04.20.2010|Uning Pegantungen
11.04.20.2011|Simpang Uning Niken
11.04.20.2012|Karang Bayur
11.04.21.2001|Pantan Tengah
11.04.21.2002|Rusip
11.04.21.2003|Pilar
11.04.21.2004|Arul Pertik
11.04.21.2005|Pilar Jaya
11.04.21.2006|Tirmi Ara
11.04.21.2007|Atu Singkih
11.04.21.2008|Pantan Bener
11.04.21.2009|Kerawang
11.04.21.2010|Mekar Maju
11.04.21.2011|Paya Tampu
11.04.21.2012|Tanjung
11.04.21.2013|Merandeh Paya
11.04.21.2014|Kuala Rawa
11.04.21.2015|Pilar Wih Kiri
11.04.21.2016|Lut Jaya
11.05.01.2001|Suak Indrapuri
11.05.01.2002|Kampung Belakang
11.05.01.2003|Ujong Kalak
11.05.01.2004|Kuta Padang
11.05.01.2005|Ujong Baroh
11.05.01.2006|Rundeng
11.05.01.2007|Drien Rampak
11.05.01.2008|Pasir
11.05.01.2009|Pasar Aceh
11.05.01.2010|Padang Seurahet
11.05.01.2011|Panggong
11.05.01.2012|Seuneubok
11.05.01.2013|Gampong Darat
11.05.01.2014|Gampa
11.05.01.2015|Lapang
11.05.01.2016|Blang Beurandang
11.05.01.2017|Suak Ribee
11.05.01.2018|Suak Raya
11.05.01.2019|Suak Nie
11.05.01.2020|Leuhan
11.05.01.2021|Suak Sigadeng
11.05.02.2001|Keude Aron
11.05.02.2002|Kampong Mesjid
11.05.02.2003|Padang Mancang
11.05.02.2004|Meunasah Buloh
11.05.02.2005|Alue Tampak
11.05.02.2006|Beureugang
11.05.02.2007|Marek
11.05.02.2008|Pasi Jambu
11.05.02.2009|Meunasah Ara
11.05.02.2010|Meunasah Rayeuk
11.05.02.2011|Simpang
11.05.02.2012|Peunia
11.05.02.2013|Tumpok Ladang
11.05.02.2014|Pasi Teungoh
11.05.02.2015|Putim
11.05.02.2016|Meunasah Rambot
11.05.02.2017|Pasi Jeumpa
11.05.02.2018|Palimbungan
11.05.02.2019|Muko
11.05.02.2020|Meunasah Gantung
11.05.02.2021|Blang Geunang
11.05.02.2022|Puuk
11.05.02.2023|Tanjong Bungong
11.05.02.2024|Alue On
11.05.02.2036|Tanjong Meulaboh
11.05.02.2037|Keude Tanjong
11.05.02.2038|Pungkie
11.05.02.2039|Pucok Pungkie
11.05.02.2040|Teladan
11.05.02.2041|Pasi Ara
11.05.02.2042|Meunuang Tanjong
11.05.02.2043|Alue Lhee
11.05.02.2044|Blang Dalam
11.05.02.2045|Teupin Panah
11.05.02.2046|Drien Caleue
11.05.02.2047|Alue Peudeung
11.05.02.2048|Pasi Meugat
11.05.02.2049|Babah Meulaboh
11.05.02.2050|Pasi Kumbang
11.05.02.2051|Padang Sikabu
11.05.02.2052|Sawang Teubei
11.05.02.2053|Alue Lhok
11.05.02.2062|Batu Jaya
11.05.02.2063|Keuramat
11.05.03.2001|Tungkop
11.05.03.2002|Sakuy
11.05.03.2003|Kajeung
11.05.03.2004|Geudong
11.05.03.2005|Sarah Perlak
11.05.03.2006|Tutut
11.05.03.2007|Drien Sibak
11.05.03.2008|Tuwi Saya
11.05.03.2009|Lancong
11.05.03.2010|Sipot
11.05.03.2011|Pungkie
11.05.03.2012|Gunong Buloh
11.05.03.2013|Ramitie
11.05.03.2014|Lubok Beutong
11.05.03.2015|Gleng
11.05.03.2016|Tanoh Mirah
11.05.03.2017|Gaseu
11.05.03.2018|Lueng Baro
11.05.04.2001|Kuala Bhee
11.05.04.2002|Pasi Lunak
11.05.04.2003|Pasi Aceh
11.05.04.2004|Aron Tunong
11.05.04.2005|Aron Baroh
11.05.04.2006|Pasi Pandan
11.05.04.2007|Ranto Panyang
11.05.04.2008|Geumpa Raya
11.05.04.2009|Padang Jawa
11.05.04.2010|Ie Itam Tunong
11.05.04.2011|Ie Itam Baroh
11.05.04.2012|Tingkeum Panyang
11.05.04.2013|Lueng Teungku Yah
11.05.04.2014|Lueng Tanoh Tho
11.05.04.2015|Gunong Rambong
11.05.04.2016|Drien Mangko
11.05.04.2017|Gunong Hampa
11.05.04.2018|Lueng Jawa
11.05.04.2019|Blang Mee
11.05.04.2020|Alue Blang
11.05.04.2021|Paya Dua
11.05.04.2022|Paya Luah
11.05.04.2023|Pasi Ara
11.05.04.2024|Alue Sikaya
11.05.04.2025|Darul Huda
11.05.04.2026|Keuleumbah
11.05.04.2027|Jawa
11.05.04.2028|Pulo Ie
11.05.04.2029|Alue Panyang
11.05.04.2030|Cot Keumude
11.05.04.2031|Seumantok
11.05.04.2032|Cot Situah
11.05.04.2033|Jawi
11.05.04.2034|Panton
11.05.04.2035|Pasi Birah
11.05.04.2036|Alue Sundak
11.05.04.2037|Teumarom
11.05.04.2038|Cot Murong
11.05.04.2039|Glee Siblah
11.05.04.2040|Suak Trieng
11.05.04.2041|Cot Lagan Bubon
11.05.04.2042|Bakat
11.05.04.2043|Lueng Buloh
11.05.05.2001|Alue Raya
11.05.05.2002|Cot Darat
11.05.05.2003|Cot Pluh
11.05.05.2004|Cot Seumeureung
11.05.05.2005|Cot Mesjid
11.05.05.2006|Cot Lampise
11.05.05.2007|Cot Seulamat
11.05.05.2008|Cot Amun
11.05.05.2009|Deuah
11.05.05.2010|Gampong Teungoh
11.05.05.2011|Gampong Ladang
11.05.05.2012|Gampong Cot
11.05.05.2013|Keureuseng
11.05.05.2014|Krueng Tinggai
11.05.05.2015|Kuala Bubon
11.05.05.2016|Leubok
11.05.05.2017|Lhok Bubon
11.05.05.2018|Leukeun
11.05.05.2019|Mesjid baro
11.05.05.2020|Paya Lumpat
11.05.05.2021|Pinem
11.05.05.2022|Pange
11.05.05.2023|Pucok Lueng
11.05.05.2024|Rangkileh
11.05.05.2025|Reusak
11.05.05.2026|Suak Pandan
11.05.05.2027|Suak Seuke
11.05.05.2028|Suak Pante Breuh
11.05.05.2029|Suak Geudeubang
11.05.05.2030|Suak Seumaseh
11.05.05.2031|Suak Timah
11.05.05.2032|Ujong Nga
11.05.06.2001|Alue Lhok
11.05.06.2002|Alue Bakong
11.05.06.2003|Beurawang
11.05.06.2004|Blang Sibeutong
11.05.06.2005|Cot Keumuneng
11.05.06.2006|Cot Lada
11.05.06.2007|Gunong Panah
11.05.06.2008|Kuta Padang
11.05.06.2009|Kuala Pling
11.05.06.2010|Layung
11.05.06.2011|Liceh
11.05.06.2012|Peulanteu SP
11.05.06.2013|Rambong
11.05.06.2014|Seumuleng
11.05.06.2015|Suak Pangkat
11.05.06.2016|Seuneubok Trap
11.05.06.2017|Ulee Blang
11.05.07.2001|Arongan
11.05.07.2002|Alue Bagok
11.05.07.2003|Alue Sundak
11.05.07.2004|Alue Batee
11.05.07.2005|Cot Buloh
11.05.07.2006|Cot Kumbang
11.05.07.2007|Cot Juru Mudi
11.05.07.2008|Drien Rampak
11.05.07.2009|Kubu
11.05.07.2010|Keub
11.05.07.2011|Pante Mutia
11.05.07.2012|Peuribu
11.05.07.2013|Panton Makmu
11.05.07.2014|Panton Bahagia
11.05.07.2015|Peulanteu LB
11.05.07.2016|Rimba Langgeh
11.05.07.2017|Suak Keumudee
11.05.07.2018|Seuneubok Lhong
11.05.07.2019|Suak Ie Beuso
11.05.07.2020|Suak Bidok
11.05.07.2021|Simpang peut
11.05.07.2022|Seuneubok Teungoh
11.05.07.2023|Teupin Peraho
11.05.07.2024|Ujong Beusa
11.05.07.2025|Ujong Simpang
11.05.07.2026|Gunong Pulo
11.05.07.2027|Karang Hampa
11.05.08.2001|Seumara
11.05.08.2002|Babah Lueng
11.05.08.2003|Babah Iseung
11.05.08.2004|Seumantok
11.05.08.2005|Alue Keumang
11.05.08.2006|Meunuang Kinco
11.05.08.2007|Lango
11.05.08.2008|Sikundo
11.05.08.2009|Lawet
11.05.08.2010|Canggai
11.05.08.2011|Manjeng
11.05.08.2012|Keutambang
11.05.08.2013|Pante Ceuremen
11.05.08.2014|Pulo Teungoh Manjeng
11.05.08.2015|Jambak
11.05.08.2016|Tegal Sari
11.05.08.2017|Gunong Tarok
11.05.08.2018|Suak Awe
11.05.08.2019|Kreung Beukah
11.05.08.2020|Lhok Sari
11.05.08.2021|Babah Krueng Tep Lep
11.05.08.2022|Berdikari
11.05.08.2023|Lhok Guci
11.05.08.2024|Keude Suak Awe
11.05.08.2025|Sawang Rambot
11.05.09.2001|Ranto Panyang Barat
11.05.09.2002|Ranto Panyang Timur
11.05.09.2003|Mesjid Tuha
11.05.09.2004|Ujong Tanoh Darat
11.05.09.2005|Pasi Aceh Tunong
11.05.09.2006|Pasi Aceh Baroh
11.05.09.2007|Buloh
11.05.09.2008|Pulo Teungoh
11.05.09.2009|Paya Baro Ranto P
11.05.09.2010|Ranub Dong
11.05.09.2011|Pasi Pinang
11.05.09.2012|Pasi Mesjid
11.05.09.2013|Meureubo
11.05.09.2014|Langung
11.05.09.2015|Gunong Kleng
11.05.09.2016|Ujong Drien
11.05.09.2017|Peunaga Rayeuk
11.05.09.2018|Peunaga Pasi
11.05.09.2019|Peunaga Cut Ujong
11.05.09.2020|Reudeup
11.05.09.2021|Balee
11.05.09.2022|Paya Peunaga
11.05.09.2023|Ujong Tanjong
11.05.09.2024|Pucok Reudeup
11.05.09.2025|Sumber Batu
11.05.09.2026|Bukit Jaya
11.05.10.2001|Blang Luah LM
11.05.10.2002|Cot Rambong
11.05.10.2003|Lhok Malee
11.05.10.2004|Pasi Malee
11.05.10.2005|Napai
11.05.10.2006|Blang Cot Mameh
11.05.10.2007|Blang Cot Rubek
11.05.10.2008|Alue Leuhob
11.05.10.2009|Leubok Pasi Ara
11.05.10.2010|Ulee Pasi Ara
11.05.10.2011|Cot Lagan LM
11.05.10.2012|Lueng Baro
11.05.10.2013|Kulam Kaju
11.05.10.2014|Alue Perman
11.05.10.2015|Peuleukueng
11.05.10.2016|Pasi Jeut
11.05.10.2017|Mon Pasong
11.05.10.2018|Pasi Mali
11.05.10.2019|Karak
11.05.10.2020|Ie Sayang
11.05.10.2021|Ulee Pulo
11.05.10.2022|Pasi Panyang
11.05.10.2023|Alue Keumuning
11.05.10.2024|Simpang Teumarom
11.05.11.2001|Seuradeuk
11.05.11.2002|Lubuk Panyang
11.05.11.2003|Paya Baro
11.05.11.2004|Kubu Capang
11.05.11.2005|Pasi Ara WT
11.05.11.2006|Gampong Baro WT
11.05.11.2007|Rambong
11.05.11.2008|Cot Punti
11.05.11.2009|Alue Eumpeuk
11.05.11.2010|Alue Bilie
11.05.11.2011|Pasi Janeng
11.05.11.2012|Tangkeh
11.05.11.2013|Alue Kuyun
11.05.11.2014|Bukit Meugajah
11.05.11.2015|Blang Dalam
11.05.11.2016|Teumiket Ranom
11.05.11.2017|Blang Makmue
11.05.11.2018|Gampong Baro KB
11.05.11.2019|Alue Meuganda
11.05.11.2020|Alue Seuralen
11.05.11.2021|Rambong Pinto
11.05.11.2022|Tuwi Eumpeuk
11.05.11.2023|Blang Luah KB
11.05.11.2024|Seuneubok Dalam
11.05.11.2025|Paya Meugendrang
11.05.11.2026|Gunong Panyang
11.05.12.2001|Meutulang
11.05.12.2002|Mugo Cut
11.05.12.2003|Mugo Rayeuk
11.05.12.2004|Baro Paya
11.05.12.2005|Sibintang
11.05.12.2006|Blang Teungoh
11.05.12.2007|Antong
11.05.12.2008|Ujong Raja
11.05.12.2009|Paya Baro Meuko
11.05.12.2010|Tuwi Buya
11.05.12.2011|Kuala Manyeu
11.05.12.2012|Manggie
11.05.12.2013|Gampong Baro
11.05.12.2014|Tamping
11.05.12.2015|Cot Manggie
11.05.12.2016|Blang Balee
11.05.12.2017|Babah Krueng Manggie
11.05.12.2018|Gunong Mata Ie
11.05.12.2019|Lek-Lek
11.06.01.2001|Meunasah Krueng Kala
11.06.01.2002|Jantang
11.06.01.2003|Baroh Krueng Kala
11.06.01.2004|Tunong Krueng Kala
11.06.01.2005|Sungko Mulat
11.06.01.2006|Birek
11.06.01.2007|Kareung
11.06.01.2008|Paroy
11.06.01.2009|Teungoh Blang Mee
11.06.01.2010|Lamkuta Blang Mee
11.06.01.2011|Baroh Blang Mee
11.06.01.2012|Umong Seuribee
11.06.01.2013|Teungoh Geunteut
11.06.01.2014|Baroh Geunteut
11.06.01.2015|Lam Juhang
11.06.01.2016|Utamong
11.06.01.2017|Gapuy
11.06.01.2018|Lamsujen
11.06.01.2019|Mon Mata
11.06.01.2020|Lamgeuriheu
11.06.01.2021|Keutapang
11.06.01.2022|Saney
11.06.01.2023|Cundien
11.06.01.2024|Glee Bruek
11.06.01.2025|Pasi
11.06.01.2026|Pudeng
11.06.01.2027|Meunasah Cot
11.06.01.2028|Meunasah Lhok
11.06.02.2001|Mon Ikeun
11.06.02.2002|Nusa
11.06.02.2003|Weu Raya
11.06.02.2004|Lamkrut
11.06.02.2005|Lamgaboh
11.06.02.2006|Lambaro Kueh
11.06.02.2007|Lam Ateuk
11.06.02.2008|Kueh
11.06.02.2009|Tanjong
11.06.02.2010|Aneuk Paya
11.06.02.2011|Seubun Keutapang
11.06.02.2012|Seubun Ayon
11.06.02.2013|Lambaro Seubun
11.06.02.2014|Naga Umbang
11.06.02.2015|Lampaya
11.06.02.2016|Meunasah Mesjid Lamlhom
11.06.02.2017|Meunasah Mon Cut
11.06.02.2018|Meunasah Manyang
11.06.02.2019|Meunasah Lam Girek
11.06.02.2020|Meunasah Lambaro
11.06.02.2021|Meunasah Baro Lamlhom
11.06.02.2022|Meunasah Beutong
11.06.02.2023|Mns. Mesjid Lampuuk
11.06.02.2024|Meunasah Balee
11.06.02.2025|Meunasah Karieng
11.06.02.2026|Lamcok
11.06.02.2027|Meunasah Cut
11.06.02.2028|Meunasah Blang
11.06.03.2001|Reukih Dayah
11.06.03.2002|Indrapuri
11.06.03.2003|Lam Leubok
11.06.03.2004|Empee Ara
11.06.03.2005|Limo Blang
11.06.03.2006|Limo Mesjid
11.06.03.2007|Limo Lamleuweung
11.06.03.2008|Lheue
11.06.03.2009|Meusale
11.06.03.2010|Cureh
11.06.03.2011|Cot Kareung
11.06.03.2012|Lamlung
11.06.03.2013|Meureu Ulee Titie
11.06.03.2014|Meureu Bueng-U
11.06.03.2015|Mureu Baro
11.06.03.2016|Meureu Lamglumpang
11.06.03.2017|Pasar Indrapuri
11.06.03.2018|Manggra
11.06.03.2019|Reukih Kupula
11.06.03.2020|Lam Ilie Mesjid
11.06.03.2021|Lam Ilie Tengoh
11.06.03.2022|Lam Ilie Ganto
11.06.03.2023|Meunara
11.06.03.2024|Aneuk Glee
11.06.03.2025|Krueng Lamkareung
11.06.03.2026|Sinyeu
11.06.03.2027|Seureumo
11.06.03.2028|Ulee Kareung
11.06.03.2029|Lambeutong
11.06.03.2030|Lampupok Baro
11.06.03.2031|Lampupok Raya
11.06.03.2032|Seulangai
11.06.03.2033|Riting
11.06.03.2034|Sihom Lhok
11.06.03.2035|Sihom Cot
11.06.03.2036|Seuot Baroh
11.06.03.2037|Seuot Tunong
11.06.03.2038|Lampanah Ranjo
11.06.03.2039|Lampanah Teungoh
11.06.03.2040|Lampanah Dayah
11.06.03.2041|Lampanah Baro
11.06.03.2042|Lampanah Tunong
11.06.03.2043|Groet Blang
11.06.03.2044|Groet Manyang
11.06.03.2045|Groet Baro
11.06.03.2046|Jruek Bak Kreh
11.06.03.2047|Jruek Balee
11.06.03.2049|Mon Alue
11.06.03.2050|Lambeunot
11.06.03.2051|Ulee Ue
11.06.03.2052|Lamsiot
11.06.03.2053|Lingom
11.06.04.2001|Peukan Seulimeum
11.06.04.2002|Keunaloi
11.06.04.2003|Lhieb
11.06.04.2004|Alue Gintong
11.06.04.2005|Gampong Seulimeum
11.06.04.2006|Data Gaseu
11.06.04.2007|Rabo
11.06.04.2008|Gampong Raya
11.06.04.2009|Lamjruen
11.06.04.2010|Buga
11.06.04.2011|Jawie
11.06.04.2012|Alue Rindang
11.06.04.2013|Iboh Tunong
11.06.04.2014|Iboh Tanjong
11.06.04.2015|Seuneubok
11.06.04.2016|Meunasah Baro
11.06.04.2017|Meunasah Tunong
11.06.04.2018|Batee Lhee
11.06.04.2019|Mangeu
11.06.04.2020|Bayu
11.06.04.2021|Ayon
11.06.04.2022|Lamteuba Droe
11.06.04.2023|Pulo
11.06.04.2024|Lampantee
11.06.04.2025|Lambada
11.06.04.2026|Blang Tingkeum
11.06.04.2027|Ateuk
11.06.04.2028|Lam Apeng
11.06.04.2029|Meurah
11.06.04.2030|Lampanah
11.06.04.2031|Ujong Mesjid Lampanah
11.06.04.2032|Ujong Keupula
11.06.04.2033|Leungah
11.06.04.2034|Beureunut
11.06.04.2035|Meunasah Jeumpa
11.06.04.2036|Pinto Khop
11.06.04.2037|Bak Seutui
11.06.04.2038|Bak Aghu
11.06.04.2039|Kayee Adang
11.06.04.2040|Lamkuk
11.06.04.2041|Ujong Mesjid Tanoh Abee
11.06.04.2042|Lamcarak
11.06.04.2043|Capeung Dayah
11.06.04.2044|Capeung Baroh
11.06.04.2045|Lampisang Dayah
11.06.04.2046|Lampisang Tunong
11.06.04.2047|Lampisang Teungoh
11.06.05.2001|Mata Ie
11.06.05.2002|Gampong Baroh
11.06.05.2003|Lampaseh Lhok
11.06.05.2004|Lampaseh Krueng
11.06.05.2005|Lamnga
11.06.05.2006|Dayah Daboh
11.06.05.2007|Weu Lhok
11.06.05.2008|Alue
11.06.05.2009|Weu Krueng
11.06.05.2010|Seubam Cot
11.06.05.2011|Bak Dilip
11.06.05.2012|Ulee Lhat
11.06.05.2015|Lamraya
11.06.05.2016|Lamme Garot
11.06.05.2017|Weu Bada
11.06.05.2018|Meunasah Tutong
11.06.05.2019|Empee Tanong
11.06.05.2020|Bak Cirih
11.06.05.2021|Warabo
11.06.05.2022|Teubang Phui Mesjid
11.06.05.2023|Teubang Phui Baro
11.06.05.2024|Bira Cot
11.06.05.2025|Bira Lhok
11.06.05.2026|Bung Tujoh
11.06.05.2027|Peurumping
11.06.05.2028|Atong
11.06.05.2029|Reudeup
11.06.05.2042|Seubam Lhok
11.06.05.2043|Seumet
11.06.05.2044|Cot Seunong
11.06.05.2045|Mon Ara
11.06.05.2046|Cot Lhok
11.06.05.2047|Cot Lampoh Soh
11.06.05.2048|Bueng Raya
11.06.05.2049|Piyeung Lhang
11.06.05.2050|Piyeung Manee
11.06.05.2051|Bueng Daroh
11.06.05.2052|Kuweu
11.06.05.2053|Piyeung Datu
11.06.06.2001|Reuhat Tuha
11.06.06.2002|Weusiteh
11.06.06.2003|Dilib Lamteungoh
11.06.06.2004|Baet Lampuot
11.06.06.2005|Dilib Bukit
11.06.06.2006|Seumeureung
11.06.06.2007|Sibreh Keumudee
11.06.06.2008|Baet Mesago
11.06.06.2009|Baet Mesjid
11.06.06.2010|Lambaro Sibreh
11.06.06.2011|Lamgeu Baro
11.06.06.2012|Lamgeu Tuha
11.06.06.2013|Lampanah Ineu
11.06.06.2014|Tampok Jeurat Raya
11.06.06.2015|Tampok Blang
11.06.06.2016|Lamteh Dayah
11.06.06.2017|Lam Lheu
11.06.06.2018|Lambarih Jurong Raya
11.06.06.2019|Bukloh
11.06.06.2020|Niron
11.06.06.2021|Aneuk Galong Baro
11.06.06.2022|Aneuk Galong Titi
11.06.06.2023|Blang Cut
11.06.06.2024|Klieng Mayang
11.06.06.2025|Aneuk Batee
11.06.06.2026|Meunasah Tuha
11.06.06.2027|Lampisang
11.06.06.2028|Meunasah Bakthu
11.06.06.2029|Lambarih Bak Mee
11.06.06.2030|Luthu Dayah Krueng
11.06.06.2031|Luthu Lamweu
11.06.06.2032|Panterawa
11.06.06.2033|Lambirah
11.06.06.2034|Kayee Adang
11.06.06.2035|Lam Tanjong
11.06.07.2001|Lampeuneurut Ujong Blang
11.06.07.2002|Lampeuneurut Gampong
11.06.07.2003|Lamreung
11.06.07.2004|Lamcot
11.06.07.2005|Lam Blang Trieng
11.06.07.2006|Lam Blang Mayang
11.06.07.2007|Bayu
11.06.07.2008|Lagang
11.06.07.2009|Lamsiteh
11.06.07.2010|Lamkawe
11.06.07.2011|Lheu Blang
11.06.07.2012|Payaroh
11.06.07.2013|Lamsidaya
11.06.07.2014|Kuta Karang
11.06.07.2015|Leu Geu
11.06.07.2016|Lampeuneun
11.06.07.2017|Lamtheun
11.06.07.2018|Deunong
11.06.07.2019|Tingkuem
11.06.07.2020|Kandang
11.06.07.2021|Lam Bheu
11.06.07.2022|Daroy Kameu
11.06.07.2023|Geundrieng
11.06.07.2024|Garot
11.06.07.2025|Pasheu Beutong
11.06.07.2026|Lampasi Engking
11.06.07.2027|Jeumpet Ajun
11.06.07.2028|Gue Gajah
11.06.07.2029|Leu Ue
11.06.07.2030|Ulee Lueng
11.06.07.2031|Punie
11.06.07.2032|Ulee Tuy
11.06.08.2001|Lambadeuk
11.06.08.2002|Lamguron
11.06.08.2003|Lambaro Nejid
11.06.08.2004|Lampageu
11.06.08.2005|Gampong Baro
11.06.08.2006|Lam Manyang
11.06.08.2007|Lamteh
11.06.08.2008|Lam Lumpu
11.06.08.2009|Lamteungoh
11.06.08.2010|Lamtutui
11.06.08.2011|Meunasah Tuha
11.06.08.2012|Lam Awe
11.06.08.2013|Pulo Bunta
11.06.08.2014|Beuradeun
11.06.08.2015|Lampisang
11.06.08.2016|Keuneu Eu
11.06.08.2017|Lam Isek
11.06.08.2018|Lamkeumok
11.06.08.2019|Lam Rukam
11.06.08.2020|Gurah
11.06.08.2021|Rima Jeuneu
11.06.08.2022|Lam Geu Eu
11.06.08.2023|Lam Hasan
11.06.08.2024|Paya Tieng
11.06.08.2025|Ajuen
11.06.08.2026|Rima Keuneurom
11.06.09.2001|Meunasah Kulam
11.06.09.2002|Beurandeh
11.06.09.2003|Ie Seum
11.06.09.2004|Meunasah Keudee
11.06.09.2005|Lamreh
11.06.09.2006|Meunasah Mon
11.06.09.2007|Paya Kameng
11.06.09.2008|Ruyung
11.06.09.2009|Ladong
11.06.09.2010|Gampong Baro
11.06.09.2011|Durung
11.06.09.2012|Neuheun
11.06.09.2013|Lamnga
11.06.10.2001|Lambaro
11.06.10.2002|Meunasah Manyang Lam Garot
11.06.10.2003|Bakoy
11.06.10.2004|Meunasah Baro
11.06.10.2005|Meunasah Deyah
11.06.10.2006|Meunasah Tutong
11.06.10.2007|Siron
11.06.10.2008|Pasie Lamgarot
11.06.10.2009|Dham Ceukok
11.06.10.2010|Dham Pulo
11.06.10.2011|Lubok Sukon
11.06.10.2012|Lubok Gapuy
11.06.10.2013|Pasie Lubuk
11.06.10.2014|Bung Ceukok
11.06.10.2015|Teubang Phuy
11.06.10.2016|Ateuk Anggok
11.06.10.2017|Ajee Rayeuk
11.06.10.2018|Ajee Cut
11.06.10.2019|Gani
11.06.10.2020|Ateuk Lueng Ie
11.06.10.2021|Cot Alue
11.06.10.2022|Cot Suruy
11.06.10.2023|Cot Bada
11.06.10.2024|Ajee Pagar Air
11.06.10.2025|Meunasah Krueng
11.06.10.2026|Jurong Peujera
11.06.10.2027|Lubok Batee
11.06.10.2028|Bineh Blang
11.06.10.2029|Pantee
11.06.10.2030|Kalut
11.06.10.2031|Meunasah Manyang Pagar Air
11.06.10.2032|Meunasah Manyet
11.06.10.2033|Santan
11.06.10.2034|Tanjong
11.06.10.2035|Reuloh
11.06.10.2041|Paleuh Blang
11.06.10.2042|Cot Mentiwan
11.06.10.2043|Lampreh Lam Jampok
11.06.10.2044|Paleuh Pulo
11.06.10.2045|Lamcot
11.06.10.2046|Lamsinyeu
11.06.10.2047|Lam Ue
11.06.10.2048|Cot Gud
11.06.10.2049|Lamdaya
11.06.10.2050|Lambada
11.06.10.2051|Ujong XII
11.06.10.2052|Bada
11.06.10.2053|Lamteungoh
11.06.10.2054|Kayee Lee
11.06.10.2056|Lampreh Lamteungoh
11.06.11.2001|Krueng Anoi
11.06.11.2002|Lam Puuk
11.06.11.2003|Cot Beut
11.06.11.2004|Bueng Bakjok
11.06.11.2005|Lam Neuheun
11.06.11.2006|Seupeu
11.06.11.2007|Cot Mancang
11.06.11.2008|Lam Baet
11.06.11.2009|Cot Masam
11.06.11.2016|Gue
11.06.11.2018|Lam Sabang
11.06.11.2019|Lam Alue Raya
11.06.11.2020|Lam Alue Cut
11.06.11.2021|Leupung Mesjid
11.06.11.2022|Cot Lamee
11.06.11.2023|Leupung Ulee Alue
11.06.11.2024|Lampoh Tarom
11.06.11.2025|Lamteube Geupula
11.06.11.2026|Lamteube Mon Ara
11.06.11.2027|Aron
11.06.11.2028|Bak Buloh
11.06.11.2029|Lam Seunong
11.06.11.2030|Lam Raya
11.06.11.2031|Lam Roh
11.06.11.2032|Lambunot Tanoh
11.06.11.2033|Tumpok Lampoh
11.06.11.2034|Puuk
11.06.11.2035|Lambunot Paya
11.06.11.2036|Lampoh Keude
11.06.11.2037|Lam Asan
11.06.11.2038|Lambro Deyah
11.06.11.2039|Lambro Bileu
11.06.11.2040|Cot Peutano
11.06.11.2041|Cot Cut
11.06.11.2042|Meunasah Baktrieng
11.06.11.2043|Babah Jurong
11.06.11.2044|Lam Glumpang
11.06.11.2045|Rabeu
11.06.11.2046|Cucum
11.06.11.2047|Deyah
11.06.11.2048|Lam Trieng
11.06.11.2049|Beurangong
11.06.11.2050|Cot Preh
11.06.11.2051|Cot Raya
11.06.11.2052|Cot Yang
11.06.11.2053|Ujong Blang
11.06.11.2054|Lamceu
11.06.12.2001|Angan
11.06.12.2002|Lam Peudaya
11.06.12.2003|Lambada Peukan
11.06.12.2004|Lambiheu La
11.06.12.2005|Lambaro Sukon
11.06.12.2006|Miruek Taman
11.06.12.2007|Suleue
11.06.12.2008|Gampong Cot
11.06.12.2009|Gampong Blang
11.06.12.2010|Lampuja
11.06.12.2011|Tanjung Deah
11.06.12.2012|Limpok
11.06.12.2013|Lampuuk
11.06.12.2014|Lam Ujong
11.06.12.2015|Lam Gawe
11.06.12.2016|Berabung
11.06.12.2017|Lamtimpeung
11.06.12.2018|Tungkop
11.06.12.2019|Tanjong Seulamat
11.06.12.2020|Lamkeunung
11.06.12.2021|Lam Duroy
11.06.12.2022|Lam Klat
11.06.12.2023|Lambiheu Siem
11.06.12.2024|Lambitra
11.06.12.2025|Lie Eue
11.06.12.2026|Krueng Kalee
11.06.12.2027|Lam Asan
11.06.12.2028|Lam Reh
11.06.12.2029|Siem
11.06.13.2001|Rinon
11.06.13.2002|Alue Raya
11.06.13.2003|Melingge
11.06.13.2004|Lapeng
11.06.13.2005|Ulee Paya
11.06.13.2006|Gugop
11.06.13.2007|Seurapong
11.06.13.2008|Blang Situngkoh
11.06.13.2009|Paloh
11.06.13.2010|Lampuyang
11.06.13.2011|Lhok
11.06.13.2012|Teunom
11.06.13.2013|Lamteng
11.06.13.2014|Pasi Janeng
11.06.13.2015|Rabo
11.06.13.2016|Alue Reuyeueng
11.06.13.2017|Deudap
11.06.14.2001|Lamtamot
11.06.14.2002|Lambaro Tunong
11.06.14.2003|Lonbaroh
11.06.14.2004|Lon Asan
11.06.14.2005|Paya Keureuleh
11.06.14.2006|Panca
11.06.14.2007|Lam Kubu
11.06.14.2008|Panca Kubu
11.06.14.2009|Suka Damai
11.06.14.2010|Suka Mulya
11.06.14.2011|Saree Aceh
11.06.14.2012|Teuladan
11.06.15.2001|Teureubeh
11.06.15.2002|Barueh
11.06.15.2003|Jantho
11.06.15.2004|Awek
11.06.15.2005|Data Cut
11.06.15.2006|Bueng
11.06.15.2007|Weu
11.06.15.2008|Jalin
11.06.15.2009|Suka Tani
11.06.15.2010|Cucum
11.06.15.2011|Jantho Baru
11.06.15.2012|Jantho Makmur
11.06.15.2013|Bukit Meusara
11.06.16.2001|Lampakuk
11.06.16.2002|Lampoh Raja
11.06.16.2003|Lam Aling
11.06.16.2004|Lamleupung
11.06.16.2005|Lamkleng
11.06.16.2006|Ie Alang Lamkreumeuh
11.06.16.2007|Ie Alang Lamghui
11.06.16.2008|Ie Alang Mesjid
11.06.16.2009|Ie Alang Dayah
11.06.16.2010|Lamtui
11.06.16.2011|Barih Lhok
11.06.16.2012|Bueng Simek
11.06.16.2013|Banda Safa
11.06.16.2014|Bithak
11.06.16.2015|Lambeugak
11.06.16.2016|Pakuk
11.06.16.2017|Lamsie
11.06.16.2018|Sigapang
11.06.16.2019|Tutui
11.06.16.2020|Pasar Lampaku
11.06.16.2021|Maheng
11.06.16.2022|Leupung Bruek
11.06.16.2023|Keumireu
11.06.16.2024|Lamleuot
11.06.16.2025|Leupung Balue
11.06.16.2026|Bak Sukon
11.06.16.2027|Cot Bayu
11.06.16.2028|Glee Jai
11.06.16.2029|Keuruweung Blang
11.06.16.2030|Keuruweung Krueng
11.06.16.2031|Siron Blang
11.06.16.2032|Siron Krueng
11.06.17.2001|Lambaro Samahani
11.06.17.2002|Lam Ara Cut
11.06.17.2003|Lam Ara Engkit
11.06.17.2004|Lam Ara Tunong
11.06.17.2005|Leupung Riwat
11.06.17.2006|Tumbo Baro
11.06.17.2007|Leupung Cut
11.06.17.2008|Lamsiteh Cot
11.06.17.2009|Reuleung Karieng
11.06.17.2010|Leubok Buni
11.06.17.2011|Leubok Batee
11.06.17.2012|Bunghu
11.06.17.2013|Teu Dayah
11.06.17.2014|Leupung Rayeuk
11.06.17.2015|Reuleung Glumpang
11.06.18.2001|Ateuk Lam Phang
11.06.18.2002|Ateuk Lampuot
11.06.18.2003|Ateuk Mon Panah
11.06.18.2004|Ateuk Lam Ura
11.06.18.2005|Ateuk Cut
11.06.18.2006|Ateuk Blang Asan
11.06.18.2007|Lamjamee Dayah
11.06.18.2008|Lam Batee
11.06.18.2009|Nya
11.06.18.2010|Batee Linteung
11.06.18.2011|Krueng Mak
11.06.18.2012|Lambunot
11.06.18.2013|Lamjamee Lamkrak
11.06.18.2014|Blang Miro
11.06.18.2015|Blang Preh
11.06.18.2016|Bha Ulee Tutu
11.06.18.2017|Lam Urit
11.06.18.2018|Tantuha
11.06.19.2001|Lhang
11.06.19.2002|Biluy
11.06.19.2003|Lambatee
11.06.19.2004|Lamkunyet
11.06.19.2005|Lamtadok
11.06.19.2006|Neusok
11.06.19.2007|Turam
11.06.19.2008|Tubaluy
11.06.19.2009|Blang Kiree
11.06.19.2010|Manee Dayah
11.06.19.2011|Lamsod
11.06.19.2012|Lambleut
11.06.19.2013|Empee Trieng
11.06.19.2014|Lambaro Biluy
11.06.20.2001|Cadek
11.06.20.2002|Kajhu
11.06.20.2003|Baet
11.06.20.2004|Blang Krueng
11.06.20.2005|Klieng Muria
11.06.20.2006|Lam Bada Lhok
11.06.20.2007|Lampineung
11.06.20.2008|Lam Asan
11.06.20.2009|Labuy
11.06.20.2010|Lam Ujong
11.06.20.2011|Klieng Cot Aron
11.06.20.2012|Cot Paya
11.06.20.2013|Miruk Lam Reudep
11.06.21.2001|Meunasah Papeun
11.06.21.2002|Meunasah Baktrieng
11.06.21.2003|Leung Ie
11.06.21.2004|Lampermai
11.06.21.2005|Gle Deyah
11.06.21.2006|Miruk
11.06.21.2007|Lam Gapang
11.06.21.2008|Meunasah Manyang
11.06.21.2009|Meunasah Baet
11.06.21.2010|Meunasah Intan
11.06.21.2011|Rumpet
11.06.21.2012|Gla Meunasah Baro
11.06.22.2001|Layeun
11.06.22.2002|Pulot
11.06.22.2003|Lamseunia
11.06.22.2004|Mns. Mesjid
11.06.22.2005|Meunasah Bak U
11.06.22.2006|Dayah Mamplam
11.06.23.2001|Cot Puklat
11.06.23.2002|Lamme
11.06.23.2003|Meulayo
11.06.23.2004|Lam Siem
11.06.23.2005|Cot Geundreut
11.06.23.2006|Paya Ue
11.06.23.2007|Cot Mon Raya
11.06.23.2008|Cot Meulangeun
11.06.23.2009|Cot Madhi
11.06.23.2010|Bueng Sidom
11.06.23.2011|Cot Karieng
11.06.23.2012|Kampung Blang
11.06.23.2013|Cot Malem
11.06.23.2014|Cot Rumpun
11.06.23.2015|Cot Hoho
11.06.23.2016|Cot Jambo
11.06.23.2017|Cot Nambak
11.06.23.2018|Bueng Pageu
11.06.23.2019|Cot Sayun
11.06.23.2020|Teupin Batee
11.06.23.2021|Cot Leuot
11.06.23.2022|Cot Bagie
11.06.23.2023|Kayee Kunyet
11.06.23.2024|Cot Mancang
11.06.23.2025|Empee Bata
11.06.23.2026|Data Makmur
11.07.03.2001|Dayah Tuha
11.07.03.2002|Dayah Baroh
11.07.03.2003|Bintang Hu
11.07.03.2004|Pulo Tukok
11.07.03.2005|Pulo Bungong
11.07.03.2006|Geunteng Barat
11.07.03.2007|Geunteng Timur
11.07.03.2008|Calong Cut
11.07.03.2009|Glumpang Lhee
11.07.03.2010|Aron
11.07.03.2011|Tuha
11.07.03.2012|Dayah
11.07.03.2013|Mesjid
11.07.03.2014|Meucat
11.07.03.2015|Teupin Raya
11.07.03.2016|Rungkom
11.07.03.2017|Mee
11.07.03.2018|Pulo Pande
11.07.03.2019|Seulatan
11.07.03.2020|Alue Lada
11.07.03.2021|Teupin Jeue
11.07.03.2022|Neuheun
11.07.03.2023|Crueng
11.07.03.2024|Kareung
11.07.03.2025|Kulee
11.07.03.2026|Kulam
11.07.03.2027|Awe
11.07.03.2028|Pasi Beurandeh
11.07.04.2001|Tunong
11.07.04.2002|Raya
11.07.04.2003|Daboh
11.07.04.2004|Cut
11.07.04.2005|Mesjid Reubee
11.07.04.2006|Tanjong
11.07.04.2007|Geudong
11.07.04.2008|Reuntoh
11.07.04.2009|Reuba
11.07.04.2010|Krueng Reubee
11.07.04.2011|Neulop
11.07.04.2012|Glee
11.07.04.2013|Kumbang
11.07.04.2014|Buloh
11.07.04.2015|Bungo
11.07.04.2016|Dayah Reubee
11.07.04.2017|Jambee
11.07.04.2018|Dayah Baro
11.07.04.2019|Puuk Aree
11.07.04.2020|Lhee Meunasah
11.07.04.2021|Ulee Tutue Raya
11.07.04.2022|Mesjid Aree
11.07.04.2023|Keutapang Aree
11.07.04.2024|Pantee Aree
11.07.04.2025|Pulo Tunong
11.07.04.2026|Pulo Baroh Aree
11.07.04.2027|Keurumbok
11.07.04.2028|Ceurih Blang Mee
11.07.04.2029|Ceurih Kupula
11.07.04.2030|Ceurih Alue
11.07.04.2031|Ceurih Cot
11.07.04.2032|Seupeung
11.07.04.2033|Sukon Lhong
11.07.04.2034|Dayah Beuah
11.07.04.2035|Krueng Cot
11.07.04.2036|Mesjid Beuah
11.07.04.2037|Lueng Dama
11.07.04.2038|Mesjid Bambong
11.07.04.2039|Ruseb
11.07.04.2040|Sagoe
11.07.04.2041|Seukeum
11.07.04.2042|Pangoe
11.07.04.2043|Keutapang Bambong
11.07.04.2044|Metareum
11.07.05.2001|Bangkeh
11.07.05.2002|Pucok
11.07.05.2004|Leupu
11.07.05.2005|Pulo Lhoih
11.07.05.2006|Keune
11.07.06.2001|Simpang
11.07.06.2002|Krueng Jangko
11.07.06.2003|Krueng Nyong
11.07.06.2004|Cot Baroh
11.07.06.2005|Cot Tunong
11.07.06.2006|Bili
11.07.06.2007|Panjoe
11.07.06.2008|Amud Mesjid
11.07.06.2009|Reudeup Meulayu
11.07.06.2010|Dayah Tanoh
11.07.06.2011|Mamplam
11.07.06.2012|Balee
11.07.06.2013|Kupula
11.07.06.2014|Pulo Lueng Teuga
11.07.06.2015|Sukon Mesjid
11.07.06.2016|Sukon Baroh
11.07.06.2017|Kruet Teumpeun
11.07.06.2018|Blang Drang
11.07.06.2019|Ude Gampong
11.07.06.2020|Kayee Jatoe
11.07.06.2021|Kampong Jeumpa
11.07.06.2022|Pulo Lon / Pulo Dayah
11.07.06.2023|Jurong Pande
11.07.06.2024|Pulo Gajah Mate
11.07.06.2025|Tufah Jeulatang
11.07.06.2026|Kumbang Keupula
11.07.06.2027|Pulo Batee
11.07.06.2028|Meunjee
11.07.06.2029|Keutapang Mesjid
11.07.06.2030|Dayah Kp. Pisang
11.07.06.2031|Blang Tunong
11.07.06.2032|Blang Pueb
11.07.06.2033|Lambaro
11.07.06.2034|Neurok
11.07.07.2001|Tampieng Tunong
11.07.07.2002|Tampieng Baroh
11.07.07.2003|Dayah Caleue
11.07.07.2004|Jurong
11.07.07.2005|Keutapang
11.07.07.2006|Dayah Keurako
11.07.07.2007|Mesjid Lam Ujong
11.07.07.2008|Baro Jruek
11.07.07.2009|Yub Mee
11.07.07.2010|Raya Lhok Kaju
11.07.07.2011|Pulo Gampong U
11.07.07.2012|Pante Lhok Kaju
11.07.07.2014|Sukon Tungkop
11.07.07.2015|Rawa Tungkop
11.07.07.2016|Mesjid Tungkop
11.07.07.2017|Dayah Muara Garot
11.07.07.2018|Pante Garot
11.07.07.2019|Garot Cut
11.07.07.2020|Keubang
11.07.07.2021|Blang Garot
11.07.07.2022|Meulayu
11.07.07.2023|Tungkop Cut
11.07.07.2024|Guci
11.07.07.2025|Teungoh Blang
11.07.07.2026|Mesjid Dijiem
11.07.07.2027|Sukon Ulee Gampong
11.07.07.2028|Lamkabu
11.07.07.2029|Ulee Birah
11.07.07.2030|Mesjid Baro
11.07.07.2031|Lamreuneung
11.07.07.2032|Cot Seukee
11.07.07.2033|Drien
11.07.07.2034|Rumia
11.07.07.2035|Wakheuh
11.07.07.2036|Baro Bluek
11.07.07.2037|Mesjid Ulee Gampong
11.07.07.2038|Dayah Bie
11.07.07.2039|Balee Baroh Bluek
11.07.07.2040|Peutoe
11.07.07.2041|Blang Rapai
11.07.07.2042|Neulop II
11.07.07.2043|Baro Gapui
11.07.07.2044|Balee Baroh Gapui
11.07.07.2045|Glee Gapui
11.07.07.2046|Teungoh Suwiek
11.07.07.2047|Mesjid Suwiek
11.07.07.2048|Tuha Suwiek
11.07.07.2049|Beureudep
11.07.07.2050|Blang Lhok Kaju
11.07.08.2001|Jurong Balee
11.07.08.2002|Aron Asan Kumbang
11.07.08.2003|Cebrek
11.07.08.2004|Jurong Mesjid
11.07.08.2005|Meunasah Gantung
11.07.08.2006|Babah Jurong
11.07.08.2007|Keupula
11.07.08.2008|Meunasah Jareng
11.07.08.2009|Arusan
11.07.08.2010|Tanjong Krueng
11.07.08.2011|Lancang
11.07.08.2012|Pasi Lhok
11.07.08.2013|Jeumeurang
11.07.08.2014|Pusong
11.07.08.2015|Meuraksa
11.07.08.2016|Kayee Panyang
11.07.08.2017|Panjoe
11.07.08.2018|Asan
11.07.08.2019|Meunasah Mesjid
11.07.08.2020|Meunasah Mee
11.07.08.2021|Meunasah Teungoh
11.07.08.2022|Pasi ie Leubeue
11.07.08.2023|Keude ie Leubeue
11.07.08.2024|Meunasah Sukon
11.07.08.2025|Meunasah Ara
11.07.08.2026|Meunasah Krueng
11.07.08.2027|Krueng Dhoe
11.07.08.2028|Meunasah Baro
11.07.08.2029|Bentayan
11.07.08.2030|Meunasah Kandang
11.07.08.2031|Lamkawe
11.07.08.2032|Puuk
11.07.08.2033|Tanjong
11.07.08.2034|Dayah Blang
11.07.08.2035|Dayah Mon Ara
11.07.08.2036|Keureumbok
11.07.08.2037|Meunasah Manyang
11.07.08.2038|Matang Kuli
11.07.08.2039|Reung-Reung
11.07.08.2040|Teumpeun
11.07.08.2041|Blang Cut
11.07.08.2042|Geuleumpang
11.07.08.2043|Aron Kuta Baro
11.07.08.2044|Barat
11.07.08.2045|Araih
11.07.09.2001|Blang Paseh
11.07.09.2002|Benteng
11.07.09.2003|Blok Bengkel
11.07.09.2004|Pante Teungoh
11.07.09.2005|Kuala Pidie
11.07.09.2006|Kramat Luar
11.07.09.2007|Kramat Dalam
11.07.09.2008|Blok Sawah
11.07.09.2009|Blang Asan
11.07.09.2010|Lampoh Krueng
11.07.09.2011|Kampong Asan
11.07.09.2012|Meunasah Peukan
11.07.09.2013|Pasi Rawa
11.07.09.2014|Pasi Peukan Baro
11.07.09.2015|Tanjong Krueng
11.07.11.2001|Blang
11.07.11.2002|Teumeucet
11.07.11.2003|Blang Cut
11.07.11.2004|Kumbang
11.07.11.2005|Pulo Tanjong
11.07.11.2006|Ara Bungkok
11.07.11.2007|Lagang
11.07.11.2008|Mesjid Ilot
11.07.11.2009|Baroh Ilot
11.07.11.2010|Tunong Ilot
11.07.11.2011|Teungoh Ilot
11.07.11.2012|Dayah Andeue
11.07.11.2013|Dayah Sinthop
11.07.11.2014|Kulu
11.07.11.2015|Mesjid Andeue
11.07.11.2016|Meuyub Lala
11.07.11.2017|Tuha Lala
11.07.11.2018|Lhok Lubu
11.07.11.2019|Babah Jurong
11.07.11.2020|Krueng Lala
11.07.12.2001|Cot
11.07.12.2002|Tgk Dilaweueng
11.07.12.2003|Mesjid
11.07.12.2004|Keupula
11.07.12.2005|Suka Jaya
11.07.12.2006|Pawod
11.07.12.2007|Deyah
11.07.12.2008|Krueng
11.07.12.2009|Gle Cut
11.07.12.2010|IE Masen
11.07.12.2011|Sagoe
11.07.12.2012|Ujong Pie
11.07.12.2013|Blang Raya
11.07.12.2014|Batee
11.07.12.2015|Ingin Jaya
11.07.12.2016|Papeun
11.07.12.2017|Tuha Biheue
11.07.12.2018|Simpang Beutong
11.07.13.2001|Mesjid Yaman
11.07.13.2002|Baro Yaman
11.07.13.2003|Mee Teungoh
11.07.13.2004|Sentosa
11.07.13.2005|Baroh Barat Yaman
11.07.13.2006|Tuha Gampong Gajah
11.07.13.2007|Jadan
11.07.13.2008|Bale Baro Keumangan
11.07.13.2009|Blang Tidiek
11.07.13.2010|Blang Lileue
11.07.13.2011|Keumangan Cut
11.07.13.2012|Mesjid Keumangan
11.07.13.2013|Dayah Tidiek
11.07.13.2014|Lueng Sagoe
11.07.13.2015|Blang Beureueh
11.07.13.2016|Dayah Beureueh
11.07.13.2017|Pante Beureueh
11.07.13.2018|Rapana
11.07.13.2019|Paya Tiba
11.07.13.2020|Paloh Kambuek
11.07.13.2021|Lampoh Sirong
11.07.13.2022|Mee Panyang
11.07.13.2023|Reului
11.07.13.2024|Dayah Syarif
11.07.13.2025|Peureulak
11.07.13.2026|Ribeun
11.07.13.2027|Balee Busu
11.07.13.2028|Lingkok
11.07.13.2029|Kumbang
11.07.14.2001|Mesjid Kunyet
11.07.14.2002|Piala Kunyet
11.07.14.2003|Hagu Kunyet
11.07.14.2004|Baro Kunyet
11.07.14.2005|Dayah Tanoh Kunyet
11.07.14.2006|Kambuek Nicah Kunyet
11.07.14.2007|Kambuek Payapi Kunyet
11.07.14.2008|Seunadeu Kunyet
11.07.14.2009|Blang Gunci Kunyet
11.07.14.2010|Dayah Baroh Kunyet
11.07.14.2011|Blang Geuleudieng
11.07.14.2012|Geulumpang Geuleudieng
11.07.14.2013|Mesjid Geuleudieng
11.07.14.2014|Sukon Peudaya
11.07.14.2015|Mesjid Peudaya
11.07.14.2016|Cut Peudaya
11.07.14.2017|Buloh Peudaya
11.07.14.2018|Perlak Peudaya
11.07.14.2019|Dayah Peudaya
11.07.14.2020|Teungoh Peudaya
11.07.14.2021|Tuha Peudaya
11.07.14.2022|Tunong Peudaya
11.07.14.2023|Buni Reulieng Peudaya
11.07.14.2024|Trieng Paloh
11.07.14.2025|Leuhob Paloh
11.07.14.2026|Jurong Gampong Cot Paloh
11.07.14.2027|Suyo Paloh
11.07.14.2028|Kreet Paloh
11.07.14.2029|Capa Paloh
11.07.14.2030|Jurong Anoe Paloh
11.07.14.2031|Balee Paloh
11.07.14.2032|Siron Paloh
11.07.14.2033|Gampong Cut Paloh
11.07.14.2034|Pante Cermen Paloh
11.07.14.2035|Pasar Paloh
11.07.14.2036|Cot Kunyet
11.07.14.2037|Meuke Beurabo
11.07.14.2038|Mesjid Beurabo
11.07.14.2039|Seukeumbrok Beurabo
11.07.14.2040|Baro Beurabo
11.07.14.2041|Adang Beurabo
11.07.14.2042|Paloh Jeurat Beurabo
11.07.14.2043|Seuleunggieng Beurabo
11.07.14.2044|Teungoh Drien Gogo
11.07.14.2045|Kumbang Gogo
11.07.14.2046|Mesjid Gogos
11.07.14.2047|Tuha Gogo
11.07.14.2048|Glee Gogo
11.07.14.2049|Meuke Gogo
11.07.14.2050|Raya Gogo
11.07.14.2051|Grong-Grong Gogo
11.07.14.2052|Aron Bunot Gogo
11.07.14.2053|Buloh Gogo
11.07.14.2054|Tunong Tanjong
11.07.14.2055|Keupula Tanjong
11.07.14.2056|Jok Tanjong
11.07.14.2057|Leun Tanjong
11.07.14.2058|Pante Crueng Tanjong
11.07.14.2059|Cot Keutapang Tanjong
11.07.14.2060|Siron Tanjong
11.07.14.2061|Mesjid Tanjong
11.07.14.2062|Khang Tanjong
11.07.14.2063|Meuriya Tanjong
11.07.14.2064|Pulo Hagu Tanjong
11.07.15.2001|Dua Paya
11.07.15.2002|Cot Mulu
11.07.15.2003|Dayah Bubue
11.07.15.2004|Tanjong Hagu
11.07.15.2005|Sumboe Buga
11.07.15.2006|Rambayan Kupula
11.07.15.2007|Rambayan Lueng
11.07.15.2008|Cempala Kuneng
11.07.15.2009|Peunayong
11.07.15.2010|Leuhop
11.07.15.2011|Kumbang waido
11.07.15.2012|Gampong waido
11.07.15.2013|Mee Krukon
11.07.15.2014|Mee Lampoih Saka
11.07.15.2015|Lueng Guci Rumpong
11.07.15.2016|Dayah Seumideun
11.07.15.2017|Mesjid Guci Rumpong
11.07.15.2018|Reuba Waido
11.07.15.2019|Dayah Teungku
11.07.15.2020|Jurong Raya
11.07.15.2021|Balee Rastong
11.07.15.2022|Lueng Mesjid
11.07.15.2023|Teungoh Baroh
11.07.15.2024|Mee Hagu
11.07.15.2025|Dayah Sukon
11.07.15.2026|Blang Raya
11.07.15.2027|Balee Pineung
11.07.15.2028|Menjee Mesjid
11.07.15.2029|Mee Tanoh
11.07.15.2030|Sialet-Alet
11.07.15.2031|Bluek Arab
11.07.15.2032|Puuk
11.07.15.2033|Dayah Muara
11.07.15.2034|Sawiet
11.07.15.2035|Ulee Tutue
11.07.15.2036|Jim
11.07.15.2037|Keutapang
11.07.15.2038|Meuleuweuk
11.07.15.2039|Jurong
11.07.15.2040|Raya Krueng Seumideun
11.07.15.2041|Sukon Krueng Seumideun
11.07.15.2042|Mee Krueng Seumideun
11.07.15.2043|Blang Krueng Seumideun
11.07.15.2044|Keureumbok
11.07.15.2045|Ulee Cot Seupeng
11.07.15.2046|Kabat
11.07.15.2049|Blang Seupeng
11.07.15.2050|Gampong Krueng Seumideun
11.07.16.2001|Tijue
11.07.16.2002|Lampeudeu Tunong
11.07.16.2003|Puuk
11.07.16.2004|Lampeudue Baroh
11.07.16.2005|Paya
11.07.16.2006|Mesjid Runtoh
11.07.16.2007|Dayah Teungoh
11.07.16.2008|Baroh
11.07.16.2009|Dayah Tanoh
11.07.16.2010|Cot Geunduek
11.07.16.2011|Tumpok Laweung
11.07.16.2012|Ulee Ceue Keulibeut
11.07.16.2013|Keudee
11.07.16.2014|Ulee Tutue
11.07.16.2015|Dayah Tutong
11.07.16.2016|Lampoh Lada
11.07.16.2017|Keuniree
11.07.16.2018|Tumpok 40
11.07.16.2019|Cot Teungoh
11.07.16.2020|Cot Rheng
11.07.16.2021|Labui
11.07.16.2022|Gampong
11.07.16.2023|Pulo Pisang
11.07.16.2024|Lamkuta
11.07.16.2025|Kampong Pukat
11.07.16.2026|Kampong Barat
11.07.16.2027|Paloh
11.07.16.2028|Kampong Baro
11.07.16.2029|Pulo Bubee
11.07.16.2030|Tibang
11.07.16.2031|Rawa
11.07.16.2032|Peukan Baro
11.07.16.2033|Mancang
11.07.16.2034|Gajah Ayee
11.07.16.2035|Lhok Keutapang
11.07.16.2036|Dalueng
11.07.16.2037|Ulee Ceue Teubeng
11.07.16.2038|Meucat Teubeng
11.07.16.2039|Dayah Teubeng
11.07.16.2040|Tanjong Teubeng
11.07.16.2041|Jawa Teubeng
11.07.16.2042|Bayu Teubeng
11.07.16.2043|Abo Teubeng
11.07.16.2044|Keutapang Sanggeue
11.07.16.2045|Krueng Dhoe
11.07.16.2046|Sirong
11.07.16.2047|Keutumbu
11.07.16.2048|Jeumpa
11.07.16.2049|Raya sanggeue
11.07.16.2050|Jeuleupee
11.07.16.2051|Ujong Langgo
11.07.16.2052|Cot Glumpang
11.07.16.2053|Seuriweuk
11.07.16.2054|Mesjid Utue
11.07.16.2055|Leubue
11.07.16.2056|Batee
11.07.16.2057|Raya Uteu
11.07.16.2058|Seukeumbrok
11.07.16.2059|Bie
11.07.16.2060|Blang Kula
11.07.16.2061|ALue
11.07.16.2062|Seukee
11.07.16.2063|Paya Linteung
11.07.16.2064|Puli
11.07.17.2001|Balue Tanoh
11.07.17.2002|Balue Kulu
11.07.17.2003|Lhok Empeh
11.07.17.2004|Cot Sukon
11.07.17.2005|Dayah Tuha
11.07.17.2006|Kampong Cot
11.07.17.2007|Paloh Jeureula
11.07.17.2008|Barieh
11.07.17.2009|Kandang
11.07.17.2010|Riweuek
11.07.17.2011|Mancang
11.07.17.2012|Kampong Pisang Bucue
11.07.17.2013|Bucue
11.07.17.2014|Lhok Panah
11.07.17.2015|Murong Cot
11.07.17.2016|Cumbok Lie
11.07.17.2017|Lam Ujong
11.07.17.2018|Murong Lhok
11.07.17.2019|Blang Cot
11.07.17.2020|Cot Cantek
11.07.17.2021|Blang Kumot Baroh
11.07.17.2022|Blang Kumot Tunong
11.07.17.2023|Cumbok Niwa
11.07.17.2024|Leupeuem Mesjid
11.07.17.2025|Pulo Jeumpa
11.07.17.2026|Beutong Pocut
11.07.17.2027|Beutong Perlak
11.07.17.2028|Kampong Jeumpa
11.07.17.2029|Pante Krueng
11.07.17.2030|Jurong Pante
11.07.17.2032|Mali Lamkuta
11.07.17.2033|Mali Uke
11.07.17.2034|Mali Mesjid
11.07.17.2035|Mali Cot
11.07.17.2036|Tangkueng
11.07.17.2037|Lhok Mee
11.07.17.2038|Lameue Mns. Raya
11.07.17.2039|Lameue Mns. Baro
11.07.17.2040|Lameue Mns. Lueng
11.07.17.2041|Pulo Keureumbok
11.07.17.2042|Dayah Kp Pisang
11.07.17.2043|Mns Blang Sakti
11.07.17.2044|Perlak Baroh
11.07.17.2045|Lingkok
11.07.17.2046|Pasar Kota Bakti
11.07.17.2047|Mns Balee
11.07.17.2048|Perlak Asan
11.07.17.2049|Kampong Baro
11.07.17.2050|Mali Guyui
11.07.18.2001|Raya Paya
11.07.18.2002|Mesjid Bungie
11.07.18.2003|Liliep
11.07.18.2004|Ujong Baroh
11.07.18.2005|Peukan Sot
11.07.18.2006|Sukon
11.07.18.2007|Raya Paleue
11.07.18.2008|Lambideng
11.07.18.2009|Cot Paleue
11.07.18.2010|Seukee
11.07.18.2011|Cebrek
11.07.18.2012|Linggong Sagoe
11.07.18.2013|Kulam Baro
11.07.18.2014|Empeh
11.07.18.2015|Nien
11.07.18.2016|Ceureucok Timur
11.07.18.2017|Ceureukcok Barat
11.07.18.2018|Jaja Baroh
11.07.18.2019|Jaja Tunong
11.07.18.2020|Mesjid Gigieng
11.07.18.2021|Gong
11.07.18.2022|Pulo Raya
11.07.18.2023|Pulo Blang
11.07.18.2024|Mamplam
11.07.18.2025|Meunasah Lhee
11.07.18.2026|Pante
11.07.18.2027|Kupula
11.07.18.2028|Mantak Raya
11.07.18.2029|Peukan Tuha
11.07.18.2030|Dayah Lampoh Awe
11.07.18.2031|Meunasah Blang
11.07.18.2032|Pulo Gajah Mate
11.07.18.2033|Seuk Ceukok
11.07.18.2034|Pulo Tu
11.07.18.2035|Meunasah Jurong
11.07.18.2036|Kampong Blang
11.07.18.2037|Padang
11.07.18.2038|Cot Ara
11.07.18.2039|Dayah Blang Cut
11.07.18.2040|Teungoh Mangki
11.07.18.2041|Dayah Blang
11.07.18.2042|Madika
11.07.18.2043|Sagoe
11.07.18.2044|Ceureucok Sagoe
11.07.18.2045|Bunien
11.07.18.2046|Paloh Tok Due
11.07.18.2047|Mesjid Tungoe
11.07.18.2048|Blang Leuen
11.07.18.2049|Ujong Gampong
11.07.18.2050|Cot Jaja
11.07.18.2051|Lheue
11.07.18.2052|Ulee Barat
11.07.19.2001|Keude Tangse
11.07.19.2002|Pulo Mesjid I
11.07.19.2003|Pulo Mesjid II
11.07.19.2004|Pulo Sejahtera
11.07.19.2005|Pulo Kawa
11.07.19.2006|Pulo Seunong
11.07.19.2007|Nubok Badeuk
11.07.19.2008|Blang Jeurat
11.07.19.2009|Pulo Baro
11.07.19.2010|Layan
11.07.19.2011|Blang Dalam
11.07.19.2012|Peunalom I
11.07.19.2013|Peunalom II
11.07.19.2014|Krueng Meuriam
11.07.19.2015|Blang Teungoh
11.07.19.2016|Blang Dhot
11.07.19.2017|Blang Bungong
11.07.19.2018|Ulee Gunong
11.07.19.2019|Keubon Nilam
11.07.19.2020|Paya Guci
11.07.19.2021|Ranto Panyang
11.07.19.2022|Blang Malo
11.07.19.2023|Krueng Seukeuek
11.07.19.2024|Beungga
11.07.19.2025|Alue Calong
11.07.19.2026|Pulo Ie
11.07.19.2027|Lhok Keutapang
11.07.19.2028|Blang Pandak
11.07.21.2001|Rabo
11.07.21.2002|Pulo Siblah
11.07.21.2003|Lhok Igeuh
11.07.21.2004|Pulo Glumpang
11.07.21.2005|Meunasah Mancang
11.07.21.2006|Pulo Tambo
11.07.21.2007|Pulo Keunari
11.07.21.2008|Peunadok
11.07.21.2009|Pulo Mesjid
11.07.21.2010|Meunasah Panah
11.07.21.2011|Trieng Cudo Baroh
11.07.21.2012|Trieng Cudo Tunong
11.07.21.2013|Mampree
11.07.21.2014|Daya Baroh
11.07.21.2015|Daya Teungoh
11.07.21.2016|Daya Kampong Baro
11.07.21.2017|Daya Cot
11.07.21.2018|Blang Rikui
11.07.21.2019|Panton Beunot
11.07.22.2001|U Gadeng
11.07.22.2002|Kumbang
11.07.22.2003|Sagoe
11.07.22.2004|Dayah Keumala
11.07.22.2005|Jijiem
11.07.22.2006|Rheng
11.07.22.2007|Cot Nuran
11.07.22.2008|Pulo Pante
11.07.22.2009|Paloh Teungoh
11.07.22.2010|Asan Nicah
11.07.22.2011|Papeun Nicah
11.07.22.2012|Pulo Seupeng
11.07.22.2013|Mesjid Nicah
11.07.22.2014|Tunong
11.07.22.2015|Pako
11.07.22.2016|Pulo Baro
11.07.22.2017|Cot Kreh
11.07.22.2031|Pulo Cahi
11.07.24.2001|Baroh Ujong Rimba
11.07.24.2002|Jojo
11.07.24.2003|Gampong Cot Usi
11.07.24.2004|Dayah Usi
11.07.24.2005|Paloh lhok Usi
11.07.24.2006|Campli Usi
11.07.24.2007|Mee Tanjong Usi
11.07.24.2008|Mesjid Usi
11.07.24.2009|Paloh Raya
11.07.24.2010|Nibong
11.07.24.2011|Baro Ujong Rimba
11.07.24.2012|Rinti
11.07.24.2013|Didoh
11.07.24.2014|Meugit
11.07.24.2015|Empeh
11.07.24.2016|Blang Riek
11.07.24.2017|Balee Ujong Rimba
11.07.24.2018|Mon Ara
11.07.24.2019|Kulam Ara
11.07.24.2020|Blangong Basah
11.07.24.2021|Rambong
11.07.24.2022|Gampong Lada
11.07.24.2023|Dayah Kumba
11.07.24.2024|Cot Kuthang
11.07.24.2025|Dayah Tanoh
11.07.24.2026|Ulee Tutue
11.07.24.2027|Beureueh II
11.07.24.2028|Mesjid Jeurat Manyang
11.07.24.2029|Paloh Tinggi
11.07.24.2030|Karieng
11.07.24.2031|Sagoe Teumpeun
11.07.24.2032|Tong Peria
11.07.24.2033|Tong Weng
11.07.24.2034|Pulo Drien
11.07.24.2035|Mesjid Gumpueng
11.07.24.2036|Ulee Gampong
11.07.24.2037|Barieh
11.07.24.2038|Jumphoih Adan
11.07.24.2039|Mee Adan
11.07.24.2040|Dayah Adan
11.07.24.2041|Alue Adan
11.07.24.2042|Rambot Adan
11.07.24.2043|Meucat Adan
11.07.24.2044|Tiba Mesjid
11.07.24.2045|Tiba Raya
11.07.24.2046|Reubat
11.07.24.2047|Simbe
11.07.24.2048|Jiem
11.07.25.2001|Gintong
11.07.25.2002|Mesjid Beureuleung
11.07.25.2003|Beureuleung
11.07.25.2004|Baroh
11.07.25.2005|Mee
11.07.25.2006|Paya
11.07.25.2007|Teungoh
11.07.25.2008|Pangge Pilok
11.07.25.2009|Karieng
11.07.25.2010|Grong-Grong
11.07.25.2011|Nicah
11.07.25.2012|Mesjid Memeuaneuk
11.07.25.2013|Daka
11.07.25.2014|Sentosa
11.07.25.2015|Sukon
11.07.27.2001|Lutueng
11.07.27.2002|Blang Dalam
11.07.27.2003|Mane
11.07.27.2004|Turue Cut
11.07.29.2001|U. Bungkok
11.07.29.2002|Mee Teumpeun
11.07.29.2003|Kumbang Unoe
11.07.29.2004|Sagoe
11.07.29.2005|Geunteng
11.07.29.2006|Jurong Baro
11.07.29.2007|Sukon Paku
11.07.29.2008|Pulo Iboih
11.07.29.2009|Sangget
11.07.29.2010|Blang Baroh
11.07.29.2011|Manyang
11.07.29.2012|Pulo Panjoe
11.07.29.2013|Balee Gantung
11.07.29.2014|Daboih
11.07.29.2015|Seureukui Cebrek
11.07.29.2016|Glumpang Bungkok
11.07.29.2017|Ukee
11.07.29.2018|Kumbang Trueng Campli
11.07.29.2019|Palong
11.07.29.2020|Seukee
11.07.29.2021|Bungong
11.07.31.2001|Lingkok
11.07.31.2002|Pante Kulu
11.07.31.2003|Uke
11.07.31.2004|Pante Siren
11.07.31.2005|Pulo Raya
11.07.31.2006|Cut
11.07.31.2007|Dayah Meunara
11.07.31.2008|Paloh Naleueng
11.07.31.2009|Pulo Lhoih
11.07.31.2010|Mesjid Tongpudeng
11.07.31.2011|Blang Tho
11.07.31.2012|Asan Tongpudeng
11.07.31.2013|Alue
11.08.01.2001|Keude Alue Ie Puteh
11.08.01.2002|Meunasah Alue Ie Puteh
11.08.01.2003|Pucok Alue
11.08.01.2004|Alue Anoe Timu
11.08.01.2005|Alue Anoe Barat
11.08.01.2006|Pulo Seukee
11.08.01.2007|Alue Serdang
11.08.01.2008|Cot Mane
11.08.01.2009|Cot Kumbang
11.08.01.2010|Matang Kumbang
11.08.01.2011|Matang Kareung
11.08.01.2012|Cot Ulaya
11.08.01.2013|Alue Geudong
11.08.01.2014|Tanjong Glumpang
11.08.01.2015|Matang Raya Timu
11.08.01.2016|Matang Raya Barat
11.08.01.2017|Matang Kelayu
11.08.01.2018|Alue Buya
11.08.01.2019|Matang Cut
11.08.01.2020|Keude Panteu Breuh
11.08.01.2021|Meudang Ara
11.08.01.2022|Meunasah Bujok
11.08.01.2023|Alue Dama
11.08.01.2024|Cot Ara
11.08.01.2025|Rambong Dalam
11.08.01.2026|Meunasah Geudong
11.08.01.2027|Alue Keutapang
11.08.01.2028|Krueng Lingka Barat
11.08.01.2029|Krueng Lingka Timu
11.08.01.2030|Alue Jamok
11.08.01.2031|Alue Bili Geulumpang
11.08.01.2032|Lhok Seutuy
11.08.01.2033|Alue Bili Rayeuk
11.08.01.2034|Keude Menjee IV
11.08.01.2035|Glumpang Bungkok
11.08.01.2036|Matang Rawa
11.08.01.2037|Glumpang Samlakoe
11.08.01.2038|Arongan Lise
11.08.01.2039|Matang Reudeup
11.08.01.2040|Matang Manyam
11.08.01.2041|Matang Ulim
11.08.01.2042|Matang Beuringen
11.08.01.2043|Cot Manyang
11.08.01.2044|Alue Ie Tarek
11.08.01.2045|Alue Rambong
11.08.01.2046|Matang Linya
11.08.01.2047|Matang Lawang
11.08.01.2048|Glumpang payong
11.08.01.2049|Mon Sukon
11.08.01.2050|Lueng Bata
11.08.01.2051|Ceumpeudak
11.08.01.2052|Buket Dara Baro
11.08.01.2053|Matang Pineung
11.08.01.2054|Matang Baro
11.08.01.2055|Ujong Dama
11.08.01.2056|Babussalam
11.08.01.2057|Cinta Makmur
11.08.02.2001|Keude Krueng Geukueh
11.08.02.2002|Tambon Baroh
11.08.02.2003|Tambon Tunong
11.08.02.2004|Paloh Gadeng
11.08.02.2005|Paloh Lada
11.08.02.2006|Uteun Geulinggang
11.08.02.2007|Pulo Rungkom
11.08.02.2008|Paloh Igeuh
11.08.02.2009|Bangka Jaya
11.08.02.2010|Ulee Pulo
11.08.02.2011|Ulee Reuleung
11.08.02.2012|Geulumpang Sulu Timu
11.08.02.2013|Geulumpang Sulu Barat
11.08.02.2014|Bluka Teubai
11.08.02.2015|Lancang Barat
11.08.03.2001|Meunasah Blang Ara
11.08.03.2002|Meunasah Buket
11.08.03.2003|Blang Talon
11.08.03.2004|Cot Rheu
11.08.03.2005|Krueng Manyang
11.08.03.2006|Bayu
11.08.03.2007|Blang Ado
11.08.03.2008|Dayah Meunara
11.08.03.2009|Meunasah Kumbang
11.08.03.2010|Meunye Cut Bahagia
11.08.03.2011|Lhok Jok
11.08.03.2012|Alue Rambee
11.08.03.2013|Blang Riek
11.08.03.2014|Cempeudak
11.08.03.2015|Seuneubok Drien
11.08.03.2016|Cot Merbo
11.08.03.2017|Keude Blang Ara
11.08.03.2018|Keude Krueng
11.08.03.2019|Krueng Seunong
11.08.03.2020|Pulo Iboih
11.08.03.2021|Blang Gurah
11.08.03.2022|Guha Uleu
11.08.03.2023|Ceumeucet
11.08.03.2024|Pulo Barat
11.08.03.2025|Pulo Rayeuk
11.08.03.2026|Cot Seutui
11.08.03.2027|Langkuta
11.08.03.2028|Saweuk
11.08.03.2029|Meuria
11.08.03.2030|Meunasah Kulam
11.08.03.2031|Cot Seumiyong
11.08.03.2032|Keureusek
11.08.03.2033|Krueng Seupeng
11.08.03.2034|Muling Manyang
11.08.03.2035|Muling Meucat
11.08.03.2036|Babah Lueng
11.08.03.2037|Panton Rayeuk I
11.08.03.2038|Panton Rayeuk II
11.08.03.2039|Sido Muliyo
11.08.04.2001|Kuta Lhoksukon
11.08.04.2002|Cot U Sibak
11.08.04.2003|Bintang Hu
11.08.04.2004|Blang Aman
11.08.04.2005|Cot Ara
11.08.04.2006|Blang Rubek
11.08.04.2007|Nga Matang Ubi
11.08.04.2008|Meunasah Reudeup
11.08.04.2009|Alue Buket
11.08.04.2010|Meunye Matang Ubi
11.08.04.2011|Trieng Matang Ubi
11.08.04.2012|Ceubrek
11.08.04.2013|Meunasah Blang
11.08.04.2014|Buket Seuntang
11.08.04.2015|Meunasah Arongan AB
11.08.04.2016|Trieng Pantang
11.08.04.2017|Meunasah Leubok AB
11.08.04.2018|Cot Glumpang AB
11.08.04.2019|Abeuk Leupon
11.08.04.2020|Ara AB
11.08.04.2021|Mancang
11.08.04.2022|Matang Pupanji AB
11.08.04.2023|Meunasah Asan AB
11.08.04.2024|Matang Teungoh AB
11.08.04.2025|Pante
11.08.04.2026|Rambot
11.08.04.2027|Meunasah Alue Drien LB
11.08.04.2028|Alue Mudem
11.08.04.2029|Meunasah Geulinggang
11.08.04.2030|Meunasah Asan LB
11.08.04.2031|Beringin LB
11.08.04.2032|Meunasah Teungoh LB
11.08.04.2033|Meunasah Rayeuk LB
11.08.04.2034|Meunasah Ulee Barat
11.08.04.2035|Meunasah Ranto
11.08.04.2036|Meunasah Tutong
11.08.04.2037|Meunasah Nga LB
11.08.04.2038|Keutapang
11.08.04.2039|Matang Munjee
11.08.04.2040|Pulo Dulang
11.08.04.2041|Dayah LB
11.08.04.2042|Meunasah Geumata
11.08.04.2043|Meunasah Meureubo
11.08.04.2044|Meunasah Dayah LT
11.08.04.2045|Arongan LT
11.08.04.2046|Meunasah Tuha
11.08.04.2047|Meunasah Krueng LT
11.08.04.2048|Babah Geudeubang
11.08.04.2049|Grong-grong
11.08.04.2050|Alue Itam Reudeup
11.08.04.2051|Teupin Keubeu
11.08.04.2052|Meunasah Nga LT
11.08.04.2053|Meunasah Meuria
11.08.04.2054|Kumbang LT
11.08.04.2055|Seuneubok Dalam
11.08.04.2056|Alue Eumpok
11.08.04.2057|Meunasah Jok
11.08.04.2058|Manyang
11.08.04.2059|Lhok Kareung
11.08.04.2060|Cot Asan
11.08.04.2061|Alue Abee
11.08.04.2062|Buloh LT
11.08.04.2063|Geulumpang
11.08.04.2064|Meunasah Teungoh LT
11.08.04.2065|Mata U
11.08.04.2066|Meucat
11.08.04.2067|Buket Mee LT
11.08.04.2068|Ulee Tanoh
11.08.04.2069|Buket Krueng
11.08.04.2070|Ulee Gunong
11.08.04.2071|Lhok Seuntang
11.08.04.2072|Alue Itam Baroh
11.08.04.2073|Mata Ie
11.08.04.2074|Rawa
11.08.04.2075|Buket Hagu
11.08.05.2001|Keude Matangkuli
11.08.05.2002|Ude
11.08.05.2003|Blang Matangkuli
11.08.05.2004|Rayeuk Matangkuli
11.08.05.2005|Tumpok Perlak
11.08.05.2006|Ujong Kulam
11.08.05.2007|Tanjong Teungku Ali
11.08.05.2008|Rayeuk Glang Glong
11.08.05.2009|Punti Geulumpang VII
11.08.05.2010|Geulumpang VII
11.08.05.2011|Teungoh Glumpang VII
11.08.05.2012|Aron Geulumpang VII
11.08.05.2013|Matang Munye
11.08.05.2014|Parang Sikureung
11.08.05.2015|Baro
11.08.05.2016|Mee
11.08.05.2017|Tanjong Babah Krueng
11.08.05.2018|Punti Matangkuli
11.08.05.2019|Teupin Keubeu
11.08.05.2020|Trieng Teupin Keubeu
11.08.05.2021|Matang Mee
11.08.05.2022|Jeumpa Geulumpang VII
11.08.05.2034|Tumpok Barat
11.08.05.2035|Meuria Matangkuli
11.08.05.2036|Hagu
11.08.05.2037|Alue Tho
11.08.05.2039|Ceubrek Pirak
11.08.05.2040|Rayeuk Pirak
11.08.05.2041|Aron Pirak
11.08.05.2042|Lawang
11.08.05.2043|Tanjong Haji Muda
11.08.05.2044|Siren
11.08.05.2045|Meunye Pirak
11.08.05.2046|Beuringen Pirak
11.08.05.2047|Teungoh Pirak
11.08.05.2048|Mesjid Pirak
11.08.05.2049|Matang Peusangan
11.08.05.2050|Pante Pirak
11.08.05.2052|Leubok Pirak
11.08.05.2053|Blang Kuta
11.08.05.2054|Blang Supeng
11.08.05.2055|Beurancan Pirak
11.08.05.2066|Alue Entok
11.08.05.2067|Tanjong Teungku Kari
11.08.05.2068|Teungoh Seuleumak
11.08.05.2069|Seuriweuk
11.08.05.2070|Dayah Baro
11.08.05.2071|Kunyet Mulee
11.08.05.2072|Tutong
11.08.06.2001|Keude Mane
11.08.06.2002|Meunasah Drang
11.08.06.2003|Meunasah Baro
11.08.06.2004|Meunasah Lhok
11.08.06.2005|Cot Seurani
11.08.06.2006|Mane Tunong
11.08.06.2007|Kuala Dua
11.08.06.2008|Meunasah Pinto
11.08.06.2009|Keude Bungkaih
11.08.06.2010|Kambam
11.08.06.2011|Meunasah Aron
11.08.06.2012|Cot Trueng
11.08.06.2013|Dakuta
11.08.06.2014|Paloh Awe
11.08.06.2015|Tanoh Anoe
11.08.06.2016|Pante Gurah
11.08.06.2017|Teupin Banja
11.08.06.2018|Teumpok Beurandang
11.08.06.2019|Paloh Raya
11.08.06.2020|Panigah
11.08.06.2021|Ulee Madon
11.08.06.2022|Reuleut Timu
11.08.06.2023|Reuleut Barat
11.08.06.2024|Pinto Makmur
11.08.07.2001|Dayah Bluek
11.08.07.2002|Mesjid Bluek
11.08.07.2003|Meuria Bluek
11.08.07.2004|Rheng Bluek
11.08.07.2005|Pulo Bluek
11.08.07.2006|Rangkileh
11.08.07.2007|Rayeuk Matang
11.08.07.2008|Ulee Meuria
11.08.07.2009|Tanjong
11.08.07.2010|Keude Karieng
11.08.07.2011|Manyang
11.08.07.2012|Ulee Ceubrek
11.08.07.2013|Teumpok Teungku
11.08.07.2014|Geulumpang
11.08.07.2015|Reudeup
11.08.07.2016|Barat Paya Itek
11.08.07.2017|Paya Kambuk
11.08.07.2018|Paya Bili
11.08.07.2019|Meunasah Mee
11.08.07.2020|Meunasah Nga
11.08.07.2021|Ubit Paya Itek
11.08.07.2022|Rayeuk Paya Itek
11.08.07.2023|Blang Cut
11.08.07.2024|Keeh
11.08.07.2025|Kumbang
11.08.07.2026|Pri Keutapang
11.08.07.2027|Mesjid
11.08.07.2028|Teungoh Reuba
11.08.07.2029|Blang Reuma
11.08.07.2030|Drien Puntong
11.08.07.2031|Pulo Kitou
11.08.07.2032|Ceubrek
11.08.07.2033|Meunye Peut
11.08.07.2034|Beuringen
11.08.07.2035|Nibong
11.08.07.2036|Tualang
11.08.07.2037|Pulo Drien Beukah
11.08.07.2038|Teungoh Kuta Batee
11.08.07.2039|Ujung Kuta Batee
11.08.07.2040|Pulo Blang
11.08.07.2041|Leubok Tuwe
11.08.07.2042|Baroh Kuta Batee
11.08.07.2043|Gampong Teungoh
11.08.07.2044|Ranto
11.08.07.2045|Meunye Payong
11.08.07.2046|Ujong Reuba
11.08.07.2047|Paya Sutra
11.08.07.2048|Baree Blang
11.08.07.2049|Keude Jungka Gajah
11.08.07.2050|Saramaba
11.08.08.2001|Pie
11.08.08.2002|Asan
11.08.08.2003|Murong
11.08.08.2004|Blang Kabu
11.08.08.2005|Mancang
11.08.08.2006|Keude Geudong
11.08.08.2007|Blang Peuria
11.08.08.2008|Teupin Ara
11.08.08.2009|Teupin Beulangan
11.08.08.2010|Krueng Baro Langgahan
11.08.08.2011|Pusong
11.08.08.2012|Tanjong Kleng
11.08.08.2013|Gampong Baro
11.08.08.2014|Beuringen
11.08.08.2015|Kuta Krueng
11.08.08.2016|Kuta Glumpang
11.08.08.2017|Meucat
11.08.08.2018|Krueng Baro Blang Mee
11.08.08.2019|Ujong
11.08.08.2020|Mesjid
11.08.08.2021|Teungoh
11.08.08.2022|Keude Blang Mee Pulo Klat
11.08.08.2023|Puuk
11.08.08.2024|Lancang
11.08.08.2025|Matang Ulim
11.08.08.2026|Sawang
11.08.08.2027|Laga Baro
11.08.08.2028|Pulo
11.08.08.2029|Matang Tunong
11.08.08.2030|Matang Puntong
11.08.08.2031|Blang Nibong
11.08.08.2032|Tanjong Baroh
11.08.08.2033|Tanjong Hagu
11.08.08.2034|Tanjong Reungkam
11.08.08.2035|Tanjong Mesjid
11.08.08.2036|Paya Terbang
11.08.08.2037|Madan
11.08.08.2038|Tanjong Awe
11.08.08.2039|Kitou
11.08.08.2040|Krueng Matee
11.08.09.2001|Tanjong Pineung
11.08.09.2002|Meurubo Puntong
11.08.09.2003|Mane Kawan
11.08.09.2004|Alue Barueh
11.08.09.2005|Keude Simpang Jalan
11.08.09.2006|Blang Pha
11.08.09.2007|Alue Kiran
11.08.09.2008|Blang Tue
11.08.09.2009|Cot Kafiraton
11.08.09.2010|Tanjong Dama
11.08.09.2011|Paya Dua Uram
11.08.09.2012|Paya Dua Ujong
11.08.09.2013|Alue Capli
11.08.09.2014|Simpang Peut
11.08.09.2015|Meunasah Sagoe
11.08.09.2016|Matang Puntong
11.08.09.2017|Matang Panyang
11.08.09.2018|Cot Patisah
11.08.09.2019|Cot Trueng
11.08.09.2020|Darul Aman
11.08.09.2021|Matang Jeulikat
11.08.09.2022|Lhok Puuk
11.08.09.2023|Ulee Rubek Barat
11.08.09.2024|Ulee Rubek Timu
11.08.09.2025|Bantayan
11.08.09.2026|Teupin Kuyuen
11.08.09.2027|Matang Lada
11.08.09.2028|Ulee Matang
11.08.09.2029|Matang Karieng
11.08.09.2030|Lhok Rambideng
11.08.09.2031|Matang Anoe
11.08.09.2032|Lhok Geulituet
11.08.09.2033|Ulee Titi
11.08.10.2001|Keude Aron
11.08.10.2002|Dayah Aron
11.08.10.2003|Moncrang
11.08.10.2004|Kanot
11.08.10.2005|Meuria Aron
11.08.10.2006|Mee Aron
11.08.10.2007|Glok
11.08.10.2008|Cibrek Baroh
11.08.10.2009|Cibrek Tunong
11.08.10.2010|Matang Munye
11.08.10.2011|Pante
11.08.10.2012|Keutapang
11.08.10.2013|Blang
11.08.10.2014|Teungoh
11.08.10.2015|Tanjong Krueng Pase
11.08.10.2016|Mesjid
11.08.10.2017|Keude Teupin Punti
11.08.10.2018|Kumbang
11.08.10.2019|Gampong U
11.08.10.2020|Calong
11.08.10.2021|Manyang Baroh
11.08.10.2022|Peurupok
11.08.10.2023|Alue Gunto
11.08.10.2024|Pulo
11.08.10.2025|Kulam
11.08.10.2026|Ampeh
11.08.10.2027|Dayah Meuria
11.08.10.2028|Mampree
11.08.10.2029|Meucat
11.08.10.2030|Ara
11.08.10.2031|Hagu
11.08.10.2032|Awe
11.08.10.2033|Tanjong Mulieng
11.08.10.2034|Dayah Teungku
11.08.11.2001|Bale
11.08.11.2002|Bie
11.08.11.2003|Beurandang
11.08.11.2004|Baro Kulam Gajah
11.08.11.2005|Glong
11.08.11.2006|Nibong
11.08.11.2007|Langa
11.08.11.2008|Beunot
11.08.11.2009|Keude Bayu
11.08.11.2010|Blang Bayu
11.08.11.2011|Dayah Tuha
11.08.11.2012|Dayah Baro
11.08.11.2013|Lancok
11.08.11.2014|Punti
11.08.11.2015|Bungong
11.08.11.2016|Baroh Blang Rimueng
11.08.11.2017|Ulee Meuria
11.08.11.2018|Kayee Panyang
11.08.11.2019|Rheng
11.08.11.2020|Trieng Meudurou
11.08.11.2021|Ulee Gampong
11.08.11.2022|Garut
11.08.11.2023|Blang Awe
11.08.11.2024|Pulo Blang Mangat
11.08.11.2025|Cibrek
11.08.11.2026|Pulo Blang Trieng
11.08.11.2027|Meudang Ara
11.08.11.2028|Cot Neuheun
11.08.11.2029|Tumpeun
11.08.11.2030|Alen
11.08.11.2031|Dayah Blang Seureukuy
11.08.11.2032|Blang Patra
11.08.11.2033|Blang Majron
11.08.11.2034|Seuneubok Baro
11.08.11.2035|Buket Glumpang
11.08.11.2037|Alue Majron
11.08.11.2038|Siren Tujoh
11.08.11.2047|Blang Seureukuy
11.08.12.2001|Pulo Blang
11.08.12.2002|Matang Ben
11.08.12.2003|Matang Cibrek
11.08.12.2004|Deng
11.08.12.2005|Rawa
11.08.12.2006|Punti Pulo Agam
11.08.12.2007|Alue Pangkat
11.08.12.2008|Teungoh Pulo Agam
11.08.12.2009|Hueng
11.08.12.2010|Pulo U
11.08.12.2011|Alue Keujruen
11.08.12.2012|Paya Beurandang
11.08.12.2013|Manyang Tunong
11.08.12.2014|Meunasah Tutong
11.08.12.2015|Ampeh
11.08.12.2016|Alue
11.08.12.2017|Teungku Dibalee
11.08.12.2018|Keude Blang Jruen
11.08.12.2019|Blang Jruen
11.08.12.2020|Ujong Baroh Berghang
11.08.12.2021|Jeumpa Berghang
11.08.12.2022|Teungoh Berghang
11.08.12.2023|Pante Berghang
11.08.12.2024|Serba Jaman
11.08.12.2025|Rayeuk Naleung
11.08.12.2026|Rangkaya
11.08.12.2027|Paya
11.08.12.2028|Blang Bidok
11.08.12.2029|Rayeuk Kuta
11.08.12.2030|Rayeuk Meunye
11.08.12.2031|Ujong Baroh SB
11.08.12.2032|Trieng
11.08.12.2033|Manyang SB
11.08.12.2034|Cibrek
11.08.12.2035|Keutapang
11.08.12.2036|Matang Mane
11.08.12.2037|Alue Gampong
11.08.12.2038|Bayi
11.08.12.2039|Tumpok Aceh
11.08.12.2040|Ulee Buket
11.08.12.2041|Cot Dah
11.08.12.2042|Leupon Siren
11.08.12.2043|Blang Trieng
11.08.12.2044|Alue Sijuek
11.08.12.2045|Hagu
11.08.12.2046|Teupin Mee
11.08.12.2047|Plu Pakam
11.08.12.2048|Blang Pie
11.08.12.2049|Punti Seuleumak Barat
11.08.12.2050|Serba Jaman Tunong
11.08.12.2051|Leuhong
11.08.12.2052|Blang
11.08.12.2053|Tanjong Mesjid
11.08.12.2054|Serba Jaman Baroh
11.08.12.2055|Cot Barat
11.08.12.2056|Matang Baloy
11.08.12.2057|Buket Makarti
11.08.13.2001|Alue
11.08.13.2002|Mee Matang Panyang
11.08.13.2003|Blang
11.08.13.2004|Paloh
11.08.13.2005|Keude Matang Payang
11.08.13.2006|Gampong Pande
11.08.13.2007|Matang Ranup Laseh
11.08.13.2008|Cangguek
11.08.13.2009|Kumbang
11.08.13.2010|Prie
11.08.13.2011|Keutapang
11.08.13.2012|Keude Jrat Manyang
11.08.13.2013|Teupin Gapeuh
11.08.13.2014|Cibrek
11.08.13.2015|Me Merbo
11.08.13.2016|Ulee Tanoh
11.08.13.2017|Matang Janeng
11.08.13.2018|Kuala Keureutou Barat
11.08.14.2001|Teupin Gajah
11.08.14.2002|Geulumpang Umpung Unou
11.08.14.2003|Ranto Panyang
11.08.14.2004|Seuneubok Doe
11.08.14.2005|Meunasah Geudong
11.08.14.2006|Meunasah Merbo
11.08.14.2007|Tanjong Meunye
11.08.14.2008|Matang Jurong
11.08.14.2009|Tanjong Dalam Utara
11.08.14.2010|Meunasah Dayah
11.08.14.2011|Seuneubok Pidie
11.08.14.2012|Tanjong Menuang
11.08.14.2013|Matang Teungoh-Teungoh
11.08.14.2014|Lhok Reudeup
11.08.14.2015|Lhok Merbo
11.08.14.2016|Tanjong Ara
11.08.14.2017|Alue Ie Mirah
11.08.14.2018|Tanjong Punti
11.08.14.2019|Buket Alue Puteh
11.08.14.2020|Buket Jrat Manyang
11.08.14.2021|Matang Maneh
11.08.14.2022|Pucok Alue
11.08.14.2023|Matang Serdang
11.08.14.2024|Matang Santot
11.08.14.2025|Buket Padang
11.08.14.2026|Matang Seuke Pulot
11.08.14.2027|Lhok Beuringen
11.08.14.2028|Lueng Tuha
11.08.14.2029|Matang Raya
11.08.14.2030|Tanjong Ceungai
11.08.14.2031|Teupin Bayu
11.08.14.2032|Meunasah Panton Labu
11.08.14.2033|Kota Panton Labu
11.08.14.2034|Rawang Itek
11.08.14.2035|Samakurok
11.08.14.2036|Biara Barat
11.08.14.2037|Biara Timur
11.08.14.2038|Matang Drien
11.08.14.2039|Ceumpeudak
11.08.14.2040|Alue Papeun
11.08.14.2041|Lhok Bintang Hu
11.08.14.2042|Biram Rayeuk
11.08.14.2043|Cot Biek
11.08.14.2044|Matang Arongan
11.08.14.2045|Biram Cut
11.08.14.2046|Buket Batee Badan
11.08.14.2047|Ulee Glee
11.08.15.2001|Lagang
11.08.15.2002|Abeuk Reuling
11.08.15.2003|Lhok Krek
11.08.15.2004|Lhok Merbo
11.08.15.2005|Gle Dagang
11.08.15.2006|Kuta Meuligoe
11.08.15.2007|Gampong Teungoh
11.08.15.2008|Babah Buloh
11.08.15.2009|Meunasah Pulo
11.08.15.2010|Punteuet
11.08.15.2011|Pante Jaloh
11.08.15.2012|Lhok Kuyun
11.08.15.2013|Blang Reuling
11.08.15.2014|Lhok Gajah
11.08.15.2015|Teupin Rusep
11.08.15.2016|Ulee Geudong
11.08.15.2017|Tanjong Keumala
11.08.15.2018|Cot Kumuneng
11.08.15.2019|Cot Lambideng
11.08.15.2020|Paya Gaboh
11.08.15.2021|Paya Rabo Lhok
11.08.15.2022|Paya Rabo Timu
11.08.15.2023|Lancok
11.08.15.2024|Rambong Payong
11.08.15.2025|Lhok Bayu
11.08.15.2026|Krueng Baro
11.08.15.2027|Babah Krueng
11.08.15.2028|Jurong
11.08.15.2029|Blang Manyak
11.08.15.2030|Lhok Jok
11.08.15.2031|Blang Teurakan
11.08.15.2032|Sawang
11.08.15.2033|Riseh Baroh
11.08.15.2034|Riseh Teungoh
11.08.15.2035|Riseh Tunong
11.08.15.2036|Gunci
11.08.15.2037|Kubu
11.08.15.2038|Blang Cut
11.08.15.2039|Lhok Cut
11.08.16.2015|Paloh Mambu
11.08.16.2017|Blang Karieng
11.08.16.2018|Paloh Kayee Kunyet
11.08.16.2019|Gampong Barat
11.08.16.2020|Meunasah Beunot
11.08.16.2021|Seuneubok
11.08.16.2022|Cot Leupee
11.08.16.2023|Gampong Teungoh
11.08.16.2024|Meunasah Meucat
11.08.16.2025|Meunasah Alue
11.08.16.2026|Panton
11.08.16.2027|Paloh Mampree
11.08.16.2028|Peunayan
11.08.16.2029|Tingkeum
11.08.16.2030|Meunasah Rayeuk
11.08.16.2031|Meunasah Cut
11.08.16.2032|Jeulikat
11.08.16.2033|Alue Bili
11.08.16.2034|Cot Mambong
11.08.16.2035|Blang Dalam Geunteng
11.08.16.2036|Blang Dalam Tunong
11.08.16.2037|Blang Dalam Baroh
11.08.16.2038|Cot Mee
11.08.16.2039|Cot Euntung
11.08.16.2040|Blang Crok
11.08.16.2041|Meunasah Krueng
11.08.16.2042|Binjee
11.08.16.2043|Keutapang
11.08.16.2044|Ulee Blang
11.08.17.2001|Cot Girek
11.08.17.2002|Lhok Meurbo
11.08.17.2003|Kp. Bantan
11.08.17.2004|Alue Seumambu
11.08.17.2005|Ulee Gampong
11.08.17.2006|Batu XII
11.08.17.2007|Kp. Tempel
11.08.17.2008|Alue Leuhob
11.08.17.2009|Seuneubok Baro
11.08.17.2010|Alue Drien
11.08.17.2011|Cempeudak
11.08.17.2012|Matang Teungoh
11.08.17.2013|Pucok Alue
11.08.17.2014|U Baro
11.08.17.2015|Trieng
11.08.17.2016|Lhok Reuhat
11.08.17.2017|Lueng Baro
11.08.17.2018|Jeulikat
11.08.17.2019|Gampong Ara
11.08.17.2020|Beurandang Dayah
11.08.17.2021|Beurandang Krueng
11.08.17.2022|Seupeng
11.08.17.2023|Beurandang Asan
11.08.17.2024|Drien II
11.08.18.2001|Cot Bada
11.08.18.2002|Alue Dua
11.08.18.2003|Bantayan
11.08.18.2004|Kampong Blang
11.08.18.2005|Paya Tukai
11.08.18.2006|Matang Keutapang
11.08.18.2007|Krueng Lingka
11.08.18.2008|Simpang Tiga
11.08.18.2009|Matang Rubek
11.08.18.2010|Leubok Mane
11.08.18.2011|Matang Teungoh Selatan
11.08.18.2012|Padang Meuria
11.08.18.2013|Alue Krak Kayee
11.08.18.2014|Tanjong Jawa
11.08.18.2015|Meunasah Blang
11.08.18.2016|Tanjong Dalam Selatan
11.08.18.2017|Geudumbak
11.08.18.2018|Langkahan
11.08.18.2019|Rumoh Rayeuk
11.08.18.2020|Buket Linteung
11.08.18.2021|Lubok Pusaka
11.08.18.2022|Seureuke
11.08.18.2023|Pante Gaki Bale
11.08.19.2001|Keude Sampoiniet
11.08.19.2002|Lhok Iboh
11.08.19.2003|Matang Bayu
11.08.19.2004|Lang Nibong
11.08.19.2005|Blang Seunong
11.08.19.2006|Singgah Mata
11.08.19.2007|Matang Panyang
11.08.19.2008|Matang Ceubrek
11.08.19.2009|Matang Teungoh
11.08.19.2010|Cot Paya
11.08.19.2011|Cot Kupok
11.08.19.2012|Matang Raya Blang Sialet
11.08.19.2013|Pucok Alue Buket
11.08.19.2014|Matang Sijuek Timu
11.08.19.2015|Matang Sijuek Teungoh
11.08.19.2016|Matang Sijuek Barat
11.08.19.2017|Cot Laba
11.08.19.2018|Meunasah Pante
11.08.19.2019|Meurandeh Paya
11.08.19.2020|Cot Murong
11.08.19.2021|Matang Paya
11.08.19.2022|Lhok Euncien
11.08.19.2023|Cot Usen
11.08.19.2024|Meunasah Hagu
11.08.19.2025|Blang Rheue
11.08.19.2026|Paya Bateung
11.08.20.2001|Blang Ara
11.08.20.2002|Tgk.Dibanda Pirak
11.08.20.2003|Paya Meudru
11.08.20.2004|Blang Sialet
11.08.20.2005|Buket Guru
11.08.20.2006|Geulumpang Pirak
11.08.20.2007|Alue Lhok
11.08.20.2008|Seuneubok Aceh
11.08.20.2009|Buket Pidie
11.08.20.2010|Kebon Pirak
11.08.20.2011|Alue Leukot
11.08.20.2012|Blang Mane
11.08.20.2013|Peureupok
11.08.20.2014|Alue Bieng
11.08.20.2015|Pante Seuleumak
11.08.20.2016|Meuria Seuleumak
11.08.20.2017|Tunong Krueng
11.08.20.2018|Geureughek
11.08.20.2019|Meunye Seuleumak
11.08.20.2020|Simpang
11.08.20.2021|Tumpok Mesjid
11.08.20.2022|Jok
11.08.20.2023|Leuhong
11.08.20.2024|Tanjong Burunyong
11.08.20.2025|Keude Paya Bakong
11.08.20.2026|Blang Gunci
11.08.20.2027|Gampong Nga
11.08.20.2028|Mampree
11.08.20.2029|Matang Panyang
11.08.20.2030|Tanjong Drieng
11.08.20.2031|Asan Seuleumak
11.08.20.2032|Tgk. Dibanda Tek-Tek
11.08.20.2033|Cot Teufah
11.08.20.2034|Pucok Alue Seuleumak
11.08.20.2035|Lueng
11.08.20.2036|Cempeudak
11.08.20.2037|Blang Paku
11.08.20.2038|Blang Dalam
11.08.20.2039|Blang Pante
11.08.21.2001|Nibong Baroh
11.08.21.2002|Nibong Wakheuh
11.08.21.2003|Keude Nibong
11.08.21.2004|Keupok Nibong
11.08.21.2005|Dayah Nibong
11.08.21.2006|Sumbok Rayeuk
11.08.21.2007|Paya Terbang
11.08.21.2008|Teupin Jok
11.08.21.2009|Mamplam
11.08.21.2010|Keulilee
11.08.21.2011|Meunye Lhee
11.08.21.2012|Ranto
11.08.21.2013|Seulunyok
11.08.21.2014|Keh Nibong
11.08.21.2015|Alue Ie Mirah
11.08.21.2016|Maddi
11.08.21.2017|Alue Ngom
11.08.21.2018|Tanjong Putoh
11.08.21.2019|Bumban
11.08.21.2020|Alue Panah
11.08.22.2001|Keude Simpang Empat
11.08.22.2002|Seunebok Punti
11.08.22.2003|Paya Leupah
11.08.22.2004|Paya Teungoh
11.08.22.2005|Keubon Baro
11.08.22.2006|Meunasah Teungoh
11.08.22.2007|Meunasah Baroh
11.08.22.2008|Mancang
11.08.22.2009|Alue Bade
11.08.22.2010|Meunasah Dayah SPK
11.08.22.2011|Kilometer VI
11.08.22.2012|Kilometer VIII
11.08.22.2013|Ie Tarek I
11.08.22.2014|Ie Tarek II
11.08.22.2015|Pase Sentosa
11.08.22.2016|Blang Raleue
11.08.23.2001|Keureutou
11.08.23.2002|Lueng Baro
11.08.23.2003|Merbo Jurong
11.08.23.2004|Merbo Lama
11.08.23.2005|Tanjong Dama
11.08.23.2006|Geulanggang Baro
11.08.23.2007|Matang Tunong
11.08.23.2008|Keude Lapang
11.08.23.2009|Matang Baroh
11.08.23.2010|Kuala Kereuto
11.08.23.2011|Kuala Cangkoy
11.08.24.2001|Rayeuk Pange
11.08.24.2002|Bungong
11.08.24.2003|Geulumpang
11.08.24.2004|Asan Krueng Kreh
11.08.24.2005|Beuracan Rata
11.08.24.2006|Reungkam
11.08.24.2007|Trieng Krueng Kreh
11.08.24.2008|Keutapang
11.08.24.2009|Bili Baro
11.08.24.2010|Paya Lueng Jalo
11.08.24.2011|Alue Rimee
11.08.24.2012|Serdang
11.08.24.2013|Ara Ton-Ton Moncrang
11.08.24.2014|Tanjong Seureukuy
11.08.24.2015|Ulee Blang
11.08.24.2016|Krueng Pirak
11.08.24.2017|Matang Keh
11.08.24.2018|Leupe
11.08.24.2019|Ceumeucet
11.08.24.2020|Teupin U
11.08.24.2021|Alue Bungkoh
11.08.24.2022|Pucok Alue
11.08.24.2023|Meunye Tujoh
11.08.25.2001|Lhok Asan
11.08.25.2002|Darul Aman
11.08.25.2003|Alue Awe
11.08.25.2004|Darussalam
11.08.25.2005|Rayeuk Jawa
11.08.25.2006|Dayah Seupeng
11.08.25.2007|Uram Jalan
11.08.25.2008|Peudari
11.08.25.2009|Krueng Mbang
11.08.25.2010|Pulo Meuria
11.08.25.2011|Suka Damai
11.08.26.2001|Paya Dua
11.08.26.2002|Cot Jabet
11.08.26.2003|Ulee Nyeue
11.08.26.2004|Paya Uleue
11.08.26.2005|Jamuan
11.08.26.2006|Alue Keurinyai
11.08.26.2007|Sangkelan
11.08.26.2008|Blang Pala
11.08.26.2009|Paya Beunyot
11.08.27.2001|Alue Dua
11.08.27.2002|Seumirah
11.08.27.2003|Darussalam
11.08.27.2004|Alue Papeun
11.08.27.2005|Blang Jrat
11.08.27.2006|Blang Pohroh
11.09.01.2007|Wel Wel
11.09.01.2008|Kampung Aie
11.09.01.2009|Lauree
11.09.01.2010|Lamayang
11.09.01.2011|Lakubang
11.09.01.2012|Lambaya
11.09.01.2013|Dihit
11.09.01.2016|Latitik
11.09.01.2017|Wellangkum
11.09.01.2018|Kuta Baru
11.09.01.2019|Sebbe
11.09.01.2020|Suak Baru
11.09.01.2021|Luan Sorep
11.09.01.2022|Putra Jaya
11.09.01.2023|Lauke
11.09.01.2024|Situfa Jaya
11.09.02.2001|Ujung Salang
11.09.02.2002|Padang Unoi
11.09.02.2003|Nasreuhe
11.09.02.2004|Meunafa
11.09.02.2005|Along
11.09.02.2006|Panton Lawe
11.09.02.2007|Mutiara
11.09.02.2008|Tamon Jaya
11.09.02.2009|Karya Bakti
11.09.02.2010|Jaya Baru
11.09.02.2011|Tameng
11.09.02.2012|Lalla Bahagia
11.09.02.2013|Suak Manang
11.09.02.2014|Ganang Pusako
11.09.02.2015|Kenangan Jaya
11.09.02.2016|Bunga
11.09.03.2001|Silengas
11.09.03.2002|Bunon
11.09.03.2003|Angkeo
11.09.03.2004|Awe Seubal
11.09.03.2005|Laayon
11.09.03.2006|Inor
11.09.03.2007|Salur Lasengalu
11.09.03.2008|Salur Latun
11.09.03.2009|Salur
11.09.03.2010|Pulau Teupah
11.09.03.2011|Awe Kecil
11.09.03.2012|Naibos
11.09.03.2013|Lantik
11.09.03.2014|Leubang Hulu
11.09.03.2015|Leubang
11.09.03.2016|Sital
11.09.03.2017|Maudil
11.09.03.2018|Nancala
11.09.04.2009|Suak Buluh
11.09.04.2012|Air Dingin
11.09.04.2013|Ameria Bahagia
11.09.04.2014|Suka Jaya
11.09.04.2015|Suka Maju
11.09.04.2016|Suka Karya
11.09.04.2017|Sinabang
11.09.04.2018|Amaiteng Mulia
11.09.04.2019|Lugu
11.09.04.2020|Sefoyan
11.09.04.2021|Ganting
11.09.04.2022|Kuala Makmur
11.09.04.2023|Ujung Tinggi
11.09.04.2024|Air Pinang
11.09.04.2025|Pulau Siumat
11.09.04.2026|Kota Batu
11.09.04.2028|Linggi
11.09.05.2001|Babussalam
11.09.05.2002|Muara Aman
11.09.05.2003|Gunung Putih
11.09.05.2004|Lugu Sebahak
11.09.05.2005|Kuala Bakti
11.09.05.2006|Bulu Hadik
11.09.05.2007|Sambay
11.09.05.2008|Luan Balu
11.09.05.2009|Tanjung Raya
11.09.05.2010|Kuala Baru
11.09.06.2001|Layabaung
11.09.06.2002|Sembilan
11.09.06.2003|Sigulai
11.09.06.2004|Sinar Bahagia
11.09.06.2005|Lamamek
11.09.06.2006|Batu Ragi
11.09.06.2007|Malasin
11.09.06.2008|Babul Makmur
11.09.06.2009|Amabaan
11.09.06.2010|Miteum
11.09.06.2011|Lhok Bikhau
11.09.06.2012|Ujung Harapan
11.09.06.2013|Sanggiran
11.09.06.2014|Lhok Makmur
11.09.07.2001|Seneubuk
11.09.07.2002|Suak Lamatan
11.09.07.2003|Alus Alus
11.09.07.2004|Batu Ralang
11.09.07.2005|Ulul Mayang
11.09.07.2006|Kebun Baru
11.09.07.2007|Badegong
11.09.07.2008|Latiung
11.09.07.2009|Pasir Tinggi
11.09.07.2010|Labuhan Jaya
11.09.07.2011|Labuhan Bajau
11.09.07.2012|Blang Sebel
11.09.07.2013|Ana Ao
11.09.07.2014|Lataling
11.09.07.2015|Pulau Bangkalak
11.09.07.2016|Labuhan Bakti
11.09.07.2017|Trans Jernge
11.09.07.2018|Trans Meranti
11.09.07.2019|Trans Baru
11.09.08.2001|Lewak
11.09.08.2002|Lamerem
11.09.08.2003|Lhok Pauh
11.09.08.2004|Serafon
11.09.08.2005|Langi
11.09.08.2006|Lubuk Baik
11.09.08.2007|Lhok Dalam
11.09.08.2008|Lafakha
11.09.09.2001|Matanurung
11.09.09.2002|Lasikin
11.09.09.2003|Lanting
11.09.09.2004|Busung Indah
11.09.09.2005|Kahad
11.09.09.2006|Simpang Abail
11.09.09.2007|Abail
11.09.09.2008|Nancawa
11.09.09.2009|Labuah
11.09.09.2010|Sua-Sua
11.09.09.2011|Batu-Batu
11.09.09.2012|Situbuk
11.09.10.2001|Bubuhan
11.09.10.2002|Amarabu
11.09.10.2003|Kuta Inang
11.09.10.2004|Kuta Padang
11.09.10.2005|Sibuluh
11.09.10.2006|Latak Ayah
11.09.10.2007|Borengan
11.09.10.2008|Ujung Padang
11.10.01.2001|Pulau Balai
11.10.01.2002|Pulau Baguk
11.10.01.2004|Teluk Nibung
11.10.02.2001|Lipat Kajang
11.10.02.2002|Kain Golong
11.10.02.2003|Kuta Kerangan
11.10.02.2004|Siatas
11.10.02.2005|Pangi
11.10.02.2006|Sukarejo
11.10.02.2007|Ujung Limus
11.10.02.2008|Silatong
11.10.02.2009|Pertabas
11.10.02.2010|Lae Riman
11.10.02.2011|Pakiraman
11.10.02.2012|Kuta Batu
11.10.02.2013|Lae Nipe
11.10.02.2014|Kuta Tinggi
11.10.02.2015|Tuhtuhan
11.10.02.2016|Lae Gecih
11.10.02.2017|Guha
11.10.02.2018|Lae Gambir
11.10.02.2019|Cibubukan
11.10.02.2020|Serasah
11.10.02.2021|Tugan
11.10.02.2022|Tanjung Mas
11.10.02.2023|Lipat Kajang Atas
11.10.02.2024|Sidodadi
11.10.02.2025|Pandan Sari
11.10.04.2001|Pasar
11.10.04.2002|Ujung
11.10.04.2003|Pulo Sarok
11.10.04.2004|Kilangan
11.10.04.2005|Kuta Simboling
11.10.04.2007|Teluk Ambun
11.10.04.2008|Rantau Gedang
11.10.04.2009|Teluk Rumbia
11.10.04.2010|Pea Bumbung
11.10.04.2011|Pemuka
11.10.04.2012|Takal pasir
11.10.04.2014|Selok Aceh
11.10.04.2016|Suka Makmur
11.10.04.2017|Ujung Bawang
11.10.04.2019|Siti Ambia
11.10.04.2020|Suka Damai
11.10.06.2001|Tanjung Betik
11.10.06.2002|Penjahitan
11.10.06.2003|Bukit Harapan
11.10.06.2004|Cingkam
11.10.06.2005|Labuhan Kera
11.10.06.2006|Tanah Bara
11.10.06.2007|Rimo
11.10.06.2008|Blok VI Baru
11.10.06.2009|Blok 15
11.10.06.2010|Blok 18
11.10.06.2011|Blok 31
11.10.06.2012|Sidorejo
11.10.06.2013|Suka Makmur
11.10.06.2014|Gunung Lagan
11.10.06.2015|Perangusan
11.10.06.2016|Seping Baru
11.10.06.2017|Sebatang
11.10.06.2018|Tanah Merah
11.10.06.2019|Pertampakan
11.10.06.2020|Pandan Sari
11.10.06.2021|Sanggaberu Silulusan
11.10.06.2022|Tulaan
11.10.06.2023|Tunas Harapan
11.10.06.2024|Lae Butar
11.10.06.2025|Sianjo-Anjo Meriah
11.10.09.2001|Lentong
11.10.09.2002|Lapahan Buaya
11.10.09.2003|Butar
11.10.09.2004|Samar Dua
11.10.09.2005|Ladang Bisik
11.10.09.2006|Muara Pea
11.10.09.2008|Sumber Mukti
11.10.09.2009|Mukti Lincer
11.10.09.2010|Danau Bungara
11.10.10.2001|Gosong Telaga Utara
11.10.10.2002|Gosong Telaga Selatan
11.10.10.2003|Kampung Baru
11.10.10.2004|Ketapang Indah
11.10.10.2005|Gosong Telaga Timur
11.10.10.2006|Gosong Telaga Barat
11.10.10.2007|Telaga Bakti
11.10.11.2001|Lae Balno
11.10.11.2002|Napagaluh
11.10.11.2003|Sikoran
11.10.11.2004|Situbuh-tubuh
11.10.11.2005|Biskang
11.10.11.2006|Sintuban Makmur
11.10.12.2001|Suro Makmur
11.10.12.2002|Pangkalan Sulampi
11.10.12.2003|Bulu Sema
11.10.12.2004|Lae Bangun
11.10.12.2005|Alur Linci
11.10.12.2006|Siompin
11.10.12.2007|Ketangkuhan
11.10.12.2008|Keras
11.10.12.2009|Mandumpang
11.10.12.2010|Sirimo Mungkur
11.10.12.2011|Bulu Ara
11.10.13.2001|Singkohor
11.10.13.2002|Lae Sipola
11.10.13.2003|Lae Pinang
11.10.13.2004|Mukti Jaya
11.10.13.2006|Sri Kayu
11.10.13.2007|Pea Jambu
11.10.14.2001|Kuala Baru Laut
11.10.14.2002|Kuala Baru Sungai
11.10.14.2003|Suka Jaya
11.10.14.2004|Kayu Menang
11.10.16.2001|Haloban
11.10.16.2002|Asantola
11.10.16.2003|Ujung Sialit
11.10.16.2004|Suka Makmur
11.11.01.2001|Keude Aceh
11.11.01.2002|Sangso
11.11.01.2003|Pante Rheng
11.11.01.2004|Meuliek
11.11.01.2005|Namploh Baro
11.11.01.2006|Namploh Manyang
11.11.01.2007|Namploh Blanggarang
11.11.01.2008|Namploh Krueng
11.11.01.2009|Namploh Papeun
11.11.01.2010|Meunasah Lueng
11.11.01.2011|Lhok Seumira
11.11.01.2012|Ulee Jeumatan
11.11.01.2013|Lancok
11.11.01.2014|Paloh
11.11.01.2015|Mesjid Baro
11.11.01.2016|Batee Iliek
11.11.01.2017|Pulo Baroh
11.11.01.2018|Matang Wakeuh
11.11.01.2019|Darussalam
11.11.01.2020|Matang Jareung
11.11.01.2021|Matang
11.11.01.2022|Cot Mane
11.11.01.2023|Alue Barat
11.11.01.2024|Cot Siren
11.11.01.2025|Ulee Alue
11.11.01.2026|Pineung Siribee
11.11.01.2027|Gampong Baro
11.11.01.2028|Kandang
11.11.01.2029|Gampong Putoh
11.11.01.2030|Mideun Jok
11.11.01.2031|Mideun Geudong
11.11.01.2032|Lueng Keubeu
11.11.01.2033|Glumpang Bungkok
11.11.01.2034|Gampong Meulum
11.11.01.2035|Cot Meurak Baroh
11.11.01.2036|Cot Meurak Blang
11.11.01.2037|Meurah
11.11.01.2038|Ulee Ue
11.11.01.2039|Matang Teungoh
11.11.01.2040|Tanjong Baro
11.11.01.2041|Angkieng Barat
11.11.01.2042|Meunasah Lincah
11.11.01.2043|Meunasah Lancok
11.11.01.2044|Meunasah Puuk
11.11.01.2045|Tanjongan Idem
11.11.01.2084|Geulumpang Payong
11.11.02.2018|Blang Me Timu
11.11.02.2019|Lancang
11.11.02.2020|Blang Lancang
11.11.02.2021|Teupin Kupula
11.11.02.2022|Tanjong Bungong
11.11.02.2023|Dayah Baro
11.11.02.2024|Ulee Rabo
11.11.02.2025|Lueng Teungoh
11.11.02.2026|Lampoh Oe
11.11.02.2027|Pulo Rangkileh
11.11.02.2028|Tufah
11.11.02.2029|Sampo Ajad
11.11.02.2030|Darul Aman
11.11.02.2031|Lhok Kulam
11.11.02.2032|Ulee Blang
11.11.02.2033|Uteun Peupaleh
11.11.02.2034|Ulee Gajah
11.11.02.2035|Alue Seutui
11.11.02.2036|Blang Neubok
11.11.02.2037|Matang Bangka
11.11.02.2038|Matang Teungoh
11.11.02.2039|Matang Nibong
11.11.02.2040|Blang Me Barat
11.11.02.2041|Keude Jeunieb
11.11.02.2042|Cot Geulumpang Baroh
11.11.02.2043|Cot Geulumpang Tunong
11.11.02.2044|Meunasah Keutapang
11.11.02.2045|Meunasah Dayah
11.11.02.2046|Lheu Simpang
11.11.02.2047|Lheu Barat
11.11.02.2048|Jeumpa Sikureng
11.11.02.2049|Janggot Seungko
11.11.02.2050|Meunasah Tambo
11.11.02.2051|Meunasah Keupula
11.11.02.2052|Meunasah Tunong Lueng
11.11.02.2053|Meunasah Alue
11.11.02.2054|Blang Pohroh
11.11.02.2057|Meunasah Lueng
11.11.02.2058|Dayah Blang Raleu
11.11.02.2059|Meunasah Blang
11.11.02.2060|Alue Lamsaba
11.11.02.2061|Meunasah Kota
11.11.02.2062|Paya Bili
11.11.03.2001|Lawang
11.11.03.2002|Matang Reuleut
11.11.03.2003|Meunasah Krueng
11.11.03.2004|Cot Keutapang
11.11.03.2005|Meunasah Rabo
11.11.03.2006|Meunasah Tambo
11.11.03.2007|Meunasah Baroh
11.11.03.2008|Meunasah Pulo
11.11.03.2009|Matang Pasi
11.11.03.2010|Blang Kubu
11.11.03.2011|Garot
11.11.03.2012|Ara Bungong
11.11.03.2013|Jabet
11.11.03.2014|Sawang
11.11.03.2015|Blang Beururu
11.11.03.2016|Hagu
11.11.03.2017|Blang Rangkuluh
11.11.03.2018|Meunasah Bungo
11.11.03.2019|Paya Beunot
11.11.03.2020|Meunasah Tunong
11.11.03.2021|Meunasah Alue
11.11.03.2022|Meunasah Cut
11.11.03.2023|Gampong Mesjid
11.11.03.2024|Meunasah Teungoh
11.11.03.2025|Meunasah Blang
11.11.03.2026|Kukue
11.11.03.2027|Blang Matang
11.11.03.2028|Blang Glumpang
11.11.03.2029|Gampong Baro
11.11.03.2030|Gampong Paya
11.11.03.2031|Seuneubok Paya
11.11.03.2032|Pulo Lawang
11.11.03.2033|Keude Alue Rheng
11.11.03.2034|Karieng
11.11.03.2035|Pulo Ara
11.11.03.2036|Cot Laot
11.11.03.2037|Alue Sijuek
11.11.03.2038|Blang Bati
11.11.03.2039|Buket Paya
11.11.03.2040|Dayah Mon Ara
11.11.03.2041|Calok
11.11.03.2042|Cot Kruet
11.11.03.2043|Tanjong Seulamat
11.11.03.2044|Jaba
11.11.03.2045|Alue Gandai
11.11.03.2046|Neubok Naleung
11.11.03.2047|Paya Timu
11.11.03.2048|Gampong Mulia
11.11.03.2049|Pinto Rimba
11.11.03.2050|Alue Keutapang
11.11.03.2051|Tgk. Di Bathon
11.11.03.2052|Paya Barat
11.11.04.2032|Glumpang Payong
11.11.04.2033|Blang Seunong
11.11.04.2034|Cot Leusong
11.11.04.2035|Batee Timoh
11.11.04.2036|Lipah Rayeuk
11.11.04.2037|Cot Geureundong
11.11.04.2038|Lipah Cut
11.11.04.2039|Beurawang
11.11.04.2042|Geudong Tampu
11.11.04.2043|Cot Tarom Baroh
11.11.04.2044|Blang Cot Baroh
11.11.04.2045|Blang Cot Tunong
11.11.04.2046|Seuleumbah
11.11.04.2047|Cot Keutapang
11.11.04.2048|Cot Tarom Tunong
11.11.04.2049|Blang Bladeh
11.11.04.2050|Mon Jambee
11.11.04.2051|Blang Dalam
11.11.04.2052|Kuala Jeumpa
11.11.04.2053|Cot Gadong
11.11.04.2054|Cot Bada
11.11.04.2055|Teupok Baroh
11.11.04.2056|Teupok Tunong
11.11.04.2057|Pulo Lawang
11.11.04.2058|Abeuk Usong
11.11.04.2059|Paloh Seulimeng
11.11.04.2060|Abeuk Tingkeum
11.11.04.2061|Blang Mee
11.11.04.2062|Blang Seupeung
11.11.04.2063|Blang Gandai
11.11.04.2064|Cot Ulim
11.11.04.2065|Cot Iboeh
11.11.04.2071|Blang Rheum
11.11.04.2072|Paloh Panyang
11.11.04.2073|Seuneubok Lhong
11.11.04.2075|Salah Sirong Jaya
11.11.04.2076|Mon Mane
11.11.04.2077|Alue Limeng
11.11.04.2078|Cot Meugoe
11.11.04.2079|Cot Iboeh Timu
11.11.04.2080|Kuta Meuligoe
11.11.04.2081|Lhaksmana
11.11.05.2003|Matang Glumpang Dua Mns. Timu (X)
11.11.05.2004|Keude Matang Glumpang Dua
11.11.05.2005|Matang Glumpang Dua Meunasah Dayah
11.11.05.2006|Pante Gajah
11.11.05.2007|Blang Asan
11.11.05.2008|Paya Cut
11.11.05.2009|Seuneubok Aceh
11.11.05.2010|Panton Geulima
11.11.05.2011|Neuheun
11.11.05.2012|Matang Sagoe
11.11.05.2013|Matang Mesjid
11.11.05.2014|Matang Cot Paseh
11.11.05.2015|Cot Panjoe
11.11.05.2016|Paya Lipah
11.11.05.2017|Paya Meuneng
11.11.05.2018|Keude Tanjong
11.11.05.2019|Tanjong Paya
11.11.05.2020|Tanjong Nie
11.11.05.2021|Tanjong Mesjid
11.11.05.2022|Pante Cut
11.11.05.2023|Blang Cut
11.11.05.2024|Pulo Pisang
11.11.05.2025|Pante Piyeu
11.11.05.2026|Meunasah Nibong
11.11.05.2027|Krueng Baro Babah Krueng
11.11.05.2028|Krueng Baro Mesjid
11.11.05.2029|Bayu
11.11.05.2030|Gampong Putoh
11.11.05.2031|Meunasah Meucap
11.11.05.2032|Pante Ara
11.11.05.2033|Gampong Raya Dagang
11.11.05.2034|Gampong Raya Tambo
11.11.05.2035|Kapa
11.11.05.2036|Blang Panjoe
11.11.05.2037|Pantee Lhong
11.11.05.2038|Asan Bideun
11.11.05.2040|Cot Rabo Baroh
11.11.05.2041|Cot Rabo Tunong
11.11.05.2042|Cot Nga
11.11.05.2043|Pulo Naleung
11.11.05.2044|Mata Mamplam
11.11.05.2045|Alue Glumpang
11.11.05.2046|Karieng
11.11.05.2047|Krueng Dheu
11.11.05.2048|Cot Ijue
11.11.05.2049|Cot Buket
11.11.05.2050|Nicah
11.11.05.2051|Cot Keuranji
11.11.05.2052|Paloh
11.11.05.2054|Cot Bada Tunong
11.11.05.2055|Cot Bada Baroh
11.11.05.2056|Cot Girek
11.11.05.2057|Cot Keumude
11.11.05.2058|Sagoe
11.11.05.2059|Pulo Ue Baroe
11.11.05.2060|Cot Bada Barat
11.11.05.2061|Tanoh Mirah
11.11.05.2062|Seuneubok Rawa
11.11.05.2063|Paya Aboe
11.11.05.2064|Blang Rambong
11.11.05.2065|Blang Geulanggang
11.11.05.2066|Paya Reuhat
11.11.05.2067|Uteun Bunta
11.11.05.2068|Alue Udeng
11.11.05.2069|Alue Peuno
11.11.05.2105|Cot Puuk
11.11.05.2106|Pante Pisang
11.11.05.2107|Gampong Baro
11.11.05.2108|Blang Dalam
11.11.06.2001|Leubu Me
11.11.06.2002|Paya Dua
11.11.06.2003|Leubu Cot
11.11.06.2004|Leubu Mesjid
11.11.06.2005|Kuta Barat
11.11.06.2006|Trienggadeng
11.11.06.2007|Cot Kruet
11.11.06.2008|Blang Khutang
11.11.06.2009|Buket Seulamat
11.11.06.2010|Lapehan Mesjid
11.11.06.2011|Ulee Glee
11.11.06.2012|Mona Ara
11.11.06.2013|Pandak
11.11.06.2014|Blang Dalam
11.11.06.2015|Alue Dua
11.11.06.2016|Seuneubok Baro
11.11.06.2017|Panteu Breuh
11.11.06.2018|Tanjong Mulia
11.11.06.2019|Blang Mane
11.11.06.2020|Meureubo
11.11.06.2021|Blang Perlak
11.11.06.2022|Panton Mesjid
11.11.06.2023|Sukarame
11.11.06.2024|Matang Kumbang
11.11.06.2025|Pulo Teungoh
11.11.06.2026|Batee Dabai
11.11.06.2027|Ara Lipeh
11.11.07.2001|Keude Lapang
11.11.07.2002|Lapang Barat
11.11.07.2003|Lingka Kuta
11.11.07.2004|Lapang Timu
11.11.07.2005|Teupin Siron
11.11.07.2006|Ie Rhop
11.11.07.2007|Ceubo
11.11.07.2008|Paloh Me
11.11.07.2009|Lhok Mambang
11.11.07.2010|Samuti Krueng
11.11.07.2011|Cot Mane
11.11.07.2012|Samuti Makmur
11.11.07.2013|Samuti Rayeuk
11.11.07.2014|Cot Puuk
11.11.07.2015|Samuti Aman
11.11.07.2016|Alue Mangki
11.11.07.2017|Mon Keulayu
11.11.07.2018|Geurugok
11.11.07.2019|Blang Keude
11.11.07.2020|Cot Tufah
11.11.07.2021|Cot Tunong
11.11.07.2022|Paya Baro
11.11.07.2023|Paloh Kaye Kunyet
11.11.07.2024|Cot Jabet
11.11.07.2025|Cot Tube
11.11.07.2026|Pante Sikumbong
11.11.07.2027|Blang Guron
11.11.07.2028|Dama Kawan
11.11.07.2029|Paya Seupat
11.11.07.2030|Cot Rambat
11.11.07.2031|Paya Kareung
11.11.07.2032|Mon Jeurujak
11.11.07.2033|Tanjong Raya
11.11.07.2034|Tanjong Mesjid
11.11.07.2035|Blang Kubu
11.11.07.2036|Tanjong Bungong
11.11.07.2037|Pulo Gisa
11.11.07.2038|Ujong Bayu
11.11.07.2078|Mon Jambe
11.11.07.2079|Blang Rheue
11.11.08.2001|Lancok Ulim
11.11.08.2002|Nase Mee
11.11.08.2003|Pandrah Kandeh
11.11.08.2004|Panton
11.11.08.2005|Lhok Dagang
11.11.08.2006|Pandrah Janeng
11.11.08.2007|Garot
11.11.08.2008|Gampong Blang
11.11.08.2009|Kuta Rusep
11.11.08.2010|Blang Sama Gadeng
11.11.08.2011|Panton Bili
11.11.08.2012|Alue Igeuh
11.11.08.2013|Meunasah Reudeup
11.11.08.2014|Meunasah Teungoh
11.11.08.2015|Bantayan
11.11.08.2016|Cot Leubeng
11.11.08.2017|Seunebok Baro
11.11.08.2018|Uteuen Kruet
11.11.08.2019|Nase Barat
11.11.09.2001|Juli Cot Mesjid
11.11.09.2002|Juli Seutuy
11.11.09.2003|Juli Tambo Tanjong
11.11.09.2004|Juli Keude dua
11.11.09.2005|Juli Tgk Dilampoh
11.11.09.2006|Glumpang Meujimjim
11.11.09.2007|Alue Unoe
11.11.09.2008|Batee Raya
11.11.09.2009|Seuneubok Peuraden
11.11.09.2010|Juli Mee Teungoh
11.11.09.2011|Seuneubok Gunci
11.11.09.2012|Mane Meujingki
11.11.09.2013|Abeuk Budi
11.11.09.2014|Blang Ketumba
11.11.09.2015|Pante Baro
11.11.09.2016|Beunyot
11.11.09.2017|Paya Cut
11.11.09.2018|Teupin Mane
11.11.09.2019|Simpang Jaya
11.11.09.2020|Krueng Simpo
11.11.09.2021|Suka Tani
11.11.09.2022|Juli Seupeng
11.11.09.2023|Bukit Mulia
11.11.09.2024|Juli Meunasah Tambo
11.11.09.2025|Alue Rambong
11.11.09.2026|Juli Meunasah Teungoh
11.11.09.2027|Juli Payaru
11.11.09.2028|Paseh
11.11.09.2029|Juli Cot Meurak
11.11.09.2030|Pante Peusangan
11.11.09.2031|Bale Panah
11.11.09.2032|Ranto Panyang
11.11.09.2033|Simpang Mulia
11.11.09.2034|Seuneubok Dalam
11.11.09.2035|Juli Meunasah Jok
11.11.09.2036|Juli Uruek Anoe
11.11.10.2001|Jangka Mesjid
11.11.10.2002|Jangka Keutapang
11.11.10.2003|Jangka Alue U
11.11.10.2004|Jangka Alue
11.11.10.2005|Jangka Alue Bie
11.11.10.2006|Gampong Meulinteung
11.11.10.2007|Paya Bieng
11.11.10.2008|Meunasah Krueng
11.11.10.2009|Barat Lanyan
11.11.10.2010|Lamkuta
11.11.10.2011|Geundot
11.11.10.2012|Lueng
11.11.10.2013|Kambuek
11.11.10.2014|Ruseb Ara
11.11.10.2015|Ruseb Dayah
11.11.10.2016|Bada Barat
11.11.10.2017|Bada Timu
11.11.10.2018|Tanjongan
11.11.10.2019|Tanah Anoe
11.11.10.2020|Lhok Bugeng
11.11.10.2021|Lampoh Rayeuk
11.11.10.2022|Pulo Reudeup
11.11.10.2023|Pulo Seuna
11.11.10.2024|Linggong
11.11.10.2025|Pulo Blang
11.11.10.2026|Pulo Iboih
11.11.10.2027|Abeuk Jaloh
11.11.10.2028|Pulo U
11.11.10.2029|Alue Buya
11.11.10.2030|Alue Buya Pasi
11.11.10.2031|Pante Sukon
11.11.10.2032|Pante Paku
11.11.10.2033|Bugak Blang
11.11.10.2034|Bugak Mesjid
11.11.10.2035|Bugak Krueng Matee
11.11.10.2036|Bugak Krueng
11.11.10.2037|Pante Ranub
11.11.10.2038|Pulo Pineung Meunasah Dua
11.11.10.2039|Punjot
11.11.10.2040|Bugeng
11.11.10.2041|Alue Kuta
11.11.10.2042|Alue Bayeu Utang
11.11.10.2043|Ulee Ceu
11.11.10.2044|Kuala Cerape
11.11.10.2045|Pante Peusangan
11.11.10.2046|Alue Bie Pusong
11.11.11.2001|Rheum Barat
11.11.11.2002|Rheum Baroh
11.11.11.2003|Rheum Timu
11.11.11.2004|Blang Kuta Coh
11.11.11.2005|Blang Kuta Dua Meunasah
11.11.11.2006|Lancang
11.11.11.2007|Blang Teumulek
11.11.11.2008|Meunasah Mesjid
11.11.11.2009|Jurong Binjee
11.11.11.2010|Blang Mane Dua Meunasah
11.11.11.2011|Blang Mane Barat
11.11.11.2012|Balee
11.11.11.2013|Arongan
11.11.11.2014|Meunasah Mamplam
11.11.11.2015|Pulo Dapong
11.11.11.2016|Ceurucok
11.11.11.2017|Ie Rhob Glumpang
11.11.11.2018|Ie Rhob Barat
11.11.11.2019|Ie Rhob Timu
11.11.11.2020|Ie Rhob Babah Lueng
11.11.11.2021|Glee Meudong
11.11.11.2022|Pulo Drien
11.11.11.2023|Meunasah Dayah
11.11.11.2024|Cot Trieng
11.11.11.2025|Krueng Meuseugob
11.11.11.2026|Lhok Tanoh
11.11.11.2027|Blang Tambue
11.11.11.2028|Keude Tambue
11.11.11.2029|Meunasah Asan
11.11.11.2030|Peuneulet Tunong
11.11.11.2031|Cure Tunong
11.11.11.2032|Cure Baroh
11.11.11.2033|Peuneulet Baroh
11.11.11.2034|Ulee Kareung
11.11.11.2035|Blang Payang
11.11.11.2036|Calok
11.11.11.2037|Alue Leuhop
11.11.11.2038|Paku
11.11.11.2039|Lhok Mane
11.11.11.2040|Tambue Barat
11.11.11.2041|Meunasah Barat
11.11.12.2001|Keude Plimbang
11.11.12.2002|Krueng Baro
11.11.12.2003|Seuneubok Nalan
11.11.12.2004|Rambong Payong
11.11.12.2005|Seuneubok Aceh
11.11.12.2006|Seuneubok Plimbang
11.11.12.2007|Seuneubok Punti
11.11.12.2008|Uteun Sikumbong
11.11.12.2009|Teupin Panah
11.11.12.2010|Matang Kulee
11.11.12.2011|Lancok Bungo
11.11.12.2012|Uteun Rungkom
11.11.12.2013|Padang Kasab
11.11.12.2014|Seuneubok Seumawe
11.11.12.2015|Jambo Dalam
11.11.12.2016|Cot Gleumpang
11.11.12.2017|Puuek
11.11.12.2018|Balee Daka
11.11.12.2019|Paloh Pupu
11.11.12.2020|Seunebok Teungoh
11.11.12.2021|Garab
11.11.12.2022|Kuta Trieng
11.11.13.2001|Bandar Bireuen
11.11.13.2002|Bireuen Meunasah Reulet
11.11.13.2003|Bireuen Meunasah Blang
11.11.13.2004|Bireuen Meunasah Capa
11.11.13.2005|Bireuen Meunasah Dayah
11.11.13.2006|Bireuen Meunasah Tgk Digadong
11.11.13.2007|Geudong-Geudong
11.11.13.2008|Pulo Ara Geudong Teungoh
11.11.13.2009|Geudong Alue
11.11.13.2010|Pulo Kiton
11.11.13.2011|Lhok Awe Teungoh
11.11.13.2012|Geulanggang Teungoh
11.11.13.2013|Cot Gapu
11.11.13.2014|Geulanggang Kulam
11.11.13.2015|Geulanggang Gampong
11.11.13.2016|Blang Tingkeum
11.11.13.2017|Buket Teukueh
11.11.13.2018|Blang Reuling
11.11.13.2019|Cot Jrat
11.11.13.2020|Cot Peutek
11.11.13.2021|Uteun Reutoh
11.11.13.2022|Geulanggang Baro
11.11.13.2023|Gampong Baro
11.11.14.2001|Cot Batee
11.11.14.2002|Cot Unoe
11.11.14.2003|Kuta Baro
11.11.14.2004|Cot Glumpang
11.11.14.2005|Cot Kuta
11.11.14.2006|Glumpang Baroh
11.11.14.2007|Krueng Juli Timu
11.11.14.2008|Krueng Juli Barat
11.11.14.2009|Cot Trieng
11.11.14.2010|Lhok Awe Awe
11.11.14.2011|Cot Laga Sawa
11.11.14.2012|Cot U Sibak
11.11.14.2013|Lancok Pante Ara
11.11.14.2014|Lancok-Lancok
11.11.14.2015|Kareung
11.11.14.2016|Balee Kuyun
11.11.14.2017|Ujong Blang
11.11.14.2018|Ujong Blang Mesjid
11.11.14.2019|Weu Jangka
11.11.14.2020|Kuala Raja
11.11.15.2001|Lueng Daneun
11.11.15.2002|Rambong Payong
11.11.15.2003|Alue Kupula
11.11.15.2004|Blang Cirih
11.11.15.2005|Kubu
11.11.15.2006|Teupin Raya
11.11.15.2007|Cot Aneuk Batee
11.11.15.2008|Kubu Raya
11.11.15.2009|Pante Baro Gle Siblah
11.11.15.2010|Pante Baro Kumbang
11.11.15.2011|Pante Baro Buket Panyang
11.11.15.2012|Alue Krueb
11.11.15.2013|Alue Iet
11.11.15.2014|Paloh Mampre
11.11.15.2015|Buket Sudan
11.11.15.2016|Awe Geutah
11.11.15.2017|Cot Saleuet
11.11.15.2018|Alue Glumpang
11.11.15.2019|Pante Karya
11.11.15.2020|Awe Geutah Paya
11.11.15.2021|Dayah Baro
11.11.16.2001|Darussalam
11.11.16.2002|Blang Mane
11.11.16.2003|Tanjong Beuridi
11.11.16.2004|Darul Aman
11.11.16.2005|Geulanggang Labu
11.11.16.2006|Teupin Reudeup
11.11.16.2007|Ulee Jalan
11.11.16.2008|Paya Crot
11.11.16.2009|Pulo Panyang
11.11.16.2010|Me Rayeuk
11.11.16.2011|Uteun Gathom
11.11.16.2012|Lueng Kuli
11.11.16.2013|Lueng Baro
11.11.16.2014|Mata Ie
11.11.16.2015|Blang Cut
11.11.16.2016|Blang Pala
11.11.16.2017|Krueng Beukah
11.11.16.2018|Ceubrek
11.11.16.2019|Uteun Raya
11.11.16.2020|Pulo Harapan
11.11.16.2021|Suwak
11.11.17.2001|Paloh Dama
11.11.17.2002|Paya Rangkuluh
11.11.17.2003|Paloh Raya
11.11.17.2004|Crueng Kumbang
11.11.17.2005|Tanjong Siron
11.11.17.2006|Balee Mee
11.11.17.2007|Buket Dalam
11.11.17.2008|Parang Sikureung
11.11.17.2009|Cot Baroh
11.11.17.2010|Paloh Peuradi
11.11.17.2011|Cot Mee
11.11.17.2012|Blang Mee
11.11.17.2013|Glee Putoh
11.11.17.2014|Tingkeum Baro
11.11.17.2015|Tingkeum Manyang
11.11.17.2016|Kulu
11.11.17.2017|Babah Suak
11.11.17.2018|Ulee Pusong
11.11.17.2019|Pulo Nga
11.11.17.2020|Meusee
11.11.17.2021|Blang Panjo
11.11.17.2022|Babah Jurong
11.11.17.2023|Dayah Panjoe
11.11.17.2024|Pulo Blang
11.11.17.2025|Imbudee
11.11.17.2026|Pulo Siren
11.11.17.2027|Jarommah Me
11.11.17.2028|Jaromah Baroh
11.11.17.2029|Lhok Nga
11.11.17.2030|Pulo Reudeup
11.11.17.2031|Geulanggang Meunjee
11.11.17.2032|Geulanggang Panah
11.11.17.2033|Ujong Blang
11.11.17.2034|Geulanggang Rayeuk
11.11.17.2035|Dayah Mesjid
11.11.17.2036|Keurumbok
11.11.17.2037|Cot Ara
11.11.17.2038|Rancong
11.11.17.2039|Jambo Kajeung
11.11.17.2040|Kulu Kuta
11.11.17.2041|Pulo Awe
11.12.01.2006|Guhang
11.12.01.2007|Seunaloh
11.12.01.2008|Lhung Asan
11.12.01.2010|Lhung Tarok
11.12.01.2014|Cot Jeurat
11.12.01.2015|Meudang Ara
11.12.01.2016|Keude Siblah
11.12.01.2017|Kuta Bahagia
11.12.01.2018|Kuta Tinggi
11.12.01.2019|Mata Ie
11.12.01.2020|Geulumpang Payong
11.12.01.2021|Panton Raya
11.12.01.2022|Alue Manggota
11.12.01.2023|Lam Kuta
11.12.01.2024|Baharu
11.12.01.2025|Keude Paya
11.12.01.2026|Pasar Blangpidie
11.12.01.2028|Kuta Tuha
11.12.01.2029|Gudang
11.12.01.2030|Babah Lhung
11.12.02.2001|Adan
11.12.02.2002|Pante Geulumpang
11.12.02.2003|Mesjid
11.12.02.2004|Gunong Cut
11.12.02.2005|Padang Kawa
11.12.02.2006|Blang Padang
11.12.02.2007|Padang Bak Jeumpa
11.12.02.2008|Suak Labu
11.12.02.2014|Bineh Krueng
11.12.02.2015|Drien Kipah
11.12.02.2016|Drien Jalo
11.12.02.2017|Padang Bak Jok
11.12.02.2018|Suak Nibong
11.12.02.2019|Kuta Bak Drien
11.12.02.2020|Ie Lhob
11.12.03.2001|Kedai
11.12.03.2002|Padang
11.12.03.2003|Tengah
11.12.03.2005|Paya
11.12.03.2006|Seuneulop
11.12.03.2007|Lhok Puntoy
11.12.03.2009|Ladang Panah
11.12.03.2010|Pusu Ingin Jaya
11.12.03.2011|Panton Makmur
11.12.03.2022|Lhueng Baro
11.12.03.2023|Tokoh
11.12.03.2024|Blang Manggeng
11.12.03.2025|Pante Raja
11.12.03.2026|Sejahtera
11.12.03.2027|Lhok Pawoh
11.12.03.2029|Pante Pirak
11.12.03.2030|Ujung Padang
11.12.03.2031|Pante Cermin
11.12.04.2001|Pantai Perak
11.12.04.2002|Durian Rampak
11.12.04.2003|Barat
11.12.04.2004|Palak Hulu
11.12.04.2005|Palak Hilir
11.12.04.2006|Durian Jangek
11.12.04.2007|Rumah Dua Lapis
11.12.04.2008|Pinang
11.12.04.2009|Rumah Panjang
11.12.04.2010|Baharu
11.12.04.2011|Pawoh
11.12.04.2012|Padang Baru
11.12.04.2013|Pulau Kayu
11.12.04.2014|Ujung Padang
11.12.04.2015|Kedai Susoh
11.12.04.2016|Panjang Baru
11.12.04.2017|Kedai Palak Kerambil
11.12.04.2018|Ladang
11.12.04.2019|Kepala Bandar
11.12.04.2020|Tangah
11.12.04.2021|Gadang
11.12.04.2022|Padang Hilir
11.12.04.2023|Blang Dalam
11.12.04.2024|Meunasah
11.12.04.2025|Lampoh Drien
11.12.04.2026|Padang Panjang
11.12.04.2027|Rubek Meupayong
11.12.04.2028|Cot Mancang
11.12.04.2029|Geulima Jaya
11.12.05.2001|Kota Bahagia
11.12.05.2002|Pasar Kota Bahagia
11.12.05.2003|Geulanggang Gajah
11.12.05.2004|Kuala Terubue
11.12.05.2005|Blang Makmur
11.12.05.2006|Panto Cut
11.12.05.2007|Alue Padee
11.12.05.2008|Muka Blang
11.12.05.2009|Lhung Geulumpang
11.12.05.2010|Padang Sikabu
11.12.05.2011|Kampung Tengah
11.12.05.2012|Blang Panyang
11.12.05.2013|Krueng Batee
11.12.05.2014|Alue Pisang
11.12.05.2015|Lhok Gajah
11.12.05.2016|Ie Mameh
11.12.05.2017|Keude Baro
11.12.05.2018|Lama Tuha
11.12.05.2019|Drien Berumbang
11.12.05.2020|Rumoh Panyang
11.12.05.2021|Krueng Panto
11.12.06.2001|Pante Rakyat
11.12.06.2002|Ie Mirah
11.12.06.2003|Gunung Samarinda
11.12.06.2004|Alue Jeurejak
11.12.06.2005|Blang Dalam
11.12.06.2006|Alue Peunawa
11.12.06.2007|Pante Cermin
11.12.06.2008|Blang Raja
11.12.06.2009|Rukoen Dame
11.12.06.2010|Simpang Gadeng
11.12.06.2011|Teladan Jaya
11.12.06.2012|Lhok Gayo
11.12.06.2013|Alue Dawah
11.12.06.2014|Cot Seumantok
11.12.07.2001|Lhang
11.12.07.2002|Rambong
11.12.07.2003|Pisang
11.12.07.2004|Ujung Tanah
11.12.07.2005|Alue Dama
11.12.07.2007|Tangan-Tangan Cut
11.12.07.2008|Mon Mameh
11.12.07.2009|Cinta Makmur
11.12.07.2010|Kuta Murni
11.12.08.2001|Baru
11.12.08.2002|Alue Rambot
11.12.08.2003|Kuta Jeumpa
11.12.08.2004|Alue Sungai Pinang
11.12.08.2005|Cot Mane
11.12.08.2006|Ladang Neubok
11.12.08.2007|Asoe Nanggroe
11.12.08.2008|Padang Geulumpang
11.12.08.2009|Ikue Lhung
11.12.08.2010|Kuta Makmur
11.12.08.2011|Jeumpa Barat
11.12.08.2012|Alue Seulaseh
11.12.09.2001|Meurandeh
11.12.09.2002|Sukadamai
11.12.09.2003|Cot Bak-U
11.12.09.2004|Meunasah Sukon
11.12.09.2005|Meunasah Tengah
11.12.09.2006|Geulanggang Batee
11.12.09.2007|Kuta Paya
11.12.09.2008|Ujung Tanah
11.12.09.2009|Padang Keulele
11.12.09.2010|Alue Rambot
11.12.09.2011|Ladang Tuha I
11.12.09.2012|Ladang Tuha II
11.12.09.2013|Tokoh II
11.12.09.2014|Kayee Aceh
11.13.01.2001|Blangkejeren
11.13.01.2002|Penampaan
11.13.01.2003|Bukit
11.13.01.2004|Bacang
11.13.01.2005|Durin
11.13.01.2007|Kampung Jawa
11.13.01.2008|Porang
11.13.01.2011|Kute Lintang
11.13.01.2014|Leme
11.13.01.2016|Gele
11.13.01.2017|Sere
11.13.01.2018|Cempa
11.13.01.2019|Lempuh
11.13.01.2021|Palok
11.13.01.2022|Penggalangan
11.13.01.2027|Agusen
11.13.01.2031|Bustanussalam
11.13.01.2032|Penampaan Uken
11.13.01.2033|Raklunung
11.13.01.2034|Sepang
11.13.02.2002|Tampeng
11.13.02.2004|Bener
11.13.02.2005|Ulun Tanoh
11.13.02.2006|Kuta Ujung
11.13.02.2008|Beranang
11.13.02.2010|Rikit Dekat
11.13.02.2011|Rema
11.13.02.2014|Rema Baru
11.13.02.2015|Cike
11.13.02.2016|Kerukunan Kuta Panjang
11.13.02.2020|Tampeng Musara
11.13.02.2021|Kong Paluh
11.13.03.2001|Ampa Kolak
11.13.03.2002|Cane Toa
11.13.03.2003|Padang Pasir
11.13.03.2005|Pinang Rugub
11.13.03.2006|Kuning
11.13.03.2008|Mangang
11.13.03.2011|Rempelam
11.13.03.2012|Cane Uken
11.13.03.2013|Tungel
11.13.03.2014|Kota Rikit Gaib
11.13.03.2016|Lukup Baru
11.13.03.2017|Penomon Jaya
11.13.03.2018|Tungel Baru
11.13.04.2001|Jabo
11.13.04.2002|Kutesange
11.13.04.2003|Padang
11.13.04.2006|Rumpi
11.13.04.2007|Bukut
11.13.04.2008|Terangun
11.13.04.2010|Rempelam Pinang
11.13.04.2011|Soyo
11.13.04.2012|Terlis
11.13.04.2013|Kutereje
11.13.04.2014|Persada Tongra
11.13.04.2015|Berhut
11.13.04.2016|Gewat
11.13.04.2017|Pantan Lues
11.13.04.2018|Makmur Jaya
11.13.04.2020|Blang Kuncir
11.13.04.2023|Reje Pudung
11.13.04.2024|Garut
11.13.04.2025|Telege Jernih
11.13.04.2026|Rime Raya
11.13.04.2027|Lestari
11.13.04.2028|Gawar Belangi
11.13.04.2029|Blang Kala
11.13.05.2001|Pining
11.13.05.2002|Pertik
11.13.05.2003|Ekan
11.13.05.2004|Uring
11.13.05.2005|Gajah
11.13.05.2006|Pintu Rime
11.13.05.2007|Pepelah
11.13.05.2008|Pasir Putih
11.13.05.2009|Lesten
11.13.06.2001|Gantung Geluni
11.13.06.2002|Kutabukit
11.13.06.2003|Bener Baru
11.13.06.2004|Blangbengkik
11.13.06.2005|Kong
11.13.06.2006|Ume Lah
11.13.06.2007|Cinta Maju
11.13.06.2008|Porang Ayu
11.13.06.2009|Tetingi
11.13.06.2010|Anak Reje
11.13.06.2011|Bemem Buntul Pegayon
11.13.06.2012|Akang Siwah
11.13.07.2001|Gumpang
11.13.07.2002|Marpunge
11.13.07.2003|Ramung Musara
11.13.07.2004|Meloak Sepakat
11.13.07.2005|Kutelengat Sepakat
11.13.07.2006|Singah Mulo
11.13.07.2007|Uning Pune
11.13.07.2008|Gumpang Lempuh
11.13.07.2009|Putri Betung
11.13.08.2001|Pangur
11.13.08.2002|Badak
11.13.08.2003|Kendawi
11.13.08.2004|Sangir
11.13.08.2005|Panglima Linting
11.13.08.2006|Blangtemung
11.13.08.2007|Rerebe
11.13.08.2008|Uning Gelung
11.13.08.2009|Uning Sepakat
11.13.09.2001|Penosan
11.13.09.2002|Sekuelen
11.13.09.2003|Akul
11.13.09.2004|Gegarang
11.13.09.2005|Peparik Gaib
11.13.09.2006|Penosan Sepakat
11.13.09.2007|Tingkem
11.13.09.2008|Ketukah
11.13.09.2009|Peparik Dekat
11.13.09.2010|Blangjerango
11.13.10.2001|Perlak
11.13.10.2002|Rerebe
11.13.10.2003|Pasir
11.13.10.2004|Setul
11.13.10.2005|UPT Paya Kumer
11.13.10.2006|UPT Pantan Kela
11.13.10.2007|Buntul Musara
11.13.10.2008|Kuala Jernih
11.13.10.2009|Uyem Beriring
11.13.10.2010|Pulo Gelime
11.13.11.2001|Seneren
11.13.11.2002|Remukut
11.13.11.2003|Kenyaran
11.13.11.2004|Tetingi
11.13.11.2005|Atu Kapur
11.13.11.2006|Suri Musara
11.13.11.2007|UPT Aih Selah
11.13.11.2008|Cane Baru
11.13.11.2009|Kurnia
11.14.01.2001|Keude Teunom
11.14.01.2002|Alue Ambang
11.14.01.2003|Padang Kleng
11.14.01.2004|Panton
11.14.01.2005|Pasi Tulak Bala
11.14.01.2006|Gampong Baro
11.14.01.2007|Rambong Payong
11.14.01.2008|Pasi Pawang
11.14.01.2009|Blang Baro
11.14.01.2010|Tanoh Anoe
11.14.01.2011|Tanoh Manyang
11.14.01.2012|Batee Roo
11.14.01.2013|Seuneubok Padang
11.14.01.2014|Seumira
11.14.01.2015|Kubu
11.14.01.2016|Alue Meuraksa
11.14.01.2017|Paya Baro
11.14.01.2018|Teupin Ara
11.14.01.2019|Cot Trap
11.14.01.2020|Leung Gayo
11.14.01.2021|Pasi Geulima
11.14.01.2022|Pasi Timon
11.14.02.2001|Bahagia
11.14.02.2002|Sentosa
11.14.02.2003|Dayah Baro
11.14.02.2004|Gampong Blang
11.14.02.2005|Keutapang
11.14.02.2006|Panton Makmur
11.14.02.2007|Keude Krueng Sabee
11.14.02.2008|Kabong
11.14.02.2009|Padang Datar
11.14.02.2010|Datar Luas
11.14.02.2011|Ranto Panyang
11.14.02.2012|Buntha
11.14.02.2013|Panggong
11.14.02.2014|Curek
11.14.02.2015|Alue Tho
11.14.02.2016|Mon Mata
11.14.02.2017|Paya Seumantok
11.14.03.2001|Sawang
11.14.03.2002|Lhok Geulumpang
11.14.03.2003|Padang
11.14.03.2004|Gunong Meunasah
11.14.03.2005|Sapek
11.14.03.2006|Pante Kuyun
11.14.03.2007|Glee Seubak
11.14.03.2008|Gampong Baroh
11.14.03.2009|Lhok Timon
11.14.03.2010|Gampong Baro
11.14.03.2011|Lhok Buya
11.14.03.2012|Lhok Bot
11.14.03.2013|Paya Laot
11.14.04.2001|Lhok Kruet
11.14.04.2002|Pulo Raya
11.14.04.2003|Meunasah Kulam
11.14.04.2004|Crak Mong
11.14.04.2005|Alue Gro
11.14.04.2006|Kuala Ligan
11.14.04.2007|Babah Nipah
11.14.04.2008|Jeumpheuk
11.14.04.2009|Cot Langsat
11.14.04.2010|Mata Ie
11.14.04.2011|Blang Monlung
11.14.04.2012|Krueng No
11.14.04.2013|Seumantok
11.14.04.2014|Ranto Sabon
11.14.04.2015|Ligan
11.14.04.2016|Ie Jeureungeh
11.14.04.2020|Kuala Bakong
11.14.04.2036|Cot Punti
11.14.04.2037|Krueng Ayon
11.14.05.2011|Pante Cermin
11.14.05.2012|Sabet
11.14.05.2013|Sango
11.14.05.2014|Mareu
11.14.05.2015|Lam Asan
11.14.05.2016|Alue Rayeuk
11.14.05.2017|Sapek
11.14.05.2018|Lambaroh
11.14.05.2019|Meudheun
11.14.05.2020|Babah Ie
11.14.05.2021|Ujong Sudheun
11.14.05.2022|Krueng Tunong
11.14.05.2023|Jambo Masi
11.14.05.2024|Lamtui
11.14.05.2025|Pasar Lamno
11.14.05.2026|Meunasah Weh
11.14.05.2027|Bak Paoh
11.14.05.2028|Babah Krueng
11.14.05.2029|Cot Dulang
11.14.05.2030|Lamdurian
11.14.05.2031|Putue
11.14.05.2032|Gle Putoh
11.14.05.2033|Pante Keutapang
11.14.05.2034|Lamme
11.14.05.2035|Meunasah Serba
11.14.05.2036|Leupe
11.14.05.2037|Meutara
11.14.05.2038|Lhuet
11.14.05.2039|Gle Jong
11.14.05.2040|Darat
11.14.05.2041|Gampong Baro
11.14.05.2042|Panton Makmur
11.14.05.2043|Rumpet
11.14.05.2044|Nusa
11.14.06.2001|Keude Panga
11.14.06.2002|Kuta Tuha
11.14.06.2003|Tuwi Kareung
11.14.06.2004|Ladang Baro
11.14.06.2005|Panton Krueng
11.14.06.2006|Gle Putoh
11.14.06.2007|Alue Pande
11.14.06.2008|Batee Meutudong
11.14.06.2009|Gampong Harapan
11.14.06.2010|Gunong Buloh
11.14.06.2011|Gunong Meulinteung
11.14.06.2013|Alue Abed
11.14.06.2014|Gunong Mantok
11.14.06.2015|Alue Raya
11.14.06.2016|Alue Teungoh
11.14.06.2017|Babah Ceupan
11.14.06.2018|Tuwi Eumpeuk
11.14.06.2019|Panton Kabu
11.14.06.2020|Tuwi Kayee
11.14.06.2021|Alue Piet
11.14.07.2001|Ujong Muloh
11.14.07.2002|Janguet
11.14.07.2003|Meunasah Rayeuk
11.14.07.2004|Mukhan
11.14.07.2005|Meunasah Teungoh
11.14.07.2006|Meunasah Tutong
11.14.07.2007|Babah Dua
11.14.07.2008|Alue Mie
11.14.07.2009|Teumareum
11.14.07.2010|Kuala
11.14.07.2011|Meudhang Ghon
11.14.07.2012|Kareung Ateuh
11.14.07.2013|Keude Unga
11.14.07.2014|Ceunamprong
11.14.08.2001|Patek
11.14.08.2002|Gampong Baro Patek
11.14.08.2003|Blang Dalam
11.14.08.2004|Pajar
11.14.08.2005|Reuntang
11.14.08.2006|Cot Pange
11.14.08.2007|Arongan
11.14.08.2008|Paya Santeut
11.14.08.2009|Krueng Tho
11.14.08.2010|Panton Krueng
11.14.08.2011|Alue Gajah
11.14.08.2012|Sayeung
11.14.08.2013|Gunong Cut
11.14.08.2014|Ujong Rimba
11.14.08.2015|Lamteungoh
11.14.08.2016|Gampong Baro Lamteungoh
11.14.08.2017|Babah Dua
11.14.08.2018|Masen
11.14.08.2019|Teupin Asan
11.14.09.2001|Pulo Tinggi
11.14.09.2002|Alue Krueng
11.14.09.2003|Pasi Teubee
11.14.09.2004|Timpleung
11.14.09.2005|Krueng Beukah
11.14.09.2006|Tuwi Kareung
11.14.09.2007|Lhok Guci
11.14.09.2008|Tuwi Peuriya
11.14.09.2009|Sarah Raya
11.14.09.2010|Alue Jang
11.14.09.2011|Ceuraceu
11.14.09.2012|Alue Punti
11.14.09.2013|Bintah
11.14.09.2014|Buket Keumuneng
11.15.01.2003|Lawa Batu
11.15.01.2004|Jogja
11.15.01.2019|Ujong Sikuneng
11.15.01.2020|Blang Muko
11.15.01.2021|Pulo Ie
11.15.01.2022|Purworejo
11.15.01.2023|Blang Baro
11.15.01.2024|Alue Ie Mameh
11.15.01.2025|Ujong Pasi
11.15.01.2026|Simpang Peut
11.15.01.2027|Blang Teungoh
11.15.01.2028|Ujong Padang
11.15.01.2029|Cot Kumbang
11.15.01.2030|Blang Bintang
11.15.01.2031|Ujong Patihah
11.15.01.2032|Kuta Makmue
11.15.01.2033|Gunong Reubo
11.15.02.2001|Jeuram
11.15.02.2002|Pante Ceureumen
11.15.02.2003|Kuta Baro Jeuram
11.15.02.2004|Parom
11.15.02.2005|Peureulak
11.15.02.2006|Kuta Sayeh
11.15.02.2007|Blang Baro
11.15.02.2008|Padang
11.15.02.2009|Alue Tho
11.15.02.2010|Lhok Parom
11.15.02.2011|Sapek
11.15.02.2012|Alue Dodok
11.15.02.2013|Cot Kumbang
11.15.02.2014|Kuta Kumbang
11.15.02.2015|Nigan
11.15.02.2016|Gampong Cot
11.15.02.2017|Blang Pateuk
11.15.02.2018|Blang Puuk Nigan
11.15.02.2019|Krueng Ceh
11.15.02.2020|Bantan
11.15.02.2021|Cot Lhe-Lhe
11.15.02.2022|Rambong Rayeuk
11.15.02.2023|Paya Udeung
11.15.02.2024|Alue Buloh
11.15.02.2025|Kuta Paya
11.15.02.2026|Krueng Ceuko
11.15.02.2027|Lhok Padang
11.15.02.2028|Kuta Aceh
11.15.02.2029|Krueng Mangkom
11.15.02.2030|Latong
11.15.02.2031|Paya Undan
11.15.02.2032|Blang Puuk Kulu
11.15.02.2033|Blang Murong
11.15.02.2034|Kulu
11.15.02.2035|Rambong Cut
11.15.03.2001|Blang Panyang
11.15.03.2002|Meugat Meh
11.15.03.2003|Lhok Pange
11.15.03.2004|Blang Lango
11.15.03.2005|Tuwi Meuleusong
11.15.03.2006|Blang Geudong
11.15.03.2007|Blang Teungku
11.15.03.2008|Sawang Mane
11.15.03.2009|Keude Neulop
11.15.03.2010|Kila
11.15.03.2011|Kandeh
11.15.03.2012|Cot Gud
11.15.03.2013|Kabu Baroh
11.15.03.2014|Kabu Tunong
11.15.03.2015|Keude Linteung
11.15.03.2016|Meurandeh Suak
11.15.03.2017|Uteun Pulo
11.15.03.2018|Cot Manyang
11.15.03.2019|Pulo Teungoh
11.15.03.2020|Cot Dirui
11.15.03.2021|Cot Teuku Dek
11.15.03.2022|Sapeng
11.15.03.2023|Peuleukung
11.15.03.2024|Paya
11.15.03.2025|Blang Preh
11.15.03.2026|Blang Ara Keude
11.15.03.2027|Blang Ara Gampong
11.15.03.2028|Ie Beudoh
11.15.03.2029|Blang Bayu
11.15.03.2030|Mon Bateung
11.15.03.2031|Suak Peureubong
11.15.03.2032|Krueng Kulu
11.15.03.2033|Cot Punti
11.15.03.2034|Lhok Mesjid
11.15.04.2001|Blang Seunong
11.15.04.2002|Pante Ara
11.15.04.2003|Gunong Nagan
11.15.04.2004|Tuwi Bunta
11.15.04.2005|Blang Mesjid
11.15.04.2006|Blang Neuang
11.15.04.2007|Panton Bayam
11.15.04.2008|Blang Baro Pulo Raga
11.15.04.2009|Krueng Cut
11.15.04.2010|Blang Leumak
11.15.04.2011|Babah Krueng
11.15.04.2012|Blang Seumot
11.15.04.2013|Lhok Seumot
11.15.04.2014|Meunasah Pante
11.15.04.2015|Kuta Jeumpa
11.15.04.2016|Blang Dalam
11.15.04.2017|Keude Seumot
11.15.04.2018|Blang Baro Rambong
11.15.04.2019|Ujong Blang
11.15.04.2020|Meunasah Krueng
11.15.04.2021|Meunasah Dayah
11.15.04.2022|Meunasah Teungoh
11.15.04.2023|Kulam Jeureuneh
11.15.04.2028|Bumi Sari
11.15.05.2012|Lamie
11.15.05.2013|Kuta Trieng
11.15.05.2014|Geulanggang Gajah
11.15.05.2015|Kayee Unoe
11.15.05.2016|Blang Baro
11.15.05.2017|Alue Bilie
11.15.05.2018|Suka Raja
11.15.05.2019|Gunong Cut
11.15.05.2020|Suka Jadi
11.15.05.2021|Tuwi Buya
11.15.05.2022|Ujong Lamie
11.15.05.2023|Suak Palembang
11.15.05.2024|Alue Waki
11.15.05.2025|Alue Geutah
11.15.05.2026|Krueng Alem
11.15.05.2027|Alue Rambot
11.15.05.2028|Krueng Seumayam
11.15.05.2029|Pulo Teungoh
11.15.05.2030|Karang Anyar
11.15.05.2031|Kuala Seumayam
11.15.05.2032|Pulo Ie
11.15.05.2033|Pulo Kruet
11.15.05.2034|Alue Kuyun
11.15.05.2035|Alue Raya
11.15.05.2036|Alue Jampak
11.15.05.2037|Suka Mulia
11.15.05.2038|Simpang Dua
11.15.05.2039|Sidojadi
11.15.05.2040|Serba Jadi
11.15.05.2041|Serba Guna
11.15.05.2042|Simpang Deli Kilang
11.15.05.2043|Panton Bayu
11.15.05.2044|Ujong Tanjong
11.15.05.2045|Suka Ramai
11.15.05.2046|Ladang Baro
11.15.05.2047|Alue Bateung Brok
11.15.05.2048|Simpang Deli Kampong
11.15.05.2049|Blang Luah
11.15.05.2050|Sumber Makmur
11.15.05.2051|Makarti Jaya
11.15.06.2001|Lueng Baro
11.15.06.2002|Alue Kambuk
11.15.06.2003|Kuta Padang
11.15.06.2004|Suak Bilie
11.15.06.2005|Macah
11.15.06.2006|Seumambek
11.15.06.2007|Cot Kuta
11.15.06.2008|Kabu Blang Sapek
11.15.06.2009|Cot Peuradi
11.15.06.2010|Blang Sapek
11.15.06.2011|Lhok Beutong
11.15.06.2012|Gampong Teungoh
11.15.06.2013|Lhok Rameuan
11.15.06.2014|Blang Muling
11.15.06.2015|Krak Tampai
11.15.06.2016|Meureubo
11.15.06.2017|Kuta Baro Blang Muling
11.15.06.2018|Alue Peusaja
11.15.06.2019|Alue Gajah
11.15.07.2001|Suak Puntong
11.15.07.2002|Gampong Lhok
11.15.07.2003|Kuala Baro
11.15.07.2004|Padang Rubek
11.15.07.2005|Pulo
11.15.07.2006|Langkak
11.15.07.2007|Kuala Tuha
11.15.07.2008|Kubang Gajah
11.15.07.2009|Kuala Trang
11.15.07.2010|Cot Rambong
11.15.07.2011|Padang Panyang
11.15.07.2012|Arongan
11.15.07.2013|Jati Rejo
11.15.07.2014|Purwodadi
11.15.07.2015|Lueng Teuku Ben
11.15.07.2016|Purwosari
11.15.08.2001|Alue Bata
11.15.08.2002|Gunong Sapek
11.15.08.2003|Sarah Mantok
11.15.08.2004|Pasie Luah
11.15.08.2005|Gunong Geulugo
11.15.08.2006|Gunong Kupok
11.15.08.2007|Gunong Pungki
11.15.08.2008|Alue Siron
11.15.08.2009|Cot Mue
11.15.08.2010|Babah Rot
11.15.08.2011|Babah Dua
11.15.08.2012|Batu Raja
11.15.08.2013|Simpang Jaya
11.15.08.2014|Sumber Daya
11.15.08.2015|Rantau Selamat
11.15.08.2016|Alue Seupeung
11.15.08.2017|Krueng Itam
11.15.08.2018|Alue Gajah
11.15.08.2019|Alue Labu
11.15.08.2020|Gapa Garu
11.15.08.2021|Kuala Tadu
11.15.08.2022|Cot Mee
11.15.09.2001|Kuala Tripa
11.15.09.2002|Babah Lueng
11.15.09.2003|Drien Tujoh
11.15.09.2004|Lueng Keubeu Jagat
11.15.09.2005|Kabu
11.15.09.2006|Pasie Keube Dom
11.15.09.2007|Neubok Yee PK
11.15.09.2008|Neubok Yee PP
11.15.09.2009|Mon Dua
11.15.09.2010|Ujong Krueng
11.15.09.2011|Panton Pange
11.15.10.2001|Blang Puuk
11.15.10.2002|Babah Suak
11.15.10.2003|Kuta Teungoh
11.15.10.2004|Blang Meurandeh
11.16.01.2001|Simpang Lhee
11.16.01.2002|Buket Panyang Sa
11.16.01.2003|Buket Panyang Dua
11.16.01.2004|Seuneubok Baru
11.16.01.2005|Sampaimah
11.16.01.2006|Krueng Sikajang
11.16.01.2007|Seuneubok Punti
11.16.01.2008|Mesjid
11.16.01.2009|Paya Ketenggar
11.16.01.2010|Pahlawan
11.16.01.2011|Matang Ara Aceh
11.16.01.2012|Ie Bintah
11.16.01.2013|Geudham
11.16.01.2014|Geulanggang Merak
11.16.01.2015|Bukit Paya
11.16.01.2016|Dagang Setia
11.16.01.2017|Meunasah Paya
11.16.01.2018|Benteng Anyer
11.16.01.2019|Tanjung Neraca
11.16.01.2020|Lueng Manyo
11.16.01.2021|Tualang Baro
11.16.01.2022|Lhok Medang Ara
11.16.01.2023|Kaseh Sayang
11.16.01.2024|Seuneubok Pidie
11.16.01.2025|Matang Cincin
11.16.01.2026|Matang Ara Jawa
11.16.01.2027|Meurandeh
11.16.01.2028|Raja Tuha
11.16.01.2029|Ujung Tanjung
11.16.01.2030|Alue Ie Puteh
11.16.01.2031|Alue Sentang
11.16.01.2032|Seuneubok Cantek
11.16.01.2033|Sapta Marga
11.16.01.2034|Paya Baru
11.16.01.2035|Bandung Jaya
11.16.01.2036|Pandan Sari
11.16.02.2001|Mesjid Sungai Iyu
11.16.02.2002|Alur Cantik
11.16.02.2003|Tanjung Lipat I
11.16.02.2004|Tanjung Lipat II
11.16.02.2005|Seuneubok Dalam Mesjid
11.16.02.2006|Bandar Baru
11.16.02.2007|Cinta Raja
11.16.02.2008|Kuala Genting
11.16.02.2009|Bandar Khalifah
11.16.02.2010|Suka Mulia Bendahara
11.16.02.2011|Seuneubok Aceh
11.16.02.2012|Tengku Tinggi
11.16.02.2013|Perkebunan Sungai Iyu
11.16.02.2014|Marlempang
11.16.02.2015|Balai
11.16.02.2016|Lubuk Batil
11.16.02.2017|Lambung Blang
11.16.02.2018|Tanjung Parit
11.16.02.2019|Tanjung
11.16.02.2020|Raja
11.16.02.2021|Tumpok Tengoh
11.16.02.2029|Upah
11.16.02.2030|Perkebunan Upah
11.16.02.2031|Matang Tepah
11.16.02.2035|Seuneubok Dalam Upah
11.16.02.2036|Mesjid Bendahara
11.16.02.2037|Teluk Kemiri
11.16.02.2038|Teluk Kepayang
11.16.02.2039|Teluk Halban
11.16.02.2040|Rantau Pakam
11.16.02.2041|Tanjung Binjai
11.16.02.2042|Tanjung Mulia
11.16.02.2043|Kuala Penaga
11.16.03.2001|Kesehatan
11.16.03.2002|Suka Jadi
11.16.03.2006|Menanggini
11.16.03.2007|Tanjung Karang
11.16.03.2009|Bundar
11.16.03.2011|Dalam
11.16.03.2012|Tanah Terban
11.16.03.2013|Air Tenang
11.16.03.2014|Johar
11.16.03.2015|Tupah
11.16.03.2016|Banai
11.16.03.2017|Rantau Panjang
11.16.03.2018|Medang Ara
11.16.03.2019|Pahlawan
11.16.03.2020|Alur Selalas
11.16.03.2021|Paya Tampah
11.16.03.2022|Alur Baung
11.16.03.2023|Kebun Tanah Terban
11.16.03.2024|Kebun Medang Ara
11.16.03.2025|Kebun Afdeling Seleleh
11.16.03.2026|Paya Awe
11.16.03.2027|Simpang Empat
11.16.03.2028|Paya Kulbi
11.16.03.2029|Alur Bemban
11.16.03.2030|Paya Meta
11.16.03.2031|Tanjung Seumantoh
11.16.03.2032|Bukit Keranji
11.16.03.2033|Kebun Tanjung Seumantoh
11.16.03.2034|Bukit Panjang
11.16.03.2035|Alue Lhok
11.16.03.2036|Suka Jadi Paya Bujok
11.16.04.2002|Pekan Seruway
11.16.04.2003|Binjai
11.16.04.2004|Pantai Balai
11.16.04.2005|Padang Langgis
11.16.04.2006|Suka Ramai Satu
11.16.04.2007|Suka Ramai Dua
11.16.04.2008|Perkebunan Seruway
11.16.04.2009|Gedung Biara
11.16.04.2010|Alur Alim
11.16.04.2011|Tualang
11.16.04.2012|Matang Sentang
11.16.04.2013|Air Masin
11.16.04.2014|Sidodadi
11.16.04.2015|Perk. Gedung Biara
11.16.04.2016|Muka Sungai Kuruk
11.16.04.2017|Paya Udang
11.16.04.2018|Gelung
11.16.04.2019|Kampung Baru
11.16.04.2020|Kuala Pusung Kapal
11.16.04.2021|Sungai Kuruk I
11.16.04.2022|Sungai Kuruk II
11.16.04.2023|Sungai Kuruk III
11.16.04.2024|Tangsi Lama
11.16.04.2025|Lubuk Damar
11.16.05.2001|Kota Kualasimpang
11.16.05.2002|Perdamaian
11.16.05.2003|Sriwijaya
11.16.05.2004|Bukit Tempurung
11.16.05.2005|Kota Lintang
11.16.06.2001|Bukit Rata
11.16.06.2002|Pangkalan
11.16.06.2003|Tanjung Mancang
11.16.06.2004|Simpang Kanan
11.16.06.2005|Tanjung Genteng
11.16.06.2006|Gerenggam
11.16.06.2007|Suka Makmur
11.16.06.2008|Alur Selebu
11.16.06.2010|Sungai Liput
11.16.06.2011|Kebun Sungai Liput
11.16.06.2012|Purwodadi
11.16.06.2013|Jawa
11.16.06.2014|Sidodadi
11.16.06.2015|Karang Jadi
11.16.06.2016|Seumadam
11.16.06.2021|Alur Mentawak
11.16.07.2001|Alur Tani Satu
11.16.07.2002|Alur Tani Dua
11.16.07.2003|Bandar Khalifah
11.16.07.2004|Kaloy
11.16.07.2005|Perkebunan Pulau Tiga
11.16.07.2006|Harum Sari
11.16.07.2007|Bandar Setia
11.16.07.2008|Rongoh
11.16.07.2010|Wono Sari
11.16.08.2001|Benua Raja
11.16.08.2002|Landuh
11.16.08.2003|Paya Bedi
11.16.08.2004|Ingin Jaya
11.16.08.2005|Suka Rahmat
11.16.08.2006|Suka Jadi
11.16.08.2007|Durian
11.16.08.2008|Rantau Pauh
11.16.08.2009|Alur Cucur
11.16.08.2010|Pertamina
11.16.08.2011|Kebun Rantau
11.16.08.2012|Alur Manis
11.16.08.2013|Jamur Jelatang
11.16.08.2014|Suka Rakyat
11.16.08.2015|Jamur Labu
11.16.08.2016|Suka Mulia
11.16.08.2017|Mekar Jaya
11.16.09.2001|Telaga Meuku Sa
11.16.09.2002|Telaga Meuku Dua
11.16.09.2003|Alur Nunang
11.16.09.2004|Tanjung Keramat
11.16.09.2005|Matang Seping
11.16.09.2006|Besar
11.16.09.2007|Paya Rahat
11.16.09.2008|Suka Jadi
11.16.09.2009|Suka Mulia Upah
11.16.09.2010|Suka Damai
11.16.10.2001|Aras Sembilan
11.16.10.2002|Jambo Rambong
11.16.10.2003|Blang Kandis
11.16.10.2004|Alur Jambu
11.16.10.2005|Perkebunan Alur Jambu
11.16.10.2006|Batang Ara
11.16.10.2007|Perupuk
11.16.10.2008|Serba
11.16.10.2009|Sunting
11.16.10.2010|Rantau Bintang
11.16.10.2011|Babo
11.16.10.2012|Pantai Cempa
11.16.10.2013|Pengidam
11.16.10.2014|Bengkelang
11.16.10.2015|Batu Bedulang
11.16.11.2001|Tebing Tinggi
11.16.11.2002|Rimba Sawang
11.16.11.2003|Tenggulun
11.16.11.2004|Selamat
11.16.11.2005|Simpang Kiri
11.16.11.2006|Sumber Makmur
11.16.12.2001|Bandar Mahligai
11.16.12.2002|Sekerak Kiri
11.16.12.2003|Pantai Tinjau
11.16.12.2004|Pantai Perlak
11.16.12.2005|Kebun Batang Ara
11.16.12.2006|Sekerak Kanan
11.16.12.2007|Lubuk Sidup
11.16.12.2008|Sekumur
11.16.12.2009|Tanjung Gelumpang
11.16.12.2010|Pematang Durian
11.16.12.2011|Juar
11.16.12.2012|Sulum
11.16.12.2013|Suka Makmur
11.16.12.2014|Baling Karang
11.17.01.2001|Blang Rakal
11.17.01.2002|Negeri Antara
11.17.01.2003|Alur Cincin
11.17.01.2004|Pantan Sinaku
11.17.01.2005|Bintang Berangun
11.17.01.2006|Taman Firdaus
11.17.01.2007|Uning Mas
11.17.01.2008|Perdamaian
11.17.01.2009|Ulu Naron
11.17.01.2010|Pantan Lah
11.17.01.2011|Pancar Jelobok
11.17.01.2012|Alur Gading
11.17.01.2013|Rime Raya
11.17.01.2014|Singah Mulo
11.17.01.2015|Simpang Lancang
11.17.01.2016|Wih Porak
11.17.01.2017|Bener Meriah
11.17.01.2018|Musara 58
11.17.01.2019|Musara Pakat
11.17.01.2020|Rata Ara
11.17.01.2021|Gemasih
11.17.01.2022|Pulo Intan
11.17.01.2023|Blang Ara
11.17.02.2001|Bener Pepanyi
11.17.02.2002|Bintang Bener
11.17.02.2003|Bintang Permata
11.17.02.2004|Buntul Peteri
11.17.02.2005|Darul Aman
11.17.02.2006|GLP. Wih Tenang Uken
11.17.02.2007|Pantan Tengah Jaya
11.17.02.2008|Penosan Jaya
11.17.02.2009|Ramung Jaya
11.17.02.2010|Seni Antara
11.17.02.2011|Temas Mumanang
11.17.02.2012|Wih Tenang Toa
11.17.02.2013|Wih Tenang Uken
11.17.02.2014|Ayu Ara
11.17.02.2015|Ceding Ayu
11.17.02.2016|Uning Sejuk
11.17.02.2017|Suku Sara Tangke
11.17.02.2018|Rikit Musara
11.17.02.2019|Jungke
11.17.02.2020|Burni Pase
11.17.02.2021|Bale Musara
11.17.02.2022|Pemango
11.17.02.2023|Jelobok
11.17.02.2024|Kepies
11.17.02.2025|Timur Jaya
11.17.02.2026|Bale Purnama
11.17.02.2027|Tawar Bengi
11.17.03.2001|Blang Panu
11.17.03.2003|Gerpa
11.17.03.2004|Goneng
11.17.03.2007|Kerlang
11.17.03.2008|Kutelah Lane
11.17.03.2009|Pasir Putih
11.17.03.2010|Payung
11.17.03.2012|Rusip
11.17.03.2014|Tembolon
11.17.03.2015|Uning
11.17.03.2016|Wihni Durin
11.17.03.2017|Rata Mulie
11.17.03.2018|Tempen Baru
11.17.03.2019|Geruti Jaya
11.17.04.2001|Bahgie Bertona
11.17.04.2003|Bathin Baru
11.17.04.2004|Blang Pulo
11.17.04.2009|Bukit Wih Ilang
11.17.04.2010|Hakim Wih Ilang
11.17.04.2011|Janarata
11.17.04.2012|Keramat Jaya
11.17.04.2013|Lewa Jadi
11.17.04.2014|Muyang Kute Mangku
11.17.04.2016|Pakat Jeroh
11.17.04.2017|Paya Baning
11.17.04.2018|Blang Jorong
11.17.04.2019|Pondok Baru
11.17.04.2020|Pondok Gajah
11.17.04.2021|Pondok Ulung
11.17.04.2022|Puja Mulia
11.17.04.2023|Purwosari
11.17.04.2024|Selamat Rejo
11.17.04.2025|Sidodadi
11.17.04.2026|Simpang Utama
11.17.04.2027|Suku Wih Ilang
11.17.04.2028|Tanjung Pura
11.17.04.2029|Wonosari
11.17.04.2030|Mutiara
11.17.04.2032|Tansaran Bidin
11.17.04.2033|Jadi Sepakat
11.17.04.2034|Selisih Mara
11.17.04.2035|Kala Nempan
11.17.04.2036|Gunung Antara
11.17.04.2037|Gele Semayang
11.17.04.2042|Tawar Sedenge
11.17.04.2043|Beranun Teleden
11.17.04.2044|Remang Ketike Jaya
11.17.04.2045|Makmur Sentosa
11.17.04.2047|Sinar Jaya Paya Ringkel
11.17.05.2001|Bale Atu
11.17.05.2002|Bale Redelong
11.17.05.2003|Batin Wih Pongas
11.17.05.2004|Blang Ara
11.17.05.2005|Blang Sentang
11.17.05.2006|Blang Tampu
11.17.05.2007|Bujang
11.17.05.2009|Delung Tue
11.17.05.2010|Hakim Tungul Naru
11.17.05.2011|Isaq Busur
11.17.05.2012|Kenawat Redelong
11.17.05.2013|Kute Lintang
11.17.05.2014|Panji Mulia I
11.17.05.2015|Panji Mulia II
11.17.05.2016|Pasar Simpang Tiga
11.17.05.2017|Reje Guru
11.17.05.2018|Rembele
11.17.05.2019|Sedie Jadi
11.17.05.2020|Tingkem Asli
11.17.05.2021|Tingkem Benyer
11.17.05.2022|Tingkem Bersatu
11.17.05.2023|Ujung Gele
11.17.05.2024|Uning Bersah
11.17.05.2025|Uning Teritit
11.17.05.2026|Waq Pondok Sayur
11.17.05.2027|Babussalam
11.17.05.2028|Paya Gajah
11.17.05.2029|Kute Tanyung
11.17.05.2030|Meluem
11.17.05.2031|Delung Asli
11.17.05.2032|Pilar Jaya
11.17.05.2033|Serule Kayu
11.17.05.2034|Uring
11.17.05.2035|Mupakat Jadi
11.17.05.2036|Kute Kering
11.17.05.2037|Blang Panas
11.17.05.2038|Mutiara Baru
11.17.05.2039|Bukit Bersatu
11.17.05.2040|Godang
11.17.05.2041|Karang Rejo
11.17.06.2001|Blang Paku
11.17.06.2004|Pante Raya
11.17.06.2005|Simpang Balek
11.17.06.2006|Simpang Teritit
11.17.06.2007|Suka Jadi
11.17.06.2008|Suka Makmur
11.17.06.2009|Suka Ramai Atas
11.17.06.2010|Suka Ramai Bawah
11.17.06.2011|Syura Jadi
11.17.06.2012|Jamur Uluh
11.17.06.2013|Gegerung
11.17.06.2014|Merie Satu
11.17.06.2015|Blang Benara
11.17.06.2016|Bukit Pepanyi
11.17.06.2017|Wih Pesam
11.17.06.2018|Cinta Damai
11.17.06.2019|Bener Ayu
11.17.06.2020|Bener Mulie
11.17.06.2021|Blang Kucak
11.17.06.2022|Wonosobo
11.17.06.2023|Lut Kucak
11.17.06.2024|Kebun Baru
11.17.06.2025|Simpang Antara
11.17.06.2026|Jamur Ujung
11.17.06.2027|Suka Makmur Timur
11.17.06.2028|Burni Telong
11.17.07.2001|Bandar Lampahan
11.17.07.2002|Blang Rongka
11.17.07.2003|Cekal Baru
11.17.07.2004|Gegur Sepakat
11.17.07.2005|Karang Jadi
11.17.07.2006|Lampahan
11.17.07.2010|Setie
11.17.07.2011|Simpang Layang
11.17.07.2012|Suka Damai
11.17.07.2014|Tunyang
11.17.07.2016|Datu Beru
11.17.07.2017|Kenine
11.17.07.2018|Rembune
11.17.07.2019|Damaran Baru
11.17.07.2020|Fajar Harapan
11.17.07.2021|Mude Benara
11.17.07.2022|Kampung Baru 76
11.17.07.2023|Pantan Pediangan
11.17.07.2024|Bumi Ayu
11.17.07.2025|Kulem Para Kanis
11.17.07.2026|Mekar Ayu
11.17.07.2027|Lampahan Barat
11.17.07.2028|Lampahan Timur
11.17.07.2029|Timang Rasa
11.17.07.2030|Gunung Tunyang
11.17.07.2031|Bukit Tunyang
11.17.07.2032|Linung Bale
11.17.07.2033|Pantan Kemuning
11.17.07.2034|Sumber Jaya
11.17.07.2035|Bukit Mulie
11.17.08.2001|Bandar Jaya
11.17.08.2002|Jongok Meluem
11.17.08.2003|Suku Bener
11.17.08.2004|Bener Lukup II
11.17.08.2005|Gunung Musara
11.17.08.2006|Bener Kelipah Selatan
11.17.08.2007|Bintang Musara
11.17.08.2008|Kala Tenang
11.17.08.2009|Bener Kelipah Utara
11.17.08.2010|Lot Bener Kelipah
11.17.08.2011|Nosar Tawar Jaya
11.17.08.2012|Nosar Baru
11.17.09.2001|Cemparam Lama
11.17.09.2002|Cemparam Pakat Jeroh
11.17.09.2003|Cemparam Jaya
11.17.09.2004|Pantan Kuli
11.17.09.2005|Simpang Renggali
11.17.09.2006|Jamur Atu Jaya
11.17.09.2007|Sosial
11.17.09.2008|Gunung Sayang
11.17.09.2009|Amor
11.17.09.2010|Buntul Gayo
11.17.09.2011|Wih Resap
11.17.09.2012|Wer Tingkem
11.17.09.2013|Perumpaken Benjadi
11.17.09.2014|Hakim Peteri Pintu
11.17.09.2015|Simpur
11.17.10.2001|Simpang Rahmat
11.17.10.2002|Gajah Putih
11.17.10.2003|Gayo Setie
11.17.10.2004|Umah Besi
11.17.10.2005|Pante Karya
11.17.10.2006|Meriah Jaya
11.17.10.2007|Timang Gajah
11.17.10.2008|Pantan Lues
11.17.10.2009|Alam Jaya
11.17.10.2010|Reronga
11.18.01.2001|Meunasah Balek
11.18.01.2002|Kota Meureudu
11.18.01.2003|Mesjid Tuha
11.18.01.2004|Rungkom
11.18.01.2005|Blang Awe
11.18.01.2006|Manyang Lancok
11.18.01.2007|Manyang Cut
11.18.01.2008|Beurawang
11.18.01.2009|Rhieng Blang
11.18.01.2010|Rhieng Krueng
11.18.01.2011|Rhieng Mancang
11.18.01.2012|Meunasah Lhok
11.18.01.2013|Meuraksa
11.18.01.2014|Pulo U
11.18.01.2015|Geuleudah
11.18.01.2016|Dayah Timu
11.18.01.2017|Bunot
11.18.01.2018|Glumpang Tutong
11.18.01.2019|Meunasah Hagu
11.18.01.2020|Pohroh
11.18.01.2021|Kudrang
11.18.01.2022|Lampoh Lada
11.18.01.2023|Mulieng
11.18.01.2024|Dayah Tuha
11.18.01.2025|Rumpuen
11.18.01.2026|Rambong
11.18.01.2027|Meunasah Kulam
11.18.01.2028|Grong-Grong
11.18.01.2029|Kuta Trieng
11.18.01.2030|Teupin Peuraho
11.18.02.2001|Dayah Baroh
11.18.02.2002|Reuleut
11.18.02.2003|Sambongan Baro
11.18.02.2004|Tijien Husen
11.18.02.2005|Meunasah Krueng
11.18.02.2006|Geulanggang
11.18.02.2007|Mesjid Ulim Baroh
11.18.02.2008|Pulo Lhok
11.18.02.2009|Dayah Leubue
11.18.02.2010|Tijien Daboh
11.18.02.2011|Keude Ulim
11.18.02.2012|Meunasah Bueng
11.18.02.2013|Balee Ulim
11.18.02.2014|Grong Grong Capa
11.18.02.2015|Meunasah Kumbang
11.18.02.2016|Tanjong Ulim
11.18.02.2017|Mesjid Ulim Tunong
11.18.02.2018|Pulo Ulim
11.18.02.2019|Siblah Coh
11.18.02.2020|Bidok
11.18.02.2021|Pantang Cot Baloi
11.18.02.2022|Meunasah Pupu
11.18.02.2023|Nangrhoe Barat
11.18.02.2024|Nangrhoe Timu
11.18.02.2025|Meunasah Mesjid
11.18.02.2026|Blang Rheue
11.18.02.2027|Cot Seutui
11.18.02.2028|Lhok Gajah
11.18.02.2029|Alue Keumiki
11.18.02.2030|Blang Cari
11.18.03.2001|Meuko Jurong
11.18.03.2002|Kuta Baroh
11.18.03.2003|Meuko Meugit
11.18.03.2004|Kiran Dayah
11.18.03.2005|Kiran Baroh
11.18.03.2006|Keurisi Meunasah Raya
11.18.03.2007|Keurisi Meunasah Lueng
11.18.03.2008|Keurisi Meunasah Beurembang
11.18.03.2009|Meunasah Mee
11.18.03.2010|Meunasah Kumbang
11.18.03.2011|Kiran Krueng
11.18.03.2012|Buket Teungoh
11.18.03.2013|Reului Mangat
11.18.03.2014|Gampong Cot
11.18.03.2015|Jurong Binje
11.18.03.2016|Jurong Teungoh
11.18.03.2017|Jurong Ara
11.18.03.2018|Keude Jangka Buya
11.18.04.2001|Keude Ulee Gle
11.18.04.2002|Ulee Gle
11.18.04.2003|Blang Dalam
11.18.04.2004|Pulo
11.18.04.2005|Baro
11.18.04.2006|Meuko Kuthang
11.18.04.2007|Uteun Bayu
11.18.04.2008|Alue Ketapang
11.18.04.2009|Jaulanga Barat
11.18.04.2010|Kumba
11.18.04.2011|Babah Krueng
11.18.04.2012|Pohroh
11.18.04.2013|Seunong
11.18.04.2014|Alue Mee
11.18.04.2015|Blang Kuta
11.18.04.2016|Drien Tujoh
11.18.04.2017|Alue Sane
11.18.04.2018|Gahru
11.18.04.2019|Lhok Pusong
11.18.04.2020|Paya Pisang Klat
11.18.04.2021|Cot Geurefai
11.18.04.2022|Muko Dayah
11.18.04.2023|Meuko Buloh
11.18.04.2024|Peulakan Tunong
11.18.04.2025|Adan
11.18.04.2026|Meugit Kayee Panyang
11.18.04.2027|Meugit Sagoe
11.18.04.2028|Meurandeh Alue
11.18.04.2029|Reudeup Melayu
11.18.04.2030|Meunasah Paku
11.18.04.2031|Jeulanga Mata Ie
11.18.04.2032|Jeulanga Mesjid
11.18.04.2033|Pulo Gapu
11.18.04.2034|Blang Miroe
11.18.04.2035|Beurasan
11.18.04.2036|Cot Keng
11.18.04.2037|Krueng Kiran
11.18.04.2038|Asan Kumbang
11.18.04.2039|Drien Bungong
11.18.04.2040|Peulakan Cibrek
11.18.04.2041|Paya Tunong
11.18.04.2042|Peulakan Tambo
11.18.04.2043|Paya Baroh
11.18.04.2044|Meuko Baroh
11.18.04.2045|Kuta Krueng
11.18.05.2001|Lhok Sandeng
11.18.05.2002|Sarah Mane
11.18.05.2003|Seunong
11.18.05.2004|Lancok
11.18.05.2005|Meunasah Kulam
11.18.05.2006|Meunasah Teungoh
11.18.05.2007|Meunasah Bie
11.18.05.2008|Meunasah Raya
11.18.05.2009|Geunteng
11.18.05.2010|Gampong Blang
11.18.05.2011|Blang Cut
11.18.05.2012|Dayah Kruet
11.18.05.2013|Meunasah Mancang
11.18.05.2014|Dayah Usen
11.18.05.2015|Lueng Bimba
11.18.05.2016|Beuringen
11.18.05.2017|Buangan
11.18.05.2018|Meunasah Jurong
11.18.05.2019|Pante Beureune
11.18.06.2001|Cut Nyong
11.18.06.2002|Meunasah Gampong
11.18.06.2003|Baro
11.18.06.2004|Pulo Rheng
11.18.06.2005|Dayah Nyong
11.18.06.2006|Daboih
11.18.06.2007|Beurandeh
11.18.06.2008|Kaye Raya
11.18.06.2009|Blang Glong
11.18.06.2010|Tutong
11.18.06.2011|Siren
11.18.06.2012|Keude Lueng Putu
11.18.06.2013|Peub Lueng Nibong
11.18.06.2014|Baroh Musa
11.18.06.2015|Teungoh Musa
11.18.06.2016|Balee
11.18.06.2017|Udeung
11.18.06.2018|Ara
11.18.06.2019|Baroh Lancok
11.18.06.2020|Manyang
11.18.06.2021|Mesjid
11.18.06.2022|Pulo Pueb
11.18.06.2023|Sawang
11.18.06.2024|Tualada
11.18.06.2025|Cut Langien
11.18.06.2026|Sagoe
11.18.06.2027|Dayah Langien
11.18.06.2028|Baroh Cot
11.18.06.2029|Meunasah Blang Iboih
11.18.06.2030|Blang Sukon
11.18.06.2031|Kayee Jatoe
11.18.06.2032|Blang Baro
11.18.06.2033|Lancang
11.18.06.2034|Paru Keude
11.18.06.2035|Blang Krueng
11.18.06.2036|Jijiem
11.18.06.2037|Sarah Panyang
11.18.06.2038|Abah Lueng
11.18.06.2039|Aki Neungoh
11.18.06.2040|Ujong Leubat
11.18.06.2041|Alue
11.18.06.2042|Tanoh Mirah
11.18.06.2043|Paru Cot
11.18.07.2001|Keude Panteraja
11.18.07.2002|Tu
11.18.07.2003|Hagu
11.18.07.2004|Muka Blang
11.18.07.2005|Lhok Puuk
11.18.07.2006|Mesjid
11.18.07.2007|Teungoh
11.18.07.2008|Tunong
11.18.07.2009|Peurade
11.18.07.2010|Reudeup
11.18.08.2001|Sagoe
11.18.08.2002|Mee Peuduek
11.18.08.2003|Mesjid Peuduek
11.18.08.2004|Tuha
11.18.08.2005|Reuseb
11.18.08.2006|Dee
11.18.08.2007|Panton Raya
11.18.08.2008|Deah Teumanah
11.18.08.2009|Tampui
11.18.08.2010|Keude Trienggadeng
11.18.08.2011|Raya
11.18.08.2012|Paya
11.18.08.2013|Meue
11.18.08.2014|Mesjid Trienggadeng
11.18.08.2015|Teungkluet
11.18.08.2016|Matang
11.18.08.2017|Deah Ujong Baroh
11.18.08.2018|Peulandok Teungoh
11.18.08.2019|Peulandok Tunong
11.18.08.2020|Deah Pangwa
11.18.08.2021|Meucat
11.18.08.2022|Cot Makaso
11.18.08.2023|Buloh
11.18.08.2024|Mee Pangwa
11.18.08.2025|Kuta Pangwa
11.18.08.2026|Cot Lheue Rheng
11.18.08.2027|Rawasari
11.71.01.2001|Kampung Baru
11.71.01.2002|Neusu Jaya
11.71.01.2003|Sukaramai
11.71.01.2004|Seutui
11.71.01.2005|Peuniti
11.71.01.2006|Neusu Aceh
11.71.01.2007|Ateuk Pahlawan
11.71.01.2008|Ateuk Jawo
11.71.01.2009|Ateuk Deah Tanoh
11.71.01.2010|Ateuk Munjeng
11.71.02.2001|Mulia
11.71.02.2002|Peunayong
11.71.02.2003|Laksana
11.71.02.2004|Keuramat
11.71.02.2005|Kota Baru
11.71.02.2006|Beurawe
11.71.02.2007|Kuta Alam
11.71.02.2008|Bandar Baru
11.71.02.2009|Lamdingin
11.71.02.2010|Lampulo
11.71.02.2011|Lambaro Skep
11.71.03.2001|Punge Jurong
11.71.03.2002|Ulee Lheue
11.71.03.2003|Lambung
11.71.03.2004|Deah Glumpang
11.71.03.2005|Deah Baro
11.71.03.2006|Alue Deah Teungoh
11.71.03.2007|Lampaseh Aceh
11.71.03.2008|Blang Oi
11.71.03.2009|Asoe Nanggroe
11.71.03.2010|Gampong Blang
11.71.03.2011|Gampong Pie
11.71.03.2012|Lamjabat
11.71.03.2013|Cot Lamkuweuh
11.71.03.2014|Surien
11.71.03.2015|Gampong Baro
11.71.03.2016|Punge Ujong
11.71.04.2001|Jeulingke
11.71.04.2002|Tibang
11.71.04.2003|Deah Raya
11.71.04.2004|Alue Naga
11.71.04.2005|Ie Masen Kayee Adang
11.71.04.2006|Pineung
11.71.04.2007|Lamgugob
11.71.04.2008|Kopelma Darussalam
11.71.04.2009|Rukoh
11.71.04.2010|Peurada
11.71.05.2001|Lueng Bata
11.71.05.2002|Cot Mesjid
11.71.05.2003|Panteriek
11.71.05.2004|Blang Cut
11.71.05.2005|Lamseupeung
11.71.05.2006|Batoh
11.71.05.2007|Suka Damai
11.71.05.2008|Lamdom
11.71.05.2009|Lampaloh
11.71.06.2001|Keudah
11.71.06.2002|Peulanggahan
11.71.06.2003|Merduati
11.71.06.2004|Lampaseh Kota
11.71.06.2005|Gampong Pande
11.71.06.2006|Gampong Jawa
11.71.07.2001|Geuceu Komplek
11.71.07.2002|Lamlagang
11.71.07.2003|Geuceu Iniem
11.71.07.2004|Geuceu Kayee Jato
11.71.07.2005|Lam Ara
11.71.07.2006|Lhong Raya
11.71.07.2007|Mibo
11.71.07.2008|Peunyerat
11.71.07.2009|Lhong Cut
11.71.07.2010|Lampeuot
11.71.08.2001|Punge Blang Cut
11.71.08.2002|Bitai
11.71.08.2003|Lamjamee
11.71.08.2004|Ulee Pata
11.71.08.2005|Lampoh Daya
11.71.08.2006|Emperom
11.71.08.2007|Geuceu Meunara
11.71.08.2008|Lamteumen Timur
11.71.08.2009|Lamteumen Barat
11.71.09.2001|Lambhuk
11.71.09.2002|Lamteh
11.71.09.2003|Ilie
11.71.09.2004|Pango Raya
11.71.09.2005|Pango Deah
11.71.09.2006|Ceurih
11.71.09.2007|Doy
11.71.09.2008|Lamglumpang
11.71.09.2009|Ie Masen Ulee Kareng
11.72.01.2004|Krueng Raya
11.72.01.2005|Aneuk Laot
11.72.01.2006|Kuta Timu
11.72.01.2007|Kuta Barat
11.72.01.2008|Kuta Ateuh
11.72.02.2004|Jaboi
11.72.02.2005|Balohan
11.72.02.2006|Cot Abeuk
11.72.02.2007|Cot Ba U
11.72.02.2008|Ie Meulee
11.72.02.2009|Ujoeng Kareung
11.72.02.2010|Anoe Itam
11.72.03.2001|Iboih
11.72.03.2002|Batee Shok
11.72.03.2003|Paya Seunara
11.72.03.2004|Paya
11.72.03.2005|Keunekai
11.72.03.2006|Beurawang
11.73.01.2002|Alue Awe
11.73.01.2003|Blang Crum
11.73.01.2004|Cut Mamplam
11.73.01.2005|Meunasah Mee
11.73.01.2006|Cot Girek Kandang
11.73.01.2007|Keude Cunda
11.73.01.2008|Uteunkot
11.73.01.2009|Lhok Mon Puteh
11.73.01.2010|Meunasah Mesjid
11.73.01.2011|Mns. Panggoi
11.73.01.2013|Paya Bili
11.73.01.2014|Meunasah Alue
11.73.01.2015|Paya Punteuet
11.73.01.2016|Blang Poroh
11.73.01.2024|Meunasah Manyang
11.73.01.2025|Meunasah Blang
11.73.01.2026|Paloh Batee
11.73.02.2001|Kuta Blang
11.73.02.2002|Tumpok Teungoh
11.73.02.2003|Simpang Empat
11.73.02.2004|Kampung Jawa Lhokseumawe
11.73.02.2005|Kota Lhokseumawe
11.73.02.2006|Mon Geudong
11.73.02.2007|Keude Aceh
11.73.02.2008|Pusong Lhokseumawe
11.73.02.2009|Hagu Teungoh
11.73.02.2010|Uteun Bayi
11.73.02.2011|Ujong Blang
11.73.02.2012|Hagu Selatan
11.73.02.2013|Pusong Baru
11.73.02.2014|Ulee Jalan
11.73.02.2015|Banda Masen
11.73.02.2016|Lancang Garam
11.73.02.2017|Jawa Baroe
11.73.02.2018|Hagu Barat Laut
11.73.03.2001|Kuala
11.73.03.2002|Blang Cut
11.73.03.2003|Jambo Mesjid
11.73.03.2004|Jambo Timu
11.73.03.2005|Tunong
11.73.03.2006|Blang Teue
11.73.03.2007|Teungoh
11.73.03.2008|Baloi
11.73.03.2009|Mane Kareung
11.73.03.2010|Asan Kareung
11.73.03.2011|Rayeuk Kareung
11.73.03.2012|Blang Punteuet
11.73.03.2013|Kumbang Punteuet
11.73.03.2014|Mesjid Punteuet
11.73.03.2015|Ulee Blang Mane
11.73.03.2016|Keude Punteuet
11.73.03.2017|Alue Lim
11.73.03.2018|Blang Buloh
11.73.03.2019|Blang Weu Panjoe
11.73.03.2020|Jeulikat
11.73.03.2021|Blang Weu Baroh
11.73.03.2022|Seuneubok
11.73.04.2001|Batuphat Barat
11.73.04.2002|Blang Panyang
11.73.04.2003|Meunasah Dayah
11.73.04.2004|Paloh Punti
11.73.04.2005|Blang Pulo
11.73.04.2006|Batuphat Timur
11.73.04.2007|Blang Naleung Mameh
11.73.04.2008|Cot Trieng
11.73.04.2009|Padang Sakti
11.73.04.2010|Meuria Paloh
11.73.04.2011|Ujong Pacu
11.74.01.2007|Buket Medang Ara
11.74.01.2009|Matang Seutui
11.74.01.2010|Buket Pulo
11.74.01.2011|Matang Panyang
11.74.01.2012|Simpang Wie
11.74.01.2013|Buket Rata
11.74.01.2014|Buket Meutuah
11.74.01.2015|Alue Merbau
11.74.01.2016|Matang Cengai
11.74.01.2017|Seunubok Antara
11.74.01.2018|Alue Pineung
11.74.01.2019|Sukarejo
11.74.01.2020|Cinta Raja
11.74.01.2021|Sungai Lueng
11.74.01.2025|Alue Pineung Timue
11.74.01.2026|Kapa
11.74.02.2005|Lhok Banie
11.74.02.2006|PB. Teungoh
11.74.02.2007|PB. Beuramo
11.74.02.2008|Simpang Lhee
11.74.02.2009|Seuriget
11.74.02.2015|Matang Seulimeng
11.74.02.2016|Sungai Pauh
11.74.02.2017|Kuala Langsa
11.74.02.2018|Teulaga Tujuh
11.74.02.2019|Serambi Indah
11.74.02.2020|Sungai Pauh Pusaka
11.74.02.2021|Sungai Pauh Tanjong
11.74.02.2022|Sungai Pauh Firdaus
11.74.03.2001|Teungoh
11.74.03.2002|Peukan Langsa
11.74.03.2004|Jawa
11.74.03.2005|Paya Bujok Blang Pase
11.74.03.2006|Blang
11.74.03.2007|Alue Beurawe
11.74.03.2009|Daulat
11.74.03.2010|Meutia
11.74.03.2011|Blang Seunibong
11.74.03.2013|Tualang Teungoh
11.74.04.2001|Pondok Kemuning
11.74.04.2002|Seulalah
11.74.04.2003|Pondok Pabrik
11.74.04.2004|Sidodadi
11.74.04.2005|Sidorejo
11.74.04.2006|Baro
11.74.04.2007|Meurandeh
11.74.04.2008|Asam Peutik
11.74.04.2009|Baroh Langsa Lama
11.74.04.2010|Seulalah Baru
11.74.04.2011|Sukajadi Kebun Ireng
11.74.04.2012|Meurandeh Tengah
11.74.04.2013|Meurandeh Dayah
11.74.04.2014|Meurandeh Aceh
11.74.04.2015|Batee Puteh
11.74.05.2001|Timbang Langsa
11.74.05.2002|Alue Dua
11.74.05.2003|Birem Puntong
11.74.05.2004|Paya Bujok Seuleumak
11.74.05.2005|Pondok Kelapa
11.74.05.2006|Karang Anyar
11.74.05.2007|Paya Bujok Tunong
11.74.05.2008|Geudubang Jawa
11.74.05.2009|Geudubang Aceh
11.74.05.2010|Alue Dua Bakaran Batee
11.74.05.2011|Lengkong
11.74.05.2012|Sukajadi Makmur
11.75.01.2001|Subulussalam
11.75.01.2002|Pegayo
11.75.01.2003|Sikalondang
11.75.01.2004|Buluh Dori
11.75.01.2005|Subulussalam Utara
11.75.01.2006|Subulussalam Selatan
11.75.01.2007|Subulussalam Barat
11.75.01.2008|Suka Makmur
11.75.01.2009|Tangga Besi
11.75.01.2010|Kuta Cepu
11.75.01.2011|Pasar Panjang
11.75.01.2012|Mukti Makmur
11.75.01.2013|Lae Oram
11.75.01.2014|Makmur Jaya
11.75.01.2015|Belegen Mulia
11.75.01.2016|Danau Tras
11.75.01.2017|Subulussalam Timur
11.75.02.2001|Penanggalan
11.75.02.2002|Cepu
11.75.02.2003|Kuta Tengah
11.75.02.2004|Kampung Baru
11.75.02.2005|Sikelang
11.75.02.2006|Penuntungan
11.75.02.2007|Jontor
11.75.02.2008|Lae Motong
11.75.02.2009|Lae Ikan
11.75.02.2010|Lae Bersih
11.75.02.2011|Dasan Raja
11.75.02.2012|Penanggalan Timur
11.75.02.2013|Penanggalan Barat
11.75.03.2001|Pasar Rundeng
11.75.03.2002|Dah
11.75.03.2003|Oboh
11.75.03.2004|Sepadan
11.75.03.2005|Sibuasan
11.75.03.2006|Binanga
11.75.03.2007|Kuta Beringin
11.75.03.2008|Muara Batu-batu
11.75.03.2009|Siperkas
11.75.03.2010|Lae Mate
11.75.03.2011|Sibungke
11.75.03.2012|Harapan Baru
11.75.03.2013|Teladan Baru
11.75.03.2014|Bulukur Makmur
11.75.03.2015|Badar
11.75.03.2016|Lae Pemulaan
11.75.03.2017|Panglima Saman
11.75.03.2018|Suak Jampak
11.75.03.2019|Geruguh
11.75.03.2020|Mandilam
11.75.03.2021|Tualang
11.75.03.2022|Kuala Kepeng
11.75.03.2023|Tanah Tumbuh
11.75.04.2001|Pasir Belo
11.75.04.2002|Bawan
11.75.04.2003|Sigrun
11.75.04.2004|Jabi-jabi
11.75.04.2005|Lae Simolap
11.75.04.2006|Lae Langge
11.75.04.2007|Suka Maju
11.75.04.2008|Gunung Bakti
11.75.04.2009|Jambi Baru
11.75.04.2010|Pulo Kedep
11.75.04.2011|Pulo Belen
11.75.04.2012|Singgersing
11.75.04.2013|Namo Buaya
11.75.04.2014|Cipare Pare
11.75.04.2015|Bunga Tanjung
11.75.04.2016|Cipar-Pari Timur
11.75.04.2018|Darul Makmur
11.75.04.2019|Jabi-Jabi Barat
11.75.04.2020|Batu Napal
11.75.05.2001|Longkib
11.75.05.2002|Sepang
11.75.05.2003|Panji
11.75.05.2004|Lae Saga
11.75.05.2005|Sikerabang
11.75.05.2006|Rantau Panjang
11.75.05.2007|Bukit Alim
11.75.05.2008|Darul Aman
11.75.05.2009|Bangun Sari
11.75.05.2010|Darussalam
12.01.01.1001|Pasar Batu Gerigis
12.01.01.1002|Padang Masiang
12.01.01.2003|Kampung Solok
12.01.01.2004|Pasar Terandam
12.01.01.2005|Sigambo Gambo
12.01.01.2006|Ujung Batu
12.01.01.2007|Kinali
12.01.01.2008|Kampung Mudik
12.01.01.2009|Aek Dakka
12.01.01.2010|Patupangan
12.01.01.2011|Gabungan Hasang
12.01.01.2017|Bungo Tanjung
12.01.01.2018|Kedai Gedang
12.01.02.1001|Sorkam
12.01.02.1002|Pargarutan
12.01.02.1004|Tarutung Bolak
12.01.02.1009|Naipospos Barat
12.01.02.2003|Teluk Roban
12.01.02.2005|Fajar
12.01.02.2006|Pardamean
12.01.02.2007|Pelita
12.01.02.2008|Rianiate
12.01.02.2010|Gonting Mahe
12.01.02.2011|Dolok Pantis
12.01.02.2014|Pea Raja
12.01.02.2015|Bottot
12.01.02.2016|Sorkam Tengah
12.01.02.2017|Sorkam Kiri
12.01.02.2018|Pananggahan
12.01.02.2019|Pagaran Julu
12.01.02.2020|Hite Urat
12.01.02.2021|Sihapas
12.01.02.2022|Nauli
12.01.02.2023|Muara Nauli
12.01.03.1001|Pandan
12.01.03.1002|Hajoran
12.01.03.1003|Aek Tolang
12.01.03.1004|Lubuk Tukko
12.01.03.1005|Sibuluan Indah
12.01.03.1006|Sibuluan Nauli
12.01.03.1011|Aek Sitio-tio
12.01.03.1012|Sibuluan Raya
12.01.03.1013|Kalangan
12.01.03.1016|Pandan Wangi
12.01.03.1017|Lubuk Tukko Baru
12.01.03.1018|Sibuluan Baru
12.01.03.1019|Sibuluan Terpadu
12.01.03.1020|Sihaporas Nauli
12.01.03.1021|Pasar Baru
12.01.03.1022|Budi Luhur
12.01.03.1023|Kalangan Indah
12.01.03.1024|Mangga Dua
12.01.03.1025|Muara Nibung
12.01.03.1026|Hajoran Indah
12.01.03.2014|Aek Garut
12.01.03.2015|Sitio-Tio Hilir
12.01.04.1001|Pinangsori
12.01.04.1004|Sitonong Bangun
12.01.04.1007|Pinangbaru
12.01.04.1009|Albion Prancis
12.01.04.1010|Sori Nauli
12.01.04.2002|Gunung Marijo
12.01.04.2003|Sihaporas
12.01.04.2005|Toga Basir
12.01.04.2006|Parjalihotan Baru
12.01.04.2008|Danau Pandan
12.01.05.1001|P.O. Manduamas
12.01.05.1003|Binjohara
12.01.05.1020|Perluasan
12.01.05.2002|Saragih
12.01.05.2004|Pagaran Nauli
12.01.05.2005|Sarma Nauli
12.01.05.2006|Manduamas Lama
12.01.05.2007|Tumba
12.01.05.2008|Tumba Jae
12.01.05.2009|Lae Monong
12.01.05.2010|Saragih Barat
12.01.05.2011|Saragih Timur
12.01.05.2012|Binjohara Uruk
12.01.05.2013|Binjohara Baru
12.01.05.2014|Tumba Nauli
12.01.05.2015|Manduamas Baru
12.01.05.2016|Muara Tapus
12.01.05.2017|Pagaran Baru
12.01.05.2018|Parsihotangan
12.01.05.2019|Tambahan Nanjur
12.01.06.1006|P.O. Hurlang
12.01.06.1007|Kolang Nauli
12.01.06.2001|Unte Mungkur IV
12.01.06.2002|Unte Mungkur III
12.01.06.2003|Unte Mungkur II
12.01.06.2004|Unte Mungkur I
12.01.06.2005|Satahi Nauli
12.01.06.2008|Hurlang Muara Nauli
12.01.06.2009|Sipakpahi Aek Lobu
12.01.06.2010|Hodopa Nauli
12.01.06.2011|Makarti Nauli
12.01.06.2012|Rawa Makmur
12.01.06.2013|Simarpinggang
12.01.06.2014|Pargaringan
12.01.07.1001|Tapian Nauli II
12.01.07.2002|Tapian Nauli I
12.01.07.2003|Tapian Nauli III
12.01.07.2004|Tapian Nauli IV
12.01.07.2005|Aloban Bair
12.01.07.2006|Mela Dolok
12.01.07.2007|Mela I
12.01.07.2008|Mela II
12.01.07.2009|Bair
12.01.08.1002|Sibabangun
12.01.08.2005|Mombang Boru
12.01.08.2006|Anggoli
12.01.08.2007|Muara Sibuntuon
12.01.08.2008|Sibio bio
12.01.08.2010|Simanosor
12.01.08.2011|Hutagur-gur
12.01.09.1001|Sosor Gadong
12.01.09.2002|Unte Boang
12.01.09.2003|Sibintang
12.01.09.2004|Barambang
12.01.09.2005|Siantar Ca
12.01.09.2006|Muara Bolak
12.01.09.2007|Huta Tombak
12.01.09.2008|Siantar Dolok
12.01.09.2009|Baringin
12.01.10.1001|Sorkam Kanan
12.01.10.1019|Binasi
12.01.10.2002|Sipea Pea
12.01.10.2003|Pahieme I
12.01.10.2004|Pasar Sorkam
12.01.10.2005|Aek Raso
12.01.10.2006|Pasaribu Tobing Jae
12.01.10.2014|Maduma
12.01.10.2016|Sidikalang
12.01.10.2017|Pahieme II
12.01.10.2018|Sorkam Kanan
12.01.10.2020|Madani
12.01.11.1001|Bajamas
12.01.11.2002|Sampang Maruhur
12.01.11.2003|Siordang
12.01.11.2004|Pardomuan
12.01.11.2005|Simpang III Lae Bingke
12.01.11.2006|Sigodung
12.01.11.2007|Masnauli
12.01.11.2008|Muara Ode
12.01.12.1007|Rina Bolak
12.01.12.2001|Sijungkang
12.01.12.2002|Pangaribuan
12.01.12.2003|Sogar
12.01.12.2004|Sirami Ramian
12.01.12.2005|Sigolang
12.01.12.2006|Sosor Gonting
12.01.12.2008|Bondar Sihudon I
12.01.12.2009|Uratan
12.01.12.2010|Ladang Tengah
12.01.12.2011|Lobu Tua
12.01.12.2012|Bondar Sihudon II
12.01.12.2013|Sitiris-Tiris
12.01.12.2014|Sawah Lamo
12.01.13.1003|Nauli
12.01.13.2001|Bonandolok
12.01.13.2002|Rampa
12.01.13.2004|Mardame
12.01.13.2005|Naga Timbul
12.01.13.2006|Simaninggir
12.01.14.1001|Tukka
12.01.14.1002|Bona Lumban
12.01.14.1003|Huta Nabolon
12.01.14.1007|Sipange
12.01.14.1009|Aek Tolang Induk
12.01.14.2004|Sigiring Giring
12.01.14.2005|Tapian Nauli/ Saurmanggita
12.01.14.2006|Sait Kalangan II
12.01.14.2008|Aek Bottar
12.01.15.1001|Hutabalang
12.01.15.1002|Lopian
12.01.15.2003|Jago Jago
12.01.15.2004|Aek Horsik
12.01.15.2005|Gunung Kelambu
12.01.15.2006|Kebun Pisang
12.01.15.2007|Lubuk Ampolu
12.01.15.2008|Pagaran Honas
12.01.15.2009|Sitardas
12.01.16.2001|Suga Suga Hutagodang
12.01.16.2002|Suka Maju
12.01.16.2003|Makmur
12.01.16.2004|Pasaribu Tobing
12.01.16.2005|Aek Nadua
12.01.16.2006|Simargarap
12.01.16.2007|Sidaling
12.01.16.2008|Sipakpahi
12.01.16.2009|PO Simargarap
12.01.17.2001|Hutaginjang
12.01.17.2002|Sihorbo
12.01.17.2003|Parik Sinomba
12.01.17.2004|Purba Tua
12.01.17.2005|Pananggahan
12.01.17.2006|Siharbangan
12.01.18.2001|Pulo Pakkat
12.01.18.2002|Tebing Tinggi
12.01.18.2003|Pulo Pakkat II
12.01.18.2004|Janji Maria
12.01.18.2005|Sihadatuon
12.01.18.2006|Sihapas
12.01.19.1001|Lumut
12.01.19.2002|Aek Gambir
12.01.19.2003|Masundung
12.01.19.2005|Lumut Nauli
12.01.19.2006|Lumut Maju
12.01.19.2007|Sialogo
12.01.20.1001|Sibuluan Nalambok
12.01.20.1002|Sarudik
12.01.20.1004|Pasir Bidang
12.01.20.1005|Pondok Batu
12.01.20.2003|Sipan
12.02.01.1001|Partoli Toruan
12.02.01.1002|Hutatoruan V
12.02.01.1003|Hutatoruan VI
12.02.01.1004|Hutatoruan VII
12.02.01.1005|Hutatoruan IX
12.02.01.1006|Hutatoruan X
12.02.01.1007|Hutatoruan XI
12.02.01.2008|Parbubu I
12.02.01.2009|Parbubu II
12.02.01.2010|Hutapea Banuarea
12.02.01.2011|Siandor-andor
12.02.01.2012|Hutauruk
12.02.01.2013|Hapoltahan
12.02.01.2014|Parbubu Dolok
12.02.01.2015|Aek Siansimun
12.02.01.2016|Htgalung Siwaluompo
12.02.01.2017|Parbubu Pea
12.02.01.2018|Hutatoruan IV
12.02.01.2019|Sosunggulon
12.02.01.2020|Hutatoruan VIII
12.02.01.2021|Simamora
12.02.01.2022|Parbaju Toruan
12.02.01.2023|Parbaju Julu
12.02.01.2024|Parbaju Tonga
12.02.01.2025|Sitampurung
12.02.01.2026|Siraja Oloan
12.02.01.2027|Jambur Nauli
12.02.01.2028|Sihujur
12.02.01.2029|Partali Julu
12.02.01.2030|Hutatoruan I
12.02.01.2031|Hutatoruan III
12.02.02.2001|Siraja Hutagalung
12.02.02.2002|Pansur Napitu
12.02.02.2003|Simanampang
12.02.02.2004|Sidagal
12.02.02.2005|Simarakir Julu
12.02.02.2006|Enda Portibi
12.02.02.2007|Simorangkir Habinsaran
12.02.02.2008|Sangkaran
12.02.02.2009|Lumban Siagian Jae
12.02.02.2010|Lumban Siagian Julu
12.02.02.2011|Sitompul
12.02.02.2012|Lobu Hole
12.02.03.2001|Dolok Nauli
12.02.03.2002|Pansurbatu
12.02.03.2003|Pardomuan Nauli
12.02.03.2004|Siantar Naipospos
12.02.03.2005|Sibalanga
12.02.03.2006|Pagaran Lambung III
12.02.03.2007|Pagaran Lambung IV
12.02.03.2008|Adian Koting
12.02.03.2009|Pangaran Pisang
12.02.03.2010|Banuaji IV
12.02.03.2011|Banuaji I
12.02.03.2012|Banuaji II
12.02.03.2013|Pangaran Lambung I
12.02.03.2014|Pangaran Lambung II
12.02.03.2015|Pansurbatu I
12.02.03.2016|Pansurbatu II
12.02.04.1001|Situmeang Habinsaran
12.02.04.2002|Hutauruk
12.02.04.2003|Simanungkalit
12.02.04.2004|Situmeang Hasundutan
12.02.04.2005|Sipahutar
12.02.04.2007|Tapian Nauli
12.02.04.2008|Huta Raja
12.02.04.2009|Lobu Singkam
12.02.04.2010|Rura Julu Dolok
12.02.04.2011|Rura Julu Toruan
12.02.04.2012|Hutaraja Hasundutan
12.02.04.2013|Pagarbatu
12.02.04.2014|Hutaraja Simanungkalit
12.02.04.2015|Hutauruk Hasundutan
12.02.05.1001|Onan Hasang
12.02.05.2002|Simasom
12.02.05.2003|Janji Natogu
12.02.05.2004|Pagur Dotan
12.02.05.2005|Sibaganding
12.02.05.2006|Lumban Garaga
12.02.05.2007|Sitolu Ama
12.02.05.2008|Lumban Tonga
12.02.05.2009|Lumban Dolok
12.02.05.2010|Simataniari
12.02.05.2011|Lumban Jaean
12.02.05.2012|Huta Barat
12.02.05.2013|Lontung Dolok
12.02.05.2014|Simanampang
12.02.05.2015|Lobu Pining
12.02.05.2016|Pantis
12.02.05.2017|Lumban Gaol
12.02.05.2018|Simardangiang
12.02.05.2019|Simasom Toruan
12.02.06.1001|Sarulla
12.02.06.2002|Tordolok Nauli
12.02.06.2003|Sigurung-gurung
12.02.06.2004|Silangkitang
12.02.06.2005|Sitoluompu
12.02.06.2006|Siopat Bahal
12.02.06.2007|Pardomuan Nainggolan
12.02.06.2008|Nahornop Marsada
12.02.06.2009|Parsaoran Samosir
12.02.06.2010|Suka Maju
12.02.06.2011|Setia
12.02.06.2012|Parsaoran Nainggolan
12.02.06.2013|Pardamean Nainggolan
12.02.07.2001|Silosung
12.02.07.2002|Dolok Sanggul
12.02.07.2003|Simangumban Jae
12.02.07.2004|Aek Nabara
12.02.07.2005|Dolok Saut
12.02.07.2006|Simangumban Julu
12.02.07.2007|Lobu Sihim
12.02.07.2008|Pardomuan
12.02.08.2001|Sidua Bahal
12.02.08.2002|Sibulan Bulan
12.02.08.2003|Bonani Dolok
12.02.08.2004|Pardomuan J.Angkola
12.02.08.2005|Hutanagodang
12.02.08.2006|Robean
12.02.08.2007|Janji Nauli
12.02.08.2008|Selamat
12.02.08.2009|Purba Tua
12.02.08.2010|Sitolu Bahal
12.02.08.2011|Parsaoran J. Angkola
12.02.09.1001|Psr Siborong Borong
12.02.09.2002|Siborong Borong I
12.02.09.2003|Siborong Borong II
12.02.09.2004|Sitampurung
12.02.09.2005|Sitabotabo
12.02.09.2006|Bahal Batu I
12.02.09.2007|Bahal Batu II
12.02.09.2008|Bahal Batu III
12.02.09.2009|Lobu Siregar I
12.02.09.2010|Lobu Siregar II
12.02.09.2011|Pohan Julu
12.02.09.2012|Pohan Tonga
12.02.09.2013|Pohan Jae
12.02.09.2014|Paniaran
12.02.09.2015|Parik Sabungan
12.02.09.2016|Hutabulu
12.02.09.2017|Lumban Tonga Tonga
12.02.09.2018|Sigumbang
12.02.09.2019|Siaro
12.02.09.2020|Silait-Lait
12.02.09.2021|Sitabotabo Toruan
12.02.10.2001|Simamora Hasibuan
12.02.10.2002|Lumban Julu
12.02.10.2003|Pagaran
12.02.10.2004|Sibaragas
12.02.10.2005|Sipultak
12.02.10.2006|Lubis
12.02.10.2007|Banualuhu
12.02.10.2008|Parhorboan
12.02.10.2009|Lumban Motung
12.02.10.2010|Lumban Ina Ina
12.02.10.2011|Doloksaribu
12.02.10.2012|Lumban Silintong
12.02.10.2013|Sipultak Dolok
12.02.10.2014|Hasibuan
12.02.11.2001|Manalu
12.02.11.2002|Manalu Purba
12.02.11.2003|Manalu Dolok
12.02.11.2004|Hutajulu
12.02.11.2005|Aek Raja
12.02.11.2006|Hutatinggi
12.02.11.2007|Lobusunut
12.02.11.2008|Sisordak
12.02.11.2009|Pertengahan
12.02.11.2010|Hutatua
12.02.11.2011|Hutajulu Parbalik
12.02.11.2012|Horisan Ranggitgit
12.02.11.2013|Purba Dolok
12.02.11.2014|Batuarimo
12.02.12.2001|Sabungannihuta IV
12.02.12.2002|Sabungannihuta I
12.02.12.2003|Sipahutar I
12.02.12.2004|Sipahutar II
12.02.12.2005|Sipahutar III
12.02.12.2006|Onan Runggu I
12.02.12.2007|Tapian Nauli III
12.02.12.2008|Onan Runggu III
12.02.12.2009|Siabal-abal III
12.02.12.2010|Siabal-abal I
12.02.12.2011|Aek Nauli II
12.02.12.2012|Tapian Nauli II
12.02.12.2013|Sabungannihuta III
12.02.12.2014|Onan Runggu IV
12.02.12.2015|Siabal-abal II
12.02.12.2016|Aek Nauli I
12.02.12.2017|Aek Nauli III
12.02.12.2018|Onan Runggu II
12.02.12.2019|Tapian Nauli I
12.02.12.2020|Sabungannihuta II
12.02.12.2021|Sabungannihuta V
12.02.12.2022|Siabal-abal IV
12.02.12.2023|Aek Nauli IV
12.02.12.2024|Siabal-abal V
12.02.12.2025|Siabal-abal VI
12.02.13.2001|Pakpahan
12.02.13.2002|Sampagul
12.02.13.2003|Godung Borotan
12.02.13.2004|Parratusan
12.02.13.2005|Lumban Siregar
12.02.13.2006|Sigotom Julu
12.02.13.2007|Rahut Bosi
12.02.13.2008|Batu Nadua
12.02.13.2009|Silantom Tonga
12.02.13.2010|Silantom Julu
12.02.13.2011|Pansurnatolu
12.02.13.2012|Parlombuan
12.02.13.2013|Purbatua
12.02.13.2014|Lumban Sinaga Simatupang
12.02.13.2015|Batumanumpak
12.02.13.2016|Sibingke
12.02.13.2017|Najumambe
12.02.13.2018|Parsibarungan
12.02.13.2019|Harianja
12.02.13.2020|Silantom Jae
12.02.13.2021|Padang Parsadaan
12.02.13.2022|Parsorminan I
12.02.13.2023|Hutaraja
12.02.13.2024|Rahut Bosi Onan
12.02.13.2025|Sigotom Timur
12.02.13.2026|Sigotom Dolok Nauli
12.02.14.2001|Garoga Sibargot
12.02.14.2002|Lontung Jae I
12.02.14.2003|Parsosoran
12.02.14.2004|Padang Siandomang
12.02.14.2005|Sibaganding
12.02.14.2006|Sirmpang Bolon
12.02.14.2007|Gonting Garoga
12.02.14.2008|Lontung Jae II
12.02.14.2009|Gonting Salak
12.02.14.2010|Sibalanga
12.02.14.2011|Aek Tangga
12.02.14.2012|Parinsoran
12.02.14.2013|Parmanuhan
12.02.15.2001|Hutanagodang
12.02.15.2002|Unte Mungkur
12.02.15.2003|Hutalontung
12.02.15.2004|Hutaginjang
12.02.15.2005|Dolok Matumbur
12.02.15.2006|Mariba Ni Aek
12.02.15.2007|Sampuran
12.02.15.2008|Silando
12.02.15.2009|Sibandang
12.02.15.2010|Simatupang
12.02.15.2011|Silali Toruan
12.02.15.2012|Batubinumbun
12.02.15.2013|Sitanggor
12.02.15.2014|Papande
12.02.15.2015|Aritonang
12.03.01.1001|Sitinjak
12.03.01.1003|Simatorkis Sisoma
12.03.01.2002|Panobasan
12.03.01.2004|Siuhom
12.03.01.2005|Sigumuru
12.03.01.2006|Sibangkua
12.03.01.2007|Sisundung
12.03.01.2008|Aek Nabara
12.03.01.2011|Parsalakan
12.03.01.2015|Sitaratoit
12.03.01.2016|Sialogo
12.03.01.2024|Lembah Lubuk Raya
12.03.01.2031|Lobu Layan Sigordang
12.03.01.2035|Panobasan Lombang
12.03.02.1001|Wek I
12.03.02.1002|Wek II
12.03.02.1011|Perkebunan Batang Toru
12.03.02.1030|Padang Lancat
12.03.02.1032|Aek Pining
12.03.02.2003|Garoga
12.03.02.2004|Huta Godang
12.03.02.2005|Batu Horing
12.03.02.2008|Batu Hula
12.03.02.2009|Sumuran
12.03.02.2015|Napa
12.03.02.2016|Wek IV
12.03.02.2017|Hapesong Baru
12.03.02.2018|Telo
12.03.02.2019|Wek III
12.03.02.2020|Perkebunan Sigala-Gala
12.03.02.2021|Perkebunan Hapesong
12.03.02.2022|Hapesong Lama
12.03.02.2023|Sipenggeng
12.03.02.2025|Sianggunan
12.03.02.2026|Huta Baru
12.03.02.2036|Aek Ngadol Sitinjak
12.03.02.2037|Sisipa
12.03.03.1098|Pasar Pargarutan
12.03.03.1099|Batang Tura Sirumambe
12.03.03.2003|Panompuan Jae
12.03.03.2004|Pargarutan Tonga
12.03.03.2008|Huraba
12.03.03.2012|Marisi
12.03.03.2013|Pargarutan Julu
12.03.03.2014|Huta Ginjang
12.03.03.2069|Lantosan Rogas
12.03.03.2079|Sijungkang
12.03.03.2083|Pargarutan Jae
12.03.03.2094|Panompuan
12.03.03.2095|Pargarutan Dolok
12.03.03.2096|Sanggapati
12.03.03.2097|Pall XI
12.03.04.1001|Pasar Sipirok
12.03.04.1003|Hutasuhut
12.03.04.1004|Baringin
12.03.04.1005|Bunga Bondar
12.03.04.1061|Parau Sorat
12.03.04.1114|Sipirok Godang
12.03.04.2010|Bagas Lombang
12.03.04.2017|Batu Satail
12.03.04.2025|Hasang Marsada
12.03.04.2034|Janji Mauli
12.03.04.2048|Paran Julu
12.03.04.2051|Pangaribuan
12.03.04.2052|Pargarutan
12.03.04.2054|Panaungan
12.03.04.2059|Padang Bujur
12.03.04.2060|Paran Padang
12.03.04.2064|Pangurabaan
12.03.04.2068|Ramba Sihasur
12.03.04.2069|Tolang
12.03.04.2072|Sampean
12.03.04.2075|Simaninggir
12.03.04.2076|Sibadoar
12.03.04.2085|Sialagundi
12.03.04.2096|Bulu Mario
12.03.04.2097|Barnang Koling
12.03.04.2101|Dolok Sordang Julu
12.03.04.2102|Situmba Julu
12.03.04.2103|Situmba
12.03.04.2104|Kilang Papan
12.03.04.2105|Sialaman
12.03.04.2106|Paran Dolok Mardomu
12.03.04.2107|Batang Tura Julu
12.03.04.2108|Batang Tura
12.03.04.2109|Dolok Sordang
12.03.04.2110|Pahae Aek Sagala
12.03.04.2111|Marsada
12.03.04.2112|Luat Lombang
12.03.04.2113|Aek Batang Paya
12.03.04.2115|Saba Batang Miha
12.03.04.2116|Sarogodung
12.03.05.1001|Pasar Sipagimbar
12.03.05.1080|Aek Simotung
12.03.05.2018|Simangambat
12.03.05.2069|Sidapdap Simanosor
12.03.05.2070|Saut Banua Simanosor
12.03.05.2071|Damparan Haunatas
12.03.05.2072|Somba Debata Purba
12.03.05.2073|Padang Mandailing Garugur
12.03.05.2074|Ulu Mamis Situnggaling
12.03.05.2075|Parau Sorat Sitabo-tabo
12.03.05.2076|Pintu Padang Mandalasena
12.03.05.2077|Sunge Sigiring-giring
12.03.05.2078|Silangkitang Tambiski
12.03.05.2079|Batang Parsuluman
12.03.06.1001|Simarpinggan
12.03.06.1007|Napa
12.03.06.1014|Tapian Nauli
12.03.06.1019|Pardomuan
12.03.06.2004|Situmbaga
12.03.06.2005|Sinyior
12.03.06.2006|Pintu Padang
12.03.06.2008|Sibong-bong
12.03.06.2009|Siamporik Dolok
12.03.06.2010|Siamporik Lombang
12.03.06.2011|Sihopur
12.03.06.2012|Tandihat
12.03.06.2013|Perkebunan Marpinggan
12.03.06.2015|Aek Natas
12.03.06.2016|Dolok Godang
12.03.06.2017|Sihuik-huik
12.03.06.2018|Gunung Baringin
12.03.07.1001|Sigalangan
12.03.07.1060|Pintu Padang I
12.03.07.1061|Pintu Padang II
12.03.07.1068|Bangun Purba
12.03.07.2005|Aek Nauli
12.03.07.2016|Sidadi I
12.03.07.2018|Janji Manaon
12.03.07.2020|Sitampa Simatoras
12.03.07.2021|Pasar Lama
12.03.07.2027|Benteng Huraba
12.03.07.2029|Padang Kahombu
12.03.07.2030|Sorik
12.03.07.2045|Sibulele Muara
12.03.07.2047|Bargot Topong
12.03.07.2053|Sigulang Losung
12.03.07.2055|Hurase
12.03.07.2057|Sorimadingin PP
12.03.07.2058|Huta Padang
12.03.07.2062|Tahalak Ujung Gading
12.03.07.2063|Sidadi II
12.03.07.2067|Aek Gunung
12.03.14.1039|Arse
12.03.14.1040|Lancat
12.03.14.2028|Sipogu
12.03.14.2032|Pinagar
12.03.14.2033|Pardomuan
12.03.14.2034|Aek Haminjon
12.03.14.2035|Nanggar Jati Huta Padang
12.03.14.2036|Nanggar Jati
12.03.14.2037|Natambang Roncitan
12.03.14.2038|Dalihan Natolu
12.03.20.1004|Pasar Sempurna
12.03.20.2002|Huraba
12.03.20.2014|Gunung Binanga
12.03.20.2015|Marancar Godang
12.03.20.2016|Simaninggir
12.03.20.2023|Sugi
12.03.20.2028|Haunatas
12.03.20.2032|Aek Nabara
12.03.20.2033|Gapuk Tua
12.03.20.2034|Marancar Julu
12.03.20.2035|Aek Sabaon
12.03.20.2036|Tanjung Dolok
12.03.21.1063|Sayur Matinggi
12.03.21.2003|Janji Mauli Baringin
12.03.21.2004|Mondang
12.03.21.2005|Sialang
12.03.21.2006|Sipange Julu
12.03.21.2007|Sipange Godang
12.03.21.2008|Tolang Julu
12.03.21.2009|Tolang Jae
12.03.21.2012|Bange
12.03.21.2013|Bulu Gading
12.03.21.2018|Aek Libung
12.03.21.2023|Aek Badak Jae
12.03.21.2024|Aek Badak Julu
12.03.21.2026|Huta Pardomuan
12.03.21.2056|Sipange Siunjam
12.03.21.2057|Silaiya
12.03.21.2058|Somanggal Parmonangan
12.03.21.2059|Lumban Huayan
12.03.21.2062|Silaiya Tanjung Leuk
12.03.22.2003|Sigolang
12.03.22.2005|Biru
12.03.22.2008|Tapus Godang
12.03.22.2017|Lobu Tayas
12.03.22.2020|Silangkitang
12.03.22.2033|Sihulambu
12.03.22.2043|Tolang
12.03.22.2044|Tapus Sipagabu
12.03.22.2045|Huta baru
12.03.22.2046|Aek Latong
12.03.22.2047|Aek Urat
12.03.22.2048|Gorahut
12.03.29.1002|Hutaraja
12.03.29.1008|Muara Manompas
12.03.29.1009|Muara Ampolu
12.03.29.2001|Bandar Hapinis
12.03.29.2003|Pardamean
12.03.29.2004|Tarapung Raya
12.03.29.2007|Muara Opu
12.03.29.2010|Simarlelan
12.03.29.2011|Muara Huta Raja
12.03.30.1001|Panabari Hutatonga
12.03.30.2002|Aek Uncim
12.03.30.2003|Panindoan
12.03.30.2004|Aek Kahombu
12.03.30.2005|Batu Horpak
12.03.30.2006|Situmba
12.03.30.2007|Purba Tua
12.03.30.2008|Lumban Jabi-jabi
12.03.30.2009|Ingul Jae
12.03.30.2010|Sisoma
12.03.30.2011|Lumban Ratus
12.03.30.2012|Kota Tua
12.03.30.2013|Simaninggir Tano Tombangan
12.03.30.2014|Huta Raja
12.03.30.2015|Harean
12.03.30.2016|Aek Parupuk
12.03.30.2017|Tanjung Medan
12.03.31.1001|Sangkunur
12.03.31.1002|Rianiate
12.03.31.2003|Simatohir
12.03.31.2004|Perkebunan
12.03.31.2005|Bandar Tarutung
12.03.31.2006|Aek Pardomuan
12.03.31.2007|Tindoan Laut
12.03.31.2008|Simataniari
12.03.31.2009|Batu Godang
12.03.31.2010|Malombu
12.03.32.1001|Bintuju
12.03.32.1002|Huta Tonga
12.03.32.2003|Basilam Baru
12.03.32.2004|Sipangko
12.03.32.2005|Huta Holbung
12.03.32.2006|Muara Tais I
12.03.32.2007|Muara Tais II
12.03.32.2008|Muara Tais III
12.03.32.2009|Janji Mauli MT
12.03.32.2010|Pargumbangan
12.03.32.2011|Pangaribuan
12.03.32.2012|Pasir Matogu
12.03.32.2013|Sori Manaon
12.03.32.2014|Muara Purba Nauli
12.03.32.2015|Tatengger
12.04.05.2001|Ononamolo I Bot
12.04.05.2021|Dima
12.04.05.2022|Sinarikhi
12.04.05.2023|Ombolata Salo'o
12.04.05.2024|Sisobalauru
12.04.05.2025|Tuhegafoa II
12.04.05.2027|Fadoro Lauru
12.04.05.2028|Lasara Tanose'o
12.04.05.2030|Hiliduho
12.04.05.2031|Hiligodu Tanose'o
12.04.05.2032|Sisobahili I Tanose'o
12.04.05.2033|Onozitolidulu
12.04.05.2034|Mazingo Tanose'o
12.04.05.2040|Onowaembo Hiligara
12.04.05.2041|Silimabanua
12.04.05.2042|Ombolata Sisarahili
12.04.06.2006|Hiliotalua
12.04.06.2008|Akhelauwe
12.04.06.2016|Hilisebua
12.04.06.2017|Somi
12.04.06.2018|Sirete
12.04.06.2019|Hiliweto Gido
12.04.06.2020|Loloana'a Gido
12.04.06.2022|Sisobahili
12.04.06.2023|Lahemo
12.04.06.2024|Ladea
12.04.06.2027|Umbu
12.04.06.2028|Soewe
12.04.06.2029|Lolozasai
12.04.06.2030|Lasara Idanoi
12.04.06.2050|Lasela
12.04.06.2051|Ladea Orahua
12.04.06.2052|Tulumbaho Salo'o
12.04.06.2053|Nifalo'olauru
12.04.06.2054|Hilizoi
12.04.06.2055|Somi Botogo'o
12.04.06.2056|Olindrawa Sisarahili
12.04.10.2005|Hilimoasio
12.04.10.2006|Tetegeona'ai
12.04.10.2007|Laowo Hilimbaruzo
12.04.10.2008|Hililawa'e
12.04.10.2009|Tuhewaebu
12.04.10.2014|Sisobahili Iraonohura
12.04.10.2015|Bozihona
12.04.10.2016|Oladano
12.04.10.2017|Ahedano
12.04.10.2018|Hilina'a Tafuo
12.04.10.2019|Hilionozega
12.04.10.2020|Mondrali
12.04.10.2022|Tetehosi
12.04.10.2023|Saiwahili Hiliadulo
12.04.10.2024|Maliwa'a
12.04.10.2025|Biouti
12.04.10.2026|Awoni Lauso
12.04.10.2027|Bobozioli Loloana'a
12.04.10.2028|Sandruta
12.04.10.2029|Laira
12.04.10.2030|Otalua
12.04.10.2031|Baruzo
12.04.10.2032|Orahili Zuzundrao
12.04.10.2033|Tiga Serangkai Maliwa'a
12.04.10.2034|Hiligogowaya Maliwa'a
12.04.10.2035|Hili'adulo
12.04.10.2036|Hilimoasio Dua
12.04.10.2037|Biouti Timur
12.04.11.2002|Sisarahili Bawolato
12.04.11.2003|Hiliganoita
12.04.11.2004|Gazamanu
12.04.11.2005|Hilihoru
12.04.11.2006|Hilialawa
12.04.11.2007|Hilifaosi
12.04.11.2008|Hiliwarokha
12.04.11.2009|Sitolubanua
12.04.11.2010|Siofaewali
12.04.11.2011|Sohoya
12.04.11.2012|Botohaenga
12.04.11.2013|Orahili
12.04.11.2014|Tagaule
12.04.11.2015|Siofabanua
12.04.11.2016|Sifaoro'asi Uluhou
12.04.11.2017|Dahana
12.04.11.2018|Orahua
12.04.11.2019|Banua Sibohou Silima Ewali
12.04.11.2020|Si'ofaewali Selatan
12.04.11.2021|Lagasimahe
12.04.11.2022|Hilihao Cugala
12.04.11.2023|Orahua Faondrato
12.04.11.2024|Hou
12.04.11.2025|Sindrondro
12.04.11.2026|Balale Toba'a
12.04.20.2001|Fadoro Hunogoa
12.04.20.2002|Lolofaoso Lalai
12.04.20.2003|Fulolo Lalai
12.04.20.2004|Lawa-Lawa
12.04.20.2005|Lalai I/II
12.04.20.2006|Lolowua
12.04.20.2007|Dahadano Botombawo
12.04.20.2008|Fadoro Lalai
12.04.20.2009|Lolowua Hiliwarasi
12.04.20.2010|Hilizia Lauru
12.04.20.2011|Ehosakhozi
12.04.20.2012|Awela
12.04.20.2013|Onombongi
12.04.20.2014|Orahili Idanoi
12.04.20.2015|Lolofaoso
12.04.21.2001|Hiligodu Botomuzoi
12.04.21.2002|Lasara Botomuzoi
12.04.21.2003|Hiliwa'ele I
12.04.21.2004|Hilimbowo Botomuzoi
12.04.21.2005|Simanaere Botomuzoi
12.04.21.2006|Hiliwa'ele II
12.04.21.2007|Tuhegafoa I
12.04.21.2008|Balohili Botomuzoi
12.04.21.2009|Hilihambawa Botomuzoi
12.04.21.2010|Fulolo Botomuzoi
12.04.21.2011|Loloana'a
12.04.21.2012|Ononamolo Talafu
12.04.21.2013|Sisobahili Dola
12.04.21.2014|Banua Sibohou Botomuzoi
12.04.21.2015|Mohili Berua Botomuzoi
12.04.21.2016|Tetehosi Botomuzoi
12.04.21.2017|Talafu
12.04.21.2018|Ola Nori
12.04.27.2001|Orahili
12.04.27.2002|Hiliweto Gela
12.04.27.2003|Lawa-lawa Luo
12.04.27.2004|Hilimbowo
12.04.27.2005|Hilibadalu
12.04.27.2006|Fatodano
12.04.27.2007|Fahandrona
12.04.27.2008|Onodalinga
12.04.27.2009|Holi
12.04.27.2010|Sisobahili Ulugawo
12.04.27.2011|Sifaoroasi Ulugawo
12.04.27.2012|Mohili
12.04.27.2013|Hiligafoa
12.04.27.2014|Sisarahili Soroma'asi
12.04.28.2001|Balodano
12.04.28.2002|Lewuoguru II
12.04.28.2003|Sihare'o III
12.04.28.2004|Sisarahili Ma'u
12.04.28.2005|Lasara Siwalubanua
12.04.28.2006|Tuhemberua
12.04.28.2007|Atualuo
12.04.28.2008|Lewa-lewa
12.04.28.2009|Dekha
12.04.28.2010|Sihare'o III Bawosalo'o Berua
12.04.28.2011|Sihare'o III Hilibadalu
12.04.29.2001|Sisobawino I
12.04.29.2002|I'odano
12.04.29.2003|Huno
12.04.29.2004|Sisaratandrawa
12.04.29.2005|Somolo-molo
12.04.29.2006|Lewuoguru I
12.04.29.2007|Sifaoroasi
12.04.29.2008|Lewuombanua
12.04.29.2009|Hiligodu Somolo-Molo
12.04.29.2010|Hilimborodano
12.04.29.2011|So'ewali
12.04.35.2001|Tuhembuasi
12.04.35.2002|Hilibadalu
12.04.35.2003|La'uri
12.04.35.2004|Hilimbana
12.04.35.2005|Saitagaramba
12.04.35.2006|Sogae'adu
12.04.35.2007|Baruzo
12.04.35.2008|Tulumbaho
12.04.35.2009|Sisarahili Sogae'adu
12.04.35.2010|We'a-we'a
12.04.35.2011|Sihare'o Sogae'adu
12.05.01.1001|Pekan Bahorok
12.05.01.2002|Lau Damak
12.05.01.2003|Timbang Lawan
12.05.01.2004|Sampe Raya
12.05.01.2005|Tanjung Lenggang
12.05.01.2006|Suka Rakyat
12.05.01.2007|Perkebunan Turangi
12.05.01.2008|Perkebunan Bungara
12.05.01.2009|Perkebunan B. Lawang
12.05.01.2011|Empus
12.05.01.2012|Simpang Pulo Rambung
12.05.01.2013|Perkebunan Sei Musam
12.05.01.2014|Batu Jong-Jong
12.05.01.2015|Sematar
12.05.01.2016|Perkebunan Pulo Rambung
12.05.01.2017|Sei Musam Kendit
12.05.01.2020|Timbang Jaya
12.05.01.2021|Musam Pembangunan
12.05.01.2022|Ujung Bandar
12.05.02.1007|Tanjung Langkat
12.05.02.2002|Perkebunan Tanjung Keliling
12.05.02.2004|Perkebunan Gelugur Langkat
12.05.02.2005|Perkebunan Tambunan
12.05.02.2006|Perkebunan Bandar Telu
12.05.02.2008|Naman Jahe
12.05.02.2009|Turangi
12.05.02.2010|Ujung Teran
12.05.02.2011|Pamah Tambunan
12.05.02.2014|Minta Kasih
12.05.02.2019|Ujung Bandar
12.05.02.2020|Lau Tepu
12.05.02.2021|Parangguam
12.05.02.2023|Ponco Warno
12.05.02.2024|Adin Tengah
12.05.02.2025|Lau Lugur
12.05.02.2026|Pancur Ido
12.05.03.1001|Pekan Kuala
12.05.03.1019|Bela Rakyat
12.05.03.2002|Dalan Naman
12.05.03.2003|Balai Kasih
12.05.03.2004|Bekiung
12.05.03.2005|Blankahan
12.05.03.2006|Besadi
12.05.03.2007|Beruam
12.05.03.2009|Raja Tengah
12.05.03.2011|Namo Mbelin
12.05.03.2012|Parit Bindu
12.05.03.2013|Sei Penjara
12.05.03.2015|Perkebunan Bekiun
12.05.03.2016|Garunggang
12.05.03.2017|Suka Damai
12.05.03.2018|Sido Makmur
12.05.04.1005|Namu Ukur Selatan
12.05.04.2001|Telagah
12.05.04.2002|Rumah Galuh
12.05.04.2003|Simpang Kuta Buluh
12.05.04.2004|Gunung Ambat
12.05.04.2006|Belinteng
12.05.04.2007|Namu Ukur Utara
12.05.04.2008|Pasar VI Kwala Mencirim
12.05.04.2009|Emplasmen Kwala Mencirim
12.05.04.2010|Purwobinangun
12.05.04.2011|Pasar IV.Namo Terasi
12.05.04.2012|Pasar VIII.Namo Terasi
12.05.04.2013|Durian Lingga
12.05.04.2014|Pekan Sawah
12.05.04.2015|Tanjung Gunung
12.05.04.2016|Mekar Jaya
12.05.05.1001|Kwala Begumit
12.05.05.2002|Sambi Rejo
12.05.05.2003|Sendang Rejo
12.05.05.2004|Tanjung Jati
12.05.05.2005|Sidomulyo
12.05.05.2006|Perdamaian
12.05.05.2007|Suka Makmur
12.05.06.1001|Pekan Selesai
12.05.06.2002|Sei Limbat
12.05.06.2003|Padang Brahrang
12.05.06.2004|Tanjung Merahe
12.05.06.2005|Nambiki
12.05.06.2006|Lau Mulgap
12.05.06.2007|Kuta Parit
12.05.06.2008|Bekulap
12.05.06.2009|Perhiasan
12.05.06.2010|Selayang
12.05.06.2011|Mancang
12.05.06.2012|Kwala Air Hitam
12.05.06.2013|Padang Cermin
12.05.06.2014|Selayang Baru
12.05.07.1004|Perdamaian
12.05.07.1005|Kwala Bingai
12.05.07.1006|Sidomulyo
12.05.07.1010|Stabat Baru
12.05.07.1011|Dendang
12.05.07.1012|Paya Mabar
12.05.07.2001|Karang Rejo
12.05.07.2002|Kwala Begumit
12.05.07.2003|Mangga
12.05.07.2007|Banyumas
12.05.07.2008|Pantai Gemi
12.05.07.2009|Ara Condong
12.05.08.1001|Bingai
12.05.08.2002|Gohor Lama
12.05.08.2003|Stabat Lama
12.05.08.2004|Besilam Bukit Lembasa
12.05.08.2005|Kebun Balok
12.05.08.2006|Bukit Melintang
12.05.08.2007|Gergas
12.05.08.2008|Stabat Lama Barat
12.05.08.2009|Sumber Mulyo
12.05.08.2010|Pertumbukan
12.05.08.2011|Paya Tusam
12.05.08.2012|Mekar Jaya
12.05.08.2013|Jentera Stabat
12.05.08.2014|Stungkit
12.05.09.1004|Hinai Kiri
12.05.09.2001|Kepala Sungai
12.05.09.2002|Teluk
12.05.09.2003|Cinta Raja
12.05.09.2005|Kebun Kelapa
12.05.09.2006|Sungai Ular
12.05.09.2007|Tanjung Ibus
12.05.09.2008|Secanggang
12.05.09.2009|Selotong
12.05.09.2010|Karang Gading
12.05.09.2011|Jaring Halus
12.05.09.2012|Telaga Jernih
12.05.09.2013|Perkotaan
12.05.09.2014|Kwala Besar
12.05.09.2015|Karang Anyar
12.05.09.2016|Pantai Gading
12.05.09.2017|Suka Mulia
12.05.10.1008|Kebun Lada
12.05.10.2001|Cempa
12.05.10.2002|Batu Malenggang
12.05.10.2003|Tamaran
12.05.10.2004|Tanjung Mulia
12.05.10.2005|Muka Paya
12.05.10.2006|Hinai Kanan
12.05.10.2007|Suka Damai
12.05.10.2009|Baru Pasar VIII
12.05.10.2010|Perkebunan Tanjung Beringin
12.05.10.2011|Suka Jadi
12.05.10.2012|Paya Rengas
12.05.10.2013|Suka Damai Timur
12.05.11.1005|Pekan Tanjung Pura
12.05.11.2001|Serapuh Asli
12.05.11.2002|Pematang Tengah
12.05.11.2003|Paya Perupuk
12.05.11.2004|Lalang
12.05.11.2006|Pekubuan
12.05.11.2007|Teluk Bakung
12.05.11.2008|Pantai Cermin
12.05.11.2009|Pematang Serai
12.05.11.2010|Baja Kuning
12.05.11.2011|Pulau Banyak
12.05.11.2012|Pematang Cengal
12.05.11.2013|Kwala Serapuh
12.05.11.2014|Kwala Langkat
12.05.11.2015|Bubun
12.05.11.2016|Tapak Kuda
12.05.11.2017|Suka Maju
12.05.11.2018|Karya Maju
12.05.11.2019|Pematang Cengal Barat
12.05.12.1006|Tanjung Selamat
12.05.12.2001|Serapuh ABC
12.05.12.2002|Padang Tualang
12.05.12.2003|Kwala Besilam
12.05.12.2004|Buluh Telang
12.05.12.2005|Besilam
12.05.12.2007|Tebing Tanjung Selamat
12.05.12.2008|Tanjung Putus
12.05.12.2009|Suka Ramai
12.05.12.2010|Jati Sari
12.05.12.2011|Banjaran Raya
12.05.12.2012|Bukit Sari
12.05.13.1001|Pekan Gebang
12.05.13.2002|Paluh Manis
12.05.13.2003|Pasar Rawa
12.05.13.2004|Padang Langkat
12.05.13.2005|Air Hitam
12.05.13.2006|Paya Bengkuang
12.05.13.2007|Dogang
12.05.13.2008|Sangga Lima
12.05.13.2009|Kwala Gebang
12.05.13.2010|Bukit Mengkirai
12.05.13.2011|Pasiran
12.05.14.1001|Pelawi Utara
12.05.14.1006|Berandan Barat
12.05.14.1007|Berandan Timur Baru
12.05.14.1008|Berandan Timur
12.05.14.2002|Securai Utara
12.05.14.2003|Teluk Meku
12.05.14.2004|Pelawi Selatan
12.05.14.2005|Securai Selatan
12.05.15.1009|Beras Basah
12.05.15.1010|Bukit Jengkol
12.05.15.2001|Alur Cempedak
12.05.15.2002|Sei Siur
12.05.15.2003|Tanjung Pasir
12.05.15.2004|Paya Tampak
12.05.15.2005|Pintu Air
12.05.15.2006|Sei Meran
12.05.15.2007|Pulau Sembilan
12.05.15.2008|Pulau Kampai
12.05.15.2011|Pangkalan Siata
12.05.16.1009|Pekan Besitang
12.05.16.1010|Bukit Kubu
12.05.16.1011|Kampung Lama
12.05.16.2001|Halaban
12.05.16.2002|Bukit Mas
12.05.16.2005|Pir Adb Besitang
12.05.16.2006|Sekoci
12.05.16.2007|Suka Jaya
12.05.16.2008|Bukit Selamat
12.05.17.1001|Sei Bilah
12.05.17.1002|Alur Dua
12.05.17.1008|Alur Dua Baru
12.05.17.1009|Harapan Jaya
12.05.17.1010|Sei Bilah Timur
12.05.17.2003|Puraka I
12.05.17.2004|Puraka II
12.05.17.2005|Lama
12.05.17.2006|Telaga Said
12.05.17.2007|Lama Baru
12.05.17.2011|Mekar Makmur
12.05.17.2012|Harapan Baru
12.05.17.2013|Harapan Maju
12.05.17.2014|Harapan Makmur
12.05.18.1001|Tangkahan Durian
12.05.18.1004|Pangkalan Batu
12.05.18.2002|Sei Tualang
12.05.18.2003|Lubuk Kasih
12.05.18.2005|Lubuk Kertang
12.05.18.2006|Perlis
12.05.18.2007|Kelantan
12.05.19.1001|Batang Serangan
12.05.19.2002|Sei Bamban
12.05.19.2003|Sei Musam
12.05.19.2004|Sei Serdang
12.05.19.2005|Namo Sialang
12.05.19.2006|Kwala Musam
12.05.19.2007|Karya Jadi
12.05.19.2008|Paluh Pakeh Babussalam
12.05.20.1001|Sawit Seberang
12.05.20.2002|Alur Gadung
12.05.20.2003|Simpang Tiga
12.05.20.2004|Sei Litur Tasik
12.05.20.2005|Sawit Hulu
12.05.20.2006|Mekar Sawit
12.05.20.2007|Alur Melati
12.05.21.2001|Serapit
12.05.21.2002|Gunung Tinggi
12.05.21.2003|Sidorejo
12.05.21.2004|Suka Pulung
12.05.21.2005|Aman Damai
12.05.21.2006|Tanjung Kariahan
12.05.21.2007|Sebertung
12.05.21.2008|Pulau Semikat
12.05.21.2009|Sumber Jaya
12.05.21.2010|Perkebunan Amal Tani
12.05.22.2001|Namotogan
12.05.22.2002|Kuta Gajah
12.05.22.2003|Perkebunan Marike
12.05.22.2004|Kaperas
12.05.22.2005|Namoteras
12.05.22.2006|Rampah
12.05.22.2007|Sulkam
12.05.22.2008|Kutambaru
12.05.23.2001|Pematang Tengah
12.05.23.2002|Damar Condong
12.05.23.2003|Perkebunan Damar Condong
12.05.23.2004|Perkebunan Perapen
12.05.23.2005|Limau Mungkur
12.05.23.2006|Serang Jaya Hilir
12.05.23.2007|Serang Jaya
12.05.23.2008|Sala Haji
12.06.01.1009|Padang Mas
12.06.01.1010|Lau Cimba
12.06.01.1011|Gung Leto
12.06.01.1012|Gung Negeri
12.06.01.1013|Kampung Dalam
12.06.01.2001|Rumah Kabanjahe
12.06.01.2002|Kaban
12.06.01.2003|Ketaren
12.06.01.2004|Samura
12.06.01.2005|Lau Simomo
12.06.01.2006|Sumber Mufakat
12.06.01.2007|Kandibata
12.06.01.2008|Kacaribu
12.06.02.1006|Tambak Lau Mulgab I
12.06.02.1007|Tambak Lau Mulgab II
12.06.02.1008|Gundaling I
12.06.02.1009|Gundaling II
12.06.02.2001|Daulu
12.06.02.2002|Gurusinga
12.06.02.2003|Raya
12.06.02.2004|Rumah Berastagi
12.06.02.2005|Sempajaya
12.06.02.2010|Lau Gumba
12.06.03.2001|Paribun
12.06.03.2002|Rumamis
12.06.03.2003|Sinaman
12.06.03.2004|Sukanalu
12.06.03.2005|Barusjulu
12.06.03.2006|Tangkidik
12.06.03.2007|Sukajulu
12.06.03.2008|Barusjahe
12.06.03.2009|Bulanjahe
12.06.03.2010|Pertumbuken
12.06.03.2011|Talimbaru
12.06.03.2012|Sikab
12.06.03.2013|Persadanta
12.06.03.2014|Bulanjulu
12.06.03.2015|Semangat
12.06.03.2016|Serdang
12.06.03.2017|Tanjung Barus
12.06.03.2018|Sarimanis
12.06.03.2019|Penampen
12.06.04.2001|Kutakepar
12.06.04.2002|Ajijulu
12.06.04.2004|Singa
12.06.04.2007|Ajijahe
12.06.04.2008|Bunuraya
12.06.04.2010|Kubusimbelang
12.06.04.2011|Tigapanah
12.06.04.2012|Suka
12.06.04.2014|Kacinambun
12.06.04.2015|Kutajulu
12.06.04.2016|Bertah
12.06.04.2017|Manukmulia
12.06.04.2018|Lauriman
12.06.04.2019|Sukadame
12.06.04.2020|Mulawari
12.06.04.2023|Sukamaju
12.06.04.2024|Kutambelin
12.06.04.2025|Kutabale
12.06.04.2026|Leparsamura
12.06.04.2027|Seberaya
12.06.04.2028|Ajimbelang
12.06.04.2029|Ajibuhara
12.06.04.2030|Lambar
12.06.04.2031|Salit
12.06.04.2032|Suka Mbayak
12.06.04.2033|Suka Sipilihen
12.06.04.2034|Sukameriah
12.06.04.2035|Bekerah
12.06.04.2036|Simacem
12.06.05.2001|Partibi Tembe
12.06.05.2002|Negeri Tongging
12.06.05.2003|Kodon-Kodon
12.06.05.2004|Dokan
12.06.05.2005|Nagara
12.06.05.2006|Sibolangit
12.06.05.2007|Sukamandi
12.06.05.2008|Nagalingga
12.06.05.2009|Pangambatan
12.06.05.2010|Tongging
12.06.05.2011|Partibi Lama
12.06.05.2012|Regaji
12.06.05.2013|Ajinembah
12.06.05.2014|Situnggaling
12.06.05.2015|Garingging
12.06.05.2016|Mulia Rayat
12.06.05.2017|Bandar Tongging
12.06.05.2018|Pancur Batu
12.06.05.2019|Merek
12.06.06.2001|Nageri
12.06.06.2002|Munte
12.06.06.2003|Kineppen
12.06.06.2004|Bandar Meriah
12.06.06.2005|Barung Kersap
12.06.06.2006|Kutambaru
12.06.06.2007|Buluhnaman
12.06.06.2008|Singgamanik
12.06.06.2009|Kuta Gerat
12.06.06.2010|Pertumbungen
12.06.06.2011|Sarimunte
12.06.06.2012|Kaban Tua
12.06.06.2013|Gunung Manumpak
12.06.06.2014|Tanjung Beringin
12.06.06.2015|Kuta Suah
12.06.06.2016|Sarinembah
12.06.06.2017|Selakkar
12.06.06.2018|Parimbalang
12.06.06.2019|Gunung Saribu
12.06.06.2020|Sukarame
12.06.06.2021|Gurubenua
12.06.06.2022|Biaknampe
12.06.07.2001|Juhar Perangin-angin
12.06.07.2002|Lau Lingga
12.06.07.2003|Kidupen
12.06.07.2004|Namosuro
12.06.07.2005|Bekilang
12.06.07.2006|Sugihen
12.06.07.2007|Pernantin
12.06.07.2008|Nageri
12.06.07.2009|Juhar Ginting
12.06.07.2010|Juhar Tarigan
12.06.07.2011|Pasar Baru
12.06.07.2012|Batu Mamak
12.06.07.2013|Naga
12.06.07.2014|Kutambelin
12.06.07.2015|Mbetong
12.06.07.2016|Keriahen
12.06.07.2017|Gunung Juhar
12.06.07.2018|Ketawaren
12.06.07.2019|Jandi
12.06.07.2020|Buluh Pancur
12.06.07.2021|Kutagugung
12.06.07.2022|Sukababo
12.06.07.2023|Lau Kidupen
12.06.07.2024|Sigenderang
12.06.07.2025|Juhar Ginting Sadanioga
12.06.08.1019|Tiga Binanga
12.06.08.2001|Gunung
12.06.08.2002|Kem Kem
12.06.08.2003|Pertumbuken
12.06.08.2004|Kuala
12.06.08.2005|Limang
12.06.08.2006|Perbesi
12.06.08.2007|Lau Kapur
12.06.08.2008|Kuta Bangun
12.06.08.2009|Kuta Raya
12.06.08.2010|Pergendangen
12.06.08.2011|Simolap
12.06.08.2012|Simpang Pergendangen
12.06.08.2013|Kuta Gerat
12.06.08.2014|Suka Julu
12.06.08.2015|Kuta Galoh
12.06.08.2016|Bunga Baru
12.06.08.2017|Kutambaru Punti
12.06.08.2018|Kuta Buara
12.06.08.2020|Batumamak
12.06.09.2001|Martelu
12.06.09.2002|Mbal-Mbal Petarum
12.06.09.2003|Lau Peranggunen
12.06.09.2004|Tanjung Gunung
12.06.09.2005|Lau Baleng
12.06.09.2006|Durin Rugun
12.06.09.2007|Perbulan
12.06.09.2008|Kutambelin
12.06.09.2009|Lingga Muda
12.06.09.2010|Kinangkong
12.06.09.2011|Rambah Tampu
12.06.09.2012|Lau Peradep
12.06.09.2013|Buluh Pancur
12.06.09.2014|Batu Rongkam
12.06.09.2015|Pintu Angin
12.06.10.2001|Lau Pengulu
12.06.10.2002|Lau Mulgap
12.06.10.2003|Lau Kesumpat
12.06.10.2004|Rimo Bunga
12.06.10.2005|Tanjung Pamah
12.06.10.2006|Kuta Pengkih
12.06.10.2007|Bandar Purba
12.06.10.2008|Mardingding
12.06.10.2009|Lau Pakam
12.06.10.2010|Lau Solu
12.06.10.2011|Lau Garut
12.06.10.2012|Bukit Makmur
12.06.11.2001|Payung
12.06.11.2004|Rimo Kayu
12.06.11.2007|Selandi
12.06.11.2012|Batukarang
12.06.11.2015|Gurukinayan
12.06.11.2017|Cimbang
12.06.11.2025|Ujung Payung
12.06.12.2005|Kutatengah
12.06.12.2006|Tigapancur
12.06.12.2007|Pintu Besi
12.06.12.2009|Gamber
12.06.12.2012|Sirumbia
12.06.12.2014|Ndokumsiroga
12.06.12.2016|Linggajulu
12.06.12.2017|Gajah
12.06.12.2018|Lingga
12.06.12.2019|Nangbelawan
12.06.12.2022|Beganding
12.06.12.2024|Torong
12.06.12.2025|Berastepu
12.06.12.2026|Surbakti
12.06.12.2028|Jeraya
12.06.12.2030|Perteguhen
12.06.12.2035|Bulanbaru
12.06.13.2001|Negeri Jahe
12.06.13.2002|Kutabuluh Gugung
12.06.13.2003|Siabang-abang
12.06.13.2004|Lau Buluh
12.06.13.2005|Bintang Meriah
12.06.13.2006|Jinabun
12.06.13.2007|Kuta Male
12.06.13.2008|Ujung Deleng
12.06.13.2009|Gunung Meriah
12.06.13.2010|Buah Raya
12.06.13.2011|Tanjung Merahe
12.06.13.2012|Rih Tengah
12.06.13.2013|Kutabuluh
12.06.13.2014|Liang Merdeka
12.06.13.2015|Pola Tebu
12.06.13.2016|Mburidi
12.06.14.2001|Kubu Colia
12.06.14.2002|Ujung Sampun
12.06.14.2003|Bukit
12.06.14.2004|Melas
12.06.14.2005|Sampun
12.06.14.2006|Sugihen
12.06.14.2007|Dolat Rayat
12.06.15.2001|Cinta Rakyat
12.06.15.2002|Semangat
12.06.15.2003|Ujung Teran
12.06.15.2004|Gongsol
12.06.15.2005|Jaranguda
12.06.15.2006|Semangat Gunung
12.06.15.2007|Deram
12.06.15.2008|Merdeka
12.06.15.2009|Sada Perarih
12.06.16.2002|Kutagugung
12.06.16.2003|Kuta Tonggal
12.06.16.2004|Naman
12.06.16.2005|Sukanalu
12.06.16.2006|Kebayaken
12.06.16.2007|Kutarayat
12.06.16.2009|Sukandebi
12.06.16.2010|Gung Pinto
12.06.16.2011|Kutambelin
12.06.16.2012|Ndeskati
12.06.16.2013|Sukatepu
12.06.16.2014|Sigarang-garang
12.06.17.2001|Sukatendel
12.06.17.2002|Mardingding
12.06.17.2003|Kutagaluh
12.06.17.2004|Kutambaru
12.06.17.2005|Jandimeriah
12.06.17.2006|Tiganderket
12.06.17.2007|Tanjung Pulo
12.06.17.2008|Tanjung Merawa
12.06.17.2009|Perbaji
12.06.17.2010|Temburun
12.06.17.2011|Kutakepar
12.06.17.2012|Penampen
12.06.17.2013|Tanjung Mbelang
12.06.17.2014|Narigunung I
12.06.17.2015|Narigunung II
12.06.17.2016|Gunung Merlawan
12.06.17.2017|Susuk
12.07.01.2001|Kuta Bayu
12.07.01.2002|Gunung Paribuan
12.07.01.2003|Simempar
12.07.01.2004|Gunung Seribu
12.07.01.2005|Gunung Sinembah
12.07.01.2006|Bintang Meriah
12.07.01.2007|Kuta Tengah
12.07.01.2008|Pekan Gunung Mariah
12.07.01.2009|Gunung Meriah
12.07.01.2010|Ujung Meriah
12.07.01.2011|Marjandi Pematang
12.07.01.2012|Marjandi Tongah
12.07.02.1026|Pekan Tanjung Morawa
12.07.02.2001|Medan Senembah
12.07.02.2002|Ujung Serdang
12.07.02.2003|Limau Manis
12.07.02.2004|Bandar Labuhan
12.07.02.2005|Bangun Rejo
12.07.02.2006|Aek Pancur
12.07.02.2007|Sei Merah
12.07.02.2008|Naga Timbul
12.07.02.2009|Lengau Seprang
12.07.02.2010|Tanjung Mulia
12.07.02.2011|Punden Rejo
12.07.02.2012|Tanjung Morawa-B
12.07.02.2013|Dagang Kerawan
12.07.02.2014|Tanjung Morawa-A
12.07.02.2015|Buntu Bedimbar
12.07.02.2016|Bangun Sari
12.07.02.2017|Dagang Kelambir
12.07.02.2018|Dalu Sepuluh-A
12.07.02.2019|Dalu Sepuluh-B
12.07.02.2020|Wonosari
12.07.02.2021|Perdamean
12.07.02.2022|Penara Kebun
12.07.02.2023|Bangun Sari Baru
12.07.02.2024|Telaga Sari
12.07.02.2025|Tanjung Baru
12.07.03.2001|Bandar Baru
12.07.03.2002|Batu Layang
12.07.03.2003|Batu Mbelin
12.07.03.2004|Betimus Mbaru
12.07.03.2005|Bengkurung
12.07.03.2006|Bingkawan
12.07.03.2007|Buah Nabar
12.07.03.2008|Bukum
12.07.03.2009|Buluh Awar
12.07.03.2010|Cinta Rakyat
12.07.03.2011|Durin Serugun
12.07.03.2012|Ketangkuhen
12.07.03.2013|Kuala
12.07.03.2014|Martelu
12.07.03.2015|Negeri Gugung
12.07.03.2016|Puangaja
12.07.03.2017|Rumah Kinangkung SP
12.07.03.2018|Rambung Baru
12.07.03.2019|Rumah Pil Pil
12.07.03.2020|Rumah Sumbul
12.07.03.2021|Sala Bulan
12.07.03.2022|Sayum Sabah
12.07.03.2023|Sembahe
12.07.03.2024|Sibolangit
12.07.03.2025|Sikeben
12.07.03.2026|Suka Maju
12.07.03.2027|Suka Makmur
12.07.03.2028|Tambunen
12.07.03.2029|Tanjung Beringin
12.07.03.2030|Ujung Deleng
12.07.04.2001|Suka Makmur
12.07.04.2002|Namo Mirik
12.07.04.2003|Suka Dame
12.07.04.2004|Pasar X
12.07.04.2005|Perpanden
12.07.04.2006|Kutalimbaru
12.07.04.2007|Sampe Cita
12.07.04.2008|Suka Rende
12.07.04.2009|Kwala Lau Bicik
12.07.04.2010|Lau Bekeri
12.07.04.2011|Silebo-Lebo
12.07.04.2012|Sawit Rejo
12.07.04.2013|Namo Rube Julu
12.07.04.2014|Sei Mencirim
12.07.05.2001|Bintang Meriah
12.07.05.2002|Sugau
12.07.05.2003|Tiang Layar
12.07.05.2004|Durin Simbelang
12.07.05.2005|Namo Riam
12.07.05.2006|Durin Tonggal
12.07.05.2007|Hulu
12.07.05.2008|Pertampilen
12.07.05.2009|Salam Tani
12.07.05.2010|Tengah
12.07.05.2011|Namo Simpur
12.07.05.2012|Simalingkar A
12.07.05.2013|Namo Bintang
12.07.05.2014|Lama
12.07.05.2015|Namo Rih
12.07.05.2016|Tuntungan I
12.07.05.2017|Gunung Tinggi
12.07.05.2018|Tuntungan II
12.07.05.2019|Durin Jangak
12.07.05.2020|Sembahe Baru
12.07.05.2021|Tanjung Anom
12.07.05.2022|Sei Glugur
12.07.05.2023|Suka Raya
12.07.05.2024|Baru
12.07.05.2025|Perumnas Simalingkar
12.07.06.2001|Deli Tua
12.07.06.2002|Jati Kesuma
12.07.06.2003|Namo Rambe
12.07.06.2004|Gunung Kelawas
12.07.06.2005|Ujung Labuhan
12.07.06.2006|Lubang Ido
12.07.06.2007|Silue-lue
12.07.06.2008|Timbang Lawan
12.07.06.2009|Batu Mbelin
12.07.06.2010|Namo Batang
12.07.06.2011|Tanjung Selamat
12.07.06.2012|Bekukul
12.07.06.2013|Namo Pakam
12.07.06.2014|Suka Mulia Hilir
12.07.06.2015|Suka Mulia Hulu
12.07.06.2016|Rumah Mbacang
12.07.06.2017|Cinta Rakyat
12.07.06.2018|Batu Penjemuran
12.07.06.2019|Kuta Tengah
12.07.06.2020|Namo Landur
12.07.06.2021|Gunung Berita
12.07.06.2022|Tangkahan
12.07.06.2023|Uruk Gedang
12.07.06.2024|Rumah Keben
12.07.06.2025|Namo Pinang
12.07.06.2026|Sudi Rejo
12.07.06.2027|Jaba
12.07.06.2028|Kuta Tualah
12.07.06.2029|Kwala Simeme
12.07.06.2030|Batu Gemuk
12.07.06.2031|Lau Mulgap
12.07.06.2032|Batu Rejo
12.07.06.2033|Salang Tungir
12.07.06.2034|Namo Mbaru
12.07.06.2035|Rimo Mungkur
12.07.06.2036|Namo Mbelin
12.07.07.2001|Aji Baho
12.07.07.2002|Biru-biru
12.07.07.2003|Candi Rejo
12.07.07.2004|Kutomulyo
12.07.07.2005|Kuala Dekah
12.07.07.2006|Mbaruai
12.07.07.2007|Mardinding Julu
12.07.07.2008|Namo Suro Baru
12.07.07.2009|Peria-ria
12.07.07.2010|Penen
12.07.07.2011|Rumah Gerat
12.07.07.2012|Sidodadi
12.07.07.2013|Sidomulyo
12.07.07.2014|Selamat
12.07.07.2015|Sarilaba Jahe
12.07.07.2016|Tanjung Sena
12.07.07.2017|Namo Tualang
12.07.08.2001|Talun Kenas
12.07.08.2002|Gunung Rintih
12.07.08.2003|Sumbul
12.07.08.2004|Tadukan Raga
12.07.08.2005|Limau Mungkur
12.07.08.2006|Negara Beringin
12.07.08.2007|Lau Barus Baru
12.07.08.2008|Juma Tombak
12.07.08.2009|Siguci
12.07.08.2010|Kuta Jurung
12.07.08.2011|Tala Peta
12.07.08.2012|Lau Rakit
12.07.08.2013|Penungkiren
12.07.08.2014|Rambai
12.07.08.2015|Lau Rempak
12.07.09.2001|Bah Perak
12.07.09.2002|Bandar Kwala
12.07.09.2003|Bah Balua
12.07.09.2005|Bandar Gugung
12.07.09.2006|Bandar Meriah
12.07.09.2007|Batu Gingging
12.07.09.2008|Bangun Purba
12.07.09.2009|Bangun Purba Tengah
12.07.09.2010|Begerpang
12.07.09.2011|Batu Rata
12.07.09.2012|Cimahi
12.07.09.2014|Damak Maliho
12.07.09.2015|Greahan
12.07.09.2017|Marombun Ujung Jawi
12.07.09.2018|Marombun Barat
12.07.09.2019|Mabar
12.07.09.2020|Perguroan
12.07.09.2023|Rumah Deleng
12.07.09.2024|Sibaganding
12.07.09.2025|Sialang
12.07.09.2027|Sukaluwei
12.07.09.2030|Tanjung Purba
12.07.09.2032|Urung Ganjang
12.07.09.2033|Ujung Rambe
12.07.19.1038|Galang Kota
12.07.19.2001|Tanjung Gusti
12.07.19.2002|Baru Titi Besi
12.07.19.2003|Bandar Kuala
12.07.19.2004|Batu Lokong
12.07.19.2005|Galang Suka
12.07.19.2006|Galang Barat
12.07.19.2007|Jaharun A
12.07.19.2008|Jaharun B
12.07.19.2009|Juhar Baru
12.07.19.2012|Kramat Gajah
12.07.19.2013|Kotasan
12.07.19.2015|Kotangan
12.07.19.2016|Kelapa Satu
12.07.19.2019|Nogorejo
12.07.19.2022|Paku
12.07.19.2023|Petumbukan
12.07.19.2024|Petangguhan
12.07.19.2025|Pisang Pala
12.07.19.2026|Paya Itik
12.07.19.2027|Pulo Tagor Baru
12.07.19.2028|Paya Kuda
12.07.19.2029|Paya Sampir
12.07.19.2030|Sei Putih
12.07.19.2031|Sei Karang
12.07.19.2034|Tanah Abang
12.07.19.2035|Timbang Deli
12.07.19.2036|Tanah Merah
12.07.19.2037|Tanjung Siporkis
12.07.20.2001|Tiga Juhar
12.07.20.2002|Tanjung Bampu
12.07.20.2003|Rumah Rih
12.07.20.2004|Liang Muda
12.07.20.2005|Durian IV Mbelang
12.07.20.2006|Tanah Gara Hulu
12.07.20.2007|Gunung Manumpak A
12.07.20.2008|Bah Bah Buntu
12.07.20.2009|Tanjung Muda
12.07.20.2010|Tanjung Raja
12.07.20.2011|Kuta Mbelin
12.07.20.2012|Rumah Sumbul
12.07.20.2013|Ranggit-git
12.07.20.2014|Liang Pematang
12.07.20.2015|Gunung Manumpak B
12.07.20.2016|Rumah Lengo
12.07.20.2017|Sipinggan
12.07.20.2018|Tanjung Timur
12.07.20.2019|Durian Tinggung
12.07.20.2020|Sibunga Bunga Hilir
12.07.21.2001|Lantasan Baru
12.07.21.2002|Patumbak I
12.07.21.2003|Patumbak II
12.07.21.2004|Lantasan Lama
12.07.21.2005|Sigara-gara
12.07.21.2006|Marindal I
12.07.21.2007|Marindal II
12.07.21.2008|Patumbak Kampung
12.07.22.1004|Deli Tua
12.07.22.1005|Deli Tua Timur
12.07.22.1006|Deli Tua Barat
12.07.22.2001|Kedai Durian
12.07.22.2002|Suka Makmur
12.07.22.2003|Mekar Sari
12.07.23.2001|Sei Semayang
12.07.23.2002|Lalang
12.07.23.2003|Puji Mulyo
12.07.23.2004|Paya Geli
12.07.23.2005|Mulio Rejo
12.07.23.2006|Purwodadi
12.07.23.2007|Sumber Melati Diski
12.07.23.2008|Tanjung Gusta
12.07.23.2009|Helvetia
12.07.23.2010|Medan Krio
12.07.23.2011|Sei Mencirim
12.07.23.2012|Sukamaju
12.07.23.2013|Sunggal Kanan
12.07.23.2014|Serbajadi
12.07.23.2015|Telaga Sari
12.07.23.2016|Tanjung Selamat
12.07.23.2017|Sei Beras Sekata
12.07.24.2001|Hamparan Perak
12.07.24.2002|Sei Baharu
12.07.24.2003|Klumpang Kebun
12.07.24.2004|Klumpang Kampung
12.07.24.2005|Klambir Lima Kampung
12.07.24.2006|Tandam Hulu II
12.07.24.2007|Klambir
12.07.24.2008|Selemak
12.07.24.2009|Klambir Lima Kebun
12.07.24.2010|Sialang Muda
12.07.24.2011|Paya Bakung
12.07.24.2012|Tandem Hulu I
12.07.24.2013|Tandem Hilir I
12.07.24.2014|Tandam Hilir II
12.07.24.2015|Kota Datar
12.07.24.2016|Bulu Cina
12.07.24.2017|Kota Rantang
12.07.24.2018|Paluh Manan
12.07.24.2019|Lama
12.07.24.2020|Paluh Kurau
12.07.25.2001|Helvetia
12.07.25.2002|Manunggal
12.07.25.2003|Pematang Johar
12.07.25.2004|Karang Gading
12.07.25.2005|Telaga Tujuh
12.07.26.1019|Kenangan
12.07.26.1020|Kenangan Baru
12.07.26.2001|Pematang Lalang
12.07.26.2002|Sambirejo Timur
12.07.26.2003|Kolam
12.07.26.2004|Percut
12.07.26.2005|Laut Dendang
12.07.26.2006|Tembung
12.07.26.2007|Cinta Rakyat
12.07.26.2008|Amplas
12.07.26.2009|Saentis
12.07.26.2010|Sampali
12.07.26.2011|Bandar Khalipah
12.07.26.2012|Bandar Klippa
12.07.26.2013|Tanjung Selamat
12.07.26.2014|Tanjung Rejo
12.07.26.2015|Medan Estate
12.07.26.2016|Cinta Damai
12.07.26.2017|Bandar Setia
12.07.26.2018|Sei Rotan
12.07.27.2001|Sena
12.07.27.2002|Tumpatan Nibung
12.07.27.2003|Tanjung Sari
12.07.27.2004|Baru
12.07.27.2005|Batangkuis Pekan
12.07.27.2006|Sidodadi
12.07.27.2007|Bintang Meriah
12.07.27.2008|Bakaran Batu
12.07.27.2009|Paya Gambar
12.07.27.2010|Mesjid
12.07.27.2011|Sugiharjo
12.07.28.1007|Lubuk Pakam I,II
12.07.28.1008|Lubuk Pakam III
12.07.28.1009|Paluh Kemiri
12.07.28.1010|Cemara
12.07.28.1011|Syahmad
12.07.28.1012|Petapahan
12.07.28.1013|Lubuk Pakam Pekan
12.07.28.2001|Sekip
12.07.28.2002|Pagar Jati
12.07.28.2003|Tanjung Garbus I
12.07.28.2004|Pasar Melintang
12.07.28.2005|Pagar Merbau III
12.07.28.2006|Bakaran Batu
12.07.31.2001|Tanjung Mulia
12.07.31.2002|Purwodadi
12.07.31.2003|Sidodadi Batu 8
12.07.31.2004|Suka Mulia
12.07.31.2005|Jati Rejo
12.07.31.2006|Pagar Merbau I
12.07.31.2007|Pagar Merbau II
12.07.31.2008|Sidoharjo-I Pasar Miring
12.07.31.2009|Sidoharjo-I Jati Baru
12.07.31.2010|Bandar Dolok
12.07.31.2011|Tanjung Garbus II
12.07.31.2012|Tanjung Garbus Kampung
12.07.31.2013|Perbarakan
12.07.31.2014|Sukamandi Hilir
12.07.31.2015|Sukamandi Hulu
12.07.31.2016|Sumberejo
12.07.32.2001|Sei Tuan
12.07.32.2002|Tengah
12.07.32.2003|Bagan Serdang
12.07.32.2004|Rantau Panjang
12.07.32.2005|Rugemuk
12.07.32.2006|Kubah Sentang
12.07.32.2007|Pantai Labu Pekan
12.07.32.2008|Pantai Labu Baru
12.07.32.2009|Ramunia 1
12.07.32.2010|Ramunia 2
12.07.32.2011|Perkebunan Ramunia
12.07.32.2012|Denai Lama
12.07.32.2013|Denai Kuala
12.07.32.2014|Denai Sarang Burung
12.07.32.2015|Binjai Bakung
12.07.32.2016|Paluh Sibaji
12.07.32.2017|Kelambir
12.07.32.2018|Durian
12.07.32.2019|Pematang Biara
12.07.33.2001|Serdang
12.07.33.2002|Sidourip
12.07.33.2003|Aras Kabu
12.07.33.2004|Pasar VI Kuala Namu
12.07.33.2005|Emplasmen Kuala Namu
12.07.33.2006|Pasar V Kebun Kelapa
12.07.33.2007|Beringin
12.07.33.2008|Sidoarjo II Ramunia
12.07.33.2009|Karang Anyar
12.07.33.2010|Sidodadi Ramunia
12.07.33.2011|Tumpatan
12.08.01.2001|Silampuyang
12.08.01.2002|Marihat Baris
12.08.01.2003|Dolok Marlawan
12.08.01.2004|Rambung Merah
12.08.01.2005|Silou Manik
12.08.01.2006|Sejahtera
12.08.01.2007|Siantar Estate
12.08.01.2008|Karang Bangun
12.08.01.2009|Nusa Harapan
12.08.01.2010|Sitalasari
12.08.01.2011|Lestari Indah
12.08.01.2012|Laras Dua
12.08.01.2013|Dolok Hataran
12.08.01.2014|Pantoan Maju
12.08.01.2015|Pamatang Simalungun
12.08.01.2016|Silau Malaha
12.08.01.2017|Pamatang Silampuyang
12.08.02.2001|Dolog Malela
12.08.02.2002|Senio
12.08.02.2003|Pamatang Asilom
12.08.02.2004|Serapuh
12.08.02.2005|Margo Mulyo
12.08.02.2006|Silulu
12.08.02.2007|Silou Malela
12.08.02.2008|Bandar Siantar
12.08.02.2009|Pamatang Gajing
12.08.02.2010|Bangun
12.08.02.2011|Malela
12.08.02.2012|Bukit Maraja
12.08.02.2013|Pamatang Sahkuda
12.08.02.2014|Marihat Bukit
12.08.02.2015|Sahkuda Bayu
12.08.02.2016|Lingga
12.08.03.2001|Silou Bayu
12.08.03.2002|Karang Anyer
12.08.03.2003|Karang Rejo
12.08.03.2004|Karang Sari
12.08.03.2005|Tumorang
12.08.03.2006|Rabuhit
12.08.03.2007|Huta Dipar
12.08.03.2008|Ganjing
12.08.03.2009|Bandar Malela
12.08.04.1011|Panei Tongah
12.08.04.2001|Janggir Leto
12.08.04.2002|Simpang Pane Raya
12.08.04.2003|Siborna
12.08.04.2004|Sipoldas
12.08.04.2005|Bangun Rakyat
12.08.04.2006|Sigodang
12.08.04.2007|Sigodang Barat
12.08.04.2008|Bah Bolon Tongah
12.08.04.2009|Mekar Sari Raya
12.08.04.2010|Simantin Pane Dame
12.08.04.2012|Simpang Raya Dasma
12.08.04.2013|Bangun Das Mariah
12.08.04.2014|Bangun Sitolu Bah
12.08.04.2015|Bah Liran Siborna
12.08.04.2016|Nauli Baru
12.08.04.2017|Rawang Pardomuan Nauli
12.08.05.2001|Panombeian
12.08.05.2002|Pamatang Panombeian
12.08.05.2003|Nagori Bosar
12.08.05.2004|Marjandi
12.08.05.2005|Simpang Panei
12.08.05.2006|Talun Kondot
12.08.05.2007|Simbolon Tengkoh
12.08.05.2008|Pamatang Panei
12.08.05.2009|Marjandi Pisang
12.08.05.2010|Banuh Raya
12.08.05.2011|Rukun Mulyo
12.08.06.1008|Tiga Balata
12.08.06.2001|Kasindir
12.08.06.2002|Sibunga Bunga
12.08.06.2003|Jorlang Hataran
12.08.06.2004|Bah Sampuran
12.08.06.2005|Bah Birong Ulu
12.08.06.2006|Pinang Ratus
12.08.06.2007|Dolok Marlawan
12.08.06.2009|Panombean Hutaurung
12.08.06.2010|Dipar Hataran
12.08.06.2011|Pagar Pinang
12.08.06.2012|Dolok Parriasan
12.08.06.2013|Parmonangan
12.08.07.1008|Sindar Raya
12.08.07.2001|Sambosar Raya
12.08.07.2002|Panduman
12.08.07.2003|Ambarokan Panei Raya
12.08.07.2004|Bah Tonang
12.08.07.2005|Bah Bulian
12.08.07.2006|Bangun Raya
12.08.07.2007|Durian Banggal
12.08.07.2008|Sorba Dolog
12.08.07.2009|Gunung Datas
12.08.07.2010|Puli Buah
12.08.07.2011|Banu Raya
12.08.07.2012|Marubun Siboras
12.08.07.2013|Banjaran
12.08.08.1013|Bosar Maligas
12.08.08.2001|Parbutaran
12.08.08.2002|Mayang
12.08.08.2003|Boluk
12.08.08.2004|Sei Mangkei
12.08.08.2005|Gunung Bayu
12.08.08.2006|Talun Saragih
12.08.08.2007|Dusun Pengkolan
12.08.08.2008|Sei Torop
12.08.08.2009|Marihat Tanjung
12.08.08.2010|Marihat Butar
12.08.08.2011|Teladan
12.08.08.2012|Adil Makmur
12.08.08.2014|Tempel Jaya
12.08.08.2015|Sidomulyo
12.08.08.2016|Mekar Rejo
12.08.08.2017|Nanggar Bayu
12.08.09.1013|Sarimatondang
12.08.09.2001|Bah Butong I
12.08.09.2002|Sidamanik
12.08.09.2003|Ambarisan
12.08.09.2004|Tiga Bolon
12.08.09.2005|Bah Butong II
12.08.09.2006|Bahal Gajah
12.08.09.2007|Manik Hataran
12.08.09.2008|Mekar Sidamanik
12.08.09.2009|Manik Maraja
12.08.09.2010|Bah Biak
12.08.09.2011|Birong Ulu Manriah
12.08.09.2012|Kebun Sayur Bah Butong
12.08.09.2014|Manik Rambung
12.08.09.2015|Bukit Rejo
12.08.10.1009|Sipolha Horisan
12.08.10.2001|Sait Buttu Saribu
12.08.10.2002|Pamatang Sidamanik
12.08.10.2003|Sarimattin
12.08.10.2004|Bandar Manik
12.08.10.2005|Jorlang Huluan
12.08.10.2006|Sihaporas
12.08.10.2007|Pematang Tambun Raya
12.08.10.2008|Simantin
12.08.10.2010|Gorak
12.08.11.1018|Pematang Tanah Jawa
12.08.11.2001|Tanjung Pasir
12.08.11.2002|Totap Majawa
12.08.11.2003|Balimbingan
12.08.11.2004|Baja Dolok
12.08.11.2005|Bosar Galugur
12.08.11.2006|Bah Jambi II
12.08.11.2007|Bah Kisat
12.08.11.2008|Panombeian Marjanji
12.08.11.2009|Muara Mulia
12.08.11.2010|Pardamean Asih
12.08.11.2011|Mekar Mulia
12.08.11.2012|Maligas Tongah
12.08.11.2013|Marubun Jaya
12.08.11.2014|Pagar Jambi
12.08.11.2015|Baliju
12.08.11.2016|Bayu Bagasan
12.08.11.2017|Bah Jambi III
12.08.11.2019|Parbalogan
12.08.11.2020|Marubun Bayu
12.08.12.2001|Buntu Bayu
12.08.12.2002|Bosar Nauli
12.08.12.2003|Tangga Batu
12.08.12.2004|Buntu Turunan
12.08.12.2005|Saribu Asih
12.08.12.2006|Jawa Tongah
12.08.12.2007|Tonduhan
12.08.12.2008|Parhundalian Jawa Dipar
12.08.12.2009|Jawa Tongah II
12.08.13.2001|Negeri Dolok
12.08.13.2002|Dolok Parmonangan
12.08.13.2003|Dolok Tomuan
12.08.13.2004|Marihat Dolok
12.08.13.2005|Tiga Dolok
12.08.13.2006|Ujung Bondar
12.08.13.2007|Marihat Raja
12.08.13.2008|Bandar Dolok
12.08.13.2009|Gunung Mariah
12.08.13.2010|Siatasan
12.08.13.2011|Marihat Marsada
12.08.13.2012|Pondok Buluh
12.08.13.2013|Marihat Pondok
12.08.13.2014|Lumban Gorat
12.08.13.2015|Palia Naopat
12.08.14.1008|Tiga Runggu
12.08.14.2001|Purba Tongah
12.08.14.2002|Pematang Purba
12.08.14.2003|Urung Purba
12.08.14.2004|Purba Sipinggan
12.08.14.2005|Hinalang
12.08.14.2006|Purba Dolok
12.08.14.2007|Tano Tinggir
12.08.14.2009|Saribu Jandi
12.08.14.2010|Huta Raja
12.08.14.2011|Bandar Sauhur
12.08.14.2012|Bunga Sampang
12.08.14.2013|Nagori Tongah
12.08.14.2014|Urung Pane
12.08.15.1005|Haranggaol
12.08.15.2001|Nagori Purba
12.08.15.2002|Nagori Sihalpe
12.08.15.2003|Purba Horisan
12.08.15.2004|Purba Pasir
12.08.16.1003|Girsang
12.08.16.1004|Parapat
12.08.16.1005|Tiga Raja
12.08.16.2001|Sipangan Bolon
12.08.16.2002|Sibaganding
12.08.16.2006|Sipangan Bolon Mekar
12.08.17.1015|Serbelawan
12.08.17.1016|Aman Sari
12.08.17.2001|Silenduk
12.08.17.2002|Bah Tobu
12.08.17.2003|Bandar Selamat
12.08.17.2004|Dolok Ilir I
12.08.17.2005|Dolok Ilir II
12.08.17.2006|Bahung Kahean
12.08.17.2007|Dolok Mainu
12.08.17.2008|Dolok Merangir I
12.08.17.2009|Dolok Merangir II
12.08.17.2010|Kahean
12.08.17.2011|Dolok Tenera
12.08.17.2012|Dolok Kataran
12.08.17.2013|Padang Mainu
12.08.17.2014|Bahung Huluan
12.08.18.1013|Huta Bayu
12.08.18.2001|Mariah Hombang
12.08.18.2002|Pulo Bayu
12.08.18.2003|Silakkidir
12.08.18.2004|Raja Maligas
12.08.18.2005|Dolok Sinumbah
12.08.18.2006|Maligas Bayu
12.08.18.2007|Jawa Baru
12.08.18.2008|Mancuk
12.08.18.2009|Marihat Mayang
12.08.18.2010|Bosar Bayu
12.08.18.2011|Raja Maligas I
12.08.18.2012|Bahal Batu
12.08.18.2014|Pokan Baru
12.08.18.2015|Manrayap Bayu
12.08.18.2016|Talang Bayu
12.08.19.2001|Jawa Maraja
12.08.19.2002|Moho
12.08.19.2003|Bahalat Bayu
12.08.19.2004|Mekar Bahalat
12.08.19.2005|Tanjung Maraja
12.08.19.2006|Mariah Jambi
12.08.19.2007|Bah Joga
12.08.19.2008|Bah Jambi
12.08.20.2001|Tigaras
12.08.20.2002|Parik Sabungan
12.08.20.2003|Sibuntuon
12.08.20.2004|Dolok Saribu
12.08.20.2007|Buntu Bayu Panei Raja
12.08.20.2009|Silabah Jaya
12.08.20.2010|Togu Domu Nauli
12.08.20.2011|Sirube-rube Gunung Purba
12.08.20.2014|Tanjung Saribu
12.08.20.2015|Sihemun Baru
12.08.20.2016|Nagori Bayu
12.08.21.1009|Kerasaan I
12.08.21.1010|Pematang Bandar
12.08.21.2001|Purwosari
12.08.21.2002|Talun Madear
12.08.21.2003|Mariah Bandar
12.08.21.2004|Kandangan
12.08.21.2005|Pardomuan Nauli
12.08.21.2006|Purba Ganda
12.08.21.2007|Kerasaan II
12.08.21.2008|Bandar Manis
12.08.21.2011|Wonorejo
12.08.21.2012|Talun Rejo
12.08.21.2013|Purwodadi
12.08.22.2001|Naga Jaya I
12.08.22.2002|Bah Gunung
12.08.22.2003|Bandar Tongah
12.08.22.2004|Dolog Parmonangan
12.08.22.2005|Laras
12.08.22.2006|Naga Jaya II
12.08.22.2007|Tanjung Hataran
12.08.22.2008|Bandar Betsy I
12.08.22.2009|Bandar Betsy II
12.08.22.2010|Naga Soppa
12.08.23.1014|Perdagangan I
12.08.23.1015|Perdagangan III
12.08.23.2001|Pematang Kerasaan
12.08.23.2002|Marihat Bandar
12.08.23.2003|Nagori Bandar
12.08.23.2004|Bandar Rakyat
12.08.23.2005|Bandar Pulo
12.08.23.2006|Bah Lias
12.08.23.2007|Perdagangan II
12.08.23.2008|Perlanaan
12.08.23.2009|Sugarang Bayu
12.08.23.2010|Pem Kerasaan Rejo
12.08.23.2011|Timbaan
12.08.23.2012|Bandar Jawa
12.08.23.2013|Sidotani
12.08.23.2016|Landbouw
12.08.24.2001|Bandar Masilam
12.08.24.2002|Lias Baru
12.08.24.2003|Bandar Silou
12.08.24.2004|Panombeian Baru
12.08.24.2005|Gunung Serawan
12.08.24.2006|Bandar Masilam II
12.08.24.2007|Partimbalan
12.08.24.2008|Bandar Tinggi
12.08.24.2009|Bandar Rejo
12.08.24.2010|Bandar Gunung
12.08.25.1012|Saribu Dolok
12.08.25.2003|Bangun Mariah
12.08.25.2004|Purba Sinombah
12.08.25.2006|Purba Tua
12.08.25.2009|Purba Tua Baru
12.08.25.2014|Sinar Baru
12.08.25.2016|Purba Tua Etek
12.08.26.2001|Cingkes
12.08.26.2002|Panribuan
12.08.26.2003|Saran Padang
12.08.26.2004|Mariah Dolok
12.08.26.2005|Marubun Lokkung
12.08.26.2006|Dolok Mariah
12.08.26.2007|Bawang
12.08.26.2008|Huta Saing
12.08.26.2009|Togur
12.08.26.2010|Perasmian
12.08.26.2011|Tanjung Purba
12.08.26.2012|Silau Marawan
12.08.26.2013|Bosi Sinombah
12.08.26.2014|Ujung Bawang
12.08.27.2001|Simanabun
12.08.27.2002|Pardomuan Tongah
12.08.27.2003|Nagori Dolok
12.08.27.2004|Bandar Maruhur
12.08.27.2005|Silou Dunia
12.08.27.2006|Dolok Marawa
12.08.27.2007|Mariah Buttu
12.08.27.2008|Dolok Saribu Bangun
12.08.27.2009|Bandar Nagori
12.08.27.2010|Silou Paribuan
12.08.27.2011|Buttu Bayu
12.08.27.2012|Nagori Tani
12.08.27.2013|Bah Sarimah
12.08.27.2014|Damaritang
12.08.27.2015|Sinasih
12.08.27.2016|Pardomuan Bandar
12.08.28.1009|Sinaksak
12.08.28.2001|Batu Silangit
12.08.28.2002|Dolok Maraja
12.08.28.2003|Dolok Ulu
12.08.28.2004|Nagur Usang
12.08.28.2005|Dolok Kahean
12.08.28.2006|Naga Dolok
12.08.28.2007|Purbasari
12.08.28.2008|Pematang Dolok Kahean
12.08.28.2010|Negeri Bayu Muslimin
12.08.28.2011|Dolok Simbolon
12.08.29.1001|Merek Raya
12.08.29.1002|Dalig Raya
12.08.29.1005|Sondi Raya
12.08.29.1011|Pamatang Raya
12.08.29.1018|Baringin Raya
12.08.29.2004|Raya Bayu
12.08.29.2007|Bahapal Raya
12.08.29.2010|Siporkas
12.08.29.2012|Sihubu Raya
12.08.29.2013|Raya Bosi
12.08.29.2014|Silou Huluan
12.08.29.2015|Silou Buttu
12.08.29.2016|Bongguron Kariahan
12.08.29.2017|Simbou Baru
12.08.29.2020|Dame Raya
12.08.29.2021|Limag Raya
12.08.29.2022|Lokkung Raya
12.08.30.1001|Ujung Padang
12.08.30.2002|Huta Parik
12.08.30.2003|Dusun Ulu
12.08.30.2004|Tinjowan
12.08.30.2005|Sayur Matinggi
12.08.30.2006|Taratak Nagodang
12.08.30.2007|Sordang Bolon
12.08.30.2008|Teluk Lapian
12.08.30.2009|Tanjung Rapuan
12.08.30.2010|Pagar Bosi
12.08.30.2011|Bangun Sordang
12.08.30.2012|Aek Gerger Sidodadi
12.08.30.2013|Pulo Pitu Marihat
12.08.30.2014|Siringan Ringan
12.08.30.2015|Riah Na Poso
12.08.30.2016|Sei Merbau
12.08.30.2017|Kampung Lalang
12.08.30.2018|Sordang Baru
12.08.30.2019|Banjar Hulu
12.08.30.2020|Rawa Masin
12.08.31.2001|Ujung Saribu
12.08.31.2002|Silimakuta Barat
12.08.31.2003|Siboras
12.08.31.2004|Mardingding
12.08.31.2005|Naga Saribu
12.08.31.2007|Saribu Jandi
12.08.31.2008|Sinar Naga Mariah
12.08.31.2009|Ujung Mariah
12.08.31.2010|Bandar Saribu
12.08.31.2011|Naga Bosar
12.08.32.2001|Raya Huluan
12.08.32.2002|Dolog Huluan
12.08.32.2003|Bintang Mariah
12.08.32.2004|Bah Bolon
12.08.32.2005|Raya Usang
12.08.32.2006|Bangun Pane
12.08.32.2007|Parjalangan
12.08.32.2008|Partuahan
12.08.32.2009|Sinaman Labah
12.08.32.2010|Pamatang Sinaman
12.09.08.2002|Meranti
12.09.08.2004|Perkebunan Sei Balai
12.09.08.2011|Sei Beluru
12.09.08.2012|Serdang
12.09.08.2019|Gajah
12.09.08.2021|Air Putih
12.09.08.2022|Sukajadi
12.09.09.1001|Binjai Serbangan
12.09.09.2002|Air Joman
12.09.09.2003|Air Joman Baru
12.09.09.2005|Banjar
12.09.09.2007|Pasar Lembu
12.09.09.2008|Punggulan
12.09.09.2012|Subur
12.09.10.2001|Asahan Mati
12.09.10.2002|Bagan Asahan
12.09.10.2003|Bagan Asahan Baru
12.09.10.2004|Bagan Asahan Pekan
12.09.10.2005|Kapias Batu VIII
12.09.10.2006|Pematang Sei Baru
12.09.10.2007|Sei Apung
12.09.10.2008|Sei Apung Jaya
12.09.11.2008|Sei Kepayang Tengah
12.09.11.2010|Sei Kepayang Kanan
12.09.11.2011|Sei Paham
12.09.11.2014|Pertahanan
12.09.11.2015|Perbangunan
12.09.11.2016|Bangun Baru
12.09.12.2002|Perkebunan Suka Raja
12.09.12.2004|Perkebunan Hessa
12.09.12.2006|Sei Dua Hulu
12.09.12.2007|Sei Lama
12.09.12.2008|Silomlom
12.09.12.2009|Simpang Empat
12.09.12.2012|Sipaku Area
12.09.12.2013|Anjung Ganjang
12.09.13.2001|Sei Alim Ulu
12.09.13.2003|Pinanggiripan
12.09.13.2006|Perkebunan Pulahan
12.09.13.2007|Hessa Perlompongan
12.09.13.2008|Perkebunan Air Batu I/II
12.09.13.2009|Perkebunan Air Batu III/IX
12.09.13.2010|Danau Sijabut
12.09.13.2012|Air Teluk Hessa
12.09.13.2013|Air Genting
12.09.13.2014|Hessa Air Genting
12.09.13.2018|Sijabut Teratai
12.09.13.2019|Pulau Pule
12.09.14.2001|Sei Piring
12.09.14.2002|Pulau Rakyat Tua
12.09.14.2003|Pulau Rakyat Pekan
12.09.14.2004|Orika
12.09.14.2005|Manis
12.09.14.2006|Tunggul 45
12.09.14.2007|Bangun
12.09.14.2008|Persatuan
12.09.14.2009|Padang Mahondang
12.09.14.2010|Ofa Padang Mahondang
12.09.14.2011|Baru
12.09.14.2012|Mekar Sari
12.09.15.2003|Bandar Pulau Pekan
12.09.15.2005|Buntu Maraja
12.09.15.2006|Gonting Malaha
12.09.15.2010|Padang Pulau
12.09.15.2012|Perkebunan Aek Tarum
12.09.15.2016|Perkebunan Padang Pulau
12.09.15.2019|Huta Rao
12.09.15.2020|Aek Nagali
12.09.15.2021|Gajah Sakti
12.09.15.2022|Gunung Berkat
12.09.16.2001|Ambalutu
12.09.16.2002|Buntu Pane
12.09.16.2003|Lestari
12.09.16.2005|Prapat Janji
12.09.16.2007|Sei Silau Timur
12.09.16.2016|Sionggang
12.09.16.2017|Mekar Sari
12.09.16.2018|Perkebunan Sei Silau
12.09.16.2019|Karya Ambalutu
12.09.17.2001|Bandar Pasir Mandoge
12.09.17.2002|Huta Bagasan
12.09.17.2003|Sei Nadoras
12.09.17.2004|Silau Jawa
12.09.17.2005|Suka Makmur
12.09.17.2006|Sei Kopas
12.09.17.2007|Huta Padang
12.09.17.2008|Tomuan Holbung
12.09.17.2009|Gotting Sidodadi
12.09.18.1001|Aek Loba Pekan
12.09.18.2002|Aek Loba Afd I
12.09.18.2003|Alang Bonbon
12.09.18.2009|Sengon Sari
12.09.18.2010|Lobu Jiur
12.09.18.2011|Rawa Sari
12.09.18.2013|Aek Loba
12.09.19.1001|Bunut
12.09.19.1002|Bunut Barat
12.09.19.1003|Dadimulyo
12.09.19.1004|Kisaran Barat
12.09.19.1005|Kisaran Baru
12.09.19.1006|Kisaran Kota
12.09.19.1007|Mekar Baru
12.09.19.1008|Sei Renggas
12.09.19.1009|Sendang Sari
12.09.19.1010|Sidodadi
12.09.19.1011|Sidomukti
12.09.19.1012|Tebing Kisaran
12.09.19.1013|Tegal Sari
12.09.20.1001|Teladan
12.09.20.1002|Siumbut Umbut
12.09.20.1003|Siumbut Baru
12.09.20.1004|Sentang
12.09.20.1005|Selawan
12.09.20.1006|Mutiara
12.09.20.1007|Lestari
12.09.20.1008|Kisaran Timur
12.09.20.1009|Kisaran Naga
12.09.20.1010|Kedai Ledang
12.09.20.1011|Karang Anyer
12.09.20.1012|Gambir Baru
12.09.21.2001|Aek Songsongan
12.09.21.2002|Perkebunan Bandar Selamat
12.09.21.2003|Perkebunan Bandar Pulau
12.09.21.2004|Aek Bamban
12.09.21.2005|Marjanji Aceh
12.09.21.2006|Lobu Rappa
12.09.21.2007|Tangga
12.09.21.2008|Situnjak
12.09.21.2009|Mekar Marjanji
12.09.22.2001|Rahuning
12.09.22.2002|Perkebunan Gunung Melayu
12.09.22.2003|Gunung Melayu
12.09.22.2004|Batu Anam
12.09.22.2005|Perkebunan Aek Nagaga
12.09.22.2006|Rahuning I
12.09.22.2007|Rahuning II
12.09.23.2001|Tanjung Alam
12.09.23.2002|Perkebunan Sei Dadap I/II
12.09.23.2003|Perkebunan Sei Dadap III/IV
12.09.23.2004|Sei Kamah I
12.09.23.2005|Sei Kamah II
12.09.23.2006|Bahung Sibatu-batu
12.09.23.2007|Sei Alim Hasak
12.09.23.2008|Tanjung Asri
12.09.23.2009|Sei Kamah Baru
12.09.23.2010|Pasiran
12.09.24.2001|Sei Nangka
12.09.24.2002|Sei Jawi-Jawi
12.09.24.2003|Sei Serindan
12.09.24.2004|Sei Tualang Pandau
12.09.24.2005|Sei Lendir
12.09.24.2006|Sei Kepayang Kiri
12.09.25.2001|Sei Lunang
12.09.25.2002|Sei Pasir
12.09.25.2003|Sei Tempurung
12.09.25.2004|Sarang Helang
12.09.25.2005|Sei Sembilang
12.09.26.2001|Tinggi Raja
12.09.26.2002|Sumber Harapan
12.09.26.2003|Terusan Tengah
12.09.26.2004|Piasa Ulu
12.09.26.2005|Sidomulyo
12.09.26.2006|Teladan
12.09.26.2007|Padang Sari
12.09.27.2001|Urung Pane
12.09.27.2002|Sei Silau Tua
12.09.27.2003|Sei Silau Barat
12.09.27.2004|Silau Maraja
12.09.27.2005|Bangun Sari
12.09.28.2001|Silo Baru
12.09.28.2002|Silo Lama
12.09.28.2003|Silo Bonto
12.09.28.2004|Lubuk Palas
12.09.28.2005|Bangun Sari
12.09.29.2001|Rawang Lama
12.09.29.2002|Rawang Baru
12.09.29.2003|Rawang Pasar IV
12.09.29.2004|Rawang Pasar V
12.09.29.2005|Pondok Bungur
12.09.29.2006|Panca Arga
12.09.29.2007|Rawang Pasar VI
12.09.30.2001|Suka Damai
12.09.30.2002|Perhutaan Silau
12.09.30.2003|Tanah Rakyat
12.09.30.2004|Taman Sari
12.09.30.2005|Gedangan
12.09.30.2006|Suka Makmur
12.09.30.2007|Pulo Bandring
12.09.30.2008|Sidomulyo
12.09.30.2009|Suka Damai Barat
12.09.30.2010|Bunut Seberang
12.09.31.2001|Air Teluk Kiri
12.09.31.2002|Teluk Dalam
12.09.31.2003|Perkebunan Teluk Dalam
12.09.31.2004|Pulau Maria
12.09.31.2005|Pulau Tanjung
12.09.31.2006|Mekar Tanjung
12.09.32.2001|Aek Bange
12.09.32.2002|Aek Korsik
12.09.32.2003|Aek Ledong
12.09.32.2004|Ledong Barat
12.09.32.2005|Aek Nabuntu
12.09.32.2006|Ledong Timur
12.09.32.2007|Padang Sipirok
12.10.01.1001|Padang Matinggi
12.10.01.1002|Siringo-Ringo
12.10.01.1003|Sirandorung
12.10.01.1004|Rantauprapat
12.10.01.1005|Kartini
12.10.01.1006|Cendana
12.10.01.1007|Binaraga
12.10.01.1008|Pulo Padang
12.10.01.1009|Padang Bulan
12.10.01.1010|Aek Paing
12.10.02.1001|Bakaran Batu
12.10.02.1002|Sioldengan
12.10.02.1003|Urung Kompas
12.10.02.1004|Ujung Bandar
12.10.02.1005|Sigambal
12.10.02.1006|Lobusona
12.10.02.1007|Pardamean
12.10.02.1008|Danau Bale
12.10.02.1009|Sidorejo
12.10.07.2001|Sibargot
12.10.07.2002|Bandar Kumbul
12.10.07.2003|Tanjung Medan
12.10.07.2004|Janji
12.10.07.2005|Tebing Linggahara
12.10.07.2006|AFD.I Rantauprapat
12.10.07.2007|AFD.II Rantauprapat
12.10.07.2008|Aek Buru Selatan
12.10.07.2009|Kampung Baru
12.10.07.2010|Tebing Linggahara Baru
12.10.08.1001|Negeri Lama
12.10.08.1002|Negeri Baru
12.10.08.2003|Perkebunan Sennah
12.10.08.2004|Perkebunan Negeri Lama
12.10.08.2005|Perkebunan Bilah
12.10.08.2006|Kampung Bilah
12.10.08.2007|Negeri Lama Seberang
12.10.08.2008|Sei Tampang
12.10.08.2009|Selat Besar
12.10.08.2010|Tanjung Haloban
12.10.08.2011|Sidomulyo
12.10.08.2012|Sei Tarolat
12.10.08.2013|Sei Kasih
12.10.09.2001|Lingga Tiga
12.10.09.2002|Tanjung Siram
12.10.09.2003|Pematang Seleng
12.10.09.2004|Perbaungan
12.10.09.2005|Gunung Selamat
12.10.09.2006|Emplasemen Aek Nabara
12.10.09.2007|Bandar Tinggi
12.10.09.2008|Kampung Dalam
12.10.09.2009|Pondok Batu
12.10.09.2010|Meranti
12.10.09.2011|N-1 Aek Nabara
12.10.09.2012|N-2 Aek Nabara
12.10.09.2013|N-3 Aek Nabara
12.10.09.2014|N-4 Aek Nabara
12.10.09.2015|N-5 Aek Nabara
12.10.09.2016|N-6 Aek Nabara
12.10.09.2017|N-7 Aek Nabara
12.10.09.2018|N-8 Aek Nabara
12.10.09.2019|S-1 Aek Nabara
12.10.09.2020|S-2 Aek Nabara
12.10.09.2021|S-3 Aek Nabara
12.10.09.2022|S-4 Aek Nabara
12.10.09.2023|S-5 Aek Nabara
12.10.09.2024|S-6 Aek Nabara
12.10.14.2001|Sidorukun
12.10.14.2002|Tebing Tinggi Pangkatan
12.10.14.2003|Perkebunan Pangkatan
12.10.14.2004|Kampung Padang
12.10.14.2005|Pangkatan
12.10.14.2006|Sennah
12.10.14.2007|Tanjung Harapan
12.10.18.1001|Labuhan Bilik
12.10.18.2002|Sei Pelancang
12.10.18.2003|Sei Siarti
12.10.18.2004|Sei Nahodaris
12.10.18.2005|Sei Merdeka
12.10.18.2006|Sei Rakyat
12.10.18.2007|Selat Beting
12.10.18.2008|Bagan Bilah
12.10.18.2009|Telaga Suka
12.10.18.2010|Pasar Tiga
12.10.19.1001|Sei Berombang
12.10.19.2002|Sei Penggantungan
12.10.19.2003|Sei Lumut
12.10.19.2004|Sei Tawar
12.10.19.2005|Sei Sanggul
12.10.19.2006|Sei Sakat
12.10.19.2007|Sei Baru
12.10.19.2008|Wonosari
12.10.20.2001|Tanjung Sarang Elang
12.10.20.2002|Perkebunan Ajamu
12.10.20.2003|Teluk Sentosa
12.10.20.2004|Cinta Makmur
12.10.20.2005|Sei Sentosa
12.10.20.2006|Meranti Paham
12.10.20.2007|Sei Jawi-Jawi
12.11.01.1005|Kuta Gambir
12.11.01.1007|Sidiangkat
12.11.01.1009|Batang Beruh
12.11.01.1010|Sidikalang
12.11.01.1015|Bintang Hulu
12.11.01.2008|Belang Malum
12.11.01.2011|Huta Rakyat
12.11.01.2012|Kalang
12.11.01.2013|Bintang
12.11.01.2014|Kalang Simbara
12.11.01.2017|Bintang Mersada
12.11.02.1007|Pegagan Julu I
12.11.02.2001|Pegagan Julu X
12.11.02.2002|Pegagan Julu IX
12.11.02.2003|Pegagan Julu VIII
12.11.02.2004|Pegagan Julu VII
12.11.02.2005|Pegagan Julu VI
12.11.02.2006|Pegagan Julu V
12.11.02.2008|Pegagan Julu IV
12.11.02.2009|Pegagan Julu III
12.11.02.2010|Pegagan Julu II
12.11.02.2014|Tanjung Beringin
12.11.02.2015|Dolok Tolong
12.11.02.2017|Pargambiran
12.11.02.2018|Perjuangan
12.11.02.2020|Kuta Gugung
12.11.02.2024|Sileuh-leuh Parsaoran
12.11.02.2025|Barisan Nauli
12.11.02.2026|Pangguruan
12.11.02.2027|Tanjung Beringin I
12.11.03.2001|Sumbul Tengah
12.11.03.2002|Ujung Teran
12.11.03.2003|Juma Gerat
12.11.03.2004|Sarintonu
12.11.03.2005|Tigalingga
12.11.03.2006|Palding
12.11.03.2007|Lau Bagot
12.11.03.2008|Bertungen Julu
12.11.03.2009|Lau Molgap
12.11.03.2010|Lau Pak-Pak
12.11.03.2012|Sukandebi
12.11.03.2013|Lau Mil
12.11.03.2014|Lau Sireme
12.11.03.2019|Palding Jaya Sumbul
12.11.04.2001|Sinampang
12.11.04.2002|Sihorbo
12.11.04.2003|Soban
12.11.04.2004|Adian Nangka
12.11.04.2005|Bunturaja
12.11.04.2006|Juma Siulok
12.11.04.2007|Juma Teguh
12.11.04.2008|Sosor Lontung
12.11.04.2009|Huta Imbaru
12.11.04.2010|Jumantuang
12.11.04.2011|Gomit
12.11.04.2012|Adian Gupa
12.11.04.2013|Maju
12.11.05.1014|Parongil
12.11.05.2008|Palipi
12.11.05.2010|Longkotan
12.11.05.2011|Bongkaras
12.11.05.2012|Tungtung Batu
12.11.05.2013|Polling Anak-Anak
12.11.05.2015|Siratah
12.11.05.2016|Uruk Mblin
12.11.05.2017|Siboras
12.11.05.2018|Bonian
12.11.05.2019|Sumbari
12.11.05.2020|Bakal Gajah
12.11.05.2021|Lae Panginuman
12.11.05.2022|Lae Ambat
12.11.05.2023|Lae Rambong
12.11.05.2024|Lae Pangaroan
12.11.06.2001|Sukadame
12.11.06.2002|Gunung Tua
12.11.06.2003|Harapan
12.11.06.2004|Lau Primbon
12.11.06.2005|Kuta Gamber
12.11.06.2006|Kempawa
12.11.06.2007|Tanah Pinem
12.11.06.2008|Pamah
12.11.06.2009|Kuta Buluh
12.11.06.2010|Pasir Tengah
12.11.06.2011|Renun
12.11.06.2012|Lau Tawar
12.11.06.2013|Balandua
12.11.06.2014|Mangan Molih
12.11.06.2015|Liang Jering
12.11.06.2016|Alur Subur
12.11.06.2017|Lau Njuhar I
12.11.06.2018|Pasir Mbelang
12.11.06.2019|Sinar Pagi
12.11.07.2001|Tambahan
12.11.07.2002|Kuta Tengah
12.11.07.2003|Lae Nuaha
12.11.07.2004|Sungai Raya
12.11.07.2005|Gunung Meriah
12.11.07.2006|Silumboyah
12.11.07.2007|Pandan
12.11.07.2008|Tualang
12.11.07.2009|Pangaribuan
12.11.07.2010|Sigambir-gambir
12.11.07.2011|Bakal Julu
12.11.07.2012|Sipoltong
12.11.08.2001|Lae Itam
12.11.08.2002|Lae Luhung
12.11.08.2003|Pardomuan
12.11.08.2004|Lae Markelang
12.11.08.2005|Jambur Indonesia
12.11.08.2006|Simungun
12.11.08.2007|Janji
12.11.08.2008|Sopo Butar
12.11.08.2009|Lae Sering
12.11.08.2010|Lae Haporas
12.11.09.2001|Simanduma
12.11.09.2002|Bandar Huta Usang
12.11.09.2003|Onan Lama
12.11.09.2004|Lingga Raja
12.11.09.2005|Laksa
12.11.09.2006|Tanjung Saluksuk
12.11.09.2007|Bukit Tinggi
12.11.09.2008|Simartugan
12.11.09.2009|Kuta Usang
12.11.09.2010|Lingga Raja II
12.11.09.2011|Mbinanga
12.11.09.2012|Bukit Baru
12.11.09.2013|Perrik Mbue
12.11.10.2001|Bangun
12.11.10.2002|Lae Hole
12.11.10.2003|Parbuluan IV
12.11.10.2004|Parbuluan III
12.11.10.2005|Parbuluan II
12.11.10.2006|Parbuluan I
12.11.10.2007|Parbuluan V
12.11.10.2008|Parbuluan VI
12.11.10.2009|Lae Hole I
12.11.10.2010|Lae Hole II
12.11.10.2011|Bangun I
12.11.11.2001|Sumbul
12.11.11.2002|Kentara
12.11.11.2003|Lae Parira
12.11.11.2004|Buluduri
12.11.11.2005|Sempung Polling
12.11.11.2006|Lumban Sihite
12.11.11.2007|Lumban Toruan
12.11.11.2008|Pandiangan
12.11.11.2009|Kaban Julu
12.11.12.2001|Bukit Lau Kersik
12.11.12.2002|Gunung Sitember
12.11.12.2003|Batu Gun Gun
12.11.12.2004|Rante Besi
12.11.12.2005|Gundaling
12.11.12.2006|Kendit Liang
12.11.12.2007|Lau Lebah
12.11.12.2008|Tupak Raja
12.11.13.2001|Sambaliang
12.11.13.2002|Pasi
12.11.13.2003|Banjar Toba
12.11.13.2004|Berampu
12.11.13.2005|Karing
12.11.14.2001|Silalahi II
12.11.14.2002|Silalahi I
12.11.14.2003|Paropo
12.11.14.2004|Silalahi III
12.11.14.2005|Paropo I
12.11.15.1004|Panji Dabutar
12.11.15.2001|Sitinjo
12.11.15.2002|Sitinjo I
12.11.15.2003|Sitinjo II
12.12.01.1034|Balige I
12.12.01.1035|Balige III
12.12.01.1036|Pardede Onan
12.12.01.1037|Sangkar Nihuta
12.12.01.1038|Lumban Dolok Hauma Bange
12.12.01.1039|Napitupulu Bagasan
12.12.01.2003|Hutanamora
12.12.01.2004|Hutagaol Peatalun
12.12.01.2005|Hinalang Bagasan
12.12.01.2006|Matio
12.12.01.2007|Lumban Pea
12.12.01.2008|Hutabulu Mejan
12.12.01.2010|Lumban Gaol
12.12.01.2011|Parsuratan
12.12.01.2012|Baruara
12.12.01.2013|Aek Bolon Julu
12.12.01.2014|Sibolahotang SAS
12.12.01.2015|Lumban Bulbul
12.12.01.2016|Sianipar Sihailhail
12.12.01.2017|Silalahi Pagar Batu
12.12.01.2018|Lumban Silintong
12.12.01.2019|Saribu Raja Janji Maria
12.12.01.2022|Longat
12.12.01.2023|Balige II
12.12.01.2024|Aek Bolon Jae
12.12.01.2025|Lumban Gorat
12.12.01.2026|Sibuntuon
12.12.01.2027|Siboruon
12.12.01.2028|Paindoan
12.12.01.2029|Bonan Dolok I
12.12.01.2030|Bonan Dolok II
12.12.01.2031|Bonan Dolok III
12.12.01.2032|Huta Dame
12.12.01.2040|Lumban Pea Timur
12.12.01.2041|Tambunan Sunge
12.12.02.1001|Pasar Laguboti
12.12.02.2002|Sibuea
12.12.02.2003|Sintong Marnipi
12.12.02.2004|Sibarani Nasampulu/Namungkup
12.12.02.2005|Aruan
12.12.02.2006|Sidulang
12.12.02.2007|Ujung Tanduk
12.12.02.2008|Haunatas II
12.12.02.2009|Pardomuan Nauli
12.12.02.2010|Sitangkola
12.12.02.2011|Tinggir Nipasir
12.12.02.2012|Haunatas I
12.12.02.2013|Pintu Bosi
12.12.02.2014|Simatibung
12.12.02.2015|Lumban Binanga
12.12.02.2016|Ompu Raja Hutapea
12.12.02.2017|Gasaribu
12.12.02.2018|Pardinggaran
12.12.02.2019|Sitoluama
12.12.02.2020|Lumban Bagasan
12.12.02.2021|Siraja Gorat
12.12.02.2022|Ompu Raja Hutapea Timur
12.12.02.2023|Ompu Raja Hatulian
12.12.03.2001|Pintu Batu
12.12.03.2002|Sitorang
12.12.03.2003|Parsambilan
12.12.03.2004|Huta Gur- Gur II
12.12.03.2005|Silaen
12.12.03.2006|Ombur
12.12.03.2008|Natolutali
12.12.03.2009|Dalihan Natolu
12.12.03.2010|Sigodang Tua
12.12.03.2014|Sinta Dame
12.12.03.2015|Hutanamora
12.12.03.2017|Pardomuan
12.12.03.2018|Huta Gur-Gur I
12.12.03.2022|Lumban Dolok
12.12.03.2023|Napitupulu
12.12.03.2024|Hutagaol Sihujur
12.12.03.2025|Meranti Barat
12.12.03.2026|Sibide Barat
12.12.03.2027|Sibide
12.12.03.2028|Simanobak
12.12.03.2029|Panindi
12.12.03.2030|Siringkiron
12.12.03.2031|Marbulang
12.12.04.1009|Parsoburan Tengah
12.12.04.2002|Lumban Rau Selatan
12.12.04.2004|Lumban Rau Barat
12.12.04.2006|Lumban Balik
12.12.04.2007|Panamparan
12.12.04.2008|Lumban Pinasa
12.12.04.2010|Parsoburan Barat
12.12.04.2011|Lumban Ruhap
12.12.04.2012|Lumban Pea
12.12.04.2014|Hitetano
12.12.04.2017|Lobu Hole
12.12.04.2018|Batu Nabolon
12.12.04.2019|Lumban Gaol
12.12.04.2020|Tornagodang
12.12.04.2021|Taon Marisi
12.12.04.2022|Pagar Batu
12.12.04.2023|Sibuntuon
12.12.04.2024|Pararungan
12.12.04.2025|Lumban Lintong
12.12.04.2026|Pangunjungan
12.12.04.2027|Lumban Pinasa Saroha
12.12.04.2028|Aek Ulok
12.12.05.2001|Meranti Utara
12.12.05.2002|Meranti Timur
12.12.05.2003|Meranti Tengah
12.12.05.2007|Pintu Pohan
12.12.05.2008|Ambar Halim
12.12.05.2009|Pintu Pohan Dolok
12.12.05.2010|Halado
12.12.06.2001|Natumingka
12.12.06.2002|Pangururan
12.12.06.2003|Pardomuan Nauli
12.12.06.2004|Lintong
12.12.06.2005|Rianiate
12.12.06.2006|Aek Unsim
12.12.06.2007|Purba Tua
12.12.06.2008|Janji Maria
12.12.06.2009|Pangururan II
12.12.06.2010|Pangururan III
12.12.06.2011|Hutagurgur
12.12.06.2012|Simare
12.12.06.2013|Lumban Sewa
12.12.06.2014|Riganjang
12.12.06.2015|Pasar Borbor
12.12.07.1037|Pasar Porsea
12.12.07.1038|Patane III
12.12.07.1039|Parparean III
12.12.07.2001|Patane IV
12.12.07.2003|Lumban Gurning
12.12.07.2004|Amborgang
12.12.07.2005|Nalela
12.12.07.2007|Patane II
12.12.07.2022|Gala Gala Pangkailan
12.12.07.2023|Silamosik I
12.12.07.2030|Parparean IV
12.12.07.2031|Parparean I
12.12.07.2033|Parparean II
12.12.07.2036|Patane I
12.12.07.2040|Patane V
12.12.07.2041|Simpang Sigura-Gura
12.12.07.2042|Raut Bosi
12.12.08.1009|Parsaoran Ajibata
12.12.08.2001|Sigapiton
12.12.08.2002|Pardomuan Ajibata
12.12.08.2003|Pardamean Ajibata
12.12.08.2004|Motung
12.12.08.2005|Horsik
12.12.08.2006|Sirungkungon
12.12.08.2007|Parsaoran Sibisa
12.12.08.2008|Pardamean Sibisa
12.12.08.2010|Pardomuan Motung
12.12.09.2002|Lintong Julu
12.12.09.2003|Hatinggian
12.12.09.2004|Sibaruang
12.12.09.2005|Jangga Toruan
12.12.09.2006|Sionggang Selatan
12.12.09.2007|Pasar Lumban Julu
12.12.09.2008|Sionggang Utara
12.12.09.2014|Sionggang Tengah
12.12.09.2015|Jangga Dolok
12.12.09.2016|Hutanamora
12.12.09.2017|Jonggi Nihuta
12.12.09.2018|Aek Natolu Jaya
12.12.10.2001|Dolok Saribu Janji Matogu
12.12.10.2002|Dolok Nagodang
12.12.10.2003|Lumban Binanga
12.12.10.2004|Partor Janji Matogu
12.12.10.2005|Parhabinsaran Janji Matogu
12.12.10.2006|Parik
12.12.10.2007|Sibuntuon
12.12.10.2008|Sigaol Barat
12.12.10.2009|Marom
12.12.10.2010|Sigaol Timur
12.12.10.2012|Siregar Aek Nalas
12.12.10.2014|Lumban Holbung
12.12.10.2015|Parbagasan Janji Matogu
12.12.10.2016|Partoruan Janji Matogu
12.12.10.2017|Lumban Nabolon
12.12.10.2018|Sampuara
12.12.10.2019|Dolok Saribu Lumban Nabolon
12.12.19.1007|Sigumpar Dangsina
12.12.19.2001|Marsangap
12.12.19.2002|Nauli
12.12.19.2003|Situa-tua
12.12.19.2004|Sigumpar
12.12.19.2005|Maju
12.12.19.2006|Dolok Jior
12.12.19.2008|Sigumpar Julu
12.12.19.2009|Sigumpar Barat
12.12.19.2010|Banua Huta
12.12.20.2001|Narumonda I
12.12.20.2002|Narumonda II
12.12.20.2003|Narumonda III
12.12.20.2004|Narumonda IV
12.12.20.2005|Narumonda V
12.12.20.2006|Narumonda VI
12.12.20.2007|Narumonda VII
12.12.20.2008|Narumonda VIII
12.12.20.2009|Siantar Sitio Tio
12.12.20.2010|Siantar Dangsina
12.12.20.2011|Siantar Tonga-tonga I
12.12.20.2012|Siantar Tonga-Tonga II
12.12.20.2013|Siantar Sigordang
12.12.20.2014|Siantar Tonga-Tonga III
12.12.21.2001|Lumban Rau Tengah
12.12.21.2002|Lumban Rau Timur
12.12.21.2003|Lumban Rau Utara
12.12.21.2004|Sipagabu
12.12.21.2005|Napajoring
12.12.21.2006|Liat Tondung
12.12.21.2007|Batu Manumpak
12.12.21.2008|Lumban Rau Tenggara
12.12.21.2009|Cinta Damai
12.12.21.2010|Siantarasa
12.12.22.2001|Lintong Nihuta
12.12.22.2002|Tarabunga
12.12.22.2003|Meat
12.12.22.2004|Gurgur Aek Raja
12.12.22.2005|Tangga Batu Barat
12.12.22.2006|Tangga Batu Timur
12.12.23.2001|Sihiong
12.12.23.2002|Sinar Sabungan
12.12.23.2003|Lumban Lobu
12.12.23.2004|Harungguan
12.12.23.2005|Naga Timbul
12.12.23.2006|Sibadihon
12.12.23.2007|Silamosik II
12.12.23.2011|Partoruan Lumban Lobu
12.12.23.2012|Pardolok Lumban Lobu
12.12.23.2013|Silombu
12.12.23.2014|Lumban Sangkalan
12.12.23.2015|Nagatimbul Timur
12.12.24.2001|Siantar Utara
12.12.24.2002|Lumban Sitorus
12.12.24.2003|Banjar Ganjang
12.12.24.2004|Tangga Batu I
12.12.24.2005|Tangga Batu II
12.12.24.2006|Pangombusan
12.12.24.2007|Jonggi Manulus
12.12.24.2008|Lumban Huala
12.12.24.2009|Dolok Nauli
12.12.24.2010|Lumban Sirait Gu
12.12.24.2011|Lumban Manurung
12.13.01.1011|Kota Siantar
12.13.01.1014|Kayu Jati
12.13.01.1022|Pasar Hilir
12.13.01.1023|Pidoli Dolok
12.13.01.1031|Panyabungan II
12.13.01.1032|Panyabungan III
12.13.01.1033|Panyabungan I
12.13.01.1035|Sipolu-Polu
12.13.01.1036|Dalan Lidang
12.13.01.2001|Adian Jior
12.13.01.2002|Aek Banir
12.13.01.2003|Aek Mata
12.13.01.2004|Darussalam
12.13.01.2005|Gunung Barani
12.13.01.2006|Gunung Manaon
12.13.01.2007|Gunung Tua Jae
12.13.01.2008|Gunung Tua Julu
12.13.01.2009|Gunung Tua Tonga
12.13.01.2010|Huta Lombang Lubis
12.13.01.2012|Ipar Bondar
12.13.01.2013|Kampung Padang
12.13.01.2015|Lumban Pasir
12.13.01.2016|Manyabar
12.13.01.2017|Pagaran Tonga
12.13.01.2018|Panyabungan Jae
12.13.01.2019|Panyabungan Julu
12.13.01.2020|Panyabungan Tonga
12.13.01.2021|Perbangunan
12.13.01.2024|Pidoli Lombang
12.13.01.2025|Salam Bue
12.13.01.2026|Sarak Matua
12.13.01.2027|Sigalapang Julu
12.13.01.2028|Siobon Julu
12.13.01.2029|Sipapaga
12.13.01.2030|Sopobatu
12.13.01.2037|Siobon Jae
12.13.01.2038|Panggorengan
12.13.01.2039|Saba Jambu
12.13.01.2040|Manyabar Jae
12.13.02.1012|Mompang Jae
12.13.02.2002|Beringin Jaya
12.13.02.2007|Huta damai
12.13.02.2008|Jambur Padang Matinggi
12.13.02.2009|Kampung Baru
12.13.02.2010|Mompang Julu
12.13.02.2014|Rumbio
12.13.02.2015|Suka Ramai
12.13.02.2017|Sopo Sorik
12.13.02.2018|Simanondong
12.13.02.2019|Torbanua Raja
12.13.02.2020|Tanjung Mompang
12.13.03.1002|Gunung Baringin
12.13.03.2001|Aek Nabara
12.13.03.2003|Hutaimbaru
12.13.03.2004|Huta Bangun
12.13.03.2005|Huta Tinggi
12.13.03.2006|Pagur
12.13.03.2007|Pardomuan
12.13.03.2008|Parmompang
12.13.03.2009|Ranto Natas
12.13.03.2010|Sirangkap
12.13.03.2011|Tanjung
12.13.03.2012|Tebing Tinggi
12.13.03.2013|Tanjung Julu
12.13.03.2014|Banjar Lancat
12.13.03.2015|Padang Laru
12.13.04.1009|Tano Bato
12.13.04.2001|Aek Ngali
12.13.04.2002|Hutarimbaru
12.13.04.2003|Hayuraja
12.13.04.2004|Huta Julu
12.13.04.2005|Kayu Laut
12.13.04.2006|Lumban Dolok
12.13.04.2007|Roburan Dolok
12.13.04.2008|Roburan Lombang
12.13.04.2010|Huta Raja
12.13.04.2011|Pagaran Gala-Gala
12.13.05.1006|Longat
12.13.05.2001|Barbaran
12.13.05.2002|Barbaran Jae
12.13.05.2003|Batang Gadis
12.13.05.2004|Huta Baringin
12.13.05.2005|Huta Tonga BB
12.13.05.2007|Runding
12.13.05.2008|Sirambas
12.13.05.2009|Saba Jior
12.13.05.2010|Batang Gadis Jae
12.13.06.1014|Siabu
12.13.06.1023|Simangambat
12.13.06.2001|Aek Mual
12.13.06.2002|Bonan Dolok
12.13.06.2003|Huta Raja
12.13.06.2004|Huta Puli
12.13.06.2005|Huta Baringin
12.13.06.2006|Huta Godang Muda
12.13.06.2007|Huraba I
12.13.06.2008|Huraba II
12.13.06.2009|Lumban Pinasa
12.13.06.2010|Lumban Dolok
12.13.06.2011|Muara Btg. Angkola
12.13.06.2012|Pintu Padang Jae
12.13.06.2013|Pintu Padang Julu
12.13.06.2015|Sibaruang
12.13.06.2016|Sihepeng
12.13.06.2017|Simaninggir
12.13.06.2018|Sinonoan
12.13.06.2019|Tangga Bosi II
12.13.06.2020|Tanjung Sialang
12.13.06.2021|Tangga Bosi I
12.13.06.2022|Tangga Bosi III
12.13.06.2024|Sihepeng Sada
12.13.06.2025|Sihepeng Dua
12.13.06.2026|Sihepeng Tolu
12.13.06.2027|Sihepeng Opat
12.13.06.2028|Sihepeng Lima
12.13.07.2001|Bange
12.13.07.2003|Huta Bangun
12.13.07.2005|Janji Matogu
12.13.07.2006|Malintang Jae
12.13.07.2007|Malintang Julu
12.13.07.2008|Pasar Baru Malintang
12.13.07.2010|Sidojadi
12.13.07.2013|Lambou Darul Ihsan
12.13.07.2014|Huta Bangun Jae
12.13.07.2015|Bange Nauli
12.13.07.2016|Malintang
12.13.08.1032|Tamiang
12.13.08.1036|Pasar Kotanopan
12.13.08.2001|Batahan
12.13.08.2002|Botung
12.13.08.2003|Gading Bain
12.13.08.2004|Gunung Tua MS
12.13.08.2005|Gunung Tua SM
12.13.08.2006|Hutapuli
12.13.08.2007|Huta Padang MS
12.13.08.2008|Hutarimbaru SM
12.13.08.2009|Huta Baringin TB
12.13.08.2010|Huta Pungkut Jae
12.13.08.2011|Huta Pungkut Tonga
12.13.08.2012|Huta Pungkut Julu
12.13.08.2013|Huta Dangka
12.13.08.2014|Muara Potan
12.13.08.2015|Muara Siambak
12.13.08.2016|Manambin
12.13.08.2017|Muara Pungkut
12.13.08.2018|Muara Botung
12.13.08.2019|Pagar Gunung
12.13.08.2020|Padang Bulan
12.13.08.2021|Patialo
12.13.08.2022|Saba Dolok
12.13.08.2023|Singengu Jae
12.13.08.2024|Singengu Julu
12.13.08.2025|Sayur Maincat
12.13.08.2026|Simpang Tolang Jae
12.13.08.2027|Simpang Tolang Julu
12.13.08.2028|Sibio Bio
12.13.08.2029|Sopo Sorik
12.13.08.2030|Simandolam
12.13.08.2031|Tombang Bustak
12.13.08.2033|Tobang
12.13.08.2034|Ujung Marisi
12.13.08.2035|Usor Tolang
12.13.09.1008|Pasar Maga
12.13.09.2001|Aek Marian MG
12.13.09.2002|Bangun Purba
12.13.09.2003|Maga Lombang
12.13.09.2004|Maga Dolok
12.13.09.2005|Purba Baru
12.13.09.2006|Purba Lamo
12.13.09.2007|Pangkat
12.13.09.2009|Siantona
12.13.10.1010|Laru Lombang
12.13.10.2001|Angin Barat
12.13.10.2006|Huta Tonga AB
12.13.10.2007|Laru Baringin
12.13.10.2008|Laru Bolak
12.13.10.2009|Laru Dolok
12.13.10.2011|Lumban Pasir
12.13.10.2012|Muara Mais
12.13.10.2013|Muara Mais Jambur
12.13.10.2014|Padang Sanggar
12.13.10.2015|Panjaringan
12.13.10.2016|Pasar Laru
12.13.10.2017|Pastap
12.13.10.2018|Pastap Julu
12.13.10.2020|Rao Rao Dolok
12.13.10.2021|Rao Rao Lombang
12.13.10.2025|Simangambat TB
12.13.10.2026|Tambangan Jae
12.13.10.2027|Tambangan Pasoman
12.13.10.2028|Tambangan Tonga
12.13.11.1003|Huta Godang
12.13.11.2001|Alahan Kae
12.13.11.2002|Habincaran
12.13.11.2004|Huta Padang UP
12.13.11.2005|Hutaimbaru UP
12.13.11.2006|Muara Saladi
12.13.11.2007|Patahajang
12.13.11.2008|Simpang Banyak Jae
12.13.11.2009|Simpang Banyak Julu
12.13.11.2010|Simpang Duhu Dolok
12.13.11.2011|Simpang Duhu Lombang
12.13.11.2012|Simpang Pining
12.13.11.2013|Tolang
12.13.12.1019|Pasar Muara Sipongi
12.13.12.2001|Bandar Panjang
12.13.12.2002|Bandar Panjang Tuo
12.13.12.2007|Kampung Pinang
12.13.12.2008|Koto Baringin
12.13.12.2009|Limau Manis
12.13.12.2012|Ranjo Batu
12.13.12.2013|Sibinail
12.13.12.2015|Simpang Mandepo
12.13.12.2016|Tamiang Mudo
12.13.12.2017|Tanjung Alai
12.13.12.2020|Tanjung Medan
12.13.12.2021|Muara Kumpulan
12.13.12.2022|Aek Botung
12.13.12.2023|Koto Boru
12.13.12.2024|Tanjung Larangan
12.13.13.1017|Muara Soma
12.13.13.2001|Aek Guo
12.13.13.2002|Aek Holbung
12.13.13.2003|Aek Manggis
12.13.13.2004|Aek Nabara
12.13.13.2005|Aek Nangali
12.13.13.2006|Ampung Julu
12.13.13.2007|Ampung Padang
12.13.13.2008|Ampung Siala
12.13.13.2009|Bangkelang
12.13.13.2010|Banjar Malayu
12.13.13.2011|Batu Madinding
12.13.13.2012|Bulu Soma
12.13.13.2013|Guo Batu
12.13.13.2014|Hadangkahan
12.13.13.2015|Hatupangan
12.13.13.2016|Muara Parlampungan
12.13.13.2018|Rantobi
12.13.13.2019|Rao Rao
12.13.13.2020|Simanguntong
12.13.13.2021|Sipogu
12.13.13.2022|Sopo Tinjak
12.13.13.2023|Tarlola
12.13.13.2024|Tombang Kaluang
12.13.13.2025|Huta Lobu
12.13.13.2026|Lubuk Samboa
12.13.13.2027|Jambur Baru
12.13.13.2028|Aek Baru Jae
12.13.13.2029|Aek Baru Julu
12.13.13.2030|Lubuk Bondar Panjang
12.13.13.2031|Tor Naincat
12.13.14.1024|Simpang Gambir
12.13.14.1028|Tapus
12.13.14.2001|Aek Garingging
12.13.14.2002|Aek Manyuruk
12.13.14.2003|Bandar Limabung
12.13.14.2006|Lancat
12.13.14.2010|Kampung Baru
12.13.14.2011|Lobung
12.13.14.2014|Pangkalan
12.13.14.2015|Perk. Simpang Gambir
12.13.14.2019|Sikumbu
12.13.14.2021|Simpang Bajole
12.13.14.2022|Simpang Duku
12.13.14.2023|Simpang Durian
12.13.14.2025|Simpang Koje
12.13.14.2029|Dalan Lidang
12.13.14.2031|Bonca Bayuon
12.13.14.2034|Perbatasan
12.13.14.2035|Tangsi Atas
12.13.15.1011|Pasar Baru Batahan
12.13.15.2001|Banjar Aur
12.13.15.2003|Batahan I
12.13.15.2004|Batu Sondat
12.13.15.2005|Bintungan Bejangkar
12.13.15.2007|Kampung Kapas
12.13.15.2008|Kuala Batahan
12.13.15.2009|Kubangan Tompek
12.13.15.2010|Muara Pertemuan
12.13.15.2012|Pasar Batahan
12.13.15.2013|Pulau Tamang
12.13.15.2014|Sari Kenanga Batahan
12.13.15.2019|Batahan II
12.13.15.2020|Batahan III
12.13.15.2021|Batahan IV
12.13.15.2022|Sinunukan VI
12.13.15.2023|Kampung Kapas I
12.13.15.2024|Kubangan Pandan Sari
12.13.16.1008|Pasar II Natal
12.13.16.1025|Pasar I Natal
12.13.16.2001|Balimbing
12.13.16.2002|Bintuas
12.13.16.2003|Bonda Kase
12.13.16.2004|Buburan
12.13.16.2005|Kampung Sawah
12.13.16.2006|Panggautan
12.13.16.2007|Pardamean Baru
12.13.16.2009|Pasar III Natal
12.13.16.2010|Pasar V Natal
12.13.16.2011|Patiluban Hilir
12.13.16.2012|Patiluban Mudik
12.13.16.2013|Perkebunan Patiluban
12.13.16.2014|Rukun Jaya
12.13.16.2015|Setia Karya
12.13.16.2016|Sikara Kara
12.13.16.2017|Sikara Kara I
12.13.16.2018|Sikara Kara II
12.13.16.2019|Sikara Kara III
12.13.16.2020|Sikara Kara IV
12.13.16.2021|Sundutan Tigo
12.13.16.2022|Taluk
12.13.16.2023|Tegal Sari
12.13.16.2024|Tunas Karya
12.13.16.2026|Pasar VI Natal
12.13.16.2027|Sinunukan V
12.13.16.2028|Suka Maju
12.13.16.2029|Sasaran
12.13.16.2030|Kun-Kun
12.13.17.2001|Batu Mundom
12.13.17.2002|Hutaimbaru
12.13.17.2003|Lubuk Kapundung
12.13.17.2004|Manuncang
12.13.17.2005|Panunggulan
12.13.17.2006|Pasar Singkuang I
12.13.17.2007|Pasar Singkuang II
12.13.17.2008|Rantau Panjang
12.13.17.2009|Sikapas
12.13.17.2010|Tabuyung
12.13.17.2011|Tagilang Julu
12.13.17.2012|Sali Baru
12.13.17.2013|Lubuk Kapundung II
12.13.17.2014|Suka Makmur
12.13.18.2001|Manisak
12.13.18.2002|Simpang Talap
12.13.18.2003|Sampuran
12.13.18.2004|Tandikek
12.13.18.2005|Gonting
12.13.18.2006|Bangun Saroha
12.13.18.2007|Huta Baringin
12.13.18.2008|Muara Bangko
12.13.18.2009|Ranto Nalinjang
12.13.18.2010|Banjar Maga
12.13.18.2011|Huta Raja
12.13.18.2012|Simaninggir
12.13.18.2013|Ranto Panjang
12.13.18.2014|Huta Nauli
12.13.18.2015|Lubuk Kancah
12.13.18.2016|Dua Sepakat
12.13.18.2017|Gunung Godang
12.13.18.2018|Padang Silojongan
12.13.19.2001|Bangun Sejati
12.13.19.2002|Hutarimbaru
12.13.19.2003|Pasar Huta Bargot
12.13.19.2004|Huta Bargot Lombang
12.13.19.2005|Huta Bargot Dolok
12.13.19.2006|Huta Bargot Setia
12.13.19.2007|Huta Bargot Nauli
12.13.19.2008|Mondan
12.13.19.2009|Sayur Maincat
12.13.19.2010|Kumpulan Setia
12.13.19.2011|Simalagi
12.13.19.2012|Saba Padang
12.13.19.2013|Binanga
12.13.19.2014|Huta Naingkan
12.13.20.2001|Huta Lombang
12.13.20.2002|Huta Baru
12.13.20.2003|Handel
12.13.20.2004|Hutatinggi
12.13.20.2005|Hutanamale
12.13.20.2006|Hutabaringin Julu
12.13.20.2007|Sibanggor Jae
12.13.20.2008|Sibanggor Tonga
12.13.20.2009|Sibanggor Julu
12.13.20.2010|Purba Julu
12.13.20.2011|Huta Baringin
12.13.21.2001|Pakantan Dolok
12.13.21.2002|Pakantan Lombang
12.13.21.2003|Huta Gambir
12.13.21.2004|Huta Lancat
12.13.21.2005|Huta Julu
12.13.21.2006|Huta Toras
12.13.21.2007|Huta Padang
12.13.21.2008|Silogun
12.13.22.2001|Sinunukan I
12.13.22.2002|Sinunukan II
12.13.22.2003|Sinunukan III
12.13.22.2004|Sinunukan IV
12.13.22.2005|Bintungan Bejangkar Baru
12.13.22.2006|Banjar Aur Utara
12.13.22.2007|Kampung Kapas II
12.13.22.2008|Airapa
12.13.22.2009|Sido Makmur
12.13.22.2010|Wido Daren
12.13.22.2011|Wono Sari
12.13.22.2012|Suka Damai
12.13.22.2013|Pasir Putih
12.13.22.2014|Sinunukan I Central
12.13.23.2001|Tambiski
12.13.23.2002|Tarutung Panjang
12.13.23.2003|Humbang I
12.13.23.2004|Banua Rakyat
12.13.23.2005|Sayur Matua
12.13.23.2006|Banua Simanosor
12.13.23.2007|Tambiski Nauli
12.14.01.2002|Hilisangowola
12.14.01.2005|Hiliotalua
12.14.01.2006|Koendrafo
12.14.01.2008|Lawa-lawa Luo
12.14.01.2016|Tuhemberua
12.14.01.2017|Tesikhori
12.14.01.2021|Tumari
12.14.01.2023|Ewo
12.14.01.2024|Ko'olotano
12.14.01.2026|Botohilindruria
12.14.01.2027|Caritas Sogawunasi
12.14.01.2028|Orudua Lawa-lawa Luo
12.14.01.2029|Hilifaondrato
12.14.02.2005|Doli-doli Idanotae
12.14.02.2007|Hiliana'a Gomo
12.14.02.2015|Lawa-lawa Luo Gomo
12.14.02.2017|Lolosoni
12.14.02.2023|Orahili Gomo
12.14.02.2024|Sifaoro'asi Gomo
12.14.02.2035|Tanoniko'o
12.14.02.2040|Suka Maju Mohili
12.14.02.2041|Orahili Sibohou
12.14.02.2042|Gunung Gabungan
12.14.02.2043|Umbu Orahua
12.14.03.2001|Bawolato
12.14.03.2002|Bawozihono
12.14.03.2003|Bawo'otalua
12.14.03.2004|Golambanua I
12.14.03.2007|Hilisimaetano Balaekha
12.14.03.2009|Lahusa
12.14.03.2014|Tetezou
12.14.03.2016|Orahili Balaekha
12.14.03.2017|Harenoro
12.14.03.2018|Sarahililaza
12.14.03.2024|Hiliabolata
12.14.03.2025|Hiligambukha
12.14.03.2026|Sinar Baru Darodaro
12.14.03.2027|Hiliorudua
12.14.03.2032|Hilizomboi
12.14.03.2036|Oikhoda Balaekha
12.14.03.2037|Angorudua Balaekha
12.14.03.2038|Hilinawalo Balaekha
12.14.03.2039|Sobawagoli
12.14.03.2040|Lahusa I
12.14.03.2041|Hiliwatema
12.14.03.2042|Mogae
12.14.03.2043|Sinar Baho
12.14.04.2001|Duru
12.14.04.2002|Tuwaso
12.14.04.2003|Hilioromao
12.14.04.2004|Eho
12.14.04.2005|Sialema
12.14.04.2006|Bowonifaoso
12.14.04.2007|Hilianombasela
12.14.04.2008|Lumbui Melayu
12.14.04.2009|Hiliorodua Tebolo
12.14.04.2010|Tebolo Melayu
12.14.04.2021|Lumbui Nias
12.14.04.2022|Baruyu Sibohou
12.14.04.2023|Sepakat
12.14.04.2024|Tano Mokinu
12.14.04.2025|Hilikana
12.14.04.2026|Hilinifaese
12.14.04.2027|Omega
12.14.05.1046|Pasar Pulau Tello
12.14.05.2001|Hiliotalua
12.14.05.2002|Bawodobara
12.14.05.2003|Bawo'amahelato
12.14.05.2004|Bawo'omasio
12.14.05.2005|Loboi
12.14.05.2006|Hiliamaodula
12.14.05.2007|Baruyu Lasara
12.14.05.2008|Sifitu Ewali
12.14.05.2009|Rapa-rapa Melayu
12.14.05.2010|Sinauru
12.14.05.2011|Siofa Ewali
12.14.05.2012|Simaluaya
12.14.05.2013|Silima Ewali
12.14.05.2014|Sidua Ewali
12.14.05.2027|Balogia
12.14.05.2029|Lasonde
12.14.05.2041|Koto
12.14.05.2048|Onaya
12.14.05.2049|Sisarahili
12.14.05.2051|Sebuasi
12.14.05.2054|Orahili
12.14.06.1008|Pasar Teluk Dalam
12.14.06.2006|Hiligeho
12.14.06.2007|Hilitobara
12.14.06.2009|Bawonifaoso
12.14.06.2010|Bawozaua
12.14.06.2011|Hiliganowo
12.14.06.2023|Bawodobara
12.14.06.2024|Bawolowalani
12.14.06.2025|Hilisao'otoniha
12.14.06.2026|Hilisondrekha
12.14.06.2040|Hiliamuri
12.14.06.2042|Hiliana'a
12.14.06.2043|Hiliganowo Salo'o
12.14.06.2044|Ganowo Saua
12.14.06.2045|Nanowa
12.14.06.2046|Hililaza
12.14.07.2004|Sifaoroasi
12.14.07.2005|Hilihoru
12.14.07.2006|Hilimbulawa
12.14.07.2008|Tuindrao
12.14.07.2009|Hilimbowo
12.14.07.2011|Mohili
12.14.07.2012|Lolozaria
12.14.07.2013|Lolomoyo
12.14.07.2014|Hilifadolo
12.14.07.2015|Orahili Eho
12.14.07.2016|Sisobahili
12.14.07.2023|Loloabolo
12.14.07.2024|Hilisalo'o
12.14.07.2026|Sirofi
12.14.07.2027|Hilindraso
12.14.07.2028|Hilimaera
12.14.07.2029|Boholu
12.14.07.2030|Amandraya
12.14.07.2031|Sinar Ino'o
12.14.07.2032|Tuindrao I
12.14.07.2033|Tuhemberua Amandraya
12.14.08.2001|Amuri
12.14.08.2004|Bawosalo'o Siwalawa
12.14.08.2009|Hilifadolo
12.14.08.2014|Lolofaoso
12.14.08.2015|Lolomoyo
12.14.08.2016|Lolowau
12.14.08.2017|Lolohowa
12.14.08.2022|Sisarahili Ekholo
12.14.08.2030|Tuhegafoa
12.14.08.2033|Botohili
12.14.08.2035|Hilikara
12.14.08.2044|Samiri
12.14.08.2047|Hilimbowo Siwalawa
12.14.08.2048|Nituwu Boho
12.14.09.2001|Sifalago Susua
12.14.09.2002|Orahili Susua
12.14.09.2003|Hiliana'a Susua
12.14.09.2004|Hiliorahua
12.14.09.2005|Hilimboe
12.14.09.2006|Hilimboho
12.14.09.2008|Hiliwaebu
12.14.09.2009|Hilidanayao
12.14.09.2010|Hilizamurugo
12.14.09.2011|Sisobahili
12.14.09.2012|Dao-dao Zanuwo
12.14.09.2013|Hiliorudua
12.14.09.2014|Bintang Baru
12.14.09.2015|Hilitobara Susua
12.14.09.2016|Orahua Uluzoi
12.14.09.2017|Hilisibohou
12.14.09.2018|Hiliadulosoi
12.14.09.2019|Orahili Bo'e
12.14.10.2001|Hilisimaetano
12.14.10.2002|Bawogosali
12.14.10.2003|Hilifalawu
12.14.10.2005|Samadaya Hilisimaetano
12.14.10.2006|Idala Jaya Hilisimaetano
12.14.10.2007|Pekan Hilisimaetano
12.14.10.2008|Bonia Hilisimaetano
12.14.10.2009|Ndraso Hilisimaetano
12.14.10.2010|Faomasi Hilisimaetano
12.14.10.2011|Eho Hilisimaetano
12.14.10.2012|Soto'o Hilisimaetano
12.14.10.2013|Hiliaurifa Hilisimaetano
12.14.10.2015|Bawohosi Maniamolo
12.14.10.2016|Bawosaodano
12.14.11.2001|Togizita
12.14.11.2002|Soledua
12.14.11.2003|Bawosalo'o Dao-dao
12.14.11.2004|Tuho'owo
12.14.11.2005|Togizita I
12.14.11.2007|Hilitoese
12.14.11.2008|Dao-dao Sowo
12.14.11.2009|Hiliadulo
12.14.11.2010|Soledua I
12.14.11.2011|Soledua II
12.14.12.2001|Hilisataro
12.14.12.2002|Hilinamoniha
12.14.12.2003|Hiliamaetaluo
12.14.12.2004|Bawoganowo
12.14.12.2005|Hili'alawa
12.14.12.2006|Hilindrasoniha
12.14.12.2007|Hilimagari
12.14.12.2008|Hilisataro Raya
12.14.12.2009|Hilisataro Gewa
12.14.12.2010|Hilisoromi
12.14.12.2011|Hiliasi
12.14.12.2012|Hilindraso Raya
12.14.12.2013|Hilisataro Nandisa
12.14.12.2014|Hilisataro Eho Sofayo
12.14.13.2001|Hilizalo'otano
12.14.13.2002|Hilinawalo Mazino
12.14.13.2003|Lawindra
12.14.13.2004|Bawolahusa
12.14.13.2005|Hilizoroi Lawa
12.14.13.2006|Hilizalo'otano Laowo
12.14.13.2007|Hilizalo'otano Larono
12.14.13.2008|Hililaza Hilinawalo Mazino
12.14.13.2009|Hilifondege Hilizoroilawa
12.14.13.2010|Lolomboli
12.14.13.2011|Bawolahusa Doli-doli
12.14.14.2001|Lawindra
12.14.14.2003|Sifaoro'asi Mola
12.14.14.2004|Hiliuso
12.14.14.2005|Balohili Mola
12.14.14.2006|Ambukha
12.14.14.2007|Tobualo
12.14.14.2008|Hilibadalu
12.14.14.2009|Foikhugaga
12.14.14.2010|Orlin
12.14.14.2011|Orahili Mola
12.14.14.2012|Umbunasi
12.14.15.2001|Hilitotao
12.14.15.2002|Hiliorudua
12.14.15.2003|Sisobambowo
12.14.15.2004|Hiliamauzula
12.14.15.2005|Aramo
12.14.15.2006|Sikhorilafau
12.14.15.2007|Hilifadolo
12.14.15.2008|Hume
12.14.15.2009|Dao-dao
12.14.15.2010|Hilimagiao
12.14.15.2011|Hilisawato
12.14.15.2012|Balohao
12.14.15.2013|Hiligafoa
12.14.15.2014|Hilimbowo
12.14.15.2015|Hilimezaya
12.14.15.2016|Hiliadolowa
12.14.15.2017|Hiligumbu
12.14.15.2018|Bagoa
12.14.16.2001|Labuhan Hiu
12.14.16.2002|Labuhan Bazau
12.14.16.2003|Labuan Rima
12.14.16.2004|Lambak
12.14.16.2005|Bais
12.14.16.2006|Mahang Labara
12.14.16.2007|Adam
12.14.16.2008|Labara
12.14.16.2009|Bais Baru
12.14.16.2010|Labuan Rima Baru
12.14.17.2001|Tetegawa'ai
12.14.17.2002|Hilimbaruzo
12.14.17.2003|Luahandroito
12.14.17.2005|Orahuahili
12.14.17.2006|Ulu Mazo
12.14.17.2007|Guigui
12.14.17.2009|Hilimaufa
12.14.17.2010|Siofabanua
12.14.17.2011|Tetegawa'ai Ehomo
12.14.17.2013|Tafulu
12.14.18.2001|Bawomataluo
12.14.18.2002|Orahili Fau
12.14.18.2003|Bawonahono
12.14.18.2005|Siwalawa
12.14.18.2006|Onohondro
12.14.18.2007|Hilinawalo Fau
12.14.18.2008|Lahusa Fau
12.14.18.2011|Hilizihono
12.14.18.2012|Hiliofonaluo
12.14.18.2015|Bawofanayama
12.14.18.2017|Hilikara Maha
12.14.18.2018|Hilisalawa
12.14.18.2019|Hiligito
12.14.18.2020|Siliwulawa
12.14.18.2021|Hilifarokha Lawa
12.14.18.2022|Eho Orahili
12.14.18.2023|Ete Batu
12.14.19.2001|Sambulu
12.14.19.2002|Orahili Ulunoyo
12.14.19.2003|Hiliwaebu
12.14.19.2004|Amorosa
12.14.19.2005|Marao
12.14.19.2006|Borowosi
12.14.19.2007|Hilimaera
12.14.19.2008|Suka Maju
12.14.19.2009|Loloana'a
12.14.19.2010|Hilifakhe
12.14.19.2011|Bawo Lolomatua
12.14.19.2012|Ambukha I
12.14.19.2013|Puncak Lolomatua
12.14.20.2001|Ehosakhozi
12.14.20.2002|Bawohosi
12.14.20.2003|Hilizoliga
12.14.20.2004|Olayama
12.14.20.2005|Sifaoroasi
12.14.20.2006|Sifalago
12.14.20.2007|Lalimanawa
12.14.20.2008|Tundrumbaho
12.14.20.2009|Hiliuso
12.14.20.2010|Sisarahili Huruna
12.14.20.2011|Tarewe
12.14.20.2012|Fadoro Tuhemberua
12.14.20.2013|Hilifalawu
12.14.20.2014|Luahamofakhe
12.14.20.2015|Sifaoroasi Huruna
12.14.20.2016|Hilimanawa
12.14.20.2017|Mombawa Oladano
12.14.21.2001|Hilinamazihono
12.14.21.2002|Hilimbowo
12.14.21.2003|Simandraolo
12.14.21.2004|Bawosalo'o Bawoluo
12.14.21.2005|Hilimbuasi
12.14.21.2006|Simandraolo O'o'u
12.14.21.2007|Lolomaya
12.14.21.2008|Suka Maju
12.14.21.2009|Hiliorudua
12.14.21.2010|Hilinamazihono Moale
12.14.21.2011|Balohili O'o'u
12.14.22.2001|Fadoro Ewo
12.14.22.2002|Soroma'asi
12.14.22.2003|Lauso
12.14.22.2004|Sisarahili Oyo
12.14.22.2005|Sisobahili Huruna
12.14.22.2006|Onohazumba
12.14.22.2007|Hiliweto
12.14.22.2008|Orahili Huruna
12.14.22.2009|Tetehosi
12.14.22.2010|Helefanikha
12.14.23.2001|Maluo
12.14.23.2002|Hiliadulo
12.14.23.2003|Umbuasi
12.14.23.2004|Sisobahili Siwalawa
12.14.23.2005|Manawadano
12.14.23.2006|Talio
12.14.23.2007|Anaoma
12.14.23.2008|Berua Siwalawa
12.14.23.2009|Umbuasi Barat
12.14.23.2010|Hiligodu
12.14.23.2011|Bukit Burasi
12.14.24.2001|Fondrakoraya
12.14.24.2002|Orudua Sibohou
12.14.24.2003|Sisarahili Susua
12.14.24.2004|Susua
12.14.24.2005|Lahusa Susua
12.14.24.2006|Ramba-ramba
12.14.24.2007|Hilinifaoso
12.14.24.2008|Sifaoroasi
12.14.24.2009|Amandraya
12.14.24.2010|Foikhu Fondrako
12.14.24.2011|Hiliwosi
12.14.24.2012|Orahili Fondrako
12.14.25.2001|Mondrowe
12.14.25.2002|Hilidohona
12.14.25.2003|Hililaora
12.14.25.2004|Uluidanoduo
12.14.25.2005|Umbu Sohahau
12.14.25.2006|Hilisao'oto
12.14.25.2007|Taluzusua
12.14.25.2008|Hilizanuwo
12.14.25.2009|Hoya
12.14.25.2010|Na'ai
12.14.25.2011|Olanori
12.14.26.2001|Sifitubanua
12.14.26.2002|Siwalu Banua
12.14.26.2003|Sitolu Banua
12.14.26.2004|Silima Banua
12.14.26.2005|Mehaga
12.14.26.2006|Sihare'o
12.14.26.2007|Golambanua II
12.14.26.2008|Oladano
12.14.26.2009|Fanedanu
12.14.26.2010|Hiliorahua Tasua
12.14.26.2011|Somambawa
12.14.26.2012|Gabungan Tasua
12.14.26.2013|Hilialawa
12.14.26.2014|Sinar Susua
12.14.27.2001|Sifalago Gomo
12.14.27.2002|Balohili Gomo
12.14.27.2003|Bohalu
12.14.27.2004|Orsedes
12.14.27.2005|Sinar Helaowo
12.14.27.2006|Siholi
12.14.27.2007|Tuhegafoa
12.14.27.2008|Perjuangan
12.14.27.2009|Lewa-lewa
12.14.27.2010|Siraha
12.14.28.2001|Gobo
12.14.28.2002|Silina
12.14.28.2003|Maufa
12.14.28.2004|Gondia
12.14.28.2005|Gobo Baru
12.14.28.2006|Silina Baru
12.14.29.2001|Fuge
12.14.29.2002|Luaha Idano Pono
12.14.29.2003|Sigese
12.14.29.2004|Bawositora
12.14.29.2005|Bintuang
12.14.29.2006|Sibaranun
12.14.29.2007|Bawolawindra
12.14.29.2008|Hayo
12.14.29.2009|Hilizamorogotano
12.14.30.2001|Siofa Banua Lorang
12.14.30.2002|Silima Banua Marit
12.14.30.2003|Zia Biang
12.14.30.2004|Limo Biang
12.14.30.2005|Memong
12.14.30.2006|Bale-bale
12.14.30.2007|Teluk Limo
12.14.30.2008|Wawa
12.14.30.2009|Marit Baru
12.14.30.2010|Majino Lorang
12.14.30.2011|Afore Gobo
12.14.30.2012|Bale-bale Sibohou
12.14.31.2001|Baluta
12.14.31.2002|Eho Baluta
12.14.31.2003|Bawo Ofuloa
12.14.31.2004|Hale Baluta
12.14.31.2005|Bawo Orudua
12.14.31.2006|Jeke
12.14.31.2007|Makole
12.14.31.2008|Sifauruasi
12.14.31.2009|Bawo Analita Saeru
12.14.31.2010|Saeru Melayu
12.14.31.2011|Hiligeho Sogawu
12.14.31.2012|Hiliomasio
12.14.32.2001|Botohilitano
12.14.32.2002|Botohilisalo'o
12.14.32.2003|Lagundri
12.14.32.2004|Orahili Faomasi
12.14.32.2005|Hiliamaetaniha
12.14.32.2006|Sondregeasi
12.14.32.2007|Botohili Silambo
12.14.32.2008|Botohili Sorake
12.14.32.2009|Hilimaenamolo
12.14.32.2010|Bawomaenamolo
12.14.33.2001|Hilifalago
12.14.33.2002|Hilimondregeraya
12.14.33.2003|Hilinamozaua
12.14.33.2004|Hilifarono
12.14.33.2005|Hilionaha
12.14.33.2006|Hilikara
12.14.33.2007|Hilialito Saua
12.14.33.2008|Hilinamozaua Raya
12.14.33.2009|Hilifalago Raya
12.14.33.2010|Hilisanekhehosi
12.14.34.2001|Fanedanu
12.14.34.2002|Fanedanu Sibohou
12.14.34.2003|Lawa-lawa Luo Idanotae
12.14.34.2004|Dao-dao Zanuwo Idano Tae
12.14.34.2005|Sisiwa Ewali
12.14.34.2006|Sisarahili Ewo
12.14.34.2007|Hilialo'oa
12.14.34.2008|Damai
12.14.34.2009|Lolozukhu
12.14.34.2010|Silima Banua Umbunasi
12.14.34.2011|Sindrolo
12.14.35.2001|Lahusa Idanotae
12.14.35.2002|Hiliserangkai
12.14.35.2003|Orahua
12.14.35.2004|Hilimbowo Idanotae
12.14.35.2005|Sirahia
12.14.35.2006|Umbu Idanotae
12.14.35.2007|Awoni
12.14.35.2008|Hilisalo'o
12.14.35.2009|Balombaruzo Orahua
12.14.35.2010|Harefa Orahua
12.14.35.2011|Hiligabungan
12.14.35.2012|Buhawa
12.15.01.2001|Tanjung Meriah
12.15.01.2002|Tanjung Mulia
12.15.01.2003|Kaban Tengah
12.15.01.2004|Bandar Baru
12.15.01.2005|Simberruna
12.15.01.2006|Perolihen
12.15.01.2007|Maholida
12.15.01.2008|Perjaga
12.15.01.2009|Malum
12.15.01.2010|Mbinalun
12.15.02.2001|Sukaramai
12.15.02.2002|Kuta Saga
12.15.02.2003|Kuta Meriah
12.15.02.2004|Kuta Dame
12.15.02.2005|Perpulungen
12.15.02.2006|Pardomuan
12.15.02.2014|Majanggut I
12.15.02.2015|Majanggut II
12.15.02.2016|Surung Mersada
12.15.02.2021|Perduhapen
12.15.03.2001|Salak I
12.15.03.2002|Salak II
12.15.03.2003|Boangmanalu
12.15.03.2009|Sibongkaras
12.15.03.2013|Kuta Tinggi
12.15.03.2014|Penanggalan Binanga Boang
12.15.04.2001|Ulumerah
12.15.04.2002|Pardomuan
12.15.04.2003|Silima Kuta
12.15.04.2004|Lae Langge Namuseng
12.15.04.2005|Cikaok
12.15.05.2001|Kecupak I
12.15.05.2002|Kecupak II
12.15.05.2003|Aornakan I
12.15.05.2004|Simerpara
12.15.05.2005|Aornakan II
12.15.06.2001|Sibagindar
12.15.06.2002|Napatalun Perlambuken
12.15.06.2003|Lae Mbentar
12.15.06.2004|Pagindar
12.15.07.2001|Kuta Babo
12.15.07.2002|Tinada
12.15.07.2003|Silima Kuta
12.15.07.2004|Mahala
12.15.07.2005|Prongil
12.15.07.2006|Buluh Tellang
12.15.08.2001|Siempat Rube II
12.15.08.2002|Siempat Rube I
12.15.08.2003|Mungkur
12.15.08.2004|Siempat Rube IV
12.15.08.2005|Kuta Jungak
12.15.08.2006|Traju
12.16.01.2002|Pusuk II Simaninggir
12.16.01.2003|Sionom Hudon VII
12.16.01.2004|Baringin
12.16.01.2005|Sionom Hudon Julu
12.16.01.2006|Sionom Hudon Tonga
12.16.01.2007|Sionom Hudon Utara
12.16.01.2008|Sionom Hudon Selatan
12.16.01.2009|Sionom Hudon Timur
12.16.01.2010|Sihotang Hasugian Tonga
12.16.01.2011|Pusuk I
12.16.01.2012|Sionom Hudon Toruan
12.16.01.2013|Simataniari
12.16.01.2014|Sionom Hudon Timur II
12.16.01.2015|Sihotang Hasugian Dolok II
12.16.01.2016|Sihotang Hasugian Habinsaran
12.16.01.2017|Sionom Hudon Sibulbulon
12.16.01.2018|Sionom Hudon Runggu
12.16.01.2019|Janji Hutanapa
12.16.01.2020|Baringin Natam
12.16.01.2021|Sihotang Hasugian Dolok I
12.16.02.2001|Parsingguran I
12.16.02.2002|Hutapaung
12.16.02.2003|Pollung
12.16.02.2004|Hutajulu
12.16.02.2005|Ria Ria
12.16.02.2006|Parsingguran II
12.16.02.2007|Pansurbatu
12.16.02.2008|Aek Nauli I
12.16.02.2009|Aek Nauli II
12.16.02.2010|Pandumaan
12.16.02.2011|Sipituhuta
12.16.02.2012|Pardomuan
12.16.02.2013|Hutapaung Utara
12.16.03.2001|Marbun Toruan
12.16.03.2002|Simamora
12.16.03.2003|Tipang
12.16.03.2004|Sinambela
12.16.03.2005|Simangulampe
12.16.03.2006|Siunong Unong Julu
12.16.03.2007|Marbun Tonga Marbun Dolok
12.16.04.2001|Sihonongan
12.16.04.2002|Paranginan Selatan
12.16.04.2003|Paranginan Utara
12.16.04.2004|Lumban Sialaman
12.16.04.2005|Pearung
12.16.04.2006|Lobutolong
12.16.04.2007|Lumban Barat
12.16.04.2008|Siboru Torop
12.16.04.2009|Pearung Silali
12.16.04.2010|Lumban Sianturi
12.16.04.2011|Lobutolong Habinsaran
12.16.05.2001|Sibuntuon Partur
12.16.05.2002|Siharjulu
12.16.05.2003|Sitolu Bahal
12.16.05.2004|Tapian Nauli
12.16.05.2005|Pargaulan
12.16.05.2006|Lobutua
12.16.05.2007|Dolok Margu
12.16.05.2008|Hutasoit I
12.16.05.2009|Nagasaribu I
12.16.05.2010|Nagasaribu II
12.16.05.2011|Sibuntoan Parpea
12.16.05.2012|Siponjot
12.16.05.2013|Habeahan
12.16.05.2014|Sigompul
12.16.05.2015|Bonan Dolok
12.16.05.2016|Sigumpar
12.16.05.2017|Parulohan
12.16.05.2018|Sitio II
12.16.05.2019|Hutasoit II
12.16.05.2020|Nagasaribu III
12.16.05.2021|Nagasaribu IV
12.16.05.2022|Nagasaribu V
12.16.06.1001|Pasar Dolok Sanggul
12.16.06.2002|Sileang
12.16.06.2003|Purba Manalu
12.16.06.2004|Pasaribu
12.16.06.2005|Simarigung
12.16.06.2006|Sampean
12.16.06.2007|Silaga Laga
12.16.06.2008|Sosor Gonting
12.16.06.2009|Sosor Tambok
12.16.06.2010|Purba Dolok
12.16.06.2011|Sihite I
12.16.06.2012|Lumban Tobing
12.16.06.2013|Hutabagasan
12.16.06.2014|Matiti II
12.16.06.2015|Saitnihuta
12.16.06.2016|Hutaraja
12.16.06.2017|Lumban Purba
12.16.06.2018|Bonanionan
12.16.06.2019|Parik Sinomba
12.16.06.2020|Sihite II
12.16.06.2021|Janji
12.16.06.2022|Pakkat
12.16.06.2023|Sirisirisi
12.16.06.2024|Hutagurgur
12.16.06.2025|Matiti
12.16.06.2026|Aek Lung
12.16.06.2027|Simangaronsang
12.16.06.2028|Sosortolong Sihite III
12.16.07.2001|Batunajagar
12.16.07.2002|Sanggaran I
12.16.07.2003|Sitapongan
12.16.07.2004|Sigulok
12.16.07.2005|Hutaginjang
12.16.07.2006|Siborboron
12.16.07.2007|Bonan Dolok I
12.16.07.2008|Bonan Dolok II
12.16.07.2009|Sibuntuon
12.16.07.2010|Nagurguran
12.16.08.2001|Batu Nagodang Siatas
12.16.08.2002|Onan Ganjang
12.16.08.2003|Parbotihan
12.16.08.2004|Sihikit
12.16.08.2005|Parnapa
12.16.08.2006|Janji Nagodang
12.16.08.2007|Sampe Tua
12.16.08.2008|Hutajulu
12.16.08.2009|Sibuluan
12.16.08.2010|Sigalogo
12.16.08.2011|Aek Godang Arbaan
12.16.08.2012|Sanggaran II
12.16.09.2001|Purba Bersatu
12.16.09.2002|Purba Baringin
12.16.09.2003|Karya
12.16.09.2004|Manalu
12.16.09.2005|Sijarango
12.16.09.2006|Tukka Dolok
12.16.09.2007|Siambaton
12.16.09.2008|Parmonangan
12.16.09.2009|Sipagabu
12.16.09.2010|Banuarea
12.16.09.2011|Rura Tanjung
12.16.09.2012|Rura Aek Sopang
12.16.09.2013|Lumban Tonga-Tonga
12.16.09.2014|Pulo Godang
12.16.09.2015|Pakkat Hauagong
12.16.09.2016|Peadungdung
12.16.09.2017|Sijarango I
12.16.09.2018|Ambobi Paranginan
12.16.09.2019|Purba Sianjur
12.16.09.2020|Siambaton Pahae
12.16.09.2021|Panggugunan
12.16.09.2022|Hauagong
12.16.10.2001|Tarabintang
12.16.10.2002|Sihotang Hasugian Toruan
12.16.10.2003|Sibongkare
12.16.10.2004|Sitanduk
12.16.10.2005|Sihombu
12.16.10.2006|Simbara
12.16.10.2007|Marpadan
12.16.10.2008|Mungkur
12.16.10.2009|Sibongkare Sianju
12.17.01.1016|Tuktuk Siadong
12.17.01.2001|Tomok
12.17.01.2002|Sihusapi
12.17.01.2003|Maduma
12.17.01.2004|Dosroha
12.17.01.2005|Ambarita
12.17.01.2006|Martoba
12.17.01.2007|Garoga
12.17.01.2008|Simanindo Sangkal
12.17.01.2009|Cinta Dame
12.17.01.2010|Huta Ginjang
12.17.01.2011|Pardomuan
12.17.01.2012|Parmonangan
12.17.01.2013|Parbalohan
12.17.01.2014|Tanjungan
12.17.01.2015|Simarmata
12.17.01.2017|Tomok Parsaoran
12.17.01.2018|Marlumba
12.17.01.2019|Simanindo
12.17.01.2020|Unjur
12.17.01.2021|Siallagan Pindaraya
12.17.02.2001|Pakpahan
12.17.02.2002|Huta Hotang
12.17.02.2003|Sitinjak
12.17.02.2004|Pardomuan
12.17.02.2005|Tambun Sungkean
12.17.02.2006|Rina Bolak
12.17.02.2007|Onan Runggu
12.17.02.2008|Sitamiang
12.17.02.2009|Janji Matogu
12.17.02.2010|Silima Lombu
12.17.02.2011|Sipira
12.17.02.2012|Harian
12.17.03.1011|Parhusip III
12.17.03.1012|Sirumahombar
12.17.03.2001|Pangaloan
12.17.03.2002|Hutarihit
12.17.03.2003|Sinaga Uruk Pandiangan
12.17.03.2004|Toguan Galung
12.17.03.2005|Pananggangan
12.17.03.2006|Pasaran Parsaoran
12.17.03.2007|Sipinggan Lumban Siantar
12.17.03.2008|Sibonor Ompu Ratus
12.17.03.2009|Nainggolan
12.17.03.2010|Pasaran I
12.17.03.2013|Pananggangan II
12.17.03.2014|Sipinggan
12.17.03.2015|Janji Marapot
12.17.04.2001|Suhutnihuta Pardomuan
12.17.04.2002|Gorat Pallombuan
12.17.04.2003|Urat II
12.17.04.2004|Palipi
12.17.04.2005|Pardomuan Nauli
12.17.04.2006|Hatoguan
12.17.04.2007|Simbolon Purba
12.17.04.2008|Sigaol Simbolon
12.17.04.2009|Urat Timur
12.17.04.2010|Saor Nauli Hatoguan
12.17.04.2011|Parsaoran Urat
12.17.04.2012|Hutaginjang
12.17.04.2014|Sigaol Marbun
12.17.04.2018|Hutadame
12.17.04.2019|Pallombuan
12.17.04.2020|Pamutaran
12.17.04.2021|Sideak
12.17.05.2001|Sosor Dolok
12.17.05.2002|Partungkonaginjang
12.17.05.2003|Hariara Pohan
12.17.05.2004|Dolok Raja
12.17.05.2006|Sampur Toba
12.17.05.2007|Siparmahan
12.17.05.2008|Turpuk Limbong
12.17.05.2009|Turpuk Sagala
12.17.05.2010|Turpuk Malau
12.17.05.2011|Turpuk Sihotang
12.17.05.2012|Janji Martahan
12.17.05.2014|Hutagalung
12.17.05.2015|Hariara Pintu
12.17.06.2001|Huta Ginjang
12.17.06.2002|Singkam
12.17.06.2003|Hasinggaan
12.17.06.2004|Aek Sipitudai
12.17.06.2005|Huta Gurgur
12.17.06.2006|Sianjur Mula Mula
12.17.06.2007|Boho
12.17.06.2008|Siboro
12.17.06.2009|Simarihit
12.17.06.2010|Ginolat
12.17.06.2011|Bonan Dolok
12.17.06.2012|Habeahan Naburahan
12.17.07.2001|Salaon Toba
12.17.07.2002|Lintong Nihuta
12.17.07.2003|Salaon Tonga Tonga
12.17.07.2004|Salaon Dolok
12.17.07.2005|Ronggur Nihuta
12.17.07.2006|Sabungan Nihuta
12.17.07.2007|Paraduan
12.17.07.2008|Sijambur
12.17.08.1026|Pasar Pangururan
12.17.08.1027|Pintu Sona
12.17.08.1028|Siogung-Ogung
12.17.08.2001|Lumban SS Dolok
12.17.08.2002|Lumban SS Torua
12.17.08.2003|Parbaba Dolok
12.17.08.2004|Huta Tinggi
12.17.08.2005|Parhorasan
12.17.08.2006|Pardomuan Nauli
12.17.08.2007|Parsaoran I
12.17.08.2008|Rianiate
12.17.08.2009|Huta Bolon
12.17.08.2010|Panampangan
12.17.08.2011|Pardugul
12.17.08.2012|Huta Namora
12.17.08.2013|Parlondut
12.17.08.2014|Tanjung Bunga
12.17.08.2015|Parmonangan
12.17.08.2016|Sait Nihuta
12.17.08.2017|Situngkir
12.17.08.2018|Sianting-Anting
12.17.08.2019|Sialanguan
12.17.08.2020|Lumban Pinggol
12.17.08.2021|Pardomuan I
12.17.08.2022|Sitolu Huta
12.17.08.2023|Sinabulan
12.17.08.2024|Aek Nauli
12.17.08.2025|Siopat Sosor
12.17.09.2001|Holbung
12.17.09.2002|Janji Raja
12.17.09.2003|Sabulan
12.17.09.2004|Buntu Mauli
12.17.09.2005|Tamba Dolok
12.17.09.2006|Cinta Maju
12.17.09.2007|Parsaoran
12.17.09.2008|Janji Maria
12.18.01.2001|Pantai Cermin Kanan
12.18.01.2002|Pantai Cermin Kiri
12.18.01.2003|Kota Pari
12.18.01.2004|Celawan
12.18.01.2005|Ujung Rambung
12.18.01.2006|Kuala Lama
12.18.01.2007|Besar II Terjun
12.18.01.2008|Sementara
12.18.01.2009|Ara Payung
12.18.01.2010|Pematang Kasih
12.18.01.2011|Lubuk Saban
12.18.01.2012|Naga Kisar
12.18.02.1038|Melati I
12.18.02.1039|Simpang Tiga Pekan
12.18.02.1040|Batang Terap
12.18.02.1041|Tualang
12.18.02.2001|Adolina
12.18.02.2003|Bengkel
12.18.02.2005|Cinta Air
12.18.02.2006|Citaman Jernih
12.18.02.2007|Deli Muda Hulu
12.18.02.2008|Deli Muda Hilir
12.18.02.2009|Jambur Pulau
12.18.02.2012|Kesatuan
12.18.02.2013|Kota Galuh
12.18.02.2015|Lidah Tanah
12.18.02.2016|Lubuk Bayas
12.18.02.2017|Lubuk Cemara
12.18.02.2018|Lubuk Dendang
12.18.02.2019|Lubuk Rotan
12.18.02.2020|Melati II
12.18.02.2024|Pematang Sijonam
12.18.02.2025|Pematang Tatal
12.18.02.2028|Suka Beras
12.18.02.2029|Sukajadi
12.18.02.2031|Sei Buluh
12.18.02.2032|Sei Nagalawan
12.18.02.2033|Sei Sijenggi
12.18.02.2034|Tanah Merah
12.18.02.2035|Tanjung Buluh
12.18.03.2001|Sei Buluh
12.18.03.2002|Liberia
12.18.03.2003|Mata Pao
12.18.03.2004|Pematang Setrak
12.18.03.2005|Makmur
12.18.03.2006|Pasar Baru
12.18.03.2007|Pekan Sialang Buah
12.18.03.2008|Pematang Guntung
12.18.03.2009|Sialang Buah
12.18.03.2010|Sentang
12.18.03.2011|Bogak Besar
12.18.03.2012|Pematang Kuala
12.18.04.2001|Cempedak Lobang
12.18.04.2002|Firdaus
12.18.04.2004|Pergulaan
12.18.04.2006|Sei Rampah
12.18.04.2008|Sei Rejo
12.18.04.2009|Sei Parit
12.18.04.2010|Silau Rakyat
12.18.04.2012|Firdaus Estate
12.18.04.2014|Pematang Ganjang
12.18.04.2015|Pematang Pelintahan
12.18.04.2016|Rambung Estate
12.18.04.2017|Rambung Sialang Hulu
12.18.04.2018|Rambung Sialang Tengah
12.18.04.2019|Rambung Sialang Hilir
12.18.04.2024|Simpang Empat
12.18.04.2026|Sinah Kasih
12.18.04.2027|Tanah Raja
12.18.05.2001|Pekan Tanjung Beringin
12.18.05.2002|Nagur
12.18.05.2003|Mangga Dua
12.18.05.2004|Sukajadi
12.18.05.2005|Tebing Tinggi
12.18.05.2006|Pematang Cermai
12.18.05.2007|Pematang Terang
12.18.05.2008|Bagan Kuala
12.18.06.2001|Bandar Tengah
12.18.06.2002|Juhar
12.18.06.2003|Gelam Sei Serimah
12.18.06.2004|Pekan Bandar Khalipah
12.18.06.2005|Kayu Besar
12.18.07.2001|Nagaraja I
12.18.07.2002|Panglong
12.18.07.2003|Bandarawan
12.18.07.2004|Gunung Para II
12.18.07.2005|Limbong
12.18.07.2006|Dolok Merawan
12.18.07.2007|Paritokan
12.18.07.2008|Kalembak
12.18.07.2009|Afd. VI Dolok Ilir
12.18.07.2010|Pabatu I
12.18.07.2011|Afd. VII Dolok Ilir
12.18.07.2012|Pabatu II
12.18.07.2013|Mainu Tengah
12.18.07.2014|Bahdamar
12.18.07.2015|Pabatu III
12.18.07.2016|Pabatu VI
12.18.07.2017|Korajim
12.18.08.2001|Sipispis
12.18.08.2002|Serbananti
12.18.08.2003|Bartong
12.18.08.2004|Marubun
12.18.08.2005|Pispis
12.18.08.2006|Baja Dolok
12.18.08.2007|Tinokkah
12.18.08.2008|Nagur Pane
12.18.08.2009|Parlambean
12.18.08.2010|Naga Raja
12.18.08.2011|Mariah Nagur
12.18.08.2012|Rimbun
12.18.08.2013|Marjanji
12.18.08.2014|Silau Padang
12.18.08.2015|Buluh Duri
12.18.08.2016|Gunung Monako
12.18.08.2017|Damak Urat
12.18.08.2018|Simalas
12.18.08.2019|Gunung Pane
12.18.08.2020|Sibarau
12.18.09.1029|Pekan Dolok Masihul
12.18.09.2001|Dame
12.18.09.2002|Blok 10
12.18.09.2003|Kota Tengah
12.18.09.2004|Silau Merawan
12.18.09.2005|Pekan Kamis
12.18.09.2006|Batu 12
12.18.09.2007|Batu 13
12.18.09.2008|Baja Ronggi
12.18.09.2009|Dolok Sagala
12.18.09.2010|Dolok Manampang
12.18.09.2011|Pardomuan
12.18.09.2012|Tegal Sari
12.18.09.2013|Pertambatan
12.18.09.2015|Huta Nauli
12.18.09.2016|Bantan
12.18.09.2017|Bukit Cermin Hilir
12.18.09.2018|Malasori
12.18.09.2019|Sarang Giting
12.18.09.2020|Durian Puloan
12.18.09.2021|Sarang Torop
12.18.09.2022|Havea
12.18.09.2023|Aras Panjang
12.18.09.2024|Martebing
12.18.09.2025|Kerapuh
12.18.09.2026|Tanjung Maria
12.18.09.2027|Bah Kerapuh
12.18.09.2028|Ujung Silau
12.18.10.2001|Kotarih Pekan
12.18.10.2002|Kotarih Baru
12.18.10.2003|Banjaran Godang
12.18.10.2004|Si Ujan Ujan
12.18.10.2010|Sei Kari
12.18.10.2013|Bandar Bayu
12.18.10.2014|Durian Kondot
12.18.10.2015|Perbahingan
12.18.10.2022|Sialtong
12.18.10.2023|Huta Galuh
12.18.10.2024|Rubun Dunia
12.18.11.2004|Batu Masagi
12.18.11.2013|Damak Gelugur
12.18.11.2016|Kulasar
12.18.11.2021|Pagar Manik
12.18.11.2022|Pamah
12.18.11.2026|Silinda
12.18.11.2028|Sungai Buaya
12.18.11.2029|Tarean
12.18.11.2031|Tapak Meriah
12.18.12.2010|Tanjung Harap
12.18.12.2011|Kuala Bali
12.18.12.2014|Karang Tengah
12.18.12.2015|Kelapa Bajohom
12.18.12.2018|Manggis
12.18.12.2020|Pulau Gambar
12.18.12.2021|Pulau Tagor
12.18.12.2032|Serba Jadi
12.18.12.2033|Tambak Cekur
12.18.12.2038|Bah Sidua-dua
12.18.13.2001|Bah Sumbu
12.18.13.2002|Naga Kesiangan
12.18.13.2003|Jambu
12.18.13.2004|Mariah Padang
12.18.13.2005|Pertapaan
12.18.13.2006|Paya Lombang
12.18.13.2007|Sei Serimah
12.18.13.2008|Paya Bagas
12.18.13.2009|Paya Mabar
12.18.13.2010|Sei. Priok
12.18.13.2011|Kuta Baru
12.18.13.2018|Kedai Damar
12.18.13.2019|Penonggol
12.18.13.2020|Gunung Kataran
12.18.14.1012|Melati Kebun
12.18.14.2001|Bengabing
12.18.14.2002|Bingkat
12.18.14.2003|Jati Mulyo
12.18.14.2004|Karang Anyar
12.18.14.2005|Lestari Dadi
12.18.14.2006|Pegajahan
12.18.14.2007|Petuaran Hulu
12.18.14.2008|Petuaran Hilir
12.18.14.2009|Pondok Tengah
12.18.14.2010|Sukasari
12.18.14.2011|Tanjung Putus
12.18.14.2013|Sennah
12.18.15.2001|Pon
12.18.15.2002|Sei Bamban
12.18.15.2003|Bakaran Batu
12.18.15.2004|Gempolan
12.18.15.2005|Rampah Estate
12.18.15.2006|Suka Damai
12.18.15.2007|Sei Bamban Estate
12.18.15.2008|Sei Belutu
12.18.15.2009|Sei Buluh
12.18.15.2010|Penggalangan
12.18.16.2001|Penggalian
12.18.16.2002|Laut Tador
12.18.16.2003|Tanah Besih
12.18.16.2004|Binjai
12.18.16.2005|Paya Pasir
12.18.16.2006|Bahilang
12.18.16.2007|Penggalangan
12.18.16.2008|Paya Pinang
12.18.16.2009|Kuta Pinang
12.18.16.2010|Sibulan
12.18.17.2001|Gudang Garam
12.18.17.2002|Dolok Masango
12.18.17.2003|Panombean
12.18.17.2004|Bandar Negeri
12.18.17.2005|Ujung Negeri Kahan
12.18.17.2006|Bandar Magodang
12.18.17.2007|Ujung Negeri Hulu
12.18.17.2008|Pegajahan Hulu
12.18.17.2009|Marihat Dolok
12.18.17.2010|Bintang Bayu
12.18.17.2011|Bandar Pinang Kebun
12.18.17.2012|Damak Tolong Buho
12.18.17.2013|Bandar Pinang Rambe
12.18.17.2014|Pegajahan Kahan
12.18.17.2015|Huta Durian
12.18.17.2016|Kampung Kristen
12.18.17.2017|Sarang Ginting Kahan
12.18.17.2018|Sarang Ginting Hulu
12.18.17.2019|Siahap
12.19.01.1001|Pangkalan Dodek
12.19.01.1002|Pangkalan Dodek Baru
12.19.01.1021|Pagurawan
12.19.01.2003|Aek Nauli
12.19.01.2004|Durian
12.19.01.2005|Lalang
12.19.01.2006|Medang
12.19.01.2007|Pakam
12.19.01.2008|Pakam Raya
12.19.01.2009|Pematang Cengkering
12.19.01.2010|Sei Buah Keras
12.19.01.2011|Sei Rakyat
12.19.01.2012|Sidomulyo
12.19.01.2013|Tanjung Sigoni
12.19.01.2014|Nenas Siam
12.19.01.2015|Pakam Raya Selatan
12.19.01.2016|Mandarsah
12.19.01.2017|Medang Baru
12.19.01.2018|Pematang Nibung
12.19.01.2019|Cengkering Pekan
12.19.01.2020|Sei Raja
12.19.02.1001|Perkebunan Sipare pare
12.19.02.2007|Sei Suka Deras
12.19.02.2008|Simodong
12.19.02.2009|Pematang Jering
12.19.02.2010|Pematang Kuning
12.19.02.2011|Kuala Indah
12.19.02.2012|Kuala Tanjung
12.19.02.2018|Tanjung Gading
12.19.02.2019|Simpang Kopi
12.19.02.2020|Brohol
12.19.03.1001|Indrapura
12.19.03.1019|Indrasakti
12.19.03.2002|Limau Sundai
12.19.03.2003|Pematang Panjang
12.19.03.2004|Sukaraja
12.19.03.2005|Tanah Tinggi
12.19.03.2006|Tanjungmuda
12.19.03.2007|Tanah Merah
12.19.03.2008|Aras
12.19.03.2009|Pasar Lapan
12.19.03.2010|Sipare-pare
12.19.03.2011|Tanjungkubah
12.19.03.2012|Tanjungharapan
12.19.03.2013|Suka Ramai
12.19.03.2014|Tanah Rendah
12.19.03.2015|Tanjungmulya
12.19.03.2016|Titi Payung
12.19.03.2017|Perkotaan
12.19.03.2018|Kampung Kelapa
12.19.04.1001|Lima Puluh Kota
12.19.04.2011|Mangkai Baru
12.19.04.2012|Mangkai Lama
12.19.04.2014|Perkebunan Dolok
12.19.04.2015|Perkebunan Kwala Gunung
12.19.04.2016|Antara
12.19.04.2017|Perkebunan Lima Puluh
12.19.04.2018|Perkebunan Limau Manis
12.19.04.2019|Perkebunan Tanah Gambus
12.19.04.2025|Simpang Gambus
12.19.04.2026|Sumber Makmur
12.19.04.2027|Sumber Padi
12.19.05.1001|Labuhan Ruku
12.19.05.2004|Dahari Selebar
12.19.05.2006|Mesjid Lama
12.19.05.2007|Padang Genting
12.19.05.2008|Pahang
12.19.05.2009|Panjang
12.19.05.2014|Gunung Rante
12.19.05.2015|Dahari Indah
12.19.05.2016|Indra Yaman
12.19.05.2017|Benteng
12.19.06.1001|Tanjung Tiram
12.19.06.1022|Bagan Arya
12.19.06.2002|Guntung
12.19.06.2004|Bagan Dalam
12.19.06.2005|Bogak
12.19.06.2006|Suka Maju
12.19.06.2016|Suka Jaya
12.19.06.2017|Pahlawan
12.19.06.2018|Bandar Rahmat
12.19.06.2019|Kampung Lalang
12.19.07.2001|Kwala Sikasim
12.19.07.2002|Sei Balai
12.19.07.2004|Durian
12.19.07.2005|Perkebunan Sei Balai
12.19.07.2007|Suka Ramai
12.19.07.2008|Sei Bejangkar
12.19.07.2009|Mekar Mulio
12.19.07.2010|Perkebunan Sei Bejangkar
12.19.07.2012|Benteng Jaya
12.19.07.2013|Tanah Timbul
12.19.07.2014|Perjuangan
12.19.07.2015|Sidomulio
12.19.07.2016|Mekar Baru
12.19.07.2017|Suko Rejo
12.19.08.2001|Tanjung Prapat
12.19.08.2002|Laut Tador
12.19.08.2003|Pelanggiran Laut Tador
12.19.08.2004|Perkebunan Tanjung Kasau
12.19.08.2005|Dewi Sri
12.19.08.2006|Tanjung Kasau
12.19.08.2007|Tanjung Seri
12.19.08.2008|Mekar Sari
12.19.08.2009|Sei Simujur
12.19.08.2010|Kandangan
12.19.09.2001|Gambus Laut
12.19.09.2002|Perupuk
12.19.09.2003|Guntung
12.19.09.2004|Barung-Barung
12.19.09.2005|Titi Putih
12.19.09.2006|Pasir Permit
12.19.09.2007|Titi Merah
12.19.09.2008|Pematang Panjang
12.19.09.2009|Bulan-Bulan
12.19.09.2010|Gunung Bandung
12.19.09.2011|Lubuk Cuik
12.19.09.2012|Tanah Itam Ilir
12.19.09.2013|Pematang Tengah
12.19.10.2001|Perkebunan Tanah Itam Ulu
12.19.10.2002|Empat Negeri
12.19.10.2003|Sumber Rejo
12.19.10.2004|Lubuk Hulu
12.19.10.2005|Lubuk Besar
12.19.10.2006|Pulau Sejuk
12.19.10.2007|Simpang Dolok
12.19.10.2008|Air Hitam
12.19.10.2009|Kwala Gunung
12.19.10.2010|Cahaya Pardomuan
12.19.11.2001|Sumber Tani
12.19.11.2002|Sei Muka
12.19.11.2003|Perkebunan Tanah Datar
12.19.11.2004|Binjai Baru
12.19.11.2005|Bangun Sari
12.19.11.2006|Karang Baru
12.19.11.2007|Perkebunan Petatal
12.19.11.2008|Mekar Baru
12.19.11.2009|Petatal
12.19.11.2010|Glugur Makmur
12.19.12.2001|Sentang
12.19.12.2002|Tanjung Mulia
12.19.12.2003|Jati Mulia
12.19.12.2004|Lima Laras
12.19.12.2005|Mekar Laras
12.19.12.2006|Bandar Sono
12.19.12.2007|Ujung Kubu
12.19.12.2008|Sei Mentaram
12.19.12.2009|Pematang Rambai
12.19.12.2010|Tali Air Permai
12.19.12.2011|Bagan Baru
12.19.12.2012|Kapal Merah
12.20.01.2001|Janji Manahan GNT
12.20.01.2002|Pasang Lela
12.20.01.2003|Aek Jabut
12.20.01.2004|Nabundong
12.20.01.2005|Gunung Sormin
12.20.01.2006|Sihalo Halo
12.20.01.2007|Kuala Simpang
12.20.01.2008|Simundol
12.20.01.2009|Nahula Julu
12.20.01.2010|Simaninggir Simundol
12.20.01.2011|Simangambat
12.20.01.2012|Saba Bangun
12.20.01.2013|Malino
12.20.01.2014|Gonting Bange
12.20.01.2015|Hutaimbaru Simundol
12.20.01.2016|Padang Matinggi Simundol
12.20.01.2017|Sunut
12.20.01.2018|Batu Hibul
12.20.01.2019|Sigordang
12.20.01.2020|Pamarai
12.20.01.2021|Padang Matinggi GNT
12.20.01.2022|Gadung Holbung
12.20.01.2023|Salusuhan
12.20.01.2024|Panyabungan
12.20.01.2025|Sayur Matinggi
12.20.01.2026|Hasahatan
12.20.01.2027|Pinarik
12.20.01.2028|Unte Manis
12.20.01.2029|Sipogas
12.20.01.2030|Sipogas A
12.20.01.2031|Padang Malakka
12.20.01.2032|Aek Simanap
12.20.01.2033|Pulo Liman
12.20.01.2034|Aek Kundur
12.20.01.2035|Hatiran
12.20.01.2036|Karang Anyar
12.20.01.2037|Aek Kanan
12.20.01.2038|Nahula Jae
12.20.01.2039|Simadihon
12.20.01.2040|Pasar Sayur Matinggi
12.20.01.2041|Tj. Baru Silaiya
12.20.01.2042|Sitonun
12.20.01.2043|Pasar Simundol
12.20.01.2044|Pamonoran
12.20.02.2001|Siguga
12.20.02.2002|Singanyal
12.20.02.2003|Binanga Panasahan
12.20.02.2004|Aek Haruaya
12.20.02.2005|Tanjung Baru B
12.20.02.2006|Pasar Sipiongot
12.20.02.2007|Bintais Julu
12.20.02.2008|Bunut
12.20.02.2009|Paya Ombik
12.20.02.2010|Aek Suhat Jae
12.20.02.2011|Huta Baru Sil
12.20.02.2012|Sijorang
12.20.02.2013|Simaninggir Sip
12.20.02.2014|Pangaran Julu I
12.20.02.2015|Mompang Lombang
12.20.02.2016|Janji Manahan Sil
12.20.02.2017|Baringin Sip
12.20.02.2018|Gunung Maria
12.20.02.2019|Mompang Dolok
12.20.02.2020|Aek Rao TN
12.20.02.2021|Sijantung Julu
12.20.02.2022|Batu Runding
12.20.02.2023|Lubuk Godang
12.20.02.2024|Bahap
12.20.02.2025|Aek Ilung
12.20.02.2026|Tarutung Bolak
12.20.02.2027|Sungai Pining
12.20.02.2028|Siloung
12.20.02.2029|Hutaimbaru Gul
12.20.02.2030|Sipiongot
12.20.02.2031|Gumbot
12.20.02.2032|Gunung Selamat
12.20.02.2033|Silogo Logo
12.20.02.2034|Lubuk Kundur
12.20.02.2035|Jambur Batu
12.20.02.2036|Simatorkis
12.20.02.2037|Rancaran
12.20.02.2038|Naga Saribu
12.20.02.2039|Simataniari Jae
12.20.02.2040|Janji Manahan Gul
12.20.02.2041|Simataniari
12.20.02.2042|Parmeraan
12.20.02.2043|Panca
12.20.02.2044|Dalihan Natolu
12.20.02.2045|Sungai Datar
12.20.02.2046|Lubuk Lanjang
12.20.02.2047|Arse
12.20.02.2048|Simangambat Tua
12.20.02.2049|Sigala Gala
12.20.02.2050|Sibayo Jae
12.20.02.2051|Dolok Sanggul
12.20.02.2052|Silangge
12.20.02.2053|Pijor Koling
12.20.02.2054|Pagaran Julu II
12.20.02.2055|Siala Gundi
12.20.02.2056|Siraga HP
12.20.02.2057|Aek Sundur
12.20.02.2058|Baringin Sil
12.20.02.2059|Hula Baringin
12.20.02.2060|Nabonggal
12.20.02.2061|Purba Tua
12.20.02.2062|Tanjung Longat
12.20.02.2063|Sibio Bio
12.20.02.2064|Situmbaga
12.20.02.2065|Sijara Jara
12.20.02.2066|Huta Baru Sip
12.20.02.2067|Pagaran Siregar
12.20.02.2068|Parigi
12.20.02.2069|Napasundali
12.20.02.2070|Aek Suhat TR
12.20.02.2071|Gumaruntar
12.20.02.2072|Sijantung Jae
12.20.02.2073|Janji Matogu
12.20.02.2074|Sialang Dolok
12.20.02.2075|Binanga Gumbot
12.20.02.2076|Simanosor
12.20.02.2077|Bukit Tinggi
12.20.02.2078|Simambal
12.20.02.2079|Bandar Nauli
12.20.02.2080|Sibayo
12.20.02.2081|Sinabongan
12.20.02.2082|Siranap
12.20.02.2083|Aek Tangga
12.20.02.2084|Rongkare
12.20.02.2085|Siburbur
12.20.02.2086|Pintu Padang Merdeka
12.20.03.2001|Hutaimbaru
12.20.03.2002|Hambulo
12.20.03.2003|Paolan
12.20.03.2004|Pangirkiran
12.20.03.2005|Balimbing
12.20.03.2006|Rondaman Siburegar
12.20.03.2007|Sipaho
12.20.03.2008|Silantoyung
12.20.03.2009|Hiteurat
12.20.03.2010|Siboru Angin
12.20.03.2011|Sandean Jae
12.20.03.2012|Sandean Tonga
12.20.03.2013|Sandean Julu
12.20.03.2014|Hasahatan
12.20.03.2015|Pagar Gunung
12.20.03.2016|Pangarambangan
12.20.03.2017|Napa Lancat
12.20.03.2018|Halongonan
12.20.03.2019|Bargot Topong Julu
12.20.03.2020|Bargot Topong Jae
12.20.03.2021|Siringki Jae
12.20.03.2022|Ujung Padang
12.20.03.2023|Sigala Gala
12.20.03.2032|Hutanopan
12.20.03.2036|Sipenggeng
12.20.03.2037|Saba
12.20.03.2038|Sitabola
12.20.03.2039|Sitonun
12.20.03.2040|Tapus Jae
12.20.03.2041|Japinulik
12.20.03.2042|Paran Honas
12.20.03.2043|Siringki Julu
12.20.03.2044|Batu Tunggal
12.20.04.1001|Pasar Gunung Tua
12.20.04.2008|Lubuk Torop
12.20.04.2012|Tanjung Marulak
12.20.04.2013|Ambasang Natigor
12.20.04.2014|Napagadung Laut
12.20.04.2015|Rampa Jae
12.20.04.2016|Rampa Julu
12.20.04.2017|Mananti
12.20.04.2018|Paran Padang
12.20.04.2019|Rahuning Jae
12.20.04.2020|Botung
12.20.04.2021|Sigimbal
12.20.04.2022|Dolok Sae
12.20.04.2023|Simasi
12.20.04.2024|Sihapas Hapas
12.20.04.2025|Sungai Tolang
12.20.04.2026|Losung Batu
12.20.04.2027|Batu Mamak
12.20.04.2028|Sampuran
12.20.04.2029|Gunung Tua Baru
12.20.04.2030|Sibatang Kayu
12.20.04.2031|Aek Suhat
12.20.04.2038|Gunung Tua Tonga
12.20.04.2039|Gunung Tua Jae
12.20.04.2040|Gunung Tua Julu
12.20.04.2041|Hutalombang
12.20.04.2042|Batang Baruhar Julu
12.20.04.2043|Batang Baruhar Jae
12.20.04.2044|Purba Sinomba
12.20.04.2045|Hambiri
12.20.04.2046|Sosopan
12.20.04.2047|Pagaran Singkam
12.20.04.2048|Pagaran Tonga
12.20.04.2049|Sibagasi
12.20.04.2050|Batu Tambun
12.20.04.2051|Tanjung Tiram
12.20.04.2052|Garoga
12.20.04.2053|Hajoran
12.20.04.2054|Batu Sundung
12.20.04.2055|Garonggang
12.20.04.2056|Nabonggal
12.20.04.2057|Liang Hasona
12.20.04.2058|Simandiangin Dolok
12.20.04.2059|Simandiangin Lombang
12.20.04.2060|Padang Garugur
12.20.04.2061|Simanosor
12.20.04.2062|Sigama
12.20.04.2063|Sigama Ujung Gading
12.20.04.2064|Parlimbatan
12.20.04.2065|Saba Sitahul tahul
12.20.04.2066|Saba Bangunan
12.20.04.2067|Sidingkat
12.20.04.2069|Gunung Manaon II
12.20.04.2070|Purba Tua
12.20.04.2071|Sungai Durian
12.20.04.2072|Sungai Orosan
12.20.04.2073|Hutaimbaru II
12.20.04.2074|Siombob
12.20.04.2075|Aek Gambir
12.20.04.2076|Bukit Raya Sordang
12.20.04.2077|Aek Jangkang
12.20.04.2078|Simbolon
12.20.05.2001|Pancur Pangko
12.20.05.2002|Hasambi
12.20.05.2003|Paran Nangka
12.20.05.2004|Batu Rancang
12.20.05.2005|Sitanggoru
12.20.05.2006|Siunggam Dolok
12.20.05.2007|Balimbing Jae
12.20.05.2008|Sipupus Lombang
12.20.05.2009|Balimbing Julu
12.20.05.2010|Sobar
12.20.05.2011|Pamuntaran
12.20.05.2012|Paran Gadung
12.20.05.2013|Padang Bujur
12.20.05.2014|Ubar
12.20.05.2015|Lantosan II
12.20.05.2016|Batu Gana
12.20.05.2017|Padang Baruas
12.20.05.2018|Aek Bargot
12.20.05.2019|Gariang
12.20.05.2020|Balakka
12.20.05.2021|Parupuk Jae
12.20.05.2022|Parupuk Julu
12.20.05.2023|Sialang
12.20.06.2002|Sitopayan
12.20.06.2003|Lantosan I
12.20.06.2004|Aek Haruaya
12.20.06.2005|Gunung Baringin
12.20.06.2006|Hadungdung
12.20.06.2007|Rondaman Dolok
12.20.06.2008|Sipirok
12.20.06.2009|Tanjung Salamat
12.20.06.2010|Rondaman Lombang
12.20.06.2011|Parsarmaan
12.20.06.2012|Aloban
12.20.06.2013|Portibi Julu
12.20.06.2014|Portibi Jae
12.20.06.2015|Gunung Manaon I
12.20.06.2016|Pasir Pinang
12.20.06.2017|Bahal
12.20.06.2018|Bara
12.20.06.2019|Simandiangin
12.20.06.2020|Hotang Sasa
12.20.06.2021|Aek Siala
12.20.06.2022|Gumarupu Baru
12.20.06.2023|Padang Manjoir
12.20.06.2024|Gumarupu Lama
12.20.06.2025|Gunung Martua
12.20.06.2026|Sihambeng
12.20.06.2027|Aek Torop
12.20.06.2028|Napa Lombang
12.20.06.2029|Mangaledang Lama
12.20.06.2030|Mangaledang
12.20.06.2031|Bangkudu
12.20.06.2032|Balakka Torop
12.20.06.2033|Janji Matogu
12.20.06.2034|Muara Sigama
12.20.06.2035|Napahalas
12.20.06.2036|Sigama Napahalas
12.20.06.2039|Torluk Muara Dolok
12.20.07.1001|Sayur Matinggi
12.20.07.2002|Pangkal Dolok Lama
12.20.07.2003|Pangkal Dolok Julu
12.20.07.2004|Pintu Padang
12.20.07.2005|Batang Onang Lama
12.20.07.2006|Bonan Dolok
12.20.07.2007|Simardona
12.20.07.2008|Batang Onang Baru
12.20.07.2009|Parau Sorat
12.20.07.2010|Pasar Matanggor
12.20.07.2011|Batu Pulut
12.20.07.2012|Huta Lambung
12.20.07.2013|Galanggang
12.20.07.2014|Gunungtua Tumbu Jati
12.20.07.2015|Gunungtua Batang Onang
12.20.07.2016|Simanapang
12.20.07.2017|Simaninggir
12.20.07.2018|Batu Mamak
12.20.07.2019|Padang Garugur
12.20.07.2020|Padang Matinggi
12.20.07.2021|Purba Tua
12.20.07.2022|Janji Mauli
12.20.07.2023|Sayur Matinggi Julu
12.20.07.2024|Gunung Tua Julu
12.20.07.2025|Pasir Ampolu Hopong
12.20.07.2026|Pagaran Batu
12.20.07.2027|Tamosu
12.20.07.2028|Simangambat Dolok
12.20.07.2029|Janji Manahan
12.20.07.2030|Padang Bujur Baru
12.20.07.2031|Batu Nanggar
12.20.07.2032|Morang
12.20.08.2014|Ulak Tano
12.20.08.2015|Aekraru
12.20.08.2016|Tanjung Maria
12.20.08.2017|Mandasip
12.20.08.2018|Huta Baru
12.20.08.2019|Janji Matogu
12.20.08.2020|Paran Padang
12.20.08.2021|Tanjung Botung
12.20.08.2022|Huta Pasir
12.20.08.2023|Langkimat
12.20.08.2024|Jabi Jabi
12.20.08.2025|Simangambat Jae
12.20.08.2026|Ujung Gading Jae
12.20.08.2027|Huta Baringin
12.20.08.2028|Gunung Manaon Sim
12.20.08.2029|Sionggoton
12.20.08.2030|Paran Tonga Sim
12.20.08.2031|Ujung Gading Julu
12.20.08.2032|Simangambat Julu
12.20.08.2033|Sigagan
12.20.08.2034|Kosik Putih
12.20.09.2001|Aek Godang
12.20.09.2002|Aek Nauli
12.20.09.2003|Sampuran Simarloting
12.20.09.2004|Pangirkiran
12.20.09.2005|Simaninggir
12.20.09.2006|Suka Dame
12.20.09.2007|Pintu Bosi
12.20.09.2008|Sidong-dong
12.20.09.2009|Sitabar
12.20.09.2010|Parmeraan
12.20.10.2001|Siunggam Julu
12.20.10.2002|Siunggam Tonga
12.20.10.2003|Siunggam Jae
12.20.10.2004|Aek Bayur
12.20.10.2005|Aek Tolong
12.20.10.2006|Tangga-Tangga Hambeng
12.20.10.2007|Simaninggir
12.20.10.2008|Bangun Purba
12.20.10.2009|Naga Saribu
12.20.10.2010|Sihoda-Hoda
12.20.10.2011|Mompang II
12.20.10.2012|Gulangan
12.20.10.2013|Pijor Koling
12.20.10.2014|Purba Tua Dolok
12.20.11.2001|Siancimun
12.20.11.2002|Bolatan
12.20.11.2003|Pasir Bara
12.20.11.2004|Gunung Intan
12.20.11.2005|Mompang I
12.20.11.2006|Gunung Manaon III
12.20.11.2007|Sihopuk Baru
12.20.11.2008|Sihopuk Lama
12.20.11.2009|Rondaman
12.20.11.2010|Hutabaru Nangka
12.20.11.2011|Situmbaga
12.20.11.2012|Batang Pane I
12.20.11.2013|Batang Pane II
12.20.11.2014|Batang Pane III
12.20.12.2001|Huta Raja
12.20.12.2002|Ujung Batu Julu
12.20.12.2003|Gunung Manaon UB
12.20.12.2004|Labuhan Jurung
12.20.12.2005|Martujuan
12.20.12.2006|Paya Bahung UB
12.20.12.2007|Tobing Tinggi UB
12.20.12.2008|Ujung Batu Jae
12.20.12.2009|Marlaung
12.20.12.2010|Mananti
12.20.12.2011|Jambu Tonang
12.20.12.2012|Manare Tua
12.20.12.2013|Pasir Lancat UB
12.21.01.2001|Pagaranbira Jae
12.21.01.2002|Pagaran Bira Julu
12.21.01.2003|Huta Bargot
12.21.01.2004|Siundol Jae
12.21.01.2005|Siundol Julu
12.21.01.2006|Siundol Dolok
12.21.01.2007|Hutabaru Siundol
12.21.01.2008|Binanga Tolu
12.21.01.2009|Aek Bargot
12.21.01.2010|Ulu Aer
12.21.01.2011|Hulim
12.21.01.2012|Sianggunan
12.21.01.2013|Simaninggir Sosopan
12.21.01.2014|Sibualbuali
12.21.01.2015|Sosopan
12.21.01.2016|Sigala-Gala
12.21.01.2017|Sihaporas
12.21.01.2018|Banua Tonga
12.21.01.2019|Sosopan Julu
12.21.01.2020|Huta Bara
12.21.01.2021|Hutabaru Sosopan
12.21.01.2022|Simartolu
12.21.02.2001|Gunung Baringin
12.21.02.2002|Pasar Binanga
12.21.02.2003|Sihaborgoan Dalan
12.21.02.2004|Aek Tanduk
12.21.02.2005|PP. Makmur
12.21.02.2006|Siboris Bahal
12.21.02.2007|Bangkudu
12.21.02.2008|Siolip
12.21.02.2009|Aek Tunjang
12.21.02.2010|Binanga
12.21.02.2011|Manombo
12.21.02.2012|Janji Raja
12.21.02.2013|Pangirkiran Dolok
12.21.02.2014|Sihaborgoan Barumun
12.21.02.2015|Siboris Dolok
12.21.02.2016|Padang Matinggi
12.21.02.2017|Tandihat
12.21.02.2018|Bara Batu
12.21.02.2019|Bahal Batu
12.21.02.2020|Ginduang Batu
12.21.02.2021|Padang Garugur
12.21.02.2022|Gunung Manaon
12.21.02.2023|Siboris Lombang
12.21.02.2024|Janji Matogu
12.21.02.2025|Gunung Malintang
12.21.02.2026|Sibatu Loting
12.21.02.2028|Janji Manahan
12.21.02.2029|Siparau
12.21.02.2030|Unterudang
12.21.03.2001|Binanga Tolu
12.21.03.2002|Tanjung Baringin
12.21.03.2003|Huristak
12.21.03.2004|Paran Tonga
12.21.03.2005|Gonting Julu
12.21.03.2006|Bulu Cina
12.21.03.2007|Sigading
12.21.03.2008|Pasir Lancat Lama
12.21.03.2009|Siala Gundi
12.21.03.2010|Tobing Julu
12.21.03.2011|Tar Sihoda-Hoda
12.21.03.2012|Huta Pasir Ulak Tano
12.21.03.2013|Tobing Jae
12.21.03.2014|Pasar Huristak
12.21.03.2015|Sipirok Baru
12.21.03.2016|Pasir Lancat Baru
12.21.03.2017|Tobing Tinggi
12.21.03.2018|Ganal
12.21.03.2019|Paya Bujing
12.21.03.2020|Pulo Bariang
12.21.03.2021|Ramba
12.21.03.2022|Gonting Jae
12.21.03.2023|Gala Bonang
12.21.03.2024|Tanjung Morang
12.21.03.2025|Gunung Manaon
12.21.03.2026|Gunung Matinggi
12.21.03.2027|Pasir Pinang
12.21.04.2001|Janji Matogu
12.21.04.2002|Pagaran Silindung
12.21.04.2003|Tangga Bosi
12.21.04.2004|Hutaibus
12.21.04.2005|Pagaran Jalu-Jalu
12.21.04.2006|Hutanopan
12.21.04.2007|Pasar Latong
12.21.04.2008|Pagaran Jae Batu
12.21.04.2009|Aek Lancat
12.21.04.2010|Batang Tanggal Baru
12.21.04.2011|Bonal
12.21.04.2012|Pagaran Malaka
12.21.04.2013|Huta Dolok
12.21.04.2014|Gunung Manobot
12.21.04.2015|Batang Bulu Jae
12.21.04.2016|Suro Dingin
12.21.04.2017|Janji Lobi Lima
12.21.04.2018|Sangkilon
12.21.04.2019|Siali-Ali
12.21.04.2020|Huta Lombang
12.21.04.2021|Pagaran Mompang
12.21.04.2022|Parsombaan
12.21.04.2023|Sihiuk
12.21.04.2024|Batang Bulu Tanggal
12.21.05.2004|Lubuk Bunut
12.21.05.2005|Ujung Padang
12.21.05.2006|Tanjung Baringin
12.21.05.2007|Sibodak Sosa Jae
$wilayah$, E'\r?\n') as baris
  where baris <> ''
) as d
order by length(kode), kode
on conflict (kode) do update
  set nama = excluded.nama, tingkat = excluded.tingkat, induk_kode = excluded.induk_kode;
