// To parse this JSON data, do
//
//     final suratSakitModel = suratSakitModelFromJson(jsonString);

import 'dart:convert';

List<SuratSakitModel> suratSakitModelFromJson(String str) =>
    List<SuratSakitModel>.from(
        json.decode(str).map((x) => SuratSakitModel.fromJson(x)));

String suratSakitModelToJson(List<SuratSakitModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SuratSakitModel {
  SuratSakitModel({
    this.noSurat,
    this.noRawat,
    this.tanggalawal,
    this.tanggalakhir,
    this.lamasakit,
    this.nmDokter,
  });

  String? noSurat;
  String? noRawat;
  String? tanggalawal;
  String? tanggalakhir;
  String? lamasakit;
  String? nmDokter;

  factory SuratSakitModel.fromJson(Map<String, dynamic> json) =>
      SuratSakitModel(
        noSurat: json["no_surat"],
        noRawat: json["no_rawat"],
        tanggalawal: json["tanggalawal"],
        tanggalakhir: json["tanggalakhir"],
        lamasakit: json["lamasakit"],
        nmDokter: json["nm_dokter"],
      );

  Map<String, dynamic> toJson() => {
        "no_surat": noSurat,
        "no_rawat": noRawat,
        "tanggalawal": tanggalawal,
        "tanggalakhir": tanggalakhir,
        "lamasakit": lamasakit,
        "nm_dokter": nmDokter,
      };
}
