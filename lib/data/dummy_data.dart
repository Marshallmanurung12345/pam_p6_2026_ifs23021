// lib/data/dummy_data.dart

import 'models/plant_model.dart';

/// Kelas untuk menyimpan data statis (dummy)
/// Menggunakan static method agar tidak perlu instansiasi
class DummyData {
  DummyData._();

  static List<PlantModel> getPlantsData() {
    return const [
      PlantModel(
        nama: 'Bawang Merah',
        gambar: 'assets/images/img_bawang_merah.png',
        deskripsi: 'Bawang merah adalah umbi yang banyak digunakan sebagai bumbu dapur dan memiliki aroma kuat.',
        manfaat: 'Membantu meningkatkan daya tahan tubuh, mengurangi peradangan, dan mendukung kesehatan jantung.',
        efekSamping: 'Dapat menyebabkan iritasi mata dan gangguan pencernaan jika dikonsumsi berlebihan.',
      ),
      PlantModel(
        nama: 'Bawang Putih',
        gambar: 'assets/images/img_bawang_putih.png',
        deskripsi: 'Bawang putih merupakan tanaman umbi dengan aroma khas yang sering digunakan sebagai bumbu dasar.',
        manfaat: 'Mendukung kesehatan jantung, membantu meningkatkan imunitas, dan memiliki efek antibakteri alami.',
        efekSamping: 'Dapat menyebabkan bau mulut, mulas, dan iritasi lambung ketika konsumsi berlebih.',
      ),
      PlantModel(
        nama: 'Brokoli',
        gambar: 'assets/images/img_brokoli.png',
        deskripsi: 'Brokoli adalah sayuran hijau yang kaya vitamin, mineral, dan serat.',
        manfaat: 'Membantu detoksifikasi, menjaga kesehatan mata, dan mendukung sistem kekebalan tubuh.',
        efekSamping: 'Dapat menyebabkan kembung dan gas pada beberapa orang.',
      ),
      PlantModel(
        nama: 'Cabai',
        gambar: 'assets/images/img_cabai.png',
        deskripsi: 'Cabai adalah buah pedas yang sering digunakan untuk menambah rasa pada makanan.',
        manfaat: 'Meningkatkan metabolisme, membantu peredaran darah, dan kaya vitamin C.',
        efekSamping: 'Dapat menyebabkan iritasi lambung, heartburn, dan diare jika terlalu banyak.',
      ),
      PlantModel(
        nama: 'Kentang',
        gambar: 'assets/images/img_kentang.png',
        deskripsi: 'Kentang adalah umbi yang menjadi sumber karbohidrat dan energi.',
        manfaat: 'Memberikan energi, mendukung pencernaan, dan kaya vitamin B serta kalium.',
        efekSamping: 'Jika digoreng dapat meningkatkan kalori dan risiko kenaikan berat badan.',
      ),
      PlantModel(
        nama: 'Kol',
        gambar: 'assets/images/img_kol.png',
        deskripsi: 'Kol adalah sayuran daun yang banyak digunakan dalam masakan Asia.',
        manfaat: 'Membantu pencernaan, kaya vitamin C dan K, serta menjaga kesehatan kulit.',
        efekSamping: 'Dapat menyebabkan gas dan perut kembung bila dikonsumsi berlebihan.',
      ),
      PlantModel(
        nama: 'Terong',
        gambar: 'assets/images/img_terong.png',
        deskripsi: 'Terong adalah sayuran berwarna ungu atau hijau dengan tekstur lembut.',
        manfaat: 'Membantu mengontrol kadar gula darah, menjaga kesehatan jantung, dan kaya antioksidan.',
        efekSamping: 'Pada beberapa orang dapat menyebabkan alergi ringan atau gangguan pencernaan.',
      ),
      PlantModel(
        nama: 'Mentimun',
        gambar: 'assets/images/img_mentimun.png',
        deskripsi: 'Mentimun adalah buah yang kaya air dan sering digunakan sebagai lalapan atau bahan salad.',
        manfaat: 'Membantu hidrasi, menjaga kesehatan kulit, dan mendukung pencernaan.',
        efekSamping: 'Bila terlalu banyak dapat menyebabkan sering buang air kecil atau kembung.',
      ),
      PlantModel(
        nama: 'Tomat',
        gambar: 'assets/images/img_tomat.png',
        deskripsi: 'Tomat adalah buah yang banyak digunakan dalam masakan dan kaya antioksidan.',
        manfaat: 'Mendukung kesehatan mata, menjaga kesehatan jantung, dan baik untuk kulit.',
        efekSamping: 'Dapat menyebabkan asam lambung meningkat pada beberapa orang.',
      ),
      PlantModel(
        nama: 'Wortel',
        gambar: 'assets/images/img_wortel.png',
        deskripsi: 'Wortel adalah sayuran berwarna oranye yang kaya beta-karoten.',
        manfaat: 'Membantu menjaga kesehatan mata, meningkatkan imunitas, dan baik untuk kulit.',
        efekSamping: 'Konsumsi berlebihan dapat membuat kulit agak kekuningan (karotenemia).',
      ),
    ];
  }
}