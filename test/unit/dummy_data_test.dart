// test/unit/dummy_data_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:pam_p6_2026_ifs18005/data/dummy_data.dart';
import 'package:pam_p6_2026_ifs18005/data/models/plant_model.dart';

void main() {
  group('DummyData.getPlantsData()', () {
    late List<PlantModel> plants;

    setUp(() {
      plants = DummyData.getPlantsData();
    });

    test('mengembalikan list yang tidak kosong', () {
      expect(plants, isNotEmpty);
    });

    test('mengembalikan minimal 10 tanaman', () {
      expect(plants.length, greaterThanOrEqualTo(10));
    });

    test('semua tanaman memiliki nama yang tidak kosong', () {
      for (final plant in plants) {
        expect(plant.nama, isNotEmpty,
            reason: 'Nama tidak boleh kosong untuk: ${plant.nama}');
      }
    });

    test('semua tanaman memiliki path gambar yang valid', () {
      for (final plant in plants) {
        expect(plant.gambar, startsWith('assets/images/'),
            reason: 'Path gambar tidak valid untuk: ${plant.nama}');
        expect(plant.gambar, endsWith('.png'),
            reason: 'Gambar harus berformat .png untuk: ${plant.nama}');
      }
    });

    test('semua tanaman memiliki deskripsi yang tidak kosong', () {
      for (final plant in plants) {
        expect(plant.deskripsi, isNotEmpty,
            reason: 'Deskripsi kosong untuk: ${plant.nama}');
      }
    });

    test('tidak ada nama tanaman yang duplikat', () {
      final namaList = plants.map((p) => p.nama).toList();
      final namaSet = namaList.toSet();
      expect(namaSet.length, equals(namaList.length),
          reason: 'Ditemukan nama tanaman yang duplikat');
    });

    test('data "Wortel" terdapat dalam list', () {
      final wortel = plants.where((p) => p.nama == 'Wortel').firstOrNull;
      expect(wortel, isNotNull);
      expect(wortel!.gambar, contains('wortel'));
    });

    test('filter pencarian berdasarkan nama bekerja dengan benar', () {
      final hasil = plants
          .where((p) => p.nama.toLowerCase().contains('bawang'))
          .toList();
      expect(hasil.length, equals(2)); // Bawang Merah & Bawang Putih
    });

    test('memanggil getPlantsData dua kali menghasilkan data yang sama', () {
      final plants2 = DummyData.getPlantsData();
      expect(plants.length, equals(plants2.length));
      for (int i = 0; i < plants.length; i++) {
        expect(plants[i].nama, equals(plants2[i].nama));
      }
    });
  });
}