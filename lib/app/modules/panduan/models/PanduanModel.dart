// To parse this JSON data, do
//
//     final panduanModel = panduanModelFromJson(jsonString);

import 'dart:convert';

List<PanduanModel> panduanModelFromJson(String str) => List<PanduanModel>.from(
    json.decode(str).map((x) => PanduanModel.fromJson(x)));

String panduanModelToJson(List<PanduanModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PanduanModel {
  PanduanModel({
    this.id,
    this.judul,
    this.deskripsi,
  });

  String? id;
  String? judul;
  String? deskripsi;

  factory PanduanModel.fromJson(Map<String, dynamic> json) => PanduanModel(
        id: json["id"],
        judul: json["judul"],
        deskripsi: json["deskripsi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "deskripsi": deskripsi,
      };
}
