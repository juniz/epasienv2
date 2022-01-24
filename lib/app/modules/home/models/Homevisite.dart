// To parse this JSON data, do
//
//     final homeVisiteModel = homeVisiteModelFromJson(jsonString);

import 'dart:convert';

HomeVisiteModel homeVisiteModelFromJson(String str) =>
    HomeVisiteModel.fromJson(json.decode(str));

String homeVisiteModelToJson(HomeVisiteModel data) =>
    json.encode(data.toJson());

class HomeVisiteModel {
  HomeVisiteModel({
    this.noRkmMedis,
    this.tanggalBooking,
    this.tanggalPemeriksaan,
    this.kdDokter,
    this.status,
    this.nmDokter,
  });

  String? noRkmMedis;
  DateTime? tanggalBooking;
  DateTime? tanggalPemeriksaan;
  String? kdDokter;
  String? status;
  String? nmDokter;

  factory HomeVisiteModel.fromJson(Map<String, dynamic> json) =>
      HomeVisiteModel(
        noRkmMedis: json["no_rkm_medis"],
        tanggalBooking: DateTime.parse(json["tanggal_booking"]),
        tanggalPemeriksaan: DateTime.parse(json["tanggal_pemeriksaan"]),
        kdDokter: json["kd_dokter"],
        status: json["status"],
        nmDokter: json["nm_dokter"],
      );

  Map<String, dynamic> toJson() => {
        "no_rkm_medis": noRkmMedis,
        "tanggal_booking":
            "${tanggalBooking!.year.toString().padLeft(4, '0')}-${tanggalBooking!.month.toString().padLeft(2, '0')}-${tanggalBooking!.day.toString().padLeft(2, '0')}",
        "tanggal_pemeriksaan":
            "${tanggalPemeriksaan!.year.toString().padLeft(4, '0')}-${tanggalPemeriksaan!.month.toString().padLeft(2, '0')}-${tanggalPemeriksaan!.day.toString().padLeft(2, '0')}",
        "kd_dokter": kdDokter,
        "status": status,
        "nm_dokter": nmDokter,
      };
}
