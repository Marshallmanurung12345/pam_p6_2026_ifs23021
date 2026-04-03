// lib/data/models/wisata_model.dart

/// Model data untuk tempat wisata Samosir
class WisataModel {
  const WisataModel({
    required this.nama,
    required this.gambar,
    required this.deskripsi,
    required this.lokasi,
    required this.kategori,
    required this.jamBuka,
    required this.tiketMasuk,
  });

  final String nama;
  final String gambar; // Path asset, contoh: 'assets/images/batu hoda.jpg'
  final String deskripsi;
  final String lokasi;
  final String kategori;
  final String jamBuka;
  final String tiketMasuk;

  WisataModel copyWith({
    String? nama,
    String? gambar,
    String? deskripsi,
    String? lokasi,
    String? kategori,
    String? jamBuka,
    String? tiketMasuk,
  }) {
    return WisataModel(
      nama: nama ?? this.nama,
      gambar: gambar ?? this.gambar,
      deskripsi: deskripsi ?? this.deskripsi,
      lokasi: lokasi ?? this.lokasi,
      kategori: kategori ?? this.kategori,
      jamBuka: jamBuka ?? this.jamBuka,
      tiketMasuk: tiketMasuk ?? this.tiketMasuk,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WisataModel &&
          runtimeType == other.runtimeType &&
          nama == other.nama;

  @override
  int get hashCode => nama.hashCode;

  @override
  String toString() => 'WisataModel(nama: $nama)';
}
