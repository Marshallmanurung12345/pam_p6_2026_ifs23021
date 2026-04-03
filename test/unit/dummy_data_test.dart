// test/unit/dummy_data_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:pam_p6_2026_ifs23021/data/dummy_data.dart';
import 'package:pam_p6_2026_ifs23021/data/models/wisata_model.dart';

void main() {
  group('DummyData.getWisataData()', () {
    late List<WisataModel> wisataList;

    setUp(() {
      wisataList = DummyData.getWisataData();
    });

    test('mengembalikan list yang tidak kosong', () {
      expect(wisataList, isNotEmpty);
    });

    test('mengembalikan minimal 10 destinasi wisata', () {
      expect(wisataList.length, greaterThanOrEqualTo(10));
    });

    test('semua wisata memiliki nama yang tidak kosong', () {
      for (final wisata in wisataList) {
        expect(wisata.nama, isNotEmpty,
            reason: 'Nama tidak boleh kosong untuk: ${wisata.nama}');
      }
    });

    test('semua wisata memiliki path gambar yang valid', () {
      for (final wisata in wisataList) {
        expect(wisata.gambar, startsWith('assets/images/'),
            reason: 'Path gambar tidak valid untuk: ${wisata.nama}');
      }
    });

    test('semua wisata memiliki deskripsi yang tidak kosong', () {
      for (final wisata in wisataList) {
        expect(wisata.deskripsi, isNotEmpty,
            reason: 'Deskripsi kosong untuk: ${wisata.nama}');
      }
    });

    test('semua wisata memiliki lokasi yang tidak kosong', () {
      for (final wisata in wisataList) {
        expect(wisata.lokasi, isNotEmpty,
            reason: 'Lokasi kosong untuk: ${wisata.nama}');
      }
    });

    test('semua wisata memiliki kategori yang tidak kosong', () {
      for (final wisata in wisataList) {
        expect(wisata.kategori, isNotEmpty,
            reason: 'Kategori kosong untuk: ${wisata.nama}');
      }
    });

    test('semua wisata memiliki jam buka yang tidak kosong', () {
      for (final wisata in wisataList) {
        expect(wisata.jamBuka, isNotEmpty,
            reason: 'Jam buka kosong untuk: ${wisata.nama}');
      }
    });

    test('semua wisata memiliki info tiket masuk', () {
      for (final wisata in wisataList) {
        expect(wisata.tiketMasuk, isNotEmpty,
            reason: 'Tiket masuk kosong untuk: ${wisata.nama}');
      }
    });

    test('tidak ada nama wisata yang duplikat', () {
      final namaList = wisataList.map((w) => w.nama).toList();
      final namaSet = namaList.toSet();
      expect(namaSet.length, equals(namaList.length),
          reason: 'Ditemukan nama wisata yang duplikat');
    });

    test('data "Danau Sidihoni" terdapat dalam list', () {
      final sidihoni =
          wisataList.where((w) => w.nama == 'Danau Sidihoni').firstOrNull;
      expect(sidihoni, isNotNull);
      expect(sidihoni!.gambar, contains('sidihoni'));
    });

    test('data "Pantai Parbaba" terdapat dalam list', () {
      final parbaba =
          wisataList.where((w) => w.nama == 'Pantai Parbaba').firstOrNull;
      expect(parbaba, isNotNull);
      expect(parbaba!.kategori, equals('Pantai & Danau'));
    });

    test('filter pencarian berdasarkan nama bekerja dengan benar', () {
      final hasil = wisataList
          .where((w) => w.nama.toLowerCase().contains('air terjun'))
          .toList();
      expect(hasil.length, greaterThanOrEqualTo(2));
    });

    test('memanggil getWisataData dua kali menghasilkan data yang sama', () {
      final wisataList2 = DummyData.getWisataData();
      expect(wisataList.length, equals(wisataList2.length));
      for (int i = 0; i < wisataList.length; i++) {
        expect(wisataList[i].nama, equals(wisataList2[i].nama));
      }
    });
  });
}
