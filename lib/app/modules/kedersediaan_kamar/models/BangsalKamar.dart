// To parse this JSON data, do
//
//     final bangsalKamarModel = bangsalKamarModelFromJson(jsonString);

import 'dart:convert';

List<BangsalKamarModel> bangsalKamarModelFromJson(String str) =>
    List<BangsalKamarModel>.from(
        json.decode(str).map((x) => BangsalKamarModel.fromJson(x)));

String bangsalKamarModelToJson(List<BangsalKamarModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BangsalKamarModel {
  BangsalKamarModel({
    this.nmBangsal,
    this.kdBangsal,
    this.total,
    this.isi,
    this.kosong,
  });

  String? nmBangsal;
  String? kdBangsal;
  String? total;
  String? isi;
  String? kosong;

  factory BangsalKamarModel.fromJson(Map<String, dynamic> json) =>
      BangsalKamarModel(
        nmBangsal: json["nm_bangsal"],
        kdBangsal: json["kd_bangsal"],
        total: json["total"],
        isi: json["isi"],
        kosong: json["kosong"],
      );

  Map<String, dynamic> toJson() => {
        "nm_bangsal": nmBangsal,
        "kd_bangsal": kdBangsal,
        "total": total,
        "isi": isi,
        "kosong": kosong,
      };
}
