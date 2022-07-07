// To parse this JSON data, do
//
//     final listPoliklinikModel = listPoliklinikModelFromJson(jsonString);

import 'dart:convert';

List<ListPoliklinikModel> listPoliklinikModelFromJson(String str) =>
    List<ListPoliklinikModel>.from(
        json.decode(str).map((x) => ListPoliklinikModel.fromJson(x)));

String listPoliklinikModelToJson(List<ListPoliklinikModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListPoliklinikModel {
  ListPoliklinikModel({
    this.kdPoli,
    this.nmPoli,
    this.registrasi,
    this.registrasilama,
    this.status,
  });

  String? kdPoli;
  String? nmPoli;
  String? registrasi;
  String? registrasilama;
  String? status;

  factory ListPoliklinikModel.fromJson(Map<String, dynamic> json) =>
      ListPoliklinikModel(
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
