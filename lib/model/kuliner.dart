import 'dart:convert';

class Kuliner {
  final String nama;
  final String instagram;
  final String alamat;
  final String telepon;
  final String foto;

  Kuliner(
      {required this.nama,
      required this.instagram,
      required this.alamat,
      required this.telepon,
      required this.foto});

  Kuliner copyWith(
      {String? nama, String? instagram, String? alamat, String? telepon, String? foto}) {
    return Kuliner(
        nama: nama ?? this.nama,
        instagram: instagram ?? this.instagram,
        alamat: alamat ?? this.alamat,
        telepon: telepon ?? this.telepon,
        foto: foto ?? this.foto);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nama': nama,
      'instagram': instagram,
      'alamat': alamat,
      'telepon': telepon,
      'foto': foto
    };
  }

  factory Kuliner.fromMap(Map<String, dynamic> map) {
    return Kuliner(
        nama: map['nama'] as String,
        instagram: map['instagram'] as String,
        alamat: map['alamat'] as String,
        telepon: map['telepon'] as String,
        foto: map['foto'] as String);
  }

  String toJson() => json.encode(toMap());

  factory Kuliner.fromJson(String source) =>
      Kuliner.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Kuliner(nama: $nama, instagram: $instagram, alamat: $alamat, telepon: $telepon, foto: $foto)';
  }

  @override
  bool operator ==(covariant Kuliner other) {
    if (identical(this, other)) return true;

    return other.nama == nama &&
        other.instagram == instagram &&
        other.alamat == alamat &&
        other.telepon == telepon &&
        other.foto == foto;
  }

  @override
  int get hashCode {
    return nama.hashCode ^
        instagram.hashCode ^
        alamat.hashCode ^
        telepon.hashCode ^
        foto.hashCode;
  }
}
