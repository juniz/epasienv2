// To parse this JSON data, do
//
//     final poliklinikModel = poliklinikModelFromJson(jsonString);

import 'dart:convert';

List<PoliklinikModel> poliklinikModelFromJson(String str) =>
    List<PoliklinikModel>.from(
        json.decode(str).map((x) => PoliklinikModel.fromJson(x)));

String poliklinikModelToJson(List<PoliklinikModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PoliklinikModel {
  PoliklinikModel({
    this.kdPoli,
    this.nmPoli,
    this.registrasi,
    this.registrasilama,
    this.status,
  });

  String? kdPoli;
  String? nmPoli;
  int? registrasi;
  int? registrasilama;
  String? status;

  factory PoliklinikModel.fromJson(Map<String, dynamic> json) =>
      PoliklinikModel(
        kdPoli: json["kd_poli"],
        nmPoli: json["nm_poli"],
        registrasi: json["registrasi"],
        registrasilama: json["registrasilama"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "kd_poli": kdPoli,
        "nm_poli": nmPoli,
        "registrasi": registrasi,
        "registrasilama": registrasilama,
        "status": status,
      };
}
