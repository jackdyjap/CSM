-- Data wilayah Indonesia, versi RINGKAS untuk SQL Editor Supabase: bagian 5 dari 5.
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
73.04.10.2003|Bontomanai
73.04.10.2004|Bontotiro
73.04.10.2005|Loka
73.04.10.2006|Tompobulu
73.04.10.2007|Kassi
73.04.10.2008|Pallantikang
73.04.10.2009|Lebangmanai Utara
73.04.10.2010|Bontocini
73.04.10.2011|Janetallasa
73.04.10.2012|Ujung Bulu
73.04.11.2001|Pao
73.04.11.2002|Bontorappo
73.04.11.2003|Tarowang
73.04.11.2004|Allu Tarowang
73.04.11.2005|Balangbaru
73.04.11.2006|Balangloe Tarowang
73.04.11.2007|Bonto Ujung
73.04.11.2008|Tino
73.05.01.1001|Takalar
73.05.01.2003|Patani
73.05.01.2009|Soreang
73.05.01.2010|Pa'batangang
73.05.02.1002|Mangadu
73.05.02.2001|Lengkese
73.05.02.2003|Topejawa
73.05.02.2004|Lakatong
73.05.02.2007|Banggae
73.05.02.2008|Bontomanai
73.05.03.1001|Pa'bundukang
73.05.03.1002|Pattene
73.05.03.1003|Bontokadatto
73.05.03.1004|Canrego
73.05.03.1005|Bulukunyi
73.05.03.1010|Rajaya
73.05.03.2006|Moncongkomba
73.05.03.2007|Cakura
73.05.03.2008|Lantang
73.05.03.2009|Su'rulangi
73.05.03.2011|Kale Lantang
73.05.04.1001|Panrannuangku
73.05.04.1002|Manongkoki
73.05.04.1003|Malewang
73.05.04.1004|Palleko
73.05.04.1005|Mattompodale
73.05.04.1006|Parang Luara
73.05.04.2007|Lassang
73.05.04.2009|Pa'rappunganta
73.05.04.2010|Towata
73.05.04.2016|Lassang Barat
73.05.05.2006|Bonto Kanang
73.05.05.2007|Bontomarannu
73.05.05.2008|Mangindara
73.05.05.2009|Bontokassi
73.05.05.2011|Bentang
73.05.05.2012|Barangmamase
73.05.05.2013|Sawakong
73.05.05.2015|Popo
73.05.05.2016|Tarowang
73.05.05.2017|Kalukubodo
73.05.05.2018|Kadatong
73.05.05.2019|Kale Bentang
73.05.05.2020|Kanaeng
73.05.06.1004|Bontolebang
73.05.06.2001|Pakkabba
73.05.06.2002|Bontolanra
73.05.06.2003|Aeng Batu Batu
73.05.06.2005|Tamalate
73.05.06.2006|Tamasaju
73.05.06.2007|Bontosunggu
73.05.06.2010|Aeng Towa
73.05.06.2011|Bontokaddopepe
73.05.06.2012|Sampulungan
73.05.06.2013|Maccini Sombala
73.05.06.2014|Sawakung Beba
73.05.06.2015|Biring Kassi
73.05.06.2016|Kaballokang Pakkabba
73.05.07.1001|Pattallassang
73.05.07.1002|Pallantikang
73.05.07.1003|Somba Bella
73.05.07.1004|Kalabbirang
73.05.07.1005|Maradekaya
73.05.07.1006|Pappa
73.05.07.1007|Bajeng
73.05.07.1008|Sabintang
73.05.07.1009|Salaka
73.05.08.2001|Laguruda
73.05.08.2002|Banyuanyara
73.05.08.2003|Sanrobone
73.05.08.2004|Paddinging
73.05.08.2005|Ujung Baji
73.05.08.2006|Tonasa
73.05.09.2001|Galesong Baru
73.05.09.2002|Galesong Kota
73.05.09.2003|Bontoloe
73.05.09.2004|Boddia
73.05.09.2005|Bontomangape
73.05.09.2006|Parangmata
73.05.09.2007|Parambambe
73.05.09.2008|Pa'rasangang Beru
73.05.09.2009|Pa'lalakkang
73.05.09.2010|Pattinoang
73.05.09.2011|Kalenna Bontongape
73.05.09.2012|Kalukuang
73.05.09.2013|Mappakalompo
73.05.09.2014|Campagaya
73.05.09.2015|Galesong Timur
73.05.09.2016|Kampung Beru
73.05.09.2017|Tarembang
73.05.10.2001|Tompotana
73.05.10.2002|Mattiro Baji
73.05.10.2003|Rewataya
73.05.10.2004|Balangdatu
73.05.10.2005|Maccini Baji
73.05.10.2006|Minasa Baji
73.05.11.2001|Ko'mara
73.05.11.2002|Kale Ko'mara
73.05.11.2003|Barugaya
73.05.11.2004|Parang Baddo
73.05.11.2005|Massamaturu
73.05.11.2006|Timbuseng
73.05.11.2007|Balangtanaya
73.05.11.2008|Kampung Beru
73.05.12.2001|Panyangkalang
73.05.12.2002|Bontoparang
73.05.12.2003|Pattopakang
73.05.12.2004|Cikoang
73.05.12.2005|Punaga
73.05.12.2006|Laikang
73.06.01.1001|Bontonompo
73.06.01.1002|Tamallayang
73.06.01.1003|Kalaserena
73.06.01.2004|Bontolangkasa Utara
73.06.01.2005|Bontolangkasa Selatan
73.06.01.2006|Barembeng
73.06.01.2015|Manjapai
73.06.01.2016|Bontobiraeng
73.06.01.2017|Romanglasa
73.06.01.2018|Katangka
73.06.01.2019|Bulogading
73.06.01.2020|Bategulung
73.06.01.2021|Kalabarembeng
73.06.01.2022|Bontobiraeng Selatan
73.06.02.1001|Kalebajeng
73.06.02.1002|Limbung
73.06.02.1017|Tubajeng
73.06.02.1018|Mata Allo
73.06.02.2003|Bontosunggu
73.06.02.2006|Maccinibaji
73.06.02.2007|Pa'bentengang
73.06.02.2009|Tangkebajeng
73.06.02.2010|Maradekaya
73.06.02.2011|Panciro
73.06.02.2012|Lempangang
73.06.02.2013|Bone
73.06.02.2015|Pannyangkalang
73.06.02.2019|Paraikatte
73.06.03.1001|Malakaji
73.06.03.1002|Cikoro
73.06.03.2003|Garing
73.06.03.2004|Datara
73.06.03.2005|Rappolemba
73.06.03.2006|Rappoala
73.06.03.2007|Tanete
73.06.03.2008|Bontobuddung
73.06.04.1001|Malino
73.06.04.1002|Buluttana
73.06.04.1003|Gantarang
73.06.04.1010|Pattapang
73.06.04.1011|Bonto Lerung
73.06.04.1012|Garassi
73.06.04.2004|Parigi
73.06.05.1001|Lanna
73.06.05.1002|Bontoparang
73.06.05.2006|Lonjoboko
73.06.05.2008|Borisallo
73.06.05.2009|Belapunranga
73.06.05.2010|Bontokassi
73.06.05.2011|Belabori
73.06.06.1001|Borongloe
73.06.06.1002|Bontomanai
73.06.06.1012|Romang Lompoa
73.06.06.2003|Pakatto
73.06.06.2004|Nirannuang
73.06.06.2005|Romangloe
73.06.06.2006|Sokkolia
73.06.06.2013|Mata Allo
73.06.06.2014|Bili-bili
73.06.07.1001|Tetebatu
73.06.07.1002|Pangkabinanga
73.06.07.1003|Parangbanoa
73.06.07.1015|Mangalli
73.06.07.2004|Bontoala
73.06.07.2005|Pallangga
73.06.07.2006|Julubori
73.06.07.2007|Kampili
73.06.07.2008|Panakkukang
73.06.07.2009|Bontoramba
73.06.07.2010|Jene'tallasa
73.06.07.2011|Julukanaya
73.06.07.2012|Julupa'mai
73.06.07.2013|Bungaejaya
73.06.07.2014|Toddotoa
73.06.07.2016|Taeng
73.06.08.1001|Sungguminasa
73.06.08.1002|Bonto Bontoa
73.06.08.1003|Batangkaluku
73.06.08.1004|Tompobalang
73.06.08.1005|Samata
73.06.08.1006|Katangka
73.06.08.1007|Pandang Pandang
73.06.08.1008|Tombolo
73.06.08.1009|Kalegowa
73.06.08.1010|Romangpolong
73.06.08.1011|Paccinongang
73.06.08.1012|Tamarunang
73.06.08.1013|Bontoramba
73.06.08.1014|Mawang
73.06.09.1001|Sapaya
73.06.09.1010|Je'nebatu
73.06.09.2002|Bontomanai
73.06.09.2003|Buakkang
73.06.09.2004|Bissoloro
73.06.09.2011|Rannaloe
73.06.09.2012|Mangempang
73.06.10.1001|Tamaona
73.06.10.2002|Ta'binjai
73.06.10.2003|Erelembang
73.06.10.2004|Kanreapia
73.06.10.2005|Pao
73.06.10.2006|Balassuka
73.06.10.2007|Mamampang
73.06.10.2008|Tonasa
73.06.10.2009|Bolaromang
73.06.11.1002|Tonrorita
73.06.11.1004|Lauwa
73.06.11.2001|Taring
73.06.11.2003|Pencong
73.06.11.2005|Berutallasa
73.06.11.2006|Parangloe
73.06.11.2007|Baturappe
73.06.11.2008|Batumalonro
73.06.11.2009|Borimasunggu
73.06.11.2010|Lembangloe
73.06.11.2011|Julukanaya
73.06.12.1001|Benteng Somba Opu
73.06.12.1005|Lembang Parang
73.06.12.2002|Kanjilo
73.06.12.2003|Moncobalang
73.06.12.2004|Tinggimae
73.06.12.2006|Biringala
73.06.12.2007|Tamannyeleng
73.06.13.2001|Timbuseng
73.06.13.2002|Pallantikang
73.06.13.2003|Sunggumanai
73.06.13.2004|Paccellekang
73.06.13.2005|Pattallassang
73.06.13.2006|Je'nemadinging
73.06.13.2007|Panaikang
73.06.13.2008|Borongpala'la
73.06.14.2001|Manuju
73.06.14.2002|Pattallikang
73.06.14.2003|Tamalatea
73.06.14.2004|Moncongloe
73.06.14.2005|Bilalang
73.06.14.2006|Tassese
73.06.14.2007|Tana Karaeng
73.06.15.2001|Julumate'ne
73.06.15.2002|Bontolempangang
73.06.15.2003|Lassa-Lassa
73.06.15.2004|Bontoloe
73.06.15.2005|Pa'ladingang
73.06.15.2006|Paranglompoa
73.06.15.2007|Bontotangnga
73.06.15.2008|Ulujangang
73.06.16.1009|Bontoramba
73.06.16.2001|Sengka
73.06.16.2002|Tanrara
73.06.16.2003|Tindang
73.06.16.2004|Pa'bundukang
73.06.16.2005|Bontosunggu
73.06.16.2006|Salajangki
73.06.16.2007|Salajo
73.06.16.2008|Jipang
73.06.17.2001|Majannang
73.06.17.2002|Jonjo
73.06.17.2003|Manimbahoi
73.06.17.2004|Sicini
73.06.17.2005|Bilanrengi
73.06.18.2001|Borimatangkasa
73.06.18.2002|Mandalle
73.06.18.2003|Manjalling
73.06.18.2004|Gentungang
73.06.18.2005|Tanabangka
73.06.18.2006|Kalemandalle
73.06.18.2007|Bontomanai
73.07.01.1001|Tassililu
73.07.01.1002|Balakia
73.07.01.2003|Gunung Perak
73.07.01.2004|Arabika
73.07.01.2005|Bonto Salama
73.07.01.2006|Turungan Baji
73.07.01.2007|Barania
73.07.01.2008|Boto Lempangan
73.07.01.2009|Terasa
73.07.02.1001|Sangiaseri
73.07.02.2002|Puncak
73.07.02.2003|Songing
73.07.02.2004|Aska
73.07.02.2005|Talle
73.07.02.2006|Palae
73.07.02.2007|Bulu Kamase
73.07.02.2008|Palangka
73.07.02.2009|Polewali
73.07.02.2010|Gareccing
73.07.02.2011|Alenangka
73.07.03.1001|Samataring
73.07.03.2002|Sanjai
73.07.03.2003|Pattalassang
73.07.03.2004|Panaikang
73.07.03.2005|Saukang
73.07.03.2006|Kampala
73.07.03.2007|Lasiai
73.07.03.2008|Biroro
73.07.03.2009|Kaloling
73.07.03.2010|Pasimarannu
73.07.03.2011|Tongke-Tongke
73.07.03.2012|Salohe
73.07.03.2013|Bongki Lengkese
73.07.04.1001|Samaenre
73.07.04.2002|Mattunreng Tellue
73.07.04.2003|Kompang
73.07.04.2004|Baru
73.07.04.2005|Pattongko
73.07.04.2006|Saotengnga
73.07.04.2007|Saohiring
73.07.04.2008|Kanrung
73.07.04.2009|Saotanre
73.07.04.2010|Bonto
73.07.04.2011|Gantarang
73.07.05.1001|Biringere
73.07.05.1002|Lamatti Rilau
73.07.05.1003|Balangnipa
73.07.05.1004|Lappa
73.07.05.1005|Bongki
73.07.05.1006|Alehanuae
73.07.06.2001|Lamatti Riattang
73.07.06.2002|Lamatti Riaja
73.07.06.2003|Bulu Tellue
73.07.06.2004|Duampanuae
73.07.06.2005|Tompobulu
73.07.06.2006|Lamatti Riawang
73.07.06.2007|Lappacinrana
73.07.07.1001|Pasir Putih
73.07.07.2002|Batu Belerang
73.07.07.2003|Biji Nangka
73.07.07.2004|Barambang
73.07.07.2005|Bonto Sinala
73.07.07.2006|Kassi Buleng
73.07.07.2007|Bonto Katute
73.07.07.2008|Bonto Tengnga
73.07.08.1001|Mannanti
73.07.08.2002|Saotengah
73.07.08.2003|Kalobba
73.07.08.2004|Tellu Limpoe
73.07.08.2005|Massaile
73.07.08.2006|Lembang Lohe
73.07.08.2007|Pattongko
73.07.08.2008|Bua
73.07.08.2009|Suka Maju
73.07.08.2010|Erabaru
73.07.08.2011|Samaturue
73.07.09.2001|Pulau Harapan
73.07.09.2002|Pulau Buhung Pitue
73.07.09.2003|Pulau Padaelo
73.07.09.2004|Pulau Persatuan
73.08.01.1001|Kahu
73.08.01.2002|Watang Cani
73.08.01.2003|Pattuku
73.08.01.2004|Bontojai
73.08.01.2005|Bana
73.08.01.2006|Pammusureng
73.08.01.2007|Langi
73.08.01.2008|Ere Cinnong
73.08.01.2009|Bulu Sirua
73.08.01.2010|Lamoncong
73.08.01.2011|Mattirowalie
73.08.02.1001|Palattae
73.08.02.2002|Nusa
73.08.02.2003|Pasaka
73.08.02.2004|Labuaja
73.08.02.2005|Cakkela
73.08.02.2006|Balle
73.08.02.2007|Matajang
73.08.02.2008|Cenrana
73.08.02.2009|Sanrego
73.08.02.2010|Biru
73.08.02.2011|Palakka
73.08.02.2012|Tompong Patu
73.08.02.2013|Hulo
73.08.02.2014|Cammilo
73.08.02.2015|Carima
73.08.02.2016|Mattoanging
73.08.02.2017|Arallae
73.08.02.2018|Bonto Padang
73.08.02.2019|Lalepo
73.08.02.2020|Maggenrang
73.08.03.1001|Awang Tangka
73.08.03.2002|Raja
73.08.03.2003|Abbumpungeng
73.08.03.2004|Bulu Tanah
73.08.03.2005|Gona
73.08.03.2006|Buareng
73.08.03.2007|Polewali
73.08.03.2008|Padaelo
73.08.03.2009|Ancu
73.08.03.2010|Tarasu
73.08.03.2011|Lemo
73.08.03.2012|Kalero
73.08.03.2013|Lappabosse
73.08.03.2014|Waetuo
73.08.03.2015|Pude
73.08.03.2016|Angkue
73.08.03.2017|Massangkae
73.08.03.2018|Mallahae
73.08.04.1001|Pancaitana
73.08.04.2002|Malimongeng
73.08.04.2003|Manera
73.08.04.2004|Ulubalang
73.08.04.2005|Gattareng
73.08.04.2006|Bellu
73.08.04.2007|Tebba
73.08.04.2008|Mappatoba
73.08.05.2001|Bulu Bulu
73.08.05.2002|Gareccing
73.08.05.2003|Biccoing
73.08.05.2004|Ujunge
73.08.05.2005|Libureng
73.08.05.2006|Rappa
73.08.05.2007|Bacu
73.08.05.2008|Muara
73.08.05.2009|Bone Pute
73.08.05.2010|Padatuo
73.08.05.2011|Samaenre
73.08.06.1001|Tanah Batue
73.08.06.1010|Ceppaga
73.08.06.2002|Tompo Bulu
73.08.06.2003|Tappale
73.08.06.2004|Polewali
73.08.06.2005|Pitumpidange
73.08.06.2006|Bune
73.08.06.2007|Swadaya
73.08.06.2008|Binuang
73.08.06.2009|Mallinrung
73.08.06.2011|Baringeng
73.08.06.2012|Mario
73.08.06.2013|Wanuawaru
73.08.06.2014|Mattirowalie
73.08.06.2015|Poleonro
73.08.06.2016|Matirro Bulu
73.08.06.2017|Matirrodeceng
73.08.06.2018|Suwa
73.08.06.2019|Laburasseng
73.08.06.2020|Ponre Ponre
73.08.07.1001|Padaelo
73.08.07.2002|Mattirowalie
73.08.07.2003|Mario
73.08.07.2004|Ujung Salangketo
73.08.07.2005|Tellu Boccoe
73.08.07.2006|Mattampa Walie
73.08.07.2007|Ujung Tanah
73.08.07.2008|Sumaling
73.08.07.2009|Tellongeng
73.08.07.2010|Data
73.08.07.2011|Batu Gading
73.08.07.2012|Cege
73.08.07.2013|Kadai
73.08.07.2014|Lakukang
73.08.07.2015|Pattiro
73.08.07.2016|Lapasa
73.08.07.2017|Karella
73.08.07.2018|Lappa Upang
73.08.08.1001|Maroanging
73.08.08.2002|Pattiro Bajo
73.08.08.2003|Massenreng Pulu
73.08.08.2004|Tunreng Tellue
73.08.08.2005|Polewali
73.08.08.2006|Tadang Palie
73.08.08.2007|Cinnong
73.08.08.2008|Mallusetasi
73.08.08.2009|Pakkasalo
73.08.08.2010|Pattiro Sompe
73.08.08.2011|Ajang Pulu
73.08.08.2012|Sumpang Minangae
73.08.08.2013|Mabbiring
73.08.08.2014|Pasaka
73.08.08.2015|Kalibong
73.08.08.2016|Pattiro Riolo
73.08.08.2017|Letta Tanah
73.08.08.2018|Manajeng
73.08.08.2019|Bulie
73.08.08.2020|Balieng Toa
73.08.09.1006|Apala
73.08.09.2001|Bacu
73.08.09.2002|Lampoko
73.08.09.2003|Congko
73.08.09.2004|Wollangi
73.08.09.2005|Parippung
73.08.09.2007|Barebbo
73.08.09.2008|Kampuno
73.08.09.2009|Kading
73.08.09.2010|Kajaolaliddong
73.08.09.2011|Samaelo
73.08.09.2012|Corawali
73.08.09.2013|Talungeng
73.08.09.2014|Watu
73.08.09.2015|Cingkang
73.08.09.2016|Cinnong
73.08.09.2017|Cempaniga
73.08.09.2018|Sugiale
73.08.10.1001|Tanete
73.08.10.2002|Arasoe
73.08.10.2003|Tanete Harapan
73.08.10.2004|Lompu
73.08.10.2005|Walenreng
73.08.10.2006|Ajang Pulu
73.08.10.2007|Padang Loang
73.08.10.2008|Abbumpungeng
73.08.10.2009|Kawerang
73.08.10.2010|Awo
73.08.10.2011|Kanco
73.08.10.2012|Cinennung
73.08.11.2001|Mappesangka
73.08.11.2002|Salebba
73.08.11.2003|Mattampae
73.08.11.2004|Pattimpa
73.08.11.2005|Tellu Boccoe
73.08.11.2006|Turu Adae
73.08.11.2007|Salampe
73.08.11.2008|Poleonro
73.08.11.2009|Bolli
73.08.12.2001|Mattampawalie
73.08.12.2002|Lili Riattang
73.08.12.2003|Sengeng Palie
73.08.12.2004|Tenri Pakkua
73.08.12.2005|Patangkai
73.08.12.2006|Ujung Lamuru
73.08.12.2007|Pattuku Limpoe
73.08.12.2008|Waekeccee
73.08.12.2009|Tonronge
73.08.13.1001|Lalebata
73.08.13.2002|Mattampa Walie
73.08.13.2003|Poleonro
73.08.13.2004|Sengeng Palie
73.08.13.2005|Mattampa Bulu
73.08.13.2006|Turu Cinnae
73.08.13.2007|Seberang
73.08.13.2008|Massenreng pulu
73.08.13.2009|Mamminasae
73.08.13.2010|Padaelo
73.08.13.2011|Barugae
73.08.13.2012|Barakkae
73.08.14.1001|Cinnong
73.08.14.2002|Lilina Ajangale
73.08.14.2003|Cani Sirenreng
73.08.14.2004|Ulaweng Cinnong
73.08.14.2005|Pallawarukka
73.08.14.2006|Jompie
73.08.14.2007|Sappewalie
73.08.14.2008|Lamakkaraseng
73.08.14.2009|Mula Menree
73.08.14.2010|Tea Musu
73.08.14.2011|Tea Malala
73.08.14.2012|Galung
73.08.14.2013|Tadang Palie
73.08.14.2014|Timusu
73.08.14.2015|Manurunge
73.08.15.2001|Cinenung
73.08.15.2002|Siame
73.08.15.2003|Pasempe
73.08.15.2004|Ureng
73.08.15.2005|Usa
73.08.15.2006|Mico
73.08.15.2007|Bainang
73.08.15.2008|Passippo
73.08.15.2009|Tanah Tengnga
73.08.15.2010|Tirong
73.08.15.2011|Mattanete Bua
73.08.15.2012|Maduri
73.08.15.2013|Melle
73.08.15.2014|Lemoape
73.08.15.2015|Panyili
73.08.16.1001|Maccope
73.08.16.2002|Carebbu
73.08.16.2003|Cumpiga
73.08.16.2004|Paccing
73.08.16.2005|Lattekko
73.08.16.2006|Matuju
73.08.16.2007|Unra
73.08.16.2008|Kading
73.08.16.2009|Mallari
73.08.16.2010|Kajuara
73.08.16.2011|Jaling
73.08.16.2012|Bulumpare'e
73.08.16.2013|Abbanuang
73.08.16.2014|Lappoase
73.08.16.2015|Awolagading
73.08.16.2016|Carigading
73.08.16.2017|Cakke Bone
73.08.16.2018|Mappalo Ulaweng
73.08.17.1001|Otting
73.08.17.1002|Tokaseng
73.08.17.2003|Palongki
73.08.17.2004|Tajong
73.08.17.2005|Ulo
73.08.17.2006|Lanca
73.08.17.2007|Itterung
73.08.17.2008|Mattoanging
73.08.17.2009|Lamuru
73.08.17.2010|Waji
73.08.17.2011|Ajjalireng
73.08.17.2012|Sijelling
73.08.17.2013|Lea
73.08.17.2014|Padaidi
73.08.17.2015|Pongka
73.08.17.2016|Lappae
73.08.17.2017|Patangnga
73.08.18.1001|Pompanua
73.08.18.1002|Pompanua Riattang
73.08.18.2003|Welado
73.08.18.2004|Pinceng Pute
73.08.18.2005|Opo
73.08.18.2006|Labissa
73.08.18.2007|Timurung
73.08.18.2008|Leppangeng
73.08.18.2009|Allamungeng Patue
73.08.18.2010|Amessangeng
73.08.18.2011|Lebbae
73.08.18.2012|Manciri
73.08.18.2013|Telle
73.08.18.2014|Pacciro
73.08.19.1001|Unyi
73.08.19.2002|Mario
73.08.19.2003|Laccori
73.08.19.2004|Pattiro
73.08.19.2005|Cabbeng
73.08.19.2006|Panyili
73.08.19.2007|Sanrangeng
73.08.19.2008|Sailong
73.08.19.2009|Melle
73.08.19.2010|Pakkasalo
73.08.19.2011|Tawaroe
73.08.19.2012|Uloe
73.08.19.2013|Ujung
73.08.19.2014|Padacenga
73.08.19.2015|Lallatang
73.08.19.2016|Kampoti
73.08.19.2017|Praja Maju
73.08.19.2018|Tocina
73.08.19.2019|Tempe
73.08.19.2020|Solo
73.08.19.2021|Watang Padacenga
73.08.19.2022|Matajang
73.08.20.1001|Cenrana
73.08.20.2002|Pacubbe
73.08.20.2003|Panyiwi
73.08.20.2004|Latonro
73.08.20.2005|Watu
73.08.20.2006|Nagauleng
73.08.20.2007|Cakkeware
73.08.20.2008|Pallime
73.08.20.2009|Laoni
73.08.20.2010|Labotto
73.08.20.2011|Awang Cenrana
73.08.20.2012|Labongnge
73.08.20.2013|Ajalasse
73.08.20.2014|Pusungnge
73.08.20.2015|Pallae
73.08.20.2016|Watang Ta
73.08.21.1001|Biru
73.08.21.1002|Ta
73.08.21.1003|Watampone
73.08.21.1004|Bukaka
73.08.21.1005|Pappolo
73.08.21.1006|Manurunge
73.08.21.1007|Walanae
73.08.21.1008|Masumpu
73.08.22.1001|Macege
73.08.22.1002|Matirro Walie
73.08.22.1003|Macanang
73.08.22.1004|Majang
73.08.22.1005|Bulu Tempe
73.08.22.1006|Jeppee
73.08.22.1007|Polewali
73.08.22.1008|Watang Palakka
73.08.23.1001|Bajoe
73.08.23.1002|Cellu
73.08.23.1003|Panyula
73.08.23.1004|Waetuo
73.08.23.1005|Palette
73.08.23.1006|Tipojong
73.08.23.1007|Toro
73.08.23.1008|Lonrae
73.08.24.1015|Mampotu
73.08.24.2001|Liliriattang
73.08.24.2002|Mattaropurae
73.08.24.2003|Ulaweng Riaja
73.08.24.2004|Waempubbu
73.08.24.2005|Waemputtange
73.08.24.2006|Amali Riattang
73.08.24.2007|Tassipi
73.08.24.2008|Wellulang
73.08.24.2009|Benteng Tellue
73.08.24.2010|Tacipong
73.08.24.2011|Laponrong
73.08.24.2012|Ajanglaleng
73.08.24.2013|Tocinnong
73.08.24.2014|Bila
73.08.25.2001|Tellang Kere
73.08.25.2002|Lagori
73.08.25.2003|Gaya Baru
73.08.25.2004|Tapong
73.08.25.2005|Sadar
73.08.25.2006|Tondong
73.08.25.2007|Samaenre
73.08.25.2008|Bonto Masunggu
73.08.25.2009|Pallawa
73.08.25.2010|Polewali
73.08.25.2011|Batu Putih
73.08.26.2001|Samaenre
73.08.26.2002|Tungke
73.08.26.2003|Selli
73.08.26.2004|Bengo
73.08.26.2005|Mattaropuli
73.08.26.2006|Lili Riawang
73.08.26.2007|Walimpong
73.08.26.2008|Bulu Allaporenge
73.08.26.2009|Mattirowalie
73.08.27.2001|Patimpeng
73.08.27.2002|Latellang
73.08.27.2003|Maddenreng Pulu
73.08.27.2004|Masago
73.08.27.2005|Batu Lappa
73.08.27.2006|Paccing
73.08.27.2007|Massila
73.08.27.2008|Talabangi
73.08.27.2009|Pationgi
73.08.27.2010|Bulu Ulaweng
73.09.01.1001|Hasanuddin
73.09.01.1002|Bontoa
73.09.01.2003|Tenrigangkae
73.09.01.2004|Pattontongang
73.09.01.2005|Bonto Mate'ne
73.09.01.2006|Baji Mangngai
73.09.02.1001|Cempaniga
73.09.02.1002|Mario Pulana
73.09.02.2003|Timpuseng
73.09.02.2004|Cenrana
73.09.02.2005|Sawaru
73.09.02.2006|Patanyamang
73.09.02.2007|Pattiro Deceng
73.09.02.2008|Benteng
73.09.03.1001|Kalabbirang
73.09.03.1002|Leang-Leang
73.09.03.2003|Alatengae
73.09.03.2004|Minasa Baji
73.09.03.2005|Tukamasea
73.09.03.2006|Mattoanging
73.09.03.2007|Mangeloreng
73.09.03.2008|Baruga
73.09.04.1001|Baji Pa'mai
73.09.04.1002|Pallantikang
73.09.04.1003|Baju Bodoa
73.09.04.2004|Borikamase
73.09.04.2005|Mattirotasi
73.09.04.2006|Majannang
73.09.04.2007|Borimasunggu
73.09.05.1001|Bontoa
73.09.05.2002|Pajjukukang
73.09.05.2003|Tunikamaseang
73.09.05.2004|Tupabbiring
73.09.05.2005|Botolempangang
73.09.05.2006|Salenrang
73.09.05.2007|Minasa Upa
73.09.05.2008|Ampekale
73.09.05.2009|Bonto Bahari
73.09.06.1001|Sabila
73.09.06.2002|Padaelo
73.09.06.2003|Batu Putih
73.09.06.2004|Wanua Waru
73.09.06.2005|Telumpanuae
73.09.06.2006|Samaenre
73.09.06.2007|Bentenge
73.09.06.2008|Mattampapole
73.09.06.2009|Uludaya
73.09.06.2010|Gattareng Matinggi
73.09.06.2011|Barugae
73.09.07.1001|Borong
73.09.07.2002|Allaere
73.09.07.2003|Toddopulia
73.09.07.2004|Kurusumange
73.09.07.2005|Lekopancing
73.09.07.2006|Damai
73.09.07.2007|Sudirman
73.09.07.2008|Purnakarya
73.09.08.2001|Temmapaduae
73.09.08.2002|Nisombalia
73.09.08.2003|Tellumpoccoe
73.09.08.2004|Ma'rumpa
73.09.08.2005|Bonto Mate'ne
73.09.08.2006|Abbulosibatang
73.09.08.2007|Pabbentengang
73.09.09.2001|Jenetaesa
73.09.09.2002|Bonto Tallasa
73.09.09.2003|Sambueja
73.09.09.2004|Tanete
73.09.09.2005|Samangki
73.09.09.2006|Simbang
73.09.10.2001|Laiya
73.09.10.2002|Labuaja
73.09.10.2003|Limampoccoe
73.09.10.2004|Lebbo Tengae
73.09.10.2005|Rompegading
73.09.10.2006|Baji pa'mai
73.09.10.2007|Cenrana Baru
73.09.11.2001|Tompobulu
73.09.11.2002|Benteng Gajah
73.09.11.2003|Bonto Manai
73.09.11.2004|Bonto Somba
73.09.11.2005|Toddolimae
73.09.11.2006|Pucak
73.09.11.2007|Bonto Matinggi
73.09.11.2008|Bonto Manurung
73.09.12.1001|Allepolea
73.09.12.1002|Maccini Baji
73.09.12.1003|Soreang
73.09.12.1004|Mattirodeceng
73.09.12.2005|Marannu
73.09.12.2006|Tengkuru
73.09.13.2001|Moncongloe
73.09.13.2002|Moncongloe Bulu
73.09.13.2003|Moncongloe Lappara
73.09.13.2004|Bonto Bunga
73.09.13.2005|Bonto Marannu
73.09.14.1001|Pettuadae
73.09.14.1002|Boribellayya
73.09.14.1003|Alliritengae
73.09.14.1004|Turikale
73.09.14.1005|Taroada
73.09.14.1006|Raya
73.09.14.1007|Adatongeng
73.10.01.1001|Sapuka
73.10.01.2002|Sabaru
73.10.01.2003|Balo Baloang
73.10.01.2004|Sabalana
73.10.01.2005|Tampaang
73.10.01.2006|Sailus
73.10.01.2007|Satanger
73.10.01.2008|Kapoposang Bali
73.10.01.2009|Poleonro
73.10.02.1001|Kalu-Kalukuang
73.10.02.2002|Pammas
73.10.02.2003|Sabaru
73.10.02.2004|Kanyurang
73.10.02.2005|Doang-Doangan Lompo
73.10.02.2006|Marasende
73.10.02.2007|Dewakang
73.10.03.1001|Mattiro Sompe
73.10.03.1016|Mattiro Bintang
73.10.03.2002|Mattiro Deceng
73.10.03.2003|Mattiro Langi
73.10.03.2009|Mattiro Matae
73.10.03.2010|Mattiro Ujung
73.10.03.2011|Mattiro Dolangeng
73.10.03.2013|Mattiro Bone
73.10.03.2015|Mattaro Adae
73.10.04.1001|Jagong
73.10.04.1002|Mappasaile
73.10.04.1003|Pabundukang
73.10.04.1004|Anrong Appaka
73.10.04.1005|Sibatua
73.10.04.1006|Padoang Doangan
73.10.04.1007|Tumampua
73.10.04.1008|Tekolabbua
73.10.04.1009|Bonto Perak
73.10.05.1001|Balleangin
73.10.05.1002|Balocci Baru
73.10.05.1003|Kassi
73.10.05.1004|Tonasa
73.10.05.2005|Tompo Bulu
73.10.06.1001|Bori Appaka
73.10.06.1002|Samalewa
73.10.06.1003|Sapanang
73.10.06.2004|Bowong Cindea
73.10.06.2005|Tabo-Tabo
73.10.06.2006|Mangilu
73.10.06.2007|Bulu Cindea
73.10.06.2008|Biring Ere
73.10.07.1001|Labakkang
73.10.07.1002|Mangallekana
73.10.07.1003|Pundata Baji
73.10.07.1004|Borimasunggu
73.10.07.2005|Patallassang
73.10.07.2006|Manakku
73.10.07.2007|Gentung
73.10.07.2008|Batara
73.10.07.2009|Taraweang
73.10.07.2010|Kanaungan
73.10.07.2011|Bonto Manai
73.10.07.2012|Kassiloe
73.10.07.2013|Bara Batu
73.10.08.1001|Bonto-Bonto
73.10.08.1002|Talaka
73.10.08.1003|Ma'rang
73.10.08.1004|Attang Salo
73.10.08.2005|Padang Lampe
73.10.08.2006|Tamangapa
73.10.08.2007|Pitusunggu
73.10.08.2008|Pitue
73.10.08.2009|Punranga
73.10.08.2010|Alesipitto
73.10.09.1001|Bonto Matene
73.10.09.1002|Segeri
73.10.09.1003|Bone
73.10.09.1004|Bawasalo
73.10.09.2005|Baring
73.10.09.2006|Parenreng
73.10.10.1001|Minasa Te'ne
73.10.10.1002|Kalabbirang
73.10.10.1003|Biraeng
73.10.10.1004|Bonto Kio
73.10.10.1005|Bontoa
73.10.10.1006|Bonto Langkasa
73.10.10.2007|Kabba
73.10.10.2008|Panaikang
73.10.11.2001|Benteng
73.10.11.2002|Manggalung
73.10.11.2003|Tamarupa
73.10.11.2004|Mandalle
73.10.11.2005|Boddie
73.10.11.2006|Coppo Tompong
73.10.12.2001|Bantimurung
73.10.12.2002|Tondongkura
73.10.12.2003|Lanne
73.10.12.2004|Bulu Tellue
73.10.12.2005|Malaka
73.10.12.2006|Bonto Birao
73.10.13.2001|Mattiro Kanja
73.10.13.2002|Mattiro Baji
73.10.13.2003|Mattiro Bulu
73.10.13.2004|Mattiro Bombang
73.10.13.2005|Mattiro Labangeng
73.10.13.2006|Mattiro Uleng
73.10.13.2007|Mattiro Walie
73.11.01.1001|Lompo Riaja
73.11.01.2002|Harapan
73.11.01.2003|Lompo Tengah
73.11.01.2004|Kading
73.11.01.2005|Libureng
73.11.01.2006|Mattirowalie
73.11.01.2007|Lempang
73.11.02.1001|Lalolang
73.11.02.1002|Tanete
73.11.02.2003|Pancana
73.11.02.2004|Lalabata
73.11.02.2005|Corawali
73.11.02.2006|Pao Pao
73.11.02.2007|Tellumpanua
73.11.02.2008|Lipukasi
73.11.02.2009|Garessi
73.11.02.2010|Lasitae
73.11.03.1001|Coppo
73.11.03.1002|Mangempang
73.11.03.1003|Sumpang Binangae
73.11.03.1004|Sepee
73.11.03.1005|Tuwung
73.11.03.2006|Palakka
73.11.03.2007|Tompo
73.11.03.2008|Anabanua
73.11.03.2009|Galung
73.11.03.2010|Siawung
73.11.04.1001|Kiru Kiru
73.11.04.1002|Mangkoso
73.11.04.2003|Lawallu
73.11.04.2004|Paccekke
73.11.04.2005|Ajakkang
73.11.04.2006|Siddo
73.11.04.2007|Batupute
73.11.05.1001|Palanro
73.11.05.1002|Mallawa
73.11.05.1003|Bojo Baru
73.11.05.2004|Cilellang
73.11.05.2005|Manuba
73.11.05.2006|Nepo
73.11.05.2007|Kupa
73.11.05.2008|Bojo
73.11.06.1007|Mattappawalie
73.11.06.2001|Pujananting
73.11.06.2002|Gattareng
73.11.06.2003|Pattappa
73.11.06.2004|Jangan Jangan
73.11.06.2005|Bulo Bulo
73.11.06.2006|Bacu Bacu
73.11.07.1001|Takkalasi
73.11.07.2002|Balusu
73.11.07.2003|Lampoko
73.11.07.2004|Kamiri
73.11.07.2005|Madello
73.11.07.2006|Binuang
73.12.01.1001|Labessi
73.12.01.1002|Tettikenrarae
73.12.01.2003|Gattareng
73.12.01.2004|Watu
73.12.01.2005|Goarie
73.12.01.2006|Barae
73.12.01.2007|Marioriaja
73.12.01.2008|Marioritengnga
73.12.01.2009|Mariorilau
73.12.01.2010|Watu Toa
73.12.01.2011|Congko
73.12.01.2012|Gattareng Toa
73.12.01.2013|Soga
73.12.02.1001|Appanang
73.12.02.1002|Jennae
73.12.02.1003|Galung
73.12.02.2005|Jampu
73.12.02.2006|Pattojo
73.12.02.2009|Timusu
73.12.02.2010|Rompegading
73.12.02.2011|Barang
73.12.03.1001|Ujung
73.12.03.1002|Cabenge
73.12.03.1003|Pajalesang
73.12.03.1004|Macanre
73.12.03.2005|Abbanuange
73.12.03.2006|Tetewatu
73.12.03.2007|Baringeng
73.12.03.2009|Masing
73.12.03.2010|Kebo
73.12.03.2011|Parenring
73.12.03.2012|Paroto
73.12.03.2013|Palangiseng
73.12.04.1001|Lalabata Rilau
73.12.04.1002|Ompo
73.12.04.1003|Botto
73.12.04.1004|Lemba
73.12.04.1005|Bila
73.12.04.1006|Lapajung
73.12.04.1007|Salokaraja
73.12.04.2008|Maccile
73.12.04.2009|Umpungeng
73.12.04.2010|Mattabulu
73.12.05.1001|Batu Batu
73.12.05.1002|Kaca
73.12.05.1003|Attang Salo
73.12.05.1004|Manorang Salo
73.12.05.1005|Limpomajang
73.12.05.2006|Bulue
73.12.05.2007|Panincong
73.12.05.2008|Patampanua
73.12.05.2009|Tellulimpoe
73.12.05.2010|Laringgi
73.12.06.2002|Donri Donri
73.12.06.2003|Lalabatariaja
73.12.06.2004|Leworeng
73.12.06.2005|Labokong
73.12.06.2006|Sering
73.12.06.2007|Pesse
73.12.06.2008|Tottong
73.12.06.2009|Kessing
73.12.06.2010|Pising
73.12.07.2001|Belo
73.12.07.2002|Ganra
73.12.07.2003|Lompulle
73.12.07.2004|Enrekeng
73.12.08.2001|Citta
73.12.08.2002|Kampiri
73.12.08.2003|Labae
73.12.08.2004|Tinco
73.13.01.1001|Walennae
73.13.01.1002|Tolotenreng
73.13.01.1003|Sompe
73.13.01.2004|Liu
73.13.01.2005|Ugi
73.13.01.2006|Ujungpero
73.13.01.2007|Wage
73.13.01.2008|Worongnge
73.13.01.2009|Salotengnga
73.13.01.2010|Pallimae
73.13.01.2011|Mallusesalo
73.13.01.2012|Pasaka
73.13.01.2013|Tadangpalie
73.13.01.2014|Benteng Lompoe
73.13.01.2015|Bila
73.13.02.1001|Pammana
73.13.02.1002|Cina
73.13.02.2003|Lempa
73.13.02.2004|Patila
73.13.02.2005|Kampiri
73.13.02.2006|Lapaukke
73.13.02.2007|Lagosi
73.13.02.2008|Pallawarukka
73.13.02.2009|Wecudai
73.13.02.2010|Lampulung
73.13.02.2011|Watampanua
73.13.02.2012|Tadangpalie
73.13.02.2013|Simpursia
73.13.02.2014|Tobatang
73.13.02.2015|Abbanuangnge
73.13.02.2016|Tonrong Tengnga
73.13.03.1001|Peneki
73.13.03.1002|Bocco
73.13.03.2003|Parigi
73.13.03.2004|Manyili
73.13.03.2005|Soro
73.13.03.2006|Ceppaga
73.13.03.2007|Leweng
73.13.03.2008|Ajuraja
73.13.03.2009|Botto
73.13.03.2010|Lagoari
73.13.03.2011|Aluppang
73.13.03.2012|Lamarua
73.13.03.2013|Pantai Timur
73.13.04.1001|Akkajeng
73.13.04.1002|Assorajang
73.13.04.1003|Minangae
73.13.04.2004|Akkotengeng
73.13.04.2005|Sakkoli
73.13.04.2006|Barangmamase
73.13.04.2007|Salobulo
73.13.04.2008|Towalida
73.13.04.2009|Alewadeng
73.13.05.1001|Paria
73.13.05.1002|Limpomajang
73.13.05.1003|Macanang
73.13.05.1004|Uraiyang
73.13.05.2005|Tosora
73.13.05.2006|Cinnong Tabi
73.13.05.2007|Rumpia
73.13.05.2008|Laerung
73.13.05.2009|Lamiku
73.13.05.2010|Bottobenteng
73.13.05.2011|Bottotanre
73.13.05.2012|Tua
73.13.05.2013|Tajo
73.13.05.2014|Tengnga
73.13.05.2015|Liu
73.13.05.2016|Tellulimpoe
73.13.05.2017|Bottopenno
73.13.05.2018|Watanrumpia
73.13.06.1001|Siengkang
73.13.06.1002|Pattirosompe
73.13.06.1003|Tempe
73.13.06.1004|Maddukelleng
73.13.06.1005|Watallipue
73.13.06.1006|Mattiro Tappareng
73.13.06.1007|Laelo
73.13.06.1008|Salo Menraleng
73.13.06.1009|Campalagi
73.13.06.1010|Lapongkoda
73.13.06.1011|Teddaopu
73.13.06.1012|Paddupa
73.13.06.1013|Wiring Palenae
73.13.06.1014|Attakkae
73.13.06.1015|Sitampae
73.13.06.1016|Bulu Pabbulu
73.13.07.1001|Macero
73.13.07.1002|Malangke
73.13.07.1003|Belawa
73.13.07.2004|Ongkoe
73.13.07.2005|Leppangeng
73.13.07.2006|Wele
73.13.07.2007|Limporilau
73.13.07.2008|Sappa
73.13.07.2009|Lautang
73.13.08.1001|Tancung
73.13.08.1002|Mappadaelo
73.13.08.1003|Pincengpute
73.13.08.1004|Barutancung
73.13.08.2005|Nepo
73.13.08.2006|Lowa
73.13.08.2007|Inalipue
73.13.08.2008|Pakkana
73.13.08.2009|Wajoriaja
73.13.08.2010|Wewangrewu
73.13.08.2011|Wae Tuwo
73.13.08.2012|Assorajang
73.13.08.2013|Ujungnge
73.13.08.2014|Pajalele
73.13.08.2015|Mario
73.13.08.2016|Palippu
73.13.08.2017|Tonralipue
73.13.08.2018|Ujungbaru
73.13.08.2019|Mannagae
73.13.09.1001|Anabanua
73.13.09.1002|Dualimpoe
73.13.09.1003|Tangkoli
73.13.09.2004|Mattirowalie
73.13.09.2005|Kalola
73.13.09.2006|Sogi
73.13.09.2007|Abbanuangnge
73.13.09.2008|Minagatellue
73.13.10.1001|Bulete
73.13.10.1002|Siwa
73.13.10.1003|Tobarakka
73.13.10.1004|Benteng
73.13.10.2005|Batu
73.13.10.2006|Lauwa
73.13.10.2007|Tanrongi
73.13.10.2008|Lompoloang
73.13.10.2009|Tellesang
73.13.10.2010|Tangkoro
73.13.10.2011|Marannu
73.13.10.2012|Abbanderangnge
73.13.10.2013|Simpellu
73.13.10.2014|Alesilurengnge
73.13.10.2015|Jauh Pandang
73.13.10.2016|Lacinde
73.13.10.2017|Buriko
73.13.10.2018|Bau-Bau
73.13.10.2019|Ale Lebbae
73.13.10.2020|Bulu Siwa
73.13.10.2021|Botto Tengnga
73.13.10.2022|Kaluku
73.13.10.2023|Mattiro Walie
73.13.10.2024|Maccolli Loloe
73.13.10.2025|Lompo Bulo
73.13.10.2026|Padang Loang
73.13.10.2027|Kompong
73.13.11.1001|Solo
73.13.11.2002|Bola
73.13.11.2003|Ujungtanah
73.13.11.2004|Lempong
73.13.11.2005|Sanreseng Ade
73.13.11.2006|Pattangngae
73.13.11.2007|Balielo
73.13.11.2008|Manurung
73.13.11.2009|Lattimu
73.13.11.2010|Pasir Putih
73.13.11.2011|Rajamawellang
73.13.12.1001|Doping
73.13.12.2002|Padaelo
73.13.12.2003|Temmabarang
73.13.12.2004|Penrang
73.13.12.2005|Lawesso
73.13.12.2006|Benteng
73.13.12.2007|Walanga
73.13.12.2008|Makmur
73.13.12.2009|Tadangpalie
73.13.12.2010|Raddae
73.13.13.1002|Gilireng
73.13.13.2001|Mamminasae
73.13.13.2003|Poleonro
73.13.13.2004|Arajang
73.13.13.2005|Lamata
73.13.13.2006|Paselloreng
73.13.13.2007|Alausalo
73.13.13.2008|Polewalie
73.13.13.2009|Abbatireng
73.13.14.1001|Ballaere
73.13.14.2002|Awota
73.13.14.2003|Keera
73.13.14.2004|Lalliseng
73.13.14.2005|Paojepe
73.13.14.2006|Inrello
73.13.14.2007|Pattirolokka
73.13.14.2008|Awo
73.13.14.2009|Ciromanie
73.13.14.2010|Labawang
73.14.01.1001|Bilokka
73.14.01.1002|Wette'E
73.14.01.1003|Lajonga
73.14.01.2004|Wanio
73.14.01.2005|Wanio Timoreng
73.14.01.2006|Corawali
73.14.01.2007|Lise
73.14.01.2008|Bapangi
73.14.01.2009|Alesalewo
73.14.01.2010|Cenrana
73.14.02.1001|Amparita
73.14.02.1002|Massepe
73.14.02.1003|Toddang Pulu
73.14.02.1004|Pajalele
73.14.02.1005|Baula
73.14.02.1006|Arateng
73.14.02.2007|Teteaji
73.14.02.2008|Polewali
73.14.02.2009|Teppo
73.14.03.1001|Lawawoi
73.14.03.1002|Arawa
73.14.03.1003|Bangkai
73.14.03.1004|Uluale
73.14.03.1005|Batu Lappa
73.14.03.2006|Lainungan
73.14.03.2007|Carawali
73.14.03.2008|Buae
73.14.03.2009|Mattirotasi
73.14.03.2010|Ciro-Ciroe
73.14.04.1001|Baranti
73.14.04.1002|Duampanua
73.14.04.1003|Benteng
73.14.04.1004|Manisa
73.14.04.1005|Panreng
73.14.04.2006|Passeno
73.14.04.2007|Sipodeceng
73.14.04.2008|Tonrongnge
73.14.04.2009|Tonrong Rijang
73.14.05.1001|Rappang
73.14.05.1002|Lalebata
73.14.05.1003|Maccorawalie
73.14.05.1004|Kadidi
73.14.05.2005|Timoreng Panua
73.14.05.2006|Bulo Wattang
73.14.05.2007|Bulo
73.14.05.2008|Cipotakari
73.14.06.2001|Rijang Panua
73.14.06.2002|Kulo
73.14.06.2003|Maddenra
73.14.06.2004|Mario
73.14.06.2005|Bina Baru
73.14.06.2006|Abbokongang
73.14.07.1001|Pangkajene
73.14.07.1002|Lautang Benteng
73.14.07.1003|Majjelling
73.14.07.1004|Wala
73.14.07.1005|Lakessi
73.14.07.1006|Rijang Pittu
73.14.07.1007|Majjelling Watang
73.14.07.2008|Sereang
73.14.07.2009|Kanie
73.14.07.2010|Allakuang
73.14.07.2011|Tanete
73.14.07.2012|Takkalasi
73.14.08.1001|Empagae
73.14.08.1002|Sidenreng
73.14.08.1003|Kanyuara
73.14.08.2004|Mojong
73.14.08.2005|Damai
73.14.08.2006|Talumae
73.14.08.2007|Aka-akae
73.14.08.2008|Talawe
73.14.09.1001|Tanru Tedong
73.14.09.1002|Salomalori
73.14.09.2003|Kalosi
73.14.09.2004|Padangloang
73.14.09.2005|Kalosi Alau
73.14.09.2006|Bila
73.14.09.2007|Padangloang Alau
73.14.09.2008|Salobukkang
73.14.09.2009|Taccimpo
73.14.09.2010|Kampale
73.14.10.1001|Lancirang
73.14.10.1002|PongrangaE
73.14.10.2003|Ajubissue
73.14.10.2004|Otting
73.14.10.2005|Bulucenrana
73.14.10.2006|Betao
73.14.10.2007|Anabannae
73.14.10.2008|Betao Riase
73.14.10.2009|Dongi
73.14.10.2010|Lasiwala
73.14.10.2011|Sumpang Mango
73.14.10.2012|Kalempang
73.14.11.1001|Batu
73.14.11.2002|Compong
73.14.11.2003|Belawae
73.14.11.2004|Botto
73.14.11.2005|Bila Riase
73.14.11.2006|Bola Bulu
73.14.11.2007|Tana Toro
73.14.11.2008|Lombo
73.14.11.2009|Lagading
73.14.11.2010|Dengeng-Dengeng
73.14.11.2011|Buntu Buangin
73.14.11.2012|Leppangeng
73.15.01.1001|Langnga
73.15.01.1002|Pallameang
73.15.01.2003|Massulowalie
73.15.01.2004|Mattombong
73.15.01.2005|Mattongang Tongang
73.15.01.2006|Patobong
73.15.01.2007|Samaenre
73.15.01.2008|Mattiro Tasi
73.15.01.2009|Siwolong Polong
73.15.02.1001|Watang Suppa
73.15.02.1002|Tellumpanua
73.15.02.2003|Lero
73.15.02.2004|Watang Pulu
73.15.02.2005|Maritengngae
73.15.02.2006|Tasiwalie
73.15.02.2007|Wiring Tasi
73.15.02.2008|Lotang Salo
73.15.02.2009|Ujung Labuang
73.15.02.2010|Polewali
73.15.03.1001|Manarang
73.15.03.1002|Padaidi
73.15.03.2003|Pananrang
73.15.03.2004|Padakkalawa
73.15.03.2005|Marannu
73.15.03.2006|Alitta
73.15.03.2007|Padaelo
73.15.03.2008|Bunga
73.15.03.2009|Makkawaru
73.15.04.1001|Jaya
73.15.04.1002|Sawitto
73.15.04.1003|Macorawalie
73.15.04.1004|Penrang
73.15.04.1005|Salo
73.15.04.1006|Bentengnge
73.15.04.1007|Sipatokkong
73.15.04.1008|Siparappe
73.15.05.1001|Benteng
73.15.05.1002|Teppo
73.15.05.1003|Tonyamang
73.15.05.1004|Maccirinna
73.15.05.2005|Leppangang
73.15.05.2006|Malimpung
73.15.05.2007|Mattiro Ade
73.15.05.2008|Sipatuo
73.15.05.2009|Padang Loang
73.15.05.2010|Pincara
73.15.05.2011|Masolo
73.15.06.1001|Pekkabata
73.15.06.1002|Tatae
73.15.06.1003|Lampa
73.15.06.1004|Data
73.15.06.1005|Bittoeng
73.15.06.2006|Kaballangang
73.15.06.2007|Paria
73.15.06.2008|Kaliang
73.15.06.2009|Buttu Sawe
73.15.06.2010|Maroneng
73.15.06.2011|Katomporang
73.15.06.2012|Bungi
73.15.06.2013|Massewae
73.15.06.2014|Bababinanga
73.15.06.2015|Barugae
73.15.07.1001|Tadokkong
73.15.07.1002|Betteng
73.15.07.2003|Binanga Karaeng
73.15.07.2004|Rajang
73.15.07.2005|Letta
73.15.07.2006|Ulu Saddang
73.15.07.2007|Suppirang
73.15.07.2008|Basseang
73.15.07.2009|Kariango
73.15.07.2010|Benteng Paremba
73.15.07.2011|Pakeng
73.15.07.2012|Lembang Mesakada
73.15.07.2013|Sali Sali
73.15.07.2014|Sabbang Paru
73.15.07.2015|Bakaru
73.15.07.2016|Pangaparang
73.15.08.1001|Cempa
73.15.08.2002|Mangki
73.15.08.2003|Mattunru Tunrue
73.15.08.2004|Sikkuale
73.15.08.2005|Tadang Palie
73.15.08.2006|Salipolo
73.15.08.2007|Tanra Tuo
73.15.09.1001|Pammase
73.15.09.1002|Marawi
73.15.09.1003|Fakkie
73.15.09.1004|Tiroang
73.15.09.1005|Mattiro Deceng
73.15.09.1006|Samaturue
73.15.10.1001|Lanrisang
73.15.10.2002|Samaulue
73.15.10.2003|Mallongi-longi
73.15.10.2004|Amassangang
73.15.10.2005|Barang Palie
73.15.10.2006|Waetuoe
73.15.10.2007|Lerang
73.15.11.1001|Pacongang
73.15.11.1002|Macinnae
73.15.11.1003|Temmassarangnge
73.15.11.1004|Mamminasae
73.15.11.1005|Laleng Bata
73.15.11.1006|Benteng Sawitto
73.15.12.1003|Kassa
73.15.12.2001|Batulappa
73.15.12.2004|Tapporang
73.15.12.2005|Kaseralau
73.15.12.2006|Watang Kassa
73.16.01.1001|Bangkala
73.16.01.2002|Pattondon Salu
73.16.01.2003|Tuncung
73.16.01.2004|Pasang
73.16.01.2005|Salodua
73.16.01.2006|Batu Mila
73.16.01.2007|Puncak Harapan
73.16.01.2008|Palakka
73.16.01.2009|Tapong
73.16.01.2010|Mangkawani
73.16.01.2011|Botto Malangga
73.16.01.2012|Boiya
73.16.01.2013|Matajang
73.16.01.2014|Baringin
73.16.01.2015|Lebani
73.16.01.2016|Limbuang
73.16.01.2017|Paladang
73.16.01.2018|Pariwang
73.16.01.2019|Kaluppang
73.16.01.2020|Ongko
73.16.01.2021|Tanete
73.16.01.2022|Labuku
73.16.02.1001|Galonta
73.16.02.1002|Juppandang
73.16.02.1003|Puserren
73.16.02.1004|Lewaja
73.16.02.1010|Leoran
73.16.02.1016|Tuara
73.16.02.2005|Ranga
73.16.02.2006|Buttu Batu
73.16.02.2007|Tokkonan
73.16.02.2008|Karueng
73.16.02.2011|Tallu Bamba
73.16.02.2012|Tungka
73.16.02.2013|Kaluppini
73.16.02.2014|Tobalu
73.16.02.2015|Cemba
73.16.02.2017|Temban
73.16.02.2018|Rosoan
73.16.02.2019|Lembang
73.16.03.1001|Baraka
73.16.03.1002|Tomenawa
73.16.03.1021|Balla
73.16.03.2003|Banti
73.16.03.2005|Bontongan
73.16.03.2006|Salukanan
73.16.03.2007|Parinding
73.16.03.2010|Tirowali
73.16.03.2011|Pepandungan
73.16.03.2012|Kendenan
73.16.03.2015|Perangian
73.16.03.2019|Janggurara
73.16.03.2020|Kadingeh
73.16.03.2022|Bonebone
73.16.03.2023|Pandung Batu
73.16.04.1001|Lakawan
73.16.04.1002|Tanete
73.16.04.1004|Mataran
73.16.04.2003|Bamba Puang
73.16.04.2005|Siambo
73.16.04.2006|Mampu
73.16.04.2007|Pekalobean
73.16.04.2008|Singki
73.16.04.2009|Salu Dewata
73.16.04.2010|Tindalun
73.16.04.2011|Bubun Lamba
73.16.04.2012|Tampo
73.16.04.2013|Batunoni
73.16.04.2014|Saruran
73.16.04.2015|Mendatte
73.16.05.1001|Kambiolangi
73.16.05.1002|Kalosi
73.16.05.1003|Buntu Sugi
73.16.05.2004|Mata Allo
73.16.05.2010|Sumillan
73.16.05.2011|Pana
73.16.05.2017|Taulo
73.16.05.2018|Bolang
73.16.06.2002|Bungin
73.16.06.2003|Talang Rilau
73.16.06.2004|Baruka
73.16.06.2008|Sawitto
73.16.06.2009|Bulo
73.16.06.2010|Banua
73.16.07.2001|Cendana
73.16.07.2002|Taulan
73.16.07.2003|Pinang
73.16.07.2004|Malalin
73.16.07.2005|Karrang
73.16.07.2006|Lebang
73.16.07.2007|Pundi Lemo
73.16.08.2001|Sangiepongan
73.16.08.2002|Buntu Barana
73.16.08.2003|Buntu Pema
73.16.08.2004|Parombean
73.16.08.2005|Tallung Ura
73.16.08.2006|Pebaloran
73.16.08.2007|Curio
73.16.08.2008|Mekkala
73.16.08.2009|Sumbang
73.16.08.2010|Mandalan
73.16.08.2011|Salassa
73.16.09.1001|Malua
73.16.09.2002|Bonto
73.16.09.2003|Tallung Tondok
73.16.09.2004|Rante Mario
73.16.09.2005|Tangru
73.16.09.2006|Kolai
73.16.09.2007|Dulang
73.16.09.2008|Buntu Batuan
73.16.10.2001|Pasui
73.16.10.2002|Eran Batu
73.16.10.2003|Latimojong
73.16.10.2004|Buntu Mondong
73.16.10.2005|Ledan
73.16.10.2006|Lunjen
73.16.10.2007|Langda
73.16.10.2008|Potok Ullin
73.16.11.2001|Masalle
73.16.11.2003|Batu Ke'de
73.16.11.2004|Mundan
73.16.11.2006|Buntu Sarong
73.16.11.2008|Rampunan
73.16.11.2055|Tongkonan Basse
73.16.12.2001|Baroko
73.16.12.2002|Benteng Alla
73.16.12.2003|Benteng Alla Utara
73.16.12.2004|Tongko
73.16.12.2005|Patongloan
73.17.01.2005|Kanna
73.17.01.2006|Kanna Utara
73.17.01.2008|Tabi
73.17.01.2010|Bolu
73.17.01.2011|Lange
73.17.01.2012|Sinaji
73.17.01.2013|Mappetajang
73.17.01.2016|Andulan
73.17.01.2017|Buntu Batu
73.17.01.2019|Ledan
73.17.01.2020|Lissaga
73.17.01.2022|To'long
73.17.02.1003|Larompong
73.17.02.2001|Rantebelu
73.17.02.2002|Komba
73.17.02.2004|Lumaring
73.17.02.2005|Binturu
73.17.02.2006|Bilante
73.17.02.2007|Rante Alang
73.17.02.2008|Riwang
73.17.02.2009|Buntu Matabing
73.17.02.2010|Bukit Sutra
73.17.02.2011|Riwang Selatan
73.17.02.2012|Komba Selatan
73.17.02.2013|Buntu Pasik
73.17.03.1003|Suli
73.17.03.2002|Murante
73.17.03.2004|Malela
73.17.03.2005|Botta
73.17.03.2006|Cimpu
73.17.03.2008|Buntu Kunyi
73.17.03.2011|Padang Lambe
73.17.03.2012|Kasiwiang
73.17.03.2013|Cakkeawo
73.17.03.2015|Lempopacci
73.17.03.2016|Towondu
73.17.03.2017|Cimpu Utara
73.17.03.2018|Papakaju
73.17.04.1005|Bajo
73.17.04.2004|Rumaju
73.17.04.2006|Sampa
73.17.04.2007|Pangi
73.17.04.2008|Tallang Bulawang
73.17.04.2010|Jambu
73.17.04.2013|Saga
73.17.04.2014|Sumabu
73.17.04.2015|Balla
73.17.04.2017|Langkiddi
73.17.04.2018|Samulang
73.17.04.2019|Buntu Babang
73.17.05.1001|Noling
73.17.05.2002|Tanjong
73.17.05.2003|Buntu Batu
73.17.05.2004|Tampumia
73.17.05.2005|Padang Tuju
73.17.05.2006|Padang Kamburi
73.17.05.2007|Malenggang
73.17.05.2008|Balutan
73.17.05.2009|Padang Ma'bud
73.17.05.2010|Saluinduk
73.17.06.1006|Bulo
73.17.06.2001|Tombang
73.17.06.2005|Lalong
73.17.06.2008|Harapan
73.17.06.2011|Barammamase
73.17.06.2012|Walenrang
73.17.06.2015|Saragi
73.17.06.2021|Batusitanduk
73.17.06.2022|Kalibamamase
73.17.07.1001|Tampumia Radda
73.17.07.1003|Tanamanai
73.17.07.1005|Senga
73.17.07.1007|Balo-Balo
73.17.07.2004|Kurrusumanga
73.17.07.2006|Belopa
73.17.07.2014|Senga Selatan
73.17.07.2015|Balubu
73.17.07.2016|Pasamai
73.17.08.1001|Sakti
73.17.08.2002|Barowa
73.17.08.2003|Puty
73.17.08.2004|Raja
73.17.08.2005|Posi
73.17.08.2006|Karang-Karangan
73.17.08.2007|Lare-Lare
73.17.08.2008|Lengkong
73.17.08.2009|Tiromanda
73.17.08.2010|Tana Rigella
73.17.08.2011|Bukit Harapan
73.17.08.2012|Padang Kalua
73.17.08.2013|Pammesakang
73.17.08.2014|Pabbaresseng
73.17.08.2015|Toddopuli
73.17.09.1001|Lamasi
73.17.09.2007|Salujambu
73.17.09.2008|Wiwitan
73.17.09.2010|Setiarejo
73.17.09.2011|Pongsamelung
73.17.09.2014|Padang Kalua
73.17.09.2020|To'pongo
73.17.09.2022|Se'pon
73.17.09.2024|Awo' Gading
73.17.09.2026|Wiwitan Timur
73.17.10.1001|Bone Pute
73.17.10.2002|Temboe
73.17.10.2003|Sampano
73.17.10.2004|Babang
73.17.10.2005|La'loa
73.17.10.2006|Batulappa
73.17.10.2007|Malewong
73.17.10.2008|Salusana
73.17.10.2009|Dadeko
73.17.10.2010|Gandang Batu
73.17.11.1001|Padang Subur
73.17.11.1004|Padang Sappa
73.17.11.2005|Tirowali
73.17.11.2006|Mario
73.17.11.2007|Muladimeng
73.17.11.2013|Buntu Kamiri
73.17.11.2014|Tumale
73.17.11.2016|Buntu Nanna
73.17.11.2017|Tampa
73.17.11.2019|Parekaju
73.17.12.2001|Rante Balla
73.17.12.2002|Kadundung
73.17.12.2003|Ulusalu
73.17.12.2004|Lambanan
73.17.12.2005|Tabang
73.17.12.2006|Boneposi
73.17.12.2007|Pangi
73.17.12.2008|Pajang
73.17.12.2009|Buntu Sarek
73.17.12.2010|To'barru
73.17.12.2011|Tibussan
73.17.12.2012|To'lajuk
73.17.13.1001|Cilallang
73.17.13.2002|Kamanre
73.17.13.2003|Tabbaja
73.17.13.2004|Libukang
73.17.13.2005|Wara
73.17.13.2006|Salu Paremang
73.17.13.2007|Salu Paremang Selatan
73.17.13.2008|Bunga Eja
73.17.14.1001|Sabe
73.17.14.1004|Pammanu
73.17.14.2002|Lamunre
73.17.14.2003|Lauwa
73.17.14.2005|Seppong
73.17.14.2006|Paconne
73.17.14.2007|Lebani
73.17.14.2008|Lamunre Tengah
73.17.15.2001|Ilan Batu
73.17.15.2002|Ilan Batu Uru
73.17.15.2003|Lempe Pasang
73.17.15.2004|Lamasi Hulu
73.17.15.2005|Lempe
73.17.15.2006|Lewandi
73.17.16.1004|Bosso
73.17.16.2001|Salutubu
73.17.16.2002|Siteba
73.17.16.2003|Bolong
73.17.16.2005|Pongko
73.17.16.2006|Buntu Awo'
73.17.16.2007|Marabuana
73.17.16.2008|Salulino
73.17.16.2009|Sangtandung
73.17.16.2010|Bosso Timur
73.17.16.2011|Limbong
73.17.17.2001|Lamasi Pantai
73.17.17.2002|Tanete
73.17.17.2003|Rantai Damai
73.17.17.2004|Tabah
73.17.17.2005|Kendekan
73.17.17.2006|Pangalli
73.17.17.2007|Seba-Seba
73.17.17.2008|Suka Damai
73.17.18.2001|Pompengan
73.17.18.2002|Bulolondong
73.17.18.2003|Pompengan pantai
73.17.18.2004|Seriti
73.17.18.2005|Salupao
73.17.18.2006|To'lemo
73.17.18.2007|Pelalan
73.17.18.2008|Pompengan Tengah
73.17.18.2009|Pompengan Utara
73.17.19.1002|Lindajang
73.17.19.2001|Buntu Barana
73.17.19.2003|Poringan
73.17.19.2004|Salubua
73.17.19.2005|Kaili
73.17.19.2006|Muhajirin
73.17.19.2007|Tallang
73.17.19.2008|Kaladi Darussalam
73.17.20.2001|Bonelemo
73.17.20.2002|Sampeang
73.17.20.2003|Marinding
73.17.20.2004|Saronda
73.17.20.2005|Kadong-Kadong
73.17.20.2006|Tumbubara
73.17.20.2007|Tettekang
73.17.20.2008|Bonelemo Utara
73.17.20.2009|Bonelemo Barat
73.17.21.1005|Pattedong
73.17.21.2001|Jenne Maeja
73.17.21.2002|Bakti
73.17.21.2003|Buntu Karya
73.17.21.2004|Olang
73.17.21.2006|Bassiang
73.17.21.2007|Paccerakkang
73.17.21.2008|Lampuara
73.17.21.2009|To'balo
73.17.21.2010|To'bia
73.17.21.2011|Bassiang Timur
73.17.21.2012|Pattedong Selatan
73.17.21.2013|Tarramatekkeng
73.17.22.2001|Bonglo
73.17.22.2002|Tede
73.17.22.2003|Barana
73.17.22.2004|Uraso
73.17.22.2005|Karatuan
73.17.22.2006|Salubua
73.17.22.2007|Pantilang
73.17.22.2008|Buntu Tallang
73.17.22.2009|Dampan
73.17.22.2010|Maindo
73.17.22.2011|Tasangtongkonan
73.17.22.2012|Ta'ba
73.18.01.1009|Pattan Ulusalu
73.18.01.2010|Salutandung
73.18.01.2011|Rea Tulak Langi
73.18.01.2012|Ratte Talonge
73.18.01.2013|Sa'tandung
73.18.01.2014|Ra'bung
73.18.01.2015|Salutapokko
73.18.01.2016|Salu Boronan
73.18.01.2017|Batu Tiakka
73.18.02.1006|Bittuang
73.18.02.2002|Se'seng
73.18.02.2004|Pali'
73.18.02.2007|Tiroan
73.18.02.2008|Balla
73.18.02.2009|Le'tek
73.18.02.2010|Kole Palian
73.18.02.2011|Patongloan
73.18.02.2012|Sasak
73.18.02.2013|Bau
73.18.02.2014|Sandana
73.18.02.2015|Rembo Rembo
73.18.02.2016|Burasia
73.18.02.2017|Kandua'
73.18.02.2018|Buttu Limbong
73.18.03.1007|Ratte Buttu
73.18.03.2001|Bau
73.18.03.2002|Buakayu
73.18.03.2004|Mappa'
73.18.03.2006|Poton
73.18.03.2008|Bau Selatan
73.18.05.1003|Bombongan
73.18.05.1005|Batupapan
73.18.05.1006|Tarongko
73.18.05.1007|Lamunan
73.18.05.1009|Manggau
73.18.05.1014|Tondon Mamullu
73.18.05.1015|Pantan
73.18.05.1016|Buntu Burake
73.18.05.1017|Kamali Pentalluan
73.18.05.1018|Rante
73.18.05.1019|Lapandan
73.18.05.1020|Tampo Makale
73.18.05.1021|Ariang
73.18.05.1022|Botang
73.18.05.2023|Lea
73.18.09.1008|Sima
73.18.09.2003|Simbuang
73.18.09.2004|Pongbembe
73.18.09.2006|Simbuang Batutallu
73.18.09.2009|Makkodo
73.18.09.2010|Puangbembe Mesakada
73.18.11.1003|Tapparan
73.18.11.1012|Rantetayo
73.18.11.1013|Padangiring
73.18.11.2007|Madandan
73.18.11.2011|Tapparan Utara
73.18.11.2014|Tonglo
73.18.12.1002|Rante Kalua'
73.18.12.1016|Tampo
73.18.12.1023|Lemo
73.18.12.1024|Tengan
73.18.12.2004|Gasing
73.18.12.2006|Uluway
73.18.12.2012|Randanan
73.18.12.2015|Buntu Tangti
73.18.12.2017|Rantedada
73.18.12.2018|Pa'tengko
73.18.12.2019|Simbuang
73.18.12.2020|Pakala
73.18.12.2021|Uluway Barat
73.18.12.2022|Marinding
73.18.12.2025|Palipu
73.18.12.2026|Ke'pe Tinoring
73.18.12.2027|Buntudatu
73.18.13.1009|Tongko Sarapung
73.18.13.1010|Buntu Masakke
73.18.13.2004|Bulian Massa'bu
73.18.13.2006|Kaero
73.18.13.2008|Turunan
73.18.19.1002|Benteng Ambeso
73.18.19.1004|Salubarani
73.18.19.1012|Mebali
73.18.19.2001|Buntu Limbong
73.18.19.2003|Sillanan
73.18.19.2005|Gandangbatu
73.18.19.2006|Kaduaja
73.18.19.2007|Garassik
73.18.19.2008|Pemanukan
73.18.19.2009|Perindingan
73.18.19.2010|Buntu Tabang
73.18.19.2011|Betteng Deata
73.18.20.1001|Talion
73.18.20.1013|Rembon
73.18.20.2002|Palesan
73.18.20.2003|Banga
73.18.20.2004|Ullin
73.18.20.2005|Limbong
73.18.20.2006|Sarapeang
73.18.20.2007|Buri'
73.18.20.2008|Maroson
73.18.20.2009|Batusura'
73.18.20.2010|Bua' Tarrung
73.18.20.2011|To'pao
73.18.20.2012|Kayuosing
73.18.27.1001|Tambunan
73.18.27.1002|Sarira
73.18.27.1003|Bungin
73.18.27.1004|Lion Tondok Iring
73.18.27.1005|Lemo
73.18.28.1004|Kondodewata
73.18.28.2001|Tanete
73.18.28.2002|Dewata
73.18.28.2003|Miallo
73.18.28.2005|Sangpeparikan
73.18.28.2006|Butang
73.18.29.1001|Tiromanda
73.18.29.1002|Sandabilik
73.18.29.1003|Tosapan
73.18.29.1004|Pasang
73.18.29.2005|Randan Batu
73.18.29.2006|Patekke
73.18.29.2007|Pa'buaran
73.18.29.2008|Bo'ne Buntu Sisong
73.18.31.2001|Ratte
73.18.31.2002|Paliorong
73.18.31.2003|Kadundung
73.18.31.2004|Pondingao'
73.18.31.2005|Belau
73.18.31.2006|Belau Utara
73.18.31.2007|Paku
73.18.31.2008|Sesesalu
73.18.33.1005|Rante Alang
73.18.33.2001|Batualu
73.18.33.2002|Tokesan
73.18.33.2003|Batualu Selatan
73.18.33.2004|Raru Sibunuan
73.18.34.1001|Leatung
73.18.34.1006|Bebo'
73.18.34.2002|Rantela'bi Kambisa
73.18.34.2003|Leatung Matallo
73.18.34.2004|Saluallo
73.18.34.2005|Tumbang Datu
73.18.35.1001|Malimbong
73.18.35.2002|Leppan
73.18.35.2003|Kole Sawangan
73.18.35.2004|Kole Barebatu
73.18.35.2005|Lemo Menduruk
73.18.35.2006|Balepe'
73.18.37.2001|Rano
73.18.37.2002|Rano Utara
73.18.37.2003|Rumandan
73.18.37.2004|Rano Tengah
73.18.37.2005|Rano Timur
73.18.38.1001|Ratte Kurra
73.18.38.2002|Bambalu
73.18.38.2003|Maroson
73.18.38.2004|Lipungan Tanete
73.18.38.2005|Rante limbong
73.18.38.2006|Limbong Sangpolo
73.22.01.2001|Pattimang
73.22.01.2002|Malangke
73.22.01.2003|Benteng
73.22.01.2004|Tolada
73.22.01.2005|Salekoe
73.22.01.2006|Pute Mata
73.22.01.2007|Tingkara
73.22.01.2008|Ladongi
73.22.01.2009|Giri Kusuma
73.22.01.2010|Tandung
73.22.01.2011|Takkalala
73.22.01.2012|Pettalandung
73.22.01.2013|Tokke
73.22.01.2014|Pince Pute
73.22.02.1001|Bone Bone
73.22.02.2002|Tamuku
73.22.02.2007|Sidomukti
73.22.02.2008|Sukaraya
73.22.02.2011|Batang Tongka
73.22.02.2012|Patoloan
73.22.02.2015|Banyuurip
73.22.02.2017|Pongko
73.22.02.2018|Bantimurung
73.22.02.2020|Muktisari
73.22.02.2021|Sadar
73.22.03.1001|Kappuna
73.22.03.1002|Bone
73.22.03.1003|Baliase
73.22.03.1006|Bone Tua
73.22.03.2004|Pincara
73.22.03.2005|Balebo
73.22.03.2007|Pombakka
73.22.03.2008|Rompu
73.22.03.2009|Lantang Tallang
73.22.03.2010|Lapapa
73.22.03.2011|Maipi
73.22.03.2012|Masamba
73.22.03.2013|Pandak
73.22.03.2014|Sepakat
73.22.03.2015|Pongo
73.22.03.2016|Laba
73.22.03.2017|Toradda
73.22.03.2018|Sumilin
73.22.03.2019|Kamiri
73.22.04.1012|Marobo
73.22.04.2002|Sabbang
73.22.04.2003|Pararra
73.22.04.2004|Tandung
73.22.04.2007|Malimbu
73.22.04.2008|Tullak Tallu
73.22.04.2009|Bakka
73.22.04.2014|Buntu Torpedo
73.22.04.2018|Pengkendekan
73.22.04.2020|Salama
73.22.05.2001|Marampa
73.22.05.2002|Pengkendekan
73.22.05.2003|Kanandede
73.22.05.2004|Rinding Allo
73.22.05.2005|Minanga
73.22.05.2006|Komba
73.22.05.2007|Limbong
73.22.06.2001|Lampuawa
73.22.06.2002|Ketulungan
73.22.06.2003|Salulemo
73.22.06.2004|Kaluku
73.22.06.2005|Sukamaju
73.22.06.2006|Sukadamai
73.22.06.2010|Tamboke
73.22.06.2013|Tolangi
73.22.06.2014|Tulung Indah
73.22.06.2019|Minanga Tallu
73.22.06.2020|Wonosari
73.22.06.2021|Mulyasari
73.22.06.2022|Saptamarga
73.22.06.2024|Tulung Sari
73.22.07.2001|Tirobali
73.22.07.2002|Malimongan
73.22.07.2003|Tanamakaleang
73.22.07.2004|Padang Balua
73.22.07.2005|Padang Raya
73.22.07.2006|Embonatana
73.22.07.2007|Hono
73.22.07.2008|Beroppa
73.22.07.2009|Lodang
73.22.07.2010|Taloto
73.22.07.2011|Hoyane
73.22.07.2012|Marante
73.22.08.2001|Cenning
73.22.08.2002|Pengkajoang
73.22.08.2003|Pao
73.22.08.2004|Arusu
73.22.08.2005|Baku Baku
73.22.08.2006|Wara
73.22.08.2007|Waelawi
73.22.08.2008|Pembuniang
73.22.08.2009|Limbong Wara
73.22.08.2010|Kalitata
73.22.08.2011|Pombakka
73.22.08.2012|Polejiwa
73.22.08.2013|Waetuo
73.22.09.2001|Rampi
73.22.09.2002|Onondowa
73.22.09.2003|Leboni
73.22.09.2004|Dodolo
73.22.09.2005|Sulaku
73.22.09.2006|Tedeboe
73.22.10.2001|Mappedeceng
73.22.10.2002|Cendana Putih
73.22.10.2003|Hasana
73.22.10.2004|Kapidi
73.22.10.2005|Uraso
73.22.10.2006|Benteng
73.22.10.2007|Ujung Mattajang
73.22.10.2009|Cendana Putih I
73.22.10.2010|Sumber Wangi
73.22.10.2011|Mangalle
73.22.10.2012|Mekar Jaya Tondok
73.22.10.2013|Cendana Putih II
73.22.10.2014|Sumber Harum
73.22.10.2015|Tarrak Tallu
73.22.10.2016|Harapan
73.22.11.1005|Salassa
73.22.11.2002|Salulemo
73.22.11.2003|Radda
73.22.11.2004|Baebunta
73.22.11.2007|Tarobok
73.22.11.2008|Mario
73.22.11.2009|Sassa
73.22.11.2010|Kariango
73.22.11.2011|Meli
73.22.11.2013|Palandan
73.22.11.2015|Bumi Harapan
73.22.12.2001|Bungapati
73.22.12.2002|Bungadidi
73.22.12.2003|Poreang
73.22.12.2004|Sumberdadi
73.22.12.2005|Patila
73.22.12.2006|Sidobinangun
73.22.12.2007|Rampoang
73.22.12.2008|Karondang
73.22.12.2009|Munte
73.22.12.2010|Sidomakmur
73.22.13.2001|Mulyorejo
73.22.13.2002|Rawamangun
73.22.13.2003|Paomacang
73.22.13.2004|Wonokerto
73.22.13.2005|Sumberbaru
73.22.13.2006|Banyuwangi
73.22.13.2007|Subur
73.22.13.2008|Lino
73.22.13.2009|Sidoharjo
73.22.13.2010|Sukamukti
73.22.13.2011|Sukaharapan
73.22.14.2001|Lara
73.22.14.2002|Marannu
73.22.14.2003|Beringin Jaya
73.22.14.2004|Mukti Jaya
73.22.14.2005|Mekarsari Jaya
73.22.14.2006|Mukti Tama
73.22.14.2007|Lembang-lembang
73.22.14.2008|Lawewe
73.22.14.2009|Polewali
73.22.14.2010|Sumpira
73.22.15.2001|Buangin
73.22.15.2002|Terpedojaya
73.22.15.2003|Dandang
73.22.15.2004|Kampung Baru
73.22.15.2005|Teteuri
73.22.15.2006|Kalotok
73.22.15.2007|Batualang
73.22.15.2008|Bone Subur
73.22.15.2009|Pompaniki
73.22.15.2010|Mari-mari
73.24.01.2001|Maleku
73.24.01.2002|Wonorejo
73.24.01.2003|Margolembo
73.24.01.2004|Teromu
73.24.01.2007|Manggala
73.24.01.2009|Kasintuwu
73.24.01.2011|Balai Kembang
73.24.01.2013|Panca Karsa
73.24.01.2014|Sindu Agung
73.24.01.2015|Wonorejo Timur
73.24.01.2016|Koroncia
73.24.02.1007|Magani
73.24.02.2001|Nuha
73.24.02.2003|Nikkel
73.24.02.2005|Matano
73.24.02.2009|Sorowako
73.24.03.2001|Loeha
73.24.03.2002|Mahalona
73.24.03.2003|Timampu
73.24.03.2004|Wawondula
73.24.03.2005|Langkea Raya
73.24.03.2006|Tokalimbo
73.24.03.2007|Baruga
73.24.03.2008|Pekaloa
73.24.03.2009|Lioka
73.24.03.2010|Asuli
73.24.03.2011|Bantilang
73.24.03.2012|Masiku
73.24.03.2013|Rante Angin
73.24.03.2014|Matompi
73.24.03.2015|Tole
73.24.03.2016|Libukan Mandiri
73.24.03.2017|Kalosi
73.24.03.2018|Buangin
73.24.04.1003|Malili
73.24.04.2001|Harapan
73.24.04.2002|Laskap
73.24.04.2004|Manurung
73.24.04.2005|Wewangriu
73.24.04.2006|Baruga
73.24.04.2007|Lakawali
73.24.04.2008|Ussu
73.24.04.2009|Tarabbi
73.24.04.2010|Balantang
73.24.04.2011|Atue
73.24.04.2012|Pongkeru
73.24.04.2013|Puncak Indah
73.24.04.2014|Pasi-Pasi
73.24.04.2015|Lakawali Pantai
73.24.05.2001|Tawakua
73.24.05.2002|Tampinna
73.24.05.2003|Solo
73.24.05.2004|Taripa
73.24.05.2005|Mantadulu
73.24.05.2006|Balirejo
73.24.05.2007|Maliwowo
73.24.05.2008|Lamaeto
73.24.05.2009|Watangpanua
73.24.05.2010|Wanasari
73.24.06.2001|Lampenai
73.24.06.2002|Tarengge
73.24.06.2003|Maramba
73.24.06.2004|Cendana Hijau
73.24.06.2005|Bawalipu
73.24.06.2006|Kalaena
73.24.06.2007|Lera
73.24.06.2008|Kanawatu
73.24.06.2009|Bahari
73.24.06.2010|Karambua
73.24.06.2011|Pepuro Barat
73.24.06.2012|Balo-Balo
73.24.06.2013|Rinjani
73.24.06.2014|Tarengge Timur
73.24.06.2015|Madani
73.24.06.2016|Tabaroge
73.24.06.2017|Arolipu
73.24.07.2001|Burau
73.24.07.2002|Jalajja
73.24.07.2003|Lewonu
73.24.07.2004|Lambarese
73.24.07.2005|Lauwo
73.24.07.2006|Bone Pute
73.24.07.2007|Lumbewe
73.24.07.2008|Mabonta
73.24.07.2009|Laro
73.24.07.2010|Benteng
73.24.07.2011|Batu Putih
73.24.07.2012|Lanosi
73.24.07.2013|Lagego
73.24.07.2014|Cendana
73.24.07.2015|Burau Pantai
73.24.07.2016|Asana
73.24.07.2017|Kalatiri
73.24.07.2018|Lambara Harapan
73.24.08.1003|Tomoni
73.24.08.2001|Bayondo
73.24.08.2002|Mulyasri
73.24.08.2007|Lestari
73.24.08.2008|Kalpataru
73.24.08.2011|Tadulako
73.24.08.2012|Beringin Jaya
73.24.08.2015|Bangun Jaya
73.24.08.2016|Mandiri
73.24.08.2017|Sumber Alam
73.24.08.2018|Ujung Baru
73.24.08.2019|Bangun Karya
73.24.08.2020|Rante Mario
73.24.09.2001|Kertoraharjo
73.24.09.2002|Cendana Hitam
73.24.09.2003|Purwosari
73.24.09.2004|Pattengko
73.24.09.2005|Manunggal
73.24.09.2006|Margomulyo
73.24.09.2007|Alam Buana
73.24.09.2008|Cendana Hitam Timur
73.24.10.2001|Kalaena Kiri
73.24.10.2002|Sumber Agung
73.24.10.2003|Pertasi Kencana
73.24.10.2004|Non Blok
73.24.10.2005|Argomulyo
73.24.10.2006|Sumber Makmur
73.24.10.2007|Mekar Sari
73.24.11.2001|Ledu Ledu
73.24.11.2002|Kawata
73.24.11.2003|Tabarano
73.24.11.2004|Wasuponda
73.24.11.2005|Parumpanai
73.24.11.2006|Balambano
73.26.01.1001|Laang Tanduk
73.26.01.1002|Rantepao
73.26.01.1003|Mentirotiku
73.26.01.1004|Manggalo
73.26.01.1005|Pasale
73.26.01.1006|Singki'
73.26.01.1007|Karassik
73.26.01.1008|Penanian
73.26.01.1009|Rante Pasele
73.26.01.2010|Limbong
73.26.01.2011|Saloso
73.26.02.1001|Bori
73.26.02.1002|Pangli
73.26.02.1004|Palawa'
73.26.02.1005|Deri'
73.26.02.1009|Pangli Selatan
73.26.02.2003|Buntu Lobo'
73.26.02.2006|Parinding
73.26.02.2007|Bori' Ranteletok
73.26.02.2008|Bori' Lombongan
73.26.03.1004|Nanggala Sanpiak Satu
73.26.03.2001|Nanggala
73.26.03.2002|Tandung Nanggala
73.26.03.2003|Lili'kira'
73.26.03.2005|Karre Limbong
73.26.03.2006|Rante
73.26.03.2007|Basokan
73.26.03.2008|Nanna' Nanggala
73.26.03.2009|Karre Pananian
73.26.04.1002|Pangala'
73.26.04.1004|Pangala' Utara
73.26.04.2001|Bululangkan
73.26.04.2003|Rindingallo
73.26.04.2005|Mai'ting
73.26.04.2006|Lo'ko'uru Tanetebatu
73.26.04.2007|Ampang Batu
73.26.04.2008|Lempo Poton
73.26.04.2009|Buntu Batu
73.26.05.1005|Tullang' Sura
73.26.05.1006|Tongkonan Bassae
73.26.05.2001|Sapan Kua-kua
73.26.05.2002|Rindingkila'
73.26.05.2003|Misa'ba'bana
73.26.05.2004|Issong Kalua'
73.26.06.1002|Sa'dan Malimbong
73.26.06.1004|Sa'dan Matalo
73.26.06.2001|Sa'dan Ulusalu
73.26.06.2003|Sa'dan Ballo Pasange'
73.26.06.2005|Sa'dan Pebulian
73.26.06.2006|Sa'dan Sangkaropi'
73.26.06.2007|Sa'dan Tiroallo
73.26.06.2008|Sa'dan Andulan
73.26.06.2009|Sa'dan Pesondongan
73.26.06.2010|Sa'dan Liku Lambe'
73.26.07.1006|Paepalean
73.26.07.2001|La'bo'
73.26.07.2002|Buntu La'bo'
73.26.07.2003|Tallung Penanian
73.26.07.2004|Pata'padang
73.26.07.2005|Tandung La'bo'
73.26.08.1002|Nonongan Utara
73.26.08.2001|Salu
73.26.08.2003|Salu Sopai
73.26.08.2004|Tombang Langda
73.26.08.2005|Marante
73.26.08.2006|Langda
73.26.08.2007|Nonongan Selatan
73.26.08.2008|Salu Sarre
73.26.09.1001|Tikala
73.26.09.1002|Buntu Barana
73.26.09.2003|Buntu Batu
73.26.09.2004|Sereale
73.26.09.2005|Embatau
73.26.09.2006|Benteng Ka'do To'ria
73.26.09.2007|Pangden
73.26.10.1002|Tagari
73.26.10.1005|Balusu
73.26.10.2001|Palangi'
73.26.10.2003|Lilikira Ao'gading
73.26.10.2004|Karua
73.26.10.2006|Awa' Kawasik
73.26.10.2007|Balusu Bangunlipu
73.26.11.1001|Tallunglipu Matalo
73.26.11.1002|Tallunglipu
73.26.11.1003|Tampo Tallunglipu
73.26.11.1004|Tagari Tallunglipu
73.26.11.1005|Tantanan Tallunglipu
73.26.11.1007|Rante PakuTallunglipu
73.26.11.2006|Buntu Tallunglipu
73.26.12.1004|Pasang
73.26.12.2001|Ma'dong
73.26.12.2002|Dende'
73.26.12.2003|Piongan
73.26.12.2005|Paku
73.26.12.2006|Kapolang
73.26.12.2007|Buntu Tagari
73.26.12.2008|Parinding
73.26.13.1002|Sapan
73.26.13.2001|Buntu Minanga
73.26.13.2003|Sarambu
73.26.13.2004|Rante Uma
73.26.13.2005|Talimbangan
73.26.13.2006|Pulu' Pulu'
73.26.13.2007|Paonganan
73.26.13.2008|Parandangan
73.26.13.2009|Roroan Barra'-Barra'
73.26.13.2010|Pangkung Batu
73.26.13.2011|Pengkaroan Manuk
73.26.13.2012|Batu Busa
73.26.13.2013|Ponglu
73.26.14.1002|Baruppu Selatan
73.26.14.2001|Baruppu' Utara
73.26.14.2003|Baruppu Benteng Batu
73.26.14.2004|Baruppu' Parodo
73.26.15.1003|Ba'tan
73.26.15.1004|Pantanakan Lolo
73.26.15.2001|Tallu Lolo
73.26.15.2002|Rinding Batu
73.26.15.2005|Angin-angin
73.26.15.2006|Sangbua'
73.26.15.2007|Tadongkon
73.26.16.2001|Tondon Langi'
73.26.16.2002|Tondon
73.26.16.2003|Tondon Sibata
73.26.16.2004|Tondon Matallo
73.26.17.2001|To'yasa Akung
73.26.17.2002|Batu Limbong
73.26.17.2003|Bangkelekila'
73.26.17.2004|Tampan Bonga
73.26.18.1002|Bokin
73.26.18.1005|Buangin
73.26.18.2001|Rantebua
73.26.18.2003|Pitung Penanian
73.26.18.2004|Ma'kuan Pare
73.26.18.2006|Rantebua Sumalu
73.26.18.2007|Rantebua Sanggalangi'
73.26.19.2001|Suloara'
73.26.19.2002|Sesean Matallo
73.26.19.2003|Landorundun
73.26.19.2004|Tonga Riu
73.26.19.2005|Lempo
73.26.20.2001|Benteng Ka'do
73.26.20.2002|Sikuku'
73.26.20.2003|Polo Padang
73.26.20.2004|Kantun Poya
73.26.20.2005|Kapala Pitu
73.26.20.2006|Benteng Mamullu
73.26.21.2001|Awan
73.26.21.2002|Batu Lotong
73.26.21.2003|Buntu Karua
73.26.21.2004|Londong Biang
73.71.01.1001|Bontorannu
73.71.01.1002|Mattoangin
73.71.01.1003|Kunjung Mae
73.71.01.1004|Lette
73.71.01.1005|Panambungan
73.71.01.1006|Mariso
73.71.01.1007|Mario
73.71.01.1008|Kampung Buyang
73.71.01.1009|Tamarunang
73.71.02.1001|Sambung Jawa
73.71.02.1002|Parang
73.71.02.1003|Mamajang Luar
73.71.02.1004|Mamajang Dalam
73.71.02.1005|Maricaya Selatan
73.71.02.1006|Bonto Lebang
73.71.02.1007|Pa'batang
73.71.02.1008|Bonto Biraeng
73.71.02.1009|Labuang Baji
73.71.02.1010|Mandala
73.71.02.1011|Tamparang Keke
73.71.02.1012|Baji Mappakasunggu
73.71.02.1013|Karang Anyar
73.71.03.1001|Maricaya
73.71.03.1002|Bara Baraya
73.71.03.1003|Maradekaya
73.71.03.1004|Lariangbangi
73.71.03.1005|Maccini
73.71.03.1006|Maricaya Baru
73.71.03.1007|Bara Baraya Timur
73.71.03.1008|Bara Baraya Selatan
73.71.03.1009|Maradekaya Selatan
73.71.03.1010|Barana
73.71.03.1011|Maccini Parang
73.71.03.1012|Maccini Gusung
73.71.03.1013|Maradekaya Utara
73.71.03.1014|Bara Baraya Utara
73.71.04.1001|Maloku
73.71.04.1002|Mangkura
73.71.04.1003|Pisang Selatan
73.71.04.1004|Pisang Utara
73.71.04.1005|Baru
73.71.04.1006|Bulogading
73.71.04.1007|Lae-Lae
73.71.04.1008|Losari
73.71.04.1009|Sawerigading
73.71.04.1010|Lajangiru
73.71.05.1001|Pattunuang
73.71.05.1002|Melayu
73.71.05.1003|Butung
73.71.05.1004|Malimongan Tua
73.71.05.1005|Ende
73.71.05.1006|Mampu
73.71.05.1007|Malimongan
73.71.05.1008|Melayu Baru
73.71.06.1001|Malimongan Baru
73.71.06.1002|Wajo Baru
73.71.06.1003|Gaddong
73.71.06.1004|Bontoala
73.71.06.1005|Baraya
73.71.06.1006|Layang
73.71.06.1007|Parang Layang
73.71.06.1008|Bontoala Tua
73.71.06.1009|Bontoala Parang
73.71.06.1010|Tompo Balang
73.71.06.1011|Bunga Ejaya
73.71.06.1012|Timungan Lompoa
73.71.07.1001|Pannampu
73.71.07.1002|Kalukuang
73.71.07.1003|Kaluku Bodoa
73.71.07.1004|Rappojawa
73.71.07.1005|Rappokalling
73.71.07.1006|Lakkang
73.71.07.1007|Tallo
73.71.07.1008|La'latang
73.71.07.1009|Wala-Walaya
73.71.07.1010|Tammua
73.71.07.1011|Buloa
73.71.07.1012|Suangga
73.71.07.1013|Ujung Pandang Baru
73.71.07.1014|Lembo
73.71.07.1015|Bunga Eja Beru
73.71.08.1002|Tabaringan
73.71.08.1003|Patingalloang
73.71.08.1004|Gusung
73.71.08.1005|Cambaya
73.71.08.1006|Ujung Tanah
73.71.08.1009|Totaka
73.71.08.1010|Tamalabba
73.71.08.1011|Camba Berua
73.71.08.1012|Patingalloang Baru
73.71.09.1001|Karuwisi
73.71.09.1002|Panaikang
73.71.09.1003|Tello Baru
73.71.09.1004|Pampang
73.71.09.1005|Karampuang
73.71.09.1006|Tamamaung
73.71.09.1007|Masale
73.71.09.1008|Pandang
73.71.09.1009|Karuwisi Utara
73.71.09.1010|Sinrijala
73.71.09.1011|Paropo
73.71.10.1001|Barombong
73.71.10.1002|Maccini Sombala
73.71.10.1003|Jongaya
73.71.10.1004|Mangasa
73.71.10.1005|Bongaya
73.71.10.1006|Balang Baru
73.71.10.1007|Mannuruki
73.71.10.1008|Pa'baeng-Baeng
73.71.10.1009|Parang Tambung
73.71.10.1010|Tanjung Merdeka
73.71.10.1011|Bonto Duri
73.71.11.1001|Paccerakkang
73.71.11.1002|Daya
73.71.11.1003|Pai
73.71.11.1004|Bulurokeng
73.71.11.1005|Sudiang
73.71.11.1006|Sudiang Raya
73.71.11.1007|Untia
73.71.11.1008|Laikang
73.71.11.1009|Berua
73.71.11.1010|Katimbang
73.71.11.1011|Bakung
73.71.12.1001|Manggala
73.71.12.1002|Bangkala
73.71.12.1003|Tamangapa
73.71.12.1004|Antang
73.71.12.1005|Batua
73.71.12.1006|Borong
73.71.12.1007|Biring Romang
73.71.12.1008|Bitowa
73.71.13.1001|Tidung
73.71.13.1002|Kassi-Kassi
73.71.13.1003|Mappala
73.71.13.1004|Buakana
73.71.13.1005|Bonto Makkio
73.71.13.1006|Rappocini
73.71.13.1007|Balla Parang
73.71.13.1008|Banta-Bantaeng
73.71.13.1009|Karunrung
73.71.13.1010|Gunung Sari
73.71.13.1011|Minasa Upa
73.71.14.1001|Tamalanrea
73.71.14.1002|Kapasa
73.71.14.1003|Tamalanrea Indah
73.71.14.1004|Parang Loe
73.71.14.1005|Bira
73.71.14.1006|Tamalanrea Jaya
73.71.14.1007|Buntusu
73.71.14.1008|Kapasa Raya
73.71.15.1001|Barrang Caddi
73.71.15.1002|Barrang Lompo
73.71.15.1003|Kodingareng
73.72.01.1004|Lompoe
73.72.01.1005|Watang Bacukiki
73.72.01.1009|Lemoe
73.72.01.1010|Galung Maloang
73.72.02.1001|Labukkang
73.72.02.1002|Ujung Sabbang
73.72.02.1003|Ujung Bulu
73.72.02.1004|Lapadde
73.72.02.1005|Mallusetasi
73.72.03.1001|Lakessi
73.72.03.1002|Ujung Baru
73.72.03.1003|Watang Soreang
73.72.03.1004|Kampung Pisang
73.72.03.1005|Ujung Lare
73.72.03.1006|Bukit Indah
73.72.03.1007|Bukit Harapan
73.72.04.1001|Kampung Baru
73.72.04.1002|Cappa Galung
73.72.04.1003|Lumpue
73.72.04.1004|Tiro Sompe
73.72.04.1005|Sumpang Minangae
73.72.04.1006|Bumi Harapan
73.73.01.1001|Tompotikka
73.73.01.1002|Boting
73.73.01.1003|Ammasangan
73.73.01.1005|Lagaligo
73.73.01.1011|Dangerakko
73.73.01.1012|Pajalesang
73.73.02.1002|Batupasi
73.73.02.1003|Sabbamparu
73.73.02.1005|Salobulo
73.73.02.1007|Penggoli
73.73.02.1008|Luminda
73.73.02.1009|Pattene
73.73.03.1001|Takkalala
73.73.03.1002|Songka
73.73.03.1006|Sampoddo
73.73.03.1007|Binturu
73.73.04.1002|Maroangin
73.73.04.1003|Mancani
73.73.04.1004|Sumarambu
73.73.04.1005|Salubattang
73.73.04.1006|Jaya
73.73.04.1007|Batu Walenrang
73.73.04.1008|Pentojangan
73.73.05.1001|Surutanga
73.73.05.1002|Benteng
73.73.05.1003|Pontap
73.73.05.1004|Malatunrung
73.73.05.1005|Salekoe
73.73.05.1006|Salutellue
73.73.05.1007|Ponjalae
73.73.06.1001|Tamarundung
73.73.06.1002|Battang
73.73.06.1003|Lebang
73.73.06.1004|Battang Barat
73.73.06.1005|Padang Lambe
73.73.07.1001|Mawa
73.73.07.1002|Purangi
73.73.07.1003|Peta
73.73.07.1004|Sendana
73.73.08.1001|Mungkajang
73.73.08.1002|Murante
73.73.08.1003|Latuppa
73.73.08.1004|Kambo
73.73.09.1001|Temmalebba
73.73.09.1002|Balandai
73.73.09.1003|Rampoang
73.73.09.1004|To'Bulung
73.73.09.1005|Buntu Datu
74.01.01.1001|19 Nopember
74.01.01.1002|Wundulako
74.01.01.1003|Lamekongga
74.01.01.1004|Kowioha
74.01.01.1005|Silea
74.01.01.1011|Ngapa
74.01.01.2006|Towua
74.01.01.2007|Bende
74.01.01.2008|Unamendaa
74.01.01.2009|Tikonu
74.01.01.2010|Sabiano
74.01.04.1001|Lamokato
74.01.04.1002|Watuliandu
74.01.04.1003|Balandete
74.01.04.1004|Lalombaa
74.01.04.1005|Sabilambo
74.01.04.1006|Laloeha
74.01.04.1007|Tahoa
74.01.07.1001|Dawi-Dawi
74.01.07.1002|Pomalaa
74.01.07.1009|Tonggoni
74.01.07.1011|Kumoro
74.01.07.2003|Huko-Huko
74.01.07.2004|Pelambua
74.01.07.2005|Tambea
74.01.07.2006|Sopura
74.01.07.2007|Pesouha
74.01.07.2008|Totobo
74.01.07.2010|Oko-Oko
74.01.07.2012|Hakatutobu
74.01.08.1001|Watubangga
74.01.08.1006|Tandebura
74.01.08.1015|Wolulu
74.01.08.2002|Lamundre
74.01.08.2007|Kukutio
74.01.08.2011|Langgosipi
74.01.08.2012|Sumber Rejeki
74.01.08.2016|Peoho
74.01.08.2017|Mataosu
74.01.08.2018|Polenga
74.01.08.2020|Kastura
74.01.08.2023|Gunung Sari
74.01.08.2025|Mataosu Ujung
74.01.08.2026|Ranoteta
74.01.10.1001|Wolo
74.01.10.1007|Ulu Wolo
74.01.10.2002|Donggala
74.01.10.2003|Ululapao-pao
74.01.10.2008|Tolowe Ponrewaru
74.01.10.2009|Lapao-Pao
74.01.10.2010|Langgomali
74.01.10.2011|Lalonaha
74.01.10.2012|Lana
74.01.10.2015|Lalonggopi
74.01.10.2016|Muara Lapao-Pao
74.01.10.2018|Samaenre
74.01.10.2019|Iwoimopuro
74.01.10.2021|Ulu Rina
74.01.12.1001|Puundoho
74.01.12.2002|Longori
74.01.12.2003|Puubunga
74.01.12.2004|Puulemo
74.01.12.2005|Puubenua
74.01.12.2006|Baula
74.01.12.2007|Pewutaa
74.01.12.2008|Watalara
74.01.12.2009|Puuroda
74.01.12.2010|Ulu Baula
74.01.14.1001|Mangolo
74.01.14.1002|Kolakaasi
74.01.14.1003|Sea
74.01.14.1004|Latambaga
74.01.14.1005|Sakuli
74.01.14.1006|Induha
74.01.14.1007|Ulunggolaka
74.01.18.1003|Anaiwoi
74.01.18.2001|Lamedai
74.01.18.2002|Tanggetada
74.01.18.2004|Pewisoa Jaya
74.01.18.2005|Tondowolio
74.01.18.2006|Popalia
74.01.18.2007|Lalonggolosua
74.01.18.2008|Petudua
74.01.18.2009|Rahanggada
74.01.18.2010|Palewai
74.01.18.2011|Puundaipa
74.01.18.2012|Oneeha
74.01.18.2013|Lamoiko
74.01.18.2014|Tinggo
74.01.20.1001|Tosiba
74.01.20.1013|Tonganapo
74.01.20.2002|Konaweha
74.01.20.2003|Kaloloa
74.01.20.2004|Tamboli
74.01.20.2005|Lambolemo
74.01.20.2006|Amamutu
74.01.20.2007|Lawulo
74.01.20.2008|Awa
74.01.20.2009|Latuo
74.01.20.2010|Wawo Tambali
74.01.20.2011|Malaha
74.01.20.2012|Sani-sani
74.01.20.2014|Ulu Konaweha
74.01.20.2015|Puu Tamboli
74.01.20.2016|Ulaweng
74.01.20.2017|Puu Lawulo
74.01.20.2018|Liku
74.01.20.2019|Meura
74.01.24.1003|Ranomentaa
74.01.24.2001|Toari
74.01.24.2002|Lakito
74.01.24.2004|Anawua
74.01.24.2005|Wowoli
74.01.24.2006|Rano Jaya
74.01.24.2007|Rahabite
74.01.24.2008|Wonua Raya
74.01.24.2009|Rano Sangia
74.01.24.2010|Horongkuli
74.01.25.1001|Polinggona
74.01.25.2002|Puudongi
74.01.25.2003|Plasma Jaya
74.01.25.2004|Tanggeau
74.01.25.2005|Wulonggere
74.01.25.2006|Pondowae
74.01.25.2007|Lamondape
74.01.27.2001|Tamborasi
74.01.27.2002|Ladahai
74.01.27.2003|Lasiroku
74.01.27.2004|Iwoimendaa
74.01.27.2005|Lambopini
74.01.27.2006|Ulu Kalo
74.01.27.2007|Wonualaku
74.01.27.2008|Lawolia
74.01.27.2009|Watumelewe
74.01.27.2010|Landoula
74.02.01.1001|Lambuya
74.02.01.2006|Awuliti
74.02.01.2007|Asaki
74.02.01.2011|Amberi
74.02.01.2012|Waworaha
74.02.01.2015|Tanggobu
74.02.01.2027|Meraka
74.02.01.2035|Wanua Hoa
74.02.01.2036|Watarema
74.02.01.2037|Tetembomua
74.02.02.1001|Puunaaha
74.02.02.1002|Tumpas
74.02.02.1003|Latoma
74.02.02.1004|Ambekairi
74.02.02.1005|Arombu
74.02.02.1006|Asinua
74.02.02.1011|Wawonggole
74.02.02.1012|Tuoy
74.02.02.1013|Unaaha
74.02.02.1015|Inolobunggadue
74.02.02.1016|Asambu
74.02.02.1017|Tobeu
74.02.03.1001|Wawotobi
74.02.03.1002|Inalahi
74.02.03.1006|Lalosabila
74.02.03.1007|Hopa-Hopa
74.02.03.1008|Kulahi
74.02.03.1009|Ranoeya
74.02.03.1010|Palarahi
74.02.03.1011|Kasupute
74.02.03.1019|Nohu-Nohu
74.02.03.1020|Inolobu
74.02.03.1027|Bose-Bose
74.02.03.1028|Puusinauwi
74.02.03.2013|Nario Indah
74.02.03.2017|Anggotoa
74.02.03.2018|Analahumbuti
74.02.03.2025|Karandu
74.02.03.2026|Korumba
74.02.03.2031|Kasumewuho
74.02.03.2032|Kukuluri
74.02.04.1001|Pondidaha
74.02.04.2013|Hongoa
74.02.04.2016|Mumundowu
74.02.04.2019|Ahuawatu
74.02.04.2025|Tirawuta
74.02.04.2030|Ambuulanu
74.02.04.2031|Belatu
74.02.04.2034|Amesiu
74.02.04.2035|Puumbinisi
74.02.04.2039|Wawolemo
74.02.04.2045|Sulemandara
74.02.04.2046|Lalodangge
74.02.04.2047|Wawolahumbuti
74.02.04.2048|Laloika
74.02.04.2049|Lalonggotomi
74.02.04.2050|Wonua Mandara
74.02.04.2051|Wonua Monapa
74.02.04.2052|Lahonggumbi
74.02.05.1001|Sampara
74.02.05.1007|Rawua
74.02.05.2006|Andepali
74.02.05.2008|Andaroa
74.02.05.2009|Puuloro
74.02.05.2012|Andadowi
74.02.05.2027|Totombe Jaya
74.02.05.2028|Bao-Bao
74.02.05.2030|Wawolimbue
74.02.05.2036|Baini
74.02.05.2038|Polua
74.02.05.2041|Pohara
74.02.05.2048|Bondoala
74.02.05.2052|Konggamea
74.02.05.2057|Wowa Andaroa
74.02.10.1001|Abuki
74.02.10.2007|Sambeani
74.02.10.2008|Asolu
74.02.10.2009|Punggaluku
74.02.10.2012|Walay
74.02.10.2015|Epeea
74.02.10.2024|Kumapo
74.02.10.2035|Unaasi Jaya
74.02.10.2038|Kasuwura Indah
74.02.10.2039|Arubia Jaya
74.02.10.2040|Padangguni Utama
74.02.10.2042|Anggoro
74.02.11.1001|Toronipa
74.02.11.2002|Atowatu
74.02.11.2004|Waworaha
74.02.11.2006|Sorue Jaya
74.02.11.2010|Soropia
74.02.11.2011|Tapulaga
74.02.11.2012|Sawapudo
74.02.11.2014|Bokori
74.02.11.2015|Saponda
74.02.11.2016|Mekar
74.02.11.2017|Bajo Indah
74.02.11.2022|Telaga Biru
74.02.11.2023|Leppe
74.02.11.2024|Bajoe
74.02.11.2025|Saponda Laut
74.02.15.1001|Tongauna
74.02.15.1002|Mata Iwoi
74.02.15.1003|Puosu
74.02.15.1004|Sendang Mulya Sari
74.02.15.1005|Mekar Sari
74.02.15.2006|Lalonggowuna
74.02.15.2007|Asao
74.02.15.2012|Andeposandu
74.02.15.2013|Momea
74.02.15.2018|Ambepulu
74.02.16.1003|Waworaha
74.02.16.2001|Latoma Jaya
74.02.16.2002|Ambekaeri Utama
74.02.16.2004|Amboniki
74.02.16.2005|Pinole
74.02.16.2006|Nesowi
74.02.16.2007|Wawolatoma
74.02.16.2008|Andoluto
74.02.16.2009|Lalowata
74.02.16.2010|Titiowa
74.02.16.2012|Angonga
74.02.17.1002|Watundehoa
74.02.17.2001|Puriala
74.02.17.2003|Sonai
74.02.17.2004|Lalonggatu
74.02.17.2005|Poanaha
74.02.17.2006|Wonua Morome
74.02.17.2007|Ahuawali
74.02.17.2008|Watusa
74.02.17.2009|Puusangi
74.02.17.2010|Mokaleleo
74.02.17.2011|Unggulino
74.02.17.2012|Tetewatu
74.02.17.2013|Tetehaka
74.02.17.2014|Puuhopa
74.02.17.2015|Laloonaha
74.02.17.2016|Wawosanggula
74.02.18.1001|Uepai
74.02.18.2002|Ameroro
74.02.18.2003|Tawarotebota
74.02.18.2004|Olo-Oloho
74.02.18.2005|Matahoalu
74.02.18.2006|Langgomea
74.02.18.2007|Rawua
74.02.18.2008|Baruga
74.02.18.2009|Amaroa
74.02.18.2010|Tawamelewe
74.02.18.2011|Anggopiu
74.02.18.2012|Tamesandi
74.02.18.2013|Humboto
74.02.18.2015|Anggawo
74.02.18.2016|Kasaeda
74.02.18.2017|Tanggondipo
74.02.18.2018|Panggulawu
74.02.18.2019|Puuroda Jaya
74.02.19.1009|Puuduria
74.02.19.2004|Duriaasi
74.02.19.2006|Lalousu
74.02.19.2008|Wawoone
74.02.19.2010|Wawosolo
74.02.19.2012|Wawonggole
74.02.19.2015|Tetemotaha
74.02.19.2016|Dawi-dawi
74.02.19.2017|Bendewuta
74.02.19.2018|Langgonawe
74.02.19.2019|Lalohao
74.02.19.2020|Wukusao
74.02.19.2026|Tawarolondo
74.02.19.2027|Polandangi
74.02.19.2028|Anggoro
74.02.19.2029|Tetewonua
74.02.20.1003|Besulutu
74.02.20.2001|Lawonua
74.02.20.2002|Amosilu
74.02.20.2004|Laloumera
74.02.20.2005|Asunde
74.02.20.2006|Ulupohara
74.02.20.2007|Labela
74.02.20.2008|Ranomolua
74.02.20.2009|Silea
74.02.20.2010|Onembute
74.02.20.2011|Andomesinggo
74.02.20.2012|Puulowaru
74.02.20.2013|Puundoho
74.02.20.2014|Punggaluku
74.02.20.2015|Waworaha
74.02.20.2016|Lalowulo
74.02.21.1003|Laosu
74.02.21.2002|Pebunooha
74.02.21.2004|Lalonggalaku
74.02.21.2009|Diolo
74.02.21.2018|Pebunooha Dalam
74.02.21.2023|Rumbia
74.02.21.2028|Rambu Kongga
74.02.21.2029|Laosu Jaya
74.02.21.2031|Langgaluku Timur
74.02.23.1001|Ruota
74.02.23.2002|Tirawonua
74.02.23.2003|Parudongka
74.02.23.2004|Walandawe
74.02.23.2005|Puuwiwirano
74.02.23.2006|Tanggola
74.02.23.2007|Lalomerui
74.02.24.1001|Parauna
74.02.24.1002|Anggaberi
74.02.24.1003|Lawulo
74.02.24.1004|Andabia
74.02.24.1005|Unaasi
74.02.24.1006|Toriki
74.02.24.2007|Lerehoma
74.02.24.2008|Wunduongohi
74.02.25.1003|Meluhu
74.02.25.2001|Woerahi
74.02.25.2002|Lamelai
74.02.25.2004|Ahuhu
74.02.25.2005|Tudameaso
74.02.25.2006|Larowiu
74.02.25.2007|Ahuloa
74.02.25.2008|Sambasule
74.02.25.2009|Lalopisi
74.02.28.1013|Amunggedo Baru
74.02.28.2001|Anahinunu
74.02.28.2002|Ulu Benua
74.02.28.2003|Puuasana
74.02.28.2004|Watulawu
74.02.28.2005|Lalonona
74.02.28.2006|Amonggedo
74.02.28.2007|Dunggua
74.02.28.2008|Benua
74.02.28.2009|Matabura
74.02.28.2010|Wawohine
74.02.28.2011|Mendikonu
74.02.28.2012|Amendete
74.02.28.2014|Mataiwoi
74.02.28.2015|Lalombonda
74.02.31.1004|Ambodiaa
74.02.31.2001|Nekudu
74.02.31.2002|Lasada
74.02.31.2003|Asinua Jaya
74.02.31.2005|Angohi
74.02.31.2006|Awua Jaya
74.02.31.2007|Awua Sari
74.02.31.2008|Asipako
74.02.32.1001|Bungguosu
74.02.32.1002|Tudaone
74.02.32.1003|Konawe
74.02.32.1004|Tawanga
74.02.32.2005|Sanggona
74.02.32.2006|Uelawu
74.02.32.2007|Mokowu
74.02.32.2008|Uete
74.02.32.2009|Hudoa
74.02.32.2010|Wonua Mbae
74.02.32.2011|Asoniwowo
74.02.32.2012|Puuwonua
74.02.33.1001|Kapoiala
74.02.33.2002|Lalimbue Jaya
74.02.33.2003|Labotoy
74.02.33.2004|Muara Sampara
74.02.33.2005|Sambaraasi
74.02.33.2006|Lamendora
74.02.33.2007|Tani Indah
74.02.33.2008|Pereoa
74.02.33.2009|Ulu Lalimbue
74.02.33.2010|Lalimbue
74.02.33.2011|Tombawatu
74.02.33.2012|Lalonggombuno
74.02.33.2013|Kapoiala Baru
74.02.33.2014|Labotoy Jaya
74.02.36.2001|Toli Toli
74.02.36.2002|Nii Tanasa
74.02.36.2003|Rapambinopaka
74.02.36.2004|Lalombonda
74.02.36.2005|Puuwonua
74.02.36.2006|Bumi Indah
74.02.36.2007|Lolanggasumeeto
74.02.36.2008|Toolawawo
74.02.36.2010|Wawobungi
74.02.36.2011|Batu Gong
74.02.36.2012|Watunggarandu
74.02.37.1001|Onembute
74.02.37.2002|Trimulya
74.02.37.2003|Napoosi
74.02.37.2004|Silea
74.02.37.2005|Ulumeraka
74.02.37.2006|Mataiwoi
74.02.37.2007|Kumapo
74.02.37.2008|Kasumeia
74.02.37.2009|Ulu Onembute
74.02.37.2010|Tawapandere
74.02.37.2011|Anggaloosi
74.02.37.2012|Ana Onembute
74.02.38.2001|Atodopi
74.02.38.2002|Matahori
74.02.38.2003|Sambaosu
74.02.38.2004|Matanggorai
74.02.38.2005|Alosika
74.02.38.2006|Mekar Jaya
74.02.38.2007|Langgea
74.02.38.2008|Aleuti
74.02.38.2009|Garuda
74.02.38.2010|Padangguni
74.02.38.2011|Padang Mekar
74.02.39.2001|Mendikonu
74.02.39.2002|Wonua Morini
74.02.39.2003|Besu
74.02.39.2004|Paku
74.02.39.2005|Puuruy
74.02.39.2006|Morosi
74.02.39.2007|Tanggobu
74.02.39.2008|Paku Jaya
74.02.39.2009|Tondowatu
74.02.39.2010|Porara
74.02.40.2001|Anggalomoare
74.02.40.2002|Lasoso
74.02.40.2003|Lakomea
74.02.40.2004|Abelisawah
74.02.40.2005|Galu
74.02.40.2006|Tabanggele
74.02.40.2007|Puusangi
74.02.40.2008|Andobeu Jaya
74.02.40.2009|Anggalomoare Jaya
74.02.40.2010|Pusawah Jaya
74.02.41.2001|Wonggeduku
74.02.41.2002|Puday
74.02.41.2003|Waturay
74.02.41.2004|Tobimeita
74.02.41.2005|Kasukia
74.02.41.2006|Baruga
74.02.41.2007|Teteona
74.02.41.2008|Ambuuwiu
74.02.41.2009|Linonggasai
74.02.41.2010|Lambangi
74.02.41.2011|Lahotutu
74.02.41.2012|Lamokuni
74.02.41.2013|Ranotundobu
74.02.41.2014|Anggadola
74.02.42.2001|Waworoda Jaya
74.02.42.2002|Uluao
74.02.42.2003|Sanuanggamo
74.02.42.2004|Anggohu
74.02.42.2005|Ambopi
74.02.42.2006|Nambeaboru
74.02.42.2007|Puundombi
74.02.42.2008|Olo Onua
74.02.42.2009|Barowila
74.02.42.2010|Andalambe
74.03.06.1004|Napabalano
74.03.06.1005|Tampo
74.03.06.2003|Napalakura
74.03.06.2006|Pentiro
74.03.06.2007|Langkumapo
74.03.06.2009|Lambiku
74.03.07.2001|Langkoroni
74.03.07.2002|Latompa
74.03.07.2003|Raimuna
74.03.07.2004|Maligano
74.03.07.2005|Lapole
74.03.07.2007|Pohorua
74.03.13.1003|Labunia
74.03.13.2001|Wambona
74.03.13.2004|Bakealu
74.03.13.2005|Pure
74.03.13.2006|Wakorumba
74.03.14.2001|Bangun Sari
74.03.14.2002|Labone
74.03.14.2003|Bonea
74.03.14.2004|Kombungo
74.03.14.2005|Labunti
74.03.14.2006|Parida
74.03.14.2007|Lasalepa
74.03.15.1003|Sidodadi
74.03.15.1004|Laiworu
74.03.15.2001|Wawesa
74.03.15.2002|Wakorambu
74.03.16.1001|Watonea
74.03.16.1002|Raha III
74.03.16.1003|Wamponiki
74.03.16.1004|Butung Butung
74.03.16.1005|Raha II
74.03.16.1006|Foo Kuni
74.03.16.1007|Laende
74.03.16.1008|Raha I
74.03.17.1002|Palangga
74.03.17.1005|Wapunto
74.03.17.2001|Ghonsume
74.03.17.2003|Lagasa
74.03.17.2004|Ghone Bhalano
74.03.17.2006|Lasunapa
74.03.17.2007|Banggai
74.03.18.2001|Liangkobori
74.03.18.2002|Mabolu
74.03.18.2003|Kondongia
74.03.18.2004|Waara
74.03.18.2005|Mantobua
74.03.18.2006|Loghiya
74.03.18.2007|Lohia
74.03.18.2008|Korihi
74.03.18.2009|Lakarinta
74.03.19.1004|Dana
74.03.19.1007|Wali
74.03.19.2001|Lakapodo
74.03.19.2002|Wakadia
74.03.19.2003|Matarawa
74.03.19.2005|Bhangkali Barat
74.03.19.2006|Bangkali
74.03.19.2008|Labaha
74.03.20.2001|Liabalano
74.03.20.2002|Lapodidi
74.03.20.2003|Bungi
74.03.20.2004|Kontunaga
74.03.20.2005|Madodo
74.03.20.2006|Masalili
74.03.23.2001|Komba Komba
74.03.23.2002|Kabangka
74.03.23.2003|Wakobalu Agung
74.03.23.2004|Lupia
74.03.23.2007|Sarimulyo
74.03.23.2008|Oensuli
74.03.23.2009|Wansugi
74.03.23.2010|Wataliku
74.03.23.2011|Lakandito
74.03.24.1009|Laimpi
74.03.24.2001|Lamanu
74.03.24.2002|Kawite Wite
74.03.24.2003|Bente
74.03.24.2004|Bea
74.03.24.2006|Rangka
74.03.24.2010|Kambawuna
74.03.24.2011|Kontumere
74.03.24.2012|Lamaeo
74.03.24.2013|Wantiworo
74.03.24.2014|Kasaka
74.03.25.1005|Wakumoro
74.03.25.1006|Walambeno Wite
74.03.25.1007|Kolasa
74.03.25.1009|Wasolangka
74.03.25.2001|Labulu Bulu
74.03.25.2002|Latampu
74.03.25.2003|Laiba
74.03.25.2004|Warambe
74.03.25.2008|Parigi
74.03.25.2010|Wapuale
74.03.25.2012|Wakumoro
74.03.26.2006|Bone Tondo
74.03.26.2007|Bhone Kainsetala
74.03.26.2008|Bone Lolibu
74.03.26.2009|Oelongko
74.03.26.2010|Matombura
74.03.27.1005|Danagoa
74.03.27.1007|Kontumolepe
74.03.27.1008|Tombula
74.03.27.2003|Lahontohe
74.03.27.2004|Lamorende
74.03.27.2006|Lakologou
74.03.27.2009|Matano Oe
74.03.27.2014|Lapadindi
74.03.27.2015|Oempu
74.03.27.2016|Fongkaniwa
74.03.27.2017|Tanjung
74.03.27.2019|Kotano Wuna
74.03.28.2001|Kogholifano
74.03.28.2002|Pola
74.03.28.2007|Kamosope
74.03.28.2008|Liwumetingki
74.03.28.2009|Labulawa
74.03.28.2010|Bumbu
74.03.30.2001|Kafo Foo
74.03.30.2002|Lembo
74.03.30.2003|Kilambibito
74.03.30.2004|Bahutara
74.03.30.2005|Kontu Kowuna
74.03.30.2006|Lahorio
74.03.31.2001|Marobo
74.03.31.2002|Wadolao
74.03.31.2003|Pasikuta
74.03.31.2004|Tapitapi
74.03.31.2005|Poaroha
74.03.32.1001|Lawama
74.03.32.2002|Wale-Ale
74.03.32.2003|Kulidawa
74.03.32.2004|Labasa
74.03.32.2005|Watondo
74.03.32.2006|Lianosa
74.03.33.2001|Kolese
74.03.33.2002|Tampunabale
74.03.33.2003|Mata Indaha
74.03.33.2004|Lambelu
74.03.34.2001|Bone Bone
74.03.34.2002|Lanobake
74.03.34.2003|Moolo
74.03.34.2004|Baluara
74.03.37.2001|Wangkolabu
74.03.37.2002|Lakarama
74.03.37.2003|Moasi
74.03.37.2004|Renda
74.03.37.2005|Bhontu-Bhontu
74.04.11.1005|Wakoko
74.04.11.1006|Wasaga
74.04.11.1020|Holimombo
74.04.11.1021|Kombeli
74.04.11.1022|Takimpo
74.04.11.1023|Awainulu
74.04.11.1026|Kambulabulana
74.04.11.1027|Pasarwajo
74.04.11.1028|Saragi
74.04.11.2002|Waangu-angu
74.04.11.2003|Warinta
74.04.11.2004|Lapodi
74.04.11.2007|Kancinaa
74.04.11.2008|Winning
74.04.11.2017|Holimombo Jaya
74.04.11.2018|Kondowa
74.04.11.2019|Dongkala
74.04.11.2024|Laburunci
74.04.11.2025|Banabungi
74.04.11.2029|Kabawakole
74.04.11.2030|Mantowu
74.04.11.2031|Kaongkeongkea
74.04.22.1005|Watumotobe
74.04.22.1006|Wakangka
74.04.22.2001|Barangka
74.04.22.2002|Wakalambe
74.04.22.2003|Boneatiro
74.04.22.2004|Lambusango
74.04.22.2007|Todanga
74.04.22.2008|Tuangila
74.04.22.2009|Waondo Wolio
74.04.22.2010|Bukit Asri
74.04.22.2011|Kamelanta
74.04.22.2012|Lambusango Timur
74.04.22.2013|Wakuli
74.04.22.2014|Mabulugo
74.04.22.2015|Wambulu
74.04.22.2016|Tumada
74.04.22.2017|Boneatiro Barat
74.04.23.1005|Kamaru
74.04.23.2001|Kakenauwe
74.04.23.2002|Waoleona
74.04.23.2003|Lawele
74.04.23.2004|Suandala
74.04.23.2006|Lasembangi
74.04.23.2007|Bonelalo
74.04.23.2008|Wasuamba
74.04.23.2009|Wagari
74.04.23.2010|Sribatara
74.04.23.2011|Togomangura
74.04.23.2012|Wasambaa
74.04.23.2013|Benteng
74.04.23.2014|Talaga Baru
74.04.23.2015|Nambo
74.04.24.2006|Ambuau Indah
74.04.24.2007|Kinapani Makmur
74.04.24.2008|Mopaano
74.04.24.2009|Umalaoge
74.04.24.2010|Lasalimu
74.04.24.2011|Wajah Jaya
74.04.24.2012|Siontapina
74.04.24.2013|Siomanuru
74.04.24.2016|Mulya Jaya
74.04.24.2017|Harapan Jaya
74.04.24.2018|Sangia Arano
74.04.24.2019|Megabahari
74.04.24.2020|Sumber Agung
74.04.24.2021|Rejo Sari
74.04.24.2022|Ambuau Togo
74.04.24.2023|Balimu
74.04.27.2001|Walompo
74.04.27.2002|Matanauwe
74.04.27.2003|Sampuabalo
74.04.27.2004|Kuraa
74.04.27.2005|Kumbewaha
74.04.27.2006|Sumber Sari
74.04.27.2007|Labuandiri
74.04.27.2008|Karya Jaya
74.04.27.2009|Manuru
74.04.27.2010|Gunungjaya
74.04.27.2011|Bahari Makmur
74.04.28.2001|Kaumbu
74.04.28.2002|Wolowa
74.04.28.2003|Matawia
74.04.28.2004|Wolowa Baru
74.04.28.2005|Suka Maju
74.04.28.2006|Bungi
74.04.28.2007|Galanti
74.04.29.2001|Wasuemba
74.04.29.2002|Wabula
74.04.29.2003|Wasampela
74.04.29.2004|Holimombo
74.04.29.2005|Koholimembona
74.04.29.2006|Wabula Satu
74.04.29.2007|Bajo Bahari
74.05.01.1001|Tinanggea
74.05.01.1002|Ngapaah
74.05.01.2003|Lapoa
74.05.01.2006|Asingi
74.05.01.2007|Watu Melewe
74.05.01.2009|Wadonggo
74.05.01.2010|Bungin Permai
74.05.01.2014|Palotawo
74.05.01.2019|Lalonggasu
74.05.01.2020|Molo Indah
74.05.01.2021|Telutu Jaya
74.05.01.2023|Torokeku
74.05.01.2024|Lapulu
74.05.01.2027|Roraya
74.05.01.2029|Lanowulu
74.05.01.2030|Lalo Watu
74.05.01.2032|Tatangge
74.05.01.2033|Wundumbolo
74.05.01.2034|Panggoosi
74.05.01.2035|Bomba-bomba
74.05.01.2036|Akuni
74.05.01.2037|Lasuai
74.05.01.2038|Matambawi
74.05.01.2039|Matandahi
74.05.02.2001|Pewutaa
74.05.02.2002|Aopa
74.05.02.2003|Motaha
74.05.02.2004|Lamoen
74.05.02.2005|Puusanggula
74.05.02.2006|Puao
74.05.02.2007|Sandey
74.05.02.2008|Teteasa
74.05.02.2009|Simbangu
74.05.02.2010|Lamooso
74.05.02.2011|Landabaro
74.05.02.2012|Puunggoni
74.05.02.2013|Sandarsi Jaya
74.05.02.2014|Puuroe
74.05.02.2015|Lamoeri
74.05.02.2016|Kasebo
74.05.02.2017|Mataiwoi
74.05.02.2018|Angata
74.05.02.2019|Pudambu
74.05.02.2020|Matabondu
74.05.02.2040|Mokoau
74.05.02.2041|Boloso
74.05.02.2042|Puulipu
74.05.02.2043|Langgea Indah
74.05.03.1002|Alangga
74.05.03.1018|Potoro
74.05.03.2001|Andoolo
74.05.03.2004|Alengge Agung
74.05.03.2010|Bumi Raya
74.05.03.2014|Lalobao
74.05.03.2015|Lalonggombu
74.05.03.2026|Wunduwatu
74.05.03.2031|Punggapu
74.05.03.2033|Ataku
74.05.04.1001|Palangga
74.05.04.2003|Aosole
74.05.04.2005|Anggondara
74.05.04.2007|Eewa
74.05.04.2008|Kiaea
74.05.04.2011|Mekar Sari
74.05.04.2013|Onembute
74.05.04.2018|Waworaha
74.05.04.2019|Watumerembe
74.05.04.2022|Wawouru
74.05.04.2025|Alakaya
74.05.04.2029|Wawonggura
74.05.04.2030|Kapujaya
74.05.04.2031|Watudemba
74.05.04.2032|Sanggi-Sanggi
74.05.05.1001|Landono
74.05.05.2008|Lalonggapu
74.05.05.2009|Watabenua
74.05.05.2014|Tridana Mulia
74.05.05.2015|Landono Dua
74.05.05.2016|Amotowo
74.05.05.2022|Abenggi
74.05.05.2023|Arongo
74.05.05.2024|Endanga
74.05.05.2032|Wonua Sangia
74.05.05.2035|Lakomea
74.05.05.2042|Morini Mulya
74.05.06.2011|Lalonggombu
74.05.06.2013|Watumeeto
74.05.06.2014|Pamandati
74.05.06.2015|Pangan Jaya
74.05.06.2020|Aoreo
74.05.06.2021|Kaindi
74.05.06.2022|Matabubu Jaya
74.05.06.2024|Lainea
74.05.06.2025|Molinese
74.05.06.2026|Polewali
74.05.06.2027|Bangun Jaya
74.05.06.2028|Kalo-kalo
74.05.07.1001|Konda
74.05.07.2002|Puosu Jaya
74.05.07.2003|Lamomea
74.05.07.2004|Alebo
74.05.07.2005|Morome
74.05.07.2006|Lebo Jaya
74.05.07.2007|Lambusa
74.05.07.2008|Pombula Jaya
74.05.07.2009|Ambololi
74.05.07.2010|Tanea
74.05.07.2011|Masagena
74.05.07.2012|Cialam Jaya
74.05.07.2013|Wonua
74.05.07.2014|Lawoila
74.05.07.2019|Lalowiu
74.05.07.2020|Amohalo
74.05.07.2024|Konda Satu
74.05.08.1001|Ranomeeto
74.05.08.2002|Onewila
74.05.08.2004|Boro-Boro R
74.05.08.2005|Rambu-rambu Jaya
74.05.08.2008|Amoito
74.05.08.2014|Ambaipua
74.05.08.2015|Ranooha
74.05.08.2016|Langgea
74.05.08.2017|Kota Bangun
74.05.08.2019|Laikaha
74.05.08.2020|Duduria
74.05.08.2021|Amoito Siama
74.05.09.1001|Kolono
74.05.09.2002|Sawa
74.05.09.2003|Langgowala
74.05.09.2004|Waworano
74.05.09.2005|Matandahi
74.05.09.2006|Puupi
74.05.09.2007|Mataiwoi
74.05.09.2008|Tiraosu
74.05.09.2009|Mondoe Jaya
74.05.09.2010|Ulusena Jaya
74.05.09.2011|Lamotau
74.05.09.2012|Awunio
74.05.09.2013|Meletumbo
74.05.09.2014|Roda
74.05.09.2016|Lamapu
74.05.09.2025|Andinete
74.05.09.2026|Wawoosu
74.05.09.2028|Alosi
74.05.09.2029|Silea
74.05.09.2030|Puudongi
74.05.09.2031|Sarandua
74.05.10.1001|Lapuko
74.05.10.2010|Amohola
74.05.10.2011|Tambosupa
74.05.10.2012|Marga Citta
74.05.10.2013|Moramo
74.05.10.2014|Bakutara
74.05.10.2015|Lakomea
74.05.10.2016|Landipo
74.05.10.2017|Lamboo
74.05.10.2018|Pudaria Jaya
74.05.10.2019|Sumber Sari
74.05.10.2020|Ulusena
74.05.10.2021|Panambea Barata
74.05.10.2022|Wowosunggu
74.05.10.2023|Wawondengi
74.05.10.2025|Watu Porambaa
74.05.10.2026|Wonua Jaya
74.05.10.2027|Bisikori
74.05.10.2028|Ranooha Raya
74.05.10.2029|Selabangga
74.05.11.2001|Labuan Beropa
74.05.11.2002|Tambolosu
74.05.11.2003|Woru Woru
74.05.11.2004|Tambeanga
74.05.11.2005|Labotaone
74.05.11.2006|Batu Jaya
74.05.11.2007|Namu
74.05.11.2008|Malaringgi
74.05.11.2009|Tue Tue
74.05.11.2010|Sangi Sangi
74.05.11.2011|Ulu Sawa
74.05.11.2012|Lawisata
74.05.11.2013|Kondono
74.05.11.2014|Peo Indah
74.05.11.2015|Puundirangga
74.05.11.2016|Cempedak
74.05.11.2017|Laonti
74.05.11.2018|Rumbi-Rumbia
74.05.11.2020|Wandaeha
74.05.12.1005|Atari Indah
74.05.12.2001|Lambodi Jaya
74.05.12.2002|Atari Jaya
74.05.12.2003|Mokupa Jaya
74.05.12.2004|Lambandia
74.05.12.2006|Kapuwila
74.05.12.2007|Puunangga
74.05.12.2008|Teteinea
74.05.12.2009|Puurema Subur
74.05.12.2010|Lalembu Jaya
74.05.12.2011|Sukamukti
74.05.12.2012|Potuho Jaya
74.05.12.2013|Mondoke
74.05.12.2014|Sumber Jaya
74.05.12.2015|Merongga Raya
74.05.12.2016|Tombeleu
74.05.12.2017|Padaleu
74.05.12.2018|Lalouesamba
74.05.13.2001|Lamara
74.05.13.2002|Puuosu
74.05.13.2003|Benua Utama
74.05.13.2004|Horodopi
74.05.13.2005|Benua
74.05.13.2006|Palowewu
74.05.13.2007|Punggawukawu
74.05.13.2008|Uelawa
74.05.13.2009|Tetehaka
74.05.13.2010|Awalo
74.05.13.2011|Kosambi
74.05.13.2012|Puuwehuko
74.05.14.1001|Amondo
74.05.14.2002|Lakara
74.05.14.2003|Parasi
74.05.14.2004|Ulu Lakara
74.05.14.2005|Watumbohoti
74.05.14.2006|Wawowonua
74.05.14.2007|Waturapa
74.05.14.2008|Koeono
74.05.14.2009|Lalowua
74.05.14.2010|Mondoe
74.05.15.2001|Kondoano
74.05.15.2002|Punggulahi
74.05.15.2003|Lamolori
74.05.15.2004|Toluwonua
74.05.15.2005|Mulyasari
74.05.15.2006|Rakawuta
74.05.15.2007|Ranoaopa
74.05.15.2008|Mowila
74.05.15.2009|Lalosingi
74.05.15.2010|Wuura
74.05.15.2011|Pudahoa
74.05.15.2012|Monapa
74.05.15.2013|Puuwehuko
74.05.15.2014|Ranombayasa
74.05.15.2015|Wonua Kongga
74.05.15.2016|Mataiwoi
74.05.15.2017|Lamebara
74.05.15.2018|Tetesingi
74.05.15.2019|Wonua Sari
74.05.15.2020|Wonua Monapa
74.05.16.1002|Lalowaru
74.05.16.2001|Puasana
74.05.16.2003|Tanjung Tiram
74.05.16.2004|Wawatu
74.05.16.2005|Sanggula
74.05.16.2006|Lombuea
74.05.16.2007|Mekar Jaya
74.05.16.2008|Lamokula
74.05.16.2009|Mata Wawatu
74.05.16.2010|Mata Lamokula
74.05.17.2001|Andoolo Utama
74.05.17.2002|Anggokoti
74.05.17.2003|Asembu Mulya
74.05.17.2004|Awalo
74.05.17.2005|Adaka Jaya
74.05.17.2006|Buke
74.05.17.2007|Pelandia
74.05.17.2008|Puudaria
74.05.17.2009|Rahamendaa
74.05.17.2010|Silea Jaya
74.05.17.2011|Tirtamartani
74.05.17.2012|Tetenggolasa
74.05.17.2013|Adayu Indah
74.05.17.2014|Wonua Maroa
74.05.17.2015|Wulele Jaya
74.05.17.2016|Ranooha Lestari
74.05.18.2001|Wolasi
74.05.18.2002|Aoma
74.05.18.2003|Amoito Jaya
74.05.18.2004|Leleka
74.05.18.2005|Mata Wolasi
74.05.18.2006|Ranowila
74.05.18.2007|Aunupe
74.05.19.1001|Puunggaluku
74.05.19.1002|Ambalodangge
74.05.19.2003|Aepodu
74.05.19.2004|Rambu Rambu
74.05.19.2005|Ombu Ombu Jaya
74.05.19.2006|Lamong Jaya
74.05.19.2007|Lerepako
74.05.19.2008|Ambesea
74.05.19.2009|Laeya
74.05.19.2010|Labokeo
74.05.19.2011|Torobulu
74.05.19.2012|Anduna
74.05.19.2013|Ambakumina
74.05.19.2014|Lambakara
74.05.19.2015|Anggoroboti
74.05.19.2016|Wonua Kongga
74.05.19.2017|Puuwulo
74.05.20.2001|Amasara
74.05.20.2002|Baito
74.05.20.2003|Matabubu
74.05.20.2004|Mekar Jaya
74.05.20.2005|Sambahule
74.05.20.2006|Tolihe
74.05.20.2007|Wonua Raya
74.05.20.2008|Ahuangguluri
74.05.21.2001|Iwoimendoro
74.05.21.2002|Epeesi
74.05.21.2003|Lere
74.05.21.2004|Lipumasagena
74.05.21.2005|Lambandia
74.05.21.2006|Polo Pololi
74.05.21.2007|Basala
74.05.21.2008|Tombekuku
74.05.21.2009|Teporombua
74.05.22.2001|Amokuni
74.05.22.2002|Sindang Kasih
74.05.22.2003|Jati Bali
74.05.22.2004|Laikandonga
74.05.22.2005|Boro-Boro Lameuru
74.05.22.2006|Opaasi
74.05.22.2007|Lameuru
74.05.22.2008|Abeko
74.05.22.2009|Tunduno
74.05.23.2001|Rambu-rambu
74.05.23.2002|Lambangi
74.05.23.2003|Tumbu-tumbu Jaya
74.05.23.2004|Ngapawali
74.05.23.2005|Batuh Putih
74.05.23.2006|Rumba-rumba
74.05.23.2007|Ampera
74.05.23.2008|Amolengu
74.05.23.2009|Ulunese
74.05.23.2010|Langgapulu
74.05.24.2001|Sabulakoa
74.05.24.2002|Talumbinga
74.05.24.2003|Tetenggabo
74.05.24.2004|Watu-watu
74.05.24.2005|Karoonua
74.05.24.2006|Ulu Sabulakoa
74.05.24.2007|Asaria
74.05.24.2008|Wawobende
74.05.24.2009|Wonua Koa
74.05.25.2001|Papawu
74.05.25.2002|Anese
74.05.25.2003|Bekenggasu
74.05.25.2004|Watumokala
74.05.25.2005|Mataupe
74.05.25.2006|Bimamaroa
74.05.25.2007|Wawobende
74.05.25.2008|Lapoa Indah
74.05.25.2009|Puundoho
74.05.25.2010|Mataiwoi
74.06.01.1007|Boeara
74.06.01.1008|Kastarib
74.06.01.1010|Boepinang
74.06.01.1015|Boepinang Barat
74.06.01.1016|Barangga
74.06.01.1017|Kasabolo
74.06.01.2009|Pokurumba
74.06.01.2011|Pallimae
74.06.01.2018|Salosa
74.06.01.2019|Mattiro Walie
74.06.02.1011|Bambaea
74.06.02.1015|Puu Lemo
74.06.02.2003|Teppoe
74.06.02.2004|Biru
74.06.02.2010|Mambo
74.06.03.1010|Taubonto
74.06.03.2001|Rau Rau
74.06.03.2008|Ladumpi
74.06.03.2009|Rarowatu
74.06.03.2011|Lakomea
74.06.03.2012|Pangkuri
74.06.03.2013|Lampeantani
74.06.03.2014|Watu Kalangkari
74.06.03.2015|Tahi ite
74.06.04.1002|Lameroro
74.06.04.1003|Lampopala
74.06.04.1004|Doule
74.06.04.1005|Kasipute
74.06.04.2001|Lantawonua
74.06.05.1009|Teomokole
74.06.05.1016|Rahampuu
74.06.05.2010|Rahadopi
74.06.05.2011|Tirongkotua
74.06.06.1009|Dongkala
74.06.06.1010|Lambale
74.06.06.2005|Wumbuburo
74.06.06.2006|Balo
74.06.06.2007|Toli-Toli
74.06.06.2008|Tapuhaka
74.06.06.2011|Bungi-Bungi
74.06.07.2001|Babamolingku
74.06.07.2002|Toari Bombana
74.06.07.2003|Timbala
74.06.07.2004|Ranokomea
74.06.07.2005|Rakadua
74.06.07.2006|Lameo-meong
74.06.07.2007|Pabiring
74.06.07.2008|Balasari
74.06.07.2009|Bulumanai
74.06.07.2010|Matabundu
74.06.07.2011|Analere
74.06.08.2001|Pomontoro
74.06.08.2002|Liano
74.06.08.2003|Pulau Tambako
74.06.08.2004|Lora
74.06.08.2005|Toli-Toli
74.06.08.2006|Tajuncu
74.06.08.2007|Mawar
74.06.08.2008|Laloa
74.06.08.2009|Batu Sempe Indah
74.06.08.2010|Hambawa
74.06.08.2011|Pu'u Waeya
74.06.09.1008|Aneka Marga
74.06.09.2001|Wumbubangka
74.06.09.2002|Hukaea
74.06.09.2003|Lantowua
74.06.09.2004|Tembe
74.06.09.2005|Watu Mentade
74.06.09.2006|Marga Jaya
74.06.09.2007|Tunas Baru
74.06.10.2001|Tampabulu
74.06.10.2002|Tanah Poleang
74.06.10.2003|Karya Baru
74.06.10.2004|Toburi
74.06.10.2005|Rompu Rompu
74.06.10.2006|Pusu Ea
74.06.10.2007|Lawatu Ea
74.06.10.2008|Wambarema
74.06.11.2001|Batu Putih
74.06.11.2002|Waemputang
74.06.11.2003|Kali Baru
74.06.11.2004|Akacipong
74.06.11.2005|La Ea
74.06.12.2001|Larete
74.06.12.2002|Lemo
74.06.12.2003|Terapung
74.06.12.2004|Lamoare
74.06.12.2005|Rambaha
74.06.13.2001|Langkema
74.06.13.2002|Batuawu
74.06.13.2003|Pongkalaero
74.06.13.2004|Puu Nunu
74.06.14.1001|Sikeli
74.06.14.2002|Baliara
74.06.14.2003|Rahantari
74.06.14.2004|Baliara Kepulauan
74.06.14.2005|Baliara Selatan
74.06.15.2001|Mapila
74.06.15.2002|Wumbulasa
74.06.15.2003|Sangia Makmur
74.06.15.2004|Eemokolo
74.06.15.2005|Tedubara
74.06.15.2006|Larolanu
74.06.16.2001|Lamonggi
74.06.16.2002|Tangkeno
74.06.16.2003|Lengora
74.06.16.2004|Enano
74.06.16.2005|Ulungkura
74.06.16.2006|Lengora Selatan
74.06.16.2007|Lengora Pantai
74.06.17.2001|Masaloka
74.06.17.2002|Batu Lamburi
74.06.17.2003|Masaloka Selatan
74.06.17.2004|Masaloka Timur
74.06.17.2005|Masaloka Barat
74.06.18.1001|Lauru
74.06.18.1002|Poea
74.06.18.1003|Kampung Baru
74.06.18.2004|Tapuhahi
74.06.18.2005|Lampata
74.06.19.2001|Mulaeno
74.06.19.2002|Lebo Ea
74.06.19.2003|Paria
74.06.19.2004|Poleondro
74.06.20.2001|Tontonunu
74.06.20.2002|Tongkoseng
74.06.20.2003|Tetehaka
74.06.20.2004|Watu Melomba
74.06.20.2005|Puu Wonua
74.06.21.2001|Lombakasih
74.06.21.2002|Lantari
74.06.21.2003|Langkowala
74.06.21.2004|Pasare Apua
74.06.21.2006|Anugerah
74.06.21.2007|Kalaero
74.06.21.2008|Tinabite
74.06.21.2009|Rarongkeu
74.06.21.2010|Watu-watu
74.06.22.2001|Kolombi Matausu
74.06.22.2002|Morengke
74.06.22.2003|Wia-wia
74.06.22.2004|Lamuru
74.06.22.2005|Totole
74.07.01.1002|Pongo
74.07.01.1003|Wanci
74.07.01.1004|Wandoka
74.07.01.1007|Waetuno
74.07.01.1025|Wandoka Utara
74.07.01.1026|Wandoka Selatan
74.07.01.2005|Sombu
74.07.01.2006|Waha
74.07.01.2008|Tindoi
74.07.01.2009|Maleko
74.07.01.2013|Longa
74.07.01.2022|Pada Raya Makmur
74.07.01.2023|Waelumu
74.07.01.2024|Patuno
74.07.01.2027|Waginopo
74.07.01.2028|Tindoi Timur
74.07.01.2029|Posalu
74.07.01.2030|Koroe Onawa
74.07.01.2031|Wapia-pia
74.07.01.2032|Pookambua
74.07.02.1002|Laolua
74.07.02.1004|Ambeua
74.07.02.1005|Lagiwae
74.07.02.1015|Buranga
74.07.02.2001|Sombano
74.07.02.2003|Samabahari
74.07.02.2006|Ollo
74.07.02.2007|Haruo
74.07.02.2016|Balasuna
74.07.02.2018|Mantigola Makmur
74.07.02.2019|Balasuna Selatan
74.07.02.2020|Ollo Selatan
74.07.02.2021|Waduri
74.07.02.2022|Lewuto
74.07.02.2023|Ambeua Raya
74.07.02.2024|Kalimas
74.07.03.1001|Waha
74.07.03.1016|Onemay
74.07.03.2002|Waitii Barat
74.07.03.2003|Lamanggau
74.07.03.2004|Waiti
74.07.03.2012|Runduma
74.07.03.2015|Patua
74.07.03.2017|Teemoane
74.07.03.2018|Kollo Soha
74.07.03.2019|Patua II
74.07.04.1005|Taipabu
74.07.04.1007|Palahidu
74.07.04.1010|Wali
74.07.04.1012|Rukuwa
74.07.04.2006|Makoro
74.07.04.2008|Kampo Kampo
74.07.04.2009|Lagongga
74.07.04.2011|Palahidu Barat
74.07.04.2013|Jaya Makmur
74.07.05.1016|Mandati II
74.07.05.1017|Mandati I
74.07.05.1025|Mandati III
74.07.05.2011|Kapota
74.07.05.2012|Komala
74.07.05.2013|Wungka
74.07.05.2014|Matahora
74.07.05.2015|Kabita
74.07.05.2018|Mola Utara
74.07.05.2019|Mola Selatan
74.07.05.2020|Numana
74.07.05.2021|Liya Mawi
74.07.05.2022|Liya Togo
74.07.05.2023|Kapota Utara
74.07.05.2024|Kabita Togo
74.07.05.2026|Liya Onemaelangka
74.07.05.2027|Wisata Kolo
74.07.05.2028|Mola Samaturu
74.07.05.2029|Mola Bahari
74.07.05.2030|Mola Nelayan Bhakti
74.07.05.2031|Liya Bahari Indah
74.07.06.2001|Tampara
74.07.06.2002|Kaswari
74.07.06.2003|Pajam
74.07.06.2004|Langge
74.07.06.2005|Tanomeha
74.07.06.2006|Lentea
74.07.06.2007|Darawa
74.07.06.2008|Sandi
74.07.06.2009|Peropa
74.07.06.2010|Tanjung
74.07.07.1001|Patipelong
74.07.07.1002|Tongano Barat
74.07.07.1003|Bahari
74.07.07.1004|Tongano Timur
74.07.07.2005|Timu
74.07.07.2006|Dete
74.07.07.2007|Kulati
74.07.07.2008|Wawaotimu
74.07.07.2009|Kahiyanga
74.07.08.1003|Sowa
74.07.08.1004|Popalia
74.07.08.2001|Waloindi
74.07.08.2002|Oihu
74.07.08.2005|Haka
74.08.01.1001|Lasusua
74.08.01.2002|Pitulua
74.08.01.2003|Rante Limbong
74.08.01.2006|Totallang
74.08.01.2007|Tojabi
74.08.01.2008|Ponggiha
74.08.01.2009|Watuliwu
74.08.01.2010|Sulaho
74.08.01.2015|Patowonua
74.08.01.2016|Babussalam
74.08.01.2017|Batu Ganda Permai
74.08.01.2018|Puncak Monapa
74.08.02.1001|Olo-Oloho
74.08.02.2002|Kosali
74.08.02.2003|Mikuasi
74.08.02.2010|Kasumeeto
74.08.02.2013|Lalombundi
74.08.02.2015|Toaha
74.08.02.2018|Kondara
74.08.02.2019|Sipakainge
74.08.02.2020|Seuwwa
74.08.02.2021|Alipato
74.08.02.2022|Lalume
74.08.03.1001|Batu Putih
74.08.03.2002|Latowu
74.08.03.2003|Mosiku
74.08.03.2004|Lelewawo
74.08.03.2011|Batu Api
74.08.03.2012|Bukit Tinggi
74.08.03.2015|Bukit Baru
74.08.03.2016|Parung Lampe
74.08.03.2017|Puncak Harapan
74.08.03.2020|Tetebawo
74.08.03.2021|Makkuaseng
74.08.04.1004|Rante Angin
74.08.04.2003|Rante Baru
74.08.04.2005|Pohu
74.08.04.2011|Torotuo
74.08.04.2013|Maroko
74.08.04.2014|Landolia
74.08.04.2015|Lawekara
74.08.05.1002|Mala-Mala
74.08.05.2001|Awo
74.08.05.2003|Koroha
74.08.05.2004|Kamisi
74.08.05.2006|Lametuna
74.08.05.2007|Meeto
74.08.05.2009|Kalu-Kaluku
74.08.05.2010|Jabal Nur
74.08.05.2012|Jabal Kubis
74.08.05.2014|Sawangaoha
74.08.05.2018|Ainani Tajriani
74.08.05.2019|Delang-Delang
74.08.06.1003|Lapai
74.08.06.2002|Ngapa
74.08.06.2005|Paruttellang
74.08.06.2008|Puurau
74.08.06.2009|Koreiha
74.08.06.2011|Lawolatu
74.08.06.2012|Tadaumera
74.08.06.2013|Watumotaha
74.08.06.2014|Beringin
74.08.06.2015|Mataiwoi
74.08.06.2016|Nimbuneha
74.08.06.2017|Padaelo
74.08.07.2001|Walasiho
74.08.07.2002|Wawo
74.08.07.2003|Tinukari
74.08.07.2004|Puumbolo
74.08.07.2005|Ulu Wawo
74.08.07.2006|Latawe
74.08.07.2007|Salurengko
74.08.08.2001|Lambai
74.08.08.2002|Latawaro
74.08.08.2003|Lapasi-Pasi
74.08.08.2004|Raoda
74.08.08.2005|Woise
74.08.08.2006|Woitombo
74.08.08.2007|Tebongeano
74.08.09.2001|Watunohu
74.08.09.2002|Lahabaru
74.08.09.2003|Tambuha
74.08.09.2004|Sarona
74.08.09.2005|Sapoiha
74.08.09.2006|Nyule
74.08.09.2007|Samaturu
74.08.09.2008|Lelehao
74.08.10.2001|Lanipa
74.08.10.2002|Majapahit
74.08.10.2003|Labipi
74.08.10.2004|Latali
74.08.10.2005|Pasampang
74.08.10.2006|Tarengga
74.08.10.2007|To'lemo
74.08.10.2008|Salulotong
74.08.10.2009|Powalaa
74.08.10.2010|Kalahunde
74.08.11.2001|Puundoho
74.08.11.2002|Pakue
74.08.11.2003|Lawata
74.08.11.2004|Mataleuno
74.08.11.2005|Teposua
74.08.11.2006|Saludongka
74.08.11.2007|Kalo
74.08.11.2008|Amoe
74.08.11.2009|Lengkong Batu
74.08.12.2001|Porehu
74.08.12.2002|Tobela
74.08.12.2003|Tanggaruru
74.08.12.2004|Ponggi
74.08.12.2005|Larui
74.08.12.2007|Bangsala
74.08.12.2008|Sarambu
74.08.12.2009|Tinuna
74.08.13.2001|Lanipa-Nipa
74.08.13.2002|Ujung Tobaku
74.08.13.2003|Katoi
74.08.13.2004|Simbula
74.08.13.2005|Maruge
74.08.13.2006|Lambuno
74.08.14.2001|Mattiro Bulu
74.08.14.2002|Lawadia
74.08.14.2003|Watumea
74.08.14.2004|Tiwu
74.08.14.2005|Tahibua
74.08.14.2006|Lapolu
74.08.14.2007|Tanggeawo
74.08.15.2001|Lawaki Jaya
74.08.15.2002|Patikala
74.08.15.2003|Tolala
74.08.15.2004|Bahari
74.08.15.2005|Leleulu
74.08.15.2006|Loka
74.09.01.1005|Wanggudu
74.09.01.1009|Asera
74.09.01.2006|Wanggudu Raya
74.09.01.2007|Walalindu
74.09.01.2008|Tangguluri
74.09.01.2010|Amorome
74.09.01.2016|Wawolimbue
74.09.01.2017|Walasolo
74.09.01.2020|Wunduhaka
74.09.01.2024|Tapuwatu
74.09.01.2027|Aseminunulai
74.09.01.2030|Puunggomosi
74.09.01.2031|Puuwanggudu
74.09.01.2032|Longeo Utama
74.09.01.2033|Kota Mulya
74.09.01.2034|Amorome Utama
74.09.01.2035|Andedao
74.09.01.2036|Alaa Wanggudu
74.09.01.2037|Oheo Trans
74.09.02.1001|Lamonae
74.09.02.2002|Padalere
74.09.02.2004|Tetewatu
74.09.02.2006|Culumbatu
74.09.02.2007|Wawoheo
74.09.02.2009|Lamparinga
74.09.02.2010|Lamonae Utama
74.09.02.2012|Wacumelewe
74.09.02.2013|Mata Osole
74.09.02.2014|Pondoa
74.09.02.2020|Wawonsangi
74.09.02.2021|Wawontoaho
74.09.02.2022|Larompana
74.09.02.2023|Wacu Pinodo
74.09.02.2024|Padalere Utama
74.09.03.1003|Langgikima
74.09.03.2001|Molore
74.09.03.2002|Lameruru
74.09.03.2004|Sarimukti
74.09.03.2005|Morombo Pantai
74.09.03.2006|Polora Indah
74.09.03.2007|Pariama
74.09.03.2008|Tobimeita
74.09.03.2009|Alenggo
74.09.03.2010|Mekar Jaya
74.09.03.2011|Molore Pantai
74.09.03.2012|Ngapa Inia
74.09.04.1002|Molawe
74.09.04.2001|Bandaeha
74.09.04.2003|Awila
74.09.04.2004|Mowundo
74.09.04.2005|Mandiodo
74.09.04.2006|Tapunggaya
74.09.04.2007|Mataiwoi
74.09.04.2008|Awila Puncak
74.09.04.2009|Tapuemea
74.09.05.1001|Tinobu
74.09.05.2006|Abola
74.09.05.2007|Belalo
74.09.05.2008|Andeo
74.09.05.2009|Matapila
74.09.05.2010|Andumowu
74.09.05.2011|Basule
74.09.05.2012|Waworaha
74.09.05.2013|Otole
74.09.05.2016|Watukila
74.09.05.2017|Lametono
74.09.05.2020|Larodangge
74.09.05.2024|Tetelupai
74.09.05.2025|Lalowaru
74.09.05.2026|Muara Tinobu
74.09.05.2030|Marombo Pantai
74.09.05.2031|Tokowuta
74.09.06.1004|Lembo
74.09.06.2001|Alo Alo
74.09.06.2002|Puulemo
74.09.06.2003|Padaleu
74.09.06.2005|Bungguosu
74.09.06.2006|Puusiambu
74.09.06.2007|Taipa
74.09.06.2008|Tongalino
74.09.06.2009|Pasir Putih
74.09.06.2010|Laramo
74.09.06.2011|Lapulu
74.09.06.2012|Watuwula
74.09.07.1002|Sawa
74.09.07.2003|Lalembo
74.09.07.2004|Laimeo
74.09.07.2005|Pudonggala
74.09.07.2007|Matanggonawe
74.09.07.2008|Kokapi
74.09.07.2012|Tongauna
74.09.07.2013|Puupi
74.09.07.2016|Pudonggala Utama
74.09.07.2017|Ulu Sawa
74.09.07.2021|Tudungano
74.09.07.2022|Tanjung Laimeo
74.09.07.2023|Panggulawu
74.09.07.2024|Pekaroa
74.09.08.1009|Linomoiyo
74.09.08.2001|Laronaha
74.09.08.2002|Bandaeha
74.09.08.2003|Kota Maju
74.09.08.2004|Landawe
74.09.08.2005|Wiwirano
74.09.08.2006|Mopute
74.09.08.2007|Tadoloiyo
74.09.08.2008|Puuhialu
74.09.08.2010|Sambandete
74.09.08.2011|Paka Indah
74.09.08.2013|Lameoru
74.09.08.2014|Walandawe
74.09.08.2015|Bendewuta
74.09.08.2016|Tinondo
74.09.08.2018|Horoe
74.09.08.2019|Tadoloiyo Trans
74.09.09.1001|Andowia
74.09.09.2002|Lahimbua
74.09.09.2003|Laronanga
74.09.09.2004|Lambudoni
74.09.09.2005|Lamondowo
74.09.09.2006|Labungga
74.09.09.2007|Mataiwoi
74.09.09.2008|Larobende
74.09.09.2009|Puusuli
74.09.09.2010|Banggarema
74.09.09.2011|Amolame
74.09.09.2012|Anggolohipo
74.09.09.2013|Puuwonua
74.09.09.2014|Ambake
74.09.09.2015|Waworate
74.09.10.1002|Bende
74.09.10.2001|Tondowatu
74.09.10.2003|Matandahi
74.09.10.2004|Banggina
74.09.10.2005|Motui
74.09.10.2006|Wawoluri
74.09.10.2007|Lambuluo
74.09.10.2008|Poni Poniki
74.09.10.2009|Puuwonggia
74.09.10.2010|Punggulahi
74.09.10.2011|Sama Subur
74.09.10.2012|Ranombupulu
74.09.10.2013|Tobimeita
74.09.10.2014|Kapolano
74.09.10.2015|Sambasule
74.09.11.2001|Tanjung Bunga
74.09.11.2002|Kampoh Bunga
74.09.11.2003|Lemo Bajo
74.09.11.2004|Barasanga
74.09.11.2005|Wawolesea
74.09.11.2006|Toreo
74.09.11.2007|Otipulu
74.09.11.2009|Kampoh Cina
74.09.12.2001|Boenaga
74.09.12.2002|Waturambaha
74.09.12.2003|Labengki
74.09.12.2004|Morombo
74.09.12.2005|Tapunopaka
74.09.12.2006|Boedingi
74.09.13.2001|Kuratao
74.09.13.2002|Landiwo
74.09.13.2003|Kolosua
74.09.13.2004|Laumoso
74.09.13.2005|Hialu Utama
74.09.13.2006|Polo-polora
74.09.13.2007|Tambakua
74.09.13.2008|Matabaho
74.09.13.2009|Landawe Utama
74.09.13.2010|Mata Benua
74.09.13.2011|Hialu
74.10.01.1008|Bangkudu
74.10.01.1009|Lipu
74.10.01.1010|Lakonea
74.10.01.1012|Lemo
74.10.01.1014|Bonelipu
74.10.01.1016|Sara'ea
74.10.01.1017|Wandaka
74.10.01.2001|Tri Wacu-Wacu
74.10.01.2002|Waculaea
74.10.01.2003|Eelahaji
74.10.01.2004|Tomoahi
74.10.01.2005|Kalibu
74.10.01.2006|Jampaka
74.10.01.2007|Loji
74.10.01.2011|Linsowu
74.10.01.2013|Rombo
74.10.01.2018|Wasalabose
74.10.01.2019|Malalanda
74.10.01.2020|Lemo Ea
74.10.01.2021|Lantagi
74.10.01.2022|Laangke
74.10.01.2023|Kadacua
74.10.01.2024|Banu-Banua Jaya
74.10.02.1004|Kambowa
74.10.02.2001|Bubu
74.10.02.2002|Lahumoko
74.10.02.2003|Morindino
74.10.02.2005|Pongkowulu
74.10.02.2006|Lagundi
74.10.02.2007|Konde
74.10.02.2008|Mata
74.10.02.2009|Bubu Barat
74.10.02.2010|Bente
74.10.02.2011|Baluara
74.10.03.1006|Buranga
74.10.03.1010|Bonegunu
74.10.03.2001|Gunung Sari
74.10.03.2002|Ronta
74.10.03.2003|Waode Angkalo
74.10.03.2004|Langere
74.10.03.2005|Koepisino
74.10.03.2007|Waode Kalowo
74.10.03.2008|Laano Ipi
74.10.03.2009|Eensumala
74.10.03.2013|Tatombuli
74.10.03.2014|Rante Gola
74.10.03.2015|Ngapa'ea
74.10.03.2016|Koboruno
74.10.03.2017|Damai Laborona
74.10.04.2001|Kotawo
74.10.04.2002|Karya Bhakti
74.10.04.2003|Marga Karya
74.10.04.2004|Kasulatombi
74.10.04.2005|Dampala Jaya
74.10.04.2006|Rahmat Baru
74.10.04.2007|Soloy Agung
74.10.04.2008|Bumi Lapero
74.10.04.2009|Karya Mulya
74.10.04.2010|Lambale
74.10.04.2011|Lapandewa
74.10.04.2012|Lauki
74.10.04.2013|Mekar Jaya
74.10.04.2014|Labulanda
74.10.05.2001|Kurolabu
74.10.05.2002|Torombia
74.10.05.2003|Lamoahi
74.10.05.2004|Lanosangia
74.10.05.2005|Pebaoa
74.10.05.2006|Petetea'a
74.10.05.2007|Lelamo
74.10.05.2008|Waode Buri
74.10.05.2009|Ulunambo
74.10.05.2010|Bira
74.10.05.2011|E'erinere
74.10.05.2012|Labelete
74.10.05.2013|Wamboule
74.10.05.2014|Wowonga Jaya
74.10.06.1007|Labuan
74.10.06.1008|Labuan Wolio
74.10.06.2001|Lasiwa
74.10.06.2002|Laeya
74.10.06.2003|Matalagi
74.10.06.2004|Wantulasi
74.10.06.2005|Labuan Bajo
74.10.06.2006|Labaraga
74.10.06.2009|Wamorapa
74.10.06.2010|Sumampeno
74.10.06.2011|Oengkapala
74.10.06.2012|Labuko
74.10.06.2013|Laba Jaya
74.11.01.1002|Rate-rate
74.11.01.1016|Tababu
74.11.01.2001|Simbune
74.11.01.2003|Poni-Poniki
74.11.01.2004|Tawainalu
74.11.01.2005|Woiha
74.11.01.2006|Tasahea
74.11.01.2007|Lara
74.11.01.2008|Tumbudadio
74.11.01.2009|Orawa
74.11.01.2010|Lalingato
74.11.01.2011|Tirawuta
74.11.01.2012|Roko-roko
74.11.01.2013|Loka
74.11.01.2014|Matabondu
74.11.01.2015|Karemotingge
74.11.02.1001|Loea
74.11.02.1002|Simbalae
74.11.02.2003|Lamoare
74.11.02.2004|Iwoikondo
74.11.02.2005|Peatoa
74.11.02.2006|Lalowura
74.11.02.2007|Mataiwoi
74.11.02.2008|Teposua
74.11.02.2009|Tinomu
74.11.03.1001|Ladongi
74.11.03.1002|Atula
74.11.03.1003|Raa-Raa
74.11.03.1004|Welala
74.11.03.2005|Putemata
74.11.03.2009|Lalowosula
74.11.03.2010|Wunggoloko
74.11.03.2011|Anggaloosi
74.11.03.2013|Pombeyoha
74.11.03.2018|Tongandiu
74.11.04.1001|Poli-Polia
74.11.04.2002|Wia-Wia
74.11.04.2003|Pangi-Pangi
74.11.04.2004|Tokai
74.11.04.2005|Andowengga
74.11.04.2006|Taosu
74.11.04.2007|Pole Maju Jaya
74.11.04.2008|Polenga Jaya
74.11.04.2009|Wundubite
74.11.04.2010|Hakambololi
74.11.04.2011|Inotu Mewao
74.11.04.2012|Puundokulo
74.11.05.1002|Penanggo Jaya
74.11.05.2001|Wonuambuteo
74.11.05.2003|Mokupa
74.11.05.2005|Penanggoosi
74.11.05.2007|Lowa
74.11.05.2008|Atolanu
74.11.05.2009|Lere Jaya
74.11.05.2010|Bou
74.11.05.2012|Lambandia
74.11.05.2013|Inotu
74.11.05.2018|Lalolera
74.11.05.2019|Pomburea
74.11.05.2021|Penanggootu
74.11.05.2022|Mondoke
74.11.05.2026|Onemanu
74.11.06.1001|Lalolae
74.11.06.2002|Keisio
74.11.06.2003|Talodo
74.11.06.2004|Lalosingi
74.11.06.2005|Wesalo
74.11.07.1001|Woitombo
74.11.07.1002|Inebenggi
74.11.07.1004|Horodopi
74.11.07.2003|Nelombu
74.11.07.2005|Watupute
74.11.07.2006|Puuosu
74.11.07.2007|Ulu Mowewe
74.11.07.2008|Lapangisi
74.11.07.2009|Sabi-sabila
74.11.07.2010|Lambo Tua
74.11.08.1006|Sanggona
74.11.08.2003|Pehanggo
74.11.08.2004|Tondowatu
74.11.08.2005|Tawanga
74.11.08.2007|Uete
74.11.08.2008|Undolo
74.11.08.2010|Lalombai
74.11.08.2014|Amokuni
74.11.08.2018|Amololu
74.11.08.2019|Aukora
74.11.09.1001|Tinengi
74.11.09.2002|Solewatu
74.11.09.2003|Ambapa
74.11.09.2004|Ameroro
74.11.09.2005|Lamunde
74.11.09.2006|Tawarombadaka
74.11.09.2007|Talata
74.11.09.2008|Weamo
74.11.09.2009|Tawa-tawaro
74.11.09.2010|Singgere
74.11.09.2011|Tutuwi
74.11.09.2012|Iwoimea
74.11.10.2001|Aere
74.11.10.2002|Pekorea
74.11.10.2003|Iwoi Menggura
74.11.10.2004|Iwoimea Jaya
74.11.10.2005|Awiu
74.11.10.2006|Aladadio
74.11.10.2007|Tinete
74.11.10.2008|Taore
74.11.10.2009|Ulundoro
74.11.10.2010|Watuwoha
74.11.10.2011|Rubia
74.11.11.2001|Ueesi
74.11.11.2002|Wesinggote
74.11.11.2003|Konawendepiha
74.11.11.2004|Porabua
74.11.11.2005|Watumendonga
74.11.11.2006|Silui
74.11.11.2007|Ahilulu
74.11.11.2008|Alaaha
74.11.11.2009|Likuwalanapo
74.11.11.2010|Tongauna
74.11.11.2011|Puurau
74.11.12.2001|Gunung Jaya
74.11.12.2002|Lembah Subur
74.11.12.2003|Dangia
74.11.12.2004|Lamosila
74.11.12.2005|Tetewua
74.11.12.2006|Anambada
74.11.12.2007|Talinduka
74.11.12.2008|Tetembuta
74.11.12.2009|Lalongkateba
74.11.12.2010|Wande
74.11.12.2011|Mekar Jaya
74.11.12.2012|Mulia Jaya
74.12.01.1001|Langara Laut
74.12.01.2002|Langara Iwawo
74.12.01.2003|Wawolaa
74.12.01.2004|Langara Indah
74.12.01.2005|Lamoluo
74.12.01.2006|Bukit Permai
74.12.01.2007|Wawobili
74.12.01.2008|Langaro Bajo
74.12.01.2009|Mata Langara
74.12.01.2010|Mata Baho
74.12.01.2011|Lanowatu
74.12.01.2012|Lantula
74.12.01.2013|Pasir Putih
74.12.01.2014|langkowala
74.12.01.2015|Kawa-Kawali
74.12.01.2016|Langara Tanjung Batu
74.12.02.1008|Lansilowo
74.12.02.2001|Waworope
74.12.02.2002|Dongkalaea
74.12.02.2003|Labeau
74.12.02.2004|Tambaone
74.12.02.2005|Palingi
74.12.02.2006|Mawa
74.12.02.2007|Mata Buranga
74.12.02.2009|Tambaone Utama
74.12.02.2010|Wawoea
74.12.02.2011|Palingi Barat
74.12.02.2012|Tumburano
74.12.02.2013|Mataiwoi
74.12.02.2014|Labisa
74.12.02.2015|Mata Bubu
74.12.02.2016|Wawobeau
74.12.02.2017|Tapum Batu
74.12.02.2018|Palingi Timur
74.12.02.2019|Tongalere
74.12.02.2020|Tepolawa
74.12.02.2021|Sawa Indah
74.12.03.1004|Ladianta
74.12.03.2001|Bangun Mekar
74.12.03.2002|Noko
74.12.03.2003|Tangkombuno
74.12.03.2005|Dimba
74.12.03.2006|Mata Dimba
74.12.03.2007|Puurau
74.12.03.2008|Watuondo
74.12.03.2009|Patande
74.12.03.2010|Baho Bubu
74.12.04.1001|Munse
74.12.04.2002|Lebo
74.12.04.2003|Tekonea
74.12.04.2004|Wakadawu
74.12.04.2005|Munse Indah
74.12.04.2006|Lapulu
74.12.04.2007|Laywo Jaya
74.12.04.2008|Nanga
74.12.04.2009|Butuea
74.12.04.2010|Lembono
74.12.04.2011|Saburano
74.12.05.1005|Polara
74.12.05.2001|Nambo Jaya
74.12.05.2002|Masolo
74.12.05.2003|Sinaulu Jaya
74.12.05.2004|Tondonggito
74.12.05.2006|Roko Roko
74.12.05.2007|Dompo-dompo Jaya
74.12.05.2008|Teparoko
74.12.05.2009|Sukarela Jaya
74.12.05.2011|Sainoa Indah
74.12.05.2012|Wunse Jaya
74.12.05.2013|Sinar Masolo
74.12.05.2014|Waturai
74.12.05.2015|Bahaba
74.12.05.2016|Kekea
74.12.06.1006|Sawaea
74.12.06.2001|Wungkolo
74.12.06.2002|Bobolio
74.12.06.2003|Wawosou
74.12.06.2004|Lawey
74.12.06.2005|Baku-baku
74.12.06.2007|Sawapatani
74.12.06.2008|Wawouso Baru
74.12.06.2009|Puuwatu
74.12.06.2010|Wawoone
74.12.06.2011|Langgara Jaya
74.12.07.1003|Lampeapi
74.12.07.2001|Batumea
74.12.07.2002|Wawo Indah
74.12.07.2004|Lamongupa
74.12.07.2005|Tumbu Tumbu Jaya
74.12.07.2006|Morobea
74.12.07.2007|Mekar Sari
74.12.07.2008|Rawa Indah
74.12.07.2009|Lampeapi Baru
74.12.07.2010|Pesue
74.12.07.2011|Puurau
74.12.07.2012|Baho Puu Wulu
74.13.01.2001|Wakoila
74.13.01.2002|Waukuni
74.13.01.2003|Kampobalano
74.13.01.2004|Maperaha
74.13.01.2005|Nihi
74.13.01.2006|Marobea
74.13.01.2007|Ondoke
74.13.01.2008|Lakalamba
74.13.01.2009|Lawada Jaya
74.13.01.2010|Lombu Jaya
74.13.02.2001|Wuna
74.13.02.2002|Lafinde
74.13.02.2003|Waulai
74.13.02.2004|Walelei
74.13.02.2005|Sawerigadi
74.13.02.2006|Bungkolo
74.13.02.2007|Barangka
74.13.02.2008|Lapolea
74.13.03.1007|Wamelai
74.13.03.1008|Lapadaku
74.13.03.2001|Lagadi
74.13.03.2002|Latugho
74.13.03.2003|Latompe
74.13.03.2004|Lalemba
74.13.03.2005|Madampi
74.13.03.2006|Watumela
74.13.04.2001|Lailangga
74.13.04.2002|Lasosodo
74.13.04.2003|Wakontu
74.13.04.2004|Lakanaha
74.13.04.2005|Katobu
74.13.04.2006|Lindo
74.13.04.2007|Kampani
74.13.05.2001|Parura Jaya
74.13.05.2002|Katangana
74.13.05.2003|Kasimpa Jaya
74.13.05.2004|Sangia Tiworo
74.13.05.2005|Barakkah
74.13.06.2001|Kangkunawe
74.13.06.2002|Maginti
74.13.06.2003|Pajala
74.13.06.2004|Abadi Jaya
74.13.06.2005|Gala
74.13.06.2006|Pasipadanga
74.13.06.2007|Bangko
74.13.06.2008|Kembar Maminasa
74.13.07.2001|Wanseriwu
74.13.07.2002|Labukolo
74.13.07.2003|Langku-langku
74.13.07.2004|Mekar Jaya
74.13.07.2005|Wapae Jaya
74.13.07.2006|Momuntu
74.13.07.2007|Lakabu
74.13.07.2008|Suka Damai
74.13.08.2001|Tasipi
74.13.08.2002|Mandike
74.13.08.2003|Bero
74.13.08.2004|Santigi
74.13.08.2005|Tondasi
74.13.08.2006|Santiri
74.13.08.2007|Tiga
74.13.09.1004|Waumere
74.13.09.1005|Tiworo
74.13.09.2001|Katela
74.13.09.2002|Lasama
74.13.09.2003|Sido Makmur
74.13.09.2006|Waturempe
74.13.09.2007|Laworo
74.13.09.2008|Wulanga Jaya
74.13.09.2009|Wandoke
74.13.10.1008|Konawe
74.13.10.2001|Lemoambo
74.13.10.2002|Kasakamu
74.13.10.2003|Tanjung Pinang
74.13.10.2004|Sidamangura
74.13.10.2005|Lakawoghe
74.13.10.2006|Lapokainse
74.13.10.2007|Guali
74.13.10.2009|Kusambi
74.13.10.2010|Bakeramba
74.13.11.2001|Masara
74.13.11.2002|Lahaji
74.13.11.2003|Umba
74.13.11.2004|Kombikuno
74.13.11.2005|Latawe
74.13.11.2006|Tangkumaho
74.14.01.1007|Lakudo
74.14.01.1008|Gu Timur
74.14.01.1010|Boneoge
74.14.01.2001|Metere
74.14.01.2002|Lolibu
74.14.01.2003|Wajogu
74.14.01.2004|Moko
74.14.01.2005|Mone
74.14.01.2006|Matawine
74.14.01.2009|Nepa Mekar
74.14.01.2011|Madongka
74.14.01.2012|Waraa
74.14.01.2013|Wongko Lakudo
74.14.01.2014|One Waara
74.14.01.2015|Teluk Lasongko
74.14.02.2001|Bonemarambe
74.14.02.2002|Wambuloli
74.14.02.2003|Lagili
74.14.02.2004|Bungi
74.14.02.2005|Wantopi
74.14.02.2006|Inulu
74.14.02.2007|Lasori
74.14.02.2008|Batubanawa
74.14.03.1003|Lakorua
74.14.03.2001|Morikana
74.14.03.2002|Lantongau
74.14.03.2004|Lanto
74.14.03.2005|Lalibo
74.14.03.2006|Langkomu
74.14.03.2007|Watorumbe
74.14.03.2008|Watorumbe Bata
74.14.03.2009|Gundu Gundu
74.14.03.2010|Katukobari
74.14.04.1001|Watolo
74.14.04.1002|Mawasangka
74.14.04.2003|Oengkolaki
74.14.04.2004|Banga
74.14.04.2005|Tanailandu
74.14.04.2006|Polindu
74.14.04.2007|Kanapa Napa
74.14.04.2008|Terapung
74.14.04.2009|Wasilomata II
74.14.04.2010|Wasilotama I
74.14.04.2011|Matara
74.14.04.2012|Balobone
74.14.04.2013|Napa
74.14.04.2014|Wakambangura
74.14.04.2015|Kancebungi
74.14.04.2016|Gumanano
74.14.04.2017|Dahiango
74.14.04.2018|Air Bajo
74.14.04.2019|Wakambangura II
74.14.05.1004|Talaga Satu
74.14.05.2001|Kokoe
74.14.05.2002|Talaga Besar
74.14.05.2003|Talaga II
74.14.05.2005|Wulu
74.14.05.2006|Liwulompona
74.14.05.2007|Pangilia
74.14.06.1004|Watulea
74.14.06.1005|Bombonawulu
74.14.06.2001|Bantea
74.14.06.2002|Lakapera
74.14.06.2003|Walando
74.14.06.2006|Waliko
74.14.06.2007|Wakea Kea
74.14.06.2008|Rahia
74.14.06.2009|Wadiabero
74.14.06.2010|Kolowa
74.14.06.2011|Kamama Mekar
74.14.06.2012|Lowu Lowu
74.14.07.1002|Tolandona
74.14.07.2001|Baruta Lestari
74.14.07.2003|Doda Bahari
74.14.07.2004|Baruta
74.14.07.2006|Baruta Analalaki
74.14.07.2007|Tolandona Matanaeo
74.15.01.1002|Busoa
74.15.01.1003|Laompo
74.15.01.1004|Masiri
74.15.01.1005|Majapahit
74.15.01.1010|Lakambau
74.15.01.1011|Molagina
74.15.01.1012|Bandar Batauga
74.15.01.2001|Lawela
74.15.01.2006|Bola
74.15.01.2007|Poogalampa
74.15.01.2008|Lawela Selatan
74.15.01.2009|Lampanairi
74.15.02.1003|Katilombu
74.15.02.1004|Jaya Bakti
74.15.02.1005|Todombulu
74.15.02.2001|Bangun
74.15.02.2002|Wawoangi
74.15.02.2006|Gunung Sejuk
74.15.02.2007|Sandang Pangan
74.15.02.2008|Hendea
74.15.02.2009|Tira
74.15.02.2010|Bahari
74.15.02.2011|Gerak Makmur
74.15.02.2012|Lipu Mangau
74.15.02.2013|Bahari Dua
74.15.02.2014|Bahari Tiga
74.15.02.2015|Windu Makmur
74.15.02.2016|Watiginanda
74.15.03.2001|Lapandewa Makmur
74.15.03.2002|Gaya Baru
74.15.03.2003|Burangasi Rumbia
74.15.03.2004|Burangasi
74.15.03.2005|Lapandewa Kaindea
74.15.03.2006|Lapandewa
74.15.03.2007|Lapandewa Jaya
74.15.04.2001|Batuatas Liwu
74.15.04.2002|Batuatas Barat
74.15.04.2003|Wacuala
74.15.04.2004|Batu Atas Timur
74.15.04.2005|Tolando Jaya
74.15.04.2006|Taduasa
74.15.04.2007|Wambongi
74.15.05.2001|Molona
74.15.05.2002|Mbanua
74.15.05.2003|Lalole
74.15.05.2004|Watuampara
74.15.05.2005|Katampe
74.15.05.2006|Lamaninggara
74.15.05.2007|Kamoali
74.15.05.2008|Mokobeau
74.15.06.2001|Biwinapada
74.15.06.2002|Kaimbulawa
74.15.06.2003|Wakinamboro
74.15.06.2004|Tongali
74.15.06.2005|Lontoi
74.15.06.2006|Karae
74.15.06.2007|Batuawu
74.15.06.2008|Nggulanggula
74.15.06.2009|Waindawula
74.15.06.2010|Lapara
74.15.07.2001|Waonu
74.15.07.2002|Kaofe
74.15.07.2003|Uwemaasi
74.15.07.2004|Lipu
74.15.07.2005|Kapoa
74.15.07.2006|Banabungi
74.15.07.2007|Mawambunga
74.15.07.2008|Banabungi Selatan
74.15.07.2009|Marawali
74.15.07.2010|Kapoa Barat
74.71.01.1005|Mandonga
74.71.01.1006|Korumba
74.71.01.1007|Labibia
74.71.01.1008|Wawombalata
74.71.01.1009|Alolama
74.71.01.1010|Anggilowu
74.71.02.1009|Kandai
74.71.02.1010|Gunung Jati
74.71.02.1011|Kampung Salo
74.71.02.1012|Mangga Dua
74.71.02.1013|Kendari Caddi
74.71.02.1014|Kassilampe
74.71.02.1015|Mata
74.71.02.1016|Purirano
74.71.02.1017|Jati Mekar
74.71.03.1001|Baruga
74.71.03.1002|Lepo Lepo
74.71.03.1007|Watubangga
74.71.03.1008|Wundudopi
74.71.04.1003|Andonohu
74.71.04.1004|Rahandouna
74.71.04.1005|Anggoeya
74.71.04.1006|Matabubu
74.71.04.1021|Wundumbatu
74.71.05.1001|Kemaraya
74.71.05.1002|Watu-Watu
74.71.05.1003|Tipulu
74.71.05.1004|Punggaloba
74.71.05.1005|Benu Benua
74.71.05.1006|Sodohoa
74.71.05.1007|Sanua
74.71.05.1008|Dapu Dapura
74.71.05.1009|Lahundape
74.71.06.1001|Puday
74.71.06.1002|Lapulu
74.71.06.1003|Abeli
74.71.06.1004|Benuanirae
74.71.06.1006|Anggalomelai
74.71.06.1007|Talia
74.71.06.1008|Poasia
74.71.07.1001|Wua Wua
74.71.07.1002|Bonggoeya
74.71.07.1003|Mataiwoi
74.71.07.1004|Anawai
74.71.08.1001|Kadia
74.71.08.1002|Bende
74.71.08.1003|Pondambea
74.71.08.1004|Wowawanggu
74.71.08.1005|Anaiwoi
74.71.09.1001|Puuwatu
74.71.09.1002|Watulondo
74.71.09.1003|Punggolaka
74.71.09.1004|Tobuuha
74.71.09.1005|Abeli Dalam
74.71.09.1006|Lalodati
74.71.10.1001|Kambu
74.71.10.1002|Mokoau
74.71.10.1003|Padaleu
74.71.10.1004|Lalolara
74.71.11.1001|Tobimeita
74.71.11.1002|Petoaha
74.71.11.1003|Nambo
74.71.11.1004|Bungkutoko
74.71.11.1005|Sambuli
74.71.11.1006|Tondonggeu
74.72.01.1007|Katobengke
74.72.01.1012|Waborobo
74.72.01.1013|Sulaa
74.72.01.1014|Lipu
74.72.01.1016|Labalawa
74.72.02.1001|Wale
74.72.02.1002|Tomba
74.72.02.1003|Bataraguru
74.72.02.1004|Wangkanapi
74.72.02.1005|Batulo
74.72.02.1007|Kadolo Katapi
74.72.02.1011|Bukit Wolio Indah
74.72.03.1001|Kaisabu Baru
74.72.03.1002|Karya Baru
74.72.03.1003|Gonda Baru
74.72.03.1004|Bugi
74.72.04.1001|Liabuku
74.72.04.1002|Ngkaring Karing
74.72.04.1003|Kampeonaho
74.72.04.1008|Waliabuku
74.72.04.1010|Tampuna
74.72.05.1001|Liwuto
74.72.05.1002|Sukanaeyo
74.72.05.1003|Lakologou
74.72.05.1004|Waruruma
74.72.05.1005|Kadolomoko
74.72.05.1006|Kadolo
74.72.06.1007|Wajo
74.72.06.1008|Lamangga
74.72.06.1009|Melai
74.72.06.1010|Baadia
74.72.06.1011|Tanganapada
74.72.07.1001|Lowu-Lowu
74.72.07.1002|Kalia-Lia
74.72.07.1003|Palabusa
74.72.07.1004|Kolese
74.72.07.1005|Kantalai
74.72.08.1001|Bonebone
74.72.08.1002|Tarafu
74.72.08.1003|Wameo
74.72.08.1004|Kaobula
74.72.08.1005|Lanto
74.72.08.1006|Nganganaumala
75.01.01.1001|Kayubulan
75.01.01.1002|Kayumerah
75.01.01.1003|Hunggaluwa
75.01.01.1004|Bolihuangga
75.01.01.1005|Hepuhulawa
75.01.01.1006|Hutuo
75.01.01.1007|Dutulanaa
75.01.01.1008|Tenilo
75.01.01.1009|Biyonga
75.01.01.1010|Bongohulawa
75.01.01.1011|Bulota
75.01.01.1012|Malahu
75.01.01.1013|Tilihuwa
75.01.01.1014|Polohungo
75.01.02.2011|Bulila
75.01.02.2014|Mongolato
75.01.02.2015|Luhu
75.01.02.2016|Hulawa
75.01.02.2017|Pilohayanga
75.01.02.2018|Dulamayo Selatan
75.01.02.2019|Dulamayo Barat
75.01.02.2020|Dulohupa
75.01.02.2021|Pilohayanga Barat
75.01.03.2001|Iluta
75.01.03.2002|Bua
75.01.03.2003|Huntu
75.01.03.2004|Payunga
75.01.03.2012|Barakati
75.01.03.2013|Ilohungayo
75.01.03.2014|Dunggala
75.01.03.2015|Pilobuhuta
75.01.04.2001|Isimu Utara
75.01.04.2002|Isimu Selatan
75.01.04.2003|Datahu
75.01.04.2004|Tolotio
75.01.04.2005|Labanu
75.01.04.2006|Reksonegoro
75.01.04.2007|Buhu
75.01.04.2008|Dunggala
75.01.04.2009|Molowahu
75.01.04.2010|Iloponu
75.01.04.2011|Ilomata
75.01.04.2012|Motilango
75.01.04.2013|Isimu Raya
75.01.04.2014|Balahu
75.01.04.2015|Botumoputi
75.01.04.2016|Ulobua
75.01.05.2004|Tontayuo
75.01.05.2005|Biluhu Timur
75.01.05.2006|Kayubulan
75.01.05.2007|Bongo
75.01.05.2008|Lopo
75.01.05.2009|Lamu
75.01.05.2012|Olimoo'o
75.01.05.2014|Buhudaa
75.01.05.2015|Langgula
75.01.09.2001|Sidomulyo
75.01.09.2004|Parungi
75.01.09.2006|Diloniyohu
75.01.09.2007|Sidodadi
75.01.09.2010|Potanga
75.01.09.2011|Motoduto
75.01.09.2012|Iloheluma
75.01.09.2014|Monggolito
75.01.09.2015|Bandung Rejo
75.01.09.2018|Dulohupa
75.01.09.2019|Sidomulya Selatan
75.01.09.2020|Bongongoayu
75.01.09.2021|Tolite
75.01.10.2001|Dulamayo Utara
75.01.10.2002|Ulapato A
75.01.10.2003|Ulapato B
75.01.10.2004|Talumelito
75.01.10.2005|Tuladenggi
75.01.10.2006|Pantungo
75.01.10.2007|Lupoyo
75.01.10.2008|Pentadio Timur
75.01.10.2009|Pentadio Barat
75.01.10.2010|Dumati
75.01.10.2011|Modelidu
75.01.10.2012|Tinelo
75.01.10.2013|Timuato
75.01.10.2014|Tapaluluo
75.01.10.2015|Tonala
75.01.11.2001|Dulamayo
75.01.11.2008|Upomela
75.01.11.2009|Tohupo
75.01.11.2010|Molanihu
75.01.11.2011|Molopatodu
75.01.11.2012|Molas
75.01.11.2013|Batulayar
75.01.11.2014|Batuloreng
75.01.11.2015|Bongohulawa
75.01.11.2016|Otopade
75.01.11.2018|Huntu Lo Hulawa
75.01.11.2022|Owalanga
75.01.11.2023|Liyodu
75.01.11.2024|Liyoto
75.01.11.2025|Kayumerah
75.01.13.2001|Sukamakmur
75.01.13.2002|Lakeya
75.01.13.2003|Gandasari
75.01.13.2004|Molohu
75.01.13.2007|Polohungo
75.01.13.2008|Bina Jaya
75.01.13.2009|Tamaila
75.01.13.2010|Sidoarjo
75.01.13.2013|Sukamakmur Utara
75.01.13.2014|Margomulya
75.01.13.2015|Makmur Abadi
75.01.13.2016|Gandaria
75.01.13.2017|Ombulo Tango
75.01.13.2018|Tamaila Utara
75.01.13.2019|Himalaya
75.01.14.2001|Paris
75.01.14.2002|Helumo
75.01.14.2003|Pilomonu
75.01.14.2004|Satria
75.01.14.2005|Karyamukti
75.01.14.2006|Talumopatu
75.01.14.2007|Sidomukti
75.01.14.2008|Payu
75.01.14.2009|Sukamaju
75.01.14.2010|Huyula
75.01.16.2001|Pongongaila
75.01.16.2002|Pulubala
75.01.16.2003|Molamahu
75.01.16.2004|Bakti
75.01.16.2005|Tridharma
75.01.16.2006|Molalahu
75.01.16.2007|Mulyonegoro
75.01.16.2008|Puncak
75.01.16.2009|Toyidito
75.01.16.2010|Ayumolingo
75.01.16.2011|Bukit Aren
75.01.17.2001|Pone
75.01.17.2002|Huidu
75.01.17.2003|Ombulo
75.01.17.2004|Daenaa
75.01.17.2005|Yosonegoro
75.01.17.2006|Tunggulo
75.01.17.2007|Hutabohu
75.01.17.2008|Padengo
75.01.17.2009|Haya-Haya
75.01.17.2010|Huidu Utara
75.01.18.2001|Tualango
75.01.18.2002|Dulomo
75.01.18.2003|Tilote
75.01.18.2004|Tabumela
75.01.18.2005|Ilotidea
75.01.18.2006|Lauwonu
75.01.18.2007|Tenggela
75.01.18.2008|Tinelo
75.01.19.2001|Tabongo Timur
75.01.19.2002|Tabongo Barat
75.01.19.2003|Limehe Barat
75.01.19.2004|Limehe Timur
75.01.19.2005|Ilomangga
75.01.19.2006|Motinelo
75.01.19.2007|Moahudu
75.01.19.2008|Teratai
75.01.19.2009|Limehu
75.01.20.2001|Biluhu Barat
75.01.20.2002|Lobuto
75.01.20.2003|Biluhu Tengah
75.01.20.2004|Luluo
75.01.20.2005|Huwongo
75.01.20.2006|Lobuto Timur
75.01.20.2007|Botubolu'o
75.01.20.2008|Olimeyala
75.01.21.2001|Bululi
75.01.21.2002|Mohiyolo
75.01.21.2003|Pangahu
75.01.21.2004|Karya Indah
75.01.21.2005|Prima
75.01.21.2006|Tiohu
75.01.21.2007|Olimohulo
75.01.21.2008|Karya Baru
75.01.21.2009|Bontula
75.01.21.2010|Bihe
75.01.22.2001|Hutadaa
75.01.22.2002|Buhu
75.01.22.2003|Luwoo
75.01.22.2004|Bunggalo
75.01.22.2005|Bulota
75.01.23.2001|Totopo
75.01.23.2002|Bilato
75.01.23.2003|Ilomata
75.01.23.2004|Taula'a
75.01.23.2005|Juriya
75.01.23.2006|Pelehu
75.01.23.2007|Bumela
75.01.23.2008|Lamahu
75.01.23.2009|Musyawarah
75.01.23.2010|Suka Damai
75.01.24.2001|Pilolalenga
75.01.24.2002|Kaliyoso
75.01.24.2003|Dungaliyo
75.01.24.2004|Ambara
75.01.24.2005|Bongomeme
75.01.24.2006|Duwanga
75.01.24.2007|Ayuhula
75.01.24.2008|Pangadaa
75.01.24.2009|Botubulowe
75.01.24.2010|Momala
75.02.01.2004|Bongo Nol
75.02.01.2005|Bongo IV
75.02.01.2006|Molombulahe
75.02.01.2007|Mutiara
75.02.01.2008|Saripi
75.02.01.2009|Wonggahu
75.02.01.2010|Tangkobu
75.02.01.2011|Bongo Tua
75.02.01.2012|Kuala Lumpur
75.02.01.2013|Mustika
75.02.01.2014|Tenilo
75.02.01.2015|Huwongo
75.02.01.2016|Karya Murni
75.02.01.2019|Girisa
75.02.01.2020|Batu Kramat
75.02.01.2021|Bualo
75.02.01.2022|Sosial
75.02.01.2023|Permata
75.02.01.2024|Hulawa
75.02.01.2025|Balate Jaya
75.02.01.2026|Rejonegoro
75.02.01.2027|Diloato
75.02.02.2001|Harapan
75.02.02.2002|Bongo II
75.02.02.2003|Bongo III
75.02.02.2004|Mekarjaya
75.02.02.2005|Sukamaju
75.02.02.2006|Pangeya
75.02.02.2007|Jatimulya
75.02.02.2008|Suka Mulya
75.02.02.2009|Sari Tani
75.02.02.2010|Dimito
75.02.02.2011|Tanjung Harapan
75.02.02.2012|Raharja
75.02.02.2013|Trirukun
75.02.02.2014|Dulohupa
75.02.03.2001|Dulupi
75.02.03.2002|Tabongo
75.02.03.2003|Kotaraja
75.02.03.2004|Polohungo
75.02.03.2005|Pangi
75.02.03.2006|Tangga Jaya
75.02.03.2007|Tanah Putih
75.02.03.2008|Tangga Barito
75.02.04.2001|Limbato
75.02.04.2002|Piloliyanga
75.02.04.2003|Ayuhulalo
75.02.04.2004|Hungayonaa
75.02.04.2005|Modelomo
75.02.04.2006|Pentadu Barat
75.02.04.2007|Pentadu Timur
75.02.04.2008|Bajo
75.02.04.2009|Mohungo
75.02.04.2010|Lahumbo
75.02.04.2011|Lamu
75.02.04.2018|Tenilo
75.02.05.2001|Tabulo
75.02.05.2002|Kaaruyan
75.02.05.2003|Salilama
75.02.05.2004|Bendungan
75.02.05.2005|Mananggu
75.02.05.2006|Buti
75.02.05.2007|Pontolo
75.02.05.2008|Kramat
75.02.05.2009|Tabulo Selatan
75.02.06.2001|Tutulo
75.02.06.2002|Hutamonu
75.02.06.2003|Patoameme
75.02.06.2004|Tapadaa
75.02.06.2005|Potanga
75.02.06.2006|Botumoito
75.02.06.2007|Bolihutuo
75.02.06.2008|Rumbia
75.02.06.2009|Dulangeya
75.02.07.2001|Bubaa
75.02.07.2002|Lito
75.02.07.2003|Limbatihu
75.02.07.2004|Bukit Karya
75.02.07.2005|Apitalawu
75.02.07.2006|Bangga
75.02.07.2007|Towayu
75.02.07.2008|Olibu
75.03.01.2004|Talumopatu
75.03.01.2005|Talulobutu
75.03.01.2006|Dunggala
75.03.01.2007|Langge
75.03.01.2027|Talulobutu Selatan
75.03.01.2028|Keramat
75.03.01.2029|Meranti
75.03.02.1008|Padengo
75.03.02.1009|Olohuta
75.03.02.1010|Tumbihe
75.03.02.1011|Pauwo
75.03.02.1028|Olohuta Utara
75.03.02.2006|Dutohe
75.03.02.2007|Tanggilingo
75.03.02.2012|Toto Selatan
75.03.02.2013|Poowo
75.03.02.2024|Talango
75.03.02.2026|Poowo Barat
75.03.02.2029|Dutohe Barat
75.03.03.2011|Tingkohubu
75.03.03.2012|Boludawa
75.03.03.2013|Bube
75.03.03.2014|Huluduotamo
75.03.03.2020|Ulanta
75.03.03.2021|Tinelo
75.03.03.2022|Bubeya
75.03.03.2023|Bube Baru
75.03.03.2027|Tingkohubu Timur
75.03.03.2028|Helumo
75.03.04.2003|Tamboo
75.03.04.2004|Bilungala
75.03.04.2005|Uabanga
75.03.04.2008|Tolotio
75.03.04.2012|Tongo
75.03.04.2025|Bilungala Utara
75.03.04.2026|Tihu
75.03.04.2027|Tunas Jaya
75.03.04.2028|Lembah Hijau
75.03.04.2029|Batu Hijau
75.03.04.2031|Ombulo Hijau
75.03.04.2032|Kemiri
75.03.04.2033|Pelita Hijau
75.03.05.2001|Boidu
75.03.05.2002|Bandungan
75.03.05.2003|Tupa
75.03.05.2004|Longalo
75.03.05.2009|Tuloa
75.03.05.2010|Kopi
75.03.05.2011|Lomaya
75.03.05.2012|Suka Damai
75.03.05.2015|Bunuo
75.03.06.2001|Bongoime
75.03.06.2002|Bongopini
75.03.06.2003|Toto Utara
75.03.06.2004|Moutong
75.03.06.2005|Tunggulo
75.03.06.2006|Lonuo
75.03.06.2007|Tamboo
75.03.06.2008|Iloheluma
75.03.06.2009|Motilango
75.03.06.2010|Butu
75.03.06.2011|Permata
75.03.06.2012|Tunggulo Selatan
75.03.06.2013|Bongohulawa
75.03.06.2014|Berlian
75.03.07.2001|Timbuolo
75.03.07.2002|Panggulo
75.03.07.2003|Luwohu
75.03.07.2004|Buata
75.03.07.2005|Timbuolo Timur
75.03.07.2006|Tanah Putih
75.03.07.2007|Panggulo Barat
75.03.07.2008|Timbuolo Tengah
75.03.07.2009|Sukma
75.03.08.2001|Huangobotu
75.03.08.2002|Molutabu
75.03.08.2003|Oluhuta
75.03.08.2004|Olele
75.03.08.2005|Botutonuo
75.03.08.2006|Modelomo
75.03.08.2007|Biluango
75.03.08.2008|Botubarani
75.03.08.2009|Bintalahe
75.03.09.2001|Taludaa
75.03.09.2002|Sogitia
75.03.09.2003|Moodulio
75.03.09.2004|Bilonlantunga
75.03.09.2005|Inogaluma
75.03.09.2006|Monano
75.03.09.2007|Tumbuh Mekar
75.03.09.2008|Molamahu
75.03.09.2009|Masiaga
75.03.09.2010|Ilohuuwa
75.03.09.2011|Muara Bone
75.03.09.2012|Cendana Putih
75.03.09.2013|Waluhu
75.03.09.2014|Permata
75.03.10.2001|Inomata
75.03.10.2003|Tumbulilato
75.03.10.2004|Mootayu
75.03.10.2006|Mootinelo
75.03.10.2009|Pelita Jaya
75.03.10.2010|Moopiya
75.03.10.2011|Alo
75.03.10.2012|Laut Biru
75.03.10.2014|Bunga
75.03.10.2015|Mootawa
75.03.11.2001|Tulabolo
75.03.11.2003|Dumbaya Bulan
75.03.11.2004|Tulabolo Timur
75.03.11.2005|Tilangobula
75.03.11.2007|Poduwoma
75.03.11.2008|Panggulo
75.03.11.2009|Tulabolo Barat
75.03.11.2010|Pangi
75.03.11.2011|Tinemba
75.03.12.2001|Bulontala
75.03.12.2002|Libungo
75.03.12.2003|Molintogupo
75.03.12.2004|Bonedaa
75.03.12.2005|Bondawuna
75.03.12.2006|Bulontala Timur
75.03.12.2007|Pancuran
75.03.12.2008|Bondaraya
75.03.13.2001|Lompotoo
75.03.13.2002|Lombongo
75.03.13.2003|Duano
75.03.13.2004|Tolomato
75.03.13.2005|Alale
75.03.13.2006|Tapadaa
75.03.14.2001|Mongiilo
75.03.14.2002|Owata
75.03.14.2003|Mongiilo Utara
75.03.14.2004|Pilolaheya
75.03.14.2005|Ilomata
75.03.14.2006|Suka Makmur
75.03.15.2001|Ayula Selatan
75.03.15.2002|Huntu Utara
75.03.15.2003|Ayula Utara
75.03.15.2004|Huntu Selatan
75.03.15.2006|Ayula Tilango
75.03.15.2007|Ayula Timur
75.03.15.2008|Lamahu
75.03.15.2009|Tinelo Ayula
75.03.15.2010|Sejahtera
75.03.15.2011|Huntu Barat
75.03.16.2001|Bulotalangi
75.03.16.2002|Toluwaya
75.03.16.2003|Popodu
75.03.16.2004|Bulotalangi Timur
75.03.16.2005|Bulotalangi Barat
75.03.17.2001|Mamungaa
75.03.17.2002|Kaidundu Barat
75.03.17.2003|Mopuya
75.03.17.2004|Kaidundu
75.03.17.2005|Bukit Hijau
75.03.17.2006|Mamungaa Timur
75.03.17.2007|Dunggilata
75.03.17.2008|Pinomotiga
75.03.17.2009|Patoa
75.03.18.2001|Pinogu
75.03.18.2002|Bangio
75.03.18.2003|Dataran Hijau
75.03.18.2004|Pinogu Permai
75.03.18.2005|Tilonggibila
75.04.01.2003|Torosiaje Jaya
75.04.01.2004|Popayato
75.04.01.2008|Telaga
75.04.01.2012|Torosiaje
75.04.01.2015|Bukit Tingki
75.04.01.2016|Tunas Harapan
75.04.01.2017|Trikora
75.04.01.2018|Dambalo
75.04.01.2019|Telaga Biru
75.04.01.2020|Bumi Bahari
75.04.02.2001|Lemito
75.04.02.2002|Wonggarasi Barat
75.04.02.2004|Lomuli
75.04.02.2008|Lemito Utara
75.04.02.2009|Kenari
75.04.02.2010|Wonggarasi Tengah
75.04.02.2011|Suka Damai
75.04.02.2012|Babalonge
75.04.03.2001|Motolohu
75.04.03.2002|Imbodu
75.04.03.2003|Manunggal Karya
75.04.03.2004|Sidorukun
75.04.03.2008|Sarimurni
75.04.03.2009|Huyula
75.04.03.2012|Omayuwa
75.04.03.2013|Ayula
75.04.03.2014|Patuhu
75.04.03.2015|Banuroja
75.04.03.2016|Pelambane
75.04.03.2017|Motolohu Selatan
75.04.03.2018|Sidowonge
75.04.04.2003|Marisa Selatan
75.04.04.2004|Marisa Utara
75.04.04.2007|Teratai
75.04.04.2008|Pohuwato
75.04.04.2015|Botubilotahu
75.04.04.2016|Palopo
75.04.04.2017|Pohuwato Timur
75.04.04.2018|Bulangita
75.04.05.1001|Libuo
75.04.05.1002|Pentadu
75.04.05.1003|Siduan
75.04.05.2004|Bunuyo
75.04.05.2005|Sipayo
75.04.05.2006|Soginti
75.04.05.2010|Bumbulan
75.04.05.2012|Maleo
75.04.05.2013|Molamahu
75.04.05.2014|Buhu Jaya
75.04.05.2015|Kemiri
75.04.06.2001|Iloheluma
75.04.06.2002|Balayo
75.04.06.2003|Suka Makmur
75.04.06.2004|Manawa
75.04.06.2005|Dulomo
75.04.06.2006|Dudepo
75.04.07.2001|Pancakarsa I
75.04.07.2002|Pancakarsa II
75.04.07.2003|Makarti Jaya
75.04.07.2004|Kalimas
75.04.07.2005|Malango
75.04.07.2006|Puncak Jaya
75.04.07.2007|Tirto Asri
75.04.08.2001|Popaya
75.04.08.2002|Karya Baru
75.04.08.2003|Karangetang
75.04.08.2004|Padengo
75.04.08.2005|Hutamoputi
75.04.09.2001|Hulawa
75.04.09.2002|Karya Indah
75.04.09.2003|Taluduyunu
75.04.09.2004|Buntulia Utara
75.04.09.2005|Buntulia Tengah
75.04.09.2006|Taluduyunu Utara
75.04.09.2007|Sipatana
75.04.10.2001|Bulili
75.04.10.2002|Buntulia Barat
75.04.10.2003|Buntulia Selatan
75.04.10.2004|Duhiadaa
75.04.10.2005|Mekar Jaya
75.04.10.2006|Buntulia Jaya
75.04.10.2007|Padengo
75.04.10.2008|Mootilango
75.04.11.2001|Wonggarasi Timur
75.04.11.2002|Bukit Harapan
75.04.11.2003|Bohusami
75.04.11.2004|Lembah Permai
75.04.11.2005|Limbula
75.04.11.2006|Yipilo
75.04.11.2007|Tuweya
75.04.12.2001|Milangodaa
75.04.12.2002|Londoun
75.04.12.2003|Marisa
75.04.12.2004|Tahele
75.04.12.2005|Bunto
75.04.12.2006|Maleo
75.04.12.2007|Kelapa Lima
75.04.13.2001|Dudewulo
75.04.13.2002|Tunas Jaya
75.04.13.2003|Padengo
75.04.13.2004|Molosipat
75.04.13.2005|Butungale
75.04.13.2006|Persatuan
75.04.13.2007|Molosipat Utara
75.05.01.2003|Imana
75.05.01.2004|Bintana
75.05.01.2005|Buata
75.05.01.2006|Pinontoyonga
75.05.01.2007|Monggupo
75.05.01.2008|Kotajin
75.05.01.2011|Ilomata
75.05.01.2013|Iloheluma
75.05.01.2014|Wapalo
75.05.01.2015|Posono
75.05.01.2016|Sigaso
75.05.01.2017|Tombulilato
75.05.01.2018|Kotajin Utara
75.05.01.2019|Oluhuta
75.05.02.2001|Pontolo
75.05.02.2002|Molingkapoto
75.05.02.2003|Leboto
75.05.02.2004|Posso
75.05.02.2005|Titidu
75.05.02.2006|Moluo
75.05.02.2010|Mootinelo
75.05.02.2011|Bualemo
75.05.02.2013|Bulalo
75.05.02.2017|Katialada
75.05.02.2019|Ombulodata
75.05.02.2021|Alata Karya
75.05.02.2023|Cisadane
75.05.02.2024|Botuwombato
75.05.02.2025|Botungobungo
75.05.02.2026|Molingkapoto Selatan
75.05.02.2030|Pontolo Atas
75.05.02.2032|Masuru
75.05.03.2001|Ilangata
75.05.03.2002|Tolongio
75.05.03.2006|Tolango
75.05.03.2007|Popalo
75.05.03.2008|Dudepo
75.05.03.2009|Mootilango
75.05.03.2011|Langge
75.05.03.2012|Tutuwoto
75.05.03.2013|Hiyalooile
75.05.03.2014|Ibarat
75.05.03.2017|Iloheluma
75.05.03.2021|Ilodulunga
75.05.03.2023|Putiana
75.05.03.2024|Helumo
75.05.03.2025|Datahu
75.05.04.2001|Bulontiyo Timur
75.05.04.2002|Bulontiyo Barat
75.05.04.2007|Buloila
75.05.04.2009|Kasia
75.05.04.2010|Kikia
75.05.04.2012|Tumba
75.05.04.2013|Mebongo
75.05.04.2014|Lelato
75.05.04.2016|Pulohenti
75.05.04.2019|Puncak Mandiri
75.05.04.2020|Hutakalo
75.05.05.2001|Tolinggula Tengah
75.05.05.2002|Tolinggula Pantai
75.05.05.2003|Tolinggula Ulu
75.05.05.2006|Limbato
75.05.05.2007|Papualangi
75.05.05.2008|Molangga
75.05.05.2011|Cempaka Putih
75.05.05.2014|Tolite Jaya
75.05.05.2017|Ilomangga
75.05.05.2018|Ilotunggula
75.05.06.2001|Gentuma
75.05.06.2002|Dumolodo
75.05.06.2003|Molonggota
75.05.06.2004|Ipilo
75.05.06.2005|Langke
75.05.06.2006|Pasalae
75.05.06.2007|Nanati Jaya
75.05.06.2008|Ketapang
75.05.06.2009|Motomingo
75.05.06.2010|Durian
75.05.06.2011|Bohusami
75.05.07.2001|Dambalo
75.05.07.2002|Milango
75.05.07.2003|Jembatan Merah
75.05.07.2004|Bubode
75.05.07.2005|Leyao
75.05.07.2006|Molantadu
75.05.07.2007|Huidu Melito
75.05.07.2008|Bulango Raya
75.05.07.2009|Tanjung Karang
75.05.07.2010|Mutiara Laut
75.05.08.2001|Ponelo
75.05.08.2002|Malambe
75.05.08.2003|Otiola
75.05.08.2004|Tihengo
75.05.09.2001|Monano
75.05.09.2002|Tudi
75.05.09.2003|Monas
75.05.09.2004|Dunu
75.05.09.2005|Garapia
75.05.09.2006|Sogu
75.05.09.2007|Pilohulata
75.05.09.2008|Mokonowu
75.05.09.2009|Tolitehuyu
75.05.09.2010|Zuriyati
75.05.10.2001|Biau
75.05.10.2002|Omuto
75.05.10.2003|Luhuto
75.05.10.2004|Windu
75.05.10.2005|Topi
75.05.10.2006|Sembihingan
75.05.10.2007|Didingga
75.05.10.2008|Bualo
75.05.10.2009|Potanga
75.05.10.2010|Bohulo
75.05.11.2001|Deme i
75.05.11.2002|Buluwatu
75.05.11.2003|Dulukapa
75.05.11.2004|Deme II
75.05.11.2005|Buladu
75.05.11.2006|Hulawa
75.05.11.2007|Wubudu
75.05.11.2008|Bubalango
75.05.11.2009|Motihelumo
75.05.11.2010|Koluwoka
75.71.01.1001|Dembe I
75.71.01.1002|Lekobalo
75.71.01.1003|Pilolodaa
75.71.01.1004|Buliide
75.71.01.1005|Tenilo
75.71.01.1006|Molosipat W
75.71.01.1008|Buladu
75.71.02.1010|Biawao
75.71.02.1012|Biawu
75.71.02.1013|Limba B
75.71.02.1019|Limba U I
75.71.02.1020|Limba U II
75.71.03.1003|Dembe II
75.71.03.1004|Wongkaditi Timur
75.71.03.1005|Wongkaditi Barat
75.71.03.1010|Dulomo Selatan
75.71.03.1014|Dulomo Utara
75.71.03.1015|Dembe Jaya
75.71.04.1001|Huangobotu
75.71.04.1002|Libuo
75.71.04.1003|Tomulabutao
75.71.04.1004|Tuladenggi
75.71.04.1005|Tomulabutao Selatan
75.71.05.1003|Heledulaa Utara
75.71.05.1004|Heledulaa Selatan
75.71.05.1005|Ipilo
75.71.05.1008|Moodu
75.71.05.1009|Padebuolo
75.71.05.1011|Tamalate
75.71.06.1001|Wumialo
75.71.06.1002|Dulalowo
75.71.06.1003|Liluwo
75.71.06.1004|Pulubala
75.71.06.1005|Paguyaman
75.71.06.1006|Dulalowo Timur
75.71.07.1001|Tanggikiki
75.71.07.1002|Tapa
75.71.07.1003|Bulotadaa Barat
75.71.07.1004|Bulotadaa Timur
75.71.07.1005|Molosipat U
75.71.08.1001|Leato Utara
75.71.08.1002|Leato Selatan
75.71.08.1003|Talumolo
75.71.08.1004|Botu
75.71.08.1005|Bugis
75.71.09.1001|Tanjung Kramat
75.71.09.1002|Pohe
75.71.09.1003|Tenda
75.71.09.1004|Donggala
75.71.09.1005|Siendeng
76.01.01.1006|Bambalamotu
76.01.01.2003|Polewali
76.01.01.2004|Randomayang
76.01.01.2007|Pangiang
76.01.01.2008|Kalola
76.01.01.2009|Wulai
76.01.02.1001|Pasangkayu
76.01.02.1002|Martajaya
76.01.02.2010|Pakava
76.01.02.2014|Karya Bersama
76.01.02.2015|Ako
76.01.02.2016|Gunung Sari
76.01.03.1001|Baras
76.01.03.2002|Balanti
76.01.03.2003|Motu
76.01.03.2012|Bulu Parigi
76.01.03.2013|Towoni
76.01.03.2016|Kasano
76.01.04.2001|Sarudu
76.01.04.2003|Bulu Mario
76.01.04.2005|Kumasari
76.01.04.2011|Patika
76.01.04.2012|Doda
76.01.05.2001|Dapurang
76.01.05.2002|Benggaulu
76.01.05.2003|Tirtabuana
76.01.05.2004|Bulu Bonggu
76.01.05.2005|Sarasa
76.01.06.2001|Tammarunang
76.01.06.2002|Saptanajaya
76.01.06.2003|Taranggi
76.01.06.2004|Sipakainga
76.01.07.2001|Lilimori
76.01.07.2002|Karave
76.01.07.2003|Bukit Harapan
76.01.07.2004|Kastabuana
76.01.07.2005|Sumber Sari
76.01.07.2006|Lelejae
76.01.07.2007|Ompi
76.01.08.2001|Tikke
76.01.08.2002|Makmur Jaya
76.01.08.2003|Lariang
76.01.08.2004|Pajalele
76.01.08.2005|Jengeng Raya
76.01.09.2001|Malei
76.01.09.2002|Pedanda
76.01.09.2003|Batu Oge
76.01.09.2004|Martasari
76.01.10.2001|Bambaira
76.01.10.2002|Kasoloang
76.01.10.2003|Tampaure
76.01.10.2004|Kaluku Nangka
76.01.11.2001|Sarjo
76.01.11.2002|Maponu
76.01.11.2003|Letawa
76.01.11.2004|Sarude
76.01.12.2001|Parabu
76.01.12.2002|Kenangan
76.01.12.2003|Bajawali
76.01.12.2004|Singgani
76.01.12.2005|Kulu
76.01.12.2006|Batu Matoru
76.01.12.2007|Bambakoro
76.02.01.1002|Binanga
76.02.01.1003|Mamunyu
76.02.01.1012|Karema
76.02.01.1013|Rimuku
76.02.01.2005|Bambu
76.02.01.2006|Karampuang
76.02.01.2010|Tadui
76.02.01.2014|Batu Pannu
76.02.02.1001|Galung
76.02.02.1002|Kasambang
76.02.02.1014|Dayanginna
76.02.02.2003|Orobatu
76.02.02.2006|Takandeang
76.02.02.2009|Bela
76.02.02.2010|Taan
76.02.02.2011|Tampalang
76.02.02.2012|Rantedoda
76.02.02.2013|Kopeang
76.02.03.1001|Sinyonyoi
76.02.03.1002|Bebanga
76.02.03.1003|Kalukku
76.02.03.1014|Sinyonyoi Selatan
76.02.03.2004|Sondoang
76.02.03.2005|Beru-Beru
76.02.03.2006|Belang Belang
76.02.03.2007|Kabuloang
76.02.03.2008|Keang
76.02.03.2009|Pokkang
76.02.03.2010|Guliling
76.02.03.2011|Uhaimate
76.02.03.2012|Kalukku Barat
76.02.03.2013|Pammulukang
76.02.04.2001|Kalumpang
76.02.04.2003|Karataun
76.02.04.2004|Karama
76.02.04.2006|Siraun
76.02.04.2007|Tumoga
76.02.04.2010|Salumakki
76.02.04.2011|Polio
76.02.04.2012|Limbong
76.02.04.2013|Sandapang
76.02.04.2014|Kondo Bulo
76.02.04.2015|Makkaliki
76.02.04.2016|Batu Makkada
76.02.04.2017|Lasa'
76.02.07.2001|Toabo
76.02.07.2002|Papalang
76.02.07.2003|Bonda
76.02.07.2004|Topore
76.02.07.2005|Salukayu
76.02.07.2006|Sukadamai
76.02.07.2007|Boda-Boda
76.02.07.2008|Sisango
76.02.07.2009|Batu Ampa
76.02.08.2001|Bunde
76.02.08.2002|Kalonding
76.02.08.2003|Tarailu
76.02.08.2004|Sampaga
76.02.08.2005|Tanambuah
76.02.08.2006|Salubarana
76.02.08.2007|Losso
76.02.11.2001|Tommo
76.02.11.2002|Campaloga
76.02.11.2003|Buana Sakti
76.02.11.2004|Tamemongga
76.02.11.2005|Tamejarra
76.02.11.2006|Rantemario
76.02.11.2007|Malino
76.02.11.2008|Kakullasang
76.02.11.2009|Leling
76.02.11.2010|Kalepu
76.02.11.2011|Sandana
76.02.11.2012|Leling Barat
76.02.11.2013|Leling Utara
76.02.11.2014|Saludengen
76.02.12.1001|Simboro
76.02.12.1002|Rangas
76.02.12.2003|Botteng
76.02.12.2004|Saletto
76.02.12.2005|Sumare
76.02.12.2007|Botteng Utara
76.02.12.2008|Tapandullu
76.02.12.2009|Pati'di
76.02.13.2001|Dungkait
76.02.13.2002|Lebani
76.02.13.2003|Labuang Rano
76.02.13.2004|Pasabu
76.02.13.2005|Tanete Pao
76.02.13.2006|Pangasaan
76.02.13.2007|Ahu
76.02.15.2001|Bonehau
76.02.15.2002|Salutiwo
76.02.15.2003|Buttuada
76.02.15.2004|Tamalea
76.02.15.2005|Lumika
76.02.15.2006|Mappu
76.02.15.2009|Banuada
76.02.15.2010|Hinua
76.02.15.2011|Kinatang
76.02.16.2001|Bala Balakang
76.02.16.2002|Bala-Balakang Timur
76.03.01.1001|Mambi
76.03.01.1002|Talipukki
76.03.01.2004|Rantebulahan
76.03.01.2008|Sondonglayu
76.03.01.2016|Salubanua
76.03.01.2017|Tapalina
76.03.01.2019|Sendana
76.03.01.2024|Pamosean
76.03.01.2025|Selumaka
76.03.01.2026|Bujung Manurung
76.03.01.2027|Salu Alo
76.03.01.2029|Indobanua
76.03.01.2030|Saludurian
76.03.02.1001|Aralle
76.03.02.2003|Ralle Anak
76.03.02.2004|Panetean
76.03.02.2005|Uhailanu
76.03.02.2007|Aralle Utara
76.03.02.2009|Uhaidaho
76.03.02.2010|Baruru
76.03.02.2015|Ralleanak Utara
76.03.02.2016|Pamoseang Pangga
76.03.02.2017|Kalabe
76.03.02.2018|Aralle Selatan
76.03.02.2019|Hahangan
76.03.03.1001|Mamasa
76.03.03.2002|Rambusaratu
76.03.03.2003|Osango
76.03.03.2004|Lambanan
76.03.03.2005|Lembana Salulo
76.03.03.2006|Taupe
76.03.03.2007|Buntu Buda
76.03.03.2008|Tondok Bakaru
76.03.03.2009|Pebassian
76.03.03.2010|Mambuliling
76.03.03.2011|Bombong Lambe
76.03.03.2012|Bubun Batu
76.03.04.1001|Pana
76.03.04.2003|Manipi
76.03.04.2005|Mamullu
76.03.04.2006|Sapan
76.03.04.2009|Datubaringan
76.03.04.2010|Panura
76.03.04.2011|Tallang Bulawan
76.03.04.2012|Karaka
76.03.04.2013|Ulusalu
76.03.04.2014|Weri
76.03.04.2015|Salutambun
76.03.04.2016|Saloan
76.03.04.2017|Ulusalu Indah
76.03.05.1001|Lakahang
76.03.05.2002|Periangan
76.03.05.2003|Malatiro
76.03.05.2004|Tabulahan
76.03.05.2005|Saluleang
76.03.05.2007|Tampak Kurra
76.03.05.2008|Gandang Dewata
76.03.05.2009|Burana
76.03.05.2010|Salubakka
76.03.05.2011|Pangandaran
76.03.05.2012|Talopak
76.03.05.2013|Peu'
76.03.05.2014|Timoro
76.03.05.2015|Lakahang Utama
76.03.06.1001|Sumarorong
76.03.06.1002|Tabone
76.03.06.2003|Batang Uru
76.03.06.2004|Sasakan
76.03.06.2005|Tadisi
76.03.06.2006|Sibanawa
76.03.06.2007|Batangnguru Timur
76.03.06.2008|Salubalo
76.03.06.2009|Banea
76.03.06.2010|Rante Kamase
76.03.07.1001|Messawa
76.03.07.2002|Rippung
76.03.07.2003|Makuang
76.03.07.2004|Sepang
76.03.07.2005|Malimbong
76.03.07.2006|Matande
76.03.07.2007|Sipai
76.03.07.2008|Pasma Mambu
76.03.07.2009|Tanete Batu
76.03.08.2002|Orobua
76.03.08.2003|Paladan
76.03.08.2004|Orobua Timur
76.03.08.2006|Rante Puang
76.03.08.2007|Satenetean
76.03.08.2008|Lisuan Ada
76.03.08.2010|Orobua Selatan
76.03.08.2012|Malangkena Padang
76.03.08.2013|Malimbong
76.03.08.2014|Marampan Orobua
76.03.09.1011|Minake
76.03.09.2001|Malabo
76.03.09.2005|Sindagamanik
76.03.09.2006|Parondobulawan
76.03.09.2007|Tamalantik
76.03.09.2008|Mannababa
76.03.09.2009|Mesakada
76.03.09.2010|Ballabatu
76.03.09.2012|Pambe
76.03.09.2013|Salurano
76.03.09.2014|Talimbung
76.03.09.2015|Kanan
76.03.10.1001|Tabang
76.03.10.2003|Tadokalua
76.03.10.2004|Tabang Barat
76.03.10.2005|Masupu
76.03.10.2006|Kalama
76.03.10.2007|Bakadisura
76.03.10.2008|Salukona
76.03.11.2001|Mokallang
76.03.11.2002|Masoso
76.03.11.2003|Saluassing
76.03.11.2004|Salubulo
76.03.11.2005|Salukadi
76.03.11.2006|Salukepopok
76.03.11.2007|Ulumambi Barat
76.03.11.2008|Limbadebata
76.03.11.2009|Tanete Tomba
76.03.11.2010|Bambang
76.03.11.2011|Rantelemo
76.03.11.2012|Saludengen
76.03.11.2013|Ulumambi
76.03.11.2014|Bambang Timur
76.03.11.2015|Minanga
76.03.11.2016|Sikamase
76.03.11.2017|Rantetarima
76.03.11.2018|Salururu
76.03.11.2019|Salutabang
76.03.11.2020|Balatana
76.03.12.2001|Balla
76.03.12.2002|Balla Barat
76.03.12.2003|Balla Satanetean
76.03.12.2004|Balla Tumuka
76.03.12.2005|Sepakuan
76.03.12.2006|Pidara
76.03.12.2007|Bambapuang
76.03.12.2008|Balla Timur
76.03.13.1001|Nosu
76.03.13.2002|Minanga
76.03.13.2003|Batupapan
76.03.13.2004|Masewwe
76.03.13.2005|Siwi
76.03.13.2006|Minanga Timur
76.03.13.2007|Parinding
76.03.14.1001|Tawalian
76.03.14.2002|Tawalian Timur
76.03.14.2003|Kariango
76.03.14.2004|Rantetangnga
76.03.15.2001|Salumokanan
76.03.15.2003|Salumokanan Barat
76.03.15.2004|Buangin
76.03.15.2005|Bambang Buda
76.03.15.2006|Leko
76.03.15.2007|Kirak
76.03.15.2008|Salumokanan Utara
76.03.15.2009|Sampale
76.03.16.2001|Buntumalangka
76.03.16.2002|Ranteberan
76.03.16.2003|Kebanga
76.03.16.2004|Salurindu
76.03.16.2005|Taora
76.03.16.2006|Kabae
76.03.16.2007|Salutambun Barat
76.03.16.2008|Penatangan
76.03.16.2009|Salutambun Timur
76.03.16.2010|Salutambun
76.03.16.2011|Aralle Timur
76.03.17.2001|Mehalaan
76.03.17.2002|Botteng
76.03.17.2003|Salukonta
76.03.17.2004|Mesakada
76.03.17.2005|Mehalaan Barat
76.03.17.2006|Saluahok
76.03.17.2007|Salubalo
76.03.17.2008|Passembuk
76.03.17.2009|Kondo
76.03.17.2010|Leko Sukamaju
76.03.17.2011|Ulumea
76.04.01.1001|Tinambung
76.04.01.2002|Karama
76.04.01.2003|Tangnga Tangnga
76.04.01.2004|Lekopadis
76.04.01.2005|Galung Lombok
76.04.01.2006|Tandung
76.04.01.2007|Batulaya
76.04.01.2008|Sepabatu
76.04.02.1001|Pappang
76.04.02.2002|Laliko
76.04.02.2003|Bonde
76.04.02.2004|Katumbangan Lemo
76.04.02.2005|Panyampa
76.04.02.2006|Suruang
76.04.02.2007|Lampoko
76.04.02.2008|Katumbangan
76.04.02.2009|Lapeo
76.04.02.2010|Parappe
76.04.02.2011|Ongko
76.04.02.2012|Kenje
76.04.02.2013|Sumarrang
76.04.02.2014|Botto
76.04.02.2015|Gattungan
76.04.02.2016|Padang Timur
76.04.02.2017|Padang
76.04.02.2018|Lagi-Agi
76.04.03.1001|Sidodadi
76.04.03.2002|Sidorejo
76.04.03.2003|Sumberjo
76.04.03.2004|Bumiayu
76.04.03.2005|Kebunsari
76.04.03.2006|Banua Baru
76.04.03.2007|Nepo
76.04.03.2008|Sugihwaras
76.04.03.2009|Campurjo
76.04.03.2010|Bumimulyo
76.04.03.2011|Tumpiling
76.04.03.2012|Bakka-Bakka
76.04.03.2013|Arjosari
76.04.03.2014|Galeso
76.04.04.1001|Polewali
76.04.04.1002|Wattang
76.04.04.1003|Sulewatang
76.04.04.1004|Lantora
76.04.04.1005|Takatidung
76.04.04.1006|Pekkabata
76.04.04.1007|Madatte
76.04.04.1008|Manding
76.04.04.1009|Darma
76.04.05.1001|Taramanu
76.04.05.2002|Ambopadang
76.04.05.2003|Tubbi
76.04.05.2004|Ratte
76.04.05.2005|Besoangin
76.04.05.2006|Piriang Tapiko
76.04.05.2007|Peburru
76.04.05.2008|Taloba
76.04.05.2009|Pollewani
76.04.05.2010|Arabua
76.04.05.2011|Besoangin Utara
76.04.05.2012|Poda-Poda
76.04.05.2013|Taramanu Tua
76.04.06.1005|Amassangan
76.04.06.2001|Tonyaman
76.04.06.2002|Kuajang
76.04.06.2003|Paku
76.04.06.2004|Mirring
76.04.06.2006|Batetangnga
76.04.06.2007|Mammi
76.04.06.2008|Kaleok
76.04.06.2009|Amola
76.04.06.2010|Rea
76.04.07.1001|Pelitakan
76.04.07.2002|Tapango
76.04.07.2003|Rappang
76.04.07.2004|Dakka
76.04.07.2005|Batu
76.04.07.2006|Riso
76.04.07.2007|Palatta
76.04.07.2008|Tapango Barat
76.04.07.2009|Kurrak
76.04.07.2010|Bussu
76.04.07.2011|Tuttula
76.04.07.2012|Jambu Malea
76.04.07.2013|Kalimbua
76.04.07.2014|Banato Rejo
76.04.08.1001|Mapilli
76.04.08.2002|Ugibaru
76.04.08.2003|Rumpa
76.04.08.2005|Kurma
76.04.08.2007|Buku
76.04.08.2009|Bonne Bonne
76.04.08.2011|Beroangin
76.04.08.2015|Segerang
76.04.08.2016|Bonra
76.04.08.2017|Sattoko
76.04.08.2018|Rappang Barat
76.04.08.2019|Landi Kanusuang
76.04.09.1001|Matangnga
76.04.09.2002|Lilli
76.04.09.2003|Rangoan
76.04.09.2004|Tapua
76.04.09.2005|Mambu Tapua
76.04.09.2006|Ba'ba Tapua
76.04.09.2007|Katimbang
76.04.10.1004|Batupanga
76.04.10.2001|Mambu
76.04.10.2002|Tenggelang
76.04.10.2003|Baru
76.04.10.2005|Pussui
76.04.10.2006|Mapilli Barat
76.04.10.2007|Sambali Wali
76.04.10.2008|Batupanga Daala
76.04.10.2009|Luyo
76.04.10.2010|Pussui Barat
76.04.10.2011|Puccadi
76.04.11.1001|Limboro
76.04.11.2002|Lembang Lembang
76.04.11.2003|Tandassura
76.04.11.2004|Samasundu
76.04.11.2005|Napo
76.04.11.2006|Todang Todang
76.04.11.2007|Pendulangan
76.04.11.2008|Renggeang
76.04.11.2009|Salarri
76.04.11.2010|Tangan Baru
76.04.11.2011|Palece
76.04.12.1002|Balanipa
76.04.12.2001|Tammajarra
76.04.12.2003|Tammangalle
76.04.12.2004|Mosso
76.04.12.2005|Galung Tuluk
76.04.12.2006|Sabang Subik
76.04.12.2007|Pambusuang
76.04.12.2008|Bala
76.04.12.2009|Lambanan
76.04.12.2010|Lego
76.04.12.2011|Pallis
76.04.13.1001|Anreapi
76.04.13.2002|Duampanua
76.04.13.2003|Kelapa Dua
76.04.13.2004|Pappandangan
76.04.13.2005|Kunyi
76.04.14.1001|Matakali
76.04.14.2002|Petampanua
76.04.14.2003|Barumbung
76.04.14.2004|Pasiang
76.04.14.2005|Tonrolima
76.04.14.2006|Indomakkombong
76.04.14.2007|Bunga-Bunga
76.04.15.1009|Petoosang
76.04.15.2002|Mombi
76.04.15.2003|Kalumammang
76.04.15.2004|Pao-pao
76.04.15.2005|Puppuuring
76.04.15.2006|Saragian
76.04.15.2007|Sayoang
76.04.15.2008|Allu
76.04.16.2001|Bulo
76.04.16.2002|Pulliwa
76.04.16.2003|Patambanua
76.04.16.2004|Karombang
76.04.16.2005|Daala Timur
76.04.16.2006|Lenggo
76.04.16.2007|Sabura
76.04.16.2008|Sepporakki
76.04.16.2009|Ihing
76.05.01.1001|Banggae
76.05.01.1003|Baru
76.05.01.1007|Pangali Ali
76.05.01.1009|Totoli
76.05.01.1010|Rangas
76.05.01.1013|Galung
76.05.01.2011|Palipi Soreang
76.05.01.2012|Pamboborang
76.05.02.1001|Lalampanua
76.05.02.1002|Sirindu
76.05.02.2003|Adolang
76.05.02.2004|Bababulo
76.05.02.2005|Bonde
76.05.02.2006|Betteng
76.05.02.2007|Simbang
76.05.02.2008|Bonde Utara
76.05.02.2009|Bababulo Utara
76.05.02.2010|Buttu Pamboang
76.05.02.2011|Banua Adolang
76.05.02.2012|Adolang Dhua
76.05.02.2013|Tinambung
76.05.02.2014|Pesuloang
76.05.02.2015|Balombong
76.05.03.1001|Mosso
76.05.03.1002|Mosso Dhua
76.05.03.2004|Totolisi Sendana
76.05.03.2007|Tallubanua
76.05.03.2015|Lalatedzong
76.05.03.2016|Binanga
76.05.03.2017|Puttada
76.05.03.2018|Paminggalan
76.05.03.2019|Leppangang
76.05.03.2020|Pundau
76.05.03.2021|Sendana
76.05.03.2022|Banua Sendana
76.05.03.2023|Tallubanua Utara
76.05.03.2024|Limboro Rambu-Rambu
76.05.03.2025|Limbua
76.05.03.2026|Bukit Samang
76.05.04.1001|Malunda
76.05.04.1015|Lamungang Batu
76.05.04.2002|Bambangan
76.05.04.2004|Lombang
76.05.04.2005|Lombong
76.05.04.2006|Mekkatta
76.05.04.2010|Maliaya
76.05.04.2011|Lombang Timur
76.05.04.2012|Salutahongan
76.05.04.2013|Lombong Timur
76.05.04.2014|Mekkatta Selatan
76.05.04.2016|Kayuangin
76.05.05.2001|Kabiraan
76.05.05.2002|Sambabo
76.05.05.2003|Tandeallo
76.05.05.2004|Ulumanda
76.05.05.2005|Salutambung
76.05.05.2006|Popenga
76.05.05.2007|Sulai
76.05.05.2008|Panggalo
76.05.06.2001|Seppong
76.05.06.2002|Tammerodo
76.05.06.2003|Ulidang
76.05.06.2004|Tallambalao
76.05.06.2005|Tammerodo Utara
76.05.06.2006|Manyamba
76.05.06.2007|Awo
76.05.07.2001|Onang
76.05.07.2002|Tubo
76.05.07.2003|Onang Utara
76.05.07.2004|Tubo Selatan
76.05.07.2005|Bonde bonde
76.05.07.2006|Tubo Tengah
76.05.07.2007|Tubo Poang
76.05.08.1001|Baurung
76.05.08.1002|Baruga
76.05.08.1003|Baruga Dhua
76.05.08.1004|Labuang
76.05.08.1005|Tande
76.05.08.1006|Lembang
76.05.08.1007|Labuang Utara
76.05.08.1008|Tande Timur
76.05.08.2009|Buttu Baruga
76.06.01.2001|Mahahe
76.06.01.2002|Salobaja
76.06.01.2003|Tobadak
76.06.01.2004|Palongaan
76.06.01.2005|Batu Parigi
76.06.01.2006|Bambadaru
76.06.01.2007|Sejati
76.06.01.2008|Saloadak
76.06.02.2001|Polo Pangale
76.06.02.2002|Pangale
76.06.02.2003|Sartanamaju
76.06.02.2004|Polo Lereng
76.06.02.2005|Kuo
76.06.02.2006|Polo Camba
76.06.02.2007|Lamba-lamba
76.06.02.2008|Kombiling
76.06.02.2009|Lemo-Lemo
76.06.03.2001|Babana
76.06.03.2002|Lumu
76.06.03.2003|Pontanakayang
76.06.03.2004|Salogatta
76.06.03.2005|Kire
76.06.03.2006|Tinali
76.06.03.2007|Salumanurung
76.06.03.2008|Pasapa
76.06.03.2009|Bojo
76.06.03.2010|Barakkang
76.06.03.2011|Lembah Hada
76.06.04.2001|Budong-Budong
76.06.04.2002|Topoyo
76.06.04.2003|Tumbu
76.06.04.2004|Kabubu
76.06.04.2005|Waeputeh
76.06.04.2006|Tangkou
76.06.04.2007|Tabolang
76.06.04.2008|Paraili
76.06.04.2009|Salupangkang
76.06.04.2010|Salupangkang IV
76.06.04.2011|Tappilina
76.06.04.2012|Bambamanurung
76.06.04.2013|Salulekbo
76.06.04.2014|Pangalloang
76.06.04.2015|Sinabatta
76.06.05.2001|Karossa
76.06.05.2002|Tasokko
76.06.05.2003|Lara
76.06.05.2004|Kadaila
76.06.05.2005|Kayu Calla
76.06.05.2006|Lembah Hopo
76.06.05.2007|Benggaulu
76.06.05.2008|Suka Maju
76.06.05.2009|Kambunong
76.06.05.2010|Salubiro
76.06.05.2011|Sanjango
81.01.01.1009|Hollo
81.01.01.2001|Tamilouw
81.01.01.2002|Sepa
81.01.01.2003|Rutah
81.01.01.2004|Soahuku
81.01.01.2005|Amahai
81.01.01.2006|Haruru
81.01.01.2007|Sehati
81.01.01.2008|Makariki
81.01.01.2010|Yafila
81.01.01.2011|Banda Baru
81.01.01.2020|Yainuelo
81.01.01.2021|Nua Nea
81.01.01.2022|Hatuhenu
81.01.01.2023|Nuweletetu
81.01.02.2001|Usliapan
81.01.02.2002|Kuralele
81.01.02.2003|Kokroman
81.01.02.2004|Messa
81.01.02.2005|Ameth
81.01.02.2006|Waru
81.01.02.2007|Bumey
81.01.02.2008|Sifluru
81.01.02.2009|Layeni
81.01.02.2010|Wotay
81.01.02.2011|Issu
81.01.02.2012|Lesluru
81.01.02.2013|Watludan
81.01.02.2014|Trana
81.01.02.2015|Jerili
81.01.02.2016|Nakupia
81.01.06.2001|Wahai
81.01.06.2002|Air Besar
81.01.06.2003|Pasahari
81.01.06.2007|Manusela
81.01.06.2009|Kaloa
81.01.06.2010|Kanikeh
81.01.06.2011|Roho
81.01.06.2012|Huaulu
81.01.06.2021|Rumahsokat
81.01.06.2022|Sawai
81.01.06.2044|Besi
81.01.06.2045|Malaku
81.01.06.2046|Maraina
81.01.06.2047|Solea
81.01.06.2048|Elemata
81.01.06.2049|Hatuolo
81.01.06.2050|Siatele
81.01.06.2051|Masihulan
81.01.06.2052|Oping
81.01.06.2053|Olong
81.01.09.2001|Nusantara
81.01.09.2002|Dwiwarna
81.01.09.2003|Merdeka
81.01.09.2004|Rajawali
81.01.09.2005|Kampung Baru
81.01.09.2006|Pulau Hatta
81.01.09.2007|Selamon
81.01.09.2008|Lonthoir
81.01.09.2009|Pulau Ay
81.01.09.2010|Pulau Rhun
81.01.09.2011|Tanah Rata
81.01.09.2012|Waer
81.01.09.2013|Boiyauw
81.01.09.2014|Dender
81.01.09.2015|Lautang
81.01.09.2016|Uring Tutra
81.01.09.2017|Walling Spanciby
81.01.09.2018|Combir Kasestoren
81.01.11.2011|Telutih Baru
81.01.11.2012|Mosso
81.01.11.2013|Hatumete
81.01.11.2014|Hatu
81.01.11.2015|Piliana
81.01.11.2016|Yaputih
81.01.11.2017|Saunulu
81.01.11.2018|Tehoru
81.01.11.2019|Haya
81.01.11.2020|Salamahu
81.01.12.2001|Booi
81.01.12.2002|Paperu
81.01.12.2003|Tiouw
81.01.12.2004|Haria
81.01.12.2005|Porto
81.01.12.2006|Kulur
81.01.12.2012|Saparua
81.01.13.2001|Aboru
81.01.13.2002|Wassu
81.01.13.2003|Oma
81.01.13.2004|Haruku
81.01.13.2005|Sameth
81.01.13.2006|Rohomoni
81.01.13.2007|Kabauw
81.01.13.2008|Kailolo
81.01.13.2009|Pelauw
81.01.13.2010|Kariu
81.01.13.2011|Hulaliu
81.01.14.2001|Liang
81.01.14.2002|Waai
81.01.14.2003|Tulehu
81.01.14.2004|Tial
81.01.14.2005|Tengah Tengah
81.01.14.2006|Suli
81.01.15.2006|Asilulu
81.01.15.2007|Ureng
81.01.15.2008|Negeri Lima
81.01.15.2009|Seith
81.01.15.2010|Kaitetu
81.01.15.2011|Hila
81.01.15.2012|Wakal
81.01.15.2013|Hitulama
81.01.15.2014|Hitumessing
81.01.15.2015|Mamala
81.01.15.2016|Morella
81.01.16.2001|Ameth
81.01.16.2002|Titawaai
81.01.16.2003|Abubu
81.01.16.2004|Akoon
81.01.16.2005|Nalahia
81.01.16.2006|Sila
81.01.16.2007|Leinitu
81.01.17.1001|Namaelo
81.01.17.1002|Namasina
81.01.17.1003|Ampera
81.01.17.1004|Lesane
81.01.17.1005|Letwaru
81.01.20.2001|Saleman
81.01.20.2002|Horale
81.01.20.2003|Wailulu
81.01.20.2004|Paa
81.01.20.2005|Karlutu Kara
81.01.20.2006|Pasanea
81.01.20.2007|Labuan
81.01.20.2008|Gale-gale
81.01.20.2009|Latea
81.01.20.2010|Lisabata Timur
81.01.20.2011|Rumahwey
81.01.20.2012|Warasiwa
81.01.20.2013|Herlau Pauni
81.01.21.2001|Waraka
81.01.21.2002|Tananahu
81.01.21.2003|Liang
81.01.21.2004|Sahulauw
81.01.22.2001|Larike
81.01.22.2002|Wakasihu
81.01.22.2003|Allang
81.01.22.2004|Liliboy
81.01.22.2005|Hatu
81.01.23.2001|Ulahahan
81.01.23.2002|Laha Kaba
81.01.23.2003|Lafa
81.01.23.2004|Yamalatu
81.01.23.2005|Hunisi
81.01.23.2006|Laimu
81.01.23.2007|Maneoratu
81.01.23.2008|Tehua
81.01.23.2009|Laha
81.01.23.2010|Wolu
81.01.24.2001|Seti
81.01.24.2002|Kobisonta
81.01.24.2003|Wailoping
81.01.24.2004|Tihuana
81.01.24.2005|Waitila
81.01.24.2006|Waiputih
81.01.24.2007|Waimusal
81.01.24.2008|Tanah Merah
81.01.24.2009|Aketernate
81.01.24.2010|Namto
81.01.24.2011|Loping Mulyo
81.01.24.2012|Wonosari
81.01.25.2001|Kobi
81.01.25.2002|Sariputih
81.01.25.2003|Maneo Rendah
81.01.25.2004|Kobimukti
81.01.25.2005|Leaway
81.01.25.2006|Samal
81.01.25.2007|Morokai
81.01.25.2008|Waimusi
81.01.25.2009|Way Asih
81.01.25.2010|Waitonipa
81.01.25.2011|Marasahua
81.01.25.2012|Kabauhari
81.01.26.2001|Ouw
81.01.26.2002|Ullath
81.01.26.2003|Siri Sori Islam
81.01.26.2004|Siri Sori Amalatu
81.01.26.2005|Mahu
81.01.26.2006|Tuhaha
81.01.26.2007|Ihamahu
81.01.26.2008|Iha
81.01.26.2009|Nolloth
81.01.26.2010|Itawaka
81.02.01.1013|Ohoijang Watdek
81.02.01.2014|Langgur
81.02.01.2015|Faan
81.02.01.2016|Sathean
81.02.01.2017|Ibra
81.02.01.2018|Ngabub
81.02.01.2048|Ohoidertawun
81.02.01.2049|Kelanit
81.02.01.2051|Kolser
81.02.01.2052|Letman
81.02.01.2057|Wearlilir
81.02.01.2067|Ohoider Atas
81.02.01.2068|Dudunwahan
81.02.01.2069|Loon
81.02.01.2071|Sitniohoi
81.02.03.2001|Werka
81.02.03.2002|Waur
81.02.03.2003|Ohoinangan
81.02.03.2004|Ler Ohoilim
81.02.03.2005|Rahareng
81.02.03.2006|Elat
81.02.03.2007|Depur
81.02.03.2008|Ohoilim
81.02.03.2009|El Ralang
81.02.03.2015|Reyamru
81.02.03.2016|Fako
81.02.03.2017|Yamtel
81.02.03.2018|Waur Tahit
81.02.03.2019|Ngefuit
81.02.03.2020|Ohoiel
81.02.03.2021|Ohoiwait
81.02.03.2022|Ohoiwang
81.02.03.2023|Fangamas
81.02.03.2024|Ohoinangan Atas
81.02.03.2025|Harangur
81.02.03.2026|Udar
81.02.03.2027|Daftel
81.02.03.2028|Karkarit
81.02.03.2029|Rahareng Atas
81.02.03.2030|Wulurat
81.02.03.2031|Wakol
81.02.03.2032|Ngurdu
81.02.03.2033|Soinrat
81.02.03.2034|Wermaf
81.02.03.2035|Bombay
81.02.03.2036|Watsin
81.02.03.2037|Sirbante
81.02.03.2038|Ngat
81.02.03.2039|Nabaheng
81.02.03.2040|Ngefuit Atas
81.02.03.2041|Watuar
81.02.03.2042|Mataholat
81.02.04.2001|Weduar
81.02.04.2003|Nerong
81.02.04.2004|Larat
81.02.04.2005|Tamangil Nuhuten
81.02.04.2006|Tamangil Nuhuyanat
81.02.04.2012|Kilwat
81.02.04.2013|Sather
81.02.04.2014|Tutrean
81.02.04.2015|Ohoirenan
81.02.04.2016|Soindat
81.02.05.2001|Hollat
81.02.05.2002|Ohoiraut
81.02.05.2003|Haar Ohoimel
81.02.05.2004|Langgiar Haar
81.02.05.2005|Banda Eli
81.02.05.2006|Watlaar
81.02.05.2007|Ohoifau
81.02.05.2008|Kilwair
81.02.05.2009|Renfan
81.02.05.2010|Hollat Solair
81.02.05.2011|Hoko
81.02.05.2012|Hollay
81.02.05.2013|Soin
81.02.05.2014|Haar Ohoimur GPM
81.02.05.2015|Haar Ohoimur RK
81.02.05.2016|Haar Ohoiwait
81.02.05.2017|Haar Wassar
81.02.05.2018|Haar Renrahantel
81.02.05.2019|Ur
81.02.05.2020|Ohoimajang
81.02.05.2021|Banda Efruan
81.02.05.2022|Banda Suku Tigapuluh
81.02.05.2023|Tuburlay
81.02.05.2024|Ohoifaruan
81.02.05.2025|Ohoiwirin
81.02.05.2026|Tuburngil
81.02.05.2027|Yamtimur
81.02.05.2028|Renfaan Islam
81.02.05.2029|Renfaan GPM
81.02.05.2030|Fanwav
81.02.13.2001|Wain
81.02.13.2002|Rewav
81.02.13.2003|Rumaat
81.02.13.2004|Rat
81.02.13.2005|Abean
81.02.13.2006|Mastur
81.02.13.2013|Ohoinol
81.02.13.2014|Semawi
81.02.13.2015|Iso
81.02.13.2016|Disuk
81.02.13.2017|Wain Baru
81.02.13.2018|Marfun
81.02.13.2019|Watngon
81.02.13.2020|Yafavun
81.02.13.2021|Mastur Baru
81.02.13.2022|Ohoilus
81.02.13.2023|Tenbuk
81.02.13.2024|Denwet
81.02.14.2001|Ohoidertutu
81.02.14.2002|Matwair
81.02.14.2003|Somlain
81.02.14.2004|Ohoiren
81.02.14.2005|Ohoira
81.02.14.2006|Warbal
81.02.14.2007|Ur Pulau
81.02.14.2008|Tanimbar Kei
81.02.14.2009|Ohoidertom
81.02.14.2010|Yatwav
81.02.15.2001|Rumadian
81.02.15.2002|Debut
81.02.15.2003|Namar
81.02.15.2004|Ngilngof
81.02.15.2005|Selayar
81.02.15.2006|Lairngangas
81.02.15.2007|Ohoiluk
81.02.15.2008|Ohoililir
81.02.15.2009|Ngayub
81.02.16.2001|Tetoat
81.02.16.2002|Dian Pulau
81.02.16.2003|Letvuan
81.02.16.2004|Evu
81.02.16.2005|Warwut
81.02.16.2006|Wab
81.02.16.2007|Dian Darat
81.02.16.2008|Wirin
81.02.16.2009|Ngursit
81.02.16.2010|Madwat
81.02.16.2011|Ohoibadar
81.02.16.2012|Watngil
81.02.16.2013|Arso
81.02.17.2001|Weer Ohoinam
81.02.17.2002|Weer Ohoiker
81.02.17.2003|Weer Frawaf
81.02.17.2004|Faa
81.02.17.2005|Dangarat
81.02.17.2006|Ohoituf
81.02.17.2007|Hangur
81.02.17.2008|Ngurwalek
81.02.17.2009|Uwat
81.02.17.2010|Uwat Wear
81.02.17.2011|Uwat Reyaan
81.02.17.2012|Mun Ohoiir
81.02.17.2013|Mun Essoy
81.02.17.2014|Mun Kahar
81.02.17.2015|Mun Ngurditwain
81.02.17.2016|Mun Werfan
81.02.17.2017|Ad Ngurwul
81.02.17.2018|Ad Ohoiwaf
81.02.17.2019|Laar
81.02.17.2020|Hoor Islam
81.02.17.2021|Hoor Kristen
81.02.17.2022|Waer
81.02.17.2023|Waerat
81.02.17.2024|Mun Ohoitadiun
81.02.17.2025|Ad Wear Aur
81.02.18.2001|Hoat
81.02.18.2002|Ngafan
81.02.18.2003|Feer
81.02.18.2004|Rerean
81.02.18.2005|Ngurko
81.02.18.2006|Hoko
81.02.18.2007|Weduar Fer
81.02.18.2008|Uat
81.02.18.2009|Ngan
81.02.18.2010|Watkidat
81.02.18.2011|Ohoilean
81.02.18.2012|Wafol
81.02.18.2013|Rahangiar
81.02.19.2001|Danar Ohoiseb
81.02.19.2002|Danar Ternate
81.02.19.2003|Danar Lumefar
81.02.19.2004|Elaar Ngursoin
81.02.19.2005|Elaar Lamagorang
81.02.19.2006|Elaar Let
81.02.19.2007|Sare
81.02.19.2008|Maar
81.02.19.2009|Uf
81.02.19.2010|Ngurwul
81.02.19.2011|Garara
81.03.01.1001|Saumlaki
81.03.01.1002|Saumlaki Utara
81.03.01.2002|Wowonda
81.03.01.2003|Ilngei
81.03.01.2004|Kabiarat
81.03.01.2005|Lauran
81.03.01.2006|Sifnana
81.03.01.2007|Olilit Raya
81.03.01.2008|Lermatang
81.03.01.2009|Latdalam
81.03.01.2010|Bomaki
81.03.01.2011|Matakus
81.03.02.2001|Adaut
81.03.02.2002|Namtabung
81.03.02.2003|Kandar
81.03.02.2004|Lingat
81.03.02.2005|Fursuy
81.03.02.2006|Werain
81.03.02.2007|Eliasa
81.03.03.2001|Tumbur
81.03.03.2002|Lorulun
81.03.03.2003|Atubul Dol
81.03.03.2004|Amdasa
81.03.03.2005|Sangliat Krawain
81.03.03.2006|Arui Bab
81.03.03.2007|Arui Das
81.03.03.2008|Sangliat Dol
81.03.03.2009|Atubul Da
81.03.04.2001|Kamatubun
81.03.04.2002|Rumah Salut
81.03.04.2003|Welutu
81.03.04.2004|Themin
81.03.04.2005|Weratan
81.03.04.2006|Wermatang
81.03.04.2007|Otemer
81.03.04.2008|Makatian
81.03.04.2009|Marantutul
81.03.05.2001|Lelingluan
81.03.05.2002|Ritabel
81.03.05.2003|Ridool
81.03.05.2004|Watidal
81.03.05.2005|Keliobar
81.03.05.2006|Kelaan
81.03.05.2007|Lamdesar Barat
81.03.05.2008|Lamdesar Timur
81.03.06.2001|Romean
81.03.06.2002|Rumngeur
81.03.06.2003|Awear
81.03.06.2004|Sofyanin
81.03.06.2005|Walerang
81.03.06.2006|Adodo Fordata
81.03.07.2001|Abat
81.03.07.2002|Labobar
81.03.07.2008|Watmasa
81.03.07.2009|Awear Rumngeur
81.03.07.2010|Karatat
81.03.07.2011|Wunlah
81.03.07.2012|Kiloon
81.03.07.2013|Lingada
81.03.07.2014|Teineman
81.03.07.2015|Wabar
81.03.07.2016|Romnus
81.03.08.2001|Lumasebu
81.03.08.2002|Kilmasa
81.03.08.2003|Meyano Bab
81.03.08.2004|Alusi Krawain
81.03.08.2005|Alusi Kelaan
81.03.08.2006|Alusi Bukjalim
81.03.08.2007|Alusi Tamrian
81.03.08.2008|Alusi Batjas
81.03.08.2009|Lorwembun
81.03.08.2010|Meyano Das
81.03.09.2001|Arma
81.03.09.2002|Watmuri
81.03.09.2003|Manglusi
81.03.09.2004|Tutukembong
81.03.09.2005|Waturu
81.03.18.2001|Wedangkou
81.03.18.2002|Adodo Molu
81.03.18.2003|Wulmasa
81.03.18.2004|Tutunametal
81.03.18.2005|Nurkat
81.04.01.2001|Namlea
81.04.01.2002|Lala
81.04.01.2003|Karang Jaya
81.04.01.2009|Siahoni
81.04.01.2010|Jamilu
81.04.01.2011|Sanleko
81.04.01.2012|Batu boy
81.04.02.2004|Waepure
81.04.02.2005|Waemangit
81.04.02.2006|Air Buaya
81.04.02.2007|Tanjung Karang
81.04.02.2008|Bara
81.04.02.2014|Selwadu
81.04.02.2018|Wasbaka
81.04.02.2019|Kampung Baru
81.04.02.2020|Batlale
81.04.02.2023|Awilinan
81.04.03.2001|Savana Jaya
81.04.03.2002|Waetele
81.04.03.2003|Waekasar
81.04.03.2004|Waenetat
81.04.03.2016|Waekerta
81.04.03.2019|Wanareja
81.04.03.2027|Gogorea
81.04.06.2001|Lamahang
81.04.06.2002|Waplau
81.04.06.2003|Waeura
81.04.06.2004|Samalagi
81.04.06.2005|Namsina
81.04.06.2006|Hatawano
81.04.06.2007|Waelihang
81.04.06.2008|Waprea
81.04.06.2009|Waepotih
81.04.06.2010|Skikilale
81.04.10.2001|Ilath
81.04.10.2002|Batu Jungku
81.04.10.2003|Pela
81.04.10.2004|Waemorat
81.04.10.2006|Namlea Ilath
81.04.11.2001|Kubalahin
81.04.11.2002|Waegeren
81.04.11.2003|Grandeng
81.04.11.2004|Lele
81.04.11.2005|Wanakarta
81.04.11.2006|Wabloy
81.04.11.2007|Ohilahin
81.04.11.2008|Tifu
81.04.11.2009|Wapsalit
81.04.11.2010|Nafrua
81.04.12.2001|Waelo
81.04.12.2002|Debowae
81.04.12.2003|Parbulu
81.04.12.2004|Waetina
81.04.12.2005|Waeleman
81.04.12.2006|Basalale
81.04.12.2007|Waflan
81.04.12.2008|Dava
81.04.12.2009|Waehata
81.04.12.2010|Widit
81.04.13.2001|Wamlana
81.04.13.2002|Balbalu
81.04.13.2003|Waspait
81.04.13.2004|Waedanga
81.04.13.2005|Lemanpoli
81.04.13.2006|Waelana-lana
81.04.13.2007|Waereman
81.04.13.2008|Waemite
81.04.13.2009|Wasi
81.04.13.2010|Waekose
81.04.13.2011|Wamana Baru
81.04.13.2012|Raheriat
81.04.13.2013|Waenibe
81.04.14.2001|Kaiely
81.04.14.2002|Masarete
81.04.14.2003|Waelapia
81.04.14.2004|Kaki Air
81.04.14.2005|Seith
81.04.15.2001|Ubung
81.04.15.2002|Jikumerasa
81.04.15.2003|Waemiting
81.04.15.2004|Sawa
81.04.15.2005|Waeperang
81.05.01.2003|Bula
81.05.01.2004|Salas
81.05.01.2010|Englas
81.05.01.2011|Bula Air Fatolo
81.05.01.2012|Sesar
81.05.01.2022|Tansi Ambon
81.05.01.2023|Kampung Wailola
81.05.01.2024|Kampung Gorom
81.05.01.2025|Limumir
81.05.01.2026|Fattolo
81.05.02.2001|Geser
81.05.02.2002|Kiltay
81.05.02.2003|Kilwaru
81.05.02.2004|Kellu
81.05.02.2005|Keffing
81.05.02.2028|Kilfura
81.05.03.2001|Batuasa
81.05.03.2002|Hatuimeten
81.05.03.2003|Werinama
81.05.03.2004|Bemo
81.05.03.2015|Tum
81.05.03.2016|Gusalaut
81.05.03.2017|Osong
81.05.03.2018|Tobo
81.05.03.2021|Bemo Perak
81.05.03.2022|Funa Naibaya
81.05.04.2001|Kataloka
81.05.04.2003|Amarsekaru
81.05.04.2004|Ondor
81.05.04.2005|Day
81.05.04.2006|Mida
81.05.04.2021|Loko
81.05.04.2022|Sera
81.05.04.2023|Kulugowa
81.05.04.2024|Rumeon
81.05.04.2031|Kelibingan
81.05.04.2032|Ilili
81.05.04.2042|Namalean
81.05.04.2043|Dulak
81.05.04.2044|Kilalir Kilwouw
81.05.04.2045|Kilotak
81.05.04.2046|Kilean
81.05.04.2047|Kaforing
81.05.04.2048|Arewang
81.05.04.2049|Usun Kataloka
81.05.04.2050|Buan Kataloka
81.05.04.2051|Rumanama Kotawouw Kataloka
81.05.04.2052|Sikaro Kataloka
81.05.04.2053|Aroa Kataloka
81.05.04.2054|Dada Kataloka
81.05.05.2001|Ilili
81.05.05.2002|Effa
81.05.05.2003|Lahema
81.05.05.2004|Utta
81.05.05.2005|Kelangan
81.05.05.2006|Amarlaut
81.05.05.2007|Tamher Warat
81.05.05.2008|Tamher Timur
81.05.05.2010|Wunin Eldedora
81.05.05.2011|Keldor
81.05.05.2021|Tanah Baru
81.05.05.2022|Guliar
81.05.05.2023|Karlomin
81.05.05.2024|Otademan
81.05.05.2025|Kurwara
81.05.05.2026|Kilbutak
81.05.05.2027|Ruma Durun
81.05.05.2028|Tana Soa
81.05.06.2001|Danama
81.05.06.2002|Kilmoy
81.05.06.2003|Kilbat
81.05.06.2004|Sesar
81.05.06.2005|Airkasar
81.05.06.2006|Waras-Waras
81.05.06.2007|Gah
81.05.06.2008|Walang Tenga
81.05.06.2009|Bati Kilwouw
81.05.06.2010|Taruy
81.05.06.2011|Kufar
81.05.07.2001|Dihil
81.05.07.2002|Liliama
81.05.07.2003|Naiwel Ahinulin
81.05.07.2004|Polin
81.05.07.2005|Tunsai
81.05.07.2006|Lapela
81.05.07.2007|Nayet
81.05.07.2008|Elnusa
81.05.07.2009|Atiahu
81.05.07.2010|Sabuai
81.05.07.2011|Abulate
81.05.07.2012|Adabai
81.05.08.2001|Selor
81.05.08.2002|Nekan
81.05.08.2003|Afang Kota
81.05.08.2004|Afang Defol
81.05.08.2005|Kumelang
81.05.08.2006|Undur
81.05.08.2007|Kamar
81.05.08.2008|Gunak
81.05.08.2009|Sumbawa
81.05.08.2010|Kilmury
81.05.08.2011|Kilbon Kway
81.05.08.2012|Mising
81.05.08.2013|Bitorik
81.05.08.2014|Taa
81.05.09.2001|Pulau Panjang
81.05.09.2002|Argam
81.05.09.2003|Lalasa
81.05.09.2004|Magat
81.05.09.2005|Ruku Ruku
81.05.09.2006|Perik Basaranggi
81.05.10.2001|Teor
81.05.10.2002|Kartutin Kartenga
81.05.10.2003|Ker Ker
81.05.10.2004|Duryar Rumoy
81.05.10.2005|Lapang Kampung Jawa
81.05.10.2006|Kampung Tengah Wermaf
81.05.10.2007|Kampung Baru
81.05.10.2008|Mamur
81.05.10.2009|Kiliwouw
81.05.10.2010|Karlokin
81.05.11.2001|Kilkoda
81.05.11.2002|Miran
81.05.11.2003|Kota Sirih
81.05.11.2004|Amarwatu
81.05.11.2005|Aran
81.05.11.2006|Tuha
81.05.11.2007|Bas
81.05.11.2008|Tunas Ilur
81.05.11.2009|Sagey
81.05.11.2010|Armada
81.05.11.2011|Waisalan
81.05.11.2012|Basarin
81.05.11.2013|Goha
81.05.11.2014|Rarat
81.05.11.2015|Miran Gota
81.05.11.2016|Adar
81.05.11.2017|Tinarin
81.05.11.2018|Etaralu
81.05.11.2019|Kiltufa
81.05.11.2020|Miran Kilian
81.05.11.2021|Miran Keledar
81.05.11.2022|Miran Manaban
81.05.11.2023|Miran Rumuar
81.05.12.2001|Hote
81.05.12.2002|Banggoi
81.05.12.2003|Waematakabo
81.05.12.2004|Waiketam Baru
81.05.12.2005|Waisamet
81.05.12.2006|Aki Jaya
81.05.12.2007|Jakarta Baru
81.05.12.2008|Silohan
81.05.12.2009|Sumber Agung
81.05.12.2010|Rukun Jaya
81.05.12.2011|Jembatan Basah
81.05.12.2012|Dreamland Hills
81.05.12.2013|Banggoi Pancorang
81.05.13.2001|Kian Darat
81.05.13.2002|Artafela
81.05.13.2003|Angar
81.05.13.2004|Watu Watu
81.05.13.2005|Kelaba
81.05.13.2006|Kilga Kilwouw
81.05.13.2007|Kilga Watubau
81.05.13.2008|Rumfakar
81.05.13.2009|Kileser
81.05.13.2010|Rumoga
81.05.14.2001|Kian Laut
81.05.14.2002|Kuwaos
81.05.14.2003|Salagor Air
81.05.14.2004|Salagor Kota
81.05.14.2005|Aruan Gaur
81.05.14.2006|Keta Rumadan
81.05.14.2007|Lian Tasik
81.05.14.2008|Keta
81.05.14.2009|Air Nanang
81.05.14.2010|Suru
81.05.15.2001|Waru
81.05.15.2002|Bellis
81.05.15.2003|Dawang
81.05.15.2004|Solang
81.05.15.2005|Karay
81.05.15.2006|Nama Lena
81.05.15.2007|Nama Andan
81.05.15.2008|Tubir Wasiwang
81.05.15.2009|Kampung Baru
81.05.15.2010|Boinfia
81.05.15.2011|Madak
81.05.16.2001|Urung
81.05.16.2002|Kwamor Kecil Mata Ata
81.05.16.2003|Kwamor Kecil Mata Wawa
81.05.16.2004|Kwamor Besar Ena
81.05.16.2005|Kwamor Besar Witau
81.05.16.2006|Guli-Guli
81.05.16.2007|Manggis
81.05.16.2008|Ainena
81.05.16.2009|Mugusinis
81.05.16.2010|Akat Fadedo
81.06.01.2008|Kamarian
81.06.01.2009|Seruawan
81.06.01.2010|Kairatu
81.06.01.2011|Waimital
81.06.01.2012|Hatusua
81.06.01.2014|Waipirit
81.06.01.2015|Uraur
81.06.02.2002|Kawa
81.06.02.2003|Piru
81.06.02.2004|Neniari
81.06.02.2005|Morekau
81.06.02.2006|Lumoli
81.06.02.2007|Eti
81.06.02.2008|Kaibobo
81.06.03.2001|Murnaten
81.06.03.2002|Nikulukan
81.06.03.2003|Niwelehu
81.06.03.2004|Nuniali
81.06.03.2005|Lisabata
81.06.03.2006|Wakolo
81.06.03.2007|Patahuwe
81.06.03.2008|Taniwel
81.06.03.2009|Hulung
81.06.03.2010|Kasieh
81.06.03.2011|Nukuhai
81.06.03.2012|Pasinalo
81.06.03.2028|Uweth
81.06.03.2029|Laturake
81.06.03.2030|Buria
81.06.03.2031|Riring
81.06.03.2032|Rumahsoal
81.06.03.2033|Lohiasapalewa
81.06.03.2034|Niniari
81.06.04.2001|Waesala
81.06.04.2002|Allang Asaude
81.06.04.2003|Sole
81.06.04.2004|Tonu Jaya
81.06.04.2005|Tahalupu
81.06.04.2006|Buano Utara
81.06.04.2007|Buano Selatan
81.06.05.2001|Tihulale
81.06.05.2002|Rumahkay
81.06.05.2003|Latu
81.06.05.2004|Tomalehu
81.06.05.2005|Hualoy
81.06.05.2006|Seriholo
81.06.05.2007|Tala
81.06.06.2001|Manusa
81.06.06.2002|Rambatu
81.06.06.2003|Rumberu
81.06.06.2004|Honitetu
81.06.06.2005|Hukuanakota
81.06.07.2001|Waihatu
81.06.07.2002|Lohiatala
81.06.07.2003|Waisamu
81.06.07.2004|Nuruwe
81.06.07.2005|Kamal
81.06.07.2006|Waisarisa
81.06.08.2001|Ariate
81.06.08.2002|Lokki
81.06.08.2003|Luhu
81.06.08.2004|Iha
81.06.08.2005|Kulur
81.06.09.2001|Luhutuban
81.06.09.2002|Masawoy
81.06.09.2003|Tuniwara
81.06.09.2004|Kelang Asaude
81.06.09.2005|Tomalehu Barat
81.06.09.2006|Tomalehu Timur
81.06.09.2007|Buano Hatuputih
81.06.10.2001|Sohuwe
81.06.10.2002|Maloang
81.06.10.2003|Lumahlatal
81.06.10.2004|Matapa
81.06.10.2005|Seakasale
81.06.10.2006|Makububui
81.06.10.2007|Sukaraja
81.06.10.2008|Uwen Pantai
81.06.10.2009|Tounussa
81.06.10.2010|Musihuwey
81.06.10.2011|Solea
81.06.10.2012|Waraloin
81.06.10.2013|Walakone
81.06.10.2014|Hatunuru
81.06.10.2015|Lumahpelu
81.06.11.2002|Sanahu
81.06.11.2003|Wasia
81.06.11.2004|Sumeith Pasinaro
81.06.11.2005|Watui
81.06.11.2006|Abio Ahiolo
81.06.11.2007|Huku Kecil
81.06.11.2008|Elpaputih
81.07.01.1012|Galai Dubu
81.07.01.1013|Siwa Lima
81.07.01.2001|Ujir
81.07.01.2002|Nafar
81.07.01.2003|Kobraur
81.07.01.2004|Lau-Lau
81.07.01.2005|Gorar
81.07.01.2006|Tungu
81.07.01.2007|Tunguwatu
81.07.01.2008|Jabulenga
81.07.01.2009|Wokam
81.07.01.2010|Karangguli
81.07.01.2011|Durjela
81.07.01.2014|Wangel
81.07.01.2015|Samang
81.07.02.2001|Jerol
81.07.02.2002|Marfenfen
81.07.02.2003|Kabalukin
81.07.02.2004|Kalar-Kalar
81.07.02.2005|Feruni
81.07.02.2006|Ngaiguli
81.07.02.2007|Fatural
81.07.02.2008|Ngaibor
81.07.02.2010|Popjetur
81.07.02.2026|Lor-lor
81.07.02.2027|Gaimar
81.07.02.2028|Laininir
81.07.02.2029|Doka Barat
81.07.02.2030|Doka Timur
81.07.02.2031|Jelia
81.07.03.2001|Benjina
81.07.03.2003|Gardakau
81.07.03.2004|Irloy
81.07.03.2005|Algadang
81.07.03.2006|Lorang
81.07.03.2007|Murai
81.07.03.2008|Manjau
81.07.03.2009|Kwarbola
81.07.03.2028|Kobadangar
81.07.03.2029|Kobasel Fara
81.07.03.2030|Kobasel Timur
81.07.03.2031|Fatlabata
81.07.03.2033|Wakua
81.07.03.2034|Jirlay
81.07.03.2035|Maririmar
81.07.03.2036|Papakula
81.07.03.2037|Tanah Miring
81.07.03.2038|Gulili
81.07.03.2039|Namara
81.07.03.2040|Selilau
81.07.03.2043|Maijuring
81.07.03.2045|Selibata-bata
81.07.04.2001|Marlasi
81.07.04.2002|Kolamar
81.07.04.2003|Kabufin
81.07.04.2004|Tasinwaha
81.07.04.2005|Foket
81.07.04.2006|Kaibolafin
81.07.04.2007|Wahangula-Ngula
81.07.04.2008|Wahayum
81.07.04.2009|Warialau
81.07.04.2010|Jerwatu
81.07.04.2013|Selmona
81.07.04.2014|Mesidang
81.07.05.2001|Kabalsiang
81.07.05.2002|Benjuring
81.07.05.2003|Batuley
81.07.05.2004|Kumul
81.07.05.2005|Waria
81.07.05.2006|Sewer
81.07.05.2007|Jursiang
81.07.05.2008|Kompane
81.07.05.2009|Kobamar
81.07.06.2002|Waifual
81.07.06.2003|Wafan
81.07.06.2004|Langhalau
81.07.06.2005|Gomsey
81.07.06.2006|Leiting
81.07.06.2007|Bardefan
81.07.06.2008|Mohongsel
81.07.06.2009|Kolaha
81.07.06.2010|Goda-Goda
81.07.07.2001|Koijabi
81.07.07.2002|Balatan
81.07.07.2003|Warloy
81.07.07.2004|Warjukur
81.07.07.2005|Kobror
81.07.07.2006|Basada
81.07.07.2007|Wailay
81.07.07.2008|Kaiwabar
81.07.07.2009|Ponom
81.07.07.2010|Lola
81.07.07.2011|Mariri
81.07.07.2012|Dosinamalau
81.07.07.2013|Karawai
81.07.08.2001|Longgar
81.07.08.2002|Apara
81.07.08.2003|Bemun
81.07.08.2004|Mesiang
81.07.08.2005|Gomo-Gomo
81.07.08.2006|Jambu Air
81.07.08.2007|Warabal
81.07.09.2001|Meror
81.07.09.2002|Dosimar
81.07.09.2003|Batugoyang
81.07.09.2004|Salarem
81.07.09.2005|Siya
81.07.09.2006|Beltubur
81.07.09.2007|Karey
81.07.09.2008|Jorang
81.07.09.2009|Gomar Sungai
81.07.09.2010|Gomar Meti
81.07.10.2001|Tabarfane
81.07.10.2002|Rebi
81.07.10.2003|Lutur
81.07.10.2004|Hokmar
81.07.10.2005|Juring
81.07.10.2006|Erersin
81.07.10.2007|Maekor
81.08.01.1001|Tiakur
81.08.01.2001|Klis
81.08.01.2002|Patti
81.08.01.2003|Wakarleli
81.08.01.2004|Kaiwatu
81.08.01.2005|Werwaru
81.08.01.2006|Tounwawan
81.08.01.2007|Moain
81.08.02.2001|Wulur
81.08.02.2002|Batu Merah
81.08.02.2003|Kuaimelu
81.08.02.2004|Kumur
81.08.02.2005|Bebar Timur
81.08.02.2006|Ilih
81.08.02.2007|Kehli
81.08.03.2001|Luang Barat
81.08.03.2002|Luang Timur
81.08.03.2003|Elo
81.08.03.2004|Rumkisar
81.08.03.2005|Lelang
81.08.03.2006|Mahaleta
81.08.03.2007|Romdara
81.08.03.2008|Rotnama
81.08.03.2009|Batugajah
81.08.03.2010|Pupliora
81.08.03.2011|Regoha
81.08.04.2001|Tepa
81.08.04.2002|Imroing
81.08.04.2003|Tela
81.08.04.2004|Yaltubung
81.08.04.2005|Wanuwui
81.08.04.2006|Letsiara
81.08.04.2015|Lewah
81.08.04.2016|Hertuti
81.08.04.2017|Sinairusi
81.08.05.2001|Letwurung
81.08.05.2002|Yatoke
81.08.05.2003|Kroing
81.08.05.2004|Nakarhamto
81.08.05.2005|Emplawas
81.08.05.2006|Kokwari
81.08.05.2007|Ahanari
81.08.05.2008|Wakpapapi
81.08.05.2009|Analutur
81.08.05.2010|Manuweri
81.08.05.2011|Tutuwawang
81.08.06.2001|Ilwaki
81.08.06.2002|Ilputih
81.08.06.2003|Mahuan
81.08.06.2004|Masapun
81.08.06.2021|Arnau
81.08.06.2023|Hiay
81.08.07.2001|Wonreli
81.08.07.2002|Lekloor
81.08.07.2003|Kota Lama
81.08.07.2004|Abusur
81.08.07.2005|Oirata Timur
81.08.07.2006|Oirata Barat
81.08.08.2001|Laitutun
81.08.08.2002|Batumiau
81.08.08.2003|Tutukey
81.08.08.2004|Tomra
81.08.08.2005|Nuwewang
81.08.08.2006|Tutuwaru
81.08.08.2007|Luhuely
81.08.09.2001|Latalola Besar
81.08.09.2002|Serili
81.08.09.2003|Latalola Kecil
81.08.09.2004|Telalora
81.08.09.2005|Marsela
81.08.09.2006|Babiotang
81.08.09.2007|Iblatmuntah
81.08.09.2008|Ilbutung
81.08.09.2009|Lawawang
81.08.09.2010|Nura
81.08.09.2011|Bululora
81.08.10.2001|Watuwei
81.08.10.2002|Ilmarang
81.08.10.2003|Letmasa
81.08.10.2004|Welora
81.08.10.2005|Wiratan
81.08.10.2006|Nurnyaman
81.08.11.2001|Herley
81.08.11.2002|Upuhupun
81.08.11.2003|Pota Besar
81.08.11.2004|Pota Kecil
81.08.11.2005|Wasarili
81.08.11.2006|Rumahlewang Kecil
81.08.11.2007|Rumahlewang Besar
81.08.11.2008|Nusiata
81.08.12.2001|Ketty
81.08.12.2002|Letoda
81.08.12.2003|Sera
81.08.12.2004|Yamluli
81.08.12.2005|Lolotuara
81.08.13.2001|Nabar
81.08.13.2002|Elsulith
81.08.13.2003|Naumatang
81.08.13.2004|Lurang
81.08.13.2005|Uhak
81.08.13.2006|Eray
81.08.14.2001|Telemar
81.08.14.2002|Karbubu
81.08.14.2003|Ustutun
81.08.14.2004|Klishatu
81.08.14.2005|Ilmamau
81.08.15.2001|Moning
81.08.15.2002|Arwala
81.08.15.2003|Ilway
81.08.15.2004|Kahilin
81.08.15.2005|Ilpokil
81.08.15.2006|Tomliapat
81.08.16.2001|Hila
81.08.16.2002|Jerusu
81.08.16.2003|Solath
81.08.17.2001|Purpura
81.08.17.2002|Nomaha
81.08.17.2003|Labelau
81.09.01.2001|Wamkana
81.09.01.2002|Waenalut
81.09.01.2003|Lektama
81.09.01.2004|Fatmite
81.09.01.2005|Elfule
81.09.01.2006|Leku
81.09.01.2007|Oki Baru
81.09.01.2008|Oki Lama
81.09.01.2009|Labuang
81.09.01.2010|Wali
81.09.01.2011|Tikbary
81.09.01.2012|Masnana
81.09.01.2013|Kamlanglale
81.09.01.2014|Waenono
81.09.01.2015|Namrinat
81.09.01.2016|Waefusi
81.09.01.2017|Batu Tulis
81.09.02.2001|Waetawa
81.09.02.2002|Waesili
81.09.02.2003|Lena
81.09.02.2004|Simi
81.09.02.2005|Waelikut
81.09.02.2006|Wamsisi
81.09.02.2007|Pohon Batu
81.09.02.2008|Waeteba
81.09.02.2009|Hote
81.09.02.2010|Waemasing
81.09.02.2011|Batu Kasa
81.09.03.2001|Lumoy
81.09.03.2002|Masawoy
81.09.03.2003|Ulima
81.09.03.2004|Kampung Baru
81.09.03.2005|Siwar
81.09.03.2006|Selasi
81.09.03.2007|Elara
81.09.04.2001|Balpetu
81.09.04.2002|Waekeka
81.09.04.2003|Biloro
81.09.04.2004|Nanali
81.09.04.2005|Pasir Putih
81.09.04.2006|Fogi
81.09.04.2007|Waepandan
81.09.04.2008|Walbele
81.09.04.2009|Air Ternate
81.09.04.2010|Sekat
81.09.04.2011|Waeha
81.09.04.2012|Bala-bala
81.09.04.2013|Batu Layar
81.09.04.2014|Siopot
81.09.04.2015|Emguhen
81.09.04.2016|Waehotong
81.09.05.2001|Waemulang
81.09.05.2002|Waeturen
81.09.05.2003|Waehaka
81.09.05.2004|Waemala
81.09.05.2005|Erwiri
81.09.05.2006|Tifu
81.09.05.2007|Mepa
81.09.05.2008|Leksula
81.09.05.2009|Nalbessy
81.09.05.2010|Kase
81.09.05.2015|Neath
81.09.05.2016|Liang
81.09.05.2018|Slealale
81.09.05.2023|Walunhelat
81.09.05.2024|Wahaolon
81.09.05.2025|Waewali
81.09.05.2026|Waenamaolon
81.09.05.2029|Grahwaen
81.09.05.2030|Terkuri
81.09.06.2001|Nusarua
81.09.06.2002|Mangeswaen
81.09.06.2003|Waekatin
81.09.06.2004|Fakal
81.09.06.2005|Uneth
81.09.06.2006|Waeraman
81.09.06.2007|Waelo
81.09.06.2008|Siwatlahin
81.09.06.2009|Trukat
81.09.06.2010|Waeken
81.09.06.2011|Batu Karang
81.71.01.1006|Nusaniwe
81.71.01.1007|Wainitu
81.71.01.1008|Benteng
81.71.01.1009|Kudamati
81.71.01.1010|Mangga Dua
81.71.01.1011|Urimessing
81.71.01.1012|Waihaong
81.71.01.1013|Silale
81.71.01.2001|Latuhalat
81.71.01.2002|Seilale
81.71.01.2003|Nusaniwe
81.71.01.2004|Amahusu
81.71.01.2005|Urimessing
81.71.02.1010|Pandan Kasturi
81.71.02.1011|Rijali
81.71.02.1012|Amantelu
81.71.02.1013|Karang Panjang
81.71.02.1014|Waihoka
81.71.02.1015|Batu Meja
81.71.02.1016|Batu Gajah
81.71.02.1017|Uritetu
81.71.02.1018|Honipopu
81.71.02.1019|Ahusen
81.71.02.2001|Hative Kecil
81.71.02.2002|Galala
81.71.02.2003|Batu Merah
81.71.02.2009|Soya
81.71.03.1018|Lateri
81.71.03.2001|Passo
81.71.03.2002|Halong
81.71.03.2003|Latta
81.71.03.2004|Negeri Lama
81.71.03.2005|Nania
81.71.03.2006|Waiheru
81.71.04.1008|Tihu
81.71.04.2001|Hunuth/Durian Patah
81.71.04.2002|Poka
81.71.04.2003|Rumah Tiga
81.71.04.2004|Wayame
81.71.04.2005|Tawiri
81.71.04.2006|Hative Besar
81.71.04.2007|Laha
81.71.05.2001|Hukurila
81.71.05.2002|Ema
81.71.05.2003|Kilang
81.71.05.2004|Naku
81.71.05.2005|Hatalai
81.71.05.2006|Hutumury
81.71.05.2007|Rutong
81.71.05.2008|Leahari
81.72.01.2001|Fiditan
81.72.01.2002|Ngadi
81.72.01.2003|Dullah
81.72.01.2004|Labetawi
81.72.01.2005|Tamedan
81.72.01.2006|Ohoitahit
81.72.01.2007|Ohoitel
81.72.01.2008|Dullah Laut
81.72.02.1003|Ketsoblak
81.72.02.1004|Masrum
81.72.02.1005|Lodar El
81.72.02.2001|Tual
81.72.02.2002|Taar
81.72.03.2001|Tam Ngurhir
81.72.03.2002|Tayando Langgiar
81.72.03.2003|Tayando Yamtel
81.72.03.2004|Tayando Ohoiel
81.72.03.2005|Tayando Yamru
81.72.04.2001|Tubyal
81.72.04.2002|Kaimear
81.72.04.2004|Lokwirin
81.72.04.2005|Finualen
81.72.04.2012|Sermaf
81.72.05.2001|Kanara
81.72.05.2002|Warkar
81.72.05.2003|Yapas
81.72.05.2004|Rumoin
81.72.05.2005|Hirit
81.72.05.2006|Tiflen
81.72.05.2007|Niela
82.01.01.2001|Gufasa
82.01.01.2002|Guaimaadu
82.01.01.2003|Jalan Baru
82.01.01.2004|Gam Lamo
82.01.01.2005|Soakonora
82.01.01.2006|Galala
82.01.01.2007|Bobanehena
82.01.01.2008|Payo
82.01.01.2009|Bobo
82.01.01.2010|Saria
82.01.01.2011|Idam Dehe
82.01.01.2012|Idamdehe Gamsungi
82.01.01.2013|Marmabati
82.01.01.2014|Gamtala
82.01.01.2015|Lolory
82.01.01.2016|Toboso
82.01.01.2017|Huku-Huku Kie
82.01.01.2018|Acango
82.01.01.2019|Tedeng
82.01.01.2020|Akediri
82.01.01.2021|Pornity
82.01.01.2022|Buku Matiti
82.01.01.2023|Todowongi
82.01.01.2024|Tuada
82.01.01.2025|Matui
82.01.01.2026|Buku Bualawa
82.01.01.2027|Tauro
82.01.01.2034|Hate Bicara
82.01.01.2035|Guaria
82.01.01.2036|Pateng
82.01.01.2037|Bobo Jiko
82.01.01.2038|Ulo
82.01.01.2039|Kuripasai
82.01.01.2040|Buku Maadu
82.01.02.2001|Kedi
82.01.02.2002|Soasio
82.01.02.2003|Totala
82.01.02.2004|Tolofuo
82.01.02.2005|Tuguis
82.01.02.2006|Tasye
82.01.02.2007|Laba Besar
82.01.02.2008|Laba Kecil
82.01.02.2010|Bakun
82.01.02.2011|Buo
82.01.02.2018|Kahatola
82.01.02.2019|Bosala
82.01.02.2020|Salu
82.01.02.2023|Bantoli
82.01.02.2024|Linggua
82.01.02.2025|Tomodo
82.01.02.2026|Totala Jaya
82.01.03.2012|Togola Wayoli
82.01.03.2013|Togola Sangir
82.01.03.2014|Tahafo
82.01.03.2015|Tongute Ternate
82.01.03.2016|Akesibu
82.01.03.2017|Maritango
82.01.03.2018|Kie Ici
82.01.03.2019|Tongute Goin
82.01.03.2020|Tungute Sungi
82.01.03.2021|Gam Ici
82.01.03.2022|Tobaol
82.01.03.2023|Gamlamo
82.01.03.2037|Naga
82.01.03.2040|Soana Masungi
82.01.03.2041|Tongute Ternate Selatan
82.01.03.2042|Ake Boso
82.01.03.2043|Kampung Baru
82.01.04.2001|Susupu
82.01.04.2002|Lako Akelamo
82.01.04.2003|Taruba
82.01.04.2004|Todahe
82.01.04.2005|Peot
82.01.04.2006|Sasur
82.01.04.2007|Goro goro
82.01.04.2008|Tacim
82.01.04.2009|Balisoang
82.01.04.2010|Worat-worat
82.01.04.2011|Tacici
82.01.04.2012|Taraudu
82.01.04.2013|Golo
82.01.04.2028|Lako Akederi
82.01.04.2029|Jara Kore
82.01.04.2030|Ropu Tengah Balu
82.01.04.2033|Dere
82.01.04.2034|Balisoan Utara
82.01.04.2035|Sasur Pantai
82.01.05.2001|Sidangoli Gam
82.01.05.2002|Sidongoli Dehe
82.01.05.2003|Domato
82.01.05.2004|Tataleka
82.01.05.2005|Gamlenge
82.01.05.2006|Akejailolo
82.01.05.2007|Biamaahi
82.01.05.2008|Tuguraci
82.01.05.2009|Akeara
82.01.05.2010|Akelaha
82.01.05.2011|Dodinga
82.01.05.2012|Tewe
82.01.05.2013|Toniku
82.01.05.2014|Rioribati
82.01.05.2021|Taba Damai (DB)
82.01.05.2022|Moiso
82.01.05.2023|Braha
82.01.05.2024|Bangkit Rahmat
82.01.05.2025|Bobane Dano
82.01.05.2026|Suka Damai
82.01.05.2027|Hijrah
82.01.05.2028|Ratem
82.01.05.2029|Bobaneigo Madihutu
82.01.05.2030|Tetewang Joronga
82.01.05.2031|Akelamo Cinga-Cinga
82.01.05.2032|Akesahu Madutu
82.01.07.2001|Podol
82.01.07.2002|Tengowango
82.01.07.2003|Togowo
82.01.07.2004|Duono
82.01.07.2005|Goin
82.01.07.2006|Sangaji Nyeku
82.01.07.2007|Tuguis
82.01.07.2008|Togoreba Sungi
82.01.07.2009|Barona
82.01.07.2010|Todoke
82.01.07.2011|Tolisaor
82.01.07.2012|Pasalulu
82.01.07.2013|Togoreba Tua
82.01.07.2014|Tukuoku
82.01.07.2015|Soasangaji
82.01.07.2016|Aru Jaya
82.01.08.2001|Tosoa
82.01.08.2002|Tobobol
82.01.08.2003|Baru
82.01.08.2004|Nanas
82.01.08.2005|Jere
82.01.08.2006|Gamsungi
82.01.08.2007|Bataka
82.01.08.2008|Talaga
82.01.08.2009|Tobelos
82.01.08.2010|Gamkonora
82.01.08.2011|Sarau
82.01.08.2012|Ngawet
82.01.08.2013|Adu
82.01.08.2014|Gamsida
82.01.08.2015|Ngalo Ngalo
82.01.08.2016|Tuguaer
82.01.09.2001|Loce
82.01.09.2002|Idam Gamlamo
82.01.09.2003|Gamomeng
82.01.09.2004|Akelamo
82.01.09.2005|Taraudu Kusu
82.01.09.2006|Awer
82.01.09.2007|Aketola
82.01.09.2008|Tibobo
82.01.09.2009|Hoku- hoku Gam
82.01.09.2010|Gamiyel
82.01.09.2011|Golago Kusuma
82.01.09.2012|Ngaon
82.01.09.2013|Gamsugi
82.01.09.2014|Taba Campaka
82.01.09.2015|Campaka
82.01.09.2016|Goal
82.01.09.2017|Sidodadi
82.01.09.2018|Air Panas
82.01.10.2001|Jano
82.01.10.2002|Jangailulu
82.01.10.2003|Baja
82.01.10.2004|Gam Kahe
82.01.10.2005|Barataku
82.01.10.2006|Pumadada
82.01.10.2007|Tosomolo
82.01.10.2008|Bilote
82.01.10.2009|Bakun Pantai
82.01.10.2010|Aruku
82.02.01.2004|Nusliko
82.02.01.2005|Were
82.02.01.2020|Fidy Jaya
82.02.01.2021|Sidanga
82.02.01.2022|Nurweda
82.02.01.2023|Wedana
82.02.01.2024|Goeng
82.02.02.2004|Wailegi
82.02.02.2005|Kipai
82.02.02.2006|Yeisowo
82.02.02.2012|Yondeliu
82.02.02.2013|Baka Jaya
82.02.03.2001|Kapaleo
82.02.03.2002|Kacepi
82.02.03.2003|Sanafi
82.02.03.2004|Umera
82.02.03.2005|Umiyal
82.02.03.2006|Sonof Kacepo
82.02.03.2007|Elfanun
82.02.03.2008|Yang
82.02.04.2001|Gemaf
82.02.04.2002|Sagea
82.02.04.2003|Fritu
82.02.04.2004|Waleh
82.02.04.2008|Kiya
82.02.05.2001|Tilope
82.02.05.2002|Sosowomo
82.02.05.2003|Loleo
82.02.05.2004|Wairoro Indah
82.02.05.2005|Kluting Jaya
82.02.05.2006|Lembah Asri
82.02.05.2007|Sumber Sari
82.02.05.2008|Air Salobar
82.02.06.2001|Gemia
82.02.06.2002|Tepeleo
82.02.06.2006|Bilifitu
82.02.06.2007|Tepeleo Batudua
82.02.06.2008|Pantura Jaya
82.02.06.2011|Maliforo
82.02.07.2001|Lililef Waibulan
82.02.07.2002|Lililef Sawai
82.02.07.2003|Sawai Itepo
82.02.07.2004|Kobe
82.02.07.2005|Woekob
82.02.07.2006|Woejerana
82.02.07.2007|Kulo Jaya
82.02.08.2001|Banemo
82.02.08.2002|Bobane Jaya
82.02.08.2003|Bobane Indah
82.02.08.2004|Mareala
82.02.08.2005|Sibenpope
82.02.09.2001|Dotte
82.02.09.2002|Messa
82.02.09.2003|Kotalo
82.02.09.2004|Yeke
82.02.10.2001|Sakam
82.02.10.2002|Nursifa
82.02.10.2003|Damuli
82.02.10.2004|Peniti
82.02.10.2005|Masure
82.02.10.2006|Palo
82.03.04.2001|Soa-Sio
82.03.04.2002|Pune
82.03.04.2003|Mamuya
82.03.04.2016|Toweka
82.03.04.2024|Simau
82.03.04.2031|Barataku
82.03.04.2032|Towara
82.03.05.2004|Gamsungi
82.03.05.2005|Gura
82.03.05.2006|Wari
82.03.05.2012|Kakara
82.03.05.2013|Kumo
82.03.05.2014|Gosoma
82.03.05.2015|Rawajaya
82.03.05.2018|MKCM
82.03.05.2024|Tagalaya
82.03.05.2025|Wari Ino
82.03.06.2001|Kupa Kupa
82.03.06.2002|Gamhoku
82.03.06.2003|Efi Efi
82.03.06.2004|Tomahalu
82.03.06.2005|Paca
82.03.06.2006|Leleoto
82.03.06.2009|Tobe
82.03.06.2015|Kakara B
82.03.06.2018|Talaga Paca
82.03.06.2020|Tioua
82.03.06.2021|Pale
82.03.06.2022|Kupa-kupa Selatan (Halehe)
82.03.06.2024|Lemah Ino
82.03.07.2001|Kao
82.03.07.2002|Jati
82.03.07.2003|Kusu
82.03.07.2009|Waringin Lelewi
82.03.07.2010|Soa Sangaji Dim-Dim
82.03.07.2011|Sasur
82.03.07.2012|Popon
82.03.07.2036|Biang
82.03.07.2037|Patang
82.03.07.2038|Kukumutuk
82.03.07.2039|Waringin Lamo
82.03.07.2050|Goruang
82.03.07.2051|Kusu Lofra
82.03.07.2052|Sumber Agung
82.03.08.2001|Ngofa Kiaha
82.03.08.2002|Ngofa Gita
82.03.08.2003|Samsuma
82.03.08.2004|Tahane
82.03.08.2005|Matsa
82.03.08.2007|Bobawa
82.03.08.2008|Talapao
82.03.08.2009|Tafasoho
82.03.08.2010|Sabaleh
82.03.08.2011|Tagono
82.03.08.2012|Soma
82.03.08.2013|Ngofa Bobawa
82.03.08.2014|Malapa
82.03.08.2015|Mailoa
82.03.08.2016|Peleri
82.03.08.2019|Bukit Tinggi
82.03.08.2022|Terpadu
82.03.08.2023|Tabobo
82.03.08.2024|Balisosang
82.03.08.2025|Sosol/Malifut
82.03.08.2026|Wangeotek
82.03.08.2027|Gayok
82.03.09.2001|Dorume
82.03.09.2002|Apule
82.03.09.2003|Asimiro
82.03.09.2004|Doitia
82.03.09.2005|Ngajam
82.03.09.2006|Kailupa
82.03.09.2007|Gisik
82.03.09.2008|Kapa Kapa
82.03.09.2009|Pacao
82.03.09.2010|Tate
82.03.09.2011|Posi- Posi
82.03.09.2012|Supu
82.03.09.2022|Igo
82.03.09.2023|Galao
82.03.09.2024|Teru-Teru
82.03.09.2026|Wori Moi
82.03.09.2027|Podol
82.03.09.2028|Momojiu
82.03.10.2001|Gorua
82.03.10.2002|Popilo
82.03.10.2003|Luari
82.03.10.2004|Popilo Utara
82.03.10.2005|Tolonuo
82.03.10.2006|Gorua Selatan
82.03.10.2007|Gorua Utara
82.03.10.2008|Kokota Jaya
82.03.10.2009|Ruko
82.03.10.2010|Tolonua Selatan
82.03.11.2001|Upa
82.03.11.2002|Pitu
82.03.11.2003|Wosia
82.03.11.2004|WKO
82.03.11.2005|Kalipitu
82.03.11.2006|Kali Upa
82.03.11.2007|Lina Ino
82.03.11.2008|Mahia (Wosia Tengah)
82.03.11.2009|Tanjung Niara (Wosia Selatan)
82.03.12.2001|Yaro
82.03.12.2002|Mawea
82.03.12.2003|Meti
82.03.12.2004|Katana
82.03.12.2005|Gonga
82.03.12.2006|Todokuiha
82.03.13.2001|Kusuri
82.03.13.2002|Sukamaju
82.03.13.2003|Togoliua
82.03.13.2004|Birinoa
82.03.13.2005|Wangongira
82.03.14.2001|Soatobaru
82.03.14.2002|Dokulamo
82.03.14.2003|Duma
82.03.14.2004|Gotalamo
82.03.14.2005|Makete
82.03.14.2006|Ngidiho
82.03.14.2007|Roko
82.03.14.2008|Samuda
82.03.14.2009|Kira
82.03.15.2001|Limau
82.03.15.2002|Lalonga
82.03.15.2003|Bobisingo
82.03.15.2004|Salimuli
82.03.15.2005|Tutumaloleo
82.03.15.2006|Saluta
82.03.15.2007|Jere
82.03.15.2008|Dodowo
82.03.15.2009|Togasa
82.03.15.2010|Beringin Jaya
82.03.15.2011|Pelita
82.03.15.2012|Jere Tua
82.03.16.2001|Seki
82.03.16.2002|Togawa
82.03.16.2003|Soakonora
82.03.16.2004|Igobula
82.03.16.2005|Bale
82.03.16.2006|Togawabesi
82.03.16.2007|Ori
82.03.19.2001|Salube
82.03.19.2002|Dama
82.03.19.2003|Dowonggila
82.03.19.2004|Tuakara
82.03.19.2005|Jikolamo
82.03.19.2006|Dagasuli
82.03.19.2007|Dedeta
82.03.19.2008|Fitako
82.03.19.2009|Tobo Tobo
82.03.19.2010|Cera
82.03.20.2001|Wateto
82.03.20.2002|Gulo
82.03.20.2003|Tunuo
82.03.20.2004|Pediwang
82.03.20.2005|Bori
82.03.20.2006|Doro
82.03.20.2007|Daru
82.03.20.2008|Bobale
82.03.20.2009|Gamlaha
82.03.20.2010|Boulamo
82.03.20.2011|Warudu
82.03.20.2012|Dowongimaiti
82.03.21.2001|Gaga Apok
82.03.21.2002|Ngoali
82.03.21.2003|Momoda
82.03.21.2004|Toliwang
82.03.21.2005|Tolabit
82.03.21.2006|Leleseng
82.03.21.2007|Soa Hukum
82.03.21.2008|Soa Maetek
82.03.21.2009|Bailengit
82.03.21.2010|Tuguis
82.03.21.2011|Parseba
82.03.21.2012|Pitago
82.03.21.2013|Kai
82.03.21.2014|Toboulamo
82.03.21.2015|Makarti
82.03.21.2016|Sangaji Jaya
82.03.21.2017|Takimo
82.03.21.2018|Torawat
82.03.21.2019|Wonosari
82.03.21.2020|Beringin Agung
82.03.21.2021|Margomolyo
82.03.22.2001|Tiowor
82.03.22.2002|Makaeling
82.03.22.2003|Tobanoma
82.03.22.2004|Barumadehe
82.03.22.2005|Kuntum Mekar
82.03.22.2006|Pasir Putih
82.03.22.2007|Bobaneigo
82.03.22.2008|Tetewang
82.03.22.2009|Akelamo Kao
82.03.22.2010|Gamsungi
82.03.22.2011|Dum-Dum
82.04.01.2001|Rabutdaiyo
82.04.01.2002|Waykion
82.04.01.2003|Gorup
82.04.01.2004|Walo
82.04.01.2005|Dalam
82.04.01.2006|Gitang
82.04.01.2007|Kyowor
82.04.01.2008|Matentengin
82.04.01.2009|Sangapati
82.04.01.2010|Suma
82.04.01.2011|Ploili
82.04.01.2012|Dauri
82.04.01.2013|Gurua
82.04.01.2014|Wailoa
82.04.01.2022|Waigitang
82.04.02.2004|Siko
82.04.02.2005|Gafi
82.04.02.2006|Laigoma
82.04.02.2016|Ligua
82.04.02.2017|Kida
82.04.02.2018|Buli
82.04.02.2019|Talimau
82.04.02.2020|Gunange
82.04.02.2021|Lelei
82.04.02.2022|Bajo
82.04.02.2023|Guruapin
82.04.02.2024|Karamat
82.04.02.2029|Tawabi
82.04.02.2030|Dorolamo
82.04.03.2001|Maffa
82.04.03.2002|Foya
82.04.03.2003|Tobaru
82.04.03.2004|Foya Tobaru
82.04.03.2005|Lalubi
82.04.03.2006|Akelamo
82.04.03.2007|Batonam
82.04.03.2008|Wosi
82.04.03.2014|Sumber Makmur
82.04.03.2020|Kotalow
82.04.03.2022|Kebun Raja
82.04.03.2025|Tanjung Jere
82.04.04.2016|Doro
82.04.04.2017|Koititi
82.04.04.2018|Cango
82.04.04.2019|Saketa
82.04.04.2020|Balitata
82.04.04.2021|Oha
82.04.04.2022|Papaceda
82.04.04.2023|Lemo Lemo
82.04.04.2029|Bumi Rahmat
82.04.04.2036|Tabamasa
82.04.05.2001|Wayaloar
82.04.05.2002|Fluk
82.04.05.2003|Bobo
82.04.05.2004|Mano
82.04.05.2005|Loleo
82.04.05.2007|Soligi
82.04.05.2008|Gambaru
82.04.05.2009|Ocimaloleo
82.04.06.2001|Laiwui
82.04.06.2002|Baru
82.04.06.2003|Buton
82.04.06.2004|Jikotamo
82.04.06.2005|Sambiki
82.04.06.2006|Anggai
82.04.06.2014|Air Mangga Indah
82.04.06.2020|Akegula
82.04.06.2021|Kawasi
82.04.07.2001|Babang
82.04.07.2013|Bori
82.04.07.2014|Nyonyifi
82.04.07.2015|Sabatang
82.04.07.2016|Goro-Goro
82.04.07.2017|Sali Kecil
82.04.07.2018|Timlonga
82.04.07.2021|Sayoang
82.04.07.2022|Wayamiga
82.04.07.2023|Kaireu
82.04.08.2001|Labuha
82.04.08.2002|Amasing Kota
82.04.08.2003|Amasing Kali
82.04.08.2004|Tomori
82.04.08.2009|Indomut
82.04.08.2010|Belang Belang
82.04.08.2026|Sumae
82.04.08.2027|Kaputusan
82.04.08.2030|Amasing Kota Barat
82.04.08.2031|Amasing Kota Utara
82.04.08.2032|Awanggoa
82.04.08.2036|Suma Tinggi
82.04.08.2040|Hidayat
82.04.08.2041|Marabose
82.04.09.2001|Indari
82.04.09.2014|Tawabi
82.04.09.2015|Wiring
82.04.09.2016|Nondang
82.04.09.2017|Kusubibi
82.04.09.2018|Nang
82.04.09.2030|Kokotu
82.04.10.2001|Malapat
82.04.10.2002|Bobawae
82.04.10.2003|Ombawa
82.04.10.2004|Tegono
82.04.10.2005|Mateketen
82.04.10.2006|Talapaon
82.04.10.2007|Sebelei
82.04.11.2001|Bokimiake
82.04.11.2002|Hatejawa
82.04.11.2003|Busua
82.04.11.2004|Fofao
82.04.12.2001|Ngute-Ngute
82.04.12.2002|Laluin
82.04.12.2003|Posi-Posi
82.04.12.2004|Sagawele
82.04.12.2005|Orimakurunga
82.04.12.2006|Pasir Putih
82.04.13.2001|Modayama
82.04.13.2002|Laromabati
82.04.13.2003|Gayap
82.04.13.2004|Ake Jailolo
82.04.13.2005|Wayasipang
82.04.13.2006|Ngokomalako
82.04.14.2001|Sidopo
82.04.14.2002|Lolarogurua
82.04.14.2003|Nusa Babullah
82.04.14.2004|Jojame
82.04.14.2005|Yaba
82.04.14.2006|Geti Lama
82.04.14.2007|Geti Baru
82.04.14.2008|Gilalang
82.04.15.2001|Sidanga
82.04.15.2002|Lata Lata
82.04.15.2003|Sengga Baru
82.04.15.2004|Arumamang
82.04.15.2005|Palamea
82.04.15.2006|Doko
82.04.15.2007|Bisori
82.04.15.2008|Marikapal
82.04.15.2009|Kukupang
82.04.15.2010|Imbu Imbu
82.04.16.2001|Loleo Jaya
82.04.16.2002|Tawa
82.04.16.2003|Marituso
82.04.16.2004|Kou Balabala
82.04.16.2005|Loleo Mekar
82.04.16.2006|Tutuhu
82.04.16.2007|Jeret
82.04.16.2008|Kasiruta Dalam
82.04.17.2001|Kampung Makian
82.04.17.2002|Mandaong
82.04.17.2003|Kupal
82.04.17.2004|Gandasuli
82.04.17.2005|Sawadai
82.04.17.2006|Tuokona
82.04.17.2007|Papaloang
82.04.17.2008|Tembal
82.04.17.2009|Kubung
82.04.17.2010|Panamboang
82.04.18.2001|Sawangakar
82.04.18.2002|Bajo
82.04.18.2003|Tanjung Obit
82.04.18.2004|Prapakanda
82.04.18.2005|Toin
82.04.18.2006|Kampung Baru
82.04.18.2007|Batutaga
82.04.18.2008|Paisumbaos
82.04.19.2001|Lele
82.04.19.2002|Bahu
82.04.19.2003|Jiko
82.04.19.2004|Galala
82.04.19.2005|Tabalema
82.04.19.2006|Yoyok
82.04.20.2001|Pelita
82.04.20.2002|Indong
82.04.20.2003|Waya
82.04.20.2004|Leleongusu
82.04.20.2005|Akedabo
82.04.20.2006|Bobo
82.04.21.2001|Wayaua
82.04.21.2002|Silang
82.04.21.2003|Liaro
82.04.21.2004|Pigaraja
82.04.21.2005|Wayakuba
82.04.21.2006|Tabangame
82.04.21.2007|Tabajaya
82.04.22.2001|Wayatim
82.04.22.2002|Tomara
82.04.22.2003|Tutupa
82.04.22.2004|Tabapoma
82.04.22.2005|Bibinoi
82.04.22.2006|Songa
82.04.22.2007|Tawa
82.04.23.2001|Awis
82.04.23.2002|Dowora
82.04.23.2003|Gane Dalam
82.04.23.2004|Jibubu
82.04.23.2005|Pasipalele
82.04.23.2006|Sekely
82.04.23.2007|Tawa
82.04.23.2008|Yamli
82.04.24.2001|Batulak
82.04.24.2002|Boso
82.04.24.2003|Dolik
82.04.24.2004|Fulai
82.04.24.2005|Gumira
82.04.24.2006|Moloku
82.04.24.2007|Nurjihat
82.04.24.2008|Posi Posi
82.04.24.2009|Samat
82.04.24.2010|Samo
82.04.24.2011|Suka Damai
82.04.24.2012|Tokaka
82.04.25.2001|Gonone
82.04.25.2002|Kakupang
82.04.25.2003|Kurunga
82.04.25.2004|Liboba Hijrah
82.04.25.2005|Pulau Gala
82.04.25.2006|Tawabi
82.04.25.2007|Yomen
82.04.26.2001|Gaimu
82.04.26.2002|Gane Luar
82.04.26.2003|Kuwo
82.04.26.2004|Ranga Ranga
82.04.26.2005|Sawat
82.04.27.2001|Bisui
82.04.27.2002|Lelewi
82.04.27.2003|Luim
82.04.27.2004|Matuting
82.04.27.2005|Matuting Tanjung
82.04.27.2006|Tabahidayah
82.04.27.2007|Tabahijrah
82.04.27.2008|Tagia
82.04.28.2001|Alam Kenanga
82.04.28.2002|Alam Pelita
82.04.28.2003|Jikohai
82.04.28.2004|Manatahan
82.04.28.2005|Soa Sangaji
82.04.28.2006|Tapa
82.04.29.2001|Kelo
82.04.29.2002|Sum
82.04.29.2003|Susepe
82.04.29.2004|Wooi
82.04.30.2001|Cap
82.04.30.2002|Madopolo
82.04.30.2003|Galala
82.04.30.2004|Madopolo Barat
82.04.30.2005|Waringi
82.04.30.2006|Pasir Putih
82.04.30.2007|Madopolo Timur
82.05.01.2001|Waitina
82.05.01.2006|Kau
82.05.01.2007|Waitamela
82.05.01.2013|Karamat Titdoy
82.05.01.2016|Naflo
82.05.02.2001|Mangon
82.05.02.2002|Fagudu
82.05.02.2003|Waibau
82.05.02.2004|Falahu
82.05.02.2005|Fatcei
82.05.02.2006|Fogi
82.05.02.2007|Waihama
82.05.02.2008|Wai Ipa
82.05.02.2009|Umaloya
82.05.02.2010|Pastina
82.05.02.2011|Wailau
82.05.03.2005|Wai Ina
82.05.03.2006|Kabau Pantai
82.05.03.2007|Ona
82.05.03.2008|Kabau Darat
82.05.03.2009|Nahi
82.05.03.2010|Paratina
82.05.06.2001|Dofa
82.05.06.2002|Lekokadai
82.05.06.2003|Lekosula
82.05.06.2009|Pas Ipa
82.05.06.2014|Pelita
82.05.06.2017|Johor
82.05.06.2018|Lelyaba
82.05.07.2001|Waiboga
82.05.07.2002|Soamole
82.05.07.2003|Waiman
82.05.07.2004|Fat Iba
82.05.07.2005|Bega
82.05.07.2006|Manaf
82.05.08.2001|Waigoiyofa
82.05.08.2002|Baleha
82.05.08.2003|Fatkauyon
82.05.08.2004|Wailia
82.05.08.2005|Sama
82.05.08.2006|Waisepa
82.05.09.2001|Waigai
82.05.09.2002|Fuata
82.05.09.2003|Wainib
82.05.09.2004|Skom
82.05.09.2005|Wai Tamua
82.05.10.2001|Kawata
82.05.10.2002|Waisakai
82.05.10.2003|Pelita Jaya
82.05.10.2004|Waisum
82.05.11.2001|Buruakol
82.05.11.2002|Capalulu
82.05.11.2003|Urifola
82.05.11.2004|Mangoli
82.05.11.2005|Wailoba
82.05.11.2006|Paslal
82.05.11.2007|Waitulia
82.05.11.2008|Wai U
82.05.11.2009|Jere
82.05.12.2001|Kaporo
82.05.12.2002|Waikafia
82.05.12.2003|Buya
82.05.12.2004|Auponhia
82.05.12.2005|Wailab
82.05.13.2001|Falabisahaya
82.05.13.2002|Modapia
82.05.13.2003|Modapuhi
82.05.13.2004|Pastabulu
82.05.13.2005|Saniahaya
82.05.13.2006|Minaluli
82.05.13.2007|Modapuhi Trans
82.05.18.2001|Man-Gega
82.05.18.2002|Bajo
82.05.18.2003|Pohea
82.05.18.2004|Fukweu
82.05.18.2005|Wainin
82.05.18.2006|Malbufa
82.05.18.2007|Fokalik
82.06.01.2006|Subaim
82.06.01.2008|Cemara Jaya
82.06.01.2009|Bumi Restu
82.06.01.2014|Batu Raja
82.06.01.2015|Mekar Sari
82.06.01.2016|Gulapapo
82.06.01.2027|Waisuba
82.06.02.2001|Buli
82.06.02.2002|Buli Asal
82.06.02.2003|Buli Karya
82.06.02.2011|Wayafli
82.06.02.2012|Sailal
82.06.02.2013|Geltoli
82.06.02.2014|Pekaulang
82.06.02.2023|Teluk Buli
82.06.02.2024|Gamesan
82.06.02.2025|Baburino
82.06.03.2001|Bicoli
82.06.03.2002|Waci
82.06.03.2003|Peteley
82.06.03.2004|Loleolamo
82.06.03.2005|Gotowasi
82.06.03.2010|Kasuba
82.06.03.2012|Momole
82.06.03.2013|Sil
82.06.03.2014|Sowoli
82.06.04.2001|Nusa Jaya
82.06.04.2002|Nusa Ambo
82.06.04.2003|Loleba
82.06.04.2004|Waijoi
82.06.04.2005|Pintatu
82.06.04.2006|Minamin
82.06.04.2007|Saramaake
82.06.04.2008|Fayaul
82.06.04.2009|Binagara
82.06.04.2010|Wasile
82.06.04.2011|Tomares
82.06.04.2012|Tabanalou
82.06.04.2013|Saolat
82.06.04.2014|Nanas
82.06.04.2015|Talaga Jaya
82.06.04.2016|Sondo-Sondo
82.06.04.2017|Ino Jaya
82.06.04.2018|Ake Jawi
82.06.04.2019|Ekor
82.06.04.2020|Ekorino
82.06.04.2021|Jiko Moi
82.06.04.2022|Tanure
82.06.04.2023|Yawal
82.06.04.2024|Bukutio
82.06.05.2001|Hate Tabako
82.06.05.2002|Lolobata
82.06.05.2003|Puao
82.06.05.2004|Foli
82.06.05.2005|Nyaolako
82.06.05.2006|Bokimaake
82.06.05.2007|Silalayang
82.06.05.2008|Kakaraino
82.06.06.2001|Labi-Labi
82.06.06.2002|Iga
82.06.06.2003|Tatam
82.06.06.2004|Marimoi
82.06.06.2005|Bololo
82.06.06.2006|Hilaitetor
82.06.06.2007|Dowongi Jaya
82.06.06.2008|Majiko Tongone
82.06.07.2001|Dodaga
82.06.07.2002|Dakaino
82.06.07.2003|Akedaga
82.06.07.2004|Toboino
82.06.07.2005|Tutuling Jaya
82.06.07.2006|Woka Jaya
82.06.07.2007|Rawamangun
82.06.07.2008|Sidomulyo
82.06.08.2001|Wayamli
82.06.08.2002|Beringin Lamo
82.06.08.2003|Miaf
82.06.08.2004|Bangul
82.06.08.2005|Marasipno
82.06.08.2006|Dorolamo
82.06.08.2007|Maratana Jaya
82.06.08.2008|Bebsili
82.06.08.2009|Yawanli
82.06.08.2010|Gaifoli
82.06.08.2011|Babasaram
82.06.08.2012|Tatangapu
82.06.09.2001|Sosolat
82.06.09.2002|Dorosago
82.06.09.2003|Patlean
82.06.09.2004|Lolasita
82.06.09.2005|Wasileo
82.06.09.2006|Pumlanga
82.06.09.2007|Jara-jara
82.06.09.2008|Doromoi
82.06.09.2009|Lili
82.06.09.2010|Patlean Jaya
82.06.10.2001|Wailukum
82.06.10.2002|Soalaipoh
82.06.10.2003|Soasangaji
82.06.10.2004|Soagimalaha
82.06.10.2005|Maba Sangaji
82.06.10.2006|Tewil
82.07.01.2001|Gotalamo
82.07.01.2002|Daruba
82.07.01.2003|Darame
82.07.01.2004|Wawama
82.07.01.2005|Pandanga
82.07.01.2006|Juanga
82.07.01.2007|Totodoku
82.07.01.2008|Momojiu
82.07.01.2009|Sabatai Baru
82.07.01.2010|Sabatai Tua
82.07.01.2011|Daeo
82.07.01.2012|Dehegila
82.07.01.2013|Pilowo
82.07.01.2014|Galo-Galo
82.07.01.2015|Koloray
82.07.01.2016|Yayasan
82.07.01.2017|Joubela
82.07.01.2018|Aha
82.07.01.2019|Muhajirin
82.07.01.2020|Mandiri
82.07.01.2021|Falila
82.07.01.2022|Sabala
82.07.01.2023|Daeo Majiko
82.07.01.2024|Morodadi
82.07.01.2025|Nakamura
82.07.02.2001|Wayabula
82.07.02.2002|Tiley
82.07.02.2003|Ngele-Ngele Kecil
82.07.02.2004|Cucumare
82.07.02.2005|Aru Irian
82.07.02.2006|Waringin
82.07.02.2007|Tutuhu
82.07.02.2008|Cio Gerong
82.07.02.2014|Ngele-ngele Besar
82.07.02.2015|Raja
82.07.02.2016|Cio Dalam
82.07.02.2017|Usbar Pantai
82.07.02.2018|Tiley Pantai
82.07.02.2019|Cio Maloleo
82.07.02.2020|Bobula
82.07.03.2001|Pangeo
82.07.03.2002|Sopi
82.07.03.2003|Bere Bere Kecil
82.07.03.2004|Titigogoli
82.07.03.2005|Hapo
82.07.03.2006|Libano
82.07.03.2007|Aru
82.07.03.2008|Towara
82.07.03.2009|Cendana
82.07.03.2010|Podimor Padange
82.07.03.2011|Sopi Majiko
82.07.03.2012|Gorugo
82.07.03.2013|Loleo
82.07.03.2014|Cempaka
82.07.04.2001|Bere-bere
82.07.04.2002|Sakita
82.07.04.2003|Tawakali
82.07.04.2004|Yao
82.07.04.2005|Bido
82.07.04.2006|Gorua
82.07.04.2007|Korago
82.07.04.2008|Lusuo
82.07.04.2009|Kenari
82.07.04.2010|Loleo Jaya
82.07.04.2011|Maba
82.07.04.2012|Tanjung Saleh
82.07.04.2013|Goa Hira
82.07.04.2014|Gorua Selatan
82.07.05.2001|Buho-Buho
82.07.05.2002|Wewemo
82.07.05.2003|Mira
82.07.05.2004|Lifao
82.07.05.2005|Rahmat
82.07.05.2006|Sambiki Tua
82.07.05.2007|Sangowo
82.07.05.2008|Sambiki Baru
82.07.05.2009|Sangowo Barat
82.07.05.2010|Sangowo Timur
82.07.05.2011|Seseli Jaya
82.07.05.2012|Hino
82.07.05.2013|Gosoma Maluku
82.07.05.2014|Gamlamo
82.07.05.2015|Doku Mira
82.07.06.2001|Posi-Posi
82.07.06.2002|Aru Burung
82.07.06.2003|Lou Madoro
82.07.06.2004|Leo-Leo
82.07.06.2005|Sami Nyamau
82.08.01.2001|Bobong
82.08.01.2002|Talo
82.08.01.2003|Kawalo
82.08.01.2004|Limbo
82.08.01.2005|Meranti Jaya
82.08.01.2006|Kramat
82.08.01.2007|Holbota
82.08.01.2008|Pancoran
82.08.01.2009|Wayo
82.08.01.2010|Loho Bubba
82.08.01.2011|Kilong
82.08.01.2012|Ratahaya
82.08.01.2013|Woyo
82.08.02.2001|Nggele
82.08.02.2002|Salati
82.08.02.2003|Beringin Jaya
82.08.02.2004|Kasango
82.08.02.2005|Onemay
82.08.03.2001|Lede
82.08.03.2002|Todoli
82.08.03.2003|Tolong
82.08.03.2004|Langganu
82.08.03.2005|Balohang
82.08.04.2001|Mananga
82.08.04.2002|Tanjung Una
82.08.04.2003|Jorjoga
82.08.04.2004|Gela
82.08.04.2005|Minton
82.08.04.2006|Nunca
82.08.04.2007|Sahu
82.08.04.2008|Bua Mbono
82.08.04.2009|Hai
82.08.04.2010|Tikong
82.08.04.2011|Dege
82.08.04.2012|Air Bulan
82.08.04.2013|Air Kalimat
82.08.04.2014|Ufung
82.08.04.2015|Padang
82.08.04.2016|Natang Kuning
82.08.04.2017|Nunu
82.08.04.2018|London
82.08.04.2019|Wahe
82.08.05.2001|Penu
82.08.05.2002|Parigi
82.08.05.2003|Samuya
82.08.05.2004|Tubang
82.08.06.2001|Waikadai
82.08.06.2002|Losseng
82.08.06.2003|Kawadang
82.08.06.2004|Sofan
82.08.06.2005|Mantarara
82.08.06.2006|Belo
82.08.06.2007|Kamaya
82.08.06.2008|Waikoka
82.08.06.2009|Waikadai Sula
82.08.07.2001|Bahu
82.08.07.2002|Bapenu
82.08.07.2003|Kilo
82.08.07.2004|Pancado
82.08.07.2005|Nggaki
82.08.07.2006|Sumbong
82.08.07.2007|Maluli
82.08.07.2008|Galebo
82.08.07.2009|Nggoli
82.08.08.2001|Tabona
82.08.08.2002|Kabunu
82.08.08.2003|Peleng
82.08.08.2004|Fayaunana
82.08.08.2005|Habunuha
82.08.08.2006|Kataga
82.08.08.2007|Wolio
82.71.01.1001|Jambula
82.71.01.1002|Foramadiahi
82.71.01.1003|Kastela
82.71.01.1004|Rua
82.71.01.1005|Afe Taduma
82.71.01.1019|Dorpedu
82.71.02.1001|Sasa
82.71.02.1002|Gambesi
82.71.02.1003|Fitu
82.71.02.1004|Kalumata
82.71.02.1005|Kayu Merah
82.71.02.1006|Bastiong Talangame
82.71.02.1007|Ubo-Ubo
82.71.02.1008|Mangga Dua
82.71.02.1009|Jati
82.71.02.1010|Toboko
82.71.02.1011|Tanah Tinggi
82.71.02.1020|Tanah Tinggi Barat
82.71.02.1021|Mangga Dua Utara
82.71.02.1022|Jati Perumnas
82.71.02.1023|Tabona
82.71.02.1024|Bastiong Karance
82.71.02.1025|Ngade
82.71.03.1007|Soa
82.71.03.1008|Soa Sio
82.71.03.1009|Kasturian
82.71.03.1010|Salero
82.71.03.1011|Toboleu
82.71.03.1012|Sangaji
82.71.03.1013|Dufa-Dufa
82.71.03.1014|Tafure
82.71.03.1015|Tabam
82.71.03.1016|Sango
82.71.03.1017|Tarau
82.71.03.1019|Sangaji utara
82.71.03.1020|Akehuda
82.71.03.1021|Tubo
82.71.04.1001|Takofi
82.71.04.1002|Moti Kota
82.71.04.1003|Tafamutu
82.71.04.1004|Tafaga
82.71.04.1006|Figur
82.71.04.1007|Tadenas
82.71.05.1001|Mayau
82.71.05.1002|Tifure
82.71.05.1003|Lelewi
82.71.05.1004|Bido
82.71.05.1005|Pantai Sagu
82.71.05.1006|Perum Bersatu
82.71.06.1001|Takoma
82.71.06.1002|Tanah Raja
82.71.06.1003|Muhajirin
82.71.06.1004|Stadion
82.71.06.1005|Maliaro
82.71.06.1006|Kampung Pisang
82.71.06.1007|Marikurubu
82.71.06.1008|Kota Baru
82.71.06.1009|Gamalama
82.71.06.1010|Kalumpang
82.71.06.1011|Moya
82.71.06.1012|Santiong
82.71.06.1013|Makassar Barat
82.71.06.1014|Makassar Timur
82.71.06.1015|Salahuddin
82.71.06.1016|Tongole
82.71.07.1001|Faudu
82.71.07.1002|Tomajiko
82.71.07.1003|Dorari Isa
82.71.07.1004|Togolobe
82.71.07.1005|Mado
82.71.07.1006|Tafraka
82.71.08.1001|Tagafo
82.71.08.1002|Loto
82.71.08.1003|Takome
82.71.08.1004|Sulamadaha
82.71.08.1005|Tobololo
82.71.08.1006|Bula
82.71.08.1007|Kulaba
82.72.01.1001|Soasio
82.72.01.1002|Gamtufkange
82.72.01.1003|Indonesiana
82.72.01.1005|Seli
82.72.01.1006|Soadara
82.72.01.1007|Topo
82.72.01.1008|Gurabunga
82.72.01.1012|Goto
82.72.01.1013|Tomagoba
82.72.01.1014|Folarora
82.72.01.1015|Topo Tiga
82.72.01.1016|Tambula
82.72.01.1017|Tuguwaji
82.72.02.1002|Guraping
82.72.02.1003|Sofifi
82.72.02.2001|Kaiyasa
82.72.02.2005|Oba
82.72.02.2006|Somahode
82.72.02.2007|Ake Kolano
82.72.02.2009|Balbar
82.72.02.2010|Bukit Durian
82.72.02.2011|Galala
82.72.02.2012|Ampera
82.72.02.2013|Kusu
82.72.02.2014|Garojou
82.72.02.2015|Gosale
82.72.03.1004|Payahe
82.72.03.2001|Woda
82.72.03.2002|Gita
82.72.03.2003|Toseho
82.72.03.2005|Kususinopa
82.72.03.2008|Bale
82.72.03.2009|Koli
82.72.03.2010|Kosa
82.72.03.2011|Tului
82.72.03.2012|Todapa
82.72.03.2013|Talasi
82.72.03.2014|Sigela Yef
82.72.03.2015|Talagamori
82.72.04.1001|Toloa
82.72.04.1002|Dokiri
82.72.04.1003|Tuguiha
82.72.04.1004|Tomalou
82.72.04.1005|Gurabati
82.72.04.1006|Tongowai
82.72.04.2007|Mare Kofo
82.72.04.2008|Mare Gam
82.72.05.1001|Rum
82.72.05.1002|Fobaharu
82.72.05.1003|Jaya
82.72.05.1004|Ome
82.72.05.1005|Mareku
82.72.05.1006|Afa Afa
82.72.05.1008|Bobo
82.72.05.1009|Gubu Kusuma
82.72.05.1010|Sirongo Folaraha
82.72.05.1011|Rum Balibunga
82.72.05.2007|Maitara
82.72.05.2012|Maitara Selatan
82.72.05.2013|Maitara Utara
82.72.05.2014|Maitara Tengah
82.72.06.1001|Akelamo
82.72.06.2002|Lola
82.72.06.2003|Aketobololo
82.72.06.2004|Aketobatu
82.72.06.2005|Akedotilou
82.72.06.2006|Akeguraci
82.72.06.2007|Akesai
82.72.06.2008|Togeme
82.72.06.2009|Tadupi
82.72.06.2010|Beringin Jaya
82.72.06.2011|Tauno
82.72.06.2012|Fanaha
82.72.06.2013|Yehu
82.72.06.2014|Siokona
82.72.07.2001|Maidi
82.72.07.2002|Lifofa
82.72.07.2003|Hager
82.72.07.2004|Wama
82.72.07.2005|Selamalofo
82.72.07.2006|Tagalaya
82.72.07.2007|Nuku
82.72.08.1001|Mafututu
82.72.08.1002|Tosa
82.72.08.1003|Dowora
82.72.08.1004|Kalaodi
82.72.08.1005|Cobodoe
82.72.08.1006|Doyado
82.72.08.1007|Jiko Cobo
91.03.01.1001|Sentani Kota
91.03.01.1002|Dobonsolo
91.03.01.1003|Hinekombe
91.03.01.2004|Sereh
91.03.01.2005|Yobeh
91.03.01.2006|Ilfele
91.03.01.2011|Hobong
91.03.01.2017|Yahim
91.03.01.3007|Desa Adat Yoboi
91.03.01.3010|Desa Adat Heaiseai Yomo Heai
91.03.02.2001|Nolokla
91.03.02.2002|Puai
91.03.02.2004|Asei Besar
91.03.02.2006|Nendali
91.03.02.3003|Desa Adat Ayapo
91.03.02.3005|Desa Adat Kleuwblou
91.03.02.3007|Desa Adat Yokiwa
91.03.03.2001|Waiya
91.03.03.2002|Entiyebo
91.03.03.2003|Kendate
91.03.03.2004|Tablasupa
91.03.03.2005|Yepase
91.03.03.2006|Wambena
91.03.03.2007|Yewena
91.03.03.2012|Doromena
91.03.04.2001|Dosay
91.03.04.2005|Maribu
91.03.04.2008|Sabron Sari
91.03.04.2011|Sabro Yaru
91.03.04.3006|Desa Adat Waibron Bano
91.03.05.2001|Sama
91.03.05.2002|Manda Yawan
91.03.05.2003|Mamda
91.03.05.2004|Mamei
91.03.05.2005|Nambom
91.03.05.2006|Kwansu
91.03.05.2007|Soaib
91.03.05.2008|Sabeab Kecil
91.03.05.2009|Sekori
91.03.05.2010|Skoaim
91.03.05.2011|Benggwin Progo
91.03.05.2012|Aib
91.03.06.1015|Hatib
91.03.06.2001|Domoikati
91.03.06.2002|Dementin
91.03.06.2003|Yanbra
91.03.06.2004|Braso
91.03.06.2005|Pupehabu
91.03.06.2006|Bring
91.03.06.2007|Nembu Gresi
91.03.06.2009|Ibub
91.03.06.2013|Swentab
91.03.06.2014|Jagrang
91.03.06.2016|Hyansip
91.03.07.1021|Tabri
91.03.07.2001|Gemebs
91.03.07.2002|Singgri
91.03.07.2003|Meyu
91.03.07.2004|Benyom
91.03.07.2005|Oyengsi
91.03.07.2006|Singgriway
91.03.07.2009|Imsar
91.03.07.2010|Kuipons
91.03.07.2014|Yenggu Baru
91.03.07.2015|Yenggu Lama
91.03.07.2017|Kuwase
91.03.07.2019|Pobaim
91.03.07.3018|Desa Adat Ketemung
91.03.08.2001|Nimbokrang
91.03.08.2002|Benyom Jaya I
91.03.08.2003|Benyom Jaya II
91.03.08.2004|Berab
91.03.08.2005|Hamonggrang
91.03.08.2006|Wahab
91.03.08.2007|Nombukrang Sari
91.03.08.2008|Rhepang Muaf
91.03.08.2009|Bunyom
91.03.09.2001|Beneik
91.03.09.2002|Ganusa
91.03.09.2003|Guryard
91.03.09.2004|Santosa
91.03.09.2005|Sawa Suma
91.03.09.2006|Nandaizi
91.03.10.2001|Demta
91.03.10.2002|Ambora
91.03.10.2003|Yougapsa
91.03.10.2004|Muris Kecil
91.03.10.2005|Yakore
91.03.10.2006|Kamdera
91.03.10.2007|Muaif
91.03.11.2001|Lapua
91.03.11.2002|Sebum
91.03.11.2003|Soskotek
91.03.11.2004|Yadauw
91.03.11.2006|Umbron
91.03.12.2001|Ebungfa
91.03.12.2002|Atabar
91.03.12.2004|Khameyoka
91.03.12.3003|Desa Adat Bobrongko
91.03.12.3005|Desa Adat Homfolo
91.03.13.2002|Doyo Lama
91.03.13.2003|Kwadeware
91.03.13.2004|Yakonde
91.03.13.2005|Sosiri
91.03.13.2006|Doyo Baru
91.03.13.3001|Desa Adat Dondai
91.03.13.3007|Desa Adat Bambar
91.03.14.2001|Sarmai Atas
91.03.14.2002|Sarmai Bawah
91.03.14.2003|Sanggai
91.03.14.2004|Yakasib
91.03.14.2005|Besum
91.03.14.2007|Imestum
91.03.14.2008|Karya Bumi
91.03.14.2009|Hanggaiy Hamong
91.03.14.2010|Sumbe
91.03.15.2001|Tabbeyan
91.03.15.2002|Kwarja
91.03.15.2003|Ongan Jaya
91.03.15.2004|Bumi Sahaja
91.03.15.2005|Nawa Mulya
91.03.15.2006|Nawa Mukti
91.03.15.2007|Taqwa Bangun
91.03.15.2008|Purnama Jati
91.03.15.3009|Desa Adat Bundru
91.03.16.2001|Hulu Atas
91.03.16.2002|Pagai
91.03.16.2003|Aurina
91.03.16.2004|Muara Nawa
91.03.16.2005|Kamikaru
91.03.16.2006|Naira
91.03.17.2001|Yongsu Sapari
91.03.17.2002|Yongsu Dosoyo
91.03.17.2003|Newa
91.03.17.3004|Desa Adat Nechive
91.03.18.2001|Omon
91.03.18.2003|Klaisu
91.03.18.2004|Bangai
91.03.18.3002|Desa Adat Iwon
91.03.19.2001|Maruwai
91.03.19.2002|Meukisi
91.03.19.2003|Endokisi
91.03.19.2005|Buseryo
91.03.19.2006|Senamay
91.05.01.1004|Tarau
91.05.01.1005|Serui Kota
91.05.01.1006|Serui Jaya
91.05.01.2014|Serui Laut
91.05.01.2015|Banawa
91.05.01.2017|Turu
91.05.01.2019|Pasir Hitam
91.05.01.2020|Pasir Putih
91.05.01.2023|Manaini
91.05.01.2024|Imandoa
91.05.01.2026|Barawaikap
91.05.01.2027|Bawai
91.05.01.2028|Nundawipi
91.05.02.1003|Ansus
91.05.02.2002|Webi
91.05.02.2004|Papuama
91.05.02.2007|Kairawi
91.05.02.2008|Natabui
91.05.02.2010|Warabori
91.05.02.2012|Wimoni
91.05.02.2013|Sasawa
91.05.02.2015|Inowa
91.05.02.2016|Maniri
91.05.02.2017|Nuiwiora
91.05.02.2018|Yenusi Marau
91.05.02.2019|Marau
91.05.02.2020|Toweta
91.05.02.2021|Woiwani
91.05.02.2022|Yarori
91.05.02.2023|Narei
91.05.03.2004|Korombobi
91.05.03.2005|Dawai
91.05.03.2010|Wabo
91.05.03.2014|Nunsembai
91.05.03.2015|Nunsiari
91.05.03.2023|Woinsupi
91.05.03.2024|Awunawai
91.05.03.2025|Mareruni
91.05.03.2031|Wabompi
91.05.03.2036|Duai
91.05.03.2037|Sere Sere
91.05.04.2003|Menawi
91.05.04.2004|Wadapi
91.05.04.2009|Kainui I
91.05.04.2010|Aitiri
91.05.04.2011|Wawuti
91.05.04.2015|Roipi
91.05.04.2016|Ransarnoni
91.05.04.2021|Kainui II
91.05.04.2024|Wanampompi
91.05.04.2028|Mananayam
91.05.04.2030|Roipi Dua
91.05.05.2001|Poom I
91.05.05.2003|Serewen
91.05.05.2006|Poom II
91.05.05.2007|Mokiroan
91.05.05.2011|Rarisi
91.05.05.2012|Warioi
91.05.05.2015|Humbe Awai
91.05.05.2016|Nurawi
91.05.06.2001|Kamanap
91.05.06.2002|Aromarea
91.05.06.2003|Maria Rotu
91.05.06.2004|Kanawa
91.05.06.2005|Tatui
91.05.06.2006|Ariepi
91.05.06.2007|Sarawandori
91.05.06.2008|Ambaidiru
91.05.06.2009|Mambo
91.05.06.2010|Manainin
91.05.06.2011|Numaman
91.05.06.2012|Ramangkurani
91.05.06.2013|Sarawandori Dua
91.05.06.2014|Ariepi Dua
91.05.06.2015|Panduami
91.05.07.2001|Tindaret
91.05.07.2002|Yobi
91.05.07.2003|Sambrawai
91.05.07.2006|Kiriyou
91.05.07.2007|Soromasen
91.05.07.2009|Roswari
91.05.07.2010|Doreimanona
91.05.08.2001|Waindu
91.05.08.2008|Barawai
91.05.08.2009|Woda
91.05.08.2010|Kororompui
91.05.08.2011|Aisau
91.05.08.2012|Sewenui
91.05.08.2013|Sawendui
91.05.09.2001|Randawaya
91.05.09.2002|Warironi
91.05.09.2003|Ampimoi
91.05.09.2004|Waita
91.05.09.2005|Ayari
91.05.09.2006|Koroapi
91.05.09.2007|Wabuayar
91.05.09.2008|Tarei
91.05.09.2009|Bareraif
91.05.09.2010|Arareni
91.05.09.2011|Siromi
91.05.10.2001|Ambai I
91.05.10.2004|Kawipi
91.05.10.2005|Wamori
91.05.10.2006|Adiwipi
91.05.10.2008|Ambai II
91.05.10.2009|Mambawi
91.05.10.2010|Baisore
91.05.10.2011|Rondepi
91.05.10.2014|Imboriawa
91.05.10.2015|Bairei
91.05.10.2016|Aiwaraggani
91.05.10.2017|Toroa
91.05.10.2019|Marawi
91.05.11.2001|Wooi
91.05.11.2002|Woinap
91.05.11.2003|Aibondeni
91.05.11.2004|Kanaki
91.05.11.2005|Dumani
91.05.11.2007|Karemoni
91.05.11.2008|Haihorei
91.05.11.2009|Rembai
91.05.11.2010|Jaimaria
91.05.11.2011|Awado
91.05.12.2001|Kaonda
91.05.12.2002|Windesi
91.05.12.2003|Munggui
91.05.12.2004|Karawi
91.05.12.2005|Asai
91.05.12.2006|Rosbori
91.05.12.2007|Waisani
91.05.12.2008|Saruman
91.05.12.2009|Aryobu
91.05.13.2001|Kaipuri
91.05.13.2002|Doreianmini
91.05.13.2003|Andersaria
91.05.13.2004|Kurudu
91.05.13.2005|Kirimbri
91.05.13.2006|Manusundu
91.05.13.2007|Mnukwar
91.05.13.2008|Mansesi
91.05.14.2001|Miosnum
91.05.14.2002|Jeniari
91.05.14.2003|Umpeki
91.05.14.2004|Ausem
91.05.14.2005|Yeituarau
91.05.15.1001|Anatorei
91.05.15.2001|Ketu Api
91.05.15.2002|Mariaderi
91.05.15.2003|Yapan
91.05.15.2004|Mantembu
91.05.15.2005|Famboaman
91.05.15.2006|Kandowarira
91.05.15.2007|Warari
91.05.16.2001|Kontinuai
91.05.16.2002|Woniwon
91.05.16.2003|Sanayoka
91.05.16.2004|Rambai
91.05.16.2005|Yafanani
91.05.16.2006|Borai
91.05.16.2007|Kabuaena
91.05.17.2001|Saweru
91.05.17.2002|Umani
91.05.17.2003|Perea
91.05.17.2004|Nuniandei
91.05.17.2005|Dorau
91.06.01.1001|Sorido
91.06.01.1002|Waupnor
91.06.01.1003|Saramon
91.06.01.1004|Burokup
91.06.01.1005|Fandoi
91.06.01.1006|Mandala
91.06.01.1016|Yenures
91.06.01.2007|Mnubabo
91.06.01.2008|Swapodibo
91.06.01.2009|Mokmer
91.06.01.2010|Inggiri
91.06.01.2011|Parai
91.06.01.2012|Samau
91.06.01.2013|Insrom
91.06.01.2014|Anggraidi
91.06.01.2015|Manswam
91.06.01.2017|Sanumi
91.06.01.2018|Manggandisapi
91.06.01.2019|Karyendi
91.06.01.2020|Kababur
91.06.01.2021|Babrinbo
91.06.01.2022|Inggupi
91.06.02.2001|Sarwom
91.06.02.2002|Andei
91.06.02.2004|Waromi
91.06.02.2006|Kobeoser
91.06.02.2007|Mambesak
91.06.02.2008|Saukobye
91.06.02.2010|Yobdi
91.06.02.2012|Dernafi
91.06.02.2013|Rosayendi
91.06.02.2016|Warsansan
91.06.02.2017|Nermnu
91.06.02.2018|Korem
91.06.02.2019|Mnuswor
91.06.02.2020|Dofyo Wafor
91.06.02.2021|Warbon
91.06.02.2022|Wari
91.06.03.2002|Rimba Jaya
91.06.03.2003|Owi
91.06.03.2004|Woniki
91.06.03.2005|Kajasi
91.06.03.2010|Sunde
91.06.03.2011|Sepse
91.06.03.2012|Soon
91.06.03.2013|Sareidi
91.06.03.2014|Bindusi
91.06.03.2015|Orwer
91.06.03.2016|Yenusi
91.06.03.2017|Kajasbo
91.06.03.2021|Ruar
91.06.03.2022|Mandon
91.06.03.2023|Soryar
91.06.03.2028|Insumarires
91.06.03.2030|Rim
91.06.03.2031|Adorbari
91.06.03.2032|Bosnik Sup
91.06.03.2033|Inofi
91.06.03.2034|Yenberok
91.06.03.2035|Wasori
91.06.03.2036|Yendakem
91.06.03.2037|Waderbo
91.06.03.2038|Afefbo
91.06.03.2039|Inmdi
91.06.04.2003|Namber
91.06.04.2004|Baruki
91.06.04.2005|Kameri
91.06.04.2008|Warido
91.06.04.2012|Sub Manggunsi
91.06.04.2013|Serbin
91.06.04.2014|Kansai
91.06.04.2015|Pomdori
91.06.04.2019|Semayen
91.06.04.2020|Mambodo Sawai
91.06.04.2021|Rimbaraya
91.06.04.2022|Pomdori Sup
91.06.05.2006|Yenburwo
91.06.05.2011|Kornasoren
91.06.05.2014|Rarsibo
91.06.05.2015|Asaryendi
91.06.05.2016|Yenmanu
91.06.05.2017|Pyefuri
91.06.05.2018|Indaibori
91.06.05.2019|Barkori
91.06.05.2020|Asaibori
91.06.08.2001|Andei
91.06.08.2002|Kanaan
91.06.08.2003|Asaryendi
91.06.08.2004|Sopendo
91.06.08.2006|Ampunbukor
91.06.08.2008|Wasyai
91.06.08.2009|Kababur
91.06.08.2010|Warberik
91.06.08.2011|Sosmai
91.06.08.2012|Yomdori
91.06.08.2013|Opuri
91.06.08.2014|Mamoribo
91.06.08.2021|Insiri
91.06.08.2024|Asarkir
91.06.08.2025|Dousi
91.06.08.2026|Marisen
91.06.08.2027|Sumbinya
91.06.08.2029|Rarsbari
91.06.08.2030|Banasrares
91.06.08.2031|Karnindi
91.06.08.2032|Dedifu
91.06.08.2033|Sopendo Sup Karkir
91.06.09.2003|Marur
91.06.09.2004|Diano
91.06.09.2005|Sawai
91.06.09.2006|Aman
91.06.09.2007|Yeruboi
91.06.09.2008|Amoi
91.06.09.2009|Inswambesi
91.06.09.2010|Koyomi
91.06.09.2011|Wasani
91.06.09.2017|Karuiberik
91.06.09.2018|Komboi
91.06.09.2020|Inswambesi Sup
91.06.09.2021|Inyobi
91.06.09.2023|Maniri
91.06.09.2024|Imbari
91.06.09.2025|Manbeori
91.06.09.2026|Warawaf
91.06.09.2027|Wir Insos
91.06.09.2028|Biawer
91.06.09.2029|Mamfias
91.06.10.2001|Pai
91.06.10.2002|Auki
91.06.10.2003|Wundi
91.06.10.2004|Nusi Babaruk
91.06.10.2005|Nusi
91.06.10.2014|Inbeyomi
91.06.10.2015|Sorina
91.06.10.2016|Sandidori
91.06.10.2020|Paidori
91.06.10.2021|Kanai
91.06.10.2022|Sokani
91.06.11.2001|Yendidori
91.06.11.2002|Adoki
91.06.11.2003|Urfu
91.06.11.2004|Samber
91.06.11.2005|Kabidon
91.06.11.2006|Sunyar
91.06.11.2007|Moibaken
91.06.11.2008|Wirmaker
91.06.11.2009|Syabes
91.06.11.2010|Samber Sup
91.06.11.2011|Suneri
91.06.11.2012|Rarnpimbo
91.06.11.2013|Padwa
91.06.11.2014|Waroi
91.06.11.2015|Inpendi
91.06.11.2016|Amyambenram
91.06.11.2017|Birubi
91.06.11.2018|Binyeri
91.06.11.2019|Padwa Pantai
91.06.12.1001|Samofa
91.06.12.1002|Brambaken
91.06.12.1010|Karang Mulia
91.06.12.1011|Yafdas
91.06.12.1012|Mansinyas
91.06.12.1013|Snerbo
91.06.12.1014|Anjareuw
91.06.12.2003|Mandouw
91.06.12.2004|Sumberker
91.06.12.2006|Maryendi
91.06.12.2007|Sambawofuar
91.06.12.2008|Adainasnosen
91.06.12.2009|Darmopis
91.06.12.2015|Kamorfuar
91.06.12.2016|Anjareuw
91.06.12.2017|Wisata Binsari
91.06.12.2018|Kinmom
91.06.13.2001|Asur
91.06.13.2002|Bosnabraidi
91.06.13.2003|Wasori
91.06.13.2004|Soor
91.06.13.2005|Karmon
91.06.13.2006|Fanindi
91.06.13.2007|Madirai
91.06.13.2008|Indawi
91.06.14.2001|Rumbin
91.06.14.2002|Warbinsi
91.06.14.2003|Rodifu
91.06.14.2004|Wonabraidi
91.06.14.2005|Wouna
91.06.14.2007|Mamorbo
91.06.14.2008|Faknikdi
91.06.14.2009|Armnu
91.06.14.2010|Sup Mbrur
91.06.14.2011|Wodu
91.06.14.2012|Dasdo
91.06.15.2001|Farusi
91.06.15.2002|Mandenderi
91.06.15.2003|Swainober
91.06.15.2004|Mardori
91.06.15.2005|Swaipak
91.06.15.2006|Yenbepioper
91.06.15.2007|Sarwa
91.06.15.2008|Napdori
91.06.15.2009|Ramdori
91.06.15.2010|Busdori
91.06.15.2011|Wombrisau
91.06.15.2012|Orkdori
91.06.15.2013|Saswarbo
91.06.15.2014|Andoina
91.06.15.2015|Insusbari
91.06.16.2001|Sandau
91.06.16.2002|Bruyadori
91.06.16.2003|Dafi
91.06.16.2004|Amberparem
91.06.16.2005|Mandori
91.06.16.2006|Duai
91.06.16.2007|Mandori Sup
91.06.16.2008|Kamumi
91.06.16.2009|Arimi Jaya
91.06.16.2010|Warbukor
91.06.17.2001|Yenbeba
91.06.17.2002|Yenbepon
91.06.17.2003|Saribi
91.06.17.2004|Sub Mander
91.06.17.2005|Rawar
91.06.17.2006|Pakreki
91.06.17.2007|Masyarah
91.06.17.2008|Wansra
91.06.17.2009|Manwor Indah
91.06.18.2001|Andei
91.06.18.2002|Syoribo
91.06.18.2003|Sauribru
91.06.18.2004|Manggari
91.06.18.2005|Bawei
91.06.18.2006|Sauri
91.06.18.2007|Andei Sup
91.06.18.2008|Surdori
91.06.18.2009|Koryakam
91.06.19.2001|Mios Mangguandi
91.06.19.2002|Supraima
91.06.19.2003|Samber Pasi
91.06.19.2004|Pasi
91.06.19.2005|Mbromsi
91.06.19.2006|Karabai
91.06.19.2007|Saribra
91.06.19.2008|Nyansoren
91.06.19.2009|Sasari
91.06.19.2010|Padaido
91.06.19.2011|Yeri
91.06.19.2012|Anobo
91.06.19.2013|Yen Manaina
91.06.20.2001|Opiaref
91.06.20.2002|Bakribo
91.06.20.2003|Sawa
91.06.20.2004|Marauw
91.06.20.2005|Wadibu
91.06.20.2006|Anggopi
91.06.20.2007|Anggaduber
91.06.20.2008|Animi
91.06.20.2009|Kakur
91.06.20.2010|Tanjung Barari
91.06.20.2011|Sawadori
91.06.20.2012|Sauri
91.06.20.2013|Makmakerbo
91.06.20.2014|Yensama
91.06.21.2001|Wopes
91.06.21.2002|Wandos
91.06.21.2003|Doubo
91.06.21.2004|Syurdori
91.06.21.2005|Sansundi
91.10.01.1001|Mararena
91.10.01.1002|Sarmi Kota
91.10.01.2003|Sarmo
91.10.01.2004|Liki
91.10.01.2006|Sawar
91.10.01.2007|Bagaiserwar
91.10.01.2014|Armo
91.10.01.2018|Bagaisewar II
91.10.01.2019|Pulau Armo
91.10.01.2020|Lembah Neidam
91.10.01.2021|Tefarewar
91.10.02.2001|Bota-Bora
91.10.02.2002|Toganto
91.10.02.2003|Samanente
91.10.02.2004|Kanderjan
91.10.02.2005|Omte
91.10.02.2006|Safrom Tane
91.10.02.2007|Denender
91.10.02.2009|Safron Tane
91.10.02.2010|Denander
91.10.02.2011|Waaf
91.10.03.2005|Mertewar
91.10.03.2006|Samorkena
91.10.03.2007|Arbais
91.10.03.2008|Kapeso
91.10.03.2009|Masep
91.10.03.2012|Nisro
91.10.03.2013|Aruswar
91.10.03.2014|Kamenawari
91.10.03.2015|Waim
91.10.03.2016|Subu
91.10.03.2017|Karfasia
91.10.03.2023|Burgena
91.10.03.2024|Webro
91.10.03.2025|Siantoa
91.10.03.2026|Niwerawar
91.10.03.2027|Wari
91.10.04.2001|Ansudu
91.10.04.2002|Betaf
91.10.04.2003|Yamben
91.10.04.2010|Sunum
91.10.04.2011|Komra
91.10.04.2013|Betaf Dua
91.10.04.2014|Ansudu Dua
91.10.05.2004|Armopa
91.10.05.2005|Tarontha Srum
91.10.05.2006|Anus
91.10.05.2007|Kiren
91.10.05.2008|Maweswares
91.10.05.2010|Bebon Jaya
91.10.05.2011|Tetom
91.10.05.2015|Rimsersari
91.10.05.2017|Krim Podena
91.10.05.2018|Rotea
91.10.09.2001|Wamariri
91.10.09.2002|Aurimi
91.10.09.2003|Tamaja
91.10.09.2004|Airoran
91.10.09.2005|Murara
91.10.09.2006|Sasawapece
91.10.09.2011|Maniwa
91.10.09.2012|Surimania
91.10.09.2013|Kwawitania
91.10.09.2014|Bina
91.10.12.2001|Amsira
91.10.12.2002|Siaratesa
91.10.12.2003|Munukania
91.10.12.2004|Kasukwe
91.10.12.2005|Wapo
91.10.12.2008|Angkasa Dua
91.10.13.2001|Holmafen
91.10.13.2002|Sewan
91.10.13.2003|Waskey/Tanjung Batu
91.10.13.2004|Ebram
91.10.13.2005|Binyer
91.10.13.2006|Bagaiserwar Dua
91.10.13.2007|Waskey
91.10.13.2008|Tanjung Batu
91.10.14.2001|Arare
91.10.14.2002|Wakde
91.10.14.2003|Timron/Keder
91.10.14.2004|Dabe
91.10.14.2005|Nengke
91.10.14.2006|Finyabor
91.10.14.2012|Tambrawar
91.10.14.2013|Keder Lama
91.10.14.2014|Finyabor Dua
91.10.14.2015|Dabe Dua
91.10.14.2016|Nengke Dua
91.10.15.2001|Gwinjaya
91.10.15.2002|Tamar Sari
91.10.15.2003|Mawes Mukti
91.10.15.2004|Mawesday
91.10.15.2005|Kapitiau
91.11.01.2001|Banda
91.11.01.2002|Pund
91.11.01.2003|Kalifam
91.11.01.2004|Yuwainda
91.11.01.2005|Kalimala
91.11.01.2006|Ampas
91.11.01.2007|Bompai
91.11.01.2008|Sack
91.11.02.2001|Arso Kota
91.11.02.2002|Workwana
91.11.02.2003|Kwimi
91.11.02.2004|Ubiyau
91.11.02.2006|Sawanawa
91.11.02.2009|Yuwanain
91.11.02.2010|Yanamaa
91.11.02.2011|Asyaman
91.11.02.2012|Yamta
91.11.02.2016|Bagia
91.11.02.2030|Sawabuun
91.11.02.2031|Bibiosi
91.11.03.2001|Molof
91.11.03.2002|Senggi
91.11.03.2003|Warlef
91.11.03.2005|Usku
91.11.03.2006|Woslay
91.11.03.2010|Namla
91.11.03.2011|Waley
91.11.04.2001|Dubu
91.11.04.2002|Umuraf
91.11.04.2003|Semografi
91.11.04.2005|Embi
91.11.04.2015|Yamraf Dua
91.11.04.2017|Tatakra
91.11.05.2001|Skanto
91.11.05.2002|Jaifuri
91.11.05.2003|Arsopura
91.11.05.2004|Wiantre
91.11.05.2005|Naramben
91.11.05.2006|Intaimelyan
91.11.05.2007|Traimelyan
91.11.05.2008|Wulukubun
91.11.05.2009|Gudang Garam
91.11.05.2010|Saefen Empat Dua
91.11.05.2011|Walma
91.11.05.2012|Alang-alang Raya
91.11.06.2005|Yetti
91.11.06.2006|Kriku
91.11.06.2007|Skofro
91.11.06.2008|Kibay
91.11.06.2009|Sangke
91.11.06.2011|Suskun
91.11.06.2013|Amyu
91.11.06.2014|Kikere
91.11.06.2015|Petewi
91.11.07.2001|Towe Hitam
91.11.07.2002|Towe Atas
91.11.07.2003|Terfones
91.11.07.2004|Tefalma
91.11.07.2005|Bias
91.11.07.2006|Milki
91.11.07.2007|Lules
91.11.07.2009|Jember
91.11.07.2010|Niliti
91.11.07.2011|Pris
91.11.08.2001|Dukwia
91.11.08.2002|Sanggaria
91.11.08.2003|Yatu Raharja
91.11.08.2004|Warbo
91.11.08.2005|Yammua
91.11.08.2006|Ifia-fia
91.11.08.2007|Baburia
91.11.08.2008|Yowong
91.11.09.2001|Yamara
91.11.09.2002|Wembi
91.11.09.2003|Wonorejo
91.11.09.2004|Pyawi
91.11.09.2005|Sawyatami
91.11.09.2006|Wambes
91.11.09.2007|Uskwar
91.11.10.2001|Yabanda
91.11.10.2002|Yuruf
91.11.10.2003|Amgotro
91.11.10.2004|Jifanggry
91.11.10.2005|Monggoafi
91.11.10.2006|Fafenumbu
91.11.10.2007|Akarinda
91.11.11.2001|Kaisenar
91.11.11.2002|Kiambra
91.11.11.2003|Liket
91.11.11.2004|Onam
91.11.11.2005|Tefanma Satu
91.15.01.2003|Waren I
91.15.01.2004|Waren II
91.15.01.2011|Nonomi
91.15.01.2020|Sarafambai
91.15.01.2025|Uri
91.15.01.2027|Batu Zaman
91.15.01.2029|Sawara Jaya
91.15.03.2006|Saurisirami
91.15.03.2009|Sinonde
91.15.03.2013|Kali Baru
91.15.03.2014|Sirami
91.15.03.2015|Bunggu
91.15.03.2016|Kowogi
91.15.03.2017|Emauri
91.15.03.2018|Obutay
91.15.03.2019|Wairo
91.15.07.2002|Fafado
91.15.07.2003|Wobari
91.15.07.2013|Aimasi
91.15.07.2014|Mui
91.15.07.2015|Waghare
91.15.07.2016|Ghaiwando
91.15.07.2017|Womorisi
91.15.07.2018|Orambin
91.15.07.2019|Unareu
91.15.07.2020|Ghaiwaru
91.15.08.2001|Ureifaisei I/Sanggae
91.15.08.2002|Urfas II
91.15.08.2003|Nubuai
91.15.08.2004|Ureifaisei III/Paradoi
91.15.08.2005|Apainabo
91.15.08.2006|Mambui
91.15.08.2007|Khemoon Jaya
91.15.08.2008|Usaiwa
91.15.08.2009|Paradoi
91.15.08.2010|Ghoyui
91.15.08.2011|Rorisi
91.15.08.2012|Ronggaiwa
91.15.09.2002|Somiangga
91.15.09.2004|Toire
91.15.09.2005|Harapan Jaya
91.15.09.2006|Demisa
91.15.09.2008|Otodemo
91.15.09.2011|Awaso
91.15.09.2012|Firo
91.15.10.2001|Dairi
91.15.10.2002|Spoiri
91.15.10.2003|Sooh
91.15.10.2004|Dirou
91.15.10.2005|Diwah
91.15.10.2006|Kuaisa
91.15.10.2007|Aru Antu
91.15.10.2008|Foira
91.15.10.2009|Kawari
91.15.10.2010|Wafuka
91.15.11.2001|Botawa
91.15.11.2002|Sowiwa
91.15.11.2003|Baino Jaya
91.15.11.2004|Nau
91.15.11.2005|Rasawa
91.15.11.2006|Ruambak Jaya
91.15.11.2007|Moroa
91.15.11.2008|Oiboa
91.15.12.2001|Wapoga
91.15.12.2002|Pirare
91.15.12.2003|Awera
91.15.12.2004|Syewa Merare
91.15.12.2005|Kamarisano
91.15.12.2006|Waweri
91.15.12.2007|Dokis
91.15.13.2001|Urato
91.15.13.2002|Mayaghaido
91.15.13.2003|Aniboi
91.15.13.2007|Tetui
91.15.13.2008|Demba
91.15.13.2009|Fafai
91.15.13.2017|Wudokuri
91.15.13.2018|Aiwa
91.15.13.2019|Biati
91.15.13.2020|Ronarai
91.15.14.2001|Odase
91.15.14.2002|Wanda
91.15.14.2003|Bakadaro
91.15.14.2004|Moyufuri
91.15.14.2005|Wonti Kai
91.15.14.2006|Ghoiwi Samberi
91.15.14.2007|Gheroi
91.15.14.2008|Fimore
91.15.14.2009|Sifuisera
91.15.14.2010|Borumei
91.15.15.2001|Mambai
91.15.15.2002|Soyoi
91.15.15.2003|Daimboa
91.15.15.2004|Napani
91.15.15.2005|Segha
91.15.15.2006|Wainarisi
91.15.15.2007|Fafarui
91.15.15.2008|Dawoa
91.15.15.2009|Sinabo
91.15.15.2010|Woinui
91.19.01.2003|Fanindi
91.19.01.2004|Odori
91.19.01.2010|Biniki
91.19.01.2011|Didiabolo
91.19.01.2015|Warbefondi
91.19.01.2016|Awaki
91.19.01.2019|Maryaidori
91.19.02.2003|Warsa
91.19.02.2008|Warbor
91.19.02.2009|Kobari Jaya
91.19.02.2010|Fanjur
91.19.02.2015|Puweri
91.19.03.2001|Yawerma
91.19.03.2002|Wombonda
91.19.03.2003|Marsram
91.19.03.2004|Duber
91.19.03.2005|Sauyas
91.19.03.2006|Wafor
91.19.03.2007|Sorendidori
91.19.03.2008|Waryesi
91.19.03.2009|Syurdori
91.19.03.2010|Douwbo
91.19.04.2001|Rayori
91.19.04.2002|Mbrurwandi
91.19.04.2003|Manggonswan
91.19.04.2004|Wongkeina
91.19.04.2005|Yamnaisu
91.19.04.2006|Aruri
91.19.04.2007|Imbirsbari
91.19.04.2008|Ineki
91.19.04.2009|Insumbrei
91.19.05.2001|Waryei
91.19.05.2002|Koiryakam
91.19.05.2003|Wayori
91.19.05.2004|Amyas
91.19.05.2005|Napisndi
91.19.05.2006|Masyai
91.19.05.2007|Mapia
91.20.01.2001|Burmeso
91.20.01.2002|Anggreso
91.20.01.2003|Kasonaweja
91.20.01.2004|Metaweja
91.20.01.2005|Namunaweja
91.20.01.2006|Danau Bira
91.20.01.2007|Muru Mare
91.20.01.2008|Kwerba
91.20.01.2009|Sasakwesar
91.20.01.2010|Babija
91.20.01.2011|Marina Valen
91.20.02.2001|Dabra
91.20.02.2002|Taiyeve
91.20.02.2003|Fuao
91.20.02.2004|Papasena I
91.20.02.2005|Papasena II
91.20.02.2006|Dou
91.20.02.2008|Fokri
91.20.02.2015|Taria
91.20.03.2001|Fona
91.20.03.2002|Tayai
91.20.03.2003|Bareri
91.20.03.2004|Sikari
91.20.03.2006|Kai
91.20.03.2007|Haya
91.20.04.2001|Kustra
91.20.04.2002|Noyadi
91.20.04.2003|Obogoi
91.20.04.2004|Biri
91.20.04.2005|Wakeyadi
91.20.04.2006|Eri
91.20.04.2007|Towao
91.20.05.2001|Baudi
91.20.05.2002|Trimuris
91.20.05.2003|Bagusa
91.20.05.2004|Kapeso
91.20.05.2005|Suaseso
91.20.05.2006|Warembori
91.20.05.2007|Yoke
91.20.05.2008|Taya
91.20.06.2001|Nadofoai
91.20.06.2002|Barapasi
91.20.06.2003|Sipisi
91.20.06.2004|Bariwaro
91.20.06.2005|Bensor
91.20.06.2006|Rawiwa
91.20.06.2007|Marikai
91.20.07.2001|Kamai
91.20.07.2002|Dadat
91.20.07.2003|Kerema
91.20.07.2005|Teuw
91.20.07.2006|Watiaro
91.20.07.2007|Gesa Baru
91.20.07.2008|Baitanisa
91.20.08.2001|Poiwai
91.20.08.2002|Tamakuri
91.20.08.2003|Bonoi
91.20.08.2004|Sorabi
91.20.08.2005|Rapamerei
91.20.08.2006|Anasi
91.71.01.1001|Gurabesi
91.71.01.1002|Bayangkara
91.71.01.1003|Trikora
91.71.01.1004|Imbi
91.71.01.1005|Tanjung Ria
91.71.01.1006|Mandala
91.71.01.1007|Angkasapura
91.71.01.2008|Kayo Batu
91.71.02.1001|Argapura
91.71.02.1002|Ardipura
91.71.02.1003|Numbay
91.71.02.1005|Entrop
91.71.02.1006|Hamadi
91.71.02.2007|Tahima Sorama
91.71.02.2008|Tobati
91.71.03.1002|Asano
91.71.03.1008|Awiyo
91.71.03.1010|Yobe
91.71.03.1011|Abepantai
91.71.03.1012|Kota Baru
91.71.03.1014|Vim
91.71.03.1015|Wahno
91.71.03.1016|Way Mhorock
91.71.03.2001|Nafri
91.71.03.2004|Enggros
91.71.03.2007|Koya Koso
91.71.04.1004|Koya Barat
91.71.04.1005|Koya Timur
91.71.04.2001|Skouw Mabo
91.71.04.2002|Skouw Yambe
91.71.04.2003|Skouw Sae
91.71.04.2006|Holtekamp
91.71.04.2007|Koya Tengah
91.71.04.2008|Mosso
91.71.05.1001|Hedam
91.71.05.1002|Waena
91.71.05.1004|Yabansai
91.71.05.2003|Yoka
91.71.05.2005|Waena
92.02.03.2001|Dindey
92.02.03.2002|Indisey
92.02.03.2003|Hingk
92.02.03.2004|Warmare
92.02.03.2005|Nimbay
92.02.03.2006|Meny
92.02.03.2007|Tanah Merah
92.02.03.2008|Umcen
92.02.03.2009|Subsay
92.02.03.2010|Madrat
92.02.03.2011|Snaimboy
92.02.03.2012|Guentuy
92.02.03.2013|Ngungguen
92.02.03.2014|Sotea
92.02.03.2015|Duwin
92.02.03.2016|Ibuwau
92.02.03.2017|Iboisrati
92.02.03.2018|Sraindabey
92.02.03.2023|Indonbey
92.02.04.2001|Prafi Mulya
92.02.04.2002|Umbuy
92.02.04.2003|Desay
92.02.04.2008|Ingkwoisi
92.02.04.2010|Somi
92.02.04.2016|Mebji
92.02.05.2001|Masni
92.02.05.2002|Sumber Boga
92.02.05.2008|Wariori
92.02.05.2009|Bowi Subur
92.02.05.2014|Yensum
92.02.05.2015|Mansaburi
92.02.05.2016|Igor
92.02.05.2020|Sembab
92.02.05.2027|Yonsoribo
92.02.05.2034|Koyani
92.02.05.2037|Undi
92.02.05.2038|Jowen
92.02.12.1001|Manokwari Barat
92.02.12.1002|Sanggeng
92.02.12.1003|Wosi
92.02.12.1004|Amban
92.02.12.1005|Padarni
92.02.12.1006|Manokwari Timur
92.02.12.2007|Udopi
92.02.12.2008|Ingramui
92.02.12.2009|Soribo
92.02.12.2010|Tanah Merah Indah
92.02.13.1001|Pasir Putih
92.02.13.2002|Mansinam
92.02.13.2003|Ayambori
92.02.13.2004|Bakaro
92.02.13.2005|Arowi
92.02.13.2006|Aipiri
92.02.13.2007|Susweni
92.02.14.2001|Yoom I
92.02.14.2004|Yoom II
92.02.14.2007|Bremi
92.02.14.2008|Saubeba
92.02.14.2009|Pami
92.02.14.2011|Asai
92.02.14.2013|Meyunfoka
92.02.14.2014|Tanah Rubuh
92.02.14.2015|Sairo
92.02.14.2017|Inoduas
92.02.14.2018|Lebau
92.02.14.2020|Cabang Dua
92.02.14.2022|Indou Oufa
92.02.15.1001|Sowi
92.02.15.1002|Anday
92.02.15.2003|Katebu
92.02.15.2004|Masyepi
92.02.15.2005|Warmomi
92.02.15.2006|Dihara
92.02.15.2007|Waluri
92.02.15.2008|Maruni
92.02.15.2009|Misapmeysi
92.02.15.2010|Wasai
92.02.15.2011|Anggresi
92.02.15.2012|Mupi
92.02.15.2013|Warswami
92.02.15.2014|Acemo
92.02.15.2015|Wamesa
92.02.15.2016|Dobut
92.02.15.2017|Warkomi
92.02.15.2018|Ngunimbouw
92.02.17.2001|Warkapi
92.02.17.2002|Ayawi
92.02.17.2003|Ukopti
92.02.17.2004|Misabugoid
92.02.17.2005|Mbatma
92.02.17.2006|Urwambei
92.02.17.2007|Imbeisika I
92.02.17.2008|Imbeisika II
92.02.17.2009|Warmawai
92.02.17.2010|Rembuy
92.02.17.2011|Imhasuma
92.02.17.2012|Cuyehep
92.02.17.2013|Hanghouw
92.02.17.2014|Ningdip
92.02.17.2015|Warami
92.02.17.2016|Imboiti
92.02.17.2017|Wariari
92.02.17.2018|Indibo
92.02.17.2019|Umnum
92.02.17.2020|Ukemboisi
92.02.17.2021|Menyumfoku
92.02.17.2022|Wedoni
92.02.17.2023|Mirowi
92.02.17.2024|Warnyeti
92.02.21.2001|Kaironi
92.02.21.2002|Sidey
92.02.21.2003|Waramui
92.02.21.2004|Kassi
92.02.21.2005|Saray
92.02.21.2006|Sidey Baru
92.02.21.2007|Sidey Makmur
92.02.21.2008|Meyof I
92.02.21.2009|Wariki
92.02.21.2010|Womnowi
92.02.21.2011|Manggupi
92.02.21.2012|Sidey Jaya
92.02.31.2001|Kerenu
92.02.31.2002|Wasegi Indah
92.02.31.2003|Udapi Hilir
92.02.31.2004|Waseki Pop
92.02.31.2005|Uhyehebrig
92.02.31.2006|Kali Amin
92.02.31.2007|Bogor
92.02.31.2008|Aimasi
92.02.31.2009|Lismaungu
92.02.31.2010|Bedip Matoa
92.02.32.2001|Duweibey
92.02.32.2002|Mingre
92.02.32.2003|Figoud
92.02.32.2004|Kwau
92.02.32.2005|Mokwam
92.02.32.2006|Syou
92.02.32.2007|Amber
92.02.32.2008|Asarbey
92.02.32.2009|Minoqbei
92.02.32.2010|Bahamyenti
92.02.32.2011|Kipuwau
92.02.32.2012|Aiwow
92.02.33.2001|Sibuni
92.02.33.2002|Kali Merah
92.02.33.2003|Prafi Barat
92.02.33.2004|Macuan
92.02.33.2005|Meiforga
92.02.33.2006|Muara Prafi
92.02.33.2007|Makwan
92.02.33.2008|Urey
92.02.33.2009|Mantedi
92.02.33.2010|Aska
92.02.34.2001|Moubja
92.02.34.2002|Meyof II
92.02.34.2003|Membowi
92.02.34.2004|Ririnfos
92.02.34.2005|Wariori Indah
92.02.34.2006|Merejemeg
92.02.34.2007|Wamfoura
92.02.34.2008|Meyeruk
92.02.34.2009|Aurmios
92.02.34.2010|Muara Wariori
92.02.35.2001|Mubraidiba
92.02.35.2002|Mandopi
92.02.35.2003|Mubri
92.02.35.2004|Teluk Mubri
92.02.35.2005|Meyes
92.02.35.2006|Inya
92.02.35.2007|Warbefor
92.02.35.2008|Yonggam
92.02.35.2009|Singgimeba
92.02.35.2010|Inyei
92.03.01.1001|Fak Fak Selatan
92.03.01.1002|Fak Fak Utara
92.03.01.2007|Gewerpe
92.03.01.2011|Lusi Peri
92.03.01.2012|Wrikapal
92.03.02.2001|Werba
92.03.02.2002|Kiat
92.03.02.2003|Purwasak
92.03.02.2008|Wurkendik
92.03.02.2010|Kwuhkendak
92.03.02.2011|Purwahab Tonggo
92.03.02.2012|Pahger Nkindik
92.03.02.2013|Werba Utara
92.03.02.2014|Porum
92.03.03.2001|Tunas Gain
92.03.03.2003|Urat
92.03.03.2004|Sanggram
92.03.03.2010|Weri
92.03.03.2012|Kiria Bisa
92.03.03.2013|Saharei
92.03.04.1001|Kokas Kota
92.03.04.2003|Mandoni
92.03.04.2008|Sekar
92.03.04.2009|Ugar
92.03.04.2010|Sisir
92.03.04.2011|Kampung Baru
92.03.04.2012|Patimburak
92.03.04.2013|Batufiafas
92.03.04.2014|Kinam
92.03.04.2021|Mambunibuni
92.03.04.2024|Kriawaswas
92.03.04.2028|Sosar
92.03.04.2029|Pang Wadar
92.03.04.2030|Masina
92.03.04.2031|Kimina Kra
92.03.05.1001|Danaweria
92.03.05.2002|Kayu Merah
92.03.05.2003|Katemba
92.03.05.2004|Nemewikarya
92.03.05.2005|Raduria
92.03.05.2006|Brongkendik
92.03.05.2007|Air Besar
92.03.05.2008|Mandopma
92.03.05.2009|Kanantare
92.03.05.2010|Pasir Putih
92.03.05.2011|Pirma
92.03.05.2012|Sakartemin
92.03.05.2013|Hambrangkendik
92.03.05.2014|Unipokpok
92.03.06.2001|Malakuli
92.03.06.2002|Faur
92.03.06.2003|Kiaba
92.03.06.2004|Antalisa
92.03.06.2005|Tarak
92.03.06.2006|Tuberwasak
92.03.06.2007|Mas
92.03.07.2007|Onimsari
92.03.07.2008|Mekarsari
92.03.07.2009|Pinang Agung
92.03.07.2010|Bumi Moroh Indah
92.03.07.2012|Tesha
92.03.07.2014|Onim Jaya
92.03.07.2015|Wono Rejo
92.03.08.2001|Kramongmongga
92.03.08.2007|Wargep
92.03.08.2008|Mamur
92.03.08.2009|Nembukteb
92.03.08.2010|Pikpik
92.03.08.2011|Kwamkwamur
92.03.08.2012|Bahbadan
92.03.08.2016|Gewab
92.03.08.2017|Tentreda
92.03.08.2018|Mbaham Ma Youn
92.03.09.2001|Puar
92.03.09.2002|Degen
92.03.09.2003|Tetar
92.03.09.2005|Sum
92.03.09.2011|Adora
92.03.09.2012|Us
92.03.09.2014|Patipi Pasir
92.03.09.2015|Patipi Pulau
92.03.09.2017|Mawar
92.03.09.2018|Tibatibananam
92.03.09.2020|Offie
92.03.09.2021|Muhri
92.03.09.2022|Bisa
92.03.10.1001|Wagom
92.03.10.1002|Wagom Utara
92.03.10.1003|Dulanpokpok
92.03.10.2004|Tanama
92.03.10.2005|Kapaurtutin
92.03.10.2006|Sekban
92.03.10.2007|Torea
92.03.10.2008|Sekru
92.03.10.2009|Sukuru Tuare
92.03.11.2001|Werpigan
92.03.11.2002|Werabuan
92.03.11.2003|Wartutin
92.03.11.2004|Siboru
92.03.11.2005|Sipatnanam
92.03.11.2006|Kamandur Tetar
92.03.12.2001|Waserat
92.03.12.2002|Wambar
92.03.12.2003|Kotam
92.03.12.2004|Kwama
92.03.12.2005|Kalamanuk
92.03.12.2006|Wayati Timur
92.03.12.2007|Wayati
92.03.12.2008|Wayati Barat
92.03.12.2009|Krabelang
92.03.12.2010|Wambar Timur
92.03.13.2001|Andamata
92.03.13.2002|Taver
92.03.13.2003|Arguni
92.03.13.2004|Fior
92.03.13.2005|Furir
92.03.14.2001|Darembang
92.03.14.2002|Goras
92.03.14.2003|Mitimber
92.03.14.2004|Waremu
92.03.14.2005|Wos
92.03.14.2006|Mbahamdandra
92.03.14.2007|Goras Selatan
92.03.15.2001|Kaburbur
92.03.15.2002|Ubadari
92.03.15.2004|Homorkokma
92.03.15.2005|Pattukar
92.03.15.2006|Kayuni
92.03.15.2007|Kuagas
92.03.15.2008|Rangkendak
92.03.15.2009|Mananmur
92.03.15.2010|Warpa
92.03.16.2001|Salakiti
92.03.16.2002|Tawar
92.03.16.2003|Gar
92.03.16.2004|Rumbati
92.03.16.2005|Werfra
92.03.16.2006|Tanehamur
92.03.16.2007|Sengkiti
92.03.16.2008|Twootkindik
92.03.17.2001|Mbima Jaya
92.03.17.2002|Warisa Mulya
92.03.17.2003|Wonodadi Mulya
92.03.17.2004|Tomage
92.03.17.2005|Otoweri
92.03.17.2006|Wamosan
92.03.17.2007|Salawier
92.03.17.2008|Wasa Mulya
92.03.17.2009|Wammar
92.06.01.1001|Bintuni Timur
92.06.01.1002|Bintuni Barat
92.06.01.2004|Tuasai
92.06.01.2005|Argosigemerai
92.06.01.2009|Beimes
92.06.01.2010|Iguriji
92.06.01.2022|Masina
92.06.01.2026|Wesiri
92.06.02.2001|Merdey
92.06.02.2002|Meryeb
92.06.02.2004|Meyom
92.06.02.2007|Menggerba
92.06.02.2008|Anajero
92.06.02.2010|Mogromus
92.06.02.2011|Morombuy
92.06.02.2014|Mekiesefeb
92.06.02.2020|Meyetga
92.06.03.2020|Irarutu III
92.06.03.2021|Amutu
92.06.03.2022|Nusei
92.06.03.2023|Kasira
92.06.04.2001|Aranday
92.06.04.2007|Kampung Baru
92.06.04.2008|Kecap
92.06.04.2009|Manunggal Karya
92.06.05.2001|Jagiro
92.06.05.2004|Meyenda
92.06.05.2005|Rawara
92.06.05.2006|Barma Barat
92.06.05.2011|Inggof
92.06.06.2001|Moyeba
92.06.06.2004|Merestim
92.06.06.2005|Inofina
92.06.06.2006|Mosum
92.06.07.2001|Wamesa I/Idoor
92.06.07.2002|Wamesa II/Yakati
92.06.07.2003|Yansei
92.06.07.2004|Mamuranu
92.06.08.2001|Fruata/Irowutu II
92.06.08.2002|Meryedi
92.06.08.2003|Riendo
92.06.09.2001|Tembuni
92.06.09.2002|Mogoi Baru
92.06.09.2003|Araisum
92.06.09.2004|Bangun Mulya
92.06.10.2001|Sarbe
92.06.10.2002|Wagura
92.06.10.2003|Refideso
92.06.10.2004|Naramasa
92.06.10.2005|Obo
92.06.11.2001|Bumi Saniari
92.06.11.2002|Banjar Ausoy
92.06.11.2003|Waraitama
92.06.11.2004|Atibo Manimeri
92.06.11.2005|Pasamai
92.06.11.2006|Korano Jaya
92.06.12.2001|Tuhiba
92.06.12.2002|Tisaida
92.06.12.2003|Kucir
92.06.12.2004|Sibena Raya
92.06.12.2005|Sibena Permai
92.06.13.2001|Horna
92.06.13.2002|Cumnaji
92.06.13.2003|Menci
92.06.13.2004|Sir
92.06.13.2005|Huss
92.06.13.2006|Ugdohop
92.06.14.2001|Tofoi
92.06.14.2002|Tanah Merah
92.06.14.2003|Saengga
92.06.14.2004|Forada
92.06.14.2005|Materabu Jaya
92.06.15.2001|Sara
92.06.15.2002|Warga Nusa I
92.06.15.2003|Warga Nusa II
92.06.15.2004|Tugarama
92.06.15.2005|Suga
92.06.16.2001|Aroba
92.06.16.2002|Yaru
92.06.16.2003|Sido Makmur
92.06.16.2004|Wimbro
92.06.16.2005|Sangguar
92.06.17.2001|Masyeta
92.06.17.2002|Mestofu
92.06.17.2003|Kalibiru
92.06.17.2004|Mesomda
92.06.18.2001|Jahabra
92.06.18.2002|Ibori
92.06.18.2003|Menyembru
92.06.18.2004|Meyorga
92.06.18.2005|Laudoho
92.06.18.2006|Eniba
92.06.18.2007|Mowitka
92.06.19.2001|Sebyar Rejosasi
92.06.19.2002|Tomu
92.06.19.2003|Taroy
92.06.19.2004|Ekam
92.06.20.2001|Kalitami I
92.06.20.2002|Kalitami II
92.06.20.2003|Kenara
92.06.20.2004|Bibiram
92.06.21.2001|Weriagar
92.06.21.2002|Mogotira
92.06.21.2003|Weriagar Baru
92.06.21.2004|Weriagar Utara
92.06.21.2005|Tuanaikin
92.06.22.2001|Meyerga
92.06.22.2002|Macok
92.06.22.2003|Istiwkem
92.06.22.2004|Majnic
92.06.23.2001|Meyado
92.06.23.2002|Barma
92.06.23.2003|Barma Baru
92.06.23.2004|Vasco Damneen
92.06.24.2001|Igomu
92.06.24.2002|Mesna
92.06.24.2003|Sumuy
92.07.01.1001|Wasior I
92.07.01.2002|Rado
92.07.01.2003|Dotir
92.07.01.2004|Maniwak
92.07.01.2005|Wasior II
92.07.01.2006|Maimari
92.07.01.2007|Moru
92.07.01.2009|Manopi
92.07.01.2010|Ramiki
92.07.01.2011|Iriati
92.07.02.2001|Wamesa Tengah
92.07.02.2002|Yopmeos
92.07.02.2004|Sombokoro
92.07.02.2007|Windesi
92.07.02.2010|Sandey
92.07.03.2001|Aisandami
92.07.03.2002|Sobey
92.07.03.2006|Yopanggar
92.07.03.2011|Sobey Indah
92.07.04.2002|Wondiboy
92.07.04.2009|Kabouw
92.07.04.2010|Issui
92.07.04.2015|Kaibi
92.07.05.2001|Sabubar
92.07.05.2002|Ambuar
92.07.05.2003|Karuan
92.07.05.2007|Yarpate
92.07.05.2009|Nordiwar
92.07.06.2001|Yombekiri I
92.07.06.2002|Isenebuay
92.07.06.2003|Yomakan
92.07.06.2005|Iseren
92.07.06.2008|Yembekiri II
92.07.06.2009|Yariari
92.07.06.2011|Wetitindau
92.07.07.2001|Wosimi
92.07.07.2002|Sararti
92.07.07.2003|Yabore
92.07.07.2004|Oyaa
92.07.07.2005|Inyora
92.07.07.2006|Undurara
92.07.08.2001|Rasiei
92.07.08.2002|Torey
92.07.08.2003|Isey
92.07.08.2004|Uriemi
92.07.08.2005|Sasirei
92.07.08.2006|Tandia
92.07.08.2007|Webi
92.07.08.2008|Nggatum
92.07.08.2009|Senderawoy
92.07.09.2001|Ambumi
92.07.09.2002|Nanimori
92.07.09.2003|Dusner
92.07.09.2004|Yerenusi
92.07.09.2005|Sobiar
92.07.09.2006|Simei
92.07.10.2001|Yende
92.07.10.2002|Syabes
92.07.10.2003|Menarbu
92.07.10.2004|Niab
92.07.10.2005|Inday
92.07.10.2006|Sariay
92.07.10.2007|Mena
92.07.11.2001|Waprak
92.07.11.2002|Yomber
92.07.11.2003|Syeiwar
92.07.12.2001|Werabur
92.07.12.2002|Mamisi
92.07.12.2003|Werianggi
92.07.12.2004|Kurei
92.07.12.2005|Tamoge
92.07.13.2001|Kaprus
92.07.13.2002|Yarmatum
92.07.13.2003|Reyob
92.07.13.2004|Siresi
92.07.13.2005|Nuspairo
92.08.01.1001|Kaimana Kota
92.08.01.1014|Krooy
92.08.01.2002|Marsi
92.08.01.2003|Namatota
92.08.01.2004|Lobo
92.08.01.2005|Trikora
92.08.01.2006|Tanggaromi
92.08.01.2007|Sisir
92.08.01.2008|Foroma Jaya
92.08.01.2009|Murano
92.08.01.2010|Mai Mai
92.08.01.2011|Lumira
92.08.01.2012|Kamaka
92.08.01.2013|Coa
92.08.01.2015|Saria
92.08.01.2016|Jarati
92.08.01.2017|Sara
92.08.01.2018|Werua
92.08.01.2019|Oray
92.08.02.2001|Kambala
92.08.02.2002|Yarona
92.08.02.2003|Edor
92.08.02.2004|Tairi
92.08.02.2005|Gaka
92.08.02.2006|Guriasa
92.08.02.2007|Adi Jaya
92.08.02.2008|Nusaulan
92.08.02.2009|Esania
92.08.02.2010|Hia
92.08.03.2001|Furnusu
92.08.03.2002|Feternu
92.08.03.2003|Sawi
92.08.03.2004|Tugarni
92.08.03.2010|Sawatawera
92.08.03.2012|Bofuwer
92.08.03.2013|Warwarsi
92.08.03.2014|Wanggita
92.08.03.2016|Fudima
92.08.03.2017|Weswasa
92.08.03.2018|Borogerba
92.08.03.2019|Afu Afu
92.08.03.2020|Bayeda
92.08.03.2021|Moyana
92.08.03.2022|Kokoroba
92.08.03.2023|Wainaga
92.08.03.2024|Maskur
92.08.03.2025|Kensi
92.08.03.2027|Erigara
92.08.03.2028|Pigo
92.08.03.2029|Tugumawa
92.08.03.2030|Tiwara
92.08.03.2031|Gusi
92.08.03.2032|Warua
92.08.04.2001|Rurumo
92.08.04.2002|Boiya
92.08.04.2003|Nariki
92.08.04.2004|Bamana
92.08.04.2005|Siawatan
92.08.05.2001|Rauna
92.08.05.2002|Werafuta
92.08.05.2003|Ubia Sermuku
92.08.05.2004|Bahumia
92.08.05.2005|Waho
92.08.05.2006|Wamesa
92.08.05.2007|Kooy
92.08.06.2001|Jawera
92.08.06.2002|Ruara
92.08.06.2003|Wermenu
92.08.06.2004|Egerwara
92.08.06.2005|Kufuriyai
92.08.06.2006|Manggera
92.08.06.2007|Tanusan
92.08.06.2008|Urisa
92.08.06.2009|Waromi
92.08.06.2010|Ukiara
92.08.06.2012|Nagura
92.08.06.2013|Inari
92.08.06.2014|Wanoma
92.08.06.2015|Sumun
92.08.06.2016|Seraran
92.08.07.2001|Ure
92.08.07.2002|Wosokuno
92.08.07.2003|Urubika
92.08.07.2004|Wagoha
92.08.07.2005|Hairapara
92.08.07.2006|Omba Pamuku
92.11.01.2001|Ransiki
92.11.01.2002|Nuhuwei
92.11.01.2003|Yamboi
92.11.01.2004|Tobou
92.11.01.2005|Sabri
92.11.01.2006|Bamaha
92.11.01.2007|Abreso
92.11.01.2008|Hamawi
92.11.01.2009|Kobrey
92.11.01.2010|Wamcei
92.11.01.2011|Hamor
92.11.01.2012|Susmorof
92.11.01.2013|Mambrema
92.11.02.2001|Oransbari
92.11.02.2002|Sidomulyo
92.11.02.2003|Waroser
92.11.02.2004|Margo Rukun
92.11.02.2005|Muari
92.11.02.2006|Watariri
92.11.02.2007|Masabui
92.11.02.2008|Warbiadi
92.11.02.2009|Margomulyo
92.11.02.2010|Warkwandi
92.11.02.2011|Sindang Jaya
92.11.02.2012|Wandoki
92.11.02.2013|Akeju
92.11.02.2014|Masabui II
92.11.03.2001|Wama
92.11.03.2002|Disi
92.11.03.2003|Hiyou
92.11.03.2004|Sesum
92.11.03.2005|Benyas
92.11.03.2006|Aryawenmoho
92.11.03.2007|Neney
92.11.04.2001|Isim
92.11.04.2002|Duhugesa
92.11.04.2003|Tubes
92.11.04.2004|Umohousi
92.11.04.2005|Tohosta
92.11.04.2006|Hugomot
92.11.04.2007|Dihisu
92.11.04.2008|Inyuara
92.11.04.2009|Desra
92.11.04.2010|Mindermes
92.11.04.2011|Sibjo
92.11.04.2012|Dibera
92.11.05.2001|Dembek
92.11.05.2002|Nij
92.11.05.2003|Siwi
92.11.05.2004|Gaya Baru
92.11.05.2005|Waren
92.11.05.2006|Demini
92.11.05.2007|Yekwandi
92.11.06.2001|Yarmatum
92.11.06.2002|Reyob
92.11.06.2003|Kaprus
92.11.06.2004|Seimeba
92.12.01.2001|Iraiweri
92.12.01.2002|Igembai
92.12.01.2003|Imbai
92.12.01.2004|Suteibey
92.12.01.2005|Susi
92.12.01.2006|Ullong
92.12.01.2007|Mentubey
92.12.01.2008|Ayaubey
92.12.01.2009|Testega Pamaha
92.12.01.2010|Pamaha
92.12.01.2011|Uper
92.12.01.2012|Hungku
92.12.01.2013|Srubey
92.12.02.2001|Sibiogud
92.12.02.2002|Krobut
92.12.02.2003|Tubyam
92.12.02.2004|Sakumi
92.12.02.2005|Tombrok
92.12.02.2006|Sisrang
92.12.02.2007|Ngisrow
92.12.02.2008|Itkau
92.12.03.2001|Inyebuow
92.12.03.2002|Imbeisba
92.12.03.2003|Usti
92.12.03.2004|Memti
92.12.03.2005|Koney
92.12.03.2006|Membey
92.12.04.2001|Sururey
92.12.04.2002|Tuhubea
92.12.04.2003|Sungedes
92.12.04.2004|Inyaub
92.12.04.2005|Saugemeba
92.12.04.2006|Kobrey
92.12.04.2007|Kopo
92.12.04.2008|Dugahani
92.12.04.2009|Tomstera
92.12.04.2010|Kostera
92.12.04.2011|Anuk
92.12.04.2012|Menesrij
92.12.05.2001|Iranmeba
92.12.05.2002|Cirnohu
92.12.05.2003|Dibetik
92.12.05.2004|Danmou
92.12.05.2005|Miseda
92.12.05.2006|Sirgemeh
92.12.05.2007|Sneremer
92.12.05.2008|Kusmenau
92.12.05.2009|Cigera
92.12.05.2010|Tomstir
92.12.05.2011|Gedeira
92.12.05.2012|Demdamei
92.12.05.2013|Dugrimog
92.12.05.2014|Disra
92.12.06.2001|Genyu
92.12.06.2002|Ansum
92.12.06.2003|Deurohu
92.12.06.2004|Horeta
92.12.06.2005|Ubeisa
92.12.06.2006|Taige
92.12.06.2007|Tridaga
92.12.06.2008|Disura
92.12.06.2009|Awigau
92.12.06.2010|Siskedowo
92.12.06.2011|Irbos
92.12.07.2001|Catubouw
92.12.07.2002|Bigwaimud
92.12.07.2003|Mihou
92.12.07.2004|Kaungwam
92.12.07.2005|Aiga
92.12.07.2006|Imandrigo
92.12.07.2007|Unti
92.12.07.2008|Ndabouw
92.12.07.2009|Sugemeh
92.12.07.2010|Manggesuk
92.12.07.2011|Ijigreg
92.12.07.2012|Jim
92.12.07.2013|Slomiou
92.12.07.2014|Binggrayud
92.12.07.2015|Minmo
92.12.07.2016|Mihij
92.12.07.2017|Soudin
92.12.07.2018|Timtouw
92.12.07.2019|Idemai
92.12.07.2020|Mieycomti
92.12.07.2021|Coijut
92.12.08.2001|Testega
92.12.08.2002|Meidogda
92.12.08.2003|Meifekeni
92.12.08.2004|Demuora
92.12.08.2005|Jigja
92.12.08.2006|Meigehenawu
92.12.08.2007|Morumfeyi
92.12.08.2008|Iba
92.12.08.2009|Meimersa
92.12.08.2010|Meifowoska
92.12.08.2011|Meijugjijigja
92.12.08.2012|Meifokeda
92.12.08.2013|Dumbrey
92.12.08.2014|Meksi
92.12.08.2015|Asai Dua
92.12.09.2001|Minyambouw
92.12.09.2002|Demaisi
92.12.09.2003|Awaibehel
92.12.09.2004|Indabri
92.12.09.2005|Coisi
92.12.09.2006|Imbenti
92.12.09.2007|Sigim
92.12.09.2008|Imbonggun
92.12.09.2009|Aduer
92.12.09.2010|Ugjeheg
92.12.09.2011|Micadiwor
92.12.09.2012|Ungga
92.12.09.2013|Mitiede
92.12.09.2014|Simerbei
92.12.09.2015|Driye
92.12.09.2016|Wamminda
92.12.09.2017|Umpug
92.12.09.2018|Handuk
92.12.09.2019|Ninsimoi
92.12.09.2020|Anggra
92.12.09.2021|Inggramhim
92.12.09.2022|Mbingma
92.12.09.2023|Injuar
92.12.09.2024|Apul
92.12.09.2025|Memangker
92.12.09.2026|Mainda
92.12.09.2027|Imbrekti
92.12.09.2028|Ipingosi
92.12.09.2029|Pinyausi
92.12.09.2030|Sinaltousi
92.12.09.2031|Misangoisi
92.12.09.2032|Smanggei
92.12.09.2033|Nimbiau
92.12.09.2034|Bingwoyut
92.12.09.2035|Ayau
92.12.09.2036|Andang
92.12.09.2039|Miconti
92.12.10.2001|Sopnyai
92.12.10.2002|Ikimabou
92.12.10.2003|Manggot
92.12.10.2004|Kisap
92.12.10.2005|Nungkimor
92.12.10.2006|Cangoisi
92.12.10.2007|Minyeimemud
92.12.10.2008|Penibut
92.12.10.2009|Demunti
92.12.10.2010|Gueipimbai
92.12.10.2011|Tigaucomti
92.12.10.2012|Urwong
92.12.10.2013|Aryon
92.12.10.2014|Punggung
92.12.10.2015|Humeisi
92.12.10.2016|Haktiebou
92.12.10.2017|Kwok Satu
92.12.10.2018|Kwok Dua
92.12.10.2019|Kwaiyehep
92.12.10.2020|Mbegau
92.12.10.2021|Ngimoubri
92.12.10.2022|Liehak
92.12.10.2023|Umcep
92.12.10.2024|Tumbeibehei
92.12.10.2025|Tingwoikiou
92.12.10.2026|Guwei Uti
92.12.10.2027|Ntap
92.12.10.2028|Monut
92.12.10.2029|Mbrande
93.01.01.1002|Samkai
93.01.01.1003|Karang Indah
93.01.01.1004|Mandala
93.01.01.1005|Maro
93.01.01.1006|Kelapa Lima
93.01.01.1007|Rimba Jaya
93.01.01.1009|Bambu Pemali
93.01.01.1010|Seringgu Jaya
93.01.01.1011|Kamundu
93.01.01.1012|Kamahedoga
93.01.01.1013|Muli
93.01.01.2001|Nasem
93.01.01.2008|Wasur
93.01.01.2014|Bokem
93.01.01.2015|Buti
93.01.01.2016|Nggolar
93.01.02.2001|Muting
93.01.02.2002|Boha
93.01.02.2003|Wan
93.01.02.2004|Kolam
93.01.02.2005|Selauw
93.01.02.2006|Pachas
93.01.02.2007|Seed Agung
93.01.02.2008|Enggol Jaya
93.01.02.2009|Manway Bop
93.01.02.2010|Afkab Makmur
93.01.02.2011|Sigabel Jaya
93.01.02.2012|Andaito
93.01.03.2001|Okaba
93.01.03.2002|Wambi
93.01.03.2003|Makaling
93.01.03.2004|Alatep
93.01.03.2005|Iwol
93.01.03.2006|Duf Miraf
93.01.03.2007|Alaku
93.01.03.2008|Sanggase
93.01.03.2009|Es Wambi
93.01.04.2001|Kimaam
93.01.04.2002|Komolom
93.01.04.2003|Kumbis
93.01.04.2004|Kalilam
93.01.04.2005|Teri
93.01.04.2006|Mambum
93.01.04.2007|Kiworo
93.01.04.2008|Woner
93.01.04.2009|Deka
93.01.04.2010|Turiram
93.01.04.2011|Purawanderu
93.01.04.2012|Umanderu
93.01.04.2013|Webu
93.01.05.2001|Matara
93.01.05.2002|Waninggap Nanggo
93.01.05.2003|Urumb
93.01.05.2004|Sido Mulyo
93.01.05.2005|Kuprik
93.01.05.2006|Kuper
93.01.05.2007|Semangga Jaya
93.01.05.2008|Marga Mulya
93.01.05.2009|Muram Sari
93.01.05.2010|Waninggap Kai
93.01.06.2001|Yasa Mulya
93.01.06.2002|Sumber Harapan
93.01.06.2003|Waninggap Say
93.01.06.2004|Amun Kay
93.01.06.2005|Hidup Baru
93.01.06.2006|Sarmayam Indah
93.01.06.2007|Ngguti Bob
93.01.06.2008|Waninggap Miraf
93.01.06.2009|Isano Mbias
93.01.06.2010|Yaba Maru
93.01.06.2011|Soa
93.01.06.2012|Tambat
93.01.06.2013|Bersehati
93.01.06.2014|Kamangi
93.01.07.2001|Kartini
93.01.07.2002|Makarti Jaya
93.01.07.2003|Nalkin
93.01.07.2004|Angger Permegi
93.01.07.2005|Poo
93.01.07.2006|Mimi Baru
93.01.07.2007|Kamno Sari
93.01.07.2008|Blandin Kakayo
93.01.07.2009|Gurinda Jaya
93.01.07.2010|Jagebob Raya
93.01.07.2011|Wenda Asri
93.01.07.2012|Melin Megikar
93.01.07.2013|Obaat Throw
93.01.07.2014|Yemunain Jaya
93.01.08.2001|Sota
93.01.08.2002|Yanggandur
93.01.08.2003|Rawa Biru
93.01.08.2004|Toray
93.01.08.2005|Erambu
93.01.09.2001|Selil
93.01.09.2002|Kindiki
93.01.09.2003|Kumaaf
93.01.09.2004|Nggayu
93.01.09.2005|Kafyamke
93.01.09.2006|Mandekman
93.01.09.2007|Rawahayu
93.01.09.2008|Belbeland
93.01.09.2009|Kir-ely
93.01.09.2010|Kandrakay
93.01.09.2011|Baidub
93.01.10.2001|Bupul
93.01.10.2002|Tanas
93.01.10.2003|Kweel
93.01.10.2004|Sipias
93.01.10.2005|Metaat Makmur
93.01.10.2006|Enggal Jaya
93.01.10.2007|Gerisar
93.01.10.2008|Bupul Indah
93.01.10.2009|Tof-Tof
93.01.10.2010|Bunggay
93.01.10.2011|Bouwer
93.01.10.2012|Bumun
93.01.11.2001|Harapan Makmur
93.01.11.2002|Kurik
93.01.11.2003|Telaga Sari
93.01.11.2004|Sumber Rejeki
93.01.11.2005|Jaya Makmur
93.01.11.2006|Sumber Mulya
93.01.11.2007|Kaliki
93.01.11.2008|Ivimahad
93.01.11.2009|Salor Indah
93.01.11.2010|Candra Jaya
93.01.11.2011|Wonorejo
93.01.11.2012|Anum Bob
93.01.11.2013|Wapeko
93.01.12.2001|Kuler
93.01.12.2002|Onggaya
93.01.12.2003|Tomer
93.01.12.2004|Tomerau
93.01.12.2005|Kondo
93.01.13.2001|Koa
93.01.13.2002|Baad
93.01.13.2003|Senegi
93.01.13.2004|Wayau
93.01.13.2005|Kaisah
93.01.14.2001|Kumbe
93.01.14.2002|Onggari
93.01.14.2003|Rawa Sari
93.01.14.2004|Padang Raharja
93.01.14.2005|Kaiburse
93.01.14.2006|Domande
93.01.14.2007|Suka Maju
93.01.15.2001|Yowied
93.01.15.2002|Dokib
93.01.15.2003|Wamal
93.01.15.2004|Dodalim
93.01.15.2005|Woboyo
93.01.15.2006|Welbuti
93.01.16.2001|Po-Epe
93.01.16.2002|Yawimu
93.01.16.2003|Taga Epe
93.01.16.2004|Nakias
93.01.16.2005|Salam Epe
93.01.16.2006|Yomop
93.01.17.2001|Kwemsid
93.01.17.2002|Kaptel
93.01.17.2003|Kaniskobat
93.01.17.2004|Ihalik
93.01.17.2005|Bu Epe
93.01.18.2001|Tabonji
93.01.18.2002|Wanggambi
93.01.18.2003|Suam
93.01.18.2004|Yamuka
93.01.18.2005|Iromoro
93.01.18.2006|Konjombando
93.01.18.2007|Yeraha
93.01.19.2001|Konorau
93.01.19.2002|Waan
93.01.19.2003|Toor
93.01.19.2004|Kladar
93.01.19.2005|Sabon
93.01.19.2006|Dafnawanga
93.01.20.2001|Wanam
93.01.20.2002|Bibikem
93.01.20.2003|Wogekel
93.01.20.2004|Uli Uli
93.01.21.2001|Sabudon
93.01.21.2002|Padua
93.01.21.2003|Sigad
93.01.21.2004|Bamol I
93.01.21.2005|Bamol II
93.01.22.2001|Kawe
93.01.22.2002|Wetau
93.01.22.2003|Pembri
93.01.22.2004|Sibenda
93.01.22.2005|Wantarma
93.02.01.2001|Ampera
93.02.01.2002|Sokanggo
93.02.01.2003|Persatuan
93.02.01.2004|Mariam
93.02.01.2005|Mawan
93.02.02.2001|Mindiptana
93.02.02.2002|Umap
93.02.02.2003|Awayanka
93.02.02.2004|Wanggatkibi
93.02.02.2005|Epsembit
93.02.02.2006|Andobit
93.02.02.2007|Niyimbang
93.02.02.2008|Anggumbit
93.02.02.2009|Imko
93.02.02.2010|Kamka
93.02.02.2011|Osso
93.02.02.2012|Tinggam
93.02.02.2013|Kakuna
93.02.03.2001|Woropko
93.02.03.2002|Winiktit
93.02.03.2003|Kanggewot
93.02.03.2005|Inggembit
93.02.03.2006|Wametkapa
93.02.03.2007|Wombon
93.02.03.2008|Upkim
93.02.03.2009|Ikcan
93.02.03.2010|Upyetetko
93.02.04.2001|Kouh
93.02.04.2002|Jair
93.02.04.2003|Mandobo
93.02.05.2001|Getentiri
93.02.05.2002|Anggai
93.02.05.2003|Butiptiri
93.02.05.2004|Asiki
93.02.05.2005|Kapogu
93.02.05.2006|Miri
93.02.06.2001|Bomakia I
93.02.06.2002|Bomakia II
93.02.06.2003|Somi
93.02.06.2004|Aifa
93.02.06.2005|Uni
93.02.07.2001|Kombut
93.02.07.2002|Moukbiran
93.02.07.2003|Kawangtet
93.02.07.2004|Amuan
93.02.08.2001|Langgoan
93.02.08.2002|Tetop
93.02.08.2003|Wariktop
93.02.08.2004|Autriop
93.02.08.2005|Ogenetan
93.02.09.2001|Maju
93.02.09.2002|Bukit
93.02.09.2003|Ujung
93.02.09.2004|Ginggimop
93.02.09.2005|Patriot
93.02.09.2006|Arimbet
93.02.09.2007|Aroa
93.02.10.2001|Sadar
93.02.10.2002|Bangun
93.02.10.2003|Makmur
93.02.10.2004|Sohokanggo
93.02.10.2005|Domo
93.02.10.2006|Hamkhu
93.02.10.2007|Hello
93.02.10.2008|Navini
93.02.11.2001|Kuken
93.02.11.2002|Kolopkam
93.02.11.2003|Awaken
93.02.11.2004|Arimbit
93.02.11.2005|Anyumka
93.02.12.2001|Manggelum
93.02.12.2002|Burunggop
93.02.12.2003|Bayanggop
93.02.12.2004|Gaguop
93.02.12.2005|Kewam
93.02.12.2006|Mangga Tiga
93.02.13.2001|Firiwage
93.02.13.2002|Karuwage
93.02.13.2003|Waliburu
93.02.13.2004|Kabuwage
93.02.14.2001|Yaniruma
93.02.14.2002|Manggemahe
93.02.14.2003|Fefero
93.02.15.2001|Subur
93.02.15.2002|Kaisa
93.02.15.2003|Wagai
93.02.15.2004|Aiwat
93.02.16.2001|Wanggemalo
93.02.16.2002|Sinimburu
93.02.16.2003|Yafufla
93.02.16.2004|Ugo
93.02.16.2005|Dema
93.02.17.2001|Ninati
93.02.17.2003|Kawaktembut
93.02.17.2004|Tembutka
93.02.17.2005|Timka
93.02.17.2006|Yetetko
93.02.18.2001|Sesnuk
93.02.18.2002|Anggamburan
93.02.18.2003|Kanggup
93.02.18.2004|Yomkondo
93.02.18.2005|Amboran
93.02.19.2001|Meto
93.02.19.2002|Obinangge
93.02.19.2003|Watemu
93.02.19.2004|Ujung Kia
93.02.20.2001|Wanggom
93.02.20.2002|Kawagit
93.02.20.2003|Kombay
93.02.20.2004|Biwage 1
93.02.20.2005|Biwage 2
93.02.20.2006|Niop
93.03.01.1013|Kepi
93.03.01.2001|Obaa
93.03.01.2002|Dagimon
93.03.01.2003|Rep
93.03.01.2004|Mappi Bawah/Yamui
93.03.01.2005|Wanggate
93.03.01.2006|Piai
93.03.01.2007|Muin
93.03.01.2008|Gauda
93.03.01.2009|Soba
93.03.01.2010|Enem
93.03.01.2011|Kogo
93.03.01.2012|Kadam/Oyim
93.03.01.2014|Tokhom
93.03.01.2015|Emete
93.03.01.2016|Wairu
93.03.01.2017|Rayam
93.03.01.2018|Harome
93.03.01.2019|Metim
93.03.01.2020|Masin
93.03.01.2021|Madu
93.03.01.2022|Yangpop
93.03.01.2023|Paedam
93.03.01.2024|Marbin
93.03.02.2001|Mur
93.03.02.2002|Agham
93.03.02.2003|Waghien/Koba
93.03.02.2004|Khatan
93.03.02.2005|Monana
93.03.02.2006|Wagin
93.03.02.2007|Waman
93.03.02.2008|Ima
93.03.02.2009|Kogoyaman
93.03.02.2010|Magabag
93.03.02.2011|Tereyemu
93.03.02.2012|Yatan
93.03.02.2013|Linggua
93.03.02.2014|Waruwe
93.03.02.2015|Ghanu
93.03.03.2001|Bidnew
93.03.03.2002|Senggo
93.03.03.2003|Kumasma
93.03.03.2004|Womin
93.03.03.2005|Tamanin
93.03.03.2006|Epem
93.03.03.2007|Abau
93.03.04.1001|Bade
93.03.04.2002|Geturki
93.03.04.2003|Mememu
93.03.04.2004|Gimikya
93.03.04.2005|Banamepe
93.03.04.2006|Yodom
93.03.04.2007|Isyaman
93.03.05.2001|Yagatsu
93.03.05.2002|Amagatsu
93.03.05.2003|Katage
93.03.05.2004|Sogope
93.03.05.2005|Wiyage
93.03.05.2006|Kasima
93.03.05.2007|Amenda
93.03.05.2008|Kaibu
93.03.05.2009|Omuro
93.03.05.2010|Okor
93.03.05.2011|Atsipim
93.03.05.2012|Semtaipim
93.03.05.2013|Geiripim
93.03.05.2014|Warogom
93.03.05.2015|Kaibusene
93.03.05.2016|Arare
93.03.05.2017|Paghai
93.03.05.2018|Kerke
93.03.05.2019|Mani
93.03.06.2001|Sigare
93.03.06.2002|Jufo Besar
93.03.06.2003|Eci
93.03.06.2004|Aboge
93.03.06.2005|Khanami
93.03.06.2006|Yame
93.03.06.2007|Kaitok
93.03.06.2008|Homang
93.03.06.2009|Jufo Kecil
93.03.06.2010|Khabu
93.03.06.2011|Kiki
93.03.06.2012|Isage
93.03.06.2013|Kopi
93.03.06.2014|Asaren
93.03.06.2015|Keru
93.03.06.2016|Girimio
93.03.06.2017|Haffo
93.03.06.2018|Meda
93.03.07.2001|Amazu
93.03.07.2002|Imembi
93.03.07.2003|Yemu
93.03.07.2004|Fomu
93.03.07.2005|Tiau
93.03.07.2006|Binerbis
93.03.07.2007|Tayau
93.03.08.2001|Sepoh
93.03.08.2002|Bagaram
93.03.08.2003|Passue/Taim
93.03.08.2004|Nohon
93.03.08.2005|Kotiak
93.03.08.2006|Menya
93.03.08.2007|Tokhompatu
93.03.08.2008|Kotup
93.03.08.2009|Rimba Jaya/Gayu
93.03.08.2010|Kaime
93.03.08.2011|Baitate
93.03.08.2012|Urufu
93.03.08.2013|Afogoma
93.03.09.2001|Kabe
93.03.09.2002|Kaumi
93.03.09.2003|Kayagai
93.03.09.2004|Ati
93.03.09.2005|Upin
93.03.09.2006|Taragai
93.03.09.2007|Sene
93.03.09.2008|Komru
93.03.09.2009|Kofar
93.03.09.2010|Sumuraman
93.03.09.2011|Pano
93.03.09.2012|Kogir
93.03.10.2001|Sien
93.03.10.2002|Sahapikya
93.03.10.2003|Harapan
93.03.10.2004|Yibin
93.03.10.2005|Mopio
93.03.10.2006|Pies
93.03.10.2007|Memes
93.03.10.2008|Getiyo
93.03.11.2001|Homlikia
93.03.11.2002|Kobeta
93.03.11.2003|Asset
93.03.11.2004|Osso
93.03.11.2005|Bosma
93.03.11.2006|Oghoto
93.03.12.2001|Amk
93.03.12.2002|Yame
93.03.12.2003|Benggo
93.03.12.2004|Kokoya
93.03.12.2005|Borohaba
93.03.12.2006|Ogorito
93.03.12.2007|Hebeske
93.03.13.2001|Yeloba
93.03.13.2002|Konebi
93.03.13.2003|Sibi
93.03.13.2004|Tagaimon Sino
93.03.13.2005|Tagaimon Karome
93.03.14.2001|Wonggi
93.03.14.2002|Busiri
93.03.14.2003|Keta
93.03.14.2004|Veta
93.03.14.2005|Honya
93.03.14.2006|Haku
93.03.14.2007|Bifo
93.03.14.2008|Samurukie
93.03.15.2001|Sagis
93.03.15.2002|Kumaban
93.03.15.2003|Tugumau
93.03.15.2004|Basman
93.03.15.2005|Merokima
93.03.15.2006|Mu
93.03.15.2007|Pier
93.03.15.2008|Tarwa
93.04.01.2001|Yomoth
93.04.01.2002|Uwus
93.04.01.2003|Asuwetsy
93.04.01.2004|Bismam
93.04.01.2005|Bis Agats
93.04.01.2006|Per
93.04.01.2007|Beriten
93.04.01.2008|Mbait
93.04.01.2009|Bou
93.04.01.2010|Saw
93.04.01.2011|Kaye
93.04.01.2012|Suwru
93.04.02.2001|Atsj
93.04.02.2002|Sogoni
93.04.02.2003|Amanamkai
93.04.02.2004|Ambisu
93.04.02.2005|Bine
93.04.02.2006|Bipim
93.04.02.2007|Yasiuw
93.04.02.2008|Bakasai
93.04.02.2009|Cewewyamew
93.04.03.2001|Sawa
93.04.03.2002|Erma
93.04.03.2003|Bu
93.04.03.2004|Er
93.04.03.2005|Pupis
93.04.03.2006|Sona
93.04.03.2007|Agani
93.04.03.2008|Mumugu
93.04.03.2009|Sauti
93.04.03.2010|Mumugi II
93.04.04.2001|Ayam
93.04.04.2006|Waw
93.04.04.2007|Bayiw Pinam
93.04.04.2008|Cumnew
93.04.04.2009|Jewes
93.04.05.2001|Basim
93.04.05.2002|Waras
93.04.05.2003|Biopis
93.04.05.2004|Nanai
93.04.05.2005|Pirien
93.04.05.2006|Ocenep
93.04.05.2007|Ais
93.04.05.2008|Yawas
93.04.05.2009|Bakyor
93.04.05.2010|Isar
93.04.05.2011|Kayarpis
93.04.05.2012|Sayoa
93.04.05.2013|Bora
93.04.06.2001|Kamur
93.04.06.2002|Sanep
93.04.06.2003|Saramit
93.04.06.2004|Yahoi
93.04.06.2005|Hainam
93.04.06.2006|Yagamit
93.04.06.2007|Bawor
93.04.06.2008|Sanapai
93.04.06.2009|Sarmafo
93.04.07.2001|Binam
93.04.07.2002|Wagabus
93.04.07.2003|Burbis
93.04.07.2004|Bubis
93.04.07.2005|Karbis
93.04.07.2006|Jinak
93.04.07.2007|Wowi
93.04.07.2008|Soray
93.04.07.2009|Waganu Dua
93.04.07.2014|Emnam
93.04.08.2001|Suru-Suru
93.04.08.2002|See
93.04.08.2009|Dumaten
93.04.08.2010|Hom-hom
93.04.08.2011|Ajin
93.04.08.2012|Laluk
93.04.08.2013|Kebikduk
93.04.08.2014|Hulam
93.04.08.2015|Walase
93.04.08.2016|Berimono
93.04.08.2017|Asgun
93.04.08.2018|Korobuk
93.04.08.2019|Katalina
93.04.08.2020|Obio
93.04.08.2021|Salbik
93.04.08.2022|Linduk
93.04.08.2023|Besika
93.04.09.2001|Binamsain
93.04.09.2002|Pirabanak
93.04.09.2003|Woutu Braza
93.04.09.2004|Patipi
93.04.09.2005|Ulakin
93.04.09.2006|Woutu Kolof
93.04.09.2007|Butukatnau
93.04.09.2008|Auban
93.04.09.2009|Pepera
93.04.09.2010|Waijens
93.04.09.2011|Bumu
93.04.09.2012|Kapayap Satu
93.04.09.2013|Kapayap Dua
93.04.09.2014|Sipanap
93.04.10.2001|Komor
93.04.10.2002|Amor
93.04.10.2003|Yipawer
93.04.10.2004|Berip
93.04.10.2005|Ayir
93.04.10.2006|Werer
93.04.10.2009|Paar
93.04.11.2001|Yamas
93.04.11.2002|Yeni
93.04.11.2003|Omor
93.04.11.2004|Jufri
93.04.11.2005|Yaun
93.04.11.2006|Onavai
93.04.12.2001|Kapi
93.04.12.2002|As
93.04.12.2003|Atat
93.04.12.2004|Aou
93.04.12.2005|Nakai
93.04.12.2006|Esmapan
93.04.12.2007|Eroko
93.04.12.2008|Yakapis
93.04.12.2009|Weo
93.04.12.2010|Aoap
93.04.12.2011|Fumereipits
93.04.13.2001|Warse/Jetsy
93.04.13.2002|Powetsy/Amborep
93.04.13.2003|Pau
93.04.13.2004|Sesakam
93.04.13.2005|Akamar
93.04.13.2006|Birak
93.04.13.2007|Katew
93.04.13.2008|Dawer
93.04.14.2001|Yamkap
93.04.14.2002|Amkum
93.04.14.2003|Amaru
93.04.14.2004|Amkai
93.04.14.2005|Amagais
93.04.14.2006|Erosaman
93.04.15.2001|Kawem
93.04.15.2002|Hahare
93.04.15.2003|Aikut
93.04.15.2004|Sanem
93.04.15.2005|Kaipom
93.04.15.2006|Airo Sapem
93.04.15.2007|Simipit
93.04.15.2008|Heiyaram
93.04.15.2009|Wagasu
93.04.15.2010|Sasime
93.04.16.2001|Primapun
93.04.16.2002|Aworket
93.04.16.2003|Saman
93.04.16.2004|Bayun
93.04.16.2005|Semendoro
93.04.16.2006|Tareo
93.04.16.2007|Kayirim
93.04.16.2008|Santambor
93.04.16.2009|Yaptambor
93.04.16.2010|Simsagar
93.04.16.2011|Itersok
93.04.16.2012|Emene
93.04.17.2001|Yausakor
93.04.17.2002|Damen
93.04.17.2003|Biwar Darat
93.04.17.2004|Kaimo
93.04.17.2005|Awok
93.04.17.2006|Fos
93.04.17.2007|Waganu
93.04.17.2008|Sakor
93.04.18.2001|Comoro
93.04.18.2002|Kawet
93.04.18.2003|Mausi
93.04.18.2004|Sato Yod
93.04.18.2005|Tamor
93.04.18.2006|Ero Airo
93.04.19.2001|Biwar Laut
93.04.19.2002|Atambuts
93.04.19.2003|Omanesep
93.04.19.2004|Warkai
93.04.19.2005|You
93.04.19.2006|Pirpis
93.04.19.2007|Desep
93.04.20.2001|Bor
93.04.20.2002|Daikot
93.04.20.2003|Somnak
93.04.20.2004|Wabak
93.04.20.2005|Vakam
93.04.20.2006|Vakam Dua
93.04.20.2007|Dekamer
93.04.21.2001|Piramat
93.04.21.2002|Bawos
93.04.21.2003|Akan Tapak
93.04.21.2004|Tauro
93.04.21.2005|Bagair
93.04.21.2006|Wiyar
93.04.21.2007|Kagas
93.04.21.2008|Mapane
93.04.21.2009|Ainamsato
93.04.21.2010|Amaita
93.04.22.2001|Yerfum
93.04.22.2002|Suagai
93.04.22.2003|Sohomane
93.04.22.2004|Sagare
93.04.22.2005|Yefuwagi
93.04.22.2006|Wagi
93.04.23.2001|Mabul
93.04.23.2002|Banum
93.04.23.2003|Ayak
93.04.23.2004|Amakot
93.04.23.2005|Nagatun
93.04.23.2006|Ujung Batu
93.04.23.2007|Kapayap Tiga
93.04.24.2001|Tomor
93.04.24.2002|Munu
93.04.24.2003|Abamu
93.04.24.2004|Tie
93.04.24.2005|Koba
93.04.24.2006|Sagapu
93.04.24.2007|Jifak
93.04.24.2008|Yensuku
93.04.25.2001|Beco
93.04.25.2002|Yuni
93.04.25.2003|Buetkawar
93.04.25.2004|Manep
93.04.25.2005|Simini
93.04.25.2006|Fakan/Ani
94.01.01.1001|Wonorejo
94.01.01.1002|Kali Bobo
94.01.01.1003|Morgo
94.01.01.1004|Girimulyo
94.01.01.1005|Karang Tumaritis
94.01.01.1006|Oyehe
94.01.01.1007|Karang Mulia
94.01.01.1008|Nabarua
94.01.01.1009|Siriwini
94.01.01.2010|Kalisusu
94.01.01.2011|Kali Harapan
94.01.01.2012|Sanoba
94.01.02.2001|Napan
94.01.02.2002|Masipawa
94.01.02.2003|Weinami
94.01.03.2001|Yaur
94.01.03.2002|Akudiomi
94.01.03.2003|Sima
94.01.03.2004|Wami
94.01.04.2001|Topo
94.01.04.2002|Urumusu
94.01.04.2003|Marga Jaya
94.01.04.2004|Argo Mulyo
94.01.04.2005|Topo Jaya
94.01.04.2006|Gamei Jaya
94.01.05.2001|Bumi Mulia
94.01.05.2002|Karadiri
94.01.05.2003|Wanggar Makmur
94.01.06.2001|Unipo
94.01.06.2002|Aibore
94.01.06.2003|Epomani
94.01.06.2004|Tibai
94.01.06.2005|Mabou
94.01.06.2006|Ugida
94.01.07.2001|Makimi
94.01.07.2002|Nifasi
94.01.07.2003|Biha
94.01.07.2004|Lagari Jaya
94.01.07.2005|Maidei
94.01.07.2006|Manunggal Jaya
94.01.08.2001|Napan Yaur
94.01.08.2002|Yeretuar
94.01.08.2003|Bawei
94.01.08.2004|Goni
94.01.09.2001|Samabusa
94.01.09.2002|Waharia
94.01.09.2003|Kimi
94.01.09.2004|Lani
94.01.09.2005|Air Mandidi
94.01.10.2001|Wanggar Sari
94.01.10.2002|Wiraska
94.01.10.2003|Yaro Makmur
94.01.10.2004|Jaya Mukti
94.01.10.2005|Wanggar Pantai
94.01.10.2006|Ororodo
94.01.10.2007|Bomopai
94.01.10.2008|Parauto
94.01.11.2001|Totoberi
94.01.11.2002|Samanui
94.01.11.2003|Kamarisano
94.01.11.2004|Taumi
94.01.11.2005|Keuw
94.01.12.2001|Bumi Raya
94.01.12.2002|Waroki
94.01.12.2003|Gerbang Sadu
94.01.12.2004|Kali Semen
94.01.12.2005|Wadio
94.01.13.2001|Mambor
94.01.13.2002|Hariti
94.01.13.2003|Moor
94.01.13.2004|Kama
94.01.13.2005|Arui
94.01.14.2001|Epouwa
94.01.14.2002|Dikiya
94.01.14.2003|Tagauto
94.01.14.2004|Jigikebo
94.01.14.2005|Jainoa
94.01.15.2001|Kunupi
94.01.15.2002|Ogiyai
94.01.15.2003|Lokodimi
94.01.15.2004|Yegeugi
94.02.01.1010|Wuyukwi
94.02.01.1011|Pagaleme
94.02.01.2001|Pruleme
94.02.01.2002|Wuyukwi
94.02.01.2003|Wuyuneri
94.02.01.2004|Pepera
94.02.01.2005|Muliagambut
94.02.01.2006|Trikora
94.02.01.2007|Towogi
94.02.01.2008|Birak Ambut
94.02.01.2009|Usir
94.02.02.1021|Wurak
94.02.02.2001|Wurak
94.02.02.2002|Lambo
94.02.02.2003|Pindebaga
94.02.02.2004|Dolinggame
94.02.02.2005|Belantara
94.02.02.2006|Kalengga
94.02.02.2007|Pulau Timur
94.02.02.2008|Girmor
94.02.02.2009|Maka
94.02.02.2010|Mobigi
94.02.02.2011|Jauria I
94.02.02.2012|Gubulome
94.02.02.2013|Megawi Megewa
94.02.02.2014|Kurikpulok
94.02.02.2015|Puky paky
94.02.02.2016|Kaninonggo
94.02.02.2017|Kirigimaduk
94.02.02.2018|Pologengga
94.02.02.2019|Ginipago
94.02.02.2020|Aulukme
94.02.03.2001|Fawi
94.02.03.2002|Bakusi
94.02.03.2003|Turumo
94.02.03.2004|Kaho
94.02.03.2005|Biricare
94.02.03.2006|Dorey
94.02.03.2007|Fii
94.02.03.2008|Evo
94.02.03.2009|Yerei
94.02.04.2001|Mewoluk
94.02.04.2002|Gumbru
94.02.04.2003|Anggulobaga
94.02.04.2004|Balinggup
94.02.04.2005|Waliba
94.02.04.2006|Nggininik
94.02.04.2007|Biak
94.02.04.2008|Wutikme
94.02.05.2001|Yambuni
94.02.05.2002|Yogolawi
94.02.05.2003|Wundu
94.02.05.2004|Binime
94.02.05.2005|Tiogeme
94.02.05.2006|Goyage
94.02.05.2007|Kalimbut
94.02.05.2008|Wolame
94.02.05.2009|Muara
94.02.05.2010|Gibaga
94.02.05.2011|Nami
94.02.05.2012|Linwakwi
94.02.05.2013|Kwantineri
94.02.05.2014|Jileyale
94.02.06.2001|Mepar
94.02.06.2002|Anebalui
94.02.06.2003|Pagolome
94.02.06.2004|Tombok
94.02.06.2005|Kering
94.02.06.2006|Meyongga
94.02.06.2007|Oum
94.02.06.2008|Nume
94.02.06.2009|Yawor
94.02.06.2010|Wurina
94.02.06.2011|Woraluk
94.02.06.2012|Onendu
94.02.06.2013|Akwibaga
94.02.07.2001|Gubugani
94.02.07.2002|Ambok
94.02.07.2003|Awiyam
94.02.07.2004|Tubugime
94.02.07.2005|Wariru
94.02.07.2006|Digi
94.02.07.2007|Kikup
94.02.07.2008|Gunung Tayok
94.02.07.2009|Nambu
94.02.07.2010|Asua
94.02.07.2011|Degei
94.02.07.2012|Sigou
94.02.07.2013|Nalu
94.02.08.2001|Tinggineri
94.02.08.2002|Monia
94.02.08.2003|Tingginambut
94.02.08.2004|Melekom
94.02.08.2005|Gigume
94.02.08.2006|Papua
94.02.08.2007|Tingginime
94.02.08.2008|Tombo
94.02.08.2009|Gimanggen
94.02.08.2010|Uragi
94.02.08.2011|Yamengga
94.02.08.2012|Degi
94.02.08.2013|Jugumblawi
94.02.08.2014|Paralo
94.02.08.2015|Womelagandan
94.02.08.2016|Bigirage
94.02.08.2017|Lumbuk
94.02.08.2018|Inikimaluk
94.02.08.2019|Yonggun
94.02.08.2020|Gobak
94.02.08.2021|Gubupur
94.02.08.2022|Berime
94.02.09.2001|Pagaleme
94.02.09.2002|Muliambut
94.02.09.2003|Lunggineri
94.02.09.2004|Igimbut
94.02.09.2005|Kulok enggame
94.02.10.2001|Yarmukum
94.02.10.2002|Pilia
94.02.10.2003|Yaniruk
94.02.10.2004|Gwenggu
94.02.10.2005|Tukwi
94.02.10.2006|Tiru
94.02.10.2007|Yogorini
94.02.10.2008|Nalime
94.02.10.2009|Urgele
94.02.10.2010|Yagonik
94.02.10.2011|Lulame
94.02.11.2001|Wandenggobak
94.02.11.2002|Jiginikime
94.02.11.2003|Puncak Senyum
94.02.11.2004|Anggutari
94.02.11.2005|Wunagelo
94.02.11.2006|Dondo
94.02.11.2007|Tanoba
94.02.11.2008|Niruwi
94.02.11.2009|Yalikambi
94.02.12.2001|Kulirik
94.02.12.2002|Doligobak
94.02.12.2003|Yalinggua
94.02.12.2004|Talilome
94.02.12.2005|Muara
94.02.12.2006|Karubate
94.02.12.2007|Dologobak
94.02.12.2008|Yambidugum
94.02.13.2001|Ilamburawi
94.02.13.2002|Berelema
94.02.13.2003|Kalome
94.02.13.2004|Temu
94.02.13.2005|Jigunikime
94.02.14.2001|Mondu
94.02.14.2002|Yambi
94.02.14.2003|Moulo
94.02.14.2004|Tenolok
94.02.14.2005|Ginigom
94.02.14.2006|Dangenpaga
94.02.14.2007|Wonome
94.02.14.2008|Yoboluk
94.02.14.2009|Tirineri
94.02.15.2001|Lumo
94.02.15.2002|Kililumo
94.02.15.2003|Gilibe
94.02.15.2004|Ninggineri
94.02.15.2005|Wurabak
94.02.15.2006|Wuluma
94.02.15.2007|Tigir
94.02.15.2008|Gililome
94.02.15.2009|Wuramburu
94.02.16.2001|Tiolome
94.02.16.2002|Belabaga
94.02.16.2003|Mewut
94.02.16.2004|Maloinggen
94.02.16.2005|Wanume
94.02.17.2001|Dokome
94.02.17.2002|Purbalo
94.02.17.2003|Wurage
94.02.17.2004|Nowoneri
94.02.17.2005|Nowome
94.02.17.2006|Imulineri
94.02.17.2007|Molobak
94.02.17.2008|Kimibut
94.02.17.2009|Nunggwagi
94.02.18.2001|Kalome
94.02.18.2002|Agape
94.02.18.2003|Cilome
94.02.18.2004|Longgawi
94.02.18.2005|Wundini
94.02.18.2006|Berem
94.02.18.2007|Diraluk
94.02.18.2008|Yanenggawi
94.02.18.2009|Kayogebur
94.02.18.2010|Wurabume
94.02.18.2011|Binggelakme
94.02.18.2012|Torage
94.02.18.2013|Palumagi
94.02.18.2014|Jiramok
94.02.18.2015|Jinggwi
94.02.18.2016|Pilibur
94.02.19.2001|Wanuwi
94.02.19.2002|Nenegame
94.02.19.2003|Bime
94.02.19.2004|Anggege
94.02.19.2005|Pernaluk
94.02.19.2006|Kiburu
94.02.19.2007|Nuwi
94.02.19.2008|Ponggoname
94.02.19.2009|Gibume
94.02.19.2010|Naburage
94.02.19.2011|Yunggwi
94.02.19.2012|Anggagalo
94.02.19.2013|Anggalo
94.02.19.2014|Wiyage
94.02.19.2015|Piyabigimbut
94.02.19.2016|Bunaluk
94.02.19.2017|Gereja Lama
94.02.20.2001|Amberiambut
94.02.20.2002|Kobarak
94.02.20.2003|Wugiwagi
94.02.20.2004|Yagaluk
94.02.20.2005|Moulo
94.02.20.2006|Jimbanime
94.02.20.2007|Jiguluk
94.02.20.2008|Yamoneri
94.02.20.2009|Gumawi
94.02.20.2010|Digolome
94.02.20.2011|Bunume
94.02.20.2012|Ngginigum
94.02.20.2013|Jimbeneri
94.02.20.2014|Jigelo
94.02.20.2015|Piyapigi
94.02.20.2016|Jibonok
94.02.21.2001|Anggutare
94.02.21.2002|Agopaga
94.02.21.2003|Lerawera
94.02.21.2004|Nakongwe
94.02.21.2005|Ginilome
94.02.21.2006|Yalibate
94.02.21.2007|Wurunikime
94.02.21.2008|Jimbinggame
94.02.21.2009|Oriluk
94.02.21.2010|Pagarugom
94.02.21.2011|Towoluk
94.02.21.2012|Tenolok
94.02.21.2013|Jiogobak
94.02.21.2014|Tirigoi
94.02.21.2015|Mondogoneri
94.02.21.2016|Tenomanggen
94.02.21.2017|Andiron
94.02.21.2018|Ambitmbit
94.02.21.2019|Aulakme
94.02.22.2001|Nioga
94.02.22.2002|Yonggi
94.02.22.2003|Wonggi
94.02.22.2004|Wambagalo
94.02.22.2005|Jigonikme
94.02.22.2006|Muruwi
94.02.22.2007|Wutime
94.02.22.2008|Gibaga
94.02.22.2009|Papak
94.02.22.2010|Wanduri
94.02.22.2011|Walom
94.02.23.2001|Gubume
94.02.23.2002|Milineri
94.02.23.2003|Melela
94.02.23.2004|Kenendaga
94.02.23.2005|Apelome
94.02.23.2006|Kumigi
94.02.23.2007|Noba-Noba
94.02.23.2008|Nogi
94.02.23.2009|Gubuneri
94.02.23.2010|Liguni
94.02.23.2011|Mondu
94.02.23.2012|Jinggi
94.02.23.2013|Ginilume
94.02.23.2014|Wunggani
94.02.23.2015|Menggegenikime
94.02.23.2016|Tinggirege
94.02.23.2017|Timoramo
94.02.24.2001|Guna
94.02.24.2002|Mandura
94.02.24.2003|Lugubago
94.02.24.2004|Andugir
94.02.24.2005|Muara Miguni
94.02.24.2006|Abili
94.02.24.2007|Pereya
94.02.24.2008|Ginimanggen
94.02.24.2009|Laworege
94.02.24.2010|Wumbiri
94.02.25.2001|Dagai
94.02.25.2002|Dagai 2
94.02.25.2003|Deide
94.02.25.2004|Faride
94.02.25.2005|Soi
94.02.25.2006|Mbomban
94.02.25.2007|Yeihneri
94.02.25.2008|Mandara Lani
94.02.25.2009|Debite
94.02.25.2010|Gueri
94.02.26.2001|Kiyage
94.02.26.2002|Wanggiba
94.02.26.2003|Amuringgik
94.02.26.2004|Tenggabanggwi
94.02.26.2005|Tumbiwolu
94.02.26.2006|Kelandu
94.02.26.2007|Ambo
94.02.26.2008|Atoli
94.03.01.1001|Enarotali
94.03.01.1006|Timida
94.03.01.2002|Madi
94.03.01.2003|Aikai
94.03.01.2004|Ipakiye
94.03.01.2005|Papato
94.03.01.2007|Kopo
94.03.01.2008|Wage
94.03.01.2009|Kagupago
94.03.01.2010|Oyaigo
94.03.01.2011|Kogekotu
94.03.01.2012|Awabutu
94.03.01.2013|Geko
94.03.01.2014|Mugimeketago
94.03.01.2015|Tuamakida
94.03.01.2016|Geibu
94.03.01.2017|Pudotadi
94.03.01.2018|Kogekotu
94.03.01.2019|Iyaitaka
94.03.01.2020|Ugibutu
94.03.01.2021|Wouyebutu
94.03.01.2022|Amougibutu
94.03.01.2023|Dapaiba
94.03.01.2024|Yukekebo
94.03.01.2025|Agumaida
94.03.01.2026|Yagiyo Butu
94.03.02.1001|Obano
94.03.02.2002|Kegouda
94.03.02.2003|Totiyo
94.03.02.2004|Beko
94.03.02.2005|Tipakotu
94.03.02.2006|Epo Obano
94.03.02.2007|Towauwo
94.03.02.2008|Wiyogei
94.03.02.2009|Ekinauwo
94.03.02.2010|Kigodide
94.03.02.2011|Putakogopa
94.03.02.2012|Waukotopa
94.03.02.2013|Digiugii
94.03.03.2001|Toyaimoti
94.03.03.2002|Agapo
94.03.03.2003|Abatadi
94.03.03.2005|Baguwo
94.03.03.2006|Makidini
94.03.03.2007|Tagiya
94.03.03.2008|Emai
94.03.03.2009|Dinubutu
94.03.03.2013|Duwadide
94.03.04.2001|Bogobaida
94.03.04.2002|Nawipauwo
94.03.04.2003|Madou
94.03.04.2004|Jibudide II
94.03.04.2005|Yumauwo
94.03.04.2006|Kagoudide
94.03.04.2007|Eyapouda
94.03.04.2008|Miyokepi
94.03.04.2009|Obaya Dimi
94.03.05.1001|Bibida
94.03.05.2002|Ugidimi
94.03.05.2003|Odiyai
94.03.05.2004|Tuwaktu
94.03.05.2005|Kugaisiga
94.03.05.2006|Kolaitaga
94.03.05.2007|Dama-dama
94.03.06.2001|Duma
94.03.06.2002|Bomosiga
94.03.06.2003|Japesigaiwaka
94.03.06.2004|Waitapa
94.03.06.2005|Duma II
94.03.07.2001|Todia
94.03.07.2002|Dadou
94.03.07.2003|Bua
94.03.07.2004|Kepi
94.03.07.2005|Wageme
94.03.07.2006|Bugubutu
94.03.07.2007|Dogomouto
94.03.07.2008|Giwo
94.03.07.2009|Nomokepota
94.03.07.2010|Eguai
94.03.07.2011|Degatadi
94.03.07.2012|Uwoyupi
94.03.07.2013|Wegekebo
94.03.07.2014|Yinotadi
94.03.08.2001|Kebo II
94.03.08.2002|Togowa
94.03.08.2003|Ibumaida
94.03.08.2004|Kagupagu
94.03.08.2005|Ayaigo
94.03.08.2006|Geibu
94.03.08.2007|Yokadagi
94.03.08.2008|Bunaida
94.03.08.2009|Kedege
94.03.08.2010|Uwaiye
94.03.08.2011|Dawawa
94.03.08.2012|Mugime Ketago
94.03.08.2013|Tuwamakida
94.03.09.2001|Wotai
94.03.09.2002|Keniapa
94.03.09.2003|Memiyaibutu
94.03.09.2004|Dimiya
94.03.09.2005|Udaugi
94.03.10.2001|Pasir Putih
94.03.10.2002|Geida
94.03.10.2003|Widimeida
94.03.10.2004|Makidimi
94.03.10.2005|Iteuwo
94.03.10.2006|Ogeida
94.03.10.2007|Teguogi Pugaida
94.03.10.2008|Dabamomaida
94.03.10.2009|Baguwo
94.03.10.2010|Keneugi
94.03.10.2011|Debamomaida
94.03.10.2012|Tegougi Pugaida
94.03.11.1006|Badawo
94.03.11.2001|Uwamani
94.03.11.2002|Muyadebe
94.03.11.2003|Woubutu
94.03.11.2004|Kugitadi
94.03.11.2005|Kobouyagapa
94.03.11.2007|Geko
94.03.11.2008|Kinou
94.03.11.2009|Toko
94.03.11.2010|Yagiyo Butu
94.03.11.2011|Obaidagi
94.03.12.2001|Dei
94.03.12.2002|Obaiyoweta
94.03.12.2003|Bubugiwo
94.03.12.2004|Yimouto
94.03.12.2005|Tamugauwo
94.03.12.2006|Dagouto
94.03.12.2007|Kopabutu
94.03.12.2008|Boutai
94.03.12.2009|Buka Duwata
94.03.13.2001|Pugo
94.03.13.2002|Waidide
94.03.13.2003|Kopaidagi
94.03.13.2004|Uwibutu
94.03.13.2005|Tipago
94.03.13.2006|Boba
94.03.13.2007|Iyaidagi
94.03.13.2008|Iyaitadi
94.03.13.2009|Waiepo
94.03.14.2001|Muyetadi
94.03.14.2002|Mogeya
94.03.14.2003|Epabutu
94.03.14.2004|Tiga Damuto
94.03.14.2005|Bebiyai
94.03.14.2006|Idaiyo
94.03.14.2007|Tinou
94.03.14.2008|Damuto
94.03.14.2009|Obaiyodimi
94.03.14.2010|Amopa
94.03.15.2001|Okaitadi
94.03.15.2002|Kito
94.03.15.2003|Geiketago
94.03.15.2004|Kadiyai
94.03.15.2005|Uwodege
94.03.15.2006|Digiyo Tuwataida
94.03.15.2007|Itoka
94.03.16.2001|Ukauwo
94.03.16.2002|Waipa
94.03.16.2003|Ukago
94.03.16.2004|Totiyo
94.03.16.2005|Biyadide
94.03.16.2006|Pekege
94.03.17.2001|Panibagata
94.03.17.2002|Pugaida
94.03.17.2003|Aweubutu
94.03.17.2004|Ipuwa
94.03.17.2005|Munaiyepa
94.03.17.2006|Kebo I
94.03.17.2007|Payogei
94.03.17.2008|Detauwo
94.03.17.2009|Yaibu
94.03.17.2010|Woyouto
94.03.18.2001|Youtadi
94.03.18.2002|Uwagi
94.03.18.2003|Ipouwa
94.03.18.2004|Munaiyepa
94.03.18.2005|Dokoneida
94.03.18.2006|Namutadi
94.03.19.2001|Nomouwodide
94.03.19.2002|Pikokebo
94.03.19.2003|Baya Biru
94.03.19.2004|Jigitopa Timur
94.03.19.2005|Maatadi
94.03.19.2006|Pupekebo
94.03.20.2001|Uwebutu
94.03.20.2002|Epouto
94.03.20.2003|Tugumo
94.03.20.2004|Tugu Kagomoma
94.03.20.2005|Deiyamo
94.03.20.2006|Miyamo
94.03.21.2001|Dogomo
94.03.21.2002|Bomong Bugopa
94.03.21.2003|Dangipa
94.03.21.2004|Ondegapa
94.03.21.2005|Sogomo
94.03.22.2001|Deta
94.03.22.2002|Tuguwai
94.03.22.2003|Tuguwai Moma
94.03.22.2004|Bumaida
94.03.22.2005|Debaiye
94.03.22.2007|Komopa
94.03.23.2001|Obaipugaida
94.03.23.2002|Eyagitaida
94.03.23.2003|Momageida
94.03.23.2004|Ekauwiya
94.03.23.2005|DebaKebouda
94.03.23.2006|Kaidoutadi
94.03.23.2007|Pogeidimi
94.03.23.2008|Okonobaida
94.03.23.2009|Gakokotu
94.03.23.2010|Kegama
94.03.24.2001|Yabomaida
94.03.24.2002|Akoubaida
94.03.24.2003|Dauwagu
94.03.24.2004|Ganeyetaka
94.03.24.2005|Yabomaida II
94.03.24.2006|Bodatadi
94.03.24.2007|Ibouwagu
94.04.01.1001|Koperapoka
94.04.01.1002|Kwamki
94.04.01.1003|Timika Jaya
94.04.01.1007|Sempan
94.04.01.1008|Pasar Sentral
94.04.01.1009|Wanagon
94.04.01.1010|Kebun Sirih
94.04.01.1011|Otomona
94.04.01.1012|Perintis
94.04.01.1013|Dingo Narama
94.04.01.1014|Timika Indah
94.04.01.2004|Nayaro
94.04.01.2005|Minabua
94.04.01.2006|Hangaitji
94.04.02.2001|Kiliarma
94.04.02.2002|Amungun
94.04.02.2003|Aramsolki
94.04.02.2004|Fakafuku
94.04.02.2005|Masasimamo
94.04.02.2006|Emogoma
94.04.02.2007|Emkoma Halama
94.04.02.2008|Hinat Untung
94.04.03.1001|Wania
94.04.03.2002|Kaugapa
94.04.03.2003|Poumako
94.04.03.2004|Tipuka
94.04.03.2005|Muare
94.04.03.2006|Hiripau
94.04.04.2001|Kokonao
94.04.04.2002|Migiwia
94.04.04.2003|Kiura
94.04.04.2004|Mimika
94.04.04.2005|Aparuka
94.04.04.2006|Atapo
94.04.04.2007|Apuri
94.04.05.2001|Sempan Timur
94.04.05.2002|Wenin
94.04.05.2003|Noema
94.04.05.2004|Wapu
94.04.05.2005|Sumapro
94.04.05.2006|Wacakam
94.04.05.2007|Waituku
94.04.05.2008|Bulumen
94.04.05.2009|Kanmapiri
94.04.05.2010|Jaitak
94.04.06.2001|Jila
94.04.06.2002|Diloa
94.04.06.2003|Noemun
94.04.06.2004|Pasir Putih
94.04.06.2005|Jengkon
94.04.06.2006|Pilik Ogom
94.04.06.2007|Bunaraugin
94.04.06.2008|Umpliga
94.04.06.2009|Amua Ogom
94.04.06.2010|Pusuwe
94.04.06.2011|Wandud
94.04.06.2012|Diloa Dua
94.04.07.2001|Ayuka
94.04.07.2002|Amamapare
94.04.07.2003|Ohotya
94.04.07.2004|Omawita
94.04.07.2005|Fanamo
94.04.08.2001|Atuka
94.04.08.2002|Tiwaka
94.04.08.2003|Keakwa
94.04.08.2004|Aikawapuka
94.04.08.2005|Kamoro
94.04.09.1001|Kuala Kencana
94.04.09.1002|Karang Senang
94.04.09.2003|Utikini Baru
94.04.09.2004|Bhintuka
94.04.09.2005|Tioka Kencana
94.04.09.2006|Mimika Gunung
94.04.09.2007|Karya Kencana
94.04.09.2008|Utikini Dua
94.04.09.2009|Utikini Tiga
94.04.09.2010|Jimbi
94.04.10.1001|Tembagapura
94.04.10.2002|Waa
94.04.10.2003|Arwanop
94.04.10.2004|T'Singa
94.04.10.2005|Jagamin
94.04.10.2006|Banigogom
94.04.10.2007|Opitawak
94.04.10.2008|Doliningokngin
94.04.10.2009|Banti Dua
94.04.10.2010|Aingogin
94.04.10.2011|Baluni
94.04.10.2012|Noselanop
94.04.10.2013|Meningimponogama
94.04.10.2014|Jongkogama
94.04.11.2001|Potowai Buru
94.04.11.2002|Yapkoka
94.04.11.2003|Aindua
94.04.11.2004|Tapomai
94.04.11.2005|Umar
94.04.12.2001|Kapiraya
94.04.12.2002|Uta
94.04.12.2003|Mupuruka
94.04.12.2004|Wumuka
94.04.12.2005|Akar
94.04.12.2006|Mapar
94.04.12.2007|Kipia
94.04.12.2008|Pronggo
94.04.12.2009|Wakia
94.04.13.1001|Harapan
94.04.13.2002|Meekurima
94.04.13.2003|Landun Mekar
94.04.13.2004|Olaroa
94.04.13.2005|Bintang Lima
94.04.13.2006|Damai
94.04.13.2007|Walani
94.04.13.2008|Amole
94.04.13.2009|Lamopi
94.04.13.2010|Tunas Matoa
94.04.14.2001|Hoya
94.04.14.2002|Mamontoga
94.04.14.2003|Jinonin
94.04.14.2004|Kulama Ogom
94.04.14.2005|Puti
94.04.14.2006|Jawa
94.04.15.2001|Limau Asri Timur
94.04.15.2002|Wangirja
94.04.15.2003|Iwaka
94.04.15.2004|Naena Muktipura
94.04.15.2005|Mulia Kencana
94.04.15.2006|Pigapu
94.04.15.2007|Limau Asri Barat
94.04.16.1002|Kamoro Jaya
94.04.16.1003|Wonosari Jaya
94.04.16.1005|Inauga
94.04.16.2001|Kadun Jaya
94.04.16.2004|Nawaripi
94.04.16.2006|Mawokau Jaya
94.04.16.2007|Mandiri Jaya
94.04.17.2001|Amar
94.04.17.2002|Kawar
94.04.17.2003|Manuare
94.04.17.2004|Ipiri
94.04.17.2005|Paripi
94.04.17.2006|Yaraya
94.04.18.2001|Enggin
94.04.18.2002|Alama
94.04.18.2003|Senawak
94.04.18.2004|Unimogom
94.04.18.2005|Bemoki
94.04.18.2006|Tagaralma
94.04.18.2007|Geselema
94.04.18.2008|Wuarem
94.04.18.2009|Jenggelo
94.04.18.2010|Purua
94.04.18.2011|Kilmit
94.05.01.2001|Kago
94.05.01.2002|Kimak
94.05.01.2003|Wuloni
94.05.01.2004|Nipuralome
94.05.01.2005|Tagaloa
94.05.01.2006|Jenggerpaga
94.05.01.2007|kibogolome
94.05.01.2008|Ilambet
94.05.01.2009|Kalebut
94.05.02.2001|Wangbe
94.05.02.2002|Jindak
94.05.02.2003|Pungki
94.05.02.2004|Wonalbe
94.05.02.2005|Ulipia
94.05.02.2006|Marilaukin
94.05.02.2007|Ailpailin
94.05.02.2008|Wungbet
94.05.02.2009|Nagaljagama
94.05.02.2010|Mongkoihol
94.05.02.2011|Nangi
94.05.03.2001|Yulukoma
94.05.03.2002|Milawak
94.05.03.2003|Tinggilbet
94.05.03.2004|Ogamki
94.05.03.2005|Dengkibuma
94.05.03.2006|Dambet
94.05.03.2007|Ondugi
94.05.03.2008|Ambobera
94.05.04.2001|Doufo
94.05.04.2002|Iratoi
94.05.04.2003|Lani
94.05.04.2004|Wahuka
94.05.04.2005|Sibita
94.05.04.2006|Rawa
94.05.04.2007|Jirei
94.05.05.2001|Pogoma
94.05.05.2002|Gagama
94.05.05.2003|Wiha
94.05.05.2004|Wakme
94.05.05.2005|Ugutmu
94.05.05.2006|Yugume
94.05.05.2007|Kolamagi
94.05.05.2008|Guwamu
94.05.05.2009|Kumasingga
94.05.06.2001|Yauria
94.05.06.2002|Gigobak
94.05.06.2003|Kalibuk
94.05.06.2004|Kelemame
94.05.06.2005|Gulabut
94.05.06.2006|Kolaribanak
94.05.06.2007|Mogulu
94.05.06.2008|Gigobak II
94.05.06.2009|Pasir Putih
94.05.06.2010|Gingga Baru
94.05.06.2011|Tenonggame
94.05.07.2001|Agandugume
94.05.07.2002|Gut'yenggenak
94.05.07.2003|Dugunale
94.05.07.2004|Ogobak'pelenak
94.05.07.2005|Dolinggu
94.05.07.2006|Ayume
94.05.07.2007|Terowi
94.05.08.2001|Gome
94.05.08.2002|Misimaga
94.05.08.2003|Upaga
94.05.08.2004|Agiyome
94.05.08.2005|Yenggernok
94.05.08.2006|Wako
94.05.08.2007|Tegelobak
94.05.08.2008|Ninggabuma
94.05.08.2009|Kelanungin
94.05.08.2010|Yonggolawi
94.05.09.2001|Tayai
94.05.09.2002|Kordesi
94.05.09.2003|Faisau
94.05.09.2004|Fokri
94.05.09.2005|Foisa
94.05.09.2006|Duaita
94.05.09.2007|Dervos
94.05.10.2001|Babe
94.05.10.2002|Jambul
94.05.10.2003|Nungai
94.05.10.2004|Mugulip
94.05.10.2005|Kelmabet
94.05.10.2006|Jenggeren
94.05.11.2001|Puluk
94.05.11.2002|Kelandiruma
94.05.11.2003|Pupet
94.05.11.2004|Pilokoma
94.05.11.2005|Gimurik
94.05.11.2006|Wandibet
94.05.11.2007|Meningimte
94.05.11.2008|Bungok
94.05.12.2001|Erong Berong
94.05.12.2002|Hikinat
94.05.12.2003|Daung
94.05.12.2004|Kombet
94.05.12.2005|Onop
94.05.12.2006|Kulamagom
94.05.12.2007|Ogamanin
94.05.13.2001|Aguit
94.05.13.2002|Kembru
94.05.13.2003|Molu
94.05.13.2004|Belaba
94.05.13.2005|Makuma
94.05.13.2006|Tinoti
94.05.13.2007|Nilime
94.05.14.2001|Golu
94.05.14.2002|Bina
94.05.14.2003|Lumakluk
94.05.14.2004|Wogot
94.05.14.2005|Kabogoluk
94.05.14.2006|Ogomegat
94.05.14.2007|Mamaput
94.05.15.2001|Kilunggame
94.05.15.2002|Bakcini
94.05.15.2003|Timobut
94.05.15.2004|Tagalame I
94.05.15.2005|Wonelupaga
94.05.15.2006|Komapaga
94.05.15.2007|Timobut Egewak
94.05.16.2001|Nigilome
94.05.16.2002|Weni
94.05.16.2003|Amuleme
94.05.16.2004|Jigunggi
94.05.16.2005|Kumikomo
94.05.16.2006|Rumagi
94.05.16.2007|Gelegi
94.05.16.2008|Wombru
94.05.16.2009|Kondokwe
94.05.16.2010|Tinibolu
94.05.16.2011|Winanggwi
94.05.17.2001|Pamebut
94.05.17.2002|Agenggen
94.05.17.2003|Yugumuak
94.05.17.2004|Wilewak
94.05.17.2005|Lambera
94.05.17.2006|Wobulo
94.05.17.2007|Mugalolo
94.05.17.2008|Manggame
94.05.17.2009|Jerusalem
94.05.17.2010|Wiyabubu
94.05.18.2001|Mayuberi
94.05.18.2002|Maki
94.05.18.2003|Paluga
94.05.18.2004|Ayali
94.05.18.2005|Toegi
94.05.18.2006|Amungi
94.05.18.2007|Olenki
94.05.18.2008|Mundiba
94.05.18.2009|Akonobak
94.05.19.2001|Bubet
94.05.19.2002|Bologobak
94.05.19.2003|Ko'eao
94.05.19.2004|Ogongki
94.05.19.2005|Mabuga
94.05.19.2006|Kabuki
94.05.19.2007|Oknanim
94.05.19.2008|Kalemogom
94.05.20.2001|Eromaga
94.05.20.2002|Pinggil/Eronggobak
94.05.20.2003|Gilini
94.05.20.2004|Pinapa
94.05.20.2005|Kunga
94.05.20.2006|Ondugura
94.05.20.2007|Manggume
94.05.20.2008|Kuleme
94.05.20.2009|Ninggibome
94.05.20.2010|Awilkinop
94.05.20.2011|Domaoa
94.05.20.2012|Pungtrama
94.05.20.2013|Balamagalama
94.05.20.2014|Aminggaru
94.05.21.2001|Tuput
94.05.21.2002|Wenggen'ambut
94.05.21.2003|Wamiru
94.05.21.2004|Piluwolu
94.05.21.2005|Tenawi
94.05.21.2006|Wanombut
94.05.21.2007|Pumbanak
94.05.22.2001|Jiwot
94.05.22.2002|Gunaluk
94.05.22.2003|Kugiame
94.05.22.2004|Wuyunggame
94.05.22.2005|Deogi
94.05.22.2006|Jugumi
94.05.23.2001|Amungkalpia
94.05.23.2002|Bela
94.05.23.2003|Ompliga
94.05.23.2004|Alama
94.05.23.2005|Tagalarama
94.05.23.2006|Bemoki
94.05.24.2001|Mundidok
94.05.24.2002|Yaiki Maiki
94.05.24.2003|Tobenggi
94.05.24.2004|Towenggi II
94.05.24.2005|Welenggaru
94.05.25.2001|Erelmakawia
94.05.25.2002|Kalpamonora
94.05.25.2003|Bomogin
94.05.25.2004|Mamoldema
94.05.25.2005|Wamagun
94.05.25.2006|Amungkonin
94.05.25.2007|Ipmangkop
94.05.25.2008|Tamagun
94.05.25.2009|Ai Arama
94.06.01.2001|Ikebo
94.06.01.2002|Mauwa
94.06.01.2003|Ekemanida
94.06.01.2004|Bukapa
94.06.01.2005|Kimupugi
94.06.01.2006|Dikiyouwo
94.06.01.2007|Idakotu
94.06.01.2008|Putapa
94.06.02.2001|Bobomani
94.06.02.2002|Abaimaida
94.06.02.2003|Bonakunu
94.06.02.2004|Dawaikunu
94.06.02.2005|Magone
94.06.02.2006|Diyoudimi
94.06.02.2007|Obaikagopa
94.06.03.2001|Apogomakida
94.06.03.2002|Deneiode
94.06.03.2003|Yegiyepa
94.06.03.2004|Ideduwa
94.06.03.2005|Kegata
94.06.03.2006|Egipa
94.06.03.2007|Ukagu
94.06.03.2008|Tibaugi
94.06.04.2001|Idakebo
94.06.04.2002|Pugatadi I
94.06.04.2003|Pugatadi II
94.06.04.2004|Ikrar
94.06.04.2005|Obayo
94.06.04.2006|Kuyakago
94.06.04.2007|Mogou
94.06.04.2008|Yametadi
94.06.04.2009|Duntek
94.06.04.2010|Ekimani
94.06.05.2001|Unito
94.06.05.2002|Sukikai
94.06.05.2003|Iyaro
94.06.05.2004|Wigoumakida
94.06.06.2001|Abouyaga
94.06.06.2002|Maikotu
94.06.06.2003|Taubaikebo
94.06.06.2004|Yegoukotu
94.06.07.2001|Puweta I
94.06.07.2002|Pouwouda
94.06.07.2003|Puweta II
94.06.07.2004|Botumoma
94.06.07.2005|Obaibega
94.06.07.2006|Digikebo
94.06.07.2007|Bogiyateugi
94.06.07.2008|Matadi
94.06.07.2009|Tuwaida
94.06.07.2010|Yepo
94.06.07.2011|Ugikagouda
94.06.07.2012|Ugikebo
94.06.08.2001|Ugapuga
94.06.08.2002|Deiyapa
94.06.08.2003|Boduda
94.06.08.2004|Yotapuga
94.06.08.2005|Bokaibutu
94.06.08.2006|Bunauwo
94.06.08.2007|Nuwa
94.06.09.2001|Piyakunu
94.06.09.2002|Diyeugi
94.06.09.2003|Putaapa
94.06.09.2004|Atou
94.06.09.2005|Modio
94.06.09.2006|Upibega
94.06.09.2007|Timepa
94.06.09.2008|Gabaikunu
94.06.09.2009|Adauwo
94.06.09.2010|Megaikebo
94.06.10.2001|Dogimani
94.06.10.2002|Kigamani
94.06.10.2003|Idadagi
94.06.10.2004|Denemani
94.06.10.2005|Makidimi
94.06.10.2006|Egebutu
94.06.10.2007|Motito
94.06.10.2008|Bobobutu
94.06.10.2009|Pona
94.07.01.2001|Emondi
94.07.01.2002|Mindau
94.07.01.2003|Sambili
94.07.01.2004|Yoparu
94.07.01.2005|Yokatapa
94.07.01.2006|Bilogai
94.07.01.2007|Puyagia
94.07.01.2008|Jalae
94.07.01.2009|Mamba
94.07.01.2010|Titigi
94.07.01.2011|Eknemba
94.07.01.2012|Wandoga
94.07.01.2013|Pesiga
94.07.01.2014|Mblusiga
94.07.01.2015|Ndugusiga
94.07.01.2016|Kumbalagupa
94.07.01.2017|Buwisiga
94.07.02.2001|Mapa
94.07.02.2002|Bilai
94.07.02.2003|Maya
94.07.02.2004|Degesiga
94.07.02.2005|Pogapa
94.07.02.2006|Bamba
94.07.02.2007|Zombandoga
94.07.02.2008|Kobae
94.07.02.2009|Selemama
94.07.02.2010|Kendetapa
94.07.02.2011|Hiyabu
94.07.02.2012|Ogoeapa
94.07.02.2013|Bonogo
94.07.02.2014|Agapa
94.07.02.2015|Engganengga
94.07.02.2016|Waiagepa
94.07.02.2017|Hugitapa
94.07.02.2018|Bubisiga
94.07.02.2019|Nggagemba
94.07.02.2020|Sanepa
94.07.02.2021|Mbomogo
94.07.03.2001|Sabisa
94.07.03.2002|Dubandoga
94.07.03.2003|Debasiga I
94.07.03.2004|Debasiga II
94.07.03.2005|Isandoga
94.07.03.2006|Mogalo
94.07.03.2007|Jae
94.07.03.2008|Mbugulo
94.07.03.2009|Hulagupa
94.07.04.2001|Danggatadi
94.07.04.2002|Mbiandoga
94.07.04.2003|Bugalaga
94.07.04.2004|Yagaito
94.07.04.2005|Kalawa
94.07.04.2006|Yanei
94.07.04.2007|Maniuwo
94.07.04.2008|Tunggapo
94.07.04.2009|Pagamba
94.07.04.2010|Maolagi
94.07.04.2011|Aneya
94.07.04.2012|Kigitadi
94.07.04.2013|Ndabatadi
94.07.04.2014|Moyomataga
94.07.04.2015|Pitadi
94.07.04.2016|Ular Merah
94.07.05.2001|Agisiga
94.07.05.2002|Tausiga
94.07.05.2003|Unabundoga
94.07.05.2004|Mbamogo
94.07.05.2005|Jenetapa Janasiga
94.07.05.2006|Soali
94.07.05.2007|Tambage
94.07.05.2008|Nabia
94.07.05.2009|Danggoa
94.07.05.2010|Kombogosiga
94.07.06.2001|Wabui
94.07.06.2002|Balaimai
94.07.06.2003|Janamba
94.07.06.2004|Kulapa
94.07.06.2005|Pugisiga
94.07.06.2006|Hitadipa
94.07.06.2007|Soanggama
94.07.06.2008|Danggomba
94.07.06.2009|Sakumba
94.07.07.2001|Ugimba
94.07.07.2002|Bunaopa
94.07.07.2003|Pigabu
94.07.07.2004|Teteopa
94.07.07.2005|Dukendopa
94.07.07.2006|Nggamagae
94.07.08.2001|Tomosiga
94.07.08.2002|Bigasiga
94.07.08.2003|Dapiaga
94.07.08.2004|Pewesiga
94.07.08.2005|Hegenagai
94.07.08.2006|Gaimigi
94.07.08.2007|Jawasiga
94.07.08.2008|Duginggobo
94.07.08.2009|Sugulubagala
94.08.01.2001|Waghete I
94.08.01.2002|Ugiya
94.08.01.2003|Yaba
94.08.01.2004|Waghete II
94.08.01.2005|Bomau I
94.08.01.2006|Okomakebo
94.08.01.2007|Bamou II
94.08.01.2008|Atouda
94.08.01.2009|Oneibo
94.08.01.2010|Yaba II
94.08.01.2011|Mugouda
94.08.01.2012|Bomou III
94.08.01.2013|Okomotadi
94.08.01.2014|Buwoudimi
94.08.01.2015|Ibodiyo
94.08.01.2016|Ikiyawo
94.08.01.2017|Motano
94.08.01.2018|Amago
94.08.01.2019|Idege
94.08.01.2020|Peku
94.08.02.2001|Damabagata
94.08.02.2002|Kokobaya
94.08.02.2003|Watiyai
94.08.02.2004|Edagotadi
94.08.02.2005|Dakebo
94.08.02.2006|Bagou
94.08.02.2007|Dagokebo
94.08.02.2008|Ipoke
94.08.02.2009|Waitakotu
94.08.02.2010|Pekepa
94.08.02.2011|Bagumoma
94.08.02.2012|Udaugida
94.08.02.2013|Bagou II
94.08.02.2014|Idayodagi
94.08.03.2001|Kopai I
94.08.03.2002|Kopai II
94.08.03.2003|Woge
94.08.03.2004|Yewadide
94.08.03.2005|Mudetadi
94.08.03.2006|Diita
94.08.04.2001|Gakokebo
94.08.04.2002|Demago
94.08.04.2003|Widuwakiya
94.08.04.2004|Onago
94.08.04.2005|Wagomani
94.08.04.2006|Digibagata
94.08.04.2007|Piyekedimi
94.08.04.2008|Ayatei
94.08.04.2009|Tenedagi
94.08.04.2010|Diyai
94.08.04.2011|Jinidaba
94.08.04.2012|Widimei
94.08.04.2013|Yagu
94.08.04.2014|Obai
94.08.04.2015|Yipai
94.08.04.2016|Diyai II
94.08.04.2017|Meyepa
94.08.04.2018|Kogemani
94.08.04.2019|Digikotu
94.08.04.2020|Onago II
94.08.04.2021|Maatadi
94.08.04.2022|Epanai
94.08.05.2001|Komauto/Kapiraya
94.08.05.2002|Mogodagi
94.08.05.2003|Yamouwitina
94.08.05.2004|Idego
94.08.05.2005|Uwe Onagei
95.01.01.1001|Wamena Kota
95.01.01.1006|Sinapuk
95.01.01.1007|Sinakma
95.01.01.2002|Honelama
95.01.01.2003|Hulekama
95.01.01.2004|Batu Merah
95.01.01.2005|Autakma
95.01.01.2008|Honelama Dua
95.01.01.2009|Honaima
95.01.01.2010|Lanitipo
95.01.01.2011|Wamaroma
95.01.02.2001|Jiwika
95.01.02.2002|Mulima
95.01.02.2003|Waga-Waga
95.01.02.2004|Abusa
95.01.02.2005|Eragama
95.01.02.2006|Kumima
95.01.02.2007|Menagaima
95.01.02.2008|Iyantik
95.01.02.2009|Umpagalo
95.01.02.2010|Hopama
95.01.02.2011|Obya
95.01.02.2012|Utkolo Satu
95.01.03.2001|Kimbin
95.01.03.2002|Walak
95.01.03.2003|Araboda
95.01.03.2004|Logotpaga
95.01.03.2005|Wawanca
95.01.03.2006|Miligatnem
95.01.03.2007|Loki
95.01.03.2008|Tikawo
95.01.03.2009|Kombagwe
95.01.03.2010|Wanggonoma
95.01.04.2001|Hubikosi
95.01.04.2002|Kosimeage
95.01.04.2003|Kosihilapok
95.01.04.2004|Meagama
95.01.04.2005|Pipukmo
95.01.04.2006|Isakusa
95.01.04.2007|Pelima
95.01.04.2008|Kikhumo
95.01.04.2009|Jibilabaga
95.01.04.2010|Ikilumo
95.01.04.2011|Sunili
95.01.05.2001|Bolakme
95.01.05.2002|Munak
95.01.05.2003|Tenonggame
95.01.05.2004|Bandua
95.01.05.2005|Lani Timur
95.01.05.2006|Nunggarugum
95.01.05.2007|Poitmos
95.01.05.2008|Kugitero
95.01.05.2009|Wenamela
95.01.05.2010|Bimu
95.01.05.2011|Tekani
95.01.05.2012|Owagambak
95.01.06.2001|Walelagama
95.01.06.2002|Pugima
95.01.06.2003|Itlay Halitopo
95.01.06.2004|Kubulakma
95.01.06.2005|Kulaken
95.01.06.2006|Wamusage
95.01.07.2001|Temia
95.01.07.2002|Anegera
95.01.07.2003|Elabukama
95.01.07.2004|Siapma
95.01.07.2005|Hamuhi
95.01.07.2006|Kosihave
95.01.07.2007|Mulupalek
95.01.07.2008|Pumasili
95.01.07.2009|Abulukmo
95.01.07.2010|Yumugima
95.01.08.2001|Wolo
95.01.08.2002|Kukurima
95.01.08.2003|Pirambot
95.01.08.2004|Tegabaga
95.01.08.2005|Wollo Timur
95.01.08.2006|Alugi
95.01.08.2007|Wunan
95.01.08.2008|Wodloma
95.01.09.2001|Sinata
95.01.09.2002|Asolokobal
95.01.09.2003|Hesatom
95.01.09.2004|Asotapo
95.01.09.2005|Wiaima
95.01.09.2006|Ninabua
95.01.09.2007|Helaluwa
95.01.09.2008|Mulinekama
95.01.09.2009|Yapema
95.01.10.2001|Heatnem
95.01.10.2002|Wililimo
95.01.10.2003|Yabem
95.01.10.2004|Waukahilapok
95.01.10.2005|Aleak
95.01.10.2006|Inanekelok
95.01.10.2007|Witalak
95.01.10.2008|Mulukmo
95.01.10.2009|Landia
95.01.10.2010|Filia
95.01.10.2011|Isugunik
95.01.10.2012|Hitelowa
95.01.10.2013|Duabalek
95.01.11.2001|Yalengga
95.01.11.2002|Taganik
95.01.11.2003|Wananuk
95.01.11.2004|Pilimo
95.01.11.2005|Tumun
95.01.11.2006|Akorek
95.01.11.2007|Manili
95.01.11.2008|Aipakma
95.01.11.2009|Wugurima
95.01.11.2010|Bitti
95.01.11.2011|Wamanuk Dua
95.01.12.2001|Trikora
95.01.12.2002|Nanggo
95.01.12.2003|Dinggilmo
95.01.12.2004|Kora Jaya
95.01.12.2005|Korambirik
95.01.12.2006|Anggulpa
95.01.13.2001|Napua
95.01.13.2002|Holima
95.01.13.2003|Lani Matuan
95.01.13.2004|Okilik
95.01.13.2005|Healekma
95.01.13.2006|Yelekama
95.01.13.2007|Sapalek
95.01.13.2008|Yomaima
95.01.13.2009|Wilekama
95.01.14.2001|Walaik
95.01.14.2002|Elarek
95.01.14.2003|Holima
95.01.14.2004|Yelai
95.01.14.2005|Welekama
95.01.15.2001|Wouma
95.01.15.2002|Ketimavit
95.01.15.2003|Wesakma
95.01.15.2004|Logonoba
95.01.15.2005|Wesakin
95.01.15.2006|Pipitmo
95.01.15.2007|Sinarekowa
95.01.16.2001|Hubikiak
95.01.16.2002|Hetuma
95.01.16.2003|Dokopku
95.01.16.2004|Likino
95.01.16.2005|Musiamia
95.01.16.2006|Husoak
95.01.16.2007|Hom-hom
95.01.16.2008|Musiamia Dua
95.01.17.2001|Yagarobak
95.01.17.2002|Zapma
95.01.17.2003|Ayobaibur
95.01.17.2004|Ibele
95.01.17.2005|Tipalok
95.01.17.2006|Habema
95.01.17.2007|Zinai
95.01.17.2008|Holaliba
95.01.17.2009|Yelebarek
95.01.17.2010|Yokalpalek
95.01.18.2001|Tailarek
95.01.18.2002|Senogolik
95.01.18.2003|Bokiem
95.01.18.2004|Iyora
95.01.18.2005|Budliem
95.01.18.2006|Yoman Weya
95.01.18.2007|Huluaima
95.01.18.2008|Entagekokma
95.01.19.2001|Lukaken
95.01.19.2002|Miami
95.01.19.2003|Waroba
95.01.19.2004|Yogonima
95.01.19.2005|Tomisa
95.01.19.2006|Helepalegem
95.01.19.2007|Siliwa
95.01.19.2008|Sumunikama
95.01.19.2009|Kemisake
95.01.20.2001|Siepkosi
95.01.20.2002|Yumogima
95.01.20.2003|Sekan
95.01.20.2004|Noagalo
95.01.20.2005|Manika
95.01.20.2006|Sekan Dalam
95.01.20.2007|Isawa Himan
95.01.20.2008|Lunaima
95.01.20.2009|Wekia
95.01.21.2001|Usilimo
95.01.21.2002|Siba
95.01.21.2003|Wosiala
95.01.21.2004|Gua Wisata
95.01.21.2005|Undulumo
95.01.21.2006|Fikha
95.01.21.2007|Meagamia
95.01.21.2008|Alona
95.01.21.2009|Abutpuk
95.01.21.2010|Isaiman
95.01.22.2001|Korma
95.01.22.2002|Tulem
95.01.22.2003|Alula
95.01.22.2004|Arogolik
95.01.22.2005|Wiligima
95.01.23.2001|Muliama
95.01.23.2002|Wenabubaga
95.01.23.2003|Kilubaga
95.01.23.2004|Musalfak
95.01.23.2005|Punakul
95.01.24.2001|Wadangku
95.01.24.2002|Agulimo
95.01.24.2003|Musiem
95.01.24.2004|Yomosimo
95.01.24.2005|Luku-luku
95.01.25.2001|Pisugi
95.01.25.2002|Pabuma
95.01.25.2003|Aikima
95.01.25.2004|Pikhe
95.01.25.2005|Akiaput
95.01.25.2006|Suroba
95.01.25.2007|Wara
95.01.26.2001|Koragi
95.01.26.2002|Telegai
95.01.26.2003|Kumudiluk
95.01.26.2004|Tagibaga
95.01.26.2005|Tenondek
95.01.27.2001|Tagime
95.01.27.2002|Porome
95.01.27.2003|Onggobalo
95.01.27.2004|Lakwame
95.01.27.2005|Yordania Tulak
95.01.27.2006|Gume Kupari
95.01.27.2007|Wandinggunie
95.01.27.2008|Mulugame
95.01.27.2009|Lapeyo
95.01.27.2010|Yanggapura
95.01.27.2011|Yogobur
95.01.28.2001|Tanahmerah
95.01.28.2002|Towagame
95.01.28.2003|Molagalome
95.01.28.2004|Kwigiluk
95.01.28.2005|Mebunukme
95.01.28.2006|Okwa
95.01.29.2001|Tagineri
95.01.29.2002|Injuta
95.01.29.2003|Binibaga
95.01.29.2004|Tamokilu
95.01.29.2005|Pagaluk
95.01.29.2006|Gelelame
95.01.29.2007|Wilaloma
95.01.29.2008|Melemei
95.01.29.2009|Wuragukme
95.01.30.2001|Wogi
95.01.30.2002|Elaboge
95.01.30.2003|Holasili
95.01.30.2004|Yerega
95.01.30.2005|Olagi
95.01.30.2006|Gigilobo
95.01.30.2007|Apnae
95.01.30.2008|Wonenggulik
95.01.31.2001|Piramid
95.01.31.2002|Yonggime
95.01.31.2003|Perabaga
95.01.31.2004|Algonik
95.01.31.2005|Yalinggume
95.01.31.2006|Abuneri
95.01.31.2007|Gobalimo
95.01.31.2008|Balima
95.01.31.2009|Yumbun
95.01.31.2010|Beam
95.01.32.2001|Miliama
95.01.32.2002|Asologaima
95.01.32.2003|Kewin
95.01.32.2004|Holkima
95.01.32.2005|Helefa
95.01.32.2006|Sekom
95.01.32.2007|Delekama
95.01.32.2008|Molebaga
95.01.32.2009|Silamik
95.01.32.2010|Konan
95.01.32.2011|Pilibaga
95.01.32.2012|Hukuragi
95.01.33.2001|Bugi
95.01.33.2002|Manda
95.01.33.2003|Dewene
95.01.33.2004|Totni
95.01.33.2005|Tagulik
95.01.33.2006|Walak Selatan
95.01.33.2007|Kodlangga
95.01.33.2008|Air Garam
95.01.34.2001|Iriliga
95.01.34.2002|Onggobaga
95.01.34.2003|Walakma
95.01.34.2004|Ayoma
95.01.34.2005|Dlonggoki
95.01.34.2006|Tirunggu
95.01.34.2007|Dlinggama
95.01.35.2001|Welesi
95.01.35.2002|Yagara
95.01.35.2003|Asojelipele
95.01.35.2004|Lantipo
95.01.35.2005|Pawekama
95.01.35.2006|Apenas
95.01.35.2007|Tulima
95.01.36.2001|Sogokmo
95.01.36.2002|Asotipo
95.01.36.2003|Putagaima
95.01.36.2004|Kuantapo
95.01.36.2005|Heberima
95.01.36.2006|Iwigima
95.01.36.2007|Pobiatma
95.01.36.2008|Hitigima
95.01.36.2009|Air Garam
95.01.36.2010|Hukulimo
95.01.37.2001|Maima
95.01.37.2002|Minimo
95.01.37.2003|Esiak
95.01.37.2004|Heraewa
95.01.37.2005|Kepi
95.01.37.2006|Husewa
95.01.37.2007|Menagaima
95.01.38.2001|Pupugoba
95.01.38.2002|Waima
95.01.38.2003|Yomote
95.01.38.2004|Yelelo
95.01.39.2001|Wame
95.01.39.2002|Dumapaga
95.01.39.2003|Yanenggame
95.01.39.2004|Dogoname
95.01.40.1001|Ilokama
95.01.40.2002|Kama
95.01.40.2003|Yaloaput
95.01.40.2004|Mawampi
95.01.40.2005|Parema
95.01.40.2006|Agamoa
95.01.40.2007|Silumarek
95.01.40.2008|Wesaganya
95.02.01.2001|Kabiding
95.02.01.2002|Aldom
95.02.01.2003|Kutdol
95.02.01.2004|Polsam
95.02.01.2005|Akmakot
95.02.01.2006|Mabilabol
95.02.01.2007|Bunamdol
95.02.01.2008|Molbib Silibib
95.02.02.2001|Oknanggul
95.02.02.2002|Kukihil
95.02.02.2003|Kiwi
95.02.02.2004|Berusaha
95.02.02.2005|Pelebib
95.02.02.2006|Sopamikma
95.02.02.2007|Asua
95.02.02.2008|Lolim
95.02.02.2009|Pomding
95.02.02.2010|Diip
95.02.02.2011|Delpem
95.02.02.2012|Mangoldoki
95.02.03.2001|Okbifisil
95.02.03.2002|Abmisibil
95.02.03.2003|Manunggal
95.02.03.2004|Iriding
95.02.03.2005|Atolbol
95.02.03.2006|Oktanglap
95.02.03.2007|Oksemar
95.02.03.2008|Okaplo
95.02.04.2001|Iwur
95.02.04.2002|Kurumklin
95.02.04.2003|Walapkubun
95.02.04.2004|Dinmot Arim
95.02.04.2005|Ewenkatop
95.02.04.2006|Ulkubi
95.02.04.2007|Dipol
95.02.04.2008|Nenginum
95.02.04.2009|Narnger
95.02.04.2010|Kamyoim
95.02.05.2001|Batom
95.02.05.2002|Oksip
95.02.05.2003|Mongham
95.02.05.2004|Sabi
95.02.05.2005|Neep
95.02.05.2006|Muara
95.02.05.2007|Batom Dua
95.02.05.2008|Akyako
95.02.05.2009|Peteng
95.02.05.2010|Belomo
95.02.05.2011|Abukerom
95.02.06.2001|Borme
95.02.06.2002|Omban
95.02.06.2003|Sikibur
95.02.06.2004|Onya
95.02.06.2005|Arina
95.02.06.2006|Bordamban
95.02.06.2007|Aringgon
95.02.06.2008|Bukam
95.02.06.2009|Kwime
95.02.06.2010|Kolgir
95.02.06.2011|Cangdamban
95.02.06.2012|Laydamban
95.02.06.2013|Seban
95.02.07.2001|Okyop
95.02.07.2002|Oketur
95.02.07.2003|Ehipten
95.02.07.2004|Wantem
95.02.07.2005|Dikdon
95.02.07.2006|Okyako
95.02.07.2007|Okyaop
95.02.07.2008|Tatam
95.02.07.2009|Okhik
95.02.08.2001|Aboy
95.02.08.2002|Luban
95.02.08.2003|Jubly
95.02.08.2004|Armise
95.02.08.2005|Woro
95.02.08.2006|Pipal
95.02.08.2007|Lulis Wii
95.02.09.2001|Pepera
95.02.09.2002|Okbon
95.02.09.2003|Yun Muku
95.02.09.2004|Denom
95.02.09.2005|Bon Yakwol
95.02.09.2006|Ok Telabe
95.02.09.2007|Wok Bakon
95.02.10.2001|Bime
95.02.10.2002|Bob
95.02.10.2003|Kameme
95.02.10.2004|Calab
95.02.10.2005|Limiri
95.02.10.2006|Teli
95.02.10.2007|Lim Lim
95.02.10.2008|Bunggon
95.02.10.2009|Perem
95.02.10.2010|Turwe
95.02.11.2001|Eraduman
95.02.11.2002|Alemsom
95.02.11.2003|Tapasik
95.02.11.2004|Payol Masumkon
95.02.11.2005|Tapob
95.02.11.2006|Bakwalin Yub
95.02.11.2007|Imiryi
95.02.11.2008|Sumtamon
95.02.11.2009|Bondik
95.02.11.2010|Muruman
95.02.11.2011|Binalkom
95.02.11.2012|Tibal
95.02.12.2001|Bape
95.02.12.2002|Masim
95.02.12.2003|Akmer
95.02.12.2004|Kasawi
95.02.12.2005|Tapasik Dua Bapenka
95.02.12.2006|Ibot
95.02.13.2001|Dabolding
95.02.13.2002|Kalomdol
95.02.13.2003|Tulo
95.02.13.2004|Arinkop
95.02.13.2005|Imik
95.02.14.2001|Oksop
95.02.14.2002|Mimin
95.02.14.2003|Atenor
95.02.14.2004|Oktumi
95.02.14.2005|Alutbakon
95.02.15.2001|Yapimakot
95.02.15.2002|Seramkatop
95.02.15.2003|Parim
95.02.15.2004|Siminbuk
95.02.15.2005|Modusit
95.02.15.2006|Wanbakon
95.02.15.2007|Yakmor
95.02.15.2008|Okatem
95.02.16.2001|Kungulding
95.02.16.2002|Bulangkop
95.02.16.2003|Limarum
95.02.16.2004|Yumakot
95.02.16.2005|Aplim
95.02.16.2006|Okdo
95.02.17.2001|Arintap
95.02.17.2002|Tarngop
95.02.17.2003|Kawor
95.02.17.2004|Sakup
95.02.17.2005|Umding
95.02.17.2006|Nanum
95.02.17.2007|Ater
95.02.18.2001|Awinbon
95.02.18.2002|Nanum Anaip
95.02.18.2003|Mikir
95.02.18.2004|Kawe
95.02.18.2005|Yelobib
95.02.19.2001|Tarup
95.02.19.2002|Marang Tiking
95.02.19.2003|Imsin
95.02.19.2004|Bitipding
95.02.19.2005|Onkor
95.02.19.2006|Beten Dua
95.02.19.2007|Omor
95.02.20.2001|Okelwel
95.02.20.2002|Kotyobakon
95.02.20.2003|Okteneng
95.02.20.2004|Tengnong
95.02.21.2001|Okma
95.02.21.2002|Oktae
95.02.21.2003|Tinibil
95.02.21.2004|Okdilam
95.02.21.2005|Autpahik
95.02.21.2006|Tomka
95.02.21.2007|Okpa
95.02.21.2008|Okhaka
95.02.21.2009|Honkuding
95.02.21.2010|Bomding
95.02.21.2011|Okdunam
95.02.21.2012|Paune
95.02.22.2001|Oklip
95.02.22.2002|Okhim
95.02.22.2003|Oktem
95.02.22.2004|Okbumul
95.02.22.2005|Okamin
95.02.22.2006|Oktumi
95.02.22.2007|Komok
95.02.23.2001|Oktau
95.02.23.2002|Oktaru
95.02.23.2003|Okbem
95.02.23.2004|Okngam
95.02.23.2005|Bemhimiku
95.02.23.2006|Bilip Bayo
95.02.23.2007|Atang Doki
95.02.23.2008|Okalut Kumal
95.02.23.2009|Kaep
95.02.24.2001|Kubiphkop
95.02.24.2002|Okano
95.02.24.2003|Sebul
95.02.24.2004|Mangabip
95.02.25.2001|Sabin
95.02.25.2002|Borban
95.02.25.2003|Kirimu
95.02.25.2004|Dumpasi
95.02.25.2005|Maksum
95.02.25.2006|Pedam
95.02.25.2007|Tupoplyom
95.02.25.2008|Yapil
95.02.25.2009|Atembabol
95.02.25.2010|Omliom
95.02.25.2011|Peneli
95.02.25.2012|Markom
95.02.26.2001|Karye
95.02.26.2002|Batani
95.02.26.2003|Segame
95.02.26.2004|Palur Satu
95.02.26.2005|Palur Dua
95.02.26.2006|Sople
95.02.26.2007|Bakata
95.02.27.2001|Merpasikne
95.02.27.2002|Taramlu
95.02.27.2003|Weime
95.02.27.2004|Meryang
95.02.27.2005|Limrepasikne
95.02.27.2006|Youlban
95.02.27.2007|Mekdamgon
95.02.27.2008|Daluban
95.02.27.2009|Nomteren
95.02.28.2001|Bias
95.02.28.2002|Bumi
95.02.28.2003|Tero
95.02.28.2004|Delemo
95.02.29.2001|Mot
95.02.29.2002|Milki
95.02.29.2003|Yubu
95.02.29.2004|Muara Asbi
95.02.29.2005|Tual
95.02.30.2001|Jetfa
95.02.30.2002|Lulis
95.02.30.2003|Tupalma Satu
95.02.30.2004|Tupalma Dua
95.02.30.2005|Kalimbu
95.02.30.2006|Bris
95.02.31.2001|Teiraplu
95.02.31.2002|Sinami
95.02.31.2003|Maigame
95.02.31.2004|Murme
95.02.31.2005|Yuaban Satu
95.02.31.2006|Yuaban Dua
95.02.31.2007|Terapdei
95.02.31.2008|Yitarget
95.02.31.2009|Teriame
95.02.31.2010|Bautme
95.02.32.2001|Eipumek
95.02.32.2002|Lalakon
95.02.32.2003|Londinin
95.02.32.2004|Talemu
95.02.32.2005|Wakidam
95.02.32.2006|Bunyirye
95.02.32.2007|Basiringe
95.02.32.2008|Barama
95.02.32.2009|Tanime
95.02.32.2010|Serabum
95.02.32.2011|Supleyu
95.02.32.2012|Kweredala
95.02.32.2013|Mungkona
95.02.32.2014|Malingdam
95.02.33.2001|Marikla
95.02.33.2002|Yabosorom
95.02.33.2003|Pamek
95.02.33.2004|Barice
95.02.33.2005|Imde
95.02.33.2006|Lumdakna
95.02.33.2007|Baramirye
95.02.33.2008|Mandalak
95.02.33.2009|Yokul
95.02.33.2010|Kalek
95.02.33.2011|Pinggon
95.02.34.2001|Nongme
95.02.34.2002|Rubol
95.02.34.2003|Yokom
95.02.34.2004|Yarigon
95.02.34.2005|Omtamur
95.02.34.2006|Cangpally
95.02.34.2007|Kwarban
95.03.01.1001|Obolma
95.03.01.2002|Ibiroma
95.03.01.2003|Hihundes
95.03.01.2004|Wanem
95.03.01.2005|Anjelma
95.03.01.2006|Pusuaga
95.03.01.2007|Wulik Punua
95.03.01.2008|Kilise
95.03.01.2009|Air Garam
95.03.01.2010|Esalien
95.03.01.2011|Lukulema
95.03.01.2012|Tukuarek
95.03.01.2013|Kima
95.03.01.2014|Yagarelo
95.03.01.2015|Soroh
95.03.01.2016|Eroma
95.03.01.2017|Lotia
95.03.01.2018|Wuluagaima
95.03.01.2019|Huken
95.03.01.2020|Huguma
95.03.01.2021|Parela
95.03.01.2023|Hesmat
95.03.02.2001|Yahulikma
95.03.02.2002|Lelambo
95.03.02.2003|Tulpa
95.03.02.2004|Ilwap
95.03.02.2005|Kiltam
95.03.02.2006|Pilong
95.03.02.2007|Vuno
95.03.02.2008|Suahi
95.03.02.2009|Tohong
95.03.02.2010|Paliptek
95.03.02.2011|Letin
95.03.02.2012|Hohe
95.03.03.2001|Ninia
95.03.03.2002|Liligan
95.03.03.2003|Niniahan
95.03.03.2004|Waerek
95.03.03.2005|Wahaik
95.03.03.2006|Sohwal
95.03.03.2007|Babet
95.03.03.2008|Kahul
95.03.03.2009|Hwealoma
95.03.03.2010|Liligan II
95.03.04.2001|Momnoak
95.03.04.2002|Silimo
95.03.04.2003|Eksa
95.03.04.2004|Siloma
95.03.04.2005|Asia
95.03.04.2006|Suet
95.03.04.2007|Walkruk
95.03.04.2008|Sodule
95.03.04.2009|Sagaduk
95.03.04.2010|Sianele
95.03.04.2011|Eremnahom
95.03.04.2012|Silon
95.03.04.2013|Nikilei
95.03.04.2014|Suok
95.03.04.2015|Fabe
95.03.04.2016|Weakma
95.03.04.2017|Pinda
95.03.04.2018|Hwesalemo
95.03.04.2019|Sebin
95.03.04.2020|Wubialo
95.03.05.2001|Samenage
95.03.05.2002|Haleroma
95.03.05.2003|Muke
95.03.05.2004|Pona
95.03.05.2005|Ison
95.03.05.2006|Asotapo
95.03.05.2007|Hirin
95.03.05.2008|Notnarek
95.03.05.2009|Hugi Lokon
95.03.06.2001|Nalca
95.03.06.2002|Cenderawasih
95.03.06.2003|Manggona
95.03.06.2004|Bolda
95.03.06.2005|Emm
95.03.06.2006|Imsekla
95.03.06.2007|Hein
95.03.06.2008|Luwemna
95.03.07.2001|Dekai
95.03.07.2002|Kuaserama
95.03.07.2003|Moruku
95.03.07.2004|Massi
95.03.07.2005|Keikey
95.03.07.2006|Kuari
95.03.07.2007|Muara
95.03.07.2008|Kiribun
95.03.07.2009|Kokamu
95.03.07.2010|Tomon I
95.03.07.2011|Sokamu
95.03.07.2012|Tomon II
95.03.08.2001|Munu
95.03.08.2002|Obio
95.03.08.2003|Pugun
95.03.08.2004|Ujin
95.03.08.2005|Yahufa
95.03.08.2006|Jibak
95.03.08.2007|Patin
95.03.08.2008|Hom hom
95.03.08.2009|Wendame
95.03.08.2010|Kwakenoro
95.03.08.2011|Busupa
95.03.08.2012|Yagebo
95.03.08.2013|Penigik
95.03.09.2001|Gopa
95.03.09.2002|Jinusugu
95.03.09.2003|Woropi
95.03.09.2004|Senipan
95.03.09.2005|Yosua
95.03.09.2006|Rentis
95.03.09.2007|Solok
95.03.10.2001|Apdagma
95.03.10.2002|Sabin
95.03.10.2003|Mugi
95.03.10.2004|Harap
95.03.10.2005|Suok
95.03.10.2006|Mul
95.03.10.2007|Kolodoma
95.03.10.2008|Sangatur
95.03.10.2009|Sowaling
95.03.10.2010|Yerekama
95.03.10.2011|Walkuma
95.03.11.2001|Amuma
95.03.11.2002|Sarmuge
95.03.11.2003|Tolikapura
95.03.11.2004|Wisikma
95.03.11.2005|Silorin
95.03.11.2006|Waeklek
95.03.11.2007|Balum Erang
95.03.11.2008|Golowen
95.03.11.2009|Orugai
95.03.11.2010|Plau
95.03.11.2011|Sagasal
95.03.11.2012|Kinika
95.03.11.2013|Harapan
95.03.12.2001|Usaregeik
95.03.12.2002|Lidipmu
95.03.12.2003|Sumegen
95.03.12.2004|Hendikma
95.03.12.2005|Bue
95.03.12.2006|Haletuk
95.03.12.2007|Dekbok
95.03.12.2008|Yeriko
95.03.12.2009|Weleheikma
95.03.12.2010|Esaikma
95.03.13.2001|Pasema
95.03.13.2002|Leinoko
95.03.13.2003|Lowet
95.03.13.2004|Wea
95.03.13.2005|Sengangge
95.03.13.2006|Wulin
95.03.13.2007|Pupi
95.03.14.2001|Paima
95.03.14.2002|Dugumhad
95.03.14.2003|Leleak
95.03.14.2004|Subsal
95.03.14.2005|Sengsenagaik
95.03.14.2006|Sipnidipmu
95.03.14.2007|Hogio I
95.03.14.2008|Hogio II
95.03.15.2001|Kosihun
95.03.15.2002|Seima
95.03.15.2003|Userem
95.03.15.2004|Yuarima
95.03.15.2005|Ugem
95.03.15.2006|Wusagasem
95.03.15.2007|Hunenima
95.03.15.2008|Itlay Wopi
95.03.15.2009|Togoluk
95.03.15.2010|Herawe
95.03.15.2011|Hendang
95.03.15.2012|Ilokomo
95.03.15.2013|Hulesi
95.03.15.2014|Wanesi
95.03.15.2015|Panyoke
95.03.15.2016|Nyikinen
95.03.15.2017|Wesangma
95.03.15.2018|Olomising
95.03.15.2019|Wemasili
95.03.15.2020|Lugulmu
95.03.16.2001|Soba
95.03.16.2002|Hepinis
95.03.16.2003|Aguluntipmu
95.03.16.2004|Nilen
95.03.16.2005|Surukmu
95.03.16.2006|Tanda
95.03.17.2001|Lokon
95.03.17.2002|Luarima
95.03.17.2003|Werima
95.03.17.2004|Hanoasuok
95.03.17.2005|Wesagalep
95.03.17.2006|Wesama
95.03.17.2007|Weasi
95.03.17.2008|Weriaput
95.03.17.2009|Suesi
95.03.17.2010|Nesuwen
95.03.17.2011|Esema Husage
95.03.17.2012|Libuk
95.03.17.2013|Hagawen
95.03.17.2014|Hepia
95.03.18.2001|Tangma
95.03.18.2002|Wamarek
95.03.18.2003|Hipela
95.03.18.2004|Huewi
95.03.18.2005|Punno
95.03.18.2006|Simeka
95.03.18.2007|Yeleas
95.03.18.2008|Aleleng
95.03.18.2009|Yalimo
95.03.18.2010|Helo
95.03.19.2001|Ukha
95.03.19.2002|Kuleken
95.03.19.2003|Amisangi
95.03.19.2004|Wenapuk
95.03.19.2005|Eki
95.03.19.2006|Yelepunu
95.03.19.2007|Siolorema
95.03.19.2008|Musanarek
95.03.19.2009|Walialema
95.03.19.2010|Lua
95.03.19.2022|Wakunyama
95.03.20.2001|Pontenikma
95.03.20.2002|Kuni
95.03.20.2003|Panggema
95.03.20.2004|Homtonggo
95.03.20.2005|Tukam
95.03.20.2006|Kemumanggen
95.03.20.2007|Yangkali
95.03.20.2008|Weresili
95.03.20.2009|Susek
95.03.20.2010|Kolu
95.03.20.2011|Tonggoi
95.03.20.2012|Bineluk
95.03.20.2013|Masahan
95.03.21.2001|Kosarek
95.03.21.2002|Nahomas
95.03.21.2003|Silkom
95.03.21.2004|Wahe
95.03.21.2005|Hombuka
95.03.21.2006|Mine
95.03.21.2007|Uldam
95.03.21.2008|Tiple
95.03.21.2009|Wesaltek
95.03.21.2010|Konosa
95.03.21.2011|Illion
95.03.22.2001|Nipsan
95.03.22.2002|Tapla
95.03.22.2003|Walmak
95.03.22.2004|Serengon
95.03.22.2005|Ikmu
95.03.22.2006|Biu
95.03.22.2007|Ilukdamon
95.03.22.2008|Yalmun
95.03.23.2001|Ubahak
95.03.23.2002|Saruk
95.03.23.2003|Pini
95.03.23.2004|Sosomikma
95.03.23.2005|Suhuntek
95.03.23.2006|Keleng
95.03.23.2007|Silong
95.03.23.2008|Nurap
95.03.23.2009|Wamuhuk
95.03.23.2010|Welile
95.03.23.2011|Mabien
95.03.23.2012|Kibianggen
95.03.23.2013|Koluang
95.03.23.2014|Tolombing
95.03.23.2015|Furuluk
95.03.23.2016|Oblin
95.03.23.2017|Bisifak
95.03.24.2001|Siwikma
95.03.24.2002|Pontenpilik
95.03.24.2003|Piliam
95.03.24.2004|Hiklahin
95.03.24.2005|Helapilik
95.03.24.2006|Lirutek
95.03.24.2007|Huhulpunu
95.03.24.2008|Pronggoli
95.03.25.2001|Walma
95.03.25.2002|Solinggul
95.03.25.2003|Hontulun
95.03.25.2004|Honggolek
95.03.25.2005|Werene
95.03.25.2006|Weri
95.03.25.2007|Wewasi
95.03.25.2008|Yetehup
95.03.26.2001|Subundalek
95.03.26.2002|Tanggeam
95.03.26.2003|Amfulma
95.03.26.2004|Suksale
95.03.26.2005|Linggisen
95.03.27.2001|Hereapini
95.03.27.2002|Pelentum
95.03.27.2003|Homboki
95.03.27.2004|Menetsing
95.03.27.2005|Pue
95.03.27.2006|Kabukal
95.03.27.2007|Kinkun
95.03.27.2008|Hoet
95.03.27.2009|Muhumu
95.03.27.2010|Ohena
95.03.27.2011|Nelisa
95.03.28.2001|Wanam
95.03.28.2002|Hereky
95.03.28.2003|Membaham
95.03.28.2004|Wisomi
95.03.28.2005|Talambela
95.03.28.2006|Sehelu
95.03.28.2007|Ubalihion
95.03.28.2008|Walahan
95.03.28.2009|Salakma
95.03.28.2010|Samiyul
95.03.28.2011|Letfet
95.03.29.2001|Talambo
95.03.29.2002|Tibul
95.03.29.2003|Kikila
95.03.29.2004|Palukae
95.03.29.2005|Wubri
95.03.29.2006|Bari
95.03.29.2007|Lulum
95.03.29.2008|Paleromon
95.03.29.2009|Lelambo 2
95.03.30.2001|Puldama
95.03.30.2002|Kasen
95.03.30.2003|Bako
95.03.30.2004|Balsek
95.03.30.2005|Manbolak
95.03.30.2006|Famek
95.03.30.2007|Semlu
95.03.30.2008|Baru
95.03.31.2001|Endomen
95.03.31.2002|Okloma
95.03.31.2003|Delon
95.03.31.2004|Suron
95.03.31.2005|Sentul
95.03.31.2006|Gidomen
95.03.31.2007|Galsin
95.03.31.2008|Kouwet
95.03.32.2001|Kona
95.03.32.2002|Kalpok
95.03.32.2003|Seklak
95.03.32.2004|Wetmuk
95.03.32.2005|Kugun
95.03.33.2001|Dirwemna
95.03.33.2002|Aksal
95.03.33.2003|Dolsen
95.03.33.2004|Salengkomo
95.03.33.2005|Silion
95.03.34.2001|Holuwon
95.03.34.2002|Danggema
95.03.34.2003|Weni
95.03.34.2004|Sosi
95.03.34.2005|Sia
95.03.34.2006|Bineleruk
95.03.34.2007|Sohonggik
95.03.35.2001|Wanim
95.03.35.2002|Lolat
95.03.35.2003|Bunde
95.03.35.2004|Serahak
95.03.35.2005|Webile
95.03.35.2006|Dinggila
95.03.35.2007|Esalek
95.03.35.2008|Denema
95.03.36.2001|Weawen
95.03.36.2002|Kwelena
95.03.36.2003|Singokla
95.03.36.2004|Banga
95.03.36.2005|Soline
95.03.36.2006|Musan
95.03.36.2007|Salbi
95.03.36.2008|Erim
95.03.37.2001|Sela
95.03.37.2002|Megom
95.03.37.2003|Mondon
95.03.37.2004|Horoman
95.03.37.2005|Makero
95.03.37.2006|Orisin
95.03.37.2007|Monamna
95.03.37.2008|Ejub
95.03.37.2009|Dolbol
95.03.37.2010|Hemuka
95.03.37.2011|Phoy
95.03.37.2012|Sulda
95.03.37.2013|Mekdua
95.03.37.2014|Bera
95.03.37.2015|Holdomen
95.03.37.2016|Asok
95.03.38.2001|Korupun
95.03.38.2002|Dagi
95.03.38.2003|Wemin
95.03.38.2004|Morome
95.03.38.2005|Moo
95.03.38.2006|Batkuk
95.03.38.2007|Maldua
95.03.38.2008|Amdua
95.03.38.2009|Somsek
95.03.38.2010|Basal
95.03.38.2011|Yamdua
95.03.38.2012|Dildau
95.03.39.2001|Langda
95.03.39.2002|Alirji
95.03.39.2003|Laryi
95.03.39.2004|Wasumurji
95.03.39.2005|Kirabuk
95.03.39.2006|Kap-kap
95.03.39.2007|Yalar
95.03.39.2008|Bebekle
95.03.39.2009|Lukun
95.03.40.2001|Bomela
95.03.40.2002|Yalmabi
95.03.40.2003|Kitikni
95.03.40.2004|Sombat
95.03.40.2005|Kubialat
95.03.40.2006|Palamdua
95.03.41.2001|Suntamon
95.03.41.2002|Tapasik
95.03.41.2003|Bulbul
95.03.41.2004|Dirik
95.03.41.2005|Yup
95.03.41.2006|Bongkok
95.03.41.2007|Masumkon
95.03.41.2008|Binalkon
95.03.42.2001|Seradala
95.03.42.2002|Moruf
95.03.42.2003|Koper
95.03.42.2004|Teret
95.03.42.2005|Tokuni
95.03.42.2006|Burupmakot
95.03.42.2007|Yasip
95.03.42.2008|Masomduba
95.03.42.2009|Samboga
95.03.43.2001|Yalisomon
95.03.43.2002|Yabi
95.03.43.2003|Sobaham
95.03.43.2004|Balinggama
95.03.43.2005|Dohong
95.03.43.2006|Hamik
95.03.43.2007|Kulahaik
95.03.43.2008|Simbuk
95.03.43.2009|Puahun
95.03.43.2010|Silak Pahabol
95.03.43.2011|Sele
95.03.43.2012|Benembia
95.03.43.2013|Hubik
95.03.44.2001|Kabianggama
95.03.44.2002|Sohobma
95.03.44.2003|Sohal
95.03.44.2004|Bahabolma
95.03.44.2005|Subayo
95.03.44.2006|Buahun
95.03.44.2007|Domul
95.03.45.2001|Debula
95.03.45.2002|Kwelamdua
95.03.45.2003|Kubuk dua
95.03.45.2004|Senayom
95.03.45.2005|Sesepne
95.03.45.2006|Baluk
95.03.45.2007|Kemligin
95.03.45.2008|Obis
95.03.45.2009|Yalidomon
95.03.45.2010|Kabulan
95.03.46.2001|Silakma
95.03.46.2002|Somarin
95.03.46.2003|Kenkeni
95.03.46.2004|Monin
95.03.46.2005|Enggelasue
95.03.46.2006|Oakbisik
95.03.46.2007|Momenggama
95.03.46.2008|Husmo
95.03.46.2009|Karelma
95.03.46.2010|Usabini
95.03.47.2001|Hilipuk
95.03.47.2002|Homidipmu
95.03.47.2003|Kini
95.03.47.2004|Yaruhuk
95.03.47.2005|Jamin
95.03.47.2006|Dindok
95.03.47.2007|Sohondipmu
95.03.48.2001|Duram
95.03.48.2002|Yeminikma
95.03.48.2003|Goak
95.03.48.2004|Digitme
95.03.48.2005|Dengat
95.03.48.2006|Niniwi
95.03.49.2001|Yogosem
95.03.49.2002|Kiroma
95.03.49.2003|Sogasio
95.03.49.2004|Saikama
95.03.49.2005|Hokolekma
95.03.49.2006|Esahapuk
95.03.49.2007|Mesahaput
95.03.50.2001|Kayo
95.03.50.2002|Molama
95.03.50.2003|Sebu
95.03.50.2004|Walet
95.03.50.2005|Hombesaloma
95.03.50.2006|Alhai
95.03.50.2007|Uase
95.03.51.2001|Sumo
95.03.51.2002|Uam
95.03.51.2003|Maku
95.03.51.2004|Obokain
95.03.51.2005|Jibuk
95.03.51.2006|Wenapong
95.03.51.2007|Muara Balim
95.03.51.2008|Hunisi
95.03.51.2009|Boor
95.03.51.2010|Wirilu
95.03.51.2011|Kwiriside
95.04.01.1001|Karubaga
95.04.01.2002|Kogimagi
95.04.01.2003|Muara
95.04.01.2004|Ampera
95.04.01.2005|Elsadai
95.04.01.2006|Ebenhaiser
95.04.01.2007|Kolilan
95.04.01.2008|Kuloname
95.04.01.2009|Lirak
95.04.01.2010|Kimobur
95.04.01.2011|Kuragepura
95.04.01.2012|Kiranage
95.04.01.2013|Luwik
95.04.01.2014|Gininggadonak
95.04.01.2015|Danggulurik
95.04.01.2016|Gurikme
95.04.01.2017|Molera
95.04.01.2018|Nalorini
95.04.01.2019|Beleme
95.04.01.2020|Gurikagewa
95.04.01.2021|Pulanggun
95.04.01.2022|Yalikaluk
95.04.01.2023|Losmen
95.04.02.1001|Bokondini
95.04.02.2002|Mairini
95.04.02.2003|Apiam
95.04.02.2004|Umaga
95.04.02.2005|Galala
95.04.02.2006|Mingganggo
95.04.02.2007|Tenggagama
95.04.02.2008|Kologume
95.04.02.2009|Lambogo
95.04.02.2010|Jawalane
95.04.02.2011|Dunduma
95.04.03.1001|Kanggime
95.04.03.2002|Marlo
95.04.03.2003|Logon
95.04.03.2004|Aulani
95.04.03.2005|Ligiibak
95.04.03.2006|Kerena
95.04.03.2007|Purugi
95.04.03.2008|Lawor
95.04.03.2009|Kagimaluk
95.04.03.2010|Dundu
95.04.04.1001|Kembu
95.04.04.2002|Mamit
95.04.04.2003|Yowo
95.04.04.2004|Nugari
95.04.04.2005|Kobon
95.04.04.2006|Kabori
95.04.04.2007|Genani
95.04.04.2008|Wulinaga
95.04.04.2009|Aworera
95.04.04.2010|Agimdek
95.04.04.2011|Tioga
95.04.05.2001|Goyage
95.04.05.2002|Yemarima
95.04.05.2003|Tigikun
95.04.05.2004|Dugi
95.04.05.2005|Doge
95.04.05.2006|Benari
95.04.05.2007|Wijamurik
95.04.05.2008|Woji
95.04.05.2009|Mampulaga
95.04.05.2010|Tidur Mabuk
95.04.05.2011|Bini
95.04.05.2012|Didelonik
95.04.05.2013|Kumbu
95.04.05.2014|Peko
95.04.05.2015|Tiri
95.04.05.2016|Tigir
95.04.05.2017|Bopa
95.04.05.2018|Angkasa
95.04.05.2019|Gilok
95.04.06.2001|Wurineri
95.04.06.2002|Pokegi
95.04.06.2003|Arombok
95.04.06.2004|Enanagi
95.04.06.2005|Pindak
95.04.06.2006|Gilopaga
95.04.06.2007|Keribaga
95.04.06.2008|Wona
95.04.06.2009|Numbuboton
95.04.07.2001|Wina
95.04.07.2002|Gualo
95.04.07.2003|Bimbogul
95.04.07.2004|Yugumengga
95.04.07.2005|Wariru
95.04.07.2006|Yugubuk
95.04.07.2007|Akima
95.04.07.2008|Malela
95.04.07.2009|Nakwil
95.04.07.2010|Finai
95.04.07.2011|Holandia
95.04.07.2012|Tawi
95.04.07.2013|Yogweme
95.04.08.2001|Umagi
95.04.08.2002|Yali
95.04.08.2003|Nambu
95.04.08.2004|Nolopur
95.04.08.2005|Yaleme
95.04.08.2006|Gatini
95.04.08.2007|Mino
95.04.08.2008|Gurin
95.04.08.2009|Piriluk
95.04.08.2010|Pagongga
95.04.08.2011|Warna
95.04.08.2012|Popaga
95.04.09.2001|Panaga
95.04.09.2002|Ibunuh
95.04.09.2003|Saksi Maler
95.04.09.2004|Kutiom
95.04.09.2005|Eragani
95.04.09.2006|Pindanggun
95.04.09.2007|Siak
95.04.09.2008|Yandono
95.04.09.2009|Paido
95.04.10.2001|Lugwi
95.04.10.2002|Yaliwak
95.04.10.2003|Teropme
95.04.10.2004|Yigonime
95.04.10.2005|Mome
95.04.10.2006|Bugum
95.04.10.2007|Pagona
95.04.10.2008|Wunabu
95.04.10.2009|Wilileme
95.04.10.2010|Yangguni
95.04.11.2001|Aruku
95.04.11.2002|Kubugiwa
95.04.11.2003|Kubu
95.04.11.2004|Numbugawe
95.04.11.2005|Tiyenggupur
95.04.11.2006|Murik
95.04.11.2007|Minagi
95.04.11.2008|Kalewi
95.04.11.2009|Menggenagi
95.04.12.2001|Konda
95.04.12.2002|Arulo
95.04.12.2003|Mandura
95.04.12.2004|Mowilome
95.04.12.2005|Arumagi
95.04.12.2006|Gimo
95.04.12.2007|Silabulo
95.04.12.2008|Arikoba
95.04.12.2009|Tingapura
95.04.12.2010|Ganage
95.04.12.2011|Yawineri
95.04.13.2001|Mondagul
95.04.13.2002|Timojimo
95.04.13.2003|Tabowanimbo
95.04.13.2004|Nelawi
95.04.13.2005|Woromolome
95.04.13.2006|Kendemaya
95.04.13.2007|Palagi
95.04.13.2008|Megapura
95.04.13.2009|Wabuna
95.04.13.2010|Minagame
95.04.13.2011|Barename/Luanggi
95.04.13.2012|Yilogonime/Tabinabo
95.04.14.2001|Kuari
95.04.14.2002|Menggeba
95.04.14.2003|Alopur
95.04.14.2004|Kenen
95.04.14.2005|Wanggugup
95.04.14.2006|Baliminggi
95.04.14.2007|Abepur
95.04.14.2008|Markar
95.04.14.2009|Luanggi
95.04.14.2010|Kondegun
95.04.14.2011|Jinulira
95.04.14.2012|Kibur
95.04.14.2013|Tebenalo
95.04.14.2014|Umaga
95.04.14.2015|Kurik
95.04.14.2016|Menggenagame
95.04.14.2017|Gubagi
95.04.15.2001|Bokoneri
95.04.15.2002|Donggem
95.04.15.2003|Abimbak
95.04.15.2004|Munagame
95.04.15.2005|Kanewunuk
95.04.15.2006|Nanggurilime
95.04.15.2007|Kurewunuk
95.04.15.2008|Durima
95.04.15.2009|Lerewere
95.04.15.2010|Bolly
95.04.15.2011|Omuk
95.04.15.2012|Wonaga
95.04.15.2013|Waringga
95.04.15.2014|Tanabume
95.04.15.2015|Kanere
95.04.15.2016|Nunggalo
95.04.15.2017|Weri
95.04.16.2001|Abena
95.04.16.2002|Nogobumbu
95.04.16.2003|Bilubaga
95.04.16.2004|Gabunggobak
95.04.16.2005|Wulurik
95.04.16.2006|Wanggulam
95.04.16.2007|Bitillabur
95.04.16.2008|Windik
95.04.16.2009|Yibalo
95.04.16.2010|Wania
95.04.16.2011|Arelam
95.04.16.2012|Gelalo
95.04.16.2013|Duma
95.04.16.2014|Yinama
95.04.17.2001|Nabunage
95.04.17.2002|Kupara
95.04.17.2003|Kutime
95.04.17.2004|Kumbo
95.04.17.2005|Timbindelo
95.04.17.2006|Jekito
95.04.17.2007|Wewo
95.04.17.2008|Geningga
95.04.17.2009|Kimilo
95.04.17.2010|Missa
95.04.17.2011|Logilome
95.04.18.2001|Tinggom
95.04.18.2002|Egoni
95.04.18.2003|Martelo
95.04.18.2004|Lerewere
95.04.18.2005|Yakep
95.04.18.2006|Welesi
95.04.18.2007|Orelukban
95.04.18.2008|Baguni
95.04.18.2009|Kulutin
95.04.18.2010|Yamulo
95.04.19.2001|Nunggawi
95.04.19.2002|Kokondao
95.04.19.2003|Belep
95.04.19.2004|Kuripaga
95.04.19.2005|Kimobur
95.04.19.2006|Wondame
95.04.19.2007|Kilungga
95.04.19.2008|Nombori
95.04.19.2009|Delelah
95.04.19.2010|Gilo
95.04.19.2011|Undi
95.04.19.2012|Derek
95.04.19.2013|Numbe
95.04.19.2014|Kanggineri
95.04.19.2015|Wonoluk
95.04.19.2016|Barenggo
95.04.19.2017|Tunibur
95.04.19.2018|Woyi
95.04.19.2019|Kubalo
95.04.19.2020|Tinoweno
95.04.19.2021|Mololowa
95.04.19.2022|Kunipaga
95.04.19.2023|Kabumanggen
95.04.19.2024|Kondangwi
95.04.19.2025|Kipino
95.04.19.2026|Tomobur
95.04.20.2001|Wamolo
95.04.20.2002|Woraga
95.04.20.2003|Kalarin
95.04.20.2004|Gubuk
95.04.20.2005|Umar
95.04.20.2006|Wobe
95.04.20.2007|Gingga
95.04.20.2008|Punggelak
95.04.20.2009|Kurik
95.04.20.2010|Gumbini
95.04.20.2011|Muruneri
95.04.20.2012|Nangga
95.04.20.2013|Enggawogo
95.04.20.2014|Wamili
95.04.20.2015|Oker
95.04.20.2016|Winengga
95.04.20.2017|Aworera
95.04.21.2001|Numba
95.04.21.2002|Baliminggi
95.04.21.2003|Kuma
95.04.21.2004|Yugumena
95.04.21.2005|Yalogo
95.04.21.2006|Yiragame
95.04.21.2007|Tingwineri
95.04.21.2008|Guniki
95.04.21.2009|Keragigelok
95.04.21.2010|Jinuwanu
95.04.22.2001|Bolubur
95.04.22.2002|Geneluk
95.04.22.2003|Tirib
95.04.22.2004|Beremo
95.04.22.2005|Pirage
95.04.22.2006|Koinggambu
95.04.22.2007|Liwina
95.04.22.2008|Eragani
95.04.22.2009|Luki
95.04.22.2010|Tioner
95.04.22.2011|Logulo
95.04.22.2012|Bawi
95.04.23.2001|Dundu
95.04.23.2002|Nugini
95.04.23.2003|Kembu
95.04.23.2004|Kurupu
95.04.23.2005|Yiku
95.04.23.2006|Bimo
95.04.23.2007|Dugunagep
95.04.23.2008|Nilogabu
95.04.23.2009|Nakwi
95.04.23.2010|Nini
95.04.24.2001|Geya
95.04.24.2002|Alobaga
95.04.24.2003|Timori
95.04.24.2004|Nawu
95.04.24.2005|Tinagoga
95.04.24.2006|Witipur
95.04.24.2007|Jelepele
95.04.24.2008|Winalo
95.04.24.2009|Kibu
95.04.24.2010|Wunggilipur
95.04.24.2011|Weyambi
95.04.24.2012|Dimbara
95.04.25.2001|Egiam
95.04.25.2002|Yonira
95.04.25.2003|Tabonakme
95.04.25.2004|Murni
95.04.25.2005|Yoka
95.04.25.2006|Wayongga
95.04.25.2007|Weri
95.04.25.2008|Pinde
95.04.25.2009|Kurba
95.04.25.2010|Kaliundi
95.04.26.2001|Gagulineri
95.04.26.2002|Telekonok
95.04.26.2003|Kuoklanggunik
95.04.26.2004|Bogokila
95.04.26.2005|Mabuk
95.04.26.2006|Nogari
95.04.26.2007|Genage
95.04.26.2008|Tigir
95.04.26.2009|Gindugunik
95.04.26.2010|Konengga
95.04.27.2001|Berembanak
95.04.27.2002|Habag
95.04.27.2003|Kekoli
95.04.27.2004|Kamboniki
95.04.27.2005|Kaloniki
95.04.27.2006|Tari
95.04.27.2007|Marbuna
95.04.27.2008|Malta
95.04.28.2001|Onggokme
95.04.28.2002|Kubur
95.04.28.2003|Weu
95.04.28.2004|Liwese
95.04.28.2005|Wenduri
95.04.28.2006|Tabo Wanimbo
95.04.28.2007|Lenggup
95.04.28.2008|Tinger
95.04.29.2001|Yanora
95.04.29.2002|Wari/Taiyeve
95.04.29.2003|Papedari
95.04.29.2004|Dotori
95.04.29.2005|Arebe/Ninggame
95.04.29.2006|Kowari
95.04.29.2007|Wiki
95.04.29.2008|Kuruku
95.04.29.2009|Friji
95.04.29.2010|Dorera
95.04.29.2011|Dustra/Yamiriko
95.04.29.2012|Muna
95.04.29.2013|Kalibu
95.04.29.2014|Laniloma
95.04.29.2015|Wakumendek
95.04.29.2016|Timoga/Kabupaga
95.04.29.2017|Beleise
95.04.30.2001|Dow/Bijere
95.04.30.2002|Takri
95.04.30.2003|Prawa
95.04.30.2004|Sigou
95.04.30.2005|Dagari
95.04.30.2006|Warka
95.04.30.2007|Pakare
95.04.30.2008|Tigu
95.04.30.2009|Bire
95.04.30.2010|Itoli
95.04.30.2011|Vokuyo
95.04.31.2001|Silo
95.04.31.2002|Logi
95.04.31.2003|Tagi
95.04.31.2004|Bini
95.04.31.2005|Dunda
95.04.31.2006|Getiem
95.04.31.2007|Rumbepaga
95.04.31.2008|Yimabnime
95.04.31.2009|Wanuk
95.04.31.2010|Lamaluk
95.04.32.2001|Yuneri
95.04.32.2002|Yido
95.04.32.2003|Omibur
95.04.32.2004|Tenabaga
95.04.32.2005|Wonabunggame
95.04.32.2006|Gembileme
95.04.32.2007|Wenome
95.04.32.2008|Mopi
95.04.32.2009|Kanggilo
95.04.32.2010|Yudimba
95.04.32.2011|Umar
95.04.33.2001|Wama
95.04.33.2002|Wonitu
95.04.33.2003|Kumbur
95.04.33.2004|Kwarini
95.04.33.2005|Weyage
95.04.33.2006|Timer
95.04.33.2007|Gulak
95.04.33.2008|Nowo
95.04.33.2009|Gunalo
95.04.33.2010|Korlo
95.04.33.2011|Towolome
95.04.33.2012|Golena
95.04.34.2001|Geka
95.04.34.2002|Kwa
95.04.34.2003|Gelok
95.04.34.2004|Makido
95.04.34.2005|Yinuwanu
95.04.34.2006|Wanuwi
95.04.34.2007|Dimbara
95.04.34.2008|Wenigi
95.04.34.2009|Membramonggen
95.04.34.2010|Tabunakme
95.04.35.2001|Telenggeme
95.04.35.2002|Aukuni
95.04.35.2003|Tenek
95.04.35.2004|Kimunuk
95.04.35.2005|Kimugu
95.04.35.2006|Yagagobak
95.04.35.2007|Linggira
95.04.35.2008|Wekaru
95.04.35.2009|Dolunggun
95.04.35.2010|Kagi
95.04.36.2001|Anawi
95.04.36.2002|Yalipura
95.04.36.2003|Kotori
95.04.36.2004|Bieleme
95.04.36.2005|Yalokobak
95.04.36.2006|Linggira
95.04.36.2007|Aridunda
95.04.36.2008|Loguk
95.04.36.2009|Imurik
95.04.36.2010|Gineri
95.04.37.2001|Banggeri
95.04.37.2002|Igari
95.04.37.2003|Tina
95.04.37.2004|Telelomi
95.04.37.2005|Kopenawai
95.04.37.2006|Wunggi
95.04.37.2007|Baganagapur
95.04.37.2008|Milineri
95.04.37.2009|Mili
95.04.37.2010|Geyaneri
95.04.38.2001|Wugi
95.04.38.2002|Loma
95.04.38.2003|Gitar
95.04.38.2004|Gilime
95.04.38.2005|Lena
95.04.38.2006|Timoneri
95.04.38.2007|Kuagembur
95.04.38.2008|Wuronggi
95.04.38.2009|Buangludah
95.04.38.2010|Pindelo
95.04.38.2011|Koli
95.04.39.2001|Wania
95.04.39.2002|Milipaa
95.04.39.2003|Tarawi
95.04.39.2004|Niagale
95.04.39.2005|Bumbu
95.04.39.2006|Ambena
95.04.39.2007|Gunombo
95.04.39.2008|Mawi
95.04.39.2009|Ripa
95.04.39.2010|Delegari
95.04.40.2001|Peyola
95.04.40.2002|Kogotime
95.04.40.2003|Gabunam
95.04.40.2004|Gulak
95.04.40.2005|Melaga
95.04.40.2006|Ekoni
95.04.40.2007|Minggen
95.04.40.2008|Kandimbaga
95.04.40.2009|Kinebe
95.04.40.2010|Belela
95.04.41.2001|Kaiga
95.04.41.2002|Bawi
95.04.41.2003|Tina
95.04.41.2004|Kurbaya
95.04.41.2005|Wiyangger
95.04.41.2006|Again
95.04.41.2007|Piraleme
95.04.41.2008|Tunggunale
95.04.41.2009|Kotorambur
95.04.41.2010|Wolu
95.04.42.2001|Wuluk
95.04.42.2002|Wenggun
95.04.42.2003|Posman
95.04.42.2004|Tiyonggi
95.04.42.2005|Yelly
95.04.42.2006|Agin
95.04.42.2007|Kogagi
95.04.42.2008|Yebena
95.04.42.2009|Wamigi
95.04.42.2010|Kolanggun
95.04.43.2001|Bogonuk
95.04.43.2002|Wisman
95.04.43.2003|Paba
95.04.43.2004|Ewan
95.04.43.2005|Wumelak
95.04.43.2006|Walelo
95.04.43.2007|Laura
95.04.43.2008|Talinamber
95.04.43.2009|Aliduda
95.04.43.2010|Andomak
95.04.44.2001|Wiyaluk
95.04.44.2002|Aburage
95.04.44.2003|Kogoyapura
95.04.44.2004|Erimbur
95.04.44.2005|Leragawi/Megagirakusk
95.04.44.2006|Longgoboma
95.04.44.2007|Tingwi
95.04.44.2008|Gubura
95.04.44.2009|Lubuk
95.04.44.2010|Bogome
95.04.45.2001|Biuk
95.04.45.2002|Guburini
95.04.45.2003|Yiluk/Kondenggun
95.04.45.2004|Yugu Mabur
95.04.45.2005|Tomagipura
95.04.45.2006|Yiyogobak/Kibur
95.04.45.2007|Galubup
95.04.45.2008|Mbinime/Jinulira
95.04.45.2009|Wonabu
95.04.45.2010|Tomagi/Gubagi
95.04.45.2011|Purugi
95.04.46.2001|Pekaleme
95.04.46.2002|Teleme
95.04.46.2003|Giko
95.04.46.2004|Kungge
95.04.46.2005|Kotorambur
95.04.46.2006|Miyanagame
95.04.46.2007|Karu
95.04.46.2008|Tabuh
95.04.46.2009|Gwak Dugunik
95.04.46.2010|Minegimen
95.04.46.2011|Ambirik
95.05.01.2001|Kobakma
95.05.01.2002|Ninugagas
95.05.01.2003|Seralema
95.05.01.2004|Gimbis
95.05.01.2005|Boroges
95.05.01.2006|Aunduang
95.05.01.2007|Luarima
95.05.01.2008|Guawage
95.05.01.2009|Moga
95.05.01.2010|Keniwa
95.05.01.2011|Sembegulik
95.05.01.2012|Dogle
95.05.01.2013|Wiyugobak
95.05.01.2014|Baliklabuk
95.05.01.2015|Yagalim
95.05.02.2001|Kelila
95.05.02.2002|Dibunggen
95.05.02.2003|Timeria
95.05.02.2004|Uganda
95.05.02.2005|Dogobak
95.05.02.2006|Yalenggolo
95.05.02.2007|Binime
95.05.02.2008|Tikapura
95.05.02.2009|Onggobalo
95.05.02.2010|Kambo
95.05.02.2011|Kindok
95.05.02.2012|Tari
95.05.02.2013|Gelora
95.05.02.2014|Yagabur
95.05.02.2015|Pelanme
95.05.02.2016|Tonggrik
95.05.02.2017|Kumbu
95.05.02.2018|Mabuna
95.05.02.2019|Manggaleso
95.05.03.2001|Winima
95.05.03.2002|Mogonik
95.05.03.2003|Winam
95.05.03.2004|Kino
95.05.03.2005|Ayeki
95.05.03.2006|Enggama
95.05.03.2007|Wurigelobar
95.05.03.2008|Pagale
95.05.03.2009|Arsbol
95.05.03.2010|Yabendili
95.05.03.2011|Moligi
95.05.03.2012|Kugab
95.05.03.2013|Engaima
95.05.03.2014|Erageam
95.05.03.2015|Wanilok
95.05.04.2001|Megambilis
95.05.04.2002|Tariko
95.05.04.2003|Homasan
95.05.04.2004|Higisyam
95.05.05.2001|Kalarin
95.05.05.2002|Melenggama
95.05.05.2003|Ilugwa
95.05.05.2004|Wirima
95.05.05.2005|Danama
95.05.05.2006|Illusilimo
95.06.01.2001|Elelim
95.06.01.2002|Aluis
95.06.01.2003|Honita
95.06.01.2004|Yabema
95.06.01.2005|Pihel
95.06.01.2006|Walkep
95.06.01.2007|Pangkik
95.06.01.2008|Maribu
95.06.01.2009|Yakikma
95.06.01.2010|Ulo
95.06.01.2011|Sira
95.06.01.2012|Ohoam
95.06.01.2013|Bulmu
95.06.01.2014|Ubi
95.06.01.2015|Pirip
95.06.01.2016|Momonhusi
95.06.01.2017|Helabu
95.06.01.2018|Pungkahik
95.06.01.2019|Wekolani
95.06.01.2020|Hobakma
95.06.01.2021|Wasua
95.06.01.2022|Warikma
95.06.01.2023|Kalak
95.06.01.2024|Isila
95.06.01.2025|Fima
95.06.01.2026|Sohi
95.06.01.2027|Pasimbolo
95.06.01.2028|Wagagu
95.06.01.2029|Sowi
95.06.01.2030|Sipson
95.06.01.2031|Sipsoi
95.06.01.2032|Eregi
95.06.01.2033|Ohoniam
95.06.01.2034|Hiling
95.06.01.2035|Duwong
95.06.01.2036|Pisireg
95.06.01.2037|Tanapasir
95.06.01.2038|Olani
95.06.01.2039|Sili
95.06.01.2040|Hesmat
95.06.01.2041|Molinggu
95.06.01.2042|Werekma
95.06.01.2043|Emon
95.06.01.2044|Kwikma
95.06.02.2001|Apalapsili
95.06.02.2002|Hubliki
95.06.02.2003|Kulet
95.06.02.2004|Yarema
95.06.02.2005|Asiligma
95.06.02.2006|Lambukmu
95.06.02.2007|Suwewili
95.06.02.2008|Yohul
95.06.02.2009|Lilinsaluk
95.06.02.2010|Natoksili
95.06.02.2011|Hinanggoambut
95.06.02.2012|Wiyukwilik
95.06.02.2013|Fari
95.06.02.2014|Wasalalo
95.06.02.2015|Suerlihim
95.06.02.2016|Orohon
95.06.02.2017|Habalo
95.06.02.2018|Sabilikalem
95.06.02.2019|Wanamalo
95.06.02.2020|Kundikele
95.06.02.2021|Kelampurim
95.06.02.2022|Holukalem
95.06.02.2023|Yeptek
95.06.02.2024|Benyam
95.06.02.2025|Temput
95.06.02.2026|Sabualo
95.06.02.2027|Nanahoruk
95.06.02.2028|Kengkenbun
95.06.02.2029|Sien
95.06.02.2030|Kinhe
95.06.02.2031|Humalem
95.06.02.2032|Pipisim
95.06.02.2033|Makrig
95.06.02.2034|Ilirek
95.06.02.2035|Filiahik
95.06.02.2036|Kilat
95.06.02.2037|Baptekma
95.06.02.2038|Nohonil
95.06.02.2039|Asilikma
95.06.02.2040|Tikano
95.06.02.2041|Nasinema
95.06.02.2042|Eal
95.06.02.2043|Hukalopunu
95.06.02.2044|Alimuhuk
95.06.02.2045|Pong
95.06.02.2046|Molinggi
95.06.02.2047|Sobikambut
95.06.02.2048|Wiralesili
95.06.02.2049|Holuogalma
95.06.02.2050|Falukwalilo
95.06.03.2001|Abenaho
95.06.03.2002|Wambalfak
95.06.03.2003|Landikma
95.06.03.2004|Dombomi
95.06.03.2005|Dosumo
95.06.03.2006|Wambo
95.06.03.2007|Sombule
95.06.03.2008|Hubliki
95.06.03.2009|Hulikma
95.06.03.2010|Sebi
95.06.03.2011|Suminaikma
95.06.03.2012|Ulun
95.06.03.2013|Fuahe
95.06.03.2014|Wutlarin
95.06.03.2015|Kolaima
95.06.03.2016|Wanggibo
95.06.03.2017|Walagima
95.06.03.2018|Tagabaga
95.06.03.2019|Bohum
95.06.03.2020|Jinggiwi
95.06.03.2021|Hurualma
95.06.03.2022|Humalma
95.06.03.2023|Yahatma
95.06.03.2024|Sohombunu
95.06.03.2025|Bumbum
95.06.03.2026|Burim
95.06.03.2027|Dahonaikma
95.06.03.2028|Musanahikma
95.06.03.2029|Abagima
95.06.03.2030|Waghasilimo
95.06.03.2031|Wileroma
95.06.03.2032|Obabin
95.06.03.2033|Babin
95.06.03.2034|Elesim
95.06.03.2035|Wanwal
95.06.03.2036|Sabilironggo
95.06.03.2037|Yanamik
95.06.03.2038|Lakongkong
95.06.03.2039|Helaksili
95.06.03.2040|Bukurik
95.06.03.2041|Kewi
95.06.03.2042|Yambaikma
95.06.03.2043|Hubualma
95.06.03.2044|Yuktanggo
95.06.03.2045|Wambal
95.06.03.2046|Lilimuhuk
95.06.03.2047|Hulhule
95.06.03.2048|Mahiyal
95.06.03.2049|Alugi
95.06.03.2050|Sahikma
95.06.03.2051|Bonahik
95.06.03.2052|Eliyekma
95.06.03.2053|Yabusup
95.06.03.2054|Arikbalek
95.06.03.2055|Yawan
95.06.03.2056|Fuim
95.06.03.2057|Witlanggo
95.06.03.2058|Worowi
95.06.03.2059|Bonggi
95.06.03.2060|Wilak
95.06.03.2061|Wanggun
95.06.03.2062|Hombanma
95.06.03.2063|Yama
95.06.03.2064|Halifur
95.06.03.2065|Beim
95.06.03.2066|Ulusi
95.06.03.2067|Salo
95.06.03.2068|Moban
95.06.03.2069|Mulip
95.06.03.2070|Ulukhumi
95.06.03.2071|Halisek
95.06.03.2072|Lohomabel
95.06.03.2073|Kule
95.06.03.2074|Kandibung
95.06.03.2075|Gefido
95.06.03.2076|Sapiwarek
95.06.03.2077|Fialem
95.06.03.2078|Horakia
95.06.03.2079|Suahe
95.06.03.2080|Uluhufuk
95.06.03.2081|Waroham
95.06.03.2082|Sohi
95.06.03.2083|Akris
95.06.03.2084|Pirikalem
95.06.03.2085|Sumbul
95.06.03.2086|Hundilip
95.06.03.2087|Amuki
95.06.03.2088|Wamhor
95.06.03.2089|Kesuwi
95.06.03.2090|Pamumu
95.06.03.2091|Wafuhuk
95.06.03.2092|Lilluikma
95.06.03.2093|Noholuok
95.06.03.2094|Wanam
95.06.03.2095|Nenomani
95.06.03.2096|Wilofing
95.06.03.2097|Salohe
95.06.03.2098|Dama
95.06.03.2099|Kelesu
95.06.03.2100|Kaboholik
95.06.03.2101|Horenikma
95.06.03.2102|Lasikma
95.06.03.2103|Suele
95.06.03.2104|Heahobak
95.06.03.2105|Maleo
95.06.03.2106|Usabiye
95.06.03.2107|Wiwulik
95.06.03.2108|Somohi
95.06.04.2001|Gilika
95.06.04.2002|Trikora
95.06.04.2003|Ampera
95.06.04.2004|Pepera
95.06.04.2005|Naira
95.06.04.2006|Siwa
95.06.04.2007|Tiwayi
95.06.04.2008|Kutakuruk
95.06.04.2009|Narau
95.06.04.2010|Neigase
95.06.04.2011|Martaru
95.06.04.2012|Himi
95.06.04.2013|Nungkere
95.06.04.2014|Puruku
95.06.04.2015|Paluke
95.06.04.2016|Lulum
95.06.04.2017|Pensale
95.06.04.2018|Iyap
95.06.04.2019|Wibi
95.06.04.2020|Konobun
95.06.04.2021|Wirsa
95.06.04.2022|Karamina
95.06.04.2023|Dukunasi
95.06.04.2024|Thamaksin
95.06.04.2025|Kamika
95.06.04.2026|Uramburu
95.06.04.2027|Kapawa
95.06.04.2028|Miyawi
95.06.04.2029|Yakwa
95.06.04.2030|Wermas
95.06.04.2031|Makrip
95.06.04.2032|Ikon
95.06.04.2033|Key
95.06.04.2034|Lawe
95.06.04.2035|Kukdomol
95.06.04.2036|Nihol
95.06.04.2037|Nuorok
95.06.05.2001|Welarek
95.06.05.2002|Werenggik
95.06.05.2003|Saly
95.06.05.2004|Mabualem
95.06.05.2005|Pisanggo
95.06.05.2006|Welarekpunu
95.06.05.2007|Hindalimuhuk
95.06.05.2008|Menepini
95.06.05.2009|Soharam
95.06.05.2010|Kampol
95.06.05.2011|Tahamak
95.06.05.2012|Punui
95.06.05.2013|Sakam
95.06.05.2014|Sinahal
95.06.05.2015|Samaria
95.06.05.2016|Hamboik
95.06.05.2017|Mohobiye
95.06.05.2018|Halialo
95.06.05.2019|Walingkapma
95.06.05.2020|Kayalem
95.06.05.2021|Seherek
95.06.05.2022|Halisek
95.06.05.2023|Wompoli
95.06.05.2024|Fikfak
95.06.05.2025|Mohonu
95.06.05.2026|Pikohofari
95.06.05.2027|Feingkama
95.06.05.2028|Holowi
95.06.05.2029|Poik
95.06.05.2030|Koum
95.06.05.2031|Hobut
95.06.05.2032|Mondek
95.06.05.2033|Mamion
95.06.05.2034|Selek
95.06.05.2035|Ambiliki
95.06.05.2036|Ubalihi
95.06.05.2037|Salema
95.06.05.2038|Selebi
95.06.05.2039|Langam
95.06.05.2040|Pami
95.06.05.2041|Pirang
95.06.05.2042|Poholanggen
95.06.05.2043|Nangkulamulan
95.06.05.2044|Irarek
95.06.05.2045|Ampolongsili
95.06.05.2046|Sumtan
95.06.05.2047|Ulum
95.06.05.2048|Kayo
95.06.05.2049|Panal
95.06.05.2050|Hilariki
95.06.05.2051|Tinmuhuk
95.06.05.2052|Yahamer
95.06.05.2053|Helebol
95.06.05.2054|Silfal
95.06.05.2055|Sukalimi
95.06.05.2056|Nohonil
95.06.05.2057|Lasik
95.06.05.2058|Panalulun
95.06.05.2059|Wasupahik
95.06.05.2060|Folongsili
95.06.05.2061|Amuluk
95.07.01.1001|Bokon
95.07.01.2002|Oyi
95.07.01.2003|Gurika
95.07.01.2004|Olume
95.07.01.2005|Dura
95.07.01.2006|Langgalo
95.07.01.2007|Kuapur
95.07.01.2008|Wadinalome
95.07.01.2009|Yilondum
95.07.01.2010|Palunggame
95.07.01.2011|Ginime
95.07.02.2001|Umbanume
95.07.02.2002|Wenam
95.07.02.2003|Yalipak
95.07.02.2004|Ekanom
95.07.02.2005|Yugumbinik
95.07.02.2006|Amberingime
95.07.02.2007|Aniwo
95.07.02.2008|Bugumbak
95.07.03.2001|Kemiri
95.07.03.2002|Mamiri
95.07.03.2003|Kotorambur
95.07.03.2004|Yorenime
95.07.03.2005|Waganenga
95.07.03.2006|Gembilani
95.07.03.2007|Nambume
95.07.03.2008|Tengenawi
95.07.04.2001|Gamelia
95.07.04.2002|Pirawun
95.07.04.2003|Wupi
95.07.04.2004|Gawiwarak
95.07.04.2005|Meyagale
95.07.04.2006|Wulaipas
95.07.04.2007|Gunagewak
95.07.04.2008|Wunume
95.07.05.2001|Dimba
95.07.05.2002|Yugwa
95.07.05.2003|Magegobak
95.07.05.2004|Nongopnage
95.07.05.2005|Wengenambur
95.07.05.2006|Wawiragi
95.07.05.2007|Mewilangun
95.07.05.2008|Talibarenak
95.07.06.2001|Malagai
95.07.06.2002|Oka
95.07.06.2003|Bagi
95.07.06.2004|Ganume
95.07.06.2005|Binilani
95.07.06.2006|Gumban
95.07.06.2007|Lowanom
95.07.06.2008|Nambu
95.07.07.2001|Tima
95.07.07.2002|Balime
95.07.07.2003|Balingga
95.07.07.2004|Gume
95.07.07.2005|Timonikime
95.07.07.2006|Binolanggen
95.07.07.2007|Dewaka
95.07.07.2008|Yialo
95.07.07.2009|Towewak
95.07.07.2010|Yumaneri
95.07.08.2001|Kuwobaga
95.07.08.2002|Milinggame
95.07.08.2003|Arigineri
95.07.08.2004|Muleme
95.07.08.2005|Arungwi
95.07.08.2006|Ponuma
95.07.08.2007|Gubulela
95.07.08.2008|Kolari
95.07.08.2009|Gumbo
95.07.09.2001|Kuyawage
95.07.09.2002|Wupaga
95.07.09.2003|Luarem
95.07.09.2004|Tumbupur
95.07.09.2005|Uwome
95.07.09.2006|Tunikele
95.07.09.2007|Peko
95.07.09.2008|Yugunomba
95.07.10.2001|Megalunik
95.07.10.2002|Lugobak
95.07.10.2003|Kanikbukme
95.07.10.2004|Poga
95.07.10.2005|Bigipaga
95.07.10.2006|Luneri
95.07.10.2007|Binipaga
95.07.10.2008|Mugime
95.07.10.2009|Brigme
95.07.10.2010|Unikme
95.07.10.2011|Binompaga
95.07.10.2012|Lugwa
95.07.10.2013|Guaneri
95.07.11.2001|Dugume
95.07.11.2002|Wulundia
95.07.11.2003|Dapogi
95.07.11.2004|Kulumburu
95.07.11.2005|Molobok
95.07.11.2006|Tugunakwi
95.07.11.2007|Yanuru
95.07.12.2001|Yirene
95.07.12.2002|Yogobak
95.07.12.2003|Kwenukwi
95.07.12.2004|Libungga
95.07.12.2005|Unom
95.07.12.2006|Wimolome
95.07.12.2007|Weneogun
95.07.12.2008|Berangwi
95.07.13.2001|Tepogi
95.07.13.2002|Ninabua
95.07.13.2003|Golikme
95.07.13.2004|Ninengwa
95.07.13.2005|Weri
95.07.13.2006|Gumagame
95.07.13.2007|Abua
95.07.14.2001|Kumuluk
95.07.14.2002|Giari
95.07.14.2003|Bonanip
95.07.14.2004|Kukepake
95.07.14.2005|Wayuleme
95.07.14.2006|Bogomanum
95.07.14.2007|Pindoak
95.07.14.2008|Kotorambur
95.07.14.2009|Numbo
95.07.14.2010|Lambui
95.07.15.2001|Konikme
95.07.15.2002|Giwan
95.07.15.2003|Lugom
95.07.15.2004|Mabume
95.07.15.2005|Wandoak
95.07.15.2006|Bogun Kunik
95.07.15.2007|Urgelo
95.07.15.2008|Omapaga
95.07.15.2009|Gimili Alome
95.07.16.2001|Guninggame
95.07.16.2002|Mokoni
95.07.16.2003|Popome
95.07.16.2004|Wakumalo
95.07.16.2005|Bigipura
95.07.16.2006|Yanggelome
95.07.16.2007|Wuyumbur
95.07.16.2008|Kondename
95.07.16.2009|Bumalome
95.07.17.2001|Tabukeker
95.07.17.2002|Ponalo
95.07.17.2003|Timi
95.07.17.2004|Wuragi
95.07.17.2005|Tiwa
95.07.17.2006|Dingun
95.07.17.2007|Lura Marah
95.07.17.2008|Pelek
95.07.17.2009|Beyongwi
95.07.18.2001|Milimbo
95.07.18.2002|Takobak
95.07.18.2003|Kugame
95.07.18.2004|Wamindik
95.07.18.2005|Kidoni
95.07.18.2006|Jinok
95.07.18.2007|Wewolome
95.07.18.2008|Umbename
95.07.19.2001|Yiwili
95.07.19.2002|Golo
95.07.19.2003|Golomi
95.07.19.2004|Yugumobur
95.07.19.2005|Milidi
95.07.19.2006|Uniwani
95.07.19.2007|Wiringgambut
95.07.19.2008|Wuluwebur
95.07.19.2009|Kiludo
95.07.19.2010|Giruwi
95.07.20.2001|Golopura
95.07.20.2002|Wirini
95.07.20.2003|Nileme
95.07.20.2004|Libome
95.07.20.2005|Kulia
95.07.20.2006|Yamiga
95.07.20.2007|Gubugame
95.07.20.2008|Kamenak
95.07.20.2009|Perime
95.07.20.2010|Wadinawi
95.07.20.2011|Nengguga
95.07.21.2001|Nambume
95.07.21.2002|Indawa
95.07.21.2003|Eyuni
95.07.21.2004|Yugumia
95.07.21.2005|Dolinggame
95.07.21.2006|Tinggira
95.07.21.2007|Wumuak
95.07.21.2008|Andiaput
95.07.21.2009|Wuragabur
95.07.22.2001|Anitila
95.07.22.2002|Nanim
95.07.22.2003|Lubutini
95.07.22.2004|Tikome
95.07.22.2005|Tikoyowa
95.07.22.2006|Bogogunik
95.07.22.2007|Wanggunom
95.07.22.2008|Nindonak
95.07.22.2009|Luagame
95.07.23.2001|Wamiru
95.07.23.2002|Dugu-dugu
95.07.23.2003|Andugume
95.07.23.2004|Tinime
95.07.23.2005|Mume
95.07.23.2006|Nenggeya
95.07.23.2007|Tenawi
95.07.23.2008|Kobanu
95.07.23.2009|Piragi
95.07.23.2010|Nabei
95.07.23.2011|Mingga
95.07.24.2001|Wamitu
95.07.24.2002|Balimneri
95.07.24.2003|Timotani
95.07.24.2004|Kungganeri
95.07.24.2005|Gwilonik
95.07.24.2006|Ilim
95.07.24.2007|Dinuwi
95.07.25.2001|Bruyugu
95.07.25.2002|Wame
95.07.25.2003|Ogodome
95.07.25.2004|Ekaba
95.07.25.2005|Longgapur
95.07.25.2006|Tikuluk
95.07.25.2007|Birik
95.07.25.2008|Yalogu
95.07.25.2009|Wumbugi
95.07.26.2001|Tinggipura
95.07.26.2002|Yeyugu
95.07.26.2003|Yugume
95.07.26.2004|Baliempura
95.07.26.2005|Denomagi
95.07.26.2006|Magame
95.07.26.2007|Lorea
95.07.26.2008|Anggumabume
95.07.27.2001|Lelam
95.07.27.2002|Teiko
95.07.27.2003|Yaneko
95.07.27.2004|Kimbo
95.07.27.2005|Penggima
95.07.27.2006|Magelo
95.07.27.2007|Onesia
95.07.27.2008|Wapur
95.07.27.2009|Andeyok
95.07.27.2010|Kibingga
95.07.27.2011|Ogobakni
95.07.27.2012|Jilam
95.07.28.2001|Ambena
95.07.28.2002|Kolayak
95.07.28.2003|Wanuga
95.07.28.2004|Labora
95.07.28.2005|Kondena
95.07.28.2006|Kolunggu
95.07.28.2007|Yagarikme
95.07.28.2008|Timotius
95.07.28.2009|Gunumbur
95.07.28.2010|Lalugume
95.07.29.2001|Pirambor
95.07.29.2002|Gondura
95.07.29.2003|Juta
95.07.29.2004|Tigima
95.07.29.2005|Gelok
95.07.29.2006|Murtani
95.07.29.2007|Beam
95.07.29.2008|Wanggu
95.07.29.2009|Kulip
95.07.30.2001|Indugu
95.07.30.2002|Guburini
95.07.30.2003|Jiwikelanny
95.07.30.2004|Nisimok
95.07.30.2005|Yugume
95.07.30.2006|Piname
95.07.30.2007|Londu
95.07.30.2008|Kagaluwi
95.07.31.2001|Bonom
95.07.31.2002|Kuwanom
95.07.31.2003|Kumulume
95.07.31.2004|Uwagambur
95.07.31.2005|Lagame
95.07.31.2006|Kuwoge
95.07.31.2007|Laurapaga
95.07.31.2008|Bawi
95.07.31.2009|Yugimbo
95.07.31.2010|Tinggini
95.07.31.2011|Ogin
95.07.32.2001|Ayafofa
95.07.32.2002|Salemo
95.07.32.2003|Yudani
95.07.32.2004|Towoluk
95.07.32.2005|Tunume
95.07.32.2006|Delegari
95.07.32.2007|Igimbua
95.07.32.2008|Yilokdu
95.07.33.2001|Odika
95.07.33.2002|Yubumabur
95.07.33.2003|Ekapame
95.07.33.2004|Papani
95.07.33.2005|Kubagalo
95.07.33.2006|Jilekme
95.07.33.2007|Wanome
95.07.33.2008|Yiluweneri
95.07.34.2001|Guna
95.07.34.2002|Gukopi
95.07.34.2003|Kori
95.07.34.2004|Keyagalo
95.07.34.2005|Nondinime
95.07.34.2006|Wigume
95.07.34.2007|Piwugun
95.07.35.2001|Kelulome
95.07.35.2002|Wiyagi
95.07.35.2003|Talogi
95.07.35.2004|Wiringgame
95.07.35.2005|Wegenpura
95.07.35.2006|Ilunggijime
95.07.35.2007|Juyiga
95.07.35.2008|Peragime
95.07.35.2009|Muluneri
95.07.35.2010|Lewinagi
95.07.36.2001|Wanggagome
95.07.36.2002|Langgime
95.07.36.2003|Wulawa
95.07.36.2004|Pindalo
95.07.36.2005|Kotorambur
95.07.36.2006|Ambime
95.07.36.2007|Wumbanakme
95.07.36.2008|Yimiribaga
95.07.36.2009|Elubaga
95.07.37.2001|Muara
95.07.37.2002|Lualo
95.07.37.2003|Abua
95.07.37.2004|Gikur
95.07.37.2005|Gipura
95.07.37.2006|Gulu
95.07.37.2007|Bogangi
95.07.37.2008|Golome
95.07.37.2009|Wiyapur
95.07.37.2010|Kuruguneri
95.07.38.2001|Kabiga
95.07.38.2002|Tekul
95.07.38.2003|Melendik
95.07.38.2004|Pirime
95.07.38.2005|Karunggame
95.07.38.2006|Ilunggime
95.07.38.2007|Timolome
95.07.38.2008|Wunime
95.07.38.2009|Genena
95.07.38.2010|Kulogonggame
95.07.38.2011|Kelonome
95.07.38.2012|Dua Lanny
95.07.38.2013|Dangguni
95.07.39.2001|Wabiragi
95.07.39.2002|Yigemili
95.07.39.2003|Gilo
95.07.39.2004|Kewagi
95.07.39.2005|Nombome
95.07.39.2006|Numbokawi
95.07.39.2007|Mbu
95.07.39.2008|Wunabunggu
95.08.01.2001|Kenyam
95.08.01.2002|Kemali
95.08.01.2003|Sralala
95.08.01.2004|Delpel
95.08.01.2005|Yike
95.08.01.2006|Yunat
95.08.01.2007|Dim
95.08.01.2008|Ulunmu
95.08.01.2009|Bombam
95.08.02.2001|Mapenduma
95.08.02.2002|Duma
95.08.02.2003|Yoe
95.08.02.2004|Palsam
95.08.02.2005|Endumu
95.08.02.2006|Litkui
95.08.02.2007|Nowomlusu
95.08.02.2008|Kelapa Dua
95.08.02.2009|Dumdum
95.08.02.2010|Lunggadumu
95.08.03.2001|Yigi
95.08.03.2002|Ekilapo
95.08.03.2003|Suwenem
95.08.03.2004|Karunggame
95.08.03.2005|Sirit
95.08.03.2006|Disendobo
95.08.03.2007|Sumbo
95.08.03.2008|Yebadolma
95.08.03.2009|Lumbukdumu
95.08.03.2010|Wiritlak
95.08.03.2011|Delsa
95.08.03.2012|Borot
95.08.04.2001|Pilini
95.08.04.2002|Ndugwa
95.08.04.2003|Biala
95.08.04.2004|Bambisik
95.08.04.2005|Sitpogol
95.08.05.2001|Geselma
95.08.05.2002|Talem
95.08.05.2003|Kosolpem
95.08.06.2001|Mugi
95.08.06.2002|Dondoklema
95.08.06.2003|Dobopem
95.08.06.2004|Paru
95.08.06.2005|Wundui
95.08.06.2006|Kemamburu
95.08.06.2007|Womsit
95.08.06.2008|Delit
95.08.06.2009|Keret Anggoma
95.08.06.2010|Manet
95.08.06.2011|Miri
95.08.06.2012|Yelsengge
95.08.06.2013|Sarit
95.08.06.2014|Unue
95.08.06.2015|Mirikil
95.08.06.2016|Sambua
95.08.06.2017|Gisarok
95.08.06.2018|Isiklak
95.08.07.2001|Mbuwa
95.08.07.2002|Otalama
95.08.07.2003|Arugia
95.08.07.2004|Opmu
95.08.07.2005|Digilimu
95.08.07.2006|Kogomaru
95.08.08.2001|Tribid
95.08.08.2002|Gearek
95.08.08.2003|Kibid
95.08.08.2004|Weneworarosa
95.08.08.2005|Gebem
95.08.08.2006|Bomegi
95.08.08.2007|Gilingga
95.08.09.2001|Kroptak
95.08.09.2002|Miniem
95.08.09.2003|Golparek
95.08.09.2004|Pesat
95.08.09.2005|Komoroam
95.08.09.2006|Gol
95.08.10.2001|Gilpid
95.08.10.2002|Wipdumu
95.08.10.2003|Bambi
95.08.10.2004|Osama
95.08.10.2005|Kagayem
95.08.10.2006|Ininkwaning
95.08.10.2007|Kumbuklema
95.08.10.2008|Sigimbut
95.08.10.2009|Sanwaruk
95.08.10.2010|Kusit
95.08.10.2011|Kumbun
95.08.10.2012|Peya-Peya
95.08.10.2013|Narugu
95.08.11.2001|Paro
95.08.11.2002|Lombrik
95.08.11.2003|Animarem
95.08.11.2004|Tawelma
95.08.11.2005|Loaraba
95.08.12.2001|Meborok
95.08.12.2002|Yuguru
95.08.12.2003|Lemurak
95.08.12.2004|Setmit
95.08.12.2005|Aptam
95.08.12.2006|Ngenamba
95.08.12.2007|Narugum
95.08.12.2008|Eregenmanggal
95.08.12.2009|Talpam
95.08.12.2010|Siginimarem
95.08.12.2011|Bone
95.08.12.2012|Olunmu
95.08.12.2013|Sabiem
95.08.12.2014|Pereki
95.08.13.2001|Yenggelo
95.08.13.2002|Maima
95.08.13.2003|Nolo
95.08.13.2004|Wuarem
95.08.14.2001|Gemam
95.08.14.2002|Puruwa
95.08.14.2003|Yutpul
95.08.14.2004|Kilmid
95.08.15.2001|Alama
95.08.15.2002|Nolit
95.08.15.2003|Gin
95.08.15.2004|Kulesa
95.08.16.2001|Yal
95.08.16.2002|Yimogi
95.08.16.2003|Gimi
95.08.16.2004|Mugiarem
95.08.16.2005|Palpam
95.08.16.2006|Samba
95.08.16.2007|Sitdobo
95.08.16.2008|Diringgama
95.08.16.2009|Dangenpem
95.08.16.2010|Undo
95.08.16.2011|Betbere
95.08.16.2012|Muruldumu
95.08.16.2013|Yaba
95.08.16.2014|Dengpa
95.08.16.2015|Girimnak
95.08.16.2016|Lambule
95.08.16.2017|Sujomdobo
95.08.16.2018|Suelama
95.08.16.2019|Gularem
95.08.16.2020|Biledumu
95.08.17.2001|Mam
95.08.17.2002|Pukle
95.08.17.2003|Wolmbam
95.08.17.2004|Wanduama
95.08.17.2005|Yibi
95.08.17.2006|Lakda
95.08.17.2007|Yebandui
95.08.17.2008|Laruid
95.08.17.2009|Dendamba
95.08.17.2010|Kibiaren
95.08.17.2011|Paruarem
95.08.17.2012|Kibo
95.08.17.2013|Putdumu
95.08.17.2014|Darakma
95.08.18.2001|Dal
95.08.18.2002|Silan
95.08.18.2003|Gurumbe
95.08.18.2004|Kaboneri
95.08.18.2005|Silankuru
95.08.18.2006|Grinbun
95.08.19.2001|Nirkuri
95.08.19.2002|Binime
95.08.19.2003|Uenoma
95.08.19.2004|Pasebem
95.08.19.2005|Sigmie
95.08.19.2006|Nirigimbirik
95.08.19.2007|Oldobo
95.08.19.2008|Likubuk
95.08.19.2009|Kokujondumu
95.08.19.2010|Kurigi
95.08.20.2001|Biripem
95.08.20.2002|Dakbri
95.08.20.2003|Abualak
95.08.20.2004|Urugom
95.08.20.2005|Area
95.08.20.2006|Wumaga
95.08.20.2007|Gulama
95.08.20.2008|Kigam
95.08.21.2001|Iniye
95.08.21.2002|Baklema
95.08.21.2003|Kibendumu
95.08.21.2004|Simiye
95.08.21.2005|Embuklem
95.08.21.2006|Kosobak
95.08.22.2001|Uburu
95.08.22.2002|Kabolilangen
95.08.22.2003|Kolma
95.08.22.2004|Brambel
95.08.22.2005|Kiabypma
95.08.22.2006|Kibisim
95.08.22.2007|Labrik
95.08.23.2001|Paris
95.08.23.2002|Simie
95.08.23.2003|Urugi
95.08.23.2004|Pirim-Pirim
95.08.23.2005|Tombisik
95.08.23.2006|Yepma
95.08.23.2007|Sokore
95.08.23.2008|Tobonggom
95.08.23.2009|Rapa
95.08.24.2001|Wendama
95.08.24.2002|Embetpem
95.08.24.2003|Yenai
95.08.24.2004|Digilimu
95.08.24.2005|Bisikimu
95.08.25.2001|Kora
95.08.25.2002|Nanggoal
95.08.25.2003|Wenam
95.08.25.2004|Wilimi
95.08.25.2005|Brutnai
95.08.26.2001|Wusi
95.08.26.2002|Ginigit
95.08.26.2003|Pijemae
95.08.26.2004|Gimigip
95.08.27.2001|Nganai
95.08.27.2002|Pija
95.08.27.2003|Sitgama
95.08.27.2004|Siat
95.08.27.2005|Murupbaye
95.08.28.2001|Moba
95.08.28.2002|Gunea
95.08.28.2003|Kwegono
95.08.28.2004|Langpang
95.08.28.2005|Yeretma
95.08.28.2006|Anggulpa
95.08.28.2007|Moba Dua
95.08.28.2008|Pijama
95.08.29.2001|Muli
95.08.29.2002|Tinigele
95.08.29.2003|Wuone
95.08.29.2004|Luaren
95.08.29.2005|Wangun
95.08.29.2006|Wutpaga
95.08.30.2001|Neggea
95.08.30.2002|Wulagumi
95.08.30.2003|Kombama
95.08.30.2004|Wenggenambut
95.08.30.2005|Nenggeagin
95.08.31.2001|Krepkuri
95.08.31.2002|Alguru
95.08.31.2003|Sagapusatu
95.08.31.2004|Mumugu
95.08.31.2005|Ginid
95.08.31.2006|Banggabeak
95.08.32.2001|Mandala
95.08.32.2002|Trim
95.08.32.2003|Benggem
95.08.32.2004|Pasir Putih
96.01.01.1001|Makbon
96.01.01.2002|Asbaken
96.01.01.2003|Malaumkarta
96.01.01.2004|Batu Lubang
96.01.01.2005|Batu Lubang Pantai
96.01.01.2006|Kwadas
96.01.01.2007|Bainkete
96.01.01.2008|Teluk Dore
96.01.01.2009|Sawatuk
96.01.01.2010|Malagasih
96.01.01.2011|Klasimigik
96.01.01.2012|Klasigi
96.01.01.2013|Klagulus
96.01.01.2014|Suatolo
96.01.01.2015|Mibi
96.01.02.2001|Klabra
96.01.02.2002|Wanurian
96.01.02.2003|Klarion
96.01.02.2004|Kaas
96.01.02.2005|Wensi
96.01.02.2006|Mumpi
96.01.02.2007|Klamak
96.01.02.2008|Serselion
96.01.02.2009|Kmafo
96.01.02.2010|Midlal
96.01.02.2011|Sorain
96.01.02.2012|Armoin
96.01.02.2013|Serselion Baru
96.01.03.1001|Katinim
96.01.03.1002|Majener
96.01.03.1003|Majaran
96.01.03.1004|Matawolot
96.01.03.2005|Walal
96.01.03.2006|Malaus
96.01.03.2007|Rawa Sugi
96.01.04.2001|Seget
96.01.04.2002|Malabam
96.01.04.2003|Pulau Kasim
96.01.04.2004|Kasimle
96.01.04.2005|Wewenagu
96.01.04.2006|Wasingsan
96.01.04.2007|Klayas
96.01.04.2008|Wayenkede
96.01.04.2009|Mobi
96.01.05.1001|Aimas
96.01.05.1002|Malawili
96.01.05.1003|Malawele
96.01.05.1004|Mariat Pantai
96.01.05.1005|Mariat Gunung
96.01.05.1007|Warmon
96.01.05.1008|Klabinain
96.01.05.1009|Malasom
96.01.05.1010|Klaigit
96.01.05.1012|Malagusa
96.01.05.1013|Klafma
96.01.05.2006|Maibo
96.01.05.2011|Aimo
96.01.05.2014|Malasaum
96.01.06.2001|Klawana
96.01.06.2002|Klamono
96.01.06.2003|Wariyau
96.01.06.2004|Klalomon
96.01.06.2005|Wonosari
96.01.06.2006|Gisim Darat
96.01.06.2007|Mlais
96.01.06.2008|Malasmiliy
96.01.06.2009|Klasafet
96.01.06.2010|Posa
96.01.07.2001|Sayosa
96.01.07.2002|Maladofok
96.01.07.2003|Yorbes
96.01.07.2004|Samusa
96.01.07.2005|Klamintu
96.01.07.2006|Klain
96.01.08.2001|Segun
96.01.08.2002|Gisim
96.01.08.2003|Waimon
96.01.08.2004|Klasegun
96.01.08.2005|Waimlabat
96.01.08.2006|Majemau
96.01.08.2007|Klasin
96.01.08.2008|Klajaring
96.01.08.2009|Malamas
96.01.09.1001|Makbusun
96.01.09.1002|Makbalim
96.01.09.1003|Makotyamsa
96.01.09.2004|Jeflio
96.01.09.2005|Arar
96.01.09.2006|Klain
96.01.09.2007|Klasmelek
96.01.09.2008|Wen
96.01.09.2009|Warmon Kokoda
96.01.09.2010|Asjidba
96.01.09.2011|Malamay
96.01.10.2001|Sailolof
96.01.10.2002|Kotlol
96.01.10.2003|Dulbatan
96.01.10.2004|Manoket
96.01.10.2005|Payapop
96.01.10.2006|Masmapop
96.01.11.2001|Indiwi
96.01.11.2002|Klabot
96.01.11.2003|Mlat
96.01.11.2004|Mlawes
96.01.11.2005|Mlasfa
96.01.11.2006|Kanolo
96.01.11.2007|Somir
96.01.11.2008|Warkti
96.01.12.2001|Wilty
96.01.12.2002|Mlawen
96.01.12.2003|Byoklokfle
96.01.12.2004|Tbotjin
96.01.12.2005|Sas
96.01.12.2006|Samolslo
96.01.12.2007|Kmasen
96.01.12.2008|Klasawon
96.01.12.2009|Yurkaden
96.01.12.2010|Betwaf
96.01.12.2011|Cokhif
96.01.13.2001|Luwelala
96.01.13.2002|Klatim
96.01.13.2003|Klaos
96.01.13.2004|Suluh
96.01.13.2005|Bousui
96.01.13.2006|Kamuyar
96.01.13.2007|Klaka
96.01.13.2008|Safdesa
96.01.13.2009|Klagen
96.01.14.1001|Klamalu
96.01.14.1002|Mariyai
96.01.14.1003|Klasuluk
96.01.14.1004|Klamasen
96.01.14.1008|Maklalut
96.01.14.1009|Klaru
96.01.14.1010|Jamaimo
96.01.14.2005|Klaben
96.01.14.2006|Klasan
96.01.14.2007|Fafi
96.01.14.2011|Kasih
96.01.15.2001|Klayili
96.01.15.2002|Klawuluh
96.01.15.2003|Malakobutu
96.01.15.2004|Kwakeik
96.01.15.2005|Klasowoh
96.01.15.2006|Malalilis
96.01.15.2007|Mlawer
96.01.15.2008|Klatomok
96.01.16.2001|Siwis
96.01.16.2002|Miskum
96.01.16.2003|Klamugun
96.01.16.2004|Sbaga
96.01.16.2005|Klalik
96.01.16.2006|Malawhili
96.01.16.2007|Klasou
96.01.17.2001|Klafdalim
96.01.17.2002|Klaforo
96.01.17.2003|Klasof
96.01.17.2004|Ninjimur
96.01.17.2005|Klasari
96.01.17.2006|Klawoton
96.01.17.2007|Wonosobo
96.01.17.2008|Sakamerin
96.01.17.2009|Masmili
96.01.18.2001|Maibo
96.01.18.2002|Malaflon
96.01.18.2003|Kabanmolo
96.01.18.2004|Kagiwala
96.01.19.2001|Disfra
96.01.19.2002|Bagun
96.01.19.2003|Klawom
96.01.19.2004|Klamomis
96.01.19.2005|Klakwonrit
96.01.19.2006|Mode
96.01.19.2007|Bratmawe
96.01.19.2008|Klawon
96.01.19.2009|Mlamli
96.01.20.2001|Saluk
96.01.20.2002|Klawaren
96.01.20.2003|Woloin
96.01.20.2004|Klalin Mos
96.01.20.2005|Kwari
96.01.20.2006|Kamlin
96.01.21.2001|Dasri
96.01.21.2002|Masos
96.01.21.2003|Ketawas
96.01.21.2004|Warbo
96.01.21.2005|Suus
96.01.21.2006|Sulya
96.01.21.2007|Bouwoi
96.01.22.2001|Buk
96.01.22.2002|Mlakhan
96.01.22.2003|Klais
96.01.22.2004|Mimpe
96.01.22.2005|Tiklen
96.01.22.2006|Klahen
96.01.22.2007|Moos
96.01.23.2001|Saengkeduk
96.01.23.2002|Selekobo
96.01.23.2003|Suye
96.01.23.2004|Klamede
96.01.23.2005|Sambatie
96.01.23.2006|Klagele
96.01.24.2001|Malasigit
96.01.24.2002|Klagulu
96.01.24.2003|Klamugun
96.01.24.2004|Malajapa
96.01.24.2005|Klasman
96.01.24.2006|Malamoja
96.01.24.2007|Magatarum
96.01.24.2008|Tanah Tinggi
96.01.24.2009|Marik May
96.01.25.2001|Tarsa
96.01.25.2002|Klamne
96.01.25.2003|Wisbiak
96.01.25.2004|Klafyo
96.01.25.2005|Mlasiwor
96.01.25.2006|Klafelem
96.01.25.2007|Klaflum
96.01.25.2008|Klarin
96.01.25.2009|Mlaron
96.01.26.2001|Maladuk
96.01.26.2002|Klamono Olie
96.01.26.2003|Barros
96.01.26.2004|Pusu Tiligum
96.01.26.2005|Klawilibe
96.01.27.2001|Hobard
96.01.27.2002|Brianlo
96.01.27.2003|Floyi
96.01.27.2004|Klazelt
96.01.27.2005|Sfadon
96.01.27.2006|Selol
96.01.27.2007|Dais
96.01.28.2001|Waliam
96.01.28.2002|Manfanim
96.01.28.2003|Waibin
96.01.28.2004|Waiman
96.01.28.2005|Sakapul
96.01.28.2006|Maralol
96.01.28.2007|Batbiro
96.01.28.2008|Duriankari
96.01.28.2009|Meyaup
96.01.28.2010|Sailen
96.01.29.2001|Klafluk
96.01.29.2002|Mamsit
96.01.29.2003|Sabake
96.01.29.2004|Klayastani
96.01.29.2005|Botain
96.01.30.2001|Sailala
96.01.30.2002|Klawana
96.01.30.2003|Kladuk
96.01.30.2004|Klawon
96.01.30.2005|Klakak
96.01.30.2006|Klalwok
96.02.01.1002|Kaibus
96.02.01.1003|Kohoin
96.02.01.2001|Wersar
96.02.01.2004|Wehali
96.02.01.2005|Aibobor
96.02.01.2006|Wermit
96.02.01.2007|Keyen
96.02.01.2008|Siribau
96.02.01.2009|Magis
96.02.01.2010|Tegirolo
96.02.01.2011|Wernas
96.02.01.2012|Tapiri
96.02.01.2013|Gorolo
96.02.01.2014|Nambro
96.02.01.2015|Seyolo
96.02.01.2016|Ani Sesna
96.02.02.2001|Mate
96.02.02.2002|Serkos
96.02.02.2003|Solta Baru
96.02.02.2004|Wadoi
96.02.02.2005|Isogo
96.02.02.2006|Sibae
96.02.02.2007|Mogibi
96.02.02.2008|Odeare
96.02.02.2009|Siri-siri
96.02.03.2001|Sawiat
96.02.03.2002|Sasnek
96.02.03.2003|Elles
96.02.03.2004|Sodrofoyo
96.02.03.2005|Sfakyo
96.02.03.2006|Wensough
96.02.03.2007|Ween
96.02.03.2008|Wendi
96.02.04.2001|Tarof
96.02.04.2002|Negeri Besar
96.02.04.2003|Siwatori
96.02.04.2004|Kasuweri
96.02.04.2005|Migori
96.02.04.2006|Tambani
96.02.04.2007|Daubak
96.02.04.2008|Totona
96.02.04.2009|Nayakore
96.02.04.2010|Arbasina
96.02.04.2011|Birawaku
96.02.04.2012|Korewatara
96.02.04.2013|Tapas
96.02.04.2014|Topdan
96.02.04.2015|Migrito
96.02.04.2016|Daimar
96.02.05.2001|Moswaren
96.02.05.2002|Johsiro
96.02.05.2003|Hararo
96.02.05.2004|Bumi Ajo
96.02.05.2005|Hasik Jaya
96.02.05.2006|Kamisabe
96.02.05.2007|Tokass
96.02.06.2001|Haha
96.02.06.2002|Klaogin
96.02.06.2003|Tofot
96.02.06.2004|Sbir
96.02.06.2005|Srer
96.02.06.2006|Woloin
96.02.06.2007|Kamaro
96.02.06.2008|Kakas
96.02.07.2001|Sungguer
96.02.07.2002|Unggi
96.02.07.2003|Boldon
96.02.07.2004|Sesor
96.02.07.2005|Waigo
96.02.07.2006|Bagaraga
96.02.07.2007|Wardik
96.02.07.2008|Wayer
96.02.08.2001|Kais
96.02.08.2002|Tapuri
96.02.08.2003|Yahadian
96.02.08.2004|Benawa I
96.02.08.2005|Sumano
96.02.09.2001|Konda
96.02.09.2002|Wamargege
96.02.09.2003|Bariat
96.02.09.2004|Manelek
96.02.09.2005|Nagna
96.02.10.2001|Mugim
96.02.10.2002|Nusa
96.02.10.2003|Saga
96.02.10.2004|Puragi
96.02.10.2005|Tawanggire
96.02.10.2006|Bedare
96.02.11.2001|Udagaga
96.02.11.2002|Kayubiro
96.02.11.2003|Adona
96.02.11.2004|Benawa II
96.02.11.2005|Atori
96.02.11.2006|Kamundan Satu
96.02.11.2007|Karirif
96.02.11.2008|Bubuko
96.02.11.2009|Kamundan Dua
96.02.12.2001|Manggroholo
96.02.12.2002|Komanggaret
96.02.12.2003|Sayal
96.02.12.2004|Kayabo
96.02.12.2005|Sisir
96.02.12.2006|Mlaswat
96.02.12.2007|Kwowok
96.02.12.2008|Sira
96.02.12.2009|Kenaya
96.02.13.2001|Pasir Putih
96.02.13.2002|Wandum
96.02.13.2003|Bemus
96.02.13.2004|Welek
96.02.14.2001|Wenslolo
96.02.14.2002|Klamit
96.02.14.2003|Mlabolo
96.02.14.2004|Kofalit
96.02.14.2005|Alma
96.02.15.2001|Mukamat
96.02.15.2002|Ikana
96.02.15.2003|Haemaran
96.02.15.2004|Siranggo
96.02.15.2005|Mogatemin
96.02.15.2006|Onimsefa
96.02.15.2007|Makaroro
96.03.01.2001|Waigama
96.03.01.2002|Salafen
96.03.01.2003|Aduwei
96.03.01.2004|Atkari
96.03.01.2005|Solal
96.03.02.2001|Kabare
96.03.02.2002|Andey
96.03.02.2003|Asukweri
96.03.02.2004|Bonsayor
96.03.02.2005|Darumbab
96.03.02.2006|Kalisade
96.03.03.2001|Saonek
96.03.03.2002|Saporkren
96.03.03.2003|Yenbeser
96.03.03.2004|Friwen
96.03.03.2005|Wawiyai
96.03.04.2001|Samate
96.03.04.2002|Kapatlap
96.03.04.2003|Jefman Barat
96.03.04.2004|Wamega
96.03.04.2005|Jefman Timur
96.03.04.2006|Waidim
96.03.05.2001|Dorehkar
96.03.05.2002|Yenkawir
96.03.05.2003|Boiseran
96.03.05.2004|Runi
96.03.05.2005|Yenkanfan
96.03.06.2001|Foley
96.03.06.2002|Tomolol
96.03.06.2003|Usaha Jaya
96.03.06.2004|Limalas Timur
96.03.06.2005|Audam
96.03.06.2006|Limalas Barat
96.03.07.2001|Selpele
96.03.07.2002|Mutus
96.03.07.2003|Bianci
96.03.07.2004|Saleo
96.03.07.2005|Waisilip
96.03.08.2001|Puper
96.03.08.2002|Yenbekaki
96.03.08.2003|Urbinasopen
96.03.08.2004|Yensner
96.03.09.2001|Lopintol
96.03.09.2002|Warsamdin
96.03.09.2003|Mumes
96.03.09.2004|Kalitoko
96.03.10.2001|Dibalal
96.03.10.2002|Tolobi
96.03.10.2003|Deer
96.03.10.2004|Mikiran
96.03.10.2005|Awat
96.03.11.2001|Yenbekwan
96.03.11.2002|Kapisawar
96.03.11.2003|Sawinggrai
96.03.11.2004|Yenwaupnor
96.03.11.2005|Arborek
96.03.11.2006|Yenbuba
96.03.11.2007|Kabuy
96.03.11.2008|Kurkapa
96.03.11.2009|Sauandarek
96.03.12.2001|Fafanlap
96.03.12.2002|Yellu
96.03.12.2003|Harapan Jaya
96.03.12.2004|Kareyepop
96.03.12.2005|Dabatan
96.03.13.2001|Warwanai
96.03.13.2002|Mnier
96.03.13.2003|Boni
96.03.13.2004|Warkori
96.03.14.2001|Manyaifun
96.03.14.2002|Miosmanggara
96.03.14.2003|Pam
96.03.14.2004|Saukabu
96.03.14.2005|Gag
96.03.14.2006|Saupapir
96.03.15.2001|Lilinta
96.03.15.2002|Gamta
96.03.15.2003|Biga
96.03.15.2004|Kapatcol
96.03.15.2005|Magey
96.03.16.2001|Weijim Barat
96.03.16.2002|Weijim Timur
96.03.16.2003|Satokurano
96.03.16.2004|Pulau Tikus
96.03.17.1001|Waisai
96.03.17.1002|Sapordanco
96.03.17.1003|Bonkawir
96.03.17.1004|Warmasen
96.03.18.2001|Go
96.03.18.2002|Kabilol
96.03.18.2003|Arawai
96.03.18.2004|Beo
96.03.18.2005|Waifoi
96.03.18.2006|Warimak
96.03.19.2001|Yensawai Timur
96.03.19.2002|Yensawai Barat
96.03.19.2003|Arefi Timur
96.03.19.2004|Arefi Selatan
96.03.20.2001|Waibon
96.03.20.2002|Solol
96.03.20.2003|Kaliam
96.03.20.2004|Kalwal
96.03.21.2001|Kalobo
96.03.21.2002|Sakabu
96.03.21.2003|Waibu
96.03.21.2004|Waijan
96.03.21.2005|Waimeci
96.03.21.2006|Wailabu
96.03.21.2007|Wailen
96.03.22.2001|Rauki
96.03.22.2002|Urai
96.03.22.2003|Duber
96.03.22.2004|Kapadiri
96.03.23.2001|Abidon
96.03.23.2002|Rutum
96.03.23.2003|Reni
96.03.23.2004|Meosbekwan
96.03.24.2001|Yenanas
96.03.24.2002|Amdui
96.03.24.2003|Wailebet
96.03.24.2004|Waiman
96.04.01.2001|Fef
96.04.01.2002|Wayo
96.04.01.2003|Syubun
96.04.01.2004|Sikor
96.04.01.2005|Ibe
96.04.01.2006|Syunam
96.04.01.2007|Banfot
96.04.01.2008|Iwin
96.04.01.2009|Esyum
96.04.01.2010|Imor
96.04.02.2001|Siakwa
96.04.02.2002|Aibogiar
96.04.02.2003|Ayae
96.04.02.2004|Ayawit
96.04.02.2005|Aifair
96.04.03.2001|Baun
96.04.03.2002|Sumbekas
96.04.03.2003|Metnayam
96.04.03.2004|Metbelum
96.04.03.2005|Salem
96.04.03.2006|Metbesa
96.04.04.2001|Kwoor
96.04.04.2002|Hopmare
96.04.04.2003|Orwen
96.04.04.2004|Barar
96.04.04.2005|Esmambo
96.04.05.2001|Sausapor
96.04.05.2002|Emaos
96.04.05.2003|Jokte
96.04.05.2004|Uigwem
96.04.05.2005|Sungguwan
96.04.05.2006|Sau Uram
96.04.05.2007|Nanggou
96.04.05.2008|Bondek
96.04.05.2009|Bondonggwan
96.04.05.2010|Syurauw
96.04.06.2001|Wau
96.04.06.2002|Syukwo
96.04.06.2003|Waibem
96.04.06.2004|Weyaf
96.04.06.2005|Weprari
96.04.07.2001|Syujak
96.04.07.2002|Banso
96.04.07.2003|Iof
96.04.07.2004|Frafane
96.04.08.2001|Mega
96.04.08.2002|Selewok
96.04.08.2003|Malaworsai
96.04.08.2004|Kwade
96.04.08.2005|Bonem
96.04.08.2006|Warafor
96.04.08.2007|Warmasi
96.04.08.2008|Warmanen
96.04.08.2009|Namuas
96.04.09.2001|Injai
96.04.09.2002|Apoki
96.04.09.2003|Matatun
96.04.09.2004|Jafai
96.04.09.2005|Jambuani
96.04.09.2006|Manaria
96.04.09.2007|Anarum
96.04.09.2008|Wasanggon
96.04.09.2009|Wabanek
96.04.10.2001|Saukorem
96.04.10.2002|Wefiani
96.04.10.2003|Wasarak
96.04.10.2004|Binasi
96.04.10.2005|Kabibwan
96.04.10.2006|Binmaks
96.04.10.2007|Manggapnut
96.04.10.2008|Waramui
96.04.10.2009|Warpaperi
96.04.11.2001|Senopi
96.04.11.2002|Arapi
96.04.11.2003|Srurem
96.04.11.2004|Sumo
96.04.11.2005|Ifat Mitu
96.04.11.2006|Povokek Ania
96.04.11.2007|Thomas
96.04.11.2008|Tintum Araw
96.04.11.2009|Hobiah
96.04.12.2001|Arfu
96.04.12.2002|Bawey
96.04.12.2003|Wasnembri
96.04.12.2004|Waru
96.04.12.2005|Atori
96.04.12.2006|Meriambeker
96.04.12.2007|Warokon
96.04.12.2008|Arekon
96.04.12.2009|Bonpaya
96.04.12.2010|Marbuan
96.04.13.2001|Werur
96.04.13.2002|Bukit
96.04.13.2003|Wertam
96.04.13.2004|Werwaf
96.04.13.2005|Werbes
96.04.13.2006|Nombrak
96.04.13.2007|Bikar
96.04.13.2008|Syunai
96.04.13.2009|Suyam
96.04.13.2010|Wertim
96.04.14.2001|Bamusbama
96.04.14.2002|Bamuswaiman
96.04.14.2003|Syarwom
96.04.14.2004|Babak
96.04.14.2005|Bano
96.04.14.2006|Wormon
96.04.15.2001|Ases
96.04.15.2002|Asuon
96.04.15.2003|Safotiek
96.04.15.2004|Frasayoah
96.04.16.2001|Mawor
96.04.16.2002|Ruf
96.04.16.2003|Ayamane
96.04.16.2004|Whismer
96.04.16.2005|Sahae
96.04.16.2006|Hewi
96.04.16.2007|Sisu
96.04.16.2008|Ruvewes
96.04.16.2009|Yabuow
96.04.17.2001|Miri
96.04.17.2002|Meis
96.04.17.2003|Aifamas
96.04.17.2004|Meinad
96.04.17.2005|Atafrumek
96.04.17.2006|Ifiam
96.04.17.2007|Wufmana
96.04.18.2001|Syumbab
96.04.18.2002|Krisnos
96.04.18.2003|Syukwes
96.04.18.2004|Sunggak
96.04.18.2005|Wowom
96.04.18.2006|Resye
96.04.19.2001|Tabamsere
96.04.19.2002|Sayam
96.04.19.2003|Araf Mafat
96.04.19.2004|Esyuom
96.04.20.2001|Tinggouw
96.04.20.2002|Hohair
96.04.20.2003|Ruriai
96.04.20.2004|Soon
96.04.20.2005|Ifatkan
96.04.21.2001|Jokbujoker
96.04.21.2002|Kranfotsu
96.04.21.2003|Syuau
96.04.21.2004|Kwesefo
96.04.21.2005|Batdey
96.04.21.2006|Syumbi
96.04.21.2007|Bao
96.04.21.2008|Donan
96.04.21.2009|Dombron
96.04.22.2001|Wausin
96.04.22.2002|Asiti
96.04.22.2003|Bisaud
96.04.22.2004|Nisandauw
96.04.22.2005|Afrawi
96.04.22.2006|Ajokwapi
96.04.23.2001|Inam
96.04.23.2002|Jandurauw
96.04.23.2003|Inambuari
96.04.23.2004|Sitori
96.04.23.2005|Untorey
96.04.23.2006|Nabisai
96.04.23.2007|Arumi
96.04.23.2008|Karawi
96.04.23.2009|Arampak
96.04.23.2010|Barona
96.04.24.2001|Nekori
96.04.24.2002|Ajami
96.04.24.2003|Aniti
96.04.24.2004|Akari
96.04.24.2005|Amnan
96.04.24.2006|Atiki
96.04.24.2007|Arwani
96.04.24.2008|Aritowi
96.04.24.2009|Umpay
96.04.24.2010|Meiwar
96.04.25.2001|Atai
96.04.25.2002|Akmuri
96.04.25.2003|Awori
96.04.25.2004|Itafiti
96.04.25.2005|Atunari
96.04.25.2006|Ajami Waripi
96.04.25.2007|Narai
96.04.25.2008|Aranari
96.04.25.2009|Waumi
96.04.25.2010|Aneti
96.04.26.2001|Arupi
96.04.26.2002|Mangganek
96.04.26.2003|Wajarek
96.04.26.2004|Kali An
96.04.26.2005|Araro
96.04.26.2006|Wekari
96.04.26.2007|Serayo
96.04.27.2001|Sasui
96.04.27.2002|Imbuan
96.04.27.2003|Manggaew
96.04.27.2004|Saurabon
96.04.27.2005|Wasawmontem
96.04.28.2001|Meserikweda
96.04.28.2002|Kasi Baru
96.04.28.2003|Kasi Jaya
96.04.28.2004|Meimorufof
96.04.28.2005|Kasi Indah
96.04.28.2006|Wacam
96.04.28.2007|Irumfei
96.04.28.2008|Pubuan
96.04.28.2009|Ireji
96.04.28.2010|Kasi Inom
96.04.28.2011|Meycocforga
96.04.28.2012|Meyomnar
96.04.29.2001|Della
96.04.29.2002|Malayauw
96.04.29.2003|Klasbon
96.04.29.2004|Klasei
96.04.29.2005|Klabili
96.05.01.2001|Kumurkek
96.05.01.2002|Susumuk
96.05.01.2003|Kokas
96.05.01.2004|Kocuas
96.05.01.2005|Kocuwer
96.05.01.2006|Bori
96.05.01.2007|Werjaya
96.05.01.2008|Tehahite
96.05.01.2009|Faitmayaf
96.05.01.2010|Aisyo
96.05.01.2011|Futon
96.05.01.2012|Sampika
96.05.01.2013|Martaim
96.05.01.2014|Frawebo
96.05.01.2015|Faitsawe
96.05.01.2016|Kocuwer Selatan
96.05.01.2017|Faitmayaf Barat
96.05.01.2018|Sikof
96.05.01.2019|Bori Timur
96.05.01.2020|Kumurkek Barat
96.05.01.2021|Ainod
96.05.01.2022|Kocuas Utara
96.05.01.2023|Sunei
96.05.02.2001|Ayawasi
96.05.02.2002|Ayawasi Selatan
96.05.02.2003|Ayawasi Timur
96.05.02.2004|Susai
96.05.02.2005|Fonatu
96.05.02.2006|Mosun
96.05.02.2007|Wayane
96.05.02.2008|Konja
96.05.02.2009|Yarat
96.05.02.2010|Man
96.05.02.2011|Howait
96.05.02.2012|Haenkanes
96.05.02.2013|Konja Barat
96.05.02.2014|Yarat Timur
96.05.02.2015|Raha
96.05.02.2016|Mowes
96.05.02.2017|Irata
96.05.02.2018|Neset
96.05.02.2019|Mosun Timur
96.05.02.2020|Mosun Utara
96.05.03.2001|Aisa
96.05.03.2002|Aikrer
96.05.03.2003|Aitrem
96.05.03.2004|Sawin
96.05.03.2005|Sahbuku
96.05.03.2006|Sasior Frabuku
96.05.03.2007|Wakom
96.05.03.2008|Sanem
96.05.03.2009|Buoh Sa
96.05.04.2001|Kisor
96.05.04.2002|Sorry
96.05.04.2003|Imsun
96.05.04.2004|Sabah
96.05.04.2005|Tahsimara
96.05.04.2006|Fuog
96.05.04.2007|Asiaf Saman
96.05.04.2008|Hora Iek
96.05.04.2009|Fuog Selatan
96.05.04.2010|Same Rakator
96.05.04.2011|Roma
96.05.04.2012|Krus
96.05.04.2013|Awet Main
96.05.04.2014|Yeek
96.05.04.2015|Kaitana
96.05.04.2016|Tolak
96.05.05.2001|Kambufatem
96.05.05.2002|Kambufatem Utara
96.05.05.2003|Fatase
96.05.05.2004|Hosyo Ata
96.05.05.2005|Waybomatah
96.05.05.2006|Siyo
96.05.05.2007|Hasweh
96.05.05.2008|Fatem
96.05.05.2009|Hosyo Banah
96.05.06.2001|Aitinyo
96.05.06.2002|Irohe
96.05.06.2003|Sris
96.05.06.2004|Kamro
96.05.06.2005|Karsu
96.05.06.2006|Tehak Kecil
96.05.06.2007|Sira Aya
96.05.06.2008|Korom
96.05.06.2009|Sumanis
96.05.06.2010|Ibasuf
96.05.06.2011|Sowai Sau
96.05.06.2012|Subin
96.05.06.2013|Irohmrar
96.05.06.2014|Bofait
96.05.06.2015|Afkrem
96.05.06.2016|Wiho
96.05.06.2017|Kamro Selatan
96.05.07.2001|Fategomi
96.05.07.2002|Tehak Besar
96.05.07.2003|Fan
96.05.07.2004|Gohsames
96.05.07.2005|Asmuruf U
96.05.07.2006|Mirafaan
96.05.07.2007|Asmuruf Tee
96.05.07.2008|Tehak Tee
96.05.07.2009|Framafir
96.05.07.2010|Subrit
96.05.07.2011|Inta
96.05.07.2012|Bahwat
96.05.08.1001|Ayamaru
96.05.08.2002|Framu
96.05.08.2003|Mefkajim II
96.05.08.2004|Fraharo
96.05.08.2005|Smusswioh
96.05.08.2006|Twer
96.05.08.2007|Afes
96.05.08.2008|Tuso
96.05.09.2001|Yubiah
96.05.09.2002|Karetubun
96.05.09.2003|Setta
96.05.09.2004|Hohoyor
96.05.09.2005|Arne
96.05.09.2006|Aus Tiwit
96.05.09.2007|Johafah
96.05.09.2008|Yukase
96.05.09.2009|Serma
96.05.09.2010|Kfaa
96.05.09.2011|Arne Timur
96.05.09.2012|Nauwita
96.05.10.2001|Kambuaya
96.05.10.2002|Huberita
96.05.10.2003|Faitmajin
96.05.10.2004|Ismayo
96.05.10.2005|Sefayit
96.05.10.2006|Insas
96.05.10.2007|Faitsiur
96.05.10.2008|Keyum
96.05.11.2001|Suswa
96.05.11.2002|Seya
96.05.11.2003|Waban
96.05.11.2004|Kombif
96.05.11.2005|Rufases
96.05.11.2006|Bakrabi
96.05.11.2007|Nafasi
96.05.11.2008|Mahos
96.05.11.2009|Sawo
96.05.12.2001|Mupas
96.05.12.2002|Kamat
96.05.12.2003|Frambu
96.05.12.2004|Ayata
96.05.12.2005|Aikus
96.05.12.2006|Aiwesa
96.05.12.2007|Pitor
96.05.12.2008|Aifam
96.05.12.2009|Saud
96.05.12.2010|Tiam
96.05.12.2011|Faan Kahrio
96.05.12.2012|Assem
96.05.13.2001|Ainesra
96.05.13.2002|Aimau
96.05.13.2003|Mesyam
96.05.13.2004|Aisasior
96.05.13.2005|Franeway
96.05.13.2006|Aikingging
96.05.13.2007|Tiefromen
96.05.14.2001|Wormu
96.05.14.2002|Makiri
96.05.14.2003|Warba
96.05.14.2004|Winuni
96.05.14.2005|Srumate
96.05.14.2006|Womba
96.05.15.2001|Sauf
96.05.15.2002|Sembaro
96.05.15.2003|Koma Koma
96.05.15.2004|Kanisabar
96.05.15.2005|Sfarare
96.05.15.2006|Saneh
96.05.15.2007|Lemauk Klit
96.05.15.2008|Hawioh
96.05.15.2009|Simiyah
96.05.15.2010|Sagrim
96.05.16.2001|Adoh
96.05.16.2002|Temel
96.05.16.2003|Sosian
96.05.16.2004|Segior
96.05.16.2005|Orain
96.05.16.2006|Rawas
96.05.16.2007|Orsu
96.05.16.2008|Soan
96.05.16.2009|Warbo
96.05.16.2010|Woman
96.05.17.2001|Faitsimar
96.05.17.2002|Asses
96.05.17.2003|Fait Nigre
96.05.17.2004|Sufu
96.05.17.2005|Arus
96.05.17.2006|Kofait
96.05.17.2007|Isnum
96.05.18.2001|Kambuskato
96.05.18.2002|Kambuskato Utara
96.05.18.2003|Kambuifa
96.05.18.2004|Isusu
96.05.18.2005|Mano
96.05.18.2006|Sipat
96.05.18.2007|Faitwosur/Angkasa Pura
96.05.19.2001|Mapura
96.05.19.2002|Suwiam
96.05.19.2003|Tomase
96.05.19.2004|Frabo
96.05.19.2005|Karfa
96.05.19.2006|Kona
96.05.19.2007|Kosah
96.05.20.2001|Fiane
96.05.20.2002|Kartapura
96.05.20.2003|Men
96.05.20.2004|Semu
96.05.20.2005|Isme
96.05.20.2006|Rindu
96.05.20.2007|Tut
96.05.20.2008|Yohwer
96.05.20.2009|Hufioh
96.05.20.2010|Bawy
96.05.21.2001|Soroan
96.05.21.2002|Fanse
96.05.21.2003|Chaliat
96.05.21.2004|Sfacko
96.05.21.2005|Sehu
96.05.21.2006|Tbo
96.05.21.2007|Sien
96.05.21.2008|Sfaraka
96.05.22.2001|Yaksoro
96.05.22.2002|Awit
96.05.22.2003|Sira
96.05.22.2004|Eway
96.05.22.2005|Erokwero
96.05.22.2006|Sabun
96.05.22.2007|Itigah
96.05.22.2008|Sira Tee
96.05.22.2009|Wrait 'U'
96.05.22.2010|Way 'U'
96.05.22.2011|Asnaif
96.05.22.2012|Iroh Sohser
96.05.22.2013|Framboh
96.05.22.2014|Tohmri
96.05.23.2001|Jitmau
96.05.23.2002|Ikuf
96.05.23.2003|Isir
96.05.23.2004|Jitmau Timur
96.05.23.2005|Ikuf Utara
96.05.23.2006|Sarimo
96.05.23.2007|Kambusabo
96.05.23.2008|Srirtabam
96.05.23.2009|Faithowes
96.05.23.2010|Yumame
96.05.24.2001|Seni
96.05.24.2002|Renis
96.05.24.2003|Sire
96.05.24.2004|Fase
96.05.24.2005|Sabes
96.05.24.2006|Kuraso
96.05.24.2007|Sidi
96.05.24.2008|Osom
96.05.24.2009|Sire Timur
96.71.01.1001|Remu Utara
96.71.01.1002|Klademak
96.71.01.1003|Kofkerbu
96.71.01.1004|Remu
96.71.02.1001|Klawalu
96.71.02.1002|Klamana
96.71.02.1003|Klawuyuk
96.71.02.1004|Kladufu
96.71.03.1001|Rufei
96.71.03.1002|Klawasi
96.71.03.1003|Puncak Cendrawasih
96.71.03.1004|Pal Putih
96.71.04.1001|Dum Barat
96.71.04.1002|Dum Timur
96.71.04.1003|Soop
96.71.04.1004|Raam
96.71.05.1001|Malanu
96.71.05.1002|Malasilen
96.71.05.1003|Matalamagi
96.71.05.1004|Sawagumu
96.71.06.1001|Klaligi
96.71.06.1002|Malawei
96.71.06.1003|Malabutor
96.71.06.1004|Remu Selatan
96.71.06.1005|Klasabi
96.71.07.1001|Kampung Baru
96.71.07.1002|Klabala
96.71.07.1003|Klasuur
96.71.07.1004|Klakublik
96.71.08.1001|Klasuat
96.71.08.1002|Klablim
96.71.08.1003|Klasaman
96.71.08.1004|Giwu
96.71.09.1001|Klagete
96.71.09.1002|Malaingkedi
96.71.09.1003|Malamso
96.71.09.1004|Klabulu
96.71.10.1001|Suprau
96.71.10.1002|Tampa Garam
96.71.10.1003|Saoka
96.71.10.1004|Tanjung Kasuari
$wilayah$, E'\r?\n') as baris
  where baris <> ''
) as d
order by length(kode), kode
on conflict (kode) do update
  set nama = excluded.nama, tingkat = excluded.tingkat, induk_kode = excluded.induk_kode;
