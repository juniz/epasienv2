// To parse this JSON data, do
//
//     final riwayatPemeriksaanModel = riwayatPemeriksaanModelFromJson(jsonString);

import 'dart:convert';

List<RiwayatPemeriksaanModel> riwayatPemeriksaanModelFromJson(String str) =>
    List<RiwayatPemeriksaanModel>.from(
        json.decode(str).map((x) => RiwayatPemeriksaanModel.fromJson(x)));

String riwayatPemeriksaanModelToJson(List<RiwayatPemeriksaanModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RiwayatPemeriksaanModel {
  RiwayatPemeriksaanModel({
    this.noRawat,
    this.tglRegistrasi,
    this.nmDokter,
    this.nmPoli,
    this.statusLanjut,
  });

  String? noRawat;
  DateTime? tglRegistrasi;
  String? nmDokter;
  String? nmPoli;
  String? statusLanjut;

  factory RiwayatPemeriksaanModel.fromJson(Map<String, dynamic> json) =>
      RiwayatPemeriksaanModel(
        noRawat: json["no_rawat"],
        tglRegistrasi: DateTime.parse(json["tgl_registrasi"]),
        nmDokter: json["nm_dokter"],
        nmPoli: json["nm_poli"],
        statusLanjut: json["status_lanjut"],
      );

  Map<String, dynamic> toJson() => {
        "no_rawat": noRawat,
        "tgl_registrasi":
            "${tglRegistrasi!.year.toString().padLeft(4, '0')}-${tglRegistrasi!.month.toString().padLeft(2, '0')}-${tglRegistrasi!.day.toString().padLeft(2, '0')}",
        "nm_dokter": nmDokter,
        "nm_poli": nmPoli,
        "status_lanjut": statusLanjut,
      };
}
