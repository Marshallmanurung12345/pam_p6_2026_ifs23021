// lib/data/models/plant_model.dart

/// Model data untuk tanaman
/// Menggunakan immutable class (best practice Flutter/Dart)
class PlantModel {
  const PlantModel({
    required this.nama,
    required this.gambar,
    required this.deskripsi,
    required this.manfaat,
    required this.efekSamping,
  });

  final String nama;
  final String gambar; // Path asset, contoh: 'assets/images/img_kol.png'
  final String deskripsi;
  final String manfaat;
  final String efekSamping;

  /// Metode copyWith memudahkan pembuatan objek baru dengan data yang diubah sebagian
  PlantModel copyWith({
    String? nama,
    String? gambar,
    String? deskripsi,
    String? manfaat,
    String? efekSamping,
  }) {
    return PlantModel(
      nama: nama ?? this.nama,
      gambar: gambar ?? this.gambar,
      deskripsi: deskripsi ?? this.deskripsi,
      manfaat: manfaat ?? this.manfaat,
      efekSamping: efekSamping ?? this.efekSamping,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PlantModel && runtimeType == other.runtimeType && nama == other.nama;

  @override
  int get hashCode => nama.hashCode;

  @override
  String toString() => 'PlantModel(nama: $nama)';
}