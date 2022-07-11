// To parse this JSON data, do
//
//     final jadwalPoliklinikModel = jadwalPoliklinikModelFromJson(jsonString);

import 'dart:convert';

List<JadwalPoliklinikModel> jadwalPoliklinikModelFromJson(String str) =>
    List<JadwalPoliklinikModel>.from(
        json.decode(str).map((x) => JadwalPoliklinikModel.fromJson(x)));

String jadwalPoliklinikModelToJson(List<JadwalPoliklinikModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JadwalPoliklinikModel {
  JadwalPoliklinikModel({
    this.nmDokter,
    this.kdDokter,
    this.nmPoli,
    this.kdPoli,
    this.jamMulai,
    this.jamSelesai,
    this.hariKerja,
    this.photo,
  });

  String? nmDokter;
  String? kdDokter;
  String? nmPoli;
  String? kdPoli;
  String? jamMulai;
  String? jamSelesai;
  String? hariKerja;
  String? photo;

  factory JadwalPoliklinikModel.fromJson(Map<String, dynamic> json) =>
      JadwalPoliklinikModel(
        nmDokter: json["nm_dokter"],
        kdDokter: json["kd_dokter"],
        nmPoli: json["nm_poli"],
        kdPoli: json["kd_poli"],
        jamMulai: json["jam_mulai"],
        jamSelesai: json["jam_selesai"],
        hariKerja: json["hari_kerja"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "nm_dokter": nmDokter,
        "nm_poli": nmPoli,
        "jam_mulai": jamMulai,
        "jam_selesai": jamSelesai,
        "hari_kerja": hariKerja,
        "photo": photo,
      };
}
