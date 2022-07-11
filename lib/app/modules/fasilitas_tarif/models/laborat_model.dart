// To parse this JSON data, do
//
//     final laboratModel = laboratModelFromJson(jsonString);

import 'dart:convert';

List<LaboratModel> laboratModelFromJson(String str) => List<LaboratModel>.from(
    json.decode(str).map((x) => LaboratModel.fromJson(x)));

String laboratModelToJson(List<LaboratModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LaboratModel {
  LaboratModel({
    this.kdJenisPrw,
    this.nmPerawatan,
    this.totalByr,
    this.kelas,
  });

  String? kdJenisPrw;
  String? nmPerawatan;
  String? totalByr;
  String? kelas;

  factory LaboratModel.fromJson(Map<String, dynamic> json) => LaboratModel(
        kdJenisPrw: json["kd_jenis_prw"],
        nmPerawatan: json["nm_perawatan"],
        totalByr: json["total_byr"],
        kelas: json["kelas"],
      );

  Map<String, dynamic> toJson() => {
        "kd_jenis_prw": kdJenisPrw,
        "nm_perawatan": nmPerawatan,
        "total_byr": totalByr,
        "kelas": kelas,
      };
}
