// lib/data/dummy_data.dart

import 'models/wisata_model.dart';

/// Kelas untuk menyimpan data statis (dummy) wisata Samosir
class DummyData {
  DummyData._();

  static List<WisataModel> getWisataData() {
    return const [
      WisataModel(
        nama: 'Batu Hoda',
        gambar: 'assets/images/batu hoda.jpg',
        deskripsi:
            'Batu Hoda adalah pantai indah di Pulau Samosir yang memiliki pasir putih bersih dan air danau yang jernih. Pantai ini menjadi salah satu destinasi favorit wisatawan karena keindahan alamnya yang memukau dengan latar belakang perbukitan hijau Samosir.',
        lokasi: 'Kecamatan Simanindo, Samosir, Sumatera Utara',
        kategori: 'Pantai & Danau',
        jamBuka: '07.00 – 18.00 WIB',
        tiketMasuk: 'Rp 5.000 per orang',
      ),
      WisataModel(
        nama: 'Bukit Holbung',
        gambar: 'assets/images/bukit holbung.jpg',
        deskripsi:
            'Bukit Holbung menawarkan pemandangan spektakuler Danau Toba dari ketinggian. Hamparan padang rumput hijau dengan pemandangan danau yang luas menjadikan tempat ini surga tersembunyi di Samosir. Cocok untuk hiking dan menikmati sunrise maupun sunset yang menakjubkan.',
        lokasi: 'Desa Huta Tinggi, Pangururan, Samosir',
        kategori: 'Bukit & Alam',
        jamBuka: '06.00 – 18.00 WIB',
        tiketMasuk: 'Rp 10.000 per orang',
      ),
      WisataModel(
        nama: 'Desa Tomok',
        gambar: 'assets/images/desa tomok.jpg',
        deskripsi:
            'Desa Tomok adalah desa wisata bersejarah yang menyimpan kekayaan budaya Batak Toba. Di sini terdapat makam Raja Sidabutar yang berusia ratusan tahun, museum, dan pertunjukan Sigale-gale — boneka kayu mistis yang dapat menari. Desa ini juga terkenal dengan pasar souvenir kerajinan Batak.',
        lokasi: 'Kecamatan Simanindo, Samosir',
        kategori: 'Budaya & Sejarah',
        jamBuka: '08.00 – 17.00 WIB',
        tiketMasuk: 'Rp 10.000 per orang',
      ),
      WisataModel(
        nama: 'Air Terjun Efrata',
        gambar: 'assets/images/efrata.jpg',
        deskripsi:
            'Air Terjun Efrata adalah air terjun cantik yang tersembunyi di kawasan perbukitan Samosir. Aliran air yang jernih dan segar mengalir di antara bebatuan dan pepohonan tropis yang rindang. Perjalanan menuju air terjun ini pun menjadi petualangan tersendiri melalui jalur alam yang asri.',
        lokasi: 'Kecamatan Pangururan, Samosir',
        kategori: 'Air Terjun',
        jamBuka: '08.00 – 17.00 WIB',
        tiketMasuk: 'Rp 10.000 per orang',
      ),
      WisataModel(
        nama: 'Huta Bolon Simanindo',
        gambar: 'assets/images/huta bolon.jpg',
        deskripsi:
            'Huta Bolon Simanindo adalah museum terbuka yang menampilkan rumah adat Batak Toba berusia ratusan tahun. Kompleks ini merupakan bekas istana Raja Sidauruk yang kini difungsikan sebagai museum budaya. Pengunjung dapat menyaksikan pertunjukan tari Tor-Tor dan musik gondang Batak yang meriah.',
        lokasi: 'Desa Simanindo, Kecamatan Simanindo, Samosir',
        kategori: 'Budaya & Sejarah',
        jamBuka: '09.00 – 17.00 WIB',
        tiketMasuk: 'Rp 20.000 per orang',
      ),
      WisataModel(
        nama: 'Kursi Batu Batak',
        gambar: 'assets/images/kursi batu.jpg',
        deskripsi:
            'Kursi Batu adalah situs sejarah peninggalan adat Batak Toba berupa kursi batu kuno yang digunakan dalam upacara adat dan musyawarah raja-raja Batak zaman dahulu. Situs ini menjadi bukti nyata tingginya peradaban masyarakat Batak dan menjadi daya tarik wisata budaya yang unik.',
        lokasi: 'Desa Ambarita, Kecamatan Simanindo, Samosir',
        kategori: 'Budaya & Sejarah',
        jamBuka: '08.00 – 17.00 WIB',
        tiketMasuk: 'Rp 10.000 per orang',
      ),
      WisataModel(
        nama: 'Pantai Parbaba',
        gambar: 'assets/images/parbaba.jpg',
        deskripsi:
            'Pantai Parbaba dikenal sebagai pantai paling bersih dan indah di Pulau Samosir. Pasir putihnya yang lembut dan air Danau Toba yang biru jernih menjadikannya tempat sempurna untuk bersantai, berenang, dan bermain air. Tersedia berbagai fasilitas wisata air seperti banana boat dan perahu.',
        lokasi: 'Desa Parbaba, Kecamatan Pangururan, Samosir',
        kategori: 'Pantai & Danau',
        jamBuka: '07.00 – 18.00 WIB',
        tiketMasuk: 'Rp 10.000 per orang',
      ),
      WisataModel(
        nama: 'Pulau Malau',
        gambar: 'assets/images/pulau malau.jpg',
        deskripsi:
            'Pulau Malau adalah pulau kecil eksotis yang berada di dalam Danau Toba, menjadikannya pulau di dalam pulau yang langka di dunia. Keindahan alamnya yang masih alami dengan air danau yang tenang dan bening menawarkan pengalaman wisata bahari yang tak terlupakan.',
        lokasi: 'Perairan Danau Toba, Samosir',
        kategori: 'Pulau & Danau',
        jamBuka: '07.00 – 17.00 WIB',
        tiketMasuk: 'Rp 15.000 per orang',
      ),
      WisataModel(
        nama: 'Air Terjun Sampuran',
        gambar: 'assets/images/sampuran.jpg',
        deskripsi:
            'Air Terjun Sampuran atau Sampuran Efrata adalah salah satu air terjun tertinggi dan terindah di Samosir. Debit airnya yang deras menciptakan kabut air yang menyejukkan di sekitarnya. Dikelilingi hutan tropis yang lebat, air terjun ini menjadi surga bagi para pecinta alam dan fotografi.',
        lokasi: 'Kecamatan Sianjur Mula-Mula, Samosir',
        kategori: 'Air Terjun',
        jamBuka: '08.00 – 17.00 WIB',
        tiketMasuk: 'Rp 5.000 per orang',
      ),
      WisataModel(
        nama: 'Danau Sidihoni',
        gambar: 'assets/images/sidihoni.jpg',
        deskripsi:
            'Danau Sidihoni adalah danau vulkanik yang berada di atas Pulau Samosir, menjadikannya fenomena unik yaitu danau di dalam danau (Danau Toba). Dikelilingi padang rumput hijau dan suasana yang sunyi, danau ini menawarkan ketenangan dan keindahan alam yang sulit ditemukan di tempat lain.',
        lokasi: 'Desa Saitnihuta, Kecamatan Ronggur Nihuta, Samosir',
        kategori: 'Danau & Alam',
        jamBuka: '07.00 – 18.00 WIB',
        tiketMasuk: 'Rp 5.000 per orang',
      ),
    ];
  }
}
