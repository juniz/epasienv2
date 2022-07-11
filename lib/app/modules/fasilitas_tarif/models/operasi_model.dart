// To parse this JSON data, do
//
//     final operasiModel = operasiModelFromJson(jsonString);

import 'dart:convert';

List<OperasiModel> operasiModelFromJson(String str) => List<OperasiModel>.from(
    json.decode(str).map((x) => OperasiModel.fromJson(x)));

String operasiModelToJson(List<OperasiModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OperasiModel {
  OperasiModel({
    this.nmPerawatan,
    this.total,
    this.kelas,
  });

  String? nmPerawatan;
  String? total;
  String? kelas;

  factory OperasiModel.fromJson(Map<String, dynamic> json) => OperasiModel(
        nmPerawatan: json["nm_perawatan"],
        total: json["total"],
        kelas: json["kelas"],
      );

  Map<String, dynamic> toJson() => {
        "nm_perawatan": nmPerawatan,
        "total": total,
        "kelas": kelas,
      };
}
