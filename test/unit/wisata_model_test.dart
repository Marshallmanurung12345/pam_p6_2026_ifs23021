// test/unit/wisata_model_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:pam_p6_2026_ifs23021/data/models/wisata_model.dart';

void main() {
  group('WisataModel', () {
    const wisata = WisataModel(
      nama: 'Danau Sidihoni',
      gambar: 'assets/images/sidihoni.jpg',
      deskripsi: 'Danau di dalam danau di Pulau Samosir.',
      lokasi: 'Kecamatan Ronggur Nihuta, Samosir',
      kategori: 'Danau & Alam',
      jamBuka: '07.00 – 18.00 WIB',
      tiketMasuk: 'Rp 5.000 per orang',
    );

    test('membuat objek dengan semua field yang benar', () {
      expect(wisata.nama, equals('Danau Sidihoni'));
      expect(wisata.gambar, equals('assets/images/sidihoni.jpg'));
      expect(wisata.deskripsi, equals('Danau di dalam danau di Pulau Samosir.'));
      expect(wisata.lokasi, equals('Kecamatan Ronggur Nihuta, Samosir'));
      expect(wisata.kategori, equals('Danau & Alam'));
      expect(wisata.jamBuka, equals('07.00 – 18.00 WIB'));
      expect(wisata.tiketMasuk, equals('Rp 5.000 per orang'));
    });

    test('copyWith mengubah hanya field yang diberikan', () {
      final updated = wisata.copyWith(nama: 'Pantai Parbaba');
      expect(updated.nama, equals('Pantai Parbaba'));
      expect(updated.gambar, equals(wisata.gambar));
      expect(updated.deskripsi, equals(wisata.deskripsi));
      expect(updated.lokasi, equals(wisata.lokasi));
    });

    test('copyWith tanpa argumen menghasilkan objek yang identik', () {
      final copy = wisata.copyWith();
      expect(copy.nama, equals(wisata.nama));
      expect(copy.gambar, equals(wisata.gambar));
      expect(copy.kategori, equals(wisata.kategori));
    });

    test('dua objek dengan nama sama dianggap equal', () {
      const other = WisataModel(
        nama: 'Danau Sidihoni',
        gambar: 'assets/images/lain.jpg',
        deskripsi: 'Deskripsi berbeda.',
        lokasi: 'Lokasi lain.',
        kategori: 'Kategori lain',
        jamBuka: '09.00 – 16.00 WIB',
        tiketMasuk: 'Rp 20.000 per orang',
      );
      expect(wisata, equals(other));
    });

    test('dua objek dengan nama berbeda tidak equal', () {
      const other = WisataModel(
        nama: 'Batu Hoda',
        gambar: 'assets/images/sidihoni.jpg',
        deskripsi: 'Danau di dalam danau di Pulau Samosir.',
        lokasi: 'Kecamatan Ronggur Nihuta, Samosir',
        kategori: 'Danau & Alam',
        jamBuka: '07.00 – 18.00 WIB',
        tiketMasuk: 'Rp 5.000 per orang',
      );
      expect(wisata, isNot(equals(other)));
    });

    test('hashCode konsisten dengan equality', () {
      const same = WisataModel(
        nama: 'Danau Sidihoni',
        gambar: 'assets/images/lain.jpg',
        deskripsi: '-',
        lokasi: '-',
        kategori: '-',
        jamBuka: '-',
        tiketMasuk: '-',
      );
      expect(wisata.hashCode, equals(same.hashCode));
    });

    test('toString menampilkan nama wisata', () {
      expect(wisata.toString(), contains('Danau Sidihoni'));
    });
  });
}
