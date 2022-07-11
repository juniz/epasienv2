// To parse this JSON data, do
//
//     final radiologiModel = radiologiModelFromJson(jsonString);

import 'dart:convert';

List<RadiologiModel> radiologiModelFromJson(String str) =>
    List<RadiologiModel>.from(
        json.decode(str).map((x) => RadiologiModel.fromJson(x)));

String radiologiModelToJson(List<RadiologiModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RadiologiModel {
  RadiologiModel({
    this.nmPerawatan,
    this.totalByr,
    this.kelas,
  });

  String? nmPerawatan;
  String? totalByr;
  String? kelas;

  factory RadiologiModel.fromJson(Map<String, dynamic> json) => RadiologiModel(
        nmPerawatan: json["nm_perawatan"],
        totalByr: json["total_byr"],
        kelas: json["kelas"],
      );

  Map<String, dynamic> toJson() => {
        "nm_perawatan": nmPerawatan,
        "total_byr": totalByr,
        "kelas": kelas,
      };
}
