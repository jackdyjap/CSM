-- Data wilayah Indonesia, versi RINGKAS untuk SQL Editor Supabase: bagian 2 dari 5.
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
12.21.05.2008|Parmainan
12.21.05.2009|Pagaran Dolok Sosa Jae
12.21.05.2010|Aliaga
12.21.05.2011|Mananti Sosa Jae
12.21.05.2012|Panyabungan
12.21.05.2013|Pasar Panyabungan
12.21.05.2014|Sigalapung
12.21.05.2015|Siabu
12.21.05.2016|Paya Ombur
12.21.05.2017|Hutaraja Tinggi
12.21.05.2018|Sungai Korang
12.21.05.2019|Ujung Batu I
12.21.05.2020|Ujung Batu II
12.21.05.2021|Ujung Batu III
12.21.05.2022|Ujung Batu IV
12.21.05.2023|Ujung Batu V
12.21.05.2026|Pir Trans Sosa III A
12.21.05.2027|Pir Trans Sosa III B
12.21.05.2028|Pir Trans Sosa II
12.21.05.2029|Pir Trans Sosa IV
12.21.05.2030|Pir Trans Sosa V
12.21.05.2031|Pir Trans Sosa VI
12.21.06.2001|Simanuldang Jae
12.21.06.2002|Simanuldang Julu
12.21.06.2003|Tapian Nauli
12.21.06.2004|Handang Kopo
12.21.06.2005|Subulussalam
12.21.06.2006|Pintu Padang
12.21.06.2007|Matondang
12.21.06.2008|Pasar Ipuh
12.21.06.2009|Paringgonan
12.21.06.2010|Paringgonan Julu
12.21.06.2011|Paran Batu
12.21.06.2012|Sibual Buali
12.21.06.2013|Tanjung
12.21.06.2014|Siraisan
12.21.06.2015|Aek Haruaya
12.21.07.1001|Pasar Sibuhuan
12.21.07.2002|Sibuhuan Julu
12.21.07.2003|Bangun Raya
12.21.07.2004|Purba Tua
12.21.07.2005|Handis Julu
12.21.07.2006|Sialambue
12.21.07.2007|Sibuhuan Jae
12.21.07.2008|Janjilobi
12.21.07.2021|Tanjung Durian
12.21.07.2022|Tanjung Botung
12.21.07.2023|Tanobato
12.21.07.2024|Hutarimbaru
12.21.07.2025|Sayur Matua
12.21.07.2037|Bulusonik
12.21.07.2038|Arsesimatorkis
12.21.07.2039|Pancaukan
12.21.07.2040|Pagaran Baringin
12.21.08.2006|Pasar Ujung Batu
12.21.08.2008|Plasma Mondang
12.21.08.2011|Hutaimbaru
12.21.08.2012|Mondang
12.21.08.2013|Sisoma
12.21.08.2014|Aek Tinga
12.21.08.2015|Gunung Baringin
12.21.08.2016|Simarancar
12.21.08.2017|Huta Raja Lamo
12.21.08.2018|Tanjung Botung Sosa Jae
12.21.08.2019|Ujung Batu
12.21.08.2020|Janjiraja
12.21.08.2021|Rao-Rao Dolok
12.21.08.2022|Parau Sorat
12.21.08.2023|Aer Bale
12.21.08.2024|Tanjung Bale
12.21.09.2001|Tanjung Baru
12.21.09.2002|Tamiang
12.21.09.2003|Tanjung Barani
12.21.09.2004|Manggis
12.21.09.2005|Pagaran Tayas
12.21.09.2006|Hatongga
12.21.09.2007|Botung
12.21.09.2008|Siadam
12.21.09.2009|Siojo
12.21.09.2010|Pagaran Manggis
12.21.09.2011|Muara Malinto Lama
12.21.09.2012|Hutabaru
12.21.09.2013|Huta Nopan
12.21.09.2014|Tandolan
12.21.09.2015|Tangga Batu
12.21.09.2016|Pagaran Dolok Pinarik
12.21.09.2017|Muara Malinto Baru
12.21.09.2018|Aek Sorik
12.21.09.2019|Tanjung Botung Pinarik
12.21.09.2020|Pinarik
12.21.10.2001|Batang Bulu Lama
12.21.10.2002|Pagur Satio
12.21.10.2003|Batang Bulu Baru
12.21.10.2004|Gunung Intan
12.21.10.2005|Tanjung Purba Tua
12.21.10.2006|Banua Tonga
12.21.10.2007|Gunung Barani
12.21.10.2008|Tanjung Baringin Simarulak
12.21.10.2009|Sayur Mahincat
12.21.10.2010|Sidomulio
12.21.10.2011|Panarian
12.21.11.2001|Aek Nabara Tonga
12.21.11.2002|Aek Nabara Jae
12.21.11.2003|Padang Garugur Jae
12.21.11.2004|Huta Bargot
12.21.11.2005|Janji Maria
12.21.11.2006|Padang Garugur Julu
12.21.11.2007|Sidokan
12.21.11.2008|Tobing
12.21.11.2009|Hadungdung Aek Rampah
12.21.11.2010|Tobing Tinggi
12.21.11.2011|Sipagabu
12.21.11.2012|Tanjung
12.21.11.2013|Paran Tonga
12.21.11.2014|Paran Julu
12.21.11.2015|Hadungdung Pintu Padang
12.21.11.2016|Tanjung Rokan
12.21.11.2017|Aek Bonban
12.21.11.2018|Marenu
12.21.11.2019|Aek Nabara Julu
12.21.11.2020|Padang Garugur Tonga
12.21.11.2021|Bangkuang
12.21.11.2022|Paya bahung
12.21.11.2023|Aek Buaton
12.21.11.2024|Sayur Matua
12.21.11.2025|Sayur Mahincat
12.21.12.2001|Lubuk Gonting
12.21.12.2002|Padang Hasior Dolok
12.21.12.2003|Padang Hasior Lombang
12.21.12.2004|Sitada-Tada
12.21.12.2005|Paran Dolok
12.21.12.2006|Ujung Gading
12.21.12.2007|Simaninggir
12.21.12.2008|Tanjung Morang
12.21.12.2009|Silenjeng
12.21.12.2010|Aek Goti
12.21.12.2011|Gulangan
12.21.12.2012|Ujung Padang
12.21.12.2013|Balangka
12.21.13.2001|Hasahatan Julu
12.21.13.2002|Hasahatan Jae
12.21.13.2003|Sabahotang
12.21.13.2004|Sigorbus Julu
12.21.13.2005|Sigorbus Jae
12.21.13.2006|Mompang
12.21.13.2007|Sitarolo Julu
12.21.13.2008|Siolip
12.21.13.2009|Saba Rimba
12.21.13.2010|Limbong
12.21.13.2011|Simaninggir
12.21.13.2012|Binabo Julu
12.21.13.2013|Binabo Jae
12.21.14.2001|Hapung
12.21.14.2002|Batu Gajah
12.21.14.2003|Hapung Torop
12.21.14.2004|Harang Jae
12.21.14.2005|Harang Julu
12.21.14.2006|Handio
12.21.14.2007|Gunung Tua
12.21.14.2008|Mandian
12.21.14.2009|Parapat
12.21.14.2010|Horuon
12.21.14.2011|Bonan Dolok
12.21.15.2001|Pasir Julu
12.21.15.2002|Lumban Huayan
12.21.15.2003|Siborna Bunut
12.21.15.2004|Mananti Sosa Julu
12.21.15.2005|Ampolu
12.21.15.2006|Siginduang
12.21.15.2007|Ramba
12.21.15.2008|Roburan
12.21.15.2009|Tanjung
12.21.15.2010|Hurung Jilok
12.21.15.2011|Pasir Jae
12.21.15.2012|Sungai Jior
12.21.16.2001|Gading
12.21.16.2002|Huta Ruhom
12.21.16.2003|Aek Siala
12.21.16.2004|Bire
12.21.16.2005|Sibontar
12.21.16.2006|Para Napa Jae
12.21.16.2007|Para Napa Dolok
12.21.16.2008|Batusundung
12.21.16.2009|Sidongdong
12.21.16.2010|Sisalean
12.21.17.2001|Tanjung Ale
12.21.17.2002|Sigala-Gala
12.21.17.2003|Simangambat
12.21.17.2004|Pir Trans Sosa I B
12.21.17.2005|Pir Trans Sosa I A
12.21.17.2006|Gunung Manaon
12.21.17.2007|Muara Tige
12.21.17.2008|Sibodak Papaso
12.21.17.2009|Gunung Inten
12.21.17.2010|Pagaran Baringin
12.21.17.2011|Salambue
12.21.17.2012|Papaso
12.21.17.2013|Rombayan
12.22.01.1001|Kotapinang
12.22.01.2002|Simatahari
12.22.01.2003|Mampang
12.22.01.2004|Pasir Tuntung
12.22.01.2005|Sisumut
12.22.01.2006|Hadundung
12.22.01.2007|Sosopan
12.22.01.2008|Perkebunan Nomark
12.22.01.2009|Perkebunan Nagodang
12.22.01.2010|Perk. Sei Rumbia
12.22.02.2001|Perk. Perlabian
12.22.02.2002|Perk. Teluk Panji
12.22.02.2003|Perk. Tolan I/II
12.22.02.2004|Perk. Batang Saponggol
12.22.02.2005|Perk. Tolan
12.22.02.2006|Air Merah
12.22.02.2007|Teluk Panji
12.22.02.2008|Tanjung Medan
12.22.02.2009|Kampung Perlabian
12.22.02.2010|Tanjung Selamat
12.22.02.2011|Tanjung Mulia
12.22.02.2012|Teluk Panji I
12.22.02.2013|Teluk Panji II
12.22.02.2014|Teluk Panji III
12.22.02.2015|Teluk Panji IV
12.22.03.2001|Bangai
12.22.03.2002|Rasau
12.22.03.2003|Teluk Rampah
12.22.03.2004|Pangarungan
12.22.03.2005|Bunut
12.22.03.2006|Aek Batu
12.22.03.2007|Pinang Damai
12.22.03.2008|Aek Raso
12.22.03.2009|Torgamba
12.22.03.2010|Asam Jawa
12.22.03.2011|Torganda
12.22.03.2012|Beringin Jaya
12.22.03.2013|Bukit Tujuh
12.22.03.2014|Sei Meranti
12.22.04.1001|Langga Payung
12.22.04.2002|Batang Nadenggan
12.22.04.2003|Sabungan
12.22.04.2004|Hajoran
12.22.04.2005|Ujung Gading
12.22.04.2006|Huta Godang
12.22.04.2007|Parimburan
12.22.04.2008|Sampean
12.22.04.2009|Marsonja
12.22.05.2001|Mandalasena
12.22.05.2002|Binangadua
12.22.05.2003|Aek Goti
12.22.05.2004|Ulu Mahuam
12.22.05.2005|Rintis
12.22.05.2006|Sukadame
12.23.01.1001|Aek Kanopan
12.23.01.1002|Aek Kanopan Timur
12.23.01.2003|Kuala Beringin
12.23.01.2004|Parpaudangan
12.23.01.2005|Pulo Dogom
12.23.01.2006|Londut
12.23.01.2007|Perkebunan Kanopan Ulu
12.23.01.2008|Perkebunan Membang Muda
12.23.01.2009|Perkebunan Labuhan Haji
12.23.01.2010|Perkebunan Hanna
12.23.01.2011|Sonomartani
12.23.01.2012|Sukarame
12.23.01.2013|Sukarame Baru
12.23.02.1001|Tanjung Leidong
12.23.02.2002|Teluk Pulai Dalam
12.23.02.2003|Teluk Pulai Luar
12.23.02.2004|Kelapa Sebatang
12.23.02.2005|Simandulang
12.23.02.2006|Air Hitam
12.23.02.2007|Pangkalan Lunang
12.23.03.1001|Kampung Mesjid
12.23.03.2002|Kuala Bangka
12.23.03.2003|Sei Sentang
12.23.03.2004|Teluk Piai
12.23.03.2005|Tanjung Mangedar
12.23.03.2006|Teluk Binjai
12.23.03.2007|Sei Apung
12.23.04.2001|Aek Korsik
12.23.04.2002|Bandar Selamat
12.23.04.2003|Perk. Padang Halaban
12.23.04.2004|Perkebunan Panigoran
12.23.04.2005|Sidomulyo
12.23.04.2006|Karang Anyar
12.23.04.2007|Padang Maninjau
12.23.04.2008|Purworejo
12.23.05.1001|Marbau
12.23.05.2002|Perkebunan Pernantian
12.23.05.2003|Perk. Marbau Selatan
12.23.05.2004|Perkebunan Milano
12.23.05.2005|Perkebunan Brussel
12.23.05.2006|Pulo Bargot
12.23.05.2007|Sipare Pare Tengah
12.23.05.2008|Sipare Pare Hilir
12.23.05.2009|Tubiran
12.23.05.2010|Belongkut
12.23.05.2011|Simpang Empat
12.23.05.2012|Babussalam
12.23.05.2013|Marbau Selatan
12.23.05.2014|Aek Tapa
12.23.05.2015|Lobu Rampah
12.23.05.2016|Bulungihit
12.23.05.2017|Aek Hitetoras
12.23.05.2018|Sumber Mulyo
12.23.06.1001|Aek Kota Batu
12.23.06.2002|Pematang
12.23.06.2003|Batu Tunggal
12.23.06.2004|Sungai Raja
12.23.06.2005|Perkebunan Berangir
12.23.06.2006|Silumajang
12.23.06.2007|Pulo Jantan
12.23.06.2008|Kampung Pajak
12.23.06.2009|Meranti Omas
12.23.06.2010|Hatapang
12.23.06.2011|Pasang Lela
12.23.06.2012|Simpang Marbau
12.23.06.2013|Bangun Rejo
12.23.07.1001|Bandar Durian
12.23.07.2002|Poldung
12.23.07.2003|Rombisan
12.23.07.2004|Sibito
12.23.07.2005|Simonis
12.23.07.2006|Perk. Aek Pamienke
12.23.07.2007|Pangkalan
12.23.07.2008|Adian Torop
12.23.07.2009|Ujung Padang
12.23.07.2010|Kampung Yaman
12.23.07.2011|Terang Bulan
12.23.07.2012|Perkebunan Halimbe
12.23.08.1001|Gunting Saga
12.23.08.2002|Damuli Pekan
12.23.08.2003|Siamporik
12.23.08.2004|Lobu Huala
12.23.08.2005|Gunung Melayu
12.23.08.2006|Damuli Kebun
12.23.08.2007|Hasang
12.23.08.2008|Bandar Lama
12.23.08.2009|Sidua Dua
12.23.08.2010|Simangalam
12.23.08.2011|Tanjung Pasir
12.23.08.2012|Sialang Taji
12.24.01.2001|Hilidundra
12.24.01.2002|Lawira Satua
12.24.01.2003|Fadoro Fulolo
12.24.01.2004|Lawira I
12.24.01.2005|Hiligodu
12.24.01.2006|Lombuza'ua
12.24.01.2007|Maziaya
12.24.01.2008|Baho
12.24.01.2009|Lolofaoso
12.24.01.2010|Lawira II
12.24.01.2011|Dahadano
12.24.01.2012|Lolomboli
12.24.01.2013|Hiligeo Afia
12.24.02.2001|Seriwa'u
12.24.02.2002|Ombolata Sawo
12.24.02.2003|Sanawuyu
12.24.02.2004|Onozitoli Sawo
12.24.02.2005|Sifahandro
12.24.02.2006|Sisarahili Teluk Siabang
12.24.02.2007|Lasara Sawo
12.24.02.2008|Sawo
12.24.02.2009|Hiliduruwa
12.24.02.2010|Teluk Bengkuang
12.24.03.2001|Botolakha
12.24.03.2002|Siofa Banua
12.24.03.2003|La'aya
12.24.03.2004|Alo'oa
12.24.03.2005|Ladara
12.24.03.2006|Banua Gea
12.24.03.2007|Silima Banua
12.24.03.2008|Fino
12.24.04.2001|Tetehosi Maziaya
12.24.04.2002|Umbubalodano
12.24.04.2003|Hilimbosi
12.24.04.2004|Hilisalo'o
12.24.04.2005|Fulolo Salo'o
12.24.04.2006|Botombawo
12.24.05.2001|Berua
12.24.05.2002|Esiwa
12.24.05.2003|Dahana Hiligodu
12.24.05.2004|Hilibanua
12.24.05.2005|Sisarahili
12.24.05.2006|Sisobahili
12.24.05.2007|Lasara
12.24.05.2008|Namohalu
12.24.05.2009|Tuhenakhe I
12.24.05.2010|Orahili
12.24.05.2011|Banua Sibohou
12.24.06.2001|Banua Sibohou III
12.24.06.2002|Harefanaese
12.24.06.2003|Hilimbowo Kare
12.24.06.2004|Laehuwa
12.24.06.2005|Mazingo
12.24.06.2006|Hilina'a
12.24.07.2001|Bitaya
12.24.07.2002|Lahemboho
12.24.07.2003|Anaoma
12.24.07.2004|Dahana Tugala Oyo
12.24.07.2005|Fulolo
12.24.07.2006|Hiligawoni
12.24.07.2007|Ononamolo Tumula
12.24.07.2008|Banua Sibohou I
12.24.07.2009|Ombolata
12.24.07.2010|Banua Sibohou II
12.24.07.2011|Dahana Alasa
12.24.07.2012|Ononamolo Alasa
12.24.07.2013|Loloana'a
12.24.07.2014|Hilisebua Siwalubanua
12.24.08.2001|Te'olo
12.24.08.2002|Siwawo
12.24.08.2003|Fabaliwa Oyo
12.24.08.2004|Ononazara
12.24.08.2005|Humene Siheneasi
12.24.08.2006|Gunung Tua
12.24.08.2007|Botona'ai
12.24.08.2008|Harefa
12.24.09.2001|Afulu
12.24.09.2002|Lauru Fadoro
12.24.09.2003|Lauru I
12.24.09.2004|Ombolata Afulu
12.24.09.2005|Harewakhe
12.24.09.2006|Sisobahili
12.24.09.2007|Lauru Lahewa
12.24.09.2008|Sifaoro'asi
12.24.09.2009|Faekhuna'a
12.24.10.1001|Pasar Lahewa
12.24.10.2002|Iraono Lase
12.24.10.2003|Holi
12.24.10.2004|Sifaoro'asi
12.24.10.2005|Hilizukhu
12.24.10.2006|Onozalukhu
12.24.10.2007|Hilina'a
12.24.10.2008|Hiligodu Hoya
12.24.10.2009|Sitolubanua
12.24.10.2010|Hilihati
12.24.10.2011|Fadoro Sitolu Hili
12.24.10.2012|Marafala
12.24.10.2013|Hiligawolo
12.24.10.2014|Balefadoro Tuho
12.24.10.2015|Ombolata
12.24.10.2016|Afia
12.24.10.2017|Moawo
12.24.10.2018|Lasara
12.24.10.2019|Sihene'asi
12.24.10.2020|Fadoro Hilimbowo
12.24.10.2021|Fadoro Hilihambawa
12.24.11.2001|Laowowaga
12.24.11.2002|Lukhu Lase
12.24.11.2003|Tetehosi Sorowi
12.24.11.2004|Tefa'o
12.24.11.2005|Tugala Lauru
12.24.11.2006|Muzoi
12.24.11.2007|Meafu
12.25.01.2001|Sisobaoho
12.25.01.2002|Bawozamaiwo
12.25.01.2003|Sitolubanua
12.25.01.2004|Lologundre
12.25.01.2005|Iraonogaila
12.25.01.2006|Tigaserangkai
12.25.01.2007|Onowaembo
12.25.01.2008|Onolimbu
12.25.01.2009|Haliadulo
12.25.01.2010|Sisobambowo
12.25.01.2011|Lolowau
12.25.02.2001|Bawosaloo
12.25.02.2002|Imana
12.25.02.2003|Tuwa Tuwa
12.25.02.2004|Kafo Kafo
12.25.02.2005|Bawasawa
12.25.02.2006|Pulau Bogi
12.25.02.2007|Halamona
12.25.02.2008|Hanofa
12.25.02.2009|Lahawa
12.25.02.2010|Hinako
12.25.02.2011|Sineneeto
12.25.02.2012|Balowondrate
12.25.02.2013|Hilimberuanaa
12.25.02.2014|Lahusa
12.25.02.2015|Ombolata
12.25.02.2016|Tetehosi
12.25.02.2017|Togimbogi
12.25.02.2018|Sisobandrao
12.25.02.2019|Fadoro
12.25.02.2020|Tugala Gawu
12.25.02.2021|Sirombu
12.25.02.2022|Togideu
12.25.02.2023|Tugala
12.25.02.2024|Orahili
12.25.02.2025|Gunungcahaya
12.25.03.2001|Onolimbu Raya
12.25.03.2002|Ononamolo III
12.25.03.2003|Sisobaoho
12.25.03.2004|Iraonogeba
12.25.03.2005|Lolohia
12.25.03.2006|Fadorosifulubanua
12.25.03.2007|Hillidaura
12.25.03.2008|Sisarahili II
12.25.03.2009|Lasara Bagawu
12.25.03.2010|Sisobandrao
12.25.03.2011|Mazingo
12.25.03.2012|Onolimbu You
12.25.03.2013|Lasarafaga
12.25.03.2014|Orahili Badalu
12.25.04.2001|Hiliwaloo II
12.25.04.2002|Gunungbaru
12.25.04.2003|Hilisoromi
12.25.04.2004|Siduahili
12.25.04.2005|Sitolubanua Fadoro
12.25.04.2006|Halifadolo
12.25.04.2007|Lasara Bahili
12.25.04.2008|Hiliwaele
12.25.04.2009|Sitoluewali
12.25.04.2010|Onozalukhu You
12.25.05.2001|Simaeasi
12.25.05.2002|Lologolu
12.25.05.2003|Tuwuna
12.25.05.2004|Tuhemberua
12.25.05.2005|Lolozirugi
12.25.05.2006|Lakhene
12.25.05.2007|Hiliwaloo I
12.25.05.2008|Sianaa
12.25.05.2009|Fadoro
12.25.05.2010|Iraonogambo
12.25.05.2011|Tuhoowo
12.25.05.2012|Fadoro Bahili
12.25.05.2013|Tumori
12.25.05.2014|Lasara Baene
12.25.05.2015|Tetehosi
12.25.05.2016|Sisarahili I
12.25.05.2017|Doli-Doli
12.25.05.2018|Hayo
12.25.05.2019|Zuzundrao
12.25.05.2020|Sisobambowo
12.25.06.2001|Balodano
12.25.06.2002|Hiambanua
12.25.06.2003|Hilimayo
12.25.06.2004|Sihareo
12.25.06.2005|Lolomboli
12.25.06.2006|Ononamolo I
12.25.06.2007|Hilimbaruzo
12.25.06.2008|Tarahoso
12.25.06.2009|Ononamolo II
12.25.06.2010|Taraha
12.25.06.2011|Lahagu
12.25.06.2012|Hilimbowo
12.25.07.2001|Sisobawino II
12.25.07.2002|Duria
12.25.07.2003|Ambukha
12.25.07.2004|Hilimbowo Mau
12.25.07.2005|Hilimbuasi
12.25.07.2006|Lolofitu
12.25.07.2007|Hiliuso
12.25.07.2008|Wango
12.25.08.2001|Bukit Tinggi
12.25.08.2002|Lawelu
12.25.08.2003|Saloo
12.25.08.2004|Hilisangawola
12.25.08.2005|Hilibadalu
12.71.01.1001|Pasar Baru
12.71.01.1002|Pusat Pasar
12.71.01.1003|Sei Rengas I
12.71.01.1004|Mesjid
12.71.01.1005|Pandau Hulu I
12.71.01.1006|Kotamatsum III
12.71.01.1007|Pasar Merah Barat
12.71.01.1008|Teladan Timur
12.71.01.1009|Teladan Barat
12.71.01.1010|Sudirejo 1
12.71.01.1011|Sudirejo II
12.71.01.1012|Sitirejo I
12.71.02.1001|Lalang
12.71.02.1002|Sei Sikambing B
12.71.02.1003|Sunggal
12.71.02.1004|Babura Sunggal
12.71.02.1005|Tanjung Rejo
12.71.02.1006|Simpang Tanjung
12.71.03.1001|Helvetia
12.71.03.1002|Helvetia Tengah
12.71.03.1003|Helvetia Timur
12.71.03.1004|Tanjung Gusta
12.71.03.1005|Cinta Damai
12.71.03.1006|Dwi Kora
12.71.03.1007|Sei Sikambing C II
12.71.04.1001|Tegal S Mandala I
12.71.04.1002|Tegal S Mandala II
12.71.04.1003|Tegal S Mandala III
12.71.04.1004|Denai
12.71.04.1005|Binjai
12.71.04.1006|Medan Tenggara
12.71.05.1001|Kesawan
12.71.05.1002|Silalas
12.71.05.1003|Glugur Kota
12.71.05.1004|Pulo Berayan Kota
12.71.05.1005|Sei Agul
12.71.05.1006|Karang Berombak
12.71.06.1001|Titipapan
12.71.06.1002|Tanjung Mulia Hilir
12.71.06.1003|Tanjung Mulya
12.71.06.1004|Kota Bangun
12.71.06.1005|Mabar
12.71.06.1006|Mabar Hilir
12.71.07.1001|Tanjung Selamat
12.71.07.1002|Simpang Selayang
12.71.07.1003|Namo Gajah
12.71.07.1004|Kemenangan Tani
12.71.07.1005|Laucih
12.71.07.1006|Sidomulyo
12.71.07.1007|Ladang Bambu
12.71.07.1008|Simalingkar B
12.71.07.1009|Mangga
12.71.08.1001|Belawan I
12.71.08.1002|Belawan II
12.71.08.1003|Belawan Bahagia
12.71.08.1004|Belawan Bahari
12.71.08.1005|Belawan Sicanang
12.71.08.1006|Bagan Deli
12.71.09.1001|Amplas
12.71.09.1002|Sitirejo II
12.71.09.1003|Sitirejo III
12.71.09.1004|Harjosari I
12.71.09.1005|Harjosari II
12.71.09.1006|Timbang Deli
12.71.09.1007|Bangun Mulia
12.71.10.1001|Sukaramai I
12.71.10.1002|Sukaramai II
12.71.10.1003|Sei Rengas II
12.71.10.1004|S. Rengas Permata
12.71.10.1005|Pandau Hulu II
12.71.10.1006|Kota Matsum I
12.71.10.1007|Kota Matsum II
12.71.10.1008|Kota Matsum IV
12.71.10.1009|Pasar Merah Timur
12.71.10.1010|Tegal Sari I
12.71.10.1011|Tegal Sari II
12.71.10.1012|Tegal Sari III
12.71.11.1001|Suka Maju
12.71.11.1002|Titi Kuning
12.71.11.1003|Kedai Durian
12.71.11.1004|Pangkalan Mansur
12.71.11.1005|Gedung Johor
12.71.11.1006|Kwala Bekala
12.71.12.1001|Labuhan Deli
12.71.12.1002|Rengas Pulau
12.71.12.1003|Terjun
12.71.12.1004|Tanah Enam Ratus
12.71.12.1005|Paya Pasir
12.71.13.1001|Pekan Labuhan
12.71.13.1002|Sei Mati
12.71.13.1003|Besar
12.71.13.1004|Martubung
12.71.13.1005|Nelayan Indah
12.71.13.1006|Tangkahan
12.71.14.1001|Indra Kasih
12.71.14.1002|Sidorejo Hilir
12.71.14.1003|Sidorejo
12.71.14.1004|Bantan
12.71.14.1005|Tembung
12.71.14.1006|Bandar Selamat
12.71.14.1007|Bantan Timur
12.71.15.1001|Aur
12.71.15.1002|Hamdan
12.71.15.1003|Jati
12.71.15.1004|Sukaraja
12.71.15.1005|Sei Mati
12.71.15.1006|Kampung Baru
12.71.16.1001|Madras Hulu
12.71.16.1002|Polonia
12.71.16.1003|Sari Rejo
12.71.16.1004|Suka Damai
12.71.16.1005|Anggrung
12.71.17.1001|Petisah Hulu
12.71.17.1002|Babura
12.71.17.1003|Merdeka
12.71.17.1004|Darat
12.71.17.1005|Padang Bulan
12.71.17.1006|Titi Rante
12.71.18.1001|Pandau Hilir
12.71.18.1002|Pahlawan
12.71.18.1003|Sei Kera Hilir I
12.71.18.1004|Sei Kera Hilir II
12.71.18.1005|Sei Kera Hulu
12.71.18.1006|Sidorame Timur
12.71.18.1007|Sidorame Barat I
12.71.18.1008|Sidorame Barat II
12.71.18.1009|Tegalrejo
12.71.19.1001|Petisah Tengah
12.71.19.1002|Sekip
12.71.19.1003|Sei Sikambing D
12.71.19.1004|Sei Putih Barat
12.71.19.1005|Sei Putih Tengah
12.71.19.1006|Sei Putih Timur I
12.71.19.1007|Sei Putih Timur II
12.71.20.1001|Gang Buntu
12.71.20.1002|Sidodadi
12.71.20.1003|Durian
12.71.20.1004|Glugur Darat I
12.71.20.1005|Glugur Darat II
12.71.20.1006|P Berayan Darat I
12.71.20.1007|P Berayan Darat II
12.71.20.1008|P Berayan Bengkel
12.71.20.1009|PB Bengkel Baru
12.71.20.1010|Perintis
12.71.20.1011|Gaharu
12.71.21.1001|Asam Kumbang
12.71.21.1002|Tanjungsari
12.71.21.1003|P Bulan Selayang II
12.71.21.1004|Beringin
12.71.21.1005|P Bulan Selayang I
12.71.21.1006|Sempakata
12.72.01.1001|Kebun Sayur
12.72.01.1002|Tomuan
12.72.01.1003|Pahlawan
12.72.01.1004|Asuhan
12.72.01.1005|Merdeka
12.72.01.1006|Pardomuan
12.72.01.1007|Siopat Suhu
12.72.02.1001|Dwikora
12.72.02.1002|Proklamasi
12.72.02.1003|Bantan
12.72.02.1004|Timbang Galung
12.72.02.1005|Simarito
12.72.02.1006|Sipinggolpinggol
12.72.02.1007|Banjar
12.72.02.1008|Teladan
12.72.03.1001|Melayu
12.72.03.1002|Martoba
12.72.03.1003|Baru
12.72.03.1004|Sukadame
12.72.03.1005|Kahean
12.72.03.1006|Sigulanggulang
12.72.03.1007|Bane
12.72.04.1001|Toba
12.72.04.1002|Karo
12.72.04.1003|Simalungun
12.72.04.1004|Martimbang
12.72.04.1005|Kristen
12.72.04.1006|Aek Nauli
12.72.05.1002|Sukaraja
12.72.05.1005|Baringin Pancur Nauli
12.72.05.1006|Pardamean
12.72.05.1007|Sukamaju
12.72.05.1008|Parhorasan Nauli
12.72.05.1009|Sukamakmur
12.72.05.1010|Mekar Nauli
12.72.06.1001|Sumber Jaya
12.72.06.1003|Tambun Nabolon
12.72.06.1007|Naga Pita
12.72.06.1008|Pondok Sayur
12.72.06.1009|Tanjung Tongah
12.72.06.1010|Naga Pitu
12.72.06.1011|Tanjung Pinggir
12.72.07.1001|Gurilla
12.72.07.1002|Bah Kapul
12.72.07.1003|Setia Negara
12.72.07.1004|Bukit Sofa
12.72.07.1005|Bah Sorma
12.72.08.1001|Simarimbun
12.72.08.1002|Tong Marimbun
12.72.08.1003|Naga Huta
12.72.08.1004|Naga Huta Timur
12.72.08.1005|Pematang Marihat
12.72.08.1006|Marihat Jaya
12.73.01.1001|Huta Barangan
12.73.01.1002|Angin Nauli
12.73.01.1003|Huta Tonga-tonga
12.73.01.1004|Sibolga Ilir
12.73.01.1005|Simare-Mare
12.73.02.1001|Kota Baringin
12.73.02.1002|Pasar Baru
12.73.02.1003|Pasar Belakang
12.73.02.1004|Pancuran Gerobak
12.73.03.1001|Aek Habil
12.73.03.1002|Aek Manis
12.73.03.1003|Aek Muara Pinang
12.73.03.1004|Aek Parombunan
12.73.04.1001|Pancuran Kerambil
12.73.04.1002|Pancuran Dewa
12.73.04.1003|Pancuran Pinang
12.73.04.1004|Pancuran Bambu
12.74.01.1001|Tanjungbalai Kota I
12.74.01.1002|Tanjungbalai Kota II
12.74.01.1003|Perwira
12.74.01.1004|Karya
12.74.01.1005|Pantai Burung
12.74.01.1006|Indra Sakti
12.74.02.1001|Tanjungbalai Kota III
12.74.02.1002|Tanjungbalai Kota IV
12.74.02.1003|Sejahtera
12.74.02.1004|Kuala Silo Bestari
12.74.02.1005|Matahalasan
12.74.03.1001|Keramat Kubah
12.74.03.1002|Sumber Sari
12.74.03.1003|Muara Sentosa
12.74.03.1004|Pasar Baru
12.74.03.1005|Sei Raja
12.74.04.1001|Sei Merbau
12.74.04.1002|Pematang Pasir
12.74.04.1003|Perjuangan
12.74.04.1004|Kapias Pulau Buaya
12.74.04.1005|Beting Kuala Kapias
12.74.05.1003|Gading
12.74.05.1004|Sirantau
12.74.05.1005|Sijambi
12.74.05.1006|Pahang
12.74.05.1010|Pantai Johor
12.74.06.1001|Pulau Simardan
12.74.06.1002|Semula Jadi
12.74.06.1003|Selat Lancang
12.74.06.1004|Bunga Tanjung
12.74.06.1005|Selat Tanjung Medan
12.75.01.1001|Pahlawan
12.75.01.1002|Jati Negara
12.75.01.1003|Nangka
12.75.01.1004|Damai
12.75.01.1005|Kebun Lada
12.75.01.1006|Cengkeh Turi
12.75.01.1007|Jati Utomo
12.75.01.1008|Jati Makmur
12.75.01.1009|Jati Karya
12.75.02.1001|Berngam
12.75.02.1002|Satria
12.75.02.1003|Setia
12.75.02.1004|Kartini
12.75.02.1005|Tangsi
12.75.02.1006|Binjai
12.75.02.1007|Pekan Binjai
12.75.03.1001|Bandar Senembah
12.75.03.1002|Limau Mungkur
12.75.03.1003|Limau Sundai
12.75.03.1004|Paya Roba
12.75.03.1005|Suka Maju
12.75.03.1006|Sukaramai
12.75.04.1001|Tanah Tinggi
12.75.04.1002|Dataran Tinggi
12.75.04.1003|Timbang Langkat
12.75.04.1004|Mencirim
12.75.04.1005|Tunggurono
12.75.04.1006|Sumber Mulyorejo
12.75.04.1007|Sumber Karya
12.75.05.1001|Tanah Merah
12.75.05.1002|Binjai Estate
12.75.05.1003|Bhakti Karya
12.75.05.1004|Rambung Dalam
12.75.05.1005|Pujidadi
12.75.05.1006|Tanah Seribu
12.75.05.1007|Rambung Barat
12.75.05.1008|Rambung Timur
12.76.01.1001|Pabatu
12.76.01.1002|Lubuk Baru
12.76.01.1006|Persiakan
12.76.01.1007|Bandar Sono
12.76.01.1010|Tualang
12.76.01.1011|Padang Merbau
12.76.01.1012|Lubuk Raya
12.76.02.1004|Rantau Laban
12.76.02.1007|Karya Jaya
12.76.02.1009|Lalang
12.76.02.1010|Tanjung Marulak
12.76.02.1011|Sri Padang
12.76.02.1012|Tanjung Marulak Hilir
12.76.02.1013|Mekar Sentosa
12.76.03.1001|Bagelen
12.76.03.1002|Tambangan
12.76.03.1004|Tebing Tinggi
12.76.03.1006|Satria
12.76.03.1007|Damar Sari
12.76.03.1008|Tambangan Hulu
12.76.03.1009|Deblod Sundoro
12.76.04.1001|Durian
12.76.04.1002|Pelita
12.76.04.1003|Bulian
12.76.04.1004|Berohol
12.76.04.1005|Bandar Sakti
12.76.04.1006|Pinang Mancung
12.76.04.1007|Teluk Karang
12.76.05.1001|Mandailing
12.76.05.1002|Pasar Baru
12.76.05.1003|Pasar Gambir
12.76.05.1004|Badak Bejuang
12.76.05.1005|Bandar Utama
12.76.05.1006|Rambung
12.76.05.1007|Tebing Tinggi Lama
12.77.01.1001|Wek I
12.77.01.1002|Wek II
12.77.01.1003|Wek III
12.77.01.1004|Wek IV
12.77.01.1005|Tanobato
12.77.01.1006|Tobat
12.77.01.1007|Batang Ayumi Jae
12.77.01.1008|Batang Ayumi Julu
12.77.01.1009|Sadabuan
12.77.01.1010|Panyanggar
12.77.01.1011|Bonan Dolok
12.77.01.1012|Losung Batu
12.77.01.1013|Timbangan
12.77.01.1014|Bincar
12.77.01.1015|Kantin
12.77.01.1016|Kayu Ombun
12.77.02.1001|Wek V
12.77.02.1002|Wek VI
12.77.02.1003|Losung
12.77.02.1004|Sitamiang
12.77.02.1005|Ujung Padang
12.77.02.1006|Aek Tampang
12.77.02.1007|Padang Matinggi
12.77.02.1008|Silandit
12.77.02.1009|Sidangkal
12.77.02.1010|Hanopan
12.77.02.1011|Padang Matinggi Lestari
12.77.02.1012|Sitamiang Baru
12.77.03.1001|Batunadua Jae
12.77.03.1002|Batunadua Julu
12.77.03.2003|Purwodadi
12.77.03.2004|Gunung Hasahatan
12.77.03.2005|Ujunggurap
12.77.03.2006|Aek Tuhul
12.77.03.2007|Baruas
12.77.03.2008|Siloting
12.77.03.2009|Aek Bayur
12.77.03.2010|Pudun Jae
12.77.03.2011|Pudun Julu
12.77.03.2012|Batang Bahal
12.77.03.2013|Aek Najaji
12.77.03.2014|Simirik
12.77.03.2015|Bargottopong
12.77.04.1001|Hutaimbaru
12.77.04.1002|Lubuk Raya
12.77.04.1003|Sabungan Jae
12.77.04.1004|Lembah Lubuk Manik
12.77.04.1005|Palopat Maria
12.77.04.2006|Sabungan Sipabangun
12.77.04.2007|Singali
12.77.04.2008|Huta Padang
12.77.04.2009|Partihaman Saroha
12.77.04.2010|Tinjoman Lama
12.77.05.1001|Sihitang
12.77.05.1002|Pijor Koling
12.77.05.2003|Palopat Pijor Koling
12.77.05.2004|Salambue
12.77.05.2005|Purbatua Pijor Koling
12.77.05.2006|Sigulang
12.77.05.2007|Manunggang Julu
12.77.05.2008|Goti
12.77.05.2009|Manegen
12.77.05.2010|Huta Koje
12.77.05.2011|Hutalimbong
12.77.05.2012|Huta Padang
12.77.05.2013|Perkebunan Pijor Koling
12.77.05.2014|Labuhan Labo
12.77.05.2015|Huta Lombang
12.77.05.2016|Manunggang Jae
12.77.05.2017|Labuhan Rasoki
12.77.05.2018|Tarutung Baru
12.77.06.2001|Joring Lombang
12.77.06.2002|Batu Layan
12.77.06.2003|Simasom
12.77.06.2004|Pintu Langit Jae
12.77.06.2005|Mompang
12.77.06.2006|Rimba Soping
12.77.06.2007|Simatohir
12.77.06.2008|Joring Natobang
12.78.01.1030|Pasar Gunungsitoli
12.78.01.1031|Saombo
12.78.01.1032|Ilir
12.78.01.2001|Bawodesolo
12.78.01.2002|Boyo
12.78.01.2003|Dahadano Gawu-Gawu
12.78.01.2004|Dahana Tabaloho
12.78.01.2005|Fadoro Lasara
12.78.01.2006|Hilihao
12.78.01.2007|Hilimbaruzo
12.78.01.2008|Hilina'a
12.78.01.2009|Iraonogeba
12.78.01.2010|Lasara Bahili
12.78.01.2011|Lolowonu Niko'otano
12.78.01.2012|Madula
12.78.01.2013|Madolaoli
12.78.01.2014|Mudik
12.78.01.2015|Miga
12.78.01.2016|Mo'awo
12.78.01.2017|Ombolata Ulu
12.78.01.2018|Onowaembo
12.78.01.2019|Onozitoli Olora
12.78.01.2020|Onozitoli Sifaoroasi
12.78.01.2021|Saewe
12.78.01.2022|Sifalaete Tabaloho
12.78.01.2023|Sifalaete Ulu
12.78.01.2024|Sihare'o II Tabaloho
12.78.01.2025|Simandraolo
12.78.01.2026|Sisarahiligamo
12.78.01.2027|Sisarahili Sisambualahe
12.78.01.2028|Sisobahili Tabaloho
12.78.01.2029|Tuhemberua Ulu
12.78.02.2001|Ononamolo I Lot
12.78.02.2002|Fodo
12.78.02.2003|Faekhu
12.78.02.2004|Lolofaoso Tabaloho
12.78.02.2005|Lolomboli
12.78.02.2006|Mazingo Tabaloho
12.78.02.2007|Onozitoli Tabaloho
12.78.02.2008|Lololakha
12.78.02.2009|Sihare'o I Tabaloho
12.78.02.2010|Ombolata Simenari
12.78.02.2011|Hiligara
12.78.02.2012|Luahalaraga
12.78.02.2013|Sisobahili II Tanose'o
12.78.02.2014|Hiligodu Ombolata
12.78.02.2015|Tetehosi Ombolata
12.78.03.2001|Afia
12.78.03.2002|Lolo'ana'a Lolomoyo
12.78.03.2003|Lasara Sowu
12.78.03.2004|Telukbelukar
12.78.03.2005|Tetehosi Afia
12.78.03.2006|Hambawa
12.78.03.2007|Gawu-Gawu Bo'uso
12.78.03.2008|Olora
12.78.03.2009|Hilimbowo Olora
12.78.03.2010|Hiligodu Ulu
12.78.04.2001|Sifalaete
12.78.04.2002|Hilimbawodesolo
12.78.04.2003|Dahana
12.78.04.2004|Bawodesolo
12.78.04.2005|Tuhegeo I
12.78.04.2006|Simanaere
12.78.04.2007|Humene
12.78.04.2008|Siwalubanua II
12.78.04.2009|Helefanikha
12.78.04.2010|Tetehosi I
12.78.04.2011|Fowa
12.78.04.2012|Binaka
12.78.04.2013|Idanotae
12.78.04.2014|Tetehosi II
12.78.04.2015|Lolo'ana'a Idanoi
12.78.04.2016|Siwalubanua I
12.78.04.2017|Hilihambawa
12.78.04.2018|Awa'ai
12.78.04.2019|Lewuoguru Idanoi
12.78.04.2020|Fadoro
12.78.04.2021|Hiliweto Idanoi
12.78.04.2022|Hilimbowo Idanoi
12.78.04.2023|Onowaembo
12.78.04.2024|Ombolata
12.78.04.2025|Samasi
12.78.04.2026|Tuhegeo II
12.78.05.2001|Nazalou Alo'oa
12.78.05.2002|Niko'otano Dao
12.78.05.2003|Iraonolase
12.78.05.2004|Orahili Tanose'o
12.78.05.2005|Tarakhaini
12.78.05.2006|Fadoro Hilimbowo
12.78.05.2007|Fadoro You
12.78.05.2008|Lololawa
12.78.05.2009|Nazalou Lolowua
12.78.06.2001|Tumori
12.78.06.2002|Tumori Balohili
12.78.06.2003|Orahili Tumori
12.78.06.2004|Gada
12.78.06.2005|Lolomoyo Tuhemberua
12.78.06.2006|Sihare'o Siwahili
12.78.06.2007|Hilinakhe
12.78.06.2008|Onozikho
12.78.06.2009|Ononamolo II Lot
13.01.01.2001|Inderapura
13.01.01.2002|Muaro Sakai Inderapura
13.01.01.2003|Tiga Sepakat Inderapura
13.01.01.2004|Inderapura Barat
13.01.01.2005|Kudo-Kudo Inderapura
13.01.01.2006|Inderapura Selatan
13.01.01.2009|Simpang Lama Inderapura
13.01.01.2010|Tigo Sungai Inderapura
13.01.01.2011|Tluk Amplu Inderapura
13.01.01.2012|Inderapura Tengah
13.01.02.2001|Pelangai
13.01.02.2002|Sungai Tunu
13.01.02.2003|Sungai Tunu Utara
13.01.02.2004|Sungai Tunu Barat
13.01.02.2005|Nyiur Melambai Pelangai
13.01.02.2006|Sungai Liku Pelangai
13.01.02.2007|Koto VIII Pelangai
13.01.02.2008|Pelangai Gadang
13.01.02.2009|Pelangai Kaciak
13.01.02.2010|Pasia Pelangai
13.01.03.2001|Kambang
13.01.03.2002|Lakitan
13.01.03.2003|Kambang Utara
13.01.03.2004|Kambang Timur
13.01.03.2005|Kambang Barat
13.01.03.2006|Lakitan Utara
13.01.03.2007|Lakitan Selatan
13.01.03.2008|Lakitan Timur
13.01.03.2009|Lakitan Tengah
13.01.04.2001|IV Koto Hilie
13.01.04.2002|IV Koto Mudiek
13.01.04.2003|Taluak
13.01.04.2004|Koto Nan Duo IV Koto Hilie
13.01.04.2005|Koto Nan Tigo IV Koto Hilie
13.01.04.2006|Teratak Tempatih IV Koto Mudiek
13.01.04.2007|Tuik IV Koto Mudiek
13.01.04.2008|Sungai Nyalo IV Koto Mudiek
13.01.04.2009|Taluk Tigo Sakato
13.01.05.2001|Painan
13.01.05.2002|Tambang
13.01.05.2003|Salido
13.01.05.2004|Lumpo
13.01.05.2005|Bunga Pasang Salido
13.01.05.2006|Sago Salido
13.01.05.2007|Salido Sari Bulan
13.01.05.2008|Koto Rawang
13.01.05.2009|Limau Gadang Lumpo
13.01.05.2010|Batu Kunik Lumpo
13.01.05.2011|Taratak Tangah Lumpo
13.01.05.2012|Ampuan Lumpo
13.01.05.2013|Ampang Tareh Lumpo
13.01.05.2014|Balai Sinayan Lumpo
13.01.05.2015|Sungai Gayo Lumpo
13.01.05.2016|Sungai Sariak Lumpo
13.01.05.2017|Bukik Kaciak Lumpo
13.01.05.2018|Gunung Bungkuak Lumpo
13.01.05.2019|Painan Selatan Painan
13.01.05.2020|Painan Timur Painan
13.01.06.2005|Koto Berapak
13.01.06.2006|Talaok
13.01.06.2007|Pasar Baru
13.01.06.2008|Gurun Panjang
13.01.06.2009|Api-api Pasar Baru
13.01.06.2010|Tanjung Durian Pasar Baru
13.01.06.2011|Asam Kamba Pasar Baru
13.01.06.2012|Sawah Laweh Pasar Baru
13.01.06.2013|Kapeh Panji Jaya Talaok
13.01.06.2014|Aur Begalung Talaok
13.01.06.2015|Kapelgam Koto Berapak
13.01.06.2016|Koto Baru Koto Berapak
13.01.06.2017|Kubang Koto Berapak
13.01.06.2018|Kapujan Koto Berapak
13.01.06.2019|Gurun Panjang Utara
13.01.06.2020|Gurun Panjang Barat
13.01.06.2021|Gurun Panjang Selatan
13.01.07.2001|Siguntur
13.01.07.2002|Sungai Pinang
13.01.07.2003|Duku
13.01.07.2004|Batu Hampa
13.01.07.2005|Nanggalo
13.01.07.2006|Ampang Pulai
13.01.07.2007|Kapuh
13.01.07.2008|Barung-Barung Balantai
13.01.07.2009|Barung-Barung Balantai Selatan
13.01.07.2010|Mandeh
13.01.07.2011|Kapuah Utara
13.01.07.2012|Taratak Sungai Lundang
13.01.07.2013|Siguntur Tua
13.01.07.2014|Kampung Baru Korong Nan Ampek
13.01.07.2015|Duku Utara
13.01.07.2016|Pulau Karam Ampang Pulai
13.01.07.2017|Jinang Kampung Pansur Ampang Pulai
13.01.07.2018|Cerocok Anau Ampang Pulai
13.01.07.2019|Sungai Nyalo Mudiak Aia
13.01.07.2020|Batu Hampar Selatan
13.01.07.2021|Barung-Barung Balantai Timur
13.01.07.2022|Barung-Barung Balantai Tengah
13.01.07.2023|Setara Nanggalo
13.01.08.2001|Taratak
13.01.08.2002|Surantih
13.01.08.2003|Amping Parak
13.01.08.2004|Amping Parak Timur
13.01.08.2005|Koto Taratak
13.01.08.2006|Lansano Taratak
13.01.08.2007|Aur Duri Surantih
13.01.08.2008|Rawang Gunung Malelo Surantih
13.01.08.2009|Koto Nan Tigo Selatan Surantih
13.01.08.2010|Koto Nan Tigo Utara Surantih
13.01.08.2011|Ganting Mudiak Selatan Surantih
13.01.08.2012|Ganting Mudiak Utara Surantih
13.01.09.2001|Punggasan
13.01.09.2002|Air Haji
13.01.09.2003|Punggasan Utara
13.01.09.2004|Punggasan Timur
13.01.09.2005|Padang XI Punggasan
13.01.09.2006|Lagan Mudik Punggasan
13.01.09.2007|Lagan Hilir Punggasan
13.01.09.2008|Air Haji Tenggara
13.01.09.2009|Pasar Lama Muara Air Haji
13.01.09.2010|Pasar Bukit Air Haji
13.01.09.2011|Air Haji Barat
13.01.09.2012|Air Haji Tengah
13.01.09.2013|Rantau Simalenang Air Haji
13.01.09.2014|Muara Gadang Air Haji
13.01.09.2015|Sungai Sirah Air Haji
13.01.09.2016|Muara Kandis Punggasan
13.01.10.2001|Lunang
13.01.10.2003|Lunang Utara
13.01.10.2004|Lunang Selatan
13.01.10.2005|Lunang Barat
13.01.10.2015|Sindang Lunang
13.01.10.2016|Pondok Parian Lunang
13.01.10.2017|Lunang Tengah
13.01.10.2018|Lunang Satu
13.01.10.2019|Lunang Dua
13.01.10.2020|Lunang Tiga
13.01.11.2001|Tapan
13.01.11.2002|Pasar Tapan
13.01.11.2007|Batang Arah Tapan
13.01.11.2008|Ampang Tulak Tapan
13.01.11.2009|Tanjung Pondok Tapan
13.01.11.2010|Batang Betung Tapan
13.01.11.2016|Bukit Buai Tapan
13.01.11.2017|Riak Danau Tapan
13.01.11.2018|Koto Anau Tapan
13.01.11.2019|Dusun Baru Tapan
13.01.12.2001|Puluik-Puluik
13.01.12.2002|Koto Ranah
13.01.12.2003|Muaro Aie
13.01.12.2004|Pancuang Taba
13.01.12.2005|Puluik-Puluik Selatan
13.01.12.2006|Limau Gadang Pancung Taba
13.01.13.2001|Inderapura Utara
13.01.13.2002|Muara Inderapura
13.01.13.2003|Damar Lapan Batang Inderapura
13.01.13.2004|Lalang Panjang Inderapura
13.01.13.2005|Palokan Inderapura
13.01.13.2006|Lubuk Betung Inderapura
13.01.13.2007|Tluk Kualo Inderapura
13.01.13.2008|Tanah Bakali Inderapura
13.01.13.2009|Inderapura Timur
13.01.13.2010|Pulau Rajo Inderapura
13.01.14.2001|Sungai Gambir Sako Tapan
13.01.14.2002|Limau Purut Tapan
13.01.14.2003|Talang Balarik Tapan
13.01.14.2004|Tebing Tinggi Tapan
13.01.14.2005|Binjai Tapan
13.01.14.2006|Sungai Pinang Tapan
13.01.14.2007|Talang Koto Pulai Tapan
13.01.14.2008|Kampung Tengah Tapan
13.01.14.2009|Kubu Tapan
13.01.14.2010|Simpang Gunung Tapan
13.01.15.2001|Silaut
13.01.15.2002|Sungai Sirah
13.01.15.2003|Sungai Sarik
13.01.15.2004|Sungai Pulai
13.01.15.2005|Pasir Binjai
13.01.15.2006|Talang Binjai
13.01.15.2007|Durian Seribu
13.01.15.2008|Lubuk Bunta
13.01.15.2009|Air Hitam
13.01.15.2010|Sambungo
13.02.03.2001|Lolo
13.02.03.2002|Surian
13.02.04.2001|Alahan Panjang
13.02.04.2002|Sungai Nanam
13.02.04.2003|Salimpat
13.02.04.2004|Aie Dingin
13.02.05.2001|Supayang
13.02.05.2002|Sirukam
13.02.05.2003|Aie Luo
13.02.06.2001|Batu Banyak
13.02.06.2002|Batu Bajanjang
13.02.06.2003|Koto Laweh
13.02.06.2004|Limau Lunggo
13.02.06.2005|Koto Gadang Koto Anau
13.02.06.2006|Selayo Tanang B. Sileh
13.02.07.2001|Cupak
13.02.07.2002|Talang
13.02.07.2003|Koto Gadang Guguak
13.02.07.2004|Jawi Jawi
13.02.07.2005|Sungai Janiah
13.02.07.2006|Batang Barus
13.02.07.2007|Aie Batumbuak
13.02.07.2008|Koto Gaek Guguk
13.02.08.2001|Muaro Paneh
13.02.08.2002|Kinari
13.02.08.2003|Bukit Tandang
13.02.08.2004|Parambahan
13.02.08.2005|Dilam
13.02.09.2001|Taruang-Taruang
13.02.09.2002|Siaro-Aro
13.02.09.2003|Pianggu
13.02.09.2004|Sungai Durian
13.02.09.2005|Bukik Bais
13.02.09.2006|Sungai Jambur
13.02.09.2007|Guguak Sarai
13.02.09.2008|Koto Laweh
13.02.09.2009|Indudur
13.02.10.2001|Koto Baru
13.02.10.2002|Selayo
13.02.10.2003|Panyakalan
13.02.10.2004|Gaung
13.02.10.2005|Gantuang Ciri
13.02.10.2006|Saok Laweh
13.02.10.2007|Koto Hilalang
13.02.10.2008|Tanjung Bingkung
13.02.11.2001|Sumani
13.02.11.2002|Tikalak
13.02.11.2003|Koto Sani
13.02.11.2004|Singkarak
13.02.11.2005|Aripan
13.02.11.2006|Kacang
13.02.11.2007|Tanjung Alai
13.02.11.2008|Saniangbaka
13.02.12.2001|Sulit Air
13.02.12.2002|Tanjung Balik
13.02.12.2003|Paninjauan
13.02.12.2004|Kuncir
13.02.12.2005|Katialo
13.02.12.2006|Pasilihan
13.02.12.2007|Bukit Kanduang
13.02.12.2008|Sibarambang
13.02.12.2009|Labuh Panjang
13.02.13.2001|Paninggahan
13.02.13.2002|Muaro Pingai
13.02.17.2001|Talang Babungo
13.02.17.2002|Sariak Alahan Tigo
13.02.17.2003|Sungai Abu
13.02.18.2001|Rangkiang Luluih
13.02.18.2002|Batu Bajanjang
13.02.18.2003|Garabak Data
13.02.18.2004|Tanjung Balik Sumiso
13.02.18.2005|Simanau
13.02.19.2001|Simpang Tj. Nan IV
13.02.19.2002|Kampung Batu Dalam
13.03.03.2001|Timbulun
13.03.03.2002|Tanjung Gadang
13.03.03.2003|Taratak Baru
13.03.03.2004|Pulasan
13.03.03.2005|Langki
13.03.03.2006|Sibakur
13.03.03.2007|Tanjung Lolo
13.03.03.2008|Taratak Baru Utara
13.03.03.2009|Sinyamu
13.03.04.2001|Muaro
13.03.04.2002|Kandang Baru
13.03.04.2003|Silokek
13.03.04.2004|Pematang Panjang
13.03.04.2005|Solok Ambah
13.03.04.2006|Paru
13.03.04.2007|Durian Gadang
13.03.04.2008|Aie Angek
13.03.04.2009|Sijunjung
13.03.05.2001|Palangki
13.03.05.2002|Koto Baru
13.03.05.2003|Muaro Bodi
13.03.05.2004|Mundam Sakti
13.03.05.2005|Koto Tuo
13.03.06.2001|Sungai Lansek
13.03.06.2002|Kamang
13.03.06.2003|Muaro Takuang
13.03.06.2004|Aie Amo
13.03.06.2005|Sungai Batuang
13.03.06.2006|Kunangan Parik Rantang
13.03.06.2007|Tanjung Kaliang
13.03.06.2008|Padang Tarok
13.03.06.2009|Siaur
13.03.06.2010|Lubuk Tarantang
13.03.06.2011|Maloro
13.03.07.2001|Lubuak Tarok
13.03.07.2002|Lalan
13.03.07.2003|Buluah Kasok
13.03.07.2004|Kampung Dalam
13.03.07.2005|Silongo
13.03.07.2006|Latang
13.03.08.2001|Limo Koto
13.03.08.2002|Palaluar
13.03.08.2003|Guguak
13.03.08.2004|Padang Laweh
13.03.08.2005|Tanjung
13.03.08.2006|Bukit Bual
13.03.08.2007|Padang Laweh Selatan
13.03.09.2001|Silantai
13.03.09.2002|Sisawah
13.03.09.2003|Unggan
13.03.09.2004|Tanjung Bonai Aur
13.03.09.2005|Sumpur Kudus
13.03.09.2006|Tamparungo
13.03.09.2007|Kumanis
13.03.09.2008|Manganti
13.03.09.2009|Sumpur Kudus Selatan
13.03.09.2010|Tanjung Labuah
13.03.09.2011|Tanjung Bonai Aur Selatan
13.03.10.2001|Batu Manjulur
13.03.10.2002|Pamuatan
13.03.10.2003|Padang Sibusuk
13.03.10.2004|Desa Kampung Baru
13.04.01.2001|Tambangan
13.04.01.2002|Jaho
13.04.01.2003|Singgalang
13.04.01.2004|Paninjauan
13.04.01.2005|Panyalaian
13.04.01.2006|Koto Laweh
13.04.01.2007|Aie Angek
13.04.01.2008|Pandai Sikek
13.04.01.2009|Koto Baru
13.04.02.2001|Andaleh
13.04.02.2002|Sabu
13.04.02.2003|Batipuah Ateh
13.04.02.2004|Batipuah Baruah
13.04.02.2005|Gunuang Rajo
13.04.02.2006|Pitalah
13.04.02.2007|Tanjuang Barulak
13.04.02.2008|Bungo Tanjuang
13.04.03.2001|Simawang
13.04.03.2002|Balimbiang
13.04.03.2003|III Koto
13.04.03.2004|Padang Magek
13.04.03.2005|Rambatan
13.04.04.2001|Baringin
13.04.04.2002|Limo Kaum
13.04.04.2003|Parambahan
13.04.04.2004|Cubadak
13.04.04.2005|Labuh
13.04.05.2001|Tanjung Barulak
13.04.05.2002|Saruaso
13.04.05.2003|Koto Tangah
13.04.05.2004|Pagaruyung
13.04.06.2001|Taluk
13.04.06.2002|Buo
13.04.06.2003|Tigo Jangko
13.04.06.2004|Pangian
13.04.07.2001|Sungai Patai
13.04.07.2002|Andaleh Baruh Bukik
13.04.07.2003|Tanjung
13.04.07.2004|Sungayang
13.04.07.2005|Minang Kabau
13.04.08.2001|Simpuruik
13.04.08.2002|Sungai Tarab
13.04.08.2003|Gurun
13.04.08.2004|Talang Tangah
13.04.08.2005|Padang Laweh
13.04.08.2006|Pasie Laweh
13.04.08.2007|Koto Tuo
13.04.08.2008|Rao Rao
13.04.08.2009|Kumango
13.04.08.2010|Koto Baru
13.04.09.2001|Batu Basa
13.04.09.2002|Tabek
13.04.09.2003|Sawah Tangah
13.04.09.2004|Simabur
13.04.09.2005|Pariangan
13.04.09.2006|Sungai Jambu
13.04.10.2001|Sumanik
13.04.10.2002|Situmbuk
13.04.10.2003|Lawang Mandahiling
13.04.10.2004|Supayang
13.04.10.2005|Salimpaung
13.04.10.2006|Tabek Patah
13.04.11.2001|Atar
13.04.11.2002|Padang Ganting
13.04.12.2001|Tanjuang Alam
13.04.12.2002|Barulak
13.04.13.2001|Batu Bulek
13.04.13.2002|Balai Tangah
13.04.13.2003|Tanjuang Bonai
13.04.13.2004|Lubuak Jantan
13.04.13.2005|Tapi Selo
13.04.14.2001|Batu Taba
13.04.14.2002|Sumpur
13.04.14.2003|Padang Laweh Malalo
13.04.14.2004|Guguak Malalo
13.05.01.2001|Lubuk Alung
13.05.01.2002|Pungguang Kasiak Lubuk Alung
13.05.01.2003|Pasie Laweh Lubuk Alung
13.05.01.2004|Aie Tajun Lubuk Alung
13.05.01.2005|Sikabu Lubuk Alung
13.05.01.2006|Sungai Abang Lubuk Alung
13.05.01.2007|Singguliang Lubuk Alung
13.05.01.2008|Salibutan Lubuk Alung
13.05.01.2009|Nagari Balah Hilia Lubuk Alung
13.05.02.2001|Katapiang
13.05.02.2002|Kasang
13.05.02.2003|Sungai Buluah
13.05.02.2004|Buayan Lubuk Alung
13.05.02.2005|Sungai Buluah Timur
13.05.02.2006|Sungai Buluah Barat
13.05.02.2007|Sungai Buluah Utara
13.05.02.2008|Sungai Buluah Selatan
13.05.03.2001|Kapalo Koto
13.05.03.2002|Pauh Kambar
13.05.03.2003|Padang Bintungan
13.05.03.2004|Kurai Taji
13.05.03.2005|Sunua
13.05.03.2006|Padang Kandang Pulau Air Padang Bintungan
13.05.03.2007|Sunua Tengah
13.05.03.2008|Sunua Barat
13.05.03.2009|Kurai Taji Timur
13.05.04.2002|Sicincin
13.05.04.2003|Lubuk Pandan
13.05.04.2004|Sungai Asam
13.05.05.2001|Balah Aie
13.05.05.2002|Sungai Sariak
13.05.05.2003|Lurah Ampalu
13.05.05.2004|Lareh Nan Panjang
13.05.05.2005|Lareh Nan Panjang Selatan
13.05.05.2006|Lareh Nan Panjang Barat
13.05.05.2007|Bisati Sungai Sariak
13.05.05.2008|Ambuang Kapua Sungai Sariak
13.05.05.2009|Lareh Nan Panjang Sungai Sariak
13.05.05.2010|Limpato Sungai Sariak
13.05.05.2011|Balah Aie Utara
13.05.05.2012|Balah Aie Timur
13.05.06.2001|Campago
13.05.06.2002|Sikucua
13.05.06.2003|Campago Barat
13.05.06.2004|Campago Selatan
13.05.06.2005|Sikucua Utara
13.05.06.2006|Sikucua Timur
13.05.06.2007|Sikucua Tengah
13.05.06.2008|Sikucua Barat
13.05.07.2001|Kuranji Hulu
13.05.07.2002|Malai III Koto
13.05.07.2003|Batu Gadang Kuranji Hulu
13.05.07.2004|Sungai Sirah Kuranji Hulu
13.05.08.2001|Kuranji Hilir
13.05.08.2002|Pilubang
13.05.08.2003|Guguak Kuranji Hilir
13.05.08.2004|Koto Tinggi Kuranji Hilir
13.05.09.2001|III Koto Aur Malintang
13.05.09.2002|III Koto Aur Malintang Utara
13.05.09.2003|III Koto Aur Malintang Timur
13.05.09.2004|III Koto Aur Malintang Selatan
13.05.09.2005|Balai Baiak Malai III Koto
13.05.10.2001|Tapakih
13.05.10.2002|Ulakan
13.05.10.2003|Padang Toboh Ulakan
13.05.10.2004|Sungai Gimba Ulakan
13.05.10.2005|Seulayat Ulakan
13.05.10.2006|Manggopoh Palak Gadang Ulakan
13.05.10.2007|Sandi Ulakan
13.05.10.2008|Kampuang Gelapuang Ulakan
13.05.11.2001|Sintuak
13.05.11.2002|Toboh Gadang
13.05.11.2003|Toboh Gadang Selatan
13.05.11.2004|Toboh Gadang Barat
13.05.11.2005|Toboh Gadang Timur
13.05.12.2001|Koto Baru
13.05.12.2002|Koto Dalam
13.05.12.2003|Batu Kalang
13.05.12.2004|Koto Dalam Barat
13.05.12.2005|Koto Dalam Selatan
13.05.12.2006|Batu Kalang Utara
13.05.13.2001|Malai V Suku
13.05.13.2002|Gasan Gadang
13.05.13.2003|Malai V Suku Timur
13.05.14.2001|Kudu Gantiang
13.05.14.2002|Limau Puruik
13.05.14.2003|Gunung Padang Alai
13.05.14.2004|Kudu Gantiang Barat
13.05.15.2001|Kayu Tanam
13.05.15.2002|Guguak
13.05.15.2003|Anduriang
13.05.15.2004|Kapalo Hilalang
13.05.16.2001|Sungai Durian
13.05.16.2002|Tandikek
13.05.16.2003|Tandikek Utara
13.05.16.2004|Tandikek Selatan
13.05.16.2005|Tandikek Barat
13.05.16.2006|Kampuang Tanjuang Koto Mambang Sungai Durian
13.05.17.2001|Pakandangan
13.05.17.2002|Koto Tinggi
13.05.17.2003|Toboh Ketek
13.05.17.2004|Parit Malintang
13.05.17.2005|Gadur
13.06.01.2001|Tiku Selatan
13.06.01.2002|Tiku Utara
13.06.01.2003|Tiku Limo Jorong
13.06.01.2004|Durian Kapeh Darussalam
13.06.02.2001|Lubuk Basung
13.06.02.2002|Garagahan
13.06.02.2003|Kampung Pinang
13.06.02.2004|Kampung Tangah
13.06.02.2005|Manggopoh
13.06.03.2001|Tanjung Sani
13.06.03.2002|Sungai Batang
13.06.03.2003|Maninjau
13.06.03.2004|Bayua
13.06.03.2006|Koto Kaciak
13.06.03.2007|Duo Koto
13.06.03.2008|Koto Gadang Anam Koto
13.06.03.2009|Koto Malintang
13.06.03.2010|Paninjauan
13.06.03.2011|Dalko
13.06.04.2001|Matua Hilia
13.06.04.2002|Matua Mudiak
13.06.04.2003|Tigo Balai
13.06.04.2004|Lawang
13.06.04.2005|Parik Panjang
13.06.04.2006|Panta Pauah
13.06.05.2002|Sungai Landia
13.06.05.2003|Balingka
13.06.05.2004|Koto Tuo
13.06.05.2005|Guguak Tabek Sarojo
13.06.05.2006|Koto Panjang
13.06.05.2007|Sianok Anam Suku
13.06.05.2008|Koto Gadang
13.06.06.2001|Padang Lua
13.06.06.2002|Taluak Ampek Suku
13.06.06.2003|Pakan Sinayan
13.06.06.2004|Kubang Putiah
13.06.06.2005|Ladang Laweh
13.06.06.2006|Cingkariang
13.06.06.2007|Sungai Tanang
13.06.07.2001|Batu Taba
13.06.07.2002|Biaro Gadang
13.06.07.2003|Lambah
13.06.07.2004|Panampuang
13.06.07.2005|Ampang Gadang
13.06.07.2006|Pasia
13.06.07.2008|Balai Gurah
13.06.08.2001|Koto Tinggi
13.06.08.2002|Tabek Panjang
13.06.08.2004|Simarasok
13.06.08.2005|Padang Tarok
13.06.08.2006|Salo
13.06.08.2007|Koto Baru
13.06.08.2008|Sungai Cubadak
13.06.08.2009|Koto Gadang
13.06.09.2001|Koto Tangah
13.06.09.2003|Gadut
13.06.09.2004|Kapau
13.06.10.2001|Koto Rantang
13.06.10.2002|Pasia Laweh
13.06.10.2003|Pagadih
13.06.10.2004|Nan Tujuah
13.06.10.2005|Nan Limo
13.06.11.2001|Baringin
13.06.11.2002|Sipinang
13.06.11.2003|Sungai Puar
13.06.11.2004|Ampek Koto Palembayan
13.06.11.2005|Tigo Koto Silungkang
13.06.11.2006|Salareh Aia
13.06.11.2007|Salareh Aia Timur
13.06.11.2008|Salareh Aia Utara
13.06.11.2009|Salareh Aia Barat
13.06.12.2001|Padang Laweh
13.06.12.2002|Sungai Pua
13.06.12.2003|Batagak
13.06.12.2004|Batu Palano
13.06.12.2005|Sariak
13.06.13.2001|Batu Kambing
13.06.13.2002|Sitalang
13.06.13.2003|Bawan
13.06.13.2004|Sitanang
13.06.14.2001|Canduang Koto Laweh
13.06.14.2002|Lasi
13.06.14.2003|Bukik Batabuah
13.06.15.2001|Magek
13.06.15.2002|Kamang Hilia
13.06.15.2003|Kamang Mudiak
13.06.15.2004|Kamang Tangah Anam Suku
13.06.15.2005|Pauh Kamang Mudiak
13.06.16.2001|Malalak Utara
13.06.16.2002|Malalak Timur
13.06.16.2003|Malalak Selatan
13.06.16.2004|Malalak Barat
13.07.01.2001|Kurai
13.07.01.2002|Sungai Rimbang
13.07.01.2003|Tanjuang Bungo
13.07.01.2004|Suliki
13.07.01.2005|Limbanang
13.07.01.2006|Andiang
13.07.02.2001|Guguak VIII Koto
13.07.02.2002|VII Koto Talago
13.07.02.2003|Sungai Talang
13.07.02.2004|Kubang
13.07.02.2005|Simpang Sugiran
13.07.03.2001|Koto Baru Simalanggang
13.07.03.2002|Taeh Bukik
13.07.03.2003|Simalanggang
13.07.03.2004|Sungai Beringin
13.07.03.2005|Piobang
13.07.03.2006|Taeh Baruah
13.07.03.2007|Koto Tangah Simalanggang
13.07.04.2001|Tj. Haro Sikabu-kabu Pd. Panjang
13.07.04.2002|Mungo
13.07.04.2003|Sungai Kamuyang
13.07.04.2004|Andaleh
13.07.05.2001|Taram
13.07.05.2002|Solok Bio Bio
13.07.05.2003|Tarantang
13.07.05.2004|Bukik Limbuku
13.07.05.2005|Harau
13.07.05.2006|Batu Balang
13.07.05.2007|Sarilamak
13.07.05.2008|Gurun
13.07.05.2009|Lubuak Batingkok
13.07.05.2010|Koto Tuo
13.07.05.2011|Pilubang
13.07.06.2001|Manggilang
13.07.06.2002|Tanjuang Balik
13.07.06.2003|Gunuang Malintang
13.07.06.2004|Pangkalan
13.07.06.2005|Koto Alam
13.07.06.2006|Tanjung Pauh
13.07.07.2001|Muaro Paiti
13.07.07.2002|Koto Bangun
13.07.07.2003|Lubuak Alai
13.07.07.2004|Koto Lamo
13.07.07.2005|Durian Tinggi
13.07.07.2006|Sialang
13.07.07.2007|Galugua
13.07.08.2001|Pandam Gadang
13.07.08.2002|Koto Tinggi
13.07.08.2003|Talang Anau
13.07.09.2001|Labuah Gunuang
13.07.09.2002|Batu Payuang
13.07.09.2003|Ampalu
13.07.09.2004|Bukik Sikumpa
13.07.09.2005|Balai Panjang
13.07.09.2006|Halaban
13.07.09.2007|Tanjuang Gadang
13.07.09.2008|Sitanang
13.07.10.2001|Situjuah Batua
13.07.10.2002|Situjuah Ladang Laweh
13.07.10.2003|Tungka
13.07.10.2004|Situjuah Banda Dalam
13.07.10.2005|Situjuah Gadang
13.07.11.2001|Jopang Manganti
13.07.11.2002|Simpang Kapuak
13.07.11.2003|Mungka
13.07.11.2004|Talang Maur
13.07.11.2005|Sungai Antuan
13.07.12.2001|Maek
13.07.12.2002|Banja Loweh
13.07.12.2003|Baruah Gunuang
13.07.12.2004|Sungai Naniang
13.07.12.2005|Koto Tangah
13.07.13.2001|Sariak Laweh
13.07.13.2002|Koto Tangah Batu Ampa
13.07.13.2003|Batuhampar
13.07.13.2004|Suayan
13.07.13.2005|Sungai Balantiak
13.07.13.2006|Pauh Sangik
13.07.13.2007|Durian Gadang
13.08.04.2001|Limo Koto
13.08.04.2002|Koto Kaciak
13.08.04.2003|Ganggo Mudiak
13.08.04.2004|Ganggo Hilia
13.08.04.2007|Koto Kaciak Barat
13.08.05.2001|Tanjuang Baringin
13.08.05.2002|Jambak
13.08.05.2003|Durian Tinggi
13.08.05.2004|Pauah
13.08.05.2005|Aia Manggih
13.08.05.2006|Sundata
13.08.05.2007|Tanjuang Baringin Utara
13.08.05.2008|Tanjuang Baringin Selatan
13.08.05.2009|Aia Manggih Utara
13.08.05.2010|Aia Manggih Selatan
13.08.05.2011|Aia Manggih Barat
13.08.05.2012|Sundata Utara
13.08.05.2013|Sundata Selatan
13.08.07.2001|Panti
13.08.07.2003|Panti Timur
13.08.07.2004|Panti Selatan
13.08.07.2005|Panti Utara
13.08.08.2001|Muara Tais
13.08.08.2002|Lubuak Gadang
13.08.08.2005|Pintu Padang
13.08.08.2006|Muaro Tais Koto Gadang
13.08.12.2001|Simpang Tonang
13.08.12.2002|Cubadak
13.08.12.2003|Simpang Tonang Selatan
13.08.12.2004|Simpang Tonang Utara
13.08.12.2005|Cubadak Timur
13.08.12.2006|Cubadak Tengah
13.08.12.2007|Cubadak Barat
13.08.13.2001|Malampah
13.08.13.2002|Ladang Panjang
13.08.13.2003|Binjai
13.08.13.2004|Malampah Barat
13.08.13.2005|Ladang Panjang Barat
13.08.14.2002|Taruang Taruang
13.08.14.2005|Padang Mantinggi
13.08.14.2008|Taruang Taruang Selatan
13.08.14.2009|Taruang Taruang Utara
13.08.14.2010|Padang Mantinggi Utara
13.08.15.2001|Silayang
13.08.15.2002|Muaro Sungai Lolo
13.08.16.2001|Alahan Mati
13.08.16.2002|Simpang
13.08.16.2003|Alahan Mati Hilia
13.08.16.2004|Simpang Utara
13.08.17.2001|Padang Gelugur
13.08.17.2002|Sontang Cubadak
13.08.17.2003|Sitombol Padang Gelugua
13.08.17.2004|Bahagia Padang Gelugua
13.08.18.2001|Koto Nopan
13.08.18.2002|Koto Rajo
13.08.18.2003|Languang
13.08.19.2001|Lansek Kadok
13.08.19.2002|Lubuak Layang
13.08.19.2003|Tanjung Betung
13.08.19.2004|Lansek Kadok Barat
13.08.19.2005|Tanjung Betung Utara
13.08.19.2006|Tanjung Betung Timur
13.09.01.2007|Betumonga
13.09.01.2008|Silabu
13.09.01.2009|Saumanganya
13.09.02.2001|Bosua
13.09.02.2002|Beriulou
13.09.02.2003|Nemnemleleu
13.09.02.2004|Mara
13.09.02.2006|Sioban
13.09.02.2007|Matobe
13.09.02.2008|Saureinu
13.09.03.2002|Muara Siberut
13.09.03.2003|Maileppet
13.09.03.2004|Muntei
13.09.03.2005|Matotonan
13.09.03.2007|Madobag
13.09.04.2003|Bojakan
13.09.04.2004|Sotboyak
13.09.04.2005|Mongan Poula
13.09.04.2006|Muara Sikabaluan
13.09.04.2007|Sirilogui
13.09.04.2008|Malancan
13.09.05.2001|Simatalu
13.09.05.2002|Simalegi
13.09.05.2003|Sigapokna
13.09.06.2001|Katurei
13.09.06.2002|Sagulubbeg
13.09.06.2003|Pasakiat Taileleu
13.09.07.2001|Saibi Samukop
13.09.07.2002|Cimpungan
13.09.07.2003|Saliguma
13.09.08.2001|Betumonga
13.09.08.2002|Goisooinan
13.09.08.2003|Tuapejat
13.09.08.2004|Sido Makmur
13.09.08.2005|Bukit Pamewa
13.09.08.2006|Sipora Jaya
13.09.09.2001|Sikakap
13.09.09.2002|Taikako
13.09.09.2003|Matobe
13.09.10.2001|Sinaka
13.09.10.2002|Bulasat
13.09.10.2003|Malakopa
13.09.10.2004|Makalo
13.10.01.2002|Koto Baru
13.10.01.2003|Sialang Gaung
13.10.01.2005|Ampang Kuranji
13.10.01.2008|Koto Padang
13.10.02.2001|Sungai Dareh
13.10.02.2002|Tebing Tinggi
13.10.02.2006|Empat Koto Pulau Punjung
13.10.02.2007|Sungai Kambut
13.10.02.2008|Gunung Selasih
13.10.02.2009|Sikabau
13.10.03.2003|Sungai Rumbai
13.10.03.2004|Kurnia Koto Salak
13.10.03.2007|Sungai Rumbai Timur
13.10.03.2008|Kurnia Selatan
13.10.04.2001|Sitiung
13.10.04.2002|Siguntur
13.10.04.2004|Gunung Medan
13.10.04.2005|Sungai Duo
13.10.05.2001|Silago
13.10.05.2002|Lubuak Karak
13.10.05.2003|Koto Nan Empat Dibawuh
13.10.05.2004|Banai
13.10.06.2001|Timpeh
13.10.06.2002|Taratak Tinggi
13.10.06.2003|Tabek
13.10.06.2004|Panyubarangan
13.10.06.2005|Ranah Palabi
13.10.07.2001|Koto Salak
13.10.07.2002|Ampalu
13.10.07.2003|Padukuan
13.10.07.2004|Pulau Mainan
13.10.07.2005|Simalidu
13.10.08.2001|Tiumang
13.10.08.2002|Sungai Langkok
13.10.08.2003|Koto Beringin
13.10.08.2004|Sipangkur
13.10.09.2001|Padang Laweh
13.10.09.2002|Batu Rijal
13.10.09.2003|Muaro Sopan
13.10.09.2004|Sopan Jaya
13.10.10.2001|Sungai Limau
13.10.10.2002|Alahan Nan Tigo
13.10.10.2003|Lubuk Besar
13.10.10.2004|Tanjung Alam
13.10.10.2005|Sinamar
13.10.11.2001|Koto Besar
13.10.11.2002|Koto Tinggi
13.10.11.2003|Koto Gadang
13.10.11.2004|Bonjol
13.10.11.2005|Abai Siat
13.10.11.2006|Koto Laweh
13.10.11.2007|Koto Ranah
13.11.01.2001|Lubuk Gadang
13.11.01.2002|Lubuk Gadang Timur
13.11.01.2003|Lubuk Gadang Selatan
13.11.01.2004|Lubuk Gadang Utara
13.11.02.2001|Pasir Talang
13.11.02.2002|Koto Baru
13.11.02.2004|Sako Pasia Talang
13.11.02.2005|Pasar Muara Labuh
13.11.02.2006|Pulakek Koto Baru
13.11.02.2007|Bomas
13.11.02.2008|Sako Utara Pasia Talang
13.11.02.2009|Sako Selatan Pasia Talang
13.11.02.2010|Pasir Talang Barat
13.11.02.2011|Pasir Talang Timur
13.11.02.2012|Pasir Talang Selatan
13.11.03.2001|Pakan Rabaa
13.11.03.2002|Pakan Rabaa Timur
13.11.03.2003|Pakan Rabaa Utara
13.11.03.2004|Pakan Rabaa Tengah
13.11.04.2001|Lubuk Malako
13.11.04.2002|Bidar Alam
13.11.04.2004|Padang Air Dingin
13.11.04.2005|Padang Limau Sundai
13.11.04.2006|Padang Gantiang
13.11.05.2001|Abai
13.11.05.2002|Dusun Tangah
13.11.05.2003|Lubuk Ulang Aling
13.11.05.2004|Ranah Pantai Cermin
13.11.05.2005|Sitapus
13.11.05.2006|Lubuk Ulang Aling Selatan
13.11.05.2007|Lubuk Ulang Aling Tengah
13.11.06.2001|Alam Pauh Duo
13.11.06.2002|Kapau Alam Pauh Duo
13.11.06.2003|Luak Kapau Alam Pauh Duo
13.11.06.2004|Pauh Duo Nan Batigo
13.11.07.2001|Sungai Kunyit
13.11.07.2002|Talao Sungai Kunyit
13.11.07.2003|Sungai Kunyit Barat
13.11.07.2004|Talunan Maju
13.12.01.2001|Aia Bangih
13.12.02.2001|Ujung Gading
13.12.02.2002|Brastagi Ujung Gading
13.12.02.2003|Tampus Damai Ujung Gading
13.12.02.2004|Taluak Ambun Ujung Gading
13.12.02.2005|Koto Gunung Ujung Gading
13.12.02.2006|Koto Sawah Ujung Gading
13.12.02.2007|Salido Saroha Ujung Gading
13.12.02.2008|Kuamang Alai Ujung Gading
13.12.02.2009|Situak Ujung Gading
13.12.03.2003|Lingkuang Aua
13.12.03.2004|Aua Kuniang
13.12.03.2006|Aia Gadang
13.12.03.2007|Lingkuang Aua Timur
13.12.03.2008|Lingkuang Aua Baru
13.12.03.2009|Lingkuang Aua Bandarajo
13.12.03.2010|Lingkuang Aua Jambak
13.12.03.2011|Lingkuang Aua Koto Dalam
13.12.03.2012|Lingkuang Aua Barat
13.12.03.2013|Lingkuang Aua Hilia
13.12.03.2014|Sukomananti Aua Kuniang
13.12.03.2015|Aia Gadang Timur
13.12.03.2016|Aia Gadang Barat
13.12.03.2017|Pinaga Aua Kuniang
13.12.03.2018|Lubuak Landua Aua Kuniang
13.12.03.2019|Lembah Binuang Aua Kuniang
13.12.04.2001|Kajai
13.12.04.2002|Talu
13.12.04.2003|Sinuruik
13.12.04.2004|Simpang Timbo Abu Kajai
13.12.04.2005|Kajai Selatan
13.12.04.2006|Sungai Janiah Talu
13.12.04.2007|Tabek Sirah Talu
13.12.05.2001|Kinali
13.12.05.2002|Katiagan
13.12.05.2003|Ampek Koto
13.12.05.2004|Ampek Koto Barat
13.12.05.2005|Bancah Kariang
13.12.05.2006|Mudiak Labuah
13.12.05.2007|Tandikek
13.12.05.2008|Langgam Sepakat
13.12.05.2009|Langgam Saiyo
13.12.05.2010|Anam Koto Selatan
13.12.05.2011|Sigunanti
13.12.05.2012|Koto Gadang Jaya
13.12.05.2013|Anam Koto Utara
13.12.05.2014|Bandua Balai
13.12.05.2015|Bunuik
13.12.05.2016|Padang Canduh
13.12.05.2017|Limau Purut
13.12.06.2001|Muaro Kiawai
13.12.06.2002|Rabi Jonggor
13.12.06.2003|Seberang Kenaikan
13.12.06.2004|Bahoras
13.12.06.2005|Ranah Sungai Magelang
13.12.06.2006|Muaro Kiawai Barat
13.12.06.2007|Muaro Kiawai Hilir
13.12.07.2001|Batahan
13.12.07.2002|Desa Baru
13.12.07.2003|Batahan Utara
13.12.07.2004|Batahan Tengah
13.12.07.2005|Batahan Barat
13.12.07.2006|Batahan Selatan
13.12.07.2007|Desa Baru Barat
13.12.08.2001|Parit
13.12.08.2002|Koto Tangah
13.12.08.2003|Koto Tuo
13.12.08.2004|Koto Nan Duo
13.12.08.2005|Pematang Panjang
13.12.08.2006|Ranah Koto Tinggi
13.12.09.2001|Sungai Aua
13.12.09.2002|Salingka Muaro
13.12.09.2003|Ranah Malintang
13.12.09.2004|Ranah Air Haji
13.12.09.2005|Kasikputih Sungaitanang
13.12.09.2006|Aua Serumpun
13.12.09.2007|Sikilang Sungai Aur Selatan
13.12.10.2001|Koto Baru
13.12.10.2002|Kapa
13.12.10.2003|Giri Maju
13.12.10.2004|Ophir
13.12.10.2005|Mahakarya
13.12.10.2006|Sariak
13.12.10.2007|Sungai Talang
13.12.10.2008|Jambak Selatan
13.12.10.2009|Pujorahayu
13.12.11.2001|Sasak
13.12.11.2002|Padang Harapan
13.12.11.2003|Ranah Pasisie
13.12.11.2004|Maligi
13.71.01.1001|Belakang Pondok
13.71.01.1002|Alang Laweh
13.71.01.1003|Ranah Parak Rumbio
13.71.01.1004|Pasa Gadang
13.71.01.1005|Batang Arau
13.71.01.1006|Seberang Palinggam
13.71.01.1007|Seberang Padang
13.71.01.1008|Mata Air
13.71.01.1009|Rawang
13.71.01.1010|Teluk Bayur
13.71.01.1011|Air Manis
13.71.01.1012|Bukit Gado-gado
13.71.02.1001|Sawahan
13.71.02.1002|Jati Baru
13.71.02.1003|Jati
13.71.02.1004|Sawahan Timur
13.71.02.1005|Simpang Haru
13.71.02.1006|Kubu Marapalam
13.71.02.1007|Andalas
13.71.02.1008|Kubu Dalam Parak Karakah
13.71.02.1009|Parak Gadang Timur
13.71.02.1010|Ganting Parak Gadang
13.71.03.1001|Flamboyan Baru
13.71.03.1002|Rimbo Kaluang
13.71.03.1003|Ujung Gurun
13.71.03.1004|Purus
13.71.03.1005|Padang Pasir
13.71.03.1006|Olo
13.71.03.1007|Kampung Jawa
13.71.03.1008|Belakang Tangsi
13.71.03.1009|Kampung Pondok
13.71.03.1010|Berok Nipah
13.71.04.1001|Air Tawar Timur
13.71.04.1002|Air Tawar Barat
13.71.04.1003|Ulak Karang Utara
13.71.04.1004|Ulak Karang Selatan
13.71.04.1005|Lolong Belanti
13.71.04.1006|Alai Parak Kopi
13.71.04.1007|Gunung Pangilun
13.71.05.1001|Bungus Timur
13.71.05.1002|Bungus Barat
13.71.05.1003|Bungus Selatan
13.71.05.1004|Teluk Kabung Utara
13.71.05.1005|Teluk Kabung Tengah
13.71.05.1006|Teluk Kabung Selatan
13.71.06.1001|Cangkeh Nan XX
13.71.06.1002|Kampung Baru Nan XX
13.71.06.1003|Tanah Sirah Piai Nan XX
13.71.06.1004|Tanjung Saba Pitameh Nan XX
13.71.06.1005|Lubuk Begalung Nan XX
13.71.06.1006|Gurun Laweh Nan XX
13.71.06.1007|Tanjung Aua Nan XX
13.71.06.1008|Koto Baru Nan XX
13.71.06.1009|Banuaran Nan XX
13.71.06.1010|Parak Laweh Pulau Aia Nan XX
13.71.06.1011|Batung Taba Nan XX
13.71.06.1012|Pegambiran Ampalu Nan XX
13.71.06.1013|Pampangan Nan XX
13.71.06.1014|Gates Nan XX
13.71.06.1015|Kampung Jua Nan XX
13.71.07.1001|Indarung
13.71.07.1002|Padang Besi
13.71.07.1003|Batu Gadang
13.71.07.1004|Banda Buek
13.71.07.1005|Koto Lalang
13.71.07.1006|Baringin
13.71.07.1007|Tarantang
13.71.08.1001|Limau Manis
13.71.08.1002|Koto Lua
13.71.08.1003|Limau Manis Selatan
13.71.08.1004|Piai Tangah
13.71.08.1005|Cupak Tangah
13.71.08.1006|Pisang
13.71.08.1007|Binuang Kampung Dalam
13.71.08.1008|Kapalo Koto
13.71.08.1009|Lambung Bukit
13.71.09.1001|Pasar Ambacang
13.71.09.1002|Anduring
13.71.09.1003|Lubuk Lintah
13.71.09.1004|Ampang
13.71.09.1005|Kalumbuk
13.71.09.1006|Korong Gadang
13.71.09.1007|Kuranji
13.71.09.1008|Gunung Sarik
13.71.09.1009|Sungai Sapih
13.71.10.1001|Surau Gadang
13.71.10.1002|Kampung Olo
13.71.10.1003|Kurao Pagang
13.71.10.1004|Gurun Laweh
13.71.10.1005|Tabiang Banda Gadang
13.71.10.1006|Kampung Lapai
13.71.11.1001|Balai Gadang
13.71.11.1002|Lubuk Minturun
13.71.11.1003|Aie Pacah
13.71.11.1004|Dadok Tunggul Hitam
13.71.11.1005|Koto Panjang Ikua Koto
13.71.11.1006|Koto Pulai
13.71.11.1007|Batipuh Panjang
13.71.11.1008|Padang Sarai
13.71.11.1009|Lubuk Buaya
13.71.11.1010|Batang Kabung Ganting
13.71.11.1011|Bungo Pasang
13.71.11.1012|Parupuk Tabing
13.71.11.1013|Pasie Nan Tigo
13.72.01.1001|Tanah Garam
13.72.01.1002|VI Suku
13.72.01.1003|Sinapa Piliang
13.72.01.1004|IX Korong
13.72.01.1005|Kampai Tabu Karambia
13.72.01.1006|Aro IV Korong
13.72.01.1007|Simpang Rumbio
13.72.02.1001|Koto Panjang
13.72.02.1002|Pasar Pandan Air Mati
13.72.02.1003|Tanjung Paku
13.72.02.1004|Nan Balimo
13.72.02.1005|Kampung Jawa
13.72.02.1006|Laing
13.73.01.1001|Aur Mulio
13.73.01.1002|Kubang Sirakuk Utara
13.73.01.1003|Kubang S. Selatan
13.73.01.1004|Pasar
13.73.01.1005|Tanah Lapang
13.73.01.1006|Aia Dingin
13.73.01.2007|Lunto Timur
13.73.01.2008|Lunto Barat
13.73.01.2009|Kubang Tangah
13.73.01.2010|Kubang Utara Sikabu
13.73.01.2011|Pasa Kubang
13.73.02.1001|Saringan
13.73.02.1002|Lubang Panjang
13.73.02.1003|Durian I
13.73.02.1004|Durian II
13.73.02.2005|Santur
13.73.02.2006|Kolok Mudiak
13.73.02.2007|Kolok Nan Tuo
13.73.02.2008|Talago Gunung
13.73.02.2009|Lumindai
13.73.02.2010|Balai Batu Sandaran
13.73.03.2001|Silungkang Duo
13.73.03.2002|Silungkang Oso
13.73.03.2003|Silungkang Tigo
13.73.03.2004|Muaro Kalaban
13.73.03.2005|Taratak Boncah
13.73.04.2001|Talawi Hilie
13.73.04.2002|Talawi Mudiak
13.73.04.2003|Bukit Gadang
13.73.04.2004|Batu Tanjung
13.73.04.2005|Kumbayau
13.73.04.2006|Tumpuk Tangah
13.73.04.2007|Datar Mansiang
13.73.04.2008|Sijantang Koto
13.73.04.2009|Salak
13.73.04.2010|Sikalang
13.73.04.2011|Rantih
13.74.01.1001|Ganting
13.74.01.1002|Sigando
13.74.01.1003|Ekor Lubuk
13.74.01.1004|Ngalau
13.74.01.1005|Guguk Malintang
13.74.01.1006|Koto Panjang
13.74.01.1007|Koto Katik
13.74.01.1008|Tanah Pak Lambik
13.74.02.1001|Bukit Surungan
13.74.02.1002|Pasar Usang
13.74.02.1003|Kampung Manggis
13.74.02.1004|Silaing Bawah
13.74.02.1005|Silaing Atas
13.74.02.1006|Pasar Baru
13.74.02.1007|Tanah Hitam
13.74.02.1008|Balai-balai
13.75.01.1001|Tarok Dipo
13.75.01.1002|Bukit Cangang Kayu Ramang
13.75.01.1003|Pakan Kurai
13.75.01.1004|Aur Tajungkang Tangah Sawah
13.75.01.1005|Benteng Pasar Atas
13.75.01.1006|Kayu Kubu
13.75.01.1007|Bukik Apik Puhun
13.75.02.1001|Campago Guguk Bulek
13.75.02.1002|Campago Ipuh
13.75.02.1003|Puhun Tembok
13.75.02.1004|Kubu Gulai Bancah
13.75.02.1005|Puhun Pintu Kabun
13.75.02.1006|Pulai Anak Air
13.75.02.1007|Koto Selayan
13.75.02.1008|Garegeh
13.75.02.1009|Manggis Ganting
13.75.03.1001|Aur Kuning
13.75.03.1002|Birugo
13.75.03.1003|Belakang Balok
13.75.03.1004|Sapiran
13.75.03.1005|Kubu Tanjung
13.75.03.1006|Pakan Labuah
13.75.03.1007|Parit Antang
13.75.03.1008|Ladang Cakiah
13.76.01.1002|Pakan Sinayan
13.76.01.1003|Kubu Gadang
13.76.01.1004|Bulakan Balai Kandi
13.76.01.1005|Payolansek
13.76.01.1007|Talang
13.76.01.1009|Padang Tinggi Piliang
13.76.01.1011|Koto Tangah
13.76.01.1013|Subarang Batuang
13.76.01.1016|Parik Rantang
13.76.01.1017|Parak Batuang
13.76.01.1018|Nunang Daya Bangun
13.76.01.1020|Labuah Basilang
13.76.01.1021|Ibuah
13.76.01.1022|Tanjuang Pauh
13.76.01.1032|Tanjuanggodang Sungaipinago
13.76.01.1033|Padangtongah Balainanduo
13.76.01.1034|Padangdata Tanahmati
13.76.02.1002|Napar
13.76.02.1032|Ompang Tanah Sirah
13.76.02.1033|Taratak Padang Kampuang
13.76.02.1034|Tigo Koto Dibaruah
13.76.02.1035|Tigo Koto Diate
13.76.02.1036|Ikua Koto Dibalai
13.76.02.1037|Balai Tongah Koto
13.76.02.1038|Kapalo Koto Dibalai
13.76.02.1039|Kotokociak Kubu Tapakrajo
13.76.03.1001|Balai Jaring
13.76.03.1002|Padang Alai Bodi
13.76.03.1003|Padang Tangah Payobadar
13.76.03.1005|Sicincin
13.76.03.1007|Padang Tiakar
13.76.03.1009|Payobasung
13.76.03.1010|Koto Panjang
13.76.03.1011|Koto Baru
13.76.03.1015|Tiakar
13.76.04.1001|Sungai Durian
13.76.04.1002|Parit Muko Aie
13.76.04.1003|Parambahan
13.76.04.1004|Padang Sikabu
13.76.04.1005|Koto Panjang Padang
13.76.04.1006|Koto Panjang Dalam
13.76.05.1001|Padang Karambia
13.76.05.1002|Kototuo Limokampuang
13.76.05.1003|Limbukan
13.76.05.1005|Balai Panjang
13.76.05.1006|Kapalo Koto Ampangan
13.76.05.1010|Sawahpadang Aua Kuniang
13.77.01.1001|Karan Aur
13.77.01.1002|Kampung Perak
13.77.01.1003|Lohong
13.77.01.1004|Pasir
13.77.01.1005|Kampung Pondok
13.77.01.1006|Pondok II
13.77.01.1007|Kampung Jawa I
13.77.01.1008|Kampung Jawa II
13.77.01.1009|Alai Gelombang
13.77.01.1010|Jawi Jawi I
13.77.01.1011|Jawi Jawi II
13.77.01.1012|Jalan Baru
13.77.01.1013|Taratak
13.77.01.1014|Jalan Kereta Api
13.77.01.1015|Ujung Batung
13.77.01.1016|Jati Hilir
13.77.01.2017|Pauh Barat
13.77.01.2018|Pauh Timur
13.77.01.2019|Rawang
13.77.01.2020|Kampung Baru
13.77.01.2021|Cimparuh
13.77.01.2025|Jati Mudik
13.77.02.2005|Ampalu
13.77.02.2006|Apar
13.77.02.2007|Tanjung Sabar
13.77.02.2008|Cubadak Air Selatan
13.77.02.2009|Sikapak Barat
13.77.02.2010|Sikapak Timur
13.77.02.2011|Manggung
13.77.02.2012|Cubadak Air Utara
13.77.02.2013|Tungkal Selatan
13.77.02.2014|Naras Hilir
13.77.02.2015|Naras I
13.77.02.2016|Balai Naras
13.77.02.2017|Padang Birik Birik
13.77.02.2018|Sintuk
13.77.02.2019|Sungai Rambai
13.77.02.2020|Tungkal Utara
13.77.02.2021|Cubadak Air
13.77.03.2006|Pasir Sunur
13.77.03.2007|Balai Kurai Taji
13.77.03.2008|Pauh Kurai Taji
13.77.03.2009|Simpang
13.77.03.2010|Toboh Palabah
13.77.03.2011|Marabau
13.77.03.2012|Batang Tajongkek
13.77.03.2013|Sikabu
13.77.03.2014|Sungai Kasai
13.77.03.2015|Palak Aneh
13.77.03.2016|Kampung Apar
13.77.03.2017|Marunggi
13.77.03.2018|Taluk
13.77.03.2019|Padang Cakur
13.77.03.2020|Punggung Lading
13.77.03.2021|Rambai
13.77.04.2001|Talago Sarik
13.77.04.2002|Pakasai
13.77.04.2003|Kampung Baru Padusunan
13.77.04.2004|Kampung Gadang
13.77.04.2005|Koto Marapak
13.77.04.2006|Batang Kabung
13.77.04.2007|Bato
13.77.04.2008|Air Santok
13.77.04.2009|Cubadak Mentawai
13.77.04.2010|Sungai Sirah
13.77.04.2011|Sungai Pasak
13.77.04.2012|Bungo Tanjung
13.77.04.2013|Kampung Tangah
13.77.04.2014|Kampung Kandang
13.77.04.2015|Kaluat
13.77.04.2016|Kajai
14.01.01.1011|Bangkinang
14.01.01.1013|Langgini
14.01.01.2009|Kumantan
14.01.01.2010|Ridan Permai
14.01.02.1027|Air Tiris
14.01.02.2001|Batu Belah
14.01.02.2003|Tanjung Berulak
14.01.02.2006|Ranah
14.01.02.2007|Penyasawan
14.01.02.2008|Rumbio
14.01.02.2013|Padang Mutung
14.01.02.2023|Pulau Jambu
14.01.02.2024|Tanjung Rambutan
14.01.02.2025|Simpang Kubu
14.01.02.2028|Limau Manis
14.01.02.2030|Naumbai
14.01.02.2031|Pulau Tinggi
14.01.02.2032|Ranah Baru
14.01.02.2033|Bukit Ranah
14.01.02.2034|Pulau Sarak
14.01.02.2035|Koto Tibun
14.01.02.2036|Ranah Singkuang
14.01.03.2001|Tambang
14.01.03.2002|Kuapan
14.01.03.2003|Gobah
14.01.03.2004|Teluk Kenidai
14.01.03.2005|Aursati
14.01.03.2006|Padang Luas
14.01.03.2007|Terantang
14.01.03.2008|Kualu
14.01.03.2009|Rimbo Panjang
14.01.03.2010|Parit Baru
14.01.03.2011|Kemang Indah
14.01.03.2012|Kualu Nenas
14.01.03.2013|Tarai Bangun
14.01.03.2014|Sungai Pinang
14.01.03.2015|Balam Jaya
14.01.03.2016|Pulau Permai
14.01.03.2017|Palung Raya
14.01.04.1018|Batu Bersurat
14.01.04.2004|Gunung Bungsu
14.01.04.2005|Koto Tuo
14.01.04.2006|Balung
14.01.04.2007|Muara Takus
14.01.04.2010|Pulau Gadang
14.01.04.2011|Tanjung Alai
14.01.04.2012|Ranah Sungkai
14.01.04.2013|Lubuk Agung
14.01.04.2014|Koto Mesjid
14.01.04.2016|Pongkai Istiqomah
14.01.04.2017|Binamang
14.01.04.2019|Koto Tuo Barat
14.01.05.2001|Kuok
14.01.05.2005|Merangin
14.01.05.2006|Empat Balai
14.01.05.2007|Pulau Jambu
14.01.05.2008|Silam
14.01.05.2010|Bukit Melintang
14.01.05.2011|Pulau Terap
14.01.05.2012|Lereng
14.01.05.2013|Batu Langka Kecil
14.01.06.2001|Pangkalan Baru
14.01.06.2002|Desa Baru
14.01.06.2003|Teratak Buluh
14.01.06.2005|Lubuk Siam
14.01.06.2006|Buluh Cina
14.01.06.2007|Buluh Nipis
14.01.06.2011|Tanah Merah
14.01.06.2012|Pandau Jaya
14.01.06.2013|Tanjung Balam
14.01.06.2014|Kepau Jaya
14.01.06.2015|Pangkalan Serik
14.01.06.2016|Kubang Jaya
14.01.07.1027|Lipat Kain
14.01.07.2003|Kuntu
14.01.07.2004|Padang Sawah
14.01.07.2005|Domo
14.01.07.2006|IV Koto Setingkai
14.01.07.2008|Teluk Paman
14.01.07.2013|Sungai Geringging
14.01.07.2016|Sungai Paku
14.01.07.2019|Muara Selayah
14.01.07.2020|Sungai Rambai
14.01.07.2021|Tanjung Harapan
14.01.07.2023|Sungai Raja
14.01.07.2026|Sungai Sarik
14.01.07.2028|Lipat Kain Utara
14.01.07.2029|Lipat Kain Selatan
14.01.07.2030|Kuntu Darussalam
14.01.07.2031|Tanjung Mas
14.01.07.2032|Sungai Harapan
14.01.07.2033|Sungai Liti
14.01.07.2034|Teluk Paman Timur
14.01.08.1001|Sungai Pagar
14.01.08.2002|Mentulik
14.01.08.2003|Sungai Simpang Dua
14.01.08.2004|Sungai Bungo
14.01.08.2005|Rantau Kasih
14.01.08.2006|Sungai Petai
14.01.08.2007|Gading Permai
14.01.08.2008|Bangun Sari
14.01.09.2001|Gema
14.01.09.2002|Tanjung Belit
14.01.09.2003|Tanjung Belit Selatan
14.01.09.2004|Koto Lama
14.01.09.2005|Batu Sanggan
14.01.09.2006|Aur Kuning
14.01.09.2007|Ludai
14.01.09.2008|Tanjung Karang
14.01.09.2009|Batu Sasak
14.01.09.2010|Pangkalan Kapas
14.01.09.2011|Kebun Tinggi
14.01.09.2012|Tanjung Beringin
14.01.09.2013|Gajah Bertalut
14.01.09.2014|Danau Sontul
14.01.09.2015|Pangkalan Serai
14.01.09.2016|Dua Sepakat
14.01.09.2017|Terusan
14.01.09.2018|Deras Tajak
14.01.09.2019|Sungai Santi
14.01.09.2020|Subayang Jaya
14.01.09.2021|Tanjung Permai
14.01.09.2022|Bukit Betung
14.01.09.2023|Muaro Bio
14.01.09.2024|Lubuk Bigau
14.01.10.2001|Petapahan
14.01.10.2002|Pantai Cermin
14.01.10.2003|Petapahan Jaya
14.01.10.2004|Mukti Sari
14.01.10.2005|Sungai Putih
14.01.10.2006|Indra Sakti
14.01.10.2007|Gading Sari
14.01.10.2008|Sumber Makmur
14.01.10.2009|Pancuran Gading
14.01.10.2010|Sari Galuh
14.01.10.2011|Tri Manunggal
14.01.10.2012|Air Terbit
14.01.10.2013|Tanjung Sawit
14.01.10.2014|Pagaruyung
14.01.10.2015|Sibuak
14.01.10.2016|Pelambaian
14.01.10.2017|Kenantan
14.01.10.2018|Indrapuri
14.01.10.2019|Sungai Lambu Makmur
14.01.10.2020|Muara Mahat Baru
14.01.10.2021|Karya Indah
14.01.10.2022|Kijang Rejo
14.01.10.2023|Sungai Agung
14.01.10.2024|Bencah Kelubi
14.01.10.2025|Batu Gajah
14.01.11.2001|Koto Garo
14.01.11.2002|Sekijang
14.01.11.2003|Beringin Lestari
14.01.11.2004|Kota Bangun
14.01.11.2005|Cinta Damai
14.01.11.2006|Suka Maju
14.01.11.2007|Kota Baru
14.01.11.2008|Tebing Lestari
14.01.11.2009|Tanah Tinggi
14.01.11.2010|Koto Aman
14.01.11.2011|Tapung Lestari
14.01.11.2012|Tapung Makmur
14.01.11.2013|Tandan Sari
14.01.11.2014|Gerbang Sari
14.01.11.2015|Kijang Jaya
14.01.11.2016|Kijang Makmur
14.01.12.2001|Senama Nenek
14.01.12.2002|Kasikan
14.01.12.2003|Bukit Kemuning
14.01.12.2004|Danau Lancang
14.01.12.2005|Muara Intan
14.01.12.2006|Intan Jaya
14.01.12.2007|Tanah Datar
14.01.12.2008|Rimba Jaya
14.01.12.2009|Rimba Makmur
14.01.12.2010|Rimba Beringin
14.01.12.2011|Sukaramai
14.01.12.2012|Sumber Sari
14.01.12.2013|Kusau Makmur
14.01.12.2014|Talang Danto
14.01.13.2001|Salo
14.01.13.2002|Siabu
14.01.13.2003|Salo Timur
14.01.13.2004|Sipungguk
14.01.13.2005|Ganting Damai
14.01.13.2006|Ganting
14.01.14.2001|Pulau Payung
14.01.14.2002|Teratak
14.01.14.2003|Alam Panjang
14.01.14.2004|Bukit Kratai
14.01.14.2005|Batang Batindih
14.01.14.2006|Tambusai
14.01.14.2007|Simpang Petai
14.01.15.1007|Pulau
14.01.15.1008|Pasir Sialang
14.01.15.2001|Pulau Lawas
14.01.15.2002|Muara Uwai
14.01.15.2003|Laboy Jaya
14.01.15.2004|Bukit Payung
14.01.15.2005|Suka Mulya
14.01.15.2006|Bukit Sembilan
14.01.15.2009|Binuang
14.01.16.2001|Kampung Pinang
14.01.16.2002|Pantai Raja
14.01.16.2003|Hangtuah
14.01.16.2004|Sialang Kubang
14.01.16.2005|Lubuk Sakat
14.01.17.2001|Pulau Birandang
14.01.17.2002|Pulau Rambai
14.01.17.2003|Kampar
14.01.17.2004|Koto Perambahan
14.01.17.2005|Sungai Putih
14.01.17.2006|Deli Makmur
14.01.17.2007|Sungai Tarap
14.01.17.2008|Tanjung Bungo
14.01.17.2009|Sawah Baru
14.01.18.2001|Muara Jalai
14.01.18.2002|Sawah
14.01.18.2003|Kampung Panjang
14.01.18.2004|Kayu Aro
14.01.18.2005|Sungai Tonang
14.01.18.2006|Sungai Jalau
14.01.18.2007|Sendayan
14.01.18.2008|Naga Beralih
14.01.19.2001|Simalinyang
14.01.19.2002|Bina Baru
14.01.19.2003|Hidup Baru
14.01.19.2004|Karya Bakti
14.01.19.2005|Lubuk Sakai
14.01.19.2006|Penghidupan
14.01.19.2007|Mayang Pongkai
14.01.19.2008|Koto Damai
14.01.19.2009|Utama Karya
14.01.19.2010|Bukit Sakai
14.01.19.2011|Mekar Jaya
14.01.20.2001|Kebun Durian
14.01.20.2002|Gunung Sahilan
14.01.20.2003|Gunung Sari
14.01.20.2004|Suka Makmur
14.01.20.2005|Subarak
14.01.20.2006|Sungai Lipai
14.01.20.2007|Sahilan Darussalam
14.01.20.2008|Gunung Mulya
14.01.20.2009|Makmur Sejahtera
14.01.21.2001|Siberuang
14.01.21.2002|Bandur Picak
14.01.21.2003|Gunung Malelo
14.01.21.2004|Tabing
14.01.21.2005|Pongkai
14.01.21.2006|Tanjung
14.02.01.1004|Kampung Dagang
14.02.01.1006|Pasar Kota
14.02.01.1007|Kampung Besar Kota
14.02.01.1008|Sekip Hulu
14.02.01.1011|Kampung Besar Seberang
14.02.01.1018|Sekip Hilir
14.02.01.2001|Sungai Guntung Tengah
14.02.01.2002|Sungai Guntung Hilir
14.02.01.2003|Kuantan Babu
14.02.01.2005|Kampung Pulau
14.02.01.2009|Sungai Beringin
14.02.01.2010|Pasir Kemilu
14.02.01.2012|Rantau Mapesai
14.02.01.2013|Pulau Gajah
14.02.01.2014|Sungai Raya
14.02.01.2023|Rawa Bangun
14.02.02.1009|Pematang Reba
14.02.02.2001|Barangan
14.02.02.2002|Alang Kepayang
14.02.02.2003|Kota Lama
14.02.02.2004|Redang
14.02.02.2005|Pekan Heran
14.02.02.2006|Rantau Bakung
14.02.02.2007|Talang Jerinjing
14.02.02.2008|Sialang Dua Dahan
14.02.02.2010|Sungai Dawu
14.02.02.2011|Bukit Petaling
14.02.02.2012|Pematang Jaya
14.02.02.2013|Danau Baru
14.02.02.2014|Tanah Datar
14.02.02.2015|Tani Makmur
14.02.02.2016|Sungai Baung
14.02.02.2017|Danau Tiga
14.02.02.2018|Air Jernih
14.02.03.1019|Simpang Kelayang
14.02.03.2007|Pulau Sengkilo
14.02.03.2008|Kota Medan
14.02.03.2009|Simpang Kota Medan
14.02.03.2010|Polak Pisang
14.02.03.2018|Pelangko
14.02.03.2020|Teluk Sejuah
14.02.03.2021|Bongkal Malang
14.02.03.2022|Dusun Tua
14.02.03.2024|Sungai Banyak Ikan
14.02.03.2025|Tanjung Beludu
14.02.03.2026|Sungai Pasir Putih
14.02.03.2027|Sungai Golang
14.02.03.2028|Pasir Beringin
14.02.03.2029|Sungai Kuning Benio
14.02.03.2030|Bukit Selanjut
14.02.03.2031|Dusun Tua Pelang
14.02.04.1007|Air Molek I
14.02.04.1020|Kembang Harum
14.02.04.1031|Tanjung Gading
14.02.04.1032|Sekar Mawar
14.02.04.1033|Tanah Merah
14.02.04.2006|Petalongan
14.02.04.2008|Air Molek II
14.02.04.2009|Pasir Keranji
14.02.04.2016|Jati Rejo
14.02.04.2017|Batu Gajah
14.02.04.2018|Candi Rejo
14.02.04.2019|Lembah Dusun Gading
14.02.04.2030|Serumpun Jaya
14.02.05.1005|Peranap
14.02.05.1008|Batu Rijal Hilir
14.02.05.2003|Semelinang Tebing
14.02.05.2004|Gumanti
14.02.05.2007|Batu Rijal Hulu
14.02.05.2009|Semelinang Darat
14.02.05.2010|Pauh Ranap
14.02.05.2012|Serai Wangi
14.02.05.2013|Pandan Wangi
14.02.05.2017|Katipo Pura
14.02.05.2019|Batu Rijal Barat
14.02.05.2020|Setako Raya
14.02.06.1001|Pangkalan Kasai
14.02.06.2002|Kelesa
14.02.06.2003|Beligan
14.02.06.2004|Seresam
14.02.06.2005|Paya Rumbai
14.02.06.2006|Bukit Meranti
14.02.06.2007|Buluh Rampai
14.02.06.2008|Titian Resak
14.02.06.2009|Petala Bumi
14.02.06.2010|Sibabat
14.02.06.2011|Bandar Padang
14.02.07.2002|Anak Talang
14.02.07.2004|Bukit Lingkar
14.02.07.2005|Bukit Lipai
14.02.07.2006|Kuala Gading
14.02.07.2007|Kuala Kilan
14.02.07.2008|Kerubung Jaya
14.02.07.2009|Pejangki
14.02.07.2010|Pematang Manggis
14.02.07.2011|Sipang
14.02.07.2012|Talang Bersemi
14.02.07.2013|Talang Mulya
14.02.07.2014|Punti Anai
14.02.07.2015|Petaling Jaya
14.02.07.2017|Cenaku Kecil
14.02.07.2018|Alim
14.02.07.2019|Aur Cina
14.02.07.2020|Lahai Kemuning
14.02.07.2021|Kepayang Sari
14.02.07.2022|Batu Papan
14.02.07.2023|Sanglap
14.02.08.2001|Siambul
14.02.08.2002|Rantau Langsat
14.02.08.2003|Sungai Akar
14.02.08.2004|Usul
14.02.08.2005|Seberida
14.02.08.2006|Talang Lakat
14.02.08.2007|Belimbing
14.02.08.2008|Ringin
14.02.08.2010|Penyaguan
14.02.08.2011|Danau Rambai
14.02.09.2001|Japura
14.02.09.2002|Sidomulyo
14.02.09.2003|Pasir Ringgit
14.02.09.2004|Gudang Batu
14.02.09.2005|Sungai Sagu
14.02.09.2006|Lirik Area
14.02.09.2007|Rejosari
14.02.09.2008|Lambang Sari V
14.02.09.2009|Lambang Sari IV
14.02.09.2010|Lambang Sari I, II, III
14.02.09.2011|Wonosari
14.02.09.2012|Seko Lubuk Tigo
14.02.09.2013|Banjar Balam
14.02.09.2014|Redang Seko
14.02.09.2015|Sukajadi
14.02.09.2016|Mekar Sari
14.02.09.2017|Pasir Sialang Jaya
14.02.10.2001|Tambak
14.02.10.2002|Kuala Cenaku
14.02.10.2003|Pulau Gelang
14.02.10.2004|Kuala Mulya
14.02.10.2005|Tanjung Sari
14.02.10.2006|Rawa Sekip
14.02.10.2007|Rawa Asri
14.02.10.2008|Suka Jadi
14.02.10.2009|Teluk Sungkai
14.02.10.2010|Pulau Jum'at
14.02.11.2001|Morong
14.02.11.2002|Pasir Bongkal
14.02.11.2003|Pasir Selabau
14.02.11.2004|Pasir Batu Mandi
14.02.11.2005|Pasir Kelampaian
14.02.11.2006|Kuala Lala
14.02.11.2007|Sungai Lala
14.02.11.2008|Kelawat
14.02.11.2009|Perkebunan Sungai Parit
14.02.11.2010|Perkebunan Sungai Lala
14.02.11.2011|Tanjung Danau
14.02.11.2012|Sungai Air Putih
14.02.12.2001|Rimpian
14.02.12.2002|Pondok Gelugur
14.02.12.2003|Lubuk Batu Tinggal
14.02.12.2004|Sungai Beras Hilir
14.02.12.2005|Kulim Jaya
14.02.12.2006|Sungai Beras Beras
14.02.12.2007|Tasik Juang
14.02.12.2008|Pontian Mekar
14.02.12.2009|Air Putih
14.02.13.2001|Talang Tujuh Buah Tangga
14.02.13.2002|Talang Durian Cacar
14.02.13.2003|Talang Selantai
14.02.13.2004|Talang Perigi
14.02.13.2005|Kuantan Tenang
14.02.13.2006|Kota Baru
14.02.13.2007|Rimba Seminai
14.02.13.2008|Kelayang
14.02.13.2009|Talang Gedabu
14.02.13.2010|Talang Sungai Limau
14.02.13.2011|Talang Sungai Parit
14.02.13.2012|Batu Sawar
14.02.13.2013|Petonggan
14.02.13.2014|Lubuk Sitarak
14.02.13.2015|Bukit Indah
14.02.13.2016|Sungai Ekok
14.02.13.2017|Talang Suka Maju
14.02.13.2018|Kampung Bunga
14.02.13.2019|Talang Pring Jaya
14.02.14.2001|Pesajian
14.02.14.2002|Punti Kayu
14.02.14.2003|Pematang
14.02.14.2004|Selunak
14.02.14.2005|Suka Maju
14.02.14.2006|Pematang Benteng
14.02.14.2007|Sencano Jaya
14.02.14.2008|Sungai Aur
14.02.14.2009|Peladangan
14.02.14.2010|Koto Tuo
14.03.01.1001|Bengkalis Kota
14.03.01.1002|Damon
14.03.01.1003|Rimba Sekampung
14.03.01.2004|Kelapapati
14.03.01.2005|Pedekik
14.03.01.2006|Pangkalan Batang
14.03.01.2007|Sebauk
14.03.01.2008|Teluk Latak
14.03.01.2009|Meskom
14.03.01.2010|Senggoro
14.03.01.2011|Air Putih
14.03.01.2012|Sungai Alam
14.03.01.2013|Penampi
14.03.01.2014|Temeran
14.03.01.2015|Penebal
14.03.01.2016|Pematang Duku
14.03.01.2017|Ketam Putih
14.03.01.2018|Kelemantan
14.03.01.2019|Sekodi
14.03.01.2020|Wonosari
14.03.01.2021|Kuala Alam
14.03.01.2022|Kelebuk
14.03.01.2023|Palkun
14.03.01.2024|Sungai Batang
14.03.01.2025|Prapat Tunggal
14.03.01.2026|Simpang Ayam
14.03.01.2027|Senderak
14.03.01.2028|Kelemantan Barat
14.03.01.2029|Damai
14.03.01.2030|Pangkalan Batang Barat
14.03.01.2031|Pematang Duku Timur
14.03.02.2001|Bantan Tengah
14.03.02.2002|Bantan Air
14.03.02.2003|Bantan Tua
14.03.02.2004|Teluk Pambang
14.03.02.2005|Selat Baru
14.03.02.2006|Teluk Lancar
14.03.02.2007|Kembung Luar
14.03.02.2008|Jangkang
14.03.02.2009|Muntai
14.03.02.2010|Resam Lapis
14.03.02.2011|Berancah
14.03.02.2012|Ulu Pulau
14.03.02.2013|Mentayan
14.03.02.2014|Pambang Pesisir
14.03.02.2015|Sukamaju
14.03.02.2016|Pambang Baru
14.03.02.2017|Kembung Baru
14.03.02.2018|Pasiran
14.03.02.2019|Bantan Sari
14.03.02.2020|Bantan Timur
14.03.02.2021|Teluk Papal
14.03.02.2022|Muntai Barat
14.03.02.2023|Deluk
14.03.03.1010|Sungai Pakning
14.03.03.2001|Sejangat
14.03.03.2002|Dompas
14.03.03.2003|Pangkalan Jambi
14.03.03.2004|Sungai Selari
14.03.03.2005|Buruk Bakul
14.03.03.2006|Bukit Batu
14.03.03.2007|Sukajadi
14.03.03.2016|Batang Duku
14.03.03.2017|Pakning Asal
14.03.09.1001|Air Jamban
14.03.09.1002|Babussalam
14.03.09.1003|Batang Serosa
14.03.09.1004|Balik Alam
14.03.09.1006|Duri Barat
14.03.09.1007|Duri Timur
14.03.09.1008|Gajah Sakti
14.03.09.1009|Talang Mandi
14.03.09.1010|Pematang Pudu
14.03.09.2011|Harapan Baru
14.03.09.2021|Bathin Betuah
14.03.10.1001|Batu Panjang
14.03.10.1002|Pergam
14.03.10.1003|Terkul
14.03.10.1004|Tanjung Kapal
14.03.10.2005|Sungai Cingam
14.03.10.2006|Teluk Lecah
14.03.10.2007|Makeruh
14.03.10.2008|Hutan Panjang
14.03.10.2009|Pangkalan Nyirih
14.03.10.2010|Sukarjo Mesim
14.03.10.2011|Darul Aman
14.03.10.2012|Parit Kebumen
14.03.10.2013|Sri Tanjung
14.03.10.2014|Pancur Jaya
14.03.10.2015|Pangkalan Pinang
14.03.10.2016|Dungun Baru
14.03.11.2001|Tanjung Medang
14.03.11.2002|Teluk Rhu
14.03.11.2003|Tanjung Punak
14.03.11.2004|Kadur
14.03.11.2005|Titi Akar
14.03.11.2006|Hutan Ayu
14.03.11.2007|Suka Damai
14.03.11.2008|Puteri Sembilan
14.03.12.2001|Lubuk Muda
14.03.12.2002|Tanjung Belit
14.03.12.2003|Sungai Siput
14.03.12.2004|Sepotong
14.03.12.2005|Lubuk Gaung
14.03.12.2006|Langkat
14.03.12.2007|Sadar Jaya
14.03.12.2008|Sungai Linau
14.03.12.2009|Bandar Jaya
14.03.12.2010|Muara Dua
14.03.12.2011|Tanjung Damai
14.03.12.2012|Sumber Jaya
14.03.12.2013|Lubuk Garam
14.03.12.2014|Liang Banir
14.03.12.2015|Tanjung Datuk
14.03.12.2016|Koto Raja
14.03.12.2017|Sungai Nibung
14.03.13.1001|Titian Antui
14.03.13.1012|Balai Raja
14.03.13.2003|Balai Pungut
14.03.13.2005|Muara Basung
14.03.13.2007|Pinggir
14.03.13.2008|Semunai
14.03.13.2011|Tengganau
14.03.13.2014|Sungai Meranti
14.03.13.2015|Pangkalan Libut
14.03.13.2016|Buluh Apo
14.03.14.2001|Parit I Api-Api
14.03.14.2002|Temiang
14.03.14.2003|Api-Api
14.03.14.2004|Tenggayun
14.03.14.2005|Sepahat
14.03.14.2006|Bukit Kerikil
14.03.14.2007|Tanjung Leban
14.03.15.2001|Tasik Serai
14.03.15.2002|Tasik Serai Barat
14.03.15.2003|Kualo Penaso
14.03.15.2004|Beringin
14.03.15.2005|Koto Pait Beringin
14.03.15.2006|Melibur
14.03.15.2007|Tasik Serai Timur
14.03.15.2008|Tasik Tebing Serai
14.03.15.2009|Serai Wangi
14.03.16.2001|Petani
14.03.16.2002|Air Kulim
14.03.16.2003|Buluh Manis
14.03.16.2004|Bumbung
14.03.16.2005|Pamesi
14.03.16.2006|Kesumbo Ampai
14.03.16.2007|Bathin Sobanga
14.03.16.2008|Sebangar
14.03.16.2009|Boncah Mahang
14.03.16.2010|Balai Makam
14.03.16.2011|Tambusai Batang Dui
14.03.16.2012|Simpang Padang
14.03.16.2013|Pematang Obo
14.04.01.1001|Pulaukijang
14.04.01.1017|Metro
14.04.01.1018|Madani
14.04.01.2002|Sanglar
14.04.01.2003|Pulaukecil
14.04.01.2004|Sungaiterap
14.04.01.2009|Sungaiundan
14.04.01.2010|Seberang Sanglar
14.04.01.2011|Mekar Sari
14.04.01.2012|Seberang Pulau Kijang
14.04.01.2013|Sungaiasam
14.04.01.2014|Pulauruku
14.04.01.2019|Tanjunglabuh
14.04.01.2020|Sungaimahang
14.04.02.1001|Enok
14.04.02.1002|Pusaran
14.04.02.1003|Telukmedan
14.04.02.1013|Pantaiseberang Makmur
14.04.02.2004|Pengalihan
14.04.02.2005|Sungaiambat
14.04.02.2006|Simpang Tiga
14.04.02.2007|Rantau Panjang
14.04.02.2008|Sungairukam
14.04.02.2009|Bagan Jaya
14.04.02.2010|Suhada
14.04.02.2011|Jaya Bhakti
14.04.02.2012|Sungailokan
14.04.02.2014|Simpang Tiga Daratan
14.04.03.1007|Sapat
14.04.03.2001|Sungaibuluh
14.04.03.2002|Tanjunglajau
14.04.03.2003|Sungaibela
14.04.03.2006|Telukdalam
14.04.03.2008|Sungaipiyai
14.04.03.2009|Perigi Raja
14.04.03.2010|Tanjungmelayu
14.04.04.1001|Tembilahan Kota
14.04.04.1002|Tembilahan Hilir
14.04.04.1003|Seberang Tembilahan
14.04.04.1004|Sungaiperak
14.04.04.1005|Sungaiberingin
14.04.04.1006|Pekan Arba
14.04.04.1007|Seberang Tembilahan Barat
14.04.04.1008|Seberang Tembilahan Selatan
14.04.05.1004|Sungaisalak
14.04.05.1005|Tempuling
14.04.05.1016|Tanjungpidada
14.04.05.1017|Pangkalan Tujuh
14.04.05.2002|Telukkiambang
14.04.05.2003|Mumpa
14.04.05.2007|Telukjira
14.04.05.2009|Karya Tunas Jaya
14.04.05.2011|Harapan Jaya
14.04.06.1004|Sungaiempat
14.04.06.1005|Telukpinang
14.04.06.1009|Tanjungharapan
14.04.06.2001|Kuala Gaung
14.04.06.2002|Telukpantaian
14.04.06.2003|Teluksungka
14.04.06.2006|Sungaiiliran
14.04.06.2007|Teluktuasan
14.04.06.2008|Rambaian
14.04.06.2010|Harapan Makmur
14.04.06.2011|Kelumpang
14.04.06.2012|Idaman
14.04.07.1004|Khairiah Mandah
14.04.07.2001|Pulaucawan
14.04.07.2002|Belaras
14.04.07.2003|Bente
14.04.07.2005|Igal
14.04.07.2006|Pelanduk
14.04.07.2007|Bakau Aceh
14.04.07.2008|Batang Tumu
14.04.07.2009|Bekawan
14.04.07.2010|Bantayan
14.04.07.2011|Batang Sari
14.04.07.2012|Bolak Raya
14.04.07.2013|Cahaya Baru
14.04.07.2014|Belaras Barat
14.04.07.2015|Sepakat Jaya
14.04.07.2016|Suraya Mandiri
14.04.07.2017|Bidari Tanjung Datuk
14.04.08.1001|Tegaraja
14.04.08.1009|Amal Bakti
14.04.08.1010|Bandar Sri Gemilang
14.04.08.2002|Kuala Selat
14.04.08.2003|Sungaisimbar
14.04.08.2004|Penjuru
14.04.08.2005|Sari Mulia
14.04.08.2006|Air Tawar
14.04.08.2007|Tanjungraja
14.04.08.2008|Sungaiteritip
14.04.08.2011|Makmur Jaya
14.04.09.1003|Kota Baru Reteh
14.04.09.2001|Pebenaan
14.04.09.2002|Seberang Pebenaan
14.04.09.2004|Nusantara Jaya
14.04.09.2005|Kota Baru Seberida
14.04.09.2006|Kembang Mekarsari
14.04.09.2007|Pasar Kembang
14.04.09.2008|Kuala Keritang
14.04.09.2009|Kuala Lemang
14.04.09.2010|Telukkelasa
14.04.09.2011|Pengalihan
14.04.09.2012|Pancur
14.04.09.2013|Sencalang
14.04.09.2014|Petalongan
14.04.09.2015|Nyiur Permai
14.04.09.2016|Lintas Utara
14.04.09.2017|Kayu Raja
14.04.10.1001|Kuala Enok
14.04.10.2002|Selatnama
14.04.10.2003|Sungainyiur
14.04.10.2004|Tanjungbaru
14.04.10.2005|Tekulai Hilir
14.04.10.2006|Tekulai Hulu
14.04.10.2007|Tekulai Bugis
14.04.10.2008|Tanjungpasir
14.04.10.2009|Tanah Merah
14.04.10.2010|Sungailaut
14.04.11.1001|Sungaipiring
14.04.11.2002|Sungailuar
14.04.11.2003|Sungaidusun
14.04.11.2004|Sungaijunjangan
14.04.11.2005|Sungairaya
14.04.11.2006|Kuala Sebatu
14.04.11.2007|Tanjungsiantar
14.04.11.2008|Sungairawa
14.04.11.2009|Sialang Jaya
14.04.11.2010|Gemilang Jaya
14.04.11.2011|Tasik Raya
14.04.11.2012|Pasir Emas
14.04.11.2013|Simpang Jaya
14.04.12.1006|Kuala Lahang
14.04.12.2001|Terusan Kempas
14.04.12.2002|Lahang Baru
14.04.12.2003|Simpang Gaung
14.04.12.2004|Belantaraya
14.04.12.2005|Sungaibaru
14.04.12.2007|Lahang Tengah
14.04.12.2008|Lahang Hulu
14.04.12.2009|Pungkat
14.04.12.2010|Jerambang
14.04.12.2011|Telukkabung
14.04.12.2012|Gembira
14.04.12.2013|Semambu Kuning
14.04.12.2014|Telukmerbau
14.04.12.2015|Soren
14.04.12.2016|Pintasan
14.04.13.1001|Tembilahan Hulu
14.04.13.1005|Tembilahan Barat
14.04.13.2002|Pekan Kamis
14.04.13.2003|Pulaupalas
14.04.13.2004|Sialang Panjang
14.04.13.2006|Sungaiintan
14.04.14.1001|Selensen
14.04.14.2002|Batu Ampar
14.04.14.2003|Keritang
14.04.14.2004|Air Balui
14.04.14.2005|Tuk Jimun
14.04.14.2006|Kemuning Tua
14.04.14.2007|Kemuning Muda
14.04.14.2008|Limau Manis
14.04.14.2009|Lubuk Besar
14.04.14.2010|Sekara
14.04.14.2011|Talang Jangkang
14.04.14.2012|Sekayan
14.04.15.1002|Pelangiran
14.04.15.2001|Rotan Semelur
14.04.15.2003|Simpang Kateman
14.04.15.2004|Tanjungsimpang
14.04.15.2005|Baung Rejo Jaya
14.04.15.2006|Tagagiri Tama Jaya
14.04.15.2007|Pinang Jaya
14.04.15.2008|Wonosari
14.04.15.2009|Tegal Rejo
14.04.15.2010|Intan Mulia Jaya
14.04.15.2011|Saka Palas Jaya
14.04.15.2012|Catur Karya
14.04.15.2013|Bagan Jaya
14.04.15.2014|Telukbunian
14.04.15.2015|Terusan Beringin Jaya
14.04.15.2016|Hidayah
14.04.16.2001|Hibrida Mulia
14.04.16.2002|Indra Sari Jaya
14.04.16.2003|Tunggal Rahayu Jaya
14.04.16.2004|Griya Mukti Jaya
14.04.16.2005|Beringin Mulia
14.04.16.2006|Hibrida Jaya
14.04.16.2007|Sumber Jaya
14.04.16.2008|Sumber Makmur Jaya
14.04.16.2009|Sumber Sari Jaya
14.04.16.2010|Kelapa Patih Jaya
14.04.16.2011|Sapta Mulia Jaya
14.04.16.2012|Saka Rotan
14.04.16.2013|Gembaran
14.04.17.2001|Pulauburung
14.04.17.2002|Teluknibung
14.04.17.2003|Sungaidanai
14.04.17.2004|Mayang Sari Jaya
14.04.17.2005|Bukit Sari Intan Jaya
14.04.17.2006|Manunggal Jaya
14.04.17.2007|Bangun Harjo Jaya
14.04.17.2008|Ringin Jaya
14.04.17.2009|Sri Damai
14.04.17.2010|Sapta Jaya
14.04.17.2011|Keramat Jaya
14.04.17.2012|Binagun Jaya
14.04.17.2013|Suka Jaya
14.04.17.2014|Sukaharjo Jaya
14.04.18.1001|Concong Luar
14.04.18.2002|Concong Dalam
14.04.18.2003|Concong Tengah
14.04.18.2004|Kampung Baru
14.04.18.2005|Panglima Raja
14.04.18.2006|Sungaiberapit
14.04.19.1002|Kempas Jaya
14.04.19.1007|Harapan Tani
14.04.19.2001|Pekan Tua
14.04.19.2003|Rumbai Jaya
14.04.19.2004|Bayas Jaya
14.04.19.2005|Sungaiara
14.04.19.2006|Sungaigantang
14.04.19.2008|Karya Tani
14.04.19.2009|Kerta Jaya
14.04.19.2010|Kulim Jaya
14.04.19.2011|Danaupulai Indah
14.04.19.2012|Sungairabit
14.04.20.1001|Benteng
14.04.20.2002|Benteng Utara
14.04.20.2003|Pasenggerahan
14.04.20.2004|Kuala Sungai Batang
14.04.20.2005|Kuala Patah Parang
14.04.20.2006|Benteng Barat
14.04.20.2007|Pandan Sari
14.04.20.2008|Mugo Mulyo
14.05.01.1010|Ukui I
14.05.01.2001|Air Hitam
14.05.01.2002|Air Emas
14.05.01.2003|Bukit Gajah
14.05.01.2004|Bukit Jaya
14.05.01.2005|Kampung Baru
14.05.01.2006|Lubuk Kembang Bunga
14.05.01.2007|Lubuk Kembang Sari
14.05.01.2008|Silikuan Hulu
14.05.01.2009|Tri Mulya Jaya
14.05.01.2011|Ukui Dua
14.05.01.2012|Bagan Limau
14.05.02.1007|Pangkalan Kerinci Barat
14.05.02.1008|Pangkalan Kerinci Kota
14.05.02.1009|Pangkalan Kerinci Timur
14.05.02.2001|Mekar Jaya
14.05.02.2002|Kuala Terusan
14.05.02.2003|Makmur
14.05.02.2005|Rantau Baru
14.05.03.1001|Sorek I
14.05.03.2002|Sorek II
14.05.03.2003|Dundangan
14.05.03.2004|Palas
14.05.03.2005|Terantang Manuk
14.05.03.2006|Kemang
14.05.03.2007|Talau
14.05.03.2008|Tanjung Beringin
14.05.03.2009|Betung
14.05.03.2010|Kesuma
14.05.03.2011|Surya Indah
14.05.03.2012|Sialang Indah
14.05.03.2013|Beringin Indah
14.05.03.2014|Meranti
14.05.03.2015|Harapan Jaya
14.05.03.2016|Batang Kulim
14.05.03.2017|Sidomukti
14.05.04.1001|Pangkalan Lesung
14.05.04.2002|Dusun Tua
14.05.04.2003|Genduang
14.05.04.2004|Mayang Sari
14.05.04.2005|Rawang Sari
14.05.04.2006|Mulya Subur
14.05.04.2007|Sari Mulya
14.05.04.2008|Sari Makmur
14.05.04.2009|Tanjung Kuyo
14.05.04.2010|Pesaguan
14.05.05.1001|Langgam
14.05.05.2002|Tambak
14.05.05.2003|Penarikan
14.05.05.2004|Segati
14.05.05.2005|Sotol
14.05.05.2006|Pangkalan Gondai
14.05.05.2007|Langkan
14.05.05.2008|Padang Luas
14.05.06.1001|Pelalawan
14.05.06.2002|Sungai Ara
14.05.06.2003|Ransang
14.05.06.2004|Kuala Tolam
14.05.06.2005|Sering
14.05.06.2006|Telayap
14.05.06.2007|Batang Nilo Kecil
14.05.06.2008|Delik
14.05.06.2010|Lalang Kabung
14.05.07.1001|Kerumutan
14.05.07.2002|Pangkalan Panduk
14.05.07.2003|Pangkalan Tampui
14.05.07.2004|Bukit Lembah Subur
14.05.07.2005|Banjar Panjang
14.05.07.2006|Beringin Makmur
14.05.07.2007|Pematang Tinggi
14.05.07.2008|Tanjung Air Hitam
14.05.07.2009|Mak Teduh
14.05.07.2010|Lipai Bulan
14.05.08.1011|Pangkalan Bunut
14.05.08.2001|Petani
14.05.08.2002|Merbau
14.05.08.2003|Sungai Buluh
14.05.08.2008|Lubuk Mas
14.05.08.2009|Balam Merah
14.05.08.2010|Bagan Laguh
14.05.08.2013|Lubuk Mandian Gajah
14.05.08.2017|Keriung
14.05.08.2018|Sialang Kayu Batu
14.05.09.1001|Teluk Meranti
14.05.09.2002|Kuala Panduk
14.05.09.2003|Petodaan
14.05.09.2004|Teluk Binjai
14.05.09.2005|Pulau Muda
14.05.09.2006|Gambut Mutiara
14.05.09.2007|Labuhan Bilik
14.05.09.2008|Pangkalan Terap
14.05.09.2009|Segamai
14.05.10.1001|Teluk Dalam
14.05.10.2002|Tanjung Sum
14.05.10.2003|Sungai Solok
14.05.10.2004|Sungai Upih
14.05.10.2005|Teluk
14.05.10.2006|Serapung
14.05.10.2007|Teluk Beringin
14.05.10.2008|Sokoi
14.05.10.2009|Sungai Mas
14.05.10.2010|Teluk Bakau
14.05.11.1001|Sei Kijang
14.05.11.2002|Lubuk Ogung
14.05.11.2003|Simpang Beringin
14.05.11.2004|Muda Setia
14.05.11.2005|Kiab Jaya
14.05.12.1002|Rawang Empat
14.05.12.2001|Kuala Semundam
14.05.12.2003|Tambun
14.05.12.2004|Terbangiang
14.05.12.2005|Lubuk Terap
14.05.12.2006|Angkasa
14.05.12.2007|Sialang Godang
14.05.12.2008|Lubuk Raja
14.05.12.2009|Lubuk Keranji Timur
14.05.12.2010|Airterjun
14.05.12.2011|Sialang Bungkuk
14.06.01.1001|Ujung Batu
14.06.01.2002|Suka Damai
14.06.01.2003|Ngaso
14.06.01.2004|Ujung Batu Timur
14.06.01.2005|Pematang Tebih
14.06.02.1001|Rokan
14.06.02.2002|Cipang Kanan
14.06.02.2003|Cipang Kiri Hulu
14.06.02.2004|Cipang Kiri Hilir
14.06.02.2006|Tanjung Medan
14.06.02.2007|Lubuk Bendahara Timur
14.06.02.2008|Lubuk Bendahara
14.06.02.2010|Sikebau Jaya
14.06.02.2013|Rokan Koto Ruang
14.06.02.2014|Rokan Timur
14.06.02.2016|Lubuk Betung
14.06.02.2017|Pemandang
14.06.02.2018|Alahan
14.06.02.2019|Tibawan
14.06.03.1001|Pasir Pengarayan
14.06.03.2002|Rambah Tengah Utara
14.06.03.2003|Rambah Tengah Hilir
14.06.03.2004|Rambah Tengah Hulu
14.06.03.2005|Rambah Tengah Barat
14.06.03.2006|Menaming
14.06.03.2007|Pasir Baru
14.06.03.2008|Sialang Jaya
14.06.03.2009|Tanjung Belit
14.06.03.2010|Koto Tinggi
14.06.03.2011|Suka Maju
14.06.03.2012|Pematang Berangan
14.06.03.2013|Babussalam
14.06.03.2014|Pasir Maju
14.06.04.1001|Tambusai Tengah
14.06.04.2002|Tambusai Barat
14.06.04.2003|Tambusai Timur
14.06.04.2004|Batas
14.06.04.2005|Talikumain
14.06.04.2006|Rantau Panjang
14.06.04.2007|Sungai Kumango
14.06.04.2008|Batang Kumu
14.06.04.2009|Sialang Rindang
14.06.04.2010|Suka Maju
14.06.04.2011|Lubuk Soting
14.06.04.2012|Tingkok
14.06.05.1001|KepenuhanTengah
14.06.05.2003|Kepenuhan Barat
14.06.05.2004|Kepenuhan Hilir
14.06.05.2005|Kepenuhan Timur
14.06.05.2006|Kepenuhan Barat Sei Rokan Jaya
14.06.05.2007|Kepenuhan Raya
14.06.05.2008|Kepenuhan Baru
14.06.05.2009|Kepenuhan Barat Mulya
14.06.05.2010|Ulak Patian
14.06.05.2012|Rantau Binuang Sakti
14.06.06.1001|Kota Lama
14.06.06.2003|Kota Intan
14.06.06.2004|Muara Dilam
14.06.06.2008|Kota Raya
14.06.06.2009|Kota Baru
14.06.06.2010|Sungai Kuti
14.06.06.2011|Pasir Indah
14.06.06.2012|Pasir Luhur
14.06.06.2017|Bukit Intan Makmur
14.06.06.2018|Bagan Tujuh
14.06.07.2001|Rambah Samo
14.06.07.2002|Rambah Samo Barat
14.06.07.2003|Rambah Baru
14.06.07.2004|Rambah Utama
14.06.07.2005|Pasir Makmur
14.06.07.2006|Karya Mulya
14.06.07.2007|Marga Mulya
14.06.07.2008|Langkitin
14.06.07.2009|Masda Makmur
14.06.07.2010|Lubuk Napal
14.06.07.2011|Teluk Aur
14.06.07.2012|Sei Salak
14.06.07.2013|Sei Kuning
14.06.07.2014|Lubuk Bilang
14.06.08.2001|Rambah Hilir
14.06.08.2002|Rambah Hilir Tengah
14.06.08.2003|Rambah Hilir Timur
14.06.08.2004|Pasir Utama
14.06.08.2005|Pasir Jaya
14.06.08.2006|Rambah Muda
14.06.08.2007|Sungai Sitolang
14.06.08.2008|Lubuk Kerapat
14.06.08.2009|Rambah
14.06.08.2010|Serombou Indah
14.06.08.2011|Sungai Dua Indah
14.06.08.2012|Muara Musu
14.06.08.2013|Sejati
14.06.09.2001|Tambusai Utara
14.06.09.2002|Mahato
14.06.09.2003|Bangun Jaya
14.06.09.2004|Simpang Harapan
14.06.09.2005|Pagar Mayang
14.06.09.2006|Payung Sekaki
14.06.09.2007|Mekar Jaya
14.06.09.2008|Tanjung Medan
14.06.09.2009|Suka Damai
14.06.09.2010|Rantau Sakti
14.06.09.2011|Mahato Sakti
14.06.10.2001|Pasir Agung
14.06.10.2002|Pasir Intan
14.06.10.2003|Rambah Jaya
14.06.10.2004|Bangun Purba
14.06.10.2005|Bangun Purba Timur Jaya
14.06.10.2006|Bangun Purba Barat
14.06.10.2007|Tangun
14.06.11.2001|Tandun
14.06.11.2002|Kumain
14.06.11.2003|Bono Tapung
14.06.11.2004|Dayo
14.06.11.2005|Tapung Jaya
14.06.11.2006|Puo Raya
14.06.11.2007|Sei Kuning
14.06.11.2008|Koto Tandun
14.06.11.2009|Tandun Barat
14.06.12.2001|Kabun
14.06.12.2002|Aliantan
14.06.12.2003|Koto Ranah
14.06.12.2004|Boncah Kesuma
14.06.12.2005|Batu Langkah Besar
14.06.12.2006|Giti
14.06.13.2001|Teluk Sono
14.06.13.2002|Sontang
14.06.13.2003|Bonai
14.06.13.2004|Rawa Makmur
14.06.13.2005|Pauh
14.06.13.2006|Kasang Padang
14.06.13.2007|Kasang Mungkal
14.06.14.2001|Pagaran Tapah
14.06.14.2002|Kembang Damai
14.06.14.2005|Sangkir Indah
14.06.15.2001|Kepenuhan Hulu
14.06.15.2002|Pekan Tebih
14.06.15.2003|Kepayang
14.06.15.2004|Muara Jaya
14.06.15.2005|Kepenuhan Jaya
14.06.16.2001|Pendalian
14.06.16.2002|Bengkolan Salak
14.06.16.2003|Suligi
14.06.16.2004|Air Panas
14.06.16.2005|Sei Kandis
14.07.01.1010|Telukmerbau
14.07.01.2002|Tanjungleban
14.07.01.2003|Sungaikubu
14.07.01.2004|Rantau Panjang Kanan
14.07.01.2012|Telukpiyai
14.07.01.2013|Sungaisegajah
14.07.01.2015|Sei Segajah Makmur
14.07.01.2020|Telukpiyai Pesisir
14.07.01.2021|Sungaikubu Hulu
14.07.01.2022|Sungai Segajah Jaya
14.07.02.1011|Bagan Punak
14.07.02.1012|Bagan Kota
14.07.02.1015|Bagan Hulu
14.07.02.1016|Bagan Barat
14.07.02.1017|Bagan Timur
14.07.02.2009|Labuhan Tangga Kecil
14.07.02.2010|Labuhan Tangga Besar
14.07.02.2013|Bagan Jawa
14.07.02.2014|Parit Aman
14.07.02.2019|Labuhan Tangga Baru
14.07.02.2021|Bagan Jawa Pesisir
14.07.02.2022|Serusa
14.07.02.2023|Labuhan Tangga Hilir
14.07.02.2024|Bagan Punak Meranti
14.07.02.2025|Bagan Punak Pesisir
14.07.03.1007|Sedinginan
14.07.03.1010|Banjar XII
14.07.03.1019|Cempedak Rahuk
14.07.03.2001|Ujung Tanjung
14.07.03.2002|Rantau Bais
14.07.03.2005|Sekeladi
14.07.03.2006|Teluk Mega
14.07.03.2008|Putat
14.07.03.2009|Sintong
14.07.03.2011|Mumugo
14.07.03.2012|Teluk Berembun
14.07.03.2013|Menggala Sakti
14.07.03.2014|Sekeladi Hilir
14.07.03.2015|Menggala Sempurna
14.07.03.2016|Sintong Pusaka
14.07.03.2017|Sintong Bakti
14.07.03.2018|Sintong Makmur
14.07.04.1001|Rimba Melintang
14.07.04.2002|Jumrah
14.07.04.2003|Telukpulau Hilir
14.07.04.2004|Telukpulau Hulu
14.07.04.2005|Langgadai Hulu
14.07.04.2006|Lenggadai Hilir
14.07.04.2007|Mukti Jaya
14.07.04.2008|Karya Mukti
14.07.04.2009|Harapan Jaya
14.07.04.2010|Seremban Jaya
14.07.04.2011|Pematang Botam
14.07.04.2012|Pematang Sikek
14.07.05.1018|Bagan Batu Kota
14.07.05.1019|Bahtera Makmur Kota
14.07.05.2002|Bagan Batu
14.07.05.2003|Bahtera Makmur
14.07.05.2007|Pelita
14.07.05.2008|Gelora
14.07.05.2015|Suka Maju
14.07.05.2016|Bagan Manunggal
14.07.05.2017|Bagan Sapta Permai
14.07.05.2025|Bakti Makmur
14.07.05.2028|Jaya Agung
14.07.05.2030|Meranti Makmur
14.07.05.2031|Bhayangkara Jaya
14.07.06.1007|Panipahan
14.07.06.2001|Panipahan
14.07.06.2002|Telukpulai
14.07.06.2003|Pasir Limau Kapas
14.07.06.2004|Sungai Daun
14.07.06.2005|Panipahan Darat
14.07.06.2006|Panipahan Laut
14.07.06.2008|Pulaujemur
14.07.07.1005|Sinaboi Kota
14.07.07.2001|Sinaboi
14.07.07.2002|Sei Bakau
14.07.07.2003|Raja Bejamu
14.07.07.2004|Sungai Nyamuk
14.07.07.2006|Darussalam
14.07.08.1010|Pujud Selatan
14.07.08.2001|Teluk Nayang
14.07.08.2002|Pujud
14.07.08.2003|Air Hitam
14.07.08.2004|Kasang Bangsawan
14.07.08.2005|Sungaipinang
14.07.08.2008|Siarang-arang
14.07.08.2011|Suka Jadi
14.07.08.2015|Pujud Utara
14.07.08.2016|Babussalam Rokan
14.07.08.2017|Perkebunan Siarang-arang
14.07.09.1005|Melayu Besar Kota
14.07.09.2001|Melayu Besar
14.07.09.2002|Melayu Tengah
14.07.09.2003|Batu Hampar
14.07.09.2004|Mesah
14.07.09.2006|Labuhan Papan
14.07.10.1001|Bangko Kanan
14.07.10.1006|Bangko Kiri
14.07.10.2002|Bangko Jaya
14.07.10.2003|Bangko Sempurna
14.07.10.2004|Bangko Bakti
14.07.10.2005|Bangko Pusako
14.07.10.2007|Sei Manasib
14.07.10.2008|Teluk Bano I
14.07.10.2009|Bangko Makmur
14.07.10.2010|Pematang Damar
14.07.10.2011|Pematang Ibul
14.07.10.2012|Bangko Permata
14.07.10.2013|Bangko Mukti
14.07.10.2014|Bangko Lestari
14.07.10.2015|Bangko Balam
14.07.10.2016|Bangko Mas Raya
14.07.11.1001|Simpang Kanan
14.07.11.2002|Kota Parit
14.07.11.2003|Bagan Nibung
14.07.11.2004|Bukit Damar
14.07.11.2005|Bukit Mas
14.07.11.2006|Bukit Selamat
14.07.12.1004|Bantayan Hilir
14.07.12.2001|Bantaian
14.07.12.2002|Sungaisialang
14.07.12.2003|Bantayan Baru
14.07.12.2005|Sungaisialang Hulu
14.07.13.1002|Rantau Kopar
14.07.13.1003|Sungai Rangau
14.07.13.2001|Sekapas
14.07.13.2004|Bagan Cempedak
14.07.14.2001|Pedamaran
14.07.14.2002|Rokan Baru
14.07.14.2003|Sei Besar
14.07.14.2004|Suak Temenggung
14.07.14.2005|Teluk Bano II
14.07.14.2006|Pekaitan
14.07.14.2007|Suak Air Hitam
14.07.14.2008|Kubu I
14.07.14.2009|Karyo Mulyo Sari
14.07.14.2010|Rokan Baru Pesisir
14.07.15.2001|Rantau Panjang Kiri
14.07.15.2002|Teluknilap
14.07.15.2003|Sungaimajo
14.07.15.2004|Sungaipinang
14.07.15.2005|Sungaipanji-panji
14.07.15.2006|Jojol
14.07.15.2007|Pulauhalang Muka
14.07.15.2008|Pulauhalang Belakang
14.07.15.2009|Rantau Panjang Kiri Hilir
14.07.15.2010|Teluknilap Jaya
14.07.15.2011|Sungaimajo Pusako
14.07.15.2012|Pulauhalang Hulu
14.07.16.2001|Tanjung Medan
14.07.16.2002|Tanjung Medan Utara
14.07.16.2003|Tanjung Medan Barat
14.07.16.2004|Sei Meranti
14.07.16.2005|Sei Meranti Darussalam
14.07.16.2006|Akar Belingkar
14.07.16.2007|Tangga Batu
14.07.16.2008|Perkebunan Tanjung Medan
14.07.16.2009|Sri Kayangan
14.07.16.2010|Pondok Kresek
14.07.16.2011|Sungai Tapah
14.07.16.2012|Tanjung Sari
14.07.17.1001|Bagan Sinembah Kota
14.07.17.2002|Bagan Sinembah
14.07.17.2003|Harapan Makmur Selatan
14.07.17.2004|Harapan Makmur
14.07.17.2005|Makmur Jaya
14.07.17.2006|Salak
14.07.17.2007|Panca Mukti
14.07.17.2008|Bagansinembah Timur
14.07.17.2009|Bagansinembah Utara
14.07.17.2010|Bagansinembah Barat
14.07.18.1001|Balai Jaya Kota
14.07.18.1002|Balam Sempurna Kota
14.07.18.2003|Balam Jaya
14.07.18.2004|Balai Jaya
14.07.18.2005|Balam Sempurna
14.07.18.2006|Bagan Bhakti
14.07.18.2007|Kencana
14.07.18.2008|Pasir Putih
14.07.18.2009|Pasir Putih Utara
14.07.18.2010|Pasir Putih Barat
14.07.18.2011|Lubuk Jawi
14.08.01.1001|Kampung Dalam
14.08.01.1002|Kampung Rempak
14.08.01.2003|Langkai
14.08.01.2011|Tumang
14.08.01.2012|Merempan Hulu
14.08.01.2013|Rawang Air Putih
14.08.01.2014|Suak Lanjut
14.08.01.2015|Buantan Besar
14.08.02.1001|Sungai Apit
14.08.02.2002|Teluk Lanus
14.08.02.2003|Tanjung Kuras
14.08.02.2004|Parit I/II
14.08.02.2005|Teluk Mesjid
14.08.02.2008|Sungai Kayu Ara
14.08.02.2009|Lalang
14.08.02.2010|Mengkapan
14.08.02.2011|Sungai Rawa
14.08.02.2012|Penyengat
14.08.02.2014|Teluk Batil
14.08.02.2016|Bunsur
14.08.02.2017|Harapan
14.08.02.2019|Kayu Ara Permai
14.08.02.2020|Rawa Mekar Jaya
14.08.03.1001|Minas Jaya
14.08.03.2002|Minas Timur
14.08.03.2003|Minas Barat
14.08.03.2004|Mandi Angin
14.08.03.2005|Rantau Bertuah
14.08.04.1001|Perawang
14.08.04.2002|Tualang
14.08.04.2003|Pinang Sebatang
14.08.04.2004|Meredan
14.08.04.2005|Pinang Sebatang Timur
14.08.04.2006|Pinang Sebatang Barat
14.08.04.2007|Meredan Barat
14.08.04.2008|Perawang Barat
14.08.04.2009|Tualang Timur
14.08.05.2001|Muara Kelantan
14.08.05.2002|Teluk Lancang
14.08.05.2003|Sungai Selodang
14.08.05.2004|Olak
14.08.05.2005|Lubuk Jering
14.08.05.2006|Muara Bungkal
14.08.05.2007|Lubuk Umbut
14.08.05.2008|Bencah Umbai
14.08.05.2009|Tasik Betung
14.08.06.2001|Dayun
14.08.06.2002|Banjar Seminai
14.08.06.2003|Teluk Merbau
14.08.06.2004|Merangkai
14.08.06.2005|Lubuk Tilan
14.08.06.2006|Berumbung Baru
14.08.06.2007|Pangkalan Makmur
14.08.06.2008|Buana Makmur
14.08.06.2009|Suka Mulya
14.08.06.2010|Sawit Permai
14.08.06.2011|Sialang Sakti
14.08.07.2001|Kerinci Kanan
14.08.07.2002|Kerinci Kiri
14.08.07.2003|Buana Bakti
14.08.07.2004|Bukit Harapan
14.08.07.2005|Kumbara Utama
14.08.07.2006|Bukit Agung
14.08.07.2008|Simpang Perak Jaya
14.08.07.2009|Buatan Baru
14.08.07.2010|Gabung Makmur
14.08.07.2011|Jati Mulya
14.08.07.2012|Seminai
14.08.07.2013|Delima Jaya
14.08.08.2001|Bunga Raya
14.08.08.2002|Jati Baru
14.08.08.2003|Jayapura
14.08.08.2011|Kemuning Muda
14.08.08.2012|Buatan Lestari
14.08.08.2013|Tuah Indrapura
14.08.08.2014|Langsat Permai
14.08.08.2015|Temusai
14.08.08.2016|Dayang Suri
14.08.08.2017|Suak Merambai
14.08.09.2001|Pangkalan Pisang
14.08.09.2002|Kuala Gasib
14.08.09.2003|Teluk Rimba
14.08.09.2004|Buatan I
14.08.09.2005|Buatan II
14.08.09.2006|Sengkemang
14.08.09.2007|Rantau Panjang
14.08.09.2008|Empang Pandan
14.08.09.2009|Keranji Guguh
14.08.09.2010|Sri Gemilang
14.08.09.2011|Tasik Seminai
14.08.10.1001|Simpang Belutu
14.08.10.1002|Telaga Sam-sam
14.08.10.1003|Kandis Kota
14.08.10.2004|Belutu
14.08.10.2005|Kandis
14.08.10.2006|Sam-Sam
14.08.10.2007|Bekalar
14.08.10.2008|Jambai Makmur
14.08.10.2009|Sungai Gondang
14.08.10.2010|Pencing Bekulo
14.08.10.2011|Libo Jaya
14.08.11.2001|Lubuk Dalam
14.08.11.2002|Rawang Kao
14.08.11.2003|Sri Gading
14.08.11.2004|Sialang Baru
14.08.11.2005|Sialang Palas
14.08.11.2006|Empang Baru
14.08.11.2007|Rawang Kao Barat
14.08.12.2001|Bandar Sungai
14.08.12.2002|Rempak
14.08.12.2003|Belading
14.08.12.2004|Sungai Tengah
14.08.12.2005|Laksamana
14.08.12.2006|Sabak Permai
14.08.12.2007|Bandar Pedada
14.08.12.2008|Selat Guntung
14.08.13.1006|Sungaimempura
14.08.13.2001|Kota Ringin
14.08.13.2002|Paluh
14.08.13.2003|Benteng Hilir
14.08.13.2004|Benteng Hulu
14.08.13.2005|Kampung Tengah
14.08.13.2007|Merempan Hilir
14.08.13.2008|Telukmerempan
14.08.14.2001|Sungai Berbari
14.08.14.2002|Sungai Limau
14.08.14.2003|Dosan
14.08.14.2004|Benayah
14.08.14.2005|Pebadaran
14.08.14.2006|Dusun Pusaka
14.08.14.2007|Perincit
14.09.01.1012|Pasar Lubuk Jambi
14.09.01.2004|Air Buluh
14.09.01.2005|Pantai
14.09.01.2007|Lubuk Ramo
14.09.01.2008|Seberang Cengar
14.09.01.2009|Koto Cengar
14.09.01.2010|Sangau
14.09.01.2011|Banjar Padang
14.09.01.2013|Kasang
14.09.01.2014|Koto Lubuk Jambi
14.09.01.2015|Pulaubinjai
14.09.01.2016|Seberang Pantai
14.09.01.2017|Rantau Sialang
14.09.01.2018|Luai
14.09.01.2019|Banjar Guntung
14.09.01.2020|Bukitpedusunan
14.09.01.2021|Saik
14.09.01.2022|Pebaun Hulu
14.09.01.2023|Pebaun Hilir
14.09.01.2024|Kinali
14.09.01.2025|Bukit Kauman
14.09.01.2026|Aur Duri
14.09.01.2027|Sungaimanau
14.09.01.2030|Muaro Tombang
14.09.02.1016|Pasar Teluk
14.09.02.1018|Simpang Tiga
14.09.02.1025|Sungaijering
14.09.02.2001|Bandar Alai
14.09.02.2002|Pulaukedundung
14.09.02.2003|Pulauaro
14.09.02.2004|Seberang Taluk
14.09.02.2005|Pulau Baru
14.09.02.2006|Koto Tuo
14.09.02.2007|Kopah
14.09.02.2008|Munsalo
14.09.02.2014|Sawah
14.09.02.2015|Koto Taluk
14.09.02.2017|Koto Kari
14.09.02.2019|Pintu Gobang
14.09.02.2020|Jake
14.09.02.2021|Pulau Godang Kari
14.09.02.2022|Jaya
14.09.02.2023|Beringin Taluk
14.09.02.2024|Sitorajo
14.09.02.2026|Seberang Taluk Hilir
14.09.02.2027|Titian Modang Kopah
14.09.02.2028|Pulaubanjar Kari
14.09.03.1003|Muara Lembu
14.09.03.2001|Pangkalan Indarung
14.09.03.2002|Pulaupadang
14.09.03.2004|Logas
14.09.03.2005|Kebun Lado
14.09.03.2006|Sungaikuning
14.09.03.2007|Sungaisirih
14.09.03.2008|Sungaibawang
14.09.03.2009|Air Emas
14.09.03.2010|Pasir Emas
14.09.03.2011|Petai Baru
14.09.03.2012|Sungaikeranji
14.09.03.2013|Sumber Datar
14.09.03.2014|Logas Hilir
14.09.04.1001|Pasar Usang
14.09.04.1002|Pasar Baru
14.09.04.2003|Simpang Tanah Lapang
14.09.04.2004|Rawang Bonto
14.09.04.2005|Koto Tuo
14.09.04.2006|Banuaran
14.09.04.2007|Kampung Madura
14.09.04.2009|Pulau Kijang
14.09.04.2015|Pulaumadinah
14.09.04.2016|Kampung Tengah
14.09.04.2017|Kampung Medan
14.09.04.2018|Kepala Pulau
14.09.04.2019|Teratak Baru
14.09.04.2020|Dusun Tuo
14.09.04.2028|Gunungmelintang
14.09.04.2030|Simpang Pulauberalo
14.09.05.1001|Pasar Cerenti
14.09.05.1002|Koto Peraku
14.09.05.2003|Kompe Berangin
14.09.05.2004|Sikakak
14.09.05.2005|Kampung Baru
14.09.05.2006|Pulaujambu
14.09.05.2007|Koto Cerenti
14.09.05.2008|Pulaubayur
14.09.05.2009|Pulau Panjang Cerenti
14.09.05.2010|Pesikaian
14.09.05.2011|Telukpauh
14.09.05.2012|Tanjungmedan
14.09.05.2013|Kampung Baru Timur
14.09.06.1001|Benai
14.09.06.2003|Banjar Benai
14.09.06.2004|Talontom
14.09.06.2005|Gunungkesiangan
14.09.06.2006|Pulaukalimanting
14.09.06.2007|Banjar Lopak
14.09.06.2008|Tanjungsimandolak
14.09.06.2009|Siberakun
14.09.06.2010|Pulautongah
14.09.06.2011|Ujung Tanjung
14.09.06.2012|Pulauingu
14.09.06.2013|Simandolak
14.09.06.2014|Tebing Tinggi
14.09.06.2015|Pulaulancang
14.09.06.2016|Benai Kecil
14.09.06.2021|Koto Benai
14.09.07.2001|Pulaumungkur
14.09.07.2002|Telukberingin
14.09.07.2003|Pulaurumput
14.09.07.2004|Seberang Gunung
14.09.07.2005|Teberau Panjang
14.09.07.2006|Koto Gunung
14.09.07.2007|Gunung
14.09.07.2008|Toar
14.09.07.2009|Petapahan
14.09.07.2010|Kampung Baru
14.09.07.2011|Pisang Berebus
14.09.07.2012|Lubuk Terentang
14.09.07.2013|Siberobah
14.09.07.2014|Seberang Sungai
14.09.08.2001|Koto Baru
14.09.08.2002|Petai
14.09.08.2003|Sungaipaku
14.09.08.2004|Tanjungpauh
14.09.08.2005|Simpang Raya
14.09.08.2006|Sungaibuluh
14.09.08.2007|Suka Damai
14.09.08.2008|Sumber Jaya
14.09.08.2009|Muara Bahan
14.09.08.2010|Bukitraya
14.09.08.2011|Beringin Jaya
14.09.08.2012|Suka Maju
14.09.09.2001|Pasar Baru Pangean
14.09.09.2002|Koto Pangean
14.09.09.2003|Pulaukumpai
14.09.09.2004|Pulautongah
14.09.09.2005|Pulauderas
14.09.09.2006|Telukpauh
14.09.09.2007|Tanah Bekali
14.09.09.2008|Padang Tanggung
14.09.09.2009|Padang Kunik
14.09.09.2010|Pembatang
14.09.09.2011|Pauh Angit
14.09.09.2012|Sukaping
14.09.09.2013|Pulaurengas
14.09.09.2014|Rawang Binjai
14.09.09.2015|Sako
14.09.09.2016|Sungailangsat
14.09.09.2017|Pauh Angit Hulu
14.09.10.2001|Perhentian Luas
14.09.10.2002|Logas
14.09.10.2003|Lubuk Kebun
14.09.10.2004|Sungai Rambai
14.09.10.2005|Situgal
14.09.10.2006|Rambahan
14.09.10.2007|Teratak Rendah
14.09.10.2008|Sikijang
14.09.10.2009|Sukaraja
14.09.10.2010|Sako Margasari
14.09.10.2011|Kuantan Sako
14.09.10.2012|Hulu Teso
14.09.10.2013|Giri Sako
14.09.10.2014|Bumi Mulya
14.09.10.2015|Sidodadi
14.09.11.2001|Pasar Inuman
14.09.11.2002|Koto Inuman
14.09.11.2003|Pulaupanjang Hulu
14.09.11.2004|Pulaupanjang Hilir
14.09.11.2005|Sigaruntang
14.09.11.2006|Pulaubusuk
14.09.11.2007|Bedeng Sikuran
14.09.11.2008|Banjar Nan Tigo
14.09.11.2009|Pulausipan
14.09.11.2010|Pulaubusuk Jaya
14.09.11.2011|Seberang Pulau Busuk
14.09.11.2012|Lebuh Lurus
14.09.11.2013|Kampung Baru Koto
14.09.11.2014|Ketaping Jaya
14.09.12.2001|Lubuk Ambacang
14.09.12.2002|Sungaikelelawar
14.09.12.2003|Tanjung
14.09.12.2004|Sungaipinang
14.09.12.2005|Sungaialah
14.09.12.2006|Koto Kombu
14.09.12.2007|Sumpu
14.09.12.2008|Mudik Ulo
14.09.12.2009|Inuman
14.09.12.2010|Tanjungmedang
14.09.12.2011|Serosa
14.09.12.2012|Sampurago
14.09.13.2001|Pulaubaru
14.09.13.2002|Pulauberalo
14.09.13.2003|Pulaukulur
14.09.13.2004|Pelukahan
14.09.13.2005|Pengalihan
14.09.13.2006|Lumbok
14.09.13.2007|Teratak Jering
14.09.13.2008|Tanjungpisang
14.09.13.2009|Danau
14.09.13.2010|Kasang Limau Sundai
14.09.13.2011|Koto Rajo
14.09.13.2012|Tanjung
14.09.13.2013|Sungaisorik
14.09.13.2014|Rawang Oguang
14.09.14.1015|Beringin Jaya
14.09.14.2001|Pulaukomang Sentajo
14.09.14.2002|Muaro Sentajo
14.09.14.2003|Koto Sentajo
14.09.14.2004|Kampungbaru Sentajo
14.09.14.2005|Pulaukopung Sentajo
14.09.14.2006|Teratak Air Hitam
14.09.14.2007|Seberang Teratak Air Hitam
14.09.14.2008|Parit Teratak Air Hitam
14.09.14.2009|Jalur Patah
14.09.14.2010|Geringing Baru
14.09.14.2011|Marsawa
14.09.14.2012|Langsat Hulu
14.09.14.2013|Muara Langsat
14.09.14.2014|Geringging Jaya
14.09.15.2001|Perhentian Sungkai
14.09.15.2002|Ibul
14.09.15.2003|Muarapetai
14.09.15.2004|Pangkalan
14.09.15.2005|Sungaibesar
14.09.15.2006|Setiang
14.09.15.2007|Muaro Tiu Makmur
14.09.15.2008|Muaratobek
14.09.15.2009|Sungaibesar Hilir
14.09.15.2010|Kampung Baru Ibul
14.10.01.1001|Selatpanjang Kota
14.10.01.1002|Selatpanjang Barat
14.10.01.1003|Selatpanjang Selatan
14.10.01.1004|Selatpanjang Timur
14.10.01.2005|Banglas
14.10.01.2006|Alah Air
14.10.01.2007|Alah Air Timur
14.10.01.2008|Sesap
14.10.01.2016|Banglas Barat
14.10.02.2001|Segomeng
14.10.02.2002|Bantar
14.10.02.2003|Anak Setatah
14.10.02.2004|Lemang
14.10.02.2005|Bokor
14.10.02.2006|Sungai Cina
14.10.02.2007|Melai
14.10.02.2011|Telaga Baru
14.10.02.2012|Bina Maju
14.10.02.2015|Sialang Pasung
14.10.02.2016|Permai
14.10.02.2017|Mekar Baru
14.10.03.2001|Tanjung Samak
14.10.03.2002|Tanjung Medang
14.10.03.2004|Gemala Sari
14.10.03.2007|Topang
14.10.03.2008|Penyagun
14.10.03.2010|Repan
14.10.03.2011|Tanjung Bakau
14.10.03.2012|Teluk Samak
14.10.03.2013|Sungai Gayung Kiri
14.10.03.2014|Citra Damai
14.10.03.2016|Dwi Tunggal
14.10.03.2017|Wonosari
14.10.03.2018|Tebun
14.10.03.2020|Tanjung Gemuk
14.10.04.2001|Alai
14.10.04.2002|Tenan
14.10.04.2003|Insit
14.10.04.2004|Tanjung
14.10.04.2005|Tanjung Peranap
14.10.04.2006|Kundur
14.10.04.2007|Mekong
14.10.04.2008|Batang Malas
14.10.04.2009|Mantiasa
14.10.04.2010|Gogok Darussalam
14.10.04.2011|Maini Darul Aman
14.10.04.2012|Mengkikip
14.10.04.2013|Alai Selatan
14.10.04.2014|Tanjung Darul Takzim
14.10.05.1001|Teluk Belitung
14.10.05.2002|Meranti Bunting
14.10.05.2003|Lukit
14.10.05.2004|Bagan Melibur
14.10.05.2018|Pelantai
14.10.05.2019|Tanjung Kulim
14.10.05.2021|Mekar Sari
14.10.05.2023|Mayang Sari
14.10.05.2026|Sungai Anak Kamal
14.10.05.2027|Sungai Tengah
14.10.06.2001|Kuala Merbau
14.10.06.2002|Renak Dungun
14.10.06.2003|Baran Melintang
14.10.06.2004|Teluk Ketapang
14.10.06.2005|Semukut
14.10.06.2006|Centai
14.10.06.2007|Tanjungbunga
14.10.06.2008|Batang Meranti
14.10.06.2009|Pangkalan Balai
14.10.06.2010|Padang Kamal
14.10.06.2011|Ketapang Permai
14.10.07.2001|Lukun
14.10.07.2002|Sungai Tohor
14.10.07.2003|Nipah Sendanu
14.10.07.2004|Tanjung Sari
14.10.07.2005|Tanjung Gadai
14.10.07.2006|Teluk Buntal
14.10.07.2007|Kepau Baru
14.10.07.2008|Sungai Tohor Barat
14.10.07.2009|Sendanu Darul Ihsan
14.10.07.2010|Batin Suir
14.10.08.2001|Tanjung Padang
14.10.08.2002|Putri Puyu
14.10.08.2003|Mekar Delima
14.10.08.2004|Dedap
14.10.08.2005|Kudap
14.10.08.2006|Bandul
14.10.08.2007|Selat Akar
14.10.08.2008|Tanjung Pisang
14.10.08.2009|Mengkopot
14.10.08.2010|Mengkirau
14.10.09.2001|Tanjung Kedabu
14.10.09.2002|Beting
14.10.09.2003|Sokop
14.10.09.2004|Telesung
14.10.09.2005|Bungur
14.10.09.2006|Tenggayun Raya
14.10.09.2007|Sendaur
14.10.09.2008|Kayu Ara
14.10.09.2009|Sonde
14.10.09.2010|Kedabu Rapat
14.10.09.2011|Tanah Merah
14.71.01.1002|Jadirejo
14.71.01.1003|Kampung Tengah
14.71.01.1004|Kampung Melayu
14.71.01.1005|Kedung Sari
14.71.01.1006|Harjosari
14.71.01.1007|Sukajadi
14.71.01.1008|Pulau Karomah
14.71.02.1001|Simpang Empat
14.71.02.1002|Sumahilang
14.71.02.1003|Tanah Datar
14.71.02.1004|Kota Baru
14.71.02.1005|Sukaramai
14.71.02.1006|Kota Tinggi
14.71.03.1001|Cinta Raja
14.71.03.1002|Sukamulya
14.71.03.1003|Sukamaju
14.71.04.1001|Rintis
14.71.04.1002|Tanjung RHU
14.71.04.1003|Pesisir
14.71.04.1004|Sekip
14.71.05.1001|Padang Bulan
14.71.05.1002|Sago
14.71.05.1003|Kampung Baru
14.71.05.1004|Kampung Dalam
14.71.05.1005|Kampung Bandar
14.71.05.1006|Padang Terubuk
14.71.06.1003|Rumbai Bukit
14.71.06.1005|Muarafajar Timur
14.71.06.1010|Muarafajar Barat
14.71.06.1011|Rantaupanjang
14.71.06.1012|Maharani
14.71.06.1013|Agrowisata
14.71.07.1005|Simpang Tiga
14.71.07.1006|Tangkerang Selatan
14.71.07.1008|Tangkerang Utara
14.71.07.1011|Tangkerang Labuai
14.71.07.1012|Airdingin
14.71.08.1001|Simpangbaru
14.71.08.1008|Delima
14.71.08.1009|Tobekgodang
14.71.08.1010|Binawidya
14.71.08.1014|Sungaisibam
14.71.09.1001|Tangkerang Barat
14.71.09.1002|Tangkerang Tengah
14.71.09.1003|Sidomulyo Timur
14.71.09.1004|Wonorejo
14.71.09.1005|Maharatu
14.71.09.1006|Perhentianmarpoyan
14.71.10.1002|Bencahlesung
14.71.10.1003|Tangkerang Timur
14.71.10.1004|Rejosari
14.71.10.1005|Bambukuning
14.71.10.1010|Melebung
14.71.10.1011|Industritenayan
14.71.10.1012|Sialangsakti
14.71.10.1013|Tuahnegeri
14.71.11.1001|Tampan
14.71.11.1002|Labuh Baru Timur
14.71.11.1003|Labuh Baru Barat
14.71.11.1004|Air Hitam
14.71.11.1005|Bandarraya
14.71.11.1007|Tirtasiak
14.71.12.1001|Meranti Pandak
14.71.12.1004|Lembah Damai
14.71.12.1006|Limbungan Baru
14.71.12.1009|Sri Meranti
14.71.12.1010|Palas
14.71.12.1011|Umban Sari
14.71.13.1001|Sidomulyo Barat
14.71.13.1002|Sialangmunggu
14.71.13.1003|Tuahkarya
14.71.13.1004|Tuahmadani
14.71.13.1005|Airputih
14.71.14.1001|Kulim
14.71.14.1002|Mentangor
14.71.14.1003|Sialangrampai
14.71.14.1004|Pebatuan
14.71.14.1005|Pematangkapau
14.71.15.1001|Tebing Tinggi Okura
14.71.15.1002|Sungaiukai
14.71.15.1003|Sungaiambang
14.71.15.1004|Lembah Sari
14.71.15.1005|Limbungan
14.72.01.1003|Pangkalan Sesai
14.72.01.1006|Purnama
14.72.01.1008|Bagan Keladi
14.72.01.1009|Simpang Tetap Darul Ichsan
14.72.02.1002|Teluk Binjai
14.72.02.1003|Tanjung Palas
14.72.02.1004|Jaya Mukti
14.72.02.1006|Buluh Kasap
14.72.02.1009|Bukit Batrem
14.72.03.1001|Bukit Nenas
14.72.03.1002|Bukit Kayu Kapur
14.72.03.1003|Gurun Panjang
14.72.03.1004|Bagan Besar
14.72.03.1005|Kampung Baru
14.72.03.1006|Bagan Besar Timur
14.72.03.1007|Bukit Kapur
14.72.04.1001|Lubuk Gaung
14.72.04.1002|Tanjung Penyembal
14.72.04.1003|Bangsal Aceh
14.72.04.1004|Basilam Baru
14.72.04.1005|Batu Teritip
14.72.04.1006|Sungai Geniot
14.72.05.1001|Teluk Makmur
14.72.05.1002|Mundam
14.72.05.1003|Guntung
14.72.05.1004|Pelintung
14.72.06.1001|Laksamana
14.72.06.1002|Rimba Sekampung
14.72.06.1003|Dumai Kota
14.72.06.1004|Bintan
14.72.06.1005|Sukajadi
14.72.07.1001|Ratu Sima
14.72.07.1002|Bukit Timah
14.72.07.1003|Mekar Sari
14.72.07.1004|Bukit Datuk
14.72.07.1005|Bumi Ayu
15.01.01.1004|Lempur Tengah
15.01.01.2001|Selam Paung
15.01.01.2002|Air Mumu
15.01.01.2003|Lempur Mudik
15.01.01.2005|Masgo
15.01.01.2006|Lempur Hilir
15.01.01.2011|Kebun Baru
15.01.01.2012|Perikan Tengah
15.01.01.2013|Dusun Baru Lempur
15.01.01.2016|Sungaihangat
15.01.01.2018|Manjunto Lempur
15.01.01.2019|Kebun Lima
15.01.02.2001|Sanggaran Agung
15.01.02.2002|Kota Baru Sanggaran Agung
15.01.02.2003|Pendung Talang Genting
15.01.02.2004|Seleman
15.01.02.2005|Tebing Tinggi
15.01.02.2006|Cupak
15.01.02.2007|Tanjungtanah
15.01.02.2008|Koto Tengah
15.01.02.2013|Simpang Empat
15.01.02.2014|Talang Kemulun
15.01.02.2015|Dusun Baru Tanjung Tanah
15.01.02.2016|Pasar Sore Seleman
15.01.02.2018|Tanjungharapan
15.01.04.2008|Hiang Tinggi
15.01.04.2009|Ambai Atas
15.01.04.2010|Tanjungmudo
15.01.04.2011|Pendung Tengah
15.01.04.2012|Pendung Hilir
15.01.04.2013|Koto Baru Hiang
15.01.04.2014|Betung Kuning
15.01.04.2026|Ambai Bawah
15.01.04.2028|Hiang Karya
15.01.04.2029|Hiang Lestari
15.01.04.2030|Angkasa Pura
15.01.04.2031|Hiang Sakti
15.01.04.2033|Koto Sekilan Ambai
15.01.04.2034|Penawar Tinggi
15.01.05.2002|Koto Baru Semurup
15.01.05.2004|Koto Dua Lama
15.01.05.2012|Koto Di Air
15.01.05.2013|Pasar Semurup
15.01.05.2014|Balai
15.01.05.2015|Koto Majidin Hilir
15.01.05.2016|Pendung Hilir
15.01.05.2018|Pendung Mudik
15.01.05.2022|Air Tenang
15.01.05.2024|Muara Semerah
15.01.05.2029|Koto Majidin Mudik
15.01.05.2035|Muara Semerah Mudik
15.01.05.2036|Sawahan Koto Majidin
15.01.05.2037|Sawahan Jaya
15.01.05.2038|Koto Majidin Di Air
15.01.05.2039|Pendung Tengah
15.01.06.1009|Siulak Deras
15.01.06.2010|Sungaibetung Hilir
15.01.06.2011|Sungaibatu Gantih
15.01.06.2012|Tanjunggenting
15.01.06.2013|Simpang Tutup
15.01.06.2014|Suko Pangkat
15.01.06.2015|Sungaibetung Mudik
15.01.06.2016|Danautinggi
15.01.06.2017|Sungaigelampeh
15.01.06.2018|Siulak Deras Mudik
15.01.06.2019|Siulak Tenang
15.01.06.2039|Sungai Batu Gantih Hilir
15.01.06.2040|Baru Sungai Betung Mudik
15.01.06.2041|Tanjunggenting Mudik
15.01.06.2042|Air Betung
15.01.06.2043|Ujung Ladang
15.01.07.2004|Tarutung
15.01.07.2006|Lubuk Paku
15.01.07.2007|Tamiai
15.01.07.2008|Pematang Lingkung
15.01.07.2009|Pasar Tamiai
15.01.07.2010|Seberang Merangin
15.01.07.2011|Baru Pulau Sangkar
15.01.07.2013|Batang Merangin
15.01.07.2014|Muara Hemat
15.01.08.2001|Jujun
15.01.08.2002|Talang Lindung
15.01.08.2003|Keluru
15.01.08.2004|Pidung
15.01.08.2005|Tanjungbatu
15.01.08.2006|Benik
15.01.08.2007|Kt Tuo P. Tengah
15.01.08.2008|Kt. Dian P. Tengah
15.01.08.2012|Lempur Danau
15.01.08.2013|Dsn. Baru P. Tengah
15.01.08.2018|Telago
15.01.08.2019|Koto Agung
15.01.08.2022|Pulautengah
15.01.08.2023|Koto Baru
15.01.08.2025|Jembatan Merah Pulau Tengah
15.01.08.2026|Limok Manaih Pulau Tengah
15.01.08.2027|Pasar Jujun
15.01.08.2028|Pancuran Bangko
15.01.09.2010|Koto Tuo
15.01.09.2011|Sungaitanduk
15.01.09.2012|Kersik Tuo
15.01.09.2013|Sangir
15.01.09.2014|Koto Baru
15.01.09.2015|Koto Panjang
15.01.09.2016|Koto Tengah
15.01.09.2017|Sungaibendung Air
15.01.09.2022|Sungaisampun
15.01.09.2024|Bedeng Baru
15.01.09.2025|Batang Sangir
15.01.09.2030|Sungaidalam
15.01.09.2038|Koto Periang
15.01.09.2039|Lindung Jaya
15.01.09.2041|Renah Kasah
15.01.09.2042|Pasar Sungai Tanduk
15.01.09.2043|Mekar Sari
15.01.09.2045|Mekar Jaya
15.01.09.2047|Sangir Tengah
15.01.09.2048|Tanjungbungo
15.01.09.2049|Bendung Air Timur
15.01.11.2001|Kemantan Tinggi
15.01.11.2002|Kemantan Kebalai
15.01.11.2003|Kemantan Darat
15.01.11.2004|Sungaiabu
15.01.11.2005|Pondok Sungaiabu
15.01.11.2006|Koto Tebat
15.01.11.2007|Sungaimedang
15.01.11.2008|Air Hangat
15.01.11.2009|Baru Sungai Tutung
15.01.11.2010|Pungut Tengah
15.01.11.2011|Pungut Hilir
15.01.11.2012|Pungut Mudik
15.01.11.2014|Kemantan Hilir
15.01.11.2015|Sungaitutung
15.01.11.2018|Kemantan Agung
15.01.11.2019|Sungaideras
15.01.11.2020|Kemantan Mudik
15.01.11.2021|Simpang Empat Sungai Tutung
15.01.11.2022|Baru Sungaideras
15.01.11.2023|Taman Jernih Sungaitutung
15.01.11.2024|Baru Sungaimedang
15.01.11.2025|Kemantan Raya
15.01.11.2026|Baru Air Hangat
15.01.11.2027|Air Panas Sungaiabu
15.01.11.2028|Baru Sungaiabu
15.01.15.2001|Sungairumpun
15.01.15.2002|Sungaisikai
15.01.15.2003|Tangkil
15.01.15.2004|Pelompek
15.01.15.2005|Jernih Jaya
15.01.15.2006|Bengkolan Duo
15.01.15.2007|Lubuk Pauh
15.01.15.2008|Telun Berasap
15.01.15.2009|Bumbun Duri
15.01.15.2010|Pesisir Bukit
15.01.15.2011|Pauh Tinggi
15.01.15.2012|Sungaijernih
15.01.15.2013|Pelompek Pasar Baru
15.01.16.2001|Siulak Gedang
15.01.16.2004|Pasar Siulak Gedang
15.01.16.2005|Siulak Panjang
15.01.16.2006|Siulak Kecil Mudik
15.01.16.2007|Koto Rendah
15.01.16.2009|Lubuk Nagodang
15.01.16.2010|Sungaipegeh
15.01.16.2011|Sungailebuh
15.01.16.2012|Koto Kapeh
15.01.16.2013|Koto Beringin
15.01.16.2014|Dusun Baru
15.01.16.2015|Dusun Dalam
15.01.16.2016|Air Terjun
15.01.16.2019|Koto Aro
15.01.16.2021|Koto Lebuh Tinggi
15.01.16.2024|Siulak Kecil Hilir
15.01.16.2025|Koto Tengah
15.01.16.2028|Telago Biru
15.01.16.2030|Tutung Bungkuk
15.01.16.2033|Baru Sungaipegeh
15.01.16.2034|Bendar Sedap
15.01.16.2035|Plak Naneh
15.01.16.2036|Padang Jantung
15.01.16.2038|Pelak Gedang
15.01.16.2039|Demong Sakti
15.01.16.2040|Pasar Senen
15.01.17.2001|Belui
15.01.17.2002|Baru Kubang
15.01.17.2003|Koto Panjang
15.01.17.2004|Kubang Gedang
15.01.17.2005|Semumu
15.01.17.2006|Belui Tinggi
15.01.17.2007|Koto Tuo
15.01.17.2008|Koto Payang
15.01.17.2009|Tebat Ijuk
15.01.17.2010|Sekungkung
15.01.17.2011|Simpang Belui
15.01.17.2012|Koto Lanang
15.01.17.2013|Ladeh
15.01.17.2014|Lubuk Suli
15.01.17.2015|Kayu Aho Mangkak Koto Lanang
15.01.17.2016|Tambak Tinggi
15.01.17.2017|Kubang Agung
15.01.17.2018|Tebat Ijuk Dili
15.01.17.2019|Koto Simpai Kubang
15.01.17.2020|Pahlawan Belui
15.01.18.2001|Mukai Hilir
15.01.18.2002|Mukai Tengah
15.01.18.2003|Mukai Mudik
15.01.18.2004|Senimpik
15.01.18.2005|Tebing Tinggi
15.01.18.2006|Mukai Tinggi
15.01.18.2007|Mukai Pintu
15.01.18.2008|Sungailangkap
15.01.18.2009|Pasir Jaya
15.01.18.2010|Sungaikuning
15.01.18.2011|Mukai Seberang
15.01.18.2012|Talang Tinggi
15.01.18.2013|Lubuk Tabun
15.01.18.2014|Koto Lua
15.01.19.2001|Batu Hampar
15.01.19.2002|Sungairenah
15.01.19.2003|Bedeng Delapan
15.01.19.2004|Bedeng Dua
15.01.19.2005|Sako Duo
15.01.19.2006|Sungailintang
15.01.19.2007|Kebun Baru
15.01.19.2008|Patok Empat
15.01.19.2009|Sungaijambu
15.01.19.2010|Sungaikering
15.01.19.2011|Giri Mulyo
15.01.19.2012|Gununglabu
15.01.19.2013|Bento
15.01.19.2014|Kampung Baru
15.01.19.2015|Sungaiasam
15.01.19.2016|Pasar Minggu
15.01.19.2017|Ensatu
15.01.20.2001|Pasar Kerman
15.01.20.2002|Lolo Gedang
15.01.20.2003|Lolo Kecil
15.01.20.2004|Lolo Hilir
15.01.20.2005|Tanjung Syam
15.01.20.2006|Talang Kemuning
15.01.20.2007|Pondok
15.01.20.2008|Muak
15.01.20.2009|Pengasi Lama
15.01.20.2010|Pulaupandan
15.01.20.2011|Pulausangkar
15.01.20.2012|Bintang Marak
15.01.20.2013|Karang Pandan
15.01.20.2014|Pengasi Baru
15.01.20.2015|Muaro Lulo
15.01.21.2001|Koto Mebai
15.01.21.2002|Baru
15.01.21.2003|Air Panas
15.01.21.2004|Hamparan Pugu
15.01.21.2005|Pugu
15.01.21.2006|Koto Mudik
15.01.21.2007|Koto Tengah
15.01.21.2008|Koto Datuk
15.01.21.2009|Koto Dua Baru
15.01.21.2010|Koto Cayo
15.01.21.2011|Kecil
15.01.21.2012|Air Bersih
15.01.22.2001|Kayu Aro Ambai
15.01.22.2002|Bunga Tanjung
15.01.22.2003|Pondok Beringin
15.01.22.2004|Semerah
15.01.22.2005|Sebukar
15.01.22.2006|Koto Tuo Ujung Pasir
15.01.22.2007|Ujung Pasir
15.01.22.2008|Koto Petai
15.01.22.2009|Koto Salak
15.01.22.2010|Agung Koto Iman
15.01.22.2011|Koto Iman
15.01.22.2012|Baru Semerah
15.01.23.2001|Pancuran Tiga
15.01.23.2002|Tanjung Pauh Mudik
15.01.23.2003|Bukit Pulai
15.01.23.2004|Punai Merindu
15.01.23.2005|Sumur Jauh
15.01.23.2006|Permai Baru
15.01.23.2007|Tanjung Pauh Hilir
15.01.23.2008|Serumpun Pauh
15.01.23.2009|Pondok Siguang
15.01.23.2010|Koto Tengah
15.01.23.2011|Semerap
15.01.23.2012|Koto Baru Semerap
15.01.23.2013|Pasar Semerap
15.01.23.2014|Koto Patah
15.02.01.2001|Renah Kemumu
15.02.01.2002|Tanjung Kasri
15.02.01.2003|Lubuk Mentilin
15.02.01.2004|Rantau Kermas
15.02.01.2005|Renah Alai
15.02.01.2008|Pulau Tengah
15.02.01.2009|Lubuk Pungguk
15.02.01.2010|Koto Renah
15.02.01.2011|Muara Madras
15.02.01.2023|Renah Pelaan
15.02.01.2024|Koto Rawang
15.02.02.1009|Pasar Atas
15.02.02.1010|Pasar Bangko
15.02.02.1011|Dusun Bangko
15.02.02.1013|Pematang Kandis
15.02.02.2004|Kungkai
15.02.02.2008|Mudo
15.02.02.2012|Langling
15.02.02.2024|Sungai Kapas
15.02.03.2004|Durian Rambun
15.02.03.2007|Lubuk Birah
15.02.03.2008|Lubuk Beringin
15.02.03.2009|Rantau Macang
15.02.03.2010|Peradun Temeras
15.02.03.2011|Teluk Sikumbang
15.02.03.2012|Muara Siau
15.02.03.2013|Tiaro
15.02.03.2015|Air Lago
15.02.03.2016|Badak Tekurung
15.02.03.2017|Rantau Bidaro
15.02.03.2018|Rantau Panjang
15.02.03.2021|Pulau Raman
15.02.03.2024|Pasar Muara Siau
15.02.03.2027|Sepantai Renah
15.02.03.2028|Sungai Ulas
15.02.03.2029|Rantau Bayur
15.02.04.2007|Sungai Pinang
15.02.04.2008|Tiangko
15.02.04.2009|Palipan
15.02.04.2010|Seringat
15.02.04.2011|Durian Lecah
15.02.04.2015|Bukit Batu
15.02.04.2016|Sungai Nilau
15.02.04.2017|Sungai Manau
15.02.04.2025|Benteng
15.02.04.2026|Gelanggang
15.02.05.1002|Dusun Baru
15.02.05.1003|Pasar Rantau Panjang
15.02.05.1005|Kampung Baruh
15.02.05.1020|Mampun
15.02.05.1036|Pasar Baru Rantau
15.02.05.2007|Kandang
15.02.05.2008|Koto Rayo
15.02.05.2011|Tanjung Ilir
15.02.05.2014|Beluran Panjang
15.02.05.2015|Seling
15.02.05.2035|Lubuk Napal
15.02.06.1008|Pamenang
15.02.06.2004|Jelatang
15.02.06.2005|Tanjung Gedang
15.02.06.2006|Empang Benao
15.02.06.2007|Rejo Sari
15.02.06.2009|Keroya
15.02.06.2010|Muara Belengo
15.02.06.2011|Karang Berahi
15.02.06.2012|Pauh Menang
15.02.06.2013|Pematang Kancil
15.02.06.2014|Tanah Abang
15.02.06.2015|Sialang
15.02.06.2026|Sungai Udang
15.02.06.2027|Pelakar Jaya
15.02.07.2009|Muara Jernih
15.02.07.2010|Kapuk
15.02.07.2011|Pulau Aro
15.02.07.2012|Rantau Ngarau
15.02.07.2013|Medan Baru
15.02.07.2014|Muaro Seketuk
15.02.08.2001|Sungai Sahut
15.02.08.2002|Bungo Antoi
15.02.08.2003|Muara Delang
15.02.08.2004|Sinar Gading
15.02.08.2005|Bungo Tanjung
15.02.08.2006|Rawa Jaya
15.02.08.2007|Gading Jaya
15.02.08.2008|Mekar Jaya
15.02.09.2001|Nilo Dingin
15.02.09.2002|Tanjung Berugo
15.02.09.2003|Tuo
15.02.09.2004|Koto Rami
15.02.09.2005|Rancan
15.02.09.2006|Pasar Masurai
15.02.09.2007|Rantau Jering
15.02.09.2008|Tanjung Dalam
15.02.09.2009|Muaro Pangi
15.02.09.2010|Sungai Lalang
15.02.09.2011|Talang Asal
15.02.09.2012|Muara Kelukup
15.02.09.2013|Muara Lengayo
15.02.09.2014|Talang Paruh
15.02.09.2015|Durian Mukut
15.02.10.2001|Pulau Rengas
15.02.10.2002|Biuku Tanjung
15.02.10.2003|Bedeng Rejo
15.02.10.2004|Sungai Putih
15.02.10.2005|Bukit Beringin
15.02.10.2006|Pulau Rengas Ulu
15.02.11.2001|Sungai Ulak
15.02.11.2002|Aur Berduri
15.02.11.2003|Telun
15.02.11.2004|Nalo Gedang
15.02.11.2005|Baru Nalo
15.02.11.2006|Mentawak
15.02.11.2007|Danau
15.02.12.2001|Lubuk Gaung
15.02.12.2002|Salam Buku
15.02.12.2003|Pulau Baru
15.02.12.2004|Nibung
15.02.12.2005|Titian Teras
15.02.12.2006|Kederasan Panjang
15.02.12.2007|Rantau Alai
15.02.12.2008|Tambang Besi
15.02.12.2009|Pelangki
15.02.12.2010|Pulau Layang
15.02.13.2001|Tanjung Lamin
15.02.13.2002|Limbur Merangin
15.02.13.2003|Karang Anyar
15.02.13.2004|Pinang Merah
15.02.13.2005|Simpang Limbur Merangin
15.02.13.2006|Mampun Baru
15.02.13.2007|Papit
15.02.13.2008|PulauTujuh
15.02.14.2001|Rantau Limau Manis
15.02.14.2002|Ulak Makam
15.02.14.2003|Air Batu
15.02.14.2004|Rejo Sari
15.02.14.2005|Kota Raja
15.02.14.2006|Tunggul Bulin
15.02.14.2007|Mekar Limau Manis
15.02.15.2001|Sungai Limau
15.02.15.2002|Sungai Bulian
15.02.15.2003|Sri Sembilan
15.02.15.2004|Bukit Subur
15.02.16.2001|Muaro Panco Barat
15.02.16.2002|Talang Segegah
15.02.16.2003|Durian Batakuk
15.02.16.2004|Muara Bantan
15.02.16.2005|Parit Ujung Tanjung
15.02.16.2006|Guguk
15.02.16.2007|Markeh
15.02.16.2008|Air Batu
15.02.16.2009|Marus Jaya
15.02.16.2010|Renah Medan
15.02.16.2011|Simpang Parit
15.02.16.2012|Muaro Panco Timur
15.02.17.2001|Baru Pangkalan Jambu
15.02.17.2002|Bukit Perentak
15.02.17.2003|Birun
15.02.17.2004|Tiga Alur
15.02.17.2005|Bungo Tanjung
15.02.17.2006|Sungai Jering
15.02.17.2007|Kampung Limo
15.02.17.2008|Tanjung Mudo
15.02.18.2001|Tanjung Mudo
15.02.18.2002|Koto Teguh
15.02.18.2003|Baru
15.02.18.2004|Talang Tembago
15.02.18.2005|Beringin Tinggi
15.02.18.2006|Pematang Pauh
15.02.18.2007|Rantau Suli
15.02.18.2008|Gedang
15.02.18.2010|Koto Baru
15.02.18.2011|Tanjung Benuang
15.02.18.2012|Jangkat
15.02.18.2013|Tanjung Alam
15.02.18.2014|Kabu
15.02.18.2015|Simpang Talang Tembago
15.02.19.2001|Meranti
15.02.19.2002|Bukit Bungkul
15.02.19.2003|Rasau
15.02.19.2004|Lantak Seribu
15.02.20.2001|Tambang Emas
15.02.20.2002|Tanjung Benuang
15.02.20.2003|Pulau Bayur
15.02.20.2004|Selango
15.02.21.2001|Tanjung Rejo
15.02.21.2002|Sumber Agung
15.02.21.2003|Suko Rejo
15.02.21.2004|Sido Rukun
15.02.21.2005|Lubuk Bumbun
15.02.21.2006|Tegal Rejo
15.02.22.2001|Tambang Baru
15.02.22.2002|Sido Lego
15.02.22.2003|Mensango
15.02.22.2004|Koto Baru
15.02.22.2005|Sido Harjo
15.02.23.2001|Muara Kibul
15.02.23.2002|Tanjung Putus
15.02.23.2003|Pulau Tebakar
15.02.23.2004|Batang Kibul
15.02.23.2005|Sungai Tabir
15.02.23.2006|Telentam
15.02.23.2007|Ngaol
15.02.23.2008|Air Liki
15.02.23.2009|Pulau Lebar
15.02.23.2010|Muara Langeh
15.02.23.2011|Tanjung Beringin
15.02.23.2012|Baru Kibul
15.02.23.2013|Ngaol Ilir
15.02.23.2014|Air Liki Baru
15.02.24.2001|Sekancing
15.02.24.2002|Sekancing Ilir
15.02.24.2003|Beringin Sanggul
15.02.24.2004|Baru Bukit Punjung
15.02.24.2005|Rantau Limau Kapas
15.02.24.2006|Baru Sungai Sakai
15.03.01.2001|Tambak Ratu
15.03.01.2002|Sungai Keradak
15.03.01.2003|Muaro Air Dua
15.03.01.2004|Simpang Narso
15.03.01.2005|Batin Pengambang
15.03.01.2006|Batu Empang
15.03.01.2007|Rantau Panjang
15.03.01.2008|P. Salak Baru
15.03.01.2009|Muaro Pemuat
15.03.01.2010|Lubuk Bangkar
15.03.01.2011|Pekan Gedang
15.03.01.2012|Raden Anom
15.03.01.2013|Datuk Nan Duo
15.03.01.2014|Bukit Kalimau Ulu
15.03.01.2015|Sungai Bemban
15.03.01.2016|Muara Cuban
15.03.01.2017|Sungai Baung
15.03.01.2018|Padang Jering
15.03.01.2019|Kasiro
15.03.01.2020|Kasiro Hilir
15.03.01.2021|Bukit Berantai
15.03.01.2022|Bukit Sulah
15.03.01.2023|Paniban Baru
15.03.02.2005|Pulau Pandan
15.03.02.2006|Temenggung
15.03.02.2007|Ranggo
15.03.02.2008|Panca Karya
15.03.02.2009|Lubuk Bedorong
15.03.02.2010|Meribung
15.03.02.2011|Napal Melintang
15.03.02.2012|Berkun
15.03.02.2013|Mersip
15.03.02.2014|Tanjung Raden
15.03.02.2016|Moenti
15.03.02.2017|Muara Mensao
15.03.02.2018|Demang
15.03.02.2021|Temalang
15.03.02.2022|Muara Limun
15.03.02.2023|Suka Damai
15.03.03.1001|Dusun Sarolangun
15.03.03.1015|Sukasari
15.03.03.1016|Pasar Sarolangun
15.03.03.1019|Sarolangun Kembang
15.03.03.1025|Gunung Kembang
15.03.03.1026|Aur Gading
15.03.03.2002|Bernai
15.03.03.2003|Sungai Baung
15.03.03.2004|Panti
15.03.03.2005|Tinting
15.03.03.2006|Sungai Abang
15.03.03.2013|Lidung
15.03.03.2014|Ladang Panjang
15.03.03.2024|Desa Baru
15.03.03.2027|Ujung Tanjung
15.03.03.2028|Bernai Dalam
15.03.04.1005|Pauh
15.03.04.2001|Pangidaran
15.03.04.2002|Karang Mendapo
15.03.04.2003|Batu Ampar
15.03.04.2004|Batu Kucing
15.03.04.2006|Semaran
15.03.04.2007|Kasang Melintang
15.03.04.2008|Pangkal Bulian
15.03.04.2009|Lubuk Napal
15.03.04.2010|Sepintun
15.03.04.2011|Lamban Sigatal
15.03.04.2020|Seko Besar
15.03.04.2021|Taman Bandung
15.03.04.2022|Danau Serdang
15.03.05.2001|Penegah
15.03.05.2002|Pelawan
15.03.05.2003|Pulauaro
15.03.05.2004|Bukit
15.03.05.2005|Lubuk Sepuh
15.03.05.2006|Rantau Tenang
15.03.05.2007|Muara Danau
15.03.05.2013|Sungai Merah
15.03.05.2016|Pematang Kulim
15.03.05.2017|Batu Putih
15.03.05.2019|Mekar Sari
15.03.05.2021|Pasar Pelawan
15.03.05.2022|Pelawan Jaya
15.03.05.2023|Lubuk Sayak
15.03.06.2001|Mandiangin
15.03.06.2002|Rangkiling Simpang
15.03.06.2003|Pemusiran
15.03.06.2004|Gurun Tuo Simpang
15.03.06.2005|Gurun Mudo
15.03.06.2006|Gurun Tuo
15.03.06.2007|Rangkiling
15.03.06.2008|Mandiangin Tuo
15.03.06.2009|Kertopati
15.03.06.2010|Muaro Ketalo
15.03.06.2011|Taman Dewa
15.03.06.2012|Simpang Kertopati
15.03.06.2013|Bukit Peranginan
15.03.06.2020|Gurun Baru
15.03.06.2021|Kute Jaye
15.03.06.2022|Mandiangin Pasar
15.03.06.2023|Sungai Rotan
15.03.06.2028|Talang Serdang
15.03.07.2001|Lubuk Jering
15.03.07.2002|Jernih
15.03.07.2003|Desa Baru
15.03.07.2004|Semurung
15.03.07.2005|Lubuk Kepayang
15.03.07.2006|Pematang Kabau
15.03.07.2007|Bukit Suban
15.03.07.2008|Mentawak Baru
15.03.07.2009|Mentawak Ulu
15.03.08.1011|Limbur Tembesi
15.03.08.2001|Rantau Gedang
15.03.08.2002|Penarun
15.03.08.2003|Pulau Lintang
15.03.08.2004|Tanjung
15.03.08.2005|Bangun Jayo
15.03.08.2006|Teluk kecimbung
15.03.08.2007|Pulau Melako
15.03.08.2008|Batu Penyabung
15.03.08.2009|Tanjung Gagak
15.03.08.2010|Pulau Buayo
15.03.08.2012|Dusun Dalam
15.03.08.2013|Muara Lati
15.03.08.2014|Suka Jadi
15.03.08.2015|Teluk Mancur
15.03.09.1001|Sungai Benteng
15.03.09.2002|Bukit Tigo
15.03.09.2003|Sungai Gedang
15.03.09.2004|Payo Lebar
15.03.09.2005|Bukit Murau
15.03.09.2006|Perdamaian
15.03.09.2007|Pasar Singkut
15.03.09.2008|Siliwangi
15.03.09.2009|Simpang Nibung
15.03.09.2010|Bukit Talang Mas
15.03.09.2011|Bukit Bumi Raya
15.03.09.2012|Argo Sari
15.03.09.2013|Sendang Sari
15.03.10.2001|Kampung Tujuh
15.03.10.2002|Lubuk Resam
15.03.10.2003|Teluk Rendah
15.03.10.2004|Teluk Tigo
15.03.10.2005|Lubuk Resam Hilir
15.03.10.2006|Pemuncak
15.03.10.2007|Tambang Tinggi
15.03.10.2008|Tendah
15.03.10.2009|Sungai Keramat
15.03.10.2010|Sekamis
15.03.11.2001|Guruh Baru
15.03.11.2002|Petiduran Baru
15.03.11.2003|Sungai Butang
15.03.11.2004|Butang Baru
15.03.11.2005|Suka Maju
15.03.11.2006|Jati Baru
15.03.11.2007|Jati Baru Mudo
15.03.11.2008|Meranti Baru
15.03.11.2009|Meranti Jaya
15.03.11.2010|Jernang Baru
15.04.01.1001|Kembang Paseban
15.04.01.2002|Sengkati Kecil
15.04.01.2003|Sengkati Gedang
15.04.01.2004|Sengkati Baru
15.04.01.2005|Kembang Tanjung
15.04.01.2006|Mersam
15.04.01.2007|Benteng Rendah
15.04.01.2008|Sungai Puar
15.04.01.2009|Rantau Gedang
15.04.01.2010|Pematang Gadung
15.04.01.2011|Teluk Melintang
15.04.01.2012|Bukit Harapan
15.04.01.2013|Belanti Jaya
15.04.01.2014|Tapah Sari
15.04.01.2015|Bukit Kemuning
15.04.01.2016|Simpang Rantau Gedang
15.04.01.2017|Tanjung Putra
15.04.01.2018|Sengkati Mudo
15.04.02.1001|Kampung Baru
15.04.02.1002|Pasar Muara Tembesi
15.04.02.2003|Jebak
15.04.02.2004|Ampelu
15.04.02.2005|Rambutan Masam
15.04.02.2006|Rantau Kapas Mudo
15.04.02.2007|Rantau Kapas Tuo
15.04.02.2008|Sungai Pulai
15.04.02.2009|Pulau
15.04.02.2010|Tanjung Marwo
15.04.02.2011|Suka Ramai
15.04.02.2012|Ampelu Mudo
15.04.02.2013|Pelayangan
15.04.02.2015|Pematang Lima Suku
15.04.03.1001|Muara Bulian
15.04.03.1002|Teratai
15.04.03.1003|Sridadi
15.04.03.1004|Pasar Baru
15.04.03.1005|Rengas Condong
15.04.03.2006|Pasar Terusan
15.04.03.2007|Simpang Terusan
15.04.03.2008|Malapari
15.04.03.2009|Napal Sisik
15.04.03.2010|Rambahan
15.04.03.2011|Olak
15.04.03.2012|Muaro Singoan
15.04.03.2013|Aro
15.04.03.2014|Rantau Puri
15.04.03.2015|Sungai Baung
15.04.03.2016|Bajubang Laut
15.04.03.2017|Singkawang
15.04.03.2018|Tenam
15.04.03.2019|Sungai Buluh
15.04.03.2020|Kilangan
15.04.03.2021|Pelayangan
15.04.04.1003|Durian Luncuk
15.04.04.1012|Muara Jangga
15.04.04.2001|Jelutih
15.04.04.2002|Olak Besar
15.04.04.2004|Aur Gading
15.04.04.2005|Paku Aji
15.04.04.2006|Hajran
15.04.04.2007|Mata Gual
15.04.04.2008|Jangga
15.04.04.2009|Koto Boyo
15.04.04.2010|Simpang Karmeo
15.04.04.2011|Karmeo
15.04.04.2013|Jangga Baru
15.04.04.2014|Terentang Baru
15.04.04.2015|Bulian Baru
15.04.04.2016|Simpang Jelutih
15.04.04.2017|Simpang Aur Gading
15.04.05.1002|Jembatan Mas
15.04.05.2001|Tebing Tinggi
15.04.05.2003|Serasah
15.04.05.2004|Lubuk Ruso
15.04.05.2005|Kuap
15.04.05.2006|Senaning
15.04.05.2007|Kubu Kandang
15.04.05.2008|Ture
15.04.05.2009|Pulau Betung
15.04.05.2010|Lopak Aur
15.04.05.2011|Selat
15.04.05.2012|Teluk
15.04.05.2013|Pulau Raman
15.04.05.2014|Kaos
15.04.05.2015|Simpang Kubu Kandang
15.04.05.2016|Awin
15.04.05.2017|Olak Rambahan
15.04.05.2019|Teluk Ketapang
15.04.05.2020|Kampung Pulau
15.04.06.1014|Simpang S. Rengas
15.04.06.2001|Batu Sawar
15.04.06.2002|Peninjauan
15.04.06.2003|Teluk Leban
15.04.06.2004|Kampung Baru
15.04.06.2005|Rengas IX
15.04.06.2006|Kembang Seri
15.04.06.2007|Buluh Kasab
15.04.06.2008|Tebing Tinggi
15.04.06.2009|Olak Kemang
15.04.06.2010|Padang Kelapo
15.04.06.2011|Sungai Lingkar
15.04.06.2012|Sungai Ruan Ulu
15.04.06.2013|Sungai Ruan Ilir
15.04.06.2015|Rawa Mekar
15.04.06.2016|Mekar Sari
15.04.06.2017|Kembang Seri Baru
15.04.07.1004|Bajubang
15.04.07.2001|Bungku
15.04.07.2002|Pompa Air
15.04.07.2003|Ladang Peris
15.04.07.2005|Penerokan
15.04.07.2006|Petajen
15.04.07.2007|Batin
15.04.07.2008|Mekar Jaya
15.04.07.2009|Sungkai
15.04.07.2010|Mekar Sari Nes
15.04.08.1008|Terusan
15.04.08.2001|Bulian Jaya
15.04.08.2002|Tidar Kuranji
15.04.08.2003|Kehidupan Baru
15.04.08.2004|Bukit Sari
15.04.08.2005|Karya Mukti
15.04.08.2006|Terusan
15.04.08.2007|Danau Embat
15.05.01.1003|Pijoan
15.05.01.2002|Sungai Bertam
15.05.01.2004|Pematang Jering
15.05.01.2005|Muaro Pijoan
15.05.01.2006|Sungai Duren
15.05.01.2007|Mendalo Darat
15.05.01.2008|Rengas Bandung
15.05.01.2009|Sarang Burung
15.05.01.2010|Mendalo Laut
15.05.01.2011|Sembubuk
15.05.01.2012|Senaung
15.05.01.2013|Penyengat Olak
15.05.01.2014|Simpang Sungai Duren
15.05.01.2015|Kedemangan
15.05.01.2016|Muhajirin
15.05.01.2017|Maro Sebo
15.05.01.2019|Danau Sarang Elang
15.05.01.2020|Simpang Limo
15.05.01.2021|Mendalo Indah
15.05.01.2022|Pematang Gajah
15.05.02.1010|Sengeti
15.05.02.2001|Suak Putat
15.05.02.2002|Rantau Majo
15.05.02.2003|Pulau Kayu Aro
15.05.02.2004|Pematang Pulai
15.05.02.2005|Tan Tan
15.05.02.2006|Kedotan
15.05.02.2007|Keranggan
15.05.02.2008|Berembang
15.05.02.2009|Sekernan
15.05.02.2011|Gerunggung
15.05.02.2012|Tunas Baru
15.05.02.2013|Bukit Baling
15.05.02.2014|Tanjung Lanjut
15.05.02.2015|Suko Awin Jaya
15.05.02.2016|Tunas Mudo
15.05.03.1008|Tanjung
15.05.03.2001|Puding
15.05.03.2002|Pulau Mentaro
15.05.03.2003|Betung
15.05.03.2004|Pematang Raman
15.05.03.2005|Sungai Bungur
15.05.03.2006|Seponjen
15.05.03.2007|Sogo
15.05.03.2009|Sungai Aur
15.05.03.2010|Jebus
15.05.03.2011|Gedong Karya
15.05.03.2013|Rantau Panjang
15.05.03.2014|Londerang
15.05.03.2016|Petanang
15.05.03.2017|Mekar Sari
15.05.03.2018|Rondang
15.05.03.2019|Maju Jaya
15.05.04.1002|Jambi Kecil
15.05.04.2001|Setiris
15.05.04.2003|Tanjung Katung
15.05.04.2004|Jambi Tulo
15.05.04.2005|Baru
15.05.04.2006|Danau Lamo
15.05.04.2007|Muaro Jambi
15.05.04.2016|Niaso
15.05.04.2017|Bakung
15.05.04.2018|Danau Kedap
15.05.04.2019|Mudung Darat
15.05.04.2020|Lubuk Raman
15.05.05.1009|Tempino
15.05.05.2001|Tanjung Pauh Km. 32
15.05.05.2002|Pelempang
15.05.05.2003|Sungai Landai
15.05.05.2004|Ibru
15.05.05.2005|Nagasari
15.05.05.2006|Sebapo
15.05.05.2010|Baru
15.05.05.2011|Tanjung Pauh Km. 39
15.05.05.2012|Nyogan
15.05.05.2015|Suka Damai
15.05.05.2016|Pondok Meja
15.05.05.2017|Suka Maju
15.05.05.2018|Tanjung Pauh Talang Pelita
15.05.05.2019|Muaro Sebapo
15.05.06.2001|Pudak
15.05.06.2002|Muara Kumpeh
15.05.06.2003|Kota Karang
15.05.06.2004|Kasang Lopak Alai
15.05.06.2005|Kasang Pudak
15.05.06.2008|Solok
15.05.06.2009|Sakean
15.05.06.2010|Lopak Alai
15.05.06.2011|Tarikan
15.05.06.2012|Ramin
15.05.06.2013|Teluk Raya
15.05.06.2014|Pemunduran
15.05.06.2015|Sipin Teluk Duren
15.05.06.2016|Arang Arang
15.05.06.2017|Sumber Jaya
15.05.06.2018|Sungai Terap
15.05.06.2023|Kasang Kumpeh
15.05.06.2024|Kasang Kota Karang
15.05.07.2004|Suka Makmur
15.05.07.2005|Marga Mulya
15.05.07.2006|Panca Mulya
15.05.07.2007|Marga Manunggal Jaya
15.05.07.2012|Tanjung Harapan
15.05.07.2013|Berkah
15.05.07.2018|Bukit Makmur
15.05.07.2021|Bukit Mas
15.05.07.2025|Mekar Sari Makmur
15.05.07.2033|Bakti Mulya
15.05.07.2034|Panca Bakti
15.05.08.2001|Kebon IX
15.05.08.2002|Talang Belido
15.05.08.2003|Talang Kerinci
15.05.08.2004|Ladang Panjang
15.05.08.2005|Tangkit
15.05.08.2006|Tangkit Baru
15.05.08.2007|Sungai Gelam
15.05.08.2008|Parit
15.05.08.2009|Petaling Jaya
15.05.08.2010|Sumber Agung
15.05.08.2011|Mingkung Jaya
15.05.08.2012|Trimulya Jaya
15.05.08.2013|Mekar Jaya
15.05.08.2014|Sido Mukti
15.05.08.2015|Gambut Jaya
15.05.09.2001|Talang Bukit
15.05.09.2002|Talang Datar
15.05.09.2003|Sumber Mulya
15.05.09.2004|Mulya Jaya
15.05.09.2005|Matra Manunggal
15.05.09.2006|Bukit Mulya
15.05.09.2007|Sumber Jaya
15.05.09.2008|Pinang Tinggi
15.05.09.2009|Markanding
15.05.09.2010|Sungai Dayo
15.05.09.2011|Bahar Mulya
15.05.10.2001|Bukit Subur
15.05.10.2002|Tri Jaya
15.05.10.2003|Mekar Jaya
15.05.10.2004|Ujung Tanjung
15.05.10.2005|Tanjung Baru
15.05.10.2006|Tanjung Mulia
15.05.10.2007|Adipura Kencana
15.05.10.2008|Bukit Jaya
15.05.10.2009|Tanjung Sari
15.05.10.2010|Tanjung Lebar
15.05.11.2001|Kunangan
15.05.11.2002|Talang Duku
15.05.11.2003|Tebat Patah
15.05.11.2004|Kemingking Dalam
15.05.11.2005|Teluk Jambu
15.05.11.2006|Dusun Mudo
15.05.11.2007|Sekumbung
15.05.11.2008|Kemingking Luar
15.05.11.2009|Rukam
15.05.11.2010|Manis Mato
15.06.01.1005|Pelabuhan Dagang
15.06.01.2001|Badang
15.06.01.2002|Tanjung Tayas
15.06.01.2003|Kuala Dasal
15.06.01.2004|Pematang Pauh
15.06.01.2006|Taman Raja
15.06.01.2017|Brasau
15.06.01.2019|Gemuruh
15.06.01.2020|Pematang Tembesu
15.06.01.2021|Badang Sepakat
15.06.02.1004|Tungkal Empat Kota
15.06.02.1005|Tungkal III
15.06.02.1006|Tungkal Harapan
15.06.02.1007|Tungkal II
15.06.02.1015|Kampung Nelayan
15.06.02.1016|Patunas
15.06.02.1017|Sriwijaya
15.06.02.1018|Sungainibung
15.06.02.2003|Tungkal I
15.06.02.2014|Teluk Sialang
15.06.03.1001|Teluknilau
15.06.03.2006|Parit Pudin
15.06.03.2007|Sungai Serindit
15.06.03.2008|Mekar Jati
15.06.03.2012|Sungai Pampang
15.06.03.2013|Parit Sidang
15.06.03.2014|Sungai Jering
15.06.03.2015|Parit Bilal
15.06.03.2016|Suak Samin
15.06.03.2017|Sungai Baung
15.06.03.2018|Karya Maju
15.06.03.2019|Sungai Raya
15.06.03.2020|Pasar Senin
15.06.04.1007|Mekar Jaya
15.06.04.2001|Pematang Lumut
15.06.04.2008|Makmur Jaya
15.06.04.2009|Serdang Jaya
15.06.04.2010|Terjun Gajah
15.06.04.2011|Lubuk Terentang
15.06.04.2012|Pematang Buluh
15.06.04.2013|Muntialo
15.06.04.2014|Teluk Kulbi
15.06.04.2015|Bunga Tanjung
15.06.04.2016|Sungai Terap
15.06.04.2017|Mandala Jaya
15.06.05.1007|Merlung
15.06.05.2005|Penyabungan
15.06.05.2006|Lubuk Terap
15.06.05.2008|Tanjung Paku
15.06.05.2012|Tanjung Benanak
15.06.05.2013|Bukit Harapan
15.06.05.2014|Adi Purwa
15.06.05.2018|Pinang Gading
15.06.05.2020|Merlung
15.06.05.2021|Tanjung Makmur
15.06.06.1001|Tebing Tinggi
15.06.06.2002|Purwodadi
15.06.06.2003|Suka Damai
15.06.06.2004|Adi Jaya
15.06.06.2005|Kelagian
15.06.06.2006|Teluk Pengkah
15.06.06.2007|Talang Makmur
15.06.06.2008|Sungai Keruh
15.06.06.2009|Dataran Kempas
15.06.06.2010|Delima
15.06.07.1001|Dusun Kebun
15.06.07.2002|Sri Agung
15.06.07.2003|Suban
15.06.07.2004|Tanjung Bojo
15.06.07.2005|Kampung Baru
15.06.07.2006|Lubuk Bernai
15.06.07.2007|Rawa Medang
15.06.07.2008|Sungai Penoban
15.06.07.2009|Rawang Kempas
15.06.07.2010|Lubuk Lawas
15.06.07.2011|Sungai Badar
15.06.08.1001|Lubuk Kambing
15.06.08.2002|Pulau Pauh
15.06.08.2003|Rantau Benar
15.06.08.2004|Lampisi
15.06.08.2005|Cinta Damai
15.06.08.2006|Sungai Rotan
15.06.08.2007|Muara Danau
15.06.08.2008|Tanah Tumbuh
15.06.08.2009|Sungai Paur
15.06.08.2010|Bukit Bakar
15.06.09.1001|Rantau Badak
15.06.09.2002|Dusun Mudo
15.06.09.2003|Intan Jaya
15.06.09.2004|Bukit Indah
15.06.09.2005|Kemang Manis
15.06.09.2006|Rantau Badak Lamo
15.06.09.2007|Lubuk Sebontan
15.06.09.2008|Sungai Papauh
15.06.09.2009|Sungai Muluk
15.06.09.2010|Pematang Balam
15.06.10.1001|Tungkal V
15.06.10.2002|Tungkal IV Desa
15.06.10.2003|Kuala Baru
15.06.10.2004|Teluk Pulai Raya
15.06.10.2005|Mekar Alam
15.06.10.2006|Harapan Jaya
15.06.10.2007|Kuala Kahar
15.06.10.2008|Muara Seberang
15.06.11.1001|Bram Itam Kiri
15.06.11.2002|Bram Itam Kanan
15.06.11.2003|Tanjung Senjulang
15.06.11.2004|Pembengis
15.06.11.2005|Bram Itam Raya
15.06.11.2006|Pantai Gading
15.06.11.2007|Jati Emas
15.06.11.2008|Kemuning
15.06.11.2009|Mekar Tanjung
15.06.11.2010|Semau
15.06.12.1001|Betara Kiri
15.06.12.2002|Sungai Dualap
15.06.12.2003|Betara Kanan
15.06.12.2004|Sungai Gebar
15.06.12.2005|Dataran Pinang
15.06.12.2006|Tanjung Pasir
15.06.12.2007|Sungai Gebar Barat
15.06.12.2008|Sungai Dungun
15.06.12.2009|Kuala Indah
15.06.12.2010|Suak Labu
15.06.13.1001|Senyerang
15.06.13.2002|Sungai Kayu Aro
15.06.13.2003|Teluk Ketapang
15.06.13.2004|Sungai Rambai
15.06.13.2005|Margo Rukun
15.06.13.2006|Kempas Jaya
15.06.13.2007|Lumahan
15.06.13.2008|Sungai Landak
15.06.13.2009|Sungsang
15.06.13.2010|Sungai Kepayang
15.07.01.1010|Muara Sabak Ilir
15.07.01.1013|Muara Sabak Ulu
15.07.01.2001|Alang-Alang
15.07.01.2002|Lambur
15.07.01.2004|Simbur Naik
15.07.01.2011|Lambur I
15.07.01.2012|Lambur II
15.07.01.2014|Kota Raja
15.07.01.2015|Siau Dalam
15.07.01.2016|Sungai Ular
15.07.01.2017|Kota Harapan
15.07.01.2018|Kuala Simbur
15.07.02.1001|Nipah Panjang I
15.07.02.1002|Nipah Panjang II
15.07.02.2003|Simpang Jelita
15.07.02.2004|Simpang Datuk
15.07.02.2005|Teluk Kijing
15.07.02.2006|Sungai Raya
15.07.02.2007|Pemusiran
15.07.02.2008|Sungai Tering
15.07.02.2009|Sungai Jeruk
15.07.02.2010|Bunga Tanjung
15.07.03.1002|Mendahara Ilir
15.07.03.2001|Pangkal Duri
15.07.03.2003|Mendahara Tengah
15.07.03.2007|Lagan Ilir
15.07.03.2014|Sinar Kalimantan
15.07.03.2015|Sungai Tawar
15.07.03.2016|Bakti Idaman
15.07.03.2017|Merbau
15.07.03.2018|Pangkal Duri Ilir
15.07.04.1006|Bandar Jaya
15.07.04.2004|Rantau Rasau I
15.07.04.2005|Rantau Rasau II
15.07.04.2007|Harapan Makmur
15.07.04.2008|Bangun Karya
15.07.04.2009|Rantau Jaya
15.07.04.2011|Sungai Dusun
15.07.04.2013|Karya Bakti
15.07.04.2014|Marga Mulya
15.07.04.2015|Pematang Mayan
15.07.04.2016|Tri Mulyo
15.07.05.1005|Sungai Lokan
15.07.05.2001|Sungai Sayang
15.07.05.2002|Air Hitam Laut
15.07.05.2003|Sungai Jambat
15.07.05.2004|Sungai Itik
15.07.05.2006|Sungai Benuh
15.07.05.2007|Sungai Cemara
15.07.05.2008|Remau Baku Tuo
15.07.05.2009|Labuhan Pering
15.07.06.1006|Rantau Indah
15.07.06.2003|Kuala Dendang
15.07.06.2004|Koto Kandis Dendang
15.07.06.2005|Koto Kandis
15.07.06.2007|Sido Mukti
15.07.06.2008|Catur Rahayu
15.07.06.2009|Jati Mulyo
15.07.07.1001|Kampung Singkep
15.07.07.1002|Nibung Putih
15.07.07.1003|Rano
15.07.07.1004|Talang Babat
15.07.07.1005|Parit Culum I
15.07.07.1006|Parit Culum II
15.07.07.1007|Teluk Dawan
15.07.08.1001|Kampung Laut
15.07.08.1002|Tanjung Solok
15.07.08.2003|Teluk Majelis
15.07.08.2004|Kuala Lagan
15.07.08.2005|Majelis Hidayah
15.07.08.2006|Manunggal Makmur
15.07.09.1001|Simpang Tuan
15.07.09.2002|Pematang Rahim
15.07.09.2003|Sungai Toman
15.07.09.2004|Bukit Tempurung
15.07.09.2005|Sinar Wajo
15.07.09.2006|Sungai Beras
15.07.09.2007|Mencolok
15.07.10.1010|Pandan Jaya
15.07.10.2001|Lagan Ulu
15.07.10.2002|Lagan Tengah
15.07.10.2004|Pandan Makmur
15.07.10.2005|Pandan Lagan
15.07.10.2006|Suka Maju
15.07.10.2007|Kota Baru
15.07.10.2008|Rantau Karya
15.07.10.2009|Pandan Sejahtera
15.07.11.1001|Simpang
15.07.11.2002|Rantau Rasau
15.07.11.2003|Rantau Makmur
15.07.11.2004|Sungai Rambut
15.07.11.2005|Rawasari
15.07.11.2006|Telaga Limo
15.08.01.2001|Pedukun
15.08.01.2002|Lubuk Niur
15.08.01.2003|Teluk Kecimbung
15.08.01.2004|Tanah Tumbuh
15.08.01.2005|Rambah
15.08.01.2006|Tebing Tinggi Uleh
15.08.01.2007|Bukit Kemang
15.08.01.2008|Panjang
15.08.01.2009|Perenti Luweh
15.08.01.2015|Renah Jelmu
15.08.01.2016|Koto Jayo
15.08.02.2001|Rantau Duku
15.08.02.2002|Talang Sungai Bungo
15.08.02.2003|Rantau Pandan
15.08.02.2004|Leban
15.08.02.2005|Lubuk Kayu Aro
15.08.02.2015|Lubuk Mayan
15.08.03.1006|Tanjung Gedang
15.08.03.1007|Bungo Timur
15.08.03.1008|Bungo Barat
15.08.03.1022|Jaya Setia
15.08.03.1023|Batang Bungo
15.08.04.2001|Tanjung Belit
15.08.04.2002|Rantau Ikil
15.08.04.2003|Pulau Jelmu
15.08.04.2004|Sirih Sekapur
15.08.04.2005|Ujung Tanjung
15.08.04.2007|Jumbak
15.08.04.2009|Rantau Panjang
15.08.04.2013|Talang Pamesun
15.08.04.2014|Baru Balai Panjang
15.08.04.2015|Sirih Sekapur Perkembangan
15.08.05.2001|Teluk Pandak
15.08.05.2003|Empelu
15.08.05.2006|Pasar Lubuk Landai
15.08.05.2007|Sungai Gambir
15.08.05.2009|Candi
15.08.05.2010|Tanjung
15.08.05.2012|Tanah Bekali
15.08.05.2015|Telentam
15.08.05.2017|Pasar Rantau Embacang
15.08.05.2019|Tenam
15.08.06.2001|Baru Pelepat
15.08.06.2002|Dwi Karya Bakti
15.08.06.2003|Rantau Keloyang
15.08.06.2004|Balai Jaya
15.08.06.2005|Rantel
15.08.06.2006|Senamat
15.08.06.2007|Sungai Beringin
15.08.06.2008|Sungai Gurun
15.08.06.2009|Batu Kerbau
15.08.06.2010|Gapura Suci
15.08.06.2011|Mulya Bakti
15.08.06.2012|Mulya Jaya
15.08.06.2013|Cilodang
15.08.06.2014|Bukit Telago
15.08.06.2015|Sekampil
15.08.07.2001|Tanjung Bungo
15.08.07.2002|Tuo Lbk. Mengkuang
15.08.07.2003|Pauh Agung
15.08.07.2004|Tuo Limbur
15.08.07.2005|Renah Sungai Besar
15.08.07.2006|Muaro Tebo Pandak
15.08.07.2007|Rantau Tipu
15.08.07.2008|Baru Lbk. Mengkuang
15.08.07.2009|Lbk. Tanah Terban
15.08.07.2010|Pemunyian
15.08.07.2011|Renah Sungai Ipuh
15.08.07.2012|Tebo Jaya
15.08.07.2013|Sekar Mengkuang
15.08.07.2014|Limbur Baru
15.08.08.2001|Mangun Jayo
15.08.08.2002|Tanjung Agung
15.08.08.2003|Tebat
15.08.08.2004|Baru Pusat Jalo
15.08.08.2005|Bedaro
15.08.08.2006|Tebing Tinggi
15.08.08.2007|Datar
15.08.08.2008|Suka Jaya
15.08.08.2009|Pekan Jum'at
15.08.09.2001|Koto Jayo
15.08.09.2002|Danau
15.08.09.2003|Muara Kuamang
15.08.09.2004|Lubuk
15.08.09.2005|Purwosari
15.08.09.2006|Lembah Kuamang
15.08.09.2007|Sumber Harapan
15.08.09.2008|Daya Murni
15.08.09.2009|Sumber Mulya
15.08.09.2010|Maju Jaya
15.08.09.2011|Tirta Mulya
15.08.09.2012|Lingga Kuamang
15.08.09.2013|Bangun Harjo
15.08.09.2014|Kuning gading
15.08.09.2015|Kuamang Jaya
15.08.09.2016|Karya Harapan Mukti
15.08.09.2017|Padang Palangeh
15.08.10.2001|Tanjung Menanti
15.08.10.2002|Babeko
15.08.10.2003|Sepunggur
15.08.10.2004|Simpang Bebeko
15.08.10.2005|Suka Makmur
15.08.10.2006|Tuo Sepunggur
15.08.11.1001|Manggis
15.08.11.1003|Bungo Taman Agung
15.08.11.1004|Sungai Binjai
15.08.11.2002|Lubuk Benteng
15.08.11.2005|Air Gemuruh
15.08.11.2006|Purwo Bakti
15.08.11.2007|Sarana Jaya
15.08.11.2008|Teluk Panjang
15.08.12.1001|Sungai Pinang
15.08.12.1002|Sungai Kerjan
15.08.12.2003|Talang Pantai
15.08.12.2004|Sungai Arang
15.08.12.2005|Pulau Pekan
15.08.13.1001|Pasir Putih
15.08.13.1002|Cadika
15.08.13.2003|Sungai Mengkuang
15.08.13.2004|Sungai Buluh
15.08.14.2001|Muara Buat
15.08.14.2002|Buat
15.08.14.2003|Laman Panjang
15.08.14.2004|Karak Apung
15.08.14.2005|Timbolasi
15.08.14.2006|Senamat Ulu
15.08.14.2007|Aur Cino
15.08.14.2008|Lubuk Beringin
15.08.14.2009|Sungai Telang
15.08.15.2001|Pelayang
15.08.15.2002|Peninjau
15.08.15.2003|Talang Silungko
15.08.15.2004|Pulau Kerakap
15.08.15.2005|Seberang Jaya
15.08.16.2001|Tepian Danto
15.08.16.2002|Aur Gading
15.08.16.2003|Pulau Batu
15.08.16.2004|Sari Mulya
15.08.16.2005|Bukit Sari
15.08.16.2006|Lubuk Tenam
15.08.16.2007|Kuamang
15.08.17.2001|Sungai Mancur
15.08.17.2002|Tanah Periuk
15.08.17.2003|Lubuk Landai
15.08.17.2004|Rantau Embacang
15.08.17.2005|Tebing Tinggi
15.08.17.2006|Embacang Gedang
15.08.17.2007|Sungai Puri
15.08.17.2008|Paku Aji
15.08.17.2009|Pematang Panjang
15.08.17.2010|Sungai Lilin
15.08.17.2011|Sungai Tembang
15.08.17.2012|Rantau Makmur
15.09.01.1001|Muara Tebo
15.09.01.1002|Tebing Tinggi
15.09.01.2003|Bedaro Rampak
15.09.01.2004|Mangun Jayo
15.09.01.2005|Teluk Pandak
15.09.01.2006|Tengah Ulu
15.09.01.2007|Semabu
15.09.01.2008|Kandang
15.09.01.2009|Pelayang
15.09.01.2010|Sungai Keruh
15.09.01.2011|Aburan Batang Tebo
15.09.01.2012|Sungai Alai
15.09.02.1001|Sungai Bengkal
15.09.02.2002|Sungai Aro
15.09.02.2003|Teluk Rendah Pasar
15.09.02.2004|Teluk Rendah Ulu
15.09.02.2005|Teluk Rendah Ilir
15.09.02.2008|Tuo Ilir
15.09.02.2011|Betung Bedarah Timur
15.09.02.2012|Betung Bedarah Barat
15.09.02.2014|Kunangan
15.09.02.2015|Muara ketalo
15.09.02.2017|Sungai Bengkal Barat
15.09.02.2018|Kemantan
15.09.03.1001|Pulau Temiang
15.09.03.2002|Sungai Rambai
15.09.03.2003|Pagar Puding
15.09.03.2004|Teluk Kembang Jambu
15.09.03.2005|Teluk Kasai Rambahan
15.09.03.2006|Rantau langkap
15.09.03.2007|Tanjung Aur
15.09.03.2008|Bungo Tanjung
15.09.03.2009|Pulau Panjang
15.09.03.2010|Lubuk Benteng
15.09.03.2011|Teluk Kuali
15.09.03.2012|Melako Intan
15.09.03.2015|Jambu
15.09.03.2016|Pulau Jelmu
15.09.03.2017|Medan Seri Rambahan
15.09.03.2018|Ulak Banjir Rambahan
15.09.03.2019|Teluk Pandan Rambahan
15.09.04.1001|Wirotho Agung
15.09.04.1009|Sarana Agung
15.09.04.1010|Mandiri Agung
15.09.04.2002|Perintis
15.09.04.2003|Rimbo Mulyo
15.09.04.2004|Purwo Harjo
15.09.04.2005|Tegal Arum
15.09.04.2006|Tirta Kencana
15.09.04.2007|Sapta Mulia
15.09.04.2008|Pematang Sapat
15.09.04.2011|Mekar Kencana
15.09.04.2012|Purwo Dadi
15.09.04.2013|Tegal Asri
15.09.04.2014|Perintis Jaya
15.09.04.2015|Perintis Makmur
15.09.04.2016|Jaya Mulya
15.09.05.2001|Teluk Singkawang
15.09.05.2002|Lembak Bungur
15.09.05.2003|Teluk Langkap
15.09.05.2004|Tambun Arang
15.09.05.2005|Punti Kalo
15.09.05.2006|Jati Belarik
15.09.05.2007|Tuo Sumay
15.09.05.2008|Teriti
15.09.05.2009|Suo-Suo
15.09.05.2010|Muara Sekalo
15.09.05.2011|Semambu
15.09.05.2012|Pemayungan
15.09.06.2001|Tanjung Pucuk Jambi
15.09.06.2002|Kuamang
15.09.06.2003|Teluk Kayu Putih
15.09.06.2004|Sungai Abang
15.09.06.2005|Aur Cino
15.09.06.2007|Muara Niro
15.09.06.2013|Teluk Lancang
15.09.06.2014|Dusun Baru
15.09.06.2015|Tabun
15.09.06.2016|Muara Tabun
15.09.07.2001|Suka Damai
15.09.07.2002|Wana Reja
15.09.07.2003|Sumber Sari
15.09.07.2004|Sido Rukun
15.09.07.2005|Sungai Pandan
15.09.07.2006|Suka Maju
15.09.07.2007|Mekar Sari
15.09.07.2008|Wana Arum
15.09.07.2009|Wana Mulya
15.09.07.2010|Damai Makmur
15.09.07.2011|Suka Jaya
15.09.07.2012|Sido Mulyo
15.09.08.2001|Giriwinangun
15.09.08.2002|Sidorejo
15.09.08.2003|Pulung Rejo
15.09.08.2004|Karang Dadi
15.09.08.2005|Giri Purno
15.09.08.2006|Sumber Agung
15.09.08.2007|Sari Mulya
15.09.08.2008|Sepakat Bersatu
15.09.08.2009|Rantau Kembang
15.09.08.2010|Giri Mulyo
15.09.09.2001|Muara Kilis
15.09.09.2002|Penapalan
15.09.09.2003|Mengupeh
15.09.09.2004|Rantau Api
15.09.09.2005|Lubuk Mandarsah
15.09.09.2006|Lubuk Mandarsah Ulu
15.09.10.2001|Pinang Belai
15.09.10.2002|Sekutur Jaya
15.09.10.2003|Bukit Pemuatan
15.09.10.2004|Napal Putih
15.09.10.2005|Sako Makmur
15.09.10.2006|Pagar Puding Lamo
15.09.10.2007|Tanjung Aur Seberang
15.09.10.2008|Teluk Melintang
15.09.11.2001|Teluk Kepayang Pulau Indah
15.09.11.2002|Balai Rajo
15.09.11.2003|Cermin Alam
15.09.11.2004|Sungai Karang
15.09.11.2005|Paseban
15.09.11.2006|Pasir Mayang
15.09.12.2001|Tanah Garo
15.09.12.2002|Pintas Tuo
15.09.12.2003|Embacang Gedang
15.09.12.2004|Bangun Seranten
15.09.12.2005|Tambun Arang
15.09.12.2006|Sungai Jernih
15.09.12.2007|Bangko Pintas
15.09.12.2008|Olak Kemang
15.71.01.1001|Simpang IV Sipin
15.71.01.1002|Buluran Kenali
15.71.01.1003|Teluk Kenali
15.71.01.1004|Telanaipura
15.71.01.1010|Penyengat Rendah
15.71.01.1011|Pematang Sulur
15.71.01.1012|Aur Kenali
15.71.02.1002|Pasir Putih
15.71.02.1003|Tambak Sari
15.71.02.1004|Thehok
15.71.02.1005|Wijaya Pura
15.71.02.1006|Pakuan Baru
15.71.03.1001|Sijenjang
15.71.03.1002|Kasang Jaya
15.71.03.1003|Talang Banjar
15.71.03.1004|Budiman
15.71.03.1005|Sulanjana
15.71.03.1006|Kasang
15.71.03.1007|Tanjung Sari
15.71.03.1008|Rajawali
15.71.03.1010|Tanjung Pinang
15.71.04.1001|Beringin
15.71.04.1002|Orang Kayo Hitam
15.71.04.1003|Pasar Jambi
15.71.04.1004|Sungai Asam
15.71.05.1001|Arab Melayu
15.71.05.1002|Mudung Laut
15.71.05.1003|Jelmu
15.71.05.1004|Tengah
15.71.05.1005|Tahtul Yaman
15.71.05.1006|Tanjung Johor
15.71.06.1001|Pasir Panjang
15.71.06.1002|Tanjung Raden
15.71.06.1003|Olak Kemang
15.71.06.1004|Tanjung Pasir
15.71.06.1005|Ulu Gedong
15.71.07.1001|Suka Karya
15.71.07.1002|Simpang III Sipin
15.71.07.1004|Paal Lima
15.71.07.1005|Kenali Asam Bawah
15.71.07.1006|Kenali Asam Atas
15.71.07.1011|Talang Gulo
15.71.07.1012|Kenali Asam
15.71.08.1001|Talang Jauh
15.71.08.1002|Cempaka Putih
15.71.08.1003|Kebun Handil
15.71.08.1004|Lebak Bandung
15.71.08.1005|Payo Lebar
15.71.08.1006|Jelutung
15.71.08.1007|Handil Jaya
15.71.09.1001|Kenali Besar
15.71.09.1002|Rawa Sari
15.71.09.1003|Mayang Mangurai
15.71.09.1004|Bagan Pete
15.71.09.1005|Beliung
15.71.09.1006|Simpang Rimbo
15.71.09.1007|Pinang Merah
15.71.10.1001|Sungai Putri
15.71.10.1002|Murni
15.71.10.1003|Legok
15.71.10.1004|Selamat
15.71.10.1005|Solok Sipin
15.71.11.1001|Talang Bakung
15.71.11.1002|Payo Selincah
15.71.11.1003|Eka Jaya
15.71.11.1004|Lingkar Selatan
15.71.11.1005|Paal Merah
15.71.11.1006|Bakung Jaya
15.72.01.1001|Sungai Penuh
15.72.01.1003|Pasar Sungai Penuh
15.72.01.2004|Pasar Baru
15.72.01.2006|Gedang
15.72.01.2014|Amar Sakti
15.72.02.2001|Koto Renah
15.72.02.2002|Koto Keras
15.72.02.2003|Koto Bento
15.72.02.2004|Koto Lolo
15.72.02.2005|Koto Tengah
15.72.02.2008|Koto Duo
15.72.02.2010|Sungai Liuk
15.72.02.2011|Seberang
15.72.02.2015|Sumur Gedang
15.72.03.2001|Kampung Diilir
15.72.03.2002|Koto Beringin
15.72.03.2003|Maliki Air
15.72.03.2004|Tanjung
15.72.03.2005|Koto Teluk
15.72.03.2006|Kampung Dalam
15.72.03.2007|Simpang Tiga Rawang
15.72.03.2008|Larik Kemahan
15.72.03.2009|Dusun Diilir
15.72.03.2010|Paling Serumpun
15.72.03.2011|Koto Dian
15.72.03.2012|Tanjung Muda
15.72.03.2013|Cempaka
15.72.04.2001|Baru Debai
15.72.04.2002|Pendung Hiang
15.72.04.2003|Koto Pudung
15.72.04.2004|Koto Dumo
15.72.04.2005|Sembilan
15.72.04.2006|Koto Tuo
15.72.04.2007|Koto Panap
15.72.04.2008|Koto Tengah
15.72.04.2009|Tanjung Bunga
15.72.04.2010|Koto Padang
15.72.04.2011|Tanjung Karang
15.72.04.2012|Kt. Baru Tanah Kampung
15.72.04.2013|Mekar Jaya
15.72.05.2001|Kumun Hilir
15.72.05.2002|Kumun Mudik
15.72.05.2003|Air Teluh
15.72.05.2004|Sandaran Galeh
15.72.05.2005|Debai
15.72.05.2006|Pinggir Air
15.72.05.2007|Renah Kayu Embun
15.72.05.2008|Ulu Air
15.72.05.2009|Muara Jaya
15.72.06.1008|Pondok Tinggi
15.72.06.2001|Sungai Jernih
15.72.06.2002|Aur Duri
15.72.06.2003|Pondok Agung
15.72.06.2004|Permanti
15.72.06.2005|Lawang Agung
15.72.06.2006|Karya Bakti
15.72.06.2007|Koto Lebu
15.72.07.2001|Koto Baru
15.72.07.2002|Koto Limau Manis
15.72.07.2003|Kampung Tengah
15.72.07.2004|Dujung Sakti
15.72.07.2005|Permai Indah
15.72.07.2006|Srimenanti
15.72.08.1005|Dusun Baru
15.72.08.2001|Sumur Anyir
15.72.08.2002|Koto Tinggi
15.72.08.2003|Talang Lindung
15.72.08.2004|Pelayang Raya
15.72.08.2006|Sungai Ning
16.01.07.2001|Negeri Sindang
16.01.07.2002|Rantau Kumpai
16.01.07.2003|Lubuk Baru
16.01.07.2004|Kungkilan
16.01.07.2005|Penyandingan
16.01.07.2006|Bandar
16.01.07.2007|Lubuk Leban
16.01.07.2008|Tungku Jaya
16.01.07.2009|Mekar Sari
16.01.07.2010|Mekar Jaya
16.01.07.2011|Penantian
16.01.08.2001|Gunung Meraksa
16.01.08.2003|Tanjung Pura
16.01.08.2004|Tanjung Sari
16.01.08.2005|Tangsi Lontar
16.01.08.2006|Belambangan
16.01.08.2007|Kesambirata
16.01.08.2008|Gunung Liwat
16.01.08.2015|Pengandonan
16.01.08.2016|Semanding
16.01.08.2017|Tanjungan
16.01.08.2018|Ujanmas
16.01.08.2019|Gunung Kuripan
16.01.09.2001|Kepayang
16.01.09.2002|Kedondong
16.01.09.2003|Belimbing
16.01.09.2004|Durian
16.01.09.2006|Lubuk Rukam
16.01.09.2007|Bindu
16.01.09.2009|Mendala
16.01.09.2010|Peninjauan
16.01.09.2011|Saung Naga
16.01.09.2022|Makartitama
16.01.09.2023|Espetiga
16.01.09.2024|Makarti Jaya
16.01.09.2025|Mitra Kencana
16.01.09.2026|Penilikan
16.01.09.2027|Panji Jaya
16.01.09.2028|Karang Dapo
16.01.13.1003|Tanjungagung
16.01.13.1004|Saung Naga
16.01.13.1005|Talang Jawa
16.01.13.1007|Batu Kuning
16.01.13.1011|Air Gading
16.01.13.2001|Batu Putih
16.01.13.2002|Laya
16.01.13.2006|Pusar
16.01.13.2008|Karang Agung
16.01.13.2009|Karang Endah
16.01.13.2010|Tanjung Karang
16.01.13.2012|Sukamaju
16.01.14.1001|Baturaja Lama
16.01.14.1003|Pasar Baru
16.01.14.1004|Kemalaraja
16.01.14.1005|Sukaraya
16.01.14.1006|Sukajadi
16.01.14.1011|Kemelak Bindung Langit
16.01.14.1012|Sepancar Lawang Kulon
16.01.14.1013|Baturaja Permai
16.01.14.1014|Sekar Jaya
16.01.14.2007|Tanjung Kemala
16.01.14.2008|Tanjung Baru
16.01.14.2015|Air Paoh
16.01.14.2016|Terusan
16.01.20.2001|Kelumpang
16.01.20.2002|Gunung Tiga
16.01.20.2003|Mendingin
16.01.20.2004|Ulak Lebar
16.01.20.2005|Pedataran
16.01.20.2006|Sukajadi
16.01.20.2007|Belandang
16.01.21.2001|Tanjung Kurung
16.01.21.2002|Sukarami
16.01.21.2003|Batanghari
16.01.21.2004|Nyiur Sayak
16.01.21.2005|Suka Merindu
16.01.21.2006|Padang Bindu
16.01.21.2007|Panggal Panggang
16.01.21.2008|Bedegung
16.01.21.2009|Ulak Pandan
16.01.21.2010|Keban Agung
16.01.21.2011|Tubohan
16.01.21.2012|Raksa Jiwa
16.01.21.2013|Seleman
16.01.21.2014|Kebun Jati
16.01.21.2015|Singapura
16.01.21.2016|Pengaringan
16.01.21.2017|Banjarsari
16.01.21.2018|Pandan Dulang
16.01.21.2020|Panai Makmur
16.01.21.2021|Guna Makmur
16.01.21.2022|Tebing Kampung
16.01.22.2001|Merbau
16.01.22.2002|Gunung Meraksa
16.01.22.2003|Kurup
16.01.22.2004|Banu Ayu
16.01.22.2005|Tanjung Dalam
16.01.22.2006|Lubuk Batang Baru
16.01.22.2007|Lubuk Batang Lama
16.01.22.2008|Belatung
16.01.22.2009|Karta Mulya
16.01.22.2010|Lunggaian
16.01.22.2011|Bandar Agung
16.01.22.2012|Tanjung Manggus
16.01.22.2015|Markisa
16.01.22.2016|Air Wall
16.01.22.2017|Sumber Bahagia
16.01.28.2001|Bandar Jaya
16.01.28.2002|Karang Endah
16.01.28.2003|Pajar Bulan
16.01.28.2004|Pagar Dewa
16.01.28.2005|Bumi Kawa
16.01.28.2006|Tanjunglengkayap
16.01.28.2007|Lubuk Dalam
16.01.28.2008|Negeri Ratu
16.01.28.2009|Segara Kembang
16.01.28.2010|Tihang
16.01.28.2011|Lubuk Hara
16.01.28.2012|Sukaraja
16.01.28.2013|Negeri Agung
16.01.28.2014|Gedung Pekuon
16.01.28.2015|Tualang
16.01.28.2016|Sundan
16.01.28.2017|Bunga Tanjung
16.01.28.2018|Way Heling
16.01.28.2019|Umpam
16.01.28.2020|Fajar Jaya
16.01.28.2021|Simpang Empat
16.01.28.2022|Tanjungagung
16.01.29.2001|Karya Jaya
16.01.29.2002|Karya Mukti
16.01.29.2003|Marga Bakti
16.01.29.2004|Sri Mulya
16.01.29.2005|Marga Mulya
16.01.29.2006|Tanjung Makmur
16.01.30.2001|Batu Marta I
16.01.30.2002|Batu Marta II
16.01.30.2003|Lekis Rejo
16.01.30.2004|Lubuk Banjar
16.01.30.2005|Marta Jaya
16.01.30.2006|Batu Raden
16.01.30.2007|Battu Winangun
16.01.31.2001|Kemala Jaya
16.01.31.2002|Lontar
16.01.31.2003|Muara Saeh
16.01.31.2004|Lubuk Tupak
16.01.31.2005|Beringin
16.01.31.2006|Surau
16.01.31.2007|Karang Lantang
16.01.32.2001|Bunglai
16.01.32.2002|Kedaton
16.01.32.2003|Kampai
16.01.32.2004|Rantau Panjang
16.01.32.2005|Kedaton Timur
16.01.32.2006|Suka Pindah
16.01.32.2007|Sinar Kedaton
16.01.32.2008|Lubuk Kemiling
16.02.02.1011|Tanjung Lubuk
16.02.02.2001|Ulak Kapal
16.02.02.2002|Tanjung Merindu
16.02.02.2003|Tanjung Baru
16.02.02.2004|Seritanjung
16.02.02.2005|Pengaraian
16.02.02.2006|Sukarami
16.02.02.2008|Sukamulya
16.02.02.2010|Pulau Gemantung
16.02.02.2012|Bumiagung
16.02.02.2013|Kotabumi
16.02.02.2014|Tanjung Beringin
16.02.02.2015|Tanjung Laga
16.02.02.2016|Tanjung Laut
16.02.02.2017|Ulak Balam
16.02.02.2018|Jambu Ilir
16.02.02.2031|Jukdadak
16.02.02.2032|Atar Balam
16.02.02.2033|Tanjung Harapan
16.02.02.2034|Pulau Gemantung Ilir
16.02.02.2035|Pulau Gemantung Ulu
16.02.02.2036|Pulau Gemantung Darat
16.02.03.2002|Pedamaran VI
16.02.03.2003|Pedamaran V
16.02.03.2004|Pedamaran IV
16.02.03.2005|Pedamaran III
16.02.03.2006|Pedamaran II
16.02.03.2007|Pedamaran I
16.02.03.2008|Cinta Jaya
16.02.03.2009|Sukadamai
16.02.03.2010|Serinanti
16.02.03.2011|Sukaraja
16.02.03.2017|Burnai Timur
16.02.03.2018|Suka Pulih
16.02.03.2019|Menang Raya
16.02.03.2021|Lebuh Rarak
16.02.04.2001|Pematang Panggang
16.02.04.2002|Sungai Sodong
16.02.04.2005|Pagar Dewa
16.02.04.2006|Surya Adi
16.02.04.2007|Makarti Mulya
16.02.04.2008|Marga Bakti
16.02.04.2009|Jaya Bakti
16.02.04.2025|Sukamukti
16.02.04.2026|Mekar Wangi
16.02.04.2035|Karya Mukti
16.02.04.2037|Kalideras
16.02.04.2038|Sumber Deras
16.02.04.2047|Kembang Jajar
16.02.04.2050|Kota Baru
16.02.04.2051|Sido Basuki
16.02.04.2052|Pematang Kasih
16.02.04.2053|Labuhan Jaya
16.02.05.1001|Jua-jua
16.02.05.1002|Kayuagung
16.02.05.1003|Sidakersa
16.02.05.1004|Cintaraja
16.02.05.1005|Mangun Jaya
16.02.05.1006|Paku
16.02.05.1007|Kedaton
16.02.05.1008|Sukadana
16.02.05.1009|Perigi
16.02.05.1010|Kutaraja
16.02.05.1025|Tanjung Rancing
16.02.05.2011|Kijang Ulu
16.02.05.2012|Muarabaru
16.02.05.2013|Tanjung Lubuk
16.02.05.2014|Arisan Buntal
16.02.05.2015|Celikah
16.02.05.2016|Banding Anyar
16.02.05.2017|Buluh Cawang
16.02.05.2018|Lubuk Dalam
16.02.05.2019|Anyar
16.02.05.2020|Tanjung Menang
16.02.05.2021|Teloko
16.02.05.2022|Tanjung Serang
16.02.05.2023|Serigeni Baru
16.02.05.2024|Serigeni
16.02.08.2001|Tanjung Alai
16.02.08.2002|Batu Ampar
16.02.08.2003|Awal Terusan
16.02.08.2004|Ulak Jermun
16.02.08.2005|Mangun Jaya
16.02.08.2006|Terusan Menang
16.02.08.2007|Belanti
16.02.08.2008|Terate
16.02.08.2009|Rengas Pitu
16.02.08.2010|Pantai
16.02.08.2011|Sirah Pulau Padang
16.02.08.2012|Serdang Menang
16.02.08.2013|Bungin Tinggi
16.02.08.2014|Penyandingan
16.02.08.2015|Berkat
16.02.08.2016|Sukaraja
16.02.08.2017|Pematang Buluran
16.02.08.2018|Rawang Besar
16.02.08.2019|Batu Ampar Baru
16.02.08.2020|Terusan Laut
16.02.11.1016|Tulung Selapan Ulu
16.02.11.2001|Simpang Tiga
16.02.11.2002|Pulau Beruang
16.02.11.2003|Penyandingan
16.02.11.2004|Tanjung Batu
16.02.11.2005|Toman
16.02.11.2006|Cambai
16.02.11.2007|Kayuara
16.02.11.2008|Petaling
16.02.11.2009|Tulung Selapan Ilir
16.02.11.2010|Ujung Tanjung
16.02.11.2011|Lebung Gajah
16.02.11.2012|Lebung Itam
16.02.11.2013|Penanggoan Duren
16.02.11.2014|Jerambah Rengas
16.02.11.2015|Simpang Tiga Makmur
16.02.11.2017|Simpang Tiga Jaya
16.02.11.2018|Simpang Tiga Sakti
16.02.11.2019|Tulung Seluang
16.02.11.2020|Rantau Lurus
16.02.11.2021|Kuala Dua Belas
16.02.11.2022|Simpang Tiga Abadi
16.02.11.2023|Tulung Selapan Timur
16.02.12.2001|Ulak Kemang
16.02.12.2002|Sepang
16.02.12.2003|Keman
16.02.12.2004|Kandis
16.02.12.2005|Ulak Depati
16.02.12.2006|Pulau Layang
16.02.12.2007|Tapus
16.02.12.2008|Pulau Betung
16.02.12.2009|Bangsal
16.02.12.2010|Kuro
16.02.12.2011|Menggeris
16.02.12.2012|Pampangan
16.02.12.2013|Serimenang
16.02.12.2014|Secondong
16.02.12.2015|Jermun
16.02.12.2016|Serdang
16.02.12.2017|Jungkal
16.02.12.2035|Tanjung Kemang
16.02.12.2036|Ulak Pianggu
16.02.12.2037|Ulak Kemang Baru
16.02.12.2038|Keman Baru
16.02.12.2039|Sri Mulya
16.02.13.2005|Tebing Suluh
16.02.13.2006|Cahya Bumi
16.02.13.2007|Kutapandan
16.02.13.2008|Cahaya Maju
16.02.13.2009|Bumiagung
16.02.13.2010|Sumberagung
16.02.13.2011|Tugumulyo
16.02.13.2013|Dabuk Rejo
16.02.13.2014|Suka Mulya
16.02.13.2015|Bumi Arjo
16.02.13.2016|Tulung Harapan
16.02.13.2017|Kepayang
16.02.13.2025|Tugu Jaya
16.02.13.2026|Tugu Agung
16.02.13.2027|Sindang Sari
16.02.13.2028|Mekar Jaya
16.02.13.2034|Bumiarjo Makmur
16.02.13.2035|Cahaya Makmur
16.02.13.2036|Sumber Makmur
16.02.14.2001|Tirta Mulya
16.02.14.2002|Suka Mulya
16.02.14.2003|Jadi Mulya
16.02.14.2004|Marga Tani
16.02.14.2005|Bandar Jaya
16.02.14.2006|Mukti Jaya
16.02.14.2007|Srijaya Baru
16.02.14.2008|Nusantara
16.02.14.2009|Kerta Mukti
16.02.14.2010|Nusakerta
16.02.14.2011|Banyu Biru
16.02.14.2012|Pangkalan Damai
16.02.14.2013|Negeri Sakti
16.02.14.2014|Rantau Karya
16.02.14.2015|Pangkalan Sakti
16.02.14.2016|Simpang Heran
16.02.14.2017|Rengas Abang
16.02.14.2018|Bukit Batu
16.02.14.2019|Sungai Batang
16.02.15.2001|Sungai Menang
16.02.15.2002|Karangsia
16.02.15.2003|Sungai Ceper
16.02.15.2004|Gajah Mati
16.02.15.2005|Sungai Tepuk
16.02.15.2006|Sungai Sibur
16.02.15.2007|Talang Makmur
16.02.15.2008|Harapan Jaya
16.02.15.2009|Talang Jaya
16.02.15.2010|Sidomulyo
16.02.15.2011|Bumi Pratama Mandira
16.02.15.2012|Pinang Indah
16.02.15.2013|Gajah Makmur
16.02.15.2014|Gading Jaya
16.02.15.2015|Gajah Mukti
16.02.15.2016|Gajah Mulya
16.02.15.2017|Sri Gading
16.02.15.2018|Gading Mas
16.02.17.2001|Tanjung Aur
16.02.17.2002|Lubuk Ketepeng
16.02.17.2003|Talang Cempedak
16.02.17.2004|Bubusan
16.02.17.2005|Air Itam
16.02.17.2006|Jejawi
16.02.17.2007|Karang Agung
16.02.17.2008|Muara Batun
16.02.17.2009|Lingkis
16.02.17.2010|Terusan Jawa
16.02.17.2011|Tanjung Ali
16.02.17.2012|Sukadarma
16.02.17.2013|Ulak Tembaga
16.02.17.2014|Pedu
16.02.17.2015|Pematang Kijang
16.02.17.2016|Simpang Empat
16.02.17.2017|Padang Bulan
16.02.17.2018|Batun Baru
16.02.17.2019|Danau Ceper
16.02.18.2001|Sungai Somor
16.02.18.2002|Sungai Lumpur
16.02.18.2003|Sungai Jeruju
16.02.18.2004|Sungai Ketupak
16.02.18.2005|Ulak Kedondong
16.02.18.2006|Pelimbangan
16.02.18.2007|Cengal
16.02.18.2008|Talang Rimba
16.02.18.2009|Sungai Pasir
16.02.18.2010|Kuala Sungai Jeruju
16.02.18.2011|Kuala Sungai Pasir
16.02.18.2012|Pantai Harapan
16.02.18.2013|Adil Makmur
16.02.18.2014|Balam Jeruju
16.02.18.2015|Kebun Cabe
16.02.18.2016|Lebak Beriang
16.02.18.2017|Parit Raya
16.02.19.2001|Deling
16.02.19.2002|Pangkalan Lampan
16.02.19.2003|Lirik
16.02.19.2004|Lebung Batang
16.02.19.2005|Sungai Bungin
16.02.19.2006|Sukaraja
16.02.19.2007|Darat
16.02.19.2008|Pulauan
16.02.19.2009|Riding
16.02.19.2010|Sunggutan
16.02.19.2011|Suka Damai
16.02.19.2012|Air Pedara
16.02.19.2013|Rimba Samak
16.02.19.2014|Talang Daya
16.02.19.2015|Air Rumbai
16.02.19.2016|Rambai
16.02.19.2017|Perigi
16.02.19.2018|Bukit Batu
16.02.19.2019|Rawa Tenam
16.02.20.2001|Catur Tunggal
16.02.20.2002|Surya Karta
16.02.20.2003|Tegal Sari
16.02.20.2004|Mukti Karya
16.02.20.2005|Pematang Jaya
16.02.20.2006|Pematang Sukatani
16.02.20.2007|Kampung Baru
16.02.20.2008|Cahaya Mas
16.02.20.2009|Karya Usaha
16.02.20.2010|Pematang Binatani
16.02.20.2011|Bina Karsa
16.02.20.2012|Pematang Sari
16.02.20.2013|Pematang Sukaramah
16.02.20.2014|Cahaya Mulya
16.02.20.2015|Gading Sari
16.02.20.2017|Karya Jaya
16.02.20.2018|Mesuji Jaya
16.02.20.2019|Sumber Mulya
16.02.20.2020|Beringin Jaya
16.02.21.2001|Embacang
16.02.21.2002|Balian
16.02.21.2003|Sumbu Sari
16.02.21.2004|Suka Sari
16.02.21.2005|Ciptasari
16.02.21.2006|Mataram Jaya
16.02.21.2007|Bumi Makmur
16.02.21.2008|Sumber Baru
16.02.21.2009|Mulya Jaya
16.02.21.2010|Rotan Mulya
16.02.21.2011|Embacang Permai
16.02.21.2012|Gedung Rejo
16.02.21.2013|Kertamukti
16.02.21.2014|Kemang Indah
16.02.21.2015|Balian Makmur
16.02.21.2016|Sedyomulyo
16.02.21.2017|Dabuk Makmur
16.02.22.2001|Tanjung Sari I
16.02.22.2002|Lubuk Seberuk
16.02.22.2003|Rantau Durian I
16.02.22.2004|Sungai Belida
16.02.22.2005|Lempuing Indah
16.02.22.2006|Muktisari
16.02.22.2007|Tania Makmur
16.02.22.2008|Sukamaju
16.02.22.2009|Muara Burnai II
16.02.22.2010|Suka Jaya
16.02.22.2011|Rantau Durian II
16.02.22.2012|Tanjung Sari II
16.02.22.2013|Purwo Asri
16.02.22.2014|Muara Burnai I
16.02.22.2015|Lubuk Makmur
16.02.22.2016|Rantau Durian Asli
16.02.23.2001|Benawa
16.02.23.2002|Serapek
16.02.23.2003|Sugih Waras
16.02.23.2004|Muara Telang
16.02.23.2005|Kuripan
16.02.23.2006|Cinta Marga
16.02.23.2007|Penyandingan
16.02.23.2008|Talang Pengeran
16.02.23.2009|Ulak Ketapang
16.02.23.2010|Mulyaguna
16.02.23.2011|Panca Tunggal Benawa
16.02.23.2012|Bumi Harapan
16.02.23.2013|Sinar Harapan Mulya
16.02.23.2014|Seriguna
16.02.24.2001|Pulau Geronggang
16.02.24.2002|Sumber Hidup
16.02.24.2003|Gading Raja
16.02.24.2004|Maribaya
16.02.24.2005|Pancawarna
16.02.24.2006|Tanjung Makmur
16.02.24.2007|Kayu Labu
16.03.01.2011|Embawang
16.03.01.2012|Pagar Dewa
16.03.01.2013|Tanjung Bulan
16.03.01.2014|Lesung Batu
16.03.01.2015|Pandan Enim
16.03.01.2016|Paduraksa
16.03.01.2017|Matas
16.03.01.2018|Tanjung Agung
16.03.01.2019|Muara Emil
16.03.01.2020|Tanjung Karangan
16.03.01.2021|Seleman
16.03.01.2022|Penyandingan
16.03.01.2023|Tanjung Lalang
16.03.01.2024|Pulau Panggung
16.03.02.1006|Tungkal
16.03.02.1007|Pasar II Muara Enim
16.03.02.1008|Pasar III Muara Enim
16.03.02.1009|Pasar I Muara Enim
16.03.02.1010|Muara Enim
16.03.02.1016|Air Lintang
16.03.02.2001|Tanjung Raja
16.03.02.2002|Karang Raja
16.03.02.2003|Muara Lawai
16.03.02.2004|Tanjung Jati
16.03.02.2005|Lubuk Emplas
16.03.02.2011|Kepur
16.03.02.2012|Tanjung Serian
16.03.02.2013|Muara Harapan
16.03.02.2014|Saka Jaya
16.03.02.2015|Harapan Jaya
16.03.03.2001|Gemawang
16.03.03.2002|Lubuk Raman
16.03.03.2003|Jemenang
16.03.03.2004|Tanjung Menang
16.03.03.2005|Tebat Agung
16.03.03.2006|Gerinam
16.03.03.2014|Suban Jeriji
16.03.03.2015|Air Limau
16.03.03.2016|Muara Emburung
16.03.03.2017|Manunggal Jaya
16.03.03.2018|Air Talas
16.03.03.2019|Air Enau
16.03.03.2020|Manunggal Makmur
16.03.03.2021|Aur Duri
16.03.03.2023|Kasih Dewa
16.03.03.2024|Air Cekdam
16.03.04.2001|Penanggiran
16.03.04.2002|Gunung Megang Luar
16.03.04.2003|Gunung Megang Dalam
16.03.04.2004|Lubuk Mumpo
16.03.04.2005|Perjito
16.03.04.2006|Tanjung Muning
16.03.04.2007|Tanjung Terang
16.03.04.2016|Bangun Sari
16.03.04.2017|Sumaja Makmur
16.03.04.2018|Sidomulyo
16.03.04.2019|Pajar Indah
16.03.04.2020|Kayu Ara Sakti
16.03.04.2021|Panang Jaya
16.03.06.1010|Gelumbang
16.03.06.2004|Gaung Telang
16.03.06.2006|Pinang Banjar
16.03.06.2008|Segayam
16.03.06.2009|Tambangan Kelekar
16.03.06.2011|Suka Menang
16.03.06.2013|Karang Endah
16.03.06.2014|Jambu
16.03.06.2015|Midar
16.03.06.2016|Mililian
16.03.06.2017|Pedataran
16.03.06.2018|Teluk Limau
16.03.06.2019|Kerta Mulya
16.03.06.2020|Sebau
16.03.06.2021|Sigam
16.03.06.2022|Payabakal
16.03.06.2023|Bitis
16.03.06.2024|Gumai
16.03.06.2025|Putak
16.03.06.2026|Talang Taling
16.03.06.2030|Suka Jaya
16.03.06.2031|Karang Endah Selatan
16.03.06.2032|Betung
16.03.07.1001|Tanjung Enim
16.03.07.1002|Pasar Tanjung Enim
16.03.07.1003|Tanjung Enim Selatan
16.03.07.2004|Tegal Rejo
16.03.07.2005|Lingga
16.03.07.2006|Keban Agung
16.03.07.2007|Darmo
16.03.08.2001|Penindaian
16.03.08.2002|Babatan
16.03.08.2003|Muara Dua
16.03.08.2004|Muara Danau
16.03.08.2005|Penyandingan
16.03.08.2006|Tanah Abang
16.03.08.2007|Pagar Agung
16.03.08.2008|Pulau Panggung
16.03.08.2009|Karya Nyata
16.03.08.2010|Perapau
16.03.09.2001|Tenam Bungkuk
16.03.09.2002|Kota Padang
16.03.09.2003|Gunung Agung
16.03.09.2004|Sri Tanjung
16.03.09.2005|Tebing Abang
16.03.09.2006|Batu Surau
16.03.09.2007|Tanjung Raya
16.03.09.2008|Muara Tenang
16.03.09.2009|Rekimai Jaya
16.03.09.2010|Palak Tanah
16.03.09.2011|Kota Agung
16.03.09.2012|Swarna Dwipa
16.03.10.2001|Tanjung Tiga
16.03.10.2002|Cahaya Alam
16.03.10.2003|Datar Lebar
16.03.10.2004|Segamit
16.03.10.2005|Siring Agung
16.03.10.2006|Aremantai
16.03.10.2007|Tanjung Agung
16.03.10.2008|Pajar Bulan
16.03.10.2009|Pelakat
16.03.10.2010|Danau Gerak
16.03.11.2001|Pinang Belarik
16.03.11.2002|Ujan Mas Lama
16.03.11.2003|Ujan Mas Baru
16.03.11.2004|Tanjung Raman
16.03.11.2005|Muara Gula Baru
16.03.11.2006|Muara Gula Lama
16.03.11.2007|Guci
16.03.11.2008|Ulak Bandung
16.03.11.2009|Ujan Mas Ulu
16.03.14.2005|Aur
16.03.14.2006|Beringin
16.03.14.2007|Kota Baru
16.03.14.2008|Pagar Gunung
16.03.14.2009|Gunung Raja
16.03.14.2010|Tanjung Kemala
16.03.14.2011|Suka Merindu
16.03.14.2014|Jiwa Baru
16.03.14.2020|Air Asam
16.03.14.2021|Menanti
16.03.15.2001|Baru Rambang
16.03.15.2002|Sugihan
16.03.15.2003|Tanjung Raya
16.03.15.2004|Tanjung Dalam
16.03.15.2005|Sukarami
16.03.15.2006|Pagar Agung
16.03.15.2007|Sugih Waras
16.03.15.2008|Sumber Rahayu
16.03.15.2009|Marga Mulya
16.03.15.2010|Kencana Mulia
16.03.15.2011|Negeri Agung
16.03.15.2012|Sugihwaras Barat
16.03.15.2013|Air Keruh
16.03.16.2001|Tanjung Miring
16.03.16.2002|Danau Tampang
16.03.16.2003|Kasai
16.03.16.2004|Sungai Rotan
16.03.16.2005|Sukamerindu
16.03.16.2006|Tanding Marga
16.03.16.2007|Muara Lematang
16.03.16.2008|Sukadana
16.03.16.2009|Modong
16.03.16.2010|Sukacinta
16.03.16.2011|Penandingan
16.03.16.2012|Danau Rata
16.03.16.2013|Paya Angus
16.03.16.2014|Sukarami
16.03.16.2015|Petar Dalam
16.03.16.2016|Sukajadi
16.03.16.2017|Sukamaju
16.03.16.2018|Danau Baru
16.03.16.2019|Petar Luar
16.03.17.2007|Petanang
16.03.17.2008|Talang Nangka
16.03.17.2009|Alai
16.03.17.2010|Sungai Duren
16.03.17.2011|Tapus
16.03.17.2012|Lembak
16.03.17.2013|Kemang
16.03.17.2014|Lubuk Enau
16.03.17.2015|Alai Selatan
16.03.17.2019|Tanjung Baru
16.03.19.2001|Padang Bindu
16.03.19.2002|Betung
16.03.19.2003|Pagar Dewa
16.03.19.2004|Pagarjati
16.03.19.2005|Hidup Baru
16.03.19.2006|Rami Pasai
16.03.21.2001|Embacang Kelekar
16.03.21.2002|Menanti
16.03.21.2003|Menanti Selatan
16.03.21.2004|Suban Baru
16.03.21.2005|Pelempang
16.03.21.2006|Teluk Jaya
16.03.21.2007|Tanjung Medang
16.03.22.2001|Gedung Buruk
16.03.22.2002|Arisan Musi
16.03.22.2003|Harapan Mulia
16.03.22.2004|Mulia Abadi
16.03.22.2005|Arisan Musi Timur
16.03.22.2006|Patra Tani
16.03.22.2007|Tanjung Baru
16.03.22.2008|Kayu Ara Batu
16.03.23.2001|Tanjung
16.03.23.2002|Simpang Tanjung
16.03.23.2003|Cinta Kasih
16.03.23.2004|Teluk Lubuk
16.03.23.2005|Berugo
16.03.23.2006|Belimbing
16.03.23.2007|Bulang
16.03.23.2008|Belimbing Jaya
16.03.23.2009|Darmo Kasih
16.03.23.2010|Dalam
16.03.24.2001|Tanjung Bunut
16.03.24.2002|Babat
16.03.24.2003|Lubuk Semantung
16.03.24.2004|Lubuk Getam
16.03.24.2005|Talang Balai
16.03.24.2006|Talang Beliung
16.03.24.2007|Sialingan
16.03.24.2008|Tanjung Tiga
16.03.24.2009|Ibul
16.03.24.2010|Gaung Asam
16.03.25.2001|Karang Agung
16.03.25.2002|Karang Sari
16.03.25.2003|Karang Mulya
16.03.25.2004|Sumber Mulya
16.03.25.2005|Sumber Asri
16.03.25.2006|Pagar Dewa
16.03.25.2007|Prabumenang
16.03.25.2008|Lecah
16.03.25.2009|Mekar Jaya
16.03.25.2010|Lubai Persada
16.03.25.2011|Lubai Makmur
16.03.26.2001|Muara Niru
16.03.26.2002|Kahuripan Baru
16.03.26.2003|Pangkalan Babat
16.03.26.2004|Gunung Raja
16.03.26.2005|Banuayu
16.03.26.2006|Kuripan
16.03.26.2007|Kuripan Selatan
16.03.26.2008|Batu Raja
16.03.26.2009|Dangku
16.03.26.2010|Siku
16.03.27.2001|Lebak Budi
16.03.27.2002|Lambur
16.03.27.2003|Pagar Jati
16.03.27.2004|Tanjung Baru
16.03.27.2005|Sukaraja
16.03.27.2006|Pandan Dulang
16.03.27.2007|Muara Meo
16.03.27.2008|Sugih Waras
16.03.27.2009|Indramayu
16.03.27.2010|Bedegung
16.03.27.2011|Padang Bindu
16.03.27.2012|Lubuk Nipis
16.04.01.2001|Kembang Ayun
16.04.01.2002|Gunung Meraksa
16.04.01.2003|Tanjung Alam
16.04.01.2004|Batu Rancing
16.04.01.2005|Suban
16.04.01.2006|Genting
16.04.01.2007|Gunung Ayu
16.04.01.2008|Ujung Pulau
16.04.01.2009|Muara Cawang
16.04.01.2010|Kepala Siring
16.04.01.2011|Simpang III Pumu
16.04.01.2012|Gunung Raya
16.04.01.2013|Talang Tinggi
16.04.01.2014|Karang Agung
16.04.06.2008|Sadan
16.04.06.2009|Penantian
16.04.06.2010|Bandar Aji
16.04.06.2011|Tertap
16.04.06.2012|Serambi
16.04.06.2013|Muara Tawi
16.04.06.2014|Kedaton
16.04.06.2015|Pelajaran
16.04.06.2016|Nanti Giri
16.04.06.2017|Pama Salak
16.04.06.2018|Jemaring
16.04.06.2019|Aromantai
16.04.06.2020|Jarai
16.04.06.2021|Tanjung Menang
16.04.06.2022|Mangun Sari
16.04.06.2023|Pagar Dewa
16.04.06.2024|Sukananti
16.04.06.2025|Lubuk Saung
16.04.06.2026|Karang Tanding
16.04.06.2027|Gunung Raya
16.04.06.2028|Gunung Megang
16.04.07.2001|Bangke
16.04.07.2002|Tebat Langsat
16.04.07.2003|Singapure
16.04.07.2004|Gunung Liwat
16.04.07.2005|Kebun Jati
16.04.07.2006|Bintuhan
16.04.07.2007|Mutar Alam Baru
16.04.07.2008|Pandan Arang Ulu
16.04.07.2009|Mutar Alam Lama
16.04.07.2010|Tanjung Raman
16.04.07.2011|Tunggul Bute
16.04.07.2012|Karang Endah
16.04.07.2013|Karang Agung
16.04.07.2014|Suka Raja
16.04.07.2015|Gedung Agung
16.04.07.2016|Kota Agung
16.04.07.2017|Lawang Agung
16.04.07.2018|Sukarami
16.04.07.2019|Tanjung Beringin
16.04.07.2020|Pagaruyung
16.04.07.2031|Muara Gula
16.04.07.2032|Tanjung Bulan
16.04.08.2008|Tanjung Mulak
16.04.08.2009|Pulau Pinang
16.04.08.2010|Tanjung Sirih
16.04.08.2011|Lubuk Sepang
16.04.08.2012|Karang Dalam
16.04.08.2013|Kuba
16.04.08.2014|Jati
16.04.08.2016|Pagar Batu
16.04.08.2017|Muara Siban
16.04.08.2018|Perigi
16.04.09.2010|Suka Cinta
16.04.09.2011|Gunung Agung
16.04.09.2012|Tanjung Pinang
16.04.09.2013|Suka Marga
16.04.09.2014|Payo
16.04.09.2015|Karang Endah
16.04.09.2016|Tanjung Telang
16.04.09.2017|Lubuk Kepayang
16.04.09.2018|Muara Temiang
16.04.09.2019|Ulak Pandan
16.04.09.2020|Negeri Agung
16.04.09.2021|Lebak Budi
16.04.09.2022|Tanjung Baru
16.04.09.2023|Kebur
16.04.09.2024|Telatang
16.04.09.2025|Muara Maung
16.04.09.2026|Merapi
16.04.09.2040|Purwosari
16.04.09.2041|Karang Rejo
16.04.10.1031|Lahat Tengah
16.04.10.1032|Gunung Gajah
16.04.10.1033|Pagar Agung
16.04.10.1037|Talang Jawa
16.04.10.1038|Pasar Baru
16.04.10.1040|Kota Baru
16.04.10.1041|Pasar Lama
16.04.10.1042|Pasar Bawah
16.04.10.1043|RD. PJKA
16.04.10.1046|Bandar Agung
16.04.10.1051|Kota Negara
16.04.10.1052|Kota Jaya
16.04.10.1054|RD. PJKA Bandar Agung
16.04.10.1058|Sari Bunga Mas
16.04.10.1059|Bandar Jaya
16.04.10.1060|Talang Jawa Selatan
16.04.10.1061|Talang Jawa Utara
16.04.10.2012|Padang Lengkuas
16.04.10.2027|Selawi
16.04.10.2030|Sukanegara
16.04.10.2034|Kota Raya
16.04.10.2035|Keban
16.04.10.2036|Pagar Sari
16.04.10.2039|Pagar Negara
16.04.10.2049|Senabing
16.04.10.2050|Manggul
16.04.10.2053|Ulak Lebar
16.04.10.2055|Giri Mulya
16.04.10.2056|Makarti Tama
16.04.10.2057|Ulak Mas
16.04.12.2001|Talang Baru
16.04.12.2002|Talang Pagar Agung
16.04.12.2003|Bantunan
16.04.12.2004|Suka Bumi
16.04.12.2005|Pulau Panggung
16.04.12.2006|Pajar Bulan
16.04.12.2007|Kota Raya Lembak
16.04.12.2008|Sumur
16.04.12.2009|Gelung Sakti
16.04.12.2010|Pulau
16.04.12.2011|Ulak Bandung
16.04.12.2012|Talang Padang Tinggi
16.04.12.2019|Aceh
16.04.12.2020|Pajar Tinggi
16.04.12.2025|Kota Raya Darat
16.04.12.2026|Jenti'an
16.04.12.2027|Tongkok
16.04.12.2028|Benua Raja
16.04.12.2029|Talang Mengkenang
16.04.12.2030|Talang Tangsi
16.04.15.2007|Pajar Bulan
16.04.15.2008|Sukananti
16.04.15.2009|Karang Lebak
16.04.15.2011|Babatan
16.04.15.2014|Muara Tiga
16.04.15.2015|Sengkuang
16.04.15.2016|Penindayan
16.04.15.2017|Datar Balam
16.04.15.2018|Tebing Tinggi
16.04.15.2019|Geramat
16.04.15.2020|Pengentaan
16.04.15.2021|Lesung Batu
16.04.15.2022|Air Puar
16.04.15.2024|Mengkenang
16.04.15.2029|Lawang Agung Mulak
16.04.15.2030|Padang Masat
16.04.16.2001|Pandan Arang
16.04.16.2002|Tanjung Kurung
16.04.16.2003|Nanjungan
16.04.16.2004|Pagardin
16.04.16.2005|Pulau Beringin
16.04.16.2006|Beriningin Jaya
16.04.16.2007|Banu Ayu
16.04.16.2008|Tanjung Alam
16.04.16.2009|Sirah Pulau
16.04.16.2010|Tanjung Beringin
16.04.16.2011|Pagar Jati
16.04.16.2012|Karang Cahaya
16.04.16.2013|Jaga Baya
16.04.16.2014|Keban Agung
16.04.16.2015|Padang Bindu
16.04.16.2016|Beringin Janggut
16.04.16.2017|Keban Raya
16.04.16.2018|Lubuk Tungkang
16.04.17.2001|Bunga Mas
16.04.17.2002|Gunung Kembang
16.04.17.2003|Tanjung Bindu
16.04.17.2004|Lubuk Tapang
16.04.17.2005|Lubuk Nambulan
16.04.17.2006|Gelumbang
16.04.17.2007|Gunung Aji
16.04.17.2008|Gunung Karto
16.04.17.2009|Karang Endah
16.04.17.2010|Padu Raksa
16.04.17.2011|Seronggo
16.04.17.2012|Datar Serdang
16.04.17.2013|Batu Urip
16.04.17.2014|Cecar
16.04.17.2015|Patikal Lama
16.04.17.2016|Muara Empayang
16.04.17.2017|Lubuk Kute
16.04.17.2018|Patikal Baru
16.04.17.2019|Gedung Agung
16.04.17.2020|Babat Lama
16.04.17.2021|Tanda Raja
16.04.17.2022|Muara Danau
16.04.17.2023|Sendawar
16.04.17.2024|Lubuk Layang Ilir
16.04.17.2025|Binjai
16.04.17.2026|Lubuk Layang Ulu
16.04.17.2027|Cempaka Sakti
16.04.17.2028|Suka Harjo
16.04.17.2029|Marga Mulya
16.04.17.2030|Kencana Sari
16.04.17.2031|Linggar Jaya
16.04.17.2032|Purwaraja
16.04.18.2001|Sungai Laru
16.04.18.2002|Muara Lingsing
16.04.18.2003|Tanjung Baru
16.04.18.2004|Kepala Siring
16.04.18.2005|Maspura
16.04.18.2006|Suka Raja
16.04.18.2007|Tanjung Aur
16.04.18.2008|Purbamas
16.04.18.2009|Banyu Mas
16.04.19.2001|Saung Naga
16.04.19.2002|Penantian
16.04.19.2003|Suka Merindu
16.04.19.2004|Jajaran Baru
16.04.19.2005|Wonorejo
16.04.19.2006|Babatan Baru
16.04.19.2007|Jajaran Lama
16.04.19.2008|Lubuk Seketi
16.04.19.2009|Sukarami
16.04.19.2010|Singapura
16.04.19.2011|Ulak Bandung
16.04.19.2012|Bandar Jaya
16.04.19.2013|Purnama Sari
16.04.19.2014|Wanaraya
16.04.19.2015|Purworejo
16.04.19.2016|Suka Bakti
16.04.19.2017|Mekar Jaya
16.04.19.2018|Darma Raharja
16.04.19.2019|Sido Makmur
16.04.20.2001|Sukajadi
16.04.20.2002|Tanjung Agung
16.04.20.2003|Penandingan
16.04.20.2004|Talang Tinggi
16.04.20.2005|Batu Niding
16.04.20.2006|Tanjung Raya
16.04.20.2007|Lubuk Mabar
16.04.20.2008|Pagar Agung
16.04.20.2009|Lubuk Tuba
16.04.20.2010|Lubuk Atung
16.04.20.2011|Muara Cawang
16.04.21.2001|Sugi Waras
16.04.21.2002|Tanjung Periuk
16.04.21.2003|Tanjung Karangan
16.04.21.2004|Muara Tandi
16.04.21.2005|Darmo
16.04.21.2006|Indikat Ilir
16.04.21.2007|Tanjung Baru
16.04.21.2008|Mandi Angin
16.04.21.2009|Ngalam Baru
16.04.21.2010|Sukarami
16.04.21.2011|Tanjung Dalam
16.04.21.2012|Tanah Pilih
16.04.21.2013|Tanjung Beringin
16.04.21.2014|Batay
16.04.21.2015|Suka Makmur
16.04.22.2001|Kedaton
16.04.22.2002|Tanjung Agung
16.04.22.2003|Karang Agung
16.04.22.2004|Bandung Agung
16.04.22.2005|Lesung Batu
16.04.22.2006|Air Lingkar
16.04.22.2007|Batu Rusa
16.04.22.2008|Kupang
16.04.22.2009|Sawah Darat
16.04.22.2010|Danau
16.04.22.2011|Siring Agung
16.04.22.2012|Pagar Alam
16.04.22.2013|Rimba Sujud
16.04.22.2014|Germidar Ilir
16.04.22.2015|Pagar Gunung
16.04.22.2016|Germidar Ulu
16.04.22.2017|Padang Pagun
16.04.22.2018|Muara Dua
16.04.22.2019|Penantian
16.04.22.2020|Merindu
16.04.23.1014|Lebuay Bandung
16.04.23.2001|Sirah Pulau
16.04.23.2002|Gunung Kembang
16.04.23.2003|Prabu Menang
16.04.23.2004|Banjar Sari
16.04.23.2005|Arahan
16.04.23.2006|Nanjungan
16.04.23.2007|Sengkuang
16.04.23.2008|Tanjung Lontar
16.04.23.2009|Gedung Agung
16.04.23.2010|Muara Lawai
16.04.23.2011|Tanjung Jambu
16.04.23.2012|Cempaka Wangi
16.04.23.2013|Lematang Jaya
16.04.24.2001|Pulau Panas
16.04.24.2002|Sindang Panjang
16.04.24.2003|Gunung Kembang
16.04.24.2004|Pagar Agung
16.04.24.2005|Benteng
16.04.24.2006|Ulak Lebar
16.04.24.2007|Gunung Agung
16.04.24.2008|Masam Bulau
16.04.24.2009|Pajar Bulan
16.04.24.2010|Tanjung Bulan
16.04.24.2011|Penandingan
16.04.24.2012|Tanjung Sakti
16.04.24.2013|Negeri Kaya
16.04.24.2014|Pulau Panggung
16.04.24.2015|Gunung Kerto
16.04.24.2016|Lubuk Tabun
16.04.24.2017|Pagar Jati
16.04.24.2018|Lubuk Dalam
16.04.25.2001|Tinggi Hari
16.04.25.2002|Tanjung Raja
16.04.25.2003|Sinjar Bulan
16.04.25.2004|Padang Gumay
16.04.25.2005|Tanjung Aur
16.04.25.2006|Simpur
16.04.25.2007|Lubuk Selo
16.04.25.2008|Rindu Hati
16.04.25.2009|Sumber Karya
16.04.25.2010|Trans SP II Padang Muara Dua
16.04.26.2001|Padang
16.04.26.2002|Tanjung Menang
16.04.26.2003|Lubuk Pedaro
16.04.26.2004|Suka Merindu
16.04.26.2005|Tanjung Beringin
16.04.26.2006|Talang Akar
16.04.26.2007|Lubuk Betung
16.04.26.2008|Perangai
16.04.26.2009|Geramat
16.04.27.2001|Pandan Arang Ilir
16.04.27.2002|Tanjung Kurung Ulu
16.04.27.2003|Tanjung Kurung Ilir
16.04.27.2004|Tanjung Baru
16.04.27.2005|Tanjung Nibung
16.04.27.2006|TanjungTebat
16.04.27.2007|Tanjung Bai
16.04.27.2008|Tanjung Menang
16.04.27.2009|Tanjung Raya
16.04.27.2010|Air Dingin Lama
16.04.27.2011|Air Dingin Baru
16.04.27.2012|Muara Danau
16.04.27.2013|Talang Jawa
16.04.27.2014|Padang Perigi
16.04.28.2001|Muara Payang
16.04.28.2002|Muara Gelumpai
16.04.28.2003|Talang Tinggi
16.04.28.2004|Lawang Agung Lama
16.04.28.2005|Lawang Agung Baru
16.04.28.2006|Muara Jauh
16.04.28.2007|Bandu Agung
16.04.29.2001|Sukamerindu
16.04.29.2002|Guru Agung
16.04.29.2003|Karang Caya
16.04.29.2004|Gunung liwat
16.04.29.2005|Kapitan
16.04.29.2006|Rambai Kaca
16.04.29.2007|Pagar Kaya
16.04.29.2008|Tanjung Raya
16.04.29.2009|Sukaraja
16.04.29.2010|Tanjung Agung
16.04.30.2001|Jadian Baru
16.04.30.2002|Jadian Lama
16.04.30.2003|Talang Berangin
16.04.30.2004|Padang Bindu
16.04.30.2005|Keban Agung
16.04.30.2006|Danau Belidang
16.04.30.2007|Talang Padang
16.04.30.2008|Lubuk Dendan
16.04.30.2009|Penandingan
16.04.30.2010|Durian Dangkal
16.04.31.2001|Banjar Negara
16.04.31.2002|Tanjung Payang
16.04.31.2003|Tanjung Tebat
16.04.31.2004|Nantal
16.04.31.2005|Karang Anyar
16.04.31.2006|Karang Baru
16.04.31.2007|Kerung
16.04.31.2008|Muara Cawang
16.04.31.2009|Talang Sawah
16.04.31.2010|Talang Sejemput
16.05.01.1001|B. Srikaton
16.05.01.2002|Surodadi
16.05.01.2003|Tegal Rejo
16.05.01.2004|Trikoyo
16.05.01.2005|Kalibening
16.05.01.2006|Widodo
16.05.01.2007|Wonokerto
16.05.01.2008|Nawangsasi
16.05.01.2009|Sukomulyo
16.05.01.2010|Wukirsari
16.05.01.2011|Ngadirejo
16.05.01.2012|Dwijaya
16.05.01.2013|Siti Harjo
16.05.01.2014|Mataram
16.05.01.2015|Tambahasri
16.05.01.2016|Wonorejo
16.05.01.2017|Sidoharjo
16.05.01.2018|Triwikaton
16.05.02.1019|Muara Lakitan
16.05.02.2001|Tri Anggun Jaya
16.05.02.2002|Semangus
16.05.02.2003|Anyar
16.05.02.2004|Muara Rengas
16.05.02.2005|Sungai Pinang
16.05.02.2006|Semeteh
16.05.02.2007|Prabumulih II
16.05.02.2008|Prabumulih I
16.05.02.2009|Lubuk Pandan
16.05.02.2010|Pelita Jaya
16.05.02.2011|Sidomulyo
16.05.02.2012|Marga Baru
16.05.02.2013|Pendingan
16.05.02.2014|Bumi Makmur
16.05.02.2015|Mukti Karya
16.05.02.2016|Harapan Makmur
16.05.02.2017|Pian Raya
16.05.02.2018|Sindang Laya
16.05.02.2020|Semanggus Baru
16.05.03.1013|Muara Kelingi
16.05.03.2001|Binjai
16.05.03.2002|Pulau Panggung
16.05.03.2003|Tanjung Lama
16.05.03.2012|Mandi Aur
16.05.03.2014|Lubuk Tua
16.05.03.2015|Mambang
16.05.03.2016|Bingin Janggut
16.05.03.2017|Tugu Sempurna
16.05.03.2019|Marga Sakti
16.05.03.2021|Karya Sakti
16.05.03.2022|Petrans Jaya
16.05.03.2023|Karya Mukti
16.05.03.2024|Beliti Jaya
16.05.03.2026|Karya Teladan
16.05.03.2027|Temuan Sari
16.05.03.2028|Temuan Jaya
16.05.03.2029|Mekar Sari
16.05.03.2030|Mangan Jaya
16.05.03.2031|Lubuk Muda
16.05.03.2032|Sukamenang
16.05.08.1006|Marga Tunggal
16.05.08.2001|Giri Yoso
16.05.08.2002|Kertosono
16.05.08.2003|Margoyoso
16.05.08.2004|Bumi Rejo
16.05.08.2005|Sidodadi
16.05.08.2007|Marga Tani
16.05.08.2008|Sukowono
16.05.08.2010|Purwodadi
16.05.08.2012|Dono Rejo
16.05.08.2015|Ngesti Boga I
16.05.08.2016|Ngesti Boga II
16.05.08.2020|Ngestikarya
16.05.09.1003|Pasar Muara Beliti
16.05.09.2001|Pedang
16.05.09.2002|Muara Beliti Baru
16.05.09.2004|Mana Resmi
16.05.09.2005|Bumi Agung
16.05.09.2014|Suro
16.05.09.2015|Tanah Periuk
16.05.09.2016|Ketuan Jaya
16.05.09.2017|Air Satan
16.05.09.2018|Durian Remuk
16.05.09.2019|Satan Indah Jaya
16.05.09.2020|Air Lesing
16.05.10.1017|Terawas
16.05.10.2001|Sumber Karya
16.05.10.2002|Suko Rejo
16.05.10.2003|Suka Karya
16.05.10.2011|Sri Mulyo
16.05.10.2014|Sukamerindu
16.05.10.2015|Paduraksa
16.05.10.2016|Babat
16.05.10.2018|Pasenan
16.05.10.2019|Sukaraya
16.05.10.2020|Sukamana
16.05.10.2021|Kosgoro
16.05.10.2022|Sukaraya Baru
16.05.11.1001|Selangit
16.05.11.2002|Lubuk Ngin
16.05.11.2003|Napal Melintang
16.05.11.2004|Taba Tengah
16.05.11.2005|Taba Remanik
16.05.11.2006|Batu Gane
16.05.11.2007|Karang Panggung
16.05.11.2008|Muara Nilau
16.05.11.2009|Perabumenang
16.05.11.2010|Taba Rena
16.05.11.2011|Taba Gindo
16.05.11.2012|Lubuk Ngin Baru
16.05.12.1001|Megang Sakti I
16.05.12.1021|Talang Ubi
16.05.12.2002|Muara Megang
16.05.12.2003|Megang Sakti II
16.05.12.2004|Megang Sakti III
16.05.12.2005|Megang Sakti IV
16.05.12.2006|Jajaran Baru
16.05.12.2007|Sumber Rejo
16.05.12.2008|Rejo Sari
16.05.12.2009|Mekar Sari
16.05.12.2010|Campur Sari
16.05.12.2011|Tegal Sari
16.05.12.2012|Marga Puspita
16.05.12.2013|Megang Sakti V
16.05.12.2014|Pagar Ayu
16.05.12.2015|Karya Mulia
16.05.12.2016|Wonosari
16.05.12.2017|Trisakti
16.05.12.2018|Jajaran Baru II
16.05.12.2019|Muara Megang I
16.05.12.2020|Mulyo Sari
16.05.13.1005|Purwodadi
16.05.13.1007|Mangun Harjo
16.05.13.2001|Bangun Sari
16.05.13.2002|Kerto Sari
16.05.13.2003|Pagar Sari
16.05.13.2004|Mardi Harjo
16.05.13.2006|Karya Dadi
16.05.13.2008|Rejo Sari
16.05.13.2009|Sadar Karya
16.05.13.2010|Purwakarya
16.05.13.2011|Tri Karya
16.05.14.1017|Bangun Jaya
16.05.14.2001|Kembang Tanjung
16.05.14.2002|Gn. Kembang Baru
16.05.14.2003|Gn. Kembang Lama
16.05.14.2004|Sungai Bunut
16.05.14.2005|Sungai Naik
16.05.14.2006|Pangkalan T. Lama
16.05.14.2007|Sadu
16.05.14.2008|Tambangan
16.05.14.2009|Pelawe
16.05.14.2010|Lubuk Pauh
16.05.14.2011|Tri Jaya
16.05.14.2012|Mulyo Harjo
16.05.14.2013|Suka Makmur
16.05.14.2014|Raksa Budi
16.05.14.2015|Kota Baru
16.05.14.2016|Trimukti
16.05.14.2018|Mekar Jaya
16.05.14.2019|Sembatu Jaya
16.05.18.2001|Lubuk Besar
16.05.18.2002|Batu Bandung
16.05.18.2003|Rantau Bingin
16.05.18.2004|Rantau Serik
16.05.18.2005|Muara Kati Lama
16.05.18.2006|Muara Kati Baru I
16.05.18.2007|Muara Kati Baru II
16.05.18.2008|Kebur
16.05.18.2009|Simpang Gegas Temuan
16.05.18.2010|Kebur Jaya
16.05.19.1002|Sumber Harta
16.05.19.2001|Sumber Jaya
16.05.19.2003|Sukamaju
16.05.19.2004|Jamburejo
16.05.19.2005|Sumber Sari
16.05.19.2006|Suka Mulya
16.05.19.2007|Sukajaya
16.05.19.2008|Madang
16.05.19.2009|Sukarami Jaya
16.05.19.2010|Sumber Asri
16.05.20.2001|Banpres
16.05.20.2002|Jaya Tunggal
16.05.20.2003|Sukamulya
16.05.20.2004|Darma Sakti
16.05.20.2005|Jaya Bhakti
16.05.20.2006|Remayu
16.05.20.2007|Petunang
16.05.20.2008|Lubuk Rumbai
16.05.20.2009|Air Beliti
16.05.20.2010|Leban Jaya
16.05.20.2011|Bamasco
16.05.21.2001|Sukowarno
16.05.21.2002|Sugih Waras
16.05.21.2003|Bangun Rejo
16.05.21.2004|Ciptodadi
16.05.21.2005|Sukarena
16.05.21.2006|Yudha Karya Bakti
16.05.21.2007|Rantau Alih
16.05.21.2008|Ciptodadi II
16.06.01.1009|Kayu Ara
16.06.01.1010|Serasan Jaya
16.06.01.1011|Soak baru
16.06.01.1012|Balai Agung
16.06.01.2001|Sukarami
16.06.01.2002|Lumpatan
16.06.01.2003|Bailangu
16.06.01.2004|Muara Teladan
16.06.01.2005|Bandar Jaya
16.06.01.2006|Sungai Medak
16.06.01.2007|Sungai Batang
16.06.01.2008|Rimba Ukur
16.06.01.2013|Lumpatan 2
16.06.01.2014|Baliangu Timur
16.06.02.2001|Danau Cala
16.06.02.2002|Rantau Keroya
16.06.02.2003|Tanjung Agung Timur
16.06.02.2004|Petaling
16.06.02.2005|Lais
16.06.02.2006|Teluk
16.06.02.2007|Epil
16.06.02.2008|Purwosari
16.06.02.2009|Teluk Kijing I
16.06.02.2010|Teluk Kijing II
16.06.02.2011|Teluk Kijing III
16.06.02.2012|Tanjung Agung Utara
16.06.02.2013|Tanjung Agung Barat
16.06.02.2014|Tanjung Agung Selatan
16.06.02.2015|Lais Utara
16.06.02.2016|Epil Barat
16.06.03.2002|Pagar Kaya
16.06.03.2003|Sukalali
16.06.03.2004|Kartayu
16.06.03.2006|Sungai Dua
16.06.03.2007|Sindang Marga
16.06.03.2008|Tebing Bulang
16.06.03.2009|Gajah Mati
16.06.03.2010|Rantau Sialang
16.06.03.2014|Kerta Jaya
16.06.03.2015|Keramat Jaya
16.06.04.2001|Bukit Sejahtera
16.06.04.2002|Bukit Pangkuasan
16.06.04.2003|Tanah Abang
16.06.04.2004|Talang Leban
16.06.04.2005|Talang Buluh
16.06.04.2006|Lubuk Buah
16.06.04.2007|Sungai Napal
16.06.04.2008|Lubuk Bintialo
16.06.04.2009|Sako Suban
16.06.04.2010|Bukit Selabu
16.06.04.2011|Saut
16.06.04.2012|Tanjung Bali
16.06.04.2013|Pinggap
16.06.04.2014|Pengaturan
16.06.04.2015|Ulak Kembang
16.06.04.2016|Pangkalan Bulian
16.06.05.1016|Ngulak I
16.06.05.1019|Ngulak
16.06.05.2001|Air Balui
16.06.05.2002|Nganti
16.06.05.2003|Jud I
16.06.05.2004|Jud II
16.06.05.2005|Penggage
16.06.05.2006|Ngunang
16.06.05.2007|Ngulak II
16.06.05.2008|Ngulak III
16.06.05.2009|Ulak Embacang
16.06.05.2010|Terusan
16.06.05.2011|Kemang
16.06.05.2012|Tanjung Raya
16.06.05.2013|Air Itam
16.06.05.2014|Keban I
16.06.05.2015|Keban II
16.06.05.2017|Panai
16.06.05.2018|Macang Sakti
16.06.06.1038|Babat
16.06.06.1039|Mangun Jaya
16.06.06.2001|Sereka
16.06.06.2002|Sugi Raya
16.06.06.2003|Sugi Waras
16.06.06.2004|Beruge
16.06.06.2005|Muara Punjung
16.06.06.2007|Bangun Sari
16.06.06.2008|Toman
16.06.06.2009|Kasmaran
16.06.06.2022|Sungai Angit
16.06.06.2023|Srimulyo
16.06.06.2042|Pangkalan Jaya
16.06.06.2043|Toman Baru
16.06.07.1020|Sungai Lilin
16.06.07.1030|Sungai Lilin Jaya
16.06.07.2007|Sri Gunung
16.06.07.2008|Sumber Rejeki
16.06.07.2009|Linggo Sari
16.06.07.2010|Mulyo Rejo
16.06.07.2011|Suka Damai Baru
16.06.07.2012|Cinta Damai
16.06.07.2013|Berlian Makmur
16.06.07.2014|Bumi Kencana
16.06.07.2015|Mekar Jadi
16.06.07.2016|Nusa Serasan
16.06.07.2017|Pinang Banjar
16.06.07.2019|Panca Tunggal
16.06.07.2021|Bukit Jaya
16.06.08.1015|Keluang
16.06.08.2001|Tenggaro
16.06.08.2003|Tanjung Dalam
16.06.08.2004|Dawas
16.06.08.2005|Mekar Jaya
16.06.08.2006|Sumber Agung
16.06.08.2007|Karya Maju
16.06.08.2008|Tegal Mulyo
16.06.08.2009|Cipta Praja
16.06.08.2010|Loka Jaya
16.06.08.2011|Mekar Sari
16.06.08.2012|Sido Rejo
16.06.08.2013|Mulyo Asih
16.06.08.2014|Sridamai
16.06.09.1016|Bayung Lencir
16.06.09.1065|Bayung Lencir Indah
16.06.09.2006|Muara Merang
16.06.09.2007|Mangsang
16.06.09.2008|Tampang Baru
16.06.09.2009|Kali Berau
16.06.09.2010|Sindang Marga
16.06.09.2011|Telang
16.06.09.2012|Pagar Desa
16.06.09.2013|Mendis
16.06.09.2014|Pulai Gading
16.06.09.2015|Muara Medak
16.06.09.2017|Sukajaya
16.06.09.2026|Senawar Jaya
16.06.09.2048|Simpang Bayat
16.06.09.2049|Bayat Ilir
16.06.09.2050|Pangkalan Bayat
16.06.09.2051|Muara Bahar
16.06.09.2058|Mekar Jaya
16.06.09.2059|Mendis Jaya
16.06.09.2060|Kepayang
16.06.09.2061|Wono Rejo
16.06.09.2063|Lubuk Harjo
16.06.10.2001|Sido Mukti
16.06.10.2002|Suka Damai
16.06.10.2003|Suka Jaya
16.06.10.2004|Suka Makmur
16.06.10.2005|Suka Maju
16.06.10.2006|Bangun Harja
16.06.10.2007|Sido Rahayu
16.06.10.2008|Bukit Indah
16.06.10.2009|Warga Mulya
16.06.10.2010|Tanjung Kaputran
16.06.10.2011|Air Putih Ulu
16.06.10.2012|Sialang Agung
16.06.10.2013|Cinta Karya
16.06.10.2014|Air Putih Ilir
16.06.10.2015|Sumber Rejeki
16.06.11.2001|Karang Agung
16.06.11.2002|Karang Rejo
16.06.11.2003|Karang Makmur
16.06.11.2004|Perumpung Raya
16.06.11.2005|Galih Sari
16.06.11.2006|Karang Tirta
16.06.11.2007|Purwo Agung
16.06.11.2008|Karya Mukti
16.06.11.2009|Sri Karang Rejo
16.06.11.2010|Mekar Sari
16.06.11.2011|Agung Jaya
16.06.11.2012|Bumi Agung
16.06.11.2013|Jaya Agung
16.06.11.2014|Suka Makmur
16.06.11.2015|Mandala Sari
16.06.11.2016|Bandar Agung
16.06.11.2017|Karang Sari
16.06.11.2018|Sri Gading
16.06.11.2019|Mulya Agung
16.06.11.2020|Karang Mukti
16.06.11.2021|Madya Mulya
16.06.11.2022|Mulya Jaya
16.06.11.2023|Sari Agung
16.06.11.2024|Suka Jadi
16.06.11.2025|Ringin Agung
16.06.11.2026|Tri Mulya Agung
16.06.11.2027|Mekar Jaya
16.06.12.2001|Peninggalan
16.06.12.2002|Suka Damai
16.06.12.2003|Berlian Jaya
16.06.12.2004|Simpang Tungkal
16.06.12.2005|Pangkalan Tungkal
16.06.12.2006|Sumber Harum
16.06.12.2007|Sumber Sari
16.06.12.2008|Sinar Harapan
16.06.12.2009|Banjar Jaya
16.06.12.2010|Beji Mulyo
16.06.12.2011|Bero Jaya Timur
16.06.12.2012|Pandan Sari
16.06.12.2013|Margo Mulyo
16.06.12.2014|Sri Mulyo
16.06.12.2015|Sido Mulyo
16.06.12.2016|Sinar Tungkal
16.06.13.2001|Ulak Paceh
16.06.13.2002|Ulak Paceh Jaya
16.06.13.2003|Tanjung Durian
16.06.13.2004|Napal
16.06.13.2005|Rantau Kasih
16.06.13.2006|Karang Ringin I
16.06.13.2007|Karang Ringin II
16.06.13.2008|Ulak Teberau
16.06.13.2009|Bumi Ayu
16.06.13.2010|Karang Waru
16.06.13.2011|Karang Anyar
16.06.13.2012|Rantau Panjang
16.06.13.2013|Simpang Sari
16.06.13.2014|Talang Piase
16.06.13.2015|Pandan Dulang
16.06.14.2001|Suka Maju
16.06.14.2002|Letang
16.06.14.2003|Supat
16.06.14.2004|Babat Banyuasin
16.06.14.2005|Tanjung Kerang
16.06.14.2006|Langkap
16.06.14.2007|Gajah Mati
16.06.14.2008|Tenggulang Jaya
16.06.14.2009|Bandar Tenggulang
16.06.14.2010|Sumber Jaya
16.06.14.2011|Tenggulang Baru
16.06.14.2012|Supat Barat
16.06.14.2013|Supat Timur
16.06.14.2014|Seratus Lapan
16.06.14.2015|Babat Ramba Jaya
16.06.14.2016|Gajah Muda
16.06.15.2001|Jirak
16.06.15.2002|Rukun Rahayu
16.06.15.2003|Talang Simpang
16.06.15.2004|Jembatan Gantung
16.06.15.2005|Talang Mandung
16.06.15.2006|Rejosari
16.06.15.2007|Bangkit Jaya
16.06.15.2008|Baru Jaya
16.06.15.2009|Sinar Jaya
16.06.15.2010|Setia Jaya
16.06.15.2011|Mekar Jaya
16.06.15.2012|Layan
16.07.01.1016|Mariana
16.07.01.1021|Mariana Ilir
16.07.01.2001|Sungai Rebo
16.07.01.2002|Sungai Gerong
16.07.01.2003|Merah Mata
16.07.01.2004|Perajen
16.07.01.2005|Cinta Manis Lama
16.07.01.2008|Perambahan
16.07.01.2011|Pematang Palas
16.07.01.2012|Tirto Sari
16.07.01.2014|Pulau Borang
16.07.01.2025|Perambahan Baru
16.07.01.2028|Duren Ijo
16.07.02.2001|Sungsang I
16.07.02.2002|Sungsang II
16.07.02.2003|Sungsang III
16.07.02.2004|Sungsang IV
16.07.02.2010|Teluk Payo
16.07.02.2013|Tanah Pilih
16.07.02.2015|Perajen Jaya
16.07.02.2016|Rimau Sungsang
16.07.02.2018|Marga Sungsang
16.07.02.2019|Muara Sungsang
16.07.03.1008|Kayuara Kuning
16.07.03.1009|Mulia Agung
16.07.03.1012|Pangkalan Balai
16.07.03.1023|Seterio
16.07.03.1033|Kedondong Raye
16.07.03.2006|Langkan
16.07.03.2007|Pangkalan Panji
16.07.03.2010|Lubuk Saung
16.07.03.2011|Ujung Tanjung
16.07.03.2013|Sidang Mas
16.07.03.2014|Galang Tinggi
16.07.03.2015|Petaling
16.07.03.2016|Rimba Alai
16.07.03.2017|Pelajau Ilir
16.07.03.2018|Regan Agung
16.07.03.2019|Suka Mulia
16.07.03.2020|Tanjung Agung
16.07.03.2021|Tanjung Menang
16.07.03.2022|Sri Bandung
16.07.03.2024|Pelajau
16.07.03.2025|Tanjung Beringin
16.07.03.2026|Terentang
16.07.03.2028|Tanjung Kepayang
16.07.03.2034|Sukaraja Baru
16.07.03.2037|Terlangu
16.07.03.2038|Rimba Balai
16.07.04.2002|Teluk Betung
16.07.04.2004|Mukut
16.07.04.2006|Sumber Rejeki
16.07.04.2007|Dana Mulya
16.07.04.2008|Wana Mukti
16.07.04.2009|Budi Asih
16.07.04.2013|Rukun Makmur
16.07.04.2014|Nunggal Sari
16.07.04.2017|Majatra
16.07.04.2018|Wonosari
16.07.04.2031|Sumber Mulya
16.07.04.2032|Rawa Banda
16.07.04.2037|Senda Mukti
16.07.04.2038|Tirta Mulya
16.07.04.2039|Banjar Sari
16.07.04.2040|Buana Murti
16.07.04.2041|Tabuan Asri
16.07.05.1017|Betung
16.07.05.1021|Rimba Asam
16.07.05.1022|Betung Selatan
16.07.05.2002|Pulau Rajak
16.07.05.2003|Bukit
16.07.05.2004|Sri Kembang
16.07.05.2005|Lubuk Karet
16.07.05.2014|Taja Mulya
16.07.05.2015|Taja Raya I
16.07.05.2016|Taja Indah
16.07.05.2018|Taja Raya II
16.07.05.2020|Suka Mulya
16.07.06.1021|Jakabaring Selatan
16.07.06.2001|Kebon Sahang
16.07.06.2002|Siju
16.07.06.2003|Tanah Lembak
16.07.06.2004|Parit
16.07.06.2005|Pelaju
16.07.06.2006|Suka Pindah
16.07.06.2007|Baru
16.07.06.2008|Tanjung Kerang
16.07.06.2009|Rambutan
16.07.06.2010|Tanjung Merbu
16.07.06.2011|Sako
16.07.06.2012|Gelebak Dalam
16.07.06.2013|Menten
16.07.06.2014|Pangkalan Gelebak
16.07.06.2015|Sungai Dua
16.07.06.2016|Sungai Pinang
16.07.06.2017|Sungai Kedukan
16.07.06.2019|Durian Gadis
16.07.06.2020|Pulau Parang
16.07.07.2001|Muara Padang
16.07.07.2002|Tanjung Baru
16.07.07.2003|Karang Anyar
16.07.07.2006|Purwodadi
16.07.07.2007|Sumber Makmur
16.07.07.2008|Air Gading
16.07.07.2009|Tirto Raharjo
16.07.07.2010|Daya Utama
16.07.07.2011|Daya Makmur
16.07.07.2012|Sido Mulyo 18
16.07.07.2013|Sido Rejo
16.07.07.2018|Sido Mulyo 20
16.07.07.2037|Margo Mulyo 20
16.07.07.2038|Margo Sugihan
16.07.07.2042|Tirta Jaya
16.07.08.2007|Marga Rahayu
16.07.08.2008|Sumber Mulya
16.07.08.2009|Sumber Hidup
16.07.08.2010|Telang Rejo
16.07.08.2011|Telang Jaya
16.07.08.2013|Telang Makmur
16.07.08.2014|Telang Karya
16.07.08.2015|Panca Mukti
16.07.08.2016|Mukti Jaya
16.07.08.2019|Mekar Sari
16.07.08.2024|Talang Indah
16.07.08.2025|Mekar Mukti
16.07.08.2026|Upang Jaya
16.07.08.2027|Upang Karya
16.07.08.2028|Upang Cemara
16.07.08.2029|Upang Ceria
16.07.09.1012|Makarti Jaya
16.07.09.2002|Delta Upang
16.07.09.2006|Pendowo Harjo
16.07.09.2007|Pangestu
16.07.09.2008|Tirta Kencana
16.07.09.2010|Upang Makmur
16.07.09.2013|Upang Mulya
16.07.09.2017|Purwosari
16.07.09.2019|Tanjung Mas
16.07.09.2020|Tanjung Baru
16.07.09.2021|Sungai Semut
16.07.09.2022|Muara Baru
16.07.10.1002|Air Batu
16.07.10.1003|Sukomoro
16.07.10.1004|Sukajadi
16.07.10.1006|Kenten
16.07.10.1022|Tanah Mas
16.07.10.1023|Talang Keramat
16.07.10.1024|Sukajadi Timur
16.07.10.1025|Tanah Mas Indah
16.07.10.1026|Rawa Maju
16.07.10.1027|Air Batu Jaya
16.07.10.1028|Sei Sedapat
16.07.10.1029|Azhar Permai
16.07.10.1030|Keramat Raya
16.07.10.2001|Sungai Rengit
16.07.10.2005|Pangkalan Benteng
16.07.10.2007|Gasing
16.07.10.2019|Talang Buluh
16.07.10.2020|Sungai Rengit Murni
16.07.10.2021|Kenten Laut
16.07.11.2001|Muara Abab
16.07.11.2002|Tanjung Pasir
16.07.11.2003|Tanjung Tiga
16.07.11.2004|Rantau Bayur
16.07.11.2005|Pagar Bulan
16.07.11.2006|Kemang Bejalu
16.07.11.2007|Tanjung Menang
16.07.11.2008|Srijaya
16.07.11.2009|Sejagung
16.07.11.2010|Sungai Pinang
16.07.11.2011|Semuntul
16.07.11.2012|Lebung
16.07.11.2013|Lubuk Rengas
16.07.11.2014|Paldas
16.07.11.2015|Tebing Abang
16.07.11.2016|Talang Kemang
16.07.11.2017|Rantau Harapan
16.07.11.2018|Penandingan
16.07.11.2019|Sungai Naik
16.07.11.2020|Sungai Lilin
16.07.11.2021|Sukarela
16.07.12.2001|Telang Sari
16.07.12.2002|Mulya Sari
16.07.12.2003|Purwosari
16.07.12.2004|Sri Menanti
16.07.12.2005|Sebalik
16.07.12.2006|Tanjung Lago
16.07.12.2007|Kuala Puntian
16.07.12.2008|Sukatani
16.07.12.2009|Sukadamai
16.07.12.2010|Banyu Urip
16.07.12.2011|Bangun Sari
16.07.12.2012|Sumber Mekar Mukti
16.07.12.2013|Muara Sugih
16.07.12.2014|Manggar Raya
16.07.12.2015|Bunga Karang
16.07.13.2001|Margo Mulyo 16
16.07.13.2002|Rejo Sari
16.07.13.2003|Daya Murni
16.07.13.2004|Daya Bangun Harjo
16.07.13.2005|Sumber Mulyo
16.07.13.2006|Sugih Waras
16.07.13.2007|Indrapura
16.07.13.2008|Cendana
16.07.13.2009|Argo Mulyo
16.07.13.2010|Tirta Harja
16.07.13.2011|Tirta Mulya
16.07.13.2012|Daya Kesuma
16.07.13.2013|Margo Rukun
16.07.13.2014|Ganesha Mukti
16.07.13.2015|Timbul Jaya
16.07.13.2016|Jalur Mulya
16.07.13.2017|Gilirang
16.07.13.2018|Juru Taro
16.07.13.2019|Kuala Sugihan
16.07.13.2020|Beringin Agung
16.07.13.2021|Mekar Jaya
16.07.13.2022|Sido Makmur
16.07.14.2001|Air Solok Batu
16.07.14.2002|Sri Mulyo
16.07.14.2003|Srikaton
16.07.14.2004|Sidoharjo
16.07.14.2005|Bintaran
16.07.14.2006|Damar Wulan
16.07.14.2007|Enggal Rejo
16.07.14.2008|Saleh Jaya
16.07.14.2009|Saleh Agung
16.07.14.2010|Saleh Mulya
16.07.14.2011|Saleh Mukti
16.07.14.2012|Saleh Makmur
16.07.14.2013|Upang
16.07.14.2014|Upang Marga
16.07.15.2001|Bentayan
16.07.15.2002|Teluk Tenggulang
16.07.15.2004|Suka Mulya
16.07.15.2005|Suka Raja
16.07.15.2006|Karang Anyar
16.07.15.2007|Karang Asem
16.07.15.2008|Marga Rahayu
16.07.15.2009|Sido Mulyo
16.07.15.2010|Keluang
16.07.15.2011|Bumi Serdang
16.07.15.2012|Karang Mulya
16.07.15.2013|Suka Karya
16.07.15.2014|Panca Mulya
16.07.15.2015|Suka Jaya
16.07.16.2001|Talang Ipuh
16.07.16.2002|Durian Daun
16.07.16.2003|Lubuk Lancang
16.07.16.2004|Biyuku
16.07.16.2005|Bengkuang
16.07.16.2006|Rimba Terap
16.07.16.2007|Sedang
16.07.16.2008|Tanjung Laut
16.07.16.2009|Air Senggeris
16.07.16.2010|Meranti
16.07.16.2011|Sukaraja
16.07.17.2001|Mainan
16.07.17.2002|Santan Sari
16.07.17.2003|Limau
16.07.17.2004|Rejodadi
16.07.17.2005|Lalang Sembawa
16.07.17.2006|Muara Damai
16.07.17.2007|Pulau Harapan
16.07.17.2008|Purwosari
16.07.17.2009|Limbang Mulia
16.07.17.2010|Sako Makmur
16.07.17.2011|Pulau Muning
16.07.18.2001|Terusan Dalam
16.07.18.2002|Karang Anyar
16.07.18.2003|Muara Telang
16.07.18.2004|Terusan Tengah
16.07.18.2005|Sumber Jaya
16.07.18.2006|Karang Baru
16.07.18.2007|Muara Telang Marga
16.07.18.2008|Terusan Muara
16.07.18.2009|Talang Lubuk
16.07.18.2010|Sri Tiga
16.07.19.2001|Cinta Manis Baru
16.07.19.2002|Sido Makmur
16.07.19.2003|Sidomulyo
16.07.19.2004|Nusa Makmur
16.07.19.2005|Rimba Jaya
16.07.19.2006|Teluk Tenggirik
16.07.19.2007|Sebubus
16.07.19.2008|Padang Rejo
16.07.19.2009|Kumbang Padang Permata
16.07.19.2010|Muara Baru
16.07.19.2011|Tirta Makmur
16.07.19.2012|Panca Mulya
16.07.19.2013|Budi Mulya
16.07.19.2014|Panca Desa
16.07.19.2015|Air Kumbang Bakti
16.07.19.2016|Sebokor
16.07.20.2001|Karang Sari
16.07.20.2002|Maju Ria
16.07.20.2003|Sri Agung
16.07.20.2004|Sumber Rejeki
16.07.20.2005|Tabala Jaya
16.07.20.2006|Jati Sari
16.07.20.2007|Mekar Sari
16.07.21.2001|Penuguan
16.07.21.2002|Sumber Rejo
16.07.21.2003|Sumber Mukti
16.07.21.2004|Sumber Agung
16.07.21.2005|Wonodadi
16.07.21.2006|Mekar Sari
16.07.21.2007|Songo Makmur
16.07.21.2008|Karang Manunggal
16.07.21.2009|Purwodadi
16.07.21.2010|Ringin Harjo
16.07.21.2011|Bumi Rejo
16.07.21.2012|Kelapa Dua
16.08.01.1007|Dusun Martapura
16.08.01.1008|Pasar Martapura
16.08.01.1014|Paku Sengkunyit
16.08.01.1016|Bukit Sari
16.08.01.1017|Sungai Tuha Jaya
16.08.01.1018|Terukis Rahayu
16.08.01.1019|Veteran Jaya
16.08.01.2006|Tanjung Kemala
16.08.01.2009|Kota Baru
16.08.01.2010|Keromongan
16.08.01.2011|Perjaya
16.08.01.2015|Sukomulyo
16.08.01.2020|Kotabaru Barat
16.08.01.2021|Kotabaru Selatan
16.08.01.2022|Perjaya Barat
16.08.01.2023|Tanjung Kemala Barat
16.08.02.2001|Suka Raja
16.08.02.2002|Kurungan Nyawa
16.08.02.2003|Pisang Jaya
16.08.02.2004|Sumber Agung
16.08.02.2005|Tebat Jaya
16.08.02.2006|Sridadi
16.08.02.2009|Tanjung Bulan
16.08.02.2010|Way Halom
16.08.02.2031|Kurungan Nyawa I
16.08.02.2032|Kurungan Nyawa II
16.08.02.2033|Kurungan Nyawa III
16.08.02.2034|Cipta Muda
16.08.02.2035|Aman Jaya
16.08.02.2036|Sukaraja Tuha
16.08.02.2037|Ganjar Agung
16.08.02.2038|Mulyo Agung
16.08.02.2039|Muda Sentosa
16.08.03.2001|Sido Rahayu
16.08.03.2002|Tawang Rejo
16.08.03.2006|Tanjung Raya
16.08.03.2007|Sido Mulyo
16.08.03.2008|Harjo Winangun
16.08.03.2009|Pujo Rahayu
16.08.03.2010|Triyoso
16.08.03.2011|Sumber Suko
16.08.03.2013|Suko Sari
16.08.03.2014|Gumawang
16.08.03.2015|Bedilan
16.08.03.2016|Tegal Rejo
16.08.03.2017|Sido Gede
16.08.03.2018|Sido Makmur
16.08.03.2021|Suka Jadi
16.08.03.2022|Serbaguna
16.08.03.2023|Sukarami
16.08.03.2024|Gedung Rejo
16.08.03.2025|Sidodadi
16.08.03.2026|Gunung Mas
16.08.03.2027|Sumbersuko jaya
16.08.03.2028|Karang Kemiri
16.08.03.2029|Mojosari
16.08.04.2001|Gunung Batu
16.08.04.2010|Ulak Baru
16.08.04.2011|Gunung Jati
16.08.04.2012|Kuripan
16.08.04.2013|Negeri Sakti
16.08.04.2014|Campang Tiga Hulu
16.08.04.2015|Sukaraja
16.08.04.2016|Cempaka
16.08.04.2017|Sukabumi
16.08.04.2018|Campang Tiga Ilir
16.08.04.2019|Maluai Indah
16.08.04.2020|Harisan Jaya
16.08.04.2021|Campang Tiga Jaya
16.08.05.2001|Negeri Pakuan
16.08.05.2002|Negeri Agung
16.08.05.2003|Banu Mas
16.08.05.2004|Banu Ayu
16.08.05.2005|Pulau Negara
16.08.05.2006|Saung Dadi
16.08.05.2007|Trantang Sakti
16.08.05.2008|Pemetung Besuki
16.08.05.2009|Pahang Asri
16.08.05.2010|Bantan
16.08.05.2011|Bandar Jaya
16.08.05.2012|Negeri Agung Jaya
16.08.05.2013|Bantan Pelita
16.08.06.2001|Karang Negara
16.08.06.2002|Riang Bandung
16.08.06.2005|Kota Negara
16.08.06.2006|Karta Negara
16.08.06.2007|Pandan Agung
16.08.06.2009|Sri Mulyo
16.08.06.2010|Margo Tani
16.08.06.2011|Jati Mulya II
16.08.06.2012|Pandan Jaya
16.08.06.2014|Rasuan Baru
16.08.06.2020|Banbanrejo
16.08.06.2021|Suka Negara
16.08.06.2022|Srikencana
16.08.06.2023|Dadimulyo
16.08.06.2024|Riang Bandung Ilir
16.08.06.2025|Margotani II
16.08.06.2026|Kota Negara Timur
16.08.06.2027|Talang Giring
16.08.06.2028|Kalirejo
16.08.07.2002|Mendayun
16.08.07.2003|Gunung Terang
16.08.07.2004|Karta Mulya
16.08.07.2007|SP. Kerta Mulya
16.08.07.2014|Harjo Mulyo
16.08.07.2015|Jaya Bakti
16.08.07.2016|Rasuan
16.08.07.2017|Mengulak
16.08.07.2019|Jati Sari
16.08.07.2021|Tri Dadi
16.08.07.2022|Agung Jati
16.08.07.2023|Rasuan Darat
16.08.07.2024|Harjo Mulyo Jaya
16.08.08.2002|Jaya Mulya
16.08.08.2003|Gunung Sugih
16.08.08.2007|Margo Rejo
16.08.08.2009|Trimoharjo
16.08.08.2010|Taman Agung
16.08.08.2011|Krujon
16.08.08.2013|Karang Endah
16.08.08.2014|Sriwangi
16.08.08.2015|Cahaya Negeri
16.08.08.2016|Suka Mulya
16.08.08.2017|Taraman
16.08.08.2025|Mujo Rahayu
16.08.08.2026|Taman Harjo
16.08.08.2027|Margodadi
16.08.08.2028|Taraman Jaya
16.08.08.2029|Karang Marga
16.08.08.2030|Trimo Rejo
16.08.08.2031|Sriwangi Ulu
16.08.08.2032|Taman Mulyo
16.08.09.2004|Tanjung Kemuning
16.08.09.2005|Raman Jaya
16.08.09.2006|Sumber Jaya
16.08.09.2007|Sumber Rejo
16.08.09.2008|Sumber Sari
16.08.09.2009|Tegal Sari
16.08.09.2010|Sri Bantolo
16.08.09.2011|Sumber Rahayu
16.08.09.2012|Margo Mulyo
16.08.09.2015|Purwosari
16.08.09.2016|Karang Manik
16.08.09.2017|Sumber Harapan
16.08.09.2018|Keli Rejo
16.08.09.2019|Toto Rejo
16.08.09.2020|Karang Jaya
16.08.09.2021|Kemuning Jaya
16.08.09.2022|Bangun Rejo
16.08.09.2023|Batu Mas
16.08.09.2024|Suka Jaya
16.08.09.2025|Srijaya
16.08.09.2026|Tegal Besar
16.08.09.2027|Darma Buana
16.08.09.2028|Rejo Mulyo
16.08.09.2029|Purworejo
16.08.10.2001|Kutosari
16.08.10.2002|Nusa Raya
16.08.10.2003|Nusa Tunggal
16.08.10.2004|Nusa Bali
16.08.10.2005|Nusa Bakti
16.08.10.2006|Nusa Jaya
16.08.10.2007|Nusa Tenggara
16.08.10.2008|Nusa Agung
16.08.10.2009|Nusa Maju
16.08.10.2010|Senu Marga
16.08.10.2011|Karang Sari
16.08.10.2013|Trikarya
16.08.10.2016|Suka Negara
16.08.10.2017|Karang Jadi
16.08.10.2018|Dadi Rejo
16.08.10.2019|Ganti Warno
16.08.10.2020|Sinar Bali
16.08.10.2021|Sumber Rejo
16.08.10.2022|Ringin Sari
16.08.10.2023|Karya Maju
16.08.11.2001|Batu Raja Bungin
16.08.11.2002|Tulang Bawang
16.08.11.2003|Sabahlioh
16.08.11.2004|Negeri Ratu
16.08.11.2005|Peracak
16.08.11.2006|Negeri Ratu Baru
16.08.11.2007|Tunas Peracak
16.08.11.2008|Sukabaru
16.08.12.2001|Tanjung Mas
16.08.12.2002|Tanjungsari
16.08.12.2003|Teko Rejo
16.08.12.2004|Sumber Asri
16.08.12.2005|Suka Maju
16.08.12.2006|Srikaton
16.08.12.2007|Liman Sari
16.08.12.2008|Sumber Harjo
16.08.12.2009|Sumber Mulyo
16.08.12.2010|Karang Tengah
16.08.12.2011|Bangun Harjo
16.08.12.2012|Tambak Boyo
16.08.12.2013|Pengandonan
16.08.12.2014|Rejo Dadi
16.08.12.2015|Sukoharjo
16.08.12.2016|Sumedang Sari
16.08.12.2017|Rowodadi
16.08.12.2018|Sukodadi
16.08.12.2019|Kumpul Rejo
16.08.12.2020|Metro Rejo
16.08.12.2021|Kedu
16.08.12.2022|Kedung Rejo
16.08.12.2023|Banyumas Asri
16.08.12.2024|Gumuk Rejo
16.08.12.2025|Tanjung Mulya
16.08.12.2026|Raman Agung
16.08.12.2027|Bukit Mas
16.08.12.2028|Tanjung Agung
16.08.12.2029|Berasan Mulya
16.08.12.2030|Sumber Tani
16.08.13.2001|Banding Agung
16.08.13.2002|Nikan
16.08.13.2003|Surabaya
16.08.13.2004|Wana Bakti
16.08.13.2005|Batu Marta VI
16.08.13.2006|Karya Makmur
16.08.13.2007|Bina Amarta
16.08.13.2008|Suka Damai
16.08.13.2009|Batu Marta X
16.08.13.2010|Marta V Jaya
16.08.14.2001|Tanjung Kukuh
16.08.14.2002|Betung
16.08.14.2003|Tanjung Mas
16.08.14.2004|Menanga Besar
16.08.14.2005|Menanga Tengah
16.08.14.2006|Adu manis
16.08.14.2007|Suka Negeri
16.08.14.2008|Kangkung
16.08.14.2009|Sri Tanjung
16.08.14.2010|Kangkung Ilir
16.08.14.2011|Betung Timur
16.08.14.2012|Menanga Sari
16.08.15.2001|Karang Melati
16.08.15.2002|Karang Menjangan
16.08.15.2003|Karang Anyar
16.08.15.2004|Tulung Harapan
16.08.15.2005|Kota Tanah
16.08.15.2006|Nirwana
16.08.15.2007|Burnai Mulya
16.08.15.2008|Kota Mulya
16.08.15.2009|Bungin Jaya
16.08.15.2010|Burnai Jaya
16.08.15.2011|Mulia Jaya
16.08.15.2012|Melati Jaya
16.08.15.2013|Karang Mulya
16.08.15.2014|Wanasari
16.08.15.2015|Harapan Jaya
16.08.15.2016|Melati Agung
16.08.15.2017|Wana Makmur
16.08.15.2018|Bawang Tikar
16.08.15.2019|Karya Bakti
16.08.16.2001|Jayapura
16.08.16.2002|Bunga Mayang
16.08.16.2003|Way Salak
16.08.16.2004|Mendah
16.08.16.2005|Tumijaya
16.08.16.2006|Condong
16.08.16.2007|Peracak Jaya
16.08.16.2008|Kambang
16.08.17.2001|Rejosari
16.08.17.2002|Sido Rejo
16.08.17.2003|Banjar Rejo
16.08.17.2004|Panca Tunggal
16.08.17.2005|Marga Koyo
16.08.17.2006|Sumber Agung
16.08.17.2007|Karsa Jaya
16.08.17.2008|Windusari
16.08.17.2009|Karya Makmur
16.08.17.2010|Giri Mulyo
16.08.17.2011|Madugondo
16.08.17.2012|Argomulyo
16.08.17.2013|Rejosari Jaya
16.08.18.2001|Tugu Mulyo
16.08.18.2002|Bangsa Negara
16.08.18.2003|Tugu Harum
16.08.18.2004|Tulus Ayu
16.08.18.2005|Yosowinangun
16.08.18.2006|Karang Binangun
16.08.18.2007|Jati Mulyo I
16.08.18.2008|Pandan Sari I
16.08.18.2009|Pelita Jaya
16.08.18.2010|Mekar Jaya
16.08.18.2011|Lubuk Harjo
16.08.18.2012|Tanah Merah
16.08.18.2013|Rantau Jaya
16.08.18.2014|Tebing Sari Mulya
16.08.18.2015|Marga Cinta
16.08.18.2016|Karang Binangun II
16.08.19.2001|Sari Guna
16.08.19.2002|Sido Waluyo
16.08.19.2003|Sugih Waras
16.08.19.2004|Rejo Sari
16.08.19.2005|Petanggan
16.08.19.2006|Purwodadi
16.08.19.2007|Sri Mulyo
16.08.19.2008|Ulak Buntar
16.08.19.2009|Sribudaya
16.08.19.2010|Sukoharjo
16.08.19.2011|Tulung Sari
16.08.19.2012|Mulya Sari
16.08.20.2001|Sri Bunga
16.08.20.2002|Anyar
16.08.20.2003|Pandan Sari II
16.08.20.2004|Rawasari
16.08.20.2005|Surya Menang
16.08.20.2006|Muncak Kabau
16.08.20.2007|Sri Bulan
16.09.01.1013|Batu Belang Jaya
16.09.01.1014|Bumi Agung
16.09.01.1015|Pancur Pungah
16.09.01.1016|Kisau
16.09.01.1019|Pasar Muaradua
16.09.01.2002|Gedung Lepihan
16.09.01.2003|Gunung Tiga
16.09.01.2004|Suka Banjar
16.09.01.2005|Sukaraja II
16.09.01.2017|Pendagan
16.09.01.2018|Mehanggin
16.09.01.2024|Pelangki
16.09.01.2025|Batu Belang 2
16.09.01.2026|Datar
16.09.02.2012|Tanjung Bulan
16.09.02.2013|Pulau Beringin
16.09.02.2014|Aromantai
16.09.02.2015|Tanjung Kari
16.09.02.2016|Simpang Pancur
16.09.02.2017|Pagar Agung
16.09.02.2018|Gunung Batu
16.09.02.2019|Kemu
16.09.02.2020|Anugerah Kemu
16.09.02.2021|Kemu Ulu
16.09.02.2022|Pematang Obar
16.09.02.2023|Tanjung Bulan Ulu
16.09.02.2024|Pulau Beringin Utara
16.09.03.1023|Bandar Agung Ranau
16.09.03.2020|Way Timah
16.09.03.2021|Sipatuhu
16.09.03.2022|Banding Agung
16.09.03.2024|Surabaya
16.09.03.2025|Sugih Waras
16.09.03.2026|Suka Negeri
16.09.03.2027|Rantau Nipis
16.09.03.2028|Air Rupik
16.09.03.2031|Talang Merbau
16.09.03.2032|Tanjung Agung
16.09.03.2033|Tanjung Harapan
16.09.03.2034|Telanai
16.09.03.2035|Sumber Makmur
16.09.03.2036|Karang Indah
16.09.03.2037|Tangsi Agung
16.09.03.2038|Penantian
16.09.03.2039|Suka Maju
16.09.03.2040|Sidodadi
16.09.03.2041|Sipatuhu II
16.09.03.2042|Terap Mulia
16.09.03.2043|Surabaya Timur
16.09.04.2001|Lawang Agung
16.09.04.2002|Bayur Tengah
16.09.04.2003|Tanjung Tebat
16.09.04.2004|Sugihan
16.09.04.2005|Penyandingan
16.09.04.2006|Alun Dua
16.09.04.2007|Bandar Alam Baru
16.09.04.2008|Dusun Tengah
16.09.04.2009|Ulak Agung Ilir
16.09.04.2011|Gunung Gare
16.09.04.2018|Ulak Agung Ulu
16.09.04.2019|Muaradua Kisam
16.09.04.2020|Sukananti
16.09.04.2021|Pagar Dewa
16.09.04.2022|Tanjung Beringin
16.09.04.2028|Panantian
16.09.04.2029|Sukaraja
16.09.04.2040|Simpang Lubuk Dalam
16.09.05.2001|Karang Agung
16.09.05.2007|Lubar
16.09.05.2008|Tanjung Sari
16.09.05.2009|Simpangan
16.09.05.2010|Bungin Campang
16.09.05.2029|Simpang Agung
16.09.05.2030|Sinar Mulyo
16.09.06.2007|Sukarami
16.09.06.2008|Tanjung Raya
16.09.06.2010|Tanjung Menang Ilir
16.09.06.2011|Tanjung Menang Ulu
16.09.06.2012|Kenali
16.09.06.2013|Negeri Cahya
16.09.06.2014|Sukaraja I
16.09.06.2015|Tanjung Iman
16.09.06.2016|Bunga Mas
16.09.06.2017|Lubuk Liku
16.09.06.2018|Kota Karang
16.09.06.2019|Negeri Batin
16.09.06.2020|Madura
16.09.06.2021|Negeri Agung
16.09.06.2022|Gunung Terang
16.09.06.2023|Talang Baru
16.09.07.2001|Sugih Rawas
16.09.07.2002|Padang Sari
16.09.07.2003|Padang Bindu
16.09.07.2005|Saung Naga
16.09.07.2006|Negeri Batin Baru
16.09.07.2007|Kota Aman
16.09.07.2008|Belambangan
16.09.07.2009|Paninjauan
16.09.07.2018|Nagar Agung
16.09.07.2019|Simpang Saga
16.09.07.2020|Perupus Blambangan
16.09.07.2021|Kagelang Blambangan
16.09.07.2022|Sukajadi Blambangan
16.09.07.2023|Bedeng Blambangan
16.09.08.2001|Kota Dalam
16.09.08.2002|Teluk Agung
16.09.08.2003|Pulau Duku
16.09.08.2004|Tanjung Besar
16.09.08.2005|Sinar Marga
16.09.08.2006|Kota Baru
16.09.08.2007|Galang Tinggi
16.09.08.2008|Sukaraja
16.09.08.2009|Sri Menanti
16.09.08.2010|Kepayang
16.09.08.2011|Kemang Bandung
16.09.08.2012|Selabung Belimbing Jaya
16.09.08.2013|Bunut
16.09.08.2014|Air Baru
16.09.08.2015|Pere'an
16.09.09.2001|Tanjung Durian
16.09.09.2002|Sipin
16.09.09.2003|Kota Way
16.09.09.2004|Talang Padang
16.09.09.2005|Sri Menanti
16.09.09.2006|Serakat Jaya
16.09.09.2007|Karet Jaya
16.09.09.2008|Danau Jaya
16.09.09.2009|Sumber Ringin
16.09.09.2010|Kembang Tinggi
16.09.09.2011|Sido Rahayu
16.09.09.2012|Sidodadi
16.09.09.2013|Durian Sembilan
16.09.09.2014|Sumber Raya
16.09.09.2015|Sinar Napalan
16.09.09.2016|Tanjung Jaya
16.09.09.2017|Sinar Baru
16.09.09.2018|Mekar Jaya
16.09.09.2019|Tanjung Sari
16.09.09.2020|Tanjung Baru
16.09.09.2021|Air Kelian
16.09.09.2022|Tanjung Menang
16.09.10.2001|Balayan
16.09.10.2002|Berasang
16.09.10.2003|Tebat Gabus
16.09.10.2004|Padang Lay
16.09.10.2005|Danau Rata
16.09.10.2006|Pajar Bulan
16.09.10.2007|Bandar Alam Lama
16.09.10.2008|Muara Payang
16.09.10.2009|Siring Agung
16.09.10.2010|Kota Padang
16.09.10.2011|Padang Bindu
16.09.10.2012|Tenang
16.09.10.2013|Gunung Megang
16.09.10.2014|Ulak Pandan
16.09.10.2015|Pulau Panggung
16.09.10.2016|Simpang Tiga
16.09.10.2017|Simpang Empat
16.09.10.2018|Singa Laga
16.09.10.2019|Air Alun
16.09.11.2001|Pius
16.09.11.2002|Pengandonan
16.09.11.2003|Siring Alam
16.09.11.2004|Simpang Campang
16.09.11.2005|Pulau Kemiling
16.09.11.2006|Keban Agung
16.09.11.2007|Muara Sindang
16.09.11.2008|Campang Jaya
16.09.11.2009|Tanjung Jati
16.09.12.1013|Simpang Sender
16.09.12.2001|Tanjung Kemala
16.09.12.2002|Sukamarga
16.09.12.2003|Subik
16.09.12.2004|Jepara
16.09.12.2005|Hangkusa
16.09.12.2006|Sukarami
16.09.12.2007|Padang Ratu
16.09.12.2008|Tanjung Setia
16.09.12.2009|Gedung Baru
16.09.12.2010|Tanjung Sari
16.09.12.2011|Suka Bumi
16.09.12.2012|Sumber Mulia
16.09.12.2014|Way Relai
16.09.12.2015|Tanjung Baru Ranau
16.09.12.2016|Simpang Sender Selatan
16.09.12.2017|Simpang Sender Utara
16.09.12.2018|Simpang Sender Timur
16.09.12.2019|Simpang Sender Tengah
16.09.12.2020|Sumber Jaya
16.09.12.2021|Pakhda Suka
16.09.12.2022|Serumpun Jaya
16.09.13.2001|Sukajaya
16.09.13.2002|Kota Batu
16.09.13.2003|Pagar Dewa
16.09.13.2004|Tanjung Jati
16.09.13.2005|Gunung Aji
16.09.13.2006|Pilla
16.09.13.2007|Gunung Raya
16.09.13.2008|Remanam Jaya
16.09.13.2009|Kiwis Raya
16.09.13.2010|Segigok Raya
16.09.13.2011|Bumi Agung
16.09.13.2012|Mekar Sari
16.09.13.2013|Bedeng Tiga
16.09.13.2014|Gedung Ranau
16.09.13.2015|Tanjung Baru
16.09.13.2016|Way Wangi Seminung
16.09.14.2001|Merpang
16.09.14.2002|Tanjung Kurung
16.09.14.2003|Air Baru
16.09.14.2004|Penanggungan
16.09.14.2005|Bumi Genap
16.09.14.2006|Gedung Nyawa
16.09.14.2007|Gedung Wani
16.09.14.2008|Sura
16.09.14.2009|Karang Endah
16.09.15.2001|Pulau Kemuning
16.09.15.2002|Guntung Jaya
16.09.15.2003|Tanah Pilih
16.09.15.2004|Ujan Mas
16.09.15.2005|Pecah Pinggan
16.09.15.2006|Cukoh Nau
16.09.15.2007|Simpang Luas
16.09.15.2008|Sedau Jaya
16.09.15.2009|Sebaja
16.09.16.2001|Tanjung Harapan
16.09.16.2002|Muara Sindang Ilir
16.09.16.2003|Muara Sindang Tengah
16.09.16.2004|Pematang Danau
16.09.16.2005|Ulu Danau
16.09.16.2006|Tebat Layang
16.09.16.2007|Watas
16.09.17.2001|Tekana
16.09.17.2002|Tanjung Beringin
16.09.17.2003|Bandar
16.09.17.2004|Jagaraga
16.09.17.2005|Damarpura
16.09.17.2006|Tunas Jaya
16.09.17.2007|Sinar Danau
16.09.17.2008|Gemiung
16.09.18.2001|Peninggiran
16.09.18.2002|Kuripan
16.09.18.2003|Surabaya
16.09.18.2004|Sukarena
16.09.18.2005|Karang Pendeta
16.09.18.2006|Kota Agung
16.09.18.2007|Sukabumi
16.09.18.2008|Kuripan II
16.09.19.2001|Rantau Panjang
16.09.19.2002|Sukajaya
16.09.19.2003|Banjar Agung
16.09.19.2004|Ruos
16.09.19.2005|Gunung Cahya
16.09.19.2006|Bumi Jaya
16.09.19.2007|Bendi
16.09.19.2008|Pekuolan
16.09.19.2009|Pelawi
16.09.19.2011|Majar
16.09.19.2012|Bumi Agung Jaya
16.10.01.1011|Muara Kuang
16.10.01.2005|Munggu
16.10.01.2006|Seri Menanti
16.10.01.2007|Rantau Sialang
16.10.01.2008|Kuang Anyar
16.10.01.2009|Kasah
16.10.01.2012|Tanabang Ulu
16.10.01.2013|Seri Kembang
16.10.01.2014|Nagasari
16.10.01.2015|Suka Cinta
16.10.01.2016|Kelampadu
16.10.01.2029|Sukajadi
16.10.01.2030|Ramakasih
16.10.01.2031|Tanabang Ilir
16.10.02.1017|Tanjung Batu
16.10.02.1037|Tanjung Batu Timur
16.10.02.2010|Seri Bandung
16.10.02.2011|Seri Tanjung
16.10.02.2012|Tanjung Tambak
16.10.02.2013|Senuro Timur
16.10.02.2014|Tanjung Baru Petai
16.10.02.2015|Tanjung Batu Seberang
16.10.02.2016|Pajar Bulan
16.10.02.2018|Tanjung Atap
16.10.02.2019|Tanjung Pinang I
16.10.02.2020|Limbang Jaya I
16.10.02.2021|Tanjung Laut
16.10.02.2026|Burai
16.10.02.2027|Sentul
16.10.02.2031|Bangun Jaya
16.10.02.2032|Tanjung Tambak Baru
16.10.02.2033|Limbang Jaya II
16.10.02.2034|Senuro Barat
16.10.02.2035|Tanjung Pinang II
16.10.02.2036|Tanjung Atap Barat
16.10.03.1001|Tanjung Raja
16.10.03.1027|Tanjung Raja Barat
16.10.03.1028|Tanjung Raja Utara
16.10.03.1035|Tanjung Raja Timur
16.10.03.2002|Suka Pindah
16.10.03.2007|Tanjung Temiang
16.10.03.2008|Seri Dalam
16.10.03.2018|Kerinjing
16.10.03.2019|Ulak Kerbau Baru
16.10.03.2020|Ulak Kerbau Lama
16.10.03.2021|Tanjung Agas
16.10.03.2022|Siring Alam
16.10.03.2023|Talang Balai Baru I
16.10.03.2024|Talang Balai Lama
16.10.03.2030|Skonjing
16.10.03.2031|Tanjung Raja Selatan
16.10.03.2032|Belanti
16.10.03.2033|Tanjung Harapan
16.10.03.2034|Talang Balai Baru II
16.10.04.1030|Indralaya Raya
16.10.04.1031|Indralaya Indah
16.10.04.1032|Indralaya Mulia
16.10.04.2005|Lubuk Sakti
16.10.04.2006|Tanjung Gelam
16.10.04.2007|Tanjung Agung
16.10.04.2008|Tanjung Sejaro
16.10.04.2009|Sakatiga Seberang
16.10.04.2010|Muara P. Ulu
16.10.04.2012|Tanjung Seteko
16.10.04.2013|Saka Tiga
16.10.04.2014|Ulak Banding
16.10.04.2015|Muara P. Ilir
16.10.04.2016|Talang Aur
16.10.04.2017|Ulak Bedil
16.10.04.2018|Penyandingan
16.10.04.2019|Sudimampir
16.10.04.2027|Ulak Segelung
16.10.04.2028|Sejaro Sakti
16.10.04.2029|Tunas Aur
16.10.05.2015|Aurstanding
16.10.05.2016|Sukarami
16.10.05.2017|Muara Dua
16.10.05.2018|Palu
16.10.05.2019|Teluk Kecapi
16.10.05.2020|Pelabuhan Dalam
16.10.05.2021|Pemulutan Ulu
16.10.05.2022|Pemulutan Ilir
16.10.05.2023|Sungai Rasau
16.10.05.2024|Ibul Besar I
16.10.05.2025|Pegayut
16.10.05.2029|S. Pelabuhan Dlm
16.10.05.2030|Ibul Besar II
16.10.05.2031|Ibul Besar III
16.10.05.2032|Mekar Jaya
16.10.05.2033|Kedukan Bujang
16.10.05.2034|Rawa Jaya
16.10.05.2035|Babatan Saudagar
16.10.05.2036|Tanjung Pasir
16.10.05.2037|Harapan
16.10.05.2038|Pipa Putih
16.10.05.2039|Sungai Buaya
16.10.05.2040|Muara Baru
16.10.05.2041|Sembadak
16.10.05.2042|Lebung Jangkar
16.10.06.2006|Sirah Pulau Kilip
16.10.06.2011|Kelampaian
16.10.06.2012|Sukananti
16.10.06.2013|Sukamarga
16.10.06.2014|Rantau Alai
16.10.06.2015|Kerta Bayang
16.10.06.2016|Tanjung Mas
16.10.06.2017|Talang Sari
16.10.06.2018|Lebung Bandung
16.10.06.2020|Sanding Marga
16.10.06.2021|Sukamaju
16.10.06.2022|Mekar Sari
16.10.06.2023|Sukananti Baru
16.10.07.1016|Timbangan
16.10.07.2001|Tanjung Pering
16.10.07.2002|Bakung
16.10.07.2003|Lorok
16.10.07.2004|Parit
16.10.07.2005|Payakabung
16.10.07.2006|Sungai Rambutan
16.10.07.2007|Purna Jaya
16.10.07.2008|Soak Batok
16.10.07.2009|Tanjung Baru
16.10.07.2010|Tanjung Pule
16.10.07.2011|Permata Baru
16.10.07.2012|Suka Mulia
16.10.07.2013|Pulau Kabai
16.10.07.2014|Pulau Semambu
16.10.07.2015|Palem Raya
16.10.08.2001|Mandi Angin
16.10.08.2002|Tanjung Lubuk
16.10.08.2003|Tebing Gerinting Selatan
16.10.08.2004|Arisan Gading
16.10.08.2005|Tanjung Dayang Selatan
16.10.08.2006|Beti
16.10.08.2007|Meranjat I
16.10.08.2008|Meranjat Ilir
16.10.08.2009|Meranjat II
16.10.08.2010|Sukaraja Lama
16.10.08.2011|Sukaraja Baru
16.10.08.2012|Tebing Gerinting Utara
16.10.08.2013|Tanjung Dayang Utara
16.10.08.2014|Meranjat III
16.10.09.2001|Pematang Bangsal
16.10.09.2002|Maya Pati
16.10.09.2003|Sungai Lebung
16.10.09.2005|Kapuk
16.10.09.2006|Ulak Aurstanding
16.10.09.2007|Maju Jaya
16.10.09.2008|Naikan Tembakang
16.10.09.2009|Segayam
16.10.09.2010|Cahaya Marga
16.10.09.2011|S. Lebung Ulu
16.10.09.2012|Sungai Keli
16.10.09.2013|Lebak Pering
16.10.09.2014|Sungai Ondok
16.10.09.2015|Harimau Tandang
16.10.09.2016|Pematang Bungur
16.10.10.2001|Suka Merindu
16.10.10.2002|Sarang Lang
16.10.10.2003|Kamal
16.10.10.2004|Pulau Negara
16.10.10.2005|Talang Pangeran Ulu
16.10.10.2006|Ulak Kembahang I
16.10.10.2007|Ulak Petangisan
16.10.10.2008|Sribanding
16.10.10.2009|Ulak Kembahang II
16.10.10.2010|Talang Pangeran Ilir
16.10.10.2011|Arisan Jaya
16.10.11.2001|Kotadaro I
16.10.11.2002|Ketapang I
16.10.11.2003|Rantau Panjang Ilir
16.10.11.2004|Jagaraja
16.10.11.2005|Jagalano
16.10.11.2006|Sejangko I
16.10.11.2007|Kota Daro II
16.10.11.2008|Sungai Rotan
16.10.11.2009|Rantau Panjang Ulu
16.10.11.2010|Ketapang II
16.10.11.2011|Sejangko II
16.10.11.2012|Arisan Deras
16.10.12.1007|Sungai Pinang
16.10.12.2001|Serijabo
16.10.12.2002|Sungai Pinang II
16.10.12.2003|Talang Dukun
16.10.12.2004|Tanjung Serian
16.10.12.2005|Penyandingan
16.10.12.2006|Sungai Pinang III
16.10.12.2008|Pinang Jaya
16.10.12.2009|Sungai Pinang I
16.10.12.2010|Pinang Mas
16.10.12.2011|S. Pinang Lagati
16.10.12.2012|S. Pinang Nibung
16.10.12.2013|Seri Jabo Baru
16.10.13.2001|Lubuk Rukam
16.10.13.2002|Tanjung Alai
16.10.13.2003|Kandis I
16.10.13.2004|Kumbang Ulu
16.10.13.2005|Kumbang Ilir
16.10.13.2006|Miji
16.10.13.2007|Santapan Barat
16.10.13.2008|Pandan Arang
16.10.13.2009|Muara Kumbang
16.10.13.2010|Kandis II
16.10.13.2011|Santapan Timur
16.10.13.2012|Lubuk Segonang
16.10.14.2001|Ibul Dalam
16.10.14.2002|Beringin Dalam
16.10.14.2003|Kuang Dalam Barat
16.10.14.2004|Lubuk Tunggal
16.10.14.2005|Ulak Segara
16.10.14.2006|Tanjung Bulan
16.10.14.2007|Tambang Rambang
16.10.14.2008|Sukananti
16.10.14.2009|Kayu Ara
16.10.14.2010|Tanjung Miring
16.10.14.2011|Sunur
16.10.14.2012|Kuang Dalam Timur
16.10.14.2013|Tangai
16.10.15.2001|Ulak Kembahang
16.10.15.2002|Lubuk Keliat
16.10.15.2003|Embacang
16.10.15.2004|Kasih Raja
16.10.15.2005|Talang Tengah Darat
16.10.15.2006|Betung II
16.10.15.2007|Ketiau
16.10.15.2008|Payalingkung
16.10.15.2009|Betung I
16.10.15.2010|Talang Tengah Laut
16.10.16.1012|Payaraman Barat
16.10.16.1013|Payaraman Timur
16.10.16.2001|Tebedak I
16.10.16.2002|Lubuk Bandung
16.10.16.2003|Talang Seleman
16.10.16.2004|Tebedak II
16.10.16.2005|Tanjung lalang
16.10.16.2006|Seri Kembang I
16.10.16.2007|Rengas I
16.10.16.2008|Paya Besar
16.10.16.2009|Rengas II
16.10.16.2010|Seri Kembang II
16.10.16.2011|Seri Kembang III
16.11.01.2001|Batu Jungul
16.11.01.2002|Suka Dana
16.11.01.2003|Padang Burnai
16.11.01.2004|Belimbing
16.11.01.2005|Tanjung Kurung
16.11.01.2006|Muara Pinang Baru
16.11.01.2007|Lubuk Tanjung
16.11.01.2008|Talang Baru
16.11.01.2009|Sapa Panjang
16.11.01.2010|Muara Pinang Lama
16.11.01.2011|Tanjung Tawang
16.11.01.2012|Gedung Agung
16.11.01.2013|Pajar Menang
16.11.01.2014|Niur
16.11.01.2015|Muara Semah
16.11.01.2016|Talang Benteng
16.11.01.2017|Lubuk Ulak
16.11.01.2018|Batu Galang
16.11.01.2019|Muara Timbuk
16.11.01.2020|Seleman Ilir
16.11.01.2021|Seleman Ulu
16.11.01.2022|Sawah
16.11.02.1018|Beruge Ilir
16.11.02.1030|Pendopo
16.11.02.1031|Pagar Tengah
16.11.02.2001|Jarakan
16.11.02.2002|Bandar Agung
16.11.02.2003|Lubuk Sepang
16.11.02.2004|Lubuk Layang
16.11.02.2005|Nanjungan
16.11.02.2006|Tanjung Eran
16.11.02.2007|Tanjung Raman
16.11.02.2020|Bayau
16.11.02.2022|Gn. Meraksa Baru
16.11.02.2023|Landur
16.11.02.2024|Muara Karang
16.11.02.2025|Sarang Bulan
16.11.02.2026|Tanjung Baru
16.11.02.2027|Batu Cawang
16.11.02.2028|Manggilan
16.11.02.2029|Gn Merakasa Lama
16.11.03.2001|Air Kelinsar
16.11.03.2002|Talang Bengkulu
16.11.03.2003|Kunduran
16.11.03.2004|Simpang Perigi
16.11.03.2005|Muara Kalangan
16.11.03.2006|Batu Lintang
16.11.03.2007|Padang Tepong
16.11.03.2008|Muara Betung
16.11.03.2009|Lb. Puding Baru
16.11.03.2010|Pulau Kemang
16.11.03.2011|Lb. Puding Lama
16.11.03.2012|Batu Bidung
16.11.03.2024|Tanjung Agung
16.11.03.2025|Galang
16.11.04.1010|Kupang
16.11.04.1013|Tanjungkupang
16.11.04.1014|Tanjung Makmur
16.11.04.1017|Ps. Tebing Tinggi
16.11.04.1033|Jaya Loka
16.11.04.1036|Kelumpang Jaya
16.11.04.2001|Ujung Alih
16.11.04.2002|Lb. Gelanggang
16.11.04.2003|Ulak Mengkudu
16.11.04.2004|Batu Pance
16.11.04.2005|Aur Gading
16.11.04.2006|Terusan Lama
16.11.04.2007|Terusan Baru
16.11.04.2008|Rantau Tenang
16.11.04.2009|Seguring Kecil
16.11.04.2011|Kemang Manis
16.11.04.2012|Lampar Baru
16.11.04.2021|Kota Gading
16.11.04.2022|Batu Raja Baru
16.11.04.2023|Batu Raja Lama
16.11.04.2024|Sugi Waras
16.11.04.2027|Mekar Jaya
16.11.04.2030|Fajar Bakti
16.11.04.2032|Pancur Mas
16.11.04.2034|Makarti Jaya
16.11.04.2035|Tanjung Kupang Baru
16.11.05.2001|Umo Jati
16.11.05.2002|Tanjung Jati
16.11.05.2003|Pagar Jati
16.11.05.2004|Nibung
16.11.05.2005|Batu Ampar
16.11.05.2006|Karang Tanding
16.11.05.2007|Lubuk Cik
16.11.05.2008|Rantau Kasai
16.11.05.2009|Suka Rami
16.11.05.2010|Rantau Alih
16.11.05.2011|Tanjung Alam
16.11.05.2012|Lesung Batu
16.11.05.2013|Babatan
16.11.05.2014|Muara Danau
16.11.05.2015|Endalo
16.11.05.2016|Lubuk Tapang
16.11.06.2001|Karang Are
16.11.06.2002|Padang Titiran
16.11.06.2003|Kembahang Lama
16.11.06.2004|Pasar Tl. Padang
16.11.06.2005|Macang Manis
16.11.06.2006|Lubuk Buntak
16.11.06.2007|Talang Durian
16.11.06.2008|Talang Padang
16.11.06.2009|Kembahang Baru
16.11.06.2010|Canggu
16.11.06.2011|Remantai
16.11.06.2012|Ulak Dabuk
16.11.06.2013|Lampar Baru
16.11.07.2001|Talang Padang
16.11.07.2002|Tanjung Beringin
16.11.07.2003|Penantian
16.11.07.2004|Pagar Jati
16.11.07.2005|Kebon Jati
16.11.07.2006|Bandar Agung
16.11.07.2007|Lawang Agung
16.11.07.2008|Nanjungan
16.11.07.2009|Talang Randai
16.11.07.2010|Air Mayam
16.11.07.2011|Muara Rungga
16.11.07.2012|Padang Gelai
16.11.07.2013|Padang Bindu
16.11.07.2014|Muara Sindang
16.11.07.2015|Muara Aman
16.11.08.2001|Puntang
16.11.08.2002|Bandar Aji
16.11.08.2003|Paduraksa
16.11.08.2004|Karang Gede
16.11.08.2005|Karang Dapo Baru
16.11.08.2006|Karang Dapo Lama
16.11.08.2007|Tangga Rasa
16.11.08.2008|Tapa Baru
16.11.08.2009|Tapa Lama
16.11.08.2010|Martapura
16.11.08.2011|Karang Anyar
16.11.09.2001|Lubuk Kelumpang
16.11.09.2002|Tanjungning Simpang
16.11.09.2003|Tanjungning Tengah
16.11.09.2004|Tanjungning Lama
16.11.09.2005|Tanjungning Jaya
16.11.09.2006|Sawah
16.11.09.2007|Kebon
16.11.09.2008|Suka Kaya
16.11.09.2009|Taba
16.11.09.2010|Muara Saling
16.11.10.2001|Muaralintang Lama
16.11.10.2002|Muaralintang Baru
16.11.10.2003|Tebat Payang
16.11.10.2004|Karang Caya
16.11.10.2005|Tanjungraya
16.11.10.2006|Padang Bindu
16.11.10.2007|Air Kandis
16.11.10.2008|Lingge
16.11.10.2009|Rantau Dodor
16.11.10.2010|Kungkilan
16.12.01.1003|Talang Ubi Timur
16.12.01.1010|Talang Ubi Barat
16.12.01.1011|Talang Ubi Utara
16.12.01.1012|Talang Ubi Selatan
16.12.01.1017|Pasar Bhayangkara
16.12.01.1018|Handayani Mulya
16.12.01.2001|Talang Bulang
16.12.01.2002|Benuang
16.12.01.2004|Talang Akar
16.12.01.2005|Sungai Ibul
16.12.01.2006|Karta Dewa
16.12.01.2007|Panta Dewa
16.12.01.2008|Sungai Baung
16.12.01.2009|Semangus
16.12.01.2013|Sinar Dewa
16.12.01.2014|Benakat Minyak
16.12.01.2015|Suka Maju
16.12.01.2016|Suka Damai
16.12.01.2019|Beruge Darat
16.12.01.2020|Simpang Tais
16.12.02.2001|Sukarami
16.12.02.2002|Tanjung Baru
16.12.02.2003|Prabu Menang
16.12.02.2004|Tanding Marga
16.12.02.2005|Karang Tanding
16.12.02.2006|Lubuk Tampui
16.12.02.2007|Tempirai
16.12.02.2008|Tempirai Selatan
16.12.02.2009|Kota Baru
16.12.02.2010|Tempirai Utara
16.12.02.2011|Tempirai Timur
16.12.02.2012|Tambak
16.12.02.2013|Muara Ikan
16.12.03.2001|Purun
16.12.03.2002|Gunung Menang
16.12.03.2003|Mangkunegara
16.12.03.2004|Raja Jaya
16.12.03.2005|Air Itam
16.12.03.2006|Gunung Raja
16.12.03.2007|Air Itam Timur
16.12.03.2008|Sungai Langan
16.12.03.2009|Spantan Jaya
16.12.03.2010|Babat
16.12.03.2011|Suka Raja
16.12.03.2012|Purun Timur
16.12.03.2013|Mangkunegara Timur
16.12.04.2001|Betung
16.12.04.2002|Betung Barat
16.12.04.2003|Karang Agung
16.12.04.2004|Tanjung Kurung
16.12.04.2005|Pengabuan
16.12.04.2006|Prambatan
16.12.04.2007|Pengabuan Timur
16.12.04.2008|Betung Selatan
16.12.05.2001|Bumi Ayu
16.12.05.2002|Muara Sungai
16.12.05.2003|Tanah Abang Utara
16.12.05.2004|Sedupi
16.12.05.2005|Sukaraja
16.12.05.2006|Curup
16.12.05.2007|Raja
16.12.05.2008|Pandan
16.12.05.2009|Modong
16.12.05.2010|Tanah Abang Selatan
16.12.05.2011|Harapan Jaya
16.12.05.2012|Tanjung Dalam
16.12.05.2013|Lunas Jaya
16.12.05.2014|Raja Barat
16.12.05.2015|Tanah Abang Jaya
16.12.05.2016|Muara Dua
16.12.05.2017|Sukamanis
16.13.01.1007|Muara Rupit
16.13.01.2001|Tanjung Beringin
16.13.01.2002|Noman
16.13.01.2003|Batu Gajah
16.13.01.2004|Maur Lama
16.13.01.2005|Maur Baru
16.13.01.2006|Bingin Rupit
16.13.01.2008|Lubuk Rumbai
16.13.01.2009|Pantai
16.13.01.2010|Lawang Agung
16.13.01.2011|Karang Waru
16.13.01.2012|Karang Anyar
16.13.01.2013|Sungai Jernih
16.13.01.2014|Beringin Jaya
16.13.01.2015|Lubuk Rumbai Baru
16.13.01.2016|Noman Baru
16.13.01.2017|Batu Gajah Baru
16.13.02.1005|Pasar Surulangun
16.13.02.2001|Pangkalan
16.13.02.2002|Kerta Dewa
16.13.02.2003|Teladas
16.13.02.2004|Pulau Lebar
16.13.02.2006|Sungai Baung
16.13.02.2007|Sungai Jauh
16.13.02.2008|Sungai Kijang
16.13.02.2009|Surulangun
16.13.02.2010|Lesung Batu
16.13.02.2011|Lubuk Kemang
16.13.02.2012|Remban
16.13.02.2013|Lesung Batu Muda
16.13.02.2014|Simpang Nibung Rawas
16.13.02.2015|Lubuk Mas
16.13.02.2016|Sungai Lanang
16.13.02.2017|Sukomoro
16.13.03.1003|Karya Makmur
16.13.03.2001|Tebing Tinggi
16.13.03.2002|Jadi Mulya
16.13.03.2004|Mulya Jaya
16.13.03.2005|Sumber Makmur
16.13.03.2006|Sri Jaya Makmur
16.13.03.2007|Kelumpang Jaya
16.13.03.2008|Bumi Makmur
16.13.03.2009|Sumber Sari
16.13.03.2010|Krani Jaya
16.13.03.2011|Jadi Mulya I
16.13.04.1005|Bingin Teluk
16.13.04.2001|Pauh
16.13.04.2002|Batu Kucing
16.13.04.2003|Belani
16.13.04.2004|Tanjung Raja
16.13.04.2006|Mandi Angin
16.13.04.2007|Air Bening
16.13.04.2008|Beringin Sakti
16.13.04.2009|Beringin Makmur I
16.13.04.2010|Beringin Makmur II
16.13.04.2011|Pauh I
16.13.04.2012|Ketapat Bening
16.13.04.2013|Mekarsari
16.13.05.1004|Karang Dapo
16.13.05.2001|Aringin
16.13.05.2002|Biaro Baru
16.13.05.2003|Biaro Lama
16.13.05.2005|Rantau Kadam
16.13.05.2006|Kerta Sari
16.13.05.2007|Karang Dapo I
16.13.05.2008|Setia Marga
16.13.05.2009|Bina Karya
16.13.06.1009|Karang Jaya
16.13.06.2001|Bukit Ulu
16.13.06.2002|Sukaraja
16.13.06.2003|Lubuk Kumbung
16.13.06.2004|Muara Batang Empu
16.13.06.2005|Tanjung Agung
16.13.06.2006|Rantau Telang
16.13.06.2007|Suka Menang
16.13.06.2008|Terusan
16.13.06.2010|Muara Tiku
16.13.06.2011|Embacang Baru
16.13.06.2012|Embacang Lama
16.13.06.2013|Rantau Jaya
16.13.06.2014|Bukit Langkap
16.13.06.2015|Embacang Baru Ilir
16.13.07.1007|Muara Kulam
16.13.07.2001|Jangkat
16.13.07.2002|Napal Licin
16.13.07.2003|Sosokan
16.13.07.2004|Kuto Tanjung
16.13.07.2005|Muara Kuis
16.13.07.2006|Pulau Kidak
16.71.01.1001|Tiga-puluh-lima Ilir
16.71.01.1002|Tiga-puluh-dua Ilir
16.71.01.1003|Tiga-puluh Ilir
16.71.01.1004|Dua-puluh-sembilan Ilir
16.71.01.1005|Dua-puluh-delapan Ilir
16.71.01.1006|Dua-puluh-tujuh Ilir
16.71.01.1007|Kemangmanis
16.71.02.1002|Satu Ulu
16.71.02.1003|Dua Ulu
16.71.02.1004|Tiga Empat Ulu
16.71.02.1005|Lima Ulu
16.71.02.1006|Tujuh Ulu
16.71.03.1001|Sebelas Ulu
16.71.03.1002|Dua-belas Ulu
16.71.03.1003|Tiga-belas Ulu
16.71.03.1004|Empat-belas Ulu
16.71.03.1005|Enam-belas Ulu
16.71.03.1006|Tanggatakat
16.71.03.1007|Sentosa
16.71.04.1001|Bukitlama
16.71.04.1002|Lorokpakjo
16.71.04.1003|Dua-puluh-enam Ilir Satu
16.71.04.1004|Siringagung
16.71.04.1005|Demang-Lebardaun
16.71.04.1006|Bukitbaru
16.71.05.1001|Delapan-belas Ilir
16.71.05.1002|Enam-belas Ilir
16.71.05.1003|Tiga-belas Ilir
16.71.05.1004|Empat-belas Ilir
16.71.05.1005|Lima-belas Ilir
16.71.05.1006|Tujuh-belas Ilir
16.71.05.1007|Dua-puluh Ilir Tiga
16.71.05.1008|Dua-puluh Ilir Empat
16.71.05.1009|Dua-puluh Ilir Satu
16.71.05.1010|Sungaipangeran
16.71.05.1011|Kepandean-Baru
16.71.06.1005|Lima Ilir
16.71.06.1006|Tiga Ilir
16.71.06.1007|Satu Ilir
16.71.06.1008|Dua Ilir
16.71.06.1009|Lawangkidul
16.71.06.1012|Sungaibuah
16.71.07.1002|Talangbetutu
16.71.07.1004|Sukajaya
16.71.07.1005|Sukarami
16.71.07.1007|Kebunbunga
16.71.07.1009|Sukabangun
16.71.07.1010|Talangjambe
16.71.07.1011|Sukodadi
16.71.08.1001|Sukamaju
16.71.08.1002|Sako
16.71.08.1006|Sialang
16.71.08.1007|Sako Baru
16.71.09.1001|Dua-puluh Ilir Dua
16.71.09.1002|Ario Kemuning
16.71.09.1003|Sekipjaya
16.71.09.1004|Pahlawan
16.71.09.1005|Pipareja
16.71.09.1006|Talangaman
16.71.10.1001|Bukitsangkal
16.71.10.1002|Kalidoni
16.71.10.1003|Sungaiselayur
16.71.10.1004|Sungaiselincah
16.71.10.1005|Sungailais
16.71.11.1001|Sembilan-belas Ilir
16.71.11.1002|Dua-puluh-dua Ilir
16.71.11.1003|Dua-puluh-tiga Ilir
16.71.11.1004|Dua-puluh-empat Ilir
16.71.11.1005|Dua-puluh-enam Ilir
16.71.11.1006|Talangsemut
16.71.12.1001|Gandus
16.71.12.1002|Karanganyar
16.71.12.1003|Tiga-puluh-enam Ilir
16.71.12.1004|Karangjaya
16.71.12.1005|Pulokerto
16.71.13.1001|Kemasrindo
16.71.13.1002|Kemangagung
16.71.13.1003|Keramasan
16.71.13.1004|Kertapati
16.71.13.1005|Karyajaya
16.71.13.1006|Oganbaru
16.71.14.1001|Plaju Ulu
16.71.14.1002|Plaju Darat
16.71.14.1003|Plaju Ilir
16.71.14.1004|Baguskuning
16.71.14.1005|Komperta
16.71.14.1006|Talangputri
16.71.14.1007|Talangbubuk
16.71.15.1001|Alang-Alang Lebar
16.71.15.1002|Srijaya
16.71.15.1003|Talangkelapa
16.71.15.1004|Karyabaru
16.71.16.1001|Srimulya
16.71.16.1002|Sukamulya
16.71.16.1003|Lebung-Gajah
16.71.16.1005|Karyamulya
16.71.17.1001|Delapan Ulu
16.71.17.1002|Sembilan Sepuluh Ulu
16.71.17.1003|Lima-belas Ulu
16.71.17.1004|Silaberanti
16.71.17.1005|Tuankentang
16.71.18.1001|Delapan Ilir
16.71.18.1002|Sembilan Ilir
16.71.18.1003|Sepuluh Ilir
16.71.18.1004|Sebelas Ilir
16.71.18.1005|Kutobatu
16.71.18.1006|Duku
16.72.01.1001|Sukorejo
16.72.01.1002|Bangun Rejo
16.72.01.1005|Pagar Alam
16.72.01.1007|Alun Dua
16.72.01.1014|Selibar
16.72.01.1016|Beringin Jaya
16.72.01.1018|Dempo Makmur
16.72.01.1019|Kuripan Babas
16.72.01.1020|Bangun Jaya
16.72.01.1021|Curup Jare
16.72.02.1003|Sidorejo
16.72.02.1004|Nendagung
16.72.02.1005|Gunung Dempo
16.72.02.1018|Tebat Giri Indah
16.72.02.1019|Tumbak Ulas
16.72.02.1020|Ulu Rurah
16.72.02.1021|Tanjung Agung
16.72.02.1022|Besemah Serasan
16.72.03.1006|Jangkar Mas
16.72.03.1012|Bumi Agung
16.72.03.1019|Muara Siban
16.72.03.1022|Agung Lawangan
16.72.03.1023|Pagar Wangi
16.72.03.1024|Burung Dinang
16.72.03.1025|Rebah Tinggi
16.72.04.1002|Lubuk Buntak
16.72.04.1018|Prahu Dipo
16.72.04.1020|Kance Diwe
16.72.04.1021|Atung Bungsu
16.72.04.1022|Penjalang
16.72.05.1001|Karang Dalo
16.72.05.1003|Pelang Kenidai
16.72.05.1008|Jokoh
16.72.05.1011|Padang Temu
16.72.05.1012|Candi Jaya
16.73.01.1001|Air Kuti
16.73.01.1002|Majapahit
16.73.01.1003|Taba Jemekeh
16.73.01.1004|Nikan Jaya
16.73.01.1005|Taba Lestari
16.73.01.1007|Batu Urip Taba
16.73.01.1015|Taba Koji
16.73.01.1016|Watervang
16.73.02.1001|Kayu Ara
16.73.02.1002|Lubuk Tanjung
16.73.02.1003|Tanjung Indah
16.73.02.1004|Bandung Ujung
16.73.02.1008|Bandung Kiri
16.73.02.1009|Sukajadi
16.73.02.1010|Muara Enim
16.73.02.1015|Watas Lubuk Durian
16.73.02.1016|Lubuk Aman
16.73.02.1018|Tanjung Aman
16.73.02.1019|Pelita Jaya
16.73.03.1001|Lubuk Kupang
16.73.03.1003|Rahmah
16.73.03.1008|Jukung
16.73.03.1009|Air Kati
16.73.03.1010|Air Teman
16.73.03.1011|Perumnas Rahmah
16.73.03.1012|Lubuk Binjai
16.73.04.1001|Durian Rampak
16.73.04.1002|Tanjung Raya
16.73.04.1003|Sumber Agung
16.73.04.1004|Marga Bakti
16.73.04.1005|Belalau I
16.73.04.1006|Belalau II
16.73.04.1007|Taba Baru
16.73.04.1008|Margorejo
16.73.04.1009|Petanang Ulu
16.73.04.1010|Petanang Ilir
16.73.05.1001|Jawa Kanan
16.73.05.1002|Jawa Kanan SS
16.73.05.1003|Wira Karya
16.73.05.1004|Dempo
16.73.05.1005|Jawa Kiri
16.73.05.1006|Karya Bakti
16.73.05.1007|Mesat Jaya
16.73.05.1008|Mesat Seni
16.73.05.1009|Cereme Taba
16.73.06.1001|Sidorejo
16.73.06.1002|Ulak Lebar
16.73.06.1003|Tapak Lebar
16.73.06.1004|Bandung Kanan
16.73.06.1005|Keputraan
16.73.06.1006|Lubuklinggau Ilir
16.73.06.1007|Lubuklinggau Ulu
16.73.06.1008|Pasar Permiri
16.73.07.1001|Tanah Periuk
16.73.07.1002|Simpang Periuk
16.73.07.1003|Karang Ketuan
16.73.07.1004|Siring Agung
16.73.07.1005|Eka Marga
16.73.07.1006|Marga Mulya
16.73.07.1007|Marga Rahayu
16.73.07.1008|Taba Pingin
16.73.07.1009|Moneng Sepati
16.73.08.1001|Batu Urip
16.73.08.1002|Ulak Surung
16.73.08.1003|Kenanga
16.73.08.1004|Pasar Satelit
16.73.08.1005|Senalang
16.73.08.1006|Megang
16.73.08.1007|Jogoboyo
16.73.08.1008|Puncak Kemuning
16.73.08.1009|Ponorogo
16.73.08.1010|Kali Serayu
16.74.01.1001|Prabumulih
16.74.01.1007|Patih Galung
16.74.01.1009|Muntang Tapus
16.74.01.1011|Gunung Kemala
16.74.01.1012|Payuputat
16.74.01.1014|Tebing Tanah Puteh
16.74.01.2013|Tanjung Telang
16.74.02.1003|Karang Raja
16.74.02.1004|Tugu Kecil
16.74.02.1005|Prabu Jaya
16.74.02.1006|Muara Dua
16.74.02.1007|Gunung Ibul
16.74.02.1008|Gunung Ibul Barat
16.74.02.1009|Sukajadi
16.74.02.1010|Karang Jaya
16.74.02.1011|Muara Dua Barat
16.74.02.1012|Gunung Ibul Timur
16.74.02.1013|Gunung Ibul Selatan
16.74.02.1014|Gunung Ibul Utara
16.74.02.1015|Arimbi Jaya
16.74.03.1001|Cambai
16.74.03.1002|Sindur
16.74.03.1005|Sungai Medang
16.74.03.2003|Pangkul
16.74.03.2004|Muara Sungai
16.74.04.1001|Tanjung Rambang
16.74.04.2003|Karya Mulya
16.74.04.2005|Rambang Senuling
16.74.04.2006|Jungai
16.74.04.2007|Talang Batu
16.74.04.2008|Karangan
16.74.04.2009|Karang Bindu
16.74.04.2010|Sinar Rambang
16.74.04.2011|Kemang Tanduk
16.74.05.1001|Pasar Prabumulih I
16.74.05.1002|Pasar Prabumulih II
16.74.05.1003|Wonosari
16.74.05.1004|Mangga Besar
16.74.05.1005|Anak Petai
16.74.05.1006|Sidomulyo
16.74.05.1007|Sidogede
16.74.06.1001|Majasari
16.74.06.1002|Tanjung Raman
16.74.06.1003|Sukaraja
16.74.06.2004|Tanjung Menang
17.01.01.2001|Batu Ampar
17.01.01.2002|Rantau Sialang
17.01.01.2003|Bumi Agung
17.01.01.2004|Palak Siring
17.01.01.2005|Keban Agung I
17.01.01.2006|Keban Agung II
17.01.01.2007|Tanjung Alam
17.01.01.2008|Tanjung Negara
17.01.01.2009|Keban Agung III
17.01.01.2010|Suka Nanti
17.01.01.2011|Muara Tiga
17.01.01.2012|Tanjung Besar
17.01.01.2013|Pajar Bulan
17.01.01.2014|Durian Sebatang
17.01.01.2015|Lawang Agung
17.01.01.2027|Nanti Agung
17.01.01.2028|Karang Agung
17.01.01.2029|Lubuk Resam
17.01.01.2030|Muara Tiga Ilir
17.01.02.1024|Pasar Baru
17.01.02.2001|Padang Lebar
17.01.02.2002|Sukaraja
17.01.02.2004|Tanjung Menang
17.01.02.2005|Darat Sawah
17.01.02.2006|Kota Agung
17.01.02.2007|Babatan Ilir
17.01.02.2008|Babatan Ulu
17.01.02.2009|Muara Danau
17.01.02.2011|Gunung Ayu
17.01.02.2014|Muara Pulutan
17.01.02.2015|Kota Bumi Baru
17.01.02.2016|Sindang Bulan
17.01.02.2017|Muara Payang
17.01.02.2018|Durian Seginim
17.01.02.2020|Banding Agung
17.01.02.2021|Pajar Bulan
17.01.02.2022|Dusun Tengah
17.01.02.2023|Padang Siring
17.01.02.2029|Darat Sawah Ulu
17.01.02.2030|Tanjung Agung
17.01.02.2031|Dusun Baru
17.01.03.1018|Masat
17.01.03.2001|Tanjung Aur I
17.01.03.2002|Anggut
17.01.03.2003|Tanjung Eran
17.01.03.2004|Padang Lebar
17.01.03.2005|Gedung Agung
17.01.03.2015|Batu Bandung
17.01.03.2016|Ulak Lebar
17.01.03.2017|Kota Bumi
17.01.03.2019|Air Umban
17.01.03.2020|Sebilo
17.01.03.2021|Ganjuh
17.01.03.2022|Puding
17.01.03.2023|Padang Tambak
17.01.03.2024|Padang Mumpo
17.01.03.2025|Beringin Datar
17.01.04.1022|Kayu Kunyit
17.01.04.2001|Tanjung Raman
17.01.04.2016|Tanjung Besar
17.01.04.2017|Manggul
17.01.04.2018|Terulung
17.01.04.2019|Ketaping
17.01.04.2020|Lubuk Sirih Ulu
17.01.04.2021|Lubuk Sirih Ilir
17.01.04.2023|Kota Padang
17.01.04.2024|Mela'o
17.01.04.2025|Gunung Sakti
17.01.04.2026|Jeranglah Rendah
17.01.04.2027|Jeranglah Tinggi
17.01.04.2028|Kembang Ayun
17.01.04.2029|Tambangan
17.01.04.2031|Padang Manis
17.01.04.2032|Padang Pandan
17.01.04.2033|Gunung Kembang
17.01.05.1009|Gunung Ayu
17.01.05.1010|Kota Medan
17.01.05.1016|Kampung Baru
17.01.05.1017|Pasar Baru
17.01.05.1019|Ibul
17.01.05.1020|Padang Kapuk
17.01.05.2001|Pagar Dewa
17.01.05.2004|Padang Niur
17.01.05.2005|Tebat Kubu
17.01.05.2006|Gelumbang
17.01.05.2018|Padang Berangin
17.01.06.2001|Selali
17.01.06.2002|Air Kemang
17.01.06.2003|Pasar Pino
17.01.06.2004|Tanggo Raso
17.01.06.2005|Talang Padang
17.01.06.2006|Tungkal I
17.01.06.2007|Tungkal II
17.01.06.2008|Bandung Ayu
17.01.06.2009|Napal Melintang
17.01.06.2010|Serang Bulan
17.01.06.2011|Suka Bandung
17.01.06.2012|Pagar Gading
17.01.06.2013|Cinto Mandi
17.01.06.2014|Kembang Seri
17.01.06.2015|Karang Cayo
17.01.06.2016|Tanjung Aur II
17.01.06.2017|Nanjungan
17.01.06.2018|Kemang Manis
17.01.06.2019|Padang Beriang
17.01.06.2020|Padang Serasan
17.01.06.2021|Telaga Dalam
17.01.07.2001|Karang Caya
17.01.07.2002|Betungan
17.01.07.2003|Pagar Banyu
17.01.07.2004|Nanjungan
17.01.07.2005|Suka Rami
17.01.07.2006|Padang Bindu
17.01.07.2007|Penindaian
17.01.07.2008|Limus
17.01.07.2009|Sukaraja
17.01.07.2010|Lubuk Ladung
17.01.07.2011|Air Sulau
17.01.07.2012|Suka Jaya
17.01.08.2001|Keban Jati
17.01.08.2002|Tanjung Beringin
17.01.08.2003|Suka Negeri
17.01.08.2004|Sukarami
17.01.08.2005|Palak Bengkerung
17.01.08.2006|Sukamaju
17.01.08.2007|Pino Baru
17.01.08.2008|Penandingan
17.01.08.2009|Suka Bandung
17.01.08.2010|Maras
17.01.09.2001|Batu Panco
17.01.09.2002|Batu Kuning
17.01.09.2003|Bandar Agung
17.01.09.2004|Merambung
17.01.09.2005|Simpang Pino
17.01.09.2006|Talang Tinggi
17.01.09.2007|Keban Jati
17.01.09.2008|Lubuk Tapi
17.01.09.2009|Kayu Ajaran
17.01.09.2010|Air Tenam
17.01.10.2001|Tumbuk Tebing
17.01.10.2002|Gunung Kayo
17.01.10.2003|Gindo Suli
17.01.10.2004|Talang Indah
17.01.10.2005|Kuripan
17.01.10.2006|Padang Nibung
17.01.10.2007|Tanjung Tebat
17.01.10.2008|Padang Jawi
17.01.10.2009|Tanjung Aur
17.01.10.2010|Padang Burnai
17.01.11.1003|Tanjung Mulia
17.01.11.1004|Pasar Mulia
17.01.11.1005|Belakang Gedung
17.01.11.1006|Gunung Mesir
17.01.11.1007|Padang Sialang
17.01.11.1008|Ketapang Besar
17.01.11.1009|Pasar Bawah
17.01.11.2001|Batu Kuning
17.01.11.2002|Batu Lambang
17.02.06.1004|Kota Padang
17.02.06.1015|Bedeng SS
17.02.06.1016|Dusun Baru
17.02.06.2001|Derati
17.02.06.2002|Taba Anyar
17.02.06.2003|Suka Rami
17.02.06.2005|Lubuk Mumpo
17.02.06.2006|Durian Mas
17.02.06.2018|Kota Padang Baru
17.02.06.2020|Tanjung Gelang
17.02.07.1011|Pasar PU Tanding
17.02.07.2001|Karang Baru
17.02.07.2007|Guru Agung
17.02.07.2008|Belumai II
17.02.07.2009|Belumai I
17.02.07.2010|Ulak Tanding
17.02.07.2012|Tanjung Sanai I
17.02.07.2013|Muara Telita
17.02.07.2014|Ujan Panas
17.02.07.2021|Taba Tinggi
17.02.07.2022|Tanjung Sanai II
17.02.07.2025|Taktoi
17.02.07.2026|Kasie Kasubun
17.02.07.2027|Air Kati
17.02.07.2028|Bukit Batu
17.02.08.1006|Beringin Tiga
17.02.08.2001|Sindang Jaya
17.02.08.2002|Sindang Jati
17.02.08.2003|Belitar Muka
17.02.08.2004|Pelalo
17.02.08.2005|Kayu Manis
17.02.08.2009|Air Dingin
17.02.08.2011|Belitar Seberang
17.02.08.2013|Cahaya Negeri
17.02.08.2014|Tanjung Aur
17.02.09.1012|Dwi Tunggal
17.02.09.1013|Air Putih Lama
17.02.09.1023|Adirejo
17.02.09.1025|Air Rambai
17.02.09.1026|Pasar Baru
17.02.09.1027|Pasar Tengah
17.02.09.1031|Jalan Baru
17.02.09.1033|Talang Benih
17.02.09.1047|Timbul Rejo
17.02.10.2001|Air Mundu
17.02.10.2002|Tebat Tenong Dalam
17.02.10.2003|Baru Manis
17.02.10.2012|Kampung Melayu
17.02.10.2013|Sentral Baru
17.02.10.2015|Kampung Sajad
17.02.10.2016|Suka Rami
17.02.10.2017|Pagar Gunung
17.02.10.2018|Selamat Sudiarjo
17.02.10.2019|Purwodadi
17.02.10.2020|Air Pikat
17.02.10.2021|Tebat Pulau
17.02.11.1004|Air Duku
17.02.11.1006|Cawang Baru
17.02.11.1008|Simpang Nangka
17.02.11.2001|Air Putih Kali Bandung
17.02.11.2002|Air Meles Atas
17.02.11.2003|Sambirejo
17.02.11.2005|Suban Ayam
17.02.11.2007|Cawang Lama
17.02.11.2009|Sumber Urip
17.02.11.2010|Sumber Bening
17.02.11.2011|Karang Jaya
17.02.11.2012|Kayu Manis
17.02.11.2013|Kampung Baru
17.02.11.2014|Kali Padang
17.02.11.2015|Mojorejo
17.02.11.2016|Talang Lahat
17.02.16.1001|Dusun Curup
17.02.16.1002|Tunas Harapan
17.02.16.2003|Batu Dewa
17.02.16.2004|Perbo
17.02.16.2005|Batu Panco
17.02.16.2006|Dusun Sawah
17.02.16.2007|Lubuk Kembang
17.02.16.2008|Suka Datang
17.02.16.2009|Tabarenah
17.02.16.2010|Pahlawan
17.02.16.2011|Tasik Malaya
17.02.16.2012|Tanjung Beringin
17.02.16.2013|Kota Pagu
17.02.16.2014|Seguring
17.02.17.1001|Sukaraja
17.02.17.1002|Kesambe Baru
17.02.17.1003|Karang Anyar
17.02.17.1004|Talang Ulu
17.02.17.2005|Duku Ulu
17.02.17.2006|Duku Ilir
17.02.17.2007|Air Meles Bawah
17.02.17.2008|Kampung Delima
17.02.17.2009|Kesambe Lama
17.02.18.1001|Air Putih Baru
17.02.18.1002|Tempel Rejo
17.02.18.2003|Rimbo Recap
17.02.18.2004|Watas Marga
17.02.18.2005|Teladan
17.02.18.2006|Suka Marga
17.02.18.2007|Lubuk Ubar
17.02.18.2008|Pungguk Lalang
17.02.18.2009|Turan Baru
17.02.18.2010|Tanjung Dalam
17.02.18.2011|Air Lanang
17.02.19.1001|Kepala Siring
17.02.19.1002|Talang Rimbo Baru
17.02.19.1003|Talang Rimbo Lama
17.02.19.1004|Siderejo
17.02.19.1005|Kampung Jawa
17.02.19.1006|Air Bang
17.02.19.1007|Pelabuhan Baru
17.02.19.1008|Batu Galing
17.02.19.1009|Banyu Mas
17.02.19.2010|Air Merah
17.02.20.2001|Kepala Curup
17.02.20.2002|Kampung Jeruk
17.02.20.2003|Simpang Beliti
17.02.20.2004|Taba Padang
17.02.20.2005|Air Apo
17.02.21.2001|Apur
17.02.21.2002|Lawang Agung
17.02.21.2003|Lubuk Alai
17.02.21.2004|Karang Pinang
17.02.21.2005|Tanjung Agung
17.02.21.2006|Pengambang
17.02.21.2007|Jabi
17.02.21.2008|Tanjung Herang
17.02.21.2009|Air Nau
17.02.22.2001|IV Suko Menanti
17.02.22.2002|Air Rusa
17.02.22.2003|Bengko
17.02.22.2004|Sinar Gunung
17.02.22.2005|Warung Pojok
17.02.22.2006|Talang Belitar
17.02.23.2001|Merantau
17.02.23.2002|Periang
17.02.23.2003|Balai Buntar
17.02.23.2004|LubukTunjung
17.02.23.2005|LB. Belimbing I
17.02.23.2006|LB Belimbing II
17.02.23.2007|LB. Bingin Baru
17.02.23.2008|Sari Pulau
17.02.23.2009|Suka Merindu
17.02.23.2010|Suka karya
17.02.24.2001|Dataran Tapus
17.02.24.2002|Bandung Marga
17.02.24.2003|Pal Seratus
17.02.24.2004|Pal VII
17.02.24.2005|Pal VIII
17.02.24.2006|Tebat Tenong Luar
17.02.24.2007|Bangun Jaya
17.02.24.2008|Babakan Baru
17.02.24.2009|Sumberejo Transad
17.02.24.2010|Air Bening
17.03.01.2001|Banjar Sari
17.03.01.2002|Meok
17.03.01.2003|Malakoni
17.03.01.2004|Kaana
17.03.01.2005|Kahyapu
17.03.01.2006|Apoho
17.03.06.1009|Lubuk Durian
17.03.06.2001|Talang Jambu
17.03.06.2002|Tebat Pacur
17.03.06.2003|Talang Curup
17.03.06.2004|Banyu Mas Lama
17.03.06.2005|Salam Harjo
17.03.06.2006|Jogja Baru
17.03.06.2007|Talang Pasak
17.03.06.2008|Perbo
17.03.06.2010|Lubuk Jale
17.03.06.2011|Simpang Ketenong
17.03.06.2012|Aur Gading
17.03.06.2024|Kedu Baru
17.03.06.2026|Serumbung
17.03.06.2027|Magelang
17.03.06.2028|Tanjung Putus
17.03.06.2029|Penyangkak
17.03.06.2031|Banyu Mas Baru
17.03.07.1026|Purwodadi
17.03.07.1027|Gunung Alam
17.03.07.2001|Tanjung Raman
17.03.07.2002|Lubuk Saung
17.03.07.2003|Kuro Tidur
17.03.07.2004|Karang Suci
17.03.07.2005|Rama Agung
17.03.07.2008|Talang Denau
17.03.07.2009|Gunung Selan
17.03.07.2010|Datar Ruyung
17.03.07.2011|Senali
17.03.07.2012|Gunung Agung
17.03.07.2014|Sidourip
17.03.07.2015|Karang Anyar I
17.03.07.2016|Taba Tembilang
17.03.07.2022|Karang Anyar II
17.03.08.2001|Tanjung Anom
17.03.08.2002|Suka Makmur
17.03.08.2003|Wono Harjo
17.03.08.2004|Giri Mulya
17.03.08.2005|Rena Jaya
17.03.08.2006|Suka Mulya
17.03.09.2001|Lubuk Banyau
17.03.09.2002|Talang Tua
17.03.09.2003|Marga Sakti
17.03.09.2004|Tanjung Harapan
17.03.09.2005|Padang Jaya
17.03.09.2006|Arga Mulya
17.03.09.2007|Sidomukti
17.03.09.2008|Marga Jaya
17.03.09.2009|Tanah Hitam
17.03.09.2010|Tambak Rejo
17.03.09.2011|Sido Luhur
17.03.09.2012|Tanah Tinggi
17.03.10.1010|Pasar Lais
17.03.10.2008|Datar Lebar
17.03.10.2009|Air Padang
17.03.10.2011|Durian Daun
17.03.10.2012|Dusun Raja
17.03.10.2013|Lubuk Lesung
17.03.10.2014|Pal 30
17.03.10.2015|Jagobayo
17.03.10.2017|Talang Rasau
17.03.10.2018|Lubuk Gedang
17.03.10.2019|Suka Langu
17.03.10.2020|Taba Baru
17.03.10.2021|Kalbang
17.03.11.2001|Serangai
17.03.11.2002|Selolong
17.03.11.2003|Air Lakok
17.03.11.2004|Bintunan
17.03.11.2005|Suka Marga
17.03.11.2006|Batik Nau
17.03.11.2007|Pagar Ruyung
17.03.11.2008|Durian Amparan
17.03.11.2009|Taba Kulintang
17.03.11.2010|Ulak Tanding
17.03.11.2011|Seberang Tunggal
17.03.11.2012|Sekiau
17.03.11.2013|Samban Jaya
17.03.11.2014|Peninjau
17.03.11.2015|Air Manganyau
17.03.12.2001|Urai
17.03.12.2002|Pasar Ketahun
17.03.12.2003|Giri Kencana
17.03.12.2004|Kuala Langi
17.03.12.2005|Dusun Raja
17.03.12.2012|Lubuk Mindai
17.03.12.2013|Pajar Baru
17.03.12.2014|Talang Baru
17.03.12.2019|Melati Harjo K.1
17.03.12.2020|Bukit Indah
17.03.12.2021|Bukit Tinggi
17.03.13.2003|Tanjung Alai
17.03.13.2004|Jabi
17.03.13.2005|Napal Putih
17.03.13.2006|Air Tenang
17.03.13.2007|Teluk Anggung
17.03.13.2008|Tanjung Kemayan
17.03.13.2009|Muara Santan
17.03.13.2016|Lebong Tandai
17.03.13.2019|Gembung Raya
17.03.13.2020|Kinal Jaya
17.03.14.2007|Talang Arah
17.03.14.2008|Pasar Sebelat
17.03.14.2009|Kota Bani
17.03.14.2013|Air Muring
17.03.14.2014|Air Pandan
17.03.14.2015|Cipta Mulya
17.03.14.2017|Air Petai
17.03.14.2018|Karang Tengah
17.03.14.2019|Karang Pulau
17.03.15.2003|Genting Perangkap
17.03.15.2004|Lubuk Balam
17.03.15.2005|Datar Macang
17.03.15.2006|Tanjung Genting
17.03.15.2007|Talang Renah
17.03.15.2008|Kota Agung
17.03.15.2009|Talang Lembak
17.03.15.2010|Kertapati
17.03.15.2011|Talang Pungguk
17.03.15.2012|Talang Baru Ginting
17.03.15.2013|Tanjung Karet
17.03.15.2014|Talang Ginting
17.03.15.2015|Sungai Pura
17.03.15.2016|Dusun Curup
17.03.15.2017|Penyangkak
17.03.16.2001|Pasar Bembah
17.03.16.2002|Tepi Laut
17.03.16.2003|Pasar Kerkap
17.03.16.2005|Air Napal
17.03.16.2006|Talang Kering
17.03.16.2007|Selubuk
17.03.16.2008|Pasar Tebat
17.03.16.2009|Lubuk Tanjung
17.03.16.2011|Pukur
17.03.16.2014|Pasar Palik
17.03.16.2015|Tebing Kandang
17.03.16.2016|Talang Jarang
17.03.19.2001|Kota Lekat
17.03.19.2002|Padang Bendar
17.03.19.2003|Taba Padang R
17.03.19.2004|Taba Padang Kol
17.03.19.2005|Air Banai
17.03.19.2006|Batu Raja R
17.03.19.2007|Batu Raja Kol
17.03.19.2008|Batu Layang
17.03.19.2009|Batu Roto
17.03.19.2010|Air Ba'us I
17.03.19.2011|Air Ba'us II
17.03.19.2012|Pematang Balam
17.03.19.2013|Talang Rendah
17.03.19.2014|Sumber Rejo
17.03.19.2015|Kota Lekat Mudik
17.03.20.2001|Padang Kala
17.03.20.2002|Kembang Manis
17.03.20.2003|Teluk Ajang
17.03.20.2004|Balam
17.03.20.2005|Suka Rami
17.03.20.2006|Mesigit
17.03.20.2007|Retes
17.03.20.2008|Lubuk Mumpo
17.03.20.2009|Talang Ulu
17.03.20.2010|Tanjung Aur
17.03.21.1001|Kemumu
17.03.21.2002|Tebing Kaning
17.03.21.2003|Sidodadi
17.03.21.2004|Sumber Agung
17.03.21.2005|Pematang Sapang
17.03.21.2006|Pagar Banyu
17.03.21.2007|Gardu
17.03.21.2008|Kali
17.03.21.2009|Kalai Duai
17.03.21.2010|Pagar Ruyung
17.03.21.2011|Air Merah
17.03.21.2012|Gunung Besar
17.03.22.2001|Sengkuang
17.03.22.2002|Lubuk Pendam
17.03.22.2003|Alun Dua
17.03.22.2004|Ketapi
17.03.22.2005|Lubuk Semantung
17.03.22.2006|Sawang Lebar
17.03.22.2007|Sawang Lebar Ilir
17.03.22.2008|Lubuk Gading
17.03.22.2009|Tanjung Agung
17.03.22.2010|Padang Sepan
17.03.23.2001|Air Lelangi
17.03.23.2002|Bukit Berlian
17.03.23.2003|Tanjung Dalam
17.03.23.2004|Bukit Sari
17.03.23.2005|Pagardin
17.03.23.2006|Tanjung Harapan
17.03.23.2007|Tanjung Sari
17.03.23.2008|Bangun Karya
17.03.23.2009|Pondok Bakil
17.03.23.2010|Talang Berantai
17.03.24.2001|Air Sebayur
17.03.24.2002|Air Sekamanak
17.03.24.2003|Air Simpang
17.03.24.2004|Bukit Makmur
17.03.24.2005|Marga Bhakti
17.03.24.2006|Bumi Harjo
17.03.24.2007|Sumber Mulya
17.03.24.2008|Gunung Payung
17.03.24.2009|Bukit Harapan
17.03.24.2010|Tanjung Muara
17.03.25.2001|Air Putih
17.03.25.2002|Suka Makmur
17.03.25.2003|Karya Pelita
17.03.25.2004|Suka Maju
17.03.25.2005|Suka Baru
17.03.25.2006|Suka Merindu
17.03.25.2007|Suka Medan
17.03.25.2008|Karya Bakti
17.03.25.2009|Karya Jaya
17.03.25.2010|Suka Negara
17.04.01.2001|Gedung Wani
17.04.01.2002|Penandingan
17.04.01.2003|Geramat
17.04.01.2004|Tanjung Alam
17.04.01.2005|Tanjung Baru
17.04.01.2006|Pengurung
17.04.01.2007|Pinang Jawa
17.04.01.2008|Gunung Terang
17.04.01.2009|Talang Padang
17.04.01.2010|Gunung Megang
17.04.01.2020|Talang Berangin
17.04.01.2021|Jawi
17.04.01.2022|Papahan
17.04.01.2023|Pinang Jawa II
17.04.02.2002|Tinggi Ari
17.04.02.2003|Tanjung Aur
17.04.02.2004|Aur Ringit
17.04.02.2008|Pelajaran
17.04.02.2009|Tanjung Kemuning
17.04.02.2010|Selika
17.04.02.2011|Tanjung Iman
17.04.02.2012|Padang Leban
17.04.02.2013|Beriang Tinggi
17.04.02.2014|Tanjung Bulan
17.04.02.2015|Pelajaran II
17.04.02.2016|Selika II
17.04.02.2017|Sulauwangi
17.04.02.2018|Padang Kedondong
17.04.02.2020|Padang Tinggi
17.04.02.2021|Tanjung Kemuning II
17.04.02.2022|Tanjung Kemuning III
17.04.02.2023|Tanjung Aur II
17.04.02.2024|Tanjung Iman II
17.04.02.2025|Selika III
17.04.03.1010|Simpang Tiga
17.04.03.2001|Tanjung Betung
17.04.03.2003|Padang Manis
17.04.03.2006|Guru Agung
17.04.03.2009|Gunung Agung
17.04.03.2021|Bandu Agung
17.04.03.2027|Tanjung Betung II
17.04.03.2028|Coko Enau
17.04.03.2029|Pancur Negara
17.04.03.2030|Perugaian
17.04.03.2031|Guru Agung II
17.04.04.1007|Tanjung Iman
17.04.04.2001|Sukarami
17.04.04.2002|Pajar Bulan
17.04.04.2003|Padang Hangat
17.04.04.2004|Kemang Manis
17.04.04.2005|Penyandingan
17.04.04.2006|Sinar Jaya
17.04.04.2008|Tanjung Pandan
17.04.04.2009|Padang Baru
17.04.05.1013|Bandar Bintuhan
17.04.05.2009|Sekunyit
17.04.05.2010|Suka Bandung
17.04.05.2011|Air Dingin
17.04.05.2012|Pasar Baru
17.04.05.2014|Pasar Lama
17.04.05.2015|Gedung Sako
17.04.05.2016|Jembatan Dua
17.04.05.2017|Tanjung Besar
17.04.05.2021|Pengubaian
17.04.05.2022|Pahlawan Ratu
17.04.05.2023|Pasar Saoh
17.04.05.2024|Kepala Pasar
17.04.05.2025|Padang Petron
17.04.05.2026|Sawah Jangkung
17.04.05.2027|Selasih
17.04.05.2028|Padang Genting
17.04.05.2029|Gedung Sako II
17.04.05.2030|Sinar Pagi
17.04.06.2001|Parda Suka
17.04.06.2002|Air Long
17.04.06.2003|Linau
17.04.06.2004|Way Hawang
17.04.06.2005|Tanjung Baru
17.04.06.2006|Tanjung Ganti
17.04.06.2007|Kedataran
17.04.06.2008|Tanjung Aur
17.04.06.2009|Penyandingan
17.04.06.2010|Suka Menanti
17.04.06.2012|Benteng Harapan
17.04.06.2013|Bakal Makmur
17.04.06.2014|Muara Jaya
17.04.06.2015|Tanjung Agung
17.04.06.2016|Arga Mulya
17.04.06.2017|Air Jelatang
17.04.06.2019|Sumber Harapan
17.04.06.2020|Tanjung Beringin
17.04.06.2021|Sinar Mulya
17.04.07.2001|Muara Dua
17.04.07.2002|Gedung Menung
17.04.07.2003|Ulak Pandan
17.04.07.2005|Merpas
17.04.07.2007|Tanjung Betuah
17.04.07.2008|Air Palawan
17.04.07.2009|Tebing Rambutan
17.04.07.2010|Batu Lungun
17.04.07.2011|Sumber Harapan
17.04.07.2012|Suku Tiga
17.04.07.2013|Bukit Indah
17.04.07.2014|Suka Jaya
17.04.07.2015|Pasar Baru
17.04.07.2016|Tri Jaya
17.04.07.2017|Air Batang
17.04.07.2018|Sinar Banten
17.04.07.2019|Pasar Jum'at
17.04.08.2001|Bunga Melur
17.04.08.2002|Karang Dapo
17.04.08.2003|Lubuk Gung
17.04.08.2004|Gunung Tiga
17.04.08.2005|Suka Merindu
17.04.08.2006|Mentiring
17.04.08.2007|Cahaya Batin
17.04.08.2008|Awat Mata
17.04.08.2009|Nusuk
17.04.08.2010|Tanjung Harapan
17.04.08.2011|Gunung Tiga II
17.04.08.2012|Padang Panjang
17.04.08.2013|Masria Baru
17.04.09.2001|Tanjung Ganti I
17.04.09.2002|Tanjung Ganti II
17.04.09.2003|Rigangan I
17.04.09.2004|Rigangan II
17.04.09.2005|Rigangan III
17.04.09.2006|Sukarami
17.04.09.2007|Darat Sawah
17.04.09.2008|Siring Agung
17.04.09.2009|Penantian
17.04.09.2010|Talang Tais
17.04.09.2011|Pagar Dewa
17.04.09.2012|Talang Marap
17.04.09.2013|Suka Rami II
17.04.10.2001|Bangun Jiwa
17.04.10.2002|Cahaya Negeri
17.04.10.2003|Padang Jati
17.04.10.2004|Ganda Suli
17.04.10.2005|Durian Besar
17.04.10.2006|Tanjung Beringin
17.04.10.2007|Umbul
17.04.10.2008|Benua Ratu
17.04.10.2009|Tuguk
17.04.10.2010|Kepahyang
17.04.10.2011|Pulau Panggung
17.04.10.2012|Serdang Indah
17.04.11.2001|Muara Sahung
17.04.11.2002|Tri Tunggal Bakti
17.04.11.2003|Ulak Lebar
17.04.11.2004|Sumber Makmur
17.04.11.2005|Ulak Bandung
17.04.11.2006|Cinta Makmur
17.04.11.2007|Bukit Makmur
17.04.12.2001|Suka Banjar
17.04.12.2002|Tanjung Bunga
17.04.12.2003|Cucupan
17.04.12.2004|Pagar Dewa
17.04.12.2005|Tanjung Agung
17.04.12.2006|Babat
17.04.12.2007|Kepahyang
17.04.12.2008|Tanjung Dalam
17.04.12.2009|Muara Tetap
17.04.12.2010|Kasuk Baru
17.04.12.2011|Padang Binjai
17.04.12.2012|Suka Raja
17.04.13.2001|Datar Lebar
17.04.13.2002|Tanjung Bunian
17.04.13.2003|Sinar Bulan
17.04.13.2004|Sukananti
17.04.13.2005|Lawang Agung
17.04.13.2006|Tanjung Kurung
17.04.13.2007|Senak
17.04.13.2008|Datar Lebar II
17.04.13.2009|Aur Gading
17.04.14.2001|Pulau Panggung
17.04.14.2002|Talang Besar
17.04.14.2003|Talang Jawi I
17.04.14.2004|Talang Jawi II
17.04.14.2005|Air Kering
17.04.14.2006|Gunung Kaya
17.04.14.2007|Ulak Agung
17.04.14.2008|Talang Padang
17.04.14.2009|Air Kering II
17.04.15.2001|Naga Rantai
17.04.15.2002|Bungin Tambun
17.04.15.2003|Bungin Tambun II
17.04.15.2004|Bungin Tambun III
17.04.15.2005|Manau IX
17.04.15.2006|Manau IX Dua
17.04.15.2007|Pagar Alam
17.04.15.2008|Pagar Gunung
17.04.15.2009|Coko Betung
17.04.15.2010|Marga Mulyo
17.04.15.2011|Jati Mulyo
17.05.01.1001|Babatan
17.05.01.1025|Sukaraja
17.05.01.2002|Niur
17.05.01.2003|Lubuk Sahung
17.05.01.2011|Bukit Peninjauan I
17.05.01.2026|Padang Pelawi
17.05.01.2027|Kayu Arang
17.05.01.2028|Jenggalu
17.05.01.2029|Cahaya Negeri
17.05.01.2030|Bukit Peninjauan II
17.05.01.2032|Riak Siabun
17.05.01.2033|Padang Kuas
17.05.01.2034|Kuti Agung
17.05.01.2035|Riak Siabun I
17.05.01.2036|Sido Luhur
17.05.01.2037|Sumber Arung
17.05.01.2038|Sido Sari
17.05.01.2039|Sari Mulyo
17.05.01.2043|Air Kemuning
17.05.01.2044|Sumber Makmur
17.05.01.2045|Air Petai
17.05.02.1009|Lubuk Kebur
17.05.02.1010|Pasar Tais
17.05.02.1011|Lubuk Lintang
17.05.02.1012|Talang Saling
17.05.02.1013|Dusun Baru
17.05.02.1014|Talang Dantuk
17.05.02.1024|Napal
17.05.03.1014|Masmambang
17.05.03.2002|Napal Melintang
17.05.03.2003|Serambi Gunung
17.05.03.2005|Air Payangan
17.05.03.2012|Batu Tugu
17.05.03.2013|Kampai
17.05.03.2015|Lubuk Ngantungan
17.05.03.2016|Durian Bubur
17.05.03.2017|Muara Danau
17.05.03.2018|Lubuk Gio
17.05.03.2019|Kembang Seri
17.05.03.2034|Bunut Tinggi
17.05.03.2035|Air Teras
17.05.03.2036|Lubuk Gadis
17.05.03.2045|Simpang Tiga Pagar Gasing
17.05.03.2046|Harapan Mulya
17.05.04.1005|Pajar Bulan
17.05.04.2001|Maras Jauh
17.05.04.2002|Bandung Agung
17.05.04.2003|Pinju Layang
17.05.04.2004|Nanjungan
17.05.04.2006|Petai Kayu
17.05.04.2007|Napalan
17.05.04.2008|Renah Gajah Mati I
17.05.04.2009|Renah Gajah Mati II
17.05.04.2010|Cugung Langu
17.05.04.2011|Rantau Panjang
17.05.04.2012|Air Melancar
17.05.04.2013|Muara Dua
17.05.04.2014|Nanti Agung
17.05.04.2015|Talang Durian
17.05.04.2016|Gunung Mesir
17.05.04.2017|Kayu Elang
17.05.04.2018|Padang Serunaian
17.05.04.2019|Tebat Gunung
17.05.04.2020|Mekar Sari Mukti
17.05.04.2021|Kemang Manis
17.05.04.2022|Gunung Megang
17.05.04.2023|Telatan
17.05.04.2024|Suban
17.05.05.1005|Kembang Mumpo
17.05.05.2001|Sendawar
17.05.05.2002|Gelombang
17.05.05.2003|Lubuk Betung
17.05.05.2004|Padang Peri
17.05.05.2006|Karang Anyar
17.05.05.2007|Ujung Padang
17.05.05.2008|Ketapang Baru
17.05.05.2009|Tedunan
17.05.05.2010|Talang Alai
17.05.05.2011|Padang Bakung
17.05.05.2012|Jambat Akar
17.05.05.2013|Gunung Kembang
17.05.05.2014|Gunung Bantan
17.05.05.2015|Maras Tengah
17.05.05.2016|Padang Kelapa
17.05.05.2017|Pematang Riding
17.05.05.2018|Talang Beringin
17.05.05.2019|Genting Juar
17.05.05.2020|Muara Maras
17.05.05.2021|Rimbo Besak
17.05.05.2022|Muara Timput
17.05.05.2023|Serian Bandung
17.05.05.2024|Talang Kemang
17.05.05.2025|Maras Bantan
17.05.05.2026|Karang Dapo
17.05.06.1006|Dermayu
17.05.06.2001|Sukamaju
17.05.06.2002|Talang Alai
17.05.06.2003|Talang Benuang
17.05.06.2004|Padang Pelasan
17.05.06.2005|Air Periukan
17.05.06.2007|Keban Agung
17.05.06.2008|Pasar Ngalam
17.05.06.2009|Sukasari
17.05.06.2010|Kungkai Baru
17.05.06.2011|Tawang Rejo
17.05.06.2012|Lawang Agung
17.05.06.2013|Taba Lubuk Puding
17.05.06.2014|Talang Sebaris
17.05.06.2015|Lubuk Gilang
17.05.06.2016|Lokasi Baru
17.05.07.2001|Talang Giring
17.05.07.2002|Padang Capo Ilir
17.05.07.2003|Padang Capo Ulu
17.05.07.2004|Talang Kebun
17.05.07.2005|Gunung Agung
17.05.07.2006|Cawang
17.05.07.2007|Arang Sapat
17.05.07.2008|Dusun Tengah
17.05.07.2009|Tanjung Kuaw
17.05.07.2010|Napal Jungur
17.05.07.2011|Tumbu'an
17.05.07.2012|Rena Panjang
17.05.07.2013|Sakaian
17.05.07.2014|Lubuk Terentang
17.05.08.2001|Tanjung Agung
17.05.08.2002|Air Latak
17.05.08.2003|Talang Perapat
17.05.08.2004|Pagar Agung
17.05.08.2005|Talang Tinggi
17.05.08.2006|Lunjuk
17.05.08.2007|Lubuk Lagan
17.05.08.2008|Purbosari
17.05.08.2009|Sengkuang Jaya
17.05.09.1004|Selebar
17.05.09.1005|Sembayat
17.05.09.1006|Bunga Mas
17.05.09.2001|Talang Sali
17.05.09.2002|Kunduran
17.05.09.2003|Kota Agung
17.05.09.2007|Tenangan
17.05.09.2008|Rawa Sari
17.05.10.1003|Puguk
17.05.10.2001|Talang Rami
17.05.10.2002|Talang Beringin
17.05.10.2004|Pandan
17.05.10.2005|Selinsingan
17.05.10.2006|Simpang
17.05.10.2007|Sekalak
17.05.10.2008|Lubuk Resam
17.05.10.2009|Sinar Pagi
17.05.10.2010|Talang Empat
17.05.11.1008|Rimbo Kedui
17.05.11.1010|Padang Rambun
17.05.11.1011|Sido Mulyo
17.05.11.2001|Sukarami
17.05.11.2002|Tanjung Seru
17.05.11.2003|Tanjungan
17.05.11.2004|Pasar Seluma
17.05.11.2005|Padang Genting
17.05.11.2006|Sengkuang
17.05.11.2007|Tangga Batu
17.05.11.2009|Tanjung Seluai
17.05.11.2012|Padang Merbau
17.05.12.2001|Pering Baru
17.05.12.2002|Talang Padang
17.05.12.2003|Suka Merindu
17.05.12.2004|Napalan
17.05.12.2005|Taba
17.05.12.2006|Bakal Dalam
17.05.12.2007|Lubuk Lagan
17.05.12.2008|Sungai Petai
17.05.12.2009|Suka Bulan
17.05.12.2010|Tebat Sibun
17.05.12.2011|Batu Balai
17.05.13.2001|Pagar
17.05.13.2002|Muara Simpur
17.05.13.2003|Pagar Agung
17.05.13.2004|Pagar Banyu
17.05.13.2005|Simpur Ijang
17.05.13.2006|Air Keruh
17.05.13.2007|Hargo Binangun
17.05.13.2008|Mekar Jaya
17.05.13.2009|Giri Nanto
17.05.13.2010|Banyu Kencana
17.05.13.2011|Muara Nibung
17.05.13.2012|Tanjung Agung
17.05.13.2013|Giri Mulya
17.05.14.2001|Pasar Talo
17.05.14.2002|Dusun Baru
17.05.14.2003|Talang Kabu
17.05.14.2004|Tanah Abang
17.05.14.2005|Penago Baru
17.05.14.2006|Nanti Agung
17.05.14.2007|Talang Panjang
17.05.14.2008|Penago I
17.05.14.2009|Penago II
17.05.14.2010|Rawah Indah
17.05.14.2011|Padang Cekur
17.05.14.2012|Padang Batu
17.05.14.2013|Paluah Terap
17.05.14.2014|Margo Sari
17.05.14.2015|Mekar Sari
17.06.01.2005|Suka Pindah
17.06.01.2006|Lubuk Pinang
17.06.01.2007|Arah Tiga
17.06.01.2008|Lubuk Gedang
17.06.01.2009|Tanjung Alai
17.06.01.2013|Sumber Makmur
17.06.01.2018|Ranah Karya
17.06.02.1009|Pasar Mukomuko
17.06.02.1017|Koto Jaya
17.06.02.1018|Bandar Ratu
17.06.02.2007|Pasar Sebelah
17.06.02.2008|Ujung Padang
17.06.02.2010|Pondok Batu
17.06.02.2011|Tanah Rekah
17.06.02.2012|Selagan Jaya
17.06.02.2019|Tanah Harapan
17.06.03.2008|Teras Terunjam
17.06.03.2009|Pondok Kopi
17.06.03.2013|Setia Budi
17.06.03.2014|Tunggal Jaya
17.06.03.2024|Talang Kuning
17.06.03.2025|Teruntung
17.06.03.2026|Karang Jaya
17.06.03.2027|Mekar Jaya
17.06.04.2001|Air Bikuk
17.06.04.2004|Tunggang
17.06.04.2005|Pondok Suguh
17.06.04.2006|Air Berau
17.06.04.2010|Air Hitam
17.06.04.2014|Pondok Kandang
17.06.04.2022|Bumi Mekar Jaya
17.06.04.2027|Lubuk Bento
17.06.04.2029|Sinar Laut
17.06.04.2030|Karya Mulya
17.06.04.2031|Teluk Bakung
17.06.05.2004|Air Buluh
17.06.05.2005|Pulau Baru
17.06.05.2006|Pasar Ipuh
17.06.05.2007|Medan Jaya
17.06.05.2008|Sibak
17.06.05.2009|Semundam
17.06.05.2014|Retak Ilir
17.06.05.2015|Tanjung Harapan
17.06.05.2017|Tanjung Jaya
17.06.05.2023|Manunggal Jaya
17.06.05.2028|Pulai Payung
17.06.05.2029|Tanjung Medan
17.06.05.2030|Tirta Mulya
17.06.05.2033|Pasar Baru
17.06.05.2034|Pulau Makmur
17.06.05.2035|Mundam Marap
17.06.06.2001|Talang Arah
17.06.06.2002|Serami Baru
17.06.06.2003|Lubuk Talang
17.06.06.2004|Gajah Makmur
17.06.06.2005|Semambang Makmur
17.06.06.2006|Talang Baru
17.06.06.2007|Air Merah
17.06.07.2001|Arga Jaya
17.06.07.2002|Air Rami
17.06.07.2003|Rami Mulya
17.06.07.2004|Talang Rio
17.06.07.2005|Makmur Jaya
17.06.07.2006|Marga Mulia
17.06.07.2007|Mekar Jaya
17.06.07.2008|Dusun Pulau
17.06.07.2009|Bukit Harapan
17.06.07.2010|Tirta Kencana
17.06.07.2011|Cinta Asih
17.06.07.2012|Bukit Mulya
17.06.08.2001|Pasar Bantal
17.06.08.2002|Nenggalo
17.06.08.2003|Pondok Baru
17.06.08.2004|Bunga Tanjung
17.06.08.2005|Bandar Jaya
17.06.08.2006|Teramang Jaya
17.06.08.2007|Brangan Mulya
17.06.08.2008|Sido Makmur
17.06.08.2009|Lubuk Selandak
17.06.08.2010|Nelan Indah
17.06.08.2011|Mandi Angin Jaya
17.06.08.2012|Batu Ejung
17.06.08.2013|Pernyah
17.06.09.2001|Sungai Ipuh
17.06.09.2002|Lubuk Sahung
17.06.09.2003|Surian Bungkal
17.06.09.2004|Sungai Gading
17.06.09.2005|Pondok Baru
17.06.09.2006|Sungai Jerinjing
17.06.09.2007|Lubuk Bangko
17.06.09.2008|Talang Buai
17.06.09.2009|Aur Cina
17.06.09.2010|Talang Medan
17.06.09.2011|Sungai Ipuh Satu
17.06.09.2012|Sungai Ipuh Dua
17.06.10.2001|Penarik
17.06.10.2002|Lubuk Mukti
17.06.10.2003|Bumi Mulya
17.06.10.2004|Suka Maju
17.06.10.2005|Bukit Makmur
17.06.10.2006|Sumber Mulya
17.06.10.2007|Sido Dadi
17.06.10.2008|Maju Makmur
17.06.10.2009|Sendang Mulyo
17.06.10.2010|Marga Mulya Sakti
17.06.10.2011|Wonosobo
17.06.10.2012|Mekar Mulya
17.06.10.2013|Sido Mulyo
17.06.10.2014|Marga Mukti
17.06.11.2001|Lubuk Sanai
17.06.11.2002|Rawa Mulya
17.06.11.2003|Rawa Bangun
17.06.11.2004|Tanjung Mulya
17.06.11.2005|Pauh Terenja
17.06.11.2006|Dusun Baru Pelokan
17.06.11.2007|Lubuk Sanai II
17.06.11.2009|Lubuk Sanai III
17.06.12.2001|Lalang Luas
17.06.12.2002|Resno
17.06.12.2003|Pondok Panjang
17.06.12.2004|Talang Petai
17.06.12.2005|Sungai Lintang
17.06.12.2006|Pondok Tengah
17.06.12.2007|Talang Sakti
17.06.12.2008|Talang Sepakat
17.06.12.2009|Lubuk Cabau
17.06.12.2010|Sungai Rengas
17.06.13.2001|Pondok Makmur
17.06.13.2002|Manjunto Jaya
17.06.13.2003|Tirta Makmur
17.06.13.2004|Agung Jaya
17.06.13.2005|Tirta Mulya
17.06.13.2006|Kota Praja
17.06.13.2007|Sinar Jaya
17.06.13.2008|Sido Makmur
17.06.14.2001|Dusun Baru V Koto
17.06.14.2002|Air Dikit
17.06.14.2003|Pondok Lunang
17.06.14.2004|Sari Bulan
17.06.14.2005|Sari Makmur
17.06.14.2006|Sumber Sari
17.06.14.2007|Air Kasai
17.06.15.2001|Retak Mudik
17.06.15.2002|Padang Gading
17.06.15.2003|Gajah Mati
17.06.15.2004|Mekar Sari
17.06.15.2005|Sido Dadi
17.06.15.2006|Sumber Makmur
17.06.15.2007|Talang Gading
17.06.15.2008|Gading Jaya
17.06.15.2009|Banjar Sari
17.07.01.1004|Kampung Jawa
17.07.01.1006|Pasar Muara Aman
17.07.01.2002|Gandung
17.07.01.2005|Tunggang
17.07.01.2007|Talang Ulu
17.07.01.2014|Nangai Amen
17.07.01.2016|Lebong Tambang
17.07.01.2022|Ladang Palembang
17.07.01.2023|Kampung Dalam
17.07.01.2024|Kampung Muara Aman
17.07.01.2028|Lokasari
17.07.01.2033|Gandung Baru
17.07.02.2001|Sukau Kayo
17.07.02.2004|Tik Tebing
17.07.02.2005|Tabeak Blau
17.07.02.2006|Tabeak Blau I
17.07.02.2008|Daneu
17.07.02.2012|Blau
17.07.03.1005|Embong Panjang
17.07.03.2006|Tanjung Bungai I
17.07.03.2007|Semelako I
17.07.03.2008|Pagar Agung
17.07.03.2009|Karang Anyar
17.07.03.2013|Semelako II
17.07.03.2014|Semelako III
17.07.03.2015|Semelako Atas
17.07.03.2016|Danau Liang
17.07.03.2020|Suka Damai
17.07.03.2023|Tanjung Bungai II
17.07.04.1002|Tes
17.07.04.1003|Taba Anyar
17.07.04.1004|Mubai
17.07.04.1005|Turan Lalang
17.07.04.2001|Kutai Donok
17.07.04.2013|Turan Tiging
17.07.04.2014|Suka Sari
17.07.04.2016|Mangkurajo
17.07.04.2018|Tik Jeniak
17.07.04.2019|Manai Blau
17.07.05.1002|Rimbo Pengadang
17.07.05.2009|Talang Ratau
17.07.05.2010|Bioa Sengok
17.07.05.2011|Tik Kuto
17.07.05.2012|Teluk Dien
17.07.05.2013|Bajok
17.07.06.1001|Topos
17.07.06.2002|Tik Sirong
17.07.06.2003|Suka Negeri
17.07.06.2004|Ajai Siang
17.07.06.2005|Talang Donok
17.07.06.2006|Talang Donok I
17.07.06.2007|Talang Baru I
17.07.06.2008|Talang Baru II
17.07.07.2001|Karang Dapo Atas
17.07.07.2002|Bukit Nibung
17.07.07.2003|Karang Dapo Bawah
17.07.07.2004|Pungguk Pedaro
17.07.07.2005|Talang Kerinci
17.07.07.2006|Pelabuhan Talang Liak
17.07.07.2007|Talang Liak I
17.07.07.2008|Talang Liak II
17.07.07.2009|Bungin
17.07.08.2001|Ujung Tanjung I
17.07.08.2002|Muning Agung
17.07.08.2003|Ujung Tanjung II
17.07.08.2004|Ujung Tanjung III
17.07.08.2005|Magelang Baru
17.07.08.2006|Lemeu Pit
17.07.08.2007|Tabeak Kauk
17.07.08.2008|Tabeak Dipoa
17.07.08.2009|Suka Bumi
17.07.09.1001|Tanjung Agung
17.07.09.2002|Sukau Datang
17.07.09.2003|Sukau Datang I
17.07.09.2004|Gunung Alam
17.07.09.2005|Tabeak Blau II
17.07.09.2006|Kota Baru Santan
17.07.09.2007|Tik Teleu
17.07.09.2008|Pelabai
17.07.10.1009|Amen
17.07.10.2001|Nangai Tayau
17.07.10.2002|Nangai Tayau I
17.07.10.2003|Pyang Mbik
17.07.10.2004|Sukau Mergo
17.07.10.2005|Sukau Rajo
17.07.10.2006|Talang Bunut
17.07.10.2007|Selebar Jaya
17.07.10.2008|Garut
17.07.10.2010|Sungai Gerong
17.07.11.2001|Embong
17.07.11.2002|Embong I
17.07.11.2003|Kota Baru
17.07.11.2004|Kota Agung
17.07.11.2005|Lemeu
17.07.11.2006|Pangkalan
17.07.11.2007|Tangua
17.07.12.2001|Ketenong I
17.07.12.2002|Ketenong II
17.07.12.2003|Ketenong Jaya
17.07.12.2004|Tambang Saweak
17.07.12.2005|Air Kopras
17.07.12.2006|Bioa Putiak
17.07.12.2007|Sebelat
17.07.12.2008|Sungai Lisai
17.08.01.1007|Keban Agung
17.08.01.2001|Kota Agung
17.08.01.2002|Kembang Seri
17.08.01.2003|Pagar Agung
17.08.01.2004|Embong Ijuk
17.08.01.2005|Gunung Agung
17.08.01.2006|Talang Pito
17.08.01.2008|Cinto Mandi
17.08.01.2009|Lembur Lama
17.08.01.2010|Taba Baru
17.08.01.2011|Bukit Menyan
17.08.01.2016|Batu Belarik
17.08.01.2017|Embong Sido
17.08.01.2022|Talang Sawah
17.08.01.2023|Sosokan Cinta Mandi
17.08.01.2024|Muara Langkap
17.08.01.2025|Air Raman
17.08.01.2028|Langgar Jaya
17.08.01.2029|Cinta Mandi Baru
17.08.02.1002|Ujan Mas Atas
17.08.02.2001|Daspeta
17.08.02.2003|Suro Lembak
17.08.02.2004|Tanjung Alam
17.08.02.2005|Suro Ilir
17.08.02.2006|Suro Muncar
17.08.02.2007|Suro Baru
17.08.02.2008|Pekalongan
17.08.02.2009|Bumi Sari
17.08.02.2016|Cugung Lalang
17.08.02.2017|Ujan Mas Bawah
17.08.02.2018|Suro Bali
17.08.02.2019|Pungguk Meranti
17.08.02.2020|Pungguk Meringang
17.08.02.2021|Meranti Jaya
17.08.02.2023|Air Hitam
17.08.02.2024|Daspetah II
17.08.03.1008|Tebat Karai
17.08.03.2006|Taba Santing
17.08.03.2007|Tertik
17.08.03.2009|Talang Karet
17.08.03.2010|Peraduan Binjai
17.08.03.2011|Penanjung Panjang
17.08.03.2012|Nanti Agung
17.08.03.2013|Taba Air Pauh
17.08.03.2014|Karang Tengah
17.08.03.2019|Tapak Gedung
17.08.03.2020|Tebing Penyamun
17.08.03.2021|Sinar Gunung
17.08.03.2022|Taba Saling
17.08.03.2023|Penanjung Panjang Atas
17.08.04.1003|Pensiunan
17.08.04.1004|Pasar Kepahiangan
17.08.04.1005|Pasar Ujung
17.08.04.1011|Dusun Kepahiang
17.08.04.1025|Kampung Pensiunan
17.08.04.1026|Pasar Sejantung
17.08.04.1027|Padang Lekat
17.08.04.2001|Kelilik
17.08.04.2002|Tebat Monok
17.08.04.2006|Permu
17.08.04.2007|Imigrasi Permu
17.08.04.2008|Karang Endah
17.08.04.2009|Westkust
17.08.04.2010|Kampung Bogor
17.08.04.2012|Kuto Rejo
17.08.04.2013|Karang Anyar
17.08.04.2014|Taba Tebelet
17.08.04.2015|Pelangkian
17.08.04.2016|Kelobak
17.08.04.2017|Pagar Gunung
17.08.04.2023|Sukamerindu
17.08.04.2028|Bogor Baru
17.08.04.2029|Permu bawah
17.08.05.1002|Durian Depun
17.08.05.2001|Pulo Geto
17.08.05.2003|Taba Mulan
17.08.05.2004|Lubuk Penyamun
17.08.05.2005|SP. Kota Bingin
17.08.05.2006|Bukit Barisan
17.08.05.2007|Batu Ampar
17.08.05.2008|Pulo Geto Baru
17.08.06.1005|Tangsi Baru
17.08.06.2001|Bandung Baru
17.08.06.2002|Bukit Sari
17.08.06.2003|Tugu Rejo
17.08.06.2004|Suka Sari
17.08.06.2006|Air Sempiang
17.08.06.2007|Tangsi Duren
17.08.06.2008|Babakan Bogor
17.08.06.2009|Barat Wetan
17.08.06.2010|Pematang Donok
17.08.06.2011|Sumber Sari
17.08.06.2012|Mekar Sari
17.08.06.2013|Sido Makmur
17.08.06.2014|Sido Rejo
17.08.06.2015|Bandung Jaya
17.08.07.2001|Benuang Galing
17.08.07.2002|Air Selimang
17.08.07.2003|Tebat Laut
17.08.07.2004|Temdak
17.08.07.2005|Taba Padang
17.08.07.2006|Lubuk Saung
17.08.07.2007|Kandang
17.08.07.2008|Cirebon Baru
17.08.07.2009|Talang Gelompok
17.08.07.2010|Air Pesi
17.08.07.2011|Talang Babatan
17.08.07.2012|Bayung
17.08.07.2013|Sungai Jernih
17.08.08.2001|Limbur Baru
17.08.08.2002|Batu Kalung
17.08.08.2003|Batu Bandung
17.08.08.2004|Sosokan Baru
17.08.08.2005|Sosokan Taba
17.08.08.2006|Talang Tige
17.08.08.2007|Renah Kurung
17.08.08.2008|Warung Pojok
17.09.01.2001|Taba Terunjam
17.09.01.2002|Talang Empat
17.09.01.2003|Padang Tambak
17.09.01.2004|Durian Demang
17.09.01.2005|Pelajau
17.09.01.2007|Dusun Baru II
17.09.01.2008|Penanding
17.09.01.2009|Karang Tinggi
17.09.01.2010|Renah Lebar
17.09.01.2011|Kancing
17.09.01.2012|Ujung Karang
17.09.01.2013|Taba Mutung
17.09.01.2015|Renah Semanek
17.09.02.2001|Air Sebakul
17.09.02.2004|Taba Pasmah
17.09.02.2005|Kembang Seri
17.09.02.2006|Tengah Padang
17.09.02.2007|Jayakarta
17.09.02.2008|Nakau
17.09.02.2009|Pulau Panggung
17.09.02.2014|Jum'at
17.09.02.2015|Padang Ulak Tanjung
17.09.02.2017|Air Putih
17.09.03.2009|Talang Pauh
17.09.03.2010|Srikaton
17.09.03.2011|Pekik Nyaring
17.09.03.2012|Pasar Pedati
17.09.03.2013|Sunda Kelapa
17.09.03.2014|Pondok Kelapa
17.09.03.2015|Padang Betuah
17.09.03.2016|Sidorejo
17.09.03.2017|Sidodadi
17.09.03.2018|Talang Boseng
17.09.03.2019|Pagar Dewa
17.09.03.2020|Kembang Ayun
17.09.03.2021|Panca Mukti
17.09.03.2022|Sri Kuncoro
17.09.03.2023|Bintang Selatan
17.09.03.2024|Abu Sakim
17.09.03.2025|Harapan
17.09.04.2002|Aturan Mumpo
17.09.04.2003|Talang Tengah II
17.09.04.2004|Kota Titik
17.09.04.2007|Senabah
17.09.04.2015|Air Kotok
17.09.04.2016|Batu Beriang
17.09.04.2017|Pematang Tiga
17.09.04.2018|Tiambang
17.09.04.2019|Kebun Lebar
17.09.04.2020|Tanjung Kepahyang
17.09.04.2021|Pematang Tiga Lama
17.09.04.2022|Aturan Mumpo II
17.09.04.2023|Genting Dabuk
17.09.05.2006|Temiang
17.09.05.2008|Taba Renah
17.09.05.2009|Kerta Pati
17.09.05.2010|Pagar Jati
17.09.05.2012|Karang Are
17.09.05.2013|Datar Penokat
17.09.05.2014|Layang Lekat
17.09.05.2015|Tumbuk
17.09.05.2016|Talang Curup
17.09.05.2017|Rena Kandis
17.09.05.2018|Arga Indah I
17.09.05.2022|Keroya
17.09.05.2023|Kertapati Mudik
17.09.05.2024|Rena Jaya
17.09.06.1007|Taba Penanjung
17.09.06.2002|Tanjung Raman
17.09.06.2003|Sukarami
17.09.06.2004|Karang Tengah
17.09.06.2005|Lubuk Sini
17.09.06.2008|Taba Teret
17.09.06.2009|Surau
17.09.06.2010|Rindu Hati
17.09.06.2011|Tanjung Heran
17.09.06.2012|Datar Lebar
17.09.06.2013|Penum
17.09.06.2023|Bajak I
17.09.06.2024|Taba Baru
17.09.07.2001|Jambu
17.09.07.2002|Penembang
17.09.07.2003|Talang Ambung
17.09.07.2004|Taba Durian Sebakul
17.09.07.2005|Lubuk Unen
17.09.07.2006|Pungguk Ketupak
17.09.07.2007|Pungguk Beringin
17.09.07.2008|Ulak Lebar
17.09.07.2009|Kelindang
17.09.07.2010|Bajak II
17.09.07.2011|Lubuk Unen Baru
17.09.07.2012|Padang Kedeper
17.09.07.2013|Kelindang Atas
17.09.08.2001|Komering
17.09.08.2002|Bajak Tiga
17.09.08.2003|Rajak Besi
17.09.08.2004|Punjung
17.09.08.2005|Susup
17.09.08.2006|Arga Indah II
17.09.08.2007|Curup
17.09.08.2008|Karang Panggung
17.09.08.2009|Lubuk Pendam
17.09.08.2010|Lubuk Puar
17.09.08.2011|Durian Lebar
17.09.08.2012|Pagar Agung
17.09.08.2013|Pungguk Jaya
17.09.08.2014|Taba Gemantung
17.09.08.2015|Pagar Besi
17.09.09.2001|Pondok Kubang
17.09.09.2002|Batu Raja
17.09.09.2003|Dusun Anyar
17.09.09.2004|Tanjung Dalam
17.09.09.2005|Talang Tengah I
17.09.09.2006|Paku Haji
17.09.09.2007|Tanjung Terdana
17.09.09.2008|Linggar Galing
17.09.09.2009|Dusun Baru I
17.09.09.2010|Harapan Makmur
17.09.09.2011|Margo Mulyo
17.09.09.2012|Taba Jambu
17.09.10.2001|Sekayun
17.09.10.2002|Sekayun Mudik
17.09.10.2003|Sekayun Hilir
17.09.10.2004|Talang Donok
17.09.10.2005|Taba Tengah
17.09.10.2006|Padang Berunai
17.09.10.2007|Lubuk Langkap
17.09.10.2008|Air Napal
17.09.10.2009|Genting
17.09.10.2010|Talang Panjang
17.09.10.2011|Bang Haji
17.09.10.2012|Sungkai Berayun
17.09.11.2001|Pagar Gunung
17.09.11.2002|Karang Nanding
17.09.11.2003|Semidang
17.09.11.2004|Gajah Mati
17.09.11.2005|Padang Siring
17.09.11.2006|Lagan Bungin
17.09.11.2007|Pagar Jati
17.09.11.2008|Taba Lagan
17.09.11.2009|Lagan
17.09.11.2010|Bukit
17.09.11.2011|Kota Niur
17.71.01.1001|Pagar Dewa
17.71.01.1002|Sukarami
17.71.01.1003|Pekan Sabtu
17.71.01.1004|Bumu Ayu
17.71.01.1005|Betungan
17.71.01.1006|Sumur Dewa
17.71.02.1001|Padang Harapan
17.71.02.1002|Jalan Gedang
17.71.02.1021|Sidomulyo
17.71.02.1024|Lingkar Barat
17.71.02.1027|Cempaka Permai
17.71.03.1001|Berkas
17.71.03.1002|Pasar Baru
17.71.03.1003|Jitra
17.71.03.1004|Pasar Melintang
17.71.03.1005|Kebun Roos
17.71.03.1007|Tengah Padang
17.71.03.1008|Bajak
17.71.03.1010|Pondok Besi
17.71.03.1011|Kebun Keling
17.71.03.1013|Sumur Meleleh
17.71.03.1014|Malabero
17.71.03.1018|Pintu Batu
17.71.03.1019|Kampung Bali
17.71.04.1001|Kandang Limun
17.71.04.1002|Bentiring
17.71.04.1003|Pematang Gubernur
17.71.04.1004|Rawa Makmur
17.71.04.1005|Beringin Raya
17.71.04.1006|Bentiring Permai
17.71.04.1007|Rawa Makmur Permai
17.71.05.1001|Kandang
17.71.05.1002|Kandang Mas
17.71.05.1003|Teluk Sepang
17.71.05.1004|Sumber Jaya
17.71.05.1005|Padang Serai
17.71.05.1006|Muara Dua
17.71.06.1001|Kebun Tebeng
17.71.06.1002|Tanah Patah
17.71.06.1003|Nusa Indah
17.71.06.1004|Kebun Beler
17.71.06.1005|Kebun Kenanga
17.71.06.1006|Sawah Lebar
17.71.06.1007|Sawah Lebar Baru
17.71.06.1008|Lempuing
17.71.07.1001|Padang Jati
17.71.07.1002|Kebun Dahri
17.71.07.1003|Belakang Pondok
17.71.07.1004|Penurunan
17.71.07.1005|Anggut Bawah
17.71.07.1006|Anggut Atas
17.71.07.1007|Anggut Dalam
17.71.07.1008|Kebun Geran
17.71.07.1009|Pengantungan
17.71.08.1001|Kampung Kelawi
17.71.08.1002|Sukamerindu
17.71.08.1003|Semarang
17.71.08.1004|Tanjung Agung
17.71.08.1005|Tanjung Jaya
17.71.08.1006|Surabaya
17.71.08.1007|Pasar Bengkulu
17.71.09.1001|Panorama
17.71.09.1002|Jembatan Kecil
17.71.09.1003|Dusun Besar
17.71.09.1004|Padang Nangka
17.71.09.1005|Timur Indah
17.71.09.1006|Lingkar Timur
18.01.04.2001|Hajimena
18.01.04.2002|Sidosari
18.01.04.2003|Pemanggilan
18.01.04.2004|Natar
18.01.04.2005|Muara Putih
18.01.04.2006|Negara Ratu
18.01.04.2007|Merak Batin
18.01.04.2008|Tanjung Sari
18.01.04.2009|Bumi Sari
18.01.04.2010|Candi Mas
18.01.04.2011|Branti Raya
18.01.04.2012|Haduyang
18.01.04.2013|Banjar Negeri
18.01.04.2014|Mandah
18.01.04.2015|Rulung Helok
18.01.04.2016|Bandarejo
18.01.04.2017|Suka Damai
18.01.04.2018|Purwosari
18.01.04.2019|Pancasila
18.01.04.2020|Rejosari
18.01.04.2021|Rulung Raya
18.01.04.2022|Krawang Sari
18.01.04.2023|Wai Sari
18.01.04.2024|Kali Sari
18.01.04.2025|Rulung Sari
18.01.04.2026|Rulung Mulya
18.01.05.2001|Kaliasin
18.01.05.2003|Lematang
18.01.05.2004|Sukanegara
18.01.05.2005|Serdang
18.01.05.2006|Sinar Ogan
18.01.05.2007|Jati Baru
18.01.05.2008|Sabah Balau
18.01.05.2009|Budi Lestari
18.01.05.2010|Trimulyo
18.01.05.2011|Jati Indah
18.01.05.2012|Way Galih
18.01.05.2013|Sindang Sari
18.01.05.2015|Purwodadi Simpang
18.01.05.2021|Galih Lunik
18.01.05.2022|Rejomulyo
18.01.05.2023|Sri Katon
18.01.06.1006|Bumi Agung
18.01.06.1007|Kalianda
18.01.06.1008|Way Urang
18.01.06.1028|Wai Lubuk
18.01.06.2001|Jondong
18.01.06.2002|Tengkujuh
18.01.06.2003|Pauh Tanjung Iman
18.01.06.2004|Sumur Kumbang
18.01.06.2005|Maja
18.01.06.2009|Buah Berak
18.01.06.2010|Kesugihan
18.01.06.2011|Pematang
18.01.06.2012|Kecapi
18.01.06.2013|Babulang
18.01.06.2014|Sukaratu
18.01.06.2015|Palembapang
18.01.06.2016|Tajimalela
18.01.06.2017|Canggu
18.01.06.2018|Kedaton
18.01.06.2019|Merak Belatung
18.01.06.2020|Bulok
18.01.06.2021|Munjuk Sampurna
18.01.06.2022|Gunung Terang
18.01.06.2023|Margacatur
18.01.06.2024|Sukatani
18.01.06.2025|Agom
18.01.06.2026|Negeri Pandan
18.01.06.2027|Taman Agung
18.01.06.2029|Hara Banjar Manis
18.01.07.2001|Bandar Dalam
18.01.07.2002|Campang Tiga
18.01.07.2003|Talang Baru
18.01.07.2004|Suka Banjar
18.01.07.2005|Kota Dalam
18.01.07.2006|Budidaya
18.01.07.2007|Siring Jaha
18.01.07.2008|Suak
18.01.07.2009|Sukamaju
18.01.07.2010|Sukamarga
18.01.07.2011|Seloretno
18.01.07.2012|Sidodadi
18.01.07.2013|Sidorejo
18.01.07.2014|Sidomulyo
18.01.07.2015|Sidowaluyo
18.01.07.2020|Banjar Suri
18.01.08.2001|Tarahan
18.01.08.2002|Babatan
18.01.08.2003|Pardasuka
18.01.08.2004|Sukajaya
18.01.08.2005|Tanjung Ratu
18.01.08.2006|Tanjung Agung
18.01.08.2007|Tanjungan
18.01.08.2008|Trans Tanjungan
18.01.08.2009|Neglasari
18.01.08.2018|Karya Tunggal
18.01.08.2019|Rangai Tri Tunggal
18.01.08.2020|Sidomekar
18.01.09.2001|Kekiling
18.01.09.2002|Belambangan
18.01.09.2003|Rawi
18.01.09.2004|Padan
18.01.09.2005|Kuripan
18.01.09.2006|Taman Baru
18.01.09.2007|Kelau
18.01.09.2008|Ruang Tengah
18.01.09.2009|Pasuruan
18.01.09.2010|Klaten
18.01.09.2011|Kampung Baru
18.01.09.2012|Banjar Masin
18.01.09.2013|Way Kalam
18.01.09.2014|Gedung Harta
18.01.09.2015|Gayam
18.01.09.2016|Penengahan
18.01.09.2017|Sukajaya
18.01.09.2018|Tetaan
18.01.09.2019|Suka Baru
18.01.09.2020|Pisang
18.01.09.2021|Tanjung Heran
18.01.09.2026|Gandri
18.01.10.2001|Sukaraja
18.01.10.2002|Sukabakti
18.01.10.2003|Sukamulya
18.01.10.2004|Tanjung Sari
18.01.10.2005|Bangunan
18.01.10.2006|Rejo Mulyo
18.01.10.2007|Palas Aji
18.01.10.2008|Palas Pasemah
18.01.10.2009|Palas Jaya
18.01.10.2010|Bandan Hurip
18.01.10.2011|Pulau Tengah
18.01.10.2012|Bali Agung
18.01.10.2013|Bumi Daya
18.01.10.2014|Tanjung Jaya
18.01.10.2015|Bumi Restu
18.01.10.2016|Pematang Baru
18.01.10.2017|Mekar Mulya
18.01.10.2018|Bumi Asih
18.01.10.2019|Kalirejo
18.01.10.2020|Bumi Asri
18.01.10.2021|Pulau Jaya
18.01.13.2001|Way Hui
18.01.13.2002|Sidodadi Asri
18.01.13.2003|Margo Mulyo
18.01.13.2004|Gedung Agung
18.01.13.2005|Margodadi
18.01.13.2006|Gedung Harapan
18.01.13.2007|Marga Agung
18.01.13.2008|Jati Mulyo
18.01.13.2009|Fajar Baru
18.01.13.2010|Karang Anyar
18.01.13.2011|Marga Kaya
18.01.13.2012|Margo Lestari
18.01.13.2013|Sumber Jaya
18.01.13.2014|Sinar Rejeki
18.01.13.2015|Sidoharjo
18.01.13.2016|Rejomulyo
18.01.13.2017|Purwotani
18.01.13.2018|Banjar Agung
18.01.13.2019|Karang Sari
18.01.13.2020|Karang Rejo
18.01.13.2021|Margorejo
18.01.14.2001|Bangunrejo
18.01.14.2002|Sripendowo
18.01.14.2003|Karang Sari
18.01.14.2004|Ketapang
18.01.14.2005|Legundi
18.01.14.2006|Tri Dharma Yoga
18.01.14.2007|Ruguk
18.01.14.2008|Sumur
18.01.14.2009|Sumber Nadi
18.01.14.2010|Sidoasih
18.01.14.2011|Pematang Pasir
18.01.14.2012|Berundung
18.01.14.2013|Taman Sari
18.01.14.2014|Kemukus
18.01.14.2015|Lebung Nala
18.01.14.2016|Sidoluhur
18.01.14.2017|Wai Sidomukti
18.01.15.2001|Kuala Sekampung
18.01.15.2002|Baktirasa
18.01.15.2003|Mandala Sari
18.01.15.2004|Sukapura
18.01.15.2005|Sumber Agung
18.01.15.2006|Marga Jasa
18.01.15.2007|Sumber Sari
18.01.15.2008|Bandar Agung
18.01.15.2009|Kedaung
18.01.15.2010|Margasari
18.01.16.2001|Banding
18.01.16.2002|Betung
18.01.16.2003|Batu Balak
18.01.16.2004|Canti
18.01.16.2005|Canggung
18.01.16.2006|Cugung
18.01.16.2007|Hargo Pancuran
18.01.16.2008|Kerinjing
18.01.16.2009|Kunjir
18.01.16.2010|Kota Guring
18.01.16.2011|Rajabasa
18.01.16.2012|Sukaraja
18.01.16.2013|Tanjung Gading
18.01.16.2014|Tejang Pulau Sebesi
18.01.16.2015|Way Muli
18.01.16.2016|Wai Muli Timur
18.01.17.2001|Batuliman Indah
18.01.17.2002|Sinar Palembang
18.01.17.2003|Rantau Minyak
18.01.17.2004|Sido Asri
18.01.17.2005|Way Gelam
18.01.17.2006|Cinta Mulya
18.01.17.2007|Banyumas
18.01.17.2008|Beringin Kencana
18.01.17.2009|Sinar Pasemah
18.01.17.2010|Rawa Selapan
18.01.17.2011|Bumi Jaya
18.01.17.2012|Trimomukti
18.01.17.2013|Titiwangi
18.01.17.2014|Karya Mulya Sari
18.01.18.2001|Merbau Mataram
18.01.18.2002|Suban
18.01.18.2003|Tanjung Baru
18.01.18.2004|Baru Ranji
18.01.18.2005|Karang Raja
18.01.18.2006|Talang Jawa
18.01.18.2007|Lebung Sari
18.01.18.2008|Puji Rahayu
18.01.18.2009|Batu Agung
18.01.18.2010|Tanjung Harapan
18.01.18.2011|Sinar Karya
18.01.18.2012|Triharjo
18.01.18.2013|Panca Tunggal
18.01.18.2014|Mekar Jaya
18.01.18.2015|Karang Jaya
18.01.21.2001|Semanak
18.01.21.2002|Toto Harjo
18.01.21.2003|Hatta
18.01.21.2004|Bakauheni
18.01.21.2005|Kelawi
18.01.22.2001|Bangun Sari
18.01.22.2002|Purwodadi Dalam
18.01.22.2003|Sidomukti
18.01.22.2004|Wawasan
18.01.22.2005|Mulyosari
18.01.22.2006|Wonodadi
18.01.22.2007|Kertosari
18.01.22.2008|Malangsari
18.01.23.2001|Mekar Sari
18.01.23.2002|Sumber Agung
18.01.23.2003|Talang Way Sulan
18.01.23.2004|Pamulihan
18.01.23.2005|Purwodadi
18.01.23.2006|Sukamaju
18.01.23.2007|Banjarsari
18.01.23.2008|Karang Pucung
18.01.24.2001|Sidoharjo
18.01.24.2002|Sidomakmur
18.01.24.2003|Sidoreno
18.01.24.2004|Bali Nuraga
18.02.01.2001|Sri Way Langsep
18.02.01.2002|Wayakrui
18.02.01.2003|Kalirejo
18.02.01.2004|Balai Rejo
18.02.01.2005|Watu Agung
18.02.01.2006|Sri Basuki
18.02.01.2007|Kaliwungu
18.02.01.2008|Kali Dadi
18.02.01.2009|Sri Mulyo
18.02.01.2010|Sri Dadi
18.02.01.2011|Suko Sari
18.02.01.2012|Sinar Sari
18.02.01.2013|Ponco Warno
18.02.01.2014|Sri Purnomo
18.02.01.2015|Sinar Rejo
18.02.01.2016|Agung Timur
18.02.01.2017|Kalisari
18.02.02.2001|Purwodadi
18.02.02.2002|Sido Dadi
18.02.02.2003|Sido Rejo
18.02.02.2004|Cimarias
18.02.02.2005|Bangun Rejo
18.02.02.2006|Sido Luhur
18.02.02.2007|Sido Mulyo
18.02.02.2008|Timbul Rejo
18.02.02.2009|Suka Negara
18.02.02.2010|Sinar Seputih
18.02.02.2011|Sinar Luas
18.02.02.2012|Tanjung Pandan
18.02.02.2013|Tanjung Jaya
18.02.02.2014|Sri Pendowo
18.02.02.2015|Sukowaringin
18.02.02.2016|Mekar Jaya
18.02.02.2017|Suka Negeri
18.02.03.2001|Purwosari
18.02.03.2002|Sendang Ayu
18.02.03.2003|Bandar Sari
18.02.03.2004|Surabaya
18.02.03.2005|Margorejo
18.02.03.2006|Kota Baru
18.02.03.2007|Karang Tanjung
18.02.03.2008|Kuripan
18.02.03.2009|Sri Agung
18.02.03.2010|Haduyang Ratu
18.02.03.2011|Padang Ratu
18.02.03.2018|Karang Sari
18.02.03.2019|Mojokerto
18.02.03.2020|Sumber Sari
18.02.03.2021|Purworejo
18.02.04.1005|Gunung Sugih
18.02.04.1006|Gunung S. Raya
18.02.04.1007|Komering Agung
18.02.04.1008|Seputih Jaya
18.02.04.2001|Terbanggi Subing
18.02.04.2002|Terbanggi Agung
18.02.04.2003|Fajar Bulan
18.02.04.2004|Komering Putih
18.02.04.2009|Buyut Udik
18.02.04.2010|Buyut Ilir
18.02.04.2011|Bangun Rejo
18.02.04.2012|Wono Sari
18.02.04.2013|Putra Buyut
18.02.04.2014|Gunung Sari
18.02.04.2015|Buyut Utara
18.02.05.1003|Adi Puro
18.02.05.1004|Trimurjo
18.02.05.1007|Simbar Waringin
18.02.05.2001|Depok Rejo
18.02.05.2002|Liman Benawi
18.02.05.2005|Noto Harjo
18.02.05.2006|Purwodadi
18.02.05.2008|Tempuran
18.02.05.2009|Purwo Adi
18.02.05.2010|Pujo Dadi
18.02.05.2011|Pujo Kerto
18.02.05.2012|Untoro
18.02.05.2013|Pujo Asri
18.02.05.2014|Pujo Basuki
18.02.06.2001|Nunggal Rejo
18.02.06.2002|Badran Sari
18.02.06.2003|Sri Sawahan
18.02.06.2004|Toto Katon
18.02.06.2005|Tanggul Angin
18.02.06.2006|Ngesti Rahayu
18.02.06.2007|Mojopahit
18.02.06.2008|Asto Mulyo
18.02.06.2009|Sido Mulyo
18.02.07.1002|Bandar Jaya Timur
18.02.07.1003|Bandar Jaya Barat
18.02.07.1004|Yukum Jaya
18.02.07.2001|Adi Jaya
18.02.07.2005|Indra Putra Subing
18.02.07.2006|Karang Endah
18.02.07.2007|Nambah Dadi
18.02.07.2008|Ono Harjo
18.02.07.2009|Terbanggi Besar
18.02.07.2010|Poncowati
18.02.08.2001|Rejo Basuki
18.02.08.2002|Rejo Asri
18.02.08.2003|Rukti Endah
18.02.08.2004|Rama Dewa
18.02.08.2005|Ratna Chaton
18.02.08.2006|Rama Yana
18.02.08.2007|Rama Indra
18.02.08.2008|Rukti Harjo
18.02.08.2009|Rama Gunawan
18.02.08.2010|Rama Oetama
18.02.08.2011|Rama Nirwana
18.02.08.2012|Rama Murti
18.02.08.2013|Rama Klandungan
18.02.08.2014|Buyut Baru
18.02.09.2001|Teluk Dalem Ilir
18.02.09.2002|Rekso Binangun
18.02.09.2003|Rukti Basuki
18.02.09.2004|Restu Baru
18.02.09.2005|Restu Buana
18.02.09.2006|Reno Basuki
18.02.09.2013|Bina Karya Putra
18.02.09.2014|Bina Karya Buana
18.02.09.2015|Bina Karya mandiri
18.02.10.2001|Sumber Bahagia
18.02.10.2002|Tanjung Harapan
18.02.10.2003|Setia Bumi
18.02.10.2004|Sumber Baru
18.02.10.2005|Siswo Binangun
18.02.10.2006|Sanggar Buana
18.02.10.2007|Sakti Buana
18.02.10.2008|Setia Bhakti
18.02.10.2009|Sri Basuki
18.02.10.2010|Sari Bhakti
18.02.10.2011|Swastika Buana
18.02.10.2012|Sumber Fajar
18.02.10.2013|Tanjung Krajan
18.02.11.2001|Fajar Mataram
18.02.11.2002|Rejosari Mataram
18.02.11.2003|Qurnia Mataram
18.02.11.2004|Trimulyo Mataram
18.02.11.2005|Utama Jaya Mataram
18.02.11.2006|Sumber Agung Mataram
18.02.11.2007|Varia Agung Mataram
18.02.11.2008|Wirata Agung Mataram
18.02.11.2009|Dharma Agung Mataram
18.02.11.2010|Bumi Setia Mataram
18.02.11.2011|Subing Karya
18.02.11.2012|Banjar Agung Mataram
18.02.12.2001|Gaya Baru VI
18.02.12.2002|Sumber Katon
18.02.12.2003|Sri Katon
18.02.12.2004|Gaya Baru VII
18.02.12.2005|Gaya Baru IV
18.02.12.2006|Gaya Baru III
18.02.12.2007|Gaya Baru II
18.02.12.2008|Gaya Baru VIII
18.02.12.2009|Gaya Baru I
18.02.12.2010|Mataram Ilir
18.02.12.2011|Rawa Betik
18.02.12.2012|Srimulya Jaya
18.02.12.2013|Kenanga Sari
18.02.13.2001|Gunung Batin Udik
18.02.13.2002|Gunung Batin Ilir
18.02.13.2003|Gunung Batin Baru
18.02.13.2004|Gunung Agung
18.02.13.2005|Bandar Agung
18.02.13.2006|Bandar Sakti
18.02.13.2007|Tanjung Anom
18.02.14.2001|Suka Jawa
18.02.14.2002|Sidokerto
18.02.14.2003|Suka Jadi
18.02.14.2004|Bumi Raharjo
18.02.14.2005|Wates
18.02.14.2006|Bumi Ratu
18.02.14.2007|Bulu Sari
18.02.14.2008|Bumi Rahayu
18.02.14.2009|Sido Waras
18.02.14.2010|Tulung Kakan
18.02.15.2001|Rengas
18.02.15.2002|Kesuma Dadi
18.02.15.2003|Sinar Banten
18.02.15.2004|Kesuma Jaya
18.02.15.2005|Binjai Ngagung
18.02.15.2006|Kedatuan
18.02.15.2007|Goras Jaya
18.02.15.2008|Bangun Sari
18.02.16.2001|Harapan Rejo
18.02.16.2002|Endang Rejo
18.02.16.2003|Dono Arum
18.02.16.2004|Simpang Agung
18.02.16.2005|Bumi Kencana
18.02.16.2006|Gayau Sakti
18.02.16.2007|Fajar Asri
18.02.16.2008|Muji Rahayu
18.02.16.2009|Sulusuban
18.02.16.2010|Bumi Mas
18.02.17.2001|Tanjung Ratu Ilir
18.02.17.2002|Candi Rejo
18.02.17.2003|Banjar Ratu
18.02.17.2004|Banjar Kerta Rahayu
18.02.17.2005|Lempuyang Bandar
18.02.17.2006|Purnama Tunggal
18.02.17.2007|Banjar Rejo
18.02.17.2008|Putra Lempuyang
18.02.18.2001|Sriwijaya Mataram
18.02.18.2002|Uman Agung Mataram
18.02.18.2003|Terbanggi Ilir
18.02.18.2004|Jatidatar Mataram
18.02.18.2005|Sendang Agung Mataram
18.02.18.2006|Mataram Udik
18.02.18.2007|Terbanggi Mulya
18.02.18.2008|Mataram Jaya
18.02.18.2009|Sumber Rejeki Mataram
18.02.19.2001|Kota Batu
18.02.19.2002|Sangun Ratu
18.02.19.2003|Gunung Raya
18.02.19.2004|Gunung Haji
18.02.19.2005|Negeri Ratu
18.02.19.2006|Tanjung Kemala
18.02.19.2007|Payung Rejo
18.02.19.2008|Payung Batu
18.02.19.2009|Negeri Kepayungan
18.02.19.2010|Segala Mider
18.02.19.2011|Tias Bangun
18.02.19.2012|Riau Priangan
18.02.19.2013|Payung Dadi
18.02.19.2014|Payung Makmur
18.02.19.2015|Tanjung Rejo
18.02.19.2016|Tawang Negeri
18.02.19.2017|Sinar Negeri
18.02.19.2018|Pekandangan
18.02.19.2019|Payung Mulya
18.02.19.2020|Padang Rejo
18.02.20.2001|Nyukang Harjo
18.02.20.2002|Lingga Pura
18.02.20.2003|Sido Harjo
18.02.20.2004|Taman Sari
18.02.20.2005|Karang Anyar
18.02.20.2006|Negeri Katon
18.02.20.2007|Gedung Harta
18.02.20.2008|Tanjung Ratu
18.02.20.2009|Negeri Agung
18.02.20.2010|Gilih Karang Jati
18.02.20.2011|Marga Jaya
18.02.20.2012|Gedung Aji
18.02.20.2013|Negeri Jaya
18.02.20.2014|Mekar Harjo
18.02.21.2001|Srikaton
18.02.21.2002|Jaya Sakti
18.02.21.2003|Haji Pemanggilan
18.02.21.2004|Negara Bumi Ilir
18.02.21.2005|Bumi Aji
18.02.21.2006|Negara Aji Tua
18.02.21.2007|Negara Bumi Udik
18.02.21.2008|Negara Aji Baru
18.02.21.2009|Gunung Agung
18.02.21.2010|Tanjung Harapan
18.02.21.2011|Bumi Jaya
18.02.21.2012|Mulyo Haji
18.02.22.2001|Sendang Mulyo
18.02.22.2002|Sendang Rejo
18.02.22.2003|Sendang Baru
18.02.22.2004|Sendang Retno
18.02.22.2005|Sendang Asih
18.02.22.2006|Sendang Agung
18.02.22.2007|Sendang Asri
18.02.22.2008|Sendang Mukti
18.02.22.2009|Kutowinangun
18.02.23.2001|Sritejo Kencono
18.02.23.2002|Sapto Mulyo
18.02.23.2003|Nambah Rejo
18.02.23.2004|Sumber Rejo
18.02.23.2005|Purworejo
18.02.23.2006|Kota Gajah
18.02.23.2007|Kota Gajah Timur
18.02.24.2001|Sri Kencono
18.02.24.2002|Bumi Nabung Ilir
18.02.24.2003|Bumi Nabung Utara
18.02.24.2004|Bumi Nabung Selatan
18.02.24.2005|Bumi Nabung Timur
18.02.24.2006|Bumi Nabung Baru
18.02.24.2007|Sri Kencono Baru
18.02.25.2001|Sido Binangun
18.02.25.2002|Sri Bawono
18.02.25.2003|Sri Budaya
18.02.25.2004|Suko Binangun
18.02.25.2005|Sri Busono
18.02.25.2006|Sangga Buana
18.02.26.2001|Gaya Baru V
18.02.26.2002|Surabaya Ilir
18.02.26.2003|Rajawali
18.02.26.2004|Cempaka Putih
18.02.26.2005|Subang Jaya
18.02.26.2006|Cabang
18.02.26.2007|Beringin Jaya
18.02.26.2008|Sidodadi
18.02.26.2009|Sumber Agung
18.02.26.2010|Surabaya Baru
18.02.27.2001|Gedung Sari
18.02.27.2002|Srimulyo
18.02.27.2003|Gedung Ratu
18.02.27.2004|Bandar Putih Tua
18.02.27.2005|Karang Jawa
18.02.27.2006|Sukajaya
18.02.28.2001|Bina Karya Jaya
18.02.28.2002|Bina Karya Utama
18.02.28.2003|Bina Karya Sakti
18.02.28.2004|Joharan
18.02.28.2005|Rantau Jaya Baru
18.02.28.2006|Rantau Jaya Ilir
18.02.28.2007|Bina Karya Baru
18.02.28.2008|Meranggi Jaya
18.02.28.2009|Mekar Jaya
18.02.28.2010|Rantau Jaya makmur
18.03.01.1001|Bukit Kemuning
18.03.01.2002|Tanjung Baru
18.03.01.2003|Suka Menanti
18.03.01.2004|Muara Aman
18.03.01.2005|Tanjung Baru Timur
18.03.01.2006|Dwikora
18.03.01.2007|Tanjung Waras
18.03.01.2008|Sido Mulyo
18.03.02.1001|Kotabumi Udik
18.03.02.1002|Cempedak
18.03.02.1003|Rejosari
18.03.02.1004|Kotabumi Tengah
18.03.02.1005|Kotabumi Pasar
18.03.02.1006|Kotabumi Ilir
18.03.02.1007|Sindang Sari
18.03.02.1008|Sribasuki
18.03.02.1009|Kota Gapura
18.03.02.2010|Talang Bojong
18.03.02.2011|Sumber Arum
18.03.02.2012|Bojong Barat
18.03.02.2013|Kotabumi Tengah Barat
18.03.03.2002|Bumi Ratu
18.03.03.2003|Labuhan Ratu Pasar
18.03.03.2004|Sinar Galih
18.03.03.2005|Labuhan Ratu Kampung
18.03.03.2006|Gedung Ketapang
18.03.03.2007|Kota Agung
18.03.03.2008|Ketapang
18.03.03.2009|Karang Rejo I
18.03.03.2010|Banjar Ketapang
18.03.03.2017|Sidodadi
18.03.03.2023|Gunung Labuhan
18.03.04.2001|Karang Waringin
18.03.04.2002|Suka Sari
18.03.04.2003|Merambung
18.03.04.2004|Sinar Jaya
18.03.04.2005|Sindang Agung
18.03.04.2006|Mekar Jaya
18.03.04.2007|Sri Menanti
18.03.04.2008|Tulung Balak
18.03.04.2009|Tanjung Raja
18.03.04.2010|Tanjung Riang
18.03.04.2011|Kemala Raja
18.03.04.2012|Sindang Marga
18.03.04.2013|Ulak Ata
18.03.04.2014|Gunung Katon
18.03.04.2015|Suka Mulya
18.03.04.2016|Tanjung Beringin
18.03.04.2017|Sido Mulyo
18.03.04.2018|Sinar Mulya
18.03.04.2019|Priangan Baru
18.03.05.2001|Banjar Agung
18.03.05.2002|Bumi Agung Marga
18.03.05.2003|Pungguk Lama
18.03.05.2004|Gedung Nyapah
18.03.05.2005|Penagan Ratu
18.03.05.2006|Peraduan Waras
18.03.05.2007|Surakarta
18.03.05.2008|Rejo Mulyo
18.03.05.2009|Sidomukti
18.03.05.2010|Bumi Jaya
18.03.05.2011|Papan Rejo
18.03.05.2012|Sumber Agung
18.03.06.2005|Tanjung Harta
18.03.06.2006|Ogan Lima
18.03.06.2007|Hujan Mas
18.03.06.2008|Simpang Agung
18.03.06.2009|Bumi Nabung
18.03.06.2010|Kamplas
18.03.06.2011|Kistang
18.03.06.2012|Cahaya Negeri
18.03.06.2013|Lepang Besar
18.03.06.2016|Pengaringan
18.03.06.2017|Gunung Betuah
18.03.06.2021|Way Wakak
18.03.06.2023|Pematang Kasih
18.03.06.2024|Bumi Mandiri
18.03.07.2004|Trimodadi
18.03.07.2005|Cabang Empat
18.03.07.2006|Sinar Ogan
18.03.07.2007|Kalibalangan
18.03.07.2009|Gilih Sukanegeri
18.03.07.2010|Candimas
18.03.07.2011|Kembang Tanjung
18.03.07.2012|Abung Jayo
18.03.07.2013|Kembang Gading
18.03.07.2014|Ratu Abung
18.03.07.2015|Bandar Kagungan Raya
18.03.07.2016|Bumi Raya
18.03.07.2017|Kemalo Abung
18.03.07.2018|Cabang Abung Raya
18.03.07.2019|Kalibening Raya
18.03.07.2020|Way Lunik
18.03.08.2005|Ogan Jaya
18.03.08.2009|Ciamis
18.03.08.2010|Padang Ratu
18.03.08.2011|Negeri Sakti
18.03.08.2012|Negeri Ratu
18.03.08.2019|Negara Ratu
18.03.08.2020|Batu Raja
18.03.08.2021|Gedung Batin
18.03.08.2022|Negara Batin
18.03.08.2023|Kota Negara
18.03.08.2024|Bangun Jaya
18.03.08.2028|Baru Raharja
18.03.08.2029|Hanakau Jaya
18.03.08.2032|Negara Batin II
18.03.08.2033|Kota Negara Ilir
18.03.09.2001|Madukoro
18.03.09.2002|Kali Cinta
18.03.09.2003|Wono Marto
18.03.09.2004|Talang Jali
18.03.09.2005|Margo Rejo
18.03.09.2006|Banjar Wangi
18.03.09.2007|Sawo Jajar
18.03.09.2008|Madokoro Baru
18.03.10.1001|Kelapa Tujuh
18.03.10.1002|Tanjung Aman
18.03.10.1003|Kota Alam
18.03.10.1011|Tanjung Harapan
18.03.10.1012|Tanjung Senang
18.03.10.2004|Mulang Maya
18.03.10.2005|Bandar Putih
18.03.10.2006|Karang Agung
18.03.10.2007|Curup Guruh
18.03.10.2008|Jerangkang
18.03.10.2009|Way Melan
18.03.10.2010|Taman Jaya
18.03.10.2013|Alam Jaya
18.03.10.2014|Sinar Mas Alam
18.03.11.2001|Gunung Besar
18.03.11.2002|Kinciran
18.03.11.2003|Negla Sari
18.03.11.2004|Kedaton
18.03.11.2005|Sri Bandung
18.03.11.2006|Subik
18.03.11.2007|Gunung Sadar
18.03.11.2008|Gunung Gijul
18.03.11.2016|Pekurun Barat
18.03.11.2017|Pekurun Selatan
18.03.11.2018|Pekurun Utara
18.03.12.2001|Ulak Rengas
18.03.12.2002|Muara Dua
18.03.12.2003|Pulau Panggung
18.03.12.2004|Sekipi
18.03.12.2005|Sido Kayo
18.03.12.2006|Suka Marga
18.03.12.2007|Suka Maju
18.03.12.2008|Kebun Dalam
18.03.13.2001|Suka Maju
18.03.13.2002|Semuli Raya
18.03.13.2003|Semuli Jaya
18.03.13.2004|Papan Asri
18.03.13.2005|Gunung Keramat
18.03.13.2006|Sido Rahayu
18.03.13.2007|Gunung Sari
18.03.14.2001|Tatakarya
18.03.14.2002|Bandar Abung
18.03.14.2003|Bangun Sari
18.03.14.2004|Purba Sakti
18.03.14.2005|Bumi Raharja
18.03.14.2006|Bumi Restu
18.03.14.2007|Bandar Sakti
18.03.14.2008|Karya Sakti
18.03.14.2009|Sukoharjo
18.03.15.2001|Negeri Ujung Karang
18.03.15.2002|Bandar Agung
18.03.15.2003|Karang Sari
18.03.15.2004|Karang Rejo II
18.03.15.2005|Karang Sakti
18.03.15.2006|Karang Mulyo
18.03.15.2007|Banjar Negeri
18.03.15.2008|Banjar Ratu
18.03.15.2009|Negeri Ratu
18.03.15.2010|Pakuon Agung
18.03.15.2011|Sumber Agung
18.03.16.2001|Negara Tulang Bawang
18.03.16.2002|Kota Napal
18.03.16.2003|Tanah Abang
18.03.16.2004|Sukadana Udik
18.03.16.2005|Sukadana Ilir
18.03.16.2006|Haduyang Ratu
18.03.16.2007|Iso Rejo
18.03.16.2008|Mulyo Rejo II
18.03.16.2009|Tulang Bawang Baru
18.03.16.2010|Mulyo Rejo I
18.03.16.2011|Suka Maju
18.03.17.2001|Negera Kemakmuran
18.03.17.2002|Bonglai Tengah
18.03.17.2003|Tanjung Harapan
18.03.17.2004|Lubuk Rukam
18.03.17.2005|Ibul Jaya
18.03.17.2006|Beringin Jaya
18.03.17.2007|Gedung Makrifat
18.03.17.2008|Gedung Raja
18.03.17.2009|Gedung Negara
18.03.17.2010|Tulung Buyut
18.03.18.2001|Batu Nangkop
18.03.18.2002|Negara Bumi
18.03.18.2003|Melungun Ratu
18.03.18.2004|Negeri Campang Jaya
18.03.18.2005|Pampang Tangguk Jaya
18.03.18.2006|Negeri Galih Rejo
18.03.18.2007|Ratu Jaya
18.03.18.2008|Mekar Sari
18.03.19.2001|Nyapah Banyu
18.03.19.2002|Sinar Gunung
18.03.19.2003|Campang Gijul
18.03.19.2004|Sumber Tani
18.03.19.2005|Pekurun
18.03.19.2006|Ogan Campang
18.03.19.2007|Pekurun Tengah
18.03.19.2008|Pekurun Udik
18.03.19.2009|Ogan Jaya
18.03.20.2001|Cempaka
18.03.20.2002|Sri Agung
18.03.20.2003|Lepang Tengah
18.03.20.2004|Cahaya Makmur
18.03.20.2005|Suka Jaya
18.03.20.2006|Sri Jaya
18.03.20.2007|Negara Agung
18.03.20.2008|Cempaka Barat
18.03.20.2009|Cempaka Timur
18.03.21.2001|Sinar Harapan
18.03.21.2002|Kubu Hitu
18.03.21.2003|Negeri Sakti
18.03.21.2004|Tanjung Jaya
18.03.21.2005|Gunung Raja
18.03.21.2006|Cahaya Mas
18.03.21.2007|Comok Sinar Jaya
18.03.21.2008|Way Isem
18.03.21.2009|Gunung Maknibai
18.03.21.2010|Negeri Batin Jaya
18.03.22.2001|Aji Kagungan
18.03.22.2002|Talang Jembatan
18.03.22.2003|Sabuk Empat
18.03.22.2004|Beringin
18.03.22.2005|Sabuk Indah
18.03.22.2006|Bindu
18.03.22.2007|Way Perancang
18.03.23.2001|Pagar
18.03.23.2002|Blambangan
18.03.23.2003|Jagang
18.03.23.2004|Tanjung Iman
18.03.23.2005|Tulung Singkip
18.03.23.2006|Pagar Gading
18.03.23.2007|Buring Kencana
18.04.04.1001|Pasar Liwa
18.04.04.1003|Way Mengaku
18.04.04.2002|Kubu Perahu
18.04.04.2004|Padang Cahya
18.04.04.2005|Sebarus
18.04.04.2006|Way Empulau Ulu
18.04.04.2007|Gunung Sugih
18.04.04.2008|Wates
18.04.04.2009|Padang Dalom
18.04.04.2010|Sukarame
18.04.04.2011|Bahway
18.04.04.2012|Sedampah Indah
18.04.05.1016|Tugu Sari
18.04.05.2001|Simpangsari
18.04.05.2010|Sukajaya
18.04.05.2011|Sindang Pagar
18.04.05.2012|Sukapura
18.04.05.2013|Way Petai
18.04.06.2001|Kenali
18.04.06.2002|Kejadian
18.04.06.2003|Bumi Agung
18.04.06.2004|Turgak
18.04.06.2005|Bedudu
18.04.06.2006|Sukarame
18.04.06.2007|Hujung
18.04.06.2013|Serungkuk
18.04.06.2019|Suka Makmur
18.04.06.2020|Fajar Agung
18.04.07.1001|Pajar Bulan
18.04.07.2002|Puralaksana
18.04.07.2003|Karang Agung
18.04.07.2004|Mutar Alam
18.04.07.2005|Tanjungraya
18.04.07.2006|Sukananti
18.04.07.2007|Sukaraja
18.04.07.2008|Padang Tambak
18.04.07.2009|Tambak Jaya
18.04.08.1005|Sekincau
18.04.08.2001|Pampangan
18.04.08.2006|Waspada
18.04.08.2007|Tigajaya
18.04.08.2008|Giham Sukamaju
18.04.09.2003|Suka Marga
18.04.09.2004|Sumber Agung
18.04.09.2005|Tugu Ratu
18.04.09.2006|Banding Agung
18.04.09.2010|Rowo Rejo
18.04.09.2017|Sido Rejo
18.04.09.2018|Ringin Sari
18.04.10.2001|Kembahang
18.04.10.2002|Negeri Ratu
18.04.10.2003|Kegeringan
18.04.10.2004|Gunung Sugih
18.04.10.2005|Pekon Balak
18.04.10.2006|Sukabumi
18.04.10.2007|Canggu
18.04.10.2008|Kotabesi
18.04.10.2009|Sukaraja
18.04.10.2010|Kerang
18.04.10.2011|Teba Liokh
18.04.11.2001|Tanjung Raya
18.04.11.2002|Hanakau
18.04.11.2003|Buay Nyerupa
18.04.11.2004|Tapak Siring
18.04.11.2005|Jaga Raga
18.04.11.2009|Pagar Dewa
18.04.11.2012|Suka Mulya
18.04.11.2018|Bandar Baru
18.04.11.2019|Bumi Jaya
18.04.11.2020|Teba Pering Jaya
18.04.15.2001|Gedung Surian
18.04.15.2002|Puramekar
18.04.15.2003|Ciptawaras
18.04.15.2004|Trimulyo
18.04.15.2005|Mekarjaya
18.04.18.2001|Pura Jaya
18.04.18.2002|Pura Wiwitan
18.04.18.2003|Tribudi Syukur
18.04.18.2004|Muara Jaya I
18.04.18.2005|Muara Jaya II
18.04.18.2006|Tri Budi Makmur
18.04.18.2007|Tugu Mulya
18.04.18.2008|Cipta Mulya
18.04.18.2009|Muara Baru
18.04.18.2010|Sinar Luas
18.04.19.2001|Sidodadi
18.04.19.2002|Semarang Jaya
18.04.19.2003|Sumber Alam
18.04.19.2004|Gunungterang
18.04.19.2005|Suka Jadi
18.04.19.2006|Sri Menanti
18.04.19.2007|Sinar Jaya
18.04.19.2008|Rigis Jaya
18.04.19.2009|Suka Damai
18.04.19.2010|Manggarai
18.04.20.2001|Pahayu Jaya
18.04.20.2002|Basungan
18.04.20.2003|Mekar Sari
18.04.20.2004|Sidomulyo
18.04.20.2005|Sidodadi
18.04.20.2006|Marga Jaya
18.04.20.2007|Suka Jaya
18.04.20.2008|Batu Api
18.04.20.2009|Pagar Dewa
18.04.20.2010|Suka Mulya
18.04.21.2001|Argomulyo
18.04.21.2002|Batu Kebayan
18.04.21.2003|Atar Bawang
18.04.21.2004|Campang Tiga
18.04.21.2005|Luas
18.04.21.2006|Bakhu
18.04.21.2007|Way Ngison
18.04.21.2008|Kubu Liku Jaya
18.04.21.2009|Sumber Rejo
18.04.21.2010|Atar Kuwau
18.04.22.2001|Lombok
18.04.22.2002|Heni Arong
18.04.22.2003|Suka Banjar
18.04.22.2004|Lombok Timur
18.04.22.2005|Suka Banjar II Ujung Rembun
18.04.22.2006|Suka Maju
18.04.22.2007|Ujung
18.04.22.2008|Keagungan
18.04.22.2009|Tawan Suka Mulya
18.04.22.2010|Pancur Mas
18.04.22.2011|Lombok Selatan
18.04.23.2001|Suoh
18.04.23.2002|Srimulyo
18.04.23.2003|Bandar Agung
18.04.23.2004|Ringin Jaya
18.04.23.2005|Bumi Hantatai
18.04.23.2006|Gunung Ratu
18.04.23.2007|Tanjung Sari
18.04.23.2008|Negeri Jaya
18.04.23.2009|Tembelang
18.04.23.2010|Tri Mekar Jaya
18.05.02.1008|Menggala Selatan
18.05.02.1009|Ujung Gunung
18.05.02.1010|Menggala Tengah
18.05.02.1011|Menggala Kota
18.05.02.2001|Bujung Tenuk
18.05.02.2002|Ujung Gunung Ilir
18.05.02.2007|Astra Ksetra
18.05.02.2013|Kagungan Rahayu
18.05.02.2014|Tiuh Tohou
18.05.06.2001|Aji Jaya KNPI
18.05.06.2002|Kecubung Jaya
18.05.06.2008|Kecubung Mulya
18.05.06.2015|Gedung Aji
18.05.06.2016|Penawar
18.05.06.2022|Penawar Baru
18.05.06.2023|Aji Murni Jaya
18.05.06.2024|Aji Mesir
18.05.06.2025|Aji Permai Talang Buah
18.05.06.2026|Bandar Aji Jaya
18.05.08.2001|Banjar Agung
18.05.08.2007|Tri Darma Wirajaya
18.05.08.2009|Moris Jaya
18.05.08.2010|Tunggal Warga
18.05.08.2011|Dwi Warga Tunggal Jaya
18.05.08.2019|Tri Mulya Jaya
18.05.08.2020|Tri Mukti Jaya
18.05.08.2021|Tri Tunggal Jaya
18.05.08.2022|Warga Makmur Jaya
18.05.08.2023|Warga Indah Jaya
18.05.08.2024|Banjar Dewa
18.05.11.2001|Gunung Tapa
18.05.11.2002|Gedung Meneng
18.05.11.2006|Bakung Udik
18.05.11.2007|Bakung Ilir
18.05.11.2008|Gedung Bandar Rahayu
18.05.11.2014|Gunung Tapa Ilir
18.05.11.2015|Gunung Tapa Tengah
18.05.11.2016|Gunung Tapa Udik
18.05.11.2017|Gedung Bandar Rejo
18.05.11.2018|Bakung Rahayu
18.05.11.2019|Gedung Meneng Baru
18.05.12.2003|Yudha Karya Jitu
18.05.12.2004|Gedung Karya Jitu
18.05.12.2005|Hargo Rejo
18.05.12.2006|Wono Agung
18.05.12.2008|Karya Jitu Mukti
18.05.12.2009|Bumi Ratu
18.05.12.2010|Medasari
18.05.12.2013|Hargo Mulyo
18.05.12.2014|Karya Cipta Abadi
18.05.13.2001|Tri Rejo Mulyo
18.05.13.2002|Tri Jaya
18.05.13.2005|Sidoharjo
18.05.13.2006|Sido Mulyo
18.05.13.2010|Boga Tama
18.05.13.2011|Wira Tama
18.05.13.2013|Tri Tunggal Jaya
18.05.13.2019|Pulo Gadung
18.05.13.2020|Sidodadi
18.05.13.2021|Dwimulyo
18.05.13.2022|Rejo Sari
18.05.13.2023|Wira Agung Sari
18.05.13.2024|Sidomakmur
18.05.13.2025|Trikarya
18.05.18.2001|Bumi Dipasena Utama
18.05.18.2002|Bumi Dipasena Agung
18.05.18.2003|Bumi Dipasena Jaya
18.05.18.2004|Bumi Dipasena Abadi
18.05.18.2005|Bumi Dipasena Makmur
18.05.18.2006|Bumi Sentosa
18.05.18.2007|Bumi Dipasena Mulya
18.05.18.2008|Bumi Dipasena Sejahtera
18.05.20.2001|Bujuk Agung
18.05.20.2002|Ringin Sari
18.05.20.2003|Suka Maju
18.05.20.2004|Catur Karya Buana Jaya
18.05.20.2005|Purwa Jaya
18.05.20.2006|Penawar Jaya
18.05.20.2007|Agung Dalam
18.05.20.2008|Sumber Makmur
18.05.20.2009|Tri Tunggal Jaya
18.05.20.2010|Agung Jaya
18.05.20.2011|Penawar Rejo
18.05.20.2012|Mekar Jaya
18.05.22.2001|Sumber Agung
18.05.22.2002|Batang Hari
18.05.22.2003|Panggung Mulyo
18.05.22.2004|Duto Yoso Mulyo
18.05.22.2005|Andalas Cermin
18.05.22.2006|Rawa Ragil
18.05.22.2007|Gedung Jaya
18.05.22.2008|Bumi Sari
18.05.22.2009|Mulyo Dadi
18.05.23.2001|Gedung Harapan
18.05.23.2002|Gedung Asri
18.05.23.2003|Gedung Rejo Sakti
18.05.23.2004|Pasar Batang
18.05.23.2005|Suka Makmur
18.05.23.2006|Karya Makmur
18.05.23.2007|Wono Rejo
18.05.23.2008|Panca Tunggal Jaya
18.05.23.2009|Sumber Sari
18.05.25.2001|Teladas
18.05.25.2002|Kekatung
18.05.25.2003|Kuala Teladas
18.05.25.2004|Mahabang
18.05.25.2005|Sungai Nibung
18.05.25.2006|Pasiran Jaya
18.05.25.2007|Bratasena Adiwarna
18.05.25.2008|Bratasena Mandiri
18.05.25.2009|Way Dente
18.05.25.2010|Dente Makmur
18.05.25.2011|Pendowo Asri
18.05.25.2012|Sungai Burung
18.05.26.2001|Bangun Rejo
18.05.26.2002|Paduan Rajawali
18.05.26.2003|Karya Bhakti
18.05.26.2004|Sukarame
18.05.26.2005|Bina Bumi
18.05.26.2006|Mulyo Aji
18.05.26.2007|Kecubung Raya
18.05.26.2008|Marga Jaya
18.05.27.2001|Sidomukti
18.05.27.2002|Mesir Dwi Jaya
18.05.27.2003|Makartitama
18.05.27.2004|Suka Bhakti
18.05.27.2005|Batu Ampar
18.05.27.2006|Setia Tama
18.05.27.2007|Sumber Jaya
18.05.27.2008|Mekar Asri
18.05.27.2009|Sidomekar
18.05.29.2001|Panca Mulia
18.05.29.2002|Panca Karsa Purna Jaya
18.05.29.2003|Kahuripan Jaya
18.05.29.2004|Bawang Sakti Jaya
18.05.29.2005|Mekar Jaya
18.05.29.2006|Balai Murni Jaya
18.05.29.2007|Mekar Indah Jaya
18.05.29.2008|Jaya Makmur
18.05.29.2009|Bawang Tirto Mulyo
18.05.29.2010|Karya Murni Jaya
18.05.30.2001|Lebuh Dalem
18.05.30.2002|Menggala
18.05.30.2003|Lingai
18.05.30.2004|Kibang Pacing
18.05.30.2005|Sungai Luar
18.05.30.2006|Kahuripan Dalam
18.05.30.2007|Cempaka Dalem
18.05.30.2008|Bedaro Indah
18.05.30.2009|Tri Makmur Jaya
18.05.30.2010|Cempaka Jaya
18.06.01.1001|Baros
18.06.01.1002|Pasar Madang
18.06.01.1003|Kuripan
18.06.01.2016|Negeri Ratu
18.06.01.2019|Penanggungan
18.06.01.2020|Terdana
18.06.01.2021|Kelungu
18.06.01.2022|Pardasuka
18.06.01.2023|Teratas
18.06.01.2024|Kusa
18.06.01.2025|Terbaya
18.06.01.2026|Kedamaian
18.06.01.2027|Kota Agung
18.06.01.2039|Kota Batu
18.06.01.2040|Campang Tiga
18.06.01.2041|Benteng Jaya
18.06.02.2012|Kalibening
18.06.02.2015|Kejayaan
18.06.02.2016|Suka Bumi
18.06.02.2017|Suka Negeri Jaya
18.06.02.2018|Banjar Sari
18.06.02.2019|Singosari
18.06.02.2020|Sinar Banten
18.06.02.2021|Sukarame
18.06.02.2022|Banding Agung
18.06.02.2023|Talang Padang
18.06.02.2024|Suka Negeri
18.06.02.2025|Suka Bandung
18.06.02.2026|Suka Merindu
18.06.02.2027|Sinar Semendo
18.06.02.2028|Negeri Agung
18.06.02.2029|Sinar Petir
18.06.02.2030|Way Halom
18.06.02.2031|Talang Sepuh
18.06.02.2032|Sinar Harapan
18.06.02.2033|Sinar Betung
18.06.03.2001|Karang Anyar
18.06.03.2002|Kalirejo
18.06.03.2003|Dadirejo
18.06.03.2004|Banyu Urip
18.06.03.2005|Wonosobo
18.06.03.2006|Soponyono
18.06.03.2007|Bandar Kejadian
18.06.03.2008|Way Panas
18.06.03.2009|Sinar Saudara
18.06.03.2010|Sridadi
18.06.03.2011|Lakaran
18.06.03.2012|Padang Ratu
18.06.03.2013|Pardasuka
18.06.03.2014|Tanjung Kurung
18.06.03.2015|Padang Manis
18.06.03.2016|Kejadian
18.06.03.2017|Dadisari
18.06.03.2018|Kalisari
18.06.03.2019|Banjar Negoro
18.06.03.2020|Pekon Balak
18.06.03.2021|Kunyayan
18.06.03.2022|Banjar Sari
18.06.03.2023|Negeri Ngarip
18.06.03.2034|Dadimulyo
18.06.03.2035|Sampang Turus
18.06.03.2036|Sri Melati
18.06.03.2037|Way Liwok
18.06.03.2038|Sumur Tujuh
18.06.04.2001|Talang Beringin
18.06.04.2002|Gunung Megang
18.06.04.2003|Tanjung Rejo
18.06.04.2004|Tanjung Begelung
18.06.04.2005|Sinar Mulyo
18.06.04.2006|Kemuning
18.06.04.2007|Gedung Agung
18.06.04.2008|Penantian
18.06.04.2009|Muara Dua
18.06.04.2010|Tekad
18.06.04.2011|Pulau Panggung
18.06.04.2012|Gunung Meraksa
18.06.04.2013|Way Ilahan
18.06.04.2014|Batu Bedil
18.06.04.2015|Air Bakoman
18.06.04.2025|Sumber Mulya
18.06.04.2026|Sindang Marga
18.06.04.2027|Talang Jawa
18.06.04.2028|Srimanganten
18.06.04.2029|Tanjung Gunung
18.06.04.2030|Sinar Mancak
18.06.09.2001|Karang Buah
18.06.09.2002|Sawang Balak
18.06.09.2003|Way Rilau
18.06.09.2004|Tanjung Raja
18.06.09.2005|Tengor
18.06.09.2006|Tanjung Jati
18.06.09.2007|Kejadian Lom
18.06.09.2008|Sukaraja
18.06.09.2009|Banjar Negeri
18.06.09.2010|Gedung
18.06.09.2011|Suka Padang
18.06.09.2012|Kacamarga
18.06.09.2013|Pampangan
18.06.09.2014|Banjar Manis
18.06.09.2015|Tanjung Betuah
18.06.09.2016|Putih Doh
18.06.09.2017|Pekondoh
18.06.09.2028|Kubulangka
18.06.09.2029|Kutakakhang
18.06.09.2030|Suka Banjar
18.06.11.2001|Rantau Tijang
18.06.11.2002|Tiuh Memon
18.06.11.2003|Banjar Agung Udik
18.06.11.2004|Tanjung Heran
18.06.11.2005|Sumanda
18.06.11.2006|Campang Way Handak
18.06.11.2007|Taman Sari
18.06.11.2008|Sukajadi
18.06.11.2009|Binjai Wangi
18.06.11.2010|Tanjung Kemala
18.06.11.2011|Tanjung Agung
18.06.11.2012|Babakan
18.06.11.2013|Negeri Ratu
18.06.11.2014|Sinar Agung
18.06.11.2015|Tangkit Serdang
18.06.11.2016|Gunung Kasih
18.06.11.2017|Way Jaha
18.06.11.2018|Banjar Agung Ilir
18.06.11.2019|Gading
18.06.11.2020|Way Pring
18.06.11.2021|Pungkut
18.06.11.2022|Gunung Tiga
18.06.11.2023|Way Manak
18.06.11.2024|Sukamaju
18.06.11.2025|Suka Mulya
18.06.11.2026|Kayuhubi
18.06.11.2027|Talang Lebar
18.06.12.2001|Tugu Papak
18.06.12.2002|Kacapura
18.06.12.2003|Sukaraja
18.06.12.2004|Bangun Rejo
18.06.12.2005|Tugu Rejo
18.06.12.2006|Sidodadi
18.06.12.2007|Garut
18.06.12.2008|Karang Rejo
18.06.12.2009|Kanoman
18.06.12.2010|Sudimoro
18.06.12.2011|Sudimoro Bangun
18.06.12.2012|Sri Purnomo
18.06.12.2013|Sri Kuncoro
18.06.12.2014|Sidomulyo
18.06.12.2015|Karang Agung
18.06.12.2016|Tulung Asahan
18.06.12.2017|Sri Katon
18.06.12.2018|Pardawaras
18.06.12.2019|Sedayu
18.06.12.2020|Way Kerap
18.06.12.2021|Margomulyo
18.06.12.2022|Sukajaya
18.06.13.2001|Kebumen
18.06.13.2002|Sidomulyo
18.06.13.2003|Sumber Rejo
18.06.13.2004|Tegal Binangun
18.06.13.2005|Argopeni
18.06.13.2006|Margodadi
18.06.13.2007|Margoyoso
18.06.13.2008|Dadapan
18.06.13.2009|Simpang Kanan
18.06.13.2010|Wonoharjo
18.06.13.2011|Sumber Mulyo
18.06.13.2012|Argomulyo
18.06.13.2013|Sidorejo
18.06.15.2001|Datarajan
18.06.15.2002|Gunung Tiga
18.06.15.2003|Karang Rejo
18.06.15.2004|Pagar Alam Ulu Belu
18.06.15.2005|Muara Dua Ulu Belu
18.06.15.2006|Ngarip
18.06.15.2007|Penantian Ulu Belu
18.06.15.2008|Gunung Sari
18.06.15.2009|Ulu Semong
18.06.15.2010|Sirna Galih
18.06.15.2011|Rejo Sari
18.06.15.2012|Sukamaju
18.06.15.2013|Tanjung Baru
18.06.15.2014|Sinar Banten
18.06.15.2015|Air Abang
18.06.15.2016|Petay Kayu
18.06.16.2001|Tampang Tua
18.06.16.2002|Kaur Gading
18.06.16.2003|Tirom
18.06.16.2004|Way Nipah
18.06.16.2005|Guring
18.06.16.2006|Betung
18.06.16.2007|Tanjungan
18.06.16.2009|Teluk Brak
18.06.16.2010|Karang Brak
18.06.16.2011|Pesanguan
18.06.16.2012|Way Asahan
18.06.16.2013|Tampang Muda
18.06.16.2014|Kampung Baru
18.06.16.2015|Martanda
18.06.17.2001|Negeri Kelumbayan
18.06.17.2002|Pekon Susuk
18.06.17.2003|Napal
18.06.17.2005|Pekon Unggak
18.06.17.2006|Penyandingan
18.06.17.2009|Paku
18.06.17.2010|Umbar
18.06.17.2012|Kiluan Negeri
18.06.18.2001|Belu
18.06.18.2002|Negara Batin
18.06.18.2003|Banjar Masin
18.06.18.2004|Kanyangan
18.06.18.2005|Kandang Besi
18.06.18.2006|Teba Bunuk
18.06.18.2007|Way Gelang
18.06.18.2008|Tala Gening
18.06.18.2009|Gedung Jambu
18.06.18.2010|Maja
18.06.18.2011|Pulau Benawang
18.06.18.2012|Payung
18.06.18.2013|Kesugihan
18.06.18.2014|Pejajaran
18.06.18.2015|Kalimiring
18.06.18.2016|Tanjung Agung
18.06.19.2001|Batu Kramat
18.06.19.2002|Kampung Baru
18.06.19.2003|Umbul Buah
18.06.19.2004|Menggala
18.06.19.2005|Mulang Maya
18.06.19.2006|Sukabanjar
18.06.19.2007|Tanjung Anom
18.06.19.2008|Kagungan
18.06.19.2009|Kerta
18.06.19.2010|Teba
18.06.19.2011|Talang Rejo
18.06.19.2012|Tanjung Jati
18.06.20.2001|Banjar Manis
18.06.20.2002|Campang
18.06.20.2003|Kuta Dalom
18.06.20.2004|Purwodadi
18.06.20.2005|Gisting Bawah
18.06.20.2006|Gisting Atas
18.06.20.2007|Sidokaton
18.06.20.2008|Landbaw
18.06.20.2009|Gisting Permai
18.06.21.2001|Banjar Negeri
18.06.21.2002|Sukaraja
18.06.21.2003|Banjar Agung
18.06.21.2004|Kedaloman
18.06.21.2005|Sukabanjar
18.06.21.2006|Sukamernah
18.06.21.2007|Ciherang
18.06.21.2008|Pariaman
18.06.21.2009|Sukadamai
18.06.21.2010|Way Halom
18.06.21.2011|Penanggungan
18.06.21.2012|Darussalam
18.06.24.2001|Badak
18.06.24.2002|Kuripan
18.06.24.2003|Padang Ratu
18.06.24.2004|Tegineneng
18.06.24.2005|Ketapang
18.06.24.2006|Banjar Agung
18.06.24.2007|Pekon Ampai
18.06.24.2008|Pariaman
18.06.24.2009|Atar Brak
18.06.24.2010|Tanjung Siom
18.06.24.2011|Tanjung Jaya
18.06.25.2001|Negeri Agung
18.06.25.2002|Bandar Sukabumi
18.06.25.2003|Sanggi
18.06.25.2004|Rajabasa
18.06.25.2005|Banding
18.06.25.2006|Gunung Doh
18.06.25.2007|Simpang Bayur
18.06.25.2008|Atar Lebar
18.06.25.2009|Sinar Bangun
18.06.25.2010|Sanggi Unggak
18.06.25.2011|Tulung Sari
18.06.26.2001|Way Harong
18.06.26.2002|Air Kubang
18.06.26.2003|Karang Sari
18.06.26.2004|Sidomulyo
18.06.26.2005|Air Naningan
18.06.26.2006|Datar Lebuay
18.06.26.2007|Sinar Jawa
18.06.26.2008|Batu Tegi
18.06.26.2009|Sinar Sekampung
18.06.26.2010|Margomulyo
18.06.27.2001|Sukamara
18.06.27.2002|Sukanegara
18.06.27.2003|Banjarmasin
18.06.27.2004|Suka Agung Barat
18.06.27.2005|Suka Agung
18.06.27.2006|Gunung Terang
18.06.27.2007|Napal
18.06.27.2008|Sinar Petir
18.06.27.2009|Pematang Nebak
18.06.27.2010|Tanjung Sari
18.06.28.2001|Lengkukai
18.06.28.2002|Sidoharjo
18.06.28.2003|Merbau
18.06.28.2004|Batu Patah
18.06.28.2005|Purwosari
18.06.28.2006|Marga Mulya
18.07.01.2001|Sukadana
18.07.01.2002|Pakuan Aji
18.07.01.2003|Bumi Nabung Udik
18.07.01.2004|Rajabasa Batanghari
18.07.01.2005|Negara Nabung
18.07.01.2006|Terbangi Marga
18.07.01.2007|Mataram Marga
18.07.01.2008|Pasar Sukadana
18.07.01.2009|Surabaya Udik
18.07.01.2010|Rantau Jaya Udik
18.07.01.2011|Muara Jaya
18.07.01.2012|Sukadana Ilir
18.07.01.2013|Bumi Ayu
18.07.01.2014|Sukadana Timur
18.07.01.2015|Rantau Jaya Udik II
18.07.01.2016|Putra Aji II
18.07.01.2017|Putra Aji I
18.07.01.2018|Sukadana Selatan
18.07.01.2019|Sukadana Jaya
18.07.01.2020|Sukadana Tengah
18.07.02.2001|Labuhan Maringgai
18.07.02.2002|Muara Gading Mas
18.07.02.2003|Sriminosari
18.07.02.2004|Bandar Negeri
18.07.02.2005|Karya Makmur
18.07.02.2006|Karya Tani
18.07.02.2007|Margasari
18.07.02.2008|Sukorahayu
18.07.02.2009|Srigading
18.07.02.2010|Karang Anyar
18.07.02.2011|Maringgai
18.07.03.2001|Negara Batin
18.07.03.2002|Asahan
18.07.03.2003|Adirejo
18.07.03.2004|Gunung Mekar
18.07.03.2005|Gunung Sugih Kecil
18.07.03.2006|Pematang Tahalo
18.07.03.2007|Jabung
18.07.03.2008|Negara Saka
18.07.03.2014|Betengsari
18.07.03.2015|Belimbing Sari
18.07.03.2016|Mekar Jaya
18.07.03.2018|Mumbang Jaya
18.07.03.2019|Tanjung Sari
18.07.03.2020|Adi Luhur
18.07.03.2021|Sambirejo
18.07.04.2001|Pekalongan
18.07.04.2002|Adirejo
18.07.04.2003|Sidodadi
18.07.04.2004|Gondangrejo
18.07.04.2005|Siraman
18.07.04.2006|Tulusrejo
18.07.04.2007|Jojog
18.07.04.2008|Ganti Warno
18.07.04.2009|Kalibening
18.07.04.2010|Wonosari
18.07.04.2011|Gantimulyo
18.07.04.2012|Adijaya
18.07.05.2001|Sumber Gede
18.07.05.2002|Sidomukti
18.07.05.2003|Sidomulyo
18.07.05.2004|Trimulyo
18.07.05.2005|Girikarto
18.07.05.2006|Hargomulyo
18.07.05.2007|Wonokarto
18.07.05.2008|Sukoharjo
18.07.05.2009|Giriklopomulyo
18.07.05.2010|Sidodadi
18.07.05.2011|Sambikarto
18.07.05.2012|Sumber Sari
18.07.05.2013|Karya Mukti
18.07.05.2014|Mekar Mulya
18.07.05.2015|Jadi Mulyo
18.07.05.2016|Mekar Mukti
18.07.05.2017|Mekar Sari
18.07.06.2001|Banarjoyo
18.07.06.2002|Buana Sakti
18.07.06.2003|Balekencono
18.07.06.2004|Rejo Agung
18.07.06.2005|Adiwarno
18.07.06.2006|Telogorejo
18.07.06.2007|Nampirejo
18.07.06.2008|Sumberejo
18.07.06.2009|Banjarejo
18.07.06.2010|Balerejo
18.07.06.2011|Batangharjo
18.07.06.2012|Bumi Harjo
18.07.06.2013|Bumi Mas
18.07.06.2014|Selorejo
18.07.06.2015|Sri Basuki
18.07.06.2016|Sumber Agung
18.07.06.2017|Purwodadi Mekar
18.07.07.2001|Braja Sakti
18.07.07.2002|Braja Fajar
18.07.07.2003|Braja Emas
18.07.07.2004|Braja Dewa
18.07.07.2005|Braja Caka
18.07.07.2006|Sri Wangi
18.07.07.2007|Jepara
18.07.07.2008|Sri Rejosari
18.07.07.2009|Sumberejo
18.07.07.2010|Labuhan Ratu II
18.07.07.2011|Braja Asri
18.07.07.2012|Labuhan Ratu I
18.07.07.2013|Sumur Bandung
18.07.07.2014|Sumber Marga
18.07.07.2015|Labuhan Ratu Danau
18.07.07.2016|Labuhan Ratu Baru
18.07.08.2001|Taman Fajar
18.07.08.2002|Taman Asri
18.07.08.2003|Taman Bogo
18.07.08.2004|Tambah Dadi
18.07.08.2005|Taman Cari
18.07.08.2006|Taman Endah
18.07.08.2007|Tegal Gondo
18.07.08.2008|Toto Harjo
18.07.08.2009|Tanjung Inten
18.07.08.2010|Tegal Yoso
18.07.08.2011|Tambah Luhur
18.07.08.2012|Tanjung Kesuma
18.07.09.2001|Kota Raman
18.07.09.2002|Raman Aji
18.07.09.2003|Rukti Sedyo
18.07.09.2004|Ratna Daya
18.07.09.2005|Rejo Binangun
18.07.09.2006|Rantau Fajar
18.07.09.2007|Raman Endra
18.07.09.2008|Raman Fajar
18.07.09.2009|Restu Rahayu
18.07.09.2010|Rejo Katon
18.07.09.2011|Rama Puja
18.07.10.2001|Kibang
18.07.10.2002|Marga Jaya
18.07.10.2003|Margototo
18.07.10.2004|Purbosembodo
18.07.10.2005|Sumber Agung
18.07.10.2006|Margasari
18.07.10.2007|Jaya Asri
18.07.11.2001|Tanjung Harapan
18.07.11.2002|Negeri Tua
18.07.11.2003|Negeri Katon
18.07.11.2004|Negeri Agung
18.07.11.2005|Negeri Jemanten
18.07.11.2006|Sukaraja Tiga
18.07.11.2007|Gedung Wani
18.07.11.2008|Jaya Guna
18.07.11.2009|Sukadana Baru
18.07.11.2010|Nabang Baru
18.07.11.2011|Surya Mataram
18.07.11.2012|Gedungwani Timur
18.07.11.2013|Trisinar
18.07.12.2001|Pugung Raharjo
18.07.12.2002|Mengandung Sari
18.07.12.2003|Toba
18.07.12.2004|Banjar Agung
18.07.12.2005|Bojong
18.07.12.2006|Gunung Agung
18.07.12.2007|Sindang Anom
18.07.12.2008|Bauh Gunung Sari
18.07.12.2009|Gunung Pasir Jaya
18.07.12.2010|Gunung Sugih Besar
18.07.12.2011|Sidorejo
18.07.12.2012|Brawijaya
18.07.12.2013|Gunung Mulyo
18.07.12.2014|Bumi Mulyo
18.07.12.2015|Purwokencono
18.07.13.2001|Sukaraja Nuban
18.07.13.2002|Purwosari
18.07.13.2003|Tulung Balak
18.07.13.2004|Kedaton
18.07.13.2005|Kedaton I
18.07.13.2006|Kedaton II
18.07.13.2007|Trisnomulyo
18.07.13.2008|Cempaka Nuban
18.07.13.2009|Gedung Dalem
18.07.13.2010|Bumi Jawa
18.07.13.2011|Gunung Tiga
18.07.13.2012|Negara Ratu
18.07.13.2013|Sukacari
18.07.14.2001|Donomulyo
18.07.14.2002|Nyampir
18.07.14.2003|Bumi Tinggi
18.07.14.2004|Lehan
18.07.14.2005|Marga Mulya
18.07.14.2006|Catur Swako
18.07.14.2007|Mulyo Asri
18.07.15.2001|Sribhawono
18.07.15.2002|Sadar Sriwijaya
18.07.15.2003|Srimenanti
18.07.15.2004|Sripendowo
18.07.15.2005|Waringin Jaya
18.07.15.2006|Bandar Agung
18.07.15.2007|Mekar Jaya
18.07.16.2001|Mataram Baru
18.07.16.2002|Rajabasa Baru
18.07.16.2003|Teluk Dalem
18.07.16.2004|Way Areng
18.07.16.2005|Tulung Pasik
18.07.16.2006|Mandala Sari
18.07.16.2007|Kebon Damar
18.07.17.2001|Wana
18.07.17.2002|Tanjung Aji
18.07.17.2003|Tebing
18.07.17.2004|Sido Makmur
18.07.17.2005|Itik Renday
18.07.17.2006|Sumber Hadi
18.07.18.2001|Negeri Agung
18.07.18.2002|Pempen
18.07.18.2003|Way Mili
18.07.18.2004|Pelindung Jaya
18.07.18.2005|Nibung
18.07.19.2001|Pasir Sakti
18.07.19.2002|Mulyo Sari
18.07.19.2003|Purworejo
18.07.19.2004|Rejo Mulyo
18.07.19.2005|Kedung Ringin
18.07.19.2006|Labuhan Ratu
18.07.19.2007|Sumur Kucing
18.07.19.2008|Mekar Sari
18.07.20.2001|Sumberejo
18.07.20.2002|Ngesti Karya
18.07.20.2003|Tri Tunggal
18.07.20.2004|Sidorahayu
18.07.20.2005|Jembrana
18.07.20.2006|Tanjung Wangi
18.07.20.2007|Marga Batin
18.07.20.2008|Mekar Karya
18.07.20.2009|Sumber Jaya
18.07.20.2010|Karang Anom
18.07.20.2011|Karya Basuki
18.07.21.2001|Labuhan Ratu
18.07.21.2002|Labuhan Ratu III
18.07.21.2003|Labuhan Ratu IV
18.07.21.2004|Labuhan Ratu V
18.07.21.2005|Labuhan Ratu VI
18.07.21.2006|Rajabasa Lama
18.07.21.2007|Rajabasa Lama I
18.07.21.2008|Rajabasa Lama II
18.07.21.2009|Labuhan Ratu VII
18.07.21.2010|Labuhan Ratu VIII
18.07.21.2011|Labuhan Ratu IX
18.07.22.2001|Braja Harjosari
18.07.22.2002|Braja Gemilang
18.07.22.2003|Braja Indah
18.07.22.2004|Braja Yekti
18.07.22.2005|Braja Kencana
18.07.22.2006|Braja Luhur
18.07.22.2007|Braja Mulya
18.07.23.2001|Tambah Subur
18.07.23.2002|Tanjung Qencono
18.07.23.2003|Tanjung Tirto
18.07.23.2004|Toto Mulyo
18.07.23.2005|Toto Projo
18.07.23.2006|Taman Negeri
18.07.23.2007|Tegal Ombo
18.07.23.2008|Kali Pasir
18.07.24.2001|Bungkuk
18.07.24.2002|Batu Badak
18.07.24.2003|Peniangan
18.07.24.2004|Gunung Raya
18.07.24.2005|Giri Mulyo
18.07.24.2006|Gunung Mas
18.07.24.2007|Purwosari
18.07.24.2008|Bukit Raya
18.08.01.1005|Blambangan Umpu
18.08.01.2006|Lembasung
18.08.01.2009|Gunung Sangkaran
18.08.01.2010|Tanjung Raja Giham
18.08.01.2011|Segara Mider
18.08.01.2012|Umpu Bhakti
18.08.01.2013|Sangkaran Bhakti
18.08.01.2014|Bumi Baru
18.08.01.2015|Tanjung Sari
18.08.01.2016|Sri Rejeki
18.08.01.2017|Karang Umpu
18.08.01.2018|Umpu Kencana
18.08.01.2022|Tanjung Raja Sakti
18.08.02.1004|Kasui Pasar
18.08.02.2001|Datar Bancong
18.08.02.2002|Kedaton
18.08.02.2003|Karang Lantang
18.08.02.2005|Kasui Lama
18.08.02.2006|Kampung Baru
18.08.02.2007|Jukuh Kemuning
18.08.02.2008|Kotaway
18.08.02.2009|Tanjung Kurung
18.08.02.2010|Talang Mangga
18.08.02.2011|Tanjung Harapan
18.08.02.2012|Sinar Gading
18.08.02.2013|Jaya Tinggi
18.08.02.2014|Sukajadi
18.08.02.2015|Gelombang Panjang
18.08.02.2016|Tangkas
18.08.02.2017|Tanjung Bulan
18.08.02.2018|Tanjung Kurung Lama
18.08.02.2019|Bukit Batu
18.08.03.1006|Pasar Banjit
18.08.03.2001|Bonglai
18.08.03.2002|Campang Lapan
18.08.03.2003|Sumber Baru
18.08.03.2004|Rantau Temiang
18.08.03.2005|Juku Batu
18.08.03.2007|Bali Sadhar Tengah
18.08.03.2008|Donomulyo
18.08.03.2009|Bali Sadhar Utara
18.08.03.2010|Bali Sadhar Selatan
18.08.03.2011|Menanga Jaya
18.08.03.2012|Argomulyo
18.08.03.2013|Rantau Jaya
18.08.03.2014|Rebang Tinggi
18.08.03.2015|Simpang Asam
18.08.03.2016|Bandar Agung
18.08.03.2017|Kemu
18.08.03.2018|Menanga Siamang
18.08.03.2019|Neki
18.08.03.2020|Sumber Sari
18.08.04.1009|Taman Asri
18.08.04.1015|Tiuh Balak Pasar
18.08.04.1016|Campur Asri
18.08.04.2001|Setia Negara
18.08.04.2002|Gedung Pakuon
18.08.04.2003|Bumi Merapi
18.08.04.2004|Banjar Sari
18.08.04.2005|Gunung Katun
18.08.04.2006|Bhakti Negara
18.08.04.2007|Bumi Rejo
18.08.04.2008|Sukosari
18.08.04.2010|Banjar Setia
18.08.04.2011|Gedung Rejo
18.08.04.2012|Banjar Agung
18.08.04.2013|Cugah
18.08.04.2014|Tiuh Balak I
18.08.04.2017|Tiuh Balak
18.08.04.2018|Mekar Asri
18.08.04.2019|Banjar Negara
18.08.04.2020|Banjar Masin
18.08.04.2021|Banjar Mulya
18.08.04.2022|Banjar Baru
18.08.05.2001|Tulang Bawang
18.08.05.2002|Mesir Udik
18.08.05.2005|Mesir Ilir
18.08.05.2006|Sapto Renggo
18.08.05.2007|Giri Harjo
18.08.05.2009|Bumi Agung Wates
18.08.05.2017|Serdang Kuring
18.08.05.2024|Bumi Agung
18.08.05.2025|Mekar Jaya
18.08.05.2026|Kota Dewa
18.08.05.2027|Dewa Agung
18.08.06.2001|Karang Agung
18.08.06.2002|Tanjung Ratu
18.08.06.2003|Pakuan Ratu
18.08.06.2004|Gunung Cahya
18.08.06.2005|Rumbih
18.08.06.2006|Negara Ratu
18.08.06.2007|Negara Sakti
18.08.06.2008|Suka Bumi
18.08.06.2009|Tanjung Agung
18.08.06.2010|Tanjung Serupa
18.08.06.2011|Negara Harja
18.08.06.2012|Bakti Negara
18.08.06.2013|Pakuan Baru
18.08.06.2014|Negara Tama
18.08.06.2015|Way Tawar
18.08.06.2016|Gunung Waras
18.08.06.2017|Pakuan Sakti
18.08.06.2018|Serupa Indah
18.08.06.2019|Bumi Mulya
18.08.07.2001|Negeri Agung
18.08.07.2002|Bandar Dalam
18.08.07.2003|Pulau Batu
18.08.07.2004|Penengahan
18.08.07.2005|Karya Agung
18.08.07.2006|Sunsang
18.08.07.2007|Kota Baru
18.08.07.2008|Kotabumi Way Kanan
18.08.07.2009|Gedung Menang
18.08.07.2010|Gedung Harapan
18.08.07.2011|Tanjung Rejo
18.08.07.2012|Kali Papan
18.08.07.2013|Mulya Sari
18.08.07.2014|Way Limau
18.08.07.2015|Gedung Jaya
18.08.07.2016|Rejo Sari
18.08.07.2017|Bandar Kasih
18.08.07.2018|Sumber Rejeki
18.08.07.2019|Mulya Agung
18.08.08.2001|Way Tuba
18.08.08.2002|Karya Jaya
18.08.08.2003|Say Umpu
18.08.08.2004|Beringin Jaya
18.08.08.2005|Suma Mukti
18.08.08.2006|Ramsai
18.08.08.2007|Bandar Sari
18.08.08.2008|Bumi Dana
18.08.08.2009|Bukit Gemuruh
18.08.08.2010|Way Mencar
18.08.08.2011|Way Pisang
18.08.08.2012|Bukit Harapan
18.08.08.2013|Way Tuba Asri
18.08.09.2001|Lebak Peniangan
18.08.09.2002|Tanjung Tiga
18.08.09.2003|Madang Jaya
18.08.09.2004|Air Ringkih
18.08.09.2005|Gunung Sari
18.08.09.2006|Simpang Tiga
18.08.09.2007|Tanjung Raya
18.08.09.2008|Beringin Jaya
18.08.09.2009|Karya Maju
18.08.09.2010|Mulya Jaya
18.08.10.2001|Gunung Labuhan
18.08.10.2002|Gunung Baru
18.08.10.2003|Banjar Sakti
18.08.10.2004|Suka Negeri
18.08.10.2005|Negeri Mulya
18.08.10.2006|Negeri Sungkai
18.08.10.2007|Gunung Sari
18.08.10.2008|Way Tuba
18.08.10.2009|Bengkulu
18.08.10.2010|Bengkulu Rejo
18.08.10.2011|Kayu Batu
18.08.10.2012|Bengkulu Raman
18.08.10.2013|Bengkulu Jaya
18.08.10.2014|Tiuh Balak II
18.08.10.2015|Curup Patah
18.08.10.2016|Sukarame
18.08.10.2017|Banjar Ratu
18.08.10.2018|Negeri Ujan Mas
18.08.10.2019|Bengkulu Tengah
18.08.10.2020|Gunung Pekuwon
18.08.10.2021|Labuhan Jaya
18.08.11.2001|Negara Batin
18.08.11.2002|Purwa Agung
18.08.11.2003|Purwa Negara
18.08.11.2004|Setia Negara
18.08.11.2005|Sri Mulyo
18.08.11.2006|Sri Menanti
18.08.11.2007|Karta Jaya
18.08.11.2008|Gisting Jaya
18.08.11.2009|Marga Jaya
18.08.11.2010|Bumi Jaya
18.08.11.2011|Gedung Jaya
18.08.11.2012|Adi Jaya
18.08.11.2013|Sari Jaya
18.08.11.2014|Negara Mulya
18.08.11.2015|Kota Jawa
18.08.12.2001|Negeri Besar
18.08.12.2002|Kiling-kiling
18.08.12.2003|Kali Awi
18.08.12.2004|Tiuh Baru
18.08.12.2005|Bima Sakti
18.08.12.2006|Tegal Mukti
18.08.12.2007|Negara Jaya
18.08.12.2008|Pagar Iman
18.08.12.2009|Sri Basuki
18.08.12.2010|Kali Awi Indah
18.08.12.2011|Negeri Jaya
18.08.12.2012|Tanjung Mas
18.08.12.2013|Negeri Kasih
18.08.13.2001|Bumiharjo
18.08.13.2002|Punjul Agung
18.08.13.2003|Sritunggal
18.08.13.2004|Suka Bumi
18.08.13.2005|Suka Agung
18.08.13.2006|Sukadana
18.08.13.2007|Nuar Maju
18.08.13.2008|Lebung Lawe
18.08.13.2009|Way Agung
18.08.14.2001|Pisang Baru
18.08.14.2002|Pisang Indah
18.08.14.2003|Srinumpi
18.08.14.2004|Mulyoharjo
18.08.14.2005|Bumi Agung
18.08.14.2006|Karangan
18.08.14.2007|Wonoharjo
18.08.14.2008|Sukamaju
18.08.14.2009|Tanjung Dalam
18.08.14.2010|Bumi Say Agung
18.08.15.2001|Negeri Batin
18.08.15.2002|Gistang
18.08.15.2003|Rambang Jaya
18.08.15.2004|Panca Negeri
18.08.15.2005|Negeri Bumi Putera
18.08.15.2006|Gedung Riang
18.08.15.2007|Gedung Batin
18.08.15.2008|Sidoarjo
18.08.15.2009|Bumi Ratu
18.08.15.2010|Sriwijaya
18.08.15.2011|Bratayudha
18.08.15.2012|Negeri Baru
18.08.15.2013|Ojo Lali
18.09.01.2001|Padang Ratu
18.09.01.2002|Pampangan
18.09.01.2003|Cipadang
18.09.01.2004|Way Layap
18.09.01.2005|Sukadadi
18.09.01.2006|Gedung Tataan
18.09.01.2007|Bagelen
18.09.01.2008|Sukaraja
18.09.01.2009|Kebagusan
18.09.01.2010|Sungai Langka
18.09.01.2011|Kurungan Nyawa
18.09.01.2012|Negeri Sakti
18.09.01.2013|Bernung
18.09.01.2014|Suka Banjar
18.09.01.2015|Wiyono
18.09.01.2016|Taman Sari
18.09.01.2017|Bogorejo
18.09.01.2018|Karang Anyar
18.09.01.2019|Kutoarjo
18.09.02.2001|Kagungan Ratu
18.09.02.2002|Kali Rejo
18.09.02.2003|Purworejo
18.09.02.2004|Pujo Rahayu
18.09.02.2005|Negeri Katon
18.09.02.2006|Ponco Kresno
18.09.02.2007|Halangan Ratu
18.09.02.2008|Pejambon
18.09.02.2009|Negara Saka
18.09.02.2010|Sinar Bandung
18.09.02.2011|Tanjung Rejo
18.09.02.2012|Rowo Rejo
18.09.02.2013|Tresno Maju
18.09.02.2014|Sidomulyo
18.09.02.2015|Lumbirejo
18.09.02.2016|Tri Rahayu
18.09.02.2017|Bangun Sari
18.09.02.2018|Karang Rejo
18.09.02.2019|Negeri Ulangan Jaya
18.09.02.2020|Pujodadi
18.09.02.2021|Grujugan Baru
18.09.03.2001|Bumi Agung
18.09.03.2002|Kejadian
18.09.03.2003|Batang Hari Ogan
18.09.03.2004|Negara Ratu Wates
18.09.03.2005|Gunung Sugih Baru
18.09.03.2006|Gedung Gumanti
18.09.03.2007|Kresno Widodo
18.09.03.2008|Sinarjati
18.09.03.2009|Margo Rejo
18.09.03.2010|Gerning
18.09.03.2011|Panca Bakti
18.09.03.2012|Margo Mulyo
18.09.03.2013|Rejo Agung
18.09.03.2014|Kota Agung
18.09.03.2015|Trimulyo
18.09.03.2016|Sriwedari
18.09.04.2001|Padang Manis
18.09.04.2002|Banjar Negeri
18.09.04.2003|Sidodadi
18.09.04.2004|Pekondoh Gedung
18.09.04.2005|Pekondoh
18.09.04.2006|Kota Dalam
18.09.04.2007|Tanjung Agung
18.09.04.2008|Gedong Dalam
18.09.04.2009|Sindang Garut
18.09.04.2010|Baturaja
18.09.04.2011|Way Harong
18.09.04.2012|Gunung Rejo
18.09.04.2013|Margodadi
18.09.04.2014|Cimanuk
18.09.04.2015|Sukamandi
18.09.04.2016|Paguyuban
18.09.05.2001|Banjaran
18.09.05.2004|Durian
18.09.05.2009|Hanau Berak
18.09.05.2010|Paya
18.09.05.2011|Padang Cermin
18.09.05.2012|Sanggi
18.09.05.2016|Tambangan
18.09.05.2017|Way Urang
18.09.05.2025|Khepong Jaya
18.09.05.2026|Trimulyo
18.09.05.2031|Gayau
18.09.05.2032|Dantar
18.09.06.2001|Bawang
18.09.06.2002|Banding Agung
18.09.06.2003|Batu Raja
18.09.06.2004|Sukajaya Pidada
18.09.06.2005|Rusaba
18.09.06.2006|Kota Jawa
18.09.06.2016|Sukarame
18.09.06.2017|Pagar Jaya
18.09.06.2019|Pulau Legundi
18.09.06.2020|Suka Maju
18.09.06.2021|Bangun Rejo
18.09.07.2008|Way Kepayang
18.09.07.2009|Suka Maju
18.09.07.2010|Kedondong
18.09.07.2011|Pasar Baru
18.09.07.2012|Tempel Rejo
18.09.07.2013|Kertasana
18.09.07.2014|Gunung Sugih
18.09.07.2017|Sinar Harapan
18.09.07.2018|Teba Jawa
18.09.07.2019|Babakan Loa
18.09.07.2020|Pesawaran Indah
18.09.07.2021|Harapan Jaya
18.09.08.2001|Sukajaya Punduh
18.09.08.2002|Maja
18.09.08.2003|Penyandingan
18.09.08.2004|Tajur
18.09.08.2005|Umbul Limus
18.09.08.2006|Pekon Ampai
18.09.08.2007|Kunyaian
18.09.08.2008|Kekatang
18.09.08.2009|Kampung Baru
18.09.08.2010|Pulau Pahawang
18.09.09.2001|Penengahan
18.09.09.2002|Suka Jaya
18.09.09.2003|Padang Cermin
18.09.09.2004|Bayas Jaya
18.09.09.2005|Tanjung Kerta
18.09.09.2006|Kota Jawa
18.09.09.2007|Gunung Sari
18.09.09.2008|Mada Jaya
18.09.09.2009|Kubu Batu
18.09.09.2010|Tanjung Rejo
18.09.10.2001|Batu Menyan
18.09.10.2002|Cilimus
18.09.10.2003|Gebang
18.09.10.2004|Hanura
18.09.10.2005|Hurun
18.09.10.2006|Munca
18.09.10.2007|Sidodadi
18.09.10.2008|Sukajaya Lempasing
18.09.10.2009|Talang Mulya
18.09.10.2010|Tanjung Agung
18.09.11.2001|Bunut
18.09.11.2002|Bunut Seberang
18.09.11.2003|Wates Way Ratai
18.09.11.2004|Ceringin Asri
18.09.11.2005|Sumber Jaya
18.09.11.2006|Mulyo Sari
18.09.11.2007|Poncorejo
18.09.11.2008|Gunung Rejo
18.09.11.2009|Pesawaran Indah
18.09.11.2010|Harapan Jaya
18.09.11.2011|Kalirejo
18.10.01.1001|Fajaresuk
18.10.01.1002|Pringsewu Utara
18.10.01.1003|Pringsewu Selatan
18.10.01.1004|Pringsewu Barat
18.10.01.1005|Pringsewu Timur
18.10.01.2006|Margakaya
18.10.01.2007|Waluyojati
18.10.01.2008|Sidoharjo
18.10.01.2009|Podomoro
18.10.01.2010|Bumi Arum
18.10.01.2011|Fajar Agung
18.10.01.2012|Rejo Sari
18.10.01.2013|Bumi Ayu
18.10.01.2014|Podosari
18.10.01.2015|Fajar Agung Barat
18.10.02.2001|Parerejo
18.10.02.2002|Blitarejo
18.10.02.2003|Panjerejo
18.10.02.2004|Bulokarto
18.10.02.2005|Wates
18.10.02.2006|Tambahrejo
18.10.02.2007|Wonodadi
18.10.02.2008|Gadingrejo
18.10.02.2009|Tegalsari
18.10.02.2010|Tulung Agung
18.10.02.2011|Bulurejo
18.10.02.2012|Yogyakarta
18.10.02.2013|Kediri
18.10.02.2014|Mataram
18.10.02.2015|Wonosari
18.10.02.2016|Klaten
18.10.02.2017|Wates Timur
18.10.02.2018|Wates Selatan
18.10.02.2019|Gading Rejo Timur
18.10.02.2020|Gading Rejo Utara
18.10.02.2021|Tambah Rejo Barat
18.10.02.2022|Wonodadi Utara
18.10.02.2023|Yogyakarta Selatan
18.10.03.2001|Ambarawa
18.10.03.2002|Ambarawa Barat
18.10.03.2003|Kresno Mulyo
18.10.03.2004|Sumber Agung
18.10.03.2005|Tanjung Anom
18.10.03.2006|Jati Agung
18.10.03.2007|Margodadi
18.10.03.2008|Ambarawa Timur
18.10.04.2001|Kedaung
18.10.04.2002|Pardasuka
18.10.04.2003|Suka Negeri
18.10.04.2004|Tanjung Rusia
18.10.04.2005|Warga Mulyo
18.10.04.2006|Pujodadi
18.10.04.2007|Sukorejo
18.10.04.2008|Selapan
18.10.04.2009|Rantau Tijang
18.10.04.2010|Sidodadi
18.10.04.2011|Pardasuka Timur
18.10.04.2012|Tanjung Rusia Timur
18.10.04.2013|Pardasuka Selatan
18.10.05.2001|Candi Retno
18.10.05.2002|Tanjung Dalom
18.10.05.2003|Way Ngison
18.10.05.2004|Suka Wangi
18.10.05.2005|Suka Ratu
18.10.05.2006|Pagelaran
18.10.05.2007|Patoman
18.10.05.2008|Karangsari
18.10.05.2009|Gumuk Mas
18.10.05.2010|Bumi Ratu
18.10.05.2011|Panutan
18.10.05.2012|Lugusari
18.10.05.2019|Pamenang
18.10.05.2020|Gemah Ripah
18.10.05.2023|Pasir Ukir
18.10.05.2024|Gumukrejo
18.10.05.2027|Puji Harjo
18.10.05.2028|Padang Rejo
18.10.05.2029|Sidodadi
18.10.05.2030|Sumber Rejo
18.10.05.2031|Ganjaran
18.10.05.2032|Bumi Rejo
18.10.06.2001|Banyumas
18.10.06.2002|Banyuwangi
18.10.06.2003|Sukamulya
18.10.06.2004|Sriwungu
18.10.06.2005|Banjarejo
18.10.06.2006|Waya Krui
18.10.06.2007|Sri Rahayu
18.10.06.2008|Nusa Wungu
18.10.06.2009|Sinar Mulya
18.10.06.2010|Banyu Urip
18.10.06.2011|Mulyo Rejo
18.10.07.2001|Adiluwih
18.10.07.2002|Bandung Baru
18.10.07.2003|Sinarwayah
18.10.07.2004|Enggal Rejo
18.10.07.2005|Sukoharum
18.10.07.2006|Waringin Sari Timur
18.10.07.2007|Tri Tunggal Mulya
18.10.07.2008|Purwodadi
18.10.07.2009|Srikaton
18.10.07.2010|Tunggul Pawenang
18.10.07.2011|Bandung Baru Barat
18.10.07.2012|Totokarto
18.10.07.2013|Kuta Waringin
18.10.08.2001|Sinar Baru
18.10.08.2002|Sukoharjo I
18.10.08.2003|Sukoharjo II
18.10.08.2004|Sukoharjo III
18.10.08.2005|Sukoharjo IV
18.10.08.2006|Panggungrejo
18.10.08.2007|Pandan Sari
18.10.08.2008|Pandan Surat
18.10.08.2009|Keputran
18.10.08.2010|Sukoyoso
18.10.08.2011|Siliwangi
18.10.08.2012|Waringinsari Barat
18.10.08.2013|Pandan Sari Selatan
18.10.08.2014|Sinar Baru Timur
18.10.08.2015|Panggung Rejo Utara
18.10.08.2016|Sukoharjo III Barat
18.10.09.2001|Fajar Baru
18.10.09.2002|Kemilin
18.10.09.2003|Neglasari
18.10.09.2004|Fajar Mulia
18.10.09.2005|Margosari
18.10.09.2006|Giri Tunggal
18.10.09.2007|Sumber Bandung
18.10.09.2008|Madaraya
18.10.09.2009|Way Kunir
18.10.09.2010|Gunung Raya
18.11.01.2001|Wiralaga I
18.11.01.2002|Wiralaga II
18.11.01.2003|Sungai Badak
18.11.01.2004|Nipah Kuning
18.11.01.2005|Sido Mulyo
18.11.01.2006|Tirta Laga
18.11.01.2007|Tanjung Serayan
18.11.01.2008|Sumber Makmur
18.11.01.2009|Mulya Sari
18.11.01.2010|Wiralaga Mulya
18.11.01.2011|Suka Maju
18.11.02.2001|Talang Batu
18.11.02.2002|Sungai Cambai
18.11.02.2003|Tanjung Mas Makmur
18.11.02.2004|Margo Jadi
18.11.02.2005|Tanjung Menang
18.11.02.2006|Eka Mulya
18.11.02.2007|Wono Sari
18.11.02.2008|Dwi Karya Mustika
18.11.02.2009|Pangkal Mas Jaya
18.11.02.2010|Pangkal Mas Mulya
18.11.02.2011|Tanjung Mas Mulya
18.11.02.2012|Muara Mas
18.11.02.2013|Tanjung Mas Jaya
18.11.02.2014|Margo Jaya
18.11.02.2015|Pangkal Mas
18.11.02.2016|Tanjung Menang Raya
18.11.02.2017|Tebing Karya Mandiri
18.11.02.2018|Tanjung Mas Rejo
18.11.02.2019|Margo Mulyo
18.11.02.2020|Muara Asri
18.11.03.2001|Sungai Buaya
18.11.03.2002|Panggung Jaya
18.11.03.2003|Sungai Sidang
18.11.03.2004|Sidang Sido Rahayu
18.11.03.2005|Sidang Way Puji
18.11.03.2006|Sidang Bandar Anom
18.11.03.2007|Panggung Rejo
18.11.03.2008|Sidang Iso Mukti
18.11.03.2009|Sidang Kurnia Agung
18.11.03.2010|Telogo Rejo
18.11.03.2011|Sidang Gunung Tiga
18.11.03.2012|Sidang Muara Jaya
18.11.03.2013|Sidang Makmur
18.11.04.2001|Buko Poso
18.11.04.2002|Kejadian
18.11.04.2003|Bumi Harapan
18.11.04.2004|Kebun Dalam
18.11.04.2005|Panca Warna
18.11.04.2006|Gedung Boga
18.11.04.2007|Suka Agung
18.11.04.2008|Rejo Mulyo
18.11.04.2009|Hadi Mulyo
18.11.04.2010|Labuhan Batin
18.11.04.2011|Labuhan Baru
18.11.04.2012|Labuhan Makmur
18.11.04.2013|Gedung Sri Mulyo
18.11.04.2014|Labuhan Permai
18.11.04.2015|Sumber Rejo
18.11.04.2016|Margo Bhakti
18.11.04.2017|Labuhan Mulya
18.11.04.2018|Karang Mulya
18.11.04.2019|Tri Tunggal Jaya
18.11.04.2020|Suka Mandiri
18.11.05.2001|Simpang Pematang
18.11.05.2002|Budi Aji
18.11.05.2003|Margo Rahayu
18.11.05.2004|Harapan Jaya
18.11.05.2005|Wira Bangun
18.11.05.2006|Agung Batin
18.11.05.2007|Bangun Mulyo
18.11.05.2008|Jaya Sakti
18.11.05.2009|Rejo Binangun
18.11.05.2010|Simpang Mesuji
18.11.05.2011|Margo Makmur
18.11.05.2012|Aji Jaya
18.11.05.2013|Mulya Agung
18.11.06.2001|Adi Luhur
18.11.06.2002|Mukti Karya
18.11.06.2003|Fajar Baru
18.11.06.2004|Adi Mulyo
18.11.06.2005|Fajar Asri
18.11.06.2006|Fajar Indah
18.11.06.2007|Adi Karya Mulya
18.11.07.2001|Brabasan
18.11.07.2002|Gedung Ram
18.11.07.2003|Mekar Sari
18.11.07.2004|Bujung Buring
18.11.07.2005|Kagungan Dalam
18.11.07.2006|Tanjung Sari
18.11.07.2007|Harapan Mukti
18.11.07.2008|Sri Tanjung
18.11.07.2009|Bangun Jaya
18.11.07.2010|Muara Tenang
18.11.07.2011|Wira Jaya
18.11.07.2012|Sinar Laga
18.11.07.2013|Tri Karya Mulya
18.11.07.2014|Berasan Makmur
18.11.07.2015|Mekar Jaya
18.11.07.2016|Gedung Mulya
18.11.07.2017|Tanjung Harapan
18.11.07.2018|Muara Tenang Timur
18.11.07.2019|Sriwijaya
18.11.07.2020|Mukti Jaya
18.11.07.2021|Bujung Buring Baru
18.12.01.1001|Mulyo Asri
18.12.01.1007|Panaragan Jaya
18.12.01.2002|Panaragan
18.12.01.2003|Bandar Dewa
18.12.01.2004|Menggala Mas
18.12.01.2005|Penumangan
18.12.01.2006|Penumangan Baru
18.12.01.2008|Tirta Kencana
18.12.01.2009|Pulung Kencana
18.12.01.2010|Mulya Kencana
18.12.01.2011|Candra Kencana
18.12.01.2012|Tunas Asri
18.12.01.2013|Wono Kerto
18.12.01.2014|Panaragan Jaya Utama
18.12.01.2015|Panaragan Jaya Indah
18.12.01.2016|Mulya Jaya
18.12.01.2017|Tirta Makmur
18.12.01.2018|Candra Mukti
18.12.01.2019|Candra Jaya
18.12.01.2020|Marga Asri
18.12.01.2021|Mekar Asri
18.12.02.1001|Daya Murni
18.12.02.2002|Daya Sakti
18.12.02.2003|Margo Mulyo
18.12.02.2004|Makarti
18.12.02.2005|Gunung Menanti
18.12.02.2006|Daya Asri
18.12.02.2007|Murni Jaya
18.12.02.2008|Sumber Rejo
18.12.02.2009|Margo Dadi
18.12.02.2010|Gunung Timbul
18.12.03.2001|Karta
18.12.03.2002|Karta Sari
18.12.03.2003|Karta Raharja
18.12.03.2004|Gunung Katun Tanjungan
18.12.03.2005|Gunung Katun Malai
18.12.03.2006|Gedung Ratu
18.12.03.2007|Kagungan Ratu
18.12.03.2008|Marga Kencana
18.12.03.2009|Way Sido
18.12.03.2010|Kagungan Ratu Agung
18.12.03.2011|Gading Kencana
18.12.03.2012|Karta Raya
18.12.03.2013|Karta Tanjung Selamat
18.12.04.2002|Toto Mulyo
18.12.04.2006|Setia Bumi
18.12.04.2007|Gunung Terang
18.12.04.2008|Gunung Agung
18.12.04.2011|Kagungan Jaya
18.12.04.2012|Terang Mulya
18.12.04.2013|Terang Bumi Agung
18.12.04.2015|Setia Agung
18.12.04.2017|Mulyo Jadi
18.12.04.2020|Terang Makmur
18.12.05.2001|Tunas Jaya
18.12.05.2002|Mekar Jaya
18.12.05.2003|Marga Jaya
18.12.05.2004|Jaya Murni
18.12.05.2005|Suka Jaya
18.12.05.2006|Mulya Jaya
18.12.05.2007|Bangun Jaya
18.12.05.2008|Sumber Jaya
18.12.05.2009|Wono Rejo
18.12.05.2010|Tri Tunggal Jaya
18.12.05.2011|Mulya Sari
18.12.05.2012|Dwikora Jaya
18.12.05.2013|Sumber Rejeki
18.12.06.2001|Agung Jaya
18.12.06.2002|Mercu Buana
18.12.06.2003|Balam Jaya
18.12.06.2004|Pagar Buana
18.12.06.2005|Indraloka I
18.12.06.2006|Indraloka II
18.12.06.2007|Balam Asri
18.12.06.2008|Indraloka Jaya
18.12.06.2009|Indraloka Mukti
18.12.06.2010|Sido Agung
18.12.07.2001|Kibang Budi Jaya
18.12.07.2002|Lesung Bhakti Jaya
18.12.07.2003|Mekar Sari Jaya
18.12.07.2004|Pagar Jaya
18.12.07.2005|Gunung Sari
18.12.07.2006|Sumber Rejo
18.12.07.2007|Kibang Yekti Jaya
18.12.07.2008|Kibang Tri Jaya
18.12.07.2009|Gilang Tunggal Makarta
18.12.07.2010|Kibang Mulya Jaya
18.12.08.2001|Pagar Dewa
18.12.08.2002|Pagar Dewa Suka Mulya
18.12.08.2003|Cahyou Randu
18.12.08.2004|Bujung Dewa
18.12.08.2005|Bujung Sari Marga
18.12.08.2006|Marga Jaya Indah
18.12.09.2001|Panca Marga
18.12.09.2002|Sido Makmur
18.12.09.2003|Sakti Jaya
18.12.09.2004|Margo Mulya
18.12.09.2005|Margo Dadi
18.12.09.2006|Marga Sari
18.12.09.2007|Mulyo Sari
18.12.09.2008|Toto Katon
18.12.09.2009|Toto Makmur
18.12.09.2010|Toto Wonodadi
18.13.01.1005|Pasar Krui
18.13.01.1008|Pasar Kota Krui
18.13.01.2001|Way Redak
18.13.01.2002|Seray
18.13.01.2003|Kampung Jawa
18.13.01.2004|Rawas
18.13.01.2006|Suka Negara
18.13.01.2007|Pahmungan
18.13.02.2001|Negeri Ratu Tenumbang
18.13.02.2002|Sukarame
18.13.02.2003|Pelita Jaya
18.13.02.2004|Sumur Jaya
18.13.02.2005|Tanjung Jati
18.13.02.2006|Pagar Dalam
18.13.02.2007|Tanjung Setia
18.13.02.2008|Biha
18.13.02.2009|Way Jambu
18.13.02.2010|Marang
18.13.02.2011|Tanjung Raya
18.13.02.2012|Bangun Negara
18.13.02.2013|Ulok Manik
18.13.02.2014|Paku Negara
18.13.02.2015|Tulung Bamban
18.13.03.2001|Tanjung Jati
18.13.03.2002|Tanjung Sakti
18.13.03.2003|Way Batang
18.13.03.2004|Lemong
18.13.03.2005|Cahya Negeri
18.13.03.2006|Malaya
18.13.03.2007|Bambang
18.13.03.2008|Pagar Dalam
18.13.03.2009|Bandar Pugung
18.13.03.2010|Penengahan
18.13.03.2011|Rata Agung
18.13.03.2012|Sukamulya
18.13.03.2013|Parda Haga
18.13.04.2001|Kuripan
18.13.04.2002|Padang Rindu
18.13.04.2003|Negeri Ratu
18.13.04.2004|Kerbang Dalam
18.13.04.2005|Kota Karang
18.13.04.2006|Balam
18.13.04.2007|Way Narta
18.13.04.2008|Kerbang Langgar
18.13.04.2009|Walur
18.13.04.2010|Batu Raja
18.13.04.2011|Pemancar
18.13.04.2012|Gedau
18.13.05.2001|Kebuayan
18.13.05.2002|Way Nukak
18.13.05.2003|Way Sindi
18.13.05.2004|Penengahan
18.13.05.2005|Menyancang
18.13.05.2006|Laay
18.13.05.2007|Penggawa V Ulu
18.13.05.2008|Penggawa V Tengah
18.13.05.2009|Way Sindi Utara
18.13.05.2010|Tembakak Way Sindi
18.13.05.2011|Way Sindi Hanuan
18.13.05.2012|Asahan Way Sindi
18.13.06.2001|Pasar Pulau Pisang
18.13.06.2002|Labuhan
18.13.06.2003|Bandar Dalam
18.13.06.2004|Pekon Lok
18.13.06.2005|Sukadana
18.13.06.2006|Sukamarga
18.13.07.2001|Pajar Bulan
18.13.07.2002|Bumi Waras
18.13.07.2003|Banjar Agung
18.13.07.2004|Penggawa V Ilir
18.13.07.2005|Ulu Krui
18.13.07.2006|Gunung Kemala
18.13.07.2007|Labuhan Mandi
18.13.07.2008|Suka Baru
18.13.07.2009|Penggawa Lima
18.13.07.2010|Gunungkemala Timur
18.13.08.2001|Balai Kencana
18.13.08.2002|Way Suluh
18.13.08.2003|Way Napal
18.13.08.2004|Padang Haluan
18.13.08.2005|Lintik
18.13.08.2006|Walur
18.13.08.2007|Pemerihan
18.13.08.2008|Mandiri Sejati
18.13.08.2009|Padang Raya
18.13.08.2010|Suka Jadi
18.13.09.2001|Sumber Agung
18.13.09.2002|Ulok Mukti
18.13.09.2003|Negeri Ratu Ngambur
18.13.09.2004|Pekon Mon
18.13.09.2005|Gedung Cahya Kuningan
18.13.09.2006|Suka Banjar
18.13.09.2007|Suka Negara
18.13.09.2008|Muara Tembulih
18.13.09.2009|Bumi Ratu
18.13.10.2001|Negeri Ratu Ngaras
18.13.10.2003|Kota Batu
18.13.10.2004|Mulang Maya
18.13.10.2005|Raja Basa
18.13.10.2006|Parda Suka
18.13.10.2017|Padang Dalam
18.13.10.2018|Suka Maju
18.13.10.2019|Sukarame
18.13.10.2020|Bandar Jaya
18.13.11.2001|Pagar Bukit
18.13.11.2002|Tanjung Kemala
18.13.11.2003|Suka Marga
18.13.11.2004|Kota Jawa
18.13.11.2005|Penyandingan
18.13.11.2006|Bandar Dalam
18.13.11.2007|Way Haru
18.13.11.2008|Pemerihan
18.13.11.2009|Suka Negeri
18.13.11.2010|Sumberejo
18.13.11.2011|Siring Gading
18.13.11.2012|Way Tias
18.13.11.2013|Tanjung Rejo
18.13.11.2014|Pagar Bukit Induk
18.71.01.1003|Kedaton
18.71.01.1004|Surabaya
18.71.01.1005|Sukamenanti
18.71.01.1006|Sidodadi
18.71.01.1009|Sukamenanti Baru
18.71.01.1010|Penengahan
18.71.01.1012|Penengahan Raya
18.71.02.1003|Sukarame
18.71.02.1004|Way Dadi
18.71.02.1006|Sukarame Baru
18.71.02.1007|Way Dadi Baru
18.71.02.1008|Korpri jaya
18.71.02.1009|Korpri Raya
18.71.03.1001|Gedong Air
18.71.03.1002|Sukajawa
18.71.03.1004|Susunan Baru
18.71.03.1006|Sukadana Ham
18.71.03.1008|Kelapa Tiga Permai
18.71.03.1010|Sukajawa Baru
18.71.03.1011|Segalamider
18.71.04.1001|Panjang Selatan
18.71.04.1002|Srengsem
18.71.04.1003|Panjang Utara
18.71.04.1004|Pidada
18.71.04.1007|Karang Maritim
18.71.04.1008|Way Lunik
18.71.04.1009|Ketapang
18.71.04.1010|Ketapang Kuala
18.71.05.1002|Kota Baru
18.71.05.1003|Tanjung Agung
18.71.05.1004|Kebon Jeruk
18.71.05.1005|Sawah Lama
18.71.05.1006|Sawah Brebes
18.71.06.1001|Durian Payung
18.71.06.1002|Gotong Royong
18.71.06.1005|Palapa
18.71.06.1006|Kaliawi
18.71.06.1007|Kelapa Tiga
18.71.06.1010|Pasir Gintung
18.71.06.1012|Kaliawi Persada
18.71.07.1001|Pesawahan
18.71.07.1002|Telukbetung
18.71.07.1008|Talang
18.71.07.1009|Gedong Pakuon
18.71.07.1012|Sumur Putri
18.71.07.1013|Gunungmas
18.71.08.1005|Bakung
18.71.08.1006|Kuripan
18.71.08.1007|Negeri Olok Gading
18.71.08.1008|Sukarame II
18.71.08.1009|Batu Putuk
18.71.09.1001|Kupang Kota
18.71.09.1003|Kupang Raya
18.71.09.1004|Kupang Teba
18.71.09.1006|Pengajaran
18.71.09.1007|Gulak Galik
18.71.09.1008|Sumur Batu
18.71.10.1001|Rajabasa
18.71.10.1002|Gedong Meneng
18.71.10.1005|Rajabasa Nunyai
18.71.10.1006|Rajabasa Pemuka
18.71.10.1007|Gedong Meneng Baru
18.71.10.1008|Rajabasa Raya
18.71.10.1009|Rajabasa Jaya
18.71.11.1001|Tanjung Senang
18.71.11.1002|Way Kandis
18.71.11.1003|Labuhan Dalam
18.71.11.1004|Perumnas Way Kandis
18.71.11.1005|Pematang Wangi
18.71.12.1002|Sukabumi
18.71.12.1004|Sukabumi Indah
18.71.12.1007|Campang Raya
18.71.12.1008|Nusantara Permai
18.71.12.1009|Campang Jaya
18.71.12.1010|Way Gubak
18.71.12.1011|Way Laga
18.71.13.1001|Sumber Rejo
18.71.13.1003|Beringin Jaya
18.71.13.1004|Kemiling Permai
18.71.13.1005|Sumber Agung
18.71.13.1006|Kedaung
18.71.13.1007|Pinang Jaya
18.71.13.1008|Sumberrejo Sejahtera
18.71.13.1009|Kemiling Raya
18.71.13.1010|Beringin Raya
18.71.14.1001|Labuhan Ratu
18.71.14.1002|Labuhan Ratu Raya
18.71.14.1003|Sepang Jaya
18.71.14.1004|Kota Sepang
18.71.14.1006|Kampung Baru Raya
18.71.14.1007|Kampung Baru
18.71.15.1001|Perumnas Way Halim
18.71.15.1002|Way Halim Permai
18.71.15.1003|Gunungsulah
18.71.15.1004|Jagabaya I
18.71.15.1005|Jagabaya II
18.71.15.1006|Jagabaya III
18.71.16.1001|Langkapura
18.71.16.1002|Langkapura Baru
18.71.16.1003|Gunungterang
18.71.16.1005|Bilabong Jaya
18.71.16.1006|Gunungagung
18.71.17.1001|Enggal
18.71.17.1002|Pelita
18.71.17.1003|Tanjungkarang
18.71.17.1004|Gunungsari
18.71.17.1005|Rawalaut
18.71.17.1006|Pahoman
18.71.18.1001|Kedamaian
18.71.18.1002|Bumi Kedamaian
18.71.18.1003|Tanjungagung Raya
18.71.18.1004|Tanjungbaru
18.71.18.1005|Kalibalau Kencana
18.71.18.1006|Tanjungraya
18.71.18.1007|Tanjunggading
18.71.19.1001|Kota Karang
18.71.19.1002|Kota Karang Raya
18.71.19.1003|Parwata
18.71.19.1004|Keteguhan
18.71.19.1005|Sukamaju
18.71.19.1006|Way Tataan
18.71.20.1001|Sukaraja
18.71.20.1002|Bumi Waras
18.71.20.1003|Garuntang
18.71.20.1004|Bumi Raya
18.71.20.1005|Kangkung
18.72.01.1001|Metro
18.72.01.1002|Hadimulyo Timur
18.72.01.1003|Imopuro
18.72.01.1004|Hadimulyo Barat
18.72.01.1005|Yosomulyo
18.72.02.1001|Banjarsari
18.72.02.1002|Purwosari
18.72.02.1003|Karangrejo
18.72.02.1004|Purwoasri
18.72.03.1001|Mulyojati
18.72.03.1002|Ganjar Agung
18.72.03.1003|Mulyosari
18.72.03.1004|Ganjar Asri
18.72.04.1001|Yosodadi
18.72.04.1002|Tejosari
18.72.04.1003|Iring Mulyo
18.72.04.1004|Yosorejo
18.72.04.1005|Tejo Agung
18.72.05.1001|Rejomulyo
18.72.05.1002|Margorejo
18.72.05.1003|Sumbersari Bantul
18.72.05.1004|Margodadi
19.01.01.1001|Sungailiat
19.01.01.1002|Sri Menanti
19.01.01.1003|Kudai
19.01.01.1004|Sinar Baru
19.01.01.1005|Kenanga
19.01.01.1006|Parit Padang
19.01.01.1008|Sinar Jaya Jelutung
19.01.01.1009|Matras
19.01.01.1010|Jelitik
19.01.01.1011|Surya Timur
19.01.01.1012|Lubuk Kelik
19.01.01.1013|Bukit Betung
19.01.01.2007|Rebo
19.01.02.1001|Kuto Panji
19.01.02.1002|Air Jukung
19.01.02.1003|Bukit Ketok
19.01.02.1009|Remodong Indah
19.01.02.1010|Air Asam
19.01.02.1011|Mantung
19.01.02.1012|Belinyu
19.01.02.2004|Gunung Muda
19.01.02.2005|Gunung Pelawan
19.01.02.2006|Riding Panjang
19.01.02.2007|Lumut
19.01.02.2008|Bintet
19.01.03.2001|Batu Rusa
19.01.03.2002|Balun Ijuk
19.01.03.2003|Riding Panjang
19.01.03.2004|Jurung
19.01.03.2005|Kimak
19.01.03.2006|Pagarawan
19.01.03.2007|Merawang
19.01.03.2008|Air Anyir
19.01.03.2009|Dwi Makmur
19.01.03.2010|Jada Bahrin
19.01.04.2001|Petaling
19.01.04.2002|Penagan
19.01.04.2003|Zed
19.01.04.2004|Mendo
19.01.04.2005|Paya Benua
19.01.04.2006|Cengkong Abang
19.01.04.2007|Kace
19.01.04.2008|Kemuja
19.01.04.2009|Air Duren
19.01.04.2010|Kota Kapur
19.01.04.2011|Air Buluh
19.01.04.2012|Rukam
19.01.04.2013|Labuh Air Pandan
19.01.04.2014|Kace Timur
19.01.04.2015|Petaling Banjar
19.01.05.2001|Air Ruai
19.01.05.2002|Air Duren
19.01.05.2003|Penyamun
19.01.05.2004|Sempan
19.01.05.2005|Pemali
19.01.05.2006|Karya Makmur
19.01.06.2001|Bakam
19.01.06.2002|Kapuk
19.01.06.2003|Dalil
19.01.06.2004|Neknang
19.01.06.2005|Tiang Tarah
19.01.06.2006|Mangka
19.01.06.2007|Mabat
19.01.06.2008|Bukit Layang
19.01.06.2009|Maras Senang
19.01.07.2001|Riau
19.01.07.2002|Pangkal Niur
19.01.07.2003|Pugul
19.01.07.2004|Cit
19.01.07.2005|Deniang
19.01.07.2006|Silip
19.01.07.2007|Mapur
19.01.07.2008|Banyu Asin
19.01.07.2009|Berbura
19.01.08.2001|Puding Besar
19.01.08.2002|Labu
19.01.08.2003|Nibung
19.01.08.2004|Tanah Bawah
19.01.08.2005|Saing
19.01.08.2006|Kota Waringin
19.01.08.2007|Kayu Besi
19.02.01.1001|Kota
19.02.01.1002|Parit
19.02.01.1005|Lesung Batang
19.02.01.1006|Pangkallalang
19.02.01.1009|Tanjungpendam
19.02.01.1011|Paal Satu
19.02.01.1016|Kampong Damai
19.02.01.2003|Buluh Tumbang
19.02.01.2004|Perawas
19.02.01.2007|Dukong
19.02.01.2008|Juru Seberang
19.02.01.2010|Air Saga
19.02.01.2012|Air Merbau
19.02.01.2013|Aik Pelempang Jaya
19.02.01.2014|Aik Ketekok
19.02.01.2015|Aik Rayak
19.02.02.2001|Membalong
19.02.02.2002|Perpat
19.02.02.2003|Lassar
19.02.02.2004|Simpang Rusa
19.02.02.2005|Kembiri
19.02.02.2006|Bantan
19.02.02.2007|Tanjungrusa
19.02.02.2008|Mentigi
19.02.02.2009|Pulau Seliu
19.02.02.2010|Pulau Sumedang
19.02.02.2011|Gunung Riting
19.02.02.2012|Padang Kandis
19.02.03.2001|Selat Nasik
19.02.03.2002|Petaling
19.02.03.2003|Suak Gual
19.02.03.2004|Pulau Gersik
19.02.04.2001|Sijuk
19.02.04.2002|Batu Itam
19.02.04.2003|Terong
19.02.04.2004|Air Seruk
19.02.04.2005|Tanjung Binga
19.02.04.2006|Air Selumar
19.02.04.2007|Sungai Padang
19.02.04.2008|Keciput
19.02.04.2009|Pelepak Pute
19.02.04.2010|Tanjong Tinggi
19.02.05.2001|Badau
19.02.05.2002|Air Batu Buding
19.02.05.2003|Sungai Samak
19.02.05.2004|Kacang Butor
19.02.05.2005|Cerucuk
19.02.05.2006|Pegantungan
19.02.05.2007|Ibul
19.03.01.1001|Toboali
19.03.01.1002|Teladan
19.03.01.1003|Tanjung Ketapang
19.03.01.2004|Serdang
19.03.01.2005|Jeriji
19.03.01.2006|Bikang
19.03.01.2007|Gadung
19.03.01.2008|Rias
19.03.01.2010|Kepoh
19.03.01.2012|Keposang
19.03.01.2013|Rindik
19.03.02.2001|Tanjung Labu
19.03.02.2002|Tanjung Sangkar
19.03.02.2004|Kumbung
19.03.02.2005|Penutuk
19.03.03.2001|Airgegas
19.03.03.2002|Delas
19.03.03.2003|Pergam
19.03.03.2004|Bencah
19.03.03.2005|Nyelanding
19.03.03.2006|Nangka
19.03.03.2007|Ranggas
19.03.03.2008|Airbara
19.03.03.2009|Sidoharjo
19.03.03.2010|Tepus
19.03.04.2001|Jelutung II
19.03.04.2002|Gudang
19.03.04.2003|Bangka Kota
19.03.04.2004|Rajik
19.03.04.2005|Sebagin
19.03.04.2006|Simpang Rimba
19.03.04.2007|Permis
19.03.05.2001|Payung
19.03.05.2002|Malik
19.03.05.2003|Sengir
19.03.05.2004|Pangkal Buluh
19.03.05.2005|Irat
19.03.05.2006|Bedengung
19.03.05.2008|Nadung
19.03.05.2009|Ranggung
19.03.05.2012|Paku
19.03.06.2001|Sadai
19.03.06.2002|Tukak
19.03.06.2003|Pasir Putih
19.03.06.2004|Tiram
19.03.06.2005|Bukit Terap
19.03.07.2001|Batu Betumpang
19.03.07.2002|Sukajaya
19.03.07.2003|Panca Tunggal
19.03.07.2004|Sumber Jaya Permai
19.03.07.2005|Fajar Indah
19.03.08.2001|Pongok
19.03.08.2002|Celagen
19.04.01.1001|Koba
19.04.01.1002|Arung Dalam
19.04.01.1017|Berok
19.04.01.1018|Padang Mulia
19.04.01.1019|Simpang Perlang
19.04.01.2003|Nibung
19.04.01.2005|Kurau (Timur)
19.04.01.2006|Guntung
19.04.01.2007|Penyak
19.04.01.2008|Terentang III
19.04.01.2010|Kurau Barat
19.04.02.1001|Dul
19.04.02.2004|Air Mesu
19.04.02.2006|Mangkol
19.04.02.2007|Tanjung Gunung
19.04.02.2010|Benteng
19.04.02.2012|Padang Baru
19.04.02.2013|Jeruk
19.04.02.2014|Beluluk
19.04.02.2016|Pedindang
19.04.02.2018|Batu Belubang
19.04.02.2020|Air Mesu Timur
19.04.02.2021|Kebintik
19.04.03.1001|Sungai Selan
19.04.03.2002|Kerantai
19.04.03.2003|Keretak
19.04.03.2004|Lampur
19.04.03.2005|Sarang Mandi
19.04.03.2006|Munggu
19.04.03.2007|Kemingking
19.04.03.2008|Sungai Selan Atas
19.04.03.2009|Tanjung Pura
19.04.03.2010|Romadhon
19.04.03.2011|Kerakas
19.04.03.2012|Melabun
19.04.03.2013|Keretak Atas
19.04.04.2001|Simpang Katis
19.04.04.2002|Celuak
19.04.04.2003|Sungkap
19.04.04.2004|Beruas
19.04.04.2005|Puput
19.04.04.2006|Teru
19.04.04.2007|Terak
19.04.04.2008|Pasir Garam
19.04.04.2009|Katis
19.04.04.2010|Pinang Sebatang
19.04.05.2001|Namang
19.04.05.2002|Cambai
19.04.05.2003|Kayu Besi
19.04.05.2004|Jelutung
19.04.05.2005|Belilik
19.04.05.2006|Bhaskara Bhakti
19.04.05.2008|Bukit Kijang
19.04.05.2009|Cambai Selatan
19.04.06.2001|Perlang
19.04.06.2002|Batu Beriga
19.04.06.2003|Lubuk Besar
19.04.06.2004|Kulur
19.04.06.2005|Lubuk Lingkuk
19.04.06.2006|Lubuk Pabrik
19.04.06.2007|Trubus
19.04.06.2008|Kulur Ilir
19.04.06.2009|Belimbing
19.05.01.1001|Tanjung
19.05.01.1002|Sungai Daeng
19.05.01.1003|Sungai Baru
19.05.01.1008|Keranggan
19.05.01.1009|Menjelang
19.05.01.2004|Air Putih
19.05.01.2005|Air Belo
19.05.01.2006|Belo Laut
19.05.01.2007|Air Limau
19.05.02.2001|Pelangas
19.05.02.2002|Kundi
19.05.02.2003|Mayang
19.05.02.2004|Peradong
19.05.02.2005|Air Nyatoh
19.05.02.2006|Berang
19.05.02.2007|Rambat
19.05.02.2008|Simpang Gong
19.05.02.2009|Simpang Tiga
19.05.02.2010|Ibul
19.05.02.2011|Pangek
19.05.02.2012|Bukit Terak
19.05.02.2013|Air Menduyung
19.05.03.2001|Jebus
19.05.03.2002|Sungai Buluh
19.05.03.2003|Tumbak Petar
19.05.03.2004|Limbung
19.05.03.2005|Rukam
19.05.03.2008|Ranggi Asam
19.05.03.2009|Ketap
19.05.03.2018|Mislak
19.05.03.2019|Pebuar
19.05.03.2020|Sinar Manik
19.05.03.2021|Air Kuang
19.05.04.1001|Kelapa
19.05.04.2002|Mancung
19.05.04.2003|Kayu Arang
19.05.04.2004|Pusuk
19.05.04.2005|Dendang
19.05.04.2006|Kacung
19.05.04.2007|Sinar Sari
19.05.04.2008|Beruas
19.05.04.2009|Tebing
19.05.04.2010|Terentang
19.05.04.2011|Tuik
19.05.04.2012|Tugang
19.05.04.2013|Air Bulin
19.05.04.2014|Pangkal Beras
19.05.05.2001|Tempilang
19.05.05.2002|Tanjung Niur
19.05.05.2003|Sangku
19.05.05.2004|Buyan Kelumbi
19.05.05.2005|Penyampak
19.05.05.2006|Benteng Kota
19.05.05.2007|Air Lintang
19.05.05.2008|Sinar Surya
19.05.05.2009|Simpang Yul
19.05.06.2001|Sekar Biru
19.05.06.2002|Telak
19.05.06.2003|Cupat
19.05.06.2004|Bakit
19.05.06.2005|Puput
19.05.06.2006|Air Gantang
19.05.06.2007|Kelabat
19.05.06.2008|Kapit
19.05.06.2009|Semulut
19.05.06.2010|Teluk Limau
19.06.01.2001|Lalang Jaya
19.06.01.2002|Kurnia Jaya
19.06.01.2003|Padang
19.06.01.2004|Kelubi
19.06.01.2006|Lalang
19.06.01.2007|Baru
19.06.01.2010|Buku Limau
19.06.01.2012|Mekar Jaya
19.06.01.2013|Bentaian Jaya
19.06.02.2001|Gantung
19.06.02.2002|Selingsing
19.06.02.2003|Jangkar Asam
19.06.02.2004|Lilangan
19.06.02.2009|Lenggang
19.06.02.2010|Batu Penyu
19.06.02.2011|Limbongan
19.06.03.2001|Dendang
19.06.03.2002|Jangkang
19.06.03.2005|Nyuruk
19.06.03.2008|Balok
19.06.04.2001|Mentawak
19.06.04.2002|Senyubuk
19.06.04.2003|Cendil
19.06.04.2005|Buding
19.06.04.2006|Mayang
19.06.04.2007|Pembaharuan
19.06.05.2001|Air Kelik
19.06.05.2002|Mempaya
19.06.05.2003|Burong Mandi
19.06.05.2004|Mengkubang
19.06.05.2005|Sukamandi
19.06.06.2001|Simpang Tiga
19.06.06.2002|Renggiang
19.06.06.2003|Aik Madu
19.06.06.2004|Lintang
19.06.07.2001|Simpang Pesak
19.06.07.2002|Tanjung Batu Itam
19.06.07.2003|Tanjung Kelumpang
19.06.07.2004|Dukong
19.71.01.1004|Semabung Lama
19.71.01.1006|Bacang
19.71.01.1007|Air Itam
19.71.01.1008|Pasir Putih
19.71.01.1009|Temberan
19.71.01.1010|Sinar Bulan
19.71.01.1011|Air Mawar
19.71.02.1001|Opas Indah
19.71.02.1002|Gedung Nasional
19.71.02.1003|Batin Tikal
19.71.02.1004|Rawa Bangun
19.71.02.1005|Kejaksaan
19.71.03.1004|Pasir Garam
19.71.03.1005|Lontong Pancur
19.71.03.1006|Ketapang
19.71.03.1007|Ampui
19.71.03.1008|Rejosari
19.71.04.1001|Pintu Air
19.71.04.1002|Bintang
19.71.04.1005|Masjid Jamik
19.71.04.1006|Asam
19.71.04.1007|Melintang
19.71.04.1008|Parit Lalang
19.71.04.1009|Keramat
19.71.04.1010|Gajah Mada
19.71.05.1001|Taman Bunga
19.71.05.1002|Bukit Merapen
19.71.05.1004|Bukit Sari
19.71.05.1005|Tua Tunu Indah
19.71.05.1006|Kacang Pedang
19.71.05.1007|Air Kepala Tujuh
19.71.06.1001|Selindung
19.71.06.1002|Selindung Baru
19.71.06.1003|Gabek Satu
19.71.06.1004|Gabek Dua
19.71.06.1005|Air Salemba
19.71.06.1006|Jerambah Gantung
19.71.07.1001|Pasar Padi
19.71.07.1002|Batu Intan
19.71.07.1003|Bukit Besar
19.71.07.1004|Sriwijaya
19.71.07.1005|Semabung Baru
21.01.04.1005|Kawal
21.01.04.2001|Gunung Kijang
21.01.04.2002|Malang Rapat
21.01.04.2003|Teluk Bakau
21.01.06.1008|Kijang Kota
21.01.06.1009|Sungai Lekop
21.01.06.1010|Gunung Lengkuas
21.01.06.1011|Sungai Enam
21.01.07.1001|Tanjung Uban Kota
21.01.07.1002|Tanjung Uban Utara
21.01.07.1003|Tanjung Uban Selatan
21.01.07.1011|Tanjung Uban Timur
21.01.07.2005|Lancang Kuning
21.01.08.1006|Tembeling Tanjung
21.01.08.2001|Bintan Buyu
21.01.08.2002|Pangkil
21.01.08.2003|Penaga
21.01.08.2004|Pengujan
21.01.08.2005|Tembeling
21.01.09.1001|Teluk Sekuni
21.01.09.2002|Batu Lepuk
21.01.09.2003|Kampung Hilir
21.01.09.2004|Kampung Melayu
21.01.09.2005|Pulau Mentebung
21.01.09.2006|Pulau Pinang
21.01.09.2007|Kukup
21.01.09.2008|Pengikik
21.01.10.1007|Kota Baru
21.01.10.2001|Berakit
21.01.10.2002|Ekang Anculai
21.01.10.2003|Pengudang
21.01.10.2004|Sebong Lagoi
21.01.10.2005|Sebong Pereh
21.01.10.2006|Sri Bintan
21.01.12.1004|Toapaya Asri
21.01.12.2001|Toapaya
21.01.12.2002|Toapaya Utara
21.01.12.2003|Toapaya Selatan
21.01.13.2001|Mantang Baru
21.01.13.2002|Mantang Besar
21.01.13.2003|Mantang Lama
21.01.13.2004|Dendun
21.01.14.2001|Kelong
21.01.14.2002|Mapur
21.01.14.2003|Numbing
21.01.14.2004|Air Gelubi
21.01.15.1003|Teluk Lobam
21.01.15.1005|Tanjung Permai
21.01.15.2001|Busung
21.01.15.2002|Teluk Sasah
21.01.15.2004|Kuala Sempang
21.02.01.1003|Moro
21.02.01.1010|Moro Timur
21.02.01.2004|Pauh
21.02.01.2009|Jang
21.02.01.2014|Pulau Moro
21.02.02.1001|Tanjung Batu Barat
21.02.02.1002|Tanjung Batu Kota
21.02.02.1009|Gading Sari
21.02.02.2004|Sungai Sebesi
21.02.02.2005|Sungai Ungar
21.02.02.2006|Lubuk
21.02.03.1001|Tanjung Balai
21.02.03.1002|Teluk Air
21.02.03.1003|Sungai Lakam Timur
21.02.03.1006|Lubuk Semut
21.02.03.1007|Tanjung Balai Kota
21.02.03.1008|Sungai Lakam Barat
21.02.04.1001|Meral Kota
21.02.04.1002|Baran Barat
21.02.04.1003|Sungai Raya
21.02.04.1006|Baran Timur
21.02.04.1007|Sungai Pasir
21.02.04.1008|Parit Benut
21.02.05.1001|Tebing
21.02.05.1002|Teluk Uma
21.02.05.1003|Kapling
21.02.05.1004|Pamak
21.02.05.1008|Harjosari
21.02.05.2007|Pongkar
21.02.06.1001|Buru
21.02.06.1002|Lubuk Puding
21.02.06.2003|Tanjung Hutan
21.02.06.2004|Tanjung Batu Kecil
21.02.07.1012|Tanjung Berlian Kota
21.02.07.2003|Sungai Ungar Utara
21.02.07.2004|Teluk Radang
21.02.07.2010|Perayun
21.02.07.2013|Tanjung Berlian Barat
21.02.08.1001|Sawang
21.02.08.2002|Sawang Selatan
21.02.08.2003|Sawang Laut
21.02.08.2004|Kundur
21.02.08.2005|Gemuruh
21.02.09.2002|Sanglar
21.02.09.2003|Tanjung Kilang
21.02.09.2004|Semembang
21.02.09.2005|Telaga Tujuh
21.02.10.1001|Pasir Panjang
21.02.10.1002|Darussalam
21.02.10.2003|Pangke
21.02.10.2004|Pangke Barat
21.02.11.1001|Alai
21.02.11.2002|Batu Limau
21.02.11.2003|Ngal
21.02.11.2004|Sungai Buluh
21.02.12.2001|Sebele
21.02.12.2002|Lebuh
21.02.12.2003|Penarah
21.02.12.2004|Sungai Asam
21.02.12.2005|Tebias
21.02.12.2006|Degong
21.02.13.2001|Parit
21.02.13.2002|Tulang
21.02.13.2003|Selat Mendaun
21.02.14.2001|Sugie
21.02.14.2002|Niur Permai
21.02.14.2003|Keban
21.02.14.2004|Rawa Jaya
21.02.14.2005|Tanjung Pelanduk
21.02.14.2006|Buluh Patah
21.02.14.2007|Selat Mie
21.03.04.1003|Sabang Barat
21.03.04.2001|Sebelat
21.03.04.2005|Air Putih
21.03.05.1008|Sedanau
21.03.05.2007|Mekar Jaya
21.03.05.2012|Binjai
21.03.05.2013|Piantengah
21.03.05.2015|Selaut
21.03.06.1003|Serasan
21.03.06.2002|Kampung Hilir
21.03.06.2005|Batu Berlian
21.03.06.2006|Tanjung Setelung
21.03.06.2007|Tanjung Balau
21.03.06.2010|Pangkalan
21.03.06.2011|Jermalik
21.03.07.1011|Ranai Kota
21.03.07.1016|Ranai Darat
21.03.07.1017|Bandarsyah
21.03.07.1019|Batu Hitam
21.03.07.2002|Sungai Ulu
21.03.07.2004|Sepempang
21.03.07.2014|Batu Gajah
21.03.08.2001|Kelarik Utara
21.03.08.2002|Kelarik
21.03.08.2004|Kelarik Air Mali
21.03.08.2005|Teluk Buton
21.03.08.2006|Belakang Gunung
21.03.08.2008|Gunung Durian
21.03.09.2001|Subi
21.03.09.2002|Subi Besar
21.03.09.2003|Meliah
21.03.09.2005|Terayak
21.03.09.2007|Subi Besar Timur
21.03.09.2008|Meliah Selatan
21.03.10.2001|Tanjung Pala
21.03.10.2002|Air Payang
21.03.10.2003|Kadur
21.03.11.2001|Sabang Mawang
21.03.11.2003|Sededap
21.03.11.2004|Tanjung Batang
21.03.11.2005|Serantas
21.03.11.2006|Sabang Mawang Barat
21.03.11.2010|Teluk Labuh
21.03.15.2001|Tanjung
21.03.15.2002|Ceruk
21.03.15.2003|Kelanga
21.03.15.2004|Pengadah
21.03.15.2005|Sebadai Ulu
21.03.15.2006|Limau Manis
21.03.15.2007|Seleman
21.03.16.2001|Tapau
21.03.16.2002|Harapan Jaya
21.03.16.2003|Air Lengit
21.03.18.2001|Cemaga
21.03.18.2002|Cemaga Selatan (Setengar)
21.03.18.2003|Cemaga Utara (Singgang Bulan)
21.03.18.2004|Cemaga Tengah
21.03.19.2001|Arung Ayam
21.03.19.2002|Air Nusa
21.03.19.2004|Air Ringau
21.03.19.2005|Payak
21.03.20.2001|Batubi Jaya
21.03.20.2002|Gunung Putri
21.03.20.2003|Sedarat Baru
21.03.20.2004|Sedanau Timur
21.03.20.2005|Semedang
21.03.21.2001|Pulau Tiga
21.03.21.2002|Tanjung Kumbik Utara
21.03.21.2003|Setumuk
21.03.21.2004|Selading
21.03.22.2001|Air Kumpai
21.03.22.2002|Batu Belanak
21.03.22.2003|Gunung Jambat
21.03.23.2001|Pulau Panjang
21.03.23.2002|Pulau Kerdau
21.03.24.2001|Kelarik Barat
21.03.24.2002|Seluan Barat
21.04.01.1001|Dabo
21.04.01.1007|Dabo Lama
21.04.01.1012|Sungailumpur
21.04.01.2008|Batu Berdaun
21.04.01.2009|Tanjung Harapan
21.04.01.2010|Batu Kacang
21.04.02.1010|Daik
21.04.02.1020|Daik Sepincan
21.04.02.2001|Pekajang
21.04.02.2002|Kelombok
21.04.02.2003|Mepar
21.04.02.2006|Kelumu
21.04.02.2007|Mentuda
21.04.02.2008|Merawang
21.04.02.2009|Panggak Darat
21.04.02.2011|Panggak Laut
21.04.02.2012|Musai
21.04.02.2019|Nerekeh
21.04.03.1001|Senayang
21.04.03.2002|Mamut
21.04.03.2012|Laboh
21.04.03.2013|Penaah
21.04.03.2015|Baran
21.04.04.1006|Raya
21.04.04.2001|Bakong
21.04.04.2002|Kuala Raya
21.04.04.2003|Marok Tua
21.04.04.2005|Sungai Buluh
21.04.04.2007|Sungai Raya
21.04.04.2008|Sungai Harapan
21.04.04.2009|Jagoh
21.04.04.2012|Tinjul
21.04.04.2013|Langkap
21.04.04.2014|Tanjung Irat
21.04.04.2015|Bukit Belah
21.04.05.1007|Pancur
21.04.05.2001|Bukit Harapan
21.04.05.2002|Duara
21.04.05.2003|Limbung
21.04.05.2004|Resun
21.04.05.2005|Sekanah
21.04.05.2008|Linau
21.04.05.2009|Sungaibesar
21.04.05.2010|Rantau Panjang
21.04.05.2012|Resun Pesisir
21.04.06.2001|Berindat
21.04.06.2002|Sedamai
21.04.06.2003|Lanjut
21.04.06.2004|Kote
21.04.06.2005|Persing
21.04.06.2006|Pelakak
21.04.07.2001|Bukitlangkap
21.04.07.2002|Keton
21.04.07.2003|Pekaka
21.04.07.2004|Kerandin
21.04.07.2005|Sungai Pinang
21.04.07.2006|Kudung
21.04.07.2007|Teluk
21.04.07.2008|Belungkur
21.04.08.2001|Selayar
21.04.08.2002|Penuba
21.04.08.2003|Penuba Timur
21.04.08.2004|Pantai Harapan
21.04.09.1004|Berlian
21.04.09.2001|Marok Kecil
21.04.09.2002|Pulau Lalang
21.04.09.2003|Resang
21.04.10.2001|Busung Panjang
21.04.10.2002|Posek
21.04.10.2003|Suak Buaya
21.04.11.2001|Benan
21.04.11.2002|Mensanak
21.04.11.2003|Pulau Bukit
21.04.11.2004|Pulau Duyung
21.04.11.2005|Pulau Medang
21.04.12.2001|Temiang
21.04.12.2002|Tajur Biru
21.04.12.2003|Pulau Batang
21.04.13.2001|Batu Belubang
21.04.13.2002|Cempa
21.04.13.2003|Pasir Panjang
21.04.13.2004|Tanjung Kelit
21.04.13.2005|Tanjung Lipat
21.04.13.2006|Rejai
21.05.01.1001|Terempa
21.05.01.2002|Terempa Barat
21.05.01.2003|Tarempa Selatan
21.05.01.2004|Tarempa Timur
21.05.01.2005|Pesisir Timur
21.05.01.2006|Sri Tanjung
21.05.01.2007|Tarempa Barat Daya
21.05.02.2002|Tebang
21.05.02.2003|Ladan
21.05.02.2005|Piabung
21.05.02.2006|Langir
21.05.02.2007|Candi
21.05.02.2008|Putik
21.05.02.2015|Belibak
21.05.03.2001|Nyamuk
21.05.03.2002|Batu Belah
21.05.03.2003|Munjan
21.05.03.2004|Serat
21.05.03.2005|Air Putih
21.05.03.2006|Temburun
21.05.04.2001|Kiabu
21.05.04.2002|Telaga
21.05.04.2003|Mengkait
21.05.04.2004|Tiangau
21.05.04.2005|Telaga Kecil
21.05.04.2006|Lingai
21.05.04.2007|Air Bini
21.05.05.2001|Kuala Maras
21.05.05.2002|Ulu Maras
21.05.05.2003|Bukit Padi
21.05.05.2004|Genting Pulur
21.05.06.1005|Letung
21.05.06.2001|Mampok
21.05.06.2002|Rewak
21.05.06.2006|Air Biru
21.05.06.2008|Batu Berapit
21.05.06.2009|Landak
21.05.07.2001|Air Asuk
21.05.07.2002|Air Sena
21.05.07.2003|Teluk Siantan
21.05.07.2004|Lidi
21.05.07.2005|Liuk
21.05.07.2006|Teluk Sunting
21.05.08.2001|Mubur
21.05.08.2002|Piasan
21.05.08.2003|Bayat
21.05.09.2001|Impol
21.05.09.2002|Keramut
21.05.09.2003|Sunggak
21.05.10.2001|Payalaman
21.05.10.2002|Payamaram
21.05.10.2003|Batu Ampar
21.05.10.2004|Matak
21.05.10.2005|Teluk Bayur
21.71.01.1002|Pemping
21.71.01.1003|Kasu
21.71.01.1004|Pulau Terung
21.71.01.1005|Pecong
21.71.01.1006|Tanjung Sari
21.71.01.1007|Sekanak Raya
21.71.02.1001|Tanjung Sengkuang
21.71.02.1002|Sungai Jodoh
21.71.02.1003|Batu Merah
21.71.02.1004|Kampung Seraya
21.71.03.1001|Sungai Harapan
21.71.03.1002|Tanjung Pinggir
21.71.03.1003|Tanjung Riau
21.71.03.1005|Tiban Indah
21.71.03.1006|Tiban Baru
21.71.03.1007|Tiban Lama
21.71.03.1008|Patam Lestari
21.71.04.1001|Sambau
21.71.04.1002|Batu Besar
21.71.04.1003|Kabil
21.71.04.1004|Ngenang
21.71.05.1001|Bulang Lintang
21.71.05.1002|Pulau Buluh
21.71.05.1003|Temoyong
21.71.05.1004|Batu Legong
21.71.05.1005|Pantai Gelam
21.71.05.1006|Pulau Setokok
21.71.06.1001|Kampung Pelita
21.71.06.1003|Lubuk Baja Kota
21.71.06.1004|Batu Selicin
21.71.06.1005|Tanjung Uma
21.71.06.1006|Baloi Indah
21.71.07.1001|Muka Kuning
21.71.07.1002|Duriangkang
21.71.07.1003|Mangsang
21.71.07.1004|Tanjung Piayu
21.71.08.1001|Sijantung
21.71.08.1002|Karas
21.71.08.1003|Galang Baru
21.71.08.1004|Sembulang
21.71.08.1005|Rempang Cate
21.71.08.1006|Subang Mas
21.71.08.1007|Pulau Abang
21.71.08.1008|Air Raja
21.71.09.1001|Bengkong Indah
21.71.09.1002|Bengkong Laut
21.71.09.1003|Sadai
21.71.09.1004|Tanjung Buntung
21.71.10.1001|Baloi Permai
21.71.10.1002|Taman Baloi
21.71.10.1003|Teluk Tering
21.71.10.1004|Belian
21.71.10.1005|Sukajadi
21.71.10.1006|Sungai Panas
21.71.11.1001|Tembesi
21.71.11.1002|Sungai Binti
21.71.11.1003|Sungai Lekop
21.71.11.1004|Sagulung Kota
21.71.11.1005|Sungai Langkai
21.71.11.1006|Sungai Pelunggut
21.71.12.1001|Tanjung Uncang
21.71.12.1002|Buliang
21.71.12.1003|Kibing
21.71.12.1004|Bukit Tempayan
21.72.01.1001|Tanjung Pinang Barat
21.72.01.1002|Kemboja
21.72.01.1003|Kampung Baru
21.72.01.1004|Bukit Cermin
21.72.02.1001|Melayu Kota Piring
21.72.02.1002|Kampung Bulang
21.72.02.1003|Air Raja
21.72.02.1004|Batu IX
21.72.02.1005|Pinang Kencana
21.72.03.1001|Tanjung Pinang Kota
21.72.03.1003|Senggarang
21.72.03.1004|Penyengat
21.72.03.1005|Kampung Bugis
21.72.04.1001|Tanjung Pinang Timur
21.72.04.1002|Dompak
21.72.04.1003|Tanjung Ayun Sakti
21.72.04.1004|Sei Jang
21.72.04.1005|Tanjung Unggat
31.01.01.1001|Pulau Panggang
31.01.01.1002|Pulau Kelapa
31.01.01.1003|Pulau Harapan
31.01.02.1001|Pulau Untung Jawa
31.01.02.1002|Pulau Tidung
31.01.02.1003|Pulau Pari
31.71.01.1001|Gambir
31.71.01.1002|Cideng
31.71.01.1003|Petojo Utara
31.71.01.1004|Petojo Selatan
31.71.01.1005|Kebon Kelapa
31.71.01.1006|Duri Pulo
31.71.02.1001|Pasar Baru
31.71.02.1002|Karang Anyar
31.71.02.1003|Kartini
31.71.02.1004|Gunung Sahari Utara
31.71.02.1005|Mangga Dua Selatan
31.71.03.1001|Kemayoran
31.71.03.1002|Kebon Kosong
31.71.03.1003|Harapan Mulia
31.71.03.1004|Serdang
31.71.03.1005|Gunung Sahari Selatan
31.71.03.1006|Cempaka Baru
31.71.03.1007|Sumur Batu
31.71.03.1008|Utan Panjang
31.71.04.1001|Senen
31.71.04.1002|Kenari
31.71.04.1003|Paseban
31.71.04.1004|Kramat
31.71.04.1005|Kwitang
31.71.04.1006|Bungur
31.71.05.1001|Cempaka Putih Timur
31.71.05.1002|Cempaka Putih Barat
31.71.05.1003|Rawasari
31.71.06.1001|Menteng
31.71.06.1002|Pegangsaan
31.71.06.1003|Cikini
31.71.06.1004|Gondangdia
31.71.06.1005|Kebon Sirih
31.71.07.1001|Gelora
31.71.07.1002|Bendungan Hilir
31.71.07.1003|Karet Tengsin
31.71.07.1004|Petamburan
31.71.07.1005|Kebon Melati
31.71.07.1006|Kebon Kacang
31.71.07.1007|Kampung Bali
31.71.08.1001|Johar Baru
31.71.08.1002|Kampung Rawa
31.71.08.1003|Galur
31.71.08.1004|Tanah Tinggi
31.72.01.1001|Penjaringan
31.72.01.1002|Kamal Muara
31.72.01.1003|Kapuk Muara
31.72.01.1004|Pejagalan
31.72.01.1005|Pluit
31.72.02.1001|Tanjung Priok
31.72.02.1002|Sunter Jaya
31.72.02.1003|Papanggo
31.72.02.1004|Sungai Bambu
31.72.02.1005|Kebon Bawang
31.72.02.1006|Sunter Agung
31.72.02.1007|Warakas
31.72.03.1001|Koja
31.72.03.1002|Tugu Utara
31.72.03.1003|Lagoa
31.72.03.1004|Rawa Badak Utara
31.72.03.1005|Tugu Selatan
31.72.03.1006|Rawa Badak Selatan
31.72.04.1001|Cilincing
31.72.04.1002|Sukapura
31.72.04.1003|Marunda
31.72.04.1004|Kalibaru
31.72.04.1005|Semper Timur
31.72.04.1006|Rorotan
31.72.04.1007|Semper Barat
31.72.05.1001|Pademangan Timur
31.72.05.1002|Pademangan Barat
31.72.05.1003|Ancol
31.72.06.1001|Kelapa Gading Timur
31.72.06.1002|Pegangsaan Dua
31.72.06.1003|Kelapa Gading Barat
31.73.01.1001|Cengkareng Barat
31.73.01.1002|Duri Kosambi
31.73.01.1003|Rawa Buaya
31.73.01.1004|Kedaung Kali Angke
31.73.01.1005|Kapuk
31.73.01.1006|Cengkareng Timur
31.73.02.1001|Grogol
31.73.02.1002|Tanjung Duren Utara
31.73.02.1003|Tomang
31.73.02.1004|Jelambar
31.73.02.1005|Tanjung Duren Selatan
31.73.02.1006|Jelambar Baru
31.73.02.1007|Wijaya Kusuma
31.73.03.1001|Taman Sari
31.73.03.1002|Krukut
31.73.03.1003|Maphar
31.73.03.1004|Tangki
31.73.03.1005|Mangga Besar
31.73.03.1006|Keagungan
31.73.03.1007|Glodok
31.73.03.1008|Pinangsia
31.73.04.1001|Tambora
31.73.04.1002|Kali Anyar
31.73.04.1003|Duri Utara
31.73.04.1004|Tanah Sereal
31.73.04.1005|Krendang
31.73.04.1006|Jembatan Besi
31.73.04.1007|Angke
31.73.04.1008|Jembatan Lima
31.73.04.1009|Pekojan
31.73.04.1010|Roa Malaka
31.73.04.1011|Duri Selatan
31.73.05.1001|Kebon Jeruk
31.73.05.1002|Sukabumi Utara
31.73.05.1003|Sukabumi Selatan
31.73.05.1004|Kelapa Dua
31.73.05.1005|Duri Kepa
31.73.05.1006|Kedoya Utara
31.73.05.1007|Kedoya Selatan
31.73.06.1001|Kalideres
31.73.06.1002|Semanan
31.73.06.1003|Tegal Alur
31.73.06.1004|Kamal
31.73.06.1005|Pegadungan
31.73.07.1001|Palmerah
31.73.07.1002|Slipi
31.73.07.1003|Kota Bambu Utara
31.73.07.1004|Jatipulo
31.73.07.1005|Kemanggisan
31.73.07.1006|Kota Bambu Selatan
31.73.08.1001|Kembangan Utara
31.73.08.1002|Meruya Utara
31.73.08.1003|Meruya Selatan
31.73.08.1004|Srengseng
31.73.08.1005|Joglo
31.73.08.1006|Kembangan Selatan
31.74.01.1001|Tebet Timur
31.74.01.1002|Tebet Barat
31.74.01.1003|Menteng Dalam
31.74.01.1004|Kebon Baru
31.74.01.1005|Bukit Duri
31.74.01.1006|Manggarai Selatan
31.74.01.1007|Manggarai
31.74.02.1001|Setia Budi
31.74.02.1002|Karet Semanggi
31.74.02.1003|Karet Kuningan
31.74.02.1004|Karet
31.74.02.1005|Menteng Atas
31.74.02.1006|Pasar Manggis
31.74.02.1007|Guntur
31.74.02.1008|Kuningan Timur
31.74.03.1001|Mampang Prapatan
31.74.03.1002|Bangka
31.74.03.1003|Pela Mampang
31.74.03.1004|Tegal Parang
31.74.03.1005|Kuningan Barat
31.74.04.1001|Pasar Minggu
31.74.04.1002|Jati Padang
31.74.04.1003|Cilandak Timur
31.74.04.1004|Ragunan
31.74.04.1005|Pejaten Timur
31.74.04.1006|Pejaten Barat
31.74.04.1007|Kebagusan
31.74.05.1001|Kebayoran Lama Utara
31.74.05.1002|Pondok Pinang
31.74.05.1003|Cipulir
31.74.05.1004|Grogol Utara
31.74.05.1005|Grogol Selatan
31.74.05.1006|Kebayoran Lama Selatan
31.74.06.1001|Cilandak Barat
31.74.06.1002|Lebak Bulus
31.74.06.1003|Pondok Labu
31.74.06.1004|Gandaria Selatan
31.74.06.1005|Cipete Selatan
31.74.07.1001|Melawai
31.74.07.1002|Gunung
31.74.07.1003|Kramat Pela
31.74.07.1004|Selong
31.74.07.1005|Rawa Barat
31.74.07.1006|Senayan
31.74.07.1007|Pulo
31.74.07.1008|Petogogan
31.74.07.1009|Gandaria Utara
31.74.07.1010|Cipete Utara
31.74.08.1001|Pancoran
31.74.08.1002|Kalibata
31.74.08.1003|Rawajati
31.74.08.1004|Duren Tiga
31.74.08.1005|Pengadegan
31.74.08.1006|Cikoko
31.74.09.1001|Jagakarsa
31.74.09.1002|Srengseng Sawah
31.74.09.1003|Ciganjur
31.74.09.1004|Lenteng Agung
31.74.09.1005|Tanjung Barat
31.74.09.1006|Cipedak
31.74.10.1001|Pesanggrahan
31.74.10.1002|Bintaro
31.74.10.1003|Petukangan Utara
31.74.10.1004|Petukangan Selatan
31.74.10.1005|Ulujami
31.75.01.1001|Pisangan Baru
31.75.01.1002|Utan Kayu Utara
31.75.01.1003|Kayu Manis
31.75.01.1004|Palmeriam
31.75.01.1005|Kebon Manggis
31.75.01.1006|Utan Kayu Selatan
31.75.02.1001|Pulo Gadung
31.75.02.1002|Pisangan Timur
31.75.02.1003|Cipinang
31.75.02.1004|Jatinegara Kaum
31.75.02.1005|Rawamangun
31.75.02.1006|Kayu Putih
31.75.02.1007|Jati
31.75.03.1001|Kampung Melayu
31.75.03.1002|Bidara Cina
31.75.03.1003|Bali Mester
31.75.03.1004|Rawa Bunga
31.75.03.1005|Cipinang Cempedak
31.75.03.1006|Cipinang Muara
31.75.03.1007|Cipinang Besar Selatan
31.75.03.1008|Cipinang Besar Utara
31.75.04.1001|Kramatjati
31.75.04.1002|Tengah
31.75.04.1003|Dukuh
31.75.04.1004|Batu Ampar
31.75.04.1005|Balekambang
31.75.04.1006|Cililitan
31.75.04.1007|Cawang
31.75.05.1001|Gedong
31.75.05.1002|Baru
31.75.05.1003|Cijantung
31.75.05.1004|Kalisari
31.75.05.1005|Pekayon
31.75.06.1001|Jatinegara
31.75.06.1002|Rawa Terate
31.75.06.1003|Penggilingan
31.75.06.1004|Cakung Timur
31.75.06.1005|Pulo Gebang
31.75.06.1006|Ujung Menteng
31.75.06.1007|Cakung Barat
31.75.07.1001|Duren Sawit
31.75.07.1002|Pondok Bambu
31.75.07.1003|Klender
31.75.07.1004|Pondok Kelapa
31.75.07.1005|Malaka Sari
31.75.07.1006|Malaka Jaya
31.75.07.1007|Pondok Kopi
31.75.08.1001|Makasar
31.75.08.1002|Pinangranti
31.75.08.1003|Kebon Pala
31.75.08.1004|Halim Perdana Kusuma
31.75.08.1005|Cipinang Melayu
31.75.09.1001|Ciracas
31.75.09.1002|Cibubur
31.75.09.1003|Kelapa Dua Wetan
31.75.09.1004|Susukan
31.75.09.1005|Rambutan
31.75.10.1001|Cipayung
31.75.10.1002|Cilangkap
31.75.10.1003|Pondok Ranggon
31.75.10.1004|Munjul
31.75.10.1005|Setu
31.75.10.1006|Bambu Apus
31.75.10.1007|Lubang Buaya
31.75.10.1008|Ceger
32.01.01.1001|Pondok Rajeg
32.01.01.1002|Karadenan
32.01.01.1003|Harapanjaya
32.01.01.1004|Nanggewer
32.01.01.1005|Nanggewer Mekar
32.01.01.1006|Cibinong
32.01.01.1007|Pakansari
32.01.01.1008|Tengah
32.01.01.1009|Sukahati
32.01.01.1010|Ciriung
32.01.01.1011|Cirimekar
32.01.01.1012|Pabuaran
32.01.01.1013|Pabuaran Mekar
32.01.02.2001|Wanaherang
32.01.02.2002|Bojongkulur
32.01.02.2003|Ciangsana
32.01.02.2004|Gunungputri
32.01.02.2005|Bojongnangka
32.01.02.2006|Tlajung Udik
32.01.02.2007|Cicadas
32.01.02.2008|Cikeas Udik
32.01.02.2009|Nagrak
32.01.02.2010|Karanggan
32.01.03.1006|Puspanegara
32.01.03.1007|Karang Asem Barat
32.01.03.2001|Puspasari
32.01.03.2002|Citeureup
32.01.03.2003|Leuwinutug
32.01.03.2004|Tajur
32.01.03.2005|Sanja
32.01.03.2008|Karang Asem Timur
32.01.03.2009|Tarikolot
32.01.03.2010|Gunungsari
32.01.03.2011|Tangkil
32.01.03.2012|Sukahati
32.01.03.2013|Hambalang
32.01.03.2014|Pasir Mukti
32.01.04.2001|Gunung Geulis
32.01.04.2002|Cilebut Timur
32.01.04.2003|Cilebut Barat
32.01.04.2004|Cibanon
32.01.04.2005|Nagrak
32.01.04.2006|Sukatani
32.01.04.2007|Sukaraja
32.01.04.2008|Cikeas
32.01.04.2009|Pasirjambu
32.01.04.2010|Cimandala
32.01.04.2011|Cijujung
32.01.04.2012|Cadasngampar
32.01.04.2013|Pasirlaja
32.01.05.2001|Cijayanti
32.01.05.2002|Sumur Batu
32.01.05.2003|Sentul
32.01.05.2004|Karang Tengah
32.01.05.2005|Cipambuan
32.01.05.2006|Kadumanggu
32.01.05.2007|Citaringgul
32.01.05.2008|Babakan Madang
32.01.05.2009|Bojong Koneng
32.01.06.2001|Sukamaju
32.01.06.2002|Sirnagalih
32.01.06.2003|Singajaya
32.01.06.2004|Sukasirna
32.01.06.2005|Sukanegara
32.01.06.2006|Sukamanah
32.01.06.2007|Weninggalih
32.01.06.2008|Cibodas
32.01.06.2009|Jonggol
32.01.06.2010|Bendungan
32.01.06.2011|Singasari
32.01.06.2012|Balekambang
32.01.06.2013|Sukajaya
32.01.06.2014|Sukagalih
32.01.07.2001|Pasirangin
32.01.07.2002|Mekarsari
32.01.07.2003|Mampir
32.01.07.2004|Dayeuh
32.01.07.2005|Gandoang
32.01.07.2006|Jatisari
32.01.07.2007|Cileungsi Kidul
32.01.07.2008|Cipeucang
32.01.07.2009|Situsari
32.01.07.2010|Cipenjo
32.01.07.2011|Limusnunggal
32.01.07.2012|Cileungsi
32.01.08.2001|Karyamekar
32.01.08.2002|Babakanraden
32.01.08.2003|Cikutamahi
32.01.08.2004|Kutamekar
32.01.08.2005|Cariu
32.01.08.2006|Mekarwangi
32.01.08.2007|Bantarkuning
32.01.08.2008|Sukajadi
32.01.08.2009|Tegalpanjang
32.01.08.2010|Cibatutiga
32.01.09.2001|Wargajaya
32.01.09.2002|Pabuaran
32.01.09.2003|Sukadamai
32.01.09.2004|Sukawangi
32.01.09.2005|Cibadak
32.01.09.2006|Sukaresmi
32.01.09.2007|Sukamulya
32.01.09.2008|Sukaharja
32.01.09.2009|Sirnajaya
32.01.09.2010|Sukamakmur
32.01.10.2001|Parung
32.01.10.2002|Iwul
32.01.10.2003|Bojong Sempu
32.01.10.2004|Waru
32.01.10.2005|Cogreg
32.01.10.2006|Pamegarsari
32.01.10.2007|Waru Jaya
32.01.10.2008|Bojong Indah
32.01.10.2009|Jabon Mekar
32.01.11.2001|Cidokom
32.01.11.2002|Padurenan
32.01.11.2003|Pengasinan
32.01.11.2004|Curug
32.01.11.2005|Gunungsindur
32.01.11.2006|Jampang
32.01.11.2007|Cibadung
32.01.11.2008|Cibinong
32.01.11.2009|Rawakalong
32.01.11.2010|Pabuaran
32.01.12.1006|Atang Senjaya
32.01.12.2001|Bojong
32.01.12.2002|Parakanjaya
32.01.12.2003|Kemang
32.01.12.2004|Pabuaran
32.01.12.2005|Semplak Barat
32.01.12.2007|Jampang
32.01.12.2008|Pondok Udik
32.01.12.2009|Tegal
32.01.13.1007|Pabuaran
32.01.13.2001|Bojongbaru
32.01.13.2002|Cimanggis
32.01.13.2003|Susukan
32.01.13.2004|Ragajaya
32.01.13.2005|Kedung Waringin
32.01.13.2006|Waringin Jaya
32.01.13.2008|Rawapanjang
32.01.13.2009|Bojonggede
32.01.14.2001|Leuwiliang
32.01.14.2002|Purasari
32.01.14.2003|Karyasari
32.01.14.2004|Pabangbon
32.01.14.2005|Karacak
32.01.14.2006|Barengkok
32.01.14.2007|Leuwimekar
32.01.14.2008|Puraseda
32.01.14.2009|Cibeber I
32.01.14.2010|Cibeber II
32.01.14.2011|Karehkel
32.01.15.2001|Ciampea
32.01.15.2002|Cinangka
32.01.15.2003|Cihideung Udik
32.01.15.2004|Bojongjengkol
32.01.15.2005|Tegalwaru
32.01.15.2006|Cibuntu
32.01.15.2007|Cicadas
32.01.15.2008|Cibadak
32.01.15.2009|Bojongrangkas
32.01.15.2010|Cihideung Ilir
32.01.15.2011|Cibanteng
32.01.15.2012|Benteng
32.01.15.2013|Ciampea Udik
32.01.16.2001|Situ Udik
32.01.16.2002|Situ Ilir
32.01.16.2003|Cemplang
32.01.16.2004|Cibatok I
32.01.16.2005|Ciaruteun Udik
32.01.16.2006|Leuweungkolot
32.01.16.2007|Cimanggu I
32.01.16.2008|Cimanggu II
32.01.16.2009|Dukuh
32.01.16.2010|Cijujung
32.01.16.2011|Ciaruteun Ilir
32.01.16.2012|Cibatok II
32.01.16.2013|Sukamaju
32.01.16.2014|Galuga
32.01.16.2015|Girimulya
32.01.17.2001|Purwabakti
32.01.17.2002|Cibunian
32.01.17.2003|Cibitung Wetan
32.01.17.2004|Gunung Menyan
32.01.17.2005|Gunung Bunder II
32.01.17.2006|Pasarean
32.01.17.2007|Cimayang
32.01.17.2008|Pamijahan
32.01.17.2009|Cibening
32.01.17.2010|Gunung Bunder I
32.01.17.2011|Cibitung Kulon
32.01.17.2012|Gunung Picung
32.01.17.2013|Ciasihan
32.01.17.2014|Gunung Sari
32.01.17.2015|Ciasmara
32.01.18.2001|Rumpin
32.01.18.2002|Leuwibatu
32.01.18.2003|Cidokom
32.01.18.2004|Gobang
32.01.18.2005|Cibodas
32.01.18.2006|Rabak
32.01.18.2007|Kampung Sawah
32.01.18.2008|Cipinang
32.01.18.2009|Sukasari
32.01.18.2010|Tamansari
32.01.18.2011|Kertajaya
32.01.18.2012|Sukamulya
32.01.18.2013|Mekarsari
32.01.18.2014|Mekarjaya
32.01.19.2001|Curug
32.01.19.2002|Pangradin
32.01.19.2003|Kalongsawah
32.01.19.2004|Sipak
32.01.19.2005|Jasinga
32.01.19.2006|Koleang
32.01.19.2007|Cikopomayak
32.01.19.2008|Setu
32.01.19.2009|Barengkok
32.01.19.2010|Bagoang
32.01.19.2011|Pangaur
32.01.19.2012|Pamagersari
32.01.19.2013|Jugalajaya
32.01.19.2014|Tegalwangi
32.01.19.2015|Neglasari
32.01.19.2016|Wirajaya
32.01.20.2001|Jagabaya
32.01.20.2002|Gorowong
32.01.20.2003|Dago
32.01.20.2004|Pingku
32.01.20.2005|Cikuda
32.01.20.2006|Parungpanjang
32.01.20.2007|Lumpang
32.01.20.2008|Cibunar
32.01.20.2009|Jagabita
32.01.20.2010|Gintungcilejet
32.01.20.2011|Kabasiran
32.01.21.2001|Malasari
32.01.21.2002|Curugbitung
32.01.21.2003|Cisarua
32.01.21.2004|Bantarkaret
32.01.21.2005|Hambaro
32.01.21.2006|Kalongliud
32.01.21.2007|Nanggung
32.01.21.2008|Parakanmuncang
32.01.21.2009|Pangkaljaya
32.01.21.2010|Sukaluyu
32.01.21.2011|Batu Tulis
32.01.22.2001|Sukamaju
32.01.22.2002|Cigudeg
32.01.22.2003|Bunar
32.01.22.2004|Banyuresmi
32.01.22.2005|Cintamanik
32.01.22.2006|Argapura
32.01.22.2007|Bangunjaya
32.01.22.2008|Rengasjajar
32.01.22.2009|Batujajar
32.01.22.2010|Wargajaya
32.01.22.2011|Sukaraksa
32.01.22.2012|Banyuwangi
32.01.22.2013|Banyuasih
32.01.22.2014|Mekarjaya
32.01.22.2015|Tegallega
32.01.23.2001|Tapos
32.01.23.2002|Ciomas
32.01.23.2003|Batok
32.01.23.2004|Babakan
32.01.23.2005|Tenjo
32.01.23.2006|Cilaku
32.01.23.2007|Singabraja
32.01.23.2008|Singabangsa
32.01.23.2009|Bojong
32.01.24.2001|Cileungsi
32.01.24.2002|Citapen
32.01.24.2003|Cibedug
32.01.24.2004|Jambuluwuk
32.01.24.2005|Banjarsari
32.01.24.2006|Telukpinang
32.01.24.2007|Banjarwaru
32.01.24.2008|Bendungan
32.01.24.2009|Pandansari
32.01.24.2010|Bojongmurni
32.01.24.2011|Banjarwangi
32.01.24.2012|Ciawi
32.01.24.2013|Bitungsari
32.01.25.1010|Cisarua
32.01.25.2001|Batulayang
32.01.25.2002|Jogjogan
32.01.25.2003|Cibeureum
32.01.25.2004|Cilember
32.01.25.2005|Citeko
32.01.25.2006|Tugu Selatan
32.01.25.2007|Leuwimalang
32.01.25.2008|Kopo
32.01.25.2009|Tugu Utara
32.01.26.2001|Sukamaju
32.01.26.2002|Kuta
32.01.26.2003|Gadog
32.01.26.2004|Sukakarya
32.01.26.2005|Megamendung
32.01.26.2006|Cipayung
32.01.26.2007|Sukamanah
32.01.26.2008|Sukagalih
32.01.26.2009|Cipayung Girang
32.01.26.2010|Sukamahi
32.01.26.2011|Sukaresmi
32.01.26.2012|Pasir Angin
32.01.27.2001|Pasirmuncang
32.01.27.2002|Cimande Hilir
32.01.27.2003|Ciderum
32.01.27.2004|Caringin
32.01.27.2005|Ciherang Pondok
32.01.27.2006|Cinagara
32.01.27.2007|Cimande
32.01.27.2008|Pancawati
32.01.27.2009|Muarajaya
32.01.27.2010|Pasirbuncir
32.01.27.2011|Lemah Duhur
32.01.27.2012|Tangkil
32.01.28.2001|Cijeruk
32.01.28.2002|Cipelang
32.01.28.2003|Warungmenteng
32.01.28.2004|Tajurhalang
32.01.28.2005|Cipicung
32.01.28.2006|Cibalung
32.01.28.2007|Sukaharja
32.01.28.2008|Palasari
32.01.28.2009|Tanjungsari
32.01.29.1003|Padasuka
32.01.29.2001|Mekarjaya
32.01.29.2002|Sukaharja
32.01.29.2004|Parakan
32.01.29.2005|Ciomas
32.01.29.2006|Pagelaran
32.01.29.2007|Sukamakmur
32.01.29.2008|Ciapus
32.01.29.2009|Kotabatu
32.01.29.2010|Laladon
32.01.29.2011|Ciomas Rahayu
32.01.30.2001|Sukadamai
32.01.30.2002|Ciherang
32.01.30.2003|Sinarsari
32.01.30.2004|Sukawening
32.01.30.2005|Petir
32.01.30.2006|Purwasari
32.01.30.2007|Cikarawang
32.01.30.2008|Babakan
32.01.30.2009|Dramaga
32.01.30.2010|Neglasari
32.01.31.2001|Sukamantri
32.01.31.2002|Sirnagalih
32.01.31.2003|Pasir Eurih
32.01.31.2004|Tamansari
32.01.31.2005|Sukaluyu
32.01.31.2006|Sukaresmi
32.01.31.2007|Sukajaya
32.01.31.2008|Sukajadi
32.01.32.2001|Klapanunggal
32.01.32.2002|Bojong
32.01.32.2003|Nambo
32.01.32.2004|Lulut
32.01.32.2005|Cikahuripan
32.01.32.2006|Kembangkuning
32.01.32.2007|Bantarjati
32.01.32.2008|Leuwikaret
32.01.32.2009|Ligarmukti
32.01.33.2001|Putat Nutug
32.01.33.2002|Ciseeng
32.01.33.2003|Parigi Mekar
32.01.33.2004|Cibentang
32.01.33.2005|Cibeuteung Udik
32.01.33.2006|Karihkil
32.01.33.2007|Babakan
32.01.33.2008|Cihowe
32.01.33.2009|Cibeuteung Muara
32.01.33.2010|Kuripan
32.01.34.2001|Bantarjaya
32.01.34.2002|Bantarsari
32.01.34.2003|Pasirgaok
32.01.34.2004|Rancabungur
32.01.34.2005|Mekarsari
32.01.34.2006|Candali
32.01.34.2007|Cimulang
32.01.35.2001|Cisarua
32.01.35.2002|Kiarasari
32.01.35.2003|Sukajaya
32.01.35.2004|Sipayung
32.01.35.2005|Cileuksa
32.01.35.2006|Kiarapandak
32.01.35.2007|Harkatjaya
32.01.35.2008|Sukamulih
32.01.35.2009|Pasir Madang
32.01.35.2010|Urug
32.01.35.2011|Jayaraharja
32.01.36.2001|Tanjungsari
32.01.36.2002|Selawangi
32.01.36.2003|Tanjungrasa
32.01.36.2004|Antajaya
32.01.36.2005|Pasirtanjung
32.01.36.2006|Cibadak
32.01.36.2007|Sukarasa
32.01.36.2008|Sirnasari
32.01.36.2009|Buanajaya
32.01.36.2010|Sirnarasa
32.01.37.2001|Tajurhalang
32.01.37.2002|Citayam
32.01.37.2003|Sasak Panjang
32.01.37.2004|Nanggerang
32.01.37.2005|Sukmajaya
32.01.37.2006|Tonjong
32.01.37.2007|Kalisuren
32.01.38.2001|Cigombong
32.01.38.2002|Wates Jaya
32.01.38.2003|Ciburuy
32.01.38.2004|Srogol
32.01.38.2005|Cisalada
32.01.38.2006|Tugujaya
32.01.38.2007|Pasirjaya
32.01.38.2008|Ciburayut
32.01.38.2009|Ciadeg
32.01.39.2001|Leuwisadeng
32.01.39.2002|Babakan Sadeng
32.01.39.2003|Sadengkolot
32.01.39.2004|Wangunjaya
32.01.39.2005|Kalong I
32.01.39.2006|Kalong II
32.01.39.2007|Sadeng
32.01.39.2008|Sibanteng
32.01.40.2001|Tapos I
32.01.40.2002|Tapos II
32.01.40.2003|Cibitung Tengah
32.01.40.2004|Situdaun
32.01.40.2005|Cinangneng
32.01.40.2006|Gunung Malang
32.01.40.2007|Gunung Mulya
32.02.01.1001|Palabuhanratu
32.02.01.2002|Tonjong
32.02.01.2003|Citepus
32.02.01.2004|Buniwangi
32.02.01.2005|Cibodas
32.02.01.2006|Pasirsuren
32.02.01.2007|Cikadu
32.02.01.2008|Citarik
32.02.01.2009|Cimanggu
32.02.01.2010|Jayanti
32.02.02.2001|Cidadap
32.02.02.2002|Loji
32.02.02.2003|Kertajaya
32.02.02.2004|Cihaur
32.02.02.2005|Cibuntu
32.02.02.2006|Mekarasih
32.02.02.2007|Sangrawayang
32.02.03.2001|Cikakak
32.02.03.2002|Cimaja
32.02.03.2003|Ridogalih
32.02.03.2004|Sukamaju
32.02.03.2005|Cileungsing
32.02.03.2006|Margalaksana
32.02.03.2007|Sirnarasa
32.02.03.2008|Gandasoli
32.02.03.2009|Cirendang
32.02.04.2001|Bantargadung
32.02.04.2002|Mangunjaya
32.02.04.2003|Bojonggaling
32.02.04.2004|Limusnunggal
32.02.04.2005|Bantargebang
32.02.04.2006|Buanajaya
32.02.04.2007|Boyongsari
32.02.05.2001|Cisolok
32.02.05.2002|Pasirbaru
32.02.05.2003|Cikahuripan
32.02.05.2004|Cikelat
32.02.05.2005|Caringin
32.02.05.2006|Gunungkaramat
32.02.05.2007|Gunungtanjung
32.02.05.2008|Karangpapak
32.02.05.2009|Sirnaresmi
32.02.05.2010|Cicadas
32.02.05.2011|Wanajaya
32.02.05.2012|Wangunsari
32.02.05.2013|Sukarame
32.02.06.2001|Cikidang
32.02.06.2002|Cikiray
32.02.06.2003|Gunungmalang
32.02.06.2004|Pangkalan
32.02.06.2005|Cicareuh
32.02.06.2006|Tamansari
32.02.06.2007|Bumisari
32.02.06.2008|Sampora
32.02.06.2009|Nangkakoneng
32.02.06.2010|Mekarnangka
32.02.06.2011|Cijambe
32.02.06.2012|Cikarae Thoyyibah
32.02.07.2001|Lengkong
32.02.07.2002|Cilangkap
32.02.07.2003|Tegallega
32.02.07.2004|Neglasari
32.02.07.2005|Langkapjaya
32.02.08.2001|Jampangtengah
32.02.08.2002|Padabeunghar
32.02.08.2003|Bantarpanjang
32.02.08.2004|Bojongjengkol
32.02.08.2005|Nangerang
32.02.08.2006|Tanjungsari
32.02.08.2007|Sindangresmi
32.02.08.2008|Panumbangan
32.02.08.2009|Cijulang
32.02.08.2010|Bantaragung
32.02.08.2011|Bojongtipar
32.02.09.2001|Warungkiara
32.02.09.2002|Bojongkerta
32.02.09.2003|Girijaya
32.02.09.2004|Bantarkalong
32.02.09.2005|Hegarmanah
32.02.09.2006|Ubrug
32.02.09.2007|Sirnajaya
32.02.09.2008|Sukaharja
32.02.09.2009|Kertamukti
32.02.09.2010|Mekarjaya
32.02.09.2011|Damarraja
32.02.09.2012|Tarisi
32.02.10.2001|Cikembar
32.02.10.2002|Parakanlima
32.02.10.2003|Bojong
32.02.10.2004|Cimanggu
32.02.10.2005|Bojongkembar
32.02.10.2006|Sukamaju
32.02.10.2007|Cibatu
32.02.10.2008|Kertaraharja
32.02.10.2009|Sukamulya
32.02.10.2010|Bojongraharja
32.02.11.1001|Cibadak
32.02.11.2002|Sekarwangi
32.02.11.2003|Pamuruyan
32.02.11.2004|Karangtengah
32.02.11.2005|Neglasari
32.02.11.2006|Warnajati
32.02.11.2007|Tenjojaya
32.02.11.2008|Ciheulang Tonggoh
32.02.11.2009|Sukasirna
32.02.11.2010|Batununggal
32.02.12.2001|Kalaparea
32.02.12.2002|Pawenang
32.02.12.2003|Nagrak Utara
32.02.12.2004|Cisarua
32.02.12.2009|Balekambang
32.02.12.2010|Babakan Panjang
32.02.12.2011|Darmareja
32.02.12.2012|Cihanyawar
32.02.12.2013|Nagrak Selatan
32.02.12.2014|Girijaya
32.02.13.2001|Parungkuda
32.02.13.2002|Palasari Hilir
32.02.13.2003|Kompa
32.02.13.2004|Pondokkaso Landeuh
32.02.13.2005|Sundawenang
32.02.13.2006|Bojongkokosan
32.02.13.2007|Langesari
32.02.13.2008|Babakanjaya
32.02.14.2001|Bojonggenteng
32.02.14.2002|Cibodas
32.02.14.2003|Berekah
32.02.14.2004|Cipanengah
32.02.14.2005|Bojonggaling
32.02.15.2001|Parakansalak
32.02.15.2002|Bojonglongok
32.02.15.2003|Sukakersa
32.02.15.2004|Sukatani
32.02.15.2005|Bojongasih
32.02.15.2006|Lebaksari
32.02.16.1001|Cicurug
32.02.16.2002|Nyangkowek
32.02.16.2003|Tenjolaya
32.02.16.2004|Benda
32.02.16.2005|Pasawahan
32.02.16.2006|Cisaat
32.02.16.2007|Purwasari
32.02.16.2008|Caringin
32.02.16.2009|Tenjoayu
32.02.16.2010|Kutajaya
32.02.16.2011|Mekarsari
32.02.16.2012|Bangbayang
32.02.16.2013|Nanggerang
32.02.17.2001|Pondokkaso Tonggoh
32.02.17.2002|Babakanpari
32.02.17.2003|Pondokkaso Tengah
32.02.17.2004|Cidahu
32.02.17.2005|Tangkil
32.02.17.2006|Jayabakti
32.02.17.2007|Girijaya
32.02.17.2008|Pasirdoton
32.02.18.2001|Kalapanunggal
32.02.18.2002|Palasari Girang
32.02.18.2003|Pulosari
32.02.18.2004|Makasari
32.02.18.2005|Kadununggal
32.02.18.2006|Walangsari
32.02.18.2007|Gunungendut
32.02.19.2001|Kabandungan
32.02.19.2002|Cipeuteuy
32.02.19.2003|Cihamerang
32.02.19.2004|Tugubandung
32.02.19.2005|Mekarjaya
32.02.19.2006|Cianaga
32.02.20.2001|Waluran
32.02.20.2002|Sukamukti
32.02.20.2003|Caringinnunggal
32.02.20.2004|Mekarmukti
32.02.20.2005|Mangunjaya
32.02.20.2006|Waluran Mandiri
32.02.21.1001|Jampangkulon
32.02.21.2002|Bojonggenteng
32.02.21.2003|Cikarang
32.02.21.2005|Bojongsari
32.02.21.2007|Nagraksari
32.02.21.2008|Mekarjaya
32.02.21.2009|Tanjung
32.02.21.2011|Ciparay
32.02.21.2013|Padajaya
32.02.21.2014|Karanganyar
32.02.21.2016|Cikaranggeusan
32.02.22.2001|Ciemas
32.02.22.2002|Cibenda
32.02.22.2003|Ciwaru
32.02.22.2004|Mekarjaya
32.02.22.2005|Girimukti
32.02.22.2006|Tamanjaya
32.02.22.2007|Mandrajaya
32.02.22.2008|Sidamulya
32.02.22.2009|Mekarsakti
32.02.23.2001|Kalibunder
32.02.23.2002|Bojong
32.02.23.2003|Cimahpar
32.02.23.2004|Sekarsari
32.02.23.2005|Sukaluyu
32.02.23.2006|Balekambang
32.02.23.2007|Mekarwangi
32.02.24.1013|Surade
32.02.24.2001|Jagamukti
32.02.24.2002|Citanglar
32.02.24.2003|Wanasari
32.02.24.2005|Sirnasari
32.02.24.2006|Kadaleman
32.02.24.2007|Gunungsungging
32.02.24.2008|Cipeundeuy
32.02.24.2009|Pasiripis
32.02.24.2010|Buniwangi
32.02.24.2011|Sukatani
32.02.24.2012|Kademangan
32.02.25.2001|Talagamurni
32.02.25.2002|Banyumurni
32.02.25.2003|Cibitung
32.02.25.2004|Cidahu
32.02.25.2005|Cibodas
32.02.25.2006|Banyuwangi
32.02.26.2001|Ciracap
32.02.26.2002|Cikangkung
32.02.26.2003|Gunungbatu
32.02.26.2004|Purwasedar
32.02.26.2005|Pasirpanjang
32.02.26.2006|Mekarsari
32.02.26.2007|Ujunggenteng
32.02.26.2008|Pangumbahan
32.02.27.2001|Cikujang
32.02.27.2002|Gunungguruh
32.02.27.2003|Cibentang
32.02.27.2004|Sirnaresmi
32.02.27.2005|Kebonmanggu
32.02.27.2006|Cibolang
32.02.27.2007|Mangkalaya
32.02.28.2001|Cicantayan
32.02.28.2002|Lembursawah
32.02.28.2003|Cijalingan
32.02.28.2004|Cisande
32.02.28.2005|Cimahi
32.02.28.2006|Hegarmanah
32.02.28.2007|Sukadamai
32.02.28.2008|Cimanggis
32.02.29.2001|Gunungjaya
32.02.29.2002|Sukasari
32.02.29.2003|Sukamanah
32.02.29.2004|Cisaat
32.02.29.2005|Nagrak
32.02.29.2006|Babakan
32.02.29.2007|Sukamantri
32.02.29.2008|Cibatu
32.02.29.2009|Selajambe
32.02.29.2010|Padaasih
32.02.29.2011|Cibolang Kaler
32.02.29.2012|Kutasirna
32.02.29.2013|Sukaresmi
32.02.30.2001|Kadudampit
32.02.30.2002|Citamiang
32.02.30.2003|Muaradua
32.02.30.2004|Gedepangrango
32.02.30.2005|Sukamanis
32.02.30.2006|Undrusbinangun
32.02.30.2007|Cipetir
32.02.30.2008|Sukamaju
32.02.30.2009|Cikahuripan
32.02.31.2001|Caringin Wetan
32.02.31.2002|Sukamulya
32.02.31.2003|Caringin Kulon
32.02.31.2004|Seuseupan
32.02.31.2005|Cijengkol
32.02.31.2006|Mekarjaya
32.02.31.2007|Talaga
32.02.31.2008|Cikembang
32.02.31.2009|Pasir Datar Indah
32.02.32.2001|Parungseah
32.02.32.2002|Sudajayagirang
32.02.32.2003|Karawang
32.02.32.2004|Warnasari
32.02.32.2005|Sukajaya
32.02.32.2006|Perbawati
32.02.33.2001|Pasirhalang
32.02.33.2002|Selaawi
32.02.33.2003|Langensari
32.02.33.2004|Sukaraja
32.02.33.2005|Limbangan
32.02.33.2006|Cisarua
32.02.33.2007|Sukamekar
32.02.33.2008|Selawangi
32.02.33.2009|Margaluyu
32.02.34.2001|Kebonpedes
32.02.34.2002|Cikaret
32.02.34.2003|Bojongsawah
32.02.34.2004|Sasagaran
32.02.34.2005|Jambenenggang
32.02.35.2001|Cireunghas
32.02.35.2002|Cipurut
32.02.35.2003|Bencoy
32.02.35.2004|Cikurutug
32.02.35.2005|Tegalpanjang
32.02.36.2001|Sukalarang
32.02.36.2002|Sukamaju
32.02.36.2003|Cimangkok
32.02.36.2004|Titisan
32.02.36.2005|Semplak
32.02.36.2006|Prianganjaya
32.02.37.2001|Pabuaran
32.02.37.2002|Ciwalat
32.02.37.2003|Sirnasari
32.02.37.2004|Bantarsari
32.02.37.2005|Sukajaya
32.02.37.2006|Cibadak
32.02.37.2007|Lembur Sawah
32.02.38.2001|Purabaya
32.02.38.2002|Neglasari
32.02.38.2003|Pagelaran
32.02.38.2004|Cimerang
32.02.38.2005|Citamiang
32.02.38.2006|Margaluyu
32.02.38.2007|Cicukang
32.02.39.2001|Nyalindung
32.02.39.2002|Neglasari
32.02.39.2003|Sukamaju
32.02.39.2004|Bojongkalong
32.02.39.2005|Cijangkar
32.02.39.2006|Mekarsari
32.02.39.2007|Wangunreja
32.02.39.2008|Cisitu
32.02.39.2009|Bojongsari
32.02.39.2010|Kertaangsana
32.02.40.2001|Gegerbitung
32.02.40.2002|Cijurey
32.02.40.2003|Ciengang
32.02.40.2004|Karangjaya
32.02.40.2005|Caringin
32.02.40.2006|Sukamanah
32.02.40.2007|Buniwangi
32.02.41.2001|Sagaranten
32.02.41.2002|Curugluhur
32.02.41.2003|Cibaregbeg
32.02.41.2004|Pasanggrahan
32.02.41.2005|Datarnangka
32.02.41.2006|Puncakmanggis
32.02.41.2007|Hegarmanah
32.02.41.2008|Gunungbentang
32.02.41.2009|Sinarbentang
32.02.41.2010|Cibitung
32.02.41.2011|Margaluyu
32.02.41.2012|Mekarsari
32.02.42.2001|Curugkembar
32.02.42.2002|Cimenteng
32.02.42.2003|Tanjungsari
32.02.42.2004|Sindangraja
32.02.42.2005|Mekartanjung
32.02.42.2006|Nagrakjaya
32.02.42.2007|Bojongtugu
32.02.43.2001|Cidolog
32.02.43.2002|Cipamingkis
32.02.43.2003|Cikarang
32.02.43.2004|Tegallega
32.02.43.2005|Mekarjaya
32.02.44.2001|Padasenang
32.02.44.2002|Cidadap
32.02.44.2003|Banjarsari
32.02.44.2004|Hegarmulya
32.02.44.2005|Tenjolaut
32.02.44.2006|Mekartani
32.02.45.2001|Tegalbuleud
32.02.45.2002|Bangbayang
32.02.45.2003|Sumberjaya
32.02.45.2004|Calingcing
32.02.45.2005|Nangela
32.02.45.2006|Rambay
32.02.45.2007|Buniasih
32.02.45.2008|Sirnamekar
32.02.46.2001|Cimanggu
32.02.46.2002|Sukamaju
32.02.46.2003|Sukajadi
32.02.46.2004|Karangmekar
32.02.46.2005|Boregahindah
32.02.46.2006|Sukamanah
32.02.47.2001|Ciambar
32.02.47.2002|Ginanjar
32.02.47.2003|Wangunjaya
32.02.47.2004|Munjul
32.02.47.2005|Ambarjaya
32.02.47.2006|Cibunarjaya
32.03.01.1006|Pamoyanan
32.03.01.1007|Sawahgede
32.03.01.1008|Bojongherang
32.03.01.1009|Sayang
32.03.01.1010|Solokpandan
32.03.01.1011|Muka
32.03.01.2001|Babakankaret
32.03.01.2002|Nagrak
32.03.01.2003|Sukamaju
32.03.01.2004|Mekarsari
32.03.01.2005|Limbangansari
32.03.02.2002|Jambudipa
32.03.02.2006|Cisarandi
32.03.02.2007|Cikaroya
32.03.02.2008|Bunikasih
32.03.02.2009|Ciwalen
32.03.02.2010|Tegallega
32.03.02.2011|Sukawangi
32.03.02.2014|Bunisari
32.03.02.2016|Sukamulya
32.03.02.2017|Cieundeur
32.03.02.2018|Mekarwangi
32.03.03.2001|Cipetir
32.03.03.2002|Cihaur
32.03.03.2003|Cimanggu
32.03.03.2004|Cibaregbeg
32.03.03.2005|Sukaraharja
32.03.03.2006|Peuteuycondong
32.03.03.2007|Mayak
32.03.03.2008|Cikondang
32.03.03.2009|Cibokor
32.03.03.2010|Selagedang
32.03.03.2011|Karangnunggal
32.03.03.2012|Kanoman
32.03.03.2013|Sukamaju
32.03.03.2014|Girimulya
32.03.03.2015|Cisalak
32.03.03.2016|Cibadak
32.03.03.2017|Sukamanah
32.03.03.2018|Salamnunggal
32.03.04.2001|Rancagoong
32.03.04.2002|Sukasari
32.03.04.2003|Sirnagalih
32.03.04.2004|Sukakerta
32.03.04.2005|Cibinonghilir
32.03.04.2006|Rahong
32.03.04.2007|Munjul
32.03.04.2008|Sindangsari
32.03.04.2009|Ciharashas
32.03.04.2010|Mulyasari
32.03.05.2001|Ciranjang
32.03.05.2002|Sindangjaya
32.03.05.2004|Cibiuk
32.03.05.2005|Gunungsari
32.03.05.2006|Karangwangi
32.03.05.2007|Nanggalamekar
32.03.05.2008|Kertajaya
32.03.05.2009|Sindangsari
32.03.05.2012|Mekargalih
32.03.06.2001|Hegarmanah
32.03.06.2002|Bojongpicung
32.03.06.2004|Cibarengkok
32.03.06.2006|Kemang
32.03.06.2007|Sukajaya
32.03.06.2008|Jati
32.03.06.2009|Cikondang
32.03.06.2010|Sukarama
32.03.06.2012|Sukaratu
32.03.06.2013|Neglasari
32.03.06.2014|Jatisari
32.03.07.2001|Sukamanah
32.03.07.2002|Bojong
32.03.07.2003|Sindanglaka
32.03.07.2004|Maleber
32.03.07.2005|Ciherang
32.03.07.2006|Sukamantri
32.03.07.2007|Sukasarana
32.03.07.2008|Sukasari
32.03.07.2009|Babakancaringin
32.03.07.2010|Sabandar
32.03.07.2011|Sindangasih
32.03.07.2012|Sukataris
32.03.07.2013|Langensari
32.03.07.2014|Hegarmanah
32.03.07.2015|Sukajadi
32.03.07.2016|Sukamulya
32.03.08.2001|Kademangan
32.03.08.2002|Bobojong
32.03.08.2003|Jamali
32.03.08.2004|Cikidangbayabang
32.03.08.2005|Mande
32.03.08.2006|Mulyasari
32.03.08.2007|Ciandam
32.03.08.2008|Sukamanah
32.03.08.2009|Leuwikoja
32.03.08.2010|Mekarjaya
32.03.08.2011|Kutawaringin
32.03.08.2012|Murnisari
32.03.09.2001|Selajambe
32.03.09.2002|Sukamulya
32.03.09.2003|Panyusuhan
32.03.09.2004|Tanjungsari
32.03.09.2005|Sindangraja
32.03.09.2006|Mekarjaya
32.03.09.2007|Sukasirna
32.03.09.2008|Sukaluyu
32.03.09.2009|Babakansari
32.03.09.2010|Hegarmanah
32.03.10.2001|Ciherang
32.03.10.2003|Cibodas
32.03.10.2005|Sukanagalih
32.03.10.2007|Cipendawa
32.03.10.2010|Ciputri
32.03.10.2012|Gadog
32.03.10.2013|Sukatani
32.03.11.2001|Sukamanah
32.03.11.2002|Gasol
32.03.11.2003|Cijedil
32.03.11.2004|Cibeureum
32.03.11.2005|Nyalindung
32.03.11.2006|Mangunkerta
32.03.11.2007|Sarampad
32.03.11.2008|Talaga
32.03.11.2009|Sukajaya
32.03.11.2010|Cibulakan
32.03.11.2011|Benjot
32.03.11.2012|Sukamulya
32.03.11.2013|Wangunjaya
32.03.11.2014|Cirumput
32.03.11.2015|Padaluyu
32.03.11.2016|Galudra
32.03.12.2001|Sukagalih
32.03.12.2002|Gudang
32.03.12.2003|Cinangsi
32.03.12.2004|Cijagang
32.03.12.2005|Majalaya
32.03.12.2006|Kamurang
32.03.12.2007|Warudoyong
32.03.12.2008|Ciramagirang
32.03.12.2009|Mekarjaya
32.03.12.2010|Sukamulya
32.03.12.2011|Padajaya
32.03.12.2012|Cigunungherang
32.03.12.2013|Neglasari
32.03.12.2014|Mekargalih
32.03.12.2015|Lembahsari
32.03.12.2016|Mentengsari
32.03.12.2017|Mekarsari
32.03.12.2018|Mekarmulya
32.03.13.2001|Cikanyere
32.03.13.2002|Cikancana
32.03.13.2003|Ciwalen
32.03.13.2004|Kawungluwuk
32.03.13.2005|Cibadak
32.03.13.2006|Sukamahi
32.03.13.2007|Sukaresmi
32.03.13.2008|Cibanteng
32.03.13.2009|Kubang
32.03.13.2010|Pakuon
32.03.13.2011|Rawabelut
32.03.14.2001|Sukanagara
32.03.14.2002|Sukajembar
32.03.14.2003|Sukakarya
32.03.14.2004|Ciguha
32.03.14.2005|Sukamekar
32.03.14.2006|Gunungsari
32.03.14.2007|Sukalaksana
32.03.14.2008|Sukarame
32.03.14.2009|Sindangsari
32.03.14.2010|Jayagiri
32.03.15.2001|Cidadap
32.03.15.2002|Cimenteng
32.03.15.2003|Susukan
32.03.15.2004|Sukajadi
32.03.15.2005|Sukadana
32.03.15.2006|Margaluyu
32.03.15.2007|Karyamukti
32.03.15.2008|Campaka
32.03.15.2009|Wangunjaya
32.03.15.2010|Girimukti
32.03.15.2011|Mekarjaya
32.03.16.2001|Pasawahan
32.03.16.2002|Sindangresmi
32.03.16.2003|Sindanghayu
32.03.16.2004|Simpang
32.03.16.2005|Sukagalih
32.03.16.2006|Bungbangsari
32.03.16.2007|Cisujen
32.03.16.2008|Hegarmanah
32.03.16.2009|Waringinsari
32.03.17.2003|Sukasari
32.03.17.2006|Pasirdalem
32.03.17.2008|Talagasari
32.03.17.2009|Bojongkasih
32.03.17.2010|Wargaasih
32.03.17.2011|Sukaraharja
32.03.17.2014|Sukakerta
32.03.17.2016|Neglasari
32.03.17.2017|Sukaresmi
32.03.17.2019|Wargasari
32.03.17.2020|Sukaraja
32.03.17.2021|Kadupandak
32.03.17.2022|Gandasari
32.03.17.2023|Sindangsari
32.03.18.2001|Pagelaran
32.03.18.2002|Pangadegan
32.03.18.2004|Gelaranyar
32.03.18.2005|Buniwangi
32.03.18.2007|Sindangkerta
32.03.18.2008|Pasirbaru
32.03.18.2009|Bunijaya
32.03.18.2010|Situhiang
32.03.18.2011|Mekarsari
32.03.18.2012|Kertaraharja
32.03.18.2013|Selagedang
32.03.18.2014|Padamaju
32.03.18.2015|Karangharja
32.03.18.2018|Sukamaju
32.03.19.2001|Tanggeung
32.03.19.2002|Rawagede
32.03.19.2003|Cilongsong
32.03.19.2004|Margaluyu
32.03.19.2005|Karangtengah
32.03.19.2006|Pagermaneuh
32.03.19.2007|Bojongpetir
32.03.19.2009|Pasirjambu
32.03.19.2010|Sirnajaya
32.03.19.2013|Kertajaya
32.03.19.2014|Sukajaya
32.03.19.2015|Padaluyu
32.03.20.2001|Pananggapan
32.03.20.2002|Cikangkareng
32.03.20.2003|Sukajadi
32.03.20.2004|Panyindangan
32.03.20.2005|Padasuka
32.03.20.2006|Cimaskara
32.03.20.2007|Pamoyanan
32.03.20.2008|Batulawang
32.03.20.2009|Sukamekar
32.03.20.2010|Hamerang
32.03.20.2011|Girijaya
32.03.20.2012|Wargaluyu
32.03.20.2013|Mekarmukti
32.03.20.2014|Ciburial
32.03.21.2001|Saganten
32.03.21.2002|Muaracikadu
32.03.21.2003|Jatisari
32.03.21.2004|Sirnagalih
32.03.21.2005|Jayagiri
32.03.21.2006|Kertasari
32.03.21.2007|Girimukti
32.03.21.2008|Talagasari
32.03.21.2009|Hegarsari
32.03.21.2010|Mekarlaksana
32.03.21.2011|Kertamukti
32.03.22.2004|Sukamanah
32.03.22.2005|Bojongkaso
32.03.22.2006|Bunisari
32.03.22.2007|Wanasari
32.03.22.2010|Sinarlaut
32.03.22.2014|Neglasari
32.03.22.2016|Karangsari
32.03.22.2017|Mulyasari
32.03.22.2018|Tanjung Sari
32.03.22.2019|Mekarsari
32.03.22.2022|Wangunjaya
32.03.23.2001|Cidamar
32.03.23.2002|Cibuluh
32.03.23.2003|Cisalak
32.03.23.2004|Cimaragang
32.03.23.2005|Mekarjaya
32.03.23.2006|Kertajadi
32.03.23.2007|Sukapura
32.03.23.2008|Gelarpawitan
32.03.23.2009|Karangwangi
32.03.23.2010|Karyabakti
32.03.23.2011|Jayapura
32.03.23.2012|Neglasari
32.03.23.2013|Puncakbaru
32.03.23.2014|Gelarwangi
32.03.24.2001|Naringgul
32.03.24.2002|Balegede
32.03.24.2003|Wangunjaya
32.03.24.2004|Mekarsari
32.03.24.2005|Cinerang
32.03.24.2006|Wanasari
32.03.24.2007|Sukabakti
32.03.24.2008|Malati
32.03.24.2009|Wangunsari
32.03.24.2010|Sukamulya
32.03.24.2011|Margasari
32.03.25.2001|Cibanggala
32.03.25.2002|Campakawarna
32.03.25.2003|Sukasirna
32.03.25.2004|Campakamulya
32.03.25.2005|Sukabungah
32.03.26.2001|Kalapanunggal
32.03.26.2002|Cikadu
32.03.26.2003|Mekarwangi
32.03.26.2004|Padaluyu
32.03.26.2005|Sukamulya
32.03.26.2006|Cisaranten
32.03.26.2007|Mekarlaksana
32.03.26.2008|Sukaluyu
32.03.26.2009|Mekarjaya
32.03.26.2010|Sukamanah
32.03.27.2001|Bangbayang
32.03.27.2002|Songgom
32.03.27.2003|Sukaratu
32.03.27.2004|Cikancana
32.03.27.2005|Kebonpeuteuy
32.03.27.2006|Gekbrong
32.03.27.2007|Cikahuripan
32.03.27.2008|Cintaasih
32.03.28.2001|Cipanas
32.03.28.2002|Cimacan
32.03.28.2003|Ciloto
32.03.28.2004|Sindanglaya
32.03.28.2005|Batulawang
32.03.28.2006|Palasari
32.03.28.2007|Sindangjaya
32.03.29.2001|Parakantugu
32.03.29.2002|Cijati
32.03.29.2003|Bojonglarang
32.03.29.2004|Padaasih
32.03.29.2005|Cibodas
32.03.29.2006|Sukamahi
32.03.29.2007|Sukaluyu
32.03.29.2008|Caringin
32.03.29.2009|Sinarbakti
32.03.29.2010|Sukamaju
32.03.30.2001|Pusakasari
32.03.30.2002|Walahir
32.03.30.2003|Purabaya
32.03.30.2004|Puncakwangi
32.03.30.2005|Sukajaya
32.03.30.2006|Nagasari
32.03.30.2007|Sukasirna
32.03.30.2008|Sukamulya
32.03.30.2009|Sirnasari
32.03.30.2010|Karyamukti
32.03.30.2011|Mandalawangi
32.03.30.2012|Sindangsari
32.03.31.2001|Haurwangi
32.03.31.2002|Cihea
32.03.31.2003|Ramasari
32.03.31.2004|Mekarwangi/Sukatani
32.03.31.2005|Mekarwangi
32.03.31.2006|Kertasari
32.03.31.2007|Cipeuyeum
32.03.31.2008|Kertamukti
32.03.32.2001|Simpang
32.03.32.2002|Kalibaru
32.03.32.2003|Pusakajaya
32.03.32.2004|Kubang
32.03.32.2005|Girimukti
32.03.32.2006|Karangjaya
32.03.32.2007|Mekarmulya
32.03.32.2008|Girijaya
32.03.32.2009|Padamulya
32.04.05.2001|Cileunyi Kulon
32.04.05.2002|Cileunyi Wetan
32.04.05.2003|Cimekar
32.04.05.2004|Cinunuk
32.04.05.2005|Cibiru Hilir
32.04.05.2006|Cibiru Wetan
32.04.06.1001|Padasuka
32.04.06.1002|Cibeunying
32.04.06.2003|Cimenyan
32.04.06.2004|Mandalamekar
32.04.06.2005|Cikadut
32.04.06.2006|Ciburial
32.04.06.2007|Sindanglaya
32.04.06.2008|Mekarsaluyu
32.04.06.2009|Mekarmanik
32.04.07.2001|Jatiendah
32.04.07.2002|Cilengkrang
32.04.07.2003|Cipanjalu
32.04.07.2004|Melatiwangi
32.04.07.2005|Ciporeat
32.04.07.2006|Girimekar
32.04.08.2001|Lengkong
32.04.08.2002|Bojongsoang
32.04.08.2003|Buahbatu
32.04.08.2004|Cipagalo
32.04.08.2005|Bojongsari
32.04.08.2006|Tegalluar
32.04.09.1004|Sulaiman
32.04.09.2001|Margahayu Tengah
32.04.09.2002|Margahayu Selatan
32.04.09.2003|Sukamenak
32.04.09.2005|Sayati
32.04.10.2001|Margaasih
32.04.10.2002|Lagadar
32.04.10.2003|Nanjung
32.04.10.2004|Mekarrahayu
32.04.10.2005|Rahayu
32.04.10.2006|Cigondewah Hilir
32.04.11.2001|Sangkanhurip
32.04.11.2002|Katapang
32.04.11.2004|Gandasari
32.04.11.2006|Sukamukti
32.04.11.2007|Cilampeni
32.04.11.2008|Pangauban
32.04.11.2009|Banyusari
32.04.12.1001|Pasawahan
32.04.12.2002|Dayeuhkolot
32.04.12.2003|Cangkuang Wetan
32.04.12.2004|Cangkuang Kulon
32.04.12.2005|Sukapura
32.04.12.2006|Citeureup
32.04.13.2001|Kamasan
32.04.13.2002|Banjaran Wetan
32.04.13.2003|Banjaran
32.04.13.2005|Ciapus
32.04.13.2006|Sindangpanon
32.04.13.2007|Kiangroke
32.04.13.2008|Tarajusari
32.04.13.2012|Mekarjaya
32.04.13.2013|Margahurip
32.04.13.2016|Neglasari
32.04.13.2018|Pasirmulya
32.04.14.2001|Sukasari
32.04.14.2002|Bojongmanggu
32.04.14.2003|Rancatungku
32.04.14.2004|Bojongkunci
32.04.14.2005|Rancamulya
32.04.14.2006|Langonsari
32.04.15.2001|Pangalengan
32.04.15.2002|Margaluyu
32.04.15.2003|Warnasari
32.04.15.2004|Sukamanah
32.04.15.2005|Lamajang
32.04.15.2006|Margamukti
32.04.15.2007|Margamulya
32.04.15.2008|Banjarsari
32.04.15.2009|Sukaluyu
32.04.15.2010|Tribaktimulya
32.04.15.2011|Pulosari
32.04.15.2012|Wanasuka
32.04.15.2013|Margamekar
32.04.16.2001|Arjasari
32.04.16.2002|Lebakwangi
32.04.16.2003|Batukarut
32.04.16.2004|Ancolmekar
32.04.16.2005|Baros
32.04.16.2006|Mangunjaya
32.04.16.2007|Mekarjaya
32.04.16.2008|Pinggirsari
32.04.16.2009|Patrolsari
32.04.16.2010|Rancakole
32.04.16.2011|Wargaluyu
32.04.17.2001|Cimaung
32.04.17.2002|Jagabaya
32.04.17.2003|Pasirhuni
32.04.17.2004|Campakamulya
32.04.17.2005|Cipinang
32.04.17.2006|Mekarsari
32.04.17.2007|Sukamaju
32.04.17.2008|Cikalong
32.04.17.2009|Malasari
32.04.17.2010|Warjabakti
32.04.25.2001|Cicalengka Kulon
32.04.25.2002|Cicalengka Wetan
32.04.25.2003|Babakan Peuteuy
32.04.25.2004|Cikuya
32.04.25.2005|Dampit
32.04.25.2006|Margaasih
32.04.25.2007|Narawita
32.04.25.2008|Panenjoan
32.04.25.2009|Tanjungwangi
32.04.25.2010|Tenjolaya
32.04.25.2011|Waluya
32.04.25.2012|Nagrog
32.04.26.2001|Nagreg
32.04.26.2002|Bojong
32.04.26.2003|Ciaro
32.04.26.2004|Ciherang
32.04.26.2005|Citaman
32.04.26.2006|Mandalawangi
32.04.26.2007|Nagreg Kendan
32.04.26.2008|Ganjar Sabar
32.04.27.2001|Mandalasari
32.04.27.2002|Cikancung
32.04.27.2003|Cikasungka
32.04.27.2004|Cihanyir
32.04.27.2005|Ciluluk
32.04.27.2006|Hegarmanah
32.04.27.2007|Mekarlaksana
32.04.27.2008|Tanjunglaya
32.04.27.2009|Srirahayu
32.04.28.1014|Rancaekek Kencana
32.04.28.2001|Rancaekek Wetan
32.04.28.2002|Rancaekek Kulon
32.04.28.2003|Bojongsalam
32.04.28.2004|Bojongloa
32.04.28.2005|Jelegong
32.04.28.2006|Linggar
32.04.28.2007|Cangkuang
32.04.28.2008|Haurpugur
32.04.28.2009|Sukamanah
32.04.28.2010|Sukamulya
32.04.28.2011|Tegal Sumedang
32.04.28.2012|Sangiang
32.04.28.2013|Nanjung Mekar
32.04.29.2001|Ciparay
32.04.29.2002|Gunungleutik
32.04.29.2003|Mekarsari
32.04.29.2004|Cikoneng
32.04.29.2005|Ciheulang
32.04.29.2006|Pakutandang
32.04.29.2007|Sumbersari
32.04.29.2008|Manggungharja
32.04.29.2009|Sagaracipta
32.04.29.2010|Sarimahi
32.04.29.2011|Serangmekar
32.04.29.2012|Babakan
32.04.29.2013|Bumiwangi
32.04.29.2014|Mekarlaksana
32.04.30.2001|Cipeujeuh
32.04.30.2002|Cikitu
32.04.30.2003|Cinanggela
32.04.30.2004|Maruyung
32.04.30.2005|Sukarame
32.04.30.2006|Nagrak
32.04.30.2007|Cikawao
32.04.30.2008|Mekarjaya
32.04.30.2009|Pangauban
32.04.30.2010|Mandalahaji
32.04.30.2011|Girimulya
32.04.30.2012|Tanjungwangi
32.04.30.2013|Mekarsari
32.04.31.2001|Sukapura
32.04.31.2002|Cibeureum
32.04.31.2003|Santosa
32.04.31.2004|Tarumajaya
32.04.31.2005|Neglawangi
32.04.31.2006|Cihawuk
32.04.31.2007|Cikembang
32.04.31.2008|Resmi Tingal
32.04.32.1001|Baleendah
32.04.32.1002|Andir
32.04.32.1003|Manggahang
32.04.32.1004|Jelekong
32.04.32.1008|Wargamekar
32.04.32.2005|Bojongmalaka
32.04.32.2006|Rancamanyar
32.04.32.2007|Malakasari
32.04.33.2001|Majalaya
32.04.33.2002|Wangisagara
32.04.33.2003|Biru
32.04.33.2004|Padamulya
32.04.33.2005|Bojong
32.04.33.2006|Majasetra
32.04.33.2007|Majakerta
32.04.33.2008|Sukamaju
32.04.33.2009|Padaulun
32.04.33.2010|Neglasari
32.04.33.2011|Sukamukti
32.04.34.2001|Rancakasumba
32.04.34.2002|Solokanjeruk
32.04.34.2003|Cibodas
32.04.34.2004|Panyadap
32.04.34.2005|Bojongemas
32.04.34.2006|Padamukti
32.04.34.2007|Langensari
32.04.35.2001|Cigentur
32.04.35.2002|Cipedes
32.04.35.2003|Loa
32.04.35.2004|Cijagra
32.04.35.2005|Cipaku
32.04.35.2006|Sindangsari
32.04.35.2007|Drawati
32.04.35.2008|Sukamanah
32.04.35.2009|Sukamantri
32.04.35.2010|Karangtunggal
32.04.35.2011|Mekarpawitan
32.04.35.2012|Tangsimekar
32.04.36.2001|Ibun
32.04.36.2002|Laksana
32.04.36.2003|Dukuh
32.04.36.2004|Talun
32.04.36.2005|Pangguh
32.04.36.2006|Lampegan
32.04.36.2007|Neglasari
32.04.36.2008|Mekarwangi
32.04.36.2009|Sudi
32.04.36.2010|Tanggulun
32.04.36.2011|Cibeet
32.04.36.2012|Karyalaksana
32.04.37.2001|Soreang
32.04.37.2002|Sadu
32.04.37.2004|Panyirapan
32.04.37.2010|Sukajadi
32.04.37.2011|Pamekaran
32.04.37.2017|Karamatmulya
32.04.37.2018|Sukanagara
32.04.37.2019|Cingcin
32.04.37.2020|Parungserab
32.04.37.2021|Sekarwangi
32.04.38.2001|Pasirjambu
32.04.38.2002|Cibodas
32.04.38.2003|Cikoneng
32.04.38.2004|Cukanggenteng
32.04.38.2005|Cisondari
32.04.38.2006|Margamulya
32.04.38.2007|Mekarsari
32.04.38.2008|Mekarmaju
32.04.38.2009|Sugihmukti
32.04.38.2010|Tenjolaya
32.04.39.2001|Lebakmuncang
32.04.39.2002|Ciwidey
32.04.39.2003|Nengkelan
32.04.39.2004|Panundaan
32.04.39.2005|Panyocokan
32.04.39.2006|Rawabogo
32.04.39.2007|Sukawening
32.04.40.2001|Patengan
32.04.40.2002|Sukaresmi
32.04.40.2003|Indragiri
32.04.40.2004|Cipelah
32.04.40.2005|Alamendah
32.04.44.2001|Cangkuang
32.04.44.2002|Ciluncat
32.04.44.2003|Nagrak
32.04.44.2004|Bandasari
32.04.44.2005|Pananjung
32.04.44.2006|Jatisari
32.04.44.2007|Tanjungsari
32.04.46.2001|Jelegong
32.04.46.2002|Jatisari
32.04.46.2003|Pameuntasan
32.04.46.2004|Kopo
32.04.46.2005|Cibodas
32.04.46.2006|Kutawaringin
32.04.46.2007|Sukamulya
32.04.46.2008|Padasuka
32.04.46.2009|Buninagara
32.04.46.2010|Gajah Mekar
32.04.46.2011|Cilame
32.05.01.1001|Kota Kulon
32.05.01.1002|Kota Wetan
32.05.01.1003|Margawati
32.05.01.1004|Pakuwon
32.05.01.1005|Muara Sanding
32.05.01.1006|Sukamentri
32.05.01.1007|Ciwalen
32.05.01.1008|Paminggir
32.05.01.1009|Regol
32.05.01.1010|Sukanegla
32.05.01.1011|Cimuncang
32.05.02.1001|Suci Kaler
32.05.02.1002|Lebakjaya
32.05.02.1003|Karangmulya
32.05.02.1014|Lengkongjaya
32.05.02.2004|Karangpawitan
32.05.02.2005|Situgede
32.05.02.2006|Cimurah
32.05.02.2007|Suci
32.05.02.2008|Jatisari
32.05.02.2009|Godog
32.05.02.2010|Situsari
32.05.02.2011|Karangsari
32.05.02.2012|Sindangpalay
32.05.02.2013|Lebakagung
32.05.02.2015|Sindanggalih
32.05.02.2016|Mekarsari
32.05.02.2017|Sindanglaya
32.05.02.2018|Tanjungsari
32.05.02.2019|Situsaeur
32.05.02.2020|Situjaya
32.05.03.2001|Wanaraja
32.05.03.2002|Wanamekar
32.05.03.2003|Cinunuk
32.05.03.2007|Sukamenak
32.05.03.2008|Sindangratu
32.05.03.2011|Wanajaya
32.05.03.2015|Sindangmekar
32.05.03.2019|Wanasari
32.05.03.2024|Sindangprabu
32.05.04.1012|Pananjung
32.05.04.2001|Sukajadi
32.05.04.2002|Cimanganten
32.05.04.2003|Jati
32.05.04.2004|Rancabango
32.05.04.2005|Sukawangi
32.05.04.2006|Sirnajaya
32.05.04.2007|Tanjung Kamuning
32.05.04.2008|Mekarjaya
32.05.04.2009|Langensari
32.05.04.2010|Mekarwangi
32.05.04.2011|Pasawahan
32.05.04.2013|Panjiwangi
32.05.05.1001|Pataruman
32.05.05.1002|Sukagalih
32.05.05.1006|Jayawaras
32.05.05.1009|Sukakarya
32.05.05.1012|Sukajaya
32.05.05.2003|Jayaraga
32.05.05.2004|Haurpanggung
32.05.05.2005|Cibunar
32.05.05.2007|Sukabakti
32.05.05.2008|Tarogong
32.05.05.2010|Mekargalih
32.05.05.2011|Kersamenak
32.05.06.2001|Banyuresmi
32.05.06.2002|Cimareme
32.05.06.2003|Sukaratu
32.05.06.2004|Sukasenang
32.05.06.2005|Sukaraja
32.05.06.2006|Cipicung
32.05.06.2007|Dangdeur
32.05.06.2008|Sukakarya
32.05.06.2009|Pamekarsari
32.05.06.2010|Binakarya
32.05.06.2011|Bagendit
32.05.06.2012|Karyamukti
32.05.06.2013|Karyasari
32.05.06.2014|Sukamukti
32.05.06.2015|Sukalaksana
32.05.07.2001|Samarang
32.05.07.2002|Cintarakyat
32.05.07.2003|Sukarasa
32.05.07.2004|Parakan
32.05.07.2005|Sukakarya
32.05.07.2006|Cintakarya
32.05.07.2007|Tanjung Karya
32.05.07.2008|Cisarua
32.05.07.2009|Cintarasa
32.05.07.2010|Cintaasih
32.05.07.2011|Sirnasari
32.05.07.2012|Sukalaksana
32.05.07.2013|Tanjunganom
32.05.08.2001|Pasirwangi
32.05.08.2002|Pasirkiamis
32.05.08.2003|Padasuka
32.05.08.2004|Karyamekar
32.05.08.2005|Padawaas
32.05.08.2006|Padaasih
32.05.08.2007|Barusari
32.05.08.2008|Talaga
32.05.08.2009|Padamukti
32.05.08.2010|Sinarjaya
32.05.08.2011|Sarimukti
32.05.08.2012|Padamulya
32.05.09.2001|Leles
32.05.09.2002|Ciburial
32.05.09.2003|Jangkurang
32.05.09.2004|Sukarame
32.05.09.2005|Lembang
32.05.09.2006|Cangkuang
32.05.09.2007|Salamnunggal
32.05.09.2008|Kandangmukti
32.05.09.2009|Margaluyu
32.05.09.2010|Cipancar
32.05.09.2011|Haruman
32.05.09.2012|Dano
32.05.10.2001|Kadungora
32.05.10.2002|Gandamekar
32.05.10.2003|Cikembulan
32.05.10.2004|Cisaat
32.05.10.2005|Mandalasari
32.05.10.2006|Tanggulun
32.05.10.2007|Mekarbakti
32.05.10.2008|Karangmulya
32.05.10.2009|Harumansari
32.05.10.2010|Talagasari
32.05.10.2011|Hegarsari
32.05.10.2012|Neglasari
32.05.10.2013|Karangtengah
32.05.10.2014|Rancasalak
32.05.11.2001|Leuwigoong
32.05.11.2002|Karanganyar
32.05.11.2003|Margacinta
32.05.11.2004|Margahayu
32.05.11.2005|Dungusiku
32.05.11.2006|Tambak Sari
32.05.11.2007|Sindangsari
32.05.11.2008|Karangsari
32.05.12.2001|Cibatu
32.05.12.2002|Mekarsari
32.05.12.2003|Cibunar
32.05.12.2004|Sindangsuka
32.05.12.2005|Kertajaya
32.05.12.2006|Sukalilah
32.05.12.2007|Padasuka
32.05.12.2008|Karyamukti
32.05.12.2009|Girimukti
32.05.12.2010|Keresek
32.05.12.2011|Wanakerta
32.05.13.2001|Kersamanah
32.05.13.2002|Nanjungjaya
32.05.13.2003|Sukamerang
32.05.13.2004|Girijaya
32.05.13.2005|Sukamaju
32.05.13.2006|Mekarraya
32.05.14.2001|Malangbong
32.05.14.2002|Karangmulya
32.05.14.2003|Cibunar
32.05.14.2004|Cikarag
32.05.14.2005|Sakawayana
32.05.14.2006|Mekarasih
32.05.14.2007|Cisitu
32.05.14.2008|Campaka
32.05.14.2009|Lewobaru
32.05.14.2010|Sukamanah
32.05.14.2011|Cilampuyang
32.05.14.2012|Cinagara
32.05.14.2013|Sukaratu
32.05.14.2014|Citeras
32.05.14.2015|Sukarasa
32.05.14.2016|Sekarwangi
32.05.14.2017|Kutanagara
32.05.14.2018|Sanding
32.05.14.2019|Cihaurkuning
32.05.14.2020|Baru Dua
32.05.14.2021|Sukajaya
32.05.14.2022|Bunisari
32.05.14.2023|Mekarmulya
32.05.14.2024|Girimakmur
32.05.15.2001|Sukawening
32.05.15.2002|Sukamukti
32.05.15.2003|Mekarluyu
32.05.15.2004|Sukaluyu
32.05.15.2005|Sudalarang
32.05.15.2006|Sukasono
32.05.15.2007|Sukahaji
32.05.15.2008|Pasanggrahan
32.05.15.2009|Maripari
32.05.15.2010|Mekarwangi
32.05.15.2011|Mekar Hurip
32.05.16.2001|Caringin
32.05.16.2002|Cintamanik
32.05.16.2003|Cinta
32.05.16.2004|Sindanggalih
32.05.17.2001|Bayongbong
32.05.17.2002|Panembong
32.05.17.2003|Hegarmanah
32.05.17.2004|Salakuray
32.05.17.2005|Karyajaya
32.05.17.2006|Mulyasari
32.05.17.2007|Pamalayan
32.05.17.2008|Mekarsari
32.05.17.2009|Ciburuy
32.05.17.2010|Ciela
32.05.17.2011|Cikedokan
32.05.17.2012|Banjarsari
32.05.17.2013|Sukasenang
32.05.17.2014|Mekarjaya
32.05.17.2015|Sirnagalih
32.05.17.2016|Sukarame
32.05.17.2017|Cinisti
32.05.17.2018|Sukamanah
32.05.18.2001|Cigedug
32.05.18.2002|Barusuda
32.05.18.2003|Sukahurip
32.05.18.2004|Sindangsari
32.05.18.2005|Cintanagara
32.05.19.2001|Cilawu
32.05.19.2002|Sukamukti
32.05.19.2003|Karyamekar
32.05.19.2004|Dawungsari
32.05.19.2005|Pasanggrahan
32.05.19.2006|Sukahati
32.05.19.2007|Mekarsari
32.05.19.2008|Mekarmukti
32.05.19.2009|Desakolot
32.05.19.2010|Ngamplangsari
32.05.19.2011|Margalaksana
32.05.19.2012|Dangiang
32.05.19.2013|Dayeuhmanggung
32.05.19.2014|Sukamaju
32.05.19.2015|Mangkurakyat
32.05.19.2016|Ngamplang
32.05.19.2017|Sukatani
32.05.19.2018|Sukamurni
32.05.20.2001|Cisurupan
32.05.20.2002|Cidatar
32.05.20.2003|Sukawangi
32.05.20.2004|Sukatani
32.05.20.2005|Situsari
32.05.20.2006|Pakuwon
32.05.20.2007|Balewangi
32.05.20.2008|Sirnajaya
32.05.20.2009|Cisero
32.05.20.2010|Karamatwangi
32.05.20.2011|Cipaganti
32.05.20.2012|Pamulihan
32.05.20.2013|Tambakbaya
32.05.20.2014|Sirnagalih
32.05.20.2015|Pangauban
32.05.20.2016|Simpangsari
32.05.20.2017|Cintaasih
32.05.21.2001|Sukaresmi
32.05.21.2002|Cintadamai
32.05.21.2003|Mekarjaya
32.05.21.2004|Sukajaya
32.05.21.2005|Sukamulya
32.05.21.2006|Padamukti
32.05.21.2007|Sukalilah
32.05.22.2001|Cikajang
32.05.22.2002|Simpang
32.05.22.2003|Mekarsari
32.05.22.2004|Girijaya
32.05.22.2005|Giriawas
32.05.22.2006|Cibodas
32.05.22.2007|Mekarjaya
32.05.22.2008|Cikandang
32.05.22.2009|Padasuka
32.05.22.2010|Margamulya
32.05.22.2011|Cipangramatan
32.05.22.2012|Karamatwangi
32.05.23.2001|Banjarwangi
32.05.23.2002|Talagajaya
32.05.23.2003|Padahurip
32.05.23.2004|Kadongdong
32.05.23.2005|Talagasari
32.05.23.2006|Jayabakti
32.05.23.2007|Mulyajaya
32.05.23.2008|Dangiang
32.05.23.2009|Tanjungjaya
32.05.23.2010|Bojong
32.05.23.2011|Wangunjaya
32.05.24.2001|Singajaya
32.05.24.2002|Ciudian
32.05.24.2003|Mekartani
32.05.24.2004|Sukamulya
32.05.24.2005|Sukawangi
32.05.24.2006|Pancasura
32.05.24.2007|Karangagung
32.05.24.2008|Cigintung
32.05.24.2009|Girimukti
32.05.25.2001|Cihurip
32.05.25.2002|Cisangkal
32.05.25.2003|Mekarwangi
32.05.25.2004|Jayamukti
32.05.26.2001|Peundeuy
32.05.26.2002|Toblong
32.05.26.2003|Saribakti
32.05.26.2004|Pangrumasan
32.05.26.2005|Sukanagara
32.05.26.2006|Purwajaya
32.05.27.2001|Pameungpeuk
32.05.27.2002|Mancagahar
32.05.27.2003|Paas
32.05.27.2004|Mandalakasih
32.05.27.2005|Jatimulya
32.05.27.2006|Bojong
32.05.27.2007|Sirnabakti
32.05.27.2008|Bojong Kidul
32.05.28.2001|Cisompet
32.05.28.2002|Cihaurkuning
32.05.28.2003|Margamulya
32.05.28.2004|Sukamukti
32.05.28.2005|Sukanagara
32.05.28.2006|Cikondang
32.05.28.2007|Depok
32.05.28.2008|Panyindangan
32.05.28.2009|Jatisari
32.05.28.2010|Neglasari
32.05.28.2011|Sindangsari
32.05.29.2001|Karyasari
32.05.29.2002|Maroko
32.05.29.2003|Sancang
32.05.29.2004|Karyamukti
32.05.29.2005|Sagara
32.05.29.2006|Mekarsari
32.05.29.2007|Simpang
32.05.29.2008|Mekar Mukti
32.05.29.2009|Cigaronggong
32.05.29.2010|Mekarwangi
32.05.29.2011|Najaten
32.05.30.2001|Cikelet
32.05.30.2002|Linggamanik
32.05.30.2003|Kertamukti
32.05.30.2004|Cigadog
32.05.30.2005|Pamalayan
32.05.30.2006|Karangsari
32.05.30.2007|Cijambe
32.05.30.2008|Girimukti
32.05.30.2009|Ciroyom
32.05.30.2010|Awassagara
32.05.30.2011|Tipar
32.05.31.2001|Bungbulang
32.05.31.2002|Hanjuang
32.05.31.2003|Gunamekar
32.05.31.2004|Tegallega
32.05.31.2005|Mekarbakti
32.05.31.2006|Margalaksana
32.05.31.2007|Bojong
32.05.31.2008|Sinarjaya
32.05.31.2009|Mekarjaya
32.05.31.2010|Cihikeu
32.05.31.2011|Wangunjaya
32.05.31.2012|Gunung Jampang
32.05.31.2013|Hegarmanah
32.05.32.2001|Mekarmukti
32.05.32.2002|Karangwangi
32.05.32.2003|Jagabaya
32.05.32.2004|Cijayana
32.05.32.2005|Mekarsari
32.05.33.2001|Neglasari
32.05.33.2002|Tanjungjaya
32.05.33.2003|Tanjungmulya
32.05.33.2004|Wangunjaya
32.05.33.2005|Sukamulya
32.05.33.2006|Pasirlangu
32.05.33.2007|Talagawangi
32.05.33.2008|Jatiwangi
32.05.33.2009|Panyindangan
32.05.33.2010|Tegalgede
32.05.33.2011|Depok
32.05.33.2012|Karangsari
32.05.33.2013|Jayamekar
32.05.34.2001|Pakenjeng
32.05.34.2002|Garumukti
32.05.34.2003|Panawa
32.05.34.2004|Pananjung
32.05.34.2005|Linggarjati
32.05.35.2001|Cisewu
32.05.35.2002|Girimukti
32.05.35.2003|Pamalayan
32.05.35.2004|Cikarang
32.05.35.2005|Sukajaya
32.05.35.2006|Nyalindung
32.05.35.2007|Karangsewu
32.05.35.2008|Mekarsewu
32.05.35.2009|Panggalih
32.05.36.2001|Caringin
32.05.36.2002|Indralayang
32.05.36.2003|Cimahi
32.05.36.2004|Sukarame
32.05.36.2005|Purbayani
32.05.36.2006|Samuderajaya
32.05.37.2001|Sukamaju
32.05.37.2002|Sukamulya
32.05.37.2003|Mekarmukti
32.05.37.2004|Mekarmulya
32.05.37.2005|Sukalaksana
32.05.37.2006|Selaawi
32.05.37.2007|Mekarwangi
32.05.38.2001|Limbangan Tengah
32.05.38.2002|Limbangan Barat
32.05.38.2003|Galihpakuwon
32.05.38.2004|Surabaya
32.05.38.2005|Cijolang
32.05.38.2006|Neglasari
32.05.38.2007|Simpen Kaler
32.05.38.2008|Pasirwaru
32.05.38.2009|Simpen Kidul
32.05.38.2010|Ciwangi
32.05.38.2011|Cigagade
32.05.38.2012|Limbangan Timur
32.05.38.2013|Dunguswiru
32.05.38.2014|Pangeureunan
32.05.39.2001|Selaawi
32.05.39.2002|Putrajawa
32.05.39.2003|Cigawir
32.05.39.2004|Pelitaasih
32.05.39.2005|Cirapuhan
32.05.39.2006|Mekarsari
32.05.39.2007|Samida
32.05.40.2001|Cipareuan
32.05.40.2002|Cibiuk Kaler
32.05.40.2003|Cibiuk Kidul
32.05.40.2004|Majasari
32.05.40.2005|Lingkungpasir
32.05.41.2001|Citangtu
32.05.41.2002|Cimaragas
32.05.41.2003|Babakan Loa
32.05.41.2004|Sukahurip
32.05.41.2005|Sukamulya
32.05.41.2006|Cihuni
32.05.41.2007|Sukarasa
32.05.41.2008|Karangsari
32.05.42.2001|Sadang
32.05.42.2002|Sukaratu
32.05.42.2003|Tenjonagara
32.05.42.2004|Tegalpanjang
32.05.42.2005|Cigadog
32.05.42.2006|Linggamukti
32.05.42.2007|Sukalaksana
32.06.01.2001|Ciheras
32.06.01.2002|Cipatujah
32.06.01.2003|Sindangkerta
32.06.01.2004|Cikawungading
32.06.01.2005|Bantarkalong
32.06.01.2006|Darawati
32.06.01.2007|Nagrog
32.06.01.2008|Pameutingan
32.06.01.2009|Tobongjaya
32.06.01.2010|Cipanas
32.06.01.2011|Kertasari
32.06.01.2012|Ciandum
32.06.01.2013|Nangelasari
32.06.01.2014|Padawaras
32.06.01.2015|Sukahurip
32.06.02.2001|Cidadap
32.06.02.2002|Ciawi
32.06.02.2003|Cikupa
32.06.02.2004|Karangnunggal
32.06.02.2005|Karangmekar
32.06.02.2006|Cikukulu
32.06.02.2007|Cibatuireng
32.06.02.2008|Cibatu
32.06.02.2009|Sarimanggu
32.06.02.2010|Sukawangun
32.06.02.2011|Cintawangi
32.06.02.2012|Cikapinis
32.06.02.2013|Sarimukti
32.06.02.2014|Kujang
32.06.03.2001|Cikalong
32.06.03.2002|Kalapagenep
32.06.03.2003|Cikancra
32.06.03.2004|Singkir
32.06.03.2005|Panyiaran
32.06.03.2006|Cibeber
32.06.03.2007|Cikadu
32.06.03.2008|Mandalajaya
32.06.03.2009|Cidadali
32.06.03.2010|Cimanuk
32.06.03.2011|Sindangjaya
32.06.03.2012|Kubangsari
32.06.03.2013|Tonjongsari
32.06.04.2001|Cibuniasih
32.06.04.2002|Pangliaran
32.06.04.2003|Tonjong
32.06.04.2004|Cibongas
32.06.04.2005|Tawang
32.06.04.2006|Neglasari
32.06.04.2007|Cikawung
32.06.04.2008|Jayamukti
32.06.04.2009|Margaluyu
32.06.04.2010|Mekarsari
32.06.04.2011|Pancawangi
32.06.05.2001|Gunungsari
32.06.05.2002|Cilumba
32.06.05.2003|Pakemitan
32.06.05.2004|Cogreg
32.06.05.2005|Cayur
32.06.05.2006|Lengkongbarang
32.06.05.2007|Sindangasih
32.06.05.2008|Tanjungbarang
32.06.05.2009|Linggalaksana
32.06.06.2001|Cisempur
32.06.06.2002|Setiawaras
32.06.06.2003|Eureunpalay
32.06.06.2004|Cibalong
32.06.06.2005|Singajaya
32.06.06.2006|Parung
32.06.07.2001|Parungponteng
32.06.07.2002|Cigunung
32.06.07.2003|Cibanteng
32.06.07.2004|Barumekar
32.06.07.2005|Cibungur
32.06.07.2006|Burujuljaya
32.06.07.2007|Girikencana
32.06.07.2008|Karyabakti
32.06.08.2001|Simpang
32.06.08.2002|Parakanhonje
32.06.08.2003|Pamijahan
32.06.08.2004|Sukamaju
32.06.08.2005|Wangunsari
32.06.08.2006|Hegarwangi
32.06.08.2007|Wakap
32.06.08.2008|Sirnagalih
32.06.09.2001|Mertajaya
32.06.09.2002|Cikadongdong
32.06.09.2003|Bojongasih
32.06.09.2004|Sindangsari
32.06.09.2005|Girijaya
32.06.09.2006|Toblongan
32.06.10.2001|Cikuya
32.06.10.2002|Cintabodas
32.06.10.2003|Cipicung
32.06.10.2004|Bojongsari
32.06.10.2005|Mekarlaksana
32.06.11.2001|Bojongkapol
32.06.11.2002|Pedangkamulyan
32.06.11.2003|Bojonggambir
32.06.11.2004|Ciroyom
32.06.11.2005|Wandasari
32.06.11.2006|Campakasari
32.06.11.2007|Mangkonjaya
32.06.11.2008|Kertanegla
32.06.11.2009|Purwaraharja
32.06.11.2010|Girimukti
32.06.12.2001|Parumasan
32.06.12.2002|Cukangkawung
32.06.12.2003|Sodonghilir
32.06.12.2004|Cikalong
32.06.12.2005|Cipaingeun
32.06.12.2006|Leuwidulang
32.06.12.2007|Muncang
32.06.12.2008|Sepatnunggal
32.06.12.2009|Cukangjayaguna
32.06.12.2010|Raksajaya
32.06.12.2011|Pakalongan
32.06.12.2012|Sukabakti
32.06.13.2001|Taraju
32.06.13.2002|Cikubang
32.06.13.2003|Deudeul
32.06.13.2004|Purwarahayu
32.06.13.2005|Singasari
32.06.13.2006|Banyuasih
32.06.13.2007|Raksasari
32.06.13.2008|Kertaraharja
32.06.13.2009|Pageralam
32.06.14.2001|Jahiang
32.06.14.2002|Serang
32.06.14.2003|Salawu
32.06.14.2004|Neglasari
32.06.14.2005|Tanjungsari
32.06.14.2006|Tenjowaringin
32.06.14.2007|Sundawenang
32.06.14.2008|Kawungsari
32.06.14.2009|Sukarasa
32.06.14.2010|Kutawaringin
32.06.14.2011|Karangmukti
32.06.14.2012|Margalaksana
32.06.15.2001|Mandalasari
32.06.15.2002|Sukasari
32.06.15.2003|Puspasari
32.06.15.2004|Puspahiang
32.06.15.2005|Luyubakti
32.06.15.2006|Pusparahayu
32.06.15.2007|Cimanggu
32.06.15.2008|Puspajaya
32.06.16.2001|Cikeusal
32.06.16.2002|Cibalanarik
32.06.16.2003|Sukanagara
32.06.16.2004|Tanjungjaya
32.06.16.2005|Cilolohan
32.06.16.2006|Cintajaya
32.06.16.2007|Sukasenang
32.06.17.2001|Sukapura
32.06.17.2002|Leuwibudah
32.06.17.2003|Sirnajaya
32.06.17.2004|Mekarjaya
32.06.17.2005|Linggaraja
32.06.17.2006|Janggala
32.06.17.2007|Margalaksana
32.06.17.2008|Tarunajaya
32.06.18.2001|Mandalahayu
32.06.18.2002|Mulyasari
32.06.18.2003|Kawitan
32.06.18.2004|Mandalawangi
32.06.18.2005|Karyawangi
32.06.18.2006|Tanjungsari
32.06.18.2007|Mandalaguna
32.06.18.2008|Karyamandala
32.06.18.2009|Banjarwaringin
32.06.19.2001|Kaputihan
32.06.19.2002|Setiawangi
32.06.19.2003|Sukakerta
32.06.19.2004|Neglasari
32.06.19.2005|Jatiwaras
32.06.19.2006|Papayan
32.06.19.2007|Ciwarak
32.06.19.2008|Kersagalih
32.06.19.2009|Mandalamekar
32.06.19.2010|Kertarahayu
32.06.19.2011|Mandalahurip
32.06.20.2001|Cisarua
32.06.20.2002|Cikondang
32.06.20.2003|Cijulang
32.06.20.2004|Ciampanan
32.06.20.2005|Cineam
32.06.20.2006|Rajadatu
32.06.20.2007|Ancol
32.06.20.2008|Nagaratengah
32.06.20.2009|Pasirmukti
32.06.20.2010|Madiasari
32.06.21.2001|Sirnajaya
32.06.21.2002|Karangjaya
32.06.21.2003|Karang Layung
32.06.21.2004|Citalahab
32.06.22.2001|Cihaur
32.06.22.2002|Cilangkap
32.06.22.2003|Pasirpanjang
32.06.22.2004|Cibeber
32.06.22.2005|Kamulyan
32.06.22.2006|Manonjaya
32.06.22.2007|Margaluyu
32.06.22.2008|Pasirbatang
32.06.22.2009|Kalimanggis
32.06.22.2010|Margahayu
32.06.22.2011|Batusumur
32.06.22.2012|Gunajaya
32.06.23.2001|Cinunjang
32.06.23.2002|Gunungtanjung
32.06.23.2003|Bojongsari
32.06.23.2004|Jatijaya
32.06.23.2005|Tanjungsari
32.06.23.2006|Giriwangi
32.06.23.2007|Malatisuka
32.06.24.2001|Cikunten
32.06.24.2002|Singaparna
32.06.24.2003|Cipakat
32.06.24.2004|Cintaraja
32.06.24.2005|Cikunir
32.06.24.2006|Cikadongdong
32.06.24.2007|Sukaasih
32.06.24.2008|Sukamulya
32.06.24.2009|Singasari
32.06.24.2010|Sukaherang
32.06.25.2001|Sukasukur
32.06.25.2002|Salebu
32.06.25.2003|Mangunreja
32.06.25.2004|Margajaya
32.06.25.2005|Pasirsalam
32.06.25.2006|Sukaluyu
32.06.26.2001|Sukarame
32.06.26.2002|Sukamenak
32.06.26.2003|Sukakarsa
32.06.26.2004|Padasuka
32.06.26.2005|Sukarapih
32.06.26.2006|Wargakerta
32.06.27.2001|Kersamaju
32.06.27.2002|Nangtang
32.06.27.2003|Pusparaja
32.06.27.2004|Jayapura
32.06.27.2005|Lengkongjaya
32.06.27.2006|Nanggerang
32.06.27.2007|Sukamanah
32.06.27.2008|Sirnaraja
32.06.27.2009|Cidugaleun
32.06.27.2010|Parentas
32.06.27.2011|Puspamukti
32.06.27.2012|Tenjonagara
32.06.27.2013|Cigalontang
32.06.27.2014|Sirnagalih
32.06.27.2015|Tanjungkarang
32.06.27.2016|Sirnaputra
32.06.28.2001|Arjasari
32.06.28.2002|Ciawang
32.06.28.2003|Cigadog
32.06.28.2004|Linggawangi
32.06.28.2005|Jayamukti
32.06.28.2006|Mandalagiri
32.06.28.2007|Linggamulya
32.06.29.2001|Cilampunghilir
32.06.29.2002|Rancapaku
32.06.29.2003|Mekarjaya
32.06.29.2004|Cisaruni
32.06.29.2005|Padakembang
32.06.30.2001|Sariwangi
32.06.30.2002|Sukaharja
32.06.30.2003|Jayaratu
32.06.30.2004|Linggasirna
32.06.30.2005|Sirnasari
32.06.30.2006|Sukamulih
32.06.30.2007|Selawangi
32.06.30.2008|Jayaputra
32.06.31.2001|Linggajati
32.06.31.2002|Tawangbanteng
32.06.31.2003|Sinagar
32.06.31.2004|Gunungsari
32.06.31.2005|Sukamahi
32.06.31.2006|Sukagalih
32.06.31.2007|Sukaratu
32.06.31.2008|Indrajaya
32.06.32.2001|Cisayong
32.06.32.2002|Sukajadi
32.06.32.2003|Sukasukur
32.06.32.2004|Sukamukti
32.06.32.2005|Nusawangi
32.06.32.2006|Cikadu
32.06.32.2007|Cileuleus
32.06.32.2008|Jatihurip
32.06.32.2009|Sukasetia
32.06.32.2010|Purwasari
32.06.32.2011|Sukaraharja
32.06.32.2012|Mekarwangi
32.06.32.2013|Santanamekar
32.06.33.2001|Banyurasa
32.06.33.2002|Calingcing
32.06.33.2003|Sukahening
32.06.33.2004|Kiarajangkung
32.06.33.2005|Kudadepa
32.06.33.2006|Banyuresmi
32.06.33.2007|Sundakerta
32.06.34.2001|Dawagung
32.06.34.2002|Rajapolah
32.06.34.2003|Manggungjaya
32.06.34.2004|Manggungsari
32.06.34.2005|Sukaraja
32.06.34.2006|Rajamandala
32.06.34.2007|Sukanagalih
32.06.34.2008|Tanjungpura
32.06.35.2001|Condong
32.06.35.2002|Bojonggaok
32.06.35.2003|Sindangraja
32.06.35.2004|Karangmulya
32.06.35.2005|Geresik
32.06.35.2006|Karangsembung
32.06.35.2007|Tanjungmekar
32.06.35.2008|Karangresik
32.06.36.2001|Gombong
32.06.36.2002|Bugel
32.06.36.2003|Margasari
32.06.36.2004|Pakemitan
32.06.36.2005|Ciawi
32.06.36.2006|Sukamantri
32.06.36.2007|Pasirhuni
32.06.36.2008|Citamba
32.06.36.2009|Kertamukti
32.06.36.2010|Kurniabakti
32.06.36.2011|Pakemitankidul
32.06.37.2001|Kadipaten
32.06.37.2002|Dirgahayu
32.06.37.2003|Cibahayu
32.06.37.2004|Mekarsari
32.06.37.2005|Buniasih
32.06.37.2006|Pamoyanan
32.06.38.2001|Cipacing
32.06.38.2002|Pagerageung
32.06.38.2003|Sukamaju
32.06.38.2004|Tanjungkerta
32.06.38.2005|Puteran
32.06.38.2006|Guranteng
32.06.38.2007|Nanggewer
32.06.38.2008|Sukapada
32.06.38.2009|Pagersari
32.06.38.2010|Sukadana
32.06.39.2001|Cipondok
32.06.39.2002|Sukamenak
32.06.39.2003|Sukaratu
32.06.39.2004|Banjarsari
32.06.39.2005|Tanjungsari
32.06.39.2006|Sukapancar
32.06.39.2007|Sukaresik
32.06.39.2008|Margamulya
32.07.01.1001|Ciamis
32.07.01.1002|Kertasari
32.07.01.1003|Maleber
32.07.01.1004|Cigembor
32.07.01.1005|Benteng
32.07.01.1006|Linggasari
32.07.01.1007|Sindangrasa
32.07.01.2008|Pawindan
32.07.01.2009|Cisadap
32.07.01.2010|Imbanagara
32.07.01.2011|Imbanagara Raya
32.07.01.2012|Panyingkiran
32.07.02.2001|Cikoneng
32.07.02.2002|Margaluyu
32.07.02.2003|Sindangsari
32.07.02.2011|Panaragan
32.07.02.2012|Darmacaang
32.07.02.2013|Kujang
32.07.02.2014|Nasol
32.07.02.2016|Cimari
32.07.02.2017|Gegempalan
32.07.03.2001|Handapherang
32.07.03.2002|Ciharalang
32.07.03.2003|Bojongmengger
32.07.03.2004|Karangkamulyan
32.07.03.2005|Kertabumi
32.07.03.2006|Cijeungjing
32.07.03.2007|Pamalayan
32.07.03.2008|Dewasari
32.07.03.2009|Utama
32.07.03.2010|Kertaharja
32.07.03.2011|Karanganyar
32.07.04.2001|Gunungsari
32.07.04.2002|Sadananya
32.07.04.2003|Werasari
32.07.04.2004|Mangkubumi
32.07.04.2005|Tanjungsari
32.07.04.2006|Bendasari
32.07.04.2007|Sukajadi
32.07.04.2008|Mekarjadi
32.07.05.2001|Cidolog
32.07.05.2002|Janggala
32.07.05.2003|Hegarmanah
32.07.05.2004|Jelegong
32.07.05.2005|Ciparay
32.07.05.2006|Sukasari
32.07.06.2001|Sukamulya
32.07.06.2002|Sukahurip
32.07.06.2003|Cijulang
32.07.06.2004|Sukamaju
32.07.06.2005|Sukasetia
32.07.06.2006|Sumberjaya
32.07.06.2007|Cihaurbeuti
32.07.06.2008|Pasirtamiang
32.07.06.2009|Padamulya
32.07.06.2010|Pamokolan
32.07.06.2011|Sukahaji
32.07.07.2001|Medanglayang
32.07.07.2002|Panumbangan
32.07.07.2003|Sukakerta
32.07.07.2004|Golat
32.07.07.2005|Sindangherang
32.07.07.2006|Banjarangsana
32.07.07.2007|Payungagung
32.07.07.2008|Tanjungmulya
32.07.07.2009|Payungsari
32.07.07.2010|Jayagiri
32.07.07.2011|Kertaraharja
32.07.07.2012|Sindangmukti
32.07.07.2013|Sindangbarang
32.07.07.2014|Buanamekar
32.07.08.2001|Panjalu
32.07.08.2002|Kertamandala
32.07.08.2003|Ciomas
32.07.08.2004|Sandingtaman
32.07.08.2005|Maparah
32.07.08.2009|Bahara
32.07.08.2012|Hujungtiwu
32.07.08.2013|Mandalare
32.07.09.2001|Kawali
32.07.09.2002|Talagasari
32.07.09.2004|Karangpawitan
32.07.09.2005|Winduraja
32.07.09.2006|Margamulya
32.07.09.2011|Citeureup
32.07.09.2013|Purwasari
32.07.09.2014|Sindangsari
32.07.09.2015|Kawalimukti
32.07.09.2016|Selasari
32.07.09.2019|Linggapura
32.07.10.2001|Panawangan
32.07.10.2002|Sagalaherang
32.07.10.2003|Nagarapageuh
32.07.10.2004|Nagarajati
32.07.10.2005|Nagarajaya
32.07.10.2006|Kertayasa
32.07.10.2007|Indragiri
32.07.10.2008|Cinyasag
32.07.10.2009|Sadapaingan
32.07.10.2010|Jagabaya
32.07.10.2011|Gardujaya
32.07.10.2012|Karangpaningal
32.07.10.2013|Bangunjaya
32.07.10.2014|Girilaya
32.07.10.2015|Kertajaya
32.07.10.2016|Nagarawangi
32.07.10.2017|Mekarbuana
32.07.10.2018|Natanegara
32.07.11.2001|Buniseuri
32.07.11.2002|Selacai
32.07.11.2003|Jalatrang
32.07.11.2004|Cipaku
32.07.11.2005|Cieurih
32.07.11.2006|Gereba
32.07.11.2007|Muktisari
32.07.11.2008|Mekarsari
32.07.11.2009|Pusakasari
32.07.11.2010|Bangbayang
32.07.11.2011|Selamanik
32.07.11.2012|Ciakar
32.07.11.2013|Sukawening
32.07.12.2001|Jatinagara
32.07.12.2002|Sukanagara
32.07.12.2003|Cintanagara
32.07.12.2004|Dayeuhluhur
32.07.12.2005|Mulyasari
32.07.12.2006|Bayasari
32.07.13.2001|Rajadesa
32.07.13.2002|Tanjungsukur
32.07.13.2003|Tanjungsari
32.07.13.2004|Tanjungjaya
32.07.13.2005|Andapraja
32.07.13.2006|Sukaharja
32.07.13.2007|Sukajaya
32.07.13.2008|Tigaherang
32.07.13.2009|Sirnabaya
32.07.13.2010|Sirnajaya
32.07.13.2011|Purwaraja
32.07.14.2001|Sukadana
32.07.14.2002|Salakaria
32.07.14.2003|Margaharja
32.07.14.2004|Margajaya
32.07.14.2005|Bunter
32.07.14.2006|Ciparigi
32.07.15.2001|Rancah
32.07.15.2002|Kiarapayung
32.07.15.2003|Cileungsir
32.07.15.2004|Cisontrol
32.07.15.2005|Situmandala
32.07.15.2006|Kawunglarang
32.07.15.2007|Patakaharja
32.07.15.2008|Bojonggedang
32.07.15.2009|Karangpari
32.07.15.2010|Dadiharja
32.07.15.2011|Jangalaharja
32.07.15.2012|Giriharja
32.07.15.2013|Wangunsari
32.07.16.2001|Tambaksari
32.07.16.2002|Mekarsari
32.07.16.2003|Kaso
32.07.16.2004|Kadupandak
32.07.16.2005|Sukasari
32.07.16.2006|Karangpaningal
32.07.17.2006|Sidaharja
32.07.17.2007|Kertajaya
32.07.17.2009|Sukanagara
32.07.17.2010|Cintajaya
32.07.17.2011|Cintaratu
32.07.17.2012|Sindangangin
32.07.17.2013|Tambakreja
32.07.17.2017|Baregbeg
32.07.17.2018|Kalapasawit
32.07.17.2019|Puloerang
32.07.18.2005|Kawasen
32.07.18.2006|Cicapar
32.07.18.2007|Cibadak
32.07.18.2008|Banjarsari
32.07.18.2009|Sindanghayu
32.07.18.2010|Sindangasih
32.07.18.2012|Sindangsari
32.07.18.2013|Ciherang
32.07.18.2014|Purwasari
32.07.18.2015|Ratawangi
32.07.18.2016|Ciulu
32.07.18.2018|Sukasari
32.07.19.2001|Pamarican
32.07.19.2002|Sidamulih
32.07.19.2003|Kertahayu
32.07.19.2004|Sukamukti
32.07.19.2005|Bangunsari
32.07.19.2006|Neglasari
32.07.19.2007|Bantarsari
32.07.19.2008|Margajaya
32.07.19.2009|Sukajaya
32.07.19.2010|Sukahurip
32.07.19.2011|Sukajadi
32.07.19.2012|Sidaharja
32.07.19.2013|Pasirnagara
32.07.19.2014|Mekarmulya
32.07.29.2001|Cimaragas
32.07.29.2002|Beber
32.07.29.2003|Raksabaya
32.07.29.2004|Bojongmalang
32.07.29.2005|Jayaraksa
32.07.30.2001|Cisaga
32.07.30.2002|Sidamulya
32.07.30.2003|Kepel
32.07.30.2004|Wangunjaya
32.07.30.2005|Sukahurip
32.07.30.2006|Bangunharja
32.07.30.2007|Tanjungjaya
32.07.30.2008|Mekarmukti
32.07.30.2009|Danasari
32.07.30.2010|Girimukti
32.07.30.2011|Karyamulya
32.07.31.2001|Sindangkasih
32.07.31.2002|Gunungcupu
32.07.31.2003|Budiasih
32.07.31.2004|Budiharja
32.07.31.2005|Sukaraja
32.07.31.2006|Sukamanah
32.07.31.2007|Sukasenang
32.07.31.2008|Sukaresik
32.07.31.2009|Wanasigra
32.07.32.2001|Baregbeg
32.07.32.2002|Sukamaju
32.07.32.2003|Mekarjaya
32.07.32.2004|Saguling
32.07.32.2005|Petirhilir
32.07.32.2006|Pusakanagara
32.07.32.2007|Jelat
32.07.32.2008|Karangampel
32.07.32.2009|Sukamulya
32.07.33.2001|Sukamantri
32.07.33.2002|Tenggerraharja
32.07.33.2003|Cibeureum
32.07.33.2004|Sindanglaya
32.07.33.2005|Mekarwangi
32.07.34.2001|Cikupa
32.07.34.2002|Sukaraharja
32.07.34.2003|Lumbung
32.07.34.2004|Lumbungsari
32.07.34.2005|Awiluar
32.07.34.2006|Darmaraja
32.07.34.2007|Rawa
32.07.34.2008|Sadewata
32.07.35.2001|Bantardawa
32.07.35.2002|Purwadadi
32.07.35.2003|Purwajaya
32.07.35.2004|Karangpaningal
32.07.35.2005|Sidarahayu
32.07.35.2006|Padaringan
32.07.35.2007|Pasirlawang
32.07.35.2008|Kutawaringin
32.07.35.2009|Sukamulya
32.07.37.2001|Pasawahan
32.07.37.2002|Banjaranyar
32.07.37.2003|Cigayam
32.07.37.2004|Langkapsari
32.07.37.2005|Kalijaya
32.07.37.2006|Sindangrasa
32.07.37.2007|Cikaso
32.07.37.2008|Cikupa
32.07.37.2009|Karyamukti
32.07.37.2010|Tanjungsari
32.08.01.2001|Sindangjawa
32.08.01.2002|Ciketak
32.08.01.2003|Nangka
32.08.01.2004|Windujanten
32.08.01.2005|Kadugede
32.08.01.2006|Babatan
32.08.01.2007|Cipondok
32.08.01.2008|Bayuning
32.08.01.2009|Tinggar
32.08.01.2010|Ciherang
32.08.01.2011|Cisukadana
32.08.01.2012|Margabakti
32.08.02.2001|Pinara
32.08.02.2002|Cijemit
32.08.02.2003|Cipedes
32.08.02.2004|Ciniru
32.08.02.2005|Rambatan
32.08.02.2006|Longkewang
32.08.02.2007|Mungkaldatar
32.08.02.2008|Gunungmanik
32.08.02.2009|Pamupukan
32.08.03.2001|Tangkolo
32.08.03.2002|Pamulihan
32.08.03.2003|Subang
32.08.03.2004|Gunungaci
32.08.03.2005|Situgede
32.08.03.2006|Bangunjaya
32.08.03.2007|Jatisari
32.08.04.2001|Sumberjaya
32.08.04.2002|Cilayung
32.08.04.2003|Ciwaru
32.08.04.2004|Garajati
32.08.04.2005|Baok
32.08.04.2006|Andamui
32.08.04.2007|Sagaranten
32.08.04.2008|Citundun
32.08.04.2009|Lebakherang
32.08.04.2010|Karangbaru
32.08.04.2011|Linggajaya
32.08.04.2012|Citikur
32.08.05.2001|Cipondok
32.08.05.2002|Sindangjawa
32.08.05.2003|Ciangir
32.08.05.2004|Cibingbin
32.08.05.2005|Citenjo
32.08.05.2006|Dukuhbadag
32.08.05.2007|Bantarpanjang
32.08.05.2008|Sukamaju
32.08.05.2009|Sukaharja
32.08.05.2010|Cisaat
32.08.06.2001|Dukuhpicung
32.08.06.2002|Walaharcageur
32.08.06.2003|Wilanagara
32.08.06.2004|Cigedang
32.08.06.2005|Luragungtonggoh
32.08.06.2006|Sindangsari
32.08.06.2007|Cirahayu
32.08.06.2008|Margasari
32.08.06.2009|Sindangsuka
32.08.06.2010|Cikandang
32.08.06.2011|Panyosogan
32.08.06.2012|Gunungkarung
32.08.06.2013|Luragunglandeuh
32.08.06.2014|Dukuhmaja
32.08.06.2015|Benda
32.08.06.2016|Cikaduwetan
32.08.07.2010|Langseb
32.08.07.2011|Cinagara
32.08.07.2012|Cineumbeuy
32.08.07.2013|Cipetir
32.08.07.2014|Lebakwangi
32.08.07.2015|Mancagar
32.08.07.2016|Bendungan
32.08.07.2017|Sindang
32.08.07.2018|Pasayangan
32.08.07.2019|Pajawankidul
32.08.07.2020|Pagundan
32.08.07.2021|Mekarwangi
32.08.07.2025|Manggari
32.08.08.2001|Gewok
32.08.08.2002|Cirukem
32.08.08.2003|Pakembangan
32.08.08.2004|Sukaimut
32.08.08.2005|Cikananga
32.08.08.2006|Tambakbaya
32.08.08.2007|Garawangi
32.08.08.2008|Sukamulya
32.08.08.2009|Mancagar
32.08.08.2010|Purwasari
32.08.08.2011|Lengkong
32.08.08.2023|Karamatwangi
32.08.08.2024|Citiusari
32.08.08.2026|Mekarmulya
32.08.08.2027|Tembong
32.08.08.2028|Kutakembaran
32.08.08.2029|Kadatuan
32.08.09.1001|Citangtu
32.08.09.1002|Kuningan
32.08.09.1003|Winduhaji
32.08.09.1004|Windusengkahan
32.08.09.1005|Cijoho
32.08.09.1006|Purwawinangun
32.08.09.1007|Cigintung
32.08.09.1008|Cirendang
32.08.09.1009|Ciporang
32.08.09.1010|Awirarangan
32.08.09.2011|Cibinuang
32.08.09.2012|Karangtawang
32.08.09.2013|Kedungarum
32.08.09.2014|Ancaran
32.08.09.2015|Kasturi
32.08.09.2016|Padarek
32.08.10.2001|Geresik
32.08.10.2002|Kadurama
32.08.10.2003|Ciawigebang
32.08.10.2004|Lebaksiuh
32.08.10.2005|Ciputat
32.08.10.2006|Pajawanlor
32.08.10.2007|Sidaraja
32.08.10.2008|Kapandayan
32.08.10.2009|Pangkalan
32.08.10.2010|Ciomas
32.08.10.2011|Sukaraja
32.08.10.2012|Cihaur
32.08.10.2013|Ciawilor
32.08.10.2014|Cigarukgak
32.08.10.2015|Sukadana
32.08.10.2016|Cihirup
32.08.10.2017|Karamatmulya
32.08.10.2018|Pamijahan
32.08.10.2019|Karangkamulyan
32.08.10.2020|Padarama
32.08.10.2021|Cikubangmulya
32.08.10.2022|Dukuhdalem
32.08.10.2023|Mekarjaya
32.08.10.2024|Cijagamulya
32.08.11.2001|Cihideunggirang
32.08.11.2002|Cihideunghilir
32.08.11.2003|Cidahu
32.08.11.2004|Kertawinangun
32.08.11.2005|Datar
32.08.11.2006|Legok
32.08.11.2007|Cikeusik
32.08.11.2008|Cieurih
32.08.11.2009|Cibulan
32.08.11.2010|Nanggela
32.08.11.2011|Jatimulya
32.08.11.2012|Bunder
32.08.12.2001|Sukamukti
32.08.12.2002|Sidamulya
32.08.12.2003|Jalaksana
32.08.12.2004|Sangkanerang
32.08.12.2005|Sayana
32.08.12.2006|Peusing
32.08.12.2007|Sembawa
32.08.12.2008|Sadamantra
32.08.12.2009|Maniskidul
32.08.12.2010|Manislor
32.08.12.2011|Ciniru
32.08.12.2012|Padamenak
32.08.12.2013|Babakanmulya
32.08.12.2014|Sindangbarang
32.08.12.2015|Nanggerang
32.08.13.2006|Bandorasawetan
32.08.13.2007|Bandorasakulon
32.08.13.2008|Linggasana
32.08.13.2009|Linggajati
32.08.13.2010|Bojong
32.08.13.2015|Cilimus
32.08.13.2016|Setianegara
32.08.13.2017|Cibeureum
32.08.13.2018|Kaliaren
32.08.13.2019|Sampora
32.08.13.2020|Caracas
32.08.13.2023|Linggamekar
32.08.13.2024|Linggaindah
32.08.14.2001|Cirea
32.08.14.2002|Sukasari
32.08.14.2003|Seda
32.08.14.2004|Trijaya
32.08.14.2005|Randobawagirang
32.08.14.2006|Pakembangan
32.08.14.2007|Randobawailir
32.08.14.2008|Kertawinangun
32.08.14.2009|Mandirancan
32.08.14.2010|Nanggela
32.08.14.2011|Nanggerangjaya
32.08.14.2012|Salakadomas
32.08.15.2001|Selajambe
32.08.15.2002|Cantilan
32.08.15.2003|Ciberung
32.08.15.2004|Kutawaringin
32.08.15.2005|Jamberama
32.08.15.2006|Bagawat
32.08.15.2007|Padahurip
32.08.16.2002|Gereba
32.08.16.2004|Cilaja
32.08.16.2005|Cikubangsari
32.08.16.2006|Bojong
32.08.16.2007|Cilowa
32.08.16.2008|Cibentang
32.08.16.2009|Ragawacana
32.08.16.2010|Pajambon
32.08.16.2011|Gandasoli
32.08.16.2012|Kalapagunung
32.08.16.2013|Kramatmulya
32.08.16.2014|Cikaso
32.08.16.2015|Karangmangu
32.08.16.2017|Widarasari
32.08.17.2001|Cimenga
32.08.17.2002|Cageur
32.08.17.2003|Sakertabarat
32.08.17.2004|Sukarasa
32.08.17.2005|Paninggaran
32.08.17.2006|Cipasung
32.08.17.2007|Kawahmanuk
32.08.17.2008|Cikupa
32.08.17.2009|Parung
32.08.17.2010|Darma
32.08.17.2011|Jagara
32.08.17.2012|Bakom
32.08.17.2013|Karanganyar
32.08.17.2014|Karangsari
32.08.17.2015|Sagarahiang
32.08.17.2016|Gunungsirah
32.08.17.2017|Sakertatimur
32.08.17.2018|Tugumulya
32.08.17.2019|Situsari
32.08.18.1001|Cigugur
32.08.18.1002|Cigadung
32.08.18.1003|Winduherang
32.08.18.1004|Sukamulya
32.08.18.1005|Cipari
32.08.18.2006|Cileuleuy
32.08.18.2007|Puncak
32.08.18.2008|Gunungkeling
32.08.18.2009|Cisantana
32.08.18.2010|Babakanmulya
32.08.19.2001|Padabeunghar
32.08.19.2002|Kaduela
32.08.19.2003|Pasawahan
32.08.19.2004|Ciwiru
32.08.19.2005|Cidahu
32.08.19.2006|Cimara
32.08.19.2007|Paniis
32.08.19.2008|Cibuntu
32.08.19.2009|Singkup
32.08.19.2010|Padamatang
32.08.20.2001|Haurkuning
32.08.20.2002|Kertayuga
32.08.20.2003|Windusari
32.08.20.2004|Nusaherang
32.08.20.2005|Jambar
32.08.20.2006|Cikadu
32.08.20.2007|Kertawirama
32.08.20.2008|Ciasih
32.08.21.2001|Muncangela
32.08.21.2002|Karoya
32.08.21.2003|Susukan
32.08.21.2004|Cimaranten
32.08.21.2005|Cipicung
32.08.21.2006|Pamulihan
32.08.21.2007|Salareuma
32.08.21.2008|Suganangan
32.08.21.2009|Sukamukti
32.08.21.2010|Mekarsari
32.08.22.2001|Silebu
32.08.22.2002|Patalagan
32.08.22.2003|Kahiyangan
32.08.22.2004|Tajurbuntu
32.08.22.2005|Pancalang
32.08.22.2006|Sumbakeling
32.08.22.2007|Sarewu
32.08.22.2008|Sindangkempeng
32.08.22.2009|Rajawetan
32.08.22.2010|Tenjolayar
32.08.22.2011|Mekarjaya
32.08.22.2012|Tarikolot
32.08.22.2013|Danalampah
32.08.23.2001|Garatengah
32.08.23.2002|Rajadanu
32.08.23.2003|Singkup
32.08.23.2004|Japara
32.08.23.2005|Wano
32.08.23.2006|Citapen
32.08.23.2007|Cengal
32.08.23.2008|Cikeleng
32.08.23.2009|Kalimati
32.08.23.2010|Dukuhdalem
32.08.24.2003|Cileuya
32.08.24.2004|Margamukti
32.08.24.2005|Gunungsari
32.08.24.2006|Cimahi
32.08.24.2007|Kananga
32.08.24.2008|Cikeusal
32.08.24.2009|Mekarjaya
32.08.24.2010|Sukajaya
32.08.24.2011|Mulyajaya
32.08.24.2012|Cimulya
32.08.25.2001|Legokherang
32.08.25.2002|Bungurberes
32.08.25.2003|Cilebak
32.08.25.2004|Jalatrang
32.08.25.2005|Patala
32.08.25.2006|Mandapajaya
32.08.25.2007|Cilimusari
32.08.26.2001|Citapen
32.08.26.2002|Pasiragung
32.08.26.2003|Tundagan
32.08.26.2004|Bunigeulis
32.08.26.2005|Hantara
32.08.26.2006|Pakapasangirang
32.08.26.2007|Cikondang
32.08.26.2008|Pakapasanhilir
32.08.27.2001|Kalimanggiskulon
32.08.27.2002|Partawangunan
32.08.27.2003|Cipancur
32.08.27.2004|Kertawana
32.08.27.2005|Wanasaraya
32.08.27.2006|Kalimanggiswetan
32.08.28.2001|Cimara
32.08.28.2002|Sumurwiru
32.08.28.2003|Cibeureum
32.08.28.2004|Tarikolot
32.08.28.2005|Randusari
32.08.28.2006|Sukadana
32.08.28.2007|Kawungsari
32.08.28.2008|Sukarapih
32.08.29.2001|Karangkancana
32.08.29.2002|Kaduagung
32.08.29.2003|Segong
32.08.29.2004|Tanjungkerta
32.08.29.2005|Sukasari
32.08.29.2006|Margacina
32.08.29.2007|Jabranti
32.08.29.2008|Simpayjaya
32.08.29.2009|Cihanjaro
32.08.30.2001|Garahaji
32.08.30.2002|Galaherang
32.08.30.2003|Cipakem
32.08.30.2004|Maleber
32.08.30.2005|Parakan
32.08.30.2006|Kutaraja
32.08.30.2007|Ciporang
32.08.30.2008|Dukuhtengah
32.08.30.2009|Karangtengah
32.08.30.2010|Mekarsari
32.08.30.2011|Padamulya
32.08.30.2012|Cikahuripan
32.08.30.2013|Kutamandarakan
32.08.30.2014|Mandalajaya
32.08.30.2015|Giriwaringin
32.08.30.2016|Buniasih
32.08.31.2001|Sindangsari
32.08.31.2002|Kaduagung
32.08.31.2003|Kertaungaran
32.08.31.2004|Sindangagung
32.08.31.2005|Balong
32.08.31.2006|Kertayasa
32.08.31.2007|Kertawangunan
32.08.31.2008|Babakanreuma
32.08.31.2009|Tirtawangunan
32.08.31.2010|Dukuhlor
32.08.31.2011|Taraju
32.08.31.2012|Mekarmukti
32.08.32.2001|Bunigeulis
32.08.32.2002|Jambugeulis
32.08.32.2003|Koreak
32.08.32.2004|Karangmuncang
32.08.32.2005|Sangkanurip
32.08.32.2006|Panawuan
32.08.32.2007|Timbang
32.08.32.2008|Babakanjati
32.08.32.2009|Indapatra
32.08.32.2010|Cibuntu
32.08.32.2011|Sangkanmulya
32.09.01.2008|Waled Desa
32.09.01.2009|Waled Kota
32.09.01.2010|Mekarsari
32.09.01.2011|Waled Asem
32.09.01.2012|Ambit
32.09.01.2013|Ciuyah
32.09.01.2014|Gunungsari
32.09.01.2015|Karangsari
32.09.01.2016|Cikulak Kidul
32.09.01.2017|Cikulak
32.09.01.2018|Cibogo
32.09.01.2019|Cisaat
32.09.02.2008|Leuweunggajah
32.09.02.2009|Tenjomaya
32.09.02.2010|Damarguna
32.09.02.2011|Jatiseeng
32.09.02.2012|Jatiseeng Kidul
32.09.02.2013|Ciledug Kulon
32.09.02.2014|Ciledug Wetan
32.09.02.2015|Ciledug Lor
32.09.02.2016|Ciledug Tengah
32.09.02.2017|Bojongnegara
32.09.03.2001|Astanalanggar
32.09.03.2002|Barisan
32.09.03.2003|Losari Kidul
32.09.03.2004|Panggangsari
32.09.03.2005|Losari Lor
32.09.03.2006|Mulyasari
32.09.03.2007|Kalirahayu
32.09.03.2008|Kalisari
32.09.03.2009|Ambulu
32.09.03.2010|Tawangsari
32.09.04.2001|Pabedilan Kidul
32.09.04.2002|Pabedilan Wetan
32.09.04.2003|Pabedilan Kulon
32.09.04.2004|Pabedilan Kaler
32.09.04.2005|Silihasih
32.09.04.2006|Tersana
32.09.04.2007|Pasuruan
32.09.04.2008|Dukuhwidara
32.09.04.2009|Kalibuntu
32.09.04.2010|Kalimukti
32.09.04.2011|Sidaresmi
32.09.04.2012|Babakan Losari
32.09.04.2013|Babakan Losari Lor
32.09.05.2001|Cangkuang
32.09.05.2002|Serang Wetan
32.09.05.2003|Serang Kulon
32.09.05.2004|Gembongan Mekar
32.09.05.2005|Gembongan
32.09.05.2006|Babakan Gebang
32.09.05.2007|Babakan
32.09.05.2008|Bojonggebang
32.09.05.2009|Sumber Kidul
32.09.05.2010|Sumber Lor
32.09.05.2011|Kudumulya
32.09.05.2012|Kudukeras
32.09.05.2013|Pakusamben
32.09.05.2014|Karangwangun
32.09.06.2006|Tambelang
32.09.06.2011|Karangsuwung
32.09.06.2012|Karangtengah
32.09.06.2013|Kalimeang
32.09.06.2014|Karangmalang
32.09.06.2015|Karangmekar
32.09.06.2016|Kubangkarang
32.09.06.2017|Karangsembung
32.09.07.2001|Leuwidingding
32.09.07.2002|Asem
32.09.07.2003|Cipeujeuh Kulon
32.09.07.2004|Cipeujeuh Wetan
32.09.07.2005|Sindanglaut
32.09.07.2006|Lemahabang Kulon
32.09.07.2007|Lemahabang
32.09.07.2008|Sigong
32.09.07.2009|Sarajaya
32.09.07.2010|Picungpugur
32.09.07.2011|Tuk Karangsuwung
32.09.07.2012|Belawa
32.09.07.2013|Wangkelang
32.09.08.2001|Karangamangu
32.09.08.2002|Susukan Lebak
32.09.08.2003|Susukan Agung
32.09.08.2004|Susukan Tonggoh
32.09.08.2005|Wilulang
32.09.08.2006|Sampih
32.09.08.2007|Pasawahan
32.09.08.2008|Ciawiasih
32.09.08.2009|Ciawijapura
32.09.08.2010|Curug
32.09.08.2011|Curug Wetan
32.09.08.2012|Kaligawe Wetan
32.09.08.2013|Kaligawe
32.09.09.2001|Karangwuni
32.09.09.2002|Sedong Kidul
32.09.09.2003|Sedong Lor
32.09.09.2004|Windujaya
32.09.09.2005|Winduhaji
32.09.09.2006|Kertawangun
32.09.09.2007|Panambangan
32.09.09.2008|Putat
32.09.09.2009|Panongan
32.09.09.2010|Panongan Lor
32.09.10.2004|Munjul
32.09.10.2005|Sidamulya
32.09.10.2006|Mertapada Kulon
32.09.10.2007|Mertapada Wetan
32.09.10.2008|Buntet
32.09.10.2009|Kanci Kulon
32.09.10.2010|Kanci
32.09.10.2011|Astanajapura
32.09.10.2012|Kendal
32.09.10.2013|Japura Kidul
32.09.10.2014|Japurabakti
32.09.11.2001|Getrakmoyan
32.09.11.2002|Ender
32.09.11.2003|Pangenan
32.09.11.2004|Bendungan
32.09.11.2005|Rawaurip
32.09.11.2006|Beringin
32.09.11.2007|Japura Lor
32.09.11.2008|Pengarengan
32.09.11.2009|Astanamukti
32.09.12.2001|Setupatok
32.09.12.2002|Penpen
32.09.12.2003|Mundu Mesigit
32.09.12.2004|Luwung
32.09.12.2005|Waruduwur
32.09.12.2006|Citemu
32.09.12.2007|Bandengan
32.09.12.2008|Mundu Pesisir
32.09.12.2009|Suci
32.09.12.2010|Banjarwangunan
32.09.12.2011|Pamengkang
32.09.12.2012|Sinarancang
32.09.13.2001|Wanayasa
32.09.13.2002|Sindangkasih
32.09.13.2003|Sindanghayu
32.09.13.2004|Ciawigajah
32.09.13.2008|Cikancas
32.09.13.2009|Halimpu
32.09.13.2010|Cipinang
32.09.13.2011|Beber
32.09.13.2012|Patapan
32.09.13.2013|Kondangsari
32.09.14.2001|Sampiran
32.09.14.2002|Ciperna
32.09.14.2003|Kecomberan
32.09.14.2004|Cirebon Girang
32.09.14.2005|Kerandon
32.09.14.2006|Wanasaba Kidul
32.09.14.2007|Wanasaba Lor
32.09.14.2008|Cempaka
32.09.14.2009|Kepongpongan
32.09.14.2010|Sarwadadi
32.09.14.2011|Kubang
32.09.15.1003|Babakan
32.09.15.1004|Sumber
32.09.15.1005|Perbutulan
32.09.15.1006|Kaliwadas
32.09.15.1007|Pasalakan
32.09.15.1008|Watubelah
32.09.15.1009|Pejambon
32.09.15.1010|Gegunung
32.09.15.1011|Kemantren
32.09.15.1012|Sendang
32.09.15.1013|Tukmudal
32.09.15.1014|Kenanga
32.09.15.2001|Matangaji
32.09.15.2002|Sidawangi
32.09.16.2001|Bobos
32.09.16.2002|Cikalahang
32.09.16.2003|Mandala
32.09.16.2004|Dukupuntang
32.09.16.2005|Balad
32.09.16.2006|Cangkoak
32.09.16.2007|Cisaat
32.09.16.2008|Sindangmekar
32.09.16.2009|Sindangjawa
32.09.16.2010|Kepunduan
32.09.16.2011|Girinata
32.09.16.2012|Cipanas
32.09.16.2013|Kedongdong Kidul
32.09.17.2002|Cilukrak
32.09.17.2003|Kepuh
32.09.17.2004|Balerante
32.09.17.2005|Panongan
32.09.17.2006|Beberan
32.09.17.2007|Semplo
32.09.17.2008|Palimanan Timur
32.09.17.2011|Pegagan
32.09.17.2012|Lungbenda
32.09.17.2013|Ciawi
32.09.17.2014|Tegalkarang
32.09.17.2015|Cengkuang
32.09.18.2001|Cempaka
32.09.18.2002|Pamijahan
32.09.18.2003|Lurah
32.09.18.2004|Marikangen
32.09.18.2005|Bode Lor
32.09.18.2006|Bodesari
32.09.18.2007|Gombang
32.09.18.2008|Karangmulya
32.09.18.2009|Karangasem
32.09.18.2010|Plumbon
32.09.18.2011|Purbawinangun
32.09.18.2012|Kebarepan
32.09.18.2013|Pasanggrahan
32.09.18.2014|Kedungsana
32.09.18.2015|Danamulya
32.09.19.2001|Karangsari
32.09.19.2002|Kertasari
32.09.19.2003|Megu Gede
32.09.19.2004|Megu Cilik
32.09.19.2005|Setu Wetan
32.09.19.2006|Setu Kulon
32.09.19.2007|Weru Kidul
32.09.19.2008|Weru Lor
32.09.19.2009|Tegalwangi
32.09.20.2004|Kedungdawa
32.09.20.2005|Kalikoa
32.09.20.2006|Tuk
32.09.20.2007|Kedungjaya
32.09.20.2008|Kedawung
32.09.20.2009|Kertawinangun
32.09.20.2010|Sutawinangun
32.09.20.2011|Pilangsari
32.09.21.2001|Adidharma
32.09.21.2002|Pasindangan
32.09.21.2003|Jadimulya
32.09.21.2004|Klayan
32.09.21.2005|Jatimerta
32.09.21.2006|Astana
32.09.21.2007|Kalisapu
32.09.21.2008|Wanakaya
32.09.21.2009|Grogol
32.09.21.2010|Babadan
32.09.21.2011|Buyut
32.09.21.2012|Mayung
32.09.21.2015|Mertasinga
32.09.21.2016|Sambeng
32.09.21.2017|Sirnabaya
32.09.22.2010|Kertasura
32.09.22.2011|Pegagan Kidul
32.09.22.2012|Pegagan Lor
32.09.22.2013|Dukuh
32.09.22.2014|Karangkendal
32.09.22.2015|Grogol
32.09.22.2016|Kapetakan
32.09.22.2017|Bungko
32.09.22.2018|Bungko Lor
32.09.23.2001|Serang
32.09.23.2002|Klangenan
32.09.23.2003|Danawinangun
32.09.23.2007|Pekantingan
32.09.23.2008|Jemaras Kidul
32.09.23.2009|Jemaras Lor
32.09.23.2010|Slangit
32.09.23.2011|Kreyo
32.09.23.2012|Bangodua
32.09.24.2001|Sende
32.09.24.2002|Jungjang Wetan
32.09.24.2003|Jungjang
32.09.24.2004|Arjawinangun
32.09.24.2005|Tegalgubug
32.09.24.2006|Tegalgubug Lor
32.09.24.2007|Rawagatel
32.09.24.2008|Karangsambung
32.09.24.2009|Bulak
32.09.24.2010|Geyongan
32.09.24.2011|Kebonturi
32.09.25.2001|Kalianyar
32.09.25.2002|Pangurangan Kulon
32.09.25.2003|Pangurangan Wetan
32.09.25.2004|Pangurangan Lor
32.09.25.2005|Pangurangan
32.09.25.2006|Gujeg
32.09.25.2007|Lemahtamba
32.09.25.2008|Karanganyar
32.09.25.2009|Kroya
32.09.26.2004|Budur
32.09.26.2005|Babakan
32.09.26.2006|Ciwaringin
32.09.26.2007|Gintungranjeng
32.09.26.2008|Gintung Kidul
32.09.26.2009|Gintung Tengah
32.09.26.2010|Bringin
32.09.26.2011|Galagamba
32.09.27.2001|Tangkil
32.09.27.2002|Wiyong
32.09.27.2003|Kedongdong
32.09.27.2004|Gintung Lor
32.09.27.2005|Bojong Kulon
32.09.27.2006|Kejiwan
32.09.27.2007|Susukan
32.09.27.2008|Luwung Kencana
32.09.27.2009|Bunder
32.09.27.2010|Jatipura
32.09.27.2011|Ujunggebang
32.09.27.2012|Jatianom
32.09.28.2001|Kedungdalem
32.09.28.2002|Panunggul
32.09.28.2003|Gegesik Wetan
32.09.28.2004|Gegesik Kidul
32.09.28.2005|Gegesik Lor
32.09.28.2006|Gegesik Kulon
32.09.28.2007|Slendra
32.09.28.2008|Jagapura Kidul
32.09.28.2009|Jagapura Wetan
32.09.28.2010|Jagapura Kulon
32.09.28.2011|Jagapura Lor
32.09.28.2012|Sibubut
32.09.28.2013|Bayalangu Lor
32.09.28.2014|Bayalangu Kidul
32.09.29.2001|Kalideres
32.09.29.2002|Prajawinangun Kulon
32.09.29.2003|Prajawinangun Wetan
32.09.29.2004|Ujungsemi
32.09.29.2005|Wargabinangun
32.09.29.2006|Kaliwedi Lor
32.09.29.2007|Kaliwedi Kidul
32.09.29.2008|Guwa Kidul
32.09.29.2009|Guwa Lor
32.09.30.2001|Dompyong Kulon
32.09.30.2002|Dompyong Wetan
32.09.30.2003|Kalimekar
32.09.30.2004|Kalimaro
32.09.30.2005|Gagasari
32.09.30.2006|Kalipasung
32.09.30.2007|Gebang Kulon
32.09.30.2008|Gebang
32.09.30.2009|Gebang Ilir
32.09.30.2010|Gebang Udik
32.09.30.2011|Gebang Mekar
32.09.30.2012|Playangan
32.09.30.2013|Melakasari
32.09.31.2001|Cikeduk
32.09.31.2002|Warujaya
32.09.31.2003|Warukawung
32.09.31.2004|Warugede
32.09.31.2005|Waruroyom
32.09.31.2006|Depok
32.09.31.2007|Kasugengan Kidul
32.09.31.2008|Kasugengan Lor
32.09.31.2009|Keduanan
32.09.31.2010|Kejuden
32.09.31.2011|Getasan
32.09.31.2012|Karangwangi
32.09.32.2001|Tonjong
32.09.32.2002|Tanjunganom
32.09.32.2003|Cilengkrang Girang
32.09.32.2004|Cilengkrang
32.09.32.2005|Pasaleman
32.09.32.2006|Cigobangwangi
32.09.32.2007|Cigobang
32.09.33.2001|Sukadana
32.09.33.2002|Pabuaran Kidul
32.09.33.2003|Pabuaran Wetan
32.09.33.2004|Pabuaran Lor
32.09.33.2005|Jatirenggang
32.09.33.2006|Hulubanteng
32.09.33.2007|Hulubanteng Lor
32.09.34.2001|Seuseupan
32.09.34.2002|Blender
32.09.34.2003|Sumurkondang
32.09.34.2004|Kubangdeleg
32.09.34.2005|Jatipiring
32.09.34.2006|Karanganyar
32.09.34.2007|Karangwangi
32.09.34.2008|Karangwareng
32.09.34.2009|Karangasem
32.09.35.2001|Palir
32.09.35.2002|Astapada
32.09.35.2003|Gesik
32.09.35.2004|Kemlakagede
32.09.35.2005|Dawuan
32.09.35.2006|Battembat
32.09.35.2007|Kalibaru
32.09.35.2008|Kalitengah
32.09.36.2001|Tegalsari
32.09.36.2002|Kaliwulu
32.09.36.2003|Panembahan
32.09.36.2004|Trusmi Wetan
32.09.36.2005|Trusmi Kulon
32.09.36.2006|Wotgali
32.09.36.2007|Gamel
32.09.36.2008|Sarabau
32.09.36.2009|Cangkring
32.09.36.2010|Pangkalan
32.09.37.2001|Cikeusal
32.09.37.2002|Palimanan Barat
32.09.37.2003|Kedungbunder
32.09.37.2004|Cupang
32.09.37.2005|Gempol
32.09.37.2006|Walahar
32.09.37.2007|Kempek
32.09.37.2008|Winong
32.09.38.2001|Gumulung Lebak
32.09.38.2002|Lebak Mekar
32.09.38.2003|Gumulung Tonggoh
32.09.38.2004|Kamarang
32.09.38.2005|Greged
32.09.38.2006|Kamarang Lebak
32.09.38.2007|Durajaya
32.09.38.2008|Jatipancur
32.09.38.2009|Sindang Kempeng
32.09.38.2010|Nanggela
32.09.39.2003|Muara
32.09.39.2004|Purwawinangun
32.09.39.2005|Keraton
32.09.39.2006|Surakarta
32.09.39.2007|Karangreja
32.09.39.2008|Suranenggala Kidul
32.09.39.2009|Suranenggala Kulon
32.09.39.2010|Suranenggala Lor
32.09.39.2011|Suranenggala
32.09.40.2001|Jamblang
32.09.40.2002|Sitiwinangun
32.09.40.2003|Wangunharja
32.09.40.2004|Bojong Wetan
32.09.40.2005|Bojong Lor
32.09.40.2006|Orimalang
32.09.40.2007|Bakung Kidul
32.09.40.2008|Bakung Lor
32.10.01.2001|Cipasung
32.10.01.2002|Bangbayang
32.10.01.2003|Borogojol
32.10.01.2004|Cibulan
32.10.01.2005|Lemahputih
32.10.01.2006|Sadawangi
32.10.01.2007|Kepuh
32.10.01.2008|Padarek
32.10.01.2009|Kalapadua
32.10.01.2010|Cigaleuh
32.10.01.2011|Margajaya
32.10.01.2012|Sukajadi
32.10.01.2013|Mekarwangi
32.10.01.2014|Sinargalih
32.10.01.2015|Mekarmulya
32.10.01.2016|Sukamaju
32.10.01.2017|Cisalak
32.10.01.2018|Dayeuhwangi
32.10.01.2019|Lemahsugih
32.10.02.2002|Cipeundeuy
32.10.02.2008|Cimangguhilir
32.10.02.2009|Salawangi
32.10.02.2010|Bantarujeg
32.10.02.2011|Gununglarang
32.10.02.2012|Cikidang
32.10.02.2013|Cinambo
32.10.02.2014|Haurgeulis
32.10.02.2015|Sukamenak
32.10.02.2016|Wadowetan
32.10.02.2017|Babakansari
32.10.02.2018|Silihwangi
32.10.02.2022|Sindanghurip
32.10.03.2001|Sukasari
32.10.03.2002|Cisoka
32.10.03.2003|Sindangpanji
32.10.03.2004|Cikijing
32.10.03.2005|Sindang
32.10.03.2006|Banjaransari
32.10.03.2007|Kasturi
32.10.03.2008|Cidulang
32.10.03.2009|Jagasari
32.10.03.2010|Bagjasari
32.10.03.2011|Sunalari
32.10.03.2012|Cipulus
32.10.03.2013|Kancana
32.10.03.2014|Sukamukti
32.10.03.2015|Cilangcang
32.10.04.2001|Lampuyang
32.10.04.2002|Cibeureum
32.10.04.2003|Cikeusal
32.10.04.2004|Jatipamor
32.10.04.2005|Argasari
32.10.04.2006|Cicanir
32.10.04.2007|Campaga
32.10.04.2008|Sukaperna
32.10.04.2009|Talagakulon
32.10.04.2010|Talagawetan
32.10.04.2011|Ganeas
32.10.04.2012|Salado
32.10.04.2013|Gunungmanik
32.10.04.2014|Kertarahayu
32.10.04.2015|Mekarraharja
32.10.04.2016|Margamukti
32.10.04.2017|Mekarhurip
32.10.05.2001|Sagara
32.10.05.2002|Cibunut
32.10.05.2003|Tejamulya
32.10.05.2004|Sukasari Kaler
32.10.05.2005|Argamukti
32.10.05.2006|Sukadana
32.10.05.2007|Sadasari
32.10.05.2008|Haurseah
32.10.05.2009|Mekarwangi
32.10.05.2010|Cikaracak
32.10.05.2011|Heubeulisuk
32.10.05.2012|Sukasari Kidul
32.10.05.2013|Gunungwangi
32.10.05.2014|Argalingga
32.10.06.2001|Cihaur
32.10.06.2002|Wanahayu
32.10.06.2003|Cengal
32.10.06.2004|Anggrawati
32.10.06.2005|Cipicung
32.10.06.2006|Malongpong
32.10.06.2007|Tegalsari
32.10.06.2008|Maja Utara
32.10.06.2009|Pasanggrahan
32.10.06.2010|Cieurih
32.10.06.2011|Kertabasuki
32.10.06.2012|Sindangkerta
32.10.06.2013|Banjaran
32.10.06.2014|Paniis
32.10.06.2015|Cicalung
32.10.06.2016|Pageraji
32.10.06.2017|Maja Selatan
32.10.06.2018|Nunuk Baru
32.10.07.1001|Munjul
32.10.07.1002|Babakan Jawa
32.10.07.1003|Cicurug
32.10.07.1004|Sindangkasih
32.10.07.1007|Majalengka Wetan
32.10.07.1008|Majalengka Kulon
32.10.07.1009|Tarikolot
32.10.07.1010|Cikasarung
32.10.07.1011|Tonjong
32.10.07.1013|Cijati
32.10.07.2005|Kulur
32.10.07.2006|Kawunggirang
32.10.07.2012|Sidamukti
32.10.07.2014|Cibodas
32.10.08.2001|Ciomas
32.10.08.2002|Padahanten
32.10.08.2009|Sukahaji
32.10.08.2010|Salagedang
32.10.08.2011|Cikeusik
32.10.08.2012|Jayi
32.10.08.2013|Nanggewer
32.10.08.2014|Palabuan
32.10.08.2015|Cikoneng
32.10.08.2016|Babakanmanjeti
32.10.08.2017|Tanjungsari
32.10.08.2018|Cikalong
32.10.08.2019|Candrajaya
32.10.09.2001|Pajajar
32.10.09.2002|Teja
32.10.09.2003|Payung
32.10.09.2004|Babakankareo
32.10.09.2005|Sindangpano
32.10.09.2006|Sadomas
32.10.09.2007|Kumbung
32.10.09.2008|Rajagaluh Kidul
32.10.09.2009|Singawada
32.10.09.2010|Rajagaluh Lor
32.10.09.2011|Cipinang
32.10.09.2012|Cisetu
32.10.09.2013|Rajagaluh
32.10.10.2001|Parakan
32.10.10.2002|Patuanan
32.10.10.2003|Nanggerang
32.10.10.2004|Lame
32.10.10.2005|Mindi
32.10.10.2006|Rajawangi
32.10.10.2007|Leuwikujang
32.10.10.2008|Mirat
32.10.10.2009|Leuwimunding
32.10.10.2010|Ciparay
32.10.10.2011|Heuleut
32.10.10.2012|Karangasem
32.10.10.2013|Tanjungsari
32.10.10.2014|Parungjaya
32.10.11.2001|Burujul Kulon
32.10.11.2002|Burujul Wetan
32.10.11.2003|Cicadas
32.10.11.2004|Andir
32.10.11.2005|Sukaraja Wetan
32.10.11.2006|Pinangraja
32.10.11.2007|Cibentar
32.10.11.2008|Leuweunggede
32.10.11.2009|Cibolerang
32.10.11.2010|Sutawangi
32.10.11.2011|Jatisura
32.10.11.2012|Jatiwangi
32.10.11.2013|Loji
32.10.11.2014|Sukaraja Kulon
32.10.11.2015|Mekarsari
32.10.11.2016|Surawangi
32.10.12.2006|Gandu
32.10.12.2007|Dawuan
$wilayah$, E'\r?\n') as baris
  where baris <> ''
) as d
order by length(kode), kode
on conflict (kode) do update
  set nama = excluded.nama, tingkat = excluded.tingkat, induk_kode = excluded.induk_kode;
