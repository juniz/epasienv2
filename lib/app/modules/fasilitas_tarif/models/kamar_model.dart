// To parse this JSON data, do
//
//     final kamarModel = kamarModelFromJson(jsonString);

import 'dart:convert';

List<KamarModel> kamarModelFromJson(String str) =>
    List<KamarModel>.from(json.decode(str).map((x) => KamarModel.fromJson(x)));

String kamarModelToJson(List<KamarModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KamarModel {
  KamarModel({
    this.kdKamar,
    this.nmBangsal,
    this.kelas,
    this.trfKamar,
    this.status,
  });

  String? kdKamar;
  String? nmBangsal;
  String? kelas;
  String? trfKamar;
  String? status;

  factory KamarModel.fromJson(Map<String, dynamic> json) => KamarModel(
        kdKamar: json["kd_kamar"],
        nmBangsal: json["nm_bangsal"],
        kelas: json["kelas"],
        trfKamar: json["trf_kamar"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "kd_kamar": kdKamar,
        "nm_bangsal": nmBangsal,
        "kelas": kelas,
        "trf_kamar": trfKamar,
        "status": status,
      };
}
