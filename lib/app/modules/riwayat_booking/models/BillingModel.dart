// To parse this JSON data, do
//
//     final billingModel = billingModelFromJson(jsonString);

import 'dart:convert';

List<BillingModel> billingModelFromJson(String str) => List<BillingModel>.from(
    json.decode(str).map((x) => BillingModel.fromJson(x)));

String billingModelToJson(List<BillingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BillingModel {
  BillingModel({
    this.no,
    this.nmPerawatan,
    this.satu,
    this.dua,
    this.tiga,
    this.empat,
    this.pemisah,
    this.status,
  });

  String? no;
  String? nmPerawatan;
  dynamic satu;
  dynamic dua;
  dynamic tiga;
  dynamic empat;
  String? pemisah;
  String? status;

  factory BillingModel.fromJson(Map<String, dynamic> json) => BillingModel(
        no: json["no"],
        nmPerawatan: json["nm_perawatan"],
        satu: json["satu"],
        dua: json["dua"],
        tiga: json["tiga"],
        empat: json["empat"],
        pemisah: json["pemisah"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "no": no,
        "nm_perawatan": nmPerawatan,
        "satu": satu,
        "dua": dua,
        "tiga": tiga,
        "empat": empat,
        "pemisah": pemisah,
        "status": status,
      };
}
