// To parse this JSON data, do
//
//     final riwayatBookingModel = riwayatBookingModelFromJson(jsonString);

import 'dart:convert';

List<RiwayatBookingModel> riwayatBookingModelFromJson(String str) =>
    List<RiwayatBookingModel>.from(
        json.decode(str).map((x) => RiwayatBookingModel.fromJson(x)));

String riwayatBookingModelToJson(List<RiwayatBookingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

RiwayatBookingModel selectedRiwayatBookingModelFromJson(String str) =>
    RiwayatBookingModel.fromJson(json.decode(str));

class RiwayatBookingModel {
  RiwayatBookingModel({
    this.tanggalPeriksa,
    this.nmPoli,
    this.kdPoli,
    this.nmDokter,
    this.kdDokter,
    this.pngJawab,
    this.kdPJ,
    this.noReg,
    this.status,
  });

  DateTime? tanggalPeriksa;
  String? nmPoli;
  String? kdPoli;
  String? nmDokter;
  String? kdDokter;
  String? pngJawab;
  String? kdPJ;
  String? noReg;
  String? status;

  factory RiwayatBookingModel.fromJson(Map<String, dynamic> json) =>
      RiwayatBookingModel(
        tanggalPeriksa: DateTime.parse(json["tanggal_periksa"]),
        nmPoli: json["nm_poli"],
        kdPoli: json["kd_poli"],
        nmDokter: json["nm_dokter"],
        kdDokter: json["kd_dokter"],
        pngJawab: json["png_jawab"],
        kdPJ: json["kd_pj"],
        noReg: json["no_reg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "tanggal_periksa":
            "${tanggalPeriksa!.year.toString().padLeft(4, '0')}-${tanggalPeriksa!.month.toString().padLeft(2, '0')}-${tanggalPeriksa!.day.toString().padLeft(2, '0')}",
        "nm_poli": nmPoli,
        "nm_dokter": nmDokter,
        "png_jawab": pngJawab,
      };
}
