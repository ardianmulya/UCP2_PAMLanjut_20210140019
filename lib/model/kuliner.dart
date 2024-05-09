import 'dart:convert';

import 'package:flutter/widgets.dart';

class Kuliner {
  int? id;
  final String nama;
  final String lokasi;
  final String deskripsi;
  final String foto;
  Kuliner({
    this.id,
    required this.nama,
    required this.lokasi,
    required this.deskripsi,
    required this.foto,
  });

  Kuliner copyWith({
    ValueGetter<int?>? id,
    String? nama,
    String? lokasi,
    String? deskripsi,
    String? foto,
  }) {
    return Kuliner(
      id: id != null ? id() : this.id,
      nama: nama ?? this.nama,
      lokasi: lokasi ?? this.lokasi,
      deskripsi: deskripsi ?? this.deskripsi,
      foto: foto ?? this.foto,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'lokasi': lokasi,
      'deskripsi': deskripsi,
      'foto': foto,
    };
  }

  factory Kuliner.fromMap(Map<String, dynamic> map) {
    return Kuliner(
      id: map['id']?.toInt(),
      nama: map['nama'] ?? '',
      lokasi: map['lokasi'] ?? '',
      deskripsi: map['deskripsi'] ?? '',
      foto: map['foto'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Kuliner.fromJson(String source) => Kuliner.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Kuliner(id: $id, nama: $nama, lokasi: $lokasi, deskripsi: $deskripsi, foto: $foto)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Kuliner &&
      other.id == id &&
      other.nama == nama &&
      other.lokasi == lokasi &&
      other.deskripsi == deskripsi &&
      other.foto == foto;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      nama.hashCode ^
      lokasi.hashCode ^
      deskripsi.hashCode ^
      foto.hashCode;
  }
}
