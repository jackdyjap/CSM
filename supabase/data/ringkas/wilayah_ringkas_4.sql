-- Data wilayah Indonesia, versi RINGKAS untuk SQL Editor Supabase: bagian 4 dari 5.
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
35.29.19.2006|Gersik Putih
35.29.19.2007|Gapura Tengah
35.29.19.2008|Gapura Barat
35.29.19.2009|Panagan
35.29.19.2010|Palo'lo'an
35.29.19.2011|Banjar Timur
35.29.19.2012|Banjar Barat
35.29.19.2013|Batudinding
35.29.19.2014|Baban
35.29.19.2015|Karangbudi
35.29.19.2016|Braji
35.29.19.2017|Poja
35.29.20.2001|Pancor
35.29.20.2002|Prambanan
35.29.20.2003|Gendang Timur
35.29.20.2004|Karang Tengah
35.29.20.2005|Jambuir
35.29.20.2006|Gayam
35.29.20.2007|Kalowang
35.29.20.2008|Nyamplong
35.29.20.2009|Gendang Barat
35.29.20.2010|Tarebung
35.29.21.2001|Nonggunong
35.29.21.2002|Somber
35.29.21.2003|Tanah Merah
35.29.21.2004|Sokaramme Timur
35.29.21.2005|Sokarami Paseser
35.29.21.2006|Talaga
35.29.21.2007|Rosong
35.29.21.2008|Sonok
35.29.22.2001|Ketupat
35.29.22.2002|Jungkat
35.29.22.2003|Kropoh
35.29.22.2004|Karangnangka
35.29.22.2005|Alas Malang
35.29.22.2006|Poteran
35.29.22.2007|Brakas
35.29.22.2008|Tonduk
35.29.22.2009|Guwa-Guwa
35.29.23.2001|Sukajeruk
35.29.23.2002|Masalima
35.29.23.2003|Masakambing
35.29.23.2004|Kramian
35.29.24.2001|Pajanangger
35.29.24.2008|Sawah Sumur
35.29.24.2009|Paseraman
35.29.24.2010|Gelaman
35.29.24.2011|Buddi
35.29.24.2012|Kolo-kolo
35.29.24.2013|Angkatan
35.29.24.2014|Kalisangka
35.29.24.2015|Bilis-bilis
35.29.24.2016|Laok Jang-Jang
35.29.24.2017|Sumbernangka
35.29.24.2018|Duko
35.29.24.2019|Kalikatak
35.29.24.2020|Arjasa
35.29.24.2021|Kalinganyar
35.29.24.2022|Angon-angon
35.29.24.2023|Sambakati
35.29.24.2024|Pandeman
35.29.24.2025|Pabean
35.29.25.2001|Sepanjang
35.29.25.2002|Tanjung Kiaok
35.29.25.2003|Sakala
35.29.25.2004|Pagerungan Besar
35.29.25.2005|Pagerungan Kecil
35.29.25.2006|Saseel
35.29.25.2007|Sapeken
35.29.25.2008|Sabunten
35.29.25.2009|Paliat
35.29.25.2010|Sadulang
35.29.25.2011|Saur Saebus
35.29.26.2001|Patean
35.29.26.2002|Babbalan
35.29.26.2003|Gedungan
35.29.26.2004|Gunggung
35.29.26.2005|Batuan
35.29.26.2006|Torbang
35.29.26.2007|Gelugur
35.29.27.2001|Saobi
35.29.27.2002|Kangayan
35.29.27.2003|Torjek
35.29.27.2004|Cangkramaan
35.29.27.2005|Tembayangan
35.29.27.2006|Batuputih
35.29.27.2007|Daandung
35.29.27.2008|Timur Jang-Jang
35.29.27.2009|Jukong-jukong
35.71.01.1001|Bandar Lor
35.71.01.1002|Bandar Kidul
35.71.01.1003|Banjarmlati
35.71.01.1004|Pojok
35.71.01.1005|Sukorame
35.71.01.1006|Bujel
35.71.01.1007|Gayam
35.71.01.1008|Mrican
35.71.01.1009|Dermo
35.71.01.1010|Ngampel
35.71.01.1011|Mojoroto
35.71.01.1012|Campurejo
35.71.01.1013|Lirboyo
35.71.01.1014|Tamanan
35.71.02.1001|Semampir
35.71.02.1002|Balowerti
35.71.02.1003|Dandangan
35.71.02.1004|Ngadirejo
35.71.02.1005|Kampung Dalem
35.71.02.1006|Setonopande
35.71.02.1007|Ringinanom
35.71.02.1008|Pakelan
35.71.02.1009|Setonogedong
35.71.02.1010|Kemasan
35.71.02.1011|Jagalan
35.71.02.1012|Banjaran
35.71.02.1013|Kaliombo
35.71.02.1014|Ngronggo
35.71.02.1015|Manisrenggo
35.71.02.1016|Pocanan
35.71.02.1017|Rejomulyo
35.71.03.1001|Bangsal
35.71.03.1002|Pakunden
35.71.03.1003|Tosaren
35.71.03.1004|Jamsaren
35.71.03.1005|Singonegaran
35.71.03.1006|Blabak
35.71.03.1007|Betet
35.71.03.1008|Tinalan
35.71.03.1009|Bawang
35.71.03.1010|Ngletih
35.71.03.1011|Tempurejo
35.71.03.1012|Ketami
35.71.03.1013|Pesantren
35.71.03.1014|Banaran
35.71.03.1015|Burengan
35.72.01.1001|Kepanjenkidul
35.72.01.1002|Ngadirejo
35.72.01.1003|Sentul
35.72.01.1004|Kauman
35.72.01.1005|Tanggung
35.72.01.1006|Bendo
35.72.01.1007|Kepanjenlor
35.72.02.1001|Pakunden
35.72.02.1002|Blitar
35.72.02.1003|Tlumpu
35.72.02.1004|Turi
35.72.02.1005|Karangsari
35.72.02.1006|Sukorejo
35.72.02.1007|Tanjungsari
35.72.03.1001|Gedog
35.72.03.1002|Plosokerep
35.72.03.1003|Klampok
35.72.03.1004|Sananwetan
35.72.03.1005|Rembang
35.72.03.1006|Karangtengah
35.72.03.1007|Bendogerit
35.73.01.1001|Balearjosari
35.73.01.1002|Arjosari
35.73.01.1003|Polowijen
35.73.01.1004|Purwodadi
35.73.01.1005|Blimbing
35.73.01.1006|Pandanwangi
35.73.01.1007|Purwantoro
35.73.01.1008|Bunulrejo
35.73.01.1009|Kesatrian
35.73.01.1010|Polehan
35.73.01.1011|Jodipan
35.73.02.1001|Klojen
35.73.02.1002|Rampalcelaket
35.73.02.1003|Samaan
35.73.02.1004|Kiduldalem
35.73.02.1005|Sukoharjo
35.73.02.1006|Kasin
35.73.02.1007|Kauman
35.73.02.1008|Oro-oro Dowo
35.73.02.1009|Bareng
35.73.02.1010|Gading Kasri
35.73.02.1011|Penanggungan
35.73.03.1001|Kotalama
35.73.03.1002|Mergosono
35.73.03.1003|Bumiayu
35.73.03.1004|Wonokoyo
35.73.03.1005|Buring
35.73.03.1006|Kedungkandang
35.73.03.1007|Lesanpuro
35.73.03.1008|Sawojajar
35.73.03.1009|Madyopuro
35.73.03.1010|Cemorokandang
35.73.03.1011|Arjowinangun
35.73.03.1012|Tlogowaru
35.73.04.1001|Ciptomulyo
35.73.04.1002|Gadang
35.73.04.1003|Kebonsari
35.73.04.1004|Bandungrejosari
35.73.04.1005|Sukun
35.73.04.1006|Tanjungrejo
35.73.04.1007|Pisangcandi
35.73.04.1008|Bandulan
35.73.04.1009|Karangbesuki
35.73.04.1010|Mulyorejo
35.73.04.1011|Bakalankrajan
35.73.05.1001|Tunggulwulung
35.73.05.1002|Merjosari
35.73.05.1003|Tlogomas
35.73.05.1004|Dinoyo
35.73.05.1005|Sumbersari
35.73.05.1006|Ketawanggede
35.73.05.1007|Jatimulyo
35.73.05.1008|Tunjungsekar
35.73.05.1009|Mojolangu
35.73.05.1010|Tulusrejo
35.73.05.1011|Lowokwaru
35.73.05.1012|Tasik Madu
35.74.01.1001|Ketapang
35.74.01.1002|Triwung Lor
35.74.01.1003|Triwung Kidul
35.74.01.1007|Pohsangit Kidul
35.74.01.1008|Kademangan
35.74.01.1009|Pilang
35.74.02.1001|Jrebeng Kidul
35.74.02.1002|Pakistaji
35.74.02.1003|Kedunggaleng
35.74.02.1005|Kedung Asem
35.74.02.1006|Sumber Taman
35.74.02.1007|Wonoasih
35.74.03.1001|Mayangan
35.74.03.1002|Mangunharjo
35.74.03.1004|Jati
35.74.03.1007|Sukabumi
35.74.03.1010|Wiroborang
35.74.04.1001|Tisnonegaran
35.74.04.1002|Sukoharjo
35.74.04.1003|Kanigaran
35.74.04.1004|Kebonsari Wetan
35.74.04.1005|Curahgrinting
35.74.04.1006|Kebonsari Kulon
35.74.05.1001|Jrebeng Kulon
35.74.05.1002|Kareng Lor
35.74.05.1003|Sumber Wetan
35.74.05.1004|Jrebeng Lor
35.74.05.1005|Kedopok
35.74.05.1006|Jrebeng Wetan
35.75.01.1001|Karangketug
35.75.01.1002|Gentong
35.75.01.1003|Sebani
35.75.01.1004|Petahunan
35.75.01.1005|Bukir
35.75.01.1006|Randusari
35.75.01.1007|Krapyakrejo
35.75.01.1009|Gadingrejo
35.75.02.1001|Pohjentrek
35.75.02.1002|Wirogunan
35.75.02.1003|Tembokrejo
35.75.02.1004|Purutrejo
35.75.02.1005|Kebonagung
35.75.02.1006|Purworejo
35.75.02.1011|Sekargadung
35.75.03.1001|Blandongan
35.75.03.1002|Kepel
35.75.03.1003|Tapa'an
35.75.03.1005|Bakalan
35.75.03.1006|Krampyangan
35.75.03.1009|Bugul Kidul
35.75.04.1001|Karanganyar
35.75.04.1002|Tamba'an
35.75.04.1003|Trajeng
35.75.04.1004|Bangilan
35.75.04.1005|Kebonsari
35.75.04.1006|Mayangan
35.75.04.1007|Ngemplakrejo
35.75.04.1008|Petamanan
35.75.04.1009|Pekuncen
35.75.04.1010|Bugul Lor
35.75.04.1011|Kandangsapi
35.75.04.1012|Panggungrejo
35.75.04.1013|Mandaranrejo
35.76.01.1003|Mentikan
35.76.01.1004|Kauman
35.76.01.1005|Pulorejo
35.76.01.1006|Prajuritkulon
35.76.01.1007|Surodinawan
35.76.01.1008|Blooto
35.76.02.1001|Gununggedangan
35.76.02.1003|Magersari
35.76.02.1004|Gedongan
35.76.02.1008|Balongsari
35.76.02.1009|Kedundung
35.76.02.1010|Wates
35.76.03.1001|Kranggan
35.76.03.1002|Miji
35.76.03.1003|Meri
35.76.03.1004|Jagalan
35.76.03.1005|Sentanan
35.76.03.1006|Purwotengah
35.77.01.1001|Oro-oro Ombo
35.77.01.1002|Sukosari
35.77.01.1003|Klegen
35.77.01.1004|Rejomulyo
35.77.01.1005|Pilangbango
35.77.01.1006|Tawangrejo
35.77.01.1007|Kanigoro
35.77.01.1008|Kartoharjo
35.77.01.1009|Kelun
35.77.02.1001|Manguharjo
35.77.02.1002|Sogaten
35.77.02.1003|Patihan
35.77.02.1004|Ngegong
35.77.02.1005|Winongo
35.77.02.1006|Madiun Lor
35.77.02.1007|Pangongangan
35.77.02.1008|Nambangan Lor
35.77.02.1009|Nambangan Kidul
35.77.03.1001|Mojorejo
35.77.03.1002|Pandean
35.77.03.1003|Banjarejo
35.77.03.1004|Kuncen
35.77.03.1005|Manisrejo
35.77.03.1006|Kejuron
35.77.03.1007|Josenan
35.77.03.1008|Demangan
35.77.03.1009|Taman
35.78.01.1001|Karang Pilang
35.78.01.1002|Kebraon
35.78.01.1003|Kedurus
35.78.01.1004|Waru Gunung
35.78.02.1001|Sidosermo
35.78.02.1002|Bendul Merisi
35.78.02.1003|Margorejo
35.78.02.1004|Jemur Wonosari
35.78.02.1005|Siwalankerto
35.78.03.1001|Kalirungkut
35.78.03.1002|Rungkut Kidul
35.78.03.1003|Kedung Baruk
35.78.03.1004|Penjaringansari
35.78.03.1005|Wonorejo
35.78.03.1006|Medokan Ayu
35.78.04.1001|Wonokromo
35.78.04.1002|Jagir
35.78.04.1003|Ngagel
35.78.04.1004|Ngagel Rejo
35.78.04.1005|Darmo
35.78.04.1006|Sawunggaling
35.78.05.1001|Tegalsari
35.78.05.1002|Dr. Soetomo
35.78.05.1003|Kedungdoro
35.78.05.1004|Keputran
35.78.05.1005|Wonorejo
35.78.06.1001|Petemon
35.78.06.1002|Sawahan
35.78.06.1003|Banyu Urip
35.78.06.1004|Putat Jaya
35.78.06.1005|Kupang Krajan
35.78.06.1006|Pakis
35.78.07.1001|Embong Kaliasin
35.78.07.1002|Genteng
35.78.07.1003|Kapasari
35.78.07.1004|Ketabang
35.78.07.1005|Peneleh
35.78.08.1001|Gubeng
35.78.08.1002|Mojo
35.78.08.1003|Airlangga
35.78.08.1004|Kertajaya
35.78.08.1005|Baratajaya
35.78.08.1006|Pucang Sewu
35.78.09.1001|Keputih
35.78.09.1002|Gebang Putih
35.78.09.1003|Klampis Ngasem
35.78.09.1004|Menur Pumpungan
35.78.09.1005|Nginden Jangkungan
35.78.09.1006|Semolowaru
35.78.09.1007|Medokan Semampir
35.78.10.1001|Tambaksari
35.78.10.1002|Ploso
35.78.10.1003|Gading
35.78.10.1004|Pacarkembang
35.78.10.1005|Rangkah
35.78.10.1006|Pacarkeling
35.78.10.1007|Kapasmadya Baru
35.78.10.1008|Dukuh Setro
35.78.11.1001|Simokerto
35.78.11.1002|Kapasan
35.78.11.1003|Sidodadi
35.78.11.1004|Simolawang
35.78.11.1005|Tambakrejo
35.78.12.1001|Bongkaran
35.78.12.1002|Nyamplungan
35.78.12.1003|Krembangan Utara
35.78.12.1006|Tanjung Perak
35.78.13.1001|Alun-alun Contong
35.78.13.1002|Bubutan
35.78.13.1003|Gundih
35.78.13.1004|Jepara
35.78.13.1005|Tembok Dukuh
35.78.14.1002|Tandes
35.78.14.1006|Karang Poh
35.78.14.1007|Balongsari
35.78.14.1009|Manukan Kulon
35.78.14.1011|Manukan Wetan
35.78.14.1012|Banjar Sugihan
35.78.15.1001|Krembangan Selatan
35.78.15.1002|Kemayoran
35.78.15.1003|Perak Barat
35.78.15.1004|Dupak
35.78.15.1005|Morokrembangan
35.78.16.1001|Ampel
35.78.16.1002|Pegirian
35.78.16.1003|Wonokusumo
35.78.16.1004|Ujung
35.78.16.1005|Sidotopo
35.78.17.1001|Tanah Kali Kedinding
35.78.17.1002|Sidotopo Wetan
35.78.17.1003|Bulak Banteng
35.78.17.1004|Tambak Wedi
35.78.18.1001|Bangkingan
35.78.18.1002|Jeruk
35.78.18.1003|Lakarsantri
35.78.18.1004|Lidah kulon
35.78.18.1005|Lidah Wetan
35.78.18.1006|Sumurwelut
35.78.19.1001|Kandangan
35.78.19.1003|Sememi
35.78.19.1004|Tambak Oso Wilangun
35.78.19.1005|Romokalisari
35.78.20.1001|Wiyung
35.78.20.1002|Jajar Tunggal
35.78.20.1003|Babatan
35.78.20.1004|Balas Klumprik
35.78.21.1001|Dukuh Pakis
35.78.21.1002|Dukuh Kupang
35.78.21.1003|Gunung Sari
35.78.21.1004|Pradah Kalikendal
35.78.22.1001|Gayungan
35.78.22.1002|Menanggal
35.78.22.1003|Dukuh Menanggal
35.78.22.1004|Ketintang
35.78.23.1001|Jambangan
35.78.23.1002|Karah
35.78.23.1003|Kebonsari
35.78.23.1004|Pagesangan
35.78.24.1001|Kutisari
35.78.24.1002|Kendangsari
35.78.24.1003|Tenggilis Mejoyo
35.78.24.1004|Panjang Jiwo
35.78.25.1001|Gunung Anyar
35.78.25.1002|Rungkut Tengah
35.78.25.1003|Rungkut Menanggal
35.78.25.1004|Gunung Anyar Tambak
35.78.26.1001|Mulyorejo
35.78.26.1002|Manyar Sabrangan
35.78.26.1003|Kejawan Putih Tambak
35.78.26.1004|Kalisari
35.78.26.1005|Dukuh Sutorejo
35.78.26.1006|Kalijudan
35.78.27.1001|Sukomanunggal
35.78.27.1002|Tanjungsari
35.78.27.1003|Sonokwijenan
35.78.27.1004|Putat Gede
35.78.27.1005|Simomulyo
35.78.27.1006|Simomulyo Baru
35.78.28.1001|Asem Rowo
35.78.28.1002|Genting Kalianak
35.78.28.1005|Tambak Sarioso
35.78.29.1001|Kedung Cowek
35.78.29.1003|Kenjeran
35.78.29.1004|Bulak
35.78.29.1005|Sukolilo Baru
35.78.30.1001|Pakal
35.78.30.1002|Babat Jerawat
35.78.30.1004|Sumber Rejo
35.78.30.1005|Benowo
35.78.31.1001|Sambikerep
35.78.31.1002|Made
35.78.31.1003|Beringin
35.78.31.1004|Lontar
35.79.01.1001|Temas
35.79.01.1002|Ngaglik
35.79.01.1003|Songgokerto
35.79.01.1004|Sisir
35.79.01.2005|Sumberejo
35.79.01.2006|Oro-oro Ombo
35.79.01.2007|Sidomulyo
35.79.01.2008|Pesanggrahan
35.79.02.2001|Punten
35.79.02.2002|Gunungsari
35.79.02.2003|Tulungrejo
35.79.02.2004|Sumbergondo
35.79.02.2005|Pandanrejo
35.79.02.2006|Bumiaji
35.79.02.2007|Giripurno
35.79.02.2008|Bulukerto
35.79.02.2009|Sumberbrantas
35.79.03.1001|Dadaprejo
35.79.03.2002|Beji
35.79.03.2003|Junrejo
35.79.03.2004|Tlekung
35.79.03.2005|Mojorejo
35.79.03.2006|Pendem
35.79.03.2007|Torongrejo
36.01.01.2001|Sumberjaya
36.01.01.2002|Kertajaya
36.01.01.2003|Kertamukti
36.01.01.2004|Tunggaljaya
36.01.01.2005|Cigorondong
36.01.01.2006|Tamanjaya
36.01.01.2007|Ujungjaya
36.01.02.2001|Rancapinang
36.01.02.2002|Cibadak
36.01.02.2003|Tugu
36.01.02.2004|Batuhideung
36.01.02.2005|Padasuka
36.01.02.2006|Ciburial
36.01.02.2007|Cijaralang
36.01.02.2008|Cimanggu
36.01.02.2009|Mangkualam
36.01.02.2010|Tangkil Sari
36.01.02.2011|Waringin Kurung
36.01.02.2012|Kramatjaya
36.01.03.2001|Mendung
36.01.03.2006|Sudimanik
36.01.03.2007|Curug
36.01.03.2008|Cibingbin
36.01.03.2009|Sukajadi
36.01.03.2011|Mahendra
36.01.03.2012|Cibaliung
36.01.03.2015|Cihanjuang
36.01.03.2016|Sorongan
36.01.04.2001|Tanjungan
36.01.04.2002|Sumurbatu
36.01.04.2003|Sukawaris
36.01.04.2004|Rancaseneng
36.01.04.2005|Parungkokosan
36.01.04.2006|Nanggala
36.01.04.2007|Cikeusik
36.01.04.2008|Cikadongdong
36.01.04.2009|Curugciung
36.01.04.2010|Leuwibalang
36.01.04.2011|Sukaseneng
36.01.04.2012|Sukamulya
36.01.04.2013|Umbulan
36.01.04.2014|Cikiruhwetan
36.01.05.2001|Karangbolong
36.01.05.2002|Katumbiri
36.01.05.2003|Waringinjaya
36.01.05.2004|Karyabuana
36.01.05.2005|Tarumanagara
36.01.05.2006|Ciseureuheun
36.01.05.2007|Banyuasih
36.01.05.2009|Cigeulis
36.01.05.2010|Sinarjaya
36.01.06.2001|Panimbangjaya
36.01.06.2002|Mekarjaya
36.01.06.2004|Gombong
36.01.06.2009|Mekarsari
36.01.06.2011|Citeureup
36.01.06.2012|Tanjungjaya
36.01.07.2001|Angsana
36.01.07.2002|Padaherang
36.01.07.2003|Padamulya
36.01.07.2004|Karangsari
36.01.07.2005|Cikayas
36.01.07.2006|Sumurlaban
36.01.07.2007|Kadubadak
36.01.07.2009|Cipinang
36.01.07.2010|Kramatmanik
36.01.08.2001|Pasanggrahan
36.01.08.2002|Sukasaba
36.01.08.2005|Gunungbatu
36.01.08.2006|Panacaran
36.01.08.2007|Curuglanglang
36.01.08.2008|Munjul
36.01.08.2009|Cibitung
36.01.08.2011|Kotadukuh
36.01.08.2018|Lebak
36.01.09.2001|Sukadame
36.01.09.2002|Pagelaran
36.01.09.2003|Surakarta
36.01.09.2004|Montor
36.01.09.2005|Kertasana
36.01.09.2006|Bama
36.01.09.2007|Margasana
36.01.09.2008|Sindanglaya
36.01.09.2009|Tegalpapak
36.01.09.2010|Bulagor
36.01.09.2011|Harapankarya
36.01.09.2012|Senangsari
36.01.09.2013|Margagiri
36.01.10.2001|Mekarsari
36.01.10.2002|Cijakan
36.01.10.2003|Geredug
36.01.10.2004|Bojong
36.01.10.2005|Banyumas
36.01.10.2006|Citumenggung
36.01.10.2007|Manggungjaya
36.01.10.2008|Cahayamekar
36.01.11.2001|Pasirsedang
36.01.11.2002|Cililitan
36.01.11.2003|Kadupandak
36.01.11.2004|Kolelet
36.01.11.2005|Ciherang
36.01.11.2006|Bungurcopong
36.01.11.2007|Pasirpanjang
36.01.11.2008|Kadubera
36.01.11.2009|Ganggaeng
36.01.12.2001|Rancateureup
36.01.12.2002|Labuan
36.01.12.2003|Banyubiru
36.01.12.2004|Caringin
36.01.12.2010|Teluk
36.01.12.2012|Cigondang
36.01.12.2013|Kalanganyar
36.01.12.2014|Sukamaju
36.01.12.2015|Banyumekar
36.01.13.2001|Alaswangi
36.01.13.2002|Tegalwangi
36.01.13.2003|Kananga
36.01.13.2004|Cigandeng
36.01.13.2005|Menes
36.01.13.2006|Muruy
36.01.13.2010|Sukamanah
36.01.13.2011|Purwaraja
36.01.13.2012|Sindangkarya
36.01.13.2013|Cilabanbulan
36.01.13.2015|Kadupayung
36.01.13.2016|Ramaya
36.01.14.2001|Langensari
36.01.14.2002|Medalsari
36.01.14.2003|Majau
36.01.14.2004|Sodong
36.01.14.2005|Talagasari
36.01.14.2006|Ciandur
36.01.14.2007|Kadudampit
36.01.14.2008|Wanagiri
36.01.14.2009|Parigi
36.01.14.2010|Mekarwangi
36.01.14.2011|Saketi
36.01.14.2012|Girijaya
36.01.14.2013|Sindanghayu
36.01.14.2014|Sukalangu
36.01.15.2001|Palanyar
36.01.15.2002|Baturanjang
36.01.15.2003|Cikadueun
36.01.15.2004|Koncang
36.01.15.2005|Kadugadung
36.01.15.2006|Parumasan
36.01.15.2007|Curugbarang
36.01.15.2008|Kalanggunung
36.01.15.2009|Pasireurih
36.01.15.2010|Pasirmae
36.01.16.2001|Pamarayan
36.01.16.2002|Jiput
36.01.16.2003|Sukacai
36.01.16.2004|Tenjolahang
36.01.16.2005|Janaka
36.01.16.2006|Sikulan
36.01.16.2007|Citaman
36.01.16.2008|Jayamekar
36.01.16.2011|Sukamanah
36.01.16.2012|Salapraya
36.01.16.2013|Banyuresmi
36.01.16.2014|Sampang Bitung
36.01.16.2015|Babadsari
36.01.17.2001|Pandat
36.01.17.2002|Cikoneng
36.01.17.2003|Nembol
36.01.17.2004|Kurungkambing
36.01.17.2005|Mandalawangi
36.01.17.2006|Sinarjaya
36.01.17.2007|Sirnagalih
36.01.17.2008|Cikumbuen
36.01.17.2009|Ramea
36.01.17.2010|Gunungsari
36.01.17.2011|Panjangjaya
36.01.17.2012|Giripawana
36.01.17.2013|Mandalasari
36.01.17.2014|Curuglemo
36.01.17.2015|Pari
36.01.18.2001|Cimanuk
36.01.18.2002|Batubantar
36.01.18.2003|Kadubungbang
36.01.18.2004|Kupahandap
36.01.18.2005|Dalembalar
36.01.18.2006|Kadumadang
36.01.18.2007|Rocek
36.01.18.2008|Kadudodol
36.01.18.2010|Gunungdatar
36.01.18.2013|Sekong
36.01.18.2015|Gunungcupu
36.01.19.2001|Campaka
36.01.19.2002|Banyumundu
36.01.19.2003|Mandalasari
36.01.19.2004|Sukasari
36.01.19.2005|Saninten
36.01.19.2006|Palurahan
36.01.19.2007|Sukamanah
36.01.19.2008|Kadugemblo
36.01.19.2009|Banjarsari
36.01.19.2010|Ciputri
36.01.20.2002|Citalahab
36.01.20.2004|Kadulimus
36.01.20.2005|Bandung
36.01.20.2006|Mogana
36.01.20.2007|Banjar
36.01.20.2008|Gunungputri
36.01.20.2010|Cibodas
36.01.20.2011|Kadubale
36.01.20.2012|Cibeureum
36.01.20.2013|Kadumaneuh
36.01.20.2014|Pasirawi
36.01.21.1002|Kadomas
36.01.21.1003|Babakan Kalanganyar
36.01.21.1004|Kabayan
36.01.21.1009|Pandeglang
36.01.22.2001|Kaduengang
36.01.22.2002|Pasirpeuteuy
36.01.22.2003|Kurungdahu
36.01.22.2004|Kaduela
36.01.22.2005|Koranji
36.01.22.2006|Tapos
36.01.22.2007|Cadasari
36.01.22.2008|Ciinjuk
36.01.22.2009|Kaungcaang
36.01.22.2010|Cikentrung
36.01.22.2013|Tanagara
36.01.23.2001|Rawasari
36.01.23.2002|Pasireurih
36.01.23.2003|Kaduronyok
36.01.23.2004|Cibarani
36.01.23.2005|Cisereh
36.01.23.2006|Kubangkondang
36.01.23.2007|Kondangjaya
36.01.23.2008|Ciherangjaya
36.01.23.2009|Palembang
36.01.24.2006|Turus
36.01.24.2008|Patia
36.01.24.2009|Pasirgadung
36.01.24.2010|Cimoyan
36.01.24.2011|Idaman
36.01.24.2014|Babakankeusik
36.01.24.2015|Surianeun
36.01.24.2017|Rahayu
36.01.24.2018|Ciawi
36.01.24.2020|Simpangtiga
36.01.25.1001|Kadumerak
36.01.25.1002|Cigadung
36.01.25.1003|Pagadungan
36.01.25.1014|Juhut
36.01.26.2001|Karyasari
36.01.26.2002|Tegal
36.01.26.2003|Cipicung
36.01.26.2004|Dahu
36.01.26.2005|Babakanlor
36.01.26.2006|Karyautama
36.01.26.2007|Mekarjaya
36.01.26.2008|Padahayu
36.01.26.2009|Cening
36.01.26.2010|Bangkuyung
36.01.27.2001|Sindangkerta
36.01.27.2002|Manglid
36.01.27.2003|Cikiruh
36.01.27.2004|Cikadu
36.01.27.2005|Kiarapayung
36.01.27.2006|Kutakarang
36.01.27.2007|Citeluk
36.01.27.2008|Kiarajangkung
36.01.27.2009|Cikalong
36.01.27.2010|Malangnengah
36.01.28.2001|Banjarmasin
36.01.28.2002|Carita
36.01.28.2003|Sukarame
36.01.28.2004|Sukanegara
36.01.28.2005|Cinoyong
36.01.28.2006|Pejamben
36.01.28.2007|Sukajadi
36.01.28.2008|Kawoyang
36.01.28.2009|Tembong
36.01.28.2010|Sindanglaut
36.01.29.2001|Seuseupan
36.01.29.2002|Karyasari
36.01.29.2003|Perdana
36.01.29.2004|Sukaresmi
36.01.29.2005|Pasirkadu
36.01.29.2006|Kubangkampil
36.01.29.2007|Sidamukti
36.01.29.2008|Cibungur
36.01.29.2009|Weru
36.01.29.2010|Cikuya
36.01.30.2001|Kadubelang
36.01.30.2002|Pareang
36.01.30.2003|Wirasinga
36.01.30.2004|Rancabugel
36.01.30.2005|Kadujangkung
36.01.30.2006|Medong
36.01.30.2007|Sukamulya
36.01.30.2008|Mekarjaya
36.01.31.2001|Ciodeng
36.01.31.2002|Pasirtenjo
36.01.31.2003|Bojongmanik
36.01.31.2004|Campakawarna
36.01.31.2005|Pasirloa
36.01.31.2006|Pasirlancar
36.01.31.2007|Sindangresmi
36.01.31.2008|Pasirdurung
36.01.31.2009|Kadumalati
36.01.32.2001|Koranji
36.01.32.2002|Banjarwangi
36.01.32.2003|Sukasari
36.01.32.2004|Karyawangi
36.01.32.2005|Sukaraja
36.01.32.2006|Kaduhejo
36.01.32.2007|Banjarnegara
36.01.32.2008|Sanghiangdengdek
36.01.32.2009|Cilentung
36.01.33.2001|Sukajaya
36.01.33.2002|Awilega
36.01.33.2003|Gerendong
36.01.33.2004|Koroncong
36.01.33.2005|Pakuluran
36.01.33.2006|Setrajaya
36.01.33.2007|Karangsetra
36.01.33.2008|Paniis
36.01.33.2009|Bangkonol
36.01.33.2010|Pasirjaksa
36.01.33.2011|Pasirkarag
36.01.33.2012|Tegalongok
36.01.34.1001|Sukaratu
36.01.34.1002|Karaton
36.01.34.1003|Saruni
36.01.34.1004|Pagerbatu
36.01.34.1005|Cilaja
36.01.35.2001|Cimanis
36.01.35.2002|Teluklada
36.01.35.2003|Kertaraharja
36.01.35.2004|Bojen
36.01.35.2005|Kutamekar
36.01.35.2006|Sobang
36.01.35.2007|Pangkalan
36.01.35.2008|Bojenwetan
36.02.01.2002|Cilangkahan
36.02.01.2003|Pagelaran
36.02.01.2004|Sukaraja
36.02.01.2005|Malingping Utara
36.02.01.2006|Bolang
36.02.01.2009|Cipeundeuy
36.02.01.2013|Rahong
36.02.01.2014|Kadujajar
36.02.01.2016|Kersaratu
36.02.01.2018|Malingping Selatan
36.02.01.2019|Sumberwaras
36.02.01.2023|Sukamanah
36.02.01.2024|Senanghati
36.02.01.2026|Sangiang
36.02.02.2002|Panggarangan
36.02.02.2003|Jatake
36.02.02.2004|Sogong
36.02.02.2005|Cimandiri
36.02.02.2009|Gununggede
36.02.02.2010|Situregen
36.02.02.2011|Mekarjaya
36.02.02.2014|Sindangratu
36.02.02.2017|Hegarmanah
36.02.02.2018|Sukajadi
36.02.02.2019|Cibarengkok
36.02.03.2001|Bayah Barat
36.02.03.2002|Sawarna
36.02.03.2006|Cidikit
36.02.03.2007|Suwakan
36.02.03.2008|Cimancak
36.02.03.2011|Darmasari
36.02.03.2013|Bayah Timur
36.02.03.2014|Cisuren
36.02.03.2016|Pasirgombong
36.02.03.2017|Sawarna Timur
36.02.03.2018|Pamubulan
36.02.04.2002|Cipanas
36.02.04.2003|Girilaya
36.02.04.2004|Malangsari
36.02.04.2005|Bintangresmi
36.02.04.2006|Talagahiyang
36.02.04.2007|Luhurjaya
36.02.04.2008|Haurgajrug
36.02.04.2009|Giriharja
36.02.04.2010|Sukasari
36.02.04.2013|Jayapura
36.02.04.2014|Sipayung
36.02.04.2015|Bintangsari
36.02.04.2016|Pasirhaur
36.02.04.2020|Harumsari
36.02.05.2003|Pasireurih
36.02.05.2004|Ciminyak
36.02.05.2005|Muncang
36.02.05.2006|Leuwicoo
36.02.05.2007|Sindangwangi
36.02.05.2008|Cikarang
36.02.05.2012|Sukanagara
36.02.05.2013|Pasirnangka
36.02.05.2018|Jagaraksa
36.02.05.2019|Tanjungwangi
36.02.05.2020|Mekarwangi
36.02.05.2021|Girijagabaya
36.02.06.2001|Kanekes
36.02.06.2002|Cisimeut
36.02.06.2003|Cibungur
36.02.06.2004|Leuwidamar
36.02.06.2005|Lebakparahiang
36.02.06.2006|Sangkanwangi
36.02.06.2007|Nayagati
36.02.06.2008|Bojongmenteng
36.02.06.2009|Margawangi
36.02.06.2010|Wantisari
36.02.06.2011|Jalupangmulya
36.02.06.2012|Cisimeut Raya
36.02.07.2004|Bojongmanik
36.02.07.2007|Harjawana
36.02.07.2008|Kadurahayu
36.02.07.2009|Cimayang
36.02.07.2010|Parakanbeusi
36.02.07.2012|Keboncau
36.02.07.2014|Mekarmanik
36.02.07.2016|Mekar Rahayu
36.02.07.2017|Pasirbitung
36.02.08.2001|Gunungkencana
36.02.08.2002|Cimanyangray
36.02.08.2003|Gunungkendeng
36.02.08.2004|Cisampang
36.02.08.2005|Ciginggang
36.02.08.2006|Ciakar
36.02.08.2007|Cicaringin
36.02.08.2008|Bulakan
36.02.08.2009|Sukanegara
36.02.08.2010|Bojongkoneng
36.02.08.2011|Kramatjaya
36.02.08.2012|Tanjungsari Indah
36.02.09.2001|Kerta
36.02.09.2002|Bojongjuruh
36.02.09.2003|Leuwiipuh
36.02.09.2004|Lebakkeusik
36.02.09.2005|Cilegongilir
36.02.09.2006|Keusik
36.02.09.2007|Cibaturkeusik
36.02.09.2009|Kumpay
36.02.09.2010|Jalupanggirang
36.02.09.2011|Bendungan
36.02.09.2012|Kertaraharja
36.02.09.2013|Cisampih
36.02.09.2014|Gunungsari
36.02.09.2015|Tamansari
36.02.09.2016|Cidahu
36.02.09.2017|Ciruji
36.02.09.2018|Kaduhauk
36.02.09.2019|Labanjaya
36.02.09.2020|Umbuljaya
36.02.09.2021|Kertarahayu
36.02.10.2001|Pasindangan
36.02.10.2002|Parungkujang
36.02.10.2003|Cileles
36.02.10.2004|Cikareo
36.02.10.2005|Cipadang
36.02.10.2006|Gumuruh
36.02.10.2007|Prabugantungan
36.02.10.2008|Daroyon
36.02.10.2009|Margamulya
36.02.10.2010|Mekarjaya
36.02.10.2011|Kujangsari
36.02.10.2012|Banjarsari
36.02.11.2001|Sarageni
36.02.11.2002|Gununganten
36.02.11.2003|Sudamanik
36.02.11.2004|Tambak
36.02.11.2005|Cimarga
36.02.11.2006|Karyajaya
36.02.11.2007|Margajaya
36.02.11.2008|Jayamanik
36.02.11.2009|Margaluyu
36.02.11.2010|Margatirta
36.02.11.2011|Intenjaya
36.02.11.2012|Mekarjaya
36.02.11.2013|Jayasari
36.02.11.2014|Girimukti
36.02.11.2015|Sangkanmanik
36.02.11.2016|Sangiangjaya
36.02.11.2017|Mekarmulya
36.02.12.2001|Maraya
36.02.12.2002|Sajira
36.02.12.2003|Sukarame
36.02.12.2004|Calungbungur
36.02.12.2005|Parungsari
36.02.12.2006|Sindangsari
36.02.12.2007|Mekarsari
36.02.12.2008|Sukamarga
36.02.12.2009|Pajagan
36.02.12.2010|Sukajaya
36.02.12.2011|Sajira Mekar
36.02.12.2012|Paja
36.02.12.2013|Margaluyu
36.02.12.2014|Bungurmekar
36.02.12.2015|Ciuyah
36.02.13.2005|Tanjungsari
36.02.13.2006|Maja
36.02.13.2007|Sangiang
36.02.13.2008|Binong
36.02.13.2009|Gubugan Cibeureum
36.02.13.2011|Mekarsari
36.02.13.2012|Padasuka
36.02.13.2015|Curugbadak
36.02.13.2016|Sindangmulya
36.02.13.2018|Cilangkap
36.02.13.2020|Pasirkembang
36.02.13.2021|Pasirkecapi
36.02.13.2022|Buyut Mekar
36.02.13.2023|Maja Baru
36.02.14.1002|Rangkasbitung Barat
36.02.14.1006|Cijoro Lebak
36.02.14.1007|Muara Ciujung Barat
36.02.14.1008|Cijoro Pasir
36.02.14.1012|Muara Ciujung Timur
36.02.14.2001|Pasirtanjung
36.02.14.2009|Citeras
36.02.14.2010|Nameng
36.02.14.2011|Kolelet Wetan
36.02.14.2013|Jatimulya
36.02.14.2014|Mekarsari
36.02.14.2016|Pabuaran
36.02.14.2017|Rangkasbitung Timur
36.02.14.2019|Sukamanah
36.02.14.2021|Cimangeunteung
36.02.14.2023|Narimbang Mulia
36.02.15.2001|Sukarendah
36.02.15.2002|Warunggunung
36.02.15.2003|Cibuah
36.02.15.2004|Pasir Tangkil
36.02.15.2005|Baros
36.02.15.2006|Banjarsari
36.02.15.2007|Padasuka
36.02.15.2008|Sukaraja
36.02.15.2009|Jagabaya
36.02.15.2010|Selaraja
36.02.15.2011|Cempaka
36.02.15.2012|Sindangsari
36.02.16.2004|Mekarjaya
36.02.16.2006|Cipalabuh
36.02.16.2007|Cijaku
36.02.16.2008|Cibeureum
36.02.16.2012|Ciapus
36.02.16.2013|Kandangsapi
36.02.16.2014|Cihujan
36.02.16.2015|Cimenga
36.02.16.2016|Kapunduhan
36.02.16.2017|Sukasenang
36.02.17.2001|Anggalan
36.02.17.2002|Muncangkopong
36.02.17.2003|Sukaharja
36.02.17.2004|Tamanjaya
36.02.17.2005|Cigoong Utara
36.02.17.2006|Muaradua
36.02.17.2007|Cikulur
36.02.17.2008|Curugpanjang
36.02.17.2009|Cigoong Selatan
36.02.17.2010|Sumurbandung
36.02.17.2011|Parage
36.02.17.2012|Sukadaya
36.02.17.2013|Pasirgintung
36.02.18.2001|Tambakbaya
36.02.18.2002|Kaduagung Timur
36.02.18.2003|Panancangan
36.02.18.2004|Cibadak
36.02.18.2005|Asem
36.02.18.2006|Cisangu
36.02.18.2007|Kaduagung Barat
36.02.18.2008|Bojongcae
36.02.18.2009|Malabar
36.02.18.2010|Pasar Keong
36.02.18.2011|Bojong Leles
36.02.18.2012|Cimenteng Jaya
36.02.18.2013|Mekar Agung
36.02.18.2014|Asem Margaluyu
36.02.18.2015|Kaduagung Tengah
36.02.19.2001|Cibeber
36.02.19.2002|Citorek Tengah
36.02.19.2003|Cisungsang
36.02.19.2004|Kujangjaya
36.02.19.2005|Kujangsari
36.02.19.2006|Neglasari
36.02.19.2007|Mekarsari
36.02.19.2008|Cikotok
36.02.19.2009|Sukamulya
36.02.19.2010|Citorek Timur
36.02.19.2011|Warungbanten
36.02.19.2013|Hegarmanah
36.02.19.2014|Situmulya
36.02.19.2015|Citorek Kidul
36.02.19.2016|Cikadu
36.02.19.2017|Sirnagalih
36.02.19.2018|Cihambali
36.02.19.2019|Citorek Barat
36.02.19.2020|Gunungwangun
36.02.19.2021|Wanasari
36.02.19.2022|Citorek Sabrang
36.02.19.2023|Ciherang
36.02.20.2001|Cilograng
36.02.20.2002|Cibareno
36.02.20.2003|Cikamunding
36.02.20.2004|Cijengkol
36.02.20.2005|Pasirbungur
36.02.20.2006|Lebaktipar
36.02.20.2007|Cikatomas
36.02.20.2008|Girimukti
36.02.20.2009|Cireundeu
36.02.20.2010|Gunungbatu
36.02.21.2001|Wanasalam
36.02.21.2002|Bejod
36.02.21.2003|Cilangkap
36.02.21.2004|Cipeucang
36.02.21.2005|Muara
36.02.21.2006|Parungpanjang
36.02.21.2007|Cikeusik
36.02.21.2008|Katapang
36.02.21.2009|Cisarap
36.02.21.2010|Sukatani
36.02.21.2011|Cipedang
36.02.21.2012|Parungsari
36.02.21.2013|Karangpamindangan
36.02.22.2001|Ciparasi
36.02.22.2002|Sobang
36.02.22.2003|Sukajaya
36.02.22.2004|Sindanglaya
36.02.22.2005|Sukamaju
36.02.22.2006|Hariang
36.02.22.2007|Majasari
36.02.22.2008|Sinar Jaya
36.02.22.2009|Cirompang
36.02.22.2010|Sukaresmi
36.02.23.2001|Guradog
36.02.23.2002|Curugbitung
36.02.23.2003|Candi
36.02.23.2004|Mayak
36.02.23.2005|Cipining
36.02.23.2006|Cilayang
36.02.23.2007|Ciburuy
36.02.23.2008|Sekarwangi
36.02.23.2009|Cidadap
36.02.23.2010|Lebakasih
36.02.24.2001|Kalanganyar
36.02.24.2002|Pasirkupa
36.02.24.2003|Cilangkap
36.02.24.2004|Aweh
36.02.24.2005|Sangiangtanjung
36.02.24.2006|Sukamekarsari
36.02.24.2007|Cikatapis
36.02.25.2001|Banjaririgasi
36.02.25.2002|Ciladaeun
36.02.25.2003|Lebakgedong
36.02.25.2004|Banjarsari
36.02.25.2005|Lebaksitu
36.02.25.2006|Lebaksangka
36.02.26.2001|Panyaungan
36.02.26.2002|Cihara
36.02.26.2003|Ciparahu
36.02.26.2004|Pondokpanjang
36.02.26.2005|Citeupuseun
36.02.26.2006|Lebakpeundeuy
36.02.26.2007|Mekarsari
36.02.26.2008|Karangkamulyan
36.02.26.2009|Barunai
36.02.27.2001|Datarcae
36.02.27.2002|Cirinten
36.02.27.2003|Karangnunggal
36.02.27.2004|Kadudamas
36.02.27.2005|Badur
36.02.27.2006|Parakanlima
36.02.27.2007|Nanggerang
36.02.27.2008|Cempaka
36.02.27.2009|Karoya
36.02.27.2010|Cibarani
36.02.28.2001|Peucangpari
36.02.28.2002|Cibungur
36.02.28.2003|Mugijaya
36.02.28.2004|Cikate
36.02.28.2005|Cigemblong
36.02.28.2006|Cikadongdong
36.02.28.2007|Cikaret
36.02.28.2008|Wangunjaya
36.02.28.2009|Cikaratuan
36.03.01.1001|Balaraja
36.03.01.2003|Cangkudu
36.03.01.2005|Talagasari
36.03.01.2009|Tobat
36.03.01.2010|Sentul
36.03.01.2011|Gembong
36.03.01.2013|Sukamurni
36.03.01.2014|Saga
36.03.01.2016|Sentul Jaya
36.03.02.2001|Pangkat
36.03.02.2002|Pabuaran
36.03.02.2004|Pasir Muncang
36.03.02.2005|Sumur Bandung
36.03.02.2006|Jayanti
36.03.02.2007|Dangdeur
36.03.02.2008|Cikande
36.03.02.2009|Pasir Gintung
36.03.03.1001|Tigaraksa
36.03.03.1007|Kadu Agung
36.03.03.2002|Pasir Bolang
36.03.03.2003|Matagara
36.03.03.2004|Pasir Nangka
36.03.03.2005|Pete
36.03.03.2006|Tegalsari
36.03.03.2008|Pematang
36.03.03.2009|Cisereh
36.03.03.2010|Margasari
36.03.03.2011|Cileles
36.03.03.2012|Sodong
36.03.03.2013|Tapos
36.03.03.2014|Bantar Panjang
36.03.04.2001|Sukamanah
36.03.04.2002|Jambe
36.03.04.2003|Tipar Raya
36.03.04.2004|Taban
36.03.04.2005|Daru
36.03.04.2006|Kutruk
36.03.04.2007|Ranca Buaya
36.03.04.2008|Mekarsari
36.03.04.2009|Ancol Pasir
36.03.04.2010|Pasir Barat
36.03.05.2001|Cisoka
36.03.05.2002|Caringin
36.03.05.2003|Selapajang
36.03.05.2004|Sukatani
36.03.05.2006|Bojong Loa
36.03.05.2007|Cibugel
36.03.05.2008|Cempaka
36.03.05.2009|Carenang
36.03.05.2014|Karang Harja
36.03.05.2017|Jeungjing
36.03.06.2001|Pasir Ampo
36.03.06.2003|Rancailat
36.03.06.2007|Kemuning
36.03.06.2009|Renged
36.03.06.2011|Talok
36.03.06.2013|Koper
36.03.06.2014|Jengkol
36.03.06.2015|Patrasana
36.03.06.2018|Kresek
36.03.07.2001|Kronjo
36.03.07.2002|Pagenjahan
36.03.07.2006|Pasir
36.03.07.2007|Muncung
36.03.07.2008|Pagedangan Ilir
36.03.07.2009|Pagedangan Udik
36.03.07.2010|Pasilian
36.03.07.2013|Bakung
36.03.07.2015|Blukbuk
36.03.07.2017|Cirumpak
36.03.08.1002|Mauk Timur
36.03.08.2001|Mauk Barat
36.03.08.2003|Tegal Kunir Kidul
36.03.08.2004|Tegal Kunir Lor
36.03.08.2005|Sasak
36.03.08.2006|Gunung Sari
36.03.08.2007|Kedung Dalem
36.03.08.2008|Marga Mulya
36.03.08.2009|Tanjung Anom
36.03.08.2010|Jatiwaringin
36.03.08.2011|Banyu Asih
36.03.08.2012|Ketapang
36.03.09.2001|Patramanggala
36.03.09.2002|Karang Anyar
36.03.09.2003|Lontar
36.03.09.2004|Kemiri
36.03.09.2005|Ranca Labuh
36.03.09.2006|Klebet
36.03.09.2007|Legok Suka Maju
36.03.10.2001|Sukadiri
36.03.10.2002|Buaran Jati
36.03.10.2003|Rawa Kidang
36.03.10.2004|Pekayon
36.03.10.2005|Karang Serang
36.03.10.2006|Kosambi
36.03.10.2007|Mekar Kondang
36.03.10.2008|Gintung
36.03.11.1010|Sukatani
36.03.11.2001|Rajeg
36.03.11.2002|Rajeg Mulya
36.03.11.2003|Pangarengan
36.03.11.2005|Jambu Karya
36.03.11.2006|Lembangsari
36.03.11.2007|Sukamanah
36.03.11.2008|Tanjakan
36.03.11.2009|Tanjakan Mekar
36.03.11.2011|Sukasari
36.03.11.2012|Ranca Bango
36.03.11.2013|Daon
36.03.11.2014|Mekarsari
36.03.12.1005|Sindangsari
36.03.12.1010|Kutabumi
36.03.12.1012|Kuta Jaya
36.03.12.1014|Kuta Baru
36.03.12.2001|Pasar Kemis
36.03.12.2008|Sukamantri
36.03.12.2011|Pangadegan
36.03.12.2013|Gelam Jaya
36.03.12.2015|Suka Asih
36.03.13.2001|Teluknaga
36.03.13.2002|Bojong Renged
36.03.13.2003|Babakan Asem
36.03.13.2004|Keboncau
36.03.13.2005|Pangkalan
36.03.13.2006|Kmp Melayu Tim
36.03.13.2007|Kmp Melayu Brt
36.03.13.2008|Muara
36.03.13.2009|Lemo
36.03.13.2010|Tanjung Pasir
36.03.13.2011|Tegal Angus
36.03.13.2012|Tanjung Burung
36.03.13.2013|Kampung Besar
36.03.14.1001|Kosambi Barat
36.03.14.1003|Salembaran Jaya
36.03.14.1010|Dadap
36.03.14.2002|Kosambi Timur
36.03.14.2004|Salembaran Jati
36.03.14.2005|Rawa Rengas
36.03.14.2006|Rawa Burung
36.03.14.2007|Cengklong
36.03.14.2008|Belimbing
36.03.14.2009|Jati Mulya
36.03.15.1001|Pakuhaji
36.03.15.2002|Paku Alam
36.03.15.2003|Bonisari
36.03.15.2004|Rawa Boni
36.03.15.2005|Buaran Mangga
36.03.15.2006|Buaran Bambu
36.03.15.2007|Kalibaru
36.03.15.2008|Kohod
36.03.15.2009|Kramat
36.03.15.2010|Sukawali
36.03.15.2011|Surya Bahari
36.03.15.2012|Kiara Payung
36.03.15.2013|Laksana
36.03.15.2014|Gaga
36.03.16.1001|Sepatan
36.03.16.2002|Karet
36.03.16.2003|Kayu Agung
36.03.16.2004|Kayu Bongkok
36.03.16.2008|Pondok Jaya
36.03.16.2011|Pisangan Jaya
36.03.16.2012|Mekar Jaya
36.03.16.2015|Sarakan
36.03.17.1001|Curug Kulon
36.03.17.1005|Sukabakti
36.03.17.1006|Binong
36.03.17.2002|Curug Wetan
36.03.17.2003|Kadu
36.03.17.2004|Kadu Jaya
36.03.17.2010|Cukanggalih
36.03.18.1001|Sukamulya
36.03.18.1003|Bunder
36.03.18.2002|Cibadak
36.03.18.2004|Talaga
36.03.18.2005|Talagasari
36.03.18.2006|Dukuh
36.03.18.2007|Cikupa
36.03.18.2008|Sukanagara
36.03.18.2009|Bitung Jaya
36.03.18.2010|Pasir Gadung
36.03.18.2011|Sukadamai
36.03.18.2012|Pasir Jaya
36.03.18.2013|Budi Mulya
36.03.18.2014|Bojong
36.03.19.1002|Mekar Bakti
36.03.19.2001|Ranca Iyuh
36.03.19.2003|Peusar
36.03.19.2004|Ranca Kalapa
36.03.19.2005|Serdang Kulon
36.03.19.2006|Mekar Jaya
36.03.19.2007|Ciakar
36.03.19.2008|Panongan
36.03.20.1011|Babakan
36.03.20.2002|Caringin
36.03.20.2003|Serdang Wetan
36.03.20.2004|Babat
36.03.20.2005|Ciangir
36.03.20.2006|Legok
36.03.20.2007|Palasari
36.03.20.2008|Bojongkamal
36.03.20.2009|Rancagong
36.03.20.2010|Kemuning
36.03.20.2012|Cirarab
36.03.22.1004|Medang
36.03.22.2002|Cicalengka
36.03.22.2003|Pagedangan
36.03.22.2005|Cijantra
36.03.22.2006|Lengkong Kulon
36.03.22.2007|Situ Gadung
36.03.22.2008|Jatake
36.03.22.2009|Cihuni
36.03.22.2010|Kadu Sirung
36.03.22.2011|Malang Nengah
36.03.22.2012|Karang Tengah
36.03.23.1001|Cisauk
36.03.23.2003|Mekar Wangi
36.03.23.2005|Suradita
36.03.23.2006|Sampora
36.03.23.2009|Dangdang
36.03.23.2011|Cibogo
36.03.27.2001|Benda
36.03.27.2002|Sukamulya
36.03.27.2003|Kaliasin
36.03.27.2004|Buniayu
36.03.27.2005|Parahu
36.03.27.2006|Merak
36.03.27.2007|Bunar
36.03.27.2008|Kubang
36.03.28.1001|Kelapa Dua
36.03.28.1002|Bencongan
36.03.28.1003|Bencongan Indah
36.03.28.1004|Pakulonan Barat
36.03.28.1005|Bojong Nangka
36.03.28.2006|Curug Sangereng
36.03.29.2001|Sindang Jaya
36.03.29.2002|Wanakerta
36.03.29.2003|Sukaharja
36.03.29.2004|Sindangasih
36.03.29.2005|Sindangpanon
36.03.29.2006|Sindangsono
36.03.29.2007|Badak Anom
36.03.30.2001|Kedaung Barat
36.03.30.2002|Lebak Wangi
36.03.30.2003|Jati Mulya
36.03.30.2004|Sangiang
36.03.30.2005|Gempol Sari
36.03.30.2006|Kampung Kelor
36.03.30.2007|Pondok Kelor
36.03.30.2008|Tanah Merah
36.03.31.2001|Solear
36.03.31.2002|Cikuya
36.03.31.2003|Cikasungka
36.03.31.2004|Cireundeu
36.03.31.2005|Cikareo
36.03.31.2006|Pasanggrahan
36.03.31.2007|Munjul
36.03.32.2001|Gunung Kaler
36.03.32.2002|Sidoko
36.03.32.2003|Rancagede
36.03.32.2004|Kedung
36.03.32.2005|Cipaeh
36.03.32.2006|Onyam
36.03.32.2007|Tamiang
36.03.32.2008|Kandawati
36.03.32.2009|Cibetok
36.03.33.2001|Mekar Baru
36.03.33.2002|Kedaung
36.03.33.2003|Cijeruk
36.03.33.2004|Waliwis
36.03.33.2005|Klutuk
36.03.33.2006|Jenggot
36.03.33.2007|Kosambi Dalam
36.03.33.2008|Gandaria
36.04.05.2001|Kramatwatu
36.04.05.2002|Margasana
36.04.05.2003|Pejaten
36.04.05.2004|Toyomerto
36.04.05.2005|Harjatani
36.04.05.2006|Serdang
36.04.05.2007|Terate
36.04.05.2008|Tonjong
36.04.05.2009|Pamengkang
36.04.05.2010|Pegadingan
36.04.05.2011|Lebakwana
36.04.05.2012|Wanayasa
36.04.05.2013|Pelamunan
36.04.05.2014|Teluk Terate
36.04.05.2015|Margatani
36.04.06.2001|Waringinkurung
36.04.06.2002|Talaga Luhur
36.04.06.2003|Binangun
36.04.06.2004|Melati
36.04.06.2005|Sasahan
36.04.06.2006|Sukadalem
36.04.06.2007|Sukabares
36.04.06.2008|Sambilawang
36.04.06.2009|Sampir
36.04.06.2010|Cokopsulanjana
36.04.06.2011|Kemuning
36.04.07.2001|Bojonegara
36.04.07.2002|Mangkunegara
36.04.07.2003|Wanakarta
36.04.07.2004|Karang Kepuh
36.04.07.2005|Lambangsari
36.04.07.2006|Kertasana
36.04.07.2007|Margagiri
36.04.07.2008|Ukirsari
36.04.07.2009|Pakuncen
36.04.07.2010|Pangarengan
36.04.07.2011|Mekar Jaya
36.04.08.2001|Pulo Ampel
36.04.08.2002|Sumuranja
36.04.08.2003|Mangunreja
36.04.08.2004|Kedungsoka
36.04.08.2005|Salira
36.04.08.2006|Argawana
36.04.08.2007|Banyuwangi
36.04.08.2008|Margasari
36.04.08.2009|Pulo Panjang
36.04.09.2001|Ciruas
36.04.09.2002|Citerep
36.04.09.2003|Pulo
36.04.09.2004|Kadikaran
36.04.09.2005|Kepandean
36.04.09.2006|Gosara
36.04.09.2009|Bumijaya
36.04.09.2010|Penggalang
36.04.09.2011|Pamong
36.04.09.2012|Cigelam
36.04.09.2013|Singamerta
36.04.09.2014|Ranjeng
36.04.09.2015|Beberan
36.04.09.2016|Kaserangan
36.04.09.2017|Pelawad
36.04.11.2001|Kragilan
36.04.11.2002|Silebu
36.04.11.2003|Pematang
36.04.11.2004|Dukuh
36.04.11.2005|Undar Andir
36.04.11.2006|Sukajadi
36.04.11.2007|Sentul
36.04.11.2008|Jeruk Tipis
36.04.11.2011|Kendayakan
36.04.11.2012|Tegalmaja
36.04.11.2013|Cisait
36.04.11.2014|Kramatjati
36.04.12.2001|Pontang
36.04.12.2002|Sukanegara
36.04.12.2003|Linduk
36.04.12.2004|Pulokencana
36.04.12.2006|Kelapian
36.04.12.2008|Kubang Puji
36.04.12.2009|Domas
36.04.12.2010|Singarajan
36.04.12.2011|Kaserangan
36.04.12.2012|Wanayasa
36.04.12.2013|Sukajaya
36.04.13.2001|Tirtayasa
36.04.13.2002|Samparwadi
36.04.13.2003|Kemanisan
36.04.13.2004|Pontang Legon
36.04.13.2005|Kebon
36.04.13.2006|Sujung
36.04.13.2007|Lontar
36.04.13.2008|Susukan
36.04.13.2009|Wargasara
36.04.13.2010|Laban
36.04.13.2011|Tengkurak
36.04.13.2012|Alang-alang
36.04.13.2013|Kebuyutan
36.04.13.2014|Puser
36.04.14.2001|Tanara
36.04.14.2002|Cerukcuk
36.04.14.2003|Tenjoayu
36.04.14.2004|Sukamanah
36.04.14.2005|Lempuyang
36.04.14.2006|Siremen
36.04.14.2007|Bendung
36.04.14.2008|Pedaleman
36.04.14.2009|Cibodas
36.04.15.2001|Cikande
36.04.15.2002|Leuwi Limus
36.04.15.2003|Nambo Udik
36.04.15.2004|Parigi
36.04.15.2005|Koper
36.04.15.2006|Bakung
36.04.15.2007|Julang
36.04.15.2008|Sukatani
36.04.15.2009|Situterate
36.04.15.2010|Kamurang
36.04.15.2011|Gembor Udik
36.04.15.2012|Songgom Jaya
36.04.15.2013|Cikande Permai
36.04.16.2001|Kibin
36.04.16.2002|Ketos
36.04.16.2003|Cijeruk
36.04.16.2004|Nagara
36.04.16.2005|Nambo Ilir
36.04.16.2006|Barengkok
36.04.16.2007|Sukamaju
36.04.16.2008|Tambak
36.04.16.2009|Ciagel
36.04.17.2001|Carenang
36.04.17.2002|Pamanuk
36.04.17.2003|Mandaya
36.04.17.2004|Teras
36.04.17.2006|Ragas Masigit
36.04.17.2007|Walikukun
36.04.17.2009|Panenjoan
36.04.17.2010|Mekarsari
36.04.18.2001|Binuang
36.04.18.2002|Cakung
36.04.18.2003|Renged
36.04.18.2004|Gembor
36.04.18.2005|Warakas
36.04.18.2006|Sukamampir
36.04.18.2007|Lamaran
36.04.19.2001|Petir
36.04.19.2002|Cirangkong
36.04.19.2003|Tambiluk
36.04.19.2004|Sindangsari
36.04.19.2005|Padasuka
36.04.19.2006|Seuat
36.04.19.2007|Nagara Padang
36.04.19.2008|Kadugenep
36.04.19.2009|Cireundeu
36.04.19.2010|Sanding
36.04.19.2011|Kampung Baru
36.04.19.2012|Mekar Baru
36.04.19.2013|Seuat Jaya
36.04.19.2014|Kubang Jaya
36.04.19.2015|Bojong Nangka
36.04.20.2001|Tunjung Teja
36.04.20.2002|Sukasari
36.04.20.2003|Panunggulan
36.04.20.2004|Malanggah
36.04.20.2005|Kemuning
36.04.20.2006|Bojong Menteng
36.04.20.2007|Bojong Catang
36.04.20.2008|Bojong Pandan
36.04.20.2009|Pancaregang
36.04.22.2001|Baros
36.04.22.2002|Tejamari
36.04.22.2003|Panyirapan
36.04.22.2004|Sidamukti
36.04.22.2005|Sukacai
36.04.22.2006|Tamansari
36.04.22.2007|Sindangmandi
36.04.22.2008|Cisalam
36.04.22.2009|Sukamanah
36.04.22.2010|Sukamenak
36.04.22.2011|Curug Agung
36.04.22.2012|Padasuka
36.04.22.2013|Sinarmukti
36.04.22.2014|Suka Indah
36.04.23.2001|Cikeusal
36.04.23.2002|Dahu
36.04.23.2003|Katulisan
36.04.23.2004|Sukamaju
36.04.23.2005|Cilayang
36.04.23.2006|Sukamenak
36.04.23.2007|Cimaung
36.04.23.2008|Panyabrangan
36.04.23.2009|Gandayasa
36.04.23.2010|Bantar Panjang
36.04.23.2011|Sukaratu
36.04.23.2012|Harundang
36.04.23.2013|Sukarame
36.04.23.2014|Panosogan
36.04.23.2015|Mongpok
36.04.23.2016|Sukaraja
36.04.23.2017|Cilayang Guha
36.04.24.2001|Pamarayan
36.04.24.2002|Damping
36.04.24.2003|Wirana
36.04.24.2004|Keboncau
36.04.24.2005|Pudar
36.04.24.2006|Binong
36.04.24.2007|Sangiang
36.04.24.2008|Kampungbaru
36.04.24.2010|Pasirlimus
36.04.24.2018|Pasir Kembang
36.04.25.2001|Kopo
36.04.25.2002|Garut
36.04.25.2003|Nanggung
36.04.25.2004|Cidahu
36.04.25.2005|Nyompok
36.04.25.2006|Gabus
36.04.25.2007|Carenang Udik
36.04.25.2008|Rancasumur
36.04.25.2009|Babakanjaya
36.04.25.2010|Mekarbaru
36.04.26.2001|Jawilan
36.04.26.2002|Bojot
36.04.26.2003|Cemplang
36.04.26.2004|Pagintungan
36.04.26.2005|Pasirbuyut
36.04.26.2006|Majasari
36.04.26.2007|Parakan
36.04.26.2008|Kareo
36.04.26.2009|Junti
36.04.27.2001|Ujungtebu
36.04.27.2002|Siketug
36.04.27.2003|Lebak
36.04.27.2004|Pondok Kahuru
36.04.27.2005|Sukabares
36.04.27.2006|Sukarena
36.04.27.2007|Sukadana
36.04.27.2008|Cemplang
36.04.27.2009|Cisitu
36.04.27.2010|Citaman
36.04.27.2011|Panyaungan Jaya
36.04.28.2001|Pabuaran
36.04.28.2006|Kadubeureum
36.04.28.2007|Tanjungsari
36.04.28.2009|Pancanegara
36.04.28.2010|Sindangsari
36.04.28.2012|Sindangheula
36.04.28.2013|Pasanggrahan
36.04.28.2015|Talaga Warna
36.04.29.2001|Padarincang
36.04.29.2002|Bugel
36.04.29.2003|Cibojong
36.04.29.2004|Citasuk
36.04.29.2005|Cisaat
36.04.29.2006|Ciomas
36.04.29.2007|Barugbug
36.04.29.2008|Batu Kuwung
36.04.29.2009|Kramatlaban
36.04.29.2010|Kalumpang
36.04.29.2011|Kadubeureum
36.04.29.2012|Cipayung
36.04.29.2013|Curug Goong
36.04.29.2014|Kadu Kempong
36.04.30.2001|Anyar
36.04.30.2002|Sindang Mandi
36.04.30.2003|Cikoneng
36.04.30.2004|Tanjung Manis
36.04.30.2005|Bandulu
36.04.30.2006|Bunihara
36.04.30.2007|Kosambironyok
36.04.30.2008|Banjarsari
36.04.30.2009|Mekarsari
36.04.30.2010|Sindangkarya
36.04.30.2011|Tambang Ayam
36.04.30.2012|Grogol Indah
36.04.31.2001|Cinangka
36.04.31.2002|Bantarwaru
36.04.31.2003|Pasauran
36.04.31.2004|Bulakan
36.04.31.2005|Karang Suraga
36.04.31.2006|Umbul Tanjung
36.04.31.2007|Kubang Baros
36.04.31.2008|Rancasanggal
36.04.31.2009|Cikolelet
36.04.31.2010|Sindanglaya
36.04.31.2011|Kamasan
36.04.31.2012|Bantarwangi
36.04.31.2013|Mekarsari
36.04.31.2014|Baros Jaya
36.04.32.2001|Mancak
36.04.32.2002|Ciwarna
36.04.32.2003|Angsana
36.04.32.2004|Talaga
36.04.32.2005|Cikedung
36.04.32.2006|Sigedong
36.04.32.2007|Sangiang
36.04.32.2008|Pasirwaru
36.04.32.2009|Waringin
36.04.32.2010|Winong
36.04.32.2011|Batukuda
36.04.32.2012|Labuan
36.04.32.2013|Bale Kambang
36.04.32.2014|Bale Kencana
36.04.33.2001|Gunungsari
36.04.33.2002|Ciherang
36.04.33.2003|Tamiang
36.04.33.2004|Sukalaba
36.04.33.2005|Kadu Agung
36.04.33.2006|Luwuk
36.04.33.2007|Curug Sulanjana
36.04.34.2001|Bandung
36.04.34.2002|Mander
36.04.34.2003|Panamping
36.04.34.2004|Pangawinan
36.04.34.2005|Malabar
36.04.34.2006|Blokang
36.04.34.2007|Babakan
36.04.34.2008|Pringwulung
36.04.35.2001|Kamaruton
36.04.35.2002|Teras Bendung
36.04.35.2003|Lebak Wangi
36.04.35.2004|Lebak Kepuh
36.04.35.2005|Kencana Harapan
36.04.35.2006|Pegandikan
36.04.35.2007|Purwadadi
36.04.35.2008|Bolang
36.04.35.2009|Tirem
36.04.35.2010|Kebonratu
36.71.01.1001|Sukarasa
36.71.01.1002|Sukaasih
36.71.01.1003|Tanah Tinggi
36.71.01.1004|Buaran Indah
36.71.01.1005|Cikokol
36.71.01.1006|Kelapa Indah
36.71.01.1007|Sukasari
36.71.01.1008|Babakan
36.71.02.1001|Keroncong
36.71.02.1002|Jatake
36.71.02.1003|Pasir Jaya
36.71.02.1004|Gandasari
36.71.02.1005|Manis Jaya
36.71.02.1006|Alam Jaya
36.71.03.1001|Batuceper
36.71.03.1002|Batu Jaya
36.71.03.1003|Poris Gaga
36.71.03.1004|Poris Gaga Baru
36.71.03.1005|Kebon Besar
36.71.03.1006|Batu Sari
36.71.03.1007|Poris Jaya
36.71.04.1001|Belendung
36.71.04.1002|Jurumudi
36.71.04.1003|Benda
36.71.04.1004|Pajang
36.71.04.1005|Jurumudi Baru
36.71.05.1001|Cipondoh
36.71.05.1002|Cipondoh Makmur
36.71.05.1003|Cipondoh Indah
36.71.05.1004|Gondrong
36.71.05.1005|Kenanga
36.71.05.1006|Petir
36.71.05.1007|Ketapang
36.71.05.1008|Poris Plawad
36.71.05.1009|Poris Plawad Utara
36.71.05.1010|Poris Plawad Indah
36.71.06.1001|Paninggilan
36.71.06.1002|Sudimara Barat
36.71.06.1003|Sudimara Timur
36.71.06.1004|Tajur
36.71.06.1005|Parung Serab
36.71.06.1006|Sudimara Jaya
36.71.06.1007|Sudimara Selatan
36.71.06.1008|Paninggilan Utara
36.71.07.1001|Karawaci
36.71.07.1002|Bojong Jaya
36.71.07.1003|Karawaci Baru
36.71.07.1004|Nusa Jaya
36.71.07.1005|Cimone
36.71.07.1006|Cimone Jaya
36.71.07.1007|Pabuaran
36.71.07.1008|Sumur Pacing
36.71.07.1009|Bugel
36.71.07.1010|Marga Sari
36.71.07.1011|Pabuaran Tumpeng
36.71.07.1012|Nambo Jaya
36.71.07.1013|Gerendeng
36.71.07.1014|Sukajadi
36.71.07.1015|Pasar Baru
36.71.07.1016|Koang Jaya
36.71.08.1001|Periuk
36.71.08.1002|Gembor
36.71.08.1003|Gebang Raya
36.71.08.1004|Sangiang Jaya
36.71.08.1005|Periuk Jaya
36.71.09.1001|Cibodas
36.71.09.1002|Cibodas Sari
36.71.09.1003|Cibodas Baru
36.71.09.1004|Panunggangan Barat
36.71.09.1005|Uwung Jaya
36.71.09.1006|Jatiuwung
36.71.10.1001|Neglasari
36.71.10.1002|Karang Sari
36.71.10.1003|Selapajang Jaya
36.71.10.1004|Kedaung Wetan
36.71.10.1005|Mekar Sari
36.71.10.1006|Karang Anyar
36.71.10.1007|Kedaung Baru
36.71.11.1001|Pinang
36.71.11.1002|Sudimara Pinang
36.71.11.1003|Neroktog
36.71.11.1004|Kunciran
36.71.11.1005|Kunciran Indah
36.71.11.1006|Kunciran Jaya
36.71.11.1007|Cipete
36.71.11.1008|Pakojan
36.71.11.1009|Panunggangan
36.71.11.1010|Panunggangan Utara
36.71.11.1011|Panunggangan Timur
36.71.12.1001|Karang Tengah
36.71.12.1002|Karang Mulya
36.71.12.1003|Pondok Bahar
36.71.12.1004|Pondok Pucung
36.71.12.1005|Karang Timur
36.71.12.1006|Padurenan
36.71.12.1007|Parung Jaya
36.71.13.1001|Larangan Utara
36.71.13.1002|Larangan Selatan
36.71.13.1003|Cipadu
36.71.13.1004|Kreo
36.71.13.1005|Larangan Indah
36.71.13.1006|Gaga
36.71.13.1007|Cipadu Jaya
36.71.13.1008|Kreo Selatan
36.72.01.1001|Cibeber
36.72.01.1002|Kedaleman
36.72.01.1003|Bulakan
36.72.01.1004|Cikerai
36.72.01.1005|Karang Asem
36.72.01.1006|Kalitimbang
36.72.02.1001|Bagendung
36.72.02.1002|Ciwedus
36.72.02.1003|Bendungan
36.72.02.1004|Ketileng
36.72.02.1005|Ciwaduk
36.72.03.1001|Tamansari
36.72.03.1002|Lebakgede
36.72.03.1003|Mekarsari
36.72.03.1004|Suralaya
36.72.04.1001|Banjar Negara
36.72.04.1002|Tegal Ratu
36.72.04.1003|Kubangsari
36.72.04.1004|Gunung Sugih
36.72.04.1005|Kepuh
36.72.04.1006|Randakari
36.72.05.1001|Sukmajaya
36.72.05.1002|Jombang Wetan
36.72.05.1003|Masigit
36.72.05.1004|Panggung Rawi
36.72.05.1005|Gedong Dalem
36.72.06.1001|Kotasari
36.72.06.1002|Grogol
36.72.06.1003|Rawa Arum
36.72.06.1004|Gerem
36.72.07.1001|Ramanuju
36.72.07.1002|Kotabumi
36.72.07.1003|Kebon Dalem
36.72.07.1004|Purwakarta
36.72.07.1005|Tegal Bunder
36.72.07.1006|Pabean
36.72.08.1001|Warnasari
36.72.08.1002|Dringo
36.72.08.1003|Lebak Denok
36.72.08.1004|Taman Baru
36.72.08.1005|Kebonsari
36.72.08.1006|Samangraya
36.72.08.1007|Citangkil
36.73.01.1001|Serang
36.73.01.1002|Cipare
36.73.01.1003|Sumur Pecung
36.73.01.1004|Kota Baru
36.73.01.1005|Lopang
36.73.01.1006|Cimuncang
36.73.01.1007|Unyur
36.73.01.1008|Sukawana
36.73.01.1009|Lontarbaru
36.73.01.1010|Kaligandu
36.73.01.1011|Terondol
36.73.01.1012|Kagungan
36.73.02.1001|Kasemen
36.73.02.1002|Mesjid Priyayi
36.73.02.1003|Terumbu
36.73.02.1004|Warung Jaud
36.73.02.1006|Bendung
36.73.02.1007|Banten
36.73.02.1008|Sawah Luhur
36.73.02.1009|Kilasah
36.73.02.1010|Kasunyatan
36.73.02.1011|Margaluyu
36.73.03.1001|Walantaka
36.73.03.1002|Cigoong
36.73.03.1003|Nyapah
36.73.03.1004|Pangampelan
36.73.03.1006|Kiara
36.73.03.1007|Pager Agung
36.73.03.1008|Kalodran
36.73.03.1009|Kapuren
36.73.03.1010|Teritih
36.73.03.1011|Pabuaran
36.73.03.1012|Pasuluhan
36.73.03.1013|Tegalsari
36.73.03.1014|Pipitan
36.73.03.1016|Lebakwangi
36.73.04.1001|Curug
36.73.04.1002|Tinggar
36.73.04.1003|Kemanisan
36.73.04.1004|Cipete
36.73.04.1005|Cilaku
36.73.04.1006|Pancalaksana
36.73.04.1007|Sukawana
36.73.04.1008|Sukalaksana
36.73.04.1009|Curug Manis
36.73.04.1010|Sukajaya
36.73.05.1001|Cipocok Jaya
36.73.05.1002|Karundang
36.73.05.1003|Panancangan
36.73.05.1004|Banjar Agung
36.73.05.1005|Banjarsari
36.73.05.1006|Tembong
36.73.05.1007|Dalung
36.73.05.1008|Gelam
36.73.06.1001|Taktakan
36.73.06.1002|Sayar
36.73.06.1003|Pancur
36.73.06.1004|Kuranji
36.73.06.1005|Kalanganyar
36.73.06.1006|Cilowong
36.73.06.1007|Panggungjati
36.73.06.1008|Drangong
36.73.06.1009|Umbul Tengah
36.73.06.1010|Sepang
36.73.06.1011|Lialang
36.73.06.1012|Taman Baru
36.73.06.1013|Cibendung
36.74.01.1001|Ciater
36.74.01.1002|Rawabuntu
36.74.01.1003|Rawa Mekar Jaya
36.74.01.1004|Lengkong Gudang
36.74.01.1005|Lengkong Wetan
36.74.01.1006|Buaran
36.74.01.1007|Lengkong Gudang Timur
36.74.01.1008|Cilenggang
36.74.01.1009|Serpong
36.74.02.1001|Pakulonan
36.74.02.1002|Pakualam
36.74.02.1003|Pakujaya
36.74.02.1004|Pondok Jagung
36.74.02.1005|Pondok Jagung Timur
36.74.02.1006|Jelupang
36.74.02.1007|Lengkong Karya
36.74.03.1001|Pondok Betung
36.74.03.1002|Pondok Pucung
36.74.03.1003|Pondok Karya
36.74.03.1004|Pondok Jaya
36.74.03.1005|Pondok Aren
36.74.03.1006|Pondok Kacang Barat
36.74.03.1007|Pondok Kacang Timur
36.74.03.1008|Parigi
36.74.03.1009|Parigi Baru
36.74.03.1010|Jurangmangu Barat
36.74.03.1011|Jurangmangu Timur
36.74.04.1001|Sawah Baru
36.74.04.1002|Serua
36.74.04.1003|Ciputat
36.74.04.1004|Sawah
36.74.04.1005|Serua Indah
36.74.04.1006|Jombang
36.74.04.1007|Cipayung
36.74.05.1001|Cempaka Putih
36.74.05.1002|Pondok Ranji
36.74.05.1003|Pisangan
36.74.05.1004|Cireundeu
36.74.05.1005|Rempoa
36.74.05.1006|Rengas
36.74.06.1001|Pamulang Barat
36.74.06.1002|Benda Baru
36.74.06.1003|Pondok Benda
36.74.06.1004|Pondok Cabe Udik
36.74.06.1005|Pondok Cabe Ilir
36.74.06.1006|Kedaung
36.74.06.1007|Bambu Apus
36.74.06.1008|Pamulang Timur
36.74.07.1001|Muncul
36.74.07.1002|Setu
36.74.07.1003|Keranggan
36.74.07.1004|Kademangan
36.74.07.1005|Babakan
36.74.07.1006|Bakti Jaya
51.01.01.1006|Baler Bale Agung
51.01.01.1008|Banjar Tengah
51.01.01.1013|Lelateng
51.01.01.1014|Loloan Barat
51.01.01.2001|Cupel
51.01.01.2002|Baluk
51.01.01.2003|Banyubiru
51.01.01.2004|Kaliakah
51.01.01.2005|Berangbang
51.01.01.2009|Tegal Badeng Timur
51.01.01.2010|Tegal Badeng Barat
51.01.01.2011|Pengambengan
51.01.02.1006|Tegalcangkring
51.01.02.2001|Mendoyo Dauh Tukad
51.01.02.2002|Pohsanten
51.01.02.2003|Mendoyo Dangin Tukad
51.01.02.2004|Pergung
51.01.02.2005|Delodberawah
51.01.02.2007|Penyaringan
51.01.02.2008|Yehembang
51.01.02.2009|Yeh Sumbul
51.01.02.2010|Yehembang Kauh
51.01.02.2011|Yehembang Kangin
51.01.03.2001|Medewi
51.01.03.2002|Pulukan
51.01.03.2003|Asahduren
51.01.03.2004|Pekutatan
51.01.03.2005|Pangyangan
51.01.03.2006|Gumbrih
51.01.03.2007|Manggissari
51.01.03.2008|Pengeragoan
51.01.04.1001|Gilimanuk
51.01.04.2002|Melaya
51.01.04.2003|Belimbingsari
51.01.04.2004|Ekasari
51.01.04.2005|Nusasari
51.01.04.2006|Warnasari
51.01.04.2007|Candikusuma
51.01.04.2008|Tuwed
51.01.04.2009|Tukadaya
51.01.04.2010|Manistutu
51.01.05.1001|Pendem
51.01.05.1003|Loloan Timur
51.01.05.1005|Dauhwaru
51.01.05.1009|Sangkaragung
51.01.05.2002|Perancak
51.01.05.2004|Batu Agung
51.01.05.2006|Budeng
51.01.05.2007|Air Kuning
51.01.05.2008|Yehkuning
51.01.05.2010|Dangintukadaya
51.02.01.2001|Bajera
51.02.01.2002|Wanagiri
51.02.01.2003|Pupuan Sawah
51.02.01.2004|Berembeng
51.02.01.2005|Selemadeg
51.02.01.2006|Serampingan
51.02.01.2007|Antap
51.02.01.2008|Wanagiri Kauh
51.02.01.2009|Manikyang
51.02.01.2010|Bajera Utara
51.02.02.2001|Gunung Salak
51.02.02.2002|Gadungan
51.02.02.2003|Bantas
51.02.02.2004|Mambang
51.02.02.2005|Megati
51.02.02.2006|Tangguntiti
51.02.02.2007|Beraban
51.02.02.2008|Tegal Mengkeb
51.02.02.2009|Dalang
51.02.02.2010|Gadungsari
51.02.03.2001|Mundeh
51.02.03.2002|Mundeh Kangin
51.02.03.2003|Lalanglinggah
51.02.03.2004|Antosari
51.02.03.2005|Lumbung
51.02.03.2006|Lumbung Kauh
51.02.03.2007|Tiying Gading
51.02.03.2008|Mundeh Kauh
51.02.03.2009|Angkah
51.02.03.2010|Selabih
51.02.03.2011|Bengkel Sari
51.02.04.2001|Tibubiu
51.02.04.2002|Kelating
51.02.04.2003|Penarukan
51.02.04.2004|Belumbang
51.02.04.2005|Tista
51.02.04.2006|Kerambitan
51.02.04.2007|Pangkung Karung
51.02.04.2008|Samsam
51.02.04.2009|Kukuh
51.02.04.2010|Baturiti
51.02.04.2011|Meliling
51.02.04.2012|Sembung Gede
51.02.04.2013|Batuaji
51.02.04.2014|Kesiut
51.02.04.2015|Timpag
51.02.05.2001|Sudimara
51.02.05.2002|Gubug
51.02.05.2003|Bongan
51.02.05.2004|Delod Peken
51.02.05.2005|Dauh Peken
51.02.05.2006|Dajan Peken
51.02.05.2007|Denbantas
51.02.05.2008|Subamia
51.02.05.2009|Wanasari
51.02.05.2010|Tunjuk
51.02.05.2011|Buahan
51.02.05.2012|Sesandan
51.02.06.2001|Bengkel
51.02.06.2002|Pangkung Tibah
51.02.06.2003|Belalang
51.02.06.2004|Beraban
51.02.06.2005|Buwit
51.02.06.2006|Cepaka
51.02.06.2007|Kaba-kaba
51.02.06.2008|Nyambu
51.02.06.2009|Pandak Bandung
51.02.06.2010|Pandak Gede
51.02.06.2011|Nyitdah
51.02.06.2012|Pejaten
51.02.06.2013|Kediri
51.02.06.2014|Abian Tuwung
51.02.06.2015|Banjar Anyar
51.02.07.2001|Kukuh
51.02.07.2002|Beringkit Belayu
51.02.07.2003|Peken Belayu
51.02.07.2004|Batannyuh
51.02.07.2005|Tegaljadi
51.02.07.2006|Kuwum
51.02.07.2007|Selanbawak
51.02.07.2008|Marga
51.02.07.2009|Petiga
51.02.07.2010|Cau Belayu
51.02.07.2011|Tua
51.02.07.2012|Payangan
51.02.07.2013|Marga Dajan Puri
51.02.07.2014|Marga Dauh Puri
51.02.07.2015|Geluntung
51.02.07.2016|Baru
51.02.08.2001|Rejasa
51.02.08.2002|Jegu
51.02.08.2003|Riang Gede
51.02.08.2004|Buruan
51.02.08.2005|Biaung
51.02.08.2006|Pitra
51.02.08.2007|Penatahan
51.02.08.2008|Tengkudak
51.02.08.2009|Mengesta
51.02.08.2010|Penebel
51.02.08.2011|Babahan
51.02.08.2012|Senganan
51.02.08.2013|Jatiluwih
51.02.08.2014|Wongaya Gede
51.02.08.2015|Tajen
51.02.08.2016|Tegallinggah
51.02.08.2017|Pesagi
51.02.08.2018|Sangketan
51.02.09.2001|Perean
51.02.09.2002|Luwus
51.02.09.2003|Apuan
51.02.09.2004|Angseri
51.02.09.2005|Bangli
51.02.09.2006|Baturiti
51.02.09.2007|Antapan
51.02.09.2008|Candikuning
51.02.09.2009|Mekarsari
51.02.09.2010|Batunya
51.02.09.2011|Perean Tengah
51.02.09.2012|Perean Kangin
51.02.10.2001|Belimbing
51.02.10.2002|Sanda
51.02.10.2003|Batungsel
51.02.10.2004|Kebon Padangan
51.02.10.2005|Munduktemu
51.02.10.2006|Pujungan
51.02.10.2007|Pupuan
51.02.10.2008|Bantiran
51.02.10.2009|Padangan
51.02.10.2010|Jelijih Punggang
51.02.10.2011|Belatungan
51.02.10.2012|Pajahan
51.02.10.2013|Karyasari
51.02.10.2014|Sai
51.03.01.1001|Tuban
51.03.01.1002|Kuta
51.03.01.1003|Kedonganan
51.03.01.1004|Legian
51.03.01.1005|Seminyak
51.03.02.1004|Kapal
51.03.02.1005|Sempidi
51.03.02.1014|Abianbase
51.03.02.1015|Sading
51.03.02.1016|Lukluk
51.03.02.2001|Munggu
51.03.02.2002|Buduk
51.03.02.2003|Mengwitani
51.03.02.2006|Penarungan
51.03.02.2007|Sembung
51.03.02.2008|Baha
51.03.02.2009|Mengwi
51.03.02.2010|Kekeran
51.03.02.2011|Sobangan
51.03.02.2012|Gulingan
51.03.02.2013|Werdi Bhuwana
51.03.02.2017|Cemagi
51.03.02.2018|Pererenan
51.03.02.2019|Tumbakbayuh
51.03.02.2020|Kuwum
51.03.03.2001|Darmasaba
51.03.03.2002|Sibangkaja
51.03.03.2003|Sibanggede
51.03.03.2004|Jagapati
51.03.03.2005|Angantaka
51.03.03.2006|Sedang
51.03.03.2007|Mambal
51.03.03.2008|Abiansemal
51.03.03.2009|Bongkasa
51.03.03.2010|Taman
51.03.03.2011|Blahkiuh
51.03.03.2012|Ayunan
51.03.03.2013|Sangeh
51.03.03.2014|Punggul
51.03.03.2015|Mekar Bhuwana
51.03.03.2016|Abiansemal Dauh Yeh Cani
51.03.03.2017|Selat
51.03.03.2018|Bongkasa Pertiwi
51.03.04.2001|Carangsari
51.03.04.2002|Petang
51.03.04.2003|Belok/Sidan
51.03.04.2004|Pelaga
51.03.04.2005|Getasan
51.03.04.2006|Pangsan
51.03.04.2007|Sulangai
51.03.05.1004|Benoa
51.03.05.1005|Tanjung Benoa
51.03.05.1006|Jimbaran
51.03.05.2001|Pecatu
51.03.05.2002|Ungasan
51.03.05.2003|Kutuh
51.03.06.1001|Kerobokan Kelod
51.03.06.1002|Kerobokan
51.03.06.1003|Kerobokan Kaja
51.03.06.2004|Tibubeneng
51.03.06.2005|Canggu
51.03.06.2006|Dalung
51.04.01.2001|Batubulan
51.04.01.2002|Ketewel
51.04.01.2003|Guwang
51.04.01.2004|Sukawati
51.04.01.2005|Celuk
51.04.01.2006|Singapadu
51.04.01.2007|Batuan
51.04.01.2008|Kemenuh
51.04.01.2009|Batubulan Kangin
51.04.01.2010|Singapadu Tengah
51.04.01.2011|Singapadu Kaler
51.04.01.2012|Batuan Kaler
51.04.02.2001|Saba
51.04.02.2002|Pering
51.04.02.2003|Keramas
51.04.02.2004|Belega
51.04.02.2005|Blahbatuh
51.04.02.2006|Buruan
51.04.02.2007|Bedulu
51.04.02.2008|Medahan
51.04.02.2009|Bona
51.04.03.1003|Samplangan
51.04.03.1005|Abianbase
51.04.03.1006|Gianyar
51.04.03.1007|Bitera
51.04.03.1008|Beng
51.04.03.2001|Tulikup
51.04.03.2002|Sidan
51.04.03.2004|Lebih
51.04.03.2009|Bakbakan
51.04.03.2010|Siangan
51.04.03.2011|Suwat
51.04.03.2012|Petak
51.04.03.2013|Serongga
51.04.03.2014|Petak Kaja
51.04.03.2015|Temesi
51.04.03.2016|Sumita
51.04.03.2017|Tegal Tugu
51.04.04.2001|Pejeng
51.04.04.2002|Sanding
51.04.04.2003|Tampaksiring
51.04.04.2004|Manukaya
51.04.04.2005|Pejeng Kawan
51.04.04.2006|Pejeng Kaja
51.04.04.2007|Pejeng Kangin
51.04.04.2008|Pejeng Kelod
51.04.05.1005|Ubud
51.04.05.2001|Lodtunduh
51.04.05.2002|Mas
51.04.05.2003|Singakerta
51.04.05.2004|Kedewatan
51.04.05.2006|Peliatan
51.04.05.2007|Petulu
51.04.05.2008|Sayan
51.04.06.2001|Keliki
51.04.06.2002|Tegallalang
51.04.06.2003|Kenderan
51.04.06.2004|Kedisan
51.04.06.2005|Pupuan
51.04.06.2006|Sebatu
51.04.06.2007|Taro
51.04.07.2001|Melinggih
51.04.07.2002|Kelusa
51.04.07.2003|Bukian
51.04.07.2004|Puhu
51.04.07.2005|Buahan
51.04.07.2006|Kerta
51.04.07.2007|Melinggih Kelod
51.04.07.2008|Buahan Kaja
51.04.07.2009|Bresela
51.05.01.2001|Sakti
51.05.01.2002|Batumadeg
51.05.01.2003|Klumpu
51.05.01.2004|Batukandik
51.05.01.2005|Sekartaji
51.05.01.2006|Tanglad
51.05.01.2007|Suana
51.05.01.2008|Batununggul
51.05.01.2009|Kutampi
51.05.01.2010|Ped
51.05.01.2011|Kampung Toyapakeh
51.05.01.2012|Lembongan
51.05.01.2013|Jungutbatu
51.05.01.2014|Pejukutan
51.05.01.2015|Kutampi Kaler
51.05.01.2016|Bunga Mekar
51.05.02.2001|Negari
51.05.02.2002|Takmung
51.05.02.2003|Banjarangkan
51.05.02.2004|Tusan
51.05.02.2005|Bakas
51.05.02.2006|Getakan
51.05.02.2007|Tihingan
51.05.02.2008|Aan
51.05.02.2009|Nyalian
51.05.02.2010|Bungbungan
51.05.02.2011|Timuhun
51.05.02.2012|Nyanglan
51.05.02.2013|Tohpati
51.05.03.1008|Semarapura Kaja
51.05.03.1009|Semarapura Kauh
51.05.03.1010|Semarapura Tengah
51.05.03.1011|Semarapura Kangin
51.05.03.1012|Semarapura Klod Kangin
51.05.03.1013|Semarapura Klod
51.05.03.2001|Satra
51.05.03.2002|Tojan
51.05.03.2003|Gelgel
51.05.03.2004|Kampung Gelgel
51.05.03.2005|Jumpai
51.05.03.2006|Tangkas
51.05.03.2007|Kamasan
51.05.03.2014|Akah
51.05.03.2015|Manduang
51.05.03.2016|Selat
51.05.03.2017|Tegak
51.05.03.2018|Selisihan
51.05.04.2001|Paksebali
51.05.04.2002|Sampalan Tengah
51.05.04.2003|Sampalan Klod
51.05.04.2004|Sulang
51.05.04.2005|Gunaksa
51.05.04.2006|Kusamba
51.05.04.2007|Kampung Kusamba
51.05.04.2008|Pesinggahan
51.05.04.2009|Dawan Klod
51.05.04.2010|Pikat
51.05.04.2011|Dawan Kaler
51.05.04.2012|Besan
51.06.01.2001|Apuan
51.06.01.2002|Demulih
51.06.01.2003|Abuan
51.06.01.2004|Susut
51.06.01.2005|Sulahan
51.06.01.2006|Penglumbaran
51.06.01.2007|Tiga
51.06.01.2008|Selat
51.06.01.2009|Pengiangan
51.06.02.1003|Bebalang
51.06.02.1004|Kawan
51.06.02.1005|Cempaga
51.06.02.1006|Kubu
51.06.02.2001|Bunutin
51.06.02.2002|Tamanbali
51.06.02.2007|Kayubihi
51.06.02.2008|Pengotan
51.06.02.2009|Landih
51.06.03.2001|Jehem
51.06.03.2002|Tembuku
51.06.03.2003|Yangapi
51.06.03.2004|Undisan
51.06.03.2005|Bangbang
51.06.03.2006|Peninjoan
51.06.04.2001|Mengani
51.06.04.2002|Binyan
51.06.04.2003|Ulian
51.06.04.2004|Bunutin
51.06.04.2005|Langgahan
51.06.04.2006|Lembean
51.06.04.2007|Manikliyu
51.06.04.2008|Bayung Cerik
51.06.04.2009|Mangguh
51.06.04.2010|Belancan
51.06.04.2011|Katung
51.06.04.2012|Banua
51.06.04.2013|Abuan
51.06.04.2014|Bonyoh
51.06.04.2015|Sekaan
51.06.04.2016|Bayung Gede
51.06.04.2017|Sekardadi
51.06.04.2018|Kedisan
51.06.04.2019|Buahan
51.06.04.2020|Abangsongan
51.06.04.2021|Suter
51.06.04.2022|Abang Batudinding
51.06.04.2023|Terunyan
51.06.04.2024|Songan A
51.06.04.2025|Songan B
51.06.04.2026|Batur Selatan
51.06.04.2027|Batur Tengah
51.06.04.2028|Batur Utara
51.06.04.2029|Kintamani
51.06.04.2030|Serai
51.06.04.2031|Daup
51.06.04.2032|Awan
51.06.04.2033|Gunungbau
51.06.04.2034|Belanga
51.06.04.2035|Batukaang
51.06.04.2036|Belantih
51.06.04.2037|Catur
51.06.04.2038|Pengejaran
51.06.04.2039|Selulung
51.06.04.2040|Satra
51.06.04.2041|Dausa
51.06.04.2042|Bantang
51.06.04.2043|Sukawana
51.06.04.2044|Kutuh
51.06.04.2045|Subaya
51.06.04.2046|Siakin
51.06.04.2047|Pinggan
51.06.04.2048|Belandingan
51.07.01.2001|Nongan
51.07.01.2002|Rendang
51.07.01.2003|Menanga
51.07.01.2004|Besakih
51.07.01.2005|Pempatan
51.07.01.2006|Pesaban
51.07.02.2001|Tangkup
51.07.02.2002|Talibeng
51.07.02.2003|Sidemen
51.07.02.2004|Sangkan Gunung
51.07.02.2005|Telagatawang
51.07.02.2006|Sinduwati
51.07.02.2007|Tri Eka Buana
51.07.02.2008|Kertha Buana
51.07.02.2009|Lokasari
51.07.02.2010|Wisma Kerta
51.07.03.2001|Gegelang
51.07.03.2002|Antiga
51.07.03.2003|Ulakan
51.07.03.2004|Manggis
51.07.03.2005|Nyuh Tebel
51.07.03.2006|Tenganan
51.07.03.2007|Ngis
51.07.03.2008|Selumbung
51.07.03.2009|Padangbai
51.07.03.2010|Antiga Kelod
51.07.03.2011|Pesedahan
51.07.03.2012|Sengkidu
51.07.04.1002|Subagan
51.07.04.1003|Padangkerta
51.07.04.1004|Karangasem
51.07.04.2001|Bugbug
51.07.04.2005|Tumbu
51.07.04.2006|Seraya
51.07.04.2007|Seraya Barat
51.07.04.2008|Seraya Timur
51.07.04.2009|Pertima
51.07.04.2010|Tegalinggah
51.07.04.2011|Bukit
51.07.05.2001|Ababi
51.07.05.2002|Tiyingtali
51.07.05.2003|Bunutan
51.07.05.2004|Tista
51.07.05.2005|Abang
51.07.05.2006|Pidpid
51.07.05.2007|Datah
51.07.05.2008|Culik
51.07.05.2009|Purwa Kerthi
51.07.05.2010|Kertha Mandala
51.07.05.2011|Laba Sari
51.07.05.2012|Nawa Kerti
51.07.05.2013|Kesimpar
51.07.05.2014|Tri Buana
51.07.06.2001|Bungaya
51.07.06.2002|Budakeling
51.07.06.2003|Bebandem
51.07.06.2004|Sibetan
51.07.06.2005|Jungutan
51.07.06.2006|Bungaya Kangin
51.07.06.2007|Bhuana Giri
51.07.06.2008|Macang
51.07.07.2001|Muncan
51.07.07.2002|Selat
51.07.07.2003|Duda
51.07.07.2004|Sebudi
51.07.07.2005|Duda Utara
51.07.07.2006|Duda Timur
51.07.07.2007|Peringsari
51.07.07.2008|Amerta Bhuana
51.07.08.2001|Ban
51.07.08.2002|Dukuh
51.07.08.2003|Kubu
51.07.08.2004|Tianyar
51.07.08.2005|Tianyar Barat
51.07.08.2006|Tianyar Tengah
51.07.08.2007|Tulamben
51.07.08.2008|Baturinggit
51.07.08.2009|Sukadana
51.08.01.2001|Sumberklampok
51.08.01.2002|Pejarakan
51.08.01.2003|Sumberkima
51.08.01.2004|Pemuteran
51.08.01.2005|Banyupoh
51.08.01.2006|Penyabangan
51.08.01.2007|Musi
51.08.01.2008|Sanggalangit
51.08.01.2009|Gerokgak
51.08.01.2010|Patas
51.08.01.2011|Pengulon
51.08.01.2012|Tinga-tinga
51.08.01.2013|Celukanbawang
51.08.01.2014|Tukadsumaga
51.08.02.1015|Seririt
51.08.02.2001|Unggahan
51.08.02.2002|Ularan
51.08.02.2003|Ringdikit
51.08.02.2004|Rangdu
51.08.02.2005|Mayong
51.08.02.2006|Gunungsari
51.08.02.2007|Munduk Bestala
51.08.02.2008|Bestala
51.08.02.2009|Kalianget
51.08.02.2010|Joanyar
51.08.02.2011|Tangguwisia
51.08.02.2012|Sulanyah
51.08.02.2013|Bubunan
51.08.02.2014|Patemon
51.08.02.2016|Pengastulan
51.08.02.2017|Lokapaksa
51.08.02.2018|Pangkungparuk
51.08.02.2019|Banjarasem
51.08.02.2020|Kalisada
51.08.02.2021|Umeanyar
51.08.03.2001|Sepang
51.08.03.2002|Dapdap Putih
51.08.03.2003|Bongancina
51.08.03.2004|Pucaksari
51.08.03.2005|Telaga
51.08.03.2006|Titab
51.08.03.2007|Subuk
51.08.03.2008|Tinggarsari
51.08.03.2009|Kedis
51.08.03.2010|Kekeran
51.08.03.2011|Busungbiu
51.08.03.2012|Pelapuan
51.08.03.2013|Bengkel
51.08.03.2014|Umejero
51.08.03.2015|Sepang Kelod
51.08.04.2001|Banyuseri
51.08.04.2002|Tirtasari
51.08.04.2003|Kayuputih
51.08.04.2004|Banyuatis
51.08.04.2005|Gesing
51.08.04.2006|Munduk
51.08.04.2007|Gobleg
51.08.04.2008|Pedawa
51.08.04.2009|Cempaga
51.08.04.2010|Sidetapa
51.08.04.2011|Tampekan
51.08.04.2012|Banjar Tegeha
51.08.04.2013|Banjar
51.08.04.2014|Dencarik
51.08.04.2015|Temukus
51.08.04.2016|Tigawasa
51.08.04.2017|Kaliasem
51.08.05.1009|Sukasada
51.08.05.2001|Pancasari
51.08.05.2002|Wanagiri
51.08.05.2003|Ambengan
51.08.05.2004|Gitgit
51.08.05.2005|Pegayaman
51.08.05.2006|Silangjana
51.08.05.2007|Pegadungan
51.08.05.2008|Padangbulia
51.08.05.2010|Sambangan
51.08.05.2011|Panji
51.08.05.2012|Panji Anom
51.08.05.2013|Tegallinggah
51.08.05.2014|Selat
51.08.05.2015|Kayuputih
51.08.06.1006|Banyuasri
51.08.06.1007|Banjar Tegal
51.08.06.1008|Kendran
51.08.06.1009|Paket Agung
51.08.06.1010|Kampung Singaraja
51.08.06.1011|Liligundi
51.08.06.1012|Beratan
51.08.06.1019|Banyuning
51.08.06.1020|Penarukan
51.08.06.1021|Kampung Kajanan
51.08.06.1022|Astina
51.08.06.1023|Banjar Jawa
51.08.06.1024|Kaliuntu
51.08.06.1025|Kampung Anyar
51.08.06.1026|Kampung Bugis
51.08.06.1027|Banjar Bali
51.08.06.1029|Kampung Baru
51.08.06.2001|Kalibukbuk
51.08.06.2002|Anturan
51.08.06.2003|Tukadmungga
51.08.06.2004|Pemaron
51.08.06.2005|Baktiseraga
51.08.06.2013|Sarimekar
51.08.06.2014|Nagasepaha
51.08.06.2015|Petandakan
51.08.06.2016|Alasangker
51.08.06.2017|Poh Bergong
51.08.06.2018|Jinengdalem
51.08.06.2028|Penglatan
51.08.07.2001|Lemukih
51.08.07.2002|Galungan
51.08.07.2003|Sekumpul
51.08.07.2004|Bebetin
51.08.07.2005|Sudaji
51.08.07.2006|Sawan
51.08.07.2007|Menyali
51.08.07.2008|Suwug
51.08.07.2009|Jagaraga
51.08.07.2010|Sinabun
51.08.07.2011|Kerobokan
51.08.07.2012|Sangsit
51.08.07.2013|Bungkulan
51.08.07.2014|Giri Emas
51.08.08.2001|Tambakan
51.08.08.2002|Pakisan
51.08.08.2003|Bontihing
51.08.08.2004|Tajun
51.08.08.2005|Tunjung
51.08.08.2006|Depeha
51.08.08.2007|Tamblang
51.08.08.2008|Bulian
51.08.08.2009|Bila
51.08.08.2010|Bengkala
51.08.08.2011|Kubutambahan
51.08.08.2012|Bukti
51.08.08.2013|Mengening
51.08.09.2001|Sembiran
51.08.09.2002|Pacung
51.08.09.2003|Julah
51.08.09.2004|Madenan
51.08.09.2005|Bondalem
51.08.09.2006|Tejakula
51.08.09.2007|Les
51.08.09.2008|Penuktukan
51.08.09.2009|Sambirenteng
51.08.09.2010|Tembok
51.71.01.1001|Serangan
51.71.01.1002|Pedungan
51.71.01.1003|Sesetan
51.71.01.1004|Panjer
51.71.01.1005|Renon
51.71.01.1006|Sanur
51.71.01.2007|Sidakarya
51.71.01.2008|Pemogan
51.71.01.2009|Sanur Kaja
51.71.01.2010|Sanur Kauh
51.71.02.1003|Kesiman
51.71.02.1006|Sumerta
51.71.02.1010|Dangin Puri
51.71.02.1014|Penatih
51.71.02.2001|Dangin Puri Kelod
51.71.02.2002|Sumerta Kelod
51.71.02.2004|Kesiman Petilan
51.71.02.2005|Kesiman Kertalangu
51.71.02.2007|Sumerta Kaja
51.71.02.2008|Sumerta Kauh
51.71.02.2015|Penatih Dangin Puri
51.71.03.1005|Dauh Puri
51.71.03.1007|Pemecutan
51.71.03.1010|Padangsambian
51.71.03.2001|Padangsambian Kelod
51.71.03.2002|Pemecutan Kelod
51.71.03.2003|Dauh Puri Kauh
51.71.03.2004|Dauh Puri Kelod
51.71.03.2006|Dauh Puri Kangin
51.71.03.2008|Tegal Harum
51.71.03.2009|Tegal Kertha
51.71.03.2011|Padang Sambian Kaja
51.71.04.1004|Tonja
51.71.04.1007|Ubung
51.71.04.1009|Peguyangan
51.71.04.2001|Dangin Puri Kangin
51.71.04.2002|Dangin Puri Kauh
51.71.04.2003|Dangin Puri Kaja
51.71.04.2005|Pemecutan Kaja
51.71.04.2006|Dauh Puri Kaja
51.71.04.2008|Ubung Kaja
51.71.04.2010|Peguyangan Kaja
51.71.04.2011|Peguyangan Kangin
52.01.01.1001|Gerung Utara
52.01.01.1004|Dasan Geres
52.01.01.1011|Gerung Selatan
52.01.01.2002|Kebon Ayu
52.01.01.2003|Gapuk
52.01.01.2005|Suka Makmur
52.01.01.2006|Banyu Urip
52.01.01.2007|Babussalam
52.01.01.2008|Dasan Tapen
52.01.01.2009|Beleka
52.01.01.2010|Tempos
52.01.01.2012|Mesanggok
52.01.01.2013|Taman Ayu
52.01.01.2014|Giri Tembesi
52.01.02.2001|Kediri
52.01.02.2002|Montong Are
52.01.02.2003|Jagaraga Indah
52.01.02.2004|Gelogor
52.01.02.2005|Rumak
52.01.02.2006|Banyumulek
52.01.02.2007|Ombe Baru
52.01.02.2008|Dasan Baru
52.01.02.2009|Kediri Selatan
52.01.02.2010|Lelede
52.01.03.2001|Lembuak
52.01.03.2002|Nyur Lembang
52.01.03.2003|Peresak
52.01.03.2004|Keru
52.01.03.2005|Batu Kuta
52.01.03.2006|Tanak Beak
52.01.03.2007|Sedau
52.01.03.2008|Suranadi
52.01.03.2009|Selat
52.01.03.2010|Lebah Sempage
52.01.03.2011|Sesaot
52.01.03.2012|Dasan Tereng
52.01.03.2013|Badrain
52.01.03.2014|Sembung
52.01.03.2015|Krama Jaya
52.01.03.2016|Gerimax Indah
52.01.03.2017|Pakuan
52.01.03.2018|Golong
52.01.03.2019|Mekarsari
52.01.03.2020|Buwun Sejati
52.01.03.2021|Narmada
52.01.07.2001|Sekotong Tengah
52.01.07.2002|Sekotong Barat
52.01.07.2003|Pelangan
52.01.07.2004|Buwun Mas
52.01.07.2005|Kedaro
52.01.07.2006|Batu Putih
52.01.07.2007|Gili Gede Indah
52.01.07.2008|Cendi Manik
52.01.07.2009|Taman Baru
52.01.08.2001|Bengkel
52.01.08.2002|Merembu
52.01.08.2003|Bagik Polak
52.01.08.2004|Telagawaru
52.01.08.2005|Perampuan
52.01.08.2006|Bajur
52.01.08.2007|Terong Tawah
52.01.08.2008|Kuranji
52.01.08.2009|Karang Bongkot
52.01.08.2010|Labuapi
52.01.08.2011|Bagik Polak Barat
52.01.08.2012|Kuranji Dalang
52.01.09.2001|Gunungsari
52.01.09.2002|Midang
52.01.09.2003|Sesela
52.01.09.2004|Kekait
52.01.09.2005|Kekeri
52.01.09.2006|Mambalan
52.01.09.2007|Dopang
52.01.09.2008|Penimbung
52.01.09.2009|Taman Sari
52.01.09.2010|Jatisela
52.01.09.2011|Guntur Macan
52.01.09.2012|Mekar Sari
52.01.09.2013|Ranjok
52.01.09.2014|Gelangsar
52.01.09.2015|Jeringo
52.01.09.2016|Bukittinggi
52.01.12.2001|Lingsar
52.01.12.2002|Batu Kumbung
52.01.12.2003|Sigerongan
52.01.12.2004|Duman
52.01.12.2005|Karang Bayan
52.01.12.2006|Langko
52.01.12.2007|Dasan Geria
52.01.12.2008|Peteluan Indah
52.01.12.2009|Gegerung
52.01.12.2010|Batu Mekar
52.01.12.2011|Giri Madia
52.01.12.2012|Bug-Bug
52.01.12.2013|Gegelang
52.01.12.2014|Saribaye
52.01.12.2015|Gontoran
52.01.13.2001|Lembar
52.01.13.2002|Jembatan Kembar
52.01.13.2003|Mareje
52.01.13.2004|Sekotong Timur
52.01.13.2005|Labuan Tereng
52.01.13.2006|Jembatan Gantung
52.01.13.2007|Lembar Selatan
52.01.13.2008|Mareje Timur
52.01.13.2009|Jembatan Kembar Timur
52.01.13.2010|Eyat Mayang
52.01.14.2001|Batulayar
52.01.14.2002|Meninting
52.01.14.2003|Sandik
52.01.14.2004|Lembah Sari
52.01.14.2005|Senteluk
52.01.14.2006|Senggigi
52.01.14.2007|Bengkaung
52.01.14.2008|Pusuk Lestari
52.01.14.2009|Batu Layar Barat
52.01.15.2001|Kuripan
52.01.15.2002|Jagaraga
52.01.15.2003|Kuripan Utara
52.01.15.2004|Kuripan Selatan
52.01.15.2005|Kuripan Timur
52.01.15.2006|Giri Sasak
52.02.01.1001|Praya
52.02.01.1002|Leneng
52.02.01.1003|Gerunung
52.02.01.1004|Semayan
52.02.01.1005|Perapen
52.02.01.1006|Tiwugalih
52.02.01.1007|Gonjak
52.02.01.1008|Panji Sari
52.02.01.1009|Renteng
52.02.01.2010|Mertak Tombok
52.02.01.2011|Aik Mual
52.02.01.2012|Montong Terep
52.02.01.2013|Jago
52.02.01.2014|Bunut Baok
52.02.01.2015|Mekar Damai
52.02.02.2001|Barejulat
52.02.02.2002|Ubung
52.02.02.2003|Jelantik
52.02.02.2004|Labulia
52.02.02.2005|Batu Tulis
52.02.02.2006|Perina
52.02.02.2007|Pengenjek
52.02.02.2008|Puyung
52.02.02.2009|Nyerot
52.02.02.2010|Sukarara
52.02.02.2011|Gemel
52.02.02.2012|Bonjeruk
52.02.02.2013|Bunkate
52.02.03.2001|Bujak
52.02.03.2002|Selebung
52.02.03.2003|Peresak
52.02.03.2004|Mantang
52.02.03.2005|Aik Darek
52.02.03.2006|Tampak Siring
52.02.03.2007|Barabali
52.02.03.2008|Beber
52.02.03.2009|Pagutan
52.02.03.2010|Mekar Bersatu
52.02.03.2011|Lendang Tampel
52.02.04.2001|Sengkol
52.02.04.2002|Segala Anyar
52.02.04.2003|Sukadana
52.02.04.2004|Teruwai
52.02.04.2005|Pengengat
52.02.04.2006|Kawo
52.02.04.2007|Gapura
52.02.04.2008|Rembitan
52.02.04.2009|Kuta
52.02.04.2010|Pengembur
52.02.04.2011|Tumpak
52.02.04.2012|Mertak
52.02.04.2013|Prabu
52.02.04.2014|Tanak Awu
52.02.04.2015|Ketara
52.02.04.2016|Bangket Parak
52.02.04.2017|Dadap
52.02.04.2018|Kerame Jati
52.02.05.2001|Bonder
52.02.05.2002|Banyu Urip
52.02.05.2003|Mangkung
52.02.05.2004|Kateng
52.02.05.2005|Setanggor
52.02.05.2006|Penujak
52.02.05.2007|Selong Belanak
52.02.05.2008|Mekar Sari
52.02.05.2009|Batujai
52.02.05.2010|Tanak Rarang
52.02.06.2001|Sukaraja
52.02.06.2002|Beleka
52.02.06.2003|Semoyang
52.02.06.2004|Mujur
52.02.06.2005|Landah
52.02.06.2006|Sengkerang
52.02.06.2007|Bilelando
52.02.06.2008|Ganti
52.02.06.2009|Marong
52.02.06.2010|Kidang
52.02.06.2011|Beleke Daye
52.02.06.2012|Beleke Lebe Sane
52.02.06.2013|Pegonak
52.02.06.2014|Jero Puri
52.02.07.2001|Lekor
52.02.07.2002|Langko
52.02.07.2003|Janapria
52.02.07.2004|Loang Maka
52.02.07.2005|Saba
52.02.07.2006|Bakan
52.02.07.2007|Durian
52.02.07.2008|Pendem
52.02.07.2009|Selebung Rembiga
52.02.07.2010|Kerembong
52.02.07.2011|Jango
52.02.07.2012|Setuta
52.02.07.2013|Prako
52.02.07.2014|Tibu Sisok
52.02.07.2015|Janggawana
52.02.07.2016|Lingkok Berenge
52.02.08.2001|Pringgarata
52.02.08.2002|Sepakek
52.02.08.2003|Murbaya
52.02.08.2004|Bagu
52.02.08.2005|Sintung
52.02.08.2006|Bilebante
52.02.08.2007|Pemepek
52.02.08.2008|Menemeng
52.02.08.2009|Arjangka
52.02.08.2010|Taman Indah
52.02.08.2011|Sisik
52.02.09.2001|Lendang Are
52.02.09.2002|Monggas
52.02.09.2003|Muncan
52.02.09.2004|Bebuak
52.02.09.2005|Kopang Rembiga
52.02.09.2006|Dasan Baru
52.02.09.2007|Montong Gamang
52.02.09.2008|Darmaji
52.02.09.2009|Wajageseng
52.02.09.2010|Aik Bual
52.02.09.2011|Semparu
52.02.09.2012|Berinding
52.02.09.2013|Pajangan
52.02.10.1001|Gerantung
52.02.10.1002|Jontlak
52.02.10.1003|Sasake
52.02.10.2004|Jurang Jaler 
52.02.10.2005|Beraim
52.02.10.2006|Batunyala
52.02.10.2007|Lajut
52.02.10.2008|Pengadang
52.02.10.2009|Kelebuh
52.02.10.2010|Pejanggik
52.02.10.2011|Dakung
52.02.10.2012|Prai Meke
52.02.10.2013|Lelong
52.02.11.2001|Montong Sapah
52.02.11.2002|Ungga
52.02.11.2003|Kabul
52.02.11.2004|Pelambik
52.02.11.2005|Darek
52.02.11.2006|Ranggagata
52.02.11.2007|Pandan Indah
52.02.11.2008|Serage
52.02.11.2009|Montong Ajan
52.02.11.2010|Batu Jangkih
52.02.11.2011|Teduh
52.02.11.2012|Pandan Tinggang
52.02.12.2001|Lantan
52.02.12.2002|Setiling
52.02.12.2003|Tanak Beak
52.02.12.2004|Aik Bukaq
52.02.12.2005|Teratak
52.02.12.2006|Aik Berik
52.02.12.2007|Mas-mas
52.02.12.2008|Karang Sidemen
52.03.01.2001|Tanjung Luar
52.03.01.2002|Pijot
52.03.01.2003|Selebung Ketangga
52.03.01.2004|Sepit
52.03.01.2005|Batu Putik
52.03.01.2006|Senyiur
52.03.01.2007|Keruak
52.03.01.2008|Ketapang Raya
52.03.01.2009|Pijot Utara
52.03.01.2010|Dane Rase
52.03.01.2011|Ketangga Jeraeng
52.03.01.2012|Mendana Raya
52.03.01.2013|Setungkep Lingsar
52.03.01.2014|Montong Belae
52.03.01.2015|Pulau Maringkik
52.03.02.2001|Suwangi
52.03.02.2002|Sakra
52.03.02.2003|Kabar
52.03.02.2004|Rumbuk
52.03.02.2005|Keselet
52.03.02.2006|Sakra Selatan
52.03.02.2007|Rumbuk Timur
52.03.02.2008|Suwangi Timur
52.03.02.2009|Moyot
52.03.02.2010|Songak
52.03.02.2011|Peresak
52.03.02.2012|Kuang Baru
52.03.03.2001|Jenggik
52.03.03.2002|Rarang
52.03.03.2003|Suradadi
52.03.03.2004|Santong
52.03.03.2005|Terara
52.03.03.2006|Sukadana
52.03.03.2007|Rarang Selatan
52.03.03.2008|Leming
52.03.03.2009|Lando
52.03.03.2010|Rarang Tengah
52.03.03.2011|Embung Raja
52.03.03.2012|Selagik
52.03.03.2013|Embung Kandong
52.03.03.2014|Kalianyar
52.03.03.2015|Rarang Batas
52.03.03.2016|Pandan Duri
52.03.04.2001|Semaya
52.03.04.2002|Sikur
52.03.04.2003|Montong Baan
52.03.04.2004|Loyok
52.03.04.2005|Kota Raja
52.03.04.2006|Tete Batu
52.03.04.2007|Kembang Kuning
52.03.04.2008|Montong Baan Selatan
52.03.04.2009|Gelora
52.03.04.2010|Darmasari
52.03.04.2011|Tetebatu Selatan
52.03.04.2012|Jeruk Manis
52.03.04.2013|Sikur Selatan
52.03.04.2014|Sikur Barat
52.03.05.2001|Kesik
52.03.05.2002|Paokmotong
52.03.05.2003|Masbagik Selatan
52.03.05.2004|Masbagik Timur
52.03.05.2005|Masbagik Utara
52.03.05.2006|Danger
52.03.05.2007|Lendang Nangka
52.03.05.2008|Masbagik Utara Baru
52.03.05.2009|Lendang Nangka Utara
52.03.05.2010|Kumbang
52.03.06.2001|Setanggor
52.03.06.2002|Jantuk
52.03.06.2003|Padamara
52.03.06.2004|Dasan Lekong
52.03.06.2005|Sukamulia
52.03.06.2006|Paok Pampang
52.03.06.2007|Sukamulia Timur
52.03.06.2008|Nyiur Tebel
52.03.06.2009|Setanggor Selatan
52.03.07.1001|Pancor
52.03.07.1002|Selong
52.03.07.1003|Kelayu Selatan
52.03.07.1004|Denggen
52.03.07.1005|Sekarteja
52.03.07.1006|Majidi
52.03.07.1007|Rakam
52.03.07.1008|Sandu Baya
52.03.07.1009|Kembang Sari
52.03.07.1010|Kelayu Utara
52.03.07.1011|Kelaju Jorong
52.03.07.2012|Danggen Timur
52.03.08.2001|Bagik Papan
52.03.08.2002|Apit Aik
52.03.08.2003|Kerumut
52.03.08.2004|Pohgading
52.03.08.2005|Batuyang
52.03.08.2006|Pringgabaya
52.03.08.2007|Labuhan Lombok
52.03.08.2008|Pringgabaya Utara
52.03.08.2009|Pohgading Timur
52.03.08.2010|Teko
52.03.08.2011|Anggaraksa
52.03.08.2012|Tanak Gadang
52.03.08.2013|Gunung Malang
52.03.08.2014|Seruni Mumbul
52.03.08.2015|Telaga Waru
52.03.09.2002|Aikmel
52.03.09.2003|Kalijaga
52.03.09.2004|Kembang Kerang
52.03.09.2007|Aikmel Utara
52.03.09.2008|Kalijaga Timur
52.03.09.2009|Kalijaga Selatan
52.03.09.2010|Aikmel Barat
52.03.09.2011|Kembang Kerang Daya
52.03.09.2014|Toya
52.03.09.2019|Kalijaga Tengah
52.03.09.2020|Bagik Nyaka Santri
52.03.09.2021|Aik Prapa
52.03.09.2023|Aikmel Timur
52.03.09.2024|Keroya
52.03.10.2001|Obel-obel
52.03.10.2002|Belanting
52.03.10.2003|Sambalia
52.03.10.2004|Labuhan Pandan
52.03.10.2005|Sugian
52.03.10.2006|Darakunci
52.03.10.2007|Bagik Manis
52.03.10.2008|Dadap
52.03.10.2009|Madayin
52.03.10.2010|Senanggalih
52.03.10.2011|Padak Guar
52.03.11.2001|Pringga Jurang
52.03.11.2002|Montong Betok
52.03.11.2003|Kilang
52.03.11.2004|Perian
52.03.11.2005|Jenggik Utara
52.03.11.2006|Pringgajurang Utara
52.03.11.2007|Pesanggrahan
52.03.11.2008|Lendang Belo
52.03.12.2001|Rempung
52.03.12.2002|Pringgasela
52.03.12.2003|Jurit
52.03.12.2004|Pengadangan
52.03.12.2005|Aik Dewa
52.03.12.2006|Jurit Baru
52.03.12.2007|Pringgasela Selatan
52.03.12.2008|Pengadangan Barat
52.03.12.2009|Timbanuh
52.03.12.2010|Pringgasela Timur
52.03.13.2001|Anjani
52.03.13.2002|Tebaban
52.03.13.2003|Kerongkong
52.03.13.2004|Bagik Payung
52.03.13.2005|Suralaga
52.03.13.2006|Bagik Payung Selatan
52.03.13.2007|Tumbuh Mulia
52.03.13.2008|Dasan Borok
52.03.13.2009|Gerung Permai
52.03.13.2010|Dames Damai
52.03.13.2011|Bagik Payung Timur
52.03.13.2012|Waringin
52.03.13.2013|Gapuk
52.03.13.2014|Bintang Rinjani
52.03.13.2015|Paok Lombok
52.03.14.2001|Mamben Daya
52.03.14.2002|Mamben Lauk
52.03.14.2003|Wanasaba
52.03.14.2004|Karang Baru
52.03.14.2005|Bebidas
52.03.14.2006|Tembeng Putik
52.03.14.2007|Wanasaba Lauk
52.03.14.2008|Beriri Jarak
52.03.14.2009|Bandok
52.03.14.2010|Mamben Baru
52.03.14.2011|Otak Rarangan
52.03.14.2012|Jineng
52.03.14.2013|Wanasaba Daya
52.03.14.2014|Karang Baru Timur
52.03.15.2001|Sembalun Bumbung
52.03.15.2002|Sembalun Lawang
52.03.15.2003|Sajang
52.03.15.2004|Bilok Petung
52.03.15.2005|Sembalun
52.03.15.2006|Sembalun Timba Gading
52.03.16.2001|Selaparang
52.03.16.2002|Ketangga
52.03.16.2003|Suntalangu
52.03.16.2004|Suela
52.03.16.2005|Sapit
52.03.16.2006|Perigi
52.03.16.2007|Mekar Sari
52.03.16.2008|Puncak Jeringo
52.03.17.1004|Tanjung
52.03.17.1005|Suryawangi
52.03.17.1007|Ijobalit
52.03.17.1012|Geres
52.03.17.2001|Labuhan Haji
52.03.17.2002|Peneda Gandor
52.03.17.2003|Teros
52.03.17.2006|Korleko
52.03.17.2008|Kertasari
52.03.17.2009|Tirtanadi
52.03.17.2010|Banjarsari
52.03.17.2011|Korleko Selatan
52.03.18.2001|Gelanggang
52.03.18.2002|Surabaya
52.03.18.2003|Lepak
52.03.18.2004|Gereneng
52.03.18.2005|Montong Tangi
52.03.18.2006|Menceh
52.03.18.2007|Lepak Timur
52.03.18.2008|Surabaya Utara
52.03.18.2009|Gereneng Timur
52.03.18.2010|Lenting
52.03.19.2001|Sukarara
52.03.19.2002|Gunung Rajak
52.03.19.2003|Rensing
52.03.19.2004|Bungtiang
52.03.19.2005|Pengkelak Mas
52.03.19.2006|Borok Toyang
52.03.19.2007|Rensing Raya
52.03.19.2008|Pematung
52.03.19.2009|Jerogunung
52.03.19.2010|Pejaring
52.03.19.2011|Boyemare
52.03.19.2012|Montong Beter
52.03.19.2013|Mengkuru
52.03.19.2014|Gadungmas
52.03.19.2015|Kembang Are Sampai
52.03.19.2016|Rensing Bat
52.03.19.2017|Tanak Kaken
52.03.19.2018|Gerisak Semanggeleng
52.03.20.2001|Batu Nampar
52.03.20.2002|Sukaraja
52.03.20.2003|Jerowaru
52.03.20.2004|Pemongkong
52.03.20.2005|Sekaroh
52.03.20.2006|Pandan Wangi
52.03.20.2007|Wakan
52.03.20.2008|Kwang Rundun
52.03.20.2009|Ekas Buana
52.03.20.2010|Sepapan
52.03.20.2011|Seriwe
52.03.20.2012|Pene
52.03.20.2013|Batunampar Selatan
52.03.20.2014|Sukadamai
52.03.20.2015|Pare Mas
52.03.21.2001|Lenek
52.03.21.2002|Lenek Lauk
52.03.21.2003|Lenek Daya
52.03.21.2004|Lenek Baru
52.03.21.2005|Lenek Kalibambang
52.03.21.2006|Lenek Pesiraman
52.03.21.2007|Lenek Ramban Biak
52.03.21.2008|Lenek Duren
52.03.21.2009|Sukarema
52.03.21.2010|Kalijaga Baru
52.04.02.2001|Lunyuk Rea
52.04.02.2002|Lunyuk Ode
52.04.02.2003|Jamu
52.04.02.2007|Pada Suka
52.04.02.2008|Sukamaju
52.04.02.2009|Perung
52.04.02.2010|Emang Lestari
52.04.05.2001|Luar
52.04.05.2002|Baru
52.04.05.2003|Kalimango
52.04.05.2004|Marente
52.04.05.2005|Juran Alas
52.04.05.2006|Dalam
52.04.05.2007|Pulau Bungin
52.04.05.2012|Labuhan Alas
52.04.06.2001|Stowe Brang
52.04.06.2002|Labuhan Bajo
52.04.06.2003|Pukat
52.04.06.2004|Orong Bawa
52.04.06.2005|Jorok
52.04.06.2006|Motong
52.04.06.2007|Tengah
52.04.06.2008|Sabedo
52.04.06.2012|Bale Brang
52.04.07.2001|Batu Rotok
52.04.07.2002|Tangkam Pulit
52.04.07.2003|Bao Desa
52.04.07.2004|Tepal
52.04.07.2005|Batu Dulang
52.04.07.2006|Kelungkung
52.04.08.1001|Samapuin
52.04.08.1002|Brang Bara
52.04.08.1003|Pekat
52.04.08.1004|Seketeng
52.04.08.1005|Bugis
52.04.08.1006|Lempeh
52.04.08.1007|Brang Biji
52.04.08.1008|Uma Sima
52.04.09.2001|Moyo
52.04.09.2002|Kakiang
52.04.09.2003|Ngeru
52.04.09.2004|Berare
52.04.09.2005|Poto
52.04.09.2009|Serading
52.04.09.2010|Olat Rawa
52.04.09.2011|Batu Bangka
52.04.09.2013|Moyo Mekar
52.04.09.2014|Labuhan Ijuk
52.04.10.2001|Sempe
52.04.10.2002|Semamung
52.04.10.2003|Sebasang
52.04.10.2004|Batu Tering
52.04.10.2005|Batu Bulan
52.04.10.2006|Mokong
52.04.10.2007|Pernek
52.04.10.2008|Leseng
52.04.10.2009|Lito
52.04.10.2010|Marga Karya
52.04.10.2011|Maman
52.04.10.2012|Brang Rea
52.04.11.2002|Lebin
52.04.11.2003|Lebangkar
52.04.11.2008|Ropang
52.04.11.2009|Lawin
52.04.11.2010|Ranan
52.04.12.2003|Lape
52.04.12.2005|Labuhan Kuris
52.04.12.2006|Dete
52.04.12.2009|Hijrah
52.04.13.2003|Muer
52.04.13.2004|Plampang
52.04.13.2005|Teluk Santong
52.04.13.2006|Sepayung
52.04.13.2007|Sepakat
52.04.13.2008|UPT. Prode SP.I
52.04.13.2009|UPT. Prode SP II
52.04.13.2010|UPT. Prode SP III
52.04.13.2012|Selanteh
52.04.13.2013|Brang Kolong
52.04.13.2014|Usar
52.04.14.2001|Boal
52.04.14.2002|Jotang
52.04.14.2003|Empang Atas
52.04.14.2004|Empang Bawa
52.04.14.2005|Ongko
52.04.14.2012|Lamenta
52.04.14.2013|Gapit
52.04.14.2014|Pamanto
52.04.14.2015|Bunga Eja
52.04.14.2016|Jotang Beru
52.04.17.2001|Mapin Rea
52.04.17.2002|Mapin Kebak
52.04.17.2003|Labuhan Mapin
52.04.17.2004|Lekong
52.04.17.2005|Gontar
52.04.17.2006|Usar Mapin
52.04.17.2007|Gontar Baru
52.04.17.2008|Mapin Beru
52.04.18.2001|Labuhan Badas
52.04.18.2002|Karang Dima
52.04.18.2003|Labuhan Sumbawa
52.04.18.2004|Labuhan Aji
52.04.18.2005|Sebotok
52.04.18.2006|Bajo Medang
52.04.18.2007|Bugis Medang
52.04.19.2001|Labangka
52.04.19.2002|Sekokat
52.04.19.2003|Suka Mulya
52.04.19.2004|Suka Damai
52.04.19.2005|Jaya Makmur
52.04.20.2001|Tarusa
52.04.20.2002|Juru Mapin
52.04.20.2003|Kalabeso
52.04.20.2004|Labuhan Burung
52.04.20.2005|Pulau Kaung
52.04.20.2006|Buin Baru
52.04.21.2001|Rhee
52.04.21.2002|Sampe
52.04.21.2003|Luk
52.04.21.2004|Rhee Loka
52.04.22.2001|Pelat
52.04.22.2002|Kerekeh
52.04.22.2003|Boak
52.04.22.2004|Jorok
52.04.22.2005|Kerato
52.04.22.2006|Pungka
52.04.22.2007|Uma Beringin
52.04.22.2008|Nijang
52.04.23.2001|Pungkit
52.04.23.2002|Sebewe
52.04.23.2003|Penyaring
52.04.23.2004|Kukin
52.04.23.2005|Baru Tahan
52.04.23.2006|Songkar
52.04.24.2001|Simu
52.04.24.2002|Maronge
52.04.24.2003|Pemasar
52.04.24.2004|Labuhan Sangoro
52.04.25.2001|Bantulanteh
52.04.25.2002|Labuhan Bontong
52.04.25.2003|Labuhan Aji
52.04.25.2004|Labuhan Jambu
52.04.25.2005|Mata
52.04.25.2006|Tolo' Oi
52.04.25.2007|Banda
52.04.25.2008|Labuhan Pidang
52.04.26.2001|Pungkit
52.04.26.2002|Berora
52.04.26.2003|Lopok
52.04.26.2004|Langam
52.04.26.2005|Mama
52.04.26.2006|Lopok Beru
52.04.26.2007|Tatede
52.04.27.2001|Tatebal
52.04.27.2002|Lenangguar
52.04.27.2003|Ledang
52.04.27.2004|Telaga
52.04.28.2001|Senawang
52.04.28.2002|Kelawis
52.04.28.2003|Mungkin
52.04.28.2004|Sebeok
52.04.29.2001|Lantung
52.04.29.2002|Sepukur
52.04.29.2003|Ai Mual
52.04.29.2004|Padesa
52.05.01.1001|Bada
52.05.01.1002|Bali
52.05.01.1003|Potu
52.05.01.1004|Karijawa
52.05.01.1005|Dora Tangga
52.05.01.1006|Kandai I
52.05.01.2007|O'o
52.05.01.2008|Katua
52.05.01.2009|Karamabura
52.05.01.2010|Mbawi
52.05.01.2011|Dore Bara
52.05.01.2012|Kareke
52.05.01.2013|Mangge Nae
52.05.01.2014|Manggeasi
52.05.01.2015|Sori Sakolo
52.05.02.2001|Kempo
52.05.02.2002|Ta'a
52.05.02.2003|Soro
52.05.02.2004|Konte
52.05.02.2005|Tolo Kalo
52.05.02.2006|Songgaja
52.05.02.2007|Doro Kobo
52.05.02.2008|Soro Barat
52.05.03.2001|Rasa Bou
52.05.03.2002|Daha
52.05.03.2003|Hu'u
52.05.03.2004|Adu
52.05.03.2005|Cempi Jaya
52.05.03.2006|Merada
52.05.03.2007|Jala
52.05.03.2008|Sawe
52.05.04.2001|Malaju
52.05.04.2002|Lasi
52.05.04.2003|Mbuju
52.05.04.2004|Kiwu
52.05.04.2005|Taropo
52.05.04.2006|Karama
52.05.05.1001|Monta Baru
52.05.05.1002|Kandai II
52.05.05.1003|Simpasai
52.05.05.2004|Saneo
52.05.05.2005|Wawonduru
52.05.05.2006|Matua
52.05.05.2007|Nowa
52.05.05.2008|Bara
52.05.05.2009|Mada Prama
52.05.05.2010|Riwo
52.05.05.2011|Mumbu
52.05.05.2012|Sera Kapi
52.05.05.2013|Raba Baka
52.05.05.2014|Baka Jaya
52.05.06.2001|Pekat
52.05.06.2002|Nangamiro
52.05.06.2003|Kadindi
52.05.06.2004|Beringin Jaya
52.05.06.2005|Sori Nomo
52.05.06.2006|Tambora
52.05.06.2007|Doro Peti
52.05.06.2008|Karombo
52.05.06.2009|Kadindi Barat
52.05.06.2010|Nangakara
52.05.06.2011|Sori Tatanga
52.05.06.2012|Calabai
52.05.07.2001|Soriutu
52.05.07.2002|Banggo
52.05.07.2003|Kwangko
52.05.07.2004|Lanci Jaya
52.05.07.2005|Suka Damai
52.05.07.2006|Nusa Jaya
52.05.07.2007|Doromelo
52.05.07.2008|Nangatumpu
52.05.07.2009|Kampasi Meci
52.05.07.2010|Teka Sire
52.05.07.2011|Anamina
52.05.07.2012|Tanju
52.05.08.2001|Ranggo
52.05.08.2002|Jambu
52.05.08.2003|Lepadi
52.05.08.2004|Lune
52.05.08.2005|Woko
52.05.08.2006|Tembal Lae
52.06.01.2005|Tolotangga
52.06.01.2006|Sondo
52.06.01.2007|Simpasai
52.06.01.2008|Sie
52.06.01.2009|Tangga
52.06.01.2010|Monta
52.06.01.2011|Sakuru
52.06.01.2012|Baralau
52.06.01.2014|Tolouwi
52.06.01.2015|Wilamaci
52.06.01.2016|Pela
52.06.01.2017|Tangga Baru
52.06.01.2018|Nontotera
52.06.01.2019|Waro
52.06.02.2001|Tambe
52.06.02.2002|Rasabou
52.06.02.2003|Rato
52.06.02.2004|Kananga
52.06.02.2005|Leu
52.06.02.2006|Timu
52.06.02.2007|Bontokape
52.06.02.2008|Sondosia
52.06.02.2009|Nggembe
52.06.02.2010|Sanolo
52.06.02.2011|Tumpu
52.06.02.2012|Rada
52.06.02.2013|Kara
52.06.02.2014|Darussalam
52.06.03.2001|Keli
52.06.03.2002|Tenga
52.06.03.2003|Tente
52.06.03.2004|Rabakodo
52.06.03.2005|Samili
52.06.03.2006|Kalampa
52.06.03.2007|Risa
52.06.03.2008|Pandai
52.06.03.2009|Donggobolo
52.06.03.2010|Dadibou
52.06.03.2011|Talabiu
52.06.03.2012|Naru
52.06.03.2013|Nisa
52.06.03.2014|Waduwani
52.06.03.2015|Penapali
52.06.04.2001|Ncera
52.06.04.2002|Lido
52.06.04.2003|Ngali
52.06.04.2004|Renda
52.06.04.2005|Cenggu
52.06.04.2006|Runggu
52.06.04.2014|Soki
52.06.04.2015|Roka
52.06.04.2016|Diha
52.06.05.2001|Tarlawi
52.06.05.2005|Ntori
52.06.05.2006|Maria
52.06.05.2007|Pesa
52.06.05.2008|Raba
52.06.05.2011|Kambilo
52.06.05.2012|Maria Utara
52.06.05.2013|Kombo
52.06.05.2014|Riamau
52.06.06.2001|Sari
52.06.06.2002|Boke
52.06.06.2003|Jia
52.06.06.2004|Bugis
52.06.06.2005|Naru
52.06.06.2006|Rasabou
52.06.06.2007|Sangia
52.06.06.2008|Na'e
52.06.06.2009|Rai Oi
52.06.06.2010|Parangina
52.06.06.2011|Kowo
52.06.06.2012|Buncu
52.06.06.2013|Poja
52.06.06.2014|Bajo Pulau
52.06.06.2015|Naru Barat
52.06.06.2016|Tanah Putih
52.06.06.2017|Lamere
52.06.06.2018|Oi Maci
52.06.07.2001|Ntoke
52.06.07.2002|Pai
52.06.07.2003|Nunggi
52.06.07.2004|Tawali
52.06.07.2005|Hidirasa
52.06.07.2006|Wora
52.06.07.2007|Sangiang
52.06.07.2008|Bala
52.06.07.2009|Oi Tui
52.06.07.2010|Tadewa
52.06.07.2011|Nanga Wera
52.06.07.2012|Ranggasolo
52.06.07.2013|Kalajena
52.06.07.2014|Mandala
52.06.08.2005|Doridungga
52.06.08.2006|Kala
52.06.08.2007|O'o
52.06.08.2008|Mbawa
52.06.08.2009|Palama
52.06.08.2010|Rora
52.06.08.2012|Mpili
52.06.08.2013|Bumi Pajo
52.06.08.2014|Ndano Na'e
52.06.09.2001|Piong
52.06.09.2002|Boro
52.06.09.2003|Kore
52.06.09.2004|Taloko
52.06.09.2005|Oi Saro
52.06.09.2006|Sandue
52.06.10.2001|Nipa
52.06.10.2002|Tolowata
52.06.10.2003|Rite
52.06.10.2004|Mawu
52.06.10.2005|Talapiti
52.06.10.2006|Kole
52.06.11.2001|Waworada
52.06.11.2002|Karumbu
52.06.11.2003|Rupe
52.06.11.2004|Kalodu
52.06.11.2005|Kawuwu
52.06.11.2006|Doro O'o
52.06.11.2007|Laju
52.06.11.2008|Kangga
52.06.11.2009|Karampi
52.06.11.2010|Waduruka
52.06.11.2011|Dumu
52.06.11.2012|Rompo
52.06.11.2013|Sarae Ruma
52.06.11.2014|Pusu
52.06.11.2015|Sambane
52.06.12.2001|Kaleo
52.06.12.2002|Simpasai
52.06.12.2003|Mangge
52.06.12.2004|Lanta
52.06.12.2005|Nggelu
52.06.12.2006|Rato
52.06.12.2007|Sumi
52.06.12.2008|Soro
52.06.12.2009|Lambu
52.06.12.2010|Hidirasa
52.06.12.2011|Lanta Barat
52.06.12.2012|Melayu
52.06.12.2013|Sangga
52.06.12.2014|Monta Baru
52.06.13.2001|Woro
52.06.13.2002|Campa
52.06.13.2003|Mpuri
52.06.13.2004|Ndano
52.06.13.2005|Monggo
52.06.13.2006|Dena
52.06.13.2007|Rade
52.06.13.2008|Tonda
52.06.13.2009|Bolo
52.06.13.2010|Madawau
52.06.13.2011|Ncandi
52.06.14.2001|Labuan Kananga
52.06.14.2002|Kawinda Nae
52.06.14.2003|Kawinda Toi
52.06.14.2004|Oi Panihi
52.06.14.2005|Oi Bura
52.06.14.2006|Oi Katupa
52.06.14.2007|Rasabou
52.06.15.2001|Bajo
52.06.15.2002|Punti
52.06.15.2003|Wadukopa
52.06.15.2004|Kananta
52.06.15.2005|Sai
52.06.15.2006|Sampungu
52.06.15.2007|Lewintana
52.06.16.2001|Paradowane
52.06.16.2002|Paradorato
52.06.16.2003|Kuta
52.06.16.2004|Kanca
52.06.16.2005|Lere
52.06.17.2001|Kaboro
52.06.17.2002|Kuta
52.06.17.2003|Sambori
52.06.17.2004|Teta
52.06.17.2005|Kaowa
52.06.17.2006|Londu
52.06.18.2001|Panda
52.06.18.2002|Belo
52.06.18.2003|Tonggondoa
52.06.18.2004|Tonggorisa
52.06.18.2005|Teke
52.06.18.2006|Ntonggu
52.06.18.2007|Nata
52.06.18.2008|Dore
52.06.18.2009|Roi
52.06.18.2011|Ragi
52.06.18.2012|Padolo
52.06.18.2013|Bre
52.07.01.2001|Goa
52.07.01.2002|Belo
52.07.01.2003|Beru
52.07.01.2009|Dasan Anyar
52.07.02.1004|Menala
52.07.02.1005|Kuang
52.07.02.1006|Bugis
52.07.02.1007|Dalam
52.07.02.1008|Sampir
52.07.02.1012|Telaga Bertong
52.07.02.1019|Arab Kenangan
52.07.02.2001|Labuhan Lalar
52.07.02.2009|Lalar Liang
52.07.02.2010|Labuhan Kertasari
52.07.02.2011|Seloto
52.07.02.2013|Tamekan
52.07.02.2014|Banjar
52.07.02.2015|Batu Putih
52.07.02.2020|Sermong
52.07.02.2021|Lamunga
52.07.03.2001|Meraran
52.07.03.2002|Air Suning
52.07.03.2003|Rempe
52.07.03.2004|Seteluk Atas
52.07.03.2005|Seteluk Tengah
52.07.03.2008|Kelanir
52.07.03.2011|Tapir
52.07.03.2013|Lamusung
52.07.03.2014|Seran
52.07.03.2015|Desaloka
52.07.04.2001|Sekongkang Atas
52.07.04.2002|Sekongkang Bawah
52.07.04.2003|Tongo
52.07.04.2004|Ai Kangkung
52.07.04.2005|Tatar
52.07.04.2006|Talonang Baru
52.07.04.2007|Kemuning
52.07.05.2001|Desa Beru
52.07.05.2002|Tepas
52.07.05.2003|Bangkat Monteh
52.07.05.2004|Sapugara Bree
52.07.05.2005|Tepas Sepakat
52.07.05.2006|Lamuntet
52.07.05.2007|Rarak Ronges
52.07.05.2008|Moteng
52.07.05.2009|Seminar Salit
52.07.06.2001|Senayan
52.07.06.2002|Mantar
52.07.06.2003|Kiantar
52.07.06.2004|Poto Tano
52.07.06.2005|UPT Tambak Sari
52.07.06.2006|Kokarlian
52.07.06.2007|Tebo
52.07.06.2008|Tuananga
52.07.07.2001|Mura
52.07.07.2002|Kalimantong
52.07.07.2003|Lampok
52.07.07.2004|Manemeng
52.07.07.2005|Mujahiddin
52.07.07.2006|Mataiyang
52.07.08.2001|Maluk
52.07.08.2002|Benete
52.07.08.2003|Bukit Damai
52.07.08.2004|Mantun
52.07.08.2005|Pasir Putih
52.08.01.2001|Tanjung
52.08.01.2002|Sokong
52.08.01.2003|Jenggala
52.08.01.2004|Tegal Maja
52.08.01.2005|Sigar Penjalin
52.08.01.2006|Medana
52.08.01.2007|Teniga
52.08.01.2008|Sama Guna
52.08.02.2001|Gondang
52.08.02.2002|Bentek
52.08.02.2003|Genggelang
52.08.02.2004|Rempek
52.08.02.2005|Sambik Bangkol
52.08.02.2006|Selelos
52.08.02.2007|Rempek Darussalam
52.08.02.2008|Segara Katon
52.08.03.2001|Kayangan
52.08.03.2002|Santong
52.08.03.2003|Selengen
52.08.03.2004|Sesait
52.08.03.2005|Gumantar
52.08.03.2006|Salut
52.08.03.2007|Dangiang
52.08.03.2008|Pendua
52.08.03.2009|Pansor
52.08.03.2010|Santong Mulia
52.08.04.2001|Bayan
52.08.04.2002|Loloan
52.08.04.2003|Anyar
52.08.04.2004|Sukadana
52.08.04.2005|Akar Akar
52.08.04.2006|Senaru
52.08.04.2007|Mumbul Sari
52.08.04.2008|Sambik Elen
52.08.04.2009|Karang Bajo
52.08.04.2010|Gunjan Asri
52.08.04.2011|Andalan
52.08.04.2012|Batu Rakit
52.08.05.2001|Pemenang Timur
52.08.05.2002|Pemenang Barat
52.08.05.2003|Gili Indah
52.08.05.2004|Malaka
52.08.05.2005|Menggala
52.71.01.1004|Ampenan Selatan
52.71.01.1005|Ampenan Tengah
52.71.01.1006|Pejeruk
52.71.01.1007|Ampenan Utara
52.71.01.1008|Taman Sari
52.71.01.1009|Banjar
52.71.01.1010|Kebun Sari
52.71.01.1011|Pejarakan Karya
52.71.01.1012|Dayan Peken
52.71.01.1013|Bintaro
52.71.02.1001|Pagesangan
52.71.02.1002|Mataram Timur
52.71.02.1008|Pagutan
52.71.02.1009|Pagesangan Barat
52.71.02.1010|Pagesangan Timur
52.71.02.1011|Pejanggik
52.71.02.1012|Punia
52.71.02.1013|Pagutan Timur
52.71.02.1014|Pagutan Barat
52.71.03.1004|Cakranegara Selatan
52.71.03.1005|Cakranegara Barat
52.71.03.1006|Cakranegara Timur
52.71.03.1007|Cakranegara Utara
52.71.03.1009|Sayang-sayang
52.71.03.1010|Cakranegara Selatan Baru
52.71.03.1011|Sapta Marga
52.71.03.1012|Cilinaya
52.71.03.1013|Mayura
52.71.03.1014|Karang Taliwang
52.71.04.1001|Karang Pule
52.71.04.1002|Tanjung Karang
52.71.04.1003|Jempong Baru
52.71.04.1004|Tanjung Karang Permai
52.71.04.1005|Kekalik Jaya
52.71.05.1001|Mataram Barat
52.71.05.1002|Dasan Agung
52.71.05.1003|Monjok
52.71.05.1004|Karang Baru
52.71.05.1005|Rembiga
52.71.05.1006|Gomong
52.71.05.1007|Dasan Agung Baru
52.71.05.1008|Monjok Timur
52.71.05.1009|Monjok Barat
52.71.06.1001|Dasan Cermen
52.71.06.1002|Babakan
52.71.06.1003|Bertais
52.71.06.1004|Selagalas
52.71.06.1005|Abian Tubuh Baru
52.71.06.1006|Turida
52.71.06.1007|Mandalika
52.72.01.1001|Paruga
52.72.01.1002|Nae
52.72.01.1003|Sarae
52.72.01.1004|Tanjung
52.72.01.1013|Pane
52.72.01.1014|Dara
52.72.02.1004|Kumbe
52.72.02.1008|Lampe
52.72.02.1009|Dodu
52.72.02.1011|Nungga
52.72.02.1018|Kodo
52.72.02.1019|Oi Fo'o
52.72.02.1020|Lelamase
52.72.02.1021|Oimbo
52.72.03.1001|Melayu
52.72.03.1002|Jatiwangi
52.72.03.1003|Jatibaru
52.72.03.1004|Kolo
52.72.03.1005|Jatibaru Timur
52.72.03.1006|Ule
52.72.04.1001|Penaraga
52.72.04.1002|Rontu
52.72.04.1003|PenanaE
52.72.04.1004|Kendo
52.72.04.1005|Ntobo
52.72.04.1006|Nitu
52.72.04.1007|Rabangodu Selatan
52.72.04.1008|Rabadompu Timur
52.72.04.1009|Rite
52.72.04.1010|Rabadompu Barat
52.72.04.1011|Rabangodu Utara
52.72.05.1001|Monggonao
52.72.05.1002|Sadia
52.72.05.1003|Santi
52.72.05.1004|Sambinae
52.72.05.1005|Penatoi
52.72.05.1006|Lewirato
52.72.05.1007|Mande
52.72.05.1008|Panggi
52.72.05.1009|Manggemaci
52.72.05.1010|Matakando
53.01.04.2003|Bokonusan
53.01.04.2004|Otan
53.01.04.2005|Uitao
53.01.04.2006|Uiasa
53.01.04.2008|Hansisi
53.01.04.2009|Huilelot
53.01.04.2011|Batuinan
53.01.04.2013|Letbaun
53.01.05.1001|Oenesu
53.01.05.1002|Batakte
53.01.05.2003|Manulai I
53.01.05.2004|Sumlili
53.01.05.2005|Lifuleo
53.01.05.2006|Tesabela
53.01.05.2007|Oematnunu
53.01.05.2008|Kuanheun
53.01.05.2009|Nitneo
53.01.05.2010|Bolok
53.01.05.2011|Tablolong
53.01.05.2012|Oenaek
53.01.06.1001|Babau
53.01.06.1003|Naibonat
53.01.06.1004|Oesao
53.01.06.1005|Merdeka
53.01.06.1008|Tuatuka
53.01.06.2002|Nunkurus
53.01.06.2006|Tuapukan
53.01.06.2007|Oefafi
53.01.06.2011|Pukdale
53.01.06.2015|Oesao
53.01.06.2016|Manusak
53.01.06.2017|Tanah Putih
53.01.06.2018|Oelatimo
53.01.07.1001|Sulamu
53.01.07.2002|Pitai
53.01.07.2003|Pariti
53.01.07.2004|Oeteta
53.01.07.2005|Bipolo
53.01.07.2006|Pantai Beringin
53.01.07.2007|Pantulan
53.01.08.1007|Tarus
53.01.08.2006|Oelnasi
53.01.08.2008|Noelbaki
53.01.08.2009|Oelpuah
53.01.08.2010|Oebelo
53.01.08.2011|Penfui Timur
53.01.08.2012|Tanah Merah
53.01.08.2013|Mata Air
53.01.09.1002|Nonbes
53.01.09.2001|Oesena
53.01.09.2003|Ponain
53.01.09.2004|Kotabes
53.01.09.2005|Tesbatan
53.01.09.2006|Oenoni
53.01.09.2007|Apren
53.01.09.2008|Oenoni II
53.01.09.2009|Tesbatan II
53.01.10.1001|Camplong I
53.01.10.2007|Camplong II
53.01.10.2008|Naunnu
53.01.10.2009|Oebola
53.01.10.2010|Sillu
53.01.10.2011|Ekateta
53.01.10.2012|Kuimasi
53.01.10.2013|Tolnaku
53.01.10.2014|Oebola Dalam
53.01.10.2015|Kiuoni
53.01.11.1007|Takari
53.01.11.2001|Noelmina
53.01.11.2002|Benu
53.01.11.2003|Hueknutu
53.01.11.2004|Oelnaineno
53.01.11.2005|Tanini
53.01.11.2006|Kauniki
53.01.11.2008|Tuapanaf
53.01.11.2009|Fatukona
53.01.11.2010|Oesusu
53.01.12.1003|Lelogama
53.01.12.2001|Fatusuki
53.01.12.2002|Oelbanu
53.01.12.2004|Fatumetan
53.01.12.2005|Oh'aem
53.01.12.2008|Leloboko
53.01.12.2011|Oh'aem II
53.01.13.1002|Naikliu
53.01.13.2001|Afoan
53.01.13.2003|Fatunaus
53.01.13.2004|Kolabe
53.01.13.2005|Bakuin
53.01.13.2010|Lilmus
53.01.16.2001|Oelomin
53.01.16.2002|Tasikona
53.01.16.2003|Oemasi
53.01.16.2004|Usapi Sonbai
53.01.16.2005|Oenif
53.01.16.2006|Tunfeu
53.01.16.2007|Oepaha
53.01.16.2008|Bone
53.01.16.2009|Taloetan
53.01.16.2010|Oben
53.01.16.2011|Bismarak
53.01.17.1001|Teunbaun
53.01.17.2002|Soba
53.01.17.2003|Toobaun
53.01.17.2004|Niukbaun
53.01.17.2005|Tunbaun
53.01.17.2006|Nekbaun
53.01.17.2007|Merbaun
53.01.17.2008|Erbaun
53.01.18.1001|Buraen
53.01.18.1002|Sonraen
53.01.18.2003|Nekmese
53.01.18.2004|Retraen
53.01.18.2005|Sahraen
53.01.19.2001|Oebesi
53.01.19.2002|Pakubaun
53.01.19.2003|Rabeka
53.01.19.2004|Enoraen
53.01.20.2001|Seki
53.01.20.2002|Oemofa
53.01.20.2003|Nunmafo
53.01.20.2004|Muke
53.01.20.2005|Pathau
53.01.20.2006|Oeniko
53.01.20.2007|Oenuntono
53.01.20.2008|Oemolo
53.01.20.2009|Enolanan
53.01.20.2010|Oenaunu
53.01.21.2001|Manubelon
53.01.21.2002|Letkole
53.01.21.2003|Nefoneut
53.01.21.2004|Bioba Baru
53.01.22.2001|Soliu
53.01.22.2002|Saukibe
53.01.22.2003|Oelfatu
53.01.22.2004|Timau
53.01.22.2005|Honuk
53.01.22.2006|Faumes
53.01.23.2001|Akle
53.01.23.2002|Uitiuh Ana
53.01.23.2003|Onansila
53.01.23.2004|Uitiuh Tuan
53.01.23.2005|Naikean
53.01.23.2006|Uiboa
53.01.24.2001|Oeltuah
53.01.24.2002|Baumata
53.01.24.2003|Kuaklalo
53.01.24.2004|Oeletsala
53.01.24.2005|Bokong
53.01.24.2006|Baumata Utara
53.01.24.2007|Baumata Timur
53.01.24.2008|Baumata Barat
53.01.25.2001|Fatukanutu
53.01.25.2002|Kairane
53.01.25.2003|Raknamo
53.01.25.2004|Kuanheum
53.01.25.2005|Fatuteta
53.01.25.2006|Oefeto
53.01.25.2007|Niunbaun
53.01.26.2001|Nunuanah
53.01.26.2002|Kifu
53.01.26.2003|Netemnanu Selatan
53.01.26.2004|Netemnanu Utara
53.01.26.2005|Netemnanu
53.01.27.2001|Poto
53.01.27.2002|Nuataus
53.01.27.2003|Kalali
53.01.27.2004|Tuakau
53.01.27.2005|Naitae
53.01.28.2001|Oelbiteno
53.01.28.2002|Nonbaun
53.01.28.2003|Nunsaen
53.01.28.2004|Passi
53.01.30.2001|Fatumonas
53.01.30.2002|Binafun
53.01.30.2003|Bitobe
53.01.30.2004|Bonmuti
53.02.01.1001|SoE
53.02.01.1002|Cendana
53.02.01.1003|Oebesa
53.02.01.1004|Taubneno
53.02.01.1005|Nonohonis
53.02.01.1006|Karang Sirih
53.02.01.1007|Nunumeu
53.02.01.1008|Kobekamusa
53.02.01.1009|Oe Kefan
53.02.01.1010|Kota Baru
53.02.01.1011|Kampung Baru
53.02.01.2012|Kuatae
53.02.01.2013|Noemeto
53.02.02.2001|Biloto
53.02.02.2003|Kesetnana
53.02.02.2006|Tuasene
53.02.02.2008|Oinlasi
53.02.02.2010|Bisene
53.02.02.2012|Noinbila
53.02.02.2013|Bikekneno
53.02.03.2001|O'besi
53.02.03.2002|Eonbesi
53.02.03.2003|Bosen
53.02.03.2004|Sebot
53.02.03.2007|Ajaobaki
53.02.03.2008|Netpala
53.02.03.2009|Tunua
53.02.03.2010|Bijaepunu
53.02.03.2011|Nefokoko
53.02.03.2012|Leloboko
53.02.03.2013|Lelobatan
53.02.03.2014|Halmei
53.02.03.2015|Fatukoto
53.02.03.2016|Kokfe'u
53.02.03.2017|To'fen
53.02.03.2018|Taiftob
53.02.03.2019|Iusmolo
53.02.03.2020|To'manat
53.02.04.2001|Billa
53.02.04.2002|Oelet
53.02.04.2004|Pisan
53.02.04.2005|Mauleum
53.02.04.2007|Nifukiu
53.02.04.2008|Mnelaanen
53.02.04.2009|Teluk
53.02.04.2012|Oe'Ekam
53.02.04.2016|Sini
53.02.04.2017|Tliu
53.02.05.1010|Niki-Niki
53.02.05.2001|Taebesa
53.02.05.2002|Nakfunu
53.02.05.2003|Oe'ekam
53.02.05.2004|Baki
53.02.05.2005|Tumu
53.02.05.2006|Noebesa
53.02.05.2007|Nobi-Nobi
53.02.05.2008|Sopo
53.02.05.2009|Bone
53.02.05.2011|Maunum Niki-Niki
53.02.06.2001|Pollo
53.02.06.2002|Oekiu
53.02.06.2003|Oebelo
53.02.06.2004|Noemuke
53.02.06.2010|Kiubaat
53.02.06.2011|Linamnutu
53.02.06.2014|Mio
53.02.06.2015|Batnun
53.02.06.2018|Bena
53.02.06.2019|Eno Neten
53.02.07.2007|Tublopo
53.02.07.2008|Nule
53.02.07.2009|Nusa
53.02.07.2010|Mnelalete
53.02.07.2011|Pusu
53.02.07.2012|Tubuhue
53.02.07.2013|Haumeni Baki
53.02.07.2015|Nifukani
53.02.08.2001|Oinlasi
53.02.08.2002|Nunle'u
53.02.08.2003|Kokoi
53.02.08.2004|Fenun
53.02.08.2005|Kuale'u
53.02.08.2006|Lanu
53.02.08.2007|Sunu
53.02.08.2008|Anin
53.02.08.2009|To'i
53.02.08.2010|Nifuleo
53.02.08.2011|Fatulunu
53.02.08.2012|Fae
53.02.08.2013|Netutnana
53.02.09.2001|Lilo
53.02.09.2002|Fotilo
53.02.09.2003|Nasi
53.02.09.2004|Snok
53.02.09.2005|Tumu
53.02.09.2006|Fatu Oni
53.02.09.2007|Sono
53.02.09.2009|Tauanas
53.02.09.2015|Muna
53.02.10.2001|Pilli
53.02.10.2002|Falas
53.02.10.2003|Oenai
53.02.10.2004|Belle
53.02.10.2005|Napi
53.02.10.2006|Boti
53.02.10.2007|Fatuulan
53.02.10.2008|Tesiayofanu
53.02.10.2009|Oinlasi
53.02.10.2010|Nekmese
53.02.10.2011|Eno Napi
53.02.10.2012|Fatukusi
53.02.10.2013|Naile'u
53.02.11.2001|Olais
53.02.11.2002|Lasi
53.02.11.2003|Kakan
53.02.11.2005|Basmuti
53.02.11.2006|Kusi
53.02.11.2007|Kuanfatu
53.02.11.2008|Kelle
53.02.11.2009|Taupi
53.02.11.2010|Oebo
53.02.11.2011|Kusi Utara
53.02.11.2012|Kelle Tunan
53.02.11.2013|Noebeba
53.02.11.2014|Oehan
53.02.12.2001|Nenas
53.02.12.2004|Fatumnasi
53.02.12.2005|Nuapin
53.02.12.2009|Kuanoel
53.02.12.2010|Mutis
53.02.13.2001|Konbaki
53.02.13.2002|Fatumnutu
53.02.13.2003|Bijeli
53.02.13.2004|Loli
53.02.13.2005|Usapimnasi
53.02.13.2006|Mnesatbubuk
53.02.13.2007|Puna
53.02.13.2008|Laob
53.02.13.2009|Oelnunuh
53.02.13.2010|Balu
53.02.13.2011|Sainoni
53.02.14.2001|Benlutu
53.02.14.2002|Boentuka
53.02.14.2003|Hane
53.02.14.2004|Oebobo
53.02.14.2005|Tupan
53.02.14.2006|Tuakole
53.02.14.2007|Oehela
53.02.15.2006|Sabun
53.02.15.2007|Nano
53.02.15.2009|Boking
53.02.15.2010|Baus
53.02.15.2011|Meusin
53.02.15.2013|Leonmeni
53.02.15.2014|Fatu Manufui
53.02.16.2001|Toianas
53.02.16.2002|Skinu
53.02.16.2003|Oeleu
53.02.16.2004|Sanbet
53.02.16.2005|Bokong
53.02.16.2006|Tuataum
53.02.16.2007|Lobus
53.02.16.2008|Noeolin
53.02.16.2009|Milli
53.02.17.2001|OP
53.02.17.2002|Sahan
53.02.17.2003|Nenoat
53.02.17.2004|Haineno
53.02.17.2005|Nunkolo
53.02.17.2006|Saenam
53.02.17.2007|Fat
53.02.17.2008|Haumeni
53.02.17.2009|Putun
53.02.18.2001|Neke
53.02.18.2002|Pene Utara
53.02.18.2003|Noenoni
53.02.18.2004|Hoi
53.02.18.2005|Niki Niki Un
53.02.18.2006|Oenino
53.02.18.2007|Abi
53.02.19.2001|Kolbano
53.02.19.2002|Noesiu
53.02.19.2003|Pene Selatan
53.02.19.2004|Oetuke
53.02.19.2005|Babuin
53.02.19.2006|Oeleu
53.02.19.2007|Se'i
53.02.19.2008|Nununamat
53.02.19.2009|Pana
53.02.19.2010|Haunobenak
53.02.19.2011|Ofu
53.02.19.2012|Spaha
53.02.20.2001|Kot'olin
53.02.20.2002|Nunbena
53.02.20.2003|Fatuat
53.02.20.2004|Hoibeti
53.02.20.2005|Nualunat
53.02.20.2006|Binenok
53.02.20.2007|Ponite
53.02.20.2008|O'obibi
53.02.21.2001|Kualin
53.02.21.2002|Oni
53.02.21.2003|Nunusunu
53.02.21.2004|Tuapakas
53.02.21.2005|Toineke
53.02.21.2006|Tuafanu
53.02.21.2007|Kiufatu
53.02.21.2008|Oemaman
53.02.22.2001|Besana
53.02.22.2002|Fatukoko
53.02.22.2003|Koa
53.02.22.2004|Oel Uban
53.02.22.2005|Salbait
53.02.23.2001|Lotas
53.02.23.2002|Sabnala
53.02.23.2003|Koloto
53.02.23.2004|Niti
53.02.23.2005|Obaki
53.02.23.2006|Benehe
53.02.24.2001|Noebana
53.02.24.2002|Fatumnasi
53.02.24.2003|Suni
53.02.24.2004|Mella
53.02.24.2005|Mnelapetu
53.02.25.2001|Santian
53.02.25.2002|Poli
53.02.25.2003|Manufui
53.02.25.2004|Nenotes
53.02.25.2005|Naifatu
53.02.26.2001|Naip
53.02.26.2002|Fatutnana
53.02.26.2003|Oepliki
53.02.26.2004|Oe'ekam
53.02.26.2005|Teas
53.02.26.2006|Oebaki
53.02.26.2007|Eno Nabuasa
53.02.27.2001|Tetaf
53.02.27.2002|Naukae
53.02.27.2003|Supul
53.02.27.2004|Lakat
53.02.27.2005|Enoneontes
53.02.27.2006|O'of
53.02.27.2007|Tubmonas
53.02.27.2008|Oe Oe
53.02.28.2001|Sillu
53.02.28.2002|Nunukhniti
53.02.28.2003|Kaeneno
53.02.28.2004|Oeleon
53.02.28.2005|Tunis
53.02.28.2006|Bileon
53.02.28.2007|Besle'u
53.02.29.2001|Fatukopa
53.02.29.2002|Besnam
53.02.29.2003|Taebone
53.02.29.2004|Nunfutu
53.02.29.2005|Kiki
53.02.29.2006|Ello
53.02.29.2007|Nifulinah
53.02.30.2001|Oelbubuk
53.02.30.2002|Nekemunifeto
53.02.30.2003|Binaus
53.02.30.2004|Oel'Ekam
53.02.30.2005|Kualeu
53.02.30.2006|Pika
53.02.31.2001|Tobu
53.02.31.2002|Tutem
53.02.31.2003|Tune
53.02.31.2004|Bonleu
53.02.31.2005|Pubasu
53.02.31.2006|Huetalan
53.02.31.2007|Saubalan
53.02.31.2008|Bestobe
53.02.32.2001|Lill ana
53.02.32.2002|Nunbena
53.02.32.2003|Noebesi
53.02.32.2004|Taneotob
53.02.32.2005|Feto Mone
53.02.32.2006|Tunbes
53.03.01.2005|Bokon
53.03.01.2006|Bitefa
53.03.01.2007|Keanbaun
53.03.01.2018|Amol
53.03.01.2019|Fatusene
53.03.01.2020|Oesena
53.03.01.2021|Jak
53.03.01.2022|Tuntun
53.03.01.2023|Tunoe
53.03.01.2024|Femnasi
53.03.01.2025|Taekas
53.03.02.2001|Noepesu
53.03.02.2002|Fatuneno
53.03.02.2003|Suanae
53.03.02.2004|Lemon
53.03.02.2005|Fatunisuan
53.03.02.2006|Haulasi
53.03.02.2018|Neotoko
53.03.02.2019|Fatutasu
53.03.02.2020|Manusasi
53.03.02.2025|Saenam
53.03.02.2026|Eban
53.03.02.2027|Sallu
53.03.02.2028|Sa'tab
53.03.03.2001|Pantae
53.03.03.2002|Oenaem
53.03.03.2003|Upfaon
53.03.03.2007|Tautpah
53.03.03.2009|Tokbesi
53.03.03.2010|Sainiup
53.03.03.2011|Supun
53.03.03.2012|Tunbaen
53.03.04.2001|Bijeli
53.03.04.2002|Noebaun
53.03.04.2003|Seo
53.03.04.2004|Popnam
53.03.04.2009|Nibaaf
53.03.04.2010|Banfanu
53.03.04.2011|Oenak
53.03.04.2012|Nifuboke
53.03.04.2013|Noemuti
53.03.04.2014|Fatumuti
53.03.04.2015|Kiuola
53.03.04.2016|Oeperigi
53.03.05.1001|Kefamenanu Utara
53.03.05.1002|Aplasi
53.03.05.1003|Kefamenanu Tengah
53.03.05.1004|Bansone
53.03.05.1005|Benpasi
53.03.05.1006|Kefamenanu Selatan
53.03.05.1007|Tubuhue
53.03.05.1008|Maubeli
53.03.05.1009|Sasi
53.03.06.1015|Boronubaen Timur
53.03.06.2001|Boronubaen
53.03.06.2002|Hautaes
53.03.06.2003|Tualena
53.03.06.2004|Biloe
53.03.06.2005|Taunbaen
53.03.06.2006|Sapaen
53.03.06.2012|Lokomea
53.03.06.2013|Taunbaen Timur
53.03.06.2014|Hauteas Barat
53.03.07.2001|Motadik
53.03.07.2002|Nonotbatan
53.03.07.2003|Sifaniha
53.03.07.2004|Maukabatan
53.03.07.2005|Kotafoun
53.03.07.2006|Tuamese
53.03.07.2007|Ponu
53.03.07.2008|Oemanu
53.03.07.2009|Nifutasi
53.03.08.1029|Bitauni
53.03.08.2005|Nansean
53.03.08.2006|Susulaku
53.03.08.2007|Loeram
53.03.08.2008|Manunain B
53.03.08.2010|Tapenpah
53.03.08.2011|Sekon
53.03.08.2015|Ainiut
53.03.08.2016|Nunmafo
53.03.08.2017|Oenbit
53.03.08.2018|Manunain A
53.03.08.2022|Susulaku B
53.03.08.2024|Fatoin
53.03.08.2025|Keun
53.03.08.2026|Fatu'Ana
53.03.08.2027|Botof
53.03.08.2028|Nansean Timur
53.03.09.2006|Fatumtasa
53.03.09.2007|Oesoko
53.03.09.2008|Humusu Sainiup
53.03.09.2009|Humusu Oekolo
53.03.09.2010|Humusu Wini
53.03.10.2001|Naob
53.03.10.2002|Haekto
53.03.10.2003|Manikin
53.03.10.2004|Kuaken
53.03.11.2001|Tuabatan
53.03.11.2002|Akomi
53.03.11.2003|Bijaepasu
53.03.11.2004|Neonasi
53.03.11.2005|N i a n
53.03.11.2006|Tuabatan Barat
53.03.12.2001|Oelneke
53.03.12.2002|Oetulu
53.03.12.2003|Oeolo
53.03.12.2004|Ainan
53.03.12.2005|Bisafe
53.03.12.2006|Batnes
53.03.13.2001|Tasinifu
53.03.13.2002|Naekake A
53.03.13.2003|Naekake B
53.03.13.2004|Noelelo
53.03.14.2001|Oelami
53.03.14.2002|Kiusili
53.03.14.2003|Naiola
53.03.14.2004|Maurisu
53.03.14.2005|Oetalus
53.03.14.2006|Tublopo
53.03.14.2007|Maurisu Utara
53.03.14.2008|Maurisu Selatan
53.03.14.2009|Maurisu Tengah
53.03.14.2010|Naiola Timur
53.03.15.2001|Buk
53.03.15.2002|Oenenu
53.03.15.2003|Nimasi
53.03.15.2004|Oelbonak
53.03.15.2005|Kuenak
53.03.15.2006|Oenino
53.03.15.2007|Oenenu Utara
53.03.15.2008|Oenenu Selatan
53.03.15.2009|Sono
53.03.16.2001|Inbate
53.03.16.2002|Sunkaen
53.03.16.2003|Nainaban
53.03.16.2004|Haumeni Ana
53.03.16.2005|Nilulat
53.03.16.2006|Tubu
53.03.17.2001|Faenake
53.03.17.2002|Banain A
53.03.17.2003|Banain B
53.03.17.2004|Banain C
53.03.17.2005|Sainoni
53.03.17.2006|Tes
53.03.17.2007|Napan
53.03.17.2008|Haumeni
53.03.17.2009|Baas
53.03.18.2001|Manamas
53.03.18.2002|Benus
53.03.18.2003|Bakitolas
53.03.18.2004|Sunsea
53.03.19.2001|Fafinesu A
53.03.19.2002|Fafinesu B
53.03.19.2003|Fafinesu C
53.03.19.2004|Oenain
53.03.19.2005|Baunuan
53.03.19.2006|Fafinesu
53.03.20.2001|Subun
53.03.20.2002|Usapinonot
53.03.20.2003|Lapeom
53.03.20.2004|Letneo
53.03.20.2005|Bannae
53.03.20.2006|Unini
53.03.20.2007|Atmen
53.03.20.2008|Letneo Selatan
53.03.20.2009|Oabikase
53.03.20.2010|Nifunenas
53.03.20.2011|Subun Bestobe
53.03.20.2012|Subun Tualele
53.03.21.2001|Lanaus
53.03.21.2002|Letmafo
53.03.21.2003|Tainsala
53.03.21.2004|Maubesi
53.03.21.2005|Sone
53.03.21.2006|Letmafo Timur
53.03.21.2007|Oehalo
53.03.22.2001|Teba
53.03.22.2002|Oerinbesi
53.03.22.2003|Oekopa
53.03.22.2004|T'Eba Timur
53.03.23.2001|Tunbes
53.03.23.2002|Luniup
53.03.23.2003|Matabesi
53.03.23.2004|Oepuah
53.03.23.2005|Kaubele
53.03.23.2006|Oepuah Utara
53.03.23.2007|Oepuah Selatan
53.03.24.2001|Naku
53.03.24.2002|Birunatun
53.03.24.2003|Makun
53.03.24.2004|Manumean
53.03.24.2005|Kuluan
53.04.01.2001|Kewar
53.04.01.2002|Fulur
53.04.01.2004|Duarato
53.04.01.2005|Makir
53.04.01.2006|Lamaksenulu
53.04.01.2008|Dirun
53.04.01.2009|Leowalu
53.04.01.2014|Maudemu
53.04.01.2015|Mahuitas
53.04.02.2001|Silawan
53.04.02.2002|Tulakadi
53.04.02.2003|Sadi
53.04.02.2004|Umaklaran
53.04.02.2005|Manleten
53.04.02.2006|Fatuba'a
53.04.02.2007|Dafala
53.04.02.2008|Takirin
53.04.02.2009|Bauho
53.04.02.2010|Sarabau
53.04.02.2018|Tialai
53.04.02.2019|Halimodok
53.04.03.2001|Asumanu
53.04.03.2002|Tohe
53.04.03.2003|Maumutin
53.04.03.2004|Raifatus
53.04.03.2005|Aitoun
53.04.03.2006|Tohe Leten
53.04.04.2001|Tukuneno
53.04.04.2002|Naekasa
53.04.04.2003|Lookeu
53.04.04.2004|Derokfaturene
53.04.04.2005|Bakustulama
53.04.04.2006|Rinbesihat
53.04.04.2007|Naitimu
53.04.04.2009|Lawalutolus
53.04.05.2001|Fatuketi
53.04.05.2002|Dualaus
53.04.05.2003|Jenilu
53.04.05.2004|Kenebibi
53.04.05.2005|Leosama
53.04.05.2006|Kabuna
53.04.12.1001|Kota Atambua
53.04.12.1002|Tenukiik
53.04.12.1003|Manumutin
53.04.12.1010|Fatubenao
53.04.13.2001|Mandeu Raimanus
53.04.13.2002|Renrua
53.04.13.2003|Dua Koran
53.04.13.2004|Mandeu
53.04.13.2005|Rafae
53.04.13.2006|Faturika
53.04.13.2007|Leuntolu
53.04.13.2008|Teun
53.04.13.2009|Tasain
53.04.17.2001|Lasiolat
53.04.17.2002|Maneikun
53.04.17.2003|Lakan Mau
53.04.17.2004|Dualasi Raiulun
53.04.17.2005|Dualasi
53.04.17.2006|Fatulotu
53.04.17.2007|Baudaok
53.04.18.2001|Ekin
53.04.18.2002|Loonuna
53.04.18.2003|Nualain
53.04.18.2004|Lakmaras
53.04.18.2005|Henes
53.04.18.2006|Debululik
53.04.18.2007|Sisi Fatuberal
53.04.18.2008|Lutha Rato
53.04.21.1001|Bardao
53.04.21.1002|Tulamalae
53.04.21.1003|Umanen
53.04.21.1004|Beirafu
53.04.22.1001|Manuaman
53.04.22.1002|Rinbesi
53.04.22.1003|Lidak
53.04.22.1004|Fatukbot
53.04.23.2001|Dubesi
53.04.23.2002|Nanaet
53.04.23.2003|Fohoeka
53.04.23.2004|Nanaenoe
53.05.01.1001|Kalabahi Barat
53.05.01.1002|Kalabahi Kota
53.05.01.1003|Kalabahi Tengah
53.05.01.1004|Kalabahi Timur
53.05.01.1005|Binongko
53.05.01.1006|Nusa Kenari
53.05.01.1008|Welai Barat
53.05.01.1009|Welai Timur
53.05.01.1010|Mutiara
53.05.01.1011|Wetabua
53.05.01.2012|Lendola
53.05.01.2013|Fanating
53.05.01.2014|Motongbang
53.05.01.2015|Air Kenari
53.05.01.2018|Teluk Kenari
53.05.01.2019|Adang Buom
53.05.02.1002|Adang
53.05.02.2003|Alor Kecil
53.05.02.2004|Alor Besar
53.05.02.2005|Ampera
53.05.02.2006|Dulolong
53.05.02.2007|Aimoli
53.05.02.2008|Alila
53.05.02.2009|Otvai
53.05.02.2012|Ternate
53.05.02.2013|Ternate Selatan
53.05.02.2014|Alila Selatan
53.05.02.2019|Pulau Buaya
53.05.02.2020|Hulnani
53.05.02.2022|O'a Mate
53.05.02.2023|Ala'ang
53.05.02.2024|Lefokisu
53.05.02.2025|Bampalola
53.05.02.2026|Lewalu
53.05.02.2027|Dulolong Barat
53.05.03.1001|Moru
53.05.03.2002|Probur
53.05.03.2007|Morba
53.05.03.2008|Pintumas
53.05.03.2009|Wolwal
53.05.03.2010|Halerman
53.05.03.2013|Kafelulang
53.05.03.2014|Moramam
53.05.03.2015|Pailelang
53.05.03.2016|Wolwal Barat
53.05.03.2017|Wolwal Tengah
53.05.03.2018|Wolwal Selatan
53.05.03.2019|Probur Utara
53.05.04.1001|Kelaisi Timur
53.05.04.2002|Kelaisi Barat
53.05.04.2003|Sidabui
53.05.04.2004|Padang Alang
53.05.04.2005|Kuneman
53.05.04.2006|Silaipui
53.05.04.2007|Kelaisi Tengah
53.05.04.2008|Kiraman
53.05.04.2009|Maikang
53.05.04.2010|Malaipea
53.05.04.2011|Tamanapui
53.05.04.2012|Lella
53.05.04.2013|Manmas
53.05.04.2014|Subo
53.05.05.1001|Kolana Utara
53.05.05.2004|Tanglapui
53.05.05.2005|Kolana Selatan
53.05.05.2007|Padang Panjang
53.05.05.2008|Maritaing
53.05.05.2010|Elok
53.05.05.2011|Tanglapui Timur
53.05.05.2012|Mausamang
53.05.05.2013|Belemana
53.05.05.2014|Maukuru
53.05.06.1001|Kabir
53.05.06.2005|Pandai
53.05.06.2009|Bandar
53.05.06.2010|Baolang
53.05.06.2011|Munaseli
53.05.06.2012|Helangdohi
53.05.06.2013|Wailawar
53.05.06.2014|Bana
53.05.06.2016|Bouweli
53.05.06.2017|Bukit Mas
53.05.06.2019|Madar
53.05.07.2001|Lembur Barat
53.05.07.2002|Lembur Tengah
53.05.07.2004|Likwatang
53.05.07.2007|Fungafeng
53.05.07.2008|Fuisama
53.05.07.2009|Nur Benlelang
53.05.07.2010|Kafakbeka
53.05.07.2011|Manetwati
53.05.07.2012|Lakwati
53.05.07.2014|Dapitau
53.05.07.2017|Alim Mebung
53.05.07.2018|Petleng
53.05.07.2019|Welai Selatan
53.05.07.2020|Tominuku
53.05.08.2001|Pido
53.05.08.2002|Waisika
53.05.08.2003|Kamot
53.05.08.2004|Taramana
53.05.08.2005|Nailang
53.05.08.2006|Lippang
53.05.08.2007|Kenarimbala
53.05.08.2008|Air Mancur
53.05.09.2002|Baraler
53.05.09.2003|Kalondama
53.05.09.2007|Leer
53.05.09.2018|Baranusa
53.05.09.2019|Blang Merang
53.05.09.2020|Illu
53.05.09.2024|Piringsina
53.05.10.1001|Kabola
53.05.10.2002|Kopidil
53.05.10.2003|Pante Deere
53.05.10.2004|Lawahing
53.05.10.2005|Alila Timur
53.05.11.1001|Pura
53.05.11.2002|Maru
53.05.11.2003|Pura Utara
53.05.11.2004|Pura Selatan
53.05.11.2005|Pura Timur
53.05.11.2006|Pura Barat
53.05.12.2001|Mataru Selatan
53.05.12.2002|Mataru Utara
53.05.12.2003|Lakatuli
53.05.12.2004|Mataru Timur
53.05.12.2005|Kamaifui
53.05.12.2006|Mataru Barat
53.05.12.2007|Taman Mataru
53.05.13.2001|Langkuru
53.05.13.2002|Purnama
53.05.13.2003|Kailesa
53.05.13.2004|Langkuru Utara
53.05.14.2001|Nule
53.05.14.2002|Kaleb
53.05.14.2003|Batu
53.05.14.2004|Kaera
53.05.14.2005|Mawar
53.05.14.2006|Merdeka
53.05.14.2007|Ombay
53.05.14.2008|Lekom
53.05.14.2009|Bungabali
53.05.14.2010|Tereweng
53.05.14.2011|Lalafang
53.05.15.2001|Lembur Timur
53.05.15.2002|Luba
53.05.15.2003|Talwai
53.05.15.2004|Tulleng
53.05.15.2005|Waimi
53.05.15.2006|Tasi
53.05.16.2001|Tude
53.05.16.2002|Mauta
53.05.16.2003|Muriabang
53.05.16.2004|Tubbe
53.05.16.2005|Tamakh
53.05.16.2006|Bagang
53.05.16.2007|Toang
53.05.16.2008|Eka Jaya
53.05.16.2009|Aramaba
53.05.16.2010|Delaki
53.05.17.2001|Kayang
53.05.17.2002|Marisa
53.05.17.2003|Lamma
53.05.17.2004|Allumang
53.05.17.2005|Beangonong
53.05.17.2006|Kalondama Barat
53.05.17.2007|Kalondama Tengah
53.05.18.2001|Tribur
53.05.18.2002|Wakapsir
53.05.18.2003|Manatang
53.05.18.2004|Orgen
53.05.18.2005|Wakapsir Timur
53.05.18.2006|Kuifana
53.05.18.2007|Margeta
53.06.01.2001|Ojandetun
53.06.01.2002|Hewa
53.06.01.2003|Waiula
53.06.01.2007|Nawakote
53.06.01.2008|Boru
53.06.01.2009|Pululera
53.06.01.2011|Nileknoheng
53.06.01.2012|Hokeng Jaya
53.06.01.2013|Pantai Oa
53.06.01.2014|Boru Kedang
53.06.01.2021|Klatanlo
53.06.02.2001|Kobasoma
53.06.02.2002|Lewolaga
53.06.02.2003|Lewoingu
53.06.02.2004|Tuakepa
53.06.02.2005|Tenawahang
53.06.02.2006|Leraboleng
53.06.02.2007|Serinuho
53.06.02.2008|Watowara
53.06.02.2009|Konga
53.06.02.2010|Ile Gerong
53.06.02.2011|Adabang
53.06.02.2012|Dun Tana Lewoingu
53.06.02.2013|Duli Jaya
53.06.02.2014|Bokang Wolomatang
53.06.03.1001|Waibalun
53.06.03.1002|Lewolere
53.06.03.1003|Pantai Besar
53.06.03.1004|Larantuka
53.06.03.1005|Balela
53.06.03.1006|Pohon Sirih
53.06.03.1007|Lohayong
53.06.03.1008|Lokea
53.06.03.1009|Postoh
53.06.03.1010|Amagarapati
53.06.03.1011|Ekasapta
53.06.03.1012|Sarotari
53.06.03.1013|Weri
53.06.03.1014|Pukentobi Wangin Bao
53.06.03.1021|Waihali
53.06.03.1022|Pohon Bao
53.06.03.1023|Sarotari Tengah
53.06.03.1024|Sarotari Timur
53.06.03.2019|Mokantarak
53.06.03.2020|Lamawalang
53.06.04.2001|Wailolong
53.06.04.2002|Lewoloba
53.06.04.2003|Tiwatobi
53.06.04.2004|Watotutu
53.06.04.2005|Riangkemie
53.06.04.2006|Lewohala
53.06.04.2007|Halakodanuan
53.06.04.2008|Mudakeputu
53.06.05.2006|Lewobunga
53.06.05.2007|Sina Malaka
53.06.05.2008|Ratulodong
53.06.05.2009|Sinar Hadigala
53.06.05.2010|Bahinga
53.06.05.2011|Waibao
53.06.05.2012|Lamatutu
53.06.05.2013|Laton Liwo
53.06.05.2015|Kolaka
53.06.05.2016|Bandona
53.06.05.2017|Nusa Nipa
53.06.05.2018|Patisirawalang
53.06.05.2020|Gekeng Deran
53.06.05.2021|Aransina
53.06.05.2022|Laton Liwo II
53.06.05.2023|Lamanabi
53.06.06.1001|Ritaebang
53.06.06.2002|Tanah Lein
53.06.06.2003|Lamaole
53.06.06.2004|Kalelu
53.06.06.2005|Nuhalolon
53.06.06.2007|Balaweling II
53.06.06.2008|Balaweling I
53.06.06.2009|Pamakayo
53.06.06.2012|Ongalereng
53.06.06.2013|Karawatung
53.06.06.2014|Lamawohong
53.06.06.2015|Daniwato
53.06.06.2017|Lewotanah Ole
53.06.06.2019|Titehena
53.06.06.2020|Lewonama
53.06.07.2002|Watanhura I
53.06.07.2003|Lebao
53.06.07.2004|Watohari
53.06.07.2005|Moton Wutun
53.06.07.2006|Watobuku
53.06.07.2007|Labelen
53.06.07.2008|Menanga
53.06.07.2009|Lohayong I
53.06.07.2010|Wulublolong
53.06.07.2011|Liwo
53.06.07.2012|Tanahwerang
53.06.07.2013|Lewohedo
53.06.07.2014|Lohayong II
53.06.07.2016|Watanhura II
53.06.07.2017|Lewogeka
53.06.07.2018|Lamawai
53.06.07.2019|Kewuta
53.06.08.2008|Duanur
53.06.08.2010|Bukit Saburi I
53.06.08.2011|Waiwadan
53.06.08.2012|Danibao
53.06.08.2013|Pajinian
53.06.08.2014|Ile Pati
53.06.08.2015|Wureh
53.06.08.2016|Tonuwotan
53.06.08.2017|Hurung
53.06.08.2019|Bugalima
53.06.08.2021|Homa
53.06.08.2024|Bukit Saburi II
53.06.08.2026|Kimakamak
53.06.08.2030|Watobaya
53.06.08.2032|Nimundanibao
53.06.08.2033|Waitukan
53.06.08.2035|Woloklibang
53.06.08.2036|Riangpadu
53.06.09.2001|Wailebe
53.06.09.2002|Wotanulumado
53.06.09.2003|Nayubaya
53.06.09.2004|Oyangbarang
53.06.09.2005|Kawela
53.06.09.2006|Klukengnuking
53.06.09.2007|Pandai
53.06.09.2008|Bliko
53.06.09.2009|Samasoge
53.06.09.2011|Tobilota
53.06.09.2012|Tanatukan
53.06.09.2013|Demondei
53.06.10.1001|Waiwerang Kota
53.06.10.1002|Lamatwelu
53.06.10.2003|Dawataa
53.06.10.2004|Terong
53.06.10.2005|Bilal
53.06.10.2006|Lamahala Jaya
53.06.10.2007|Waiburak
53.06.10.2008|Narasaosina
53.06.10.2009|Karinglamalouk
53.06.10.2010|Tuawolo
53.06.10.2011|Kiwangona
53.06.10.2012|Tapobali
53.06.10.2013|Lewobunga
53.06.10.2014|Bloto
53.06.10.2015|Ipiebang
53.06.10.2016|Lamalota
53.06.10.2017|Puhu
53.06.10.2018|Kwaelaga Lamawato
53.06.10.2019|Gelong
53.06.10.2020|Lelen Bala
53.06.10.2021|Saosina
53.06.11.2001|Rodentena
53.06.11.2002|Adolaba
53.06.11.2003|Hinga
53.06.11.2004|Lamapaha
53.06.11.2005|Sukutokan
53.06.11.2006|Nisakarang
53.06.11.2007|Muda
53.06.11.2008|Horinara
53.06.11.2009|Pepageka
53.06.11.2010|Lamabunga
53.06.11.2012|Mangaaleng
53.06.11.2019|Keluwain
53.06.12.2001|Watololong
53.06.12.2002|Tuwagoetobi
53.06.12.2003|Weranggere
53.06.12.2004|Oringbele
53.06.12.2005|Watoone
53.06.12.2006|Lamabelawa
53.06.12.2007|Pledo
53.06.12.2008|Lewopulo
53.06.12.2009|Sandosi
53.06.12.2010|Balaweling
53.06.12.2011|Tobitika
53.06.12.2012|Riangduli
53.06.12.2013|Waiwuring
53.06.12.2014|Bao Bage
53.06.12.2015|Lamaleka
53.06.12.2016|Balaweling Noten
53.06.13.2001|Bedalewun
53.06.13.2002|Nihaone
53.06.13.2003|Lewobelolong
53.06.13.2004|Bungalawan
53.06.13.2005|Lamawolo
53.06.13.2006|Helanlangowuyo
53.06.13.2007|Lewopao
53.06.13.2008|Gayak
53.06.13.2009|Boleng
53.06.13.2010|Neleblolong
53.06.13.2011|Duablolong
53.06.13.2012|Lewokeleng
53.06.13.2013|Nelelamawangi
53.06.13.2014|Harubala
53.06.13.2015|Nelelamadike
53.06.13.2016|Lamabayung
53.06.13.2017|Lewat
53.06.13.2018|Dokeng
53.06.13.2019|Bajuntaa
53.06.13.2020|Nobo
53.06.13.2021|Nelelamawangi II
53.06.14.2001|Lamika
53.06.14.2002|Watotika Ile
53.06.14.2003|Lewokluok
53.06.14.2004|Blepanawa
53.06.14.2005|Kawalelo
53.06.14.2006|Bama
53.06.14.2007|Lewo Muda
53.06.15.2001|Ile Padung
53.06.15.2002|Bantala
53.06.15.2003|Sinar Hading
53.06.15.2004|Painapang
53.06.15.2005|Balukhering
53.06.15.2006|Riangkotek
53.06.15.2007|Lewobelen
53.06.16.2001|Riangbaring
53.06.16.2002|Lewotobi
53.06.16.2003|Nurabelen
53.06.16.2004|Nobo
53.06.16.2005|Lewoawang
53.06.16.2006|Duli Pali
53.06.16.2007|Riang Rita
53.06.17.2001|Sagu
53.06.17.2002|Kolimasang
53.06.17.2003|Kolilanang
53.06.17.2004|Tikatukang
53.06.17.2005|Nisanulan
53.06.17.2006|Lamahoda
53.06.17.2007|Adonara
53.06.17.2008|Kolipetung
53.06.18.2001|Horowura
53.06.18.2002|Kokotobo
53.06.18.2003|Lite
53.06.18.2004|Kenotan
53.06.18.2005|Nubalema
53.06.18.2006|Wewit
53.06.18.2007|Lewobele
53.06.18.2008|Baya
53.06.18.2009|Bidara
53.06.18.2010|Oesayang
53.06.18.2011|Hoko Horowura
53.06.18.2012|Lewopao
53.06.18.2013|Nubalema Dua
53.06.19.2001|Kalike
53.06.19.2002|Kalike Aimatan
53.06.19.2003|Sulengwaseng
53.06.19.2004|Kenere
53.06.19.2005|Lemanu
53.06.19.2006|Lewograran
53.06.19.2007|Bubuatagamu
53.07.01.2001|Masabewa
53.07.01.2003|Wolowiro
53.07.01.2004|Mbengu
53.07.01.2005|Paga
53.07.01.2008|Lenandareta
53.07.01.2012|Mauloo
53.07.01.2013|Wolorega
53.07.01.2015|Wolowona
53.07.01.2017|Begu
53.07.01.2018|Kotandelu
53.07.01.2019|Lowolabo
53.07.01.2020|Aebubu
53.07.01.2021|Regapu’u
53.07.01.2022|Rejo
53.07.02.2001|Bhera
53.07.02.2002|Dobo
53.07.02.2003|Gera
53.07.02.2004|Liakutu
53.07.02.2005|Parabubu
53.07.02.2006|Wolodhesa
53.07.02.2007|Korobhera
53.07.02.2008|Napugera
53.07.02.2009|Kowi
53.07.02.2010|Dobo Nuapuu
53.07.02.2011|Ratekalo
53.07.02.2012|Ndaimbere
53.07.03.2001|Lela
53.07.03.2002|Watutedang
53.07.03.2003|Korowuwu
53.07.03.2004|Kolidetung
53.07.03.2005|Sikka
53.07.03.2006|Iligai
53.07.03.2007|Hepang
53.07.03.2008|Baopaat
53.07.03.2009|Du
53.07.04.2001|Nita
53.07.04.2002|Takaplager
53.07.04.2003|Tebuk
53.07.04.2004|Ladogahar
53.07.04.2005|Nitakloang
53.07.04.2006|Wuliwutik
53.07.04.2007|Lusitada
53.07.04.2008|Bloro
53.07.04.2009|Riit
53.07.04.2010|Tilang
53.07.04.2011|Nirangkliung
53.07.04.2017|Mahebora
53.07.04.2018|Nangablo
53.07.04.2019|Kara Kabu
53.07.04.2020|Tada Lado
53.07.05.1006|Madawat
53.07.05.1007|Nangalimang
53.07.05.1008|Kabor
53.07.05.1009|Kota Uneng
53.07.05.2014|Pemana
53.07.05.2015|Samparong
53.07.05.2016|Gunung Sari
53.07.06.2001|Maluriwu
53.07.06.2002|Reruwairere
53.07.06.2003|Tuanggeo
53.07.06.2004|Ladolaka
53.07.06.2005|Nitunglea
53.07.06.2006|Rokirole
53.07.06.2007|Kesokoja
53.07.06.2008|Lidi
53.07.07.2002|Nelle Urung
53.07.07.2003|Nelle Wutung
53.07.07.2004|Nelle Barat
53.07.07.2005|Nella Lorang
53.07.07.2006|Manubura
53.07.08.2001|Darat Gunung
53.07.08.2002|Ojang
53.07.08.2003|Hikong
53.07.08.2006|Nebe
53.07.08.2007|Wailamung
53.07.08.2008|Lewomada
53.07.08.2010|Nangahale
53.07.08.2011|Darat Pantai
53.07.08.2013|Talibura
53.07.08.2014|Kringa
53.07.08.2015|Bangkoor
53.07.08.2017|Timutawa
53.07.08.2019|Udek Du’en
53.07.08.2020|Watu Omok
53.07.08.2021|Waipaar
53.07.08.2022|Baokremot
53.07.08.2023|Henga
53.07.08.2024|Likonggete
53.07.08.2025|Watubaing
53.07.08.2026|Mamai
53.07.09.2001|Runut
53.07.09.2002|Egon
53.07.09.2003|Pogon
53.07.09.2004|Aibura
53.07.09.2005|Wairbleler
53.07.09.2006|Hoder
53.07.09.2007|Wairterang
53.07.09.2008|Nangatobong
53.07.09.2009|Watudiran
53.07.09.2010|Mahe Kelan
53.07.09.2011|Egon Buluk
53.07.10.2005|Seusina
53.07.10.2007|Kopong
53.07.10.2008|Namangkewa
53.07.10.2009|Iantena
53.07.10.2016|Umagera
53.07.10.2020|Geliting
53.07.10.2021|Waiara
53.07.10.2024|Wairkoja
53.07.10.2026|Watukobu
53.07.11.2001|Hokor
53.07.11.2002|Wolonwalu
53.07.11.2003|Wolokoli
53.07.11.2004|Bola
53.07.11.2005|Umauta
53.07.11.2006|Ipir
53.07.11.2018|Bura Bekor
53.07.11.2019|Watukrus
53.07.12.2001|Magepanda
53.07.12.2002|Reroroja
53.07.12.2003|Done
53.07.12.2004|Kolisia
53.07.12.2005|Kolisia B
53.07.12.2006|Woda Mude
53.07.12.2007|Legu Woda
53.07.12.2008|Waturia
53.07.13.2001|Natarmage
53.07.13.2002|Tanarawa
53.07.13.2003|Pruda
53.07.13.2004|Werang
53.07.13.2005|Tua Bao
53.07.13.2006|Ilinmedo
53.07.13.2007|Watu Moning
53.07.14.1001|Hewuli
53.07.14.1002|Wailiti
53.07.14.1003|Wolomarang
53.07.14.1004|Wuring
53.07.15.1001|Beru
53.07.15.1002|Kota Baru
53.07.15.1003|Nangameting
53.07.15.1004|Waioti
53.07.15.1005|Wairotang
53.07.15.2006|Koja Doi
53.07.15.2007|Kojagete
53.07.15.2008|Lepo Lima
53.07.15.2009|Perumaan
53.07.15.2010|Watugong
53.07.15.2011|Gong Bekor
53.07.16.2001|Koting A
53.07.16.2002|Koting B
53.07.16.2003|Koting C
53.07.16.2004|Koting D
53.07.16.2005|Paubekor
53.07.16.2006|Ribang
53.07.16.2007|Watu Repa
53.07.17.2001|Bu Selatan
53.07.17.2002|Bu Utara
53.07.17.2003|Bu Watuweti
53.07.17.2004|Loke
53.07.17.2005|Renggarasi
53.07.17.2006|Detubinga
53.07.17.2007|Tuwa
53.07.17.2008|Poma
53.07.17.2009|Bu Barat
53.07.17.2010|Bu Nuapu’u
53.07.18.2001|Rubit
53.07.18.2002|Wolomapa
53.07.18.2003|Baomekot
53.07.18.2004|Kajowair
53.07.18.2005|Hewokloang
53.07.18.2006|Heopuat
53.07.18.2007|Munerana
53.07.19.2001|Teka Iku
53.07.19.2002|Mekendetung
53.07.19.2003|Kokowahor
53.07.19.2004|Balatatatin
53.07.19.2005|Watuliwung
53.07.19.2006|Tana Duen
53.07.19.2007|Watumilok
53.07.19.2008|Habi
53.07.19.2009|Langir
53.07.20.2001|Waihawa
53.07.20.2002|Nenbura
53.07.20.2003|Wogalirit
53.07.20.2004|Watumerak
53.07.20.2005|Wolonterang
53.07.20.2006|Kloangpopot
53.07.20.2007|Wolomotong
53.07.20.2008|Mahe Tanah
53.07.20.2009|Pelibaler
53.07.21.2001|Hale
53.07.21.2002|Hebing
53.07.21.2003|Natakoli
53.07.21.2004|Egon Gahar
53.08.01.1001|Ndorurea
53.08.01.2002|Ondorea
53.08.01.2003|Watumite
53.08.01.2004|Tendarea
53.08.01.2005|Kerirea
53.08.01.2006|Tendambepa
53.08.01.2007|Zozozea
53.08.01.2008|Rapowawo
53.08.01.2009|Nggorea
53.08.01.2010|Raporendu
53.08.01.2011|Bheramari
53.08.01.2012|Tiwerea
53.08.01.2013|Sanggarhorho
53.08.01.2014|Ndeturea
53.08.01.2015|Ndorurea I
53.08.01.2016|Penggajawa
53.08.01.2017|Jegharangga
53.08.01.2018|Ondorea Barat
53.08.01.2019|Romarea
53.08.01.2020|Timbaria
53.08.01.2021|Mbobhenga
53.08.01.2022|Malawaru
53.08.01.2023|Anaraja
53.08.01.2024|Kekandere
53.08.01.2025|Tanazozo
53.08.01.2026|Tenda Ondo
53.08.01.2027|Jemburea
53.08.01.2028|Embuzozo
53.08.01.2029|Uzuzozo
53.08.02.2001|Aejeti
53.08.02.2002|Puutara
53.08.02.2003|Paderape
53.08.02.2004|Ndoriwoi
53.08.02.2005|Rorurangga
53.08.02.2006|Rendoraterua
53.08.02.2007|Redorori
53.08.02.2008|Kazo Kapo
53.08.02.2009|Renga Menge
53.08.03.2001|Raburia
53.08.03.2002|Riaraja
53.08.03.2003|Mbotutenda
53.08.03.2004|Wologai
53.08.03.2007|Ndetundora I
53.08.03.2008|Ndetundora II
53.08.03.2009|Tomberabu I
53.08.03.2010|Tomberabu II
53.08.03.2011|Nakuramba
53.08.03.2012|Wolokaro
53.08.03.2013|Ja Moke Asa
53.08.03.2014|Emburia
53.08.03.2016|Randotonda
53.08.03.2017|Rukuramba
53.08.03.2018|Tinabani
53.08.03.2019|Ndetundora III
53.08.03.2020|Uzuramba
53.08.03.2021|Tonggopapa
53.08.03.2022|Wologai Dua
53.08.03.2023|Worhopapa
53.08.03.2024|Wawonato
53.08.03.2025|Jejaraja
53.08.03.2026|Tendambonggi
53.08.03.2027|Randorama
53.08.03.2028|Ranoramba
53.08.03.2029|Peozakaramba
53.08.03.2030|Embutheru
53.08.03.2031|Nuaja
53.08.03.2032|Wajakea Jaya
53.08.03.2033|Nemboramba
53.08.03.2034|Embu Ngena
53.08.03.2035|Uzuramba Barat
53.08.04.1003|Mbongawani
53.08.04.1004|Rukun Lima
53.08.04.1006|Paupanda
53.08.04.1008|Tetandara
53.08.04.1014|Tanjung
53.08.05.1001|Onelako
53.08.05.1002|Lokoboko
53.08.05.2003|Wolotopo
53.08.05.2004|Wolotolo Timur
53.08.05.2006|Puutuga
53.08.05.2007|Ngalupolo
53.08.05.2012|Ngaluroga
53.08.05.2013|Nila
53.08.05.2014|Kekasewa
53.08.05.2015|Manulando
53.08.05.2016|Nanganesa
53.08.05.2017|Wolokota
53.08.05.2018|Kelikiku
53.08.05.2020|Reka
53.08.06.1001|Detusoko
53.08.06.2002|Detusoko Barat
53.08.06.2003|Wolotolo
53.08.06.2004|Wolotolo Tengah
53.08.06.2005|Roa
53.08.06.2006|Saga
53.08.06.2007|Niowula
53.08.06.2008|Wolofeo
53.08.06.2009|Nuaone
53.08.06.2010|Wologai
53.08.06.2011|Wologai Tengah
53.08.06.2013|Wolomage
53.08.06.2015|Randoria
53.08.06.2016|Wolomasi
53.08.06.2017|Rateroru
53.08.06.2018|Dile
53.08.06.2019|Ndito
53.08.06.2020|Sipijena
53.08.06.2021|Golulada
53.08.06.2022|Ranga
53.08.06.2024|Turunalu
53.08.07.2001|Welamosa
53.08.07.2002|Nuangenda
53.08.07.2003|Mautenda
53.08.07.2004|Mautenda Barat
53.08.07.2005|Wewaria
53.08.07.2006|Tanali
53.08.07.2007|Detubela
53.08.07.2008|Fataatu
53.08.07.2009|Fataatu Timur
53.08.07.2010|Mukusaki
53.08.07.2011|Ekoae
53.08.07.2012|Aemuri
53.08.07.2013|Ratewati
53.08.07.2014|Mbotulaka
53.08.07.2015|Numba
53.08.07.2017|Kelitembu
53.08.07.2018|Aelipo
53.08.07.2019|Ratewati Selatan
53.08.07.2020|Waka
53.08.07.2021|Wolooja
53.08.07.2022|Ekolea
53.08.07.2023|Ae Ndoko
53.08.08.1001|Bokasape
53.08.08.2002|Bokasape Timur
53.08.08.2010|Mbuliloo
53.08.08.2011|Rindiwawo
53.08.08.2012|Jopu
53.08.08.2013|Wolokoli
53.08.08.2014|Mbuliwaralau
53.08.08.2015|Mbuliwaralau Utara
53.08.08.2016|Lisedetu
53.08.08.2017|Nualise
53.08.08.2018|Wolosoko
53.08.08.2019|Liselowobora
53.08.08.2020|Likanaka
53.08.08.2021|Nakambara
53.08.08.2022|Niramesi
53.08.08.2023|Tana Lo'o
53.08.08.2024|Lise Pu'u
53.08.09.1001|Wolojita
53.08.09.2002|Tenda
53.08.09.2003|Wiwipemo
53.08.09.2004|Pora
53.08.09.2005|Nuamulu
53.08.09.2006|Nggela
53.08.10.2001|Maurole
53.08.10.2003|Aewora
53.08.10.2005|Mausambi
53.08.10.2006|Ranakolo
53.08.10.2007|Watukamba
53.08.10.2008|Ranakolo Selatan
53.08.10.2009|Keliwumbu
53.08.10.2018|Detuwulu
53.08.10.2019|Otogedu
53.08.10.2020|Woloau
53.08.10.2021|Ngalukoja
53.08.10.2022|Niranusa
53.08.10.2023|Uludala
53.08.11.2001|Kebirangga
53.08.11.2002|Kebirangga Selatan
53.08.11.2003|Kamubheka
53.08.11.2004|Magekapa
53.08.11.2005|Boafeo
53.08.11.2006|Nabe
53.08.11.2007|Kobaleba
53.08.11.2008|Mundinggasa
53.08.11.2009|Kolikapa
53.08.11.2010|Kebirangga Tengah
53.08.11.2011|Natanangge
53.08.12.1001|Watuneso
53.08.12.2002|Hobatua
53.08.12.2003|Wolosambi
53.08.12.2004|Woloara
53.08.12.2005|Detupera
53.08.12.2006|Wololela A
53.08.12.2007|Liabeke
53.08.12.2013|Fatamari
53.08.12.2014|Ranggatalo
53.08.12.2015|Nua Lima
53.08.12.2016|Tanaroga
53.08.12.2017|Bu Tanalagu
53.08.12.2018|Mbewawora
53.08.13.2001|Kotabaru
53.08.13.2002|Tou
53.08.13.2003|Tou Timur
53.08.13.2004|Loboniki
53.08.13.2005|Ndondo
53.08.13.2006|Niopanda
53.08.13.2007|Hangalande
53.08.13.2012|Tou Barat
53.08.13.2013|Liselande
53.08.13.2014|Rangalaka
53.08.13.2015|Pise
53.08.13.2016|Neotonda
53.08.13.2017|Nuanaga
53.08.14.2002|Nduaria
53.08.14.2003|Nuamuri
53.08.14.2004|Nuamuri Barat
53.08.14.2005|Koanara
53.08.14.2006|Woloara
53.08.14.2007|Pemo
53.08.14.2009|Detuena
53.08.14.2010|Wolokelo
53.08.14.2011|Waturaka
53.08.15.2001|Nggesa
53.08.15.2002|Detukeli
53.08.15.2003|Kebesani
53.08.15.2004|Wolomuku
53.08.15.2005|Watunggere
53.08.15.2006|Nida
53.08.15.2007|Maurole Selatan
53.08.15.2008|Detumbewa
53.08.15.2009|Kanganara
53.08.15.2011|Unggu
53.08.15.2012|Nggesabiri
53.08.15.2013|Watunggere Marilonga
53.08.15.2014|Jeo Du'a
53.08.16.2001|Kurulimbu
53.08.16.2002|Sokoria
53.08.16.2003|Demulaka
53.08.16.2004|Roga
53.08.16.2005|Kurulimbu Selatan
53.08.16.2006|Ngguwa
53.08.16.2007|Sokoria Selatan
53.08.17.2001|Maubasa
53.08.17.2002|Maubasa Timur
53.08.17.2003|Wonda
53.08.17.2004|Serandori
53.08.17.2005|Kelisamba
53.08.17.2006|Mole
53.08.17.2007|Lungaria
53.08.17.2008|Aebara
53.08.17.2009|Ratemangga
53.08.17.2010|Maubasa Barat
53.08.18.1001|Kota Raja
53.08.18.1002|Kota Ratu
53.08.18.1003|Roworena
53.08.18.1007|Roworena Barat
53.08.18.2004|Gheoghoma
53.08.18.2005|Borokanda
53.08.18.2006|Watusipi
53.08.18.2008|Mbomba
53.08.18.2009|Embundoa
53.08.18.2010|Raterua
53.08.19.1001|Potulando
53.08.19.1002|Onekore
53.08.19.1003|Kelimutu
53.08.19.1004|Paupire
53.08.20.1001|Mautapaga
53.08.20.1002|Rewarangga
53.08.20.1006|Rewarangga Selatan
53.08.20.2003|Kedebodu
53.08.20.2004|Ndungga
53.08.20.2005|Tiwutewa
53.08.21.2001|Nggumbelaka
53.08.21.2002|Mukureku
53.08.21.2003|Wologai Timur
53.08.21.2004|Kuru
53.08.21.2005|Ndenggarongge
53.08.21.2006|Ndikosapu
53.08.21.2007|Taniwoda
53.08.21.2008|Tanalangi
53.08.21.2009|Detuara
53.08.21.2010|Tiwusora
53.08.21.2011|Lisekuru
53.08.21.2012|Rutujeja
53.08.21.2013|Mukureku Sa'ate
53.08.21.2014|Kurusare
53.09.01.1002|Aimere
53.09.01.1003|Foa
53.09.01.2001|Keligejo
53.09.01.2014|Aimere Timur
53.09.01.2018|Heawea
53.09.01.2019|Legelapu
53.09.01.2020|Lekogoko
53.09.01.2021|Binawali
53.09.01.2022|Kila
53.09.01.2023|Waesae
53.09.01.2024|Mawwo Kisa
53.09.02.1008|Todabelu
53.09.02.1017|Mataloko
53.09.02.2002|Were I
53.09.02.2009|Sangadeto
53.09.02.2010|Ratogesa
53.09.02.2011|Radabata
53.09.02.2018|Dadawea
53.09.02.2019|Sarasedu
53.09.02.2020|Malanuza
53.09.02.2025|Were
53.09.02.2026|Were IV
53.09.02.2031|Malanuza I
53.09.02.2032|Sarasedu I
53.09.02.2036|Ulu Belu
53.09.02.2037|Eko Roka
53.09.02.2038|Wae Ia
53.09.02.2039|Dolupore
53.09.02.2040|Tiwo Toda
53.09.02.2041|Kelimolo
53.09.02.2042|Wogo
53.09.02.2043|Radabata I
53.09.02.2044|Bodosare
53.09.06.1013|Bajawa
53.09.06.1014|Tanalodu
53.09.06.1015|Kisanata
53.09.06.1016|Jawameze
53.09.06.1017|Trikora
53.09.06.1018|Ngedukelu
53.09.06.1019|Lebijaga
53.09.06.1020|Faobata
53.09.06.1021|Susu
53.09.06.2001|Beja
53.09.06.2002|Bomari
53.09.06.2003|Wawowae
53.09.06.2004|Ubedolumolo
53.09.06.2005|Naru
53.09.06.2009|Beiwali
53.09.06.2022|Borani
53.09.06.2023|Langagedha
53.09.06.2024|Pape
53.09.06.2025|Bowali
53.09.06.2026|Ngoranale
53.09.06.2027|Ubedolumolo I
53.09.06.2028|Bela
53.09.06.2029|Ngadhamana
53.09.06.2030|Bolonga
53.09.06.2031|Boradho
53.09.06.2032|Mukuvoka
53.09.06.2033|Ubedolumolo II
53.09.06.2034|Langagedha I
53.09.07.2001|Waepana
53.09.07.2004|Masumeli
53.09.07.2005|Piga
53.09.07.2006|Loa
53.09.07.2007|Tarawaja
53.09.07.2008|Seso
53.09.07.2010|Mengeruda
53.09.07.2011|Masu Kedhi
53.09.07.2012|Libunio
53.09.07.2013|Meli Waru
53.09.07.2014|Ngabheo
53.09.07.2016|Bogoboa
53.09.07.2017|Piga I
53.09.07.2018|Tarawali
53.09.07.2019|Waepana I
53.09.07.2020|Lokaweka
53.09.09.1010|Benteng Tengah
53.09.09.1011|Nangamese
53.09.09.2005|Taenterong
53.09.09.2006|Wangka
53.09.09.2008|Lengkosambi
53.09.09.2009|Tadho
53.09.09.2012|Sambinasi
53.09.09.2013|Latung
53.09.09.2014|Rawangkalo
53.09.09.2016|Wangka Selatan
53.09.09.2017|Lengkosambi Timur
53.09.09.2018|Lengkosambi Barat
53.09.09.2019|Sambinasi Barat
53.09.09.2020|Lengkosambi Utara
53.09.09.2021|Taen Terong I
53.09.09.2022|Taen Terong II
53.09.09.2023|Kota Raja
53.09.09.2024|Ite Jaya
53.09.09.2025|Wangka Barat
53.09.09.2026|Lengkosambi Tengah
53.09.09.2027|Tadho Timur
53.09.09.2028|Tadho Barat
53.09.09.2029|Tadho Tengah
53.09.09.2030|Sambinasi Tengah
53.09.09.2031|Latung Barat
53.09.09.2032|Rawangkalo I
53.09.09.2033|Rawangkalo II
53.09.09.2034|Wakamanga
53.09.09.2035|Lengkosambi Barat Daya
53.09.12.2001|Watumanu
53.09.12.2002|Tiworiwu
53.09.12.2003|Dariwali
53.09.12.2004|Naruwolo
53.09.12.2005|Nenowea
53.09.12.2007|Naruwolo I
53.09.12.2008|Naruwolo II
53.09.12.2009|Dariwali I
53.09.12.2010|Nio Lewa
53.09.12.2011|Tiworiwu I
53.09.12.2012|Tiworiwu II
53.09.12.2015|Batajawa
53.09.12.2016|Wongawea
53.09.12.2017|Bowaru
53.09.14.2001|Benteng Tawa
53.09.14.2002|Lanamai
53.09.14.2003|Wolomeze
53.09.14.2004|Ria
53.09.14.2005|Ngara
53.09.14.2006|Ria I
53.09.14.2007|Wolomeze I
53.09.14.2008|Benteng Tawa I
53.09.14.2009|Lanamai I
53.09.14.2010|Wolomeze II
53.09.14.2011|Benteng Tawa II
53.09.14.2012|Benteng Tawa III
53.09.14.2013|Lanamai II
53.09.14.2014|Kembang
53.09.14.2015|Wate
53.09.14.2016|Ngara I
53.09.14.2017|Benteng Tawa IV
53.09.14.2018|Benteng Tawa V
53.09.14.2019|Nili Waru Sae
53.09.15.2001|Uluwae
53.09.15.2002|Inelika
53.09.15.2003|Inegena
53.09.15.2004|Wololika
53.09.15.2005|Watukapu
53.09.15.2006|Waewea
53.09.15.2007|Nabelena
53.09.15.2008|Genamere
53.09.15.2009|Uluwae I
53.09.15.2010|Uluwae II
53.09.15.2011|Tura Muri
53.09.15.2012|Bowado
53.09.16.2001|Nginamanu
53.09.16.2002|Denatana
53.09.16.2003|Mainai
53.09.16.2004|Turaloa
53.09.16.2005|Nginamanu Selatan
53.09.16.2006|Nginamanu Barat
53.09.16.2007|Wue
53.09.16.2008|Denatana Timur
53.09.16.2009|Larilaki
53.09.16.2010|Mulumese
53.09.16.2011|Turaloa Timur
53.09.18.2001|Bawarani
53.09.18.2002|Wogowela
53.09.18.2003|Watu Sipi
53.09.18.2004|Boba
53.09.18.2005|Boba I
53.09.18.2006|Were III
53.09.18.2007|Kezewea
53.09.18.2008|Nirmala
53.09.18.2009|Sadha
53.09.18.2010|Takatunga
53.09.18.2011|Radamasa
53.09.18.2012|Were II
53.09.18.2013|Bobawa
53.09.18.2014|Were V
53.09.18.2015|Were VI
53.09.18.2016|Kezewea I
53.09.18.2017|Sadha I
53.09.18.2018|Takatunga I
53.09.19.1001|Mangulewa
53.09.19.2002|Turekisa
53.09.19.2003|Rakalaba
53.09.19.2004|Sobo
53.09.19.2005|Sobo I
53.09.19.2006|Rakateda I
53.09.19.2007|Rakateda II
53.09.19.2008|Watunay
53.09.19.2009|Dizi Gedha
53.09.19.2010|Bea Pawe
53.09.19.2011|Bopoma
53.09.19.2012|Rakalaba I
53.09.19.2013|Sobo II
53.09.20.2001|Paupaga
53.09.20.2002|Sebowuli
53.09.20.2003|Inerie
53.09.20.2004|Warupele I
53.09.20.2005|Warupele II
53.09.20.2006|Kelitei
53.09.20.2007|Waebela
53.09.20.2008|Tiwurana
53.09.20.2009|Legeriwu
53.09.20.2010|Manubhara
53.09.20.2011|Ruto
53.09.20.2012|Enabhara
53.09.20.2013|Nagebaru
53.10.01.2001|Satar Ngkeling
53.10.01.2002|Lalong
53.10.01.2003|Poco
53.10.01.2004|Wae Mulu
53.10.01.2005|Ndehes
53.10.01.2006|Golo Cador
53.10.01.2007|Longko
53.10.01.2008|Ranggi
53.10.01.2009|Compang Ndehes
53.10.01.2010|Bangka Jong
53.10.01.2012|Bangka Kenda
53.10.01.2013|Golo Mendo
53.10.01.2014|Golo Wuas
53.10.01.2015|Wae Rii
53.10.01.2016|Ranaka
53.10.01.2017|Golo Watu
53.10.01.2018|Benteng Poco
53.10.03.1005|Wae Belang
53.10.03.2002|Cumbi
53.10.03.2003|Kakor
53.10.03.2004|Pong Murung
53.10.03.2006|Bulan
53.10.03.2010|Pong Lao
53.10.03.2011|Beo Rahong
53.10.03.2019|Golo Worok
53.10.03.2020|Meler
53.10.03.2021|Benteng Kuwu
53.10.03.2022|Belang Turi
53.10.03.2023|Pong Leko
53.10.03.2024|Rai
53.10.03.2025|Poco Likang
53.10.03.2029|Bangka Lao
53.10.03.2030|Compang Dalo
53.10.03.2031|Bea Kakor
53.10.03.2032|Compang Namut
53.10.03.2033|Pong Lale
53.10.05.2003|Jaong
53.10.05.2004|Pongkor
53.10.05.2005|Wae Ajang
53.10.05.2018|Papang
53.10.05.2019|Wewo
53.10.05.2020|Lungar
53.10.05.2021|Mocok
53.10.05.2022|Koak
53.10.05.2023|Langgo
53.10.05.2024|Legu
53.10.05.2025|Paka
53.10.05.2028|Tal
53.10.05.2031|Golo Lambo
53.10.05.2032|Ngkaer
53.10.05.2033|Umung
53.10.05.2034|Tado
53.10.05.2035|Gara
53.10.05.2036|Golo Muntas
53.10.05.2038|Ponggeok
53.10.05.2039|Iteng
53.10.05.2040|Satar Loung
53.10.05.2041|Lolang
53.10.05.2042|Ulu Belang
53.10.06.1026|Pagal
53.10.06.2001|Nenu
53.10.06.2002|Rado
53.10.06.2006|Wudi
53.10.06.2007|Welu
53.10.06.2008|Golo
53.10.06.2009|Barang
53.10.06.2010|Perak
53.10.06.2011|Bea Mese
53.10.06.2012|Langkas
53.10.06.2013|Ladur
53.10.06.2014|Kentol
53.10.06.2015|Riung
53.10.06.2022|Pinggang
53.10.06.2024|Lando
53.10.06.2025|Gapong
53.10.06.2027|Golo Ncuang
53.10.11.1017|Reo
53.10.11.1018|Mata Air
53.10.11.1019|Baru
53.10.11.1020|Wangkung
53.10.11.2001|Robek
53.10.11.2009|Ruis
53.10.11.2010|Bajak
53.10.11.2011|Watu Baur
53.10.11.2012|Salama
53.10.11.2016|Watu Tango
53.10.12.1001|Golo Dukal
53.10.12.1002|Wali
53.10.12.1003|Karot
53.10.12.1004|Pitak
53.10.12.1005|Lawir
53.10.12.1006|Pau
53.10.12.1007|Waso
53.10.12.1008|Watu
53.10.12.1009|Mbaumuku
53.10.12.1010|Tenda
53.10.12.1011|Carep
53.10.12.1012|Bangka Nekang
53.10.12.1013|Satar Tacik
53.10.12.1014|Poco Mal
53.10.12.1015|Compang Carep
53.10.12.1016|Laci Carep
53.10.12.1017|Tadong
53.10.12.1018|Rowang
53.10.12.1019|Bangka Leda
53.10.12.1020|Compang Tuke
53.10.13.2002|Hilihintir
53.10.13.2005|Bea Kondo
53.10.13.2012|Golo Ropong
53.10.13.2013|Terong
53.10.13.2014|Ceka Luju
53.10.13.2015|Satar Luju
53.10.13.2016|Satar Lenda
53.10.13.2017|Satar Ruwuk
53.10.13.2018|Nuca Molas
53.10.13.2019|Borik
53.10.13.2021|Cambir Leca
53.10.13.2022|Wongka
53.10.14.2001|Buar
53.10.14.2002|Benteng Tubi
53.10.14.2003|Compang Dari
53.10.14.2004|Dimpong
53.10.14.2005|Bangka Ajang
53.10.14.2006|Liang Bua
53.10.14.2007|Tengku Lese
53.10.14.2008|Golo Langkok
53.10.14.2009|Pong Lengor
53.10.14.2010|Manong
53.10.14.2011|Bangka Ruang
53.10.14.2012|Wae Mantang
53.10.15.2001|Bangka Lelak
53.10.15.2002|Gelong
53.10.15.2003|Urang
53.10.15.2004|Ketang
53.10.15.2005|Pong Umpu
53.10.15.2006|Bangka Dese
53.10.15.2007|Nati
53.10.15.2008|Ndiwar
53.10.15.2009|Bangka Tonggur
53.10.15.2010|Lentang
53.10.16.2001|Kajong
53.10.16.2002|Lante
53.10.16.2003|Toe
53.10.16.2004|Sambi
53.10.16.2005|Nggalak
53.10.16.2006|Loce
53.10.16.2007|Lemarang
53.10.16.2008|Torong Koe
53.10.16.2009|Para Lando
53.10.16.2010|Rura
53.10.17.2001|Bere
53.10.17.2002|Wae Codi
53.10.17.2003|Golo Woi
53.10.17.2004|Golo Lanak
53.10.17.2005|Latung
53.10.17.2006|Wae Renca
53.10.17.2007|Timbu
53.10.17.2008|Bangka Ara
53.10.17.2009|Compang Cibal
53.10.17.2010|Lenda
53.10.18.2001|Renda
53.10.18.2002|Todo
53.10.18.2003|Gulung
53.10.18.2004|Popo
53.10.18.2005|Lia
53.10.18.2006|Kole
53.10.18.2007|Ling
53.10.18.2008|Nao
53.10.18.2009|Cireng
53.10.18.2010|Ruang
53.10.18.2011|Mata Wae
53.11.01.1001|Kambajawa
53.11.01.1002|Hambala
53.11.01.1003|Matawai
53.11.01.1004|Kamalaputi
53.11.01.2012|Lukukamaru
53.11.01.2013|Mbatakapidu
53.11.01.2014|Pambotandjara
53.11.02.2003|Rambangaru
53.11.02.2006|Praibakul
53.11.02.2007|Wunga
53.11.02.2008|Kadahang
53.11.02.2009|Napu
53.11.02.2010|Mbatapuhu
53.11.02.2012|Kalamba
53.11.03.1001|Lewa Paku
53.11.03.2002|Kambuhapang
53.11.03.2003|Kambata Wundut
53.11.03.2004|Kondamara
53.11.03.2005|Matawai Pawali
53.11.03.2006|Rakawatu
53.11.03.2007|Tana Rara
53.11.03.2013|Bidi Hunga
53.11.04.2001|Makamenggit
53.11.04.2002|Tandula Jangga
53.11.04.2003|Praipaha
53.11.04.2004|Praihambuli
53.11.04.2005|Pulu Panjang
53.11.04.2010|Praikarang
53.11.04.2011|Tanatuku
53.11.04.2012|Ngadulanggi
53.11.05.2001|Billa
53.11.05.2002|Karita
53.11.05.2003|Kuki Talu
53.11.05.2004|Tapil
53.11.05.2005|Tarimbang
53.11.05.2006|Waikanabu
53.11.05.2007|Pindu Hurani
53.11.05.2008|Praing Kareha
53.11.05.2009|Wudi Pandak
53.11.05.2011|Bangga Watu
53.11.06.2001|Ramuk
53.11.06.2002|Wangga Mbewa
53.11.06.2003|Lailunggi
53.11.06.2004|Tawui
53.11.06.2005|Wahang
53.11.06.2006|Mahaniwa
53.11.07.1001|Kawangu
53.11.07.1002|Watumbaka
53.11.07.2003|Kambatatana
53.11.07.2007|Palaka Hembi
53.11.07.2008|Kadumbul
53.11.07.2009|Maubokul
53.11.07.2012|Laindeha
53.11.08.1001|Lumbukore
53.11.08.2002|Umalulu
53.11.08.2003|Patawang
53.11.08.2004|Wanga
53.11.08.2005|Matawai Atu
53.11.08.2006|Mutunggeding
53.11.08.2007|Lairuru
53.11.08.2008|Watuhadang
53.11.08.2009|Watupuda
53.11.08.2010|Ngaru Kanoru
53.11.09.2001|Rindi
53.11.09.2002|Tanaraing
53.11.09.2003|Haikatapu
53.11.09.2004|Kabaru
53.11.09.2005|Hanggaroru
53.11.09.2006|Lailanjang
53.11.09.2007|Tamburi
53.11.09.2008|Kayuri
53.11.10.2001|Kaliuda
53.11.10.2002|Kuruwaki
53.11.10.2003|Tana Manang
53.11.10.2004|Mburukulu
53.11.10.2005|Pamburu
53.11.10.2006|Lambakara
53.11.10.2007|Tamma
53.11.10.2009|Palanggai
53.11.11.2001|Wulla
53.11.11.2002|Hadakamali
53.11.11.2003|Lumbu Manggit
53.11.11.2004|Latena
53.11.11.2005|Lainjanji
53.11.11.2006|Laipandak
53.11.11.2008|Paranda
53.11.12.2001|Kananggar
53.11.12.2002|Mehang Mata
53.11.12.2003|Karera Jangga
53.11.12.2004|Praimbana
53.11.12.2005|Pabera Manera
53.11.12.2010|Winumuru
53.11.12.2011|Laitaku
53.11.13.2001|Nggongi
53.11.13.2002|Praimadita
53.11.13.2003|Praisalura
53.11.13.2004|Tandula Jangga
53.11.13.2005|Nangga
53.11.13.2006|Janggamangu
53.11.13.2011|Ananjaki
53.11.14.2001|Kamanggih
53.11.14.2002|Kambatabundung
53.11.14.2003|Meurumba
53.11.14.2004|Laimbonga
53.11.14.2005|Kota Kawau
53.11.14.2006|Matawai Katingga
53.11.14.2007|Kataka
53.11.14.2008|Matawai Maringgu
53.11.14.2009|Mauramba
53.11.15.2001|Prai Bakul
53.11.15.2002|Katikutana
53.11.15.2003|Karipi
53.11.15.2004|Wangga Meti
53.11.15.2005|Katiku Wai
53.11.15.2006|Katiku Luku
53.11.16.1001|Wangga
53.11.16.1002|Prailiu
53.11.16.1003|Kambaniru
53.11.16.1004|Mauliru
53.11.16.1005|Mau Hau
53.11.16.1006|Malumbi
53.11.16.1007|Lambanapu
53.11.16.2008|Kiritana
53.11.17.2001|Lukuwingir
53.11.17.2002|Waimbidi
53.11.17.2003|Laimeta
53.11.17.2004|Mahubokul
53.11.17.2005|Marada Mundi
53.11.17.2006|Maidang
53.11.18.2001|Watumbelar
53.11.18.2002|Bidipraing
53.11.18.2003|Umamanu
53.11.18.2004|Mondulambi
53.11.18.2005|Kangeli
53.11.18.2006|Laihau
53.11.19.2001|Kompa Pari
53.11.19.2002|Matawai Amahu
53.11.19.2003|Mandahu
53.11.19.2004|Lailara
53.11.19.2005|Praibakul
53.11.20.1001|Temu
53.11.20.2002|Kuta
53.11.20.2003|Hambapraing
53.11.20.2004|Mondu
53.11.20.2005|Ndapayami
53.11.21.2001|Praiwitu
53.11.21.2002|Kakaha
53.11.21.2003|Hambawutang
53.11.21.2004|Kabanda
53.11.21.2005|Prauraming
53.11.22.2001|Lahiru
53.11.22.2002|Patamawai
53.11.22.2003|Wairara
53.11.22.2004|Praikalala
53.11.22.2005|Lulundilu
53.11.22.2006|Haray
53.12.04.2001|Loko Ry
53.12.04.2002|Lolo Wano
53.12.04.2003|Malata
53.12.04.2004|Ngadu Pada
53.12.04.2005|Lingu Lango
53.12.04.2006|Karaka Nduku
53.12.04.2007|Wano Kasa
53.12.04.2008|Wee Patola
53.12.04.2009|Zala Kadu
53.12.04.2010|Bondo Tera
53.12.04.2011|Manu Kuku
53.12.04.2012|Lolo Tana
53.12.04.2013|Kareka Nduku Utara
53.12.04.2014|Kareka Nduku Selatan
53.12.04.2015|Manu Mada
53.12.04.2016|Elu Loda
53.12.04.2017|Kalebu Ana Kaka
53.12.04.2018|Tarona
53.12.10.1007|Wee Karou
53.12.10.1008|Sobawawi
53.12.10.1011|Loda Pare
53.12.10.1012|Wee Dabo
53.12.10.1013|Dira Tana
53.12.10.2001|Bera Dolu
53.12.10.2002|Doka Kaka
53.12.10.2003|Tana Rara
53.12.10.2004|Bali Ledo
53.12.10.2005|Dedekadu
53.12.10.2006|Ubu Pede
53.12.10.2009|Tema Tana
53.12.10.2010|Ubu Raya
53.12.10.2014|Manola
53.12.11.2001|Katiku Loku
53.12.11.2002|Hupu Mada
53.12.11.2003|Praibakul
53.12.11.2004|Hoba Wawi
53.12.11.2005|Waihura
53.12.11.2006|Pahola
53.12.11.2007|Bali Loku
53.12.11.2008|Tara Manu
53.12.11.2009|Mamodu
53.12.11.2010|Rua
53.12.11.2011|Rewa Rara
53.12.11.2012|Wei Mangoma
53.12.11.2013|Ana Wolu
53.12.11.2014|Pari Rara
53.12.12.2004|Patiala Bawa
53.12.12.2005|Wailibo
53.12.12.2006|Lamboya Bawah
53.12.12.2007|Watu Karere
53.12.12.2008|Kabu Karudi
53.12.12.2009|Rajaka
53.12.12.2010|Sodana
53.12.12.2011|Laboya Dete
53.12.12.2012|Ringu Rara
53.12.12.2014|Bodo Hula
53.12.12.2015|Pala Moko
53.12.15.1001|Wailiang
53.12.15.1002|Komerda
53.12.15.1003|Kampung Baru
53.12.15.1004|Kampung Sawah
53.12.15.1008|Pada Eweta
53.12.15.1009|Maliti
53.12.15.2005|Kodaka
53.12.15.2006|Tebara
53.12.15.2007|Kalembu Kuni
53.12.15.2010|Soba Rade
53.12.15.2011|Lapale
53.12.15.2012|Modu Waimaringu
53.12.15.2013|Puu Mawo
53.12.18.2001|Wee Tana
53.12.18.2002|Gaura
53.12.18.2003|Patiala Dete
53.12.18.2004|Harona Kalla
53.13.01.2001|Pasir Putih
53.13.01.2002|Duawutun
53.13.01.2003|Atawai
53.13.01.2004|Lusiduawutun
53.13.01.2005|Labalimut
53.13.01.2006|Ileboli
53.13.01.2007|Babokerong
53.13.01.2008|Penikenek
53.13.01.2009|Belabaja
53.13.01.2010|Lolong
53.13.01.2011|Wuakoreng
53.13.01.2012|Baobolak
53.13.01.2013|Tewaowutung
53.13.01.2014|Boli Bean
53.13.01.2015|Warawatung
53.13.01.2016|Idalolong
53.13.01.2017|Ria Bao
53.13.01.2018|Liwulagang
53.13.02.2001|Atakore
53.13.02.2002|Lusilame
53.13.02.2004|Lerek
53.13.02.2005|Nubahaeraka
53.13.02.2006|Tubukrajan
53.13.02.2007|Lebaata
53.13.02.2008|Ile Kimok
53.13.02.2009|Katakeja
53.13.02.2010|Ile Kerbau
53.13.02.2011|Dulir
53.13.02.2012|Dori Pewut
53.13.02.2013|Nuba Atalojo
53.13.02.2014|Nogo Doni
53.13.02.2015|Nubaboli
53.13.02.2016|Lewogroma
53.13.03.2001|Kolipadan
53.13.03.2002|Dulitukan
53.13.03.2003|Tagawiti
53.13.03.2004|Waowala
53.13.03.2005|Amakaka
53.13.03.2006|Bungamuda
53.13.03.2007|Napasabok
53.13.03.2012|Petuntawa
53.13.03.2013|Kolontobo
53.13.03.2014|Laranwutun
53.13.03.2015|Watodiri
53.13.03.2016|Tanjung Batu
53.13.03.2018|Muruona
53.13.03.2022|Palilolon
53.13.03.2024|Lamawara
53.13.03.2025|Beutaran
53.13.03.2026|Riangbao
53.13.04.2001|Hadakewa
53.13.04.2002|Lamatuka
53.13.04.2003|Seranggorang
53.13.04.2004|Lodotodokowa
53.13.04.2005|Baopana
53.13.04.2006|Waienga
53.13.04.2007|Lewoeleng
53.13.04.2008|Dikesare
53.13.04.2009|Merdeka
53.13.04.2010|Lerahinga
53.13.04.2011|Tapobarang
53.13.04.2012|Balurebong
53.13.04.2013|Lamadale
53.13.04.2014|Tapolangu
53.13.04.2015|Lamalela
53.13.04.2016|Atakowa
53.13.04.2017|Banitobo
53.13.05.1001|Lewoleba
53.13.05.1002|Lewoleba Timur
53.13.05.1003|Lewoleba Tengah
53.13.05.1004|Lewoleba Utara
53.13.05.1015|Selandoro
53.13.05.1016|Lewoleba Selatan
53.13.05.1017|Lewoleba Barat
53.13.05.2006|Baolangu
53.13.05.2007|Nubamado
53.13.05.2008|Watokobu
53.13.05.2009|Belobatang
53.13.05.2010|Waijarang
53.13.05.2011|Udak Melomata
53.13.05.2012|Paubokol
53.13.05.2013|Pada
53.13.05.2014|Lite Ulumado
53.13.05.2018|Bakalerek
53.13.05.2019|Bour
53.13.06.2001|Balauring
53.13.06.2002|Nilanapo
53.13.06.2003|Leubatang
53.13.06.2004|Walangsawa
53.13.06.2005|Mahal
53.13.06.2006|Aramengi
53.13.06.2007|Meluwiting
53.13.06.2008|Hingalamamengi
53.13.06.2009|Dolulolong
53.13.06.2010|Hoelea
53.13.06.2011|Roma
53.13.06.2012|Leuwayang
53.13.06.2013|Leudanung
53.13.06.2014|Normal
53.13.06.2015|Wailolong
53.13.06.2016|Hoelea II
53.13.06.2017|Lebewala
53.13.06.2018|Mahal II
53.13.06.2019|Peusawa
53.13.06.2020|Wowong
53.13.06.2021|Normal I
53.13.06.2022|Meluwiting I
53.13.07.2001|Panama
53.13.07.2002|Benihading
53.13.07.2003|Atulaleng
53.13.07.2004|Roho
53.13.07.2005|Loyobohor
53.13.07.2006|Leuburi
53.13.07.2007|Kaohua
53.13.07.2008|Kalikur WL
53.13.07.2009|Umaleu
53.13.07.2010|Buriwutung
53.13.07.2011|Mampir
53.13.07.2012|Leuwohung
53.13.07.2013|Bareng
53.13.07.2014|Kalikur
53.13.07.2015|Bean
53.13.07.2016|Benihading II
53.13.07.2017|Tobotani
53.13.07.2018|Tubung Walang
53.13.07.2019|Rumang
53.13.07.2020|Atu' Walupang
53.13.08.2001|Alap Atadei
53.13.08.2002|Atakera
53.13.08.2003|Leworaja
53.13.08.2004|Pantai Harapan
53.13.08.2005|Puor
53.13.08.2006|Imulolong
53.13.08.2007|Lamalera B
53.13.08.2008|Lamalera A
53.13.08.2009|Lelata
53.13.08.2010|Wulandoni
53.13.08.2011|Belobao
53.13.08.2012|Posiwatu
53.13.08.2013|Puor B
53.13.08.2014|Ataili
53.13.08.2015|Tapobali
53.13.09.2001|Todanara
53.13.09.2002|Jontona
53.13.09.2003|Lamawolo
53.13.09.2004|Lamatokan
53.13.09.2005|Bao Lali Duli
53.13.09.2006|Lamaau
53.13.09.2007|Aulesa
53.13.09.2008|Waimatan
53.13.09.2009|Lamagute
53.14.01.2005|Oeseli
53.14.01.2006|Oebou
53.14.01.2007|Lalukoen
53.14.01.2008|Oehandi
53.14.01.2009|Oetefu
53.14.01.2010|Batutua
53.14.01.2011|Meoain
53.14.01.2012|Oebafok
53.14.01.2013|Oebatu
53.14.01.2014|Mbokak
53.14.01.2015|Lekik
53.14.01.2016|Dolasi
53.14.01.2017|Oelasin
53.14.01.2018|Landu
53.14.01.2019|Lentera
53.14.01.2020|Sanggandolu
53.14.01.2021|Sakubatun
53.14.01.2022|Fuafuni
53.14.01.2023|Dalek Esa
53.14.02.1008|Busalangga
53.14.02.2004|Temas
53.14.02.2007|Modosinal
53.14.02.2009|Netenaen
53.14.02.2012|Ingguinak
53.14.02.2013|Oetutulu
53.14.02.2014|Daudolu
53.14.02.2017|Tualima
53.14.02.2019|Hundihuk
53.14.02.2021|Saindule
53.14.02.2025|Busalangga Timur
53.14.02.2026|Busalangga Barat
53.14.03.1001|Namodale
53.14.03.1009|Mokdale
53.14.03.1011|Metina
53.14.03.2002|Kuli
53.14.03.2003|Bebalain
53.14.03.2004|Kolobolon
53.14.03.2005|Helebeik
53.14.03.2006|Sanggaoen
53.14.03.2007|Holoama
53.14.03.2008|Tuanatuk
53.14.03.2010|Oelunggu
53.14.03.2012|Oematamboli
53.14.03.2013|Suelain
53.14.03.2014|Baadale
53.14.03.2015|Lekunik
53.14.03.2016|Loleoen
53.14.03.2017|Kuli Aisele
53.14.03.2018|Oeleka
53.14.04.1002|Onatali
53.14.04.2001|Maubesi
53.14.04.2003|Nggodimeda
53.14.04.2004|Limakoli
53.14.04.2005|Lidamanu
53.14.04.2010|Suebela
53.14.04.2011|Lidabesi
53.14.04.2013|Siomeda
53.14.05.1009|Olafulihaa
53.14.05.2001|Nusakdale
53.14.05.2002|Batulilok
53.14.05.2003|Lenupetu
53.14.05.2004|Sonimanu
53.14.05.2005|Oebau
53.14.05.2006|Oeledo
53.14.05.2007|Keoen
53.14.05.2008|Edalode
53.14.05.2010|Tungganamo
53.14.05.2011|Tesa Bela
53.14.05.2012|Lekona
53.14.05.2013|Oenggae
53.14.05.2014|Fatelilo
53.14.05.2015|Ofalangga
53.14.06.1004|Londalusi
53.14.06.2001|Mukekuku
53.14.06.2002|Faifua
53.14.06.2003|Hundihopo
53.14.06.2005|Serubeba
53.14.06.2006|Lakamola
53.14.06.2007|Matasio
53.14.06.2014|Pengodua
53.14.06.2015|Batefalu
53.14.06.2016|Papela
53.14.06.2017|Matanae
53.14.07.2001|Sedeoen
53.14.07.2002|Nemberala
53.14.07.2003|Oenggaut
53.14.07.2004|Bo'a
53.14.07.2005|Oenitas
53.14.07.2006|Oelolot
53.14.07.2007|Mbueain
53.14.08.2001|Lenguselu
53.14.08.2002|Daleholu
53.14.08.2003|Dodaek
53.14.08.2004|Tebole
53.14.08.2005|Inaoe
53.14.08.2006|Nggelodae
53.14.08.2007|Pilasue
53.14.09.2001|Mbali Lendeiki
53.14.09.2002|Anarae
53.14.09.2003|Mbiu Lombo
53.14.09.2004|Nuse
53.14.09.2005|Ndaonuse
53.14.10.2001|Bolatena
53.14.10.2002|Lifuleo
53.14.10.2003|Sotimori
53.14.10.2004|Daeurendale
53.14.10.2005|Daiama
53.14.10.2006|Pukuafu
53.14.10.2007|Tena Lai
53.14.11.2001|Oelua
53.14.11.2002|Holulai
53.14.11.2003|Tolama
53.14.11.2004|Oebole
53.14.11.2005|Tasilo
53.14.11.2006|Boni
53.14.11.2007|Balaoli
53.14.11.2008|Oebela
53.14.11.2009|Lidor
53.14.11.2010|Mundek
53.15.01.2001|Bari
53.15.01.2002|Rokap
53.15.01.2003|Mbakung
53.15.01.2004|Nggilat
53.15.01.2005|Rego
53.15.01.2006|Wontong
53.15.01.2007|Raba
53.15.01.2008|Nanga Kantor
53.15.01.2014|Watubaru
53.15.01.2015|Lewat
53.15.01.2016|Watu Manggar
53.15.01.2025|Sarae Naru
53.15.01.2026|Nanga Kantor Barat
53.15.02.1022|Golo Ru'u
53.15.02.1023|Nantal
53.15.02.2002|Coal
53.15.02.2004|Pangga
53.15.02.2010|Lewur
53.15.02.2011|Lawi
53.15.02.2017|Compang Suka
53.15.02.2018|Benteng Suru
53.15.02.2021|Sama
53.15.02.2030|Bangka Lewat
53.15.02.2031|Suka Kiong
53.15.02.2032|Golo Pua
53.15.03.1032|Tangge
53.15.03.2003|Wae Wako
53.15.03.2010|Wae Kanta
53.15.03.2011|Ponto Ara
53.15.03.2012|Wae Bangka
53.15.03.2013|Pong Majok
53.15.03.2014|Daleng
53.15.03.2021|Siru
53.15.03.2022|Pondo
53.15.03.2023|Poco Rutang
53.15.03.2025|Ngancar
53.15.03.2033|LIang Sola
53.15.03.2034|Wae Mowol
53.15.03.2035|Golo Ndeweng
53.15.03.2036|Poco Dedeng
53.15.04.2001|Golo Ndaring
53.15.04.2005|Golo Kempo
53.15.04.2008|Golo Manting
53.15.04.2009|Matawae
53.15.04.2011|Nampar Macing
53.15.04.2014|Wae Sano
53.15.04.2016|Golo Mbu
53.15.04.2017|Golo Leleng
53.15.04.2018|Sano Nggoang
53.15.04.2020|Wae Lolos
53.15.04.2024|Golo Sengang
53.15.04.2025|Watu Panggal
53.15.04.2026|Golo Kondeng
53.15.04.2027|Poco Golo Kempo
53.15.04.2028|Pulau Nuncung
53.15.05.1024|Wae Kelambu
53.15.05.1025|Labuan Bajo
53.15.05.2001|Komodo
53.15.05.2002|Pasir Putih
53.15.05.2003|Pasir Panjang
53.15.05.2004|Golo Mori
53.15.05.2005|Warloka
53.15.05.2007|Golo Bilas
53.15.05.2008|Macang Tanggar
53.15.05.2009|Watu Nggelek
53.15.05.2015|Golo Pongkor
53.15.05.2016|Nggorang
53.15.05.2018|Papa Garang
53.15.05.2019|Batu Cermin
53.15.05.2020|Gorontalo
53.15.05.2022|Tiwu Nampar
53.15.05.2026|Seraya Marannu
53.15.05.2027|Compang Longgo
53.15.05.2028|Pantar
53.15.06.2001|Mbuit
53.15.06.2002|Golo Ketak
53.15.06.2003|Pota Wangka
53.15.06.2004|Tanjung Boleng
53.15.06.2005|Golo Sepang
53.15.06.2006|Pontianak
53.15.06.2007|Sepang
53.15.06.2008|Golo Lujang
53.15.06.2009|Batu Tiga
53.15.06.2020|Golo Nobo
53.15.06.2021|Beo Sepang
53.15.07.2001|Golo Ronggot
53.15.07.2002|Semang
53.15.07.2003|Dunta
53.15.07.2004|Gurung
53.15.07.2005|Orong
53.15.07.2006|Pong Welak
53.15.07.2007|Galang
53.15.07.2008|Rehak
53.15.07.2009|Watu Umpu
53.15.07.2010|Pengka
53.15.07.2011|Lale
53.15.07.2015|Racang Welak
53.15.07.2016|Sewar
53.15.07.2017|Robo
53.15.07.2018|Wewa
53.15.07.2019|Golo Ndari
53.15.08.2001|Golo Poleng
53.15.08.2002|Tentang
53.15.08.2003|Raka
53.15.08.2004|Kasong
53.15.08.2005|Ndoso
53.15.08.2006|Waning
53.15.08.2007|Wae Buka
53.15.08.2008|Momol
53.15.08.2009|Lumut
53.15.08.2010|Pong Narang
53.15.08.2011|Golo Bore
53.15.08.2012|Pateng Lesuh
53.15.08.2013|Tehong
53.15.08.2014|Golo Ru'a
53.15.08.2015|Golo Keli
53.15.09.2001|Repi
53.15.09.2002|Watu Waja
53.15.09.2003|Surunumbeng
53.15.09.2004|Munting
53.15.09.2005|Kakor
53.15.09.2006|Lalong
53.15.09.2007|Wae Mose
53.15.09.2008|Nanga Lili
53.15.09.2009|Nanga Bere
53.15.09.2010|Benteng Dewa
53.15.09.2011|Watu Rambung
53.15.09.2012|Lendong
53.15.09.2013|Watu Tiri
53.15.09.2014|Benteng Tado
53.15.09.2015|Modo
53.15.10.2001|Liang Ndara
53.15.10.2002|Tandong Belang
53.15.10.2003|Cunca Lolos
53.15.10.2004|Cunca Wulang
53.15.10.2005|Golo Damu
53.15.10.2006|Golo Ndoal
53.15.10.2007|Golo Sembea
53.15.10.2008|Golo Desat
53.15.10.2009|Kempo
53.15.10.2010|Wae Jare
53.15.10.2011|Golo Tantong
53.15.10.2012|Tiwi Riwung
53.15.10.2013|Watu Wangka
53.15.10.2014|Compang Liang Ndara
53.15.10.2015|Watu Galang
53.15.11.2001|Pacar
53.15.11.2002|Manong
53.15.11.2003|Romang
53.15.11.2004|Compang
53.15.11.2005|Waka
53.15.11.2006|Pong Kolong
53.15.11.2007|Loha
53.15.11.2008|Benteng Ndope
53.15.11.2009|Golo Lajang
53.15.11.2010|Golo Lajang Barat
53.15.11.2011|Kombo
53.15.11.2012|Kombo Selatan
53.15.11.2013|Kombo Tengah
53.15.12.2001|Golo Lewe
53.15.12.2002|Tueng
53.15.12.2003|Sompang Kolang
53.15.12.2004|Wajur
53.15.12.2005|Kolang
53.15.12.2006|Golo Riwu
53.15.12.2007|Compang Kules
53.15.12.2008|Tengku
53.15.12.2009|Golo Wedong
53.15.12.2010|Ranggu
53.16.01.1001|Dhawe
53.16.01.1003|Mbay I
53.16.01.1005|Towak
53.16.01.1007|Mbay II
53.16.01.1009|Danga
53.16.01.1011|Lape
53.16.01.2002|Labolewa
53.16.01.2004|Tedamude
53.16.01.2006|Nggolonio
53.16.01.2008|Olaia
53.16.01.2010|Aerama
53.16.01.2012|Marapokot
53.16.01.2013|Tonggurambang
53.16.01.2014|Waekokak
53.16.01.2015|Ngegedhawe
53.16.01.2016|Tadakisa
53.16.01.2017|Nggolombay
53.16.01.2018|Nangadhero
53.16.02.1001|Nangaroro
53.16.02.2002|Podenura
53.16.02.2003|Tonggo
53.16.02.2004|Wokodekororo
53.16.02.2005|Riti
53.16.02.2006|Kotakeo
53.16.02.2007|Pagomogo
53.16.02.2008|Degalea
53.16.02.2009|Ulupulu
53.16.02.2010|Bidoa
53.16.02.2011|Utetoto
53.16.02.2012|Nataute
53.16.02.2013|Woedoa
53.16.02.2014|Woewutu
53.16.02.2015|Ulupulu I
53.16.02.2016|Wokowoe
53.16.02.2017|Kotakeo Satu
53.16.02.2018|Kotakeo Dua
53.16.02.2019|Kodaute
53.16.03.1001|Natanage
53.16.03.1003|Nagesapadhi
53.16.03.1005|Nageoga
53.16.03.1007|Wolopogo
53.16.03.1009|Rega
53.16.03.1011|Ratongamobo
53.16.03.1013|Olakile
53.16.03.1021|Natanage Timur
53.16.03.2002|Rowa
53.16.03.2004|Solo
53.16.03.2006|Legederu
53.16.03.2008|Nagerawe
53.16.03.2010|Kelewae
53.16.03.2012|Kelimado
53.16.03.2014|Mulakoli
53.16.03.2015|Wea Au
53.16.03.2016|Raja
53.16.03.2017|Wolowea
53.16.03.2018|Gerodhere
53.16.03.2019|Dhereisa
53.16.03.2020|Rigi
53.16.03.2022|Alorawe
53.16.03.2023|Focolodorawe
53.16.03.2024|Wolowea Timur
53.16.03.2025|Wolowea Barat
53.16.03.2026|Raja Timur
53.16.03.2027|Raja Selatan
53.16.04.1001|Mauponggo
53.16.04.2002|Bela
53.16.04.2003|Wolokisa
53.16.04.2004|Wuliwalo
53.16.04.2005|Maukeli
53.16.04.2006|Aewoe
53.16.04.2007|Wolotelu
53.16.04.2008|Sawu
53.16.04.2009|Jawapogo
53.16.04.2010|Ululoga
53.16.04.2011|Lodaolo
53.16.04.2012|Woloede
53.16.04.2013|Woewolo
53.16.04.2014|Salalejo
53.16.04.2015|Ua
53.16.04.2016|Kotagana
53.16.04.2017|Lokalaba
53.16.04.2018|Lajawajo
53.16.04.2019|Keliwatulewa
53.16.04.2020|Wololelu
53.16.04.2021|Selalejo Timur
53.16.05.2001|Tendatoto
53.16.05.2002|Totomala
53.16.05.2003|Tendakinde
53.16.05.2004|Anakoli
53.16.05.2005|Natatoto
53.16.06.2001|Witurombaua
53.16.06.2002|Lewangera
53.16.06.2003|Wajo
53.16.06.2004|Kotowuji Timur
53.16.06.2005|Kotowuji Barat
53.16.06.2006|Mbaenuamuri
53.16.06.2007|Udiworowatu
53.16.06.2008|Kotodirumali
53.16.06.2009|Pautola
53.16.06.2010|Ladolima
53.16.06.2011|Keli
53.16.06.2012|Ngera
53.16.06.2013|Ladolima Timur
53.16.06.2014|Ladolima Utara
53.16.06.2015|Wajo Timur
53.16.06.2016|Paumali
53.16.07.2001|Rendubutowe
53.16.07.2002|Tengatiba
53.16.07.2003|Langedhawe
53.16.07.2004|Renduteno
53.16.07.2005|Renduwawo
53.16.07.2006|Wajomara
53.16.07.2007|Rendut Tutubhada
53.17.01.2001|Makata Keri
53.17.01.2003|Kabela Wuntu
53.17.01.2004|Mata Woga
53.17.01.2019|Umbu Riri
53.17.01.2023|Anakalang
53.17.01.2024|Dewa Jara
53.17.01.2025|Mata Redi
53.17.02.2002|Praimadeta
53.17.02.2003|Pondok
53.17.02.2004|Maderi
53.17.02.2005|Anajiaka
53.17.02.2006|Wairasa
53.17.02.2007|Umbu Kawolu
53.17.02.2008|Umbu Mamijuk
53.17.02.2009|Umbu Pabal
53.17.02.2010|Umbu Langang
53.17.02.2021|Umbu Pabal Selatan
53.17.02.2022|Umbu Jodu
53.17.02.2023|Anapalu
53.17.02.2024|Daha Elu
53.17.02.2025|Dewa Tana
53.17.02.2027|Mata Waikajawi
53.17.03.2001|Wendewa Timur
53.17.03.2002|Wendewa Selatan
53.17.03.2003|Wendewa Utara
53.17.03.2004|Wendewa Barat
53.17.03.2005|Cendana
53.17.03.2006|Wee Luri
53.17.03.2007|Ole Ate
53.17.03.2008|Manu Wolu
53.17.03.2009|Watu Asa
53.17.03.2010|Bondo Sulla
53.17.03.2011|Susu Wendewa
53.17.03.2012|Ole Dewa
53.17.03.2013|Cendana Barat
53.17.04.2001|Mbilur Pangadu
53.17.04.2002|Soru
53.17.04.2003|Praikoruku Jangga
53.17.04.2007|Lenang
53.17.04.2008|Tana Mbanas
53.17.04.2009|Padira Tana
53.17.04.2010|Ngadu Bolu
53.17.04.2014|Tana Mbanas Selatan
53.17.04.2015|Tana Mbanas Barat
53.17.04.2016|Ngadu Olu
53.17.04.2017|Lenang Selatan
53.17.05.2001|Konda Maloba
53.17.05.2002|Tana Modu
53.17.05.2003|Malinjak
53.17.05.2004|Wailawa
53.17.05.2005|Dameka
53.17.05.2006|Waimanu
53.17.05.2007|Manurara
53.17.05.2008|Elu
53.17.05.2009|Oka Wacu
53.17.06.2001|Bolu Bokat
53.17.06.2002|Mara Desa
53.17.06.2003|Weluk Praimemang
53.17.06.2004|Bolu Bokat Utara
53.17.06.2005|Maradesa Timur
53.17.06.2006|Maradesa Selatan
53.17.06.2007|Bolu Bokat Barat
53.17.06.2008|Wangga Waiyengu
53.17.06.2009|Sambali Loku
53.17.06.2010|Holur Kambata
53.18.01.2001|Bondo Boghila
53.18.01.2002|Lete Konda
53.18.01.2003|Karuni
53.18.01.2004|Totok
53.18.01.2009|Rama Dana
53.18.01.2010|Wee Mananda
53.18.01.2013|Pogo Tena
53.18.01.2014|Payola Umbu
53.18.01.2015|Wee Kambala
53.18.01.2016|Loko Kalada
53.18.01.2017|Lete Konda Selatan
53.18.02.2001|Mali Mada
53.18.02.2002|Wano Talla
53.18.02.2003|Wee Paboba
53.18.02.2004|Mata Loko
53.18.02.2005|Wee Namba
53.18.02.2006|Puu Potto
53.18.02.2007|Bodo Ponda
53.18.02.2008|Reda Wano
53.18.02.2009|Odi Paurata
53.18.02.2010|Pandua Tana
53.18.02.2011|Djela Manu
53.18.02.2012|Mawo Maliti
53.18.03.2001|Kalembu Ndara Mane
53.18.03.2002|Tema Tana
53.18.03.2005|Mareda Kalada
53.18.03.2006|Pada Eweta
53.18.03.2012|Wee Limbu
53.18.03.2013|Lete Kamouna
53.18.03.2014|Mata Pyawu
53.18.03.2015|Wee Lima
53.18.03.2018|Dikira
53.18.03.2020|Dangga Mangu
53.18.03.2021|Mainda Ole
53.18.03.2022|Kadi Wano
53.18.03.2023|Nyura Lele
53.18.03.2024|Lele Maya
53.18.03.2025|Maliti Dari
53.18.03.2026|Mawo Dana
53.18.03.2027|Dede Pada
53.18.03.2028|Mata Wee Lima
53.18.03.2029|Kadi Wone
53.18.04.2001|Waimangura
53.18.04.2002|Kalembu Weri
53.18.04.2003|Wali Ate
53.18.04.2004|Kabali Dana
53.18.04.2005|Wee Kombaka
53.18.04.2006|Marokota
53.18.04.2007|Watu Labara
53.18.04.2008|Kalimbu Tillu
53.18.04.2011|Menne Ate
53.18.04.2012|Reda Pada
53.18.04.2013|Raba Ege
53.18.04.2015|Kalaki Kambe
53.18.04.2016|Kalembu Kanaika
53.18.04.2017|Laga Lete
53.18.04.2018|Wee Kura
53.18.04.2019|Lua Koba
53.18.04.2020|Tawo Rara
53.18.04.2021|Sangu Ate
53.18.04.2022|Lolo Ole
53.18.04.2023|Pero
53.18.05.2001|Buru Deilo
53.18.05.2002|Weri Lolo
53.18.05.2003|Buru Kaghu
53.18.05.2004|Denduka
53.18.05.2005|Bondo Bela
53.18.05.2006|Delo
53.18.05.2007|Tena Teke
53.18.05.2008|Bondo Ukka
53.18.05.2009|Umbu Wangu
53.18.05.2010|Milla Ate
53.18.05.2011|Rita Baru
53.18.05.2012|Mandungo
53.18.05.2013|Wee Wulla
53.18.05.2014|Wee Baghe
53.18.06.2001|Dinjo
53.18.06.2002|Lete Loko
53.18.06.2003|Walla Ndimu
53.18.06.2006|Waikadada
53.18.06.2010|Rada Loko
53.18.06.2011|Mata Kapore
53.18.06.2012|Umbu Ngedo
53.18.06.2014|Waimakaha
53.18.06.2015|Waimaringi
53.18.06.2016|Tana Mete
53.18.06.2017|Waipaddi
53.18.06.2018|Manu Toghi
53.18.06.2019|Karang Indah
53.18.06.2020|Rada Malando
53.18.06.2021|Waikaninyo
53.18.06.2022|Ana Goka
53.18.06.2023|Delu Depa
53.18.06.2024|Mere Kehe
53.18.06.2025|Bondo Balla
53.18.06.2026|Maliti Bondo Ate
53.18.06.2027|Ana Lewe
53.18.07.2001|Bondo Kodi
53.18.07.2002|Ate Dalo
53.18.07.2003|Hamonggo Lele
53.18.07.2004|Homba Rande
53.18.07.2005|Pero Batang
53.18.07.2006|Wura Homba
53.18.07.2007|Koki
53.18.07.2008|Kapaka Madeta
53.18.07.2009|Kawango Hari
53.18.07.2010|Onggol
53.18.07.2011|Mali lha
53.18.07.2012|Watu Wona
53.18.07.2013|Tanjung Karoso
53.18.07.2014|Pero Konda
53.18.07.2015|Homba Rica
53.18.07.2016|Ana Kaka
53.18.07.2017|Ole Ate
53.18.07.2018|Kadoki Horo
53.18.07.2019|Ana Engge
53.18.08.2001|Hoha Wungo
53.18.08.2002|Homba Karipit
53.18.08.2003|Wailabubur
53.18.08.2004|Kori
53.18.08.2005|Kalena Rongo
53.18.08.2006|Waiholo
53.18.08.2007|Noha
53.18.08.2008|Mangganipi
53.18.08.2009|Kendu Wela
53.18.08.2010|Bila Cenge
53.18.08.2011|Bukambero
53.18.08.2013|Homba Pare
53.18.08.2014|Magho Linyo
53.18.08.2015|Wee Wella
53.18.08.2016|Kadu Eta
53.18.08.2017|Kadaghu Tana
53.18.08.2018|Hameli Ate
53.18.08.2019|Waitaru
53.18.08.2020|Nangga Mutu
53.18.08.2021|Limbu Kembe
53.18.08.2022|Moro Manduyo
53.18.09.1003|Langga Lero
53.18.09.1004|Waitabula
53.18.09.2001|Rada Mata
53.18.09.2002|Kalena Wano
53.18.09.2005|Wee Londa
53.18.09.2006|Wee Pangali
53.18.09.2007|Kadi Pada
53.18.09.2008|Watu Kawula
53.18.09.2009|Wee Rena
53.18.09.2010|Kalembu Kaha
53.18.10.2001|Kanelu
53.18.10.2002|Tanggaba
53.18.10.2003|Wee Kokora
53.18.10.2004|Wee Rame
53.18.10.2005|Lombu
53.18.10.2006|Eka Pata
53.18.10.2007|Bolora
53.18.10.2008|Omba Rade
53.18.10.2009|Kalingara
53.18.10.2010|Wee Patando
53.18.10.2011|Mereda Wuni
53.18.10.2012|Mata Wee Karoro
53.18.10.2013|Gollu Sapi
53.18.10.2014|Mata Lombu
53.18.10.2015|Kadi Roma
53.18.10.2016|Bondo Delo
53.18.10.2017|Lete Wungana
53.18.10.2018|Limbu Watu
53.18.10.2019|Kiku Booko
53.18.10.2020|Tarra Mata
53.18.11.2001|Wailangira
53.18.11.2002|Kahale
53.18.11.2003|Waikarara
53.18.11.2004|Panenggo Ede
53.18.11.2005|Waiha
53.18.11.2006|Wainyapu
53.18.11.2007|Loko Tali
53.18.11.2008|Waipakolo
53.19.01.1020|Kota Ndora
53.19.01.1021|Rana Loba
53.19.01.1039|Satar Peot
53.19.01.2001|Nanga Labang
53.19.01.2004|Gurung Liwut
53.19.01.2005|Benteng Riwu
53.19.01.2006|Ngampang Mas
53.19.01.2009|Rana Masak
53.19.01.2010|Benteng Raja
53.19.01.2014|Golo Lalong
53.19.01.2017|Golo Kantar
53.19.01.2018|Poco Rii
53.19.01.2025|Balus Permai
53.19.01.2031|Waling
53.19.01.2032|Golo Leda
53.19.01.2034|Compang Tenda
53.19.01.2035|Bangka Kantar
53.19.01.2038|Compang Ndejing
53.19.02.1027|Mandosawu
53.19.02.1028|Nggalak Leleng
53.19.02.1042|Bangka Leleng
53.19.02.2001|Poco Lia
53.19.02.2002|Pocong
53.19.02.2003|Lenang
53.19.02.2004|Melo
53.19.02.2005|Leong
53.19.02.2011|Bea Waek
53.19.02.2013|Golo Lobos
53.19.02.2014|Bangka Kuleng
53.19.02.2015|Bangka Pau
53.19.02.2016|Golo Nderu
53.19.02.2017|Satar Tesem
53.19.02.2018|Gurung Turi
53.19.02.2019|Compang Laho
53.19.02.2020|Watu Lanur
53.19.02.2026|Golo Ndari
53.19.02.2029|Compang Wesang
53.19.02.2030|Golo Wune
53.19.02.2031|Lento
53.19.02.2032|Compang Weluk
53.19.02.2033|Golo Rengket
53.19.02.2037|Deno
53.19.03.2001|Tengku Leda
53.19.03.2002|Tengku Lawar
53.19.03.2003|Goreng Meni
53.19.03.2004|Golo Munga
53.19.03.2009|Golo Rentung
53.19.03.2010|Golo Lembur
53.19.03.2011|Compang Necak
53.19.03.2013|Compang Mekar
53.19.03.2014|Compang Deru
53.19.03.2016|Golo Nimbung
53.19.03.2017|Lamba Keli
53.19.03.2021|Goreng Meni Utara
53.19.03.2023|Golo Paleng
53.19.04.1009|Pota
53.19.04.1011|Nanga Baras
53.19.04.1018|Ulung Baras
53.19.04.1020|Golo Wangkung Utara
53.19.04.2001|Nanga Mbaur
53.19.04.2002|Nanga Mbaling
53.19.04.2007|Lada Mese
53.19.04.2012|Nampar Sepang
53.19.04.2013|Kembang Mekar
53.19.04.2014|Wela Lada
53.19.05.1020|Tiwu Kondo
53.19.05.2001|Lengko Namut
53.19.05.2002|Rana Kulan
53.19.05.2003|Golo Munde
53.19.05.2004|Golo Lebo
53.19.05.2005|Golo Lijun
53.19.05.2009|Sisir
53.19.05.2015|Haju Ngendong
53.19.05.2016|Legur Lai
53.19.05.2017|Rana Gapang
53.19.05.2018|Biting
53.19.05.2025|Compang Soba
53.19.05.2026|Compang Teo
53.19.05.2028|Kaju Wangi
53.19.05.2029|Wae Lokom
53.19.06.1001|Watu Nggene
53.19.06.1002|Rongga Koe
53.19.06.1017|Tanah Rata
53.19.06.2003|Lembur
53.19.06.2004|Ruan
53.19.06.2006|Mbengan
53.19.06.2007|Rana Kolong
53.19.06.2008|Gunung
53.19.06.2013|Komba
53.19.06.2014|Bamo
53.19.06.2015|Pong Ruan
53.19.07.2001|Bea Ngencung
53.19.07.2002|Satar Lahing
53.19.07.2003|Torok Golo
53.19.07.2004|Golo Ros
53.19.07.2005|Rondo Woing
53.19.07.2006|Sano Lokom
53.19.07.2007|Golo Loni
53.19.07.2008|Sita
53.19.07.2009|Golo Rutuk
53.19.07.2010|Golo Meleng
53.19.07.2011|Wae Nggori
53.19.07.2012|Compang Kantar
53.19.07.2013|Watu Mori
53.19.07.2014|Bangka Kempo
53.19.07.2015|Compang Teber
53.19.07.2016|Satar Lenda
53.19.07.2017|Lidi
53.19.07.2018|Bangka Masa
53.19.07.2019|Lalang
53.19.07.2020|Compang Loni
53.19.07.2021|Compang Kempo
53.19.08.2001|Watu Arus
53.19.08.2002|Arus
53.19.08.2003|Golo Lero
53.19.08.2004|Rengkam
53.19.08.2005|Compang Wunis
53.19.08.2006|Benteng Rampas
53.19.08.2007|Ngkiong Dora
53.19.08.2008|Ulu Wae
53.19.08.2009|Rende Nao
53.19.08.2010|Wangkar Weli
53.19.08.2011|Tango Molas
53.19.08.2012|Urung Dora
53.19.08.2013|Compang Raci
53.19.08.2014|Wejang Mawe
53.19.08.2015|Bangka Arus
53.19.08.2016|Colol
53.19.08.2017|Benteng Wunis
53.19.08.2018|Wejang Mali
53.19.09.1001|Lempang Paji
53.19.09.2002|Sangan Kalo
53.19.09.2003|Sipi
53.19.09.2004|Gising
53.19.09.2005|Langga Sai
53.19.09.2006|Teno Mese
53.19.09.2007|Golo Wuas
53.19.09.2008|Nanga Meje
53.19.09.2009|Paan Waru
53.19.09.2010|Golo Linus
53.19.09.2011|Benteng Pau
53.19.09.2012|Wae Rasan
53.19.09.2013|Mosi Ngaran
53.19.09.2014|Nanga Puun
53.19.10.2001|Golo Tolang
53.19.10.2002|Mokel
53.19.10.2003|Paan Leleng
53.19.10.2004|Rana Mbeling
53.19.10.2005|Golo Meni
53.19.10.2006|Golo Nderu
53.19.10.2007|Golo Ndele
53.19.10.2008|Rana Mbata
53.19.10.2009|Mokel Morid
53.19.10.2010|Watu Pari
53.19.10.2011|Gunung Baru
53.19.11.2001|Satar Padut
53.19.11.2002|Satar Punda
53.19.11.2003|Nampar Tabang
53.19.11.2004|Lencur
53.19.11.2005|Liang Deruk
53.19.11.2006|Haju Wangi
53.19.11.2007|Satar Kampas
53.19.11.2008|Golo Mangung
53.19.11.2009|Golo Wontong
53.19.11.2010|Golo Munga Barat
53.19.11.2011|Satar Punda Barat
53.19.12.1001|Golo Wangkung
53.19.12.1007|Golo Wangkung Barat
53.19.12.2002|Buti
53.19.12.2003|Golo Ngawan
53.19.12.2004|Satar Nawang
53.19.12.2005|Rana Mese
53.19.12.2006|Compang Congkar
53.19.12.2008|Compang Lawi
53.19.12.2009|Golo Pari
53.19.12.2010|Wea
53.20.01.1001|Mebba
53.20.01.2002|Menia
53.20.01.2003|Raeloro
53.20.01.2004|Naawawi
53.20.01.2005|Teriwu
53.20.01.2006|Raenalulu
53.20.01.2007|Raedewa
53.20.01.2008|Ledeana
53.20.01.2009|Depe
53.20.01.2010|Raemude
53.20.01.2011|Raekore
53.20.01.2012|Raenyale
53.20.01.2013|Raemadia
53.20.01.2014|Delo
53.20.01.2015|Roboaba
53.20.01.2016|Djadu
53.20.01.2017|Ledekepaka
53.20.01.2018|Titinalede
53.20.02.2001|Bebae
53.20.02.2002|Tada
53.20.02.2003|Matei
53.20.02.2004|Loboaju
53.20.02.2005|Eimadake
53.20.02.2006|Jiwuwu
53.20.02.2007|Eilode
53.20.02.2008|Eimau
53.20.03.1001|Bolou
53.20.03.1002|Limaggu
53.20.03.2003|Lobodei
53.20.03.2004|Bodae
53.20.03.2005|Keduru
53.20.03.2006|Kuji Ratu
53.20.03.2007|Loborai
53.20.03.2008|Huwaga
53.20.03.2009|Eiada
53.20.03.2010|Keliha
53.20.04.2001|Raerobo
53.20.04.2002|Mehona
53.20.04.2003|Waduwalla
53.20.04.2004|Ledeke
53.20.04.2005|Eilogo
53.20.04.2006|Deme
53.20.04.2007|Kotahawu
53.20.04.2008|Dainao
53.20.04.2009|Eikare
53.20.04.2010|Loborui
53.20.04.2011|Halla Paji
53.20.04.2012|Ledetalo
53.20.05.2001|Lobohede
53.20.05.2002|Molie
53.20.05.2003|Daieko
53.20.05.2004|Pedarro
53.20.05.2005|Tanajawa
53.20.05.2006|Ledeae
53.20.05.2007|Wadumaddi
53.20.05.2008|Lederaga
53.20.05.2009|Gurimonearu
53.20.05.2010|Ramedue
53.20.06.1001|Ledeke
53.20.06.1002|Ledeunu
53.20.06.2003|Bolua
53.20.06.2004|Kolorae
53.20.06.2005|Ballu
53.21.01.2001|Barene
53.21.01.2002|Kakaniuk
53.21.01.2003|Kateri
53.21.01.2004|Bakiruk
53.21.01.2005|Kamanasa
53.21.01.2006|Wehali
53.21.01.2007|Umakatahan
53.21.01.2008|Umanen Lawalu
53.21.01.2009|Kletek
53.21.01.2010|Naimana
53.21.01.2011|Fahiluka
53.21.01.2012|Lawalu
53.21.01.2013|Harekakae
53.21.01.2014|Barada
53.21.01.2015|Bereliku
53.21.01.2016|Railor Tahak
53.21.01.2017|Suai
53.21.02.2001|Motaulun
53.21.02.2002|Sikun
53.21.02.2003|Fafoe
53.21.02.2004|Lasaen
53.21.02.2005|Umatoos
53.21.02.2006|Rabasahain
53.21.02.2007|Umalor
53.21.02.2008|Besikama
53.21.02.2009|Maktihan
53.21.02.2010|Loofoun
53.21.02.2011|Rabasa
53.21.02.2012|Rabasa Haerain
53.21.02.2013|Motaain
53.21.02.2014|Oan Mane
53.21.02.2015|Raimataus
53.21.02.2016|Naas
53.21.03.2001|Halibasar
53.21.03.2002|Weulun
53.21.03.2003|Webriamata
53.21.03.2004|Badarai
53.21.03.2005|Weoe
53.21.03.2006|Lorotolus
53.21.03.2007|Seserai
53.21.03.2008|Alkani
53.21.03.2009|Lamea
53.21.03.2010|Rabasa Biris
53.21.03.2011|Biris
53.21.03.2012|Weseben
53.21.04.2001|Wesey
53.21.04.2002|Haitimuk
53.21.04.2003|Laleten
53.21.04.2004|Kleseleon
53.21.04.2005|Angkaes
53.21.04.2006|Wederok
53.21.04.2007|Lamudur
53.21.04.2008|Forekmodok
53.21.04.2009|Umalawain
53.21.04.2010|Lakulo
53.21.04.2011|Leunklot
53.21.04.2012|Haliklaran
53.21.04.2013|Bonetasea
53.21.04.2014|Taaba
53.21.05.2001|Saenama
53.21.05.2002|Wekmidar
53.21.05.2003|Lotas
53.21.05.2004|Nanin
53.21.05.2005|Alala
53.21.05.2006|Oekmurak
53.21.05.2007|Webetun
53.21.05.2008|Naet
53.21.05.2009|Biudukfoho
53.21.05.2010|Niti
53.21.05.2011|Tafuli
53.21.05.2012|Boen
53.21.05.2013|Wekeke
53.21.05.2014|Raisamane
53.21.05.2015|Weain
53.21.05.2016|Nabutaek
53.21.05.2017|Tafuli I
53.21.05.2018|Nanebot
53.21.05.2019|Muke
53.21.05.2020|Naiusu
53.21.06.2001|Biau
53.21.06.2002|Kufeu
53.21.06.2003|Tunmat
53.21.06.2004|Tunabesi
53.21.06.2005|Bani-Bani
53.21.06.2006|Fatoin
53.21.06.2007|Ikan Tuanbeis
53.21.07.2001|As Manulea
53.21.07.2002|Manulea
53.21.07.2003|Naibone
53.21.07.2004|Fatuaruin
53.21.07.2005|Builaran
53.21.07.2006|Manumutin Silole
53.21.07.2007|Umutnana
53.21.07.2008|Beaneno
53.21.07.2009|Naisau
53.21.08.2001|Meotroi
53.21.08.2002|Tesa
53.21.08.2003|Kapitan Meo
53.21.08.2004|Tniumanu
53.21.08.2005|Uabau
53.21.08.2006|Boni Bais
53.21.08.2007|Nauke Kusa
53.21.08.2008|Bisesmus
53.21.08.2009|Oenaek
53.21.09.2001|Raiulun
53.21.09.2002|Wemeda
53.21.09.2003|Kusa
53.21.09.2004|Numponi
53.21.09.2005|Dirma
53.21.09.2006|Sanleo
53.21.10.2001|Alas Utara
53.21.10.2002|Kotabiru
53.21.10.2003|Alas
53.21.10.2004|Alas Selatan
53.21.11.2001|Babulu
53.21.11.2002|Babulu Selatan
53.21.11.2003|Sisi
53.21.11.2004|Rainawe
53.21.11.2005|Litamali
53.21.11.2006|Lakekun Utara
53.21.11.2007|Lakekun
53.21.11.2008|Lakekun Barat
53.21.12.2001|Babotin
53.21.12.2002|Kereana
53.21.12.2003|Babotin Maemina
53.21.12.2004|Babotin Selatan
53.21.12.2005|Takarai
53.71.01.1001|Namosain
53.71.01.1002|Nunbaun Sabu
53.71.01.1003|Nunbaun Delha
53.71.01.1004|Nunhila
53.71.01.1005|Fatufeto
53.71.01.1006|Manutapen
53.71.01.1007|Mantasi
53.71.01.1008|Alak
53.71.01.1009|Batu Plat
53.71.01.1010|Manulai II
53.71.01.1011|Naioni
53.71.01.1012|Penkase Oeleta
53.71.02.1001|Oepura
53.71.02.1002|Maulafa
53.71.02.1003|Penfui
53.71.02.1004|Naimata
53.71.02.1005|Bello
53.71.02.1006|Fatukoa
53.71.02.1007|Kolhua
53.71.02.1008|Sikumana
53.71.02.1009|Naikolan
53.71.03.1001|Kelapa Lima
53.71.03.1010|Oesapa
53.71.03.1011|Lasiana
53.71.03.1014|Oesapa Barat
53.71.03.1015|Oesapa Selatan
53.71.04.1001|Oebobo
53.71.04.1008|Oetete
53.71.04.1009|Oebufu
53.71.04.1010|Liliba
53.71.04.1011|Fatululi
53.71.04.1013|Kayu Putih
53.71.04.1014|Tuak Daun Merah
53.71.05.1001|Bakunase
53.71.05.1002|Bakunase Dua
53.71.05.1003|Airnona
53.71.05.1004|Naikoten Satu
53.71.05.1005|Naikoten Dua
53.71.05.1006|Kuanino
53.71.05.1007|Nunleu
53.71.05.1008|Fontein
53.71.06.1001|Airmata
53.71.06.1002|Lai Lai Bisi Kopan
53.71.06.1003|Bonipoi
53.71.06.1004|Solor
53.71.06.1005|Tode Kisar
53.71.06.1006|Merdeka
53.71.06.1007|Oeba
53.71.06.1008|Fatubesi
53.71.06.1009|Pasir Panjang
53.71.06.1010|Nefonaek
61.01.01.2001|Dalam Kaum
61.01.01.2002|Lubuk Dagang
61.01.01.2003|Tanjung Bugis
61.01.01.2004|Pendawan
61.01.01.2005|Pasar Melayu
61.01.01.2006|Durian
61.01.01.2007|Lorong
61.01.01.2008|Jagur
61.01.01.2009|Tumuk Manggis
61.01.01.2010|Tanjung Mekar
61.01.01.2011|Sebayan
61.01.01.2012|Kartiasa
61.01.01.2013|Saing Rambi
61.01.01.2014|Lumbang
61.01.01.2015|Sungai Rambah
61.01.01.2023|Gapura
61.01.01.2024|Sumber Harapan
61.01.01.2029|Semangau
61.01.02.2001|Sungai Kumpai
61.01.02.2002|Sekura
61.01.02.2003|Tri Mandayan
61.01.02.2004|Pedada
61.01.02.2005|Lela
61.01.02.2006|Puringan
61.01.02.2007|Berlimang
61.01.02.2008|Sungai Baru
61.01.02.2009|Sengawang
61.01.02.2010|Teluk Kaseh
61.01.02.2011|Sepadu
61.01.02.2012|Tambatan
61.01.02.2013|Kubangga
61.01.02.2020|Sungai Serabek
61.01.02.2021|Sayang Sedayu
61.01.02.2022|Pipit Teja
61.01.02.2024|Matang Segantar
61.01.02.2025|Mulia
61.01.02.2026|Teluk Kembang
61.01.02.2027|Samustida
61.01.02.2028|Tanjung Keracut
61.01.02.2029|Sebagu
61.01.02.2030|Mekar Sekuntum
61.01.02.2031|Kuala Pangkalan Keramat
61.01.02.2032|Sabing
61.01.03.2001|Sarang Burung Danau
61.01.03.2002|Sungai Nilam
61.01.03.2003|Sarang Burung Kolam
61.01.03.2004|Sarang Burung Usrat
61.01.03.2005|Sarang Burung Kuala
61.01.03.2006|Pelimpaan
61.01.03.2007|Parit Setia
61.01.03.2008|Bakau
61.01.03.2009|Sungai Nyirih
61.01.03.2010|Sentebang
61.01.03.2011|Dungun Laut
61.01.03.2021|Lambau
61.01.03.2022|Mutus Darussalam
61.01.04.2001|Tebas Kuala
61.01.04.2002|Tebas Sungai
61.01.04.2003|Sempalai
61.01.04.2004|Bekut
61.01.04.2005|Seberkat
61.01.04.2006|Sejiram
61.01.04.2007|Makrampai
61.01.04.2008|Mekar Sekuntum
61.01.04.2009|Mensere
61.01.04.2010|Pusaka
61.01.04.2011|Segedong
61.01.04.2012|Sungai Kelambu
61.01.04.2013|Serumpun Buluh
61.01.04.2014|Pangkalan Kongsi
61.01.04.2015|Dungun Perapakan
61.01.04.2016|Batu Makjage
61.01.04.2017|Serindang
61.01.04.2018|Bukit Sigoler
61.01.04.2019|Matang Labong
61.01.04.2020|Maktangguk
61.01.04.2021|Segarau Parit
61.01.04.2022|Maribas
61.01.04.2023|Seret Ayon
61.01.05.2001|Pemangkat Kota
61.01.05.2002|Harapan
61.01.05.2003|Penjajap
61.01.05.2005|Jelutung
61.01.05.2013|Perapakan
61.01.05.2016|Sebatuan
61.01.05.2017|Gugah Sejahtera
61.01.05.2018|Lonam
61.01.06.2001|Sulung
61.01.06.2002|Penakalan
61.01.06.2003|Sekuduk
61.01.06.2004|Setalik
61.01.06.2005|Parit Raja
61.01.06.2006|Piantus
61.01.06.2007|Perigi Landu
61.01.06.2008|Sendoyan
61.01.06.2009|Senujuh
61.01.06.2010|Perigi Limus
61.01.06.2011|Semanga
61.01.06.2012|Sepantai
61.01.07.2001|Semelagi Besar
61.01.07.2002|Sungai Daun
61.01.07.2003|Sungai Rusa
61.01.07.2004|Sungai Nyirih
61.01.07.2005|Kuala
61.01.07.2006|Parit Baru
61.01.07.2007|Twi Mentibar
61.01.07.2008|Bentunai
61.01.07.2013|Pangkalan Bemban
61.01.07.2014|Parit Kongsi
61.01.07.2015|Gayung Bersambut
61.01.08.2001|Sebubus
61.01.08.2002|Nibung
61.01.08.2003|Malek
61.01.08.2004|Tanah Hitam
61.01.08.2005|Matang Danau
61.01.08.2006|Kalimantan
61.01.08.2007|Temajuk
61.01.08.2008|Mentibar
61.01.09.2001|Kaliau'
61.01.09.2002|Sebunga
61.01.09.2003|Santaban
61.01.09.2004|Sanatab
61.01.09.2005|Sungai Bening
61.01.10.2001|Balai Gemuruh
61.01.10.2002|Sungai Sapa'
61.01.10.2003|Madak
61.01.10.2004|Sabung
61.01.10.2005|Tebuah Elok
61.01.10.2006|Sungai Deden
61.01.10.2007|Bukit Mulya
61.01.10.2008|Mukti Raharja
61.01.10.2009|Sempurna
61.01.10.2010|Mensade
61.01.10.2011|Karaban Jaya
61.01.10.2012|Arga Pura
61.01.10.2013|Sapak Hulu Trans
61.01.11.2001|Sagu
61.01.11.2002|Sungai Palah
61.01.11.2003|Galing
61.01.11.2004|Tempapan Kuala
61.01.11.2005|Tempapan Hulu
61.01.11.2006|Ratu Sepudak
61.01.11.2007|Tri Kembang
61.01.11.2008|Tri Gadu
61.01.11.2009|Teluk Pandan
61.01.11.2010|Sijang
61.01.12.2001|Tekarang
61.01.12.2002|Merubung
61.01.12.2003|Cepala
61.01.12.2004|Sari Makmur
61.01.12.2005|Rambayan
61.01.12.2006|Sempadian
61.01.12.2007|Matang Segarau
61.01.13.2001|Singaraya
61.01.13.2002|Semparuk
61.01.13.2003|Sepinggan
61.01.13.2004|Sepadu
61.01.13.2005|Seburing
61.01.14.2001|Jirak
61.01.14.2002|Tengguli
61.01.14.2003|Mekar Jaya
61.01.14.2004|Beringin
61.01.15.2001|Rantau Panjang
61.01.15.2002|Tebing Batu
61.01.15.2003|Sebawi
61.01.15.2004|Sepuk Tanjung
61.01.15.2005|Sebangun
61.01.15.2006|Sempalai Sebedang
61.01.15.2007|Tempatan
61.01.16.2001|Jawai Laut
61.01.16.2002|Jelu Air
61.01.16.2003|Matang Terap
61.01.16.2004|Suah Api
61.01.16.2005|Sarilaba A
61.01.16.2006|Sarilaba B
61.01.16.2007|Semperiuk A
61.01.16.2008|Semperiuk B
61.01.16.2009|Sabaran
61.01.17.2001|Tangaran
61.01.17.2002|Simpang Empat
61.01.17.2003|Merabuan
61.01.17.2004|Semata
61.01.17.2005|Merpati
61.01.17.2006|Pancur
61.01.17.2007|Arung Parak
61.01.17.2008|Arung Medang
61.01.18.2001|Parit Baru
61.01.18.2002|Sungai Toman
61.01.18.2003|Serunai
61.01.18.2004|Serumpun
61.01.18.2005|Salatiga
61.01.19.2001|Gelik
61.01.19.2002|Seranggam
61.01.19.2003|Selakau Tua
61.01.19.2004|Buduk Sempadang
61.02.01.1006|Tanjung
61.02.01.1007|Tengah
61.02.01.1009|Terusan
61.02.01.2001|Sengkubang
61.02.01.2002|Penibung
61.02.01.2003|Pasir
61.02.01.2013|Kuala Secapah
61.02.01.2015|Malikian
61.02.06.2001|Toho Ilir
61.02.06.2002|Pak Laheng
61.02.06.2003|Kecurit
61.02.06.2004|Terap
61.02.06.2005|Sepang
61.02.06.2006|Pak Utan
61.02.06.2007|Benuang
61.02.06.2008|Sambora
61.02.07.1011|Sungai Pinyuh
61.02.07.2001|Sungai Rasau
61.02.07.2002|Sungai Bakau Besar Darat
61.02.07.2003|Sungai Purun Kecil
61.02.07.2004|Sungai Bakau Besar Laut
61.02.07.2005|Sungai Batang
61.02.07.2006|Peniraman
61.02.07.2007|Nusapati
61.02.07.2008|Galang
61.02.08.2001|Wajok Hilir
61.02.08.2002|Sungai Nipah
61.02.08.2006|Peniti Luar
61.02.08.2009|Wajok Hulu
61.02.08.2010|Jungkat
61.02.12.2001|Sungai Duri I
61.02.12.2002|Sungai Duri II
61.02.12.2003|Bukit Batu
61.02.12.2004|Sungai Bundung Laut
61.02.12.2005|Sungai Kunyit Laut
61.02.12.2006|Sungai Kunyit Dalam
61.02.12.2007|Sungai Kunyit Hulu
61.02.12.2008|Sungai Limau
61.02.12.2009|Sungai Dungun
61.02.12.2010|Mendalok
61.02.12.2011|Semparong Parit Raden
61.02.12.2012|Semudun
61.02.15.2001|Peniti Besar
61.02.15.2002|Sungai Purun Besar
61.02.15.2003|Parit Bugis
61.02.15.2004|Peniti Dalam I
61.02.15.2005|Peniti Dalam II
61.02.15.2006|Sungai Burung
61.02.16.1001|Anjungan Melancar
61.02.16.2002|Anjungan Dalam
61.02.16.2003|Kepayang
61.02.16.2004|Pak Bulu
61.02.16.2005|Dema
61.02.17.2001|Sekabuk
61.02.17.2002|Pentek
61.02.17.2003|Bum-bun
61.02.17.2004|Amawang
61.02.17.2005|Ansiap
61.02.17.2006|Suak Barangan
61.02.18.1001|Pulau Pedalaman
61.02.18.1002|Pasir Wan Salim
61.02.18.2003|Antibar
61.02.18.2004|Sejegi
61.02.18.2005|Pasir Palembang
61.02.18.2006|Pasir Panjang
61.02.18.2007|Sungai Bakau Kecil
61.02.18.2008|Parit Banjar
61.03.01.1001|Tanjung Kapuas
61.03.01.1002|Tanjung Sekayam
61.03.01.1003|Sungai Sengkuang
61.03.01.1004|Ilir Kota
61.03.01.1005|Beringin
61.03.01.1006|Bunut
61.03.01.2007|Penyeladi
61.03.01.2008|Nanga Biang
61.03.01.2009|Rambin
61.03.01.2010|Entakai
61.03.01.2011|Pana
61.03.01.2012|Mengkiang
61.03.01.2013|Kambong
61.03.01.2014|Sungai Mawang
61.03.01.2015|Lape
61.03.01.2016|Penyalimau
61.03.01.2017|Sungai Alai
61.03.01.2018|Semerangkai
61.03.01.2019|Sungai Batu
61.03.01.2020|Sungai Muntik
61.03.01.2021|Lintang Kapuas
61.03.01.2022|Lintang Pelaman
61.03.01.2023|Belangin
61.03.01.2024|Penyalimau Jaya
61.03.01.2025|Tapang Dulang
61.03.01.2026|Botuh Lintang
61.03.02.2001|Kedukul
61.03.02.2002|Semuntai
61.03.02.2003|Engkode
61.03.02.2004|Sungai Mawang
61.03.02.2005|Inggis
61.03.02.2006|Layak Omang
61.03.02.2007|Semanggis Raya
61.03.02.2008|Tri Mulya
61.03.02.2009|Serambai Jaya
61.03.03.2001|Noyan
61.03.03.2002|Empoto
61.03.03.2003|Semongan
61.03.03.2004|Sungai Dangin
61.03.03.2005|Idas
61.03.04.2001|Balai Sebut
61.03.04.2002|Jangkang Benua
61.03.04.2003|Tanggung
61.03.04.2004|Empiyang
61.03.04.2005|Pisang
61.03.04.2006|Ketori
61.03.04.2007|Semombat
61.03.04.2008|Terati
61.03.04.2009|Sape
61.03.04.2010|Selampung
61.03.04.2011|Semirau
61.03.05.2001|Bonti
61.03.05.2002|Sami
61.03.05.2003|Bahta
61.03.05.2004|Upe
61.03.05.2005|Tunggul Boyok
61.03.05.2006|Empodis
61.03.05.2007|Kampuh
61.03.05.2008|Bantai
61.03.05.2009|Majel
61.03.06.2001|Kasro Mego
61.03.06.2002|Bereng Berkawat
61.03.06.2003|Sungai Ilai
61.03.06.2004|Thang Raya
61.03.06.2005|Mawang Muda
61.03.07.2001|Balai Karangan
61.03.07.2002|Pengadang
61.03.07.2003|Sotok
61.03.07.2004|Kenaman
61.03.07.2005|Raut Muara
61.03.07.2006|Engkahan
61.03.07.2007|Bungkang
61.03.07.2008|Lubuk Sabuk
61.03.07.2009|Sungai Tekam
61.03.07.2010|Malenggang
61.03.08.2001|Tanjung Bunga
61.03.08.2002|Semayang
61.03.08.2003|Sebongkuh
61.03.08.2004|Kuala Dua
61.03.08.2005|Tanjung Merpati
61.03.08.2006|Sejuah
61.03.08.2007|Mobui
61.03.08.2008|Tanap
61.03.08.2009|Sebuduh
61.03.08.2010|Kelompu
61.03.08.2011|Tunggal Bhakti
61.03.09.2001|Pusat Damai
61.03.09.2002|Maju Karya
61.03.09.2003|Sebarra
61.03.09.2004|Pandu Raya
61.03.09.2005|Embala
61.03.09.2006|Hibun
61.03.09.2007|Maringin Jaya
61.03.09.2008|Suka Mulya
61.03.09.2009|Palem Jaya
61.03.09.2010|Rahayu
61.03.09.2011|Dosan
61.03.09.2012|Suka Gerundi
61.03.09.2013|Gunam
61.03.09.2014|Marita
61.03.10.2001|Sosok
61.03.10.2002|Peruan Dalam
61.03.10.2003|Menyabo
61.03.10.2004|Mandong
61.03.10.2005|Janjang
61.03.10.2006|Riyai
61.03.10.2007|Berakak
61.03.10.2008|Engkasan
61.03.10.2009|Pandan Sembuat
61.03.10.2010|Binjai
61.03.10.2011|Kedakas
61.03.11.2001|Pulau Tayan Utara
61.03.11.2002|Kawat
61.03.11.2003|Pedalaman
61.03.11.2004|Balai Ingin
61.03.11.2005|Lalang
61.03.11.2006|Cempedak
61.03.11.2007|Melugai
61.03.11.2008|Emberas
61.03.11.2009|Beginjan
61.03.11.2010|Sejotang
61.03.11.2011|Sebemban
61.03.11.2012|Subah
61.03.11.2013|Sungai Jaman
61.03.11.2014|Tanjung Bunut
61.03.11.2015|Tebang Benua
61.03.12.2001|Hilir
61.03.12.2002|Padi Kaye
61.03.12.2003|Temiang Mali
61.03.12.2004|Cowet
61.03.12.2005|Kebadu
61.03.12.2006|Mak Kawing
61.03.12.2007|Tae
61.03.12.2008|Semoncol
61.03.12.2009|Empirang Ujung
61.03.12.2010|Bulu Bala
61.03.12.2011|Temiang Taba
61.03.12.2012|Senyabang
61.03.13.2001|Teraju
61.03.13.2002|Belungai Dalam
61.03.13.2003|Sansat
61.03.13.2004|Kampung Baru
61.03.13.2005|Bagan Asam
61.03.13.2006|Lumut
61.03.13.2007|Balai Belungai
61.03.20.2001|Meliau Hilir
61.03.20.2002|Meliau Hulu
61.03.20.2003|Kuala Buayan
61.03.20.2004|Meranggau
61.03.20.2005|Melobok
61.03.20.2006|Sungai Mayam
61.03.20.2007|Pampang Dua
61.03.20.2008|Kuala Rosan
61.03.20.2009|Sungai Kembayau
61.03.20.2010|Kunyil
61.03.20.2011|Cupang
61.03.20.2012|Lalang
61.03.20.2013|Baru Lombak
61.03.20.2014|Enggadai
61.03.20.2015|Balai Tinggi
61.03.20.2017|Bhakti Jaya
61.03.20.2018|Mukti Jaya
61.03.20.2019|Melawi Makmur
61.03.20.2020|Harapan Makmur
61.03.21.2001|Nekan
61.03.21.2002|Semanget
61.03.21.2003|Entikong
61.03.21.2004|Pala Pasang
61.03.21.2005|Suruh Tembawang
61.04.01.2011|Sungai Putri
61.04.01.2012|Tanjung Baik Budi
61.04.01.2013|Kuala Tolak
61.04.01.2014|Kuala Satong
61.04.01.2015|Laman Satong
61.04.02.2001|Sukakarya
61.04.02.2002|Randai
61.04.02.2003|Belaban
61.04.02.2004|Runjai Jaya
61.04.02.2008|Karya Baru
61.04.02.2020|Riam Batu Gading
61.04.02.2021|Batu Payung Dua
61.04.02.2022|Bantan Sari
61.04.02.2023|Pelanjau Jaya
61.04.02.2024|Rangkung
61.04.03.2001|Manis Mata
61.04.03.2002|Air Dekakah
61.04.03.2003|Suka Ramai
61.04.03.2004|Suak Burung
61.04.03.2005|Silat
61.04.03.2006|Terusan
61.04.03.2007|Kemuning
61.04.03.2008|Kelampai
61.04.03.2009|Bukit Gajah
61.04.03.2010|Lembah Mukti
61.04.03.2011|Asam Besar
61.04.03.2012|Batu Sedau
61.04.03.2013|Jambi
61.04.03.2014|Seguling
61.04.03.2015|Kalimantan
61.04.03.2016|Pelempangan
61.04.03.2017|Sengkuang Merabong
61.04.03.2018|Pakit Selaba
61.04.03.2019|Sungai Buluh
61.04.03.2020|Ratu Elok
61.04.03.2021|Mekar Jaya
61.04.03.2022|Tribun Jaya
61.04.04.2001|Kendawangan Kiri
61.04.04.2002|Banjar Sari
61.04.04.2003|Kendawangan Kanan
61.04.04.2004|Pangkalan Batu
61.04.04.2005|Bangkal Serai
61.04.04.2006|Air Hitam Besar
61.04.04.2007|Suka Harapan
61.04.04.2008|Suka Damai
61.04.04.2009|Selimantan Jaya
61.04.04.2010|Danau Buntar
61.04.04.2011|Mekar Utama
61.04.04.2012|Pembedilan
61.04.04.2013|Air Hitam Hulu
61.04.04.2014|Natai Kuini
61.04.04.2015|Keramat Jaya
61.04.04.2016|Seriam
61.04.04.2017|Kedondong
61.04.04.2018|Sungai Jelayan
61.04.04.2019|Air Tarap
61.04.05.2001|Sandai
61.04.05.2002|Randau Jungkal
61.04.05.2006|Penjawaan
61.04.05.2007|Muara Jekak
61.04.05.2008|Petai Patah
61.04.05.2010|Randau
61.04.05.2011|Sandai Kiri
61.04.05.2012|Demit
61.04.05.2013|Pendamar Indah
61.04.05.2014|Merimbang Jaya
61.04.05.2015|Alam Pakuan
61.04.05.2016|Jago Bersatu
61.04.05.2017|Istana
61.04.07.2001|Riam Bunut
61.04.07.2002|Sempurna
61.04.07.2003|Bengaras
61.04.07.2004|Sepotong
61.04.07.2005|Sukaramai
61.04.07.2006|Tanjung Beringin
61.04.07.2007|Harapan Baru
61.04.07.2008|Randau Limat
61.04.07.2009|Bayun Sari
61.04.07.2010|Teluk Bayur
61.04.07.2011|Tanjung Maju
61.04.07.2012|Sungai Daka
61.04.07.2013|Mekar Harapan
61.04.07.2014|Sinar Kuri
61.04.07.2015|Selangkut Raya
61.04.07.2016|Lanjut Mekar Sari
61.04.07.2017|Kepari
61.04.07.2018|Teluk Mutiara
61.04.07.2019|Merabu Jaya
61.04.08.2001|Balai Pinang
61.04.08.2002|Semandang Kiri
61.04.08.2003|Kualan Hulu
61.04.08.2005|Semandang Hulu
61.04.08.2006|Merawa
61.04.08.2009|Kualan Tengah
61.04.08.2010|Kualan Hilir
61.04.08.2011|Sekucing Labai
61.04.08.2012|Paoh Concong
61.04.08.2013|Legong
61.04.08.2014|Kenanga
61.04.08.2015|Balai Pinang Hulu
61.04.08.2016|Sekucing Kualan
61.04.08.2017|Labai Hilir
61.04.08.2018|Botuh Bosi
61.04.11.2001|Nanga Tayap
61.04.11.2002|Pangkalan Telok
61.04.11.2003|Pangkalan Suka
61.04.11.2004|Betenung
61.04.11.2005|Batu Mas
61.04.11.2006|Sungai Kelik
61.04.11.2007|Lembah Hijau Satu
61.04.11.2008|Lembah Hijau Dua
61.04.11.2009|Siantau Raya
61.04.11.2010|Sebadak Raya
61.04.11.2011|Simpang Tiga Sembelangaan
61.04.11.2012|Mensubang
61.04.11.2013|Tajok Kayong
61.04.11.2014|Kayong Utara
61.04.11.2015|Kayong Hulu
61.04.11.2016|Sepakat Jaya
61.04.11.2017|Cegolak
61.04.11.2018|Pateh Benteng
61.04.11.2019|Tanjung Medan
61.04.11.2020|Kayung Tuhe
61.04.12.2006|Sungai Jawi
61.04.12.2007|Pesaguan Kiri
61.04.12.2008|Sungai Pelang
61.04.12.2012|Sungai Bakau
61.04.12.2013|Pematang Gadung
61.04.12.2014|Pesaguan Kanan
61.04.12.2015|Sungai Besar
61.04.12.2016|Sungai Nanjung
61.04.12.2017|Kemuning Biutak
61.04.12.2018|Harapan Baru
61.04.12.2019|Pagar Mentimun
61.04.13.2001|Tumbang Titi
61.04.13.2002|Natai Panjang
61.04.13.2003|Serengkah
61.04.13.2004|Mahawa
61.04.13.2005|Nanga Kelampai
61.04.13.2006|Batu Tajam
61.04.13.2009|Kalimas Baru
61.04.13.2013|Pemuatan Jaya
61.04.13.2016|Sengkaharak
61.04.13.2020|Belaban Tujuh
61.04.13.2023|Segar Wangi
61.04.13.2024|Petebang Jaya
61.04.13.2025|Aur Gading
61.04.13.2026|Beringin Rayo
61.04.13.2027|Titi Baru
61.04.13.2028|Tanjung Beulang
61.04.13.2029|Batu Beransak
61.04.13.2030|Serengkah Kanan
61.04.13.2031|Sepauhan Raya
61.04.13.2032|Jungkal
61.04.13.2033|Jelayan
61.04.13.2034|Pengatapan Raya
61.04.13.2035|Suka Damai
61.04.13.2036|Tanjung Maloi
61.04.13.2037|Sepuring Indah
61.04.14.2001|Periangan
61.04.14.2002|Tanggerang
61.04.14.2003|Kesuma Jaya
61.04.14.2004|Penyarang
61.04.14.2005|Biku Sarana
61.04.14.2006|Semantun
61.04.14.2007|Riam Danau Kanan
61.04.14.2008|Limpang
61.04.14.2009|Pasir Mayang
61.04.14.2010|Tebing Berseri
61.04.14.2011|Deranuk
61.04.14.2012|Rangga Intan
61.04.14.2013|Pangkalan Suka
61.04.14.2014|Teluk Runjai
61.04.14.2015|Asam Jelai
61.04.14.2016|Air Dua
61.04.14.2017|Sidahari
61.04.14.2018|Kusik Batu Lapu
61.04.14.2019|Karang Dangin
61.04.14.2020|Perigi
61.04.14.2021|Bayam Raya
61.04.14.2022|Pangkalan Paket
61.04.16.1001|Kantor
61.04.16.1002|Tengah
61.04.16.1003|Mulia Baru
61.04.16.1004|Sampit
61.04.16.1005|Suka Harja
61.04.16.2006|Suka Bangun
61.04.16.2007|Kali Nilam
61.04.16.2008|Paya Kumang
61.04.16.2009|Suka Bangun Dalam
61.04.17.2001|Sungai Awan Kanan
61.04.17.2002|Sungai Awan Kiri
61.04.17.2003|Tempurukan
61.04.17.2004|Ulak Medang
61.04.17.2005|Tanjung Pura
61.04.17.2006|Mayak
61.04.17.2007|Tanjung Pasar
61.04.17.2008|Suka Maju
61.04.18.1001|Kauman
61.04.18.1002|Mulia Kerta
61.04.18.1004|Tuan-Tuan
61.04.18.1009|Banjar
61.04.18.2003|Padang
61.04.18.2005|Sungai Kinjil
61.04.18.2006|Suka Baru
61.04.18.2007|Baru
61.04.18.2008|Negeri Baru
61.04.18.2010|Mekar Sari
61.04.18.2011|Kinjil Pesisir
61.04.19.2001|Menyumbung
61.04.19.2002|Senduruhan
61.04.19.2003|Cinta Manis
61.04.19.2004|Beginci Darat
61.04.19.2005|Benua Krio
61.04.19.2006|Riam Dadap
61.04.19.2007|Sekukun
61.04.19.2008|Batu Lapis
61.04.19.2009|Krio Hulu
61.04.19.2010|Kenyabur
61.04.19.2011|Sunge Bengaras
61.04.19.2012|Lubuk Kakap
61.04.20.2001|Semandang Kanan
61.04.20.2002|Gema
61.04.20.2003|Mekar Raya
61.04.20.2004|Kampar Sebomban
61.04.20.2005|Batu Daya
61.04.20.2006|Kamora
61.04.21.2001|Air Upas
61.04.21.2002|Sari Bekayas
61.04.21.2003|Air Durian Jaya
61.04.21.2004|Harapan Baru
61.04.21.2005|Suka Ria
61.04.21.2006|Banda Sari
61.04.21.2007|Membuluh Baru
61.04.21.2008|Gahang
61.04.21.2009|Mekar Jaya
61.04.22.2001|Suka Mulia
61.04.22.2002|Sukaraja
61.04.22.2003|Bukit Kelambing
61.04.22.2004|Muntai
61.04.22.2005|Suka Sari
61.04.22.2006|Sukaharja
61.04.22.2007|Tanah Hitam
61.04.22.2008|Pantai Ketikal
61.04.24.2001|Pebihingan
61.04.24.2002|Lalang Panjang
61.04.24.2003|Semayok Baru
61.04.24.2004|Muara Gerunggang
61.04.24.2005|Usaha Baru
61.04.24.2006|Kerta Baru
61.04.24.2007|Muara Semayok
61.04.25.2001|Beringin Jaya
61.04.25.2002|Sungai Melayu Baru
61.04.25.2003|Suka Mulya
61.04.25.2004|Karya Mukti
61.04.25.2005|Piansak
61.04.25.2006|Jairan Jaya
61.04.25.2007|Kepuluk
61.04.25.2008|Sungai Melayu Jaya
61.04.25.2009|Sungai Melayu
61.04.25.2010|Mekar Jaya
61.04.25.2011|Makmur Abadi
61.05.01.1001|Ladang
61.05.01.1002|Kapuas Kanan Hulu
61.05.01.1003|Tanjung Puri
61.05.01.1004|Kapuas Kanan Hilir
61.05.01.1005|Kapuas Kiri Hilir
61.05.01.1006|Kapuas Kiri Hulu
61.05.01.1016|Akcaya
61.05.01.1017|Alai
61.05.01.1018|Rawa Mambok
61.05.01.1019|Sengkuang
61.05.01.1020|Mengkurai
61.05.01.1021|Kedabang
61.05.01.1022|Mekar Jaya
61.05.01.1023|Batu Lalau
61.05.01.1024|Menyumbung Tengah
61.05.01.1025|Ulak Jaya
61.05.01.2007|Baning Kota
61.05.01.2008|Tertung
61.05.01.2009|Mungguk Bantok
61.05.01.2010|Teluk Kelansam
61.05.01.2011|Sungai Ana
61.05.01.2012|Merti Guna
61.05.01.2013|Tanjung Kelansam
61.05.01.2014|Anggah Jaya
61.05.01.2015|Lalang Baru
61.05.01.2026|Tebing Raya
61.05.01.2027|Mail Jampong
61.05.01.2028|Jerora Satu
61.05.01.2029|Kebiau Baru
61.05.02.2001|Nanga Tempunak
61.05.02.2002|Mensiap Baru
61.05.02.2003|Tanjung Perada
61.05.02.2004|Suka Jaya
61.05.02.2005|Mangkurat Baru
61.05.02.2006|Paribang Baru
61.05.02.2007|Repak Sari
61.05.02.2008|Pagal Baru
61.05.02.2009|Kenyabur Baru
61.05.02.2010|Benua Baru
61.05.02.2011|Tinum Baru
61.05.02.2012|Pangkal Baru
61.05.02.2013|Pulau Jaya
61.05.02.2014|Kuala Tiga
61.05.02.2015|Gurung Mali
61.05.02.2016|Merti Jaya
61.05.02.2017|Benua Kencana
61.05.02.2018|Balai Harapan
61.05.02.2019|Tempunak Kapuas
61.05.02.2020|Riam Batu
61.05.02.2021|Pudau Bersatu
61.05.02.2022|Kupan Jaya
61.05.02.2023|Sungai Buluh
61.05.02.2024|Jaya Mentari
61.05.02.2025|Pekulai Bersatu
61.05.02.2026|Mensiap Jaya
61.05.03.2001|Nanga Sepauk
61.05.03.2002|Tanjung Ria
61.05.03.2003|Sekubang
61.05.03.2004|Kenyauk
61.05.03.2005|Lengkenat
61.05.03.2006|Manis Raya
61.05.03.2007|Temiang Kapuas
61.05.03.2008|Ensabang
61.05.03.2009|Mait Hilir
61.05.03.2010|Sekujam Timbai
61.05.03.2011|Semuntai
61.05.03.2012|Sirang Setambang
61.05.03.2013|Nanga Libau
61.05.03.2014|Bernayau
61.05.03.2015|Sinar Pekayau
61.05.03.2016|Nanga Pari
61.05.03.2017|Buluh Kuning
61.05.03.2018|Temawang Muntai
61.05.03.2019|Tawang Sari
61.05.03.2020|Gernis Jaya
61.05.03.2021|Paoh Benua
61.05.03.2022|Bedayan
61.05.03.2023|Tanjung Hulu
61.05.03.2024|Sungai Raya
61.05.03.2025|Landau Panjang
61.05.03.2026|Bangun
61.05.03.2027|Sukau Bersatu
61.05.03.2028|Kemantan
61.05.03.2029|Peninsung
61.05.03.2030|Sepulut
61.05.03.2031|Temawang Bulai
61.05.03.2032|Sungai Segak
61.05.03.2033|Tanjung Balai
61.05.03.2034|Sinar Harapan
61.05.03.2035|Riam Kempadik
61.05.03.2036|Nanga Layung
61.05.03.2037|Limau Bakti
61.05.03.2038|Tanjung Mawang
61.05.03.2040|Sungai Jaung
61.05.04.2001|Nanga Ketungau
61.05.04.2002|Setungkup
61.05.04.2004|Sungai Mali
61.05.04.2005|Air Nyuruk
61.05.04.2006|Nanga Merkak
61.05.04.2007|Sungai Deras
61.05.04.2008|Nanga Sejirak
61.05.04.2009|Semuntai
61.05.04.2010|Senibung
61.05.04.2011|Tanjung Baung
61.05.04.2012|Baung Sengatap
61.05.04.2013|Semajau Mekar
61.05.04.2014|Beluh Mulyo
61.05.04.2015|Batu Ampar
61.05.04.2016|Bukit Sidin Permai
61.05.04.2017|Betung Permai
61.05.04.2018|Kenuak
61.05.04.2019|Jentawang Hilir
61.05.04.2020|Batu Nyadi
61.05.04.2021|Ratu Damai
61.05.04.2022|Lepung Pantak
61.05.04.2023|Pampang Dua
61.05.04.2024|Mungguk Kelapa
61.05.04.2025|Maung
61.05.05.2001|Wirayuda
61.05.05.2002|Tanjung Sari
61.05.05.2003|Panding Jaya
61.05.05.2004|Tirta Karya
61.05.05.2005|Begelang Jaya
61.05.05.2006|Sumber Sari
61.05.05.2007|Panggi Agung
61.05.05.2008|Kerta Sari
61.05.05.2009|Argo Mulyo
61.05.05.2010|Wana Bhakti
61.05.05.2011|Swadaya
61.05.05.2012|Margahayu
61.05.05.2013|Gut Jaya Bhakti
61.05.05.2014|Landau Buaya
61.05.05.2015|Kayu Dujung
61.05.05.2016|Senangan Kecil
61.05.05.2017|Sungai Areh
61.05.05.2018|Mungguk Gelombang
61.05.05.2019|Mungguk Lawang
61.05.05.2020|Nanga Kelapan
61.05.05.2021|Panggi Ruguk
61.05.05.2022|Bakti Senabung
61.05.05.2023|Engkitan
61.05.05.2024|Landau Temiang
61.05.05.2025|Padung Kumang
61.05.05.2026|Radin Jaya
61.05.05.2027|Senangan Jaya
61.05.05.2028|Kubu Berangan
61.05.05.2029|Semareh
61.05.06.2001|Senaning
61.05.06.2002|Empura
61.05.06.2003|Sebadak
61.05.06.2004|Sepiluk
61.05.06.2005|Sungai Seria
61.05.06.2006|Suak Medang
61.05.06.2007|Nanga Bayan
61.05.06.2008|Rasau
61.05.06.2009|Jasa
61.05.06.2010|Sungai Bugau
61.05.06.2011|Nanga Bugau
61.05.06.2012|Empunak Tapang Keladan
61.05.06.2013|Sebetung Paluk
61.05.06.2014|Muakan Petinggi
61.05.06.2015|Nanga Sebawang
61.05.06.2016|Sekaih
61.05.06.2017|Bekuan Luyang
61.05.06.2018|Sungai Pisau
61.05.06.2019|Mungguk Entawak
61.05.06.2020|Embaleh
61.05.06.2021|Sebuluh
61.05.06.2022|Riam Sejawak
61.05.06.2023|Engkeruh
61.05.06.2024|Sungai Kelik
61.05.06.2025|Idai
61.05.06.2026|Sungai Mawang
61.05.06.2027|Ujung Kempas
61.05.06.2028|Neraci Jaya
61.05.06.2029|Sejawak
61.05.07.2001|Nanga Jetak
61.05.07.2002|Nanga Dedai
61.05.07.2003|Gandis
61.05.07.2004|Sungai Mali
61.05.07.2005|Riguk
61.05.07.2006|Pengkadan Baru
61.05.07.2007|Tauk
61.05.07.2008|Empaci
61.05.07.2009|Baras
61.05.07.2010|Pengkadan Sungai Rupa
61.05.07.2011|Kumpang
61.05.07.2012|Mangat Baru
61.05.07.2013|Menaong Baru
61.05.07.2014|Emparu Baru
61.05.07.2015|Lundang Baru
61.05.07.2016|Penyak Lalang
61.05.07.2017|Umin Jaya
61.05.07.2018|Merempit Baru
61.05.07.2019|Dedai Kanan
61.05.07.2020|Sungai Tapang
61.05.07.2021|Gandis Hulu
61.05.07.2022|Hulu Dedai
61.05.07.2023|Apin Baru
61.05.07.2024|Jangkang
61.05.07.2025|Belinyuk Sibau
61.05.07.2026|Mengkirai Jaya
61.05.07.2027|Terusan
61.05.07.2028|Tanjung
61.05.07.2029|Batu Landung
61.05.07.2030|Samak
61.05.07.2031|Manyam
61.05.08.2001|Nanga Mau
61.05.08.2002|Jambu
61.05.08.2003|Tertung Mau
61.05.08.2004|Mentunai
61.05.08.2005|Tuguk
61.05.08.2006|Natai Tebedak
61.05.08.2007|Nyangkom
61.05.08.2008|Melingkat
61.05.08.2009|Nanga Tikan
61.05.08.2010|Pelaik
61.05.08.2011|Kerapa Sepan
61.05.08.2012|Sungai Buaya
61.05.08.2013|Pakak
61.05.08.2014|Sungai Sintang
61.05.08.2015|Sungai Garong
61.05.08.2016|Paoh Desa
61.05.08.2017|Jaya Sakti
61.05.08.2018|Mekar Mandiri
61.05.08.2019|Landau Beringin
61.05.08.2020|Karya Baru
61.05.08.2021|Bukit Segaloh
61.05.08.2022|Engkerangan
61.05.08.2023|Lalang Inggar
61.05.08.2024|Linggam Permai
61.05.08.2025|Sungai Menuang
61.05.08.2026|Natai Lesung
61.05.08.2027|Begendang Mal
61.05.08.2028|Sungai Ranap
61.05.08.2029|Lengkong Bindu
61.05.08.2030|Nanga Lidau
61.05.08.2031|Mengkirai
61.05.08.2032|Tanjung Keliling
61.05.08.2033|Buluk Jegara
61.05.08.2034|Buluk Panjang
61.05.08.2035|Tanjung Putar
61.05.08.2036|Sungai Emang
61.05.08.2037|Sungai Meraya
61.05.08.2038|Kempas Raya
61.05.08.2039|Ipoh Emang
61.05.08.2040|Sungai Pengga
61.05.08.2041|Batu Netak
61.05.08.2042|Neran Baya
61.05.08.2043|Monbai Begununk
61.05.09.2001|Nanga Tebidah
61.05.09.2002|Nanga Payak
61.05.09.2003|Tanjung Bunga
61.05.09.2004|Nanga Toran
61.05.09.2005|Riam Panjang
61.05.09.2006|Entogong
61.05.09.2007|Nanga Tonggoi
61.05.09.2008|Tanjung Lalau
61.05.09.2009|Lintang Tambuk
61.05.09.2010|Nanga Masau
61.05.09.2011|Nanga Ungai
61.05.09.2012|Nanga Abai
61.05.09.2013|Nanga Laar
61.05.09.2014|Riam Muntik
61.05.09.2015|Nanga Oran
61.05.09.2016|Tonak Goneh
61.05.09.2017|Nangkak Lestari
61.05.09.2018|Topan Nanga
61.05.09.2019|Mapan Jaya
61.05.09.2020|Tanjung Miru
61.05.09.2021|Buluh Merindu
61.05.09.2022|Empakan
61.05.09.2023|Emponyang
61.05.09.2024|Merahau Permai
61.05.09.2025|Tanah Merah
61.05.09.2026|Landau Bara
61.05.09.2027|Kerapuk Jaya
61.05.09.2028|Merah Arai
61.05.09.2029|Tapang Manua
61.05.09.2030|Nanga Tampang
61.05.09.2031|Kebarau
61.05.14.2001|Nanga Serawai
61.05.14.2002|Nanga Mentatai
61.05.14.2003|Bedaha
61.05.14.2004|Begori
61.05.14.2005|Pagar Lebata
61.05.14.2006|Tontang
61.05.14.2007|Karya Jaya
61.05.14.2008|Nanga Riyoi
61.05.14.2009|Buntut Ponte
61.05.14.2010|Nanga Segulang
61.05.14.2011|Baras Nabun
61.05.14.2012|Nanga Jelundung
61.05.14.2013|Tanjung Raya
61.05.14.2014|Tahai Permai
61.05.14.2015|Merako Jaya
61.05.14.2016|Sawang Senghiang
61.05.14.2017|Tunas Harapan
61.05.14.2018|Teluk Harapan
61.05.14.2019|Gurung Senghiang
61.05.14.2020|Tanjung Harapan
61.05.14.2021|Rantau Malam
61.05.14.2022|Mentajoi
61.05.14.2023|Nanga Bihe
61.05.14.2024|Nanga Tekungai
61.05.14.2025|Talian Sahabung
61.05.14.2026|Batu Ketebung
61.05.14.2027|Muara Kota
61.05.14.2028|Mekar Sari
61.05.14.2029|Tanjung Baru
61.05.14.2030|Nusa Tujuh
61.05.14.2031|Nanga Ruhan
61.05.14.2032|Meroboi
61.05.14.2033|Panekasan
61.05.14.2034|Tamakung
61.05.14.2035|Limbur Bernaung Lestari
61.05.14.2036|Mensulung Bio
61.05.14.2037|Sabhang Landan
61.05.14.2038|Nanga Tangoi
61.05.15.2001|Nanga Kemangai
61.05.15.2002|Nanga Ambalau
61.05.15.2003|Nanga Kesange
61.05.15.2004|Nanga Menakon
61.05.15.2005|Nanga Sake
61.05.15.2006|Buntut Pimpin
61.05.15.2007|Kepala Jungai
61.05.15.2008|Tanjung Andan
61.05.15.2009|Buntut Sabon
61.05.15.2010|Nanga Keremoi
61.05.15.2011|Nanga Menantak
61.05.15.2012|Buntut Purun
61.05.15.2013|Nanga Sakai
61.05.15.2014|Nanga Mentomoi
61.05.15.2015|Sungai Tambun
61.05.15.2016|Riam Sabon
61.05.15.2017|Nanga Ukai
61.05.15.2018|Mensuang
61.05.15.2019|Dahtah Bungai
61.05.15.2020|Lunjan Tingang
61.05.15.2021|Bukit Tinggi
61.05.15.2022|Bukai Tukun
61.05.15.2023|Nusa Koring
61.05.15.2024|Purut Beribit
61.05.15.2025|Pulou Sabhang
61.05.15.2026|Patih Jepara
61.05.15.2027|Korong Daso
61.05.15.2028|Luting Mingan
61.05.15.2029|Kolangan Juoi
61.05.15.2030|Nanga Rade
61.05.15.2031|Jengkarang
61.05.15.2032|Deme
61.05.15.2033|Nanga Pahangan
61.05.19.2001|Nanga Lebang
61.05.19.2002|Merpak
61.05.19.2003|Kebong
61.05.19.2004|Baning Panjang
61.05.19.2005|Ensaid Panjang
61.05.19.2006|Bengkuang
61.05.19.2007|Pelimping
61.05.19.2008|Sungai Pukat
61.05.19.2009|Sungai Maram
61.05.19.2010|Sepan Lebang
61.05.19.2011|Gemba Raya
61.05.19.2012|Karya Jaya Bhakti
61.05.19.2013|Mandiri Jaya
61.05.19.2014|Landau Kodam
61.05.19.2015|Sungai Labi
61.05.19.2016|Sungai Lais
61.05.19.2017|Kelam Sejahtera
61.05.20.2001|Ransi Dakan
61.05.20.2002|Sungai Ukoi
61.05.20.2003|Manter
61.05.20.2004|Merarai Satu
61.05.20.2005|Merarai Dua
61.05.20.2006|Kajang Baru
61.05.20.2007|Gurung Kempadik
61.05.20.2008|Nobal
61.05.20.2009|Baya Betung
61.05.20.2010|Bonet Engkabang
61.05.20.2011|Bonet Lama
61.05.20.2012|Bancoh
61.05.20.2013|Perembang
61.05.20.2014|Solam Raya
61.05.20.2015|Lebak Ubah
61.05.20.2016|Melayang Sari
61.05.20.2017|Sarai
61.05.20.2018|Rarai
61.05.20.2019|Penjernang
61.05.20.2020|Penjernang Hulu
61.05.20.2021|Riam Kijang
61.05.20.2022|Baya Mulya
61.05.20.2023|Laman Raya
61.05.20.2024|Sabang Surai
61.05.20.2025|Balai Agung
61.05.20.2026|Kunyai
61.05.21.2001|Ampar Bedang
61.05.21.2002|Telaga Satu
61.05.21.2003|Telaga Dua
61.05.21.2004|Binjai Hilir
61.05.21.2005|Binjai Hulu
61.05.21.2006|Sungai Risap
61.05.21.2007|Dak Jaya
61.05.21.2008|Mensiku
61.05.21.2009|Empaka Kabiau Raya
61.05.21.2010|Sungai Risap Mensiku Bersatu
61.05.21.2011|Simba Raya
61.06.01.1001|Putussibau Kota
61.06.01.1002|Hilir Kantor
61.06.01.2004|Pala Pulau
61.06.01.2005|Sibau Hilir
61.06.01.2006|Padua Mendalam
61.06.01.2007|Datah Dian
61.06.01.2008|Sibau Hulu
61.06.01.2009|Nanga Nyabau
61.06.01.2010|Nanga Awin
61.06.01.2011|Ariung Mendalam
61.06.01.2012|Nanga Sambus
61.06.01.2013|Banua Tanga
61.06.01.2014|Tanjung Beruang
61.06.01.2015|Tanjung Karang
61.06.01.2016|Seluan
61.06.01.2017|Sungai Uluk Palin
61.06.01.2018|Tanjung Lasa
61.06.01.2019|Lauk
61.06.01.2020|Jangkang
61.06.02.2001|Teluk Sindur
61.06.02.2002|Bika
61.06.02.2003|Jelemuk
61.06.02.2008|Bika Hulu
61.06.02.2009|Nanga Manday
61.06.02.2010|Melapi Manday
61.06.02.2011|Penyeluang
61.06.02.2012|Jongkong Manday
61.06.03.2001|Nanga Embaloh
61.06.03.2002|Keliling Semulung
61.06.03.2006|Lawik
61.06.03.2007|Nanga Lauk
61.06.03.2008|Nanga Palin
61.06.03.2009|Kirin Nangka
61.06.03.2010|Pala Pintas
61.06.03.2011|Ujung Bayur
61.06.03.2012|Belatung
61.06.04.2001|Banua Martinus
61.06.04.2002|Menua Sadap
61.06.04.2003|Pulau Manak
61.06.04.2004|Banua Ujung
61.06.04.2005|Saujung Giling Manik
61.06.04.2006|Ulak Pauk
61.06.04.2007|Langan Baru
61.06.04.2008|Batu Lintang
61.06.04.2009|Rantau Prapat
61.06.04.2010|Tamao
61.06.05.2001|Bunut Hilir
61.06.05.2002|Bunut Hulu
61.06.05.2003|Teluk Aur
61.06.05.2004|Nanga Tuan
61.06.05.2006|Ujung Pandang
61.06.05.2007|Empangau
61.06.05.2008|Tembang
61.06.05.2009|Bunut Tengah
61.06.05.2010|Entibab
61.06.05.2011|Kapuas Raya
61.06.05.2012|Empangau Hilir
61.06.06.2001|Nanga Suruk
61.06.06.2002|Temuyuk
61.06.06.2003|Nanga Semangut
61.06.06.2004|Nanga Dua
61.06.06.2005|Selaup
61.06.06.2006|Riam Piyang
61.06.06.2007|Nanga Payang
61.06.06.2008|Batu Tiga
61.06.06.2009|Semangut Utara
61.06.06.2010|Segitak
61.06.06.2011|Nanga Kelibang
61.06.06.2012|Sungai Besar
61.06.06.2013|Bakong Permai
61.06.06.2014|Beringin
61.06.06.2015|Pantas Bersatu
61.06.07.2001|Jongkong Kiri Hilir
61.06.07.2002|Jongkong Kanan
61.06.07.2003|Jongkong Kiri Hulu
61.06.07.2004|Jongkong Pasar
61.06.07.2005|Ujung Said
61.06.07.2006|Temenang
61.06.07.2007|Ujung Jambu
61.06.07.2008|Bontai
61.06.07.2009|Jongkong Kiri Tengah
61.06.07.2010|Jongkong Tanjung
61.06.07.2011|Kandung Suli
61.06.07.2012|Penepian Raya
61.06.07.2013|Karya baru
61.06.07.2014|Nanga Serian
61.06.08.2001|Nanga Tepuai
61.06.08.2002|Landau Kumpang
61.06.08.2003|Nanga Yen
61.06.08.2004|Lubuk Antuk
61.06.08.2005|Parang
61.06.08.2006|Kelakar
61.06.08.2007|Bugang
61.06.08.2008|Mentawit
61.06.08.2009|Tani Makmur
61.06.08.2010|Simpang Senara
61.06.08.2011|Beringin
61.06.08.2012|Sejahtera Mandiri
61.06.08.2013|Mubung
61.06.08.2014|Tunas Muda
61.06.08.2015|Karya Mandiri
61.06.09.2001|Gudang Hulu
61.06.09.2002|Gudang Hilir
61.06.09.2003|Dalam
61.06.09.2004|Nibung
61.06.09.2005|Piasak Hilir
61.06.09.2006|Engkerengas
61.06.09.2007|Gerayau
61.06.09.2008|Benuis
61.06.09.2012|Titian Kuala
61.06.09.2013|Sekubah
61.06.09.2014|Piasak Hulu
61.06.09.2015|Sekulat
61.06.09.2016|Nanga Leboyan
61.06.09.2017|Vega
61.06.09.2018|Mawan
61.06.09.2019|Semalah
61.06.09.2020|Tempurau
61.06.10.2001|Semitau Hulu
61.06.10.2002|Kenerak
61.06.10.2003|Nanga Seberuang
61.06.10.2004|Entipan
61.06.10.2005|Kenepai Komplek
61.06.10.2006|Semitau Hilir
61.06.10.2007|Nanga Kenepai
61.06.10.2008|Tua' Abang
61.06.10.2009|Nanga Lemedak
61.06.10.2010|Marsedan Raya
61.06.10.2011|Padung Kumang
61.06.10.2012|Sekedau
61.06.11.2001|Sejiram
61.06.11.2002|Beluis Harum
61.06.11.2003|Gurung
61.06.11.2004|Bati
61.06.11.2005|Seneban
61.06.11.2006|Belikai
61.06.11.2007|Ranyai
61.06.11.2008|Emperiang
61.06.11.2009|Pala Kota
61.06.11.2010|Nanga Lot
61.06.11.2011|Tanjung Keliling
61.06.11.2012|Tajau Mada
61.06.11.2013|Jerenjang
61.06.11.2014|Bekuan
61.06.11.2015|Nanga Pala
61.06.12.2001|Setulang
61.06.12.2002|Sepandan
61.06.12.2003|Sungai Ajung
61.06.12.2004|Sungai Abau
61.06.12.2005|Labian
61.06.12.2006|Mensiau
61.06.12.2007|Melemba
61.06.12.2008|Lanjak Deras
61.06.12.2009|Sungai Senunuk
61.06.12.2010|Labian Ira'ang
61.06.13.2001|Keling Panggau
61.06.13.2002|Nanga Kantuk
61.06.13.2003|Tintin Peninjau
61.06.13.2004|Bajau Andai
61.06.13.2005|Kumang Jaya
61.06.13.2006|Laja Sandang
61.06.14.2001|Badau
61.06.14.2002|Janting
61.06.14.2003|Semuntik
61.06.14.2004|Kekurak
61.06.14.2005|Pulau Majang
61.06.14.2006|Seriang
61.06.14.2007|Sebindang
61.06.14.2008|Tinting Seligi
61.06.14.2009|Tajum
61.06.15.2001|Perigi
61.06.15.2002|Baru
61.06.15.2003|Pangeran
61.06.15.2004|Miau Merah
61.06.15.2005|Setunggul
61.06.15.2006|Sungai Sena
61.06.15.2007|Penai
61.06.15.2008|Nanga Nuar
61.06.15.2009|Bongkong
61.06.15.2010|Seberu
61.06.15.2011|Sentabai
61.06.15.2012|Rumbih
61.06.15.2013|Bukit Penai
61.06.16.2001|Nanga Dangkan
61.06.16.2002|Belimbing
61.06.16.2003|Nanga Ngeri
61.06.16.2004|Landau Badai
61.06.16.2005|Nanga Lungu
61.06.16.2006|Nanga Luan
61.06.16.2007|Riam Tapang
61.06.16.2008|Lebak Najah
61.06.16.2009|Dangkan Kota
61.06.16.2010|Perjuk
61.06.16.2011|Landau Rantau
61.06.16.2012|Entebi
61.06.16.2013|Selangkai
61.06.16.2014|Selimu
61.06.17.1001|Kedamin Hulu
61.06.17.1002|Kedamin Hilir
61.06.17.2003|Sungai Uluk
61.06.17.2004|Jaras
61.06.17.2005|Melapi
61.06.17.2014|Kedamin Darat
61.06.17.2015|Tanjung Jati
61.06.17.2016|Sayut
61.06.17.2017|Urang Unsa
61.06.17.2018|Suka Maju
61.06.17.2019|Cempaka Baru
61.06.17.2020|Beringin Jaya
61.06.17.2021|Bungan Jaya
61.06.17.2022|Tanjunglokang
61.06.17.2023|Kereho
61.06.17.2024|Ingko' Tambe
61.06.18.2001|Nanga Sebintang
61.06.18.2002|Nanga Lebangan
61.06.18.2003|Nanga Kalis
61.06.18.2004|Nanga Raun
61.06.18.2005|Bahenap
61.06.18.2006|Nanga Tubuk
61.06.18.2007|Nanga Danau
61.06.18.2008|Kensuray
61.06.18.2009|Rantau Kalis
61.06.18.2010|Kalis Raya
61.06.18.2011|Tekudak
61.06.18.2012|Semerantau
61.06.18.2013|Tapang Da'an
61.06.18.2014|Segiam
61.06.18.2016|Ribang Kadeng
61.06.18.2017|Rantau Bumbun
61.06.18.2018|Peniung
61.06.19.2001|Nanga Danau
61.06.19.2002|Boyan Tanjung
61.06.19.2003|Riam Mengelai
61.06.19.2004|Nanga Sangan
61.06.19.2005|Sri Wangi
61.06.19.2006|Nanga Boyan
61.06.19.2007|Nanga Betung
61.06.19.2008|Mujan
61.06.19.2009|Nanga Jemah
61.06.19.2010|Tubang Jaya
61.06.19.2011|Karya Maju
61.06.19.2012|Landau Mentail
61.06.19.2013|Delintas Karya
61.06.19.2014|Teluk Geruguk
61.06.19.2015|Nanga Ret
61.06.19.2016|Pemawan
61.06.20.2001|Nanga Mentebah
61.06.20.2002|Tekalong
61.06.20.2003|Suka Maju
61.06.20.2004|Kepala Gurung
61.06.20.2005|Tanjung
61.06.20.2006|Tanjung Intan
61.06.20.2007|Tangai Jaya
61.06.20.2008|Menaren
61.06.21.2001|Kerangan Panjang
61.06.21.2002|Mawan
61.06.21.2003|Marta Dana
61.06.21.2004|Buak Limbang
61.06.21.2005|Riam Panjang
61.06.21.2006|Permata
61.06.21.2007|Hulu Pengkadan
61.06.21.2008|Pinang Laka
61.06.21.2009|Sasan
61.06.21.2010|Pengkadan Hilir
61.06.21.2011|Sira Jaya
61.06.22.2001|Mensusai
61.06.22.2003|Kerengas
61.06.22.2004|Mantan
61.06.22.2005|Nanga Suhaid
61.06.22.2006|Tanjung
61.06.22.2007|Madang Permai
61.06.22.2008|Laut Tawang
61.06.22.2009|Jongkong Hulu
61.06.22.2010|Menapar
61.06.22.2011|Lubuk Pengail
61.06.22.2012|Tanjung Harapan
61.06.23.2001|Sungai Antu
61.06.23.2002|Merakai Panjang
61.06.23.2003|Kantuk Asam
61.06.23.2004|Kantuk Bunut
61.06.23.2005|Sungai Mawang
61.06.23.2006|Langau
61.07.01.2001|Sungai Duri
61.07.01.2004|Sungai Jaga A
61.07.01.2005|Sungai Jaga B
61.07.01.2006|Sungai Pangkalan I
61.07.01.2007|Sungai Pangkalan II
61.07.02.2001|Samalantan
61.07.02.2002|Saba'u
61.07.02.2003|Tumiang
61.07.02.2004|Babane
61.07.02.2005|Pasti Jaya
61.07.02.2006|Bukit Serayan
61.07.02.2007|Marunsu
61.07.03.2001|Lesabela
61.07.03.2002|Semangat
61.07.03.2003|Serangkat
61.07.03.2004|Rodaya
61.07.03.2005|Dayung
61.07.03.2007|Jesape
61.07.03.2011|Lomba Karya
61.07.03.2012|Sidai
61.07.03.2013|Seles
61.07.03.2018|Tebuah Marong
61.07.03.2019|Suka Damai
61.07.03.2021|Suka Jaya
61.07.04.1001|Bumi Emas
61.07.04.1010|Sebalo
61.07.04.2003|Tirta Kencana
61.07.04.2004|Bhakti Mulya
61.07.04.2006|Bani Amas
61.07.04.2009|Setia Budi
61.07.05.2001|Seluas
61.07.05.2002|Bengkawan
61.07.05.2003|Sahan
61.07.05.2004|Mayak
61.07.05.2005|Kalon
61.07.05.2006|Sentangau Jaya
61.07.06.2001|Lembang
61.07.06.2002|Gua
61.07.06.2003|Bange
61.07.06.2004|Danti
61.07.06.2005|Sango
61.07.07.2001|Jagoi
61.07.07.2002|Kumba
61.07.07.2006|Sekida
61.07.07.2007|Gersik
61.07.07.2008|Semunying Jaya
61.07.07.2009|Sinar Baru
61.07.08.2002|Gerantung
61.07.08.2003|Monterado
61.07.08.2004|Goa Boma
61.07.08.2006|Nek Ginap
61.07.08.2007|Beringin Baru
61.07.08.2008|Sendoreng
61.07.08.2009|Rantau
61.07.08.2010|Mekar Baru
61.07.08.2011|Jahandung
61.07.08.2012|Serindu
61.07.08.2013|Siaga
61.07.09.2001|Dharma Bhakti
61.07.09.2002|Sumber Karya
61.07.09.2003|Setia Jaya
61.07.09.2004|Bangun Sari
61.07.09.2005|Sebetung Menyala
61.07.09.2006|Malo Jelayan
61.07.09.2007|Ampar Benteng
61.07.09.2008|Tanjung
61.07.09.2009|Telidik
61.07.09.2010|Puteng
61.07.09.2011|Sekaruh
61.07.09.2012|Tubajur
61.07.09.2013|Lulang
61.07.09.2014|Benteng
61.07.09.2015|Sebente
61.07.09.2016|Teriak
61.07.09.2017|Temia Sio
61.07.09.2018|Bana
61.07.10.2001|Nangka
61.07.10.2002|Muhi Bersatu
61.07.10.2003|Suka Maju
61.07.10.2004|Cempaka Putih
61.07.10.2005|Kiung
61.07.10.2006|Kelayuk
61.07.10.2007|Suti Semarang
61.07.10.2008|Tapen
61.07.11.2001|Capkala
61.07.11.2002|Mandor
61.07.11.2003|Setanduk
61.07.11.2004|Aris
61.07.11.2005|Sebandut
61.07.11.2006|Pawangi
61.07.12.2002|Sungkung I
61.07.12.2004|Siding
61.07.12.2005|Hli Buei
61.07.12.2006|Tangguh
61.07.12.2007|Sungkung II
61.07.12.2008|Sungkung III
61.07.12.2009|Tamong
61.07.12.2010|Tawang
61.07.13.2001|Magmagan Karya
61.07.13.2002|Tiga Berkat
61.07.13.2003|Seren Selimbau
61.07.13.2004|Belimbing
61.07.13.2005|Lamolda
61.07.14.2001|Cipta Karya
61.07.14.2002|Suka Bangun
61.07.14.2003|Karya Bhakti
61.07.14.2004|Suka Maju
61.07.15.2001|Rukma Jaya
61.07.15.2002|Sungai Keran
61.07.15.2003|Sungai Raya
61.07.15.2004|Karimunting
61.07.15.2005|Pulau Lemukutan
61.07.16.2001|Saka Taru
61.07.16.2002|Lembah Bawang
61.07.16.2003|Janyat
61.07.16.2004|Tempapan
61.07.16.2005|Papan Uduk
61.07.16.2006|Papan Tembawang
61.07.16.2007|Godang Damar
61.07.16.2008|Kinande
61.07.17.2001|Sinar Tebudak
61.07.17.2002|Kamuh
61.07.17.2003|Bengkilu
61.07.17.2004|Pisak
61.08.01.2001|Hilir Kantor
61.08.01.2002|Hilir Tengah
61.08.01.2003|Raja
61.08.01.2004|Mungguk
61.08.01.2005|Amboyo Utara
61.08.01.2006|Sungai Keli
61.08.01.2007|Rasan
61.08.01.2008|Mu'un
61.08.01.2009|Ambarang
61.08.01.2010|Engkadu
61.08.01.2011|Amang
61.08.01.2012|Penyaho Dangku
61.08.01.2013|Antan Rayan
61.08.01.2014|Amboyo Inti
61.08.01.2015|Tebedak
61.08.01.2016|Temiang Sawi
61.08.01.2017|Amboyo Selatan
61.08.01.2018|Sebirang
61.08.01.2019|Pak Mayam
61.08.02.2001|Karangan
61.08.02.2002|Sailo
61.08.02.2003|Mentonyek
61.08.02.2004|Sampuro
61.08.02.2005|Sala'as
61.08.02.2006|Sabaka
61.08.02.2007|Tunang
61.08.02.2009|Sungai Laki
61.08.02.2014|Tiang Tanjung
61.08.02.2017|Pahokng
61.08.02.2018|Garu
61.08.02.2019|Bilayuk
61.08.02.2020|Caokng
61.08.02.2021|Salumang
61.08.02.2022|Ansolok
61.08.02.2023|Babatn
61.08.02.2024|Parigi
61.08.03.2001|Sepahat
61.08.03.2002|Lamoanak
61.08.03.2003|Bengkawe
61.08.03.2004|Tempoak
61.08.03.2005|Re'es
61.08.03.2006|Raba
61.08.03.2007|Nangka
61.08.03.2008|Menjalin
61.08.04.2001|Sebadu
61.08.04.2002|Semenok
61.08.04.2003|Mengkunyit
61.08.04.2004|Bebatung
61.08.04.2005|Kerohok
61.08.04.2006|Sumsum
61.08.04.2007|Sekilap
61.08.04.2008|Manggang
61.08.04.2009|Keramas
61.08.04.2010|Pongok
61.08.04.2011|Kayu Ara
61.08.04.2012|Selutung
61.08.04.2013|Mandor
61.08.04.2014|Simpang Kasturi
61.08.04.2015|Salatiga
61.08.04.2016|Kayu Tanam
61.08.04.2017|Ngarak
61.08.05.2001|Serimbu
61.08.05.2002|Engkangin
61.08.05.2003|Jambu Tembawang
61.08.05.2004|Sepangah
61.08.05.2005|Merayuh
61.08.05.2006|Nyari
61.08.05.2007|Sekendal
61.08.05.2008|Semuntik
61.08.05.2009|Temoyok
61.08.05.2010|Engkadik Pade
61.08.05.2011|Dange Aji
61.08.05.2012|Tenguwe
61.08.05.2013|Parek
61.08.05.2014|Bentiang Madomang
61.08.05.2015|Tengon
61.08.05.2016|Sempatung Lawek
61.08.06.2001|Darit
61.08.06.2002|Mamek
61.08.06.2003|Ansang
61.08.06.2004|Kayu Ara
61.08.06.2005|Angkaras
61.08.06.2006|Ladangan
61.08.06.2009|Songga
61.08.06.2010|Sidan
61.08.06.2011|Berinang Mayun
61.08.06.2013|Lintah Betung
61.08.06.2014|Anik Dingir
61.08.06.2015|Bagak
61.08.06.2016|Tolok
61.08.06.2017|Sungai Lubang
61.08.06.2018|Ta'as
61.08.06.2019|Ongkol Padang
61.08.07.2001|Pahauman
61.08.07.2002|Paloan
61.08.07.2003|Sebatih
61.08.07.2004|Saham
61.08.07.2005|Andeng
61.08.07.2006|Senakin
61.08.07.2007|Tonang
61.08.07.2008|Banying
61.08.07.2009|Sidas
61.08.07.2010|Keranji Mancal
61.08.07.2011|Keranji Paidang
61.08.07.2012|Aur Sampuk
61.08.07.2013|Gombang
61.08.07.2014|Rabak
61.08.08.2001|Meranti
61.08.08.2002|Kelampai Setolo
61.08.08.2003|Moro Betung
61.08.08.2004|Selange
61.08.08.2005|Ampadi
61.08.08.2006|Tahu
61.08.09.2001|Semedang
61.08.09.2002|Kuala Behe
61.08.09.2003|Nyayum
61.08.09.2004|Paku Raya
61.08.09.2005|Permiit
61.08.09.2006|Tanjung Balai
61.08.09.2007|Angkanyar
61.08.09.2008|Kedama
61.08.09.2009|Bengawan Ampar
61.08.09.2010|Sehe Lusur
61.08.09.2011|Sejowet
61.08.10.2001|Sebangki
61.08.10.2002|Kumpang Tengah
61.08.10.2003|Agak
61.08.10.2004|Rantau Panjang
61.08.10.2005|Sungai Segak
61.08.11.2001|Temahar
61.08.11.2002|Kersik Belantian
61.08.11.2003|Nyi'in
61.08.11.2004|Papung
61.08.11.2005|Sekais
61.08.11.2006|Mandor Kiru
61.08.11.2007|Jelimpo
61.08.11.2008|Tubang Raeng
61.08.11.2009|Kayu Ara
61.08.11.2010|Pawis Hilir
61.08.11.2011|Angan Tembawang
61.08.11.2012|Balai Peluntan
61.08.11.2013|Dara Itam I
61.08.12.2001|Padang Pio
61.08.12.2002|Tembawang Bale
61.08.12.2003|Kampet
61.08.12.2004|Untang
61.08.12.2005|Ringo Lojok
61.08.12.2006|Gamang
61.08.12.2007|Semade
61.08.13.2001|Sompak
61.08.13.2002|Pauh
61.08.13.2003|Lingkonong
61.08.13.2004|Galar
61.08.13.2005|Amawakng
61.08.13.2006|Tapakng
61.08.13.2007|Pakumbang
61.09.01.2001|Sungai Ringin
61.09.01.2002|Mungguk
61.09.01.2003|Tanjung
61.09.01.2004|Merapi
61.09.01.2005|Seraras
61.09.01.2006|Semabi
61.09.01.2007|Seberang Kapuas
61.09.01.2008|Landau Kodah
61.09.01.2009|Timpuk
61.09.01.2010|Sungai Kunyit
61.09.01.2011|Peniti
61.09.01.2012|Gonis Tekam
61.09.01.2013|Tapang Semadak
61.09.01.2014|Engkersik
61.09.01.2015|Ensalang
61.09.01.2016|Bokak Sebumbun
61.09.01.2017|Selalong
61.09.01.2018|Sempulau Indah
61.09.01.2019|Tigur Jaya
61.09.01.2020|Beringkai Raya
61.09.02.2001|Rawak Hilir
61.09.02.2002|Rawak Hulu
61.09.02.2003|Nanga Menterap
61.09.02.2004|Boti
61.09.02.2005|Perongkan
61.09.02.2006|Tinting Boyok
61.09.02.2007|Sekonau
61.09.02.2008|Setawar
61.09.02.2009|Nanga Pemubuh
61.09.02.2010|Tapang Perodah
61.09.02.2011|Sungai Sambang
61.09.02.2012|Mondi
61.09.02.2013|Cupang Gading
61.09.02.2014|Nanga Biaban
61.09.02.2015|Sunsong
61.09.03.2001|Nanga Taman
61.09.03.2002|Rirang Jati
61.09.03.2003|Senangak
61.09.03.2004|Nanga Kiungkang
61.09.03.2005|Sungai Lawak
61.09.03.2006|Tapang Tingang
61.09.03.2007|Nanga Mongko
61.09.03.2008|Nanga Engkulun
61.09.03.2009|Nanga Koman
61.09.03.2010|Lubuk Tajau
61.09.03.2011|Pantok
61.09.03.2012|Meragun
61.09.03.2013|Nanga Mentukak
61.09.03.2014|Semerawai
61.09.03.2015|Engkulun Hulu
61.09.04.2001|Nanga Mahap
61.09.04.2002|Batu Pahat
61.09.04.2003|Lembah Beringin
61.09.04.2004|Teluk Kebau
61.09.04.2005|Landau Apin
61.09.04.2006|Tembaga
61.09.04.2007|Cenayan
61.09.04.2008|Landau Kumpai
61.09.04.2009|Nanga Suri
61.09.04.2010|Sebabas
61.09.04.2011|Karang Betung
61.09.04.2012|Tamang
61.09.04.2013|Tembesuk
61.09.05.2001|Sungai Ayak Satu
61.09.05.2002|Sungai Ayak Dua
61.09.05.2003|Entabuk
61.09.05.2004|Tapang Pulau
61.09.05.2005|Kumpang Bis
61.09.05.2006|Menawai Tekam
61.09.05.2007|Semadu
61.09.05.2008|Merbang
61.09.05.2009|Empajak
61.09.05.2010|Sepantak
61.09.05.2011|Melanjan Raya
61.09.06.2001|Sebetung
61.09.06.2002|Seburuk Satu
61.09.06.2003|Sungai Tapah
61.09.06.2004|Ijuk
61.09.06.2005|Mengaret
61.09.06.2006|Kumpang Ilong
61.09.06.2007|Sungai Antu Hulu
61.09.06.2008|Terduk Dampak
61.09.06.2009|Pakit Mulau
61.09.06.2010|Tabuk Hulu
61.09.06.2011|Batuk Mulau
61.09.06.2012|Balai Sepuak
61.09.06.2013|Bukit Rambat
61.09.07.2001|Nanga Ansar
61.09.07.2002|Padak
61.09.07.2003|Setuntung
61.09.07.2004|Belitang Satu
61.09.07.2005|Belitang Dua
61.09.07.2006|Menua Prama
61.09.07.2007|Maboh Permai
61.10.01.2001|Pemuar
61.10.01.2002|Nusa Kenyikap
61.10.01.2003|Batu Ampar
61.10.01.2007|Balai Lagas
61.10.01.2008|Upit
61.10.01.2009|Langan
61.10.01.2010|Batu Buil
61.10.01.2011|Guhung
61.10.01.2013|Batu Nanta
61.10.01.2014|Belonsat
61.10.01.2016|Laman Bukit
61.10.01.2017|Tekaban
61.10.01.2019|Labang
61.10.01.2020|Nanga Pau
61.10.01.2021|Nanga Entebah
61.10.01.2023|Nanga Menunuk
61.10.01.2024|Sepan Tonak
61.10.02.2001|Tanjung Niaga
61.10.02.2002|Paal
61.10.02.2003|Sidomulyo
61.10.02.2004|Tembawang Panjang
61.10.02.2005|Poring
61.10.02.2007|Nanga Kebebu
61.10.02.2008|Nanga Kayan
61.10.02.2013|Baru
61.10.02.2021|Tanjung Sari
61.10.02.2023|Tanjung Lay
61.10.02.2024|Labai Mandiri
61.10.02.2026|Nusa Pandau
61.10.02.2032|Kelakik
61.10.02.2033|Semadin Lengkong
61.10.02.2038|Tebing Karangan
61.10.02.2040|Kenual
61.10.02.2042|Tanjung Tengang
61.10.03.2001|Nanga Ella Hilir
61.10.03.2002|Lengkong Nyadom
61.10.03.2003|Nanga Nuak
61.10.03.2004|Nanga Kalan
61.10.03.2005|Nanga Nyuruh
61.10.03.2006|Nanga Kempangai
61.10.03.2007|Kerangan Kora
61.10.03.2008|Penyuguk
61.10.03.2009|Popai
61.10.03.2010|Kahiya
61.10.03.2011|Bemban Permai
61.10.03.2012|Perembang Nyuruh
61.10.03.2013|Sungai Labuk
61.10.03.2014|Sungai Mentoba
61.10.03.2015|Natai Compa
61.10.03.2016|Pelempai Jaya
61.10.03.2017|Domet Permai
61.10.03.2018|Nyangau
61.10.03.2019|Jabai
61.10.04.2001|Menukung Kota
61.10.04.2002|Nanga Ella Hulu
61.10.04.2003|Sungai Sampuk
61.10.04.2004|Landau Leban
61.10.04.2005|Tanjung Beringin
61.10.04.2006|Nanga Melona Satu
61.10.04.2007|Nanga Siyai
61.10.04.2008|Nanga Mawang Mentatai
61.10.04.2009|Laman Mumbung
61.10.04.2010|Belaban Ella
61.10.04.2011|Pelaik Keruap
61.10.04.2012|Nanga Keruap
61.10.04.2013|Batas Nangka
61.10.04.2014|Nusa Poring
61.10.04.2015|Batu Onap
61.10.04.2016|Batu Badak
61.10.04.2017|Oyah
61.10.04.2018|Lihai
61.10.04.2019|Sampak
61.10.05.2001|Nanga Sayan
61.10.05.2002|Pekawai
61.10.05.2003|Landau Sandak
61.10.05.2004|Madya Raya
61.10.05.2005|Karangan Purun
61.10.05.2006|Mekar Pelita
61.10.05.2007|Bora
61.10.05.2008|Meta Bersatu
61.10.05.2009|Nanga Kasai
61.10.05.2010|Nanga Kompi
61.10.05.2011|Nanga Mancur
61.10.05.2012|Siling Permai
61.10.05.2013|Lingkar Indah
61.10.05.2014|Sayan Jaya
61.10.05.2015|Nanga Pak
61.10.05.2016|Tumbak Raya
61.10.05.2017|Berobai Permai
61.10.05.2018|Nanga Raku
61.10.06.2001|Batu Begigi
61.10.06.2002|Loka Jaya
61.10.06.2003|Suka Maju
61.10.06.2004|Bina Jaya
61.10.06.2005|Bina Karya
61.10.06.2006|Madong Jaya
61.10.06.2016|Bata Luar
61.10.06.2017|Maris Permai
61.10.06.2019|Pelita Kenaya
61.10.06.2020|Tanjung Beringin Raya
61.10.06.2021|Tanjung Gunung
61.10.06.2022|Keranjik
61.10.07.2001|Nanga Sokan
61.10.07.2002|Tanjung Sokan
61.10.07.2003|Sijau
61.10.07.2004|Keluing Taja
61.10.07.2005|Nanga Betangai
61.10.07.2006|Gelata
61.10.07.2007|Nanga Ora
61.10.07.2008|Nanga Libas
61.10.07.2009|Telaga Raya
61.10.07.2010|Teluk Pongkal
61.10.07.2011|Nanga Tangkit
61.10.07.2012|Penyengkuang
61.10.07.2013|Melana
61.10.07.2014|Nanga Potai
61.10.07.2015|Sepakat
61.10.07.2016|Muara Tanjung
61.10.07.2017|Landau Kabu
61.10.07.2018|Tanjung Mahung
61.10.08.2001|Tekelak
61.10.08.2002|Manding
61.10.08.2003|Nanga Belimbing
61.10.08.2004|Tengkajau
61.10.08.2005|Tanjung Paoh
61.10.08.2006|Nanga Man
61.10.08.2007|Sungai Pinang
61.10.08.2008|Engkurai
61.10.08.2009|Merpak
61.10.08.2010|Senibung
61.10.08.2011|Melamut Bersatu
61.10.08.2012|Natai Panjang
61.10.08.2013|Sungai Raya
61.10.08.2014|Merah Arai
61.10.08.2015|Suka Damai
61.10.08.2016|Tanjung Arak
61.10.08.2017|Melawi Kiri Hilir
61.10.08.2018|Kompas Raya
61.10.08.2019|Kayan Semapau
61.10.09.2001|Manggala
61.10.09.2002|Senempak
61.10.09.2003|Nanga Pintas
61.10.09.2004|Landau Garong
61.10.09.2005|Bina Jaya
61.10.09.2006|Mandau Baru
61.10.09.2007|Pelinggang
61.10.09.2008|Nyanggai
61.10.09.2009|Sungai Bakah
61.10.09.2010|Bayur Raya
61.10.09.2011|Landau Tubun
61.10.09.2012|Nanga Kelawai
61.10.10.2001|Tiong Keranjik
61.10.10.2002|Nanga Tikan
61.10.10.2003|Beloyang
61.10.10.2004|Nanga Raya
61.10.10.2005|Junjung Permai
61.10.10.2006|Nanga Keberak
61.10.10.2007|Piawas
61.10.10.2008|Kayu Bunga
61.10.11.2001|Ulak Muid
61.10.11.2002|Harapan Jaya
61.10.11.2003|Durian Jaya
61.10.11.2004|Togan Baru
61.10.11.2005|Pelita Jaya
61.10.11.2006|Bukit Raya
61.10.11.2007|Lintah Taum
61.10.11.2008|Laja
61.10.11.2009|Keluas Hulu
61.10.11.2010|Ganjang
61.11.01.2001|Sutera
61.11.01.2002|Pangkalan Buton
61.11.01.2003|Sejahtera
61.11.01.2004|Simpang Tiga
61.11.01.2005|Benawai Agung
61.11.01.2006|Harapan Mulia
61.11.01.2007|Pampang Harapan
61.11.01.2008|Sedahan Jaya
61.11.01.2009|Gunungsembilan
61.11.01.2010|Riam Berasap Jaya
61.11.02.2001|Teluk Melano
61.11.02.2002|Nipah Kuning
61.11.02.2003|Pemangkat
61.11.02.2004|Padu Banjar
61.11.02.2005|Penjalaan
61.11.02.2006|Sungai Mata-Mata
61.11.02.2007|Batu Barat
61.11.02.2008|Pulau Kumbang
61.11.02.2009|Rantau Panjang
61.11.02.2010|Matan Jaya
61.11.02.2011|Medan Jaya
61.11.02.2012|Lubuk Batu
61.11.03.2001|Mas Bangun
61.11.03.2002|Alur Bandung
61.11.03.2003|Telukbatang
61.11.03.2004|Sungaipaduan
61.11.03.2005|Banyu Abang
61.11.03.2006|Telukbatang Selatan
61.11.03.2007|Telukbatang Utara
61.11.04.2001|Tanjungsatai
61.11.04.2002|Kemboja
61.11.04.2003|Dusun Kecil
61.11.04.2004|Dusun Besar
61.11.04.2006|Satai Lestari
61.11.05.2001|Seponti Jaya
61.11.05.2002|Telaga Arum
61.11.05.2003|Wonorejo
61.11.05.2004|Podorukun
61.11.05.2005|Sungai Sepeti
61.11.05.2006|Durian Sebatang
61.11.06.2001|Pelapis
61.11.06.2002|Betok Jaya
61.11.06.2003|Padang
61.12.01.2001|Sungai Raya
61.12.01.2002|Sungai Ambangah
61.12.01.2003|Arang Limbung
61.12.01.2004|Kuala Dua
61.12.01.2005|Tebang Kacang
61.12.01.2006|Sungai Asam
61.12.01.2007|Pulau Limbung
61.12.01.2008|Kapur
61.12.01.2009|Gunung Tamang
61.12.01.2010|Sungai Bulan
61.12.01.2011|Limbung
61.12.01.2012|Teluk Kapuas
61.12.01.2013|Madu Sari
61.12.01.2014|Mekar Sari
61.12.01.2015|Mekar Baru
61.12.01.2016|Sungai Raya Dalam
61.12.01.2017|Parit Baru
61.12.01.2018|Pulau Jambu
61.12.01.2019|Kalibandung
61.12.01.2020|Muara Baru
61.12.01.2021|Sukulanting
61.12.01.2022|Permata Jaya
61.12.02.2001|Kuala Mandor B
61.12.02.2002|Kubu Padi
61.12.02.2003|Kuala Mandor A
61.12.02.2004|Retok
61.12.02.2005|Sungai Enau
61.12.02.2006|Padi Jaya
61.12.03.2001|Simpang Kanan
61.12.03.2002|Mega Timur
61.12.03.2003|Bengkarek
61.12.03.2004|Lingga
61.12.03.2005|Sungai Ambawang Kuala
61.12.03.2006|Jawa Tengah
61.12.03.2007|Durian
61.12.03.2008|Pancaroba
61.12.03.2009|Puguk
61.12.03.2010|Korek
61.12.03.2011|Pasak
61.12.03.2012|Pasak Piang
61.12.03.2013|Teluk Bakung
61.12.03.2014|Ampera Raya
61.12.03.2015|Sungai Malaya
61.12.04.2002|Teluk Empening
61.12.04.2003|Terentang Hilir
61.12.04.2004|Terentang Hulu
61.12.04.2005|Permata
61.12.04.2006|Betuah
61.12.04.2007|Sungai Radak Satu
61.12.04.2008|Sungai Radak Dua
61.12.04.2009|Sungai Dungun
61.12.04.2010|Teluk Bayur
61.12.04.2011|Radak Baru
61.12.05.2001|Tanjung Beringin
61.12.05.2002|Batu Ampar
61.12.05.2003|Teluk Nibung
61.12.05.2004|Padang Tikar Satu
61.12.05.2005|Padang Tikar Dua
61.12.05.2006|Tasik Malaya
61.12.05.2007|Sungai Besar
61.12.05.2008|Sungai Jawi
61.12.05.2009|Nipah Panjang
61.12.05.2010|Ambarawa
61.12.05.2011|Tanjung Harapan
61.12.05.2012|Sungai Kerawang
61.12.05.2013|Sumber Agung
61.12.05.2014|Muara Tiga
61.12.05.2015|Medan Mas
61.12.06.2001|Kubu
61.12.06.2002|Olak-Olak Kubu
61.12.06.2003|Sungai Selamat
61.12.06.2004|Sungai Bemban
61.12.06.2005|Pinang Luar
61.12.06.2006|Seruat Dua
61.12.06.2007|Seruat Tiga
61.12.06.2008|Dabong
61.12.06.2009|Ambawang
61.12.06.2010|Sepakat Baru
61.12.06.2011|Kampung Baru
61.12.06.2012|Air Putih
61.12.06.2013|Teluk Nangka
61.12.06.2014|Jangkang Satu
61.12.06.2015|Jangkang Dua
61.12.06.2016|Pinang Dalam
61.12.06.2017|Sungai Terus
61.12.06.2018|Pelita Jaya
61.12.06.2019|Mengkalang
61.12.06.2020|Mengkalang Jambu
61.12.07.2001|Rasau Jaya Umum
61.12.07.2002|Rasau Jaya Satu
61.12.07.2003|Rasau Jaya Dua
61.12.07.2004|Rasau Jaya Tiga
61.12.07.2005|Bintang Mas
61.12.07.2006|Pematang Tujuh
61.12.08.2001|Teluk Pakedai Hulu
61.12.08.2002|Teluk Pakedai Satu
61.12.08.2003|Teluk Pakedai Dua
61.12.08.2004|Kuala Karang
61.12.08.2005|Seruat Satu
61.12.08.2006|Sungai Deras
61.12.08.2007|Selat Remis
61.12.08.2008|Madura
61.12.08.2009|Pasir Putih
61.12.08.2010|Teluk Gelam
61.12.08.2011|Tanjung Bunga
61.12.08.2012|Sungai Nibung
61.12.08.2013|Arus Deras
61.12.08.2014|Sungai Nipah
61.12.09.2001|Sungai Kakap
61.12.09.2002|Sungai Itik
61.12.09.2003|Jeruju Besar
61.12.09.2004|Sungai Kupah
61.12.09.2005|Sungai Rengas
61.12.09.2006|Pal Sembilan
61.12.09.2007|Sungai Belidak
61.12.09.2008|Kalimas
61.12.09.2009|Punggur Kecil
61.12.09.2010|Punggur Besar
61.12.09.2011|Tanjung Saleh
61.12.09.2012|Sepuk Laut
61.12.09.2013|Punggur Kapuas
61.12.09.2014|Rengas Kapuas
61.12.09.2015|Parit Keladi
61.71.01.1002|Benuamelayu Laut
61.71.01.1003|Benuamelayu Darat
61.71.01.1004|Parittokaya
61.71.01.1005|Kotabaru
61.71.01.1006|Akcaya
61.71.02.1001|Paritmayor
61.71.02.1002|Banjar Serasan
61.71.02.1003|Saigon
61.71.02.1004|Tanjung Hulu
61.71.02.1005|Tanjung Hilir
61.71.02.1006|Dalambugis
61.71.02.1007|Tambelansampit
61.71.03.1001|Pallima
61.71.03.1002|Sungaijawi Dalam
61.71.03.1003|Sungaijawi Luar
61.71.03.1004|Sungaibeliung
61.71.04.1001|Siantan Hulu
61.71.04.1002|Siantan Tengah
61.71.04.1003|Siantan Hilir
61.71.04.1004|Batulayang
61.71.05.1001|Sungaibangkong
61.71.05.1002|Daratsekip
61.71.05.1003|Tengah
61.71.05.1004|Mariana
61.71.05.1005|Sungaijawi
61.71.06.1001|Bansir Laut
61.71.06.1002|Bansir Darat
61.71.06.1003|Bangkabelitung Laut
61.71.06.1004|Bangkabelitung Darat
61.72.01.1001|Roban
61.72.01.1002|Condong
61.72.01.1003|Sekip Lama
61.72.01.1004|Jawa
61.72.01.1005|Bukit Batu
61.72.01.1006|Sungai Wie
61.72.02.1001|Pasiran
61.72.02.1002|Melayu
61.72.02.1003|Tengah
61.72.02.1004|Kuala
61.72.03.1001|Pajintan
61.72.03.1002|Nyarumkop
61.72.03.1003|Maya Sopa
61.72.03.1004|Bagak Sahwa
61.72.03.1005|Sanggau Kulor
61.72.04.1001|Sungai Garam Hilir
61.72.04.1002|Naram
61.72.04.1003|Sungai Bulan
61.72.04.1004|Sungai Rasau
61.72.04.1005|Setapuk Kecil
61.72.04.1006|Setapuk Besar
61.72.04.1007|Semelagi Kecil
61.72.05.1001|Sedau
61.72.05.1002|Sagatani
61.72.05.1003|Sijangkung
61.72.05.1004|Pangmilang
62.01.01.1011|Candi
62.01.01.1012|Kumai Hulu
62.01.01.1013|Kumai Hilir
62.01.01.2001|Sungai Cabang
62.01.01.2002|Teluk Pulai
62.01.01.2003|Sabuai
62.01.01.2004|Keraya
62.01.01.2005|Teluk Bogam
62.01.01.2006|Sungai Bakau
62.01.01.2007|Kubu
62.01.01.2008|Sungai Kapitan
62.01.01.2009|Batu Belaman
62.01.01.2010|Sungai Tendang
62.01.01.2014|Sungai Sekonyer
62.01.01.2015|Sungai Bedaun
62.01.01.2017|Bumi Harjo
62.01.01.2032|Pangkalan Satu
62.01.01.2034|Sabuai Timur
62.01.02.1002|Mendawai Seberang
62.01.02.1003|Mendawai
62.01.02.1005|Madurejo
62.01.02.1006|Sidorejo
62.01.02.1007|Raja
62.01.02.1008|Raja Seberang
62.01.02.1009|Baru
62.01.02.2001|Tanjung Putri
62.01.02.2004|Pasir Panjang
62.01.02.2010|Rangda
62.01.02.2011|Kenambui
62.01.02.2012|Runtu
62.01.02.2013|Umpang
62.01.02.2014|Kumpai Batu Bawah
62.01.02.2015|Kumpai Batu Atas
62.01.02.2016|Natai Raya
62.01.02.2017|Medang Sari
62.01.02.2018|Natai Baru
62.01.02.2019|Tanjung Terantang
62.01.02.2020|Sulung
62.01.03.1007|Kotawaringin Hulu
62.01.03.1008|Kotawaringin Hilir
62.01.03.2001|Babual Baboti
62.01.03.2002|Tempayung
62.01.03.2003|Sakabulin
62.01.03.2004|Kinjil
62.01.03.2005|Dawak
62.01.03.2006|Riam Durian
62.01.03.2009|Lalang
62.01.03.2010|Rungun
62.01.03.2011|Kondang
62.01.03.2012|Suka Jaya
62.01.03.2013|Suka Makmur
62.01.03.2014|Sumber Mukti
62.01.03.2015|Palih Baru
62.01.03.2016|Ipuh Bangun Jaya
62.01.03.2017|Sagu Suka Mulya
62.01.04.1002|Pangkut
62.01.04.2001|Nanga Mua
62.01.04.2003|Sukarami
62.01.04.2004|Gandis
62.01.04.2005|Kerabu
62.01.04.2006|Sambi
62.01.04.2007|Penyombaan
62.01.04.2008|Pandau
62.01.04.2009|Riam
62.01.04.2010|Panahan
62.01.04.2011|Sungai Dau
62.01.05.2001|Pangkalan Tiga
62.01.05.2002|Pandu Sanjaya
62.01.05.2003|Lada Mandala Jaya
62.01.05.2004|Makarti Jaya
62.01.05.2005|Sumber Agung
62.01.05.2006|Purbasari
62.01.05.2007|Sungai Rangit Jaya
62.01.05.2008|Pangkalan Dewa
62.01.05.2009|Kadipi Atas
62.01.05.2010|Sungai Melawen
62.01.05.2011|Pangkalan Durin
62.01.06.2001|Pangkalan Banteng
62.01.06.2002|Mulya Jadi
62.01.06.2003|Karang Mulya
62.01.06.2004|Kebun Agung
62.01.06.2005|Sido Mulyo
62.01.06.2006|Marga Mulya
62.01.06.2007|Amin Jaya
62.01.06.2008|Arga Mulya
62.01.06.2009|Natai Kerbau
62.01.06.2010|Simpang Berambai
62.01.06.2011|Sungai Hijau
62.01.06.2012|Sungai Pakit
62.01.06.2013|Berambai Makmur
62.01.06.2014|Karang Sari
62.01.06.2015|Sungai Pulau
62.01.06.2016|Sungai Bengkuang
62.01.06.2017|Sungai Kuning
62.02.01.1009|Kota Besi Hulu
62.02.01.1010|Kota Besi Hilir
62.02.01.2003|Palangan
62.02.01.2004|Hanjalipan
62.02.01.2005|Simpur
62.02.01.2006|Pamalian
62.02.01.2007|Camba
62.02.01.2008|Kandan
62.02.01.2012|Bajarum
62.02.01.2015|Rasau Tumbuh
62.02.01.2017|Soren
62.02.02.2004|Rubung Buyung
62.02.02.2005|Patai
62.02.02.2006|Luwuk Ranggan
62.02.02.2007|Jemaras
62.02.02.2008|Cempaka Mulia Timur
62.02.02.2009|Cempaka Mulia Barat
62.02.02.2010|Luwuk Bunter
62.02.02.2011|Sungai Paring
62.02.03.1012|Kuala Kuayan
62.02.03.2001|Tangar
62.02.03.2002|Baampah
62.02.03.2003|Kawan Batu
62.02.03.2004|Tanjung Bantur
62.02.03.2005|Penda Durian
62.02.03.2006|Pahirangan
62.02.03.2007|Satiung
62.02.03.2008|Santilik
62.02.03.2009|Tangka Robah
62.02.03.2010|Pemantang
62.02.03.2011|Tumbang Sapiri
62.02.03.2014|Bawan
62.02.03.2015|Tanjung Jariangau
62.02.03.2031|Kapuk
62.02.03.2032|Pantap
62.02.04.1004|Parenggean
62.02.04.2001|Tehang
62.02.04.2002|Kabuau
62.02.04.2007|Barunang Miri
62.02.04.2009|Sumber Makmur
62.02.04.2010|Mekar Jaya
62.02.04.2011|Karang Tunggal
62.02.04.2012|Bandar Agung
62.02.04.2013|Beringin Tunggal Jaya
62.02.04.2015|Sari Harapan
62.02.04.2016|Karang Sari
62.02.04.2019|Bajarau
62.02.04.2023|Bukit Harapan
62.02.04.2024|Manjalin
62.02.04.2025|Karya Bersama
62.02.05.1001|Baamang Hilir
62.02.05.1002|Baamang Tengah
62.02.05.1003|Baamang Hulu
62.02.05.1007|Tanah Mas
62.02.05.1008|Baamang Barat
62.02.05.2006|Tinduk
62.02.06.1001|Mentawa Baru Hulu
62.02.06.1002|Mentawa Baru Hilir
62.02.06.1003|Ketapang
62.02.06.1007|Sawahan
62.02.06.1009|Pasir Putih
62.02.06.2005|Pelangsian
62.02.06.2006|Bapeang
62.02.06.2008|Eka Bahurui
62.02.06.2010|Telaga baru
62.02.06.2011|Bangkuang Makmur
62.02.06.2012|Bapanggang Raya
62.02.07.2001|Pondok Damar
62.02.07.2002|Bagendang Hilir
62.02.07.2003|Bagendang Tengah
62.02.07.2004|Natai Baru
62.02.07.2005|Bagendang Hulu
62.02.07.2006|Sumber Makmur
62.02.07.2007|Bagendang Permai
62.02.08.1008|Samuda Kota
62.02.08.1009|Basirih Hilir
62.02.08.2005|Sebamban
62.02.08.2006|Samuda Besar
62.02.08.2007|Samuda Kecil
62.02.08.2010|Jaya Kelapa
62.02.08.2011|Basirih Hulu
62.02.08.2012|Jaya Karet
62.02.08.2013|Handil Sohor
62.02.08.2014|Sei Ijum Raya
62.02.09.2001|Bapinang Hulu
62.02.09.2002|Bapinang Hilir
62.02.09.2003|Bapinang Hilir Laut
62.02.09.2004|Satiruk
62.02.09.2005|Makarti Jaya
62.02.09.2006|Rawa Sari
62.02.09.2007|Hanaut
62.02.09.2008|Babirah
62.02.09.2009|Serambut
62.02.09.2010|Babaung
62.02.09.2011|Bamadu
62.02.09.2012|Penyaguan
62.02.09.2013|Hantipan
62.02.09.2014|Bantian
62.02.10.2001|Tumbang Kalang
62.02.10.2002|Kuluk Telawang
62.02.10.2003|Sungai Puring
62.02.10.2004|Tumbang Ngahan
62.02.10.2005|Tumbang Ramei
62.02.10.2006|Tumbang Hejan
62.02.10.2007|Sungai Hanya
62.02.10.2008|Tumbang Sepayang
62.02.10.2016|Buntut Nusa
62.02.10.2017|Tumbang Gagu
62.02.10.2021|Tumbang Manya
62.02.10.2025|Gunung Makmur
62.02.10.2027|Mulya Agung
62.02.10.2028|Bhakti Karya
62.02.10.2029|Waringin Agung
62.02.11.2001|Parebok
62.02.11.2002|Basawang
62.02.11.2003|Lampuyang
62.02.11.2004|Ujung Pandaran
62.02.11.2005|Regei Lestari
62.02.11.2006|Kuin Permai
62.02.12.1001|Mentaya Seberang
62.02.12.2002|Terantang
62.02.12.2003|Batuah
62.02.12.2004|Terantang Hilir
62.02.12.2005|Ganepo
62.02.12.2006|Seragam Jaya
62.02.13.2001|Pundu
62.02.13.2002|Keruing
62.02.13.2003|Parit
62.02.13.2004|Pantai Harapan
62.02.13.2005|Pelantaran
62.02.13.2006|Tumbang Koling
62.02.13.2007|Sudan
62.02.13.2008|Bukit Batu
62.02.13.2009|Bukit Raya
62.02.13.2010|Selucing
62.02.13.2011|Sungai Ubar Mandiiri
62.02.14.2001|Sebabi
62.02.14.2002|Tanah Putih
62.02.14.2003|Sumber Makmur
62.02.14.2004|Kenyala
62.02.14.2005|Penyang
62.02.14.2006|Biru Maju
62.02.15.2001|Tumbang Tilap
62.02.15.2002|Tumbang Kaminting
62.02.15.2003|Tanah Haluan
62.02.15.2004|Tumbang Panyahuan
62.02.15.2005|Tumbang Sapia
62.02.15.2006|Tumbang Getas
62.02.15.2007|Tewai Hara
62.02.15.2008|Tumbang Payang
62.02.15.2009|Tumbang Kania
62.02.15.2010|Tumbang Tawan
62.02.15.2011|Lunuk Bagantung
62.02.15.2012|Tumbang Torung
62.02.15.2013|Tumbang Batu
62.02.15.2014|Tumbang Saluang
62.02.16.2001|Luwuk Sampun
62.02.16.2002|Tumbang Mujam
62.02.16.2003|Merah
62.02.16.2004|Tanjung Jorong
62.02.16.2005|Sebungsu
62.02.16.2006|Bukit Makmur
62.02.16.2007|Wonosari
62.02.16.2008|Mekar Sari
62.02.16.2009|Damar Makmur
62.02.16.2010|Cempaka Putih
62.02.16.2011|Jati Waringin
62.02.17.2001|Tumbang Boloi
62.02.17.2002|Luwuk Kowan
62.02.17.2003|Rantau Tampang
62.02.17.2004|Tumbang Mangkup
62.02.17.2005|Rantau Katang
62.02.17.2006|Tumbang Sangai
62.02.17.2007|Tukang Langit
62.02.17.2008|Beringin Agung
62.02.17.2009|Agung Mulya
62.02.17.2010|Batu Agung
62.02.17.2011|Bukit Indah
62.02.17.2012|Tumbang Puan
62.02.17.2013|Rantau Suang
62.02.17.2014|Rantau Sawang
62.02.17.2015|Tanjung Harapan
62.02.17.2016|Buana Mustika
62.02.17.2017|Tri Buana
62.02.17.2018|Tumbang Bajanei
62.03.01.1006|Murung Keramat
62.03.01.1007|Selat Hilir
62.03.01.1008|Selat Tengah
62.03.01.1009|Selat Hulu
62.03.01.1010|Selat Dalam
62.03.01.1021|Selat Utara
62.03.01.1022|Selat Barat
62.03.01.1023|Panamas
62.03.01.2011|Pulau Telo
62.03.01.2020|Pulau Telo Baru
62.03.02.1001|Mambulau
62.03.02.1002|Hampatung
62.03.02.1003|Dahirang
62.03.02.1004|Barimba
62.03.02.1005|Sei Pasah
62.03.02.2006|Bakungin
62.03.02.2007|Sei Asam
62.03.02.2008|Saka Batur
62.03.03.2001|Anjir Serapat Timur
62.03.03.2002|Anjir Serapat Tengah
62.03.03.2003|Anjir Serapat Barat
62.03.03.2004|Anjir Mambulau Timur
62.03.03.2005|Anjir Mambulau Tengah
62.03.03.2006|Anjir Mambulau Barat
62.03.03.2007|Anjir Serapat Baru
62.03.04.2001|Batanjung
62.03.04.2002|Cemara Labat
62.03.04.2003|Palampai
62.03.04.2004|Sei Teras
62.03.04.2005|Lupak Dalam
62.03.04.2008|Tamban Baru Selatan
62.03.04.2011|Tamban Lupak
62.03.04.2014|Lupak Timur
62.03.04.2015|Wargo Mulyo
62.03.04.2016|Sei Bakut
62.03.04.2018|Pematang
62.03.04.2019|Simpang Bunga Tanjung
62.03.04.2020|Baranggau
62.03.05.1004|Mandomai
62.03.05.2001|Sei Kayu
62.03.05.2002|Saka Mangkahai
62.03.05.2003|Anjir Kalampan
62.03.05.2005|Pantai
62.03.05.2006|Saka Tamiang
62.03.05.2007|Penda Katapi
62.03.05.2008|Teluk Hiri
62.03.05.2009|Sei Dusun
62.03.05.2010|Sei Pitung
62.03.05.2011|Maju Bersama
62.03.05.2012|Basuta Raya
62.03.06.2001|Saka Lagon
62.03.06.2002|Bunga Mawar
62.03.06.2003|Sei Tatas
62.03.06.2004|Narahan
62.03.06.2005|Handiwung
62.03.06.2006|Anjir Palambang
62.03.06.2007|Palangkai
62.03.06.2008|Teluk Palinget
62.03.06.2009|Sei Tatas Hilir
62.03.06.2010|Mawar Mekar
62.03.06.2011|Banama
62.03.06.2012|Narahan Baru
62.03.07.1001|Palingkau Baru
62.03.07.1002|Palingkau Lama
62.03.07.2003|Tajepan
62.03.07.2004|Mampai
62.03.07.2005|Muara Dadahup
62.03.07.2006|Belawang
62.03.07.2008|Palangkau Lama
62.03.07.2010|Palangkau Baru
62.03.07.2014|Talekung Punei
62.03.07.2015|Karya Bersama
62.03.07.2016|Palingkau Jaya
62.03.07.2017|Palingkau Asri
62.03.07.2018|Palingkau Sejahtera
62.03.07.2019|Saka Binjai
62.03.07.2020|Bina Sejahtera
62.03.07.2021|Suka Reja
62.03.07.2022|Suka Mukti
62.03.07.2023|Bina Karya
62.03.07.2024|Bina Mekar
62.03.07.2025|Rawa Subur
62.03.07.2026|Sumber Mulya
62.03.07.2027|Bumi Rahayu
62.03.07.2028|Manggala Permai
62.03.08.2001|Pangkalan Rekan
62.03.08.2002|Batuah
62.03.08.2003|Basarang
62.03.08.2004|Basungkai
62.03.08.2005|Maluen
62.03.08.2006|Pangkalan Sari
62.03.08.2007|Lunuk Ramba
62.03.08.2008|Batu Nindan
62.03.08.2009|Basarang Jaya
62.03.08.2010|Bungai Jaya
62.03.08.2011|Panarung
62.03.08.2012|Tarung Manuah
62.03.08.2013|Tambun Raya
62.03.08.2014|Naning
62.03.09.2001|Manusup
62.03.09.2002|Sei Kapar
62.03.09.2003|Tarantang
62.03.09.2004|Lamunti
62.03.09.2005|Pulau Kaladan
62.03.09.2006|Mantangai Hilir
62.03.09.2007|Mantangai Tengah
62.03.09.2008|Mantangai Hulu
62.03.09.2009|Kalumpang
62.03.09.2010|Sei Ahas
62.03.09.2011|Katunjung
62.03.09.2012|Lahei Mangkutup
62.03.09.2013|Tumbang Muroi
62.03.09.2014|Danau Rawah
62.03.09.2015|Muroi Raya
62.03.09.2016|Katimpun
62.03.09.2017|Manusup Hilir
62.03.09.2018|Sei Gita
62.03.09.2019|Bukit Batu
62.03.09.2020|Sei Gawing
62.03.09.2021|Humbang Raya
62.03.09.2022|Tabore
62.03.09.2023|Tumbang Mangkutup
62.03.09.2024|Lapetan
62.03.09.2025|Lamunti Permai
62.03.09.2026|Manyahi
62.03.09.2027|Sekata Makmur
62.03.09.2028|Kaladan Jaya
62.03.09.2029|Rantau Jaya
62.03.09.2030|Warga Mulya
62.03.09.2031|Lamunti Baru
62.03.09.2032|Sriwidadi
62.03.09.2033|Sumber Makmur
62.03.09.2034|Sidomulyo
62.03.09.2035|Harapan Jaya
62.03.09.2036|Sekata Bangun
62.03.09.2037|Sari Makmur
62.03.09.2038|Suka Maju
62.03.10.2001|Petak Puti
62.03.10.2002|Aruk
62.03.10.2003|Lawang Kajang
62.03.10.2004|Timpah
62.03.10.2005|Lungkuh Layang
62.03.10.2006|Lawang Kamah
62.03.10.2007|Tumbang Randang
62.03.10.2008|Batapah
62.03.10.2009|Danau Pantau
62.03.11.2001|Masaran
62.03.11.2002|Kayu Bulan
62.03.11.2003|Kota Baru
62.03.11.2004|Penda Muntei
62.03.11.2005|Tapen
62.03.11.2006|Pujon
62.03.11.2007|Marapit
62.03.11.2008|Manis
62.03.11.2009|Karukus
62.03.11.2010|Bajuh
62.03.11.2011|Barunang
62.03.11.2019|Buhut Jaya
62.03.11.2021|Hurung Pukung
62.03.12.2001|Sei Hanyo
62.03.12.2002|Hurung Tabengan
62.03.12.2003|Rahung Bungai
62.03.12.2005|Bulau Ngandung
62.03.12.2006|Tumbang Puroh
62.03.12.2008|Tangirang
62.03.12.2013|Barunang II
62.03.12.2014|Hurung Tampang
62.03.12.2015|Supang
62.03.12.2016|Katanjung
62.03.12.2018|Jakatan Pari
62.03.12.2019|Tumbang Sirat
62.03.12.2021|Dirung Koram
62.03.12.2022|Mampai Jaya
62.03.13.2001|Tamban Baru Timur
62.03.13.2002|Tamban Baru Tengah
62.03.13.2003|Tamban Baru Mekar
62.03.13.2004|Bandaraya
62.03.13.2005|Sidorejo
62.03.13.2006|Warna Sari
62.03.13.2007|Bandar Mekar
62.03.13.2008|Tamban Makmur
62.03.13.2009|Sidomulyo
62.03.13.2010|Tamban Jaya
62.03.14.2001|Jangkang
62.03.14.2002|Tumbang Tukun
62.03.14.2003|Sei Ringin
62.03.14.2004|Kaburan
62.03.14.2005|Balai Banjang
62.03.14.2006|Tumbang Diring
62.03.14.2007|Dandang
62.03.14.2008|Hurung Kampin
62.03.14.2009|Batu Sambung
62.03.14.2010|Tumbang Nusa
62.03.15.2001|Masaha
62.03.15.2002|Sei Pinang
62.03.15.2003|Lawang Tamang
62.03.15.2004|Karetau Manta'a
62.03.15.2005|Tumbang Bukoi
62.03.15.2006|Tumbang Tihis
62.03.15.2007|Tumbang Manyarung
62.03.15.2008|Tanjung Rendan
62.03.15.2009|Jakatan Masaha
62.03.15.2010|Masupa Ria
62.03.16.2001|Dadahup
62.03.16.2002|Tambak Bajai
62.03.16.2003|Bina Jaya
62.03.16.2004|Harapan Baru
62.03.16.2005|Bentuk Jaya
62.03.16.2006|Sumber Agung
62.03.16.2007|Petak Batuah
62.03.16.2008|Manuntung
62.03.16.2009|Sumber Alaska
62.03.16.2010|Menteng Karya
62.03.16.2011|Tanjung Harapan
62.03.16.2012|Kahuripan Permai
62.03.16.2013|Dadahup Raya
62.03.17.1001|Pulau Kupang
62.03.17.2002|Pulau Mambulau
62.03.17.2003|Sei Lunuk
62.03.17.2004|Sei Jangkit
62.03.17.2005|Tamban Luar
62.03.17.2006|Terusan Raya
62.03.17.2007|Terusan Karya
62.03.17.2008|Terusan Makmur
62.03.17.2009|Terusan Mulya
62.03.17.2010|Bamban Raya
62.03.17.2011|Bangun Harjo
62.03.17.2012|Terusan Baguntan Raya
62.03.17.2013|Terusan Raya Barat
62.03.17.2014|Terusan Raya Hulu
62.03.17.2015|Budi Mufakat
62.04.01.1003|Rantau Kujang
62.04.01.2001|Tampulang
62.04.01.2002|Rantau Bahuang
62.04.01.2004|Rangga Ilung
62.04.01.2005|Tabatan
62.04.02.1003|Mengkatip
62.04.02.2001|Sungai Jaya
62.04.02.2002|Mahajandau
62.04.02.2004|Kalanis
62.04.02.2005|Lehai
62.04.02.2006|Damparan
62.04.02.2007|Teluk Timbau
62.04.02.2008|Batilap
62.04.02.2009|Batampang
62.04.02.2010|Mangkatir
62.04.03.1002|Bangkuang
62.04.03.2001|Salat Baru
62.04.03.2003|Teluk Betung
62.04.03.2004|Babai
62.04.03.2005|Janggi
62.04.03.2006|Malitin
62.04.03.2007|Muara Arai
62.04.03.2008|Talio
62.04.03.2009|Tampijak
62.04.03.2010|Bintang Kurung
62.04.03.2011|Teluk Sampudau
62.04.04.1005|Pendang
62.04.04.2001|Sungai Telang
62.04.04.2002|Majundre
62.04.04.2003|Bundar
62.04.04.2004|Talekoi
62.04.04.2006|Marawan Lama
62.04.04.2007|Marawan Baru
62.04.04.2008|Reong
62.04.04.2009|Tarusan
62.04.04.2010|Panarukan
62.04.04.2011|Maruga
62.04.04.2012|Hingan
62.04.04.2013|Danau Bambure
62.04.04.2014|Tamparak
62.04.04.2015|Hulu Tampang
62.04.04.2016|Bantai Bambure
62.04.04.2017|Rampa Mea
62.04.04.2018|Gunung Rantau
62.04.04.2019|Tamparak Layung
62.04.05.2001|Baruang
62.04.05.2002|Kayumban
62.04.05.2003|Tabak Kanilan
62.04.05.2004|Sarimbuah
62.04.05.2005|Gagutur
62.04.05.2006|Muka Haji
62.04.05.2007|Sire
62.04.05.2008|Muara Singan
62.04.05.2009|Patas I
62.04.05.2010|Patas II
62.04.05.2011|Bintang Ara
62.04.05.2012|Ugang Sayu
62.04.05.2013|Ngurit
62.04.05.2014|Wungkur Baru
62.04.05.2015|Bipak Kali
62.04.05.2016|Malungai Raya
62.04.05.2017|Sei Paken
62.04.05.2018|Palu Rejo
62.04.05.2019|Wayun
62.04.05.2020|Marga Jaya
62.04.05.2021|Ruhing Raya
62.04.06.1006|Jelapat
62.04.06.1007|Hilir Seper
62.04.06.1008|Buntok Kota
62.04.06.2001|Danau Ganting
62.04.06.2002|Muara Talang
62.04.06.2003|Teluk Telaga
62.04.06.2004|Baru
62.04.06.2005|Danau Sadar
62.04.06.2009|Pamait
62.04.06.2010|Sababilah
62.04.06.2011|Mangaris
62.04.06.2012|Tetei Lanan
62.04.06.2013|Pamangka
62.04.06.2014|Sanggu
62.04.06.2015|Lembeng
62.04.06.2016|Muara Ripung
62.04.06.2017|Madara
62.04.06.2018|Murung Paken
62.04.06.2019|Mabuan
62.04.06.2020|Kalahien
62.04.06.2021|Penda Asam
62.04.06.2022|Pararapak
62.04.06.2023|Teluk Mampun
62.04.06.2024|Tanjung Jawa
62.04.06.2025|Telang Andrau
62.04.06.2026|Dangka
62.04.06.2027|Danau Masura
62.05.01.1001|Montallat I
62.05.01.1002|Montallat II
62.05.01.1003|Tumpung Laung I
62.05.01.1004|Tumpung Laung II
62.05.01.2005|Sikan
62.05.01.2006|Rubei
62.05.01.2007|Pepas
62.05.01.2008|Ruji
62.05.01.2009|Paring Lahung
62.05.01.2010|Kamawen
62.05.02.2001|Malungai
62.05.02.2002|Rarawa
62.05.02.2003|Ketapang
62.05.02.2004|Walur
62.05.02.2005|Baliti
62.05.02.2006|Majangkan
62.05.02.2007|Kandui
62.05.02.2008|Payang Ara
62.05.02.2009|Jaman
62.05.02.2010|Pelari
62.05.02.2011|Sangkorang
62.05.02.2012|Siwau
62.05.02.2013|Tongka
62.05.02.2014|Batu Raya I
62.05.02.2015|Batu Raya II
62.05.02.2016|Tapen Raya
62.05.03.2001|Tanjung Harapan
62.05.03.2002|Linon Besi I
62.05.03.2003|Linon Besi II
62.05.03.2004|Muara Mea
62.05.03.2005|Lawarang
62.05.03.2006|Lampeong I
62.05.03.2007|Lampeong II
62.05.03.2008|Payang
62.05.03.2009|Berong
62.05.03.2010|Baok
62.05.03.2011|Tambaba
62.05.04.2001|Sampirang I
62.05.04.2002|Sampirang II
62.05.04.2003|Liju
62.05.04.2004|Benangin III
62.05.04.2005|Benangin II
62.05.04.2006|Benangin V
62.05.04.2007|Benangin I
62.05.04.2008|Muara Wakat
62.05.04.2012|Mampuak I
62.05.04.2013|Jamut
62.05.04.2014|Sei Liju
62.05.04.2015|Mampuak II
62.05.05.1013|Lanjas
62.05.05.1014|Melayu
62.05.05.2010|Lemo I
62.05.05.2011|Lemo II
62.05.05.2012|Pendreh
62.05.05.2017|Rimba Sari
62.05.05.2018|Sei Rahayu I
62.05.05.2022|Sei Rahayu II
62.05.05.2024|Beringin Raya
62.05.05.2025|Datai Nirui
62.05.06.1015|Lahei I
62.05.06.1016|Lahei II
62.05.06.2001|Ipu
62.05.06.2002|Mukut
62.05.06.2014|Muara Bakah
62.05.06.2017|Juju Baru
62.05.06.2018|Muara Inu
62.05.06.2019|Bengahon
62.05.06.2020|Rahaden
62.05.06.2021|Muara Pari
62.05.06.2022|Haragandang
62.05.06.2023|Karendan
62.05.06.2024|Hurung Enep
62.05.07.1001|Jingah
62.05.07.1002|Jambu
62.05.07.2003|Liang Naga
62.05.07.2004|Sabuh
62.05.07.2005|Hajak
62.05.07.2006|Malawaken
62.05.07.2007|Sikui
62.05.07.2008|Panaen
62.05.07.2009|Liang Buah
62.05.07.2010|Gandring
62.05.08.2001|Trahean
62.05.08.2002|Trinsing
62.05.08.2003|Bintang Ninggi I
62.05.08.2004|Bintang Ninggi II
62.05.08.2005|Butong
62.05.08.2006|Buntok Baru
62.05.08.2007|Bukit Sawit
62.05.08.2008|Tawan Jaya
62.05.08.2009|Pandran Raya
62.05.08.2010|Pandran Permai
62.05.09.2001|Nihan Hilir
62.05.09.2002|Nihan Hulu
62.05.09.2003|Luwe Hilir
62.05.09.2004|Luwe Hulu
62.05.09.2005|Jangkang Baru
62.05.09.2006|Jangkang Lama
62.05.09.2007|Papar Pujung
62.05.09.2008|Teluk Malewai
62.05.09.2009|Benao Hilir
62.05.09.2010|Benao Hulu
62.05.09.2011|Karamuan
62.06.01.2001|Galinggang
62.06.01.2002|Tampelas
62.06.01.2003|Telaga
62.06.01.2004|Parupuk
62.06.01.2005|Karuing
62.06.01.2006|Jahanjang
62.06.01.2007|Tumbang Runen
62.06.01.2008|Baun Bango
62.06.01.2009|Asem Kumbang
62.06.02.1003|Kasongan Baru
62.06.02.1004|Kasongan Lama
62.06.02.2001|Tewang Kadamba
62.06.02.2002|Tumbang Liting
62.06.02.2005|Talian Kereng
62.06.02.2006|Banut Kalanaman
62.06.02.2007|Talangkah
62.06.02.2008|Hampalit
62.06.03.1006|Pendahara
62.06.03.2001|Tewang Baringin
62.06.03.2002|Hapalam
62.06.03.2003|Tewang Rangas
62.06.03.2004|Bangkuang
62.06.03.2005|Tarusan Danum
62.06.03.2007|Tumbang Tarusan
62.06.03.2008|Tewang Rangkang
62.06.03.2009|Tewang Manyangen
62.06.03.2010|Karya Unggang
62.06.04.2001|Tewang Papari
62.06.04.2002|Tewang Darayu
62.06.04.2003|Buntut Bali
62.06.04.2004|Kuluk Bali
62.06.04.2005|Manduing Taheta
62.06.04.2006|Manduing Lama
62.06.04.2007|Tumbang Banjang
62.06.04.2008|Tumbang Lawang
62.06.04.2009|Dahian Tunggal
62.06.04.2010|Tewang Karangan
62.06.04.2011|Tumbang Tungku
62.06.04.2012|Geragu
62.06.04.2013|Tumbang Tanjung
62.06.04.2014|Tura
62.06.05.1009|Samba Kahayan
62.06.05.2001|Tumbang Lahang
62.06.05.2002|Tewang Panjang
62.06.05.2003|Petak Puti
62.06.05.2004|Telok
62.06.05.2005|Samba Danum
62.06.05.2006|Samba Bakumpai
62.06.05.2007|Samba Katung
62.06.05.2008|Napu Sahur
62.06.05.2010|Batu Badinding
62.06.05.2011|Rantau Asem
62.06.05.2012|Mirah Kalanaman
62.06.05.2013|Tumbang Kalemei
62.06.05.2014|Tumbang Marak
62.06.05.2015|Tumbang Hangei
62.06.05.2016|Tumbang Pariyei
62.06.06.2001|Dehes
62.06.06.2002|Tumbang Labehu
62.06.06.2003|Tumbang Kaman
62.06.06.2004|Tumbang Manggo
62.06.06.2005|Kamanto
62.06.06.2006|Kuluk Habuhus
62.06.06.2007|Tumbang Kanei
62.06.06.2008|Tumbang Taranei
62.06.06.2009|Tumbang Kawei
62.06.06.2010|Tumbang Mangara
62.06.06.2011|Tumbang Pangka
62.06.06.2012|Tumbang Atei
62.06.06.2020|Daya Manunggal
62.06.06.2021|Rantau Bangkiang
62.06.07.2001|Tumbang Mandurei
62.06.07.2002|Tumbang Paku
62.06.07.2003|Buntut Leleng
62.06.07.2004|Kuluk Leleng
62.06.07.2005|Sabaung
62.06.07.2006|Tumbang Malawan
62.06.07.2007|Tumbang Taei
62.06.07.2008|Rangan Surai
62.06.07.2009|Tumbang Hiran
62.06.07.2010|Tumbang Pahanei
62.06.07.2011|Tumbang Dakei
62.06.07.2012|Rangan Burih
62.06.07.2013|Tumbang Bemban
62.06.07.2014|Tumbang Lambi
62.06.07.2015|Rangan Tangko
62.06.07.2016|Tumbang Tundu
62.06.07.2017|Batu Panahan
62.06.07.2018|Tumbang Tabulus
62.06.08.1014|Tumbang Sanamang
62.06.08.2001|Kiham Batang
62.06.08.2002|Tumbang Kabayan
62.06.08.2003|Rangan Kawit
62.06.08.2004|Dehes Asem
62.06.08.2005|Kuluk Sapangi
62.06.08.2006|Tumbang Kuai
62.06.08.2007|Tumbang Salaman
62.06.08.2008|Rantau Puka
62.06.08.2009|Rantau Bahai
62.06.08.2010|Rangan Ranjing
62.06.08.2011|Tumbang Labaning
62.06.08.2012|Batu Bango
62.06.08.2013|Tumbang Hangei II
62.06.08.2015|Sei Nanjan
62.06.08.2016|Tumbang Jiga
62.06.08.2017|Tumbang Mangketai
62.06.08.2019|Tumbang Mahop
62.06.08.2020|Tumbang Sabetung
62.06.08.2030|Penda Tanggaring Lama
62.06.08.2031|Penda Tanggaring Baru
62.06.08.2032|Teluk Tampang
62.06.08.2033|Tumbang Manangei
62.06.09.2001|Mendawai
62.06.09.2002|Teluk Sebulu
62.06.09.2003|Kampung Melayu
62.06.09.2004|Tewang Kampung
62.06.09.2005|Perigi
62.06.09.2006|Mekar Tani
62.06.09.2007|Tumbang Bulan
62.06.10.1001|Pagatan Hilir
62.06.10.1002|Pagatan Hulu
62.06.10.2003|Kampung Keramat
62.06.10.2004|Kampung Tengah
62.06.10.2005|Jaya Makmur
62.06.10.2006|Subur Indah
62.06.10.2007|Kampung Baru
62.06.10.2008|Bangun Jaya
62.06.10.2009|Setia Mulia
62.06.10.2010|Singam Raya
62.06.10.2011|Sebangau Jaya
62.06.10.2012|Sungai Kaki
62.06.10.2013|Selat Baning
62.06.10.2014|Makmur Utama
62.06.10.2015|Bumi Subur
62.06.10.2016|Bakung Raya
62.06.11.2001|Talingke
62.06.11.2002|Hiyang Bana
62.06.11.2003|Petak Bahandang
62.06.11.2004|Handiwung
62.06.11.2005|Tumbang Panggo
62.06.11.2006|Tewang Tampang
62.06.11.2007|Luwuk Kanan
62.06.11.2008|Luwuk Kiri
62.06.12.2001|Tumbang Baraoi
62.06.12.2002|Tumbang Jala
62.06.12.2003|Batu Badak
62.06.12.2004|Batu Tukan
62.06.12.2005|Tumbang Tangoi
62.06.12.2006|Nusa Kutau
62.06.12.2007|Tumbang Habangoi
62.06.13.2001|Tumbang Gaei
62.06.13.2002|Tumbang Kataei
62.06.13.2003|Tumbang Karuei
62.06.13.2004|Tumbang Dahuei
62.06.13.2005|Rantau Pandan
62.06.13.2006|Rangan Rondan
62.06.13.2007|Rangan Bahekang
62.06.13.2008|Tumbang Kajamei
62.06.13.2009|Tumbang Kaburai
62.06.13.2010|Tanjung Batik
62.06.13.2011|Penda Nange
62.07.01.1001|Kuala Pembuang I
62.07.01.1002|Kuala Pembuang II
62.07.01.2005|Pematang Limau
62.07.01.2006|Sungai Perlu
62.07.01.2007|Tanjung Rangas
62.07.01.2008|Muara Dua
62.07.01.2009|Jahitan
62.07.01.2010|Baung
62.07.01.2015|Persil Raya
62.07.01.2016|Sungai Undang
62.07.02.1016|Rantau Pulut
62.07.02.2008|Gantung Pangayuh
62.07.02.2009|Teluk Bayur
62.07.02.2010|Suka Mandang
62.07.02.2011|Ayawan
62.07.02.2012|Mugi Panyuhu
62.07.02.2013|Bukit Buluh
62.07.02.2014|Tumbang Bai
62.07.02.2015|Durian Tunggal
62.07.02.2017|Pangke
62.07.02.2018|Panyumpa
62.07.02.2022|Sukorejo
62.07.02.2023|Bumi Jaya
62.07.02.2024|Suka Jaya
62.07.02.2026|Panca Jaya
62.07.02.2029|Tangga Batu
62.07.02.2030|Ringin Agung
62.07.02.2031|Batu Agung
62.07.02.2032|Suka Makmur
62.07.02.2033|Suka Maju
62.07.03.2001|Telaga Pulang
62.07.03.2002|Cempaka Baru
62.07.03.2003|Palingkau
62.07.03.2004|Ulak Batu
62.07.03.2005|Paren
62.07.03.2006|Banua Usang
62.07.03.2013|Sembuluh I
62.07.03.2014|Sembuluh II
62.07.04.2001|Tanjung Hanau
62.07.04.2002|Parang Batang
62.07.04.2003|Bahaur
62.07.04.2004|Pembuang Hulu I
62.07.04.2005|Pembuang Hulu II
62.07.04.2006|Derangga
62.07.04.2011|Paring Raya
62.07.05.2020|Tumbang Bahan
62.07.05.2021|Tumbang Kalang
62.07.05.2022|Tusuk Belawan
62.07.05.2023|Marandang
62.07.05.2024|Tumbang Suei
62.07.05.2025|Tumbang Manjul
62.07.05.2026|Mojang Baru
62.07.05.2027|Rantau Panjang
62.07.05.2028|Mongoh Juoi
62.07.05.2030|Sepundu Hantu
62.07.05.2031|Tumbang Kubang
62.07.05.2032|Tumbang Laku
62.07.05.2033|Tanjung Paku
62.07.05.2034|Buntut Sapau
62.07.05.2035|Tumbang Taberau
62.07.05.2036|Riam Batang
62.07.05.2037|Tumbang Sepan
62.07.05.2038|Tumbang Setawai
62.07.05.2039|Tumbang Kasai
62.07.05.2040|Tumbang Darap
62.07.06.2001|Mekar Indah
62.07.06.2002|Halimaung Jaya
62.07.06.2003|Bangun Harja
62.07.06.2004|Kartika Bhakti
62.07.06.2005|Pematang Panjang
62.07.06.2006|Sungai Bakau
62.07.07.2001|Terawan
62.07.07.2002|Selunuk
62.07.07.2003|Lanpasa
62.07.07.2005|Bangkal
62.07.07.2006|Tabiku
62.07.08.2001|Asam Baru
62.07.08.2002|Tanjung Hara
62.07.08.2003|Tanjung Paring
62.07.08.2004|Tanjung Rangas II
62.07.08.2005|Panimba Raya
62.07.08.2006|Rungau Raya
62.07.09.2001|Sebabi
62.07.09.2002|Sandul
62.07.09.2003|Kalang
62.07.09.2004|Derawa
62.07.09.2005|Wana Tirta
62.07.09.2006|Suka Mulya
62.07.09.2007|Durian Kait
62.07.09.2008|Sahabu
62.07.09.2009|Batu Menangis
62.07.10.2001|Tumbang Magin
62.07.10.2002|Tumbang Setoli
62.07.10.2003|Tumbang Hentas
62.07.10.2004|Tumbang Langkai
62.07.10.2005|Tumbang Salau
62.07.10.2006|Tumbang Gugup
62.07.10.2007|Rangkang Munduk
62.07.10.2008|Tanjung Tukal
62.07.10.2009|Rantau Betung
62.08.01.1003|Mendawai
62.08.01.1004|Padang
62.08.01.2001|Natai Sedawak
62.08.01.2002|Pudu
62.08.01.2005|Kartamulia
62.08.01.2006|Sukaraja
62.08.01.2007|Pangkalan Muntai
62.08.01.2008|Petarikan
62.08.02.1001|Kuala Jelai
62.08.02.2002|Pulau Nibung
62.08.02.2003|Sungai Baru
62.08.02.2004|Sungai Bundung
62.08.02.2005|Sungai Raja
62.08.03.2001|Jihing
62.08.03.2002|Air Dua
62.08.03.2005|Lupu Peruca
62.08.03.2006|Balai Riam
62.08.03.2007|Pempaning
62.08.03.2011|Sekuningan Baru
62.08.03.2012|Bangun Jaya
62.08.03.2013|Bukit Sungkai
62.08.04.2001|Sungai Damar
62.08.04.2002|Sungai Tabuk
62.08.04.2003|Sungai Cabang Barat
62.08.04.2004|Sungai Pasir
62.08.05.2001|Kenawan
62.08.05.2002|Laman Baru
62.08.05.2003|Ajang
62.08.05.2004|Semantun
62.08.05.2005|Nibung Terjun
62.08.05.2006|Natai Kondang
62.08.05.2007|Sembikuan
62.09.01.1012|Tapin Bini
62.09.01.2001|Sungai Tuat
62.09.01.2002|Tanjung Beringin
62.09.01.2003|Cuhai
62.09.01.2004|Kawa
62.09.01.2005|Karang Taba
62.09.01.2006|Penopa
62.09.01.2007|Suja
62.09.01.2008|Sekoban
62.09.01.2009|Bakonsu
62.09.01.2022|Samu Jaya
62.09.02.1017|Kudangan
62.09.02.2004|Riam Panahan
62.09.02.2005|Sepoyu
62.09.02.2010|Nyalang
62.09.02.2011|Riam Tinggi
62.09.02.2012|Landau Kantu
62.09.02.2013|Lopus
62.09.02.2014|Kubung
62.09.02.2015|Sekombulan
62.09.02.2016|Penyombaan
62.09.02.2020|Hulu Jojabo
62.09.03.1005|Nanga Bulik
62.09.03.2001|Sungai Mentawa
62.09.03.2002|Guci
62.09.03.2003|Batu Kotam
62.09.03.2004|Kujan
62.09.03.2006|Bunut
62.09.03.2007|Beruta
62.09.03.2008|Tamiang
62.09.03.2031|Bumi Agung
62.09.03.2032|Sumber Mulya
62.09.03.2036|Bukit Indah
62.09.03.2037|Arga Mulya
62.09.03.2043|Perigi Raya
62.09.03.2044|Nanga Pamalontian
62.09.04.2001|Nanga Palikodan
62.09.04.2002|Sungkup
62.09.04.2003|Nuangan
62.09.04.2004|Nanga Koring
62.09.04.2005|Toka
62.09.04.2006|Sepondam
62.09.04.2007|Merambang
62.09.04.2008|Pedongatan
62.09.04.2009|Batu Tunggal
62.09.04.2010|Nanga Kemujan
62.09.04.2011|Bukit Jaya
62.09.04.2012|Suka Maju
62.09.05.2001|Melata
62.09.05.2002|Nanuah
62.09.05.2003|Batu Ampar
62.09.05.2004|Lubuk Hiju
62.09.05.2005|Topalan
62.09.05.2006|Bukit Makmur
62.09.05.2007|Modang Mas
62.09.05.2008|Bukit Raya
62.09.05.2009|Mukti Manunggal
62.09.05.2010|Sumber Jaya
62.09.05.2011|Bukit Harum
62.09.06.2001|Bina Bhakti
62.09.06.2002|Wonorejo
62.09.06.2003|Mekar Mulya
62.09.06.2004|Jangkar Prima
62.09.06.2005|Purwareja
62.09.06.2006|Tri Tunggal
62.09.06.2007|Batu Hambawang
62.09.06.2008|Rimba Jaya
62.09.07.2001|Nanga Belantikan
62.09.07.2002|Sungai Buluh
62.09.07.2003|Tangga Batu
62.09.07.2004|Belibi
62.09.07.2005|Bayat
62.09.07.2006|Karang Besi
62.09.07.2007|Benuatan
62.09.07.2008|Kahingai
62.09.07.2009|Nanga Matu
62.09.07.2010|Bintang Mangalih
62.09.07.2011|Petarikan
62.09.07.2012|Sumber Cahaya
62.09.08.2001|Batu Tambun
62.09.08.2002|Kinipan
62.09.08.2003|Ginih
62.09.08.2004|Benakitan
62.09.08.2005|Liku
62.09.08.2006|Mengkalang
62.09.08.2007|Karang Mas
62.09.08.2008|Kina
62.09.08.2009|Jamuat
62.10.01.1001|Sepang Simin
62.10.01.2002|Sepang Kota
62.10.01.2003|Tewai Baru
62.10.01.2004|Tanjung Karitak
62.10.01.2011|Pamatang Limau
62.10.01.2012|Tampelas
62.10.01.2014|Rabauh
62.10.02.1001|Tampang Tumbang Anjir
62.10.02.1012|Kurun
62.10.02.2002|Petak Bahandang
62.10.02.2003|Tanjung Riu
62.10.02.2004|Teluk Nyatu
62.10.02.2005|Tumbang Lampahung
62.10.02.2006|Tewang Pajangan
62.10.02.2007|Tumbang Tariak
62.10.02.2008|Tumbang Miwan
62.10.02.2009|Hurung Bunut
62.10.02.2010|Tumbang Hakau
62.10.02.2011|Pilang Munduk
62.10.02.2013|Tumbang Manyangan
62.10.02.2014|Penda Pilang
62.10.02.2015|Tumbang Tambirah
62.10.03.1005|Tewah
62.10.03.2001|Sare Rangan
62.10.03.2002|Tumbang Pajangei
62.10.03.2003|Kasintu
62.10.03.2004|Batu Nyiwuh
62.10.03.2006|Tumbang Habaon
62.10.03.2007|Sei Riang
62.10.03.2008|Sandung Tambun
62.10.03.2009|Tanjung Untung
62.10.03.2010|Upon Batu
62.10.03.2011|Sumur Mas
62.10.03.2012|Batu Nyapau
62.10.03.2013|Taja Urap
62.10.03.2014|Teluk Lawah
62.10.03.2015|Karason Raya
62.10.03.2016|Rangan Mihing
62.10.04.1001|Tumbang Miri
62.10.04.2002|Batu Tangkoi
62.10.04.2005|Penda Rangas
62.10.04.2006|Tumbang Sian
62.10.04.2008|Tumbang Pasangon
62.10.04.2012|Tumbang Korik
62.10.04.2014|Tumbang Ponyoi
62.10.04.2019|Dandang
62.10.04.2020|Tumbang Hamputung
62.10.04.2021|Tumbang Tajungan
62.10.04.2028|Tumbang Takaoi
62.10.04.2029|Teluk Kanduri
62.10.05.1021|Jakatan Raya
62.10.05.2001|Tumbang Jutuh
62.10.05.2002|Tumbang Baringei
62.10.05.2009|Tumbang Malahoi
62.10.05.2014|Tumbang Bunut
62.10.05.2015|Tumbang Kajuei
62.10.05.2016|Luwuk Kantor
62.10.05.2017|Luwuk Langkuas
62.10.05.2018|Talangkah
62.10.05.2019|Parempei
62.10.05.2020|Linau
62.10.05.2022|Bereng Baru
62.10.05.2023|Bereng Malaka
62.10.05.2027|Karya Bhakti
62.10.06.1001|Tumbang Talaken
62.10.06.2002|Tumbang Sepan
62.10.06.2003|Tangki Dahuyan
62.10.06.2004|Bereng Balawan
62.10.06.2005|Bereng Jun
62.10.06.2006|Takaras
62.10.06.2012|Belawan Mulia
62.10.06.2013|Taringen
62.10.06.2014|Bangun Sari
62.10.06.2015|Fajar Harapan
62.10.06.2017|Gohong
62.10.06.2018|Tumbang Jalemu
62.10.07.1005|Kampuri
62.10.07.2001|Tuyun
62.10.07.2002|Tumbang Empas
62.10.07.2003|Rangan Tate
62.10.07.2004|Dahian Tambuk
62.10.07.2006|Tumbang Danau
62.10.08.1008|Tumbang Marikoi
62.10.08.2001|Lawang Kanji
62.10.08.2002|Tumbang Mahuroi
62.10.08.2003|Karetau Rambangun
62.10.08.2004|Karetau Sarian
62.10.08.2005|Tumbang Posu
62.10.08.2006|Tumbang Maraya
62.10.08.2007|Tumbang Anoi
62.10.09.1003|Tumbang Napoi
62.10.09.2001|Tumbang Siruk
62.10.09.2002|Mangkuhung
62.10.09.2004|Tumbang Masukih
62.10.09.2005|Rangan Hiran
62.10.09.2006|Harowu
62.10.09.2007|Tumbang Manyoi
62.10.09.2008|Tumbang Lapan
62.10.09.2009|Buntoi
62.10.09.2010|Tumbang Koroi
62.10.09.2011|Tumbang Hatung
62.10.10.1004|Tumbang Rahuyan
62.10.10.2001|Jangkit
62.10.10.2002|Tumbang Lapan
62.10.10.2003|Batu Puter
62.10.10.2005|Sei Antai
62.10.10.2006|Hantapang
62.10.10.2007|Sangal
62.10.10.2008|Tumbang Tuwe Hantapang
62.10.10.2012|Tumbang Mujai
62.10.11.1005|Tehang
62.10.11.2002|Tumbang Samui
62.10.11.2003|Tumbang Oroi
62.10.11.2004|Luwuk Tukau
62.10.11.2006|Putat Durei
62.10.11.2007|Tumbang Mantuhe
62.10.12.1006|Rabambang
62.10.12.2001|Hujung Pata
62.10.12.2002|Tumbang Jalemu Kajuei
62.10.12.2003|Jalemu Raya
62.10.12.2004|Jalemu Masulan
62.10.12.2005|Mangkawuk
62.10.12.2007|Tajah Antang Raya
62.10.12.2008|Tumbang Kuayan
62.10.12.2009|Tumbang Langgah
62.10.12.2010|Tusang Raya
62.10.12.2011|Tumbang Bahanei
62.11.01.2001|Dandang
62.11.01.2002|Talio
62.11.01.2003|Pangkoh Hilir
62.11.01.2004|Pangkoh Hulu
62.11.01.2005|Kantan Muara
62.11.01.2006|Talio Muara
62.11.01.2007|Talio Hulu
62.11.01.2008|Pangkoh Sari
62.11.01.2009|Sanggang
62.11.01.2010|Pantik
62.11.01.2011|Belanti Siam
62.11.01.2012|Gadabung
62.11.01.2013|Mulyasari
62.11.01.2014|Kantan Dalam
62.11.01.2015|Kantan Atas
62.11.01.2016|Karya Bersama
62.11.02.1018|Bahaur Basantan
62.11.02.2001|Cemantan
62.11.02.2002|Papuyu II Sei. Barunai
62.11.02.2003|Kiapak
62.11.02.2005|Papuyu I Sei Pasaman
62.11.02.2006|Sei. Rungun
62.11.02.2007|Bahaur Hilir
62.11.02.2008|Bahaur Tengah
62.11.02.2009|Bahaur Hulu
62.11.02.2014|Papuyu III Sei. Pudak
62.11.02.2015|Tanjung Perawan
62.11.02.2016|Bahaur Hulu Permai
62.11.02.2017|Bahaur Batu Raya
62.11.03.2001|Tanjung Sangalang
62.11.03.2002|Penda Barania
62.11.03.2003|Bukit Rawi
62.11.03.2004|Tuwung
62.11.03.2005|Sigi
62.11.03.2006|Petuk Liti
62.11.03.2007|Bukit Liti
62.11.03.2008|Bahu Palawa
62.11.03.2009|Pamarunan
62.11.03.2010|Balukon
62.11.03.2011|Bukit Bamba
62.11.03.2012|Tahawa
62.11.03.2013|Parahangan
62.11.03.2014|Bereng Rambang
62.11.04.2001|Manen Paduran
62.11.04.2002|Manen Kaleka
62.11.04.2003|Lawang Uru
62.11.04.2004|Hurung
62.11.04.2005|Hanua
62.11.04.2006|Ramang
62.11.04.2007|Tambak
62.11.04.2008|Pahawan
62.11.04.2009|Goha
62.11.04.2010|Bawan
62.11.04.2011|Tumbang Tarusan
62.11.04.2012|Pandawei
62.11.04.2013|Pangi
62.11.04.2014|Tangkahen
62.11.04.2015|Kasali Baru
62.11.05.1005|Pulang Pisau
62.11.05.1015|Kalawa
62.11.05.1016|Bereng
62.11.05.2001|Buntoi
62.11.05.2002|Mintin
62.11.05.2003|Mantaren I
62.11.05.2004|Anjir Pulang Pisau
62.11.05.2006|Gohong
62.11.05.2014|Mantaren II
62.11.05.2017|Hanjak Maju
62.11.06.2001|Tahai Jaya
62.11.06.2002|Purwodadi
62.11.06.2003|Wono Agung
62.11.06.2004|Kanamit Barat
62.11.06.2005|Sei Baru Tewu
62.11.06.2006|Kanamit
62.11.06.2007|Garantung
62.11.06.2008|Gandang
62.11.06.2009|Badirih
62.11.06.2010|Tahai Baru
62.11.06.2011|Maliku Baru
62.11.06.2012|Sidodadi
62.11.06.2013|Kanamit Jaya
62.11.06.2014|Gandang Barat
62.11.06.2015|Maliku Mulia
62.11.07.2001|Garung
62.11.07.2002|Henda
62.11.07.2003|Simpur
62.11.07.2004|Sakakajang
62.11.07.2005|Jabiren
62.11.07.2006|Pilang
62.11.07.2007|Tumbang Nusa
62.11.07.2008|Tanjung Taruna
62.11.08.2001|Paduran Sebangau
62.11.08.2002|Paduran Mulya
62.11.08.2003|Sebangau Mulya
62.11.08.2004|Sebangau Permai
62.11.08.2005|Mekar Jaya
62.11.08.2006|Sebangau Jaya
62.11.08.2007|Sei Hambawang
62.11.08.2008|Sei Bakau
62.12.01.1012|Puruk Cahu
62.12.01.1013|Beriwit
62.12.01.2001|Dirung
62.12.01.2002|Malasan
62.12.01.2003|Batu Putih
62.12.01.2004|Mangkahui
62.12.01.2005|Panu'ut
62.12.01.2006|Muara Untu
62.12.01.2007|Muara Ja'an
62.12.01.2008|Bahitom
62.12.01.2009|Danau Usung
62.12.01.2010|Juking Pajang
62.12.01.2011|Muara Sumpoi
62.12.01.2014|Muara Bumban
62.12.01.2015|Penyang
62.12.02.1014|Saripoi
62.12.02.2007|Sungai Lunuk
62.12.02.2008|Konut
62.12.02.2009|Belawan
62.12.02.2010|Mangkolisoi
62.12.02.2011|Kalang Kaluh
62.12.02.2012|Mantiat Pari
62.12.02.2013|Olung Ulu
62.12.02.2015|Puruk Batu
62.12.02.2016|Olung Siron
62.12.02.2017|Tino Talih
62.12.02.2018|Olung Nango
62.12.02.2019|Mahanyan
62.12.02.2020|Dirung Bakung
62.12.02.2021|Tabulang
62.12.02.2022|Cangkang
62.12.02.2023|Olung Dojou
62.12.02.2024|Doan Arung
62.12.02.2025|Muwun
62.12.02.2026|Nono Kliwon
62.12.02.2027|Kolam
62.12.02.2028|Saruhung
62.12.02.2029|Olung Soloi
62.12.02.2030|Tokung
62.12.02.2031|Olung Balo
62.12.02.2032|Karali
62.12.02.2033|Osom Tompok
62.12.03.1003|Muara Laung I
62.12.03.1006|Muara Tuhup
62.12.03.1031|Batu Bua I
62.12.03.2001|Batu Tuhup
62.12.03.2002|Tumbang Bahan
62.12.03.2004|Muara Laung II
62.12.03.2005|Beras Balange
62.12.03.2010|Pelaci
62.12.03.2011|Biha
62.12.03.2012|Dirung Pundu
62.12.03.2013|Dirung Pinang
62.12.03.2014|Muara Tupuh
62.12.03.2015|Narui
62.12.03.2016|Tumbang Bana
62.12.03.2017|Lakutan
62.12.03.2018|Tawai Haui
62.12.03.2026|Penda Siron
62.12.03.2027|Muara Maruwei I
62.12.03.2028|Muara Maruwei II
62.12.03.2029|Beralang
62.12.03.2030|Kalang Dohong
62.12.03.2032|Batu Bua II
62.12.03.2033|Tahujan Laung
62.12.03.2034|Tumbang Bondang
62.12.03.2035|Tumbang Tonduk
62.12.03.2037|Batu Karang
62.12.04.1004|Muara Bakanon
62.12.04.1006|Tumbang Lahung
62.12.04.2001|Sungai Gula
62.12.04.2002|Sungai Batang
62.12.04.2003|Tumbang Salio
62.12.04.2005|Purnama
62.12.04.2007|Sungai Lobang
62.12.04.2008|Pantai Laga
62.12.04.2009|Baratu
62.12.04.2010|Juking Sopan
62.12.04.2011|Muara Babuat
62.12.04.2018|Sungai Bakanon
62.12.05.1004|Tumbang Kunyi
62.12.05.2001|Kalapeh Baru
62.12.05.2002|Tumbang Masao
62.12.05.2003|Batu Makap
62.12.05.2005|Olong Liko
62.12.05.2006|Teluk Jolo
62.12.05.2007|Laas Baru
62.12.05.2018|Tumbang Molut
62.12.05.2020|Tumbang Tuan
62.12.06.2001|Bumban Tuhup
62.12.06.2002|Makunjung
62.12.06.2003|Dirung Sararong
62.12.06.2004|Kohong
62.12.06.2005|Hingan Tokung
62.12.06.2006|Liang Nyaling
62.12.06.2007|Tumbang Bauh
62.12.06.2008|Tumbang Masalo
62.12.06.2009|Batu Tojah
62.12.06.2010|Tumbang Baloi
62.12.06.2011|Cinta Budiman
62.12.07.2001|Oreng
62.12.07.2002|Olung Muro
62.12.07.2003|Olung Hanangan
62.12.07.2004|Dirung Lingkin
62.12.07.2005|Datah Kotou
62.12.07.2006|Tahujan Ontu
62.12.07.2007|Puruk Kambang
62.12.08.2001|Batu Mirau
62.12.08.2002|Tambelum
62.12.08.2003|Tumbang Bantian
62.12.08.2004|Tumbang Saan
62.12.08.2005|Tumbang Kolon
62.12.08.2006|Tumbang Apat
62.12.09.2001|Tumbang Tohan
62.12.09.2002|Tumbang Naan
62.12.09.2003|Muara Joloi I
62.12.09.2004|Muara Joloi II
62.12.09.2005|Parahau
62.12.09.2006|Tumbang Jojang
62.12.09.2007|Takajung
62.12.10.2001|Tumbang Tujang
62.12.10.2002|Tumbang Olong I
62.12.10.2003|Kalasin
62.12.10.2004|Tumbang Topus
62.12.10.2005|Tumbang Olong II
62.13.01.1012|Tamiang Layang
62.13.01.2003|Pulau Patai
62.13.01.2004|Sarapat
62.13.01.2005|Magantis
62.13.01.2006|Jaar
62.13.01.2007|Matabu
62.13.01.2008|Dorong
62.13.01.2009|Didi
62.13.01.2010|Karang Langit
62.13.01.2011|Haringen
62.13.01.2018|Jaweten
62.13.01.2019|Matarah
62.13.01.2020|Maragut
62.13.01.2021|Mangkarap
62.13.01.2022|Gumpa
62.13.01.2023|Sumur
62.13.01.2024|Harara
62.13.02.1001|Pasar Panas/Taniran
62.13.02.2002|Kandris
62.13.02.2003|Banyu Landas
62.13.02.2004|Bagok
62.13.02.2005|Bamban
62.13.02.2006|Tewah Pupuh
62.13.02.2007|Gudang Seng
62.13.03.2001|Pulau Padang
62.13.03.2002|Kambitin
62.13.03.2003|Ramania
62.13.03.2004|Bentot
62.13.03.2005|Ampari Bura
62.13.03.2006|Kotam
62.13.03.2008|Betang Nalong
62.13.03.2009|Mawani
62.13.03.2010|Jango
62.13.03.2011|Lalap
62.13.04.2001|Janah Jari
62.13.04.2002|Bangkirayen
62.13.04.2003|Hayaping
62.13.04.2004|Tangkan
62.13.04.2005|Wungkur Nanakan
62.13.04.2006|Ampari
62.13.04.2007|Apar Batu
62.13.04.2008|Biwan
62.13.04.2009|Janah Mansiwui
62.13.04.2010|Danau
62.13.04.2011|Pianggu
62.13.05.1011|Ampah Kota
62.13.05.2008|Saing
62.13.05.2009|Rodok
62.13.05.2010|Ampah II
62.13.05.2012|Putai
62.13.05.2018|Netampin
62.13.05.2024|Sumber Garunggung
62.13.05.2025|Muara Awang
62.13.06.2001|Muara Palantau
62.13.06.2002|Ketab
62.13.06.2003|Kupang Bersih
62.13.06.2004|Tuyau
62.13.06.2005|Pinang Tunggal
62.13.06.2006|Nagaleah
62.13.06.2007|Lampeong
62.13.06.2008|Bararawa
62.13.06.2009|Bambulung
62.13.06.2010|Lebo
62.13.06.2011|Muru Duyung
62.13.06.2012|Tumpung Ulung
62.13.06.2013|Sumber Rejo
62.13.07.2001|Juru Banu
62.13.07.2002|Telang Baru
62.13.07.2003|Tampu Langit
62.13.07.2004|Telang
62.13.07.2005|Maipe
62.13.07.2006|Murutuwu
62.13.07.2007|Balawa
62.13.07.2008|Kali Napu
62.13.07.2009|Siong
62.13.08.2001|Puri
62.13.08.2002|Lenggang
62.13.08.2003|Batuah
62.13.08.2004|Unsum
62.13.08.2005|Baruyan
62.13.08.2006|Turan Amis
62.13.08.2007|Malintut
62.13.08.2008|Tangkum
62.13.08.2009|Sibung
62.13.09.2001|Tampa
62.13.09.2002|Kalamus
62.13.09.2003|Simpang Bingkuang
62.13.09.2004|Patung
62.13.09.2005|Runggu Raya
62.13.09.2006|Bantai Napu
62.13.09.2007|Tarinsing
62.13.09.2008|Paku Beto
62.13.09.2009|Gandrung
62.13.09.2010|Pangkan
62.13.09.2011|Kupang Baru
62.13.09.2012|Luau Jawuk
62.13.10.2001|Dayu
62.13.10.2002|Wuran
62.13.10.2003|Ipu Mea
62.13.10.2004|Lagan
62.13.10.2005|Putut Tawuluh
62.13.10.2006|Simpang Naneng
62.13.10.2007|Kandris
62.71.01.1001|Pahandut
62.71.01.1002|Panarung
62.71.01.1003|Langkai
62.71.01.1004|Tumbang Rungan
62.71.01.1005|Pahandut Seberang
62.71.01.1006|Tanjung Pinang
62.71.02.1001|Marang
62.71.02.1002|Tumbang Tahai
62.71.02.1003|Banturung
62.71.02.1004|Tangkiling
62.71.02.1005|Sei Gohong
62.71.02.1006|Kanarakan
62.71.02.1007|Habaring Hurung
62.71.03.1001|Palangka
62.71.03.1002|Menteng
62.71.03.1003|Bukit Tunggal
62.71.03.1004|Petuk Katimpun
62.71.04.1001|Bereng Bengkel
62.71.04.1002|Kalampangan
62.71.04.1003|Kereng Bangkirai
62.71.04.1004|Kameloh Baru
62.71.04.1005|Danau Tundai
62.71.04.1006|Sabaru
62.71.05.1001|Petuk Bukit
62.71.05.1002|Panjehang
62.71.05.1003|Petuk Barunai
62.71.05.1004|Mungku Baru
62.71.05.1005|Pager
62.71.05.1006|Gaung Baru
62.71.05.1007|Bukit Sua
63.01.01.2001|Benua Lawas
63.01.01.2002|Tabanio
63.01.01.2003|Kuala Tambangan
63.01.01.2004|Takisung
63.01.01.2005|Gunung Makmur
63.01.01.2006|Benua Tengah
63.01.01.2007|Ranggang
63.01.01.2008|Pagatan Besar
63.01.01.2009|Batilai
63.01.01.2010|Ranggang Dalam
63.01.01.2011|Telaga langsat
63.01.01.2012|Sumber Makmur
63.01.02.2001|Sabuhur
63.01.02.2002|Jorong
63.01.02.2003|Asam-Asam
63.01.02.2004|Batalang
63.01.02.2005|Swarangan
63.01.02.2006|Muara Asam-Asam
63.01.02.2007|Alur
63.01.02.2008|Asri Mulya
63.01.02.2009|Karang Rejo
63.01.02.2010|Asam Jaya
63.01.02.2011|Simpang Empat
63.01.03.1001|Sarang Halang
63.01.03.1002|Karang Taruna
63.01.03.1003|Pelaihari
63.01.03.1004|Angsau
63.01.03.1005|Pabahanan
63.01.03.2006|Bumi Jaya
63.01.03.2008|Sungai Riam
63.01.03.2009|Tampang
63.01.03.2010|Telaga
63.01.03.2011|Panjaratan
63.01.03.2012|Atu-atu
63.01.03.2015|Panggung
63.01.03.2016|Tungkaran
63.01.03.2017|Ujung Batu
63.01.03.2020|Panggung Baru
63.01.03.2024|Ambungan
63.01.03.2025|Guntung Besar
63.01.03.2026|Kampung Baru
63.01.03.2027|Sumber Mulia
63.01.03.2029|Pemuda
63.01.04.2001|Sungai Bakau
63.01.04.2002|Maluka Baulin
63.01.04.2003|Bawah Layung
63.01.04.2004|Tambak Sarinah
63.01.04.2005|Kali Besar
63.01.04.2006|Handil Negara
63.01.04.2007|Padang Luas
63.01.04.2008|Kurau
63.01.04.2017|Tambak Karya
63.01.04.2018|Raden
63.01.04.2019|Sarikandi
63.01.05.2001|Benua Raya
63.01.05.2002|Bati-Bati
63.01.05.2003|Ujung
63.01.05.2004|Liang Anggang
63.01.05.2005|Bentok Kampung
63.01.05.2006|Bentok Darat
63.01.05.2007|Banyu Irang
63.01.05.2008|Nusa Indah
63.01.05.2009|Pandahan
63.01.05.2010|Padang
63.01.05.2011|Ujung Baru
63.01.05.2012|Sambangan
63.01.05.2013|Kait-kait
63.01.05.2014|Kait-kait Baru
63.01.06.2001|Batu Tungku
63.01.06.2002|Panyipatan
63.01.06.2003|Kandangan Baru
63.01.06.2004|Kandangan Lama
63.01.06.2005|Batakan
63.01.06.2006|Kuringkit
63.01.06.2007|Tanjung Dewa
63.01.06.2008|Suka Ramah
63.01.06.2009|Batu Mulya
63.01.06.2010|Bumi Asih
63.01.07.2001|Pandan Sari
63.01.07.2002|Kintap
63.01.07.2003|Kintapura
63.01.07.2004|Sungai Cuka
63.01.07.2005|Riam Adungan
63.01.07.2006|Muara Kintap
63.01.07.2007|Salaman
63.01.07.2008|Kintap Kecil
63.01.07.2009|Pasir Putih
63.01.07.2010|Sumber Jaya
63.01.07.2011|Bukit Mulia
63.01.07.2012|Kebun Raya
63.01.07.2013|Mekar Sari
63.01.07.2014|Sebamban Baru
63.01.08.2001|Tambang Ulang
63.01.08.2002|Sungai Pinang
63.01.08.2003|Martadah
63.01.08.2004|Sungai Jelai
63.01.08.2005|Bingkulu
63.01.08.2006|Gunung Raja
63.01.08.2007|Pulau Sari
63.01.08.2008|Kayu Abang
63.01.08.2009|Martadah Baru
63.01.09.2001|Batu Ampar
63.01.09.2002|Gunung Mas
63.01.09.2003|Tajau Mulya
63.01.09.2004|Jilatan
63.01.09.2005|Durian Bungkuk
63.01.09.2006|Ambawang
63.01.09.2007|Damit
63.01.09.2008|Gunung Melati
63.01.09.2009|Bluru
63.01.09.2010|Pantai Linuh
63.01.09.2011|Damit Hulu
63.01.09.2012|Jilatan Alur
63.01.09.2013|Damar Lima
63.01.09.2014|Tajau Pecah
63.01.10.2001|Bajuin
63.01.10.2002|Sungai Bakar
63.01.10.2003|Ketapang
63.01.10.2004|Tirta Jaya
63.01.10.2005|Galam
63.01.10.2006|Pemalongan
63.01.10.2007|Kunyit
63.01.10.2008|Tebing Siring
63.01.10.2009|Tanjung
63.01.11.2001|Handil Babirik
63.01.11.2002|Kurau Utara
63.01.11.2003|Bumi Harapan
63.01.11.2004|Sungai Rasau
63.01.11.2005|Pantai Harapan
63.01.11.2006|Handil Suruk
63.01.11.2007|Handil Gayam
63.01.11.2008|Handil Birayang Atas
63.01.11.2009|Handil Birayang Bawah
63.01.11.2010|Handil Maluka
63.01.11.2011|Handil Labuan Amas
63.02.01.2001|Labuan Barat
63.02.01.2002|Teluk Sungai
63.02.01.2003|Maradapan
63.02.01.2004|Tengah
63.02.01.2005|Tanjung Nyiur
63.02.02.2005|Lontar Selatan
63.02.02.2006|Lontar Timur
63.02.02.2007|Sebanti
63.02.02.2008|Sepagar
63.02.02.2009|Semaras
63.02.02.2012|Terangkih
63.02.02.2015|Gemuruh
63.02.02.2017|Tapian Balai
63.02.02.2018|Lontar Utara
63.02.02.2021|Sumber Sari
63.02.02.2022|Subur Makmur
63.02.03.2006|Teluk Sirih
63.02.03.2007|Sungai Bahim
63.02.03.2008|Tanjung Seloka
63.02.03.2009|Tanjung Serudung
63.02.03.2011|Alle-Alle
63.02.03.2013|Sungai Bulan
63.02.03.2015|Labuan Mas
63.02.03.2016|Tanjung Seloka Utara
63.02.04.2001|Batu Tunau
63.02.04.2002|Sejakah
63.02.04.2003|Bekambit
63.02.04.2004|Langkang Baru
63.02.04.2005|Langkang Lama
63.02.04.2006|Sungai Limau
63.02.04.2007|Berangas
63.02.04.2008|Tanjung Pengharapan
63.02.04.2009|Betung
63.02.04.2010|Teluk Mesjid
63.02.04.2011|Teluk Gosong
63.02.04.2012|Kulipak
63.02.04.2013|Karangsari Indah
63.02.04.2014|Bekambit Asri
63.02.05.2001|Sekapung
63.02.05.2002|Kanibungan
63.02.05.2003|Mandin
63.02.05.2004|Serakaman
63.02.05.2005|Sungai Bali
63.02.05.2006|Balambus
63.02.05.2007|Rampa
63.02.05.2008|Ujung
63.02.06.1001|Kotabaru Hulu
63.02.06.2009|Megasari
63.02.06.2010|Sebelimbingan
63.02.06.2011|Stagen
63.02.06.2012|Rampa
63.02.06.2013|Sungai Taib
63.02.06.2014|Semayap
63.02.06.2015|Dirgahayu
63.02.06.2022|Gunung Ulin
63.02.06.2025|Gunung Sari
63.02.07.2004|Tanjung Pangga
63.02.07.2005|Pembelacanan
63.02.07.2006|Sungai Nipah
63.02.07.2007|Pantai
63.02.07.2009|Sangking Baru
63.02.07.2014|Suka Maju
63.02.07.2015|Sungai Kupang Jaya
63.02.07.2016|Pantai Baru
63.02.07.2017|Bumi Asih
63.02.08.2001|Cantung Kiri Hilir
63.02.08.2002|Karang Payau
63.02.08.2003|Banua Lawas
63.02.08.2004|Sungai Kupang
63.02.08.2005|Bangkalaan Melayu
63.02.08.2006|Bangkalaan Dayak
63.02.08.2007|Laburan
63.02.08.2008|Karang Liwar
63.02.08.2009|Mangkirana
63.02.08.2010|Sidomulyo
63.02.09.2001|Tanjung Batu
63.02.09.2002|Sungai Punggawa
63.02.09.2003|Tanah Rata
63.02.09.2004|Sebuli
63.02.09.2005|Sembilang
63.02.09.2006|Tamiang Bakung
63.02.09.2007|Sang-Sang
63.02.09.2011|Sungai Pinang
63.02.09.2012|Tanjung Selayar
63.02.09.2013|Senakin Seberang
63.02.09.2014|Senakin
63.02.09.2016|Tebing Tinggi
63.02.09.2017|Geronggang
63.02.10.2001|Sungai Hanyar
63.02.10.2002|Sungai Seluang
63.02.10.2003|Pudi
63.02.10.2004|Mangga
63.02.10.2005|Wilas
63.02.10.2006|Pudi Seberang
63.02.10.2007|Sulangkit
63.02.11.2001|Sekandis
63.02.11.2002|Gunung Calang
63.02.11.2003|Talusi
63.02.11.2004|Sakalimau
63.02.11.2005|Tanjung Samalantakan
63.02.11.2006|Sakadoyan
63.02.11.2007|Rampa Cengal
63.02.11.2008|Sesulung
63.02.11.2009|Pondok Labu
63.02.11.2010|Mulyodadi
63.02.11.2011|Sukadana
63.02.12.2001|Sepapah
63.02.12.2002|Sungai Betung
63.02.12.2003|Basuang
63.02.12.2004|Gunung Batu Besar
63.02.12.2005|Sampanahan
63.02.12.2006|Rampa Manunggul
63.02.12.2007|Papaan
63.02.12.2008|Sampanahan Hilir
63.02.12.2009|Banjarsari
63.02.12.2010|Sukamaju
63.02.13.2002|Bepara
63.02.13.2004|Betung
63.02.13.2005|Sekayu Baru
63.02.13.2006|Bakau
63.02.13.2007|Binturung
63.02.13.2008|Harapan Baru
63.02.13.2009|Balaimea
63.02.13.2010|Tamiang
63.02.13.2011|Kalian
63.02.13.2012|Mulyoharjo
63.02.13.2013|Pamukan Indah
63.02.13.2014|Wonorejo
63.02.13.2015|Lintang Jaya
63.02.14.2001|Hampang
63.02.14.2002|Cantung Kiri Hulu
63.02.14.2003|Cantung Kanan
63.02.14.2004|Muara Orie
63.02.14.2005|Lalapin
63.02.14.2006|Peramasan Dua Kali Sanga
63.02.14.2007|Limbur
63.02.14.2008|Hulu Sampanahan
63.02.14.2009|Limbungan
63.02.15.2001|Buluh Kuning
63.02.15.2002|Gendang Timburu
63.02.15.2004|Manunggul Lama
63.02.15.2006|Rantau Buda
63.02.15.2007|Manunggul Baru
63.02.15.2008|Terombong Sari
63.02.15.2009|Rantau Jaya
63.02.16.2001|Semisir
63.02.16.2002|Sungai Pasir
63.02.16.2003|Mekarpura
63.02.16.2004|Selaru
63.02.16.2005|Sungup Kanan
63.02.16.2006|Pantai Baru
63.02.16.2007|Salino
63.02.17.2001|Serongga
63.02.17.2002|Tarjun
63.02.17.2003|Langadai
63.02.17.2004|Pulau Panci
63.02.17.2005|Pelajau Baru
63.02.17.2006|Tegal Rejo
63.02.17.2007|Mandala
63.02.17.2008|Telagasari
63.02.17.2009|Sahapi
63.02.18.2001|Siayuh
63.02.18.2002|Bungkukan
63.02.18.2003|Batang Kulur
63.02.18.2004|Tanjung Sari
63.02.18.2005|Magalau Hilir
63.02.18.2006|Magalau Hulu
63.02.19.2001|Sengayam
63.02.19.2002|Mayang Sari
63.02.19.2003|Marga Jaya
63.02.19.2004|Mangka
63.02.19.2005|Batuah
63.02.20.2001|Tanjung Lalak Utara
63.02.20.2002|Tanjung Lalak Selatan
63.02.20.2003|Pulau Kerayaan
63.02.20.2004|Kerayaan Utara
63.02.20.2005|Pulau Kerasian
63.02.20.2006|Pulau Kerumputan
63.02.20.2007|Teluk Aru
63.02.20.2008|Teluk Kemuning
63.02.20.2009|Oka-Oka
63.02.21.2001|Tanjung Pelayar
63.02.21.2002|Tanjung Sungkai
63.02.21.2003|Tanjung Tengah
63.02.21.2004|Tanjung Kunyit
63.02.21.2005|Teluk Tamiang
63.02.21.2006|Gosong Panjang
63.02.21.2007|Kampung Baru
63.02.21.2008|Tata Mekar
63.02.21.2009|Bandar Raya
63.02.21.2010|Bangun Rejo
63.02.22.1009|Baharu Selatan
63.02.22.1010|Kotabaru Tengah
63.02.22.1011|Kotabaru Hilir
63.02.22.2001|Sebatung
63.02.22.2002|Hilir Muara
63.02.22.2003|Batuah
63.02.22.2004|Baharu Utara
63.02.22.2005|Tirawan
63.02.22.2006|Gedambaan
63.02.22.2007|Sarang Tiung
63.02.22.2008|Sigam
63.03.01.2001|Bakambat
63.03.01.2002|Tanipah
63.03.01.2009|Pemurus
63.03.01.2010|Simpang Warga
63.03.01.2011|Bunipah
63.03.01.2012|Aluh Aluh Besar
63.03.01.2013|Aluh Aluh Kecil
63.03.01.2014|Podok
63.03.01.2015|Handil Bujur
63.03.01.2016|Kuin Besar
63.03.01.2017|Terapu
63.03.01.2019|Labat Muara
63.03.01.2022|Pulantan
63.03.01.2024|Aluh Aluh Kecil Muara
63.03.01.2026|Simpang Warga Dalam
63.03.01.2027|Kuin Kecil
63.03.01.2028|Handil Baru
63.03.01.2030|Balimau
63.03.01.2031|Sungai Musang
63.03.02.1001|Kertak Hanyar I
63.03.02.1008|Manarap Lama
63.03.02.1015|Mandarsari
63.03.02.2005|Tatah Pemangkih Laut
63.03.02.2006|Simpang Empat
63.03.02.2007|Sungai Lakum
63.03.02.2009|Manarap Baru
63.03.02.2010|Kertak Hanyar II
63.03.02.2014|Pasar Kamis
63.03.02.2016|Manarap Tengah
63.03.02.2017|Belayung Baru
63.03.02.2021|Banua Hanyar
63.03.02.2022|Mekar Raya
63.03.03.1001|Gambut
63.03.03.1014|Gambut Barat
63.03.03.2002|Sungai Kupang
63.03.03.2003|Guntung Papuyu
63.03.03.2004|Makmur
63.03.03.2005|Tambak Sirang Darat
63.03.03.2006|Tambak Sirang Laut
63.03.03.2007|Malintang
63.03.03.2008|Kayu Bawang
63.03.03.2009|Banyu Hirang
63.03.03.2010|Guntung Ujung
63.03.03.2011|Tambak Sirang Baru
63.03.03.2012|Malintang Baru
63.03.03.2013|Keladan Baru
63.03.04.1001|Sungai Lulut
63.03.04.2002|Sungai Bakung
63.03.04.2003|Sungai Tandipah
63.03.04.2004|Lok Baintan
63.03.04.2005|Gudang Hirang
63.03.04.2006|Sungai Pinang Lama
63.03.04.2007|Pembantanan
63.03.04.2008|Pemakuan
63.03.04.2009|Sungai Tabuk Kota
63.03.04.2010|Sungai Tabuk Keramat
63.03.04.2011|Lok Buntar
63.03.04.2012|Gudang Tengah
63.03.04.2013|Pejambuan
63.03.04.2014|Keliling Benteng Ilir
63.03.04.2015|Sungai Pinang Baru
63.03.04.2016|Paku Alam
63.03.04.2017|Lok Baintan Dalam
63.03.04.2018|Pematang Panjang
63.03.04.2019|Sungai Bangkal
63.03.04.2020|Tajau Landung
63.03.04.2021|Abumbun Jaya
63.03.05.1001|Keraton
63.03.05.1002|Jawa
63.03.05.1003|Pasayangan
63.03.05.1004|Murung Keraton
63.03.05.1005|Sungai Paring
63.03.05.1055|Tanjung Rema Darat
63.03.05.1059|Sekumpul
63.03.05.2009|Sungai Sipai
63.03.05.2010|Pasayangan Selatan
63.03.05.2011|Tanjung Rema
63.03.05.2012|Bincau
63.03.05.2013|Murung Kenanga
63.03.05.2015|Tunggul Irang
63.03.05.2016|Tambak Baru
63.03.05.2034|Cindai Alus
63.03.05.2036|Tungkaran
63.03.05.2037|Tambak Baru Ulu
63.03.05.2040|Bincau Muara
63.03.05.2042|Tunggul Irang Ilir
63.03.05.2043|Tunggul Irang Ulu
63.03.05.2051|Labuan Tabu
63.03.05.2052|Indrasari
63.03.05.2054|Jawa Laut
63.03.05.2056|Pasayangan Utara
63.03.05.2057|Pasayangan Barat
63.03.05.2058|Tambak Baru Ilir
63.03.06.2001|Kiram
63.03.06.2002|Mandiangin Barat
63.03.06.2003|Karang Intan
63.03.06.2004|Pandak Daun
63.03.06.2005|Jingah Habang Ulu
63.03.06.2006|Mali Mali
63.03.06.2007|Lok Tangga
63.03.06.2008|Lihung
63.03.06.2009|Bi'ih
63.03.06.2010|Penyambaran
63.03.06.2011|Sungai Alang
63.03.06.2012|Sungai Asam
63.03.06.2013|Mandikapau Timur
63.03.06.2014|Awang Bangkal Barat
63.03.06.2015|Awang Bangkal Timur
63.03.06.2016|Sungai Besar
63.03.06.2017|Mandiangin Timur
63.03.06.2018|Pasar Lama
63.03.06.2019|Jingah Habang Ilir
63.03.06.2020|Sungai Arfat
63.03.06.2021|Padang Panjang
63.03.06.2022|Sungai Landas
63.03.06.2023|Abirau
63.03.06.2024|Pulau Nyiur
63.03.06.2025|Mandikapau Barat
63.03.06.2026|Balau
63.03.07.2001|Pingaran Ilir
63.03.07.2002|Jati Baru
63.03.07.2003|Pasar Jati
63.03.07.2004|Danau Salak
63.03.07.2005|Tambak Danau
63.03.07.2006|Kaliukan
63.03.07.2007|Sungai Alat
63.03.07.2008|Pingaran Ulu
63.03.07.2009|Astambul Kota
63.03.07.2010|Astambul Seberang
63.03.07.2011|Sungai Tuan Ulu
63.03.07.2012|Banua Anyar Sungai Tuan
63.03.07.2013|Kelampaian Ilir
63.03.07.2014|Kelampaian Ulu
63.03.07.2015|Limamar
63.03.07.2016|Lok Gabang
63.03.07.2017|Pematang Hambawang
63.03.07.2018|Kelampaian Tengah
63.03.07.2019|Tambangan
63.03.07.2020|Banua Anyar Danau Salak
63.03.07.2021|Sungai Tuan Ilir
63.03.07.2022|Munggu Raya
63.03.08.2005|Paku
63.03.08.2006|Simpang Empat
63.03.08.2007|Lok Cantung
63.03.08.2008|Tanah Intan
63.03.08.2009|Sungai Raya
63.03.08.2010|Sungkai
63.03.08.2011|Sungai Langsat
63.03.08.2014|Lawiran
63.03.08.2017|Batu Balian
63.03.08.2018|Cabi
63.03.08.2019|Berkat Mulya
63.03.08.2021|Sungkai Baru
63.03.08.2022|Paring Tali
63.03.08.2025|Pasar Lama
63.03.08.2026|Sungai Tabuk
63.03.09.2001|Maniapun
63.03.09.2002|Lok Tunggul
63.03.09.2003|Lobang Baru
63.03.09.2004|Pengaron
63.03.09.2005|Benteng
63.03.09.2006|Ati'im
63.03.09.2007|Alimukim
63.03.09.2008|Panyiuran
63.03.09.2009|Antaraku
63.03.09.2010|Mangkauk
63.03.09.2015|Kertak Empat
63.03.09.2018|Lumpangi
63.03.10.2001|Kupang Rejo
63.03.10.2002|Sungai Pinang
63.03.10.2003|Kahelaan
63.03.10.2004|Rantau Nangka
63.03.10.2005|Rantau Bakula
63.03.10.2006|Belimbing Lama
63.03.10.2010|Sumber Baru
63.03.10.2011|Belimbing Baru
63.03.10.2012|Pakutik
63.03.10.2013|Sumber Harapan
63.03.10.2015|Hakim Makmur
63.03.11.2001|Tiwingan Lama
63.03.11.2002|Kalaan
63.03.11.2003|Benua Riam
63.03.11.2004|Bunglai
63.03.11.2005|Apuai
63.03.11.2006|Rantau Bujur
63.03.11.2007|Artain
63.03.11.2008|Rantau Balai
63.03.11.2009|Tiwingan Baru
63.03.11.2010|Belangian
63.03.11.2011|Aranio
63.03.11.2012|Pa'au
63.03.12.2001|Baru
63.03.12.2002|Bawahan Pasar
63.03.12.2003|Bawahan Seberang
63.03.12.2004|Pematang Danau
63.03.12.2005|Surian
63.03.12.2006|Mataraman
63.03.12.2007|Simpang Tiga
63.03.12.2008|Bawahan Selan
63.03.12.2009|Takuti
63.03.12.2010|Pasiraman
63.03.12.2011|Lok Tamu
63.03.12.2012|Sungai Jati
63.03.12.2013|Mangkalawat
63.03.12.2014|Gunung Ulin
63.03.12.2015|Tanah Abang
63.03.13.2001|Pindahan Baru
63.03.13.2002|Handil Purai
63.03.13.2003|Kampung Baru
63.03.13.2004|Lawahan
63.03.13.2005|Babirik
63.03.13.2006|Jambu Burung
63.03.13.2007|Tambak Padi
63.03.13.2008|Haur Kuning
63.03.13.2009|Jambu Raya
63.03.13.2010|Rumpiang
63.03.13.2011|Salat Makmur
63.03.13.2012|Muara Halayung
63.03.14.2001|Teluk Selong
63.03.14.2002|Sungai Batang
63.03.14.2003|Sungai Batang Ilir
63.03.14.2004|Sungai Rangas
63.03.14.2005|Penggalaman
63.03.14.2006|Keliling Benteng Ulu
63.03.14.2007|Antasan Sutun
63.03.14.2008|Sungai Rangas Ulu
63.03.14.2009|Sungai Rangas Hambuku
63.03.14.2010|Keliling Benteng Tengah
63.03.14.2011|Teluk Selong Ulu
63.03.14.2012|Tangkas
63.03.14.2013|Sungai Rangas Tengah
63.03.15.2001|Pekauman
63.03.15.2002|Keramat
63.03.15.2003|Antasan Senor
63.03.15.2004|Tambak Anyar
63.03.15.2005|Melayu
63.03.15.2006|Melayu Ilir
63.03.15.2007|Akar Bagantung
63.03.15.2008|Dalam Pagar
63.03.15.2009|Tambak Anyar Ulu
63.03.15.2010|Pematang Baru
63.03.15.2011|Melayu Tengah
63.03.15.2012|Akar Baru
63.03.15.2013|Dalam Pagar Ulu
63.03.15.2014|Pekauman Ulu
63.03.15.2015|Mekar
63.03.15.2016|Tambak Anyar Ilir
63.03.15.2017|Sungai Kitano
63.03.15.2018|Keramat Baru
63.03.15.2019|Pekauman Dalam
63.03.15.2020|Antasan Senor Ilir
63.03.16.2001|Madurejo
63.03.16.2002|Baliangin
63.03.16.2003|Gunung Batu
63.03.16.2004|Batang Banyu
63.03.16.2005|Sungai Lurus
63.03.16.2006|Batu Tanam
63.03.16.2007|Pasar Baru
63.03.17.2001|Paramasan Atas
63.03.17.2002|Paramasan Bawah
63.03.17.2003|Remo
63.03.17.2004|Angkipih
63.03.18.2001|Rantau Bujur
63.03.18.2002|Lok Tanah
63.03.18.2003|Telaga Baru
63.03.18.2004|Rampah
63.03.19.2001|Tatah Bangkal
63.03.19.2002|Bangkal Tengah
63.03.19.2003|Layap Baru
63.03.19.2004|Tatah Layap
63.03.19.2005|Mekar Sari
63.03.19.2006|Pandan Sari
63.03.19.2007|Tampang Awang
63.03.19.2008|Pemangkih Darat
63.03.19.2009|Pemangkih Baru
63.03.19.2010|Pemangkih Tengah
63.03.19.2011|Tatah Jaruju
63.03.19.2012|Jaruju Laut
63.03.19.2013|Thaibah Raya
63.03.20.2001|Keramat Mina
63.03.20.2002|Garis Hanyar
63.03.20.2003|Cintapuri
63.03.20.2004|Surian Hanyar
63.03.20.2005|Benua Anyar
63.03.20.2006|Alalak Padang
63.03.20.2007|Makmur Karya
63.03.20.2008|Simpang Lima
63.03.20.2009|Karya Makmur
63.03.20.2010|Sindang Jaya
63.03.20.2011|Sumber Sari
63.04.01.2001|Kuala Lupak
63.04.01.2002|Sungai Telan Besar
63.04.01.2003|Sungai Telan Kecil
63.04.01.2004|Tabunganen Muara
63.04.01.2005|Tabunganen Tengah
63.04.01.2006|Karya Baru
63.04.01.2007|Tabunganen Pemurus
63.04.01.2008|Sungai Teras Dalam
63.04.01.2009|Sungai Jingah Besar
63.04.01.2010|Tabunganen Kecil
63.04.01.2011|Sungai Teras Luar
63.04.01.2012|Sungai Telan Muara
63.04.01.2013|Beringin Kencana
63.04.01.2014|Tanggul Rejo
63.04.02.2001|Purwosari II
63.04.02.2002|Purwosari I
63.04.02.2003|Tamban Bangun
63.04.02.2004|Tamban Muara
63.04.02.2005|Tamban Kecil
63.04.02.2006|Tinggiran II Luar
63.04.02.2007|Jelapat I
63.04.02.2008|Tamban Muara Baru
63.04.02.2009|Purwosari Baru
63.04.02.2010|Sekata Baru
63.04.02.2011|Koanda
63.04.02.2012|Damsari
63.04.02.2013|Sidorejo
63.04.02.2014|Jelapat Baru
63.04.02.2015|Tamban Bangun Baru
63.04.02.2016|Tamban Sari Baru
63.04.03.2001|Andaman
63.04.03.2002|Hilir Mesjid
63.04.03.2003|Anjir Pasar Kota
63.04.03.2004|Banyiur
63.04.03.2005|Gandaraya
63.04.03.2006|Gandaria
63.04.03.2007|Anjir Pasar Kota II
63.04.03.2008|Andaman II
63.04.03.2009|Anjir Seberang Pasar II
63.04.03.2010|Anjir Seberang Pasar I
63.04.03.2011|Anjir Pasar Lama
63.04.03.2012|Pandan Sari
63.04.03.2013|Mentaren
63.04.03.2014|Barunai Baru
63.04.03.2015|Danau Karya
63.04.04.2001|Anjir Serapat Muara
63.04.04.2002|Anjir Muara Kota
63.04.04.2003|Patih Muhur
63.04.04.2004|Anjir Muara Kota Tengah
63.04.04.2005|Anjir Serapat Lama
63.04.04.2006|Anjir Serapat Baru
63.04.04.2007|Anjir Muara Lama
63.04.04.2008|Sungai Punggu
63.04.04.2009|Anjir Serapat Baru I
63.04.04.2010|Patih Muhur Baru
63.04.04.2011|Sungai Punggu Baru 
63.04.04.2012|Anjir Serapat Muara I
63.04.04.2013|Sepakat Barsama
63.04.04.2014|Marabahan Baru
63.04.04.2015|Beringin Jaya
63.04.05.1001|Berangas Barat
63.04.05.1002|Berangas
63.04.05.1003|Handil Bakti
63.04.05.2004|Pulau Alalak
63.04.05.2005|Pulau Sewangi
63.04.05.2006|Pulau Sugara
63.04.05.2007|Sungai Lumbah
63.04.05.2008|Berangas Timur
63.04.05.2009|Sei Semangat Bhakti
63.04.05.2010|Sungai Pitung
63.04.05.2011|Belandean Muara
63.04.05.2012|Belandean
63.04.05.2013|Tanjung Harapan
63.04.05.2014|Semangat Dalam
63.04.05.2015|Beringin
63.04.05.2016|Semangat Karya
63.04.05.2017|Panca Karya
63.04.05.2018|Tatah Mesjid
63.04.06.2001|Terantang
63.04.06.2002|Tanipah
63.04.06.2003|Puntik Luar
63.04.06.2004|Puntik Dalam
63.04.06.2005|Tabing Rimbah
63.04.06.2006|Pantai Hambawang
63.04.06.2009|Tatah Alayung
63.04.06.2011|Puntik Tengah
63.04.06.2014|Lokrawa
63.04.06.2015|Sei Ramania
63.04.06.2016|Bangkit Baru
63.04.06.2017|Antasan Segera
63.04.06.2020|Karang Bunga
63.04.06.2021|Karang Indah
63.04.07.2001|Sungai Pantai
63.04.07.2002|Pindahan Baru
63.04.07.2003|Sungai Gampa Asahi
63.04.07.2004|Sungai Gampa
63.04.07.2005|Sungai Sahurai
63.04.07.2006|Simpang Arja
63.04.07.2007|Sinar Baru
63.04.07.2008|Sungai Bamban
63.04.07.2009|Danda Jaya
63.04.08.2001|Murung Keramat
63.04.08.2002|Sungai Seluang
63.04.08.2003|Belawang
63.04.08.2004|Bambangin
63.04.08.2005|Sukaramai
63.04.08.2006|Sungai Seluang Pasar
63.04.08.2007|Samuda
63.04.08.2008|Parimata
63.04.08.2009|Karang Dukuh
63.04.08.2010|Patih Selera
63.04.08.2011|Karang Buah
63.04.08.2012|Binaan Baru
63.04.08.2013|Rangga Surya
63.04.09.2001|Sungai Kambat
63.04.09.2002|Sungai Rasau
63.04.09.2003|Simpang Nungki
63.04.09.2004|Sawahan
63.04.09.2005|Bantuil
63.04.09.2006|Badandan
63.04.09.2007|Sei Tunjang
63.04.09.2008|Sei Raya
63.04.10.1001|Lepasan
63.04.10.2002|Banua Anyar
63.04.10.2003|Murung Raya
63.04.10.2004|Palingkau
63.04.10.2005|Balukung
63.04.10.2006|Banitan
63.04.10.2007|Batik
63.04.10.2008|Bahalayung
63.04.10.2009|Sungai Selirik
63.04.11.2001|Jambu Baru
63.04.11.2002|Jambu
63.04.11.2003|Kabuau
63.04.11.2004|Jarenang
63.04.11.2005|Tabatan
63.04.11.2006|Kuripan
63.04.11.2007|Tabatan Baru
63.04.11.2008|Asia Baru
63.04.11.2009|Rimbun Tulang
63.04.12.2001|Pantang Raya
63.04.12.2002|Tabukan Raya
63.04.12.2003|Teluk Tamba
63.04.12.2004|Rantau Bamban
63.04.12.2005|Tamba Jaya
63.04.12.2006|Muara Pulau
63.04.12.2007|Karya Indah
63.04.12.2008|Bandar Karya
63.04.12.2009|Karya Makmur
63.04.12.2010|Karya Jadi
63.04.12.2011|Pantang Baru
63.04.13.2001|Mekarsari
63.04.13.2002|Tamban Raya
63.04.13.2003|Tinggiran Tengah
63.04.13.2004|Tinggiran Darat
63.04.13.2005|Jelapat II
63.04.13.2006|Tamban Raya Baru
63.04.13.2007|Tinggiran Baru
63.04.13.2008|Karang Mekar
63.04.13.2009|Indah Sari
63.04.14.2001|Barambai
63.04.14.2002|Sungai Kali
63.04.14.2003|Pendalaman
63.04.14.2004|Handil Barabai
63.04.14.2005|Bagagap
63.04.14.2006|Barambai Karya Tani
63.04.14.2007|Pendalaman Baru
63.04.14.2008|Karya Baru
63.04.14.2009|Barambai Kolam Kiri
63.04.14.2010|Barambai Kolam Kanan
63.04.14.2011|Barambai Kolam Kiri Dalam
63.04.15.1001|Marabahan Kota
63.04.15.1002|Ulu Benteng
63.04.15.2003|Penghulu
63.04.15.2004|Bagus
63.04.15.2005|Baliuk
63.04.15.2006|Antar Baru
63.04.15.2007|Antar Jaya
63.04.15.2008|Antar Raya
63.04.15.2009|Sido Makmur
63.04.15.2010|Karya Maju
63.04.16.2001|Kolam Kiri
63.04.16.2002|Roham Raya
63.04.16.2003|Simpang Jaya
63.04.16.2004|Tumih
63.04.16.2005|Pinang Habang
63.04.16.2006|Waringin Kencana
63.04.16.2007|Babat Raya
63.04.16.2008|Kolam Kanan
63.04.16.2009|Sidomulyo
63.04.16.2010|Kolam Makmur
63.04.16.2011|Surya Kanta
63.04.16.2012|Sumber Rahayu
63.04.16.2013|Dwipasari
63.04.17.2001|Sampurna
63.04.17.2002|Jejangkit Barat
63.04.17.2003|Bahandang
63.04.17.2004|Jejangkit Timur
63.04.17.2005|Cahaya Baru
63.04.17.2006|Jejangkit Pasar
63.04.17.2007|Jejangkit Muara
63.05.01.1001|Binuang
63.05.01.1017|Karangan Putih
63.05.01.1018|Raya Belanti
63.05.01.2003|Tungkap
63.05.01.2006|A. Yani Pura
63.05.01.2007|Pulau Pinang
63.05.01.2008|Pualam Sari
63.05.01.2009|Gunung Batu
63.05.01.2012|Pulau Pinang Utara
63.05.01.2016|Padang Sari
63.05.01.2019|Mekar Sari
63.05.02.1004|Tambarangan
63.05.02.2001|Tatakan
63.05.02.2002|Suato Tatakan
63.05.02.2005|Sawang
63.05.02.2006|Lawahan
63.05.02.2007|Timbaan
63.05.02.2009|Rumintin
63.05.02.2011|Cempaka
63.05.02.2012|Harapan Masa
63.05.02.2016|Tandui
63.05.02.2017|Hatiwin
63.05.03.2001|Pandulangan
63.05.03.2002|Labung
63.05.03.2003|Mandurian
63.05.03.2004|Serawi
63.05.03.2005|Pematang Karangan Hulu
63.05.03.2006|Pematang Karangan
63.05.03.2007|Pandahan
63.05.03.2008|Pematang Karangan Hilir
63.05.03.2009|Hiyung
63.05.03.2010|Andhika
63.05.03.2011|Sukaramai
63.05.03.2012|Tirik
63.05.03.2013|Kepayang
63.05.03.2014|Batang Lantik
63.05.03.2015|Mandurian Hilir
63.05.03.2016|Sungai Bahalang
63.05.03.2017|Papagan Makmur
63.05.04.1001|Rangda Malingkung
63.05.04.1002|Kupang
63.05.04.1003|Rantau Kanan
63.05.04.1004|Rantau Kiwa
63.05.04.2005|Keramat
63.05.04.2006|Antasari
63.05.04.2007|Jingah Babaris
63.05.04.2008|Banua Hanyar
63.05.04.2009|Banua Halat Kiri
63.05.04.2010|Banua Halat Kanan
63.05.04.2011|Perintis Raya
63.05.04.2012|Kakaran
63.05.04.2013|Antasari Hilir
63.05.04.2014|Lumbu Raya
63.05.04.2015|Banua Hanyar Hulu
63.05.04.2016|Badaun
63.05.05.2001|Margasari Hulu
63.05.05.2002|Candi Laras
63.05.05.2003|Baringin A
63.05.05.2004|Marampiau
63.05.05.2005|Pabaungan Hilir
63.05.05.2006|Pabaungan Hulu
63.05.05.2007|Sungai Rutas
63.05.05.2008|Baringin B
63.05.05.2009|Marampiau Hilir
63.05.05.2010|Sungai Rutas Hulu
63.05.05.2011|Baulin
63.05.05.2012|Pabaungan Pantai
63.05.06.2001|Keladan
63.05.06.2002|Sungai Salai
63.05.06.2003|Pariok
63.05.06.2004|Margasari Hilir
63.05.06.2005|Batalas
63.05.06.2006|Rawana
63.05.06.2007|Buas-Buas
63.05.06.2008|Teluk Haur
63.05.06.2009|Sungai Puting
63.05.06.2010|Sawaja
63.05.06.2011|Sungai Salai Hilir
63.05.06.2012|Buas-Buas Hilir
63.05.06.2013|Rawana Hulu
63.05.07.2001|Parigi Kecil
63.05.07.2002|Bakarangan
63.05.07.2003|Parigi
63.05.07.2004|Paul
63.05.07.2005|Gadung
63.05.07.2006|Bundung
63.05.07.2007|Tangkawang
63.05.07.2008|Waringin
63.05.07.2009|Gadung Keramat
63.05.07.2010|Masta
63.05.07.2011|Ketapang
63.05.07.2012|Tangkawang Baru
63.05.08.2001|Pipitak Jaya
63.05.08.2002|Miawa
63.05.08.2003|Batu Ampar
63.05.08.2004|Harakit
63.05.08.2005|Batung
63.05.08.2006|Balawaian
63.05.08.2007|Baramban
63.05.08.2008|Buniin Jaya
63.05.09.2001|Kalumpang
63.05.09.2002|Banua Padang
63.05.09.2003|Bungur
63.05.09.2004|Banua Padang Hilir
63.05.09.2005|Shabah
63.05.09.2006|Hangui
63.05.09.2007|Rantau Bujur
63.05.09.2008|Purut
63.05.09.2009|Bungur Baru
63.05.09.2010|Timbung
63.05.09.2011|Paring Guling
63.05.09.2012|Linuh
63.05.10.1007|Bitahan
63.05.10.2001|Binderang
63.05.10.2002|Parandakan
63.05.10.2003|Lokpaikat
63.05.10.2004|Bataratat
63.05.10.2005|Bitahan Baru
63.05.10.2006|Puncak Harapan
63.05.10.2008|Budi Mulya
63.05.10.2009|Ayunan Papan
63.05.11.2001|Salam Babaris
63.05.11.2002|Suato Lama
63.05.11.2003|Kambang Habang Lama
63.05.11.2004|Pantai Cabe
63.05.11.2005|Suato Baru
63.05.11.2006|Kambang Habang Baru
63.05.12.2001|Tarungin
63.05.12.2002|Matang Batas
63.05.12.2003|Hatungun
63.05.12.2004|Burakai
63.05.12.2005|Batu Hapu
63.05.12.2006|Kambang Kuning
63.05.12.2007|Asam Randah
63.05.12.2008|Bagak
63.06.01.2001|Hamalau
63.06.01.2002|Telaga Bidadari
63.06.01.2003|Karasikan
63.06.01.2004|Sungai Raya Utara
63.06.01.2005|Sungai Raya Selatan
63.06.01.2006|Hariti
63.06.01.2007|Ida Manggala
63.06.01.2008|Bumi Berkat
63.06.01.2009|Batang Kulur Kiri
63.06.01.2010|Batang Kulur Tengah
63.06.01.2011|Batang Kulur Kanan
63.06.01.2012|Baru
63.06.01.2013|Tamiyang
63.06.01.2014|Asam
63.06.01.2015|Sungai Kali
63.06.01.2016|Sarang Halang
63.06.01.2017|Paring Agung
63.06.01.2018|Tanah Bangkang
63.06.02.2001|Karang Jawa Muka
63.06.02.2002|Karang Jawa
63.06.02.2003|Tabihi
63.06.02.2004|Pandulangan
63.06.02.2005|Kaliring
63.06.02.2006|Jambu Hulu
63.06.02.2007|Pahampangan
63.06.02.2008|Padang Batung
63.06.02.2009|Jembatan Merah
63.06.02.2010|Batu Bini
63.06.02.2011|Mawangi
63.06.02.2012|Madang
63.06.02.2013|Durian Rabung
63.06.02.2014|Jelatang
63.06.02.2015|Batu Laki
63.06.02.2016|Malutu
63.06.02.2017|Malilingin
63.06.03.2001|Lok Binuang
63.06.03.2002|Telaga Langsat
63.06.03.2003|Mandala
63.06.03.2004|Ambutun
63.06.03.2005|Hamak
63.06.03.2006|Hamak Timur
63.06.03.2007|Hamak Utara
63.06.03.2008|Pakuan Timur
63.06.03.2009|Gumbil
63.06.03.2010|Longawang
63.06.03.2011|Pandulangan
63.06.04.2001|Bamban Utara
63.06.04.2002|Bamban
63.06.04.2003|Bamban Selatan
63.06.04.2004|Kayu Abang
63.06.04.2005|Angkinang
63.06.04.2006|Telaga Sili-Sili
63.06.04.2007|Angkinang Selatan
63.06.04.2008|Tawia
63.06.04.2009|Taniran Kubah
63.06.04.2010|Taniran Selatan
63.06.04.2011|Bakarung
63.06.05.1001|Kandangan Kota
63.06.05.1002|Kandangan Utara
63.06.05.1003|Kandangan Barat
63.06.05.1004|Jambu Hilir
63.06.05.2005|Gambah Luar
63.06.05.2006|Gambah Luar Muka
63.06.05.2007|Gambah Dalam
63.06.05.2008|Gambah Dalam Barat
63.06.05.2009|Sungai Kupang
63.06.05.2010|Bangkau
63.06.05.2011|Lungau
63.06.05.2012|Sungai Paring
63.06.05.2013|Bariang
63.06.05.2014|Amawang Kiri
63.06.05.2015|Amawang Kiri Muka
63.06.05.2016|Amawang Kanan
63.06.05.2017|Tibung Raya
63.06.05.2018|Baluti
63.06.06.2001|Tebing Tinggi
63.06.06.2002|Simpur
63.06.06.2003|Garunggang
63.06.06.2004|Amparaya
63.06.06.2005|Panjampang Bahagia
63.06.06.2006|Ulin
63.06.06.2007|Pantai Ulin
63.06.06.2008|Wasah Hulu
63.06.06.2009|Wasah Tengah
63.06.06.2010|Wasah Hilir
63.06.06.2011|Kapuh
63.06.07.2001|Muning Baru
63.06.07.2002|Muning Dalam
63.06.07.2003|Muning Tengah
63.06.07.2004|Banjarbaru
63.06.07.2005|Bayanan
63.06.07.2006|Pandan Sari
63.06.07.2007|Pihanin Raya
63.06.07.2008|Tumbukan Banyu
63.06.07.2009|Sungai Pinang
63.06.07.2010|Habirau
63.06.07.2011|Habirau Tengah
63.06.07.2012|Parigi
63.06.07.2013|Banua Hanyar
63.06.07.2014|Tambangan
63.06.07.2015|Baruh Jaya
63.06.07.2016|Samuda
63.06.08.2001|Pakapuran Kecil
63.06.08.2002|Panggandingan
63.06.08.2003|Tambak Bitin
63.06.08.2004|Pakan Dalam
63.06.08.2005|Paramaian
63.06.08.2006|Pandak Daun
63.06.08.2007|Murung Raya
63.06.08.2008|Balah Paikat
63.06.08.2009|Sungai Garuda
63.06.08.2010|Sungai Mandala
63.06.08.2011|Mdl. Murung Mesjid
63.06.08.2012|Baruh Kembang
63.06.08.2013|Teluk Haur
63.06.08.2014|Pasungkan
63.06.08.2015|Teluk Labak
63.06.08.2016|Hamayung
63.06.08.2017|Hamayung Utara
63.06.08.2018|Paharangan
63.06.08.2019|Hakurung
63.06.09.2001|Balimau
63.06.09.2002|Karang Paci
63.06.09.2003|Bago Tanggul
63.06.09.2004|Karang Bulan
63.06.09.2005|Balanti
63.06.09.2006|Kalumpang
63.06.09.2007|Tambingkar
63.06.09.2008|Sirih
63.06.09.2009|Sirih Hulu
63.06.10.2001|Halunuk
63.06.10.2002|Panggungan
63.06.10.2003|Lumpangi
63.06.10.2004|Malinau
63.06.10.2005|Hulu Banyu
63.06.10.2006|Tumingki
63.06.10.2007|Kamawakan
63.06.10.2008|Lok Lahung
63.06.10.2009|Loksado
63.06.10.2010|Haratai
63.06.10.2011|Ulang
63.06.11.2001|Siang Gantung
63.06.11.2002|Baru
63.06.11.2003|Tanjung Selor
63.06.11.2004|Badaun
63.06.11.2005|Bajayau
63.06.11.2006|Bajayau Tengah
63.06.11.2007|Bajayau Lama
63.07.01.2001|Pengambau Hilir Luar
63.07.01.2002|Panggung
63.07.01.2003|Barikin
63.07.01.2004|Andang
63.07.01.2005|Pengambau Hilir Dalam
63.07.01.2006|Haruyan
63.07.01.2007|Haruyan Seberang
63.07.01.2008|Pengambau Hulu
63.07.01.2009|Sungai Harang
63.07.01.2010|Batu Panggung
63.07.01.2011|Mangunang
63.07.01.2012|Hapulang
63.07.01.2013|Lok Buntar
63.07.01.2014|Tabat Padang
63.07.01.2015|Mangunang Seberang
63.07.01.2016|Pandanu
63.07.01.2017|Teluk Mesjid
63.07.02.2001|Murung A
63.07.02.2002|Pagat
63.07.02.2003|Kalibaru
63.07.02.2004|Kahakan
63.07.02.2005|Aluan Sumur
63.07.02.2006|Aluan Besar
63.07.02.2007|Paya Besar
63.07.02.2008|Bakti
63.07.02.2009|Aluan
63.07.02.2010|Aluan Mati
63.07.02.2011|Baru Waki
63.07.02.2013|Pantai Batung
63.07.02.2014|Layuh
63.07.02.2015|Haliau
63.07.03.1001|Pantai Hambawang Barat
63.07.03.2002|Mahang Baru
63.07.03.2003|Mundar
63.07.03.2004|Tabudarat Hilir
63.07.03.2005|Tabudarat Hulu
63.07.03.2006|Pantai Hambawang Timur
63.07.03.2007|Banua Kepayang
63.07.03.2008|Ta'al
63.07.03.2009|Durian Gantang
63.07.03.2010|Guha
63.07.03.2011|Bangkal
63.07.03.2012|Panggang Marak
63.07.03.2013|Jamil
63.07.03.2014|Taras Padang
63.07.03.2015|Murung Ta'al
63.07.03.2016|Sungai Rangas
63.07.03.2017|Batang Bahalang
63.07.03.2018|Sungai Jaranih
63.07.04.2001|Parumahan
63.07.04.2002|Kasarangan
63.07.04.2003|Banua Kupang
63.07.04.2004|Rantau Keminting
63.07.04.2005|Pemangkih
63.07.04.2006|Pemangkih Seberang
63.07.04.2007|Binjai Pemangkih
63.07.04.2008|Samhurang
63.07.04.2009|Pahalatan
63.07.04.2010|Mantaas
63.07.04.2011|Sungai Buluh
63.07.04.2012|Kadundung
63.07.04.2013|Tungkup
63.07.04.2014|Tabat
63.07.04.2015|Rantau Bujur
63.07.04.2016|Binjai Pirua
63.07.05.2001|Jaranih
63.07.05.2002|Banua Hanyar
63.07.05.2003|Palajau
63.07.05.2004|Banua Batung
63.07.05.2005|Jatuh
63.07.05.2006|Pandawan
63.07.05.2007|Mahang Matang Landung
63.07.05.2008|Kambat Selatan
63.07.05.2009|Kayu Rabah
63.07.05.2010|Setiap
63.07.05.2011|Kambat Utara
63.07.05.2012|Banua Supanggal
63.07.05.2013|Hulu Rasau
63.07.05.2014|Banua Asam
63.07.05.2015|Masiraan
63.07.05.2016|Mahang Putat
63.07.05.2017|Mahang Sungai Hanyar
63.07.05.2018|Hilir Banua
63.07.05.2019|Buluan
63.07.05.2020|Matang Ginalun
63.07.05.2021|Walatung
63.07.06.1001|Barabai Darat
63.07.06.1002|Barabai Timur
63.07.06.1003|Barabai Selatan
63.07.06.1004|Barabai Utara
63.07.06.1005|Barabai Barat
63.07.06.1006|Bukat
63.07.06.2007|Gambah
63.07.06.2008|Kayu Bawang
63.07.06.2009|Benawa Tengah
63.07.06.2010|Mandingin
63.07.06.2011|Pajukungan
63.07.06.2012|Banua Budi
63.07.06.2013|Banua Binjai
63.07.06.2014|Banua Jingah
63.07.06.2015|Ayuang
63.07.06.2016|Babai
63.07.06.2017|Awang Besar
63.07.06.2018|Bakapas
63.07.07.1001|Birayang
63.07.07.2002|Kias
63.07.07.2003|Kapar
63.07.07.2004|Tembok Bahalang
63.07.07.2005|Limbar
63.07.07.2006|Lok Basar
63.07.07.2007|Paya
63.07.07.2008|Cukan Lipai
63.07.07.2009|Birayang Surapati
63.07.07.2010|Mahela
63.07.07.2011|Rangas
63.07.07.2012|Wawai Gardu
63.07.07.2013|Labuhan
63.07.07.2014|Birayang Timur
63.07.07.2015|Tanah Habang
63.07.07.2016|Banua Rantau
63.07.07.2017|Anduhum
63.07.07.2018|Wawai
63.07.07.2019|Lunjuk
63.07.08.2001|Sumanggi Seberang
63.07.08.2002|Sumanggi
63.07.08.2003|Ilung
63.07.08.2004|Maringgit
63.07.08.2005|Telang
63.07.08.2008|Labunganak
63.07.08.2009|Hapingin
63.07.08.2010|Dangu
63.07.08.2013|Ilung Tengah
63.07.08.2014|Haur Gading
63.07.08.2018|Awang
63.07.08.2019|Awang Baru
63.07.08.2020|Muara Rintis
63.07.08.2021|Ilung Pasar Lama
63.07.09.2001|Hantakan
63.07.09.2002|Alat
63.07.09.2003|Murung B
63.07.09.2004|Bulayak
63.07.09.2005|Batu Tunggal
63.07.09.2006|Pasting
63.07.09.2007|Tilahan
63.07.09.2008|Haruyan Dayak
63.07.09.2009|Kindingan
63.07.09.2010|Datar Ajab
63.07.09.2011|Hinas Kanan
63.07.09.2012|Patikalain
63.07.10.2001|Batu Tangga
63.07.10.2002|Hinas Kiri
63.07.10.2003|Pembakulan
63.07.10.2004|Nateh
63.07.10.2005|Tandilang
63.07.10.2006|Muara Hungi
63.07.10.2007|Atiran
63.07.10.2008|Batu Perahu
63.07.10.2009|Aing Bantai
63.07.10.2010|Juhu
63.07.10.2011|Datar Batung
63.07.11.2001|Tapuk
63.07.11.2002|Karau
63.07.11.2003|Limpasu
63.07.11.2004|Kabang
63.07.11.2005|Abung Surapati
63.07.11.2006|Karatungan
63.07.11.2007|Pauh
63.07.11.2008|Abung
63.07.11.2009|Hawang
63.08.01.2003|Sungai Namang
63.08.01.2004|Danau Panggang
63.08.01.2008|Pandamaan
63.08.01.2009|Baru
63.08.01.2010|Bitin
63.08.01.2011|Manarap
63.08.01.2012|Pararain
63.08.01.2013|Telaga Mas
63.08.01.2015|Darussalam
63.08.01.2016|Sarang Burung
63.08.01.2017|Longkong
63.08.01.2019|Rintisan
63.08.01.2020|Palukahan
63.08.01.2021|Teluk Mesjid
63.08.01.2022|Sungai Panangah
63.08.01.2023|Manarap Hulu
63.08.02.2001|Babirik Hilir
63.08.02.2002|Babirik Hulu
63.08.02.2003|Sungai Durait Hilir
63.08.02.2004|Hambuku Hilir
63.08.02.2005|Murung Panti Hulu
63.08.02.2006|Murung Panti Hilir
63.08.02.2007|Murung Kupang
63.08.02.2008|Sungai Luang Hilir
63.08.02.2009|Pajukungan Hilir
63.08.02.2010|Kalumpang Dalam
63.08.02.2011|Parupukan
63.08.02.2012|Sungai Luang Hulu
63.08.02.2013|Sungai Durait Hulu
63.08.02.2014|Sungai Dalam
63.08.02.2015|Hambuku Baru
63.08.02.2016|Hambuku Lima
63.08.02.2017|Sungai Janjam
63.08.02.2018|Kalumpang Luar
63.08.02.2019|Teluk Limbung
63.08.02.2020|Sungai Durait Tengah
63.08.02.2021|Pajukungan Hulu
63.08.02.2022|Sungai Papuyu
63.08.02.2023|Sungai Nyiur
63.08.03.2001|Rantau Karau Hilir
63.08.03.2002|Rantau Karau Hulu
63.08.03.2003|Banyu Tajun Hilir
63.08.03.2004|Banyu Tajun Hulu
63.08.03.2005|Banyu Tajun Pangkalan
63.08.03.2006|Sungai Sandung
63.08.03.2007|Sungai Pandan Hilir
63.08.03.2008|Teluk Betung
63.08.03.2009|Tambalang
63.08.03.2010|Hambuku Hulu
63.08.03.2011|Hambuku Tengah
63.08.03.2014|Pandulangan
63.08.03.2015|Sungai Pandan Hulu
63.08.03.2021|Pondok Babaris
63.08.03.2024|Sungai Pinang
63.08.03.2025|Tambalang Kecil
63.08.03.2026|Putat Atas
63.08.03.2029|Banyu Tajun Dalam
63.08.03.2031|Sungai Pandan Tengah
63.08.03.2032|Hambuku Raya
63.08.03.2033|Sungai Kuini
63.08.03.2034|Tapus Dalam
63.08.03.2035|Rantau KarauTengah
63.08.03.2037|Tambalang Tengah
63.08.03.2038|Teluk Mesjid
63.08.03.2039|Murung Asam
63.08.03.2040|Tatah Laban
63.08.03.2041|Jalan Lurus
63.08.03.2042|Teluk Sinar
63.08.03.2043|Padang Bangkal
63.08.03.2044|Hambuku Pasar
63.08.03.2045|Pangkalan Sari
63.08.03.2046|Rantau Karau Raya
63.08.04.2001|Panyiuran
63.08.04.2002|Simpang Empat
63.08.04.2003|Padang Darat
63.08.04.2004|Teluk Baru
63.08.04.2005|Ilir Mesjid
63.08.04.2006|Jarang Kuantan
63.08.04.2007|Jumba
63.08.04.2008|Telaga Sari
63.08.04.2009|Telaga Silaba
63.08.04.2010|Banyu Hirang
63.08.04.2011|Kayakah
63.08.04.2012|Bajawit
63.08.04.2013|Padang Tanggul
63.08.04.2014|Teluk Paring
63.08.04.2015|Rukam Hilir
63.08.04.2016|Mamar
63.08.04.2017|Cempaka
63.08.04.2018|Keramat
63.08.04.2019|Ujung Murung
63.08.04.2020|Kota Raja
63.08.04.2021|Pulau Tambak
63.08.04.2022|Harusan Telaga
63.08.04.2023|Simpang Tiga
63.08.04.2024|Cangkering
63.08.04.2025|Kutai Kecil
63.08.04.2026|Teluk Sari
63.08.04.2027|Murung Panggang
63.08.04.2028|Telaga Hanyar
63.08.04.2029|Rukam Hulu
63.08.04.2030|Murung Sari
63.08.05.1001|Antasari
63.08.05.1002|Murung Sari
63.08.05.1003|Kebun Sari
63.08.05.1004|Paliwara
63.08.05.1005|Sungai Malang
63.08.05.2006|Tapus
63.08.05.2007|Kandang Halang
63.08.05.2008|Pasar Senin
63.08.05.2009|Kota Raden Hulu
63.08.05.2010|Tangga Ulin Hilir
63.08.05.2011|Tambalangan
63.08.05.2012|Palampitan Hulu
63.08.05.2013|Harus
63.08.05.2014|Pinangkara
63.08.05.2015|Sungai Karias
63.08.05.2016|Tigarun
63.08.05.2017|Pinang Habang
63.08.05.2018|Hulu Pasar
63.08.05.2019|Kota Raden Hilir
63.08.05.2020|Rantawan
63.08.05.2021|Muara Tapus
63.08.05.2022|Palampitan Hilir
63.08.05.2023|Harusan
63.08.05.2024|Sungai Baring
63.08.05.2025|Kembang Kuning
63.08.05.2026|Datu Kuning
63.08.05.2027|Tangga Ulin Hulu
63.08.05.2028|Mawar Sari
63.08.05.2029|Danau Cermin
63.08.06.2003|Pakapuran
63.08.06.2004|Pakacangan
63.08.06.2005|Panangkalaan
63.08.06.2006|Padang Basar
63.08.06.2007|Murung Karangan
63.08.06.2008|Kamayahan
63.08.06.2009|Guntung
63.08.06.2010|Muara Baruh
63.08.06.2011|Teluk Daun
63.08.06.2012|Sungai Turak
63.08.06.2013|Tabalong Mati
63.08.06.2020|Pimping
63.08.06.2021|Padang Luar
63.08.06.2023|Tayur
63.08.06.2026|Panangkalaan Hulu
63.08.06.2027|Cakeru
63.08.06.2028|Sungai Turak Dalam
63.08.06.2029|Panyaungan
63.08.06.2030|Kuangan
63.08.06.2032|Tabing Liring
63.08.06.2033|Padang Basar Hilir
63.08.06.2034|Telaga Bamban
63.08.06.2035|Air Tawar
63.08.06.2037|Panangian
63.08.06.2041|Pamintangan
63.08.06.2044|Pandawanan
63.08.07.2001|Banjang
63.08.07.2002|Patarikan
63.08.07.2003|Teluk Buluh
63.08.07.2004|Pandulangan
63.08.07.2005|Danau Terati
63.08.07.2006|Garunggang
63.08.07.2007|Baruh Tabing
63.08.07.2008|Murung Padang
63.08.07.2009|Teluk Sarikat
63.08.07.2010|Beringin
63.08.07.2011|Kalintamui
63.08.07.2012|Pelanjungan Sari
63.08.07.2013|Lok Bangkai
63.08.07.2014|Sungai Bahadangan
63.08.07.2015|Karias Dalam
63.08.07.2016|Rantau Bujur
63.08.07.2017|Kaludan Kecil
63.08.07.2018|Kaludan Besar
63.08.07.2019|Pawalutan
63.08.07.2020|Pulau Damar
63.08.08.2001|Palimbangan
63.08.08.2002|Palimbangan Gusti
63.08.08.2003|Palimbang Sari
63.08.08.2004|Bayur
63.08.08.2005|Lok Suga
63.08.08.2006|Sungai Limas
63.08.08.2007|Pihaung
63.08.08.2008|Sungai Binuang
63.08.08.2009|Jingah Bujur
63.08.08.2010|Haur Gading
63.08.08.2011|Keramat
63.08.08.2012|Tambak Sari panji
63.08.08.2013|Pulantani
63.08.08.2014|Waringin
63.08.08.2015|Tangkawang
63.08.08.2016|Tuhuran
63.08.08.2017|Teluk Haur
63.08.08.2018|Panawakan
63.08.09.2001|Paminggir
63.08.09.2002|Paminggir Seberang
63.08.09.2003|Ambahai
63.08.09.2004|Sapala
63.08.09.2005|Bararawa
63.08.09.2006|Pal Batu
63.08.09.2007|Tampakang
63.08.10.2001|Sungai Tabukan
63.08.10.2002|Nelayan
63.08.10.2003|Galagah Hulu
63.08.10.2004|Galagah
63.08.10.2005|Teluk Cati
63.08.10.2006|Pematang Benteng
63.08.10.2007|Pematang Benteng Hilir
63.08.10.2008|Pasar Sabtu
63.08.10.2009|Sungai Haji
63.08.10.2010|Hilir Mesjid
63.08.10.2011|Gampa Raya
63.08.10.2012|Banua Hanyar
63.08.10.2013|Rantau Bujur Hulu
63.08.10.2014|Rantau Bujur Tengah
63.08.10.2015|Rantau Bujur Hilir
63.08.10.2016|Rantau Bujur Darat
63.08.10.2017|Tambalang Raya
63.09.01.2001|Hapalah
63.09.01.2002|Bangkiling
63.09.01.2003|Sungai Durian
63.09.01.2004|Pematang
63.09.01.2005|Hariang
63.09.01.2006|Banua Lawas
63.09.01.2007|Habau
63.09.01.2008|Banua Rantau
63.09.01.2009|Purai
63.09.01.2010|Batang Banyu
63.09.01.2011|Habau Hulu
63.09.01.2012|Bungin
63.09.01.2013|Bangkiling Raya
63.09.01.2014|Talan
63.09.01.2015|Sungai Anyar
63.09.02.1001|Pulau
63.09.02.2002|Ampukung
63.09.02.2003|Telaga Itar
63.09.02.2004|Sungai Buluh
63.09.02.2005|Binturu
63.09.02.2006|Pudak Setegal
63.09.02.2007|Pasar Panas
63.09.02.2008|Masintan
63.09.02.2009|Takulat
63.09.02.2010|Paliat
63.09.02.2011|Karangan Putih
63.09.02.2012|Bahungin
63.09.03.2001|Murung Baru
63.09.03.2002|Lukbayur
63.09.03.2003|Walangkir
63.09.03.2004|Warukin
63.09.03.2005|Barimbun
63.09.03.2006|Mangkusip
63.09.03.2007|Pamarangan Kanan
63.09.03.2008|Pulau Ku'u
63.09.03.2009|Tanta
63.09.03.2010|Padang Panjang
63.09.03.2011|Puain Kanan
63.09.03.2012|Padangin
63.09.03.2013|Tamiyang
63.09.03.2014|Tanta Hulu
63.09.04.1001|Jangkung
63.09.04.1002|Tanjung
63.09.04.1003|Agung
63.09.04.1004|Hikun
63.09.04.2005|Banyu Tajun
63.09.04.2006|Pamarangan Kiwa
63.09.04.2007|Puain Kiwa
63.09.04.2008|Juai
63.09.04.2009|Mahe Seberang
63.09.04.2010|Kambitin
63.09.04.2011|Wayau
63.09.04.2012|Garunggung
63.09.04.2013|Kitang
63.09.04.2014|Sungai Pimping
63.09.04.2015|Kambitin Raya
63.09.05.2001|Marindi
63.09.05.2002|Wirang
63.09.05.2003|Bongkang
63.09.05.2004|Nawin
63.09.05.2005|Halong
63.09.05.2007|Hayup
63.09.05.2011|Kembang Kuning
63.09.05.2012|Seradang
63.09.05.2013|Mahe Pasar
63.09.05.2014|Lok Batu
63.09.05.2015|Suput
63.09.05.2018|Surian
63.09.05.2021|Catur Karya
63.09.06.1001|Belimbing Raya
63.09.06.1002|Belimbing
63.09.06.1003|Sulingan
63.09.06.1006|Mabu'un
63.09.06.1009|Pembataan
63.09.06.2004|Maburai
63.09.06.2005|Kasiau
63.09.06.2007|Kapar
63.09.06.2008|Masukau
63.09.06.2010|Kasiau Raya
63.09.07.2001|Kupang Nunding
63.09.07.2002|Mangkupum
63.09.07.2003|Pasar Batu
63.09.07.2004|Uwie
63.09.07.2005|Muara Uya
63.09.07.2006|Lumbang
63.09.07.2007|Santuun
63.09.07.2008|Simpung Layung
63.09.07.2009|Binjai
63.09.07.2010|Palapi
63.09.07.2011|Kampung Baru
63.09.07.2012|Salikung
63.09.07.2013|Ribang
63.09.07.2014|Sungai Kumap
63.09.08.2001|Madang
63.09.08.2002|Tantaringin
63.09.08.2003|Murung Karangan
63.09.08.2004|Padangin
63.09.08.2005|Manduin
63.09.08.2006|Mantuil
63.09.08.2007|Harus
63.09.09.2001|Pugaan
63.09.09.2002|Pampanan
63.09.09.2003|Sungai Rukam II
63.09.09.2004|Sungai Rukam I
63.09.09.2005|Jirak
63.09.09.2006|Halangan
63.09.09.2007|Tamunti
63.09.10.2001|Bilas
63.09.10.2002|Kaong
63.09.10.2003|Pangelak
63.09.10.2004|Kinarum
63.09.10.2005|Masingai II
63.09.10.2006|Masingai I
63.09.11.2001|Teratau
63.09.11.2002|Namun
63.09.11.2003|Jaro
63.09.11.2004|Solan
63.09.11.2005|Muang
63.09.11.2006|Lano
63.09.11.2007|Purui
63.09.11.2008|Garagata
63.09.11.2009|Nalui
63.09.12.2001|Waling
63.09.12.2002|Usih
63.09.12.2003|Bintang Ara
63.09.12.2004|Burum
63.09.12.2005|Panaan
63.09.12.2006|Dambung Raya
63.09.12.2007|Argo Mulyo
63.09.12.2008|Bumi Makmur
63.09.12.2009|Hegarmanah
63.10.01.1007|Batulicin
63.10.01.1028|Gunungtinggi
63.10.01.2005|Segumbang
63.10.01.2006|Kersik Putih
63.10.01.2029|Maju Makmur
63.10.01.2030|Maju Bersama
63.10.01.2031|Sukamaju
63.10.01.2032|Polewali Marajae
63.10.01.2033|Danauindah
63.10.02.1001|Kota Pagatan
63.10.02.2002|Betung
63.10.02.2003|Sungai Lembu
63.10.02.2004|Wiritasi
63.10.02.2005|Pejala
63.10.02.2006|Pagaruyung
63.10.02.2007|Muara Pagatan Tengah
63.10.02.2008|Kampung Baru
63.10.02.2009|Pasar Baru
63.10.02.2010|Batuah
63.10.02.2011|Baru Gelang
63.10.02.2012|Pulau Salak
63.10.02.2019|Mudalang
63.10.02.2020|Tanette
63.10.02.2021|Muara Pagatan
63.10.02.2022|Pulau Satu
63.10.02.2027|Juku Eja
63.10.02.2029|Gusunge
63.10.02.2030|Rantau Panjang Hulu
63.10.02.2031|Penyolongan
63.10.02.2032|Beringin
63.10.02.2034|Rantau Panjang Hilir
63.10.03.2001|Sari Mulya
63.10.03.2002|Sungailoban
63.10.03.2003|Sebamban Lama
63.10.03.2004|Sebamban Baru
63.10.03.2005|Sungaidua Laut
63.10.03.2006|Marga Mulya
63.10.03.2007|Sari Utama
63.10.03.2008|Tri Mulya
63.10.03.2010|Dwi Marga Utama
63.10.03.2011|Kerta Buana
63.10.03.2012|Batu Meranti
63.10.03.2014|Tri Martani
63.10.03.2015|Sumber makmur
63.10.03.2016|Biduri Bersujud
63.10.03.2017|Sumber Sari
63.10.03.2018|Wanasari
63.10.03.2019|Damar Indah
63.10.04.2003|Setarap
63.10.04.2004|Satui Timur
63.10.04.2005|Sungaicuka
63.10.04.2006|Jombang
63.10.04.2008|Satui Barat
63.10.04.2009|Sekapuk
63.10.04.2010|Sungaidanau
63.10.04.2011|Wonorejo
63.10.04.2012|Sumber Makmur
63.10.04.2013|Tegal Sari
63.10.04.2019|Sumber Arum
63.10.04.2022|Sejahtera Mulia
63.10.04.2023|Al Kautsar
63.10.04.2024|Makmur Mulia
63.10.04.2025|Sinar Bulan
63.10.04.2026|Pandamaran Jaya
63.10.04.2027|Sido Rejo
63.10.04.2028|Beruntung Raya
63.10.04.2029|Barakat Mufakat
63.10.04.2030|Makmur Jaya
63.10.05.2001|Lasung
63.10.05.2002|Manuntung
63.10.05.2003|Anjir Baru
63.10.05.2004|Binawara
63.10.05.2005|Pacakan
63.10.05.2012|Sungai Rukam
63.10.05.2015|Bakarangan
63.10.05.2019|Karang Mulya
63.10.05.2020|Harapan Jaya
63.10.05.2021|Wonorejo
63.10.05.2022|Karang Sari
63.10.06.1001|Kampung Baru
63.10.06.1002|Tungkaran Pangeran
63.10.06.2003|Sari Gadung
63.10.06.2004|Mekar Sari
63.10.06.2005|Sungaidua
63.10.06.2006|Batu Ampar
63.10.06.2007|Gunungbesar
63.10.06.2008|Pulau Burung
63.10.06.2009|Baroqah
63.10.06.2010|Bersujud
63.10.06.2011|Sejahtera
63.10.06.2012|Gunungantasari
63.10.06.2013|Hidayah Makmur
63.10.06.2014|Plajau Mulia
63.10.06.2015|Kupang Berkah Jaya
63.10.07.2001|Karang Bintang
63.10.07.2002|Pandan Sari
63.10.07.2003|Rejo Winangun
63.10.07.2004|Selaselilau
63.10.07.2005|Pematang Ulin
63.10.07.2006|Batu Licin Irigasi
63.10.07.2007|Manunggal
63.10.07.2009|Sumber Wangi
63.10.07.2010|Madu Retno
63.10.07.2011|Maju Sejahtera
63.10.07.2012|Karang Rejo
63.10.07.2013|Karang Nunggal
63.10.08.2001|Mantewe
63.10.08.2002|Dukuh Rejo
63.10.08.2003|Rejosari
63.10.08.2004|Suka Damai
63.10.08.2005|Bulu Rejo
63.10.08.2006|Sido Mulyo
63.10.08.2008|Sepakat
63.10.08.2009|Sari Mulya
63.10.08.2010|Emil Baru
63.10.08.2011|Mentawakan Mulia
63.10.08.2012|Maju Mulyo
63.10.08.2014|Gunungraya
63.10.09.2001|Bunati
63.10.09.2002|Purwodadi
63.10.09.2003|Sumber Baru
63.10.09.2004|Karang Indah
63.10.09.2005|Angsana
63.10.09.2006|Banjar Sari
63.10.09.2007|Bayan Sari
63.10.09.2008|Makmur
63.10.09.2009|Mekar Jaya
63.10.10.2001|Giri Mulya
63.10.10.2002|Kuranji
63.10.10.2003|Waringin Tunggal
63.10.10.2004|Mustika
63.10.10.2005|Indra Lokajaya
63.10.10.2006|Karang Intan
63.10.10.2007|Ringkit
63.10.11.2001|Saring Sungai Bubu
63.10.11.2002|Saring Sungai Binjai
63.10.11.2003|Sepunggur
63.10.11.2004|Serdangan
63.10.11.2005|Satiung
63.10.11.2006|Api-api
63.10.11.2007|Pakatellu
63.10.11.2008|Manurung
63.10.11.2009|Batarang
63.10.11.2010|Mekar Jaya
63.10.11.2011|Pulau Tanjung
63.10.11.2012|UPT Karya Bakti
63.10.11.2013|Salimuran
63.10.12.2001|Teluk Kepayang
63.10.12.2002|Guntung
63.10.12.2003|Mangkalapi
63.10.12.2004|Tibarau Panjang
63.10.12.2005|Darasan Binjai
63.10.12.2006|Tapus
63.10.12.2007|Hati'if
63.10.12.2008|Batu Bulan
63.10.12.2009|Tamunih
63.10.12.2010|Dadap Kusan Raya
63.11.01.2001|Muara Ninian
63.11.01.2002|Hamarung
63.11.01.2003|Juai
63.11.01.2004|Buntu Karau
63.11.01.2005|Bata
63.11.01.2006|Galumbang
63.11.01.2007|Sungai Batung
63.11.01.2008|Sirap
63.11.01.2009|Tigarun
63.11.01.2010|Teluk Bayur
63.11.01.2011|Pamurus
63.11.01.2012|Marias
63.11.01.2013|Lalayau
63.11.01.2014|Mihu
63.11.01.2015|Hukai
63.11.01.2016|Tawahan
63.11.01.2017|Gulinggang
63.11.01.2018|Mungkur Uyam
63.11.01.2019|Panimbaan
63.11.01.2020|Wonorejo
63.11.01.2021|Sumber Rejeki
63.11.02.2001|Hauwai
63.11.02.2002|Bangkal
63.11.02.2003|Mantuyan
63.11.02.2004|Tabuan
63.11.02.2005|Halong
63.11.02.2008|Puyun
63.11.02.2009|Buntu Pilanduk
63.11.02.2010|Gunung Riut
63.11.02.2011|Kapul
63.11.02.2012|Mamantang
63.11.02.2013|Binjai Punggal
63.11.02.2014|Liyu
63.11.02.2015|Binuang Santang
63.11.02.2016|Aniungan
63.11.02.2017|Binju
63.11.02.2018|Karya
63.11.02.2019|Uren
63.11.02.2020|Marajai
63.11.02.2021|Suryatama
63.11.02.2022|Baruh Panyambaran
63.11.02.2023|Mauya
63.11.02.2024|Padang Raya
63.11.02.2025|Sumber Agung
63.11.02.2026|Mamigang
63.11.03.2004|Bihara
63.11.03.2005|Pematang
63.11.03.2006|Merah
63.11.03.2007|Awayan
63.11.03.2008|Pudak
63.11.03.2009|Badalungga
63.11.03.2010|Tundakan
63.11.03.2011|Sikontan
63.11.03.2012|Pulantan
63.11.03.2013|Tundi
63.11.03.2014|Muara Jaya
63.11.03.2016|Bihara Hilir
63.11.03.2018|Baru
63.11.03.2020|Awayan Hilir
63.11.03.2021|Putat Basiun
63.11.03.2022|Sei Pumpung
63.11.03.2024|Badalungga Hilir
63.11.03.2025|Nungka
63.11.03.2026|Tangalin
63.11.03.2027|Kedondong
63.11.03.2029|Baramban
63.11.03.2031|Ambakiang
63.11.03.2032|Piyait
63.11.04.2001|Tariwin
63.11.04.2002|Lok Batu
63.11.04.2003|Munjung
63.11.04.2004|Pelajau
63.11.04.2005|Batumandi
63.11.04.2006|Riwa
63.11.04.2007|Mantimin
63.11.04.2008|Mampari
63.11.04.2009|Bungur
63.11.04.2010|Teluk Mesjid
63.11.04.2011|Timbun Tulang
63.11.04.2012|Banua Hanyar
63.11.04.2013|Bakung
63.11.04.2014|Karuh
63.11.04.2015|Guha
63.11.04.2016|Gunung Manau
63.11.04.2017|Hampa Raya
63.11.04.2018|Kasai
63.11.05.2001|Tanah Habang Kiri
63.11.05.2002|Panaitan
63.11.05.2003|Tanah Habang Kanan
63.11.05.2004|Batu Merah
63.11.05.2005|Lampihong Kanan
63.11.05.2006|Lampihong Selatan
63.11.05.2007|Lampihong Kiri
63.11.05.2008|Lajar
63.11.05.2009|Kusambi Hulu
63.11.05.2010|Kusambi Hilir
63.11.05.2011|Simpang Tiga
63.11.05.2012|Matang Lurus
63.11.05.2013|Lok Hamawang
63.11.05.2014|Kupang
63.11.05.2015|Tampang
63.11.05.2016|Matang Hanau
63.11.05.2017|Lok Panginangan
63.11.05.2018|Jungkal
63.11.05.2019|Sungai Tabuk
63.11.05.2020|Jimamun
63.11.05.2021|Pimping
63.11.05.2022|Hilir Pasar
63.11.05.2023|Teluk Karya
63.11.05.2024|Pupuyuan
63.11.05.2025|Sungai Awang
63.11.05.2026|Kandang Jaya
63.11.05.2027|Mundar
63.11.06.1019|Paringin Timur
63.11.06.1023|Paringin Kota
63.11.06.2005|Balang
63.11.06.2006|Kalahiang
63.11.06.2007|Lasung Batu
63.11.06.2008|Paran
63.11.06.2009|Layap
63.11.06.2012|Murung Ilung
63.11.06.2013|Mangkayahu
63.11.06.2014|Lok Batung
63.11.06.2015|Lamida Bawah
63.11.06.2017|Dahai
63.11.06.2022|Hujan Mas
63.11.06.2024|Babayau
63.11.06.2034|Balida
63.11.06.2038|Sungai Ketapi
63.11.07.1001|Batu Piring
63.11.07.2002|Baruh Bahinu Luar
63.11.07.2003|Inan
63.11.07.2004|Baruh Bahinu Dalam
63.11.07.2005|Panggung
63.11.07.2006|Galumbang
63.11.07.2007|Halubau
63.11.07.2008|Binjai
63.11.07.2009|Murung Abuin
63.11.07.2010|Bungin
63.11.07.2011|Maradap
63.11.07.2012|Halubau Utara
63.11.07.2013|Murung Jambu
63.11.07.2014|Telaga Purun
63.11.07.2015|Lingsir
63.11.07.2016|Tarangan
63.11.08.2001|Dayak Pitap
63.11.08.2002|Tebing Tinggi
63.11.08.2003|Sungsum
63.11.08.2004|Ju'uh
63.11.08.2005|Mayanau
63.11.08.2006|Simpang Bumbuan
63.11.08.2007|Auh
63.11.08.2008|Gunung Batu
63.11.08.2009|Langkap
63.11.08.2010|Simpang Nadong
63.11.08.2011|Ajung
63.11.08.2012|Kambiyain
63.71.01.1001|Mantuil
63.71.01.1002|Kelayan Selatan
63.71.01.1003|Pekauman
63.71.01.1004|Kelayan Barat
63.71.01.1005|Kelayan Tengah
63.71.01.1006|Kelayan Dalam
63.71.01.1007|Murung Raya
63.71.01.1008|Kelayan Timur
63.71.01.1009|Tanjung Pagar
63.71.01.1010|Pemurus Dalam
63.71.01.1011|Pemurus Baru
63.71.01.1012|Basirih Selatan
63.71.02.1001|Kuripan
63.71.02.1002|Kebun Bunga
63.71.02.1003|Karang Mekar
63.71.02.1004|Sungai Bilu
63.71.02.1005|Sungai Lulut
63.71.02.1006|Banua Anyar
63.71.02.1007|Pengambangan
63.71.02.1008|Pekapuran Raya
63.71.02.1009|Pemurus Luar
63.71.03.1001|Belitung Utara
63.71.03.1002|Belitung Selatan
63.71.03.1003|Pelambuan
63.71.03.1004|Telaga Biru
63.71.03.1005|Telawang
63.71.03.1006|Teluk Tiram
63.71.03.1007|Kuin Selatan
63.71.03.1008|Kuin Cerucuk
63.71.03.1009|Basirih
63.71.04.1001|Alalak Tengah
63.71.04.1002|Alalak Utara
63.71.04.1003|Alalak Selatan
63.71.04.1004|Sungai Jingah
63.71.04.1005|Sungai Miai
63.71.04.1006|Surgi Mufti
63.71.04.1007|Pangeran
63.71.04.1008|Antasan Kecil Timur
63.71.04.1009|Kuin Utara
63.71.04.1010|Sungai Andai
63.71.05.1001|Kertak Baru Ilir
63.71.05.1002|Kertak Baru Ulu
63.71.05.1003|Mawar
63.71.05.1004|Teluk Dalam
63.71.05.1005|Antasan Besar
63.71.05.1006|Pasar Lama
63.71.05.1007|Seberang Mesjid
63.71.05.1008|Gadang
63.71.05.1009|Melayu
63.71.05.1010|Sungai Baru
63.71.05.1011|Pekapuran Laut
63.71.05.1012|Kelayan Luar
63.72.02.1003|Landasan Ulin Timur
63.72.02.1004|Guntung Payung
63.72.02.1005|Guntung Manggis
63.72.02.1006|Syamsudin Noor
63.72.03.1001|Palam
63.72.03.1002|Bangkal
63.72.03.1003|Sungai Tiung
63.72.03.1004|Cempaka
63.72.04.1001|Loktabat Utara
63.72.04.1002|Mentaos
63.72.04.1003|Komet
63.72.04.1004|Sungai Ulin
63.72.05.1001|Sungai Besar
63.72.05.1002|Loktabat Selatan
63.72.05.1003|Kemuning
63.72.05.1004|Guntung Paikat
63.72.06.1001|Landasan Ulin Barat
63.72.06.1002|Landasan Ulin Tengah
63.72.06.1003|Landasan Ulin Utara
63.72.06.1004|Landasan Ulin Selatan
64.01.01.2009|Samurangau
64.01.01.2010|Busui
64.01.01.2011|Batu Kajang
64.01.01.2012|Legai
64.01.01.2013|Sungai Terik
64.01.01.2014|Kasungai
64.01.01.2015|Rantau Buta
64.01.01.2016|Rantau Layung
64.01.01.2017|Songka
64.01.02.2004|Keladen
64.01.02.2006|Tanjung Aru
64.01.02.2007|Labuangkallo
64.01.02.2012|Lori
64.01.02.2013|Selengot
64.01.02.2014|Random
64.01.02.2015|Senipah
64.01.03.2001|Lempesu
64.01.03.2002|Bekoso
64.01.03.2003|Damit
64.01.03.2004|Suatang
64.01.03.2005|Suliliran
64.01.03.2006|Pasir Belengkong
64.01.03.2007|Sangkuriman
64.01.03.2008|Laburan
64.01.03.2009|Suliliran Baru
64.01.03.2010|Keresik Bura
64.01.03.2011|Laburan Baru
64.01.03.2012|Seniung Jaya
64.01.03.2013|Sunge Batu
64.01.03.2014|Olong Pinang
64.01.03.2015|Suatang Keteban
64.01.04.1001|Tanah Grogot
64.01.04.2002|Janju
64.01.04.2003|Tepian Batang
64.01.04.2004|Tanah Periuk
64.01.04.2005|Pepara
64.01.04.2006|Sungai Tuak
64.01.04.2007|Sempulang
64.01.04.2008|Jone
64.01.04.2009|Rantau Panjang
64.01.04.2010|Muara Pasir
64.01.04.2011|Padang Pengrapat
64.01.04.2012|Perepat
64.01.04.2013|Pulau Rantau
64.01.04.2014|Sungai Langir
64.01.04.2015|Tapis
64.01.04.2016|Senaken
64.01.05.1001|Kuaro
64.01.05.2002|Lolo
64.01.05.2003|Sandeley
64.01.05.2004|Harapan Baru
64.01.05.2005|Rangan
64.01.05.2006|Modang
64.01.05.2007|Pasir Mayang
64.01.05.2008|Kerta Bumi
64.01.05.2009|Pondong Baru
64.01.05.2010|Padang Jaya
64.01.05.2011|Kendarom
64.01.05.2012|Klempang Sari
64.01.05.2013|Keluang Paser Jaya
64.01.06.1001|Long Ikis
64.01.06.2002|Muara Adang
64.01.06.2003|Teluk Waru
64.01.06.2004|Tajur
64.01.06.2005|Semuntai
64.01.06.2006|Lombok
64.01.06.2007|Pait
64.01.06.2008|Olung
64.01.06.2009|Kayungo
64.01.06.2010|Jemparing
64.01.06.2011|Tiwei
64.01.06.2012|Belimbing
64.01.06.2013|Long Gelang
64.01.06.2014|Krayan Jaya
64.01.06.2015|Bukit Saloka
64.01.06.2016|Krayan Sentosa
64.01.06.2017|Krayan Makmur
64.01.06.2018|Kayungo Sari
64.01.06.2019|Krayan Bahagia
64.01.06.2020|Sawit Jaya
64.01.06.2021|Sekurou Jaya
64.01.06.2022|Kerta Bhakti
64.01.06.2023|Adang Jaya
64.01.06.2024|Tajer Mulya
64.01.06.2025|Brewe
64.01.06.2026|Atang Pait
64.01.07.1001|Muara Komam
64.01.07.2002|Batu Botuk
64.01.07.2003|Uko
64.01.07.2004|Muara Langon
64.01.07.2005|Binangon
64.01.07.2006|Muara Kuaro
64.01.07.2007|Prayon
64.01.07.2008|Long Sayo
64.01.07.2009|Muara Payang
64.01.07.2010|Lusan
64.01.07.2011|Swan Slutung
64.01.07.2012|Sekuan Makmur
64.01.07.2013|Selerong
64.01.08.1001|Long Kali
64.01.08.2002|Muara Telake
64.01.08.2003|Sebakung
64.01.08.2004|Bente Tualan
64.01.08.2005|Mendik
64.01.08.2006|Munggu
64.01.08.2007|Muara Pias
64.01.08.2008|Muara Toyu
64.01.08.2009|Perkuwen
64.01.08.2010|Pinang Jatus
64.01.08.2011|Muara Lambakan
64.01.08.2012|Kepala Telake
64.01.08.2013|Mendik Makmur
64.01.08.2014|Mendik Karya
64.01.08.2015|Mendik Bhakti
64.01.08.2016|Sebakung Taka
64.01.08.2017|Maruat
64.01.08.2018|Sebakung Makmur
64.01.08.2019|Petiku
64.01.08.2020|Muara Adang II
64.01.08.2021|Makmur Jaya
64.01.08.2022|Gunung Putar
64.01.08.2023|Putang
64.01.09.2001|Kerang
64.01.09.2002|Lomu
64.01.09.2003|Segendang
64.01.09.2004|Mengkudu
64.01.09.2005|Riwang
64.01.09.2006|Langgai
64.01.09.2007|Petangis
64.01.09.2008|Tempakan
64.01.09.2009|Kerang Dayo
64.01.09.2010|Saing Prupuk
64.01.09.2011|Bai Jaya
64.01.09.2012|Pengguren Jaya
64.01.09.2013|Tebru Paser Damai
64.01.10.2001|Tanjung Pinang
64.01.10.2002|Rantau Atas
64.01.10.2003|Libur Dinding
64.01.10.2004|Luan
64.01.10.2005|Suweto
64.01.10.2006|Muser
64.01.10.2007|Biu
64.01.10.2008|Rantau Bintungan
64.01.10.2009|Muara Andeh
64.02.01.2001|Perian
64.02.01.2002|Muara Leka
64.02.01.2003|Muara Aloh
64.02.01.2004|Jantur
64.02.01.2005|Batuq
64.02.01.2006|Rebaq Rinding
64.02.01.2007|Muara Muntai Ulu
64.02.01.2008|Muara Muntai Ilir
64.02.01.2009|Kayu Batu
64.02.01.2010|Jantur Selatan
64.02.01.2011|Tanjung Batuq Harapan
64.02.01.2012|Pulau Harapan
64.02.01.2013|Jantur Baru
64.02.02.2001|Jonggon Desa
64.02.02.2002|Sungai Payang
64.02.02.2003|Jembayan
64.02.02.2004|Loa Kulu Kota
64.02.02.2005|Loh Sumber
64.02.02.2006|Ponoragan
64.02.02.2007|Rempanga
64.02.02.2008|Margahayu
64.02.02.2009|Jonggon Jaya
64.02.02.2010|Lung Anai
64.02.02.2011|Jembayan Tengah
64.02.02.2012|Jembayan Dalam
64.02.02.2013|Sepakat
64.02.02.2014|Sumber Sari
64.02.02.2015|Jongkang
64.02.03.2001|Bakungan
64.02.03.2002|Loa Duri Ulu
64.02.03.2003|Loa Janan Ulu
64.02.03.2004|Purwajaya
64.02.03.2005|Tani Bhakti
64.02.03.2006|Batuah
64.02.03.2007|Loa Duri Ilir
64.02.03.2008|Tani Harapan
64.02.04.2001|Sepatin
64.02.04.2002|Muara Pantuan
64.02.04.2003|Tani Baru
64.02.04.2004|Kutai Lama
64.02.04.2005|Anggana
64.02.04.2006|Sungai Meriam
64.02.04.2007|Sidomulyo
64.02.04.2008|Handil Terusan
64.02.05.2001|Saliki
64.02.05.2002|Salok Palai
64.02.05.2003|Muara Badak Ulu
64.02.05.2004|Muara Badak Ilir
64.02.05.2005|Tanjung Limau
64.02.05.2006|Tanah Datar
64.02.05.2007|Badak Baru
64.02.05.2008|Suka Damai
64.02.05.2009|Badak Mekar
64.02.05.2010|Gas Alam Badak I
64.02.05.2011|Batu-Batu
64.02.05.2012|Sallo Cela
64.02.05.2013|Sungai Bawang
64.02.06.1001|Jahab
64.02.06.1002|Loa Ipuh
64.02.06.1003|Bukit Biru
64.02.06.1004|Timbau
64.02.06.1005|Melayu
64.02.06.1006|Panji
64.02.06.1007|Sukarame
64.02.06.1008|Kampung Baru
64.02.06.1009|Loa Tebu
64.02.06.1010|Mangkurawang
64.02.06.1011|Maluhu
64.02.06.1013|Loa Ipuh Darat
64.02.06.2012|Rapak Lambur
64.02.06.2014|Bendang Raya
64.02.07.2001|Selerong
64.02.07.2002|Tanjung Harapan
64.02.07.2003|Beloro
64.02.07.2004|Sebulu Ulu
64.02.07.2005|Sebulu Ilir
64.02.07.2006|Segihan
64.02.07.2007|Sumber Sari
64.02.07.2008|Manunggal Daya
64.02.07.2009|Giri Agung
64.02.07.2010|Senoni
64.02.07.2011|Sebulu Moderen
64.02.07.2012|Sanggulan
64.02.07.2013|Lekaq Kidau
64.02.07.2014|Mekar Jaya
64.02.08.2004|Loleng
64.02.08.2005|Kota Bangun Ulu
64.02.08.2006|Kota Bangun Ilir
64.02.08.2007|Liang
64.02.08.2008|Muhuran
64.02.08.2009|Pela
64.02.08.2017|Kedang Murung
64.02.08.2018|Kota Bangun Seberang
64.02.08.2019|Liang Ulu
64.02.08.2020|Sebelimbingan
64.02.08.2021|Sangkuliman
64.02.09.2001|Lamin Telihan
64.02.09.2002|Lamin Pulut
64.02.09.2003|Teluk Bingkai
64.02.09.2004|Kahala
64.02.09.2005|Tubuhan
64.02.09.2006|Semayang
64.02.09.2007|Teluk Muda
64.02.09.2008|Tuana Tuha
64.02.09.2009|Kahala Ilir
64.02.10.2001|Genting Tanah
64.02.10.2002|Loa Sakoh
64.02.10.2003|Hambau
64.02.10.2004|Kembang Janggut
64.02.10.2005|Kelekat
64.02.10.2006|Pulau Pinang
64.02.10.2007|Long Beleh Haloq
64.02.10.2008|Long Beleh Modang
64.02.10.2009|Muai
64.02.10.2010|Perdana
64.02.10.2011|Bukit Layang
64.02.11.2001|Muara Kaman Ilir
64.02.11.2002|Rantau Hempang
64.02.11.2003|Teratak
64.02.11.2004|Benua Puhun
64.02.11.2005|Muara Kaman Ulu
64.02.11.2006|Sabintulung
64.02.11.2007|Muara Siran
64.02.11.2008|Tunjungan
64.02.11.2009|Sedulang
64.02.11.2010|Menamang Kiri
64.02.11.2011|Menamang Kanan
64.02.11.2012|Sidomukti
64.02.11.2013|Panca Jaya
64.02.11.2014|Bunga Jadi
64.02.11.2015|Kupang Baru
64.02.11.2016|Lebaho Ulaq
64.02.11.2017|Bukit Jering
64.02.11.2018|Liang Buaya
64.02.11.2019|Puan Cepak
64.02.11.2020|Cipari Makmur
64.02.12.2001|Gunung Sari
64.02.12.2002|Long Lalang
64.02.12.2003|Muara Ritan
64.02.12.2004|Buluk Sen
64.02.12.2005|Umaq Dian
64.02.12.2006|Muara Pedohon
64.02.12.2007|Bila Talang
64.02.12.2008|Kampung Baru
64.02.12.2009|Umaq Tukung
64.02.12.2010|Sidomulyo
64.02.12.2011|Umaq Bekuay
64.02.12.2012|Tabang Lama
64.02.12.2013|Muara Tiq
64.02.12.2014|Muara Salung
64.02.12.2015|Muara Kebaq
64.02.12.2016|Muara Belinau
64.02.12.2017|Muara Tubo
64.02.12.2018|Ritan Baru
64.02.12.2019|Tukung Ritan
64.02.13.1007|Sungai Seluang
64.02.13.1008|Wonotirto
64.02.13.1009|Tanjung Harapan
64.02.13.1010|Samboja Kuala
64.02.13.1011|Sanipah
64.02.13.1012|Handil Baru
64.02.13.1013|Muara Sembilang
64.02.13.1021|Teluk Pemedas
64.02.13.1022|Kampung Lama
64.02.13.1023|Handil Baru Darat
64.02.13.2014|Karya Jaya
64.02.13.2016|Bukit Raya
64.02.13.2019|Beringin Agung
64.02.14.1001|Muara Jawa Ilir
64.02.14.1002|Muara Jawa Tengah
64.02.14.1003|Muara Jawa Ulu
64.02.14.1004|Teluk Dalam
64.02.14.1005|Dondang
64.02.14.1006|Tama Pole
64.02.14.1007|Muara Kembang
64.02.14.1008|Muara Jawa
64.02.15.1001|Jawa
64.02.15.1002|Pendingin
64.02.15.1003|Sanga-Sanga Dalam
64.02.15.1004|Sari Jaya
64.02.15.1005|Sanga-Sanga Muara
64.02.16.2001|Manunggal Jaya
64.02.16.2002|Bukit Raya
64.02.16.2003|Embalut
64.02.16.2004|Bangun Rejo
64.02.16.2005|Kerta Buana
64.02.16.2006|Separi
64.02.16.2007|Bukit Pariaman
64.02.16.2008|Bhuana Jaya
64.02.16.2009|Mulawarman
64.02.16.2010|Loa Ulung
64.02.16.2011|Loa Raya
64.02.16.2012|Perjiwa
64.02.16.2013|Teluk Dalam
64.02.16.2014|Loa Lepu
64.02.16.2015|Suka Maju
64.02.16.2016|Loa Pari
64.02.16.2017|Karang Tunggal
64.02.16.2018|Tanjung Batu
64.02.17.2001|Sebuntal
64.02.17.2002|Santan Ulu
64.02.17.2003|Santan Tengah
64.02.17.2004|Santan Ilir
64.02.17.2005|Kersik
64.02.17.2006|Bunga Putih
64.02.17.2007|Makarti
64.02.17.2008|Prangat Selatan
64.02.17.2009|Prangat Baru
64.02.17.2010|Semangko
64.02.17.2011|Sambera Baru
64.02.18.2001|Muara Wis
64.02.18.2002|Sebemban
64.02.18.2003|Melintang
64.02.18.2004|Enggelam
64.02.18.2005|Lebak Mantan
64.02.18.2006|Lebak Cilong
64.02.18.2007|Muara Enggelam
64.02.19.2001|Kedang Ipil
64.02.19.2002|Sedulang
64.02.19.2003|Benua Baru
64.02.19.2004|Kota Bangun I
64.02.19.2005|Kota Bangun II
64.02.19.2006|Kota Bangun III
64.02.19.2007|Sumber Sari
64.02.19.2008|Sari Nadi
64.02.19.2009|Suka Bumi
64.02.19.2010|Wonosari
64.02.20.1001|Bukit Merdeka
64.02.20.1002|Sungai Merdeka
64.02.20.1003|Karya Merdeka
64.02.20.1005|Amborawang Darat
64.02.20.1006|Argo Sari
64.02.20.1007|Salok Api Darat
64.02.20.1008|Salok Api Laut
64.02.20.1009|Amborawang Laut
64.02.20.1010|Margomulyo
64.02.20.2004|Tani Bhakti
64.03.01.2001|Merabu
64.03.01.2002|Panaan
64.03.01.2003|Merapun
64.03.01.2004|Muara Lesan
64.03.01.2005|Merasa
64.03.01.2006|Lesan Dayak
64.03.01.2007|Long Beliu
64.03.01.2008|Long Duhung
64.03.01.2009|Long Lamcin
64.03.01.2010|Long Keluh
64.03.01.2011|Long Pelay
64.03.01.2012|Mapulu
64.03.01.2013|Long Sului
64.03.01.2014|Sido Bangen
64.03.02.2002|Dumaring
64.03.02.2003|Talisayan
64.03.02.2014|Campur Sari
64.03.02.2015|Bumi Jaya
64.03.02.2016|Tunggal Bumi
64.03.02.2017|Sumber Mulya
64.03.02.2018|Suka Murya
64.03.02.2019|Purna Sari Jaya
64.03.02.2021|Eka Sapta
64.03.02.2023|Capuak
64.03.03.1013|Sambaliung
64.03.03.2001|Long Lanuk
64.03.03.2002|Tumbit Dayak
64.03.03.2004|Inaran
64.03.03.2005|Pegat Bukur
64.03.03.2006|Rantau Panjang
64.03.03.2007|Suaran
64.03.03.2008|Pilanjau
64.03.03.2009|Pesayan
64.03.03.2010|Sei Bebanir Bangun
64.03.03.2011|Gurimbang
64.03.03.2012|Sukan Tengah
64.03.03.2014|Tanjung Perangat
64.03.03.2015|Bena Baru
64.03.04.2001|Long La'ai
64.03.04.2002|Punan Segah
64.03.04.2003|Long Ayap
64.03.04.2004|Long Ayan
64.03.04.2005|Punan Malinau
64.03.04.2006|Punan Mahkam
64.03.04.2007|Gunung Sari
64.03.04.2008|Pandan Sari
64.03.04.2009|Bukit Makmur
64.03.04.2010|Harapan Jaya
64.03.04.2011|Tepian Buah
64.03.04.2012|Batu Rajang
64.03.04.2013|Siduung Indah
64.03.05.1003|Sungai Bedungun
64.03.05.1004|Tanjung Redeb
64.03.05.1005|Bugis
64.03.05.1006|Gayam
64.03.05.1007|Karang Ambun
64.03.05.1008|Gunung Panjang
64.03.06.1003|Gunung Tabur
64.03.06.2001|Tasuk
64.03.06.2002|Birang
64.03.06.2004|Maluang
64.03.06.2005|Samburakat
64.03.06.2006|Sambakungan
64.03.06.2007|Merancang Ulu
64.03.06.2008|Merancang Ilir
64.03.06.2009|Pulau Besing
64.03.06.2010|Melati Jaya
64.03.06.2011|Batu-Batu
64.03.07.2001|Pegat Batumbuk
64.03.07.2002|Teluk Semanting
64.03.07.2003|Tanjung Batu
64.03.07.2004|Pulau Derawan
64.03.07.2009|Kasai
64.03.08.2001|Biduk-Biduk
64.03.08.2002|Pantai Harapan
64.03.08.2003|Tanjung Prepat
64.03.08.2004|Teluk Sumbang
64.03.08.2008|Teluk Sulaiman
64.03.08.2009|Giring-Giring
64.03.09.1002|Teluk Bayur
64.03.09.1003|Rinding
64.03.09.2001|Tumbit Melayu
64.03.09.2004|Labanan Jaya
64.03.09.2005|Labanan Makmur
64.03.09.2006|Labanan Makarti
64.03.10.2002|Tabalar Muara
64.03.10.2003|Tubaan
64.03.10.2004|Tabalar Ulu
64.03.10.2005|Semurut
64.03.10.2006|Buyung-Buyung
64.03.10.2007|Harapan Maju
64.03.11.2001|Bohe Silian
64.03.11.2002|Payung-Payung
64.03.11.2003|Teluk Alulu
64.03.11.2004|Teluk Harapan
64.03.12.2001|Tembudan
64.03.12.2002|Kayu Indah
64.03.12.2003|Batu Putih
64.03.12.2004|Lobang Kelatak
64.03.12.2005|Ampen Medang
64.03.12.2006|Balikukup
64.03.12.2007|Sumber Agung
64.03.13.2001|Biatan Ulu
64.03.13.2002|Biatan Ilir
64.03.13.2003|Karangan
64.03.13.2004|Biatan Lempake
64.03.13.2005|Manunggal Jaya
64.03.13.2006|Biatan Bapinang
64.03.13.2007|Biatan Baru
64.03.13.2008|Bukit Makmur Jaya
64.07.05.2008|Linggang Muara Leban
64.07.05.2009|Long Iram Seberang
64.07.05.2010|Long Iram Ilir
64.07.05.2011|Anah
64.07.05.2015|Long Daliq
64.07.05.2016|Long Iram Kota
64.07.05.2017|Long Iram Bayan
64.07.05.2018|Keliwai
64.07.05.2019|Ujoh Halang
64.07.05.2021|Kelian Luar
64.07.05.2022|Sukomulyo
64.07.06.1006|Melak Ilir
64.07.06.1011|Melak Ulu
64.07.06.2001|Empas
64.07.06.2002|Empakuq
64.07.06.2003|Muara Bunyut
64.07.06.2012|Muara Benangaq
64.07.07.1001|Barong Tongkok
64.07.07.1021|Simpang Raya
64.07.07.2002|Mencimai
64.07.07.2003|Engkuni Pasek
64.07.07.2004|Pepas Eheng
64.07.07.2006|Juhan Asa
64.07.07.2007|Asa
64.07.07.2008|Pepas Asa
64.07.07.2009|Muara Asa
64.07.07.2010|Ongko Asa
64.07.07.2011|Juaq Asa
64.07.07.2012|Ombau Asa
64.07.07.2013|Ngenyan Asa
64.07.07.2014|Gemuhan Asa
64.07.07.2015|Geleo Baru
64.07.07.2016|Geleo Asa
64.07.07.2017|Rejo Basuki
64.07.07.2018|Sumber Sari
64.07.07.2019|Sendawar
64.07.07.2020|Balok Asa
64.07.07.2022|Belempung Ulaq
64.07.08.2001|Besiq
64.07.08.2002|Bermai
64.07.08.2003|Muara Niliq
64.07.08.2004|Mantar
64.07.08.2005|Muara Bomboy
64.07.08.2006|Damai Seberang
64.07.08.2007|Mendika
64.07.08.2008|Damai Kota
64.07.08.2009|Lumpat Dahuq
64.07.08.2010|Muara Tokong
64.07.08.2011|Jengan Danum
64.07.08.2012|Keay
64.07.08.2013|Tepulang
64.07.08.2014|Benung
64.07.08.2020|Muara Nyahing
64.07.08.2021|Sempatn
64.07.08.2022|Kelian
64.07.09.2001|Muara Begai
64.07.09.2002|Lotaq
64.07.09.2003|Payang
64.07.09.2004|Dingin
64.07.09.2005|Muara Lawa
64.07.09.2006|Lambing
64.07.09.2007|Benggeris
64.07.09.2008|Cempedas
64.07.10.2015|Jerang Dayak
64.07.10.2016|Mendung
64.07.10.2017|Jerang Melayu
64.07.10.2018|Dasaq
64.07.10.2020|Tepian Ulaq
64.07.10.2021|Sebelang
64.07.10.2022|Muara Baroh
64.07.10.2023|Teluk Tempudau
64.07.10.2024|Tanjung Laong
64.07.10.2025|Tanjung Pagar
64.07.10.2029|Gunung Bayan
64.07.10.2030|Muara Beloan
64.07.11.2001|Pentat
64.07.11.2002|Lembonah
64.07.11.2003|Muara Nayan
64.07.11.2004|Mancong
64.07.11.2005|Perigiq
64.07.11.2006|Muara Ohong
64.07.11.2007|Tanjung Jone
64.07.11.2008|Tanjung Isuy
64.07.11.2009|Tanjung Jan
64.07.11.2010|Pulau Lanting
64.07.11.2011|Muara Tae
64.07.11.2012|Bekokong Makmur
64.07.12.2001|Gerunggung
64.07.12.2002|Pereng Taliq
64.07.12.2003|Tanjung Soke
64.07.12.2004|Deraya
64.07.12.2005|Lemper
64.07.12.2006|Muara Siram
64.07.12.2007|Resak
64.07.12.2008|Jambuk
64.07.12.2009|Muara Gusik
64.07.12.2010|Penawai
64.07.12.2011|Muara Kedang
64.07.12.2012|Jambuk Makmur 
64.07.12.2014|Siram Makmur
64.07.12.2015|Siram Jaya
64.07.12.2016|Bukit Harapan 
64.07.12.2019|Tanjung Sari
64.07.13.2001|Loa Deras
64.07.13.2002|Minta
64.07.13.2003|Tanjung Haur
64.07.13.2004|Penyinggahan Ilir
64.07.13.2005|Penyinggahan Ulu
64.07.13.2006|Bakung
64.07.14.2001|Randa Empas
64.07.14.2002|Tukuq
64.07.14.2003|Tende
64.07.14.2004|Sambung
64.07.14.2005|Anan Jaya
64.07.14.2006|Jelmu Sibak
64.07.14.2007|Suakong
64.07.14.2008|Penarung
64.07.14.2009|Dilang Puti
64.07.15.2001|Linggang Melapeh Baru
64.07.15.2002|Linggang Bigung Baru
64.07.15.2003|Linggang Tutung
64.07.15.2004|Linggang Melapeh
64.07.15.2005|Linggang Mapan
64.07.15.2006|Linggang Bigung
64.07.15.2007|Linggang Amer
64.07.15.2008|Linggang Bangunsari
64.07.15.2009|Linggang Purwodadi
64.07.15.2010|Linggang Mencelew
64.07.15.2011|Linggang Kebut
64.07.16.2001|Dempar
64.07.16.2002|Temula
64.07.16.2003|Jontai
64.07.16.2004|Sembuan
64.07.16.2005|Intu Lingau
64.07.16.2006|Mu'ut
64.07.16.2007|Terajuk
64.07.16.2008|Lakan Bilem
64.07.16.2009|Sentalar
64.07.16.2010|Awai
64.07.17.2001|Tebisaq
64.07.17.2002|Kaliq
64.07.17.2003|Tanah Mea
64.07.17.2004|Sang-Sang
64.07.17.2005|Muhur
64.07.17.2006|Muara Kelawit
64.07.17.2007|Bentas
64.07.17.2008|Betung
64.07.17.2009|Kiaq
64.07.17.2010|Tendiq
64.07.17.2011|Penawang
64.07.17.2012|Lendian Liang Nayuq
64.07.17.2013|Kenyanyan
64.07.17.2014|Rikong
64.07.17.2015|Kendesiq
64.07.17.2016|Muara Ponaq
64.07.18.2001|Sakaq Lotoq
64.07.18.2002|Sakaq Tada
64.07.18.2003|Gemuruh
64.07.18.2004|Karangan
64.07.18.2005|Merayaq
64.07.18.2006|Linggang Marimun
64.07.18.2007|Kelumpang
64.07.18.2008|Gadur
64.07.18.2009|Linggang Muara Batuq
64.07.18.2010|Muara Jawaq
64.07.18.2011|Abit
64.07.18.2012|Rembayan
64.07.18.2014|Gunung Rampah
64.07.18.2015|Jengan
64.07.18.2016|Muara Kalaq
64.07.18.2017|Tondoh
64.07.19.2001|Tering Baru
64.07.19.2002|Tering Lama
64.07.19.2003|Linggang Tering Seberang
64.07.19.2004|Tukul
64.07.19.2005|Linggang Kelubaq
64.07.19.2006|Linggang Purworejo
64.07.19.2007|Linggang Jelemuq
64.07.19.2008|Kelian Dalam
64.07.19.2009|Linggang Muara Mujan
64.07.19.2010|Muyub Ulu
64.07.19.2011|Muyub Aket
64.07.19.2013|Linggang Muyub Ilir
64.07.19.2014|Gabung Baru
64.07.19.2015|Linggang Banjarejo
64.07.19.2016|Tering Lama Ulu
64.07.20.2001|Sekolaq Joleq
64.07.20.2002|Sekolaq Muliaq
64.07.20.2003|Sekolaq Oday
64.07.20.2004|Srimulyo
64.07.20.2005|Sumber Bangun
64.07.20.2006|Sumber Rejo
64.07.20.2007|Sekolaq Darat
64.07.20.2008|Leleng
64.08.01.2001|Senyiur
64.08.01.2002|Kelinjau Ilir
64.08.01.2003|Kelinjau Ulu
64.08.01.2004|Long Nah
64.08.01.2006|Long Tesak
64.08.01.2009|Gemar Baru
64.08.01.2012|Long Poq Baru
64.08.01.2013|Muara Dun
64.08.01.2014|Teluk Baru
64.08.02.2001|Jak Luay
64.08.02.2002|Nehes Liah Bing
64.08.02.2003|Muara Wahau
64.08.02.2004|Dabeq
64.08.02.2005|Diaq Lay
64.08.02.2006|Benhes
64.08.02.2007|Wanasari
64.08.02.2008|Wahau Baru
64.08.02.2009|Karya Bhakti
64.08.02.2010|Long Wehea
64.08.03.2001|Senambah
64.08.03.2002|Ngayau
64.08.03.2003|Muara Bengkal Ilir
64.08.03.2004|Muara Bengkal Ulu
64.08.03.2005|Benua Baru
64.08.03.2013|Mulupan
64.08.03.2014|Batu Balai
64.08.04.1010|Teluk Lingga
64.08.04.2001|Sangatta Utara
64.08.04.2011|Singa Gembara
64.08.04.2012|Swarga Bara
64.08.05.2001|Kerayaan
64.08.05.2002|Tanjung Manis
64.08.05.2003|Peridan
64.08.05.2004|Saka
64.08.05.2005|Mandu Dalam
64.08.05.2006|Benua Baru Ilir
64.08.05.2011|Sempayau
64.08.05.2012|Pelawan
64.08.05.2013|Tepian Terap
64.08.05.2015|Maloy
64.08.05.2016|Benua Baru Ulu
64.08.05.2017|Kolek
64.08.05.2018|Pulau Miang
64.08.05.2019|Perupuk
64.08.05.2020|Mandu Pantai Sejahtera
64.08.06.2001|Long Bentuq
64.08.06.2002|Long Pejeng
64.08.06.2003|Long Lees
64.08.06.2004|Mekar Baru
64.08.06.2005|Rantau Sentosa
64.08.06.2006|Long Nyelong
64.08.07.2001|Marah Haloq
64.08.07.2002|Lung Melah
64.08.07.2003|Juk Ayaq
64.08.07.2004|Long Segar
64.08.07.2005|Long Noran
64.08.07.2006|Muara Pantun
64.08.07.2007|Rantau Panjang
64.08.07.2008|Kernyanyan
64.08.08.2001|Makmur Jaya
64.08.08.2002|Marga Mulya
64.08.08.2003|Sukamaju
64.08.08.2004|Sidomulyo
64.08.08.2005|Sri Pantun
64.08.08.2006|Kombeng Indah
64.08.08.2007|Miau Baru
64.08.09.2001|Sepaso
64.08.09.2002|Sekerat
64.08.09.2003|Keraitan
64.08.09.2004|Tepian Langsat
64.08.09.2005|Tebangan Lembak
64.08.09.2006|Sepaso Timur
64.08.09.2007|Sepaso Selatan
64.08.09.2008|Muara Bengalon
64.08.09.2009|Tepian Baru
64.08.09.2010|Tepian Indah
64.08.09.2011|Sepaso Barat
64.08.10.2001|Kaliorang
64.08.10.2006|Bukit Makmur
64.08.10.2007|Bukit Harapan
64.08.10.2008|Citra Manunggal Jaya
64.08.10.2009|Bangun Jaya
64.08.10.2010|Bumi Sejahtera
64.08.10.2013|Selangkau
64.08.11.2001|Sandaran
64.08.11.2002|Manubar
64.08.11.2003|Tadoan
64.08.11.2004|Marukangan
64.08.11.2005|Susuk Luar
64.08.11.2006|Susuk Dalam
64.08.11.2007|Tanjung Mangkaliat
64.08.11.2008|Manubar Dalam
64.08.11.2009|Susuk Tengah
64.08.12.1002|Singa Geweh
64.08.12.2001|Sangatta Selatan
64.08.12.2003|Sangkima
64.08.12.2004|Teluk Singkama
64.08.13.2001|Teluk Pandan
64.08.13.2002|Suka Rahmat
64.08.13.2003|Suka Damai
64.08.13.2004|Kandolo
64.08.13.2005|Danau Redan
64.08.13.2006|Martadinata
64.08.14.2001|Mukti Jaya
64.08.14.2002|Pulung Sari
64.08.14.2003|Margo Mulyo
64.08.14.2004|Rantau Makmur
64.08.14.2005|Manunggal Jaya
64.08.14.2006|Tanjung Labu
64.08.14.2007|Kebon Agung
64.08.14.2008|Tepian Makmur
64.08.14.2009|Masalap Raya
64.08.15.2001|Bumi Etam
64.08.15.2002|Bumi Rapak
64.08.15.2003|Bumi Jaya
64.08.15.2004|Cipta Graha
64.08.15.2005|Kadungan Jaya
64.08.15.2006|Pengadan Baru
64.08.15.2007|Mata Air
64.08.15.2008|Bukit Permata
64.08.16.2001|Karangan Dalam
64.08.16.2002|Batu Lepoq
64.08.16.2003|Pengadan
64.08.16.2004|Baay
64.08.16.2005|Mukti Lestari
64.08.16.2006|Karangan Seberang
64.08.16.2007|Karangan Hilir
64.08.17.2001|Batu Timbau
64.08.17.2002|Beno Harapan
64.08.17.2003|Mugi Rahayu
64.08.17.2004|Mawai Indah
64.08.17.2005|Himba Lestari
64.08.17.2006|Telaga
64.08.17.2007|Batu Timbau Ulu
64.08.18.2001|Sika Makmur
64.08.18.2002|Segoy Makmur
64.08.18.2003|Mukti Utama
64.08.18.2004|Sumber Sari
64.08.18.2005|Melan
64.08.18.2006|Tanah Abang
64.08.18.2007|Sumber Agung
64.09.01.1001|Tanjung Tengah
64.09.01.1002|Salo Loang
64.09.01.1003|Petung
64.09.01.1004|Lawe-lawe
64.09.01.1005|Pejala
64.09.01.1006|Kampung Baru
64.09.01.1007|Sesumpu
64.09.01.1008|Sungai Parit
64.09.01.1009|Nipah-Nipah
64.09.01.1010|Nenang
64.09.01.1011|Penajam
64.09.01.1012|Gunung Seteleng
64.09.01.1013|Buluminung
64.09.01.1014|Sotek
64.09.01.1015|Sepan
64.09.01.1016|Riko
64.09.01.1017|Gersik
64.09.01.1018|Jenebora
64.09.01.1019|Pantai Lango
64.09.01.2020|Giri Mukti
64.09.01.2021|Bukit Subur
64.09.01.2022|Sidorejo
64.09.01.2023|Giri Purwa
64.09.02.1003|Waru
64.09.02.2001|Api-api
64.09.02.2002|Sesulu
64.09.02.2004|Bangun Mulya
64.09.03.2001|Babulu Darat
64.09.03.2002|Labangka
64.09.03.2003|Babulu Laut
64.09.03.2004|Gunung Intan
64.09.03.2005|Gunung Makmur
64.09.03.2006|Sebakung Jaya
64.09.03.2007|Rawa Mulia
64.09.03.2008|Sri Raharja
64.09.03.2009|Sumber Sari
64.09.03.2010|Rintik
64.09.03.2011|Gunung Mulia
64.09.03.2012|Labangka Barat
64.09.04.1005|Sepaku
64.09.04.1006|Pemaluan
64.09.04.1007|Maridan
64.09.04.1008|Mentawir
64.09.04.2001|Tengin Baru
64.09.04.2002|Bukit Raya
64.09.04.2003|Suka Raja
64.09.04.2004|Bumi Harapan
64.09.04.2009|Argo Mulyo
64.09.04.2010|Semoi Dua
64.09.04.2011|Suko Mulyo
64.09.04.2012|Wono Sari
64.09.04.2013|Karang Jinawi
64.09.04.2014|Binuang
64.09.04.2015|Telemow
64.11.01.2001|Long Hurai
64.11.01.2002|Long Melaham
64.11.01.2003|Memahak Besar
64.11.01.2004|Memahak Ulu
64.11.01.2005|Batu Majang
64.11.01.2006|Ujoh Bilang
64.11.01.2007|Long Bagun Ilir
64.11.01.2008|Long Bagun Ulu
64.11.01.2009|Batoq Kelo
64.11.01.2010|Long Merah
64.11.01.2011|Rukun Damai
64.11.02.2001|Long Hubung
64.11.02.2002|Memahak Teboq
64.11.02.2003|Lutan
64.11.02.2004|Matalibaq
64.11.02.2005|Datah Bilang Ilir
64.11.02.2006|Datah Bilang Ulu
64.11.02.2007|Tri Pariq Makmur
64.11.02.2008|Wana Pariq
64.11.02.2009|Datah Bilang Baru
64.11.02.2010|Sirau
64.11.02.2011|Long Hubung Ulu
64.11.03.2001|Laham
64.11.03.2002|Long Gelawang
64.11.03.2003|Muara Ratah
64.11.03.2004|Danum Paroy
64.11.03.2005|Nyaribungan
64.11.04.2001|Long Penaneh I
64.11.04.2002|Long Kerioq
64.11.04.2003|Long Penaneh II
64.11.04.2004|Tiong Ohang
64.11.04.2005|Long Penaneh III
64.11.04.2006|Tiong Bu'u
64.11.04.2007|Naha Buan
64.11.04.2008|Naha Tifab
64.11.04.2009|Naha Silat
64.11.04.2010|Long Apari
64.11.05.2001|Delang Kerohong
64.11.05.2002|Long Pakaq
64.11.05.2003|Long Lunuk
64.11.05.2004|Long Isun
64.11.05.2005|Naha Aru
64.11.05.2006|Datah Naha
64.11.05.2007|Lirung Ubing
64.11.05.2008|Long Pahangai I
64.11.05.2009|Long Pahangai II
64.11.05.2010|Long Tuyoq
64.11.05.2011|Liu Mulang
64.11.05.2012|Long Pakaq Baru
64.11.05.2013|Long Lunuk Baru
64.71.01.1001|Manggar
64.71.01.1002|Lamaru
64.71.01.1003|Teritip
64.71.01.1004|Manggar Baru
64.71.02.1001|Baru Ilir
64.71.02.1002|Baru Tengah
64.71.02.1003|Baru Ulu
64.71.02.1004|Kariangau
64.71.02.1005|Margo Mulyo
64.71.02.1006|Marga Sari
64.71.03.1001|Batu Ampar
64.71.03.1002|Gunung Samarinda
64.71.03.1003|Karang Joang
64.71.03.1004|Muara Rapak
64.71.03.1005|Gunung Samarinda Baru
64.71.03.1006|Graha Indah
64.71.04.1001|Gunung Sari Ulu
64.71.04.1002|Gunung Sari Ilir
64.71.04.1003|Karang Rejo
64.71.04.1004|Karang Jati
64.71.04.1005|Mekar Sari
64.71.04.1006|Sumber Rejo
64.71.05.1002|Sepinggan
64.71.05.1006|Gunung Bahagia
64.71.05.1008|Sepinggan Baru
64.71.05.1009|Sepinggan Raya
64.71.05.1010|Sungainangka
64.71.05.1011|Damai Baru
64.71.05.1012|Damai Bahagia
64.71.06.1001|Prapatan
64.71.06.1002|Telaga Sari
64.71.06.1003|Klandasan Ulu
64.71.06.1004|Klandasan Ilir
64.71.06.1005|Damai
64.72.01.1001|Rawa Makmur
64.72.01.1002|Handil Bakti
64.72.01.1003|Bukuan
64.72.01.1004|Simpang Pasir
64.72.01.1005|Bantuas
64.72.02.1001|Sungai Keledang
64.72.02.1002|Baqa
64.72.02.1003|Mesjid
64.72.02.1009|Mangkupalas
64.72.02.1010|Tenun Samarinda
64.72.02.1011|Gunung Panjang
64.72.03.1001|Teluk Lerong Ilir
64.72.03.1002|Jawa
64.72.03.1004|Air Putih
64.72.03.1005|Sidodadi
64.72.03.1006|Air Hitam
64.72.03.1007|Dadi Mulya
64.72.03.1008|Gunung Kelua
64.72.03.1009|Bukit Pinang
64.72.04.1001|Selili
64.72.04.1002|Sungai Dama
64.72.04.1003|Sidomulyo
64.72.04.1013|Sidodamai
64.72.04.1014|Pelita
64.72.05.1002|Sempaja Selatan
64.72.05.1003|Lempake
64.72.05.1004|Sungai Siring Pelita
64.72.05.1010|Sempaja Utara
64.72.05.1011|Tanah Merah
64.72.05.1012|Sempaja Barat
64.72.05.1013|Sempaja Timur
64.72.05.1014|Budaya Pampang
64.72.06.1001|Loa Bakung
64.72.06.1002|Loa Buah
64.72.06.1003|Karang Asam Ulu
64.72.06.1004|Lok Bahu
64.72.06.1005|Teluk Lerong Ulu
64.72.06.1006|Karang Asam Ilir
64.72.06.1007|Karang Anyar
64.72.07.1001|Sungai Kapih
64.72.07.1002|Sambutan
64.72.07.1003|Makroman
64.72.07.1004|Sindang Sari
64.72.07.1005|Pulau Atas
64.72.08.1001|Temindung Permai
64.72.08.1002|Sungai Pinang Dalam
64.72.08.1003|Gunung Lingai
64.72.08.1004|Mugirejo
64.72.08.1005|Bandara
64.72.09.1001|Karang Mumus
64.72.09.1002|Pelabuhan
64.72.09.1003|Pasar Pagi
64.72.09.1004|Bugis
64.72.09.1005|Sungai Pinang Luar
64.72.10.1001|Simpang Tiga
64.72.10.1002|Tani Aman
64.72.10.1003|Sengkotek
64.72.10.1004|Harapan Baru
64.72.10.1005|Rapak Dalam
64.74.01.1001|Bontang Kuala
64.74.01.1002|Bontang Baru
64.74.01.1003|Lok Tuan
64.74.01.1004|Guntung
64.74.01.1005|Gunung Elai
64.74.01.1006|Api-api
64.74.02.1001|Tanjung Laut
64.74.02.1002|Berbas Tengah
64.74.02.1003|Berbas Pantai
64.74.02.1004|Satimpo
64.74.02.1005|Bontang Lestari
64.74.02.1006|Tanjung Laut Indah
64.74.03.1001|Belimbing
64.74.03.1002|Gunung Telihan
64.74.03.1003|Kanaan
65.01.01.1001|Tanjung Palas Hulu
65.01.01.1002|Tanjung Palas Tengah
65.01.01.1003|Tanjung Palas Hilir
65.01.01.1004|Karang Anyar
65.01.01.2005|Gunung Putih
65.01.01.2006|Pejalin
65.01.01.2007|Antutan
65.01.01.2008|Teras Baru
65.01.01.2009|Teras Nawang
65.01.02.2001|Long Beluah
65.01.02.2002|Long Sam
65.01.02.2003|Mara I
65.01.02.2004|Mara Hilir
65.01.02.2005|Long Pari
65.01.03.2001|Karang Agung
65.01.03.2002|Pimping
65.01.03.2003|Panca Agung
65.01.03.2004|Ruhui Rahayu
65.01.03.2005|Ardi Mulyo
65.01.03.2006|Kelubir
65.01.04.2001|Tanah Kuning
65.01.04.2002|Mangkupadi
65.01.04.2003|Sajau
65.01.04.2004|Wonomulyo
65.01.04.2005|Tanjung Agung
65.01.04.2006|Binai
65.01.04.2007|Sajau Hilir
65.01.04.2008|Pura Sajau
65.01.05.1001|Tanjung Selor Hulu
65.01.05.1002|Tanjung Selor Hilir
65.01.05.1008|Tanjung Selor Timur
65.01.05.2003|Jelarai Selor
65.01.05.2004|Gunung Seriang
65.01.05.2005|Bumi Rahayu
65.01.05.2006|Gunung Sari
65.01.05.2007|Apung
65.01.05.2009|Tengkapak
65.01.06.2001|Salimbatu
65.01.06.2002|Silva Rahayu
65.01.06.2003|Tanjung Buka
65.01.07.2001|Lepak Aru
65.01.07.2002|Long Lasan
65.01.07.2003|Long Peso
65.01.07.2004|Long Bia
65.01.07.2005|Muara Pangean
65.01.07.2006|Long Lian
65.01.07.2007|Long Pelaah
65.01.07.2008|Long Lejuh
65.01.07.2009|Long Pelban
65.01.07.2010|Long Buang
65.01.08.2001|Long Tungu
65.01.08.2002|Long Bang
65.01.08.2003|Long Telenjau
65.01.08.2004|Naha Aya
65.01.08.2005|Long Lembu
65.01.08.2006|Long Bang Hulu
65.01.09.2001|Sekatak Buji
65.01.09.2002|Paru Abang
65.01.09.2003|Bunau
65.01.09.2004|Ujang
65.01.09.2005|Tenggiling
65.01.09.2006|Kelembunan
65.01.09.2007|Turung
65.01.09.2008|Terindak
65.01.09.2009|Kelising
65.01.09.2010|Ambalat
65.01.09.2011|Keriting
65.01.09.2012|Kendari
65.01.09.2013|Bambang
65.01.09.2014|Maritam
65.01.09.2015|Pentian
65.01.09.2016|Punan Dulau
65.01.09.2017|Kelincauan
65.01.09.2018|Bekiliu
65.01.09.2019|Sekatak Bengara
65.01.09.2020|Pungit
65.01.09.2021|Anjar Arip
65.01.09.2022|Liagu
65.01.10.2001|Bunyu Barat
65.01.10.2002|Bunyu Selatan
65.01.10.2003|Bunyu Timur
65.02.01.2002|Long Bisai
65.02.01.2005|Pulau Sapi
65.02.01.2006|Paking
65.02.01.2007|Lidung Kemenci
65.02.01.2008|Mentarang Baru
65.02.01.2009|Harapan Maju
65.02.02.2001|Batu Lidung
65.02.02.2002|Malinau Kota
65.02.02.2003|Pelita Kanaan
65.02.02.2004|Malinau Hulu
65.02.02.2005|Malinau Hilir
65.02.02.2006|Tanjung Keranjang
65.02.03.2001|Long Pujungan
65.02.03.2002|Long Ketaman
65.02.03.2003|Long Pua
65.02.03.2004|Long Lame
65.02.03.2005|Long Jelet
65.02.03.2006|Long Aran
65.02.03.2007|Long Peliran
65.02.03.2008|Long Bena
65.02.03.2009|Long Belaka Pitau
65.02.04.2001|Data Dian
65.02.04.2002|Long Pipa
65.02.04.2003|Long Sule
65.02.04.2004|Sungai Anai
65.02.04.2005|Long Metun
65.02.05.2001|Long Nawang
65.02.05.2002|Nawang Baru
65.02.05.2003|Long Temuyat
65.02.05.2004|Long Betaoh
65.02.05.2005|Long Payau
65.02.06.2001|Bila Bekayuk
65.02.06.2002|Long Loreh
65.02.06.2003|Langap
65.02.06.2004|Laban Nyarit
65.02.06.2005|Nunuk Tanah Kibang
65.02.06.2006|Pelencau
65.02.06.2007|Paya Seturan
65.02.06.2008|Punan Rian
65.02.06.2009|Sengayan
65.02.07.2001|Kaliamok
65.02.07.2002|Luso
65.02.07.2003|Malinau Seberang
65.02.07.2004|Putat
65.02.07.2005|Salap
65.02.07.2006|Seruyung
65.02.07.2007|Respen Tubu
65.02.07.2008|Belayan
65.02.07.2009|Sembuak Warod
65.02.07.2010|Lubak Manis
65.02.07.2011|Kelapis
65.02.07.2012|Semengaris
65.02.08.2001|Long Bila
65.02.08.2002|Long Kenipe
65.02.08.2003|Punan Bengalun
65.02.08.2004|Sesua
65.02.08.2005|Sentaban
65.02.08.2006|Tanjung Lapang
65.02.08.2007|Taras
65.02.08.2008|Kuala Lapang
65.02.08.2009|Sempayang
65.02.09.2001|Dumu Mahak
65.02.09.2002|Long Lebusan
65.02.09.2003|Mahak Baru
65.02.09.2004|Long Top
65.02.09.2005|Agung Baru
65.02.09.2006|Data Baru
65.02.10.2001|Long Ampung
65.02.10.2002|Long Uro
65.02.10.2003|Lidung Payau
65.02.10.2004|Sungai Barang
65.02.10.2005|Metulang
65.02.11.2001|Long Uli
65.02.11.2002|Long Alango
65.02.11.2003|Long Berini
65.02.11.2004|Long Tebulo
65.02.11.2005|Apau Ping
65.02.11.2006|Long Kemuat
65.02.12.2001|Lung Fala
65.02.12.2002|Lung Kebinu
65.02.12.2003|Lung Mekatif
65.02.12.2004|Lung Simau
65.02.12.2005|Lung Berang
65.02.12.2006|Lung Sulit
65.02.12.2007|Lung Semamu
65.02.12.2008|Long Gafid
65.02.12.2009|Temalang
65.02.12.2010|Long Liku
65.02.13.2001|Setulang
65.02.13.2002|Setarap
65.02.13.2003|Punan Setarap
65.02.13.2004|Batu Kajang
65.02.13.2005|Gong Solok
65.02.13.2006|Punan Gong Solok
65.02.13.2007|Long Adiu
65.02.13.2008|Punan Long Adiu
65.02.14.2001|Long Lake
65.02.14.2002|Punan Mirau
65.02.14.2003|Long Rat
65.02.14.2004|Halanga
65.02.14.2005|Metut
65.02.14.2006|Long Jalan
65.02.14.2007|Nahakramo
65.02.14.2008|Tanjung Nanga
65.02.15.2001|Long Nyau
65.02.15.2002|Long Titi
65.02.15.2003|Long Ranau
65.02.15.2004|Rian Tubu
65.02.15.2005|Long Pada
65.03.01.2001|Tanjungkarang
65.03.01.2002|Balansiku
65.03.01.2003|Sungai Manurung
65.03.01.2004|Padaidi
65.03.02.1001|Nunukan Timur
65.03.02.1002|Nunukan Barat
65.03.02.1003|Nunukan Utara
65.03.02.1005|Nunukan Tengah
65.03.02.2004|Binusan
65.03.03.2001|Tagul
65.03.03.2002|Lubakan
65.03.03.2003|Atap
65.03.03.2004|Manuk Bungkul
65.03.03.2005|Tujung
65.03.03.2006|Pagar
65.03.03.2007|Labuk
65.03.03.2008|Butas Bagu
65.03.03.2009|Pelaju
65.03.03.2010|Tepian
65.03.04.2001|Deralon
65.03.04.2002|Liang
65.03.04.2003|Dabulon
65.03.04.2004|Taluan
65.03.04.2005|Podong
65.03.04.2006|Patal I
65.03.04.2007|Siawang
65.03.04.2008|Sapuyan
65.03.04.2009|Nainsid
65.03.04.2010|Sasibu
65.03.04.2011|Saludan
65.03.04.2012|Semalat
65.03.04.2013|Libang
65.03.04.2014|Sedongon
65.03.04.2015|Tanjung Hilir
65.03.04.2016|Sumalumung
65.03.04.2017|Lintong
65.03.04.2018|Pulu Bulawan
65.03.04.2019|Tanjung Hulu
65.03.04.2020|Patal II
65.03.04.2021|Pa'loo
65.03.04.2022|Sangkub
65.03.04.2023|Tubus
65.03.04.2024|Likos
65.03.04.2025|Bulan-Bulan
65.03.04.2026|Kalampising
65.03.04.2027|Pa'lemumut
65.03.04.2028|Mansalong
65.03.05.2002|Pa' Padi
65.03.05.2003|Cinglat
65.03.05.2022|Liang Butan
65.03.05.2029|Pa' Rupai
65.03.05.2030|Ba Sikor
65.03.05.2031|Pa' Nado
65.03.05.2032|Buduk Kinangan
65.03.05.2033|Liang Tuer
65.03.05.2034|Buduk Tumu
65.03.05.2035|Long Berayang
65.03.05.2036|Pa' Api
65.03.05.2037|Pa' Sire
65.03.05.2038|Wa' Yanud
65.03.05.2039|Long Nawang
65.03.05.2040|Long Katung
65.03.05.2041|Long Bawan
65.03.05.2044|Long Matung
65.03.05.2045|Long Rupan
65.03.05.2046|Liang Biadung
65.03.05.2047|Wa' Laya
65.03.05.2048|Pa' Matung
65.03.05.2049|Pa' Terutun
65.03.05.2065|Pa' Putuk
65.03.06.2001|Pembeliangan
65.03.06.2002|Apas
65.03.06.2003|Kunyit
65.03.06.2004|Tetaban
65.03.06.2005|Kekayap
65.03.06.2006|Bebanas
65.03.06.2007|Lulu
65.03.06.2008|Sujau
65.03.06.2009|Melasu Baru
65.03.06.2010|Harapan
65.03.07.2001|Long Pasia
65.03.07.2002|Liang Lunuk
65.03.07.2003|Pa' Ibang
65.03.07.2004|Pa' Amai
65.03.07.2005|Pa' Kaber
65.03.07.2006|Pa' Tera
65.03.07.2007|Pa' Sing
65.03.07.2009|Pa' Dalan
65.03.07.2010|Long Birar
65.03.07.2011|Pa' Upan
65.03.07.2016|Long Budung
65.03.07.2018|Long Pupung
65.03.07.2020|Pa' Urang
65.03.08.2001|Liang Bunyu
65.03.08.2002|Binalawan
65.03.08.2003|Setabu
65.03.08.2004|Bambangan
65.03.09.1001|Selisun
65.03.09.1002|Nunukan Selatan
65.03.09.1003|Mansapa
65.03.09.1004|Tanjung Harapan
65.03.10.2001|Sungai Nyamuk
65.03.10.2002|Tanjung Harapan
65.03.10.2003|Bukit Aru Indah
65.03.10.2004|Tanjung Aru
65.03.11.2001|Sungai Pancang
65.03.11.2002|Lapri
65.03.11.2003|Seberang
65.03.12.2001|Sungai Limau
65.03.12.2002|Maspul
65.03.12.2003|Aji Kuning
65.03.12.2004|Bukit Harapan
65.03.13.2001|Srinanti
65.03.13.2002|Tabur Lestari
65.03.13.2003|Samaenre Semaja
65.03.13.2004|Sekaduyan Taka
65.03.14.2001|Sanur
65.03.14.2002|Makmur
65.03.14.2003|Semunad
65.03.14.2004|Sekikilan
65.03.14.2005|Kalunsayan
65.03.14.2006|Tembalang
65.03.14.2007|Salang
65.03.14.2008|Tinampak I
65.03.14.2009|Tinampak II
65.03.14.2010|Naputi
65.03.14.2011|Tau Baru
65.03.14.2012|Balatikon
65.03.15.2001|Payang
65.03.15.2002|Suyadon
65.03.15.2003|Bulu Mengolom
65.03.15.2004|Tukulon
65.03.15.2005|Ubol Sulok
65.03.15.2006|Batung
65.03.15.2007|Ubol Alung
65.03.15.2008|Nansapan
65.03.15.2009|Samunti
65.03.15.2010|Semata
65.03.15.2011|Sungoi
65.03.15.2012|Salan
65.03.15.2013|Sinampila I
65.03.15.2014|Paluan
65.03.15.2015|Sedalit
65.03.15.2016|Tambalang Hilir
65.03.15.2017|Tadungus
65.03.15.2018|Sinampila II
65.03.15.2019|Kalambuku
65.03.15.2020|Jukup
65.03.15.2021|Long Bulu
65.03.15.2023|Linsayung
65.03.15.2024|Tumantalas
65.03.15.2025|Sanal
65.03.15.2026|Limpakon
65.03.15.2027|Labuk
65.03.16.2001|Lubok Buat
65.03.16.2002|Katul
65.03.16.2003|Mambulu
65.03.16.2004|Pagaluyon
65.03.16.2005|Saduman
65.03.16.2006|Tulang
65.03.16.2007|Sabuluan
65.03.16.2008|Pulau Keras
65.03.16.2009|Liuk Bulu
65.03.16.2010|Binanun
65.03.17.2001|Tang Paye
65.03.17.2002|Long Rungan
65.03.17.2003|Long Kelupan
65.03.17.2004|Long Padi
65.03.17.2005|Tang Badui
65.03.17.2006|Binuang
65.03.17.2007|Long Mutan
65.03.17.2008|Pa' Milau
65.03.17.2009|Ba' Liku
65.03.17.2010|Long Rian
65.03.17.2011|Pa' Yalau
65.03.18.2001|Pa' Betung
65.03.18.2002|Long Sepayang
65.03.18.2003|Pa' Pawan
65.03.18.2004|Pa' Melade
65.03.18.2005|Pa' Kebuan
65.03.18.2006|Pa' Umung
65.03.18.2007|Pa' Rangeb
65.03.18.2008|Long Umung
65.03.18.2009|Long Tenem
65.03.18.2010|Long Nuat
65.03.18.2011|Pa' Pala
65.03.18.2012|Sinar Baru
65.03.18.2013|Pa' Lidung
65.03.18.2014|Pa' Raye
65.03.18.2015|Bungayan
65.03.18.2016|Wa' Yagung
65.03.18.2017|Kampung Baru
65.03.19.2001|Pa' Mulak
65.03.19.2002|Long Puak
65.03.19.2003|Long Mangan
65.03.19.2004|Buduk Kubul
65.03.19.2005|Long Kabid
65.03.19.2006|Pa' Inan
65.03.19.2007|Lembudud
65.03.19.2008|Long Tugul
65.03.19.2009|Pa' Butal
65.03.19.2010|Pa' Delung
65.03.19.2011|Pa' Urud
65.03.19.2012|Pa' Kemut
65.03.19.2013|Pa' Kidang
65.03.19.2014|Lembada
65.03.19.2015|Pa' Payak
65.03.19.2016|Pa' Pirit
65.03.19.2017|Liang Aliq
65.03.19.2018|Sembudud
65.03.19.2019|Liang Turan
65.03.19.2020|Liang Bua
65.03.19.2021|Lepatar
65.03.19.2022|Pa' Mering
65.03.19.2023|Pa' Pani
65.03.19.2024|Pa' Lutut
65.03.19.2025|Ma' Libu
65.03.20.2001|Sumentobol
65.03.20.2002|Nantukidan
65.03.20.2003|Labang
65.03.20.2004|Sumantipal
65.03.20.2005|Ngawol
65.03.20.2006|Bululaun Hilir
65.03.20.2007|Lagas
65.03.20.2008|Panas
65.03.20.2009|Langgason
65.03.20.2010|Tantalujuk
65.03.20.2011|Tambalang Hulu
65.03.20.2012|Kuyo
65.03.20.2013|Bokok
65.03.21.2001|Tau Lumbis
65.03.21.2002|Lipaga
65.03.21.2003|Bululaun Hulu
65.03.21.2004|Kalisun
65.03.21.2005|Mamasin
65.03.21.2006|Sibalu
65.03.21.2007|Duyan
65.03.21.2008|Tuntulibing
65.03.21.2009|Tetagas
65.03.21.2010|Kabungolor
65.04.01.2001|Tideng Pale
65.04.01.2002|Limbu Sedulun
65.04.01.2003|Sebidai
65.04.01.2004|Sedulun
65.04.01.2005|Tideng Pale Timur
65.04.01.2006|Gunawan
65.04.01.2007|Sebawang
65.04.02.2001|Sesayap
65.04.02.2002|Sengkong
65.04.02.2003|Bebatu
65.04.02.2004|Bandan Bikis
65.04.02.2005|Sepala Dalung
65.04.02.2006|Seludau
65.04.02.2007|Menjelutung
65.04.02.2008|Sesayap Selor
65.04.03.2001|Tanah Merah
65.04.03.2002|Tengku Dacing
65.04.03.2003|Sambungan
65.04.03.2004|Tanah Merah Barat
65.04.03.2005|Sambungan Selatan
65.04.04.2001|Buong Baru
65.04.04.2002|Bebakung
65.04.04.2003|Kujau
65.04.04.2004|Mendupo
65.04.04.2005|Maning
65.04.04.2006|Periuk
65.04.05.2001|Seputuk
65.04.05.2002|Rian
65.04.05.2003|Balayan Ari
65.04.05.2004|Rian Rayo
65.04.05.2005|Kapuak
65.04.05.2006|Sapari
65.71.01.1001|Karang Anyar
65.71.01.1002|Karang Rejo
65.71.01.1003|Karang Anyar Pantai
65.71.01.1004|Karang Balik
65.71.01.1005|Karang Harapan
65.71.02.1001|Kampung I Skip
65.71.02.1002|Pamusian
65.71.02.1003|Sebengkok
65.71.02.1004|Selumit
65.71.02.1005|Selumit Pantai
65.71.03.1001|Lingkas Ujung
65.71.03.1002|Gunung Lingkas
65.71.03.1003|Kampung Empat
65.71.03.1004|Kampung Enam
65.71.03.1005|Mamburungan
65.71.03.1006|Pantai Amal
65.71.03.1007|Mamburungan Timur
65.71.04.1001|Juata Laut
65.71.04.1002|Juata Permai
65.71.04.1003|Juata Kerikil
71.01.05.2001|Ayong
71.01.05.2002|Babo
71.01.05.2003|Bolangat
71.01.05.2004|Maelang
71.01.05.2005|Domisil Moonow
71.01.05.2006|Pangi
71.01.05.2012|Lolanan
71.01.05.2015|Cempaka
71.01.05.2017|Batu Merah
71.01.05.2018|Pasir Putih
71.01.05.2019|Pangi Timur
71.01.05.2020|Bolangat Timur
71.01.09.2001|Matayangan
71.01.09.2002|Uuan
71.01.09.2003|Ikhwan
71.01.09.2004|Doloduo
71.01.09.2005|Wangga Baru
71.01.09.2010|Toraut
71.01.09.2011|Mekaruo
71.01.09.2017|Toraut Utara
71.01.09.2018|Doloduo Satu
71.01.09.2019|Doloduo Dua
71.01.09.2020|Doloduo Tiga
71.01.09.2022|Toraut Tengah
71.01.10.1003|Imandi
71.01.10.2001|Tonom
71.01.10.2002|Mogoyunggung
71.01.10.2004|Modomang
71.01.10.2005|Kembang Mertha
71.01.10.2006|Dumoga
71.01.10.2013|Pinonobatuan
71.01.10.2017|Dumoga II
71.01.10.2018|Pinonobatuan Barat
71.01.10.2019|Amertha Sari
71.01.10.2020|Kembang Sari
71.01.10.2021|Amertha Buana
71.01.10.2023|Mogoyunggung Satu
71.01.10.2024|Mogoyunggung Dua
71.01.10.2025|Dumoga Tiga
71.01.10.2026|Dumoga Empat
71.01.11.2001|Tumokang Baru
71.01.11.2002|Mopugad Utara
71.01.11.2003|Mopugad Selatan
71.01.11.2004|Mopuya Utara
71.01.11.2005|Mopuya Selatan
71.01.11.2007|Dondomon
71.01.11.2014|Mopugad Utara Satu
71.01.11.2015|Mopugad Utara Dua
71.01.11.2016|Mopugad Selatan Satu
71.01.11.2017|Mopuya Utara Satu
71.01.11.2018|Mopuya Utara Dua
71.01.11.2019|Mopuya Selatan Satu
71.01.11.2020|Mopuya Selatan Dua
71.01.11.2024|Dondomon Utara
71.01.11.2025|Dondomon Selatan
71.01.11.2026|Tumokang Timur
71.01.12.2001|Totabuan
71.01.12.2002|Pindol
71.01.12.2003|Solog
71.01.12.2004|Tandu
71.01.12.2005|Lolak
71.01.12.2006|Motabang
71.01.12.2007|Mongkoinit
71.01.12.2008|Labuan Uki
71.01.12.2009|Pinogaluman
71.01.12.2010|Sauk
71.01.12.2011|Lalow
71.01.12.2012|Buntalo
71.01.12.2013|Bumbung
71.01.12.2014|Baturapa
71.01.12.2015|Tuyat
71.01.12.2016|Pindolili
71.01.12.2017|Lolak Tombolango
71.01.12.2018|Lolak II
71.01.12.2019|Buntalo Timur
71.01.12.2020|Buntalo Selatan
71.01.12.2021|Baturapa II
71.01.12.2022|Diat
71.01.12.2023|Pinogaluman Timur
71.01.12.2024|Mongkoinit Barat
71.01.12.2025|Dulangon
71.01.12.2026|Padang Lalow
71.01.13.1006|Inobonto
71.01.13.2001|Komangaan
71.01.13.2002|Solimandungan II
71.01.13.2003|Solimandungan I
71.01.13.2004|Bangomulunow
71.01.13.2005|Langagon
71.01.13.2007|Inobonto II
71.01.13.2014|Inobonto
71.01.13.2015|Langagon Satu
71.01.13.2016|Langagon Dua
71.01.13.2017|Solimandungan Baru
71.01.14.2001|Bombanon
71.01.14.2002|Abak
71.01.14.2003|Tapa Aog
71.01.14.2004|Mopusi
71.01.14.2005|Matali Baru
71.01.14.2006|Bakan
71.01.14.2007|Tanoyan Selatan
71.01.14.2008|Tungoi I
71.01.14.2009|Lolayan
71.01.14.2010|Mopait
71.01.14.2017|Kopandakan II
71.01.14.2019|Tanoyan Utara
71.01.14.2020|Tungoi II
71.01.14.2021|Mengkang
71.01.19.2001|Muntoi
71.01.19.2002|Poyuyanan
71.01.19.2003|Lobong
71.01.19.2004|Passi
71.01.19.2017|Bintau
71.01.19.2018|Bulud
71.01.19.2019|Otam
71.01.19.2020|Wangga
71.01.19.2022|Inuai
71.01.19.2023|Passi II
71.01.19.2024|Muntoi Timur
71.01.19.2025|Otam Barat
71.01.19.2026|Wangga Satu
71.01.20.2001|Mariri Lama
71.01.20.2002|Mariri Baru
71.01.20.2003|Nonapan II
71.01.20.2004|Nonapan I
71.01.20.2005|Wineru
71.01.20.2006|Gogaluman
71.01.20.2007|Poigar I
71.01.20.2008|Nanasi
71.01.20.2009|Pomoman
71.01.20.2010|Tiberias
71.01.20.2011|Mondatong
71.01.20.2012|Poigar II
71.01.20.2013|Poigar III
71.01.20.2014|Mariri II
71.01.20.2015|Mariri I
71.01.20.2016|Nonapan Baru
71.01.20.2017|Nanasi Timur
71.01.20.2018|Nonapan
71.01.20.2019|Tanjung Mariri
71.01.20.2020|Mondatong Baru
71.01.22.2003|Pangian
71.01.22.2004|Poopo
71.01.22.2005|Manembo
71.01.22.2006|Sinsingon
71.01.22.2007|Insil
71.01.22.2009|Mobuya
71.01.22.2012|Insil Baru
71.01.22.2013|Pangian Tengah
71.01.22.2014|Pangian Barat
71.01.22.2015|Poopo Barat
71.01.22.2016|Poopo Selatan
71.01.22.2017|Sinsingon Barat
71.01.22.2018|Sinsingon Timur
71.01.31.2001|Ambang I
71.01.31.2002|Ambang II
71.01.31.2003|Tadoy
71.01.31.2004|Bolaang
71.01.31.2005|Bantik
71.01.31.2006|Lolan
71.01.31.2007|Tadoy I
71.01.31.2008|Bolaang Satu
71.01.31.2009|Lolan Dua
71.01.32.2001|Bilalang III
71.01.32.2002|Bilalang IV
71.01.32.2003|Tudu Aog
71.01.32.2004|Tudu Aog Baru
71.01.32.2005|Kolinganga'an
71.01.32.2006|Bilalang III Utara
71.01.32.2007|Bilalang Baru
71.01.32.2008|Apado
71.01.33.2001|Serasi
71.01.33.2002|Kanaan
71.01.33.2003|Toruakat
71.01.33.2004|Pusian
71.01.33.2005|Ponompiaan
71.01.33.2006|Mototabian
71.01.33.2007|Bumbungon
71.01.33.2008|Siniyung
71.01.33.2009|Siniyung Satu
71.01.33.2010|Dumoga Satu
71.01.33.2011|Pusian Selatan
71.01.33.2012|Pusian Barat
71.01.34.2001|Bonawang
71.01.34.2002|Tapadaka Satu
71.01.34.2003|Tapadaka Utara
71.01.34.2004|Tapadaka Timur
71.01.34.2005|Konarom
71.01.34.2006|Konarom Barat
71.01.34.2007|Konarom Utara
71.01.34.2008|Osion
71.01.34.2009|Ikuna
71.01.34.2010|Dumara
71.01.35.2001|Ibolian
71.01.35.2002|Ibolian Satu
71.01.35.2003|Kinomaligan
71.01.35.2004|Kosio
71.01.35.2005|Kosio Timur
71.01.35.2006|Kasio Barat
71.01.35.2007|Werdhi Agung
71.01.35.2008|Werdhi Agung Selatan
71.01.35.2009|Werdhi Agung Utara
71.01.35.2010|Werdhi Agung Timur
71.02.01.1007|Masarang
71.02.01.1008|Rinegetan
71.02.01.1009|Roong
71.02.01.1010|Tuutu
71.02.01.1011|Tounkuramber
71.02.01.1012|Wawalintouan
71.02.01.1013|Rerewokan
71.02.01.1014|Watulambot
71.02.01.1015|Wewelan
71.02.02.1001|Luaan
71.02.02.1005|Ranowangko
71.02.02.1006|Wengkol
71.02.02.1007|Kendis
71.02.02.1008|Katinggolan
71.02.02.1009|Liningaan
71.02.02.1010|Taler
71.02.02.1011|Kiniar
71.02.02.1012|Touluor
71.02.02.1013|Papakelan
71.02.02.1014|Makalounsow
71.02.03.2001|Telap
71.02.03.2002|Watumea
71.02.03.2003|Eris
71.02.03.2004|Maumbi
71.02.03.2005|Tandengan
71.02.03.2006|Ranomerut
71.02.03.2007|Touliang Oki
71.02.03.2008|Tandengan Satu
71.02.04.2001|Tulap
71.02.04.2002|Lalumpe
71.02.04.2003|Kayubesi
71.02.04.2004|Ranowangko II
71.02.04.2005|Kombi
71.02.04.2006|Sawangan
71.02.04.2007|Kolongan
71.02.04.2008|Rerer
71.02.04.2009|Kinaleosan
71.02.04.2010|Makalisung
71.02.04.2011|Kalawiran
71.02.04.2012|Kolongan Satu
71.02.04.2013|Rerer Satu
71.02.05.2001|Kapataran
71.02.05.2002|Seretan
71.02.05.2003|Atep Oki
71.02.05.2004|Karor
71.02.05.2005|Kaleosan
71.02.05.2006|Watulaney
71.02.05.2007|Kayuroya
71.02.05.2008|Seretan Timu
71.02.05.2009|Parentek
71.02.05.2010|Kapataran Satu
71.02.05.2011|Watulaney Amian
71.02.06.2003|Kayuwatu
71.02.06.2004|Wineru
71.02.06.2005|Rinondor
71.02.06.2006|Sendangan
71.02.06.2015|Pahaleten
71.02.06.2016|Talikuran
71.02.06.2017|Tounelet
71.02.06.2018|Paslaten
71.02.06.2019|Kaweng
71.02.06.2020|Toulimembet
71.02.06.2021|Makalelon
71.02.06.2022|Tumpaan
71.02.06.2023|Mahembang
71.02.07.2004|Tember
71.02.07.2005|Kamanga
71.02.07.2006|Sendangan
71.02.07.2007|Talikuran
71.02.07.2009|Tempok
71.02.07.2010|Liba
71.02.07.2011|Tolok
71.02.07.2012|Kamanga Dua
71.02.07.2016|Tempok Selatan
71.02.07.2017|Tolok Satu
71.02.08.2001|Kasuratan
71.02.08.2002|Parepei
71.02.08.2003|Pulutan
71.02.08.2004|Sinuian
71.02.08.2005|Kaima
71.02.08.2006|Sendangan
71.02.08.2007|Timu
71.02.08.2008|Talikuran
71.02.08.2009|Tampusu
71.02.08.2010|Paslaten
71.02.08.2011|Leleko
71.02.09.2004|Wolaang
71.02.09.2005|Teep
71.02.09.2006|Karondoran
71.02.09.2007|Waleure
71.02.09.2008|Amongena I
71.02.09.2009|Amongena II
71.02.09.2010|Sumarayar
71.02.09.2018|Amongena III
71.02.10.2001|Koyawas
71.02.10.2002|Walewangko
71.02.10.2003|Noongan
71.02.10.2004|Raringis
71.02.10.2005|Ampreng
71.02.10.2006|Tumaratas
71.02.10.2009|Paslaten
71.02.10.2010|Lowian
71.02.10.2011|Tounelet
71.02.10.2014|Kopiwangker
71.02.10.2015|Noongan Dua
71.02.10.2016|Noongan Tiga
71.02.10.2017|Tumaratas Dua
71.02.10.2018|Raranon
71.02.10.2019|Raringis Utara
71.02.10.2020|Raringis Selatan
71.02.11.2001|Leilem
71.02.11.2002|Kolongan Atas
71.02.11.2003|Tounelet Satu
71.02.11.2004|Talikuran
71.02.11.2005|Kauneran
71.02.11.2006|Sendangan
71.02.11.2007|Rambunan
71.02.11.2008|Sawangan
71.02.11.2009|Tincep
71.02.11.2010|Timbukar
71.02.11.2011|Leilem Dua
71.02.11.2012|Leilem Tiga
71.02.11.2013|Kolongan Atas Dua
71.02.11.2014|Kauneran Satu
71.02.11.2015|Rambunan Amian
71.02.11.2016|Sendangan I
71.02.11.2017|Talikuran Satu
71.02.11.2018|Tounelet Satu
71.02.11.2019|Kolongan Atas Satu
71.02.12.1005|Sendangan
71.02.12.1011|Kinali
71.02.12.1019|Sendangan Selatan
71.02.12.1020|Sendangan Tengah
71.02.12.1028|Uner Satu
71.02.12.1029|Kinali Satu
71.02.12.2012|Tondegesan
71.02.12.2016|Kanonang Tiga
71.02.12.2030|Tondegesan Satu
71.02.12.2031|Tondegesan Dua
71.02.13.2001|Pineleng I
71.02.13.2002|Pineleng II
71.02.13.2003|Sea I
71.02.13.2004|Sea II
71.02.13.2005|Winagun Atas
71.02.13.2006|Warembungan
71.02.13.2007|Sea
71.02.13.2014|Kali
71.02.13.2016|Kali Selatan
71.02.13.2020|Pineleng Dua Indah
71.02.13.2021|Lotta
71.02.13.2022|Sea Mitra
71.02.13.2023|Sea Tumpengan
71.02.13.2024|Pineleng Satu Timur
71.02.14.2001|Kembes II
71.02.14.2002|Kembes I
71.02.14.2003|Toumbuluan
71.02.14.2004|Koka
71.02.14.2005|Suluan
71.02.14.2006|Kamangta
71.02.14.2007|Sawangan
71.02.14.2008|Rumengkor
71.02.14.2009|Tikela
71.02.14.2010|Rumengkor Satu
71.02.14.2011|Rumengkor Dua
71.02.15.2001|Kumu
71.02.15.2002|Teling
71.02.15.2003|Poopoh
71.02.15.2004|Ranowangko
71.02.15.2005|Senduk
71.02.15.2007|Pinasungkulan
71.02.15.2009|Mokupa
71.02.15.2010|Sarani Matani
71.02.15.2011|Borgo
71.02.15.2012|Tambala
71.02.16.1001|Sumalangka
71.02.16.1002|Sasaran
71.02.16.1003|Kampung Jawa
71.02.16.1004|Wulauan
71.02.16.1005|Marawas
71.02.16.2006|Tonsea Lama
71.02.16.2007|Kembuan
71.02.16.2008|Kembuan Satu
71.02.17.2001|Palamba
71.02.17.2002|Atep
71.02.17.2003|Manembo
71.02.17.2004|Temboan
71.02.17.2005|Rumbia
71.02.17.2006|Winebetan
71.02.17.2007|Kaayuran Atas
71.02.17.2008|Kaayuran Bawah
71.02.17.2009|Kawatak
71.02.17.2010|Atep Satu
71.02.18.1001|Urongo
71.02.18.1002|Tounsaru
71.02.18.1003|Tataaran II
71.02.18.1004|Tataaran I
71.02.18.1005|Koya
71.02.18.1006|Paleloan
71.02.18.1007|Tataaran Patar
71.02.18.1008|Maesa Unima
71.02.19.2001|Walantakan
71.02.19.2002|Taraitak
71.02.19.2003|Karumenga
71.02.19.2004|Toraget
71.02.19.2005|Tempang
71.02.19.2006|Tempang Dua
71.02.19.2007|Tempang Tiga
71.02.19.2008|Taraitak Satu
71.02.20.2001|Wasian
71.02.20.2002|Panasen
71.02.20.2003|Tountimomor
71.02.20.2004|Totolan
71.02.20.2005|Passo
71.02.20.2006|Kalawiran
71.02.20.2007|Touliang
71.02.20.2008|Simbel
71.02.20.2009|Wailang
71.02.20.2010|Bukit Tinggi
71.02.21.1001|Talikuran
71.02.21.1002|Talikuran Utara
71.02.21.1003|Talikuran Barat
71.02.21.1004|Uner
71.02.21.2005|Kiawa Satu
71.02.21.2006|Kiawa Satu Utara
71.02.21.2007|Kiawa Satu Barat
71.02.21.2008|Kiawa Dua
71.02.21.2009|Kiawa Dua Timur
71.02.21.2010|Kiawa Dua Barat
71.02.22.2001|Kayuuwi
71.02.22.2002|Kayuuwi Satu
71.02.22.2003|Kanonang Satu
71.02.22.2004|Kanonang Dua
71.02.22.2005|Kanonang Empat
71.02.22.2006|Kanonang Lima
71.02.22.2007|Tombasian Atas
71.02.22.2008|Tombasian Atas Satu
71.02.22.2009|Tombasian Bawah
71.02.22.2010|Ranolambot
71.02.23.2001|Kalasey Satu
71.02.23.2002|Kalasey Dua
71.02.23.2003|Tateli
71.02.23.2004|Tateli Weru
71.02.23.2005|Tateli Satu
71.02.23.2006|Tateli Dua
71.02.23.2007|Tateli Tiga
71.02.23.2008|Koha
71.02.23.2009|Koha Barat
71.02.23.2010|Koha Timur
71.02.23.2011|Koha Selatan
71.02.23.2012|Agotey
71.02.24.2001|Lemoh
71.02.24.2002|Lemoh Barat
71.02.24.2003|Lemoh Timur
71.02.24.2004|Lemoh Uner
71.02.24.2005|Lolah
71.02.24.2006|Lolah Satu
71.02.24.2007|Lolah Dua
71.02.24.2008|Lolah Tiga
71.02.24.2009|Ranotongkor
71.02.24.2010|Ranotongkor Timur
71.02.25.2001|Pinaesaan
71.02.25.2002|Tompaso Dua
71.02.25.2003|Tompaso II Utara
71.02.25.2004|Pinabetengan Utara
71.02.25.2005|Pinabetengan
71.02.25.2006|Pinabetengan Selatan
71.02.25.2007|Tonsewer
71.02.25.2008|Tonsewer Selatan
71.02.25.2009|Touure
71.02.25.2010|Touure Dua
71.03.08.2001|Kalasuge
71.03.08.2002|Bahu
71.03.08.2003|Mala
71.03.08.2004|Kalekube
71.03.08.2005|Naha
71.03.08.2006|Beha
71.03.08.2007|Utaurano
71.03.08.2008|Lenganeng
71.03.08.2009|Tarolang
71.03.08.2010|Tola
71.03.08.2011|Kalurae
71.03.08.2012|Bengketang
71.03.08.2013|Petta
71.03.08.2014|Bowongkulu
71.03.08.2016|Pusunge
71.03.08.2017|Moade
71.03.08.2019|Raku
71.03.08.2020|Petta Timur
71.03.08.2021|Petta Barat
71.03.08.2022|Petta Selatan
71.03.08.2023|Likuang
71.03.08.2024|Kalekube I
71.03.08.2025|Bowongkulu I
71.03.08.2026|Naha I
71.03.09.2001|Nanedakele
71.03.09.2002|Nusa
71.03.09.2003|Bukide
71.03.09.2004|Bukide Timur
71.03.09.2005|Nanusa
71.03.10.2001|Kaluwatu
71.03.10.2002|Laine
71.03.10.2003|Lapango
71.03.10.2004|Sowaeng
71.03.10.2005|Ngalipaeng I
71.03.10.2006|Ngalipaeng II
71.03.10.2007|Batunderang
71.03.10.2008|Bebalang
71.03.10.2009|Mawira
71.03.10.2010|Pindang
71.03.10.2011|Lapepahe
71.03.10.2012|Lehimi Tariang
71.03.10.2013|Lapango I
71.03.11.2001|Kalama
71.03.11.2002|Kahakitang
71.03.11.2003|Mahengetang
71.03.11.2004|Para
71.03.11.2005|Dalako Bembanehe
71.03.11.2006|Taleko Batusaiki
71.03.11.2007|Para I
71.03.12.2001|Nagha I
71.03.12.2002|Nagha II
71.03.12.2003|Pokol
71.03.12.2004|Balane
71.03.12.2005|Binala
71.03.12.2006|Ulung Peliang
71.03.12.2007|Menggawa
71.03.12.2008|Kalinda
71.03.12.2009|Bebu
71.03.12.2010|Makalekuhe
71.03.12.2011|Pananaru
71.03.12.2012|Dagho
71.03.12.2013|Mahumu
71.03.12.2014|Lelipang
71.03.12.2015|Menggawa II
71.03.12.2016|Kalama Darat
71.03.12.2017|Kalinda I
71.03.12.2018|Mahumu I
71.03.12.2019|Mahumu II
71.03.12.2020|Hesang
71.03.13.2001|Tawoali
71.03.13.2002|Barangka
71.03.13.2003|Nahepese
71.03.13.2004|Manumpitaeng
71.03.13.2005|Taloarane
71.03.13.2006|Mala
71.03.13.2007|Karatung I
71.03.13.2008|Karatung II
71.03.13.2009|Kauhis
71.03.13.2010|Sesiwung
71.03.13.2011|Lebo
71.03.13.2012|Barangkalang
71.03.13.2013|Belengang
71.03.13.2014|Bakalaeng
71.03.13.2015|Hiung
71.03.13.2016|Pinebentengang
71.03.13.2017|Taloarane I
71.03.13.2018|Bengka
71.03.14.2001|Bowongkali
71.03.14.2002|Kulur I
71.03.14.2003|Kulur II
71.03.14.2004|Bira
71.03.14.2005|Kuma
71.03.14.2006|Bungalawang
71.03.14.2007|Miulu
71.03.14.2008|Gunung
71.03.14.2009|Talengen
71.03.14.2010|Biru
71.03.14.2011|Tariang Baru
71.03.14.2012|Sensong
71.03.14.2013|Rendingan
71.03.14.2014|Palahanaeng
71.03.14.2015|Timbelang
71.03.14.2016|Pelelangen
71.03.14.2017|Malueng
71.03.14.2018|Kuma I
71.03.15.2001|Simueng
71.03.15.2002|Bentung
71.03.15.2003|Lesabe
71.03.15.2004|Malammenggu
71.03.15.2005|Palareng
71.03.15.2007|Binebas
71.03.15.2008|Mandoi
71.03.15.2015|Batuwingkung
71.03.15.2016|Birahi
71.03.15.2017|Laotongan
71.03.15.2018|Bukide
71.03.15.2019|Kalagheng
71.03.15.2020|Lesabe I
71.03.15.2021|Bulo
71.03.16.2001|Kendahe I
71.03.16.2002|Kendahe II
71.03.16.2003|Talawid
71.03.16.2004|Tariang Lama
71.03.16.2005|Pempalaraeng
71.03.16.2006|Mohong Sawang
71.03.16.2007|Lipang
71.03.16.2008|Kawaluso
71.03.17.1006|Sawang Bendar
71.03.17.1007|Soataloara I
71.03.17.1008|Apengsembeka
71.03.17.1009|Mahena
71.03.17.1015|Bungalawang
71.03.17.1016|Santiago
71.03.17.1017|Manente
71.03.17.1018|Soataloara II
71.03.19.2001|Hangke
71.03.19.2002|Salurang
71.03.19.2003|Tambung
71.03.19.2004|Beeng
71.03.19.2005|Lehupu
71.03.19.2006|Bowone
71.03.19.2007|Beeng Laut
71.03.19.2008|Tenda
71.03.19.2009|Aha Patung
71.03.20.2001|Pintareng
71.03.20.2002|Basauh
71.03.20.2003|Tumalede
71.03.20.2004|Sampakang
71.03.20.2005|Dalokaweng
71.03.20.2006|Malisade
71.03.23.1001|Pananekeng
71.03.23.1002|Angges
71.03.23.1003|Kolongan Mitung
71.03.23.1004|Kolongan Beha
71.03.23.1005|Kolongan Beha Baru
71.03.23.1006|Kolongan Akembawi
71.03.24.1001|Lesa
71.03.24.1002|Enengpahembang
71.03.24.1003|Tapuang
71.03.24.1004|Tidore
71.03.24.1005|Tona I
71.03.24.1006|Tona II
71.03.24.1007|Dumuhung
71.03.24.1008|Batulewehe
71.03.25.2001|Marore
71.03.25.2002|Kawio
71.03.25.2003|Matutuang
71.04.01.1005|Lirung
71.04.01.1011|Lirung Satu
71.04.01.1024|Lirung Matane
71.04.01.2006|Sereh
71.04.01.2007|Musi
71.04.01.2015|Talolang
71.04.01.2017|Sereh I
71.04.02.1005|Beo
71.04.02.1017|Beo Timur
71.04.02.1018|Beo Barat
71.04.02.2011|Bantik
71.04.02.2019|Bengel
71.04.02.2020|Bantik Lama
71.04.03.2003|Alo
71.04.03.2004|Nunu
71.04.03.2005|Rainis
71.04.03.2006|Bantane
71.04.03.2007|Tabang
71.04.03.2014|Parangen
71.04.03.2015|Bantane Utara
71.04.03.2018|Tabang Barat
71.04.03.2020|Nunu Utara
71.04.03.2021|Rainis Batupenga
71.04.03.2022|Alo Utara
71.04.04.2006|Essang
71.04.04.2007|Lalue
71.04.04.2008|Bulude
71.04.04.2016|Maririk
71.04.04.2018|Essang Selatan
71.04.04.2019|Bulude Selatan
71.04.04.2020|Lalue Tengah
71.04.04.2021|Lalue Utara
71.04.05.2001|Kakorotan
71.04.05.2002|Marampit
71.04.05.2003|Laluhe
71.04.05.2004|Dampulis
71.04.05.2005|Karatung
71.04.05.2007|Karatung Tengah
71.04.05.2008|Karatung Selatan
71.04.05.2009|Dampulis Selatan
71.04.05.2010|Marampit Timur
71.04.06.2001|Pangeran
71.04.06.2007|Bulude
71.04.06.2008|Pantuge
71.04.06.2009|Kabaruan
71.04.06.2010|Mangaran
71.04.06.2011|Kordakel
71.04.06.2012|Rarange
71.04.06.2013|Taduna
71.04.06.2017|Kabaruan Timur
71.04.06.2018|Pantuge Timur
71.04.06.2019|Pannulan
71.04.06.2020|Bulude Selatan
71.04.07.1001|Melonguane
71.04.07.1009|Melonguane Timur
71.04.07.1010|Melonguane Barat
71.04.07.2002|Mala
71.04.07.2003|Kiama
71.04.07.2006|Tarun
71.04.07.2007|Sawang
71.04.07.2008|Ambela
71.04.07.2011|Tarun Selatan
71.04.07.2012|Kiama Barat
71.04.07.2015|Maredaren Kiama
71.04.07.2016|Sawang Utara
71.04.07.2017|Mala Timur
71.04.08.2001|Mamahan
71.04.08.2002|Bambung
71.04.08.2003|Taturan
71.04.08.2004|Gemeh
71.04.08.2005|Arangkaa
71.04.08.2006|Malat
71.04.08.2007|Apan
71.04.08.2008|Taruan
71.04.08.2009|Bannada
71.04.08.2010|Gemeh Raamata
71.04.08.2011|Gemeh Wantane
71.04.08.2012|Bambung Timur
71.04.08.2013|Malat Utara
71.04.08.2014|Mamahan Barat
71.04.08.2015|Lahu
71.04.09.2001|Peret
71.04.09.2002|Ighik
71.04.09.2003|Birang
71.04.09.2004|Akas
71.04.09.2005|Damau
71.04.09.2006|Damau Bowone
71.04.09.2007|Taduwale
71.04.09.2008|Akas Balane
71.04.10.2001|Tuabatu
71.04.10.2002|Dapalan
71.04.10.2003|Riung
71.04.10.2004|Ammat
71.04.10.2005|Binalang
71.04.10.2006|Ganalo
71.04.10.2007|Dapihe
71.04.10.2008|Tuabatu Barat
71.04.10.2009|Ammat Selatan
71.04.10.2010|Binalang Timur
71.04.10.2011|Riung Utara
71.04.11.2001|Bitunuris
71.04.11.2002|Bitunuris Selatan
71.04.11.2003|Salibabu
71.04.11.2004|Salibabu Utara
71.04.11.2005|Dalum
71.04.11.2006|Balang
71.04.12.2001|Kalongan
71.04.12.2002|Kalongan Utara
71.04.12.2003|Kalongan Selatan
71.04.12.2004|Alude
71.04.12.2005|Musi I
71.04.13.2001|Pulau Miangas
71.04.14.1001|Makatara
71.04.14.1002|Makatara Timur
71.04.14.2003|Awit
71.04.14.2004|Awit Selatan
71.04.14.2005|Rae
71.04.14.2006|Rae Selatan
71.04.14.2007|Lobbo
71.04.14.2008|Lobbo I
71.04.15.2001|Pulutan
71.04.15.2002|Pulutan Utara
71.04.15.2003|Pulutan Selatan
71.04.15.2004|Daran
71.04.15.2005|Daran Utara
71.04.16.2001|Tule
71.04.16.2002|Tule Tengah
71.04.16.2003|Tule Utara
71.04.16.2004|Bowombaru
71.04.16.2005|Bowombaru Tengah
71.04.16.2006|Bowombaru Utara
71.04.17.2001|Moronge
71.04.17.2002|Moronge I
71.04.17.2003|Moronge II
71.04.17.2004|Moronge Selatan
71.04.17.2005|Moronge Selatan II
71.04.17.2006|Moronge Selatan I
71.04.18.2001|Pampalu
71.04.18.2002|Ruso
71.04.18.2003|Niampak
71.04.18.2004|Niampak Utara
71.04.18.2005|Tarohan
71.04.18.2006|Tarohan Selatan
71.04.18.2007|Matahit
71.04.19.2001|Sambuara Satu
71.04.19.2002|Sambuara
71.04.19.2003|Ensem
71.04.19.2004|Ensem Timur
71.04.19.2005|Batumbalango
71.04.19.2006|Ambia
71.04.19.2007|Ambia Utara
71.04.19.2008|Kuma
71.04.19.2009|Kuma Selatan
71.05.01.2001|Sinisir
71.05.01.2002|Kakenturan
71.05.01.2003|Palelon
71.05.01.2004|Pinasungkulan
71.05.01.2005|Wulurmaatus
71.05.01.2006|Makaaruyen
71.05.01.2007|Linelean
71.05.01.2008|Mokobang
71.05.01.2009|Kakenturan Barat
71.05.01.2010|Pinasungkulan Utara
71.05.02.2009|Raraatean
71.05.02.2010|Sion
71.05.02.2011|Tompaso Baru I
71.05.02.2012|Kinalawiran
71.05.02.2013|Tompaso Baru II
71.05.02.2014|Pinaesaan
71.05.02.2015|Torout
71.05.02.2016|Lindangan
71.05.02.2017|Karowa
71.05.02.2018|Liandok
71.05.03.2002|Poopo
71.05.03.2003|Ranoyapo
71.05.03.2004|Mopolo
71.05.03.2005|Beringin
71.05.03.2006|Powalutan
71.05.03.2008|Lompad
71.05.03.2009|Lompad Baru
71.05.03.2010|Pontak
71.05.03.2012|Poopo Utara
71.05.03.2013|Poopo Barat
71.05.03.2014|Pontak Satu
71.05.03.2015|Mopolo Esa
71.05.07.2001|Motoling
71.05.07.2002|Motoling Mawale
71.05.07.2003|Motoling I
71.05.07.2004|Motoling II
71.05.07.2005|Picuan Baru
71.05.07.2015|Lalumpe
71.05.07.2021|Raanan Lama
71.05.08.2001|Blongko
71.05.08.2002|Boyongpante
71.05.08.2003|Tiniawangko
71.05.08.2004|Ongkaw I
71.05.08.2005|Ongkaw II
71.05.08.2006|Aergale
71.05.08.2007|Poigar I
71.05.08.2008|Poigar II
71.05.08.2009|Durian
71.05.08.2010|Tanamon
71.05.08.2011|Ongkaw Tiga
71.05.08.2012|Boyongpante Dua
71.05.08.2013|Tanamon Utara
71.05.09.2001|Boyong Atas
71.05.09.2002|Paku Ure II
71.05.09.2003|Tenga
71.05.09.2004|Radey
71.05.09.2005|Tawaang
71.05.09.2009|Pakuweru
71.05.09.2010|Sapa
71.05.09.2011|Pakuure Satu
71.05.09.2012|Pakuure Tiga
71.05.09.2014|Molinow
71.05.09.2015|Paku Ure
71.05.09.2016|Paku Ure Tinanian
71.05.09.2017|Paku Ure Kinamang
71.05.09.2018|Pakuweru Utara
71.05.09.2019|Sapa Barat
71.05.09.2020|Sapa Timur
71.05.09.2021|Tawaang Timur
71.05.09.2022|Tawaang Barat
71.05.10.1004|Buyungon
71.05.10.1005|Ranoyapo
71.05.10.1006|Uwuran I
71.05.10.1007|Uwuran II
71.05.10.1008|Lewet
71.05.10.1010|Bitung
71.05.10.2009|Ranoketang Tua
71.05.10.2018|Kilometer 3
71.05.12.2001|Tumpaan Satu
71.05.12.2002|Tumpaan
71.05.12.2003|Matani
71.05.12.2004|Popontolen
71.05.12.2005|Lelema
71.05.12.2006|Tangkunei
71.05.12.2007|Munte
71.05.12.2016|Tumpaan Baru
71.05.12.2017|Matani Satu
71.05.12.2018|Tumpan Dua
71.05.13.2001|Pinamorongan
71.05.13.2002|Kaneyan
71.05.13.2003|Koreng
71.05.13.2004|Tumaluntung
71.05.13.2005|Rumoong Atas
71.05.13.2006|Lansot
71.05.13.2007|Wiau Lapi
71.05.13.2008|Wuwuk
71.05.13.2014|Rumoong Atas Dua
71.05.13.2017|Lansot Timur
71.05.13.2018|Wuwuk Barat
71.05.13.2019|Tumaluntung Satu
71.05.13.2020|Wiau Lapi Barat
71.05.15.2002|Kumelembuai
71.05.15.2003|Kumelembuai Atas
71.05.15.2004|Kumelembuai Satu
71.05.15.2005|Malola
71.05.15.2006|Malola I
71.05.15.2007|Makasili
71.05.15.2011|Kumelembuai Dua
71.05.15.2015|Lolombulan Makasili
71.05.16.2001|Tumani
71.05.16.2002|Lowian
71.05.16.2003|Kinaweruan
71.05.16.2004|Liningaan
71.05.16.2005|Bojonegoro
71.05.16.2006|Tambelang
71.05.16.2007|Kinamang
71.05.16.2008|Temboan
71.05.16.2009|Kinamang Satu
71.05.16.2010|Lowian Satu
71.05.16.2011|Tumani Utara
71.05.16.2012|Tumani Selatan
71.05.17.1002|Kawangkoan Bawah
71.05.17.1003|Rumoong Bawah
71.05.17.2001|Kapitu
71.05.17.2004|Rumoong Bawah
71.05.17.2005|Tewasen
71.05.17.2006|Pondos
71.05.17.2007|Elusan
71.05.17.2008|Teep
71.05.17.2009|Wakan
71.05.17.2010|Teep Trans
71.05.18.1002|Pondang
71.05.18.1003|Ranomea
71.05.18.2001|Lopana
71.05.18.2004|Pinaling
71.05.18.2005|Kota Menara
71.05.18.2006|Maliku
71.05.18.2007|Ritey
71.05.18.2008|Malenos Baru
71.05.18.2009|Maliku Satu
71.05.18.2010|Lopana Satu
71.05.19.2001|Paslaten
71.05.19.2002|Sulu
71.05.19.2003|Bajo
71.05.19.2004|Wawona
71.05.19.2005|Popareng
71.05.19.2006|Wawontulap
71.05.19.2007|Sondaken
71.05.19.2008|Pungkol
71.05.19.2009|Raprap
71.05.19.2010|Paslaten Satu
71.05.19.2011|Arakan
71.05.21.2001|Tondei
71.05.21.2002|Tondei Satu
71.05.21.2003|Tondei Dua
71.05.21.2004|Raanan Baru
71.05.21.2005|Ranaan Baru Satu
71.05.21.2006|Ranaan Baru Dua
71.05.21.2007|Toyopon
71.05.21.2008|Keroit
71.05.22.2001|Karimbow
71.05.22.2002|Karimbow Talikuran
71.05.22.2003|Tokin
71.05.22.2004|Tokin Baru
71.05.22.2005|Wanga Amongena
71.05.22.2006|Wanga
71.05.22.2007|Picuan
71.05.22.2008|Picuan Satu
71.05.23.2001|Talaitad
71.05.23.2002|Suluun Satu
71.05.23.2003|Suluun Dua
71.05.23.2004|Suluun Tiga
71.05.23.2005|Suluun Empat
71.05.23.2006|Pinapalangkow
71.05.23.2007|Kapoya
71.05.23.2008|Talaitad Utara
71.05.23.2009|Kapoya Satu
71.06.01.2001|Makalisung
71.06.01.2002|Waleo
71.06.01.2003|Lilang
71.06.01.2004|Lansot
71.06.01.2005|Kema III
71.06.01.2006|Kema II
71.06.01.2007|Kema I
71.06.01.2008|Tontalete
71.06.01.2009|Tontaalete Rok-rok
71.06.01.2010|Waleo Dua
71.06.02.2001|Kauditan II
71.06.02.2002|Kauditan I
71.06.02.2003|Kawiley
71.06.02.2004|Treman
71.06.02.2005|Kaima
71.06.02.2006|Karegesan
71.06.02.2007|Kaasar
71.06.02.2008|Lembean
71.06.02.2009|Paslaten
71.06.02.2010|Tumaluntung
71.06.02.2011|Watudambo
71.06.02.2012|Watudambo Dua
71.06.03.1005|Airmadidi Bawah
71.06.03.1006|Rap-Rap
71.06.03.1007|Saronsong I
71.06.03.1008|Airmadidi Atas
71.06.03.1009|Sukur
71.06.03.1011|Sarongsong II
71.06.03.2002|Tanggari
71.06.03.2003|Sampiri
71.06.03.2004|Sawangan
71.06.04.2001|Tiwoho
71.06.04.2002|Wori
71.06.04.2003|Kima Bajo
71.06.04.2004|Talawaan Bantik
71.06.04.2005|Talawaan Atas
71.06.04.2006|Budo
71.06.04.2007|Darunu
71.06.04.2008|Mantehage III Tinongko
71.06.04.2009|Nain
71.06.04.2010|Mantehage/Buhias
71.06.04.2011|Mantehage/Bango
71.06.04.2012|Mantehage II Tangkasi
71.06.04.2013|Kulu
71.06.04.2014|Bulo
71.06.04.2015|Lansa
71.06.04.2016|Lantung
71.06.04.2017|Pontoh
71.06.04.2018|Minaesa
71.06.04.2019|Nain Tatampi
71.06.04.2020|Nain Satu
71.06.05.2003|Matungkas
71.06.05.2004|Laikit
71.06.05.2005|Klabat
71.06.05.2006|Pinilih
71.06.05.2007|Tatelu
71.06.05.2008|Warukapas
71.06.05.2009|Tetey
71.06.05.2013|Wasian
71.06.05.2014|Lumpias
71.06.05.2016|Dimembe
71.06.05.2020|Tatelu Rondor
71.06.06.2001|Gangga I
71.06.06.2002|Gangga II
71.06.06.2003|Talise
71.06.06.2004|Airbanua
71.06.06.2005|Palaes
71.06.06.2006|Maliambao
71.06.06.2007|Termaal
71.06.06.2008|Paputungan
71.06.06.2009|Jayakarsa
71.06.06.2010|Tanah Putih
71.06.06.2011|Bahoi
71.06.06.2012|Tarabitan
71.06.06.2013|Serei
71.06.06.2014|Sonsilo
71.06.06.2015|Mubune
71.06.06.2016|Munte
71.06.06.2017|Bulutui
71.06.06.2018|Wawunian
71.06.06.2019|Kinabuhutan
71.06.06.2020|Tambun
71.06.07.2008|Likupang I
71.06.07.2009|Likupang II
71.06.07.2010|Serawet
71.06.07.2011|Wineru
71.06.07.2012|Maen
71.06.07.2013|Winuri
71.06.07.2014|Marinsow
71.06.07.2015|Pulisan
71.06.07.2016|Kalinaun
71.06.07.2017|Rinondoran
71.06.07.2018|Pinenek
71.06.07.2019|Lihunu
71.06.07.2020|Kahuhu
71.06.07.2021|Libas
71.06.07.2022|Likupang Kampung Ambong
71.06.07.2023|Kinunang
71.06.07.2024|Resetlemen
71.06.07.2025|Ehe
71.06.08.2001|Suwaan
71.06.08.2002|Kuwil
71.06.08.2003|Kawangkoan
71.06.08.2004|Kolongan
71.06.08.2005|Maumbi
71.06.08.2006|Kaleosan
71.06.08.2007|Watutumou
71.06.08.2008|Kolongan Tetempangan
71.06.08.2009|Kawangkoan Baru
71.06.08.2010|Kalawat
71.06.08.2011|Watutumou Dua
71.06.08.2012|Watutumou Tiga
71.06.09.2001|Paniki Atas
71.06.09.2002|Kolongan
71.06.09.2003|Talawaan
71.06.09.2004|Mapanget
71.06.09.2005|Wusa
71.06.09.2006|Warisa
71.06.09.2007|Tumbohon
71.06.09.2008|Winetin
71.06.09.2009|Patokaan
71.06.09.2010|Teepwarisa
71.06.09.2011|Warisa Kampung Baru
71.06.09.2012|Paniki Baru
71.06.10.2001|Kokoleh Satu
71.06.10.2002|Kokoleh Dua
71.06.10.2003|Paslaten
71.06.10.2004|Kaweruan
71.06.10.2005|Wangurer
71.06.10.2006|Batu
71.06.10.2007|Werot
71.07.01.1004|Tosuraya
71.07.01.1005|Wawali
71.07.01.1008|Lowu Dua
71.07.01.1009|Lowu Satu
71.07.01.1016|Lowu Utara
71.07.01.1017|Nataan
71.07.01.1018|Tosuraya Barat
71.07.01.1019|Tosuraya Selatan
71.07.01.1020|Wawali Pasan
71.07.01.2003|Rasi
71.07.01.2021|Rasi Satu
71.07.02.2001|Tatengesan
71.07.02.2002|Wiau
71.07.02.2003|Bentenan
71.07.02.2004|Tumbak
71.07.02.2005|Makalu
71.07.02.2006|Minanga
71.07.02.2007|Minanga Satu
71.07.02.2008|Bentenan Indah
71.07.02.2009|Minanga Timur
71.07.02.2010|Minanga Dua
71.07.02.2011|Minanga Tiga
71.07.02.2012|Makalu Selatan
71.07.02.2013|Tatengesan Satu
71.07.02.2014|Bentenan Satu
71.07.02.2015|Tumbak Madani
71.07.03.2001|Mangkit
71.07.03.2002|Borgo
71.07.03.2003|Belang
71.07.03.2004|Buku
71.07.03.2005|Beringin
71.07.03.2006|Tababo
71.07.03.2007|Watuliney
71.07.03.2008|Molompar
71.07.03.2009|Buku Utara
71.07.03.2010|Buku Selatan
71.07.03.2011|Watuliney Tengah
71.07.03.2012|Watuliney Indah
71.07.03.2013|Molompar Utara
71.07.03.2014|Molompar Timur
71.07.03.2015|Tababo Selatan
71.07.03.2016|Buku Tengah
71.07.03.2017|Ponosakan Indah
71.07.03.2018|Buku Tenggara
71.07.03.2019|Ponosakan Belang
71.07.03.2020|Borgo Satu
71.07.04.2001|Ratatotok Satu
71.07.04.2002|Ratatotok Dua
71.07.04.2003|Ratatotok Selatan
71.07.04.2004|Ratatotok Timur
71.07.04.2005|Basaan
71.07.04.2006|Basaan Satu
71.07.04.2007|Morea
71.07.04.2008|Morea Satu
71.07.04.2009|Soyoan
71.07.04.2010|Basaan Dua
71.07.04.2011|Ratatotok Utara
71.07.04.2012|Ratatotok Tenggara
71.07.04.2013|Ratatotok Tengah
71.07.04.2014|Ratatotok
71.07.04.2015|Ratatotok Muara
71.07.05.2006|Tonsawang
71.07.05.2008|Betelan
71.07.05.2009|Tombatu Satu
71.07.05.2012|Kali
71.07.05.2014|Pisa
71.07.05.2015|Tombatu
71.07.05.2016|Betelan Satu
71.07.05.2017|Kali Oki
71.07.05.2018|Tombatu Tiga Selatan
71.07.05.2019|Tombatu Tiga Timur
71.07.05.2020|Tonsawang Satu
71.07.06.2003|Ranoketang Atas
71.07.06.2004|Tondanauw
71.07.06.2005|Lobu Satu
71.07.06.2006|Lobu Dua
71.07.06.2017|Tondanouw Satu
71.07.06.2018|Toundanouw Atas
71.07.06.2019|Ranoketang Atas Satu
71.07.06.2020|Lobu Kota
71.07.06.2021|Lobu Atas
71.07.06.2022|Lobu
71.07.07.2001|Kalait
71.07.07.2002|Kalait Satu
71.07.07.2003|Kalait Dua
71.07.07.2004|Kalait Tiga
71.07.07.2005|Lowatag
71.07.07.2006|Bunag
71.07.07.2007|Banga
71.07.07.2008|Tambelang
71.07.07.2009|Ranoako
71.07.07.2010|Suhuyon
71.07.08.2001|Silian
71.07.08.2002|Silian Utara
71.07.08.2003|Silian Satu
71.07.08.2004|Silian Selatan
71.07.08.2005|Silian Dua
71.07.08.2006|Silian Tengah
71.07.08.2007|Silian Tiga
71.07.08.2008|Silian Barat
71.07.08.2009|Silian Kota
71.07.08.2010|Silian Timur
71.07.09.2001|Molompar
71.07.09.2002|Molompar Satu
71.07.09.2003|Molompar Atas
71.07.09.2004|Molompar Dua
71.07.09.2005|Molompar Dua Utara
71.07.09.2006|Molompar Dua Selatan
71.07.09.2007|Mundung
71.07.09.2008|Mundung Satu
71.07.09.2009|Esandom
71.07.09.2010|Esandom Satu
71.07.09.2011|Esandom Dua
71.07.10.2001|Tombatu Dua
71.07.10.2002|Tombatu Dua Utara
71.07.10.2003|Tombatu Dua Barat
71.07.10.2004|Tombatu Dua Tengah
71.07.10.2005|Tombatu Tiga
71.07.10.2006|Tombatu Tiga Tengah
71.07.10.2007|Kuyanga
71.07.10.2008|Kuyanga Satu
71.07.10.2009|Winorangian
71.07.10.2010|Winorangian Satu
71.07.11.2001|Towuntu
71.07.11.2002|Towuntu Timur
71.07.11.2003|Towuntu Barat
71.07.11.2004|Tolombukan
71.07.11.2005|Tolombukan Satu
71.07.11.2006|Tolombukan Barat
71.07.11.2007|Liwutung
71.07.11.2008|Liwutung Satu
71.07.11.2009|Liwutung Dua
71.07.11.2010|Poniki
71.07.11.2011|Maulit
71.07.12.2001|Wioi
71.07.12.2002|Wioi Satu
71.07.12.2003|Wioi Dua
71.07.12.2004|Wioi Tiga
71.07.12.2005|Wioi Timur
71.07.12.2006|Pangu
71.07.12.2007|Pangu Satu
71.07.12.2008|Pangu Dua
71.07.12.2009|Wongkai
71.07.12.2010|Wongkai Satu
71.08.01.2001|Sangkub I
71.08.01.2002|Busisingo
71.08.01.2003|Sang Tombolang
71.08.01.2004|Tombolango
71.08.01.2005|Pangkusa
71.08.01.2006|Sangkub II
71.08.01.2007|Sidodadi
71.08.01.2008|Sampiro
71.08.01.2009|Sangkub III
71.08.01.2010|Busisingo Utara
71.08.01.2011|Ampeng Sembeka
71.08.01.2012|Suka Makmur
71.08.01.2013|Sangkub Timur
71.08.01.2014|Monompia
71.08.01.2015|Mokusato
71.08.01.2016|Sangkub Empat
71.08.02.1001|Bintauna
71.08.02.2002|Huntuk
71.08.02.2003|Mome
71.08.02.2004|Kuhanga
71.08.02.2005|Padang
71.08.02.2006|Pimpi
71.08.02.2007|Bunia
71.08.02.2008|Talaga
71.08.02.2009|Batulintik
71.08.02.2010|Bintauna Pantai
71.08.02.2011|Minanga
71.08.02.2012|Kopi
71.08.02.2013|Voa'a
71.08.02.2014|Bunong
71.08.02.2015|Padang Barat
71.08.02.2016|Vahuta
71.08.03.2001|Mokoditek
71.08.03.2002|Nunuka
71.08.03.2003|Saleo
71.08.03.2004|Bohabak I
71.08.03.2005|Bohabak II
71.08.03.2006|Binjeita
71.08.03.2007|Biontong
71.08.03.2008|Biontong I
71.08.03.2009|Biontong II
71.08.03.2010|Binuanga
71.08.03.2011|Bohabak III
71.08.03.2012|Bohabak IV
71.08.03.2013|Binjeita I
71.08.03.2014|Binjeita II
71.08.03.2015|Mokoditek I
71.08.03.2016|Lipu Bogu
71.08.03.2017|Binuni
71.08.03.2018|Tanjung Labou
71.08.03.2019|Nagara
71.08.03.2020|Saleo Satu
71.08.04.2001|Paku
71.08.04.2002|Ollot
71.08.04.2003|Sonuo
71.08.04.2004|Jambusarang
71.08.04.2005|Talaga Tomoagu
71.08.04.2006|Bolangitang
71.08.04.2007|Langi
71.08.04.2008|Iyok
71.08.04.2009|Tote
71.08.04.2010|Wakat
71.08.04.2011|Ollot I
71.08.04.2012|Ollot II
71.08.04.2013|Bolangitang I
71.08.04.2014|Bolangitang II
71.08.04.2015|Talaga
71.08.04.2016|Tanjung Buaya
71.08.04.2017|Keimanga
71.08.04.2018|Paku Selatan
71.08.05.2001|Solo
71.08.05.2002|Boroko
71.08.05.2003|Bigo
71.08.05.2004|Kuala
71.08.05.2005|Pontak
71.08.05.2006|Inomunga
71.08.05.2007|Komus II
71.08.05.2008|Boroko Timur
71.08.05.2009|Kuala Utara
71.08.05.2010|Gihang
71.08.05.2011|Boroko Utara
71.08.05.2012|Bigo Selatan
71.08.05.2013|Soligir
71.08.05.2014|Inomunga Utara
71.08.05.2015|Komus Dua Timur
71.08.06.2001|Komus I
71.08.06.2002|Tuntung
71.08.06.2003|Batu Tajam
71.08.06.2004|Dalapuli
71.08.06.2005|Buko
71.08.06.2006|Dengi
71.08.06.2007|Tombulang
71.08.06.2008|Tuntulow
71.08.06.2009|Kayu Ogu
71.08.06.2010|Tanjung Sidupa
71.08.06.2011|Buko Selatan
71.08.06.2012|Busato
71.08.06.2013|Batu Bantayo
71.08.06.2014|Padango
71.08.06.2015|Tuntulow Utara
71.08.06.2016|Dalapuli Timur
71.08.06.2017|Dalapuli Barat
71.08.06.2018|Buko Utara
71.08.06.2019|Tambulang Timur
71.08.06.2020|Tambulang Pantai
71.08.06.2021|Tuntung Timur
71.08.06.2022|Duini
71.09.01.1009|Bebali
71.09.01.1010|Tatahadeng
71.09.01.1011|Tarorane
71.09.01.1012|Akesimbeka
71.09.01.1013|Bahu
71.09.01.2001|Bukide
71.09.01.2002|Apelawo
71.09.01.2003|Deahe
71.09.01.2004|Lia
71.09.01.2005|Kanang
71.09.01.2006|Buise
71.09.01.2007|Karalung
71.09.01.2008|Dame
71.09.01.2014|Dame I
71.09.01.2015|Lia Satu
71.09.01.2016|Karalung Satu
71.09.02.1002|Paseng
71.09.02.1003|Paniki
71.09.02.1004|Ondong
71.09.02.2001|Peling Sawang
71.09.02.2005|Kanawong
71.09.02.2006|Bumbiha
71.09.02.2007|Pehe
71.09.02.2008|Lehi
71.09.02.2009|Peling
71.09.02.2010|Makalehi
71.09.02.2011|Makalehi Utara
71.09.02.2012|Makalehi Timur
71.09.03.1001|Bahoi
71.09.03.1002|Balehumara
71.09.03.2003|Lesah
71.09.03.2004|Boto
71.09.03.2005|Mohongsawang
71.09.03.2006|Apengsala
71.09.03.2007|Mulengan
71.09.03.2008|Mahangiang
71.09.03.2009|Tulusan
71.09.03.2010|Haasi
71.09.03.2011|Pumpente
71.09.03.2012|Laingpatehi
71.09.03.2013|Lesah Rende
71.09.03.2014|Barangka Pehe
71.09.03.2015|Pahiama
71.09.04.2001|Mala
71.09.04.2002|Pangirolong
71.09.04.2003|Sawang
71.09.04.2004|Bandil
71.09.04.2005|Biau
71.09.04.2006|Balirangeng
71.09.04.2007|Buhias
71.09.04.2008|Tapile
71.09.04.2009|Lahopang
71.09.04.2010|Binalu
71.09.04.2011|Kalihiang
71.09.04.2012|Pahepa
71.09.04.2013|Biau Seha
71.09.04.2014|Matole
71.09.05.2001|Tanaki
71.09.05.2002|Kapeta
71.09.05.2003|Talawid
71.09.05.2004|Laghaeng
71.09.05.2005|Makoa
71.09.05.2006|Batusenggo
71.09.05.2007|Mahuneni
71.09.06.2001|Bulangan
71.09.06.2002|Minanga
71.09.06.2003|Wo
71.09.06.2004|Bawoleu
71.09.06.2005|Lumbo
71.09.06.2006|Bawo
71.09.07.2001|Buang
71.09.07.2002|Karungo
71.09.07.2003|Lamanggo
71.09.07.2004|Dalinsaheng
71.09.07.2005|Tope
71.09.08.2001|Kinali
71.09.08.2002|Hiung
71.09.08.2003|Kiawang
71.09.08.2004|Kawahang
71.09.08.2005|Batubulan
71.09.08.2006|Nameng
71.09.08.2007|Mini
71.09.08.2008|Winangun
71.09.09.2001|Salili
71.09.09.2002|Beong
71.09.09.2003|Lai
71.09.09.2004|Dompase
71.09.10.2001|Humbia
71.09.10.2002|Kisihang
71.09.10.2003|Bira Kiama
71.09.10.2004|Buha
71.09.10.2005|Batumawira
71.09.10.2006|Birarikei
71.10.01.2001|Kayumoyondi
71.10.01.2002|Tombolikat
71.10.01.2003|Tutuyan
71.10.01.2004|Togid
71.10.01.2005|Dodap
71.10.01.2006|Dodap Pantai
71.10.01.2007|Tutuyan II
71.10.01.2008|Tutuyan III
71.10.01.2009|Tombolikat Selatan
71.10.01.2010|Dodop Mikasa
71.10.02.2001|Kotabunan
71.10.02.2002|Buyat
71.10.02.2003|Bulawan
71.10.02.2004|Paret
71.10.02.2005|Bukaka
71.10.02.2006|Buyat I
71.10.02.2007|Buyat II
71.10.02.2008|Buyat Selatan
71.10.02.2009|Buyat Tengah
71.10.02.2010|Buyat Barat
71.10.02.2011|Bulawan Satu
71.10.02.2012|Bulawan Dua
71.10.02.2013|Kotabunan Selatan
71.10.02.2014|Kotabunan Barat
71.10.02.2015|Paret Timur
71.10.03.2001|Idumun
71.10.03.2002|Matabulu
71.10.03.2003|Nuangan
71.10.03.2006|Bai
71.10.03.2007|Jiko Belanga
71.10.03.2010|Nuangan I
71.10.03.2011|Iyok
71.10.03.2012|Loyow
71.10.03.2014|Matabulu Timur
71.10.03.2018|Nuangan Barat
71.10.03.2019|Nuangan Selatan
71.10.04.2001|Modayag
71.10.04.2002|Liberia
71.10.04.2003|Purworejo
71.10.04.2007|Buyandi
71.10.04.2008|Tobongon
71.10.04.2009|Lanut
71.10.04.2010|Badaro
71.10.04.2011|Modayag II
71.10.04.2012|Modayag III
71.10.04.2013|Purworejo Timur
71.10.04.2014|Liberia Timur
71.10.04.2016|Purworejo Tengah
71.10.04.2021|Candi Rejo
71.10.04.2022|Sumber Rejo
71.10.05.2001|Moyongkota
71.10.05.2002|Bangunan Wuwuk
71.10.05.2003|Bongkudai Barat
71.10.05.2004|Bongkudai
71.10.05.2005|Moyongkota Baru
71.10.05.2006|Moonow
71.10.05.2007|Inaton
71.10.05.2008|Bangunan Wuwuk Timur
71.10.05.2009|Pinonobatuan
71.10.05.2010|Tangaton
71.10.06.2001|Motongkad Utara
71.10.06.2002|Motongkad
71.10.06.2003|Motongkad Selatan
71.10.06.2004|Atoga
71.10.06.2005|Atoga Timur
71.10.06.2006|Motongkad Tengah
71.10.06.2007|Molobog
71.10.06.2008|Molobog Barat
71.10.06.2009|Jiko
71.10.06.2010|Jiko Utara
71.10.06.2011|Molobog Timur
71.10.07.2001|Mooat
71.10.07.2002|Bongkudai Selatan
71.10.07.2003|Bongkudai Baru
71.10.07.2004|Bongkudai Utara
71.10.07.2005|Bongkudai Timur
71.10.07.2006|Guaan
71.10.07.2007|Mototompiaan
71.10.07.2008|Mokitompia
71.10.07.2009|Kokapoi
71.10.07.2010|Kokapoi Timur
71.11.01.2004|Tangagah
71.11.01.2005|Salongo
71.11.01.2006|Toluaya
71.11.01.2007|Molibagu
71.11.01.2008|Popodu
71.11.01.2009|Tolondadu
71.11.01.2010|Tabilaa
71.11.01.2012|Sondana
71.11.01.2013|Dudepo
71.11.01.2014|Pinolantungan
71.11.01.2015|Tolondadu I
71.11.01.2016|Tolondadu II
71.11.01.2020|Soguo
71.11.01.2022|Pintadia
71.11.01.2023|Salongo Timur
71.11.01.2027|Salongo Barat
71.11.01.2028|Dudepo Barat
71.11.02.2001|Lion
71.11.02.2002|Momalia II
71.11.02.2003|Meyambanga
71.11.02.2004|Saibuah
71.11.02.2007|Sinombayuga
71.11.02.2008|Luwoo
71.11.02.2009|Momalia I
71.11.02.2011|Sakti
71.11.02.2012|Manggadaa
71.11.02.2013|Pilolahunga
71.11.02.2014|Tonala
71.11.02.2016|Iloheluma
71.11.02.2017|Meyambanga Timur
71.11.02.2019|Molosipat
71.11.02.2022|Momalia Tiga
71.11.02.2023|Inosota
71.11.03.2001|Linawan
71.11.03.2002|Nunuk
71.11.03.2003|Pinolosian
71.11.03.2004|Kombot
71.11.03.2005|Lungkap
71.11.03.2006|Ilomata
71.11.03.2007|Linawan I
71.11.03.2008|Tolotoyon
71.11.03.2009|Pinolosian Selatan
71.11.03.2010|Kombot Timur
71.11.04.2001|Mataindo
71.11.04.2002|Adow
71.11.04.2003|Torosik
71.11.04.2004|Tobayagan
71.11.04.2005|Deaga
71.11.04.2006|Adow Selatan
71.11.04.2007|Mataindo Utara
71.11.04.2008|Tobayagan Selatan
71.11.05.2001|Motandoi
71.11.05.2002|Dumagin A
71.11.05.2003|Dumagin B
71.11.05.2004|Dayow
71.11.05.2005|Onggunoi
71.11.05.2006|Modisi
71.11.05.2007|Posilagon
71.11.05.2008|Pidung
71.11.05.2009|Iligon
71.11.05.2010|Motandoi Selatan
71.11.05.2011|Perjuangan
71.11.05.2012|Onggunoi Selatan
71.11.06.2001|Biniha Timur
71.11.06.2002|Biniha
71.11.06.2003|Biniha Selatan
71.11.06.2004|Duminanga
71.11.06.2005|Halabolu
71.11.06.2006|Trans Patoa
71.11.06.2007|Bakida
71.11.06.2008|Sinandaka
71.11.06.2009|Soputa
71.11.06.2010|Pangia
71.11.06.2011|Motolohu
71.11.07.2001|Botuliodu
71.11.07.2002|Nunuka Raya
71.11.07.2003|Tolutu
71.11.07.2004|Milangodaa
71.11.07.2005|Milangodaa Barat
71.11.07.2006|Milangodaa Utara
71.11.07.2007|Pakuku Jaya
71.71.01.1001|Molas
71.71.01.1006|Tongkaina
71.71.01.1007|Meras
71.71.01.1008|Bailang
71.71.01.1009|Pandu
71.71.02.1001|Bitung Karangria
71.71.02.1002|Tuminting
71.71.02.1003|Tumumpa Satu
71.71.02.1004|Maasing
71.71.02.1005|Sindulang Satu
71.71.02.1006|Sindulang Dua
71.71.02.1007|Islam
71.71.02.1008|Tumumpa Dua
71.71.02.1009|Sumompo
71.71.02.1010|Mahawu
71.71.03.1001|Singkil Satu
71.71.03.1002|Singkil Dua
71.71.03.1003|Wawonasa
71.71.03.1004|Karame
71.71.03.1005|Ketang Baru
71.71.03.1006|Ternate Baru
71.71.03.1007|Kombos Barat
71.71.03.1008|Kombos Timur
71.71.03.1009|Ternate Tanjung
71.71.04.1001|Tikala Kumaraka
71.71.04.1002|Mahakeret Timur
71.71.04.1003|Mahakeret Barat
71.71.04.1004|Teling Bawah
71.71.04.1005|Wenang Utara
71.71.04.1006|Wenang Selatan
71.71.04.1007|Pinaesaan
71.71.04.1008|Calaca
71.71.04.1009|Istiqlal
71.71.04.1010|Lawangirung
71.71.04.1011|Komo Luar
71.71.04.1012|Bumi Beringin
71.71.05.1008|Tikala Baru
71.71.05.1009|Taas
71.71.05.1010|Paal IV
71.71.05.1011|Banjer
71.71.05.1012|Tikala Ares
71.71.06.1001|Sario Utara
71.71.06.1002|Sario Kotabaru
71.71.06.1003|Sario Tumpaan
71.71.06.1004|Sario
71.71.06.1005|Titiwungan Utara
71.71.06.1006|Titiwungan Selatan
71.71.06.1007|Ranotana
71.71.07.1001|Wanea
71.71.07.1002|Tanjung Batu
71.71.07.1003|Pakowa
71.71.07.1004|Bumi Nyiur
71.71.07.1005|Ranotana Weru
71.71.07.1006|Teling Atas
71.71.07.1007|Tingkulu
71.71.07.1008|Karombasan Utara
71.71.07.1009|Karombasan Selatan
71.71.08.1001|Paniki Bawah
71.71.08.1002|Lapangan
71.71.08.1003|Mapanget Barat
71.71.08.1004|Kima Atas
71.71.08.1005|Buha
71.71.08.1006|Bengkol
71.71.08.1008|Kairagi Satu
71.71.08.1009|Kairagi Dua
71.71.08.1010|Paniki Satu
71.71.08.1011|Paniki Dua
71.71.09.1001|Malalayang Satu
71.71.09.1002|Bahu
71.71.09.1003|Kleak
71.71.09.1004|Batu Kota
71.71.09.1005|Malalayang Satu Timur
71.71.09.1006|Malalayang Satu Barat
71.71.09.1007|Malalayang Dua
71.71.09.1008|Winangun Satu
71.71.09.1009|Winangun Dua
71.71.10.1001|Bunaken
71.71.10.1002|Manado Tua Satu
71.71.10.1003|Manado Tua Dua
71.71.10.1004|Alung Banua
71.71.11.1001|Ranomuut
71.71.11.1002|Kairagi Weru
71.71.11.1003|Paal Dua
71.71.11.1004|Perkamil
71.71.11.1005|Malendeng
71.71.11.1006|Dendengan Dalam
71.71.11.1007|Dendengan Luar
71.72.01.1001|Pasir Panjang
71.72.01.1002|Paudean
71.72.01.1003|Batulubang
71.72.01.1004|Papusungan
71.72.01.1006|Pancuran
71.72.01.1011|Dorbolaang
71.72.01.1016|Kelapa Dua
71.72.02.1001|Wangurer Barat
71.72.02.1002|Paceda
71.72.02.1003|Madidir Ure
71.72.02.1004|Kadoodan
71.72.02.1006|Madidir Weru
71.72.02.1007|Madidir Unet
71.72.02.1009|Wangurer timur
71.72.02.1011|Wangurer Utara
71.72.03.1001|Karondoran
71.72.03.1002|Kumeresot
71.72.03.1004|Pinokalan
71.72.03.1005|Tewaan
71.72.03.1006|Danowudu
71.72.03.1007|Duasadara
71.72.03.1008|Apela Dua
71.72.03.1009|Apela Satu
71.72.03.1010|Pinasungkulan
71.72.03.1011|Batuputih Atas
71.72.03.1012|Batuputih Bawah
71.72.04.1003|Pateten Satu
71.72.04.1004|Winenet Satu
71.72.04.1005|Aertembaga Satu
71.72.04.1006|Tandurusa
71.72.04.1007|Makawidey
71.72.04.1008|Pinangunian
71.72.04.1011|Pateten Dua
71.72.04.1012|Winenet Dua
71.72.04.1013|Kasawari
71.72.04.1014|Aertembaga Dua
71.72.05.1001|Tanjung Merah
71.72.05.1002|Sagerat
71.72.05.1003|Manembo-nembo Atas
71.72.05.1007|Manembo-nembo
71.72.05.1011|Sagerat Weru Satu
71.72.05.1012|Sagerat Weru Dua
71.72.05.1013|Manembo-nembo Tengah
71.72.05.1014|Tendeki
71.72.06.1001|Girian Atas
71.72.06.1002|Girian Weru Satu
71.72.06.1003|Girian Bawah
71.72.06.1004|Girian Permai
71.72.06.1005|Girian Weru Dua
71.72.06.1006|Girian Indah
71.72.06.1007|Wangurer
71.72.07.1001|Bitung Barat Satu
71.72.07.1002|Pakadoodan
71.72.07.1003|Bitung Barat Dua
71.72.07.1004|Bitung Tengah
71.72.07.1005|Bitung Timur
71.72.07.1006|Kakenturan Satu
71.72.07.1007|Kekenturan Dua
71.72.07.1008|Pateten Tiga
71.72.08.1001|Mawali
71.72.08.1002|Pintukota
71.72.08.1003|Binuang
71.72.08.1004|Motto
71.72.08.1005|Lirang
71.72.08.1006|Posokan
71.72.08.1007|Nusu
71.72.08.1008|Kareko
71.72.08.1009|Gunung Woka
71.72.08.1010|Batukota
71.73.01.1001|Pinaras
71.73.01.1002|Lahendong
71.73.01.1003|Tondangow
71.73.01.1004|Pangolombian
71.73.01.1005|Tumatangtang
71.73.01.1006|Kampung Jawa
71.73.01.1007|Lansot
71.73.01.1008|Walian
71.73.01.1009|Uluindano
71.73.01.1010|Walian Satu
71.73.01.1011|Walian Dua
71.73.01.1012|Tumatangtang Satu
71.73.02.1009|Talete Satu
71.73.02.1010|Talete Dua
71.73.02.1011|Kamasi
71.73.02.1012|Kolongan
71.73.02.1015|Matani Satu
71.73.02.1016|Matani Dua
71.73.02.1017|Matani Tiga
71.73.02.1018|Kamasi Satu
71.73.02.1019|Kolongan Satu
71.73.03.1001|Tinoor Satu
71.73.03.1002|Tinoor Dua
71.73.03.1003|Kinilow
71.73.03.1004|Kakaskasen Satu
71.73.03.1005|Kakaskasen Dua
71.73.03.1006|Kakaskasen Tiga
71.73.03.1007|Wailan
71.73.03.1008|Kayawu
71.73.03.1009|Kinilow Satu
71.73.03.1010|Kakaskasen
71.73.04.1001|Woloan Satu
71.73.04.1002|Woloan Dua
71.73.04.1003|Woloan Tiga
71.73.04.1004|Taratara Satu
71.73.04.1005|Taratara Dua
71.73.04.1006|Woloan Satu Utara
71.73.04.1007|Taratara
71.73.04.1008|Taratara Tiga
71.73.05.1001|Paslaten Satu
71.73.05.1002|Paslaten Dua
71.73.05.1003|Rurukan
71.73.05.1004|Rurukan Satu
71.73.05.1005|Kumelembuay
71.74.01.1005|Biga
71.74.01.1006|Upai
71.74.01.1007|Genggulang
71.74.01.2001|Bilalang Satu
71.74.01.2002|Bilalang Dua
71.74.01.2003|Pontodon
71.74.01.2004|Sia
71.74.01.2008|Pontodon Timur
71.74.02.1003|Kotobangun
71.74.02.1004|Tumubui
71.74.02.1005|Sinindian
71.74.02.1006|Matali
71.74.02.1007|Motoboi Besar
71.74.02.1008|Kobo Besar
71.74.02.2001|Moyag
71.74.02.2002|Kobo Kecil
71.74.02.2009|Moyag Tampoan
71.74.02.2010|Moyag Todulan
71.74.03.1007|Motoboi Kecil
71.74.03.1008|Mongondow
71.74.03.1009|Pobundayan
71.74.03.2001|Poyowa Besar Satu
71.74.03.2002|Poyowa Besar Dua
71.74.03.2003|Tabang
71.74.03.2004|Bungko
71.74.03.2005|Kopandakan Satu
71.74.03.2006|Poyowa Kecil
71.74.04.1001|Mongkonai
71.74.04.1002|Molinow
71.74.04.1003|Mogolaing
71.74.04.1004|Gogagoman
71.74.04.1005|Kotamobagu
71.74.04.1006|Mongkonai Barat
72.01.01.1006|Bugis
72.01.01.1007|Balantang
72.01.01.1008|Batui
72.01.01.1009|Tolando
72.01.01.1010|Lamo
72.01.01.1017|Sisipan
72.01.01.1023|Bakung
72.01.01.2002|Nonong
72.01.01.2003|Kayowa
72.01.01.2005|Ondo-Ondolu
72.01.01.2011|Honbola
72.01.01.2012|Uso
72.01.01.2016|Ondo-Ondolu I
72.01.02.1014|Bunta I
72.01.02.1025|Bunta II
72.01.02.1047|Salabenda
72.01.02.1048|Kalaka
72.01.02.2015|Bohotokong
72.01.02.2016|Dondo Soboli
72.01.02.2017|Laonggo
72.01.02.2023|Hion
72.01.02.2024|Tombongan Ulos
72.01.02.2026|Pongian
72.01.02.2027|Tuntung
72.01.02.2028|Nanga-Nangaon
72.01.02.2029|Toima
72.01.02.2030|Matabas
72.01.02.2031|Huhak
72.01.02.2032|Lontio
72.01.02.2041|Demangan Jaya
72.01.02.2042|Balanga
72.01.02.2043|Longgolian
72.01.02.2044|Kalumbangan
72.01.02.2045|Polo
72.01.02.2049|Koili
72.01.03.1006|Kintom
72.01.03.1010|Mendono
72.01.03.1017|Mondonun
72.01.03.2001|Kalolos
72.01.03.2002|Tangkiang
72.01.03.2003|Padang
72.01.03.2004|Manyula
72.01.03.2005|Uling
72.01.03.2007|Samadoya
72.01.03.2008|Dimpalon
72.01.03.2009|Solan
72.01.03.2013|Babang Buyangge
72.01.03.2015|Solan Baru
72.01.03.2019|Dimpalon Baru
72.01.04.1009|Luwuk
72.01.04.1010|Baru
72.01.04.1011|Soho
72.01.04.1012|Bungin
72.01.04.1031|Karaton
72.01.04.1033|Kaleke
72.01.04.1034|Bungin Timur
72.01.04.1035|Mangkio Baru
72.01.04.2008|Tontouan
72.01.04.2013|Lumpoknyo
72.01.05.2009|Nipa
72.01.05.2010|Kagitakan
72.01.05.2011|Sirom
72.01.05.2012|Poroan
72.01.05.2013|Lomba
72.01.05.2014|Bonebobakal
72.01.05.2015|Baruga
72.01.05.2016|Kotabaru
72.01.05.2017|Labotan
72.01.05.2023|Tinonda
72.01.05.2027|Bahari Makmur
72.01.05.2028|Kota Raya
72.01.06.1020|Balantak
72.01.06.1030|Dale-Dale
72.01.06.1031|Talang Batu
72.01.06.2009|Talima A
72.01.06.2010|Talima B
72.01.06.2013|Dolom
72.01.06.2014|Kiloma
72.01.06.2015|Ra'u
72.01.06.2016|Tanotu
72.01.06.2017|Padang
72.01.06.2018|Mamping
72.01.06.2021|Luok
72.01.06.2027|Boloak
72.01.07.1011|Pakowa
72.01.07.1018|Pagimana
72.01.07.1022|Basabungan
72.01.07.2001|Baloa Doda
72.01.07.2002|Tampe
72.01.07.2010|Asaan
72.01.07.2012|Balai Gondi
72.01.07.2013|Bajo Poat
72.01.07.2014|Gomuo
72.01.07.2015|Nain
72.01.07.2016|Lamo
72.01.07.2017|Tongkonunuk
72.01.07.2019|Hohudongan
72.01.07.2020|Sinampangnyo
72.01.07.2021|Jaya Bakti
72.01.07.2023|Pisou
72.01.07.2024|Lambangan
72.01.07.2025|Toipan
72.01.07.2026|Siuna
72.01.07.2027|Pinapuan
72.01.07.2029|Sepa
72.01.07.2030|Taloyon
72.01.07.2031|Uwedaka
72.01.07.2032|Tintingan
72.01.07.2033|Bungawon
72.01.07.2034|Huhak
72.01.07.2035|Poh
72.01.07.2037|Bondat
72.01.07.2038|Sammajatem
72.01.07.2039|Bulu
72.01.07.2041|Tombang
72.01.07.2043|Ampera
72.01.07.2044|Dongkalan
72.01.08.2001|Bualemo A
72.01.08.2002|Tikupan
72.01.08.2003|Trans Mayayap
72.01.08.2004|Toiba
72.01.08.2005|Longkoga Barat
72.01.08.2006|Longkoga Timur
72.01.08.2007|Bualemo B
72.01.08.2008|Taima
72.01.08.2009|Sampaka
72.01.08.2010|Malik
72.01.08.2011|Binsil
72.01.08.2012|Binsil Padang
72.01.08.2013|Lembah Tompotika
72.01.08.2014|Mayayap
72.01.08.2015|Bima Karya
72.01.08.2016|Salipi
72.01.08.2017|Nipa Kalemoan
72.01.08.2018|Malik Makmur
72.01.08.2019|Lembah Makmur
72.01.08.2020|Dwi Karya
72.01.09.1054|Cendana
72.01.09.2001|Cendana Pura
72.01.09.2011|Sentral Sari
72.01.09.2013|Tirta Kencana
72.01.09.2014|Singkoyo
72.01.09.2017|Tirta Sari
72.01.09.2026|Rusa Kencana
72.01.09.2036|Samalore
72.01.09.2037|Ue Mea
72.01.09.2038|Benteng
72.01.09.2039|Mansahang
72.01.09.2045|Tanah Abang
72.01.09.2047|Jaya Kencana
72.01.09.2051|Sentral Timur
72.01.09.2057|Sidomukti
72.01.10.2001|Tangeban
72.01.10.2002|Taugi
72.01.10.2003|Eteng
72.01.10.2004|Minang Andala
72.01.10.2005|Kospa Duatakarya
72.01.10.2006|Purwo Agung
72.01.10.2007|Kembang Merta
72.01.10.2008|Simpangan
72.01.10.2009|Tompotika Makmur
72.01.10.2010|Duata Karya
72.01.10.2011|Serese
72.01.10.2012|Cemerlang
72.01.10.2013|Padangon
72.01.10.2014|Ranga-Ranga
72.01.11.2001|Kayutanyo
72.01.11.2002|Pohi
72.01.11.2003|Hunduhon
72.01.11.2004|Baya
72.01.11.2005|Uwedikan
72.01.11.2006|Bantayan
72.01.11.2007|Lauwon
72.01.11.2008|Boitan
72.01.11.2009|Molino
72.01.11.2010|Louk
72.01.11.2011|Lontos
72.01.11.2012|Indang Sari
72.01.11.2013|Bukit Mulya
72.01.12.2001|Dongin
72.01.12.2002|Pandan Wangi
72.01.12.2003|Kami Wangi
72.01.12.2004|Sindang Sari
72.01.12.2005|Makapa
72.01.12.2006|Karya Makmur
72.01.12.2007|Mantawa
72.01.12.2008|Pasir Lamba
72.01.12.2009|Mantawa Bonebae
72.01.12.2010|Gunung Kramat
72.01.12.2011|Lembah Kramat
72.01.12.2012|Rata
72.01.12.2013|Bukit Makarti
72.01.12.2014|Uwe Lolu
72.01.12.2015|Bumi Harapan
72.01.12.2016|Mekar Sari
72.01.12.2017|Mekar Jaya
72.01.13.2001|Bangketa
72.01.13.2002|Tobelombang
72.01.13.2003|Balaan
72.01.13.2004|Mantan B
72.01.13.2005|Tomeang
72.01.13.2006|Pakowa Bunta
72.01.13.2007|Pibombo
72.01.13.2008|Bolobungkang
72.01.13.2009|Petak
72.01.13.2010|Bella
72.01.13.2011|Binohu
72.01.13.2012|Damai Makmur
72.01.13.2013|Jaya Makmur
72.01.13.2014|Saiti
72.01.13.2015|Sumber Agung
72.01.13.2016|Batu Hitam
72.01.13.2017|Kabua Bua
72.01.13.2018|Pulo Dalagan
72.01.13.2019|Obo Balingara
72.01.13.2020|Tetesulu
72.01.14.2001|Saluan
72.01.14.2002|Toili
72.01.14.2003|Selamet Raharjo
72.01.14.2004|Mulyoharjo
72.01.14.2005|Sidoharjo
72.01.14.2006|Bumi Harjo
72.01.14.2007|Minakarya
72.01.14.2008|Minahaki
72.01.14.2009|Arga Kencana
72.01.14.2010|Moilong
72.01.14.2011|Karang Anyar
72.01.14.2012|Sumber Harjo
72.01.14.2013|Karya Jaya
72.01.14.2014|Tou
72.01.14.2015|Argo Mulyo
72.01.14.2016|Sido Makmur
72.01.15.2001|Maasing
72.01.15.2002|Gori-Gori
72.01.15.2003|Sinorang
72.01.15.2004|Sukamaju
72.01.15.2005|Sukamaju Satu
72.01.15.2006|Paisu Buloli
72.01.15.2007|Ombolu
72.01.15.2008|Bonebalantak
72.01.15.2009|Masungkang
72.01.15.2010|Maleo Jaya
72.01.16.2001|Lobu
72.01.16.2002|Bolobungkang
72.01.16.2003|Niubulan
72.01.16.2004|Kadodi
72.01.16.2005|Uha Uhangon
72.01.16.2006|Bahingin
72.01.16.2007|Uwe Daka-Daka
72.01.16.2008|Balean
72.01.16.2009|Dolom
72.01.16.2010|Lambuli
72.01.17.2001|Beringin Jaya
72.01.17.2002|Rantau Jaya
72.01.17.2003|Koninis
72.01.17.2004|Gonohop
72.01.17.2005|Sumber Mulia
72.01.17.2006|Doda Bunta
72.01.17.2007|Simpang Satu
72.01.17.2008|Simpang Dua
72.01.17.2009|Dowiwi
72.01.17.2010|Mantan A
72.01.17.2011|Dwipa Karya
72.01.17.2012|Lokait
72.01.18.2001|Tombos
72.01.18.2002|Dondo
72.01.18.2003|Sepe
72.01.18.2004|Booy
72.01.18.2005|Tintingon
72.01.18.2006|Resarna
72.01.18.2007|Giwang
72.01.18.2008|Tongke
72.01.18.2009|Gorontalo
72.01.18.2010|Poyang
72.01.18.2011|Tanggawas
72.01.19.2001|Kampangar
72.01.19.2002|Kuntang
72.01.19.2003|Pulau Dua
72.01.19.2004|Teku
72.01.19.2005|Ondoliang
72.01.19.2006|Batu Simpang
72.01.19.2007|Batu Mandi
72.01.19.2008|Pangkalaseang
72.01.19.2009|Pangkalaseang Baru
72.01.19.2010|Toweer
72.01.20.1002|Simpong
72.01.20.1003|Hanga Hanga
72.01.20.1004|Jole
72.01.20.1005|Hanga-Hanga Permai
72.01.20.1006|Kompo
72.01.20.1007|Bukit Mambual
72.01.20.1008|Tombang Permai
72.01.20.1009|Maahas
72.01.20.1010|Tanjung Tuwis
72.01.20.2001|Bubung
72.01.21.1010|Kilongan
72.01.21.1011|Kilongan Permai
72.01.21.2001|Biak
72.01.21.2002|Bunga
72.01.21.2003|Kamumu
72.01.21.2004|Salodik
72.01.21.2005|Lenyek
72.01.21.2006|Buon Mandiri
72.01.21.2007|Boyou
72.01.21.2008|Awu
72.01.21.2009|Bumi Beringin
72.01.22.2001|Pondan
72.01.22.2002|Sobol
72.01.22.2003|Sobol Baru
72.01.22.2004|Binotik
72.01.22.2005|Garuga
72.01.22.2006|Bollo
72.01.22.2007|Sulubombong
72.01.22.2008|Boras
72.01.22.2009|Lonas
72.01.22.2010|Bombongan
72.01.23.1003|Nambo Padang
72.01.23.1004|Nambo Bosaa
72.01.23.1005|Nambo Lempek
72.01.23.1006|Nambo Lempek Baru
72.01.23.1007|Lontio
72.01.23.1008|Lontio Baru
72.01.23.2001|Koyoan
72.01.23.2002|Koyoan Permai
72.01.23.2009|Padungnyo
72.01.23.2010|Sayambongin
72.01.23.2011|Lumbe
72.01.24.2001|Tolisu
72.01.24.2002|Mekar Kencana
72.01.24.2003|Marga Kencana
72.01.24.2004|Mulyasari
72.01.24.2005|Tirta Jaya
72.01.24.2006|Saribuana
72.01.24.2007|Tohitisari
72.01.24.2008|Sindang Baru
72.01.24.2009|Bukit Jaya
72.01.24.2010|Piondo
72.02.01.1001|Moengko Lama
72.02.01.1002|Moengko Baru
72.02.01.1003|Kayamanya
72.02.01.1007|Gebangrejo
72.02.01.1016|Gebangrejo Timur
72.02.01.1017|Gebangrejo Barat
72.02.01.1018|Kayamanya Sentral
72.02.02.1008|Kasinguncu
72.02.02.1009|Mapane
72.02.02.1031|Tabalu
72.02.02.2007|Betania
72.02.02.2010|Toini
72.02.02.2012|Bega
72.02.02.2013|Masamba
72.02.02.2014|Saatu
72.02.02.2015|Pinedapa
72.02.02.2016|Masani
72.02.02.2017|Tokorondo
72.02.02.2018|Tiwaa
72.02.02.2027|Lanto Jaya
72.02.02.2028|Lape
72.02.02.2029|Towu
72.02.02.2030|Ueralulu
72.02.03.2001|Tampemadoro
72.02.03.2002|Pandiri
72.02.03.2003|Watuawu
72.02.03.2004|Tambaro
72.02.03.2005|Tagolu
72.02.03.2006|Maliwuko
72.02.03.2007|Silanca
72.02.03.2008|Sepe
72.02.03.2009|Bategencu
72.02.03.2010|Toyado
72.02.03.2011|Tongko
72.02.03.2012|Malei
72.02.03.2013|Sintuwulemba
72.02.03.2014|Labuan
72.02.03.2015|Labuadago
72.02.03.2017|Rato'ombu
72.02.04.1001|Tentena
72.02.04.1006|Pamona
72.02.04.1008|Sangele
72.02.04.2003|Tonusu
72.02.04.2004|Mayakeli
72.02.04.2005|Buyumpondoli
72.02.04.2009|Peura
72.02.04.2010|Dulumai
72.02.04.2019|Soe
72.02.04.2021|Leboni
72.02.04.2022|Wera
72.02.05.2001|Taripa
72.02.05.2002|Tiu
72.02.05.2003|Petiro
72.02.05.2004|Pancasila
72.02.05.2005|Olumokunde
72.02.05.2006|Kamba
72.02.05.2007|Didiri
72.02.05.2008|Kelei
72.02.05.2009|Poleganyara
72.02.05.2010|Masewe
72.02.05.2011|Matialemba
72.02.05.2012|Kancuu
72.02.05.2013|Magapu
72.02.06.2003|Bancea
72.02.06.2004|Boe
72.02.06.2005|Pendolo
72.02.06.2006|Pandayora
72.02.06.2007|Mayoa
72.02.06.2008|Uelene
72.02.06.2018|Mayasari
72.02.06.2019|Pandajaya
72.02.06.2020|Mayajaya
72.02.06.2021|Bangunjaya
72.02.06.2022|Panjo
72.02.06.2023|Pasir Putih
72.02.07.2001|Dodolo
72.02.07.2006|Kaduwaa
72.02.07.2007|Watumaeta
72.02.07.2008|Sedoa
72.02.07.2009|Alitupu
72.02.07.2014|Wuasa
72.02.07.2016|Bumi Banyusari
72.02.08.2001|Hangira
72.02.08.2002|Lempe
72.02.08.2003|Doda
72.02.08.2004|Bariri
72.02.08.2005|Torire
72.02.08.2006|Katu
72.02.08.2007|Rompo
72.02.08.2008|Baleura
72.02.09.2005|Gintu
72.02.09.2006|Runde
72.02.09.2007|Badangkaia
72.02.09.2008|Bakekau
72.02.09.2009|Bulili
72.02.09.2010|Bewa
72.02.09.2011|Pada
72.02.09.2012|Bomba
72.02.18.2001|Kilo
72.02.18.2002|Kawende
72.02.18.2003|Kalora
72.02.18.2004|Tambarana
72.02.18.2005|Tumora
72.02.18.2006|Tri Mulya
72.02.18.2007|Bakti Agung
72.02.18.2009|Tobe
72.02.18.2010|Membuke
72.02.18.2011|Maranda
72.02.19.2001|Dewua
72.02.19.2002|Sangginora
72.02.19.2003|Tangkura
72.02.19.2004|Malitu
72.02.19.2005|Patiwunga
72.02.19.2006|Betalemba
72.02.19.2007|Pantangolemba
72.02.19.2008|Padalembara
72.02.19.2009|Taunca
72.02.20.2001|Taipa
72.02.20.2002|Meko
72.02.20.2003|Toinasa
72.02.20.2004|Salukaia
72.02.20.2005|Uranosari
72.02.20.2006|Owini
72.02.21.1001|Sayo
72.02.21.1002|Bukit Bambu
72.02.21.1003|Kawua
72.02.21.1004|Ronononcu
72.02.21.1005|Lembomawo
72.02.22.1001|Bonesompe
72.02.22.1002|Kasintuwu
72.02.22.1003|Lombogia
72.02.22.1004|Lawanga
72.02.22.1005|Tegalrejo
72.02.22.1006|Madale
72.02.22.1007|Lawanga Tawongan
72.02.23.2001|Tuare
72.02.23.2002|Kageroa
72.02.23.2003|Tomehipi
72.02.23.2004|Lengkeka
72.02.23.2005|Kolori
72.02.23.2006|Lelio
72.02.24.2001|Winowanga
72.02.24.2002|Maholo
72.02.24.2003|Tamadue
72.02.24.2004|Mekarsari
72.02.24.2005|Kalemago
72.02.25.2001|Watutau
72.02.25.2002|Betue
72.02.25.2003|Talabosa
72.02.25.2004|Wanga
72.02.25.2005|Siliwanga
72.02.26.2001|Korobono
72.02.26.2002|Omporiwo
72.02.26.2003|Wayura
72.02.26.2004|Tokilo
72.02.26.2005|Tindoli
72.02.26.2006|Tolambo
72.02.26.2007|Singkona
72.02.26.2008|Salindu
72.02.26.2009|Barati
72.02.27.1008|Sawidago
72.02.27.1009|Petirodongi
72.02.27.1010|Tendeadongi
72.02.27.2001|Saojo
72.02.27.2002|Sulewana
72.02.27.2003|Sangira
72.02.27.2004|Kuku
72.02.27.2005|Panjoka
72.02.27.2006|Uelincu
72.02.27.2007|Lena
72.03.04.2001|Pantolobete
72.03.04.2002|Bonemarawa
72.03.04.2003|Tinauka
72.03.04.2004|Lalundu
72.03.04.2005|Towiora
72.03.04.2006|Minti Makmur
72.03.04.2007|Polanto Jaya
72.03.04.2008|Polando Jaya
72.03.04.2009|Rio Mukti
72.03.04.2010|Panca Mukti
72.03.04.2012|Ngovi
72.03.04.2013|Bukit Indah
72.03.04.2014|Mbulawa
72.03.04.2015|Pakava
72.03.06.2001|Kambayang
72.03.06.2002|Talaga
72.03.06.2003|Sabang
72.03.06.2004|Sioyong
72.03.06.2005|Pani'i
72.03.06.2006|Ponggerang
72.03.06.2007|Rerang
72.03.06.2009|Budi Mukti
72.03.06.2010|Lembah Mukti
72.03.06.2011|Malonas
72.03.06.2013|Parisan Agung
72.03.06.2014|Karya Mukti
72.03.06.2015|Long
72.03.08.1020|Ganti
72.03.08.1021|Kabonga Besar
72.03.08.1022|Kabonga Kecil
72.03.08.1023|Gunung Bale
72.03.08.1024|Maleni
72.03.08.1025|Tanjung Batu
72.03.08.1026|Boya
72.03.08.1027|Labuan Bajo
72.03.08.1028|Boneoge
72.03.08.2012|Loli Oge
72.03.08.2013|Loli Tasiburi
72.03.08.2029|Loli Pesua
72.03.08.2030|Loli Dondo
72.03.08.2031|Loli Saluran
72.03.09.2001|Labuan
72.03.09.2008|Labuan Salumbone
72.03.09.2009|Labuan Panimba
72.03.09.2010|Labuan Lelea
72.03.09.2011|Labuan Kungguma
72.03.09.2012|Labuan Toposo
72.03.09.2013|Labuan Lumbubaka
72.03.10.2001|Dalaka
72.03.10.2002|Lero
72.03.10.2003|Taripa
72.03.10.2004|Sumari
72.03.10.2005|Toaya
72.03.10.2006|Masaingi
72.03.10.2007|Marana
72.03.10.2008|Enu
72.03.10.2016|Lero Tatari
72.03.10.2017|Toaya Vunta
72.03.10.2018|Gumbasa
72.03.10.2019|Ape Maliko
72.03.10.2020|Kavaya
72.03.11.2001|Ombo
72.03.11.2002|Tondo
72.03.11.2003|Jonooge
72.03.11.2004|Dampal
72.03.11.2005|Sipi
72.03.11.2006|Tanjung Padang
72.03.11.2007|Balintuma
72.03.11.2008|Sibado
72.03.11.2009|Tompe
72.03.11.2010|Lompio
72.03.11.2011|Lende
72.03.11.2012|Lende Tovea
72.03.11.2013|Ujumbou
72.03.12.2006|Labean
72.03.12.2007|Lombonga
72.03.12.2008|Meli
72.03.12.2009|Tambu
72.03.12.2010|Siweli
72.03.12.2011|Sibualong
72.03.12.2012|Sibayu
72.03.12.2015|Malino
72.03.12.2016|Mapane Tambu
72.03.12.2017|Tovia Tambu
72.03.12.2019|Sipure
72.03.12.2020|Kampung Baru Sibayu
72.03.12.2021|Simagaya
72.03.14.2001|Balukang
72.03.14.2002|Siwalempu
72.03.14.2003|Siboang
72.03.14.2004|Tonggolobibi
72.03.14.2005|Bou
72.03.14.2011|Samalili
72.03.14.2012|Bukit Harapan
72.03.14.2013|Pangalasiang
72.03.14.2014|Balukang II
72.03.18.2001|Mbuwu
72.03.18.2002|Salumpaku
72.03.18.2003|Watatu
72.03.18.2004|Surumana
72.03.18.2005|Lalombi
72.03.18.2006|Tanamea
72.03.18.2007|Bambarimi
72.03.18.2008|Salungkaenu
72.03.18.2009|Lumbumamara
72.03.18.2010|Tolongano
72.03.18.2011|Tosale
72.03.18.2012|Lumbu Tarombo
72.03.18.2013|Lumbulama
72.03.18.2014|Ongulara
72.03.18.2015|Malino
72.03.18.2016|Lembasada
72.03.18.2017|Sarombaya
72.03.18.2018|Salusumpu
72.03.18.2019|Tanampulu
72.03.19.2001|Wani Satu
72.03.19.2002|Wani Dua
72.03.19.2003|Nupa Bomba
72.03.19.2004|Wombo
72.03.19.2005|Guntarano
72.03.19.2006|Bale
72.03.19.2007|Wombo Mpanau
72.03.19.2008|Wombo Kalonggo
72.03.19.2009|Wani Tiga
72.03.19.2010|Wani Lumbumpetigo
72.03.21.2001|Palintuma
72.03.21.2002|Gimpubia
72.03.21.2003|Dangara'a
72.03.21.2004|Bambakanini
72.03.21.2005|Bambakaenu
72.03.21.2006|Tomodo
72.03.21.2007|Kanagalongga
72.03.21.2008|Karavia
72.03.21.2009|Tavanggeli
72.03.24.2001|Tibo
72.03.24.2002|Kaliburu
72.03.24.2003|Batusuya
72.03.24.2004|Saloya
72.03.24.2005|Batusuya Go'o
72.03.24.2006|Kaliburu Kata
72.03.25.2001|Sikara Tobata
72.03.25.2002|Alindau
72.03.25.2003|Oti
72.03.25.2004|Tamarenja
72.03.25.2005|Sipeso
72.03.25.2006|Sindosa
72.03.27.2001|Powelua
72.03.27.2002|Lumbudolo
72.03.27.2003|Kola-Kola
72.03.27.2004|Limboro
72.03.27.2005|Towale
72.03.27.2006|Salubomba
72.03.27.2007|Mekar Baru
72.03.27.2008|Lampo
72.03.30.2001|Ogoamas I
72.03.30.2002|Ogoamas II
72.03.30.2003|Lenju
72.03.30.2004|Pesik
72.03.30.2005|Bengkoli
72.03.31.2001|Walandano
72.03.31.2002|Malei
72.03.31.2003|Kamonji
72.03.31.2004|Ketong
72.03.31.2005|Rano
72.03.31.2006|Pomolulu
72.03.31.2007|Palau
72.03.31.2008|Manimbaya
72.04.01.2001|Kombo
72.04.01.2002|Tampiala
72.04.01.2003|Soni
72.04.01.2004|Bangkir
72.04.01.2005|Dongko
72.04.01.2006|Mimbala
72.04.01.2007|Lempe
72.04.01.2008|Paddumpu
72.04.01.2009|Abbajareng
72.04.01.2010|Puse
72.04.01.2011|Pallakawe
72.04.01.2012|Simuntu
72.04.01.2013|Lemba Harapan
72.04.02.2001|Banagan
72.04.02.2002|Kabinuang
72.04.02.2003|Ogotua
72.04.02.2004|Tompoh
72.04.02.2005|Bambapula
72.04.02.2006|Malambigu
72.04.02.2007|Simatang Tanjung
72.04.02.2008|Simatang Utara
72.04.02.2009|Sese
72.04.02.2010|Ogolali
72.04.02.2011|Balaroa
72.04.02.2012|Stadong
72.04.03.2001|Luok Manipi
72.04.03.2002|Salumbia
72.04.03.2003|Bambapun
72.04.03.2004|Ogowele
72.04.03.2005|Lais
72.04.03.2006|Ogogasang
72.04.03.2007|Malomba
72.04.03.2008|Ogogili
72.04.03.2009|Tinabogan
72.04.03.2010|Malulu
72.04.03.2011|Malala
72.04.03.2012|Anggasan
72.04.03.2013|Betengon
72.04.03.2014|Pangkung
72.04.03.2015|Ogowele Buga
72.04.03.2016|Lobuo
72.04.04.2001|Sibaluton
72.04.04.2002|Kayu Lompa
72.04.04.2003|Labonu
72.04.04.2004|Silondou
72.04.04.2005|Kinapasan
72.04.04.2006|Kongkomos
72.04.04.2007|Ogosipat
72.04.04.2008|Galandau
72.04.04.2009|Marisa
72.04.04.2010|Basi
72.04.05.2001|Buga
72.04.05.2002|Batuilo
72.04.05.2003|Kamalu
72.04.05.2004|Muara Besar
72.04.05.2005|Bilo
72.04.05.2006|Labuan Lobo
72.04.05.2007|Sambujan
72.04.05.2008|Pulias
72.04.05.2009|Kabetan
72.04.05.2010|Pagaitan
72.04.05.2011|Bambalaga
72.04.06.2001|Janja
72.04.06.2002|Oyom
72.04.06.2003|Salugan
72.04.06.2004|Lampasio
72.04.06.2005|Tinading
72.04.06.2006|Sibea
72.04.06.2007|Maibua
72.04.06.2008|Mulya Sari
72.04.06.2009|Ogomatanang
72.04.07.1001|Tambun
72.04.07.1003|Tuweley
72.04.07.1004|Nalu
72.04.07.1005|Baru
72.04.07.1006|Panasakan
72.04.07.1007|Sidoarjo
72.04.07.2002|Dadakitan
72.04.07.2008|Buntuna
72.04.07.2009|Lelean Nono
72.04.07.2010|Pangi
72.04.08.2001|Ogomoli
72.04.08.2002|Sandana
72.04.08.2003|Kalangkangan
72.04.08.2004|Lantapan
72.04.08.2005|Lakatan
72.04.08.2006|Tinigi
72.04.08.2007|Ginunggung
72.04.08.2008|Lalos
72.04.08.2009|Tende
72.04.08.2010|Sabang
72.04.08.2011|Bajugan
72.04.08.2012|Aung
72.04.08.2013|Malangga
72.04.08.2014|Kinopasan
72.04.09.2005|Santigi
72.04.09.2006|Laulalang
72.04.09.2007|Salumpaga
72.04.09.2008|Diule
72.04.09.2009|Pinjan
72.04.09.2010|Binontoan
72.04.09.2011|Lakuan Tolitoli
72.04.09.2012|Timbolo
72.04.09.2013|Teluk Jaya
72.04.09.2014|Gio
72.04.10.2001|Galumpang
72.04.10.2002|Dungingis
72.04.10.2003|Kapas
72.04.10.2004|Lingadan
72.05.01.2001|Momunu
72.05.01.2002|Pinamula
72.05.01.2003|Pujimulyo
72.05.01.2004|Taluan
72.05.01.2005|Potugu
72.05.01.2006|Panimbul
72.05.01.2007|Tongon
72.05.01.2008|Lamadong II
72.05.01.2009|Pomayagon
72.05.01.2010|Guamonial
72.05.01.2011|Lamadong I
72.05.01.2012|Pajeko
72.05.01.2020|Wakat
72.05.01.2021|Soraya
72.05.01.2022|Pinamula Baru
72.05.01.2023|Mangubi
72.05.02.2009|Tuinan
72.05.02.2010|Lakea II
72.05.02.2011|Lakea I
72.05.02.2012|Lakuan Buol
72.05.02.2017|Bukaan
72.05.02.2018|Ngune
72.05.02.2019|Ilambe
72.05.03.2001|Tayadun
72.05.03.2002|Poongan
72.05.03.2003|Bongo
72.05.03.2004|Doulan
72.05.03.2010|Kantanan
72.05.03.2011|Kodolagon
72.05.03.2014|Negeri Lama
72.05.03.2015|Bokat IV
72.05.03.2018|Bokat
72.05.03.2019|Butukan
72.05.03.2020|Tikopo
72.05.03.2021|Bukamog
72.05.03.2022|Tang
72.05.03.2023|Duamayo
72.05.03.2024|Langudon
72.05.04.2001|Lonu
72.05.04.2002|Tamit
72.05.04.2003|Botugolu
72.05.04.2004|Bunobogu
72.05.04.2005|Konamukan
72.05.04.2006|Ponipingan
72.05.04.2007|Inalatan
72.05.04.2015|Domag Mekar
72.05.04.2016|Bunobogu Selatan
72.05.04.2017|Pokobo
72.05.05.2001|Umu
72.05.05.2002|Mulangato
72.05.05.2003|Lilito
72.05.05.2004|Talaki
72.05.05.2005|Baturata
72.05.05.2006|Kwalabesar
72.05.05.2007|Tolau
72.05.05.2008|Paleleh
72.05.05.2009|Lintidu
72.05.05.2014|Pionoto
72.05.05.2017|Dopalak
72.05.05.2018|Dotuno
72.05.06.1001|Buol
72.05.06.1002|Kali
72.05.06.1003|Leok II
72.05.06.1004|Leok I
72.05.06.1005|Kumaligon
72.05.06.1006|Kulango
72.05.06.1007|Bugis
72.05.07.2001|Boilan
72.05.07.2002|Kokobuka
72.05.07.2003|Air Terang
72.05.07.2004|Panilan Jaya
72.05.07.2005|Jatimulya
72.05.07.2006|Lomuli
72.05.07.2007|Balau
72.05.07.2008|Maniala
72.05.07.2009|Monggonit
72.05.08.2001|Biau
72.05.08.2002|Bungkudu
72.05.08.2003|Rantemaranu
72.05.08.2004|Winangun
72.05.08.2005|Modo I
72.05.08.2006|Unone
72.05.08.2007|Mopu
72.05.08.2008|Diat
72.05.08.2009|Potangoan
72.05.08.2010|Binuang
72.05.08.2011|Yugut
72.05.08.2012|Mooyong
72.05.08.2013|Mulat
72.05.08.2014|Bukal
72.05.09.2001|Lokodidi
72.05.09.2002|Matinan
72.05.09.2003|Taat
72.05.09.2004|Lokodoka
72.05.09.2005|Labuton
72.05.09.2006|Bulagidun
72.05.09.2007|Diapati
72.05.09.2008|Nandu
72.05.09.2009|Lipubogu
72.05.09.2010|Bulogidon Tanjung
72.05.09.2011|Pandangan
72.05.10.2001|Mokupo
72.05.10.2002|Mendaan
72.05.10.2003|Baruga
72.05.10.2004|Monano
72.05.10.2005|Busak I
72.05.10.2006|Busak II
72.05.10.2007|Lamakan
72.05.11.2001|Bodi
72.05.11.2002|Tayokan
72.05.11.2003|Harmoni
72.05.11.2004|Lunguto
72.05.11.2005|Timbulon
72.05.11.2006|Oyak
72.05.11.2007|Hulubalang
72.06.05.1014|Mendui
72.06.05.1015|Lamberea
72.06.05.1016|Tofoiso
72.06.05.1017|Marsaoleh
72.06.05.1018|Matano
72.06.05.1020|Bungi
72.06.05.2010|Puungkoilu
72.06.05.2011|Bahontobungku
72.06.05.2012|Tofuti
72.06.05.2013|Sakita
72.06.05.2019|Matansala
72.06.05.2021|Bahoruru
72.06.05.2022|Bente
72.06.05.2023|Ipi
72.06.05.2024|Bahomohoni
72.06.05.2025|Bahomoleo
72.06.05.2026|Bahomante
72.06.05.2027|Lanona
72.06.05.2029|Tudua
72.06.06.2001|Sainoa
72.06.06.2002|Polewali
72.06.06.2003|Umbele
72.06.06.2004|Pulau Dua
72.06.06.2005|Bakala
72.06.06.2006|Paku
72.06.06.2007|Koburu
72.06.06.2008|Buton
72.06.06.2009|Jawi-Jawi
72.06.06.2010|Kaleroang
72.06.06.2011|Bungingkela
72.06.06.2012|Lokombulo
72.06.06.2013|Buajangka
72.06.06.2014|Waru-Waru
72.06.06.2015|Padabale
72.06.06.2016|Pado-Pado
72.06.06.2017|Pulaubapa
72.06.06.2041|Bungintende
72.06.06.2043|Panimbawang
72.06.06.2044|Po'o
72.06.06.2045|Boelimau
72.06.06.2046|Poaro
72.06.06.2047|Umbele Lama
72.06.07.1007|Ulunambo
72.06.07.2001|Terebino
72.06.07.2002|Torukuno
72.06.07.2003|Ngapaea
72.06.07.2004|Padala'a
72.06.07.2005|Morompaitonga
72.06.07.2006|Kofalagadi
72.06.07.2008|Padei Laut
72.06.07.2009|Padei Darat
72.06.07.2010|Samarengga
72.06.07.2015|Ulunipa
72.06.07.2016|Wawangkolono
72.06.07.2017|Buranga
72.06.07.2019|Tafagapi
72.06.08.2001|Bahoea Reko- Reko
72.06.08.2002|Wosu
72.06.08.2003|Larobenu
72.06.08.2004|Umpanga
72.06.08.2005|Tondo
72.06.08.2006|Topogaro
72.06.08.2007|Ambunu
72.06.08.2008|Wata
72.06.08.2012|Uedago
72.06.08.2029|Marga Mulya
72.06.09.2001|Parilangke
72.06.09.2002|Bahonsuai
72.06.09.2003|Atananga
72.06.09.2004|Pebatae
72.06.09.2005|Umbele
72.06.09.2006|Lambelu
72.06.09.2007|Limbo Makmur
72.06.09.2008|Beringin Jaya
72.06.09.2009|Samarenda
72.06.09.2010|Lasampi
72.06.09.2011|Harapan Jaya
72.06.09.2012|Pebotoa
72.06.09.2013|Karaupa
72.06.10.2001|Bete-Bete
72.06.10.2002|Padabahao
72.06.10.2003|Labota
72.06.10.2004|Fatufia
72.06.10.2005|Keurea
72.06.10.2006|Bahodopi
72.06.10.2007|Lalampu
72.06.10.2008|Siumbatu
72.06.10.2009|Dampala
72.06.10.2010|Le-Le
72.06.10.2011|Baho Makmur
72.06.10.2012|Makartijaya
72.06.12.2001|Sampeantaba
72.06.12.2002|Emea
72.06.12.2006|Moahino
72.06.12.2007|Solonsa
72.06.12.2008|Lantula Jaya
72.06.12.2009|Puntari Makmur
72.06.12.2010|Bumi Harapan
72.06.12.2011|Solonsa Jaya
72.06.12.2012|Ungkaya
72.06.15.2001|Puungkeu
72.06.15.2002|Tangofa
72.06.15.2003|One Ete
72.06.15.2004|Tandaoleo
72.06.15.2005|Lafeu
72.06.15.2006|Torete
72.06.15.2007|Buleleng
72.06.15.2008|Laroenai
72.06.15.2009|Sambalagi
72.06.15.2010|Were'a
72.06.18.2001|Oneputeh Jaya
72.06.18.2002|Bahomotefe
72.06.18.2003|Bahomoahi
72.06.18.2004|Ululere
72.06.18.2005|Kolono
72.06.18.2006|Geresa
72.06.18.2007|Laroue
72.06.18.2008|Nambo
72.06.18.2009|Unsongi
72.06.18.2010|Lahuafu
72.06.20.2001|Tanjung Harapan
72.06.20.2002|Matano
72.06.20.2003|Tanona
72.06.20.2004|Tanjung Tiram
72.06.20.2005|Matarape
72.06.20.2006|Mbokita
72.06.20.2007|Dongkalan
72.06.20.2008|Pulau Tengah
72.06.20.2009|Masadian
72.06.20.2010|Pulau Tiga
72.06.20.2011|La Lemo
72.06.20.2012|Lamontoli
72.06.20.2013|Pulau Dua Darat
72.07.03.2007|Sobonon
72.07.03.2008|Bolonan
72.07.03.2009|Batang Babasal
72.07.03.2010|Sampaka
72.07.03.2011|Salangano
72.07.03.2012|Sambiut
72.07.03.2013|Sakay
72.07.03.2014|Tone
72.07.03.2015|Abason
72.07.03.2016|Lopito
72.07.03.2017|Kombutokan
72.07.04.1015|Salakan
72.07.04.2009|Manggalai
72.07.04.2010|Ambelang
72.07.04.2011|Saiyong
72.07.04.2012|Tompudau
72.07.04.2013|Bongganan
72.07.04.2014|Baka
72.07.04.2016|Bulungkobit
72.07.04.2017|Bakalan
72.07.04.2018|Kautu
72.07.04.2022|Bungin
72.07.05.2001|Tangkop
72.07.05.2002|Binuntuli
72.07.05.2003|Popidolon
72.07.05.2004|Okumel
72.07.05.2005|Tomboniki
72.07.05.2006|Kindandal
72.07.05.2007|Mamulusan
72.07.05.2010|Saleati
72.07.05.2011|Liang
72.07.05.2012|Bajo
72.07.05.2013|Balayon
72.07.05.2016|Basosol
72.07.05.2017|Boyoumoute
72.07.05.2018|Apal
72.07.05.2025|Selekan
72.07.05.2026|Loolong
72.07.06.1018|Bulagi I
72.07.06.2014|Tolo
72.07.06.2015|Lalandai
72.07.06.2016|Montomisan
72.07.06.2017|Sosom
72.07.06.2019|Bulagi II
72.07.06.2020|Boloy
72.07.06.2021|Meselesek
72.07.06.2022|Oluno
72.07.06.2023|Sumondung
72.07.06.2024|Pelingseasa
72.07.06.2025|Komba-komba
72.07.06.2035|Alul
72.07.06.2038|Toolon
72.07.06.2039|Kambal
72.07.06.2040|Kayubet
72.07.07.2008|Paisubatu
72.07.07.2009|Batangono
72.07.07.2010|Lalengan
72.07.07.2011|Peling Lalomo
72.07.07.2012|Labasiano
72.07.07.2013|Tataba
72.07.07.2014|Malanggong
72.07.07.2015|Leme-leme bungin
72.07.07.2016|Leme-leme darat
72.07.07.2017|Talas-talas
72.07.07.2018|Okulo Potil
72.07.07.2019|Tatendeng
72.07.07.2020|Olusi
72.07.09.2001|Bonepuso
72.07.09.2002|Palabatu II
72.07.09.2003|Tatarandang
72.07.09.2004|Pandaluk
72.07.09.2005|Osan
72.07.09.2006|Balalon
72.07.09.2007|Sabelak
72.07.09.2008|Suit
72.07.09.2009|Lolantang
72.07.09.2010|Toi-Toi
72.07.09.2011|Palabatu I
72.07.09.2012|Mangais
72.07.09.2013|Unu
72.07.09.2014|Lemelu
72.07.09.2015|Babang
72.07.09.2016|Momotan
72.07.09.2017|Boluni
72.07.09.2018|Labotankandi
72.07.09.2019|Alasan Nggolobuton
72.07.09.2020|Pipilogot Paipaisu
72.07.11.2001|Tobing
72.07.11.2002|Paisumusoni
72.07.11.2003|Tobungin
72.07.11.2004|Mansamat A
72.07.11.2005|Mansamat B
72.07.11.2006|Kampung Baru
72.07.11.2007|Tinangkung
72.07.11.2008|Gansal
72.07.11.2009|Bobu
72.07.15.2001|Kalumbatan
72.07.15.2002|Tonuson
72.07.15.2003|Tobungku
72.07.15.2004|Nulion
72.07.15.2005|Peley
72.07.15.2006|Kanali
72.07.15.2007|Mata
72.07.15.2008|Lobuton
72.07.16.2001|Patukuki
72.07.16.2002|Balombong
72.07.16.2003|Kolak
72.07.16.2004|Koyobunga
72.07.16.2005|Alakasing
72.07.16.2006|Tombos
72.07.16.2007|Luk
72.07.16.2008|Labibi
72.07.16.2009|Popisi
72.07.16.2010|Tolulos
72.07.16.2011|Tunggaling
72.07.17.1009|Sabang
72.07.17.2001|Sambulangan
72.07.17.2002|Bangunemo
72.07.17.2003|Paisuluno
72.07.17.2004|Montop
72.07.17.2005|Bolubung
72.07.17.2006|Bakalinga
72.07.17.2007|Lukpanenteng
72.07.17.2008|Koyobunga
72.07.17.2010|Ombuli
72.07.17.2011|Minanga
72.07.17.2012|Mandok
72.07.18.2001|Lumbi-lumbia
72.07.18.2002|Kambani
72.07.18.2003|Tatabau
72.07.18.2004|Buko
72.07.18.2005|Palapat
72.07.18.2006|Labangun
72.07.18.2007|Seano
72.07.18.2008|Lelang Matamaling
72.07.18.2009|Apal
72.07.18.2010|Sapelang
72.07.18.2011|Landonan Bebeau
72.07.19.2001|Tatakalai
72.07.19.2002|Lalong
72.07.19.2003|Ponding-ponding
72.07.19.2004|Luksagu
72.07.19.2005|Palam
72.07.19.2006|Bampanga
72.08.01.1017|Masigi
72.08.01.1018|Maesa
72.08.01.1019|Loji
72.08.01.1020|Bantaya
72.08.01.1021|Kampal
72.08.01.2011|Olaya
72.08.01.2012|Pembalowo
72.08.01.2013|Mertasari
72.08.01.2022|Bambalemo
72.08.01.2023|Lebo
72.08.01.2035|Bambalemo Ranomaisi
72.08.02.2005|Tolole
72.08.02.2006|Toga
72.08.02.2007|Sidole
72.08.02.2008|Paranggi
72.08.02.2009|Ampibabo
72.08.02.2010|Lemo
72.08.02.2011|Buranga
72.08.02.2021|Tanampedagi
72.08.02.2022|Tombi
72.08.02.2024|Ampibabo Utara
72.08.02.2025|Ogolugus
72.08.02.2026|Lemo Utara
72.08.02.2027|Sidole Barat
72.08.02.2028|Aloo
72.08.02.2029|Ampibabo Timur
72.08.02.2030|Sidole Timur
72.08.02.2031|Pangku
72.08.02.2032|Tolole Raya
72.08.02.2033|Lemo Tengah
72.08.03.2008|Bainaa
72.08.03.2009|Dongkas
72.08.03.2010|Tinombo
72.08.03.2011|Lombok
72.08.03.2012|Dusunan
72.08.03.2013|Tibu
72.08.03.2019|Bainaa Barat
72.08.03.2021|Ogoalas
72.08.03.2022|Lombok Barat
72.08.03.2027|Silabia
72.08.03.2028|Siavu
72.08.03.2029|Ambason Mekar
72.08.03.2030|Dusunan Barat
72.08.03.2031|Patingke
72.08.03.2033|Taipaobal
72.08.04.2001|Moutong Timur
72.08.04.2002|Moutong Barat
72.08.04.2003|Moutong Tengah
72.08.04.2004|Tuladenggi Pantai
72.08.04.2006|Gio
72.08.04.2024|Lobu
72.08.04.2025|Pendelalap
72.08.04.2026|Sejoli
72.08.04.2028|Aedan Raya
72.08.04.2029|Salumpengut
72.08.04.2030|Boloung Olonggata
72.08.04.2031|Labuan
72.08.04.2032|Mbelang Mbelang
72.08.04.2033|Pande
72.08.04.2034|Moutong Utara
72.08.04.2035|Salepae
72.08.04.2036|Olonggata
72.08.04.2037|Gio Timur
72.08.04.2038|Gio Barat
72.08.04.2039|Sialopa
72.08.05.2005|Tingkulang
72.08.05.2006|Tomini
72.08.05.2007|Ogotumubu
72.08.05.2008|Ambesia
72.08.05.2009|Tilung
72.08.05.2022|Ambesia Selatan
72.08.05.2023|Biga
72.08.05.2024|Tomini Utara
72.08.05.2025|Tomini Barat
72.08.05.2026|Supilopong
72.08.05.2027|Ambesia Barat
72.08.05.2028|Sipontan
72.08.05.2029|Ta'aniuge
72.08.05.2030|Ogotumubu Barat
72.08.06.2009|Sausu Peore
72.08.06.2010|Maleali
72.08.06.2011|Sausu Trans
72.08.06.2012|Sausu Torono
72.08.06.2013|Sausu Pakareme
72.08.06.2015|Sausu Gandasari
72.08.06.2016|Sausu Salubanga
72.08.06.2017|Taliabo
72.08.06.2018|Sausu Tambu
72.08.06.2019|Sausu Auma
72.08.07.2001|Lambunu
72.08.07.2004|Wanagading
72.08.07.2005|Kotanagaya
72.08.07.2006|Margapura
72.08.07.2007|Petunasugi
72.08.07.2016|Siendeng
72.08.07.2017|Lambunu Utara
72.08.07.2021|Gunungsari
72.08.07.2031|Tirtanagaya
72.08.07.2033|Anutapura
72.08.07.2035|Lambunu Timur
72.08.07.2036|Bukit Makmur
72.08.07.2037|Ogorandu
72.08.07.2038|Ganongol Sari
72.08.08.2001|Kasimbar
72.08.08.2002|Posona
72.08.08.2003|Laemanta
72.08.08.2004|Donggulu
72.08.08.2005|Kasimbar Selatan
72.08.08.2006|Kasimbar Barat
72.08.08.2007|Silampayang
72.08.08.2008|Tovalo
72.08.08.2009|Donggulu Selatan
72.08.08.2010|Labuan Donggulu
72.08.08.2011|Kasimbar Palapi
72.08.08.2012|Peningka
72.08.08.2013|Laemanta Utara
72.08.08.2014|Ogodopi Kasimbar
72.08.08.2015|Sendana
72.08.08.2016|Kasimbar Utara
72.08.08.2017|Posona Atas
72.08.08.2018|Sumber Tani
72.08.09.2001|Tanalanto
72.08.09.2002|Torue
72.08.09.2003|Astina
72.08.09.2004|Purwosari
72.08.09.2005|Tolai
72.08.09.2006|Tolai Barat
72.08.09.2007|Tolai Timur
72.08.10.2001|Tada
72.08.10.2002|Sinei
72.08.10.2003|Maninili
72.08.10.2004|Sigenti
72.08.10.2005|Malanggo
72.08.10.2006|Silutung
72.08.10.2007|Tada Selatan
72.08.10.2008|Sigega Bersehati
72.08.10.2009|Siaga
72.08.10.2010|Khatulistiwa
72.08.10.2011|Poly
72.08.10.2012|Sigenti Selatan
72.08.10.2013|Tada Timur
72.08.10.2014|Sigenti Barat
72.08.10.2015|Malanggo Pesisir
72.08.10.2016|Maninili Barat
72.08.10.2017|Maninili Utara
72.08.10.2018|Siney Tengah
72.08.10.2019|Tada Utara
72.08.10.2020|Oncone Raya
72.08.11.2001|Lemusa
72.08.11.2002|Olobaru
72.08.11.2003|Boyantongo
72.08.11.2004|Dolago
72.08.11.2005|Masari
72.08.11.2006|Sumbersari
72.08.11.2007|Nambaru
72.08.11.2008|Tindaki
72.08.11.2009|Gangga
72.08.11.2010|Dolago Padang
72.08.12.2001|Kayu Agung
72.08.12.2002|Sumber Agung
72.08.12.2003|Kotaraya
72.08.12.2004|Mepanga
72.08.12.2005|Ogotion
72.08.12.2006|Mensung
72.08.12.2007|Bugis
72.08.12.2008|Moubang
72.08.12.2009|Ogobayas
72.08.12.2010|Kota Raya Timur
72.08.12.2011|Malalan
72.08.12.2012|Kota Raya Selatan
72.08.12.2013|Maranti
72.08.12.2014|Ogomolos
72.08.12.2015|Kotaraya Barat
72.08.12.2016|Bugis Utara
72.08.12.2017|Gurinda
72.08.12.2018|Kotaraya Tenggara
72.08.13.2001|Tomoli
72.08.13.2002|Toribulu
72.08.13.2003|Sienjo
72.08.13.2004|Pinotu
72.08.13.2005|Singura
72.08.13.2006|Tomoli Selatan
72.08.13.2007|Sibalago
72.08.13.2008|Toribulu Selatan
72.08.13.2009|Tomoli Utara
72.08.14.2001|Karya Agung
72.08.14.2002|Nunurantai
72.08.14.2003|Palapi
72.08.14.2004|Taopa
72.08.14.2005|Tuladenggi Sibatang
72.08.14.2006|Tompo
72.08.14.2007|Taopa Utara
72.08.14.2008|Bilalea
72.08.14.2009|Taopa Barat
72.08.14.2010|Paria
72.08.14.2011|Karya Abadi
72.08.15.2001|Malakosa
72.08.15.2002|Balinggi Jati
72.08.15.2003|Balinggi
72.08.15.2004|Suli
72.08.15.2005|Suli Indah
72.08.15.2006|Beraban
72.08.15.2007|Lebagu
72.08.15.2008|Tumpapa Indah
72.08.15.2009|Catur Karya
72.08.16.2001|Parigimpu'u
72.08.16.2002|Baliara
72.08.16.2003|Kayuboko
72.08.16.2004|Jono Kalora
72.08.16.2005|Air Panas
72.08.16.2006|Lobu Mandiri
72.08.17.2001|Marantale
72.08.17.2002|Tandaigi
72.08.17.2003|Silanga
72.08.17.2004|Siniu
72.08.17.2005|Towera
72.08.17.2006|Toraranga
72.08.17.2007|Uevolo
72.08.17.2008|Siniu Sayogindano
72.08.17.2009|Silanga Barat
72.08.18.2001|Bobalo
72.08.18.2002|Dongkalan
72.08.18.2003|Eeya
72.08.18.2004|Ulatan
72.08.18.2005|Palasa Tangki
72.08.18.2006|Palasa Tengah
72.08.18.2007|Palasa Lambori
72.08.18.2008|Pebounang
72.08.18.2009|Bambasiang
72.08.18.2010|Beau
72.08.18.2011|Ogoansam
72.08.19.2001|Avolua
72.08.19.2002|Toboli
72.08.19.2003|Toboli Barat
72.08.19.2004|Pangi
72.08.19.2005|Sakinah Jaya
72.08.20.2001|Pelawa Baru
72.08.20.2002|Pelawa
72.08.20.2003|Binangga
72.08.20.2004|Jononunu
72.08.20.2005|Matolele
72.08.20.2006|Petapa
72.08.21.2001|Bolano
72.08.21.2002|Bolano Tengah
72.08.21.2003|Bolano Barat
72.08.21.2004|Bolano Utara
72.08.21.2005|Bajo
72.08.21.2006|Sritabaang
72.08.21.2007|Beringin Jaya
72.08.21.2008|Wanamukti
72.08.21.2009|Wanamukti Utara
72.08.21.2010|Lembah Bomban
72.08.21.2011|Sidomukti
72.08.21.2012|Wanamukti Barat
72.08.21.2013|Sama Bahari
72.08.22.2001|Ongka
72.08.22.2002|Malino
72.08.22.2003|Santigi
72.08.22.2004|Persatuan Sejati
72.08.22.2005|Tabolobolo
72.08.22.2006|Tinombala
72.08.22.2007|Karya Mandiri
72.08.22.2008|Kayu Jati
72.08.22.2009|Lambanau
72.08.22.2010|Bosagon Jaya
72.08.22.2011|Persatuan Utara
72.08.22.2012|Tinombala Jaya
72.08.22.2013|Ongka Trimuspasari
72.08.22.2014|Tinombala Sejati
72.08.22.2015|Tinombala Barat
72.08.22.2016|Padaelo
72.08.22.2017|Ongka Persatuan
72.08.23.2001|Lado
72.08.23.2002|Sipayo
72.08.23.2003|Bondoyong
72.08.23.2004|Sidoan Selatan
72.08.23.2005|Sidoan Timur
72.08.23.2006|Sidoan
72.08.23.2007|Sidoan Barat
72.08.23.2008|Ogobagis
72.08.23.2009|Muara Jaya
72.08.23.2010|Bainaa Selatan
72.08.23.2011|Sintuwu Raya
72.09.01.2005|Taningkola
72.09.01.2006|Bambu
72.09.01.2007|Wakai
72.09.01.2008|Una-Una
72.09.01.2009|Tanjung Pude
72.09.01.2010|Lembanya
72.09.01.2014|Cendana
72.09.01.2015|Binanguna
72.09.01.2017|Kavetan
72.09.01.2018|Tanimpo
72.09.01.2019|Luangon
72.09.02.2001|Bungayo
72.09.02.2002|Benteng
72.09.02.2003|Bangkagi
72.09.02.2004|Tongkabo
72.09.02.2005|Pulau Enam
72.09.02.2006|Katupat
72.09.02.2007|Awo
72.09.02.2008|Kololio
72.09.02.2009|Urulepe
72.09.02.2010|Lembanato
72.09.02.2011|Lebiti
72.09.02.2012|Tobil
72.09.02.2013|Baulu
72.09.02.2014|Motobiai
72.09.02.2015|Sampobae
72.09.02.2016|Titiri'i
72.09.03.2006|Tiga Pulau
72.09.03.2007|Popolii
72.09.03.2008|Dolong B
72.09.03.2009|Tutung
72.09.03.2010|Dolong A
72.09.03.2016|Luok
72.09.03.2018|Kolami
72.09.03.2020|Olilan
72.09.03.2023|Loe
72.09.04.2001|Pusungi
72.09.04.2002|Tete B
72.09.04.2003|Tete A
72.09.04.2004|Uebone
72.09.04.2005|Mantangisi
72.09.04.2006|Bantuga
72.09.04.2007|Borone
72.09.04.2008|Balanggala
72.09.04.2009|Sabo
72.09.04.2010|Longge
72.09.04.2011|Tampabatu
72.09.04.2012|Urundaka
72.09.04.2013|Balingara
72.09.04.2014|Bulan Jaya
72.09.04.2015|Giri Mulyo
72.09.04.2017|Wanasari
72.09.04.2019|Kajulangko
72.09.04.2020|Uemakuni
72.09.04.2021|Mpoa
72.09.04.2022|Sukamaju
72.09.05.1002|Malotong
72.09.05.1003|Bailo
72.09.05.1004|Ampana
72.09.05.1012|Bone Rato
72.09.05.1013|Bailo Baru
72.09.05.1014|Labiabae
72.09.05.2001|Sansarino
72.09.05.2011|Padang Tumbuo
72.09.05.2018|Saluaba
72.09.05.2019|Buntongi
72.09.06.2001|Tampanombo
72.09.06.2002|Bonebae II
72.09.06.2003|Tobamau
72.09.06.2004|Rompi
72.09.06.2005|Uematopa
72.09.06.2006|Uekambuno
72.09.06.2007|Paranonge
72.09.06.2008|Bonebae I
72.09.06.2009|Watusongu
72.09.06.2010|Mire
72.09.06.2011|Marowo
72.09.06.2012|Borneang
72.09.06.2013|Bongka Makmur
72.09.06.2015|Cempa
72.09.06.2016|Bonevoto
72.09.06.2017|Bongkakoy
72.09.06.2018|Takibangke
72.09.06.2019|Kasiala
72.09.07.2001|Malei Tojo
72.09.07.2002|Matako
72.09.07.2003|Bambalo
72.09.07.2004|Galuga
72.09.07.2005|Toliba
72.09.07.2006|Ujung Tibu
72.09.07.2007|Nggawia
72.09.07.2008|Tombiano
72.09.07.2009|Tatari
72.09.07.2010|Kabalo
72.09.07.2011|Tanamawau
72.09.07.2012|Malewa
72.09.07.2013|Mawomba
72.09.08.2001|Lemoro
72.09.08.2002|Korondoda
72.09.08.2003|Tayawa
72.09.08.2004|Uekuli
72.09.08.2005|Betaua
72.09.08.2006|Uedele
72.09.08.2007|Sandada
72.09.08.2008|Tojo
72.09.08.2009|Pancuma
72.09.08.2010|Tongku
72.09.08.2011|Podi
72.09.08.2012|Dataran Bugi
72.09.08.2015|Banano
72.09.08.2016|Bahari
72.09.08.2017|Buyuntaripa
72.09.08.2018|Kalemba
72.09.09.2001|Biga
72.09.09.2002|Salinggoha
72.09.09.2003|Tingki
72.09.09.2004|Malapo
72.09.09.2005|Pasokan
72.09.09.2006|Kondongan
72.09.09.2007|Katogop
72.09.09.2008|Tongidon
72.09.10.1001|Uentanaga Bawah
72.09.10.1002|Uentanaga Atas
72.09.10.1003|Dondo
72.09.10.1007|Uamalingku
72.09.10.1008|Dondo Barat
72.09.10.1009|Muara Toba
72.09.10.2004|Sumoli
72.09.10.2005|Sabulira Toba
72.09.10.2006|Labuan
72.09.10.2010|Patingko
72.09.11.2001|Bomba
72.09.11.2002|Molowagu
72.09.11.2003|Malino
72.09.11.2004|Kulingkinari
72.09.11.2005|Tumbulawa
72.09.11.2006|Siatu
72.09.11.2007|Kambutu
72.09.11.2008|Lindo
72.09.11.2009|Patoyan
72.09.12.2001|Kalia
72.09.12.2002|Malenge
72.09.12.2003|Pautu
72.09.12.2004|Tumotok
72.09.12.2005|Kabalutan
72.09.12.2006|Kadoda
72.10.01.2001|Sidondo II
72.10.01.2002|Sidondo I
72.10.01.2003|Bora
72.10.01.2004|Watunonju
72.10.01.2005|Olobuju
72.10.01.2006|Soulowe
72.10.01.2007|Sidera
72.10.01.2008|Jono Oge
72.10.01.2009|Kalukubula
72.10.01.2010|Lolu
72.10.01.2011|Pombewe
72.10.01.2012|Loru
72.10.01.2013|Mpanau
72.10.01.2014|Ngatabaru
72.10.01.2015|Maranatha
72.10.01.2016|Sidondo III
72.10.01.2017|Sidondo IV
72.10.02.2001|Bobo
72.10.02.2002|Bunga
72.10.02.2003|Kapirowe
72.10.02.2004|Makmur
72.10.02.2005|Berdikari
72.10.02.2006|Patimbe
72.10.02.2007|Ampera
72.10.02.2008|Rejeki
72.10.02.2009|Sintuwu
72.10.02.2010|Sigimpu
72.10.02.2011|Bakubakulu
72.10.02.2012|Bahagia
72.10.02.2013|Rahmat
72.10.02.2014|Tanah Harapan
72.10.02.2015|Ranteleda
72.10.02.2016|Tongoa
72.10.02.2017|Lembantongoa
72.10.02.2018|Uwe Nuni
72.10.02.2019|Sejahtera
72.10.02.2020|Ue rani
72.10.02.2021|Karunia
72.10.02.2022|Sarumana
72.10.03.2001|Kamarora A
72.10.03.2002|Kamarora B
72.10.03.2003|Kadidia
72.10.03.2004|Sopu
72.10.03.2005|Bulili
72.10.04.2001|Puroo
72.10.04.2002|Langko
72.10.04.2003|Tomado
72.10.04.2004|Anca
72.10.04.2005|Olu
72.10.05.2001|Siwongi
72.10.05.2002|Banggaiba
72.10.05.2003|Tangkulowi
72.10.05.2004|Boladangko
72.10.05.2005|Lonca
72.10.05.2006|Rantewulu
72.10.05.2007|Towulu
72.10.05.2008|Winatu
72.10.05.2009|Sungku
72.10.05.2010|Bolapapu
72.10.05.2011|Mataue
72.10.05.2012|Toro
72.10.05.2013|Salua
72.10.05.2014|Namo
72.10.05.2015|Marena
72.10.05.2016|Poleroa Makuhi
72.10.06.2001|Lempelero
72.10.06.2002|Gimpu
72.10.06.2003|Tomua
72.10.06.2004|Tompi Bugis
72.10.06.2005|Lawua
72.10.06.2006|Watukilo
72.10.06.2007|Salutome
72.10.06.2008|O'o Parese
72.10.06.2009|Pilimakujawa
72.10.06.2010|Moa
72.10.06.2011|Wangka
72.10.06.2012|Palamaki
72.10.07.2001|Koja
72.10.07.2002|Kalamanta
72.10.07.2003|Mamu
72.10.07.2004|Peana
72.10.07.2005|Kantewu
72.10.07.2006|Onu
72.10.07.2007|Mapahi
72.10.07.2008|Banasu
72.10.07.2009|Lonebasa
72.10.07.2010|Lawe
72.10.07.2011|Morui
72.10.07.2012|Kantewu II
72.10.07.2013|Porelea
72.10.07.2014|Tuwo Tanijaya
72.10.07.2015|Pelempea
72.10.07.2016|Morui II
72.10.07.2017|Poluroa
72.10.07.2018|Masewo
72.10.07.2019|Porelea II
72.10.08.2001|Tuwa
72.10.08.2002|Omu
72.10.08.2003|Simoro
72.10.08.2004|Pakuli
72.10.08.2005|Pandere
72.10.08.2006|Kalawara
72.10.08.2007|Pakuli Utara
72.10.09.2001|Bangga
72.10.09.2002|Walatana
72.10.09.2003|Bulubete
72.10.09.2004|Baluase
72.10.09.2005|Rogo
72.10.09.2006|Pulu
72.10.09.2007|Balongga
72.10.09.2008|Sambo
72.10.09.2009|Wisolo
72.10.09.2010|Jono
72.10.09.2011|Poi
72.10.09.2012|Ramba
72.10.10.2001|Lambara
72.10.10.2002|Sibalaya Selatan
72.10.10.2003|Sibalaya Utara
72.10.10.2004|Sibowi
72.10.10.2005|Sibalaya Barat
72.10.11.2001|Sibonu
72.10.11.2002|Kaluku Tinggu
72.10.11.2003|Pewunu
72.10.11.2004|Kaleke
72.10.11.2005|Rarampadende
72.10.11.2006|Balumpewa
72.10.11.2007|Balamoa
72.10.11.2008|Pesaku
72.10.11.2009|Mantikole
72.10.11.2010|Bobo
72.10.11.2011|Balaroa Pewenu
72.10.11.2012|Luku
72.10.12.2001|Tulo
72.10.12.2002|Langaleso
72.10.12.2003|Watubula
72.10.12.2004|Soulowe
72.10.12.2005|Karawana
72.10.12.2006|Kotapulu
72.10.12.2007|Kotarindau
72.10.12.2008|Panturabate
72.10.12.2009|Maku
72.10.12.2010|Potoya
72.10.12.2011|Kabobona
72.10.13.2001|Porame
72.10.13.2002|Balane
72.10.13.2003|Uwemanje
72.10.13.2004|Rondingo
72.10.13.2005|Bolobia
72.10.13.2006|Doda
72.10.13.2007|Kalora
72.10.13.2008|Kanuna
72.10.13.2009|Daenggune
72.10.13.2010|Kayumpia
72.10.14.2001|Lebanu
72.10.14.2002|Bomba
72.10.14.2003|Beka
72.10.14.2004|Sibedi
72.10.14.2005|Padende
72.10.14.2006|Sunju
72.10.14.2007|Tinggede
72.10.14.2008|Baliase
72.10.14.2009|Binangga
72.10.14.2010|Boyabaliase
72.10.14.2011|Tinggede Selatan
72.10.15.2001|Wayu
72.10.15.2002|Taipanggabe
72.10.15.2003|Matantimali
72.10.15.2004|Lewara
72.10.15.2005|Dombu
72.10.15.2006|Soi
72.10.15.2007|Wugaga
72.10.15.2008|Panasibaja
72.10.15.2009|Ongulero
72.10.15.2010|Wiapore
72.10.15.2011|Wawujai
72.10.15.2012|Lemosiranindi
72.11.01.1005|Lompio
72.11.01.1006|Tano Bununungan
72.11.01.1007|Dodung
72.11.01.2001|Lambako
72.11.01.2002|Kokini
72.11.01.2003|Lampa
72.11.01.2004|Tinakin Laut
72.11.01.2008|Potil Pololoba
72.11.01.2009|Dangkalan
72.11.01.2010|Pasir Putih
72.11.02.2001|Kendek
72.11.02.2002|Lokotoy
72.11.02.2003|Popisi
72.11.02.2004|Paisumosoni
72.11.02.2005|Tolisetubono
72.11.02.2006|Bone Baru
72.11.03.2001|Toropot
72.11.03.2002|Kokudang
72.11.03.2003|Kaukes
72.11.03.2004|Bungin
72.11.03.2005|Panapat
72.11.03.2006|Ndindibung
72.11.03.2007|Nggasuang
72.11.03.2008|Mbuang-Mbuang
72.11.03.2009|Timpaus
72.11.03.2010|Kasuari
72.11.03.2011|Sonit
72.11.03.2012|Paisubebe
72.11.03.2013|Mandel
72.11.03.2014|Minanga
72.11.03.2015|Bolokut
72.11.03.2016|Keak
72.11.04.2001|Togong Sagu
72.11.04.2002|Taduno
72.11.04.2003|Kanari
72.11.04.2004|Lantibung
72.11.04.2005|Kalupapi
72.11.04.2006|Bone-Bone
72.11.04.2007|Mbeleang
72.11.04.2008|Tabulang
72.11.04.2009|Sasabobok
72.11.04.2010|Bungin Lawean
72.11.04.2011|Lalong
72.11.04.2012|Dungkean
72.11.05.2001|Lalong
72.11.05.2002|Lipulalongo
72.11.05.2003|Paisulamo
72.11.05.2004|Alasan
72.11.05.2005|Mansalean
72.11.05.2006|Bontosi
72.11.05.2007|Lipu Talas
72.11.05.2008|Padingkian
72.11.06.2001|Matanga
72.11.06.2002|Tolokibit
72.11.06.2003|Bentean
72.11.06.2004|Malino Padas
72.11.06.2005|Kelapa Lima
72.11.06.2006|Labuan Kapelak
72.11.07.2001|Adean
72.11.07.2002|Badumpayan
72.11.07.2003|Timbong
72.11.07.2004|Mominit
72.11.07.2005|Gonggong
72.11.07.2006|Monsongan
72.11.07.2007|Tintingo
72.11.07.2008|Pososlalongo
72.12.01.1001|Kolonodale
72.12.01.1002|Bahontula
72.12.01.1003|Bahoue
72.12.01.2004|Ganda-Ganda
72.12.01.2005|Koya
72.12.01.2006|Gililana
72.12.01.2007|Tanauge
72.12.01.2008|Korololaki
72.12.01.2009|Korololama
72.12.01.2010|Koromatantu
72.12.02.2001|Bunta
72.12.02.2002|Tompira
72.12.02.2003|Bungintimbe
72.12.02.2004|Towara
72.12.02.2005|Molino
72.12.02.2006|Mohoni
72.12.02.2007|Ungkea
72.12.02.2008|Bimor Jaya
72.12.02.2009|Molores
72.12.02.2010|Keuno
72.12.02.2011|Towara Pantai
72.12.02.2012|Peboa
72.12.03.2001|Dolupo Karya
72.12.03.2002|Po'ona
72.12.03.2003|Petumbea
72.12.03.2004|Ronta
72.12.03.2005|Pontangoa
72.12.03.2006|Jamor Jaya
72.12.03.2007|Pa'awaru
72.12.03.2008|Lembobelala
72.12.03.2009|Bintangor Mukti
72.12.03.2010|Mandula
72.12.04.2001|Beteleme
72.12.04.2002|Uluanso
72.12.04.2003|Mora
72.12.04.2004|Waraa
72.12.04.2005|Tingkeao
72.12.04.2006|Wawopada
72.12.04.2007|Korowalelo
72.12.04.2008|Tinompo
72.12.04.2009|Kumpi
72.12.04.2010|Korompeeli
72.12.04.2011|Lemboroma
72.12.04.2012|Korowou
72.12.04.2013|Lembobaru
72.12.04.2014|Korobonde
72.12.05.2001|Tomata
72.12.05.2002|Londi
72.12.05.2003|Taende
72.12.05.2004|Ensa
72.12.05.2005|Kolaka
72.12.05.2006|Peonea
72.12.05.2007|Lanumor
72.12.05.2008|Gontara
72.12.05.2009|Lee
72.12.05.2010|Saemba
72.12.05.2011|Kasingoli
72.12.05.2012|Tomui Karya
72.12.05.2013|Saemba Walati
72.12.05.2014|Pambarea
72.12.06.2001|Era
72.12.06.2002|Peleru
72.12.06.2003|Tamonjengi
72.12.06.2004|Mayumba
72.12.06.2005|Tiwa'a
72.12.06.2006|Lembontonara
72.12.06.2007|Tabarano
72.12.06.2008|Wawondula
72.12.07.2001|Lembah Sumara
72.12.07.2002|Sumara Jaya
72.12.07.2003|Tambayoli
72.12.07.2004|Malino
72.12.07.2005|Panca Makmur
72.12.07.2006|Tamainusi
72.12.07.2007|Bau
72.12.07.2008|Malino Jaya
72.12.07.2009|Toddopoli Uebangke
72.12.07.2010|Tandoyondo
72.12.08.2001|Baturube
72.12.08.2002|Posangke
72.12.08.2003|Taronggo
72.12.08.2004|Ueruru
72.12.08.2005|Uewajo
72.12.08.2006|Tirongan Bawah
72.12.08.2007|Tirongan Atas
72.12.08.2008|Siliti
72.12.08.2009|Lemo
72.12.08.2010|Salubiro
72.12.08.2011|Uemasi
72.12.08.2012|Opo
72.12.08.2013|Tanakuraya
72.12.08.2014|Tambarobone
72.12.08.2015|Woomparigi
72.12.08.2016|Boba
72.12.08.2017|Kalombang
72.12.08.2018|Tokonanaka
72.12.08.2019|Matube
72.12.08.2020|Lemowalia
72.12.08.2021|Uempanapa
72.12.08.2022|Tokala Atas
72.12.08.2023|Pokeang
72.12.09.2001|Pandauke
72.12.09.2002|Kolo Bawah
72.12.09.2003|Kolo Atas
72.12.09.2004|Momo
72.12.09.2005|Tananagaya
72.12.09.2006|Uepakatu
72.12.09.2007|Lijo
72.12.09.2008|Tanasumpu
72.12.09.2009|Parangisi
72.12.09.2010|Girimulya
72.12.09.2011|Winangobino
72.12.09.2012|Tambale
72.12.09.2013|Sea
72.12.09.2014|Menyo'e
72.12.10.2001|Tiu
72.12.10.2002|Tontowea
72.12.10.2003|Togo Mulyo
72.12.10.2004|Maralee
72.12.10.2005|Mondowe
72.12.10.2006|Sampalowo
72.12.10.2007|Moleono
72.12.10.2008|Onepute
72.12.10.2009|Ulu Laa
72.12.10.2010|Tadaku Jaya
72.71.01.1004|Besusu Barat
72.71.01.1006|Besusu Tengah
72.71.01.1007|Besusu Timur
72.71.01.1009|Lolu Selatan
72.71.01.1010|Lolu Utara
72.71.02.1002|Ujuna
72.71.02.1005|Balaroa
72.71.02.1007|Kamonji
72.71.02.1008|Baru
72.71.02.1009|Lere
72.71.02.1015|Siranindi
72.71.03.1001|Tatura Utara
72.71.03.1002|Birobuli Utara
72.71.03.1003|Petobo
72.71.03.1011|Birobuli Selatan
72.71.03.1012|Tatura Selatan
72.71.04.1001|Mamboro
72.71.04.1002|Taipa
72.71.04.1003|Kayumalue Ngapa
72.71.04.1004|Kayumalue Pajeko
72.71.04.1010|Mamboro Barat
72.71.05.1001|Buluri
72.71.05.1002|Donggala Kodi
72.71.05.1003|Kabonena
72.71.05.1004|Silae
72.71.05.1005|Watusampu
72.71.05.1006|Tipo
72.71.06.1001|Nunu
72.71.06.1002|Palupi
72.71.06.1003|Tawanjuka
72.71.06.1004|Pengawu
72.71.06.1005|Duyu
72.71.06.1006|Boyaoge
72.71.07.1001|Pantoloan
72.71.07.1002|Pantoloan Boya
72.71.07.1003|Baiya
72.71.07.1004|Lambara
72.71.07.1005|Panawu
72.71.08.1001|Layana Indah
72.71.08.1002|Tondo
72.71.08.1003|Talise
72.71.08.1004|Tanamodindi
72.71.08.1005|Lasoani
72.71.08.1006|Poboya
72.71.08.1007|Kawatuna
72.71.08.1008|Talise Valangguni
73.01.01.1001|Benteng Utara
73.01.01.1002|Benteng
73.01.01.1003|Benteng Selatan
73.01.02.1001|Putabangun
73.01.02.1002|Bontobangun
73.01.02.2003|Bontosunggu
73.01.02.2004|Bontoborusu
73.01.02.2005|Bontolebang
73.01.02.2006|Bontotangnga
73.01.02.2007|Kahu-Kahu
73.01.02.2008|Kalepadang
73.01.03.1001|Batangmata
73.01.03.1002|Batangmata Sapo
73.01.03.2003|Pamatata
73.01.03.2004|Tanete
73.01.03.2005|Bungaiya
73.01.03.2006|Kayu Bauk
73.01.03.2007|Barat Lambongan
73.01.03.2008|Bontona Saluk
73.01.03.2009|Onto
73.01.03.2010|Maharayya
73.01.03.2011|Menara Indah
73.01.03.2015|Tamalanrea
73.01.04.2001|Parak
73.01.04.2002|Barugaiya
73.01.04.2003|Jambuiya
73.01.04.2004|Mare-Mare
73.01.04.2005|Polebunging
73.01.04.2006|Bonea Makmur
73.01.04.2008|Bontomarannu
73.01.04.2010|Bonea Timur
73.01.04.2011|Bontokoraang
73.01.04.2012|Kaburu
73.01.05.2001|Harapan
73.01.05.2002|Patikarya
73.01.05.2003|Patilereng
73.01.05.2004|Laiyolo Baru
73.01.05.2005|Laiyolo
73.01.05.2006|Lantibongan
73.01.05.2007|Binanga Sombaiya
73.01.05.2008|Lowa
73.01.05.2009|Appatanah
73.01.05.2010|Tambolongan
73.01.05.2011|Polassi
73.01.05.2012|Khusus Bahuluang
73.01.06.2001|Kembang Ragi
73.01.06.2003|Ma'minasa
73.01.06.2005|Tanamalala
73.01.06.2006|Labuang Pamajang
73.01.06.2007|Massungke
73.01.06.2009|Bontosaile
73.01.06.2011|Teluk Kampe
73.01.07.2001|Bonerate
73.01.07.2002|Majapahit
73.01.07.2003|Batu Bingkung
73.01.07.2004|Bonea
73.01.07.2005|Lambego
73.01.07.2006|Komba-Komba
73.01.07.2007|Sambali
73.01.07.2008|Lamantu
73.01.08.2001|Kayuadi
73.01.08.2002|Batang
73.01.08.2003|Nyiur Indah
73.01.08.2004|Tambuna
73.01.08.2005|Jinato
73.01.08.2006|Rajuni
73.01.08.2007|Latondu
73.01.08.2008|Tarupa
73.01.08.2009|Khusus Pasitallu
73.01.09.2001|Kalaotoa
73.01.09.2002|Garaupa
73.01.09.2003|Lembang Matene
73.01.09.2004|Pulo Madu
73.01.09.2005|Karumpa
73.01.09.2006|Garaupa Raya
73.01.10.2001|Bontobulaeng
73.01.10.2002|Bontobaru
73.01.10.2003|Bontomalling
73.01.10.2004|Lembang Baji
73.01.10.2005|Bontojati
73.01.10.2006|Ujung
73.01.11.2001|Buki
73.01.11.2002|Lalang Bata
73.01.11.2003|Balang Butung
73.01.11.2004|Kohala
73.01.11.2005|Bontolempangan
73.01.11.2006|Mekar Indah
73.01.11.2007|Buki Timur
73.02.01.1001|Matekko
73.02.01.1002|Jalanjang
73.02.01.1003|Mario Rennu
73.02.01.2004|Bialo
73.02.01.2005|Bontomacinna
73.02.01.2006|Gattareng
73.02.01.2007|Dampang
73.02.01.2008|Bontosunggu
73.02.01.2009|Palambarae
73.02.01.2010|Bontonyeleng
73.02.01.2011|Benteng Malewang
73.02.01.2012|Padang
73.02.01.2013|Bontoraja
73.02.01.2014|Paenre Lompoe
73.02.01.2015|Benteng Gattareng
73.02.01.2016|Bukit Harapan
73.02.01.2017|Polewali
73.02.01.2018|Bontomasila
73.02.01.2019|Barombong
73.02.01.2020|Bukit Tinggi
73.02.01.2021|Taccorong
73.02.02.1001|Tanah Kongkong
73.02.02.1002|Bentengnge
73.02.02.1003|Terang Terang
73.02.02.1004|Kalumeme
73.02.02.1005|Bintarore
73.02.02.1006|Kasimpureng
73.02.02.1007|Caile
73.02.02.1008|Loka
73.02.02.1009|Ela Ela
73.02.03.1001|Tanahl Lemo
73.02.03.1002|Sapo Lohe
73.02.03.1003|Benjala
73.02.03.1004|Tanah Beru
73.02.03.2005|Bira
73.02.03.2006|Ara
73.02.03.2007|Darubiah
73.02.03.2008|Lembanna
73.02.04.1001|Eka Tiro
73.02.04.2002|Dwitiro
73.02.04.2003|Tritiro
73.02.04.2004|Batang
73.02.04.2005|Bontotangnga
73.02.04.2006|Caramming
73.02.04.2007|Tamalanrea
73.02.04.2008|Bontobarua
73.02.04.2009|Pakubalaho
73.02.04.2010|Bontomarannu
73.02.04.2011|Bontobulaeng
73.02.04.2012|Buhung Bundang
73.02.04.2013|Lamanda
73.02.05.1001|Tanuntung
73.02.05.1002|Bonto Kamase
73.02.05.2003|Karassing
73.02.05.2004|Singa
73.02.05.2005|Gunturu
73.02.05.2006|Borong
73.02.05.2007|Tugondeng
73.02.05.2008|Pataro
73.02.06.1001|Tanah Jaya
73.02.06.1002|Laikang
73.02.06.2003|Tambangan
73.02.06.2004|Lembanna
73.02.06.2005|Possi Tanah
73.02.06.2006|Tanah Towa
73.02.06.2007|Bontobiraeng
73.02.06.2008|Lembang
73.02.06.2009|Batunilamung
73.02.06.2010|Mattoanging
73.02.06.2011|Malleleng
73.02.06.2012|Bonto Baji
73.02.06.2013|Bontorannu
73.02.06.2014|Pattiroang
73.02.06.2015|Sapanang
73.02.06.2016|Sangkala
73.02.06.2017|Lembang Lohe
73.02.06.2018|Lolisang
73.02.06.2019|Pantama
73.02.07.1001|Tanete
73.02.07.1002|Jawijawi
73.02.07.1003|Balla Saraja
73.02.07.2004|Bontobulaeng
73.02.07.2005|Bulo Bulo
73.02.07.2006|Bontominasa
73.02.07.2007|Balangtaroang
73.02.07.2008|Barugae
73.02.07.2009|Salassae
73.02.07.2010|Kambuno
73.02.07.2011|Jojjolo
73.02.07.2012|Sapobonto
73.02.07.2013|Tibona
73.02.07.2014|Balangpesoang
73.02.07.2015|Batulohe
73.02.07.2016|Bontomangiring
73.02.07.2017|Baruga Riattang
73.02.08.1001|Borong Rappoa
73.02.08.2002|Mattirowalie
73.02.08.2003|Kindang
73.02.08.2004|Arinhua
73.02.08.2005|Tamaona
73.02.08.2006|Benteng Palioi
73.02.08.2007|Balibo
73.02.08.2008|Garuntungan
73.02.08.2009|Orogading
73.02.08.2010|Sipaenre
73.02.08.2011|Kahayya
73.02.08.2012|Somba Palioli
73.02.08.2013|Sopa
73.02.09.1001|Dannuang
73.02.09.2002|Garanta
73.02.09.2003|Balleanging
73.02.09.2004|Balong
73.02.09.2005|Seppang
73.02.09.2006|Manyampa
73.02.09.2007|Tammatto
73.02.09.2008|Padangloang
73.02.09.2009|Manjalling
73.02.09.2010|Lonrong
73.02.09.2011|Salemba
73.02.09.2012|Bijawang
73.02.09.2013|Paccaramengang
73.02.10.1002|Palampang
73.02.10.2001|Bontomanai
73.02.10.2003|Bontobangun
73.02.10.2004|Karama
73.02.10.2005|Bontolohe
73.02.10.2006|Bajiminasa
73.02.10.2007|Bonto Matene
73.02.10.2008|Tanah Harapan
73.02.10.2009|Batukaropa
73.02.10.2010|Bontoharu
73.02.10.2011|Swatani
73.02.10.2012|Bulolohe
73.02.10.2013|Anrang
73.02.10.2014|Pangalloang
73.02.10.2015|Topanda
73.03.01.1001|Bonto Manai
73.03.01.1002|Bonto Lebang
73.03.01.1003|Bonto Sunggu
73.03.01.1004|Bonto Atu
73.03.01.1005|Bonto Rita
73.03.01.1006|Bonto Langkasa
73.03.01.1007|Bonto Jaya
73.03.01.2008|Bonto Jai
73.03.01.2009|Bonto Cinde
73.03.01.2010|Bonto Loe
73.03.01.2012|Bonto Salluang
73.03.02.1001|Tappanjeng
73.03.02.1002|Pallantikang
73.03.02.1003|Letta
73.03.02.1004|Mallilingi
73.03.02.1005|Lembang
73.03.02.1006|Lamalaka
73.03.02.1007|Karatuang
73.03.02.1008|Onto
73.03.02.2009|Kayu Loe
73.03.03.2001|Ulu Galung
73.03.03.2002|Lonrong
73.03.03.2003|Barua
73.03.03.2004|Kampala
73.03.03.2005|Pa'bentengan
73.03.03.2006|Mappilawing
73.03.03.2007|Pa'bumbungang
73.03.03.2008|Mamampang
73.03.03.2009|Parang Loe
73.03.04.1001|Lembang Gantarang Keke
73.03.04.1003|Banyorang
73.03.04.1004|Campaga
73.03.04.1005|Eren Ereng
73.03.04.2006|Labbo
73.03.04.2007|Pattaneteang
73.03.04.2008|Pattallassang
73.03.04.2009|Bonto-bontoa
73.03.04.2010|Bonto Tappalang
73.03.04.2011|Balumbung
73.03.05.2002|Biangkeke
73.03.05.2003|Pa'jukukang
73.03.05.2004|Biangloe
73.03.05.2005|Borong Loe
73.03.05.2006|Baruga
73.03.05.2010|Nipa-nipa
73.03.05.2012|Papan Loe
73.03.05.2013|Rappoa
73.03.05.2014|Lumpangan
73.03.05.2015|Batu Karaeng
73.03.06.2001|Bonto Marannu
73.03.06.2002|Bonto Tangnga
73.03.06.2006|Bonto Tallasa
73.03.06.2007|Bonto Rannu
73.03.06.2010|Bonto Daeng
73.03.06.2011|Bonto Lojong
73.03.07.1001|Gantarang Keke
73.03.07.1002|Tanah Loe
73.03.07.2003|Layoa
73.03.07.2004|Bajiminasa
73.03.07.2005|Tombolo
73.03.07.2006|Kaloling
73.03.08.2001|Bonto Tiro
73.03.08.2002|Bonto Karaeng
73.03.08.2003|Bonto Maccini
73.03.08.2004|Bonto Mate'ne
73.03.08.2005|Bonto Majannang
73.03.08.2006|Bonto Bulaeng
73.04.01.1001|Benteng
73.04.01.1002|Pallengu
73.04.01.1003|Pantai Bahari
73.04.01.1004|Bontorannu
73.04.01.2005|Pallantikang
73.04.01.2006|Kalimporo
73.04.01.2007|Punagaya
73.04.01.2008|Mallasoro
73.04.01.2009|Kapita
73.04.01.2010|Marayoka
73.04.01.2011|Jenetallasa
73.04.01.2012|Tombo Tombolo
73.04.01.2013|Gunung Silanu
73.04.01.2014|Bontomanai
73.04.02.1001|Bonto Tangnga
73.04.02.1002|Tonro Kassi
73.04.02.1003|Tonro Kassi Barat
73.04.02.1004|Tonro Kassi Timur
73.04.02.1005|Taman Roya
73.04.02.1006|Manjangloe
73.04.02.2007|Borongtala
73.04.02.2008|Bontosunggu
73.04.02.2009|Turatea
73.04.02.2010|Karelayu
73.04.02.2011|Bontojai
73.04.02.2012|Turatea Timur
73.04.03.1001|Pabiringa
73.04.03.1002|Balang
73.04.03.1003|Empoang
73.04.03.1004|Balang Toa
73.04.03.1005|Balang Beru
73.04.03.1006|Empoang Selatan
73.04.03.1007|Sidenre
73.04.03.1008|Empoang Utara
73.04.03.1009|Monro Monro
73.04.03.1010|Biring Kassi
73.04.03.1011|Panaikang
73.04.03.1012|Bontoa
73.04.03.2013|Sapanang
73.04.04.1001|Togo Togo
73.04.04.1002|Bonto Raya
73.04.04.2003|Maccinibaji
73.04.04.2008|Camba Camba
73.04.04.2009|Kaluku
73.04.04.2014|Bungeng
73.04.05.1001|Tolo
73.04.05.1002|Tolo Utara
73.04.05.1003|Tolo Selatan
73.04.05.1004|Tolo Timur
73.04.05.1005|Tolo Barat
73.04.05.2006|Gantarang
73.04.05.2009|Bontolebang
73.04.05.2010|Bontonompo
73.04.05.2014|Samataring
73.04.05.2021|Tombolo
73.04.06.1002|Bulu Jaya
73.04.06.2001|Banrimanurung
73.04.06.2003|Barana
73.04.06.2004|Beroanging
73.04.06.2005|Tuju
73.04.06.2006|Garassikang
73.04.06.2007|Pattiro
73.04.06.2008|Pappalluang
73.04.07.1002|Bontoramba
73.04.07.2001|Bulusibatang
73.04.07.2003|Balumbungan
73.04.07.2004|Bangkalaloe
73.04.07.2005|Datara
73.04.07.2006|Maero
73.04.07.2007|Kareloe
73.04.07.2008|Batujala
73.04.07.2009|Bulusuka
73.04.07.2010|Tanammawang
73.04.07.2011|Lentu
73.04.07.2012|Baraya
73.04.08.2001|Paitana
73.04.08.2002|Bonto Mate'ne
73.04.08.2003|Mangepong
73.04.08.2004|Bululoe
73.04.08.2005|Kayuloe Barat
73.04.08.2006|Langkura
73.04.08.2007|Bungungloe
73.04.08.2008|Kayuloe Timur
73.04.08.2009|Jombe
73.04.08.2010|Tanjonga
73.04.08.2011|Parasanganberu
73.04.09.2001|Bulo Bulo
73.04.09.2002|Arungkeke
73.04.09.2003|Palajau
73.04.09.2004|Boronglamu
73.04.09.2005|Arungkeke Pallantikang
73.04.09.2006|Kalumpangloe
73.04.09.2007|Kampala
73.04.10.2001|Rumbia
73.04.10.2002|Lebangmanai
$wilayah$, E'\r?\n') as baris
  where baris <> ''
) as d
order by length(kode), kode
on conflict (kode) do update
  set nama = excluded.nama, tingkat = excluded.tingkat, induk_kode = excluded.induk_kode;
