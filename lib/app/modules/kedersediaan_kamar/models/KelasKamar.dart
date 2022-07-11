// To parse this JSON data, do
//
//     final kelasKamarModel = kelasKamarModelFromJson(jsonString);

import 'dart:convert';

List<KelasKamarModel> kelasKamarModelFromJson(String str) =>
    List<KelasKamarModel>.from(
        json.decode(str).map((x) => KelasKamarModel.fromJson(x)));

String kelasKamarModelToJson(List<KelasKamarModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KelasKamarModel {
  KelasKamarModel({
    this.kelas,
    this.total,
    this.isi,
    this.kosong,
  });

  String? kelas;
  String? total;
  String? isi;
  String? kosong;

  factory KelasKamarModel.fromJson(Map<String, dynamic> json) =>
      KelasKamarModel(
        kelas: json["kelas"],
        total: json["total"],
        isi: json["isi"],
        kosong: json["kosong"],
      );

  Map<String, dynamic> toJson() => {
        "kelas": kelas,
        "total": total,
        "isi": isi,
        "kosong": kosong,
      };
}
