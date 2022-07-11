// To parse this JSON data, do
//
//     final statistikPasienModel = statistikPasienModelFromJson(jsonString);

import 'dart:convert';

List<StatistikPasienModel> statistikPasienModelFromJson(String str) =>
    List<StatistikPasienModel>.from(
        json.decode(str).map((x) => StatistikPasienModel.fromJson(x)));

String statistikPasienModelToJson(List<StatistikPasienModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StatistikPasienModel {
  StatistikPasienModel({
    this.kunjungan,
    this.rajal,
    this.ranap,
    this.bulan,
  });

  String? kunjungan;
  String? rajal;
  String? ranap;
  String? bulan;

  factory StatistikPasienModel.fromJson(Map<String, dynamic> json) =>
      StatistikPasienModel(
        kunjungan: json["kunjungan"],
        rajal: json["rajal"],
        ranap: json["ranap"],
        bulan: json["bulan"],
      );

  Map<String, dynamic> toJson() => {
        "kunjungan": kunjungan,
        "rajal": rajal,
        "ranap": ranap,
        "bulan": bulan,
      };
}
