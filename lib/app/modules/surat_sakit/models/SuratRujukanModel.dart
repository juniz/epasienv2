// To parse this JSON data, do
//
//     final suratRujukanModel = suratRujukanModelFromJson(jsonString);

import 'dart:convert';

List<SuratRujukanModel> suratRujukanModelFromJson(String str) =>
    List<SuratRujukanModel>.from(
        json.decode(str).map((x) => SuratRujukanModel.fromJson(x)));

String suratRujukanModelToJson(List<SuratRujukanModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SuratRujukanModel {
  SuratRujukanModel({
    this.noRujuk,
    this.rujukKe,
    this.tglRujuk,
    this.keteranganDiagnosa,
    this.nmDokter,
  });

  String? noRujuk;
  String? rujukKe;
  String? tglRujuk;
  String? keteranganDiagnosa;
  String? nmDokter;

  factory SuratRujukanModel.fromJson(Map<String, dynamic> json) =>
      SuratRujukanModel(
        noRujuk: json["no_rujuk"],
        rujukKe: json["rujuk_ke"],
        tglRujuk: json["tgl_rujuk"],
        keteranganDiagnosa: json["keterangan_diagnosa"],
        nmDokter: json["nm_dokter"],
      );

  Map<String, dynamic> toJson() => {
        "no_rujuk": noRujuk,
        "rujuk_ke": rujukKe,
        "tgl_rujuk": tglRujuk,
        "keterangan_diagnosa": keteranganDiagnosa,
        "nm_dokter": nmDokter,
      };
}
