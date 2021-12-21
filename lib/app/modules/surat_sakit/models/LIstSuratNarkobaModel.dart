// To parse this JSON data, do
//
//     final listSuratNarkobaModel = listSuratNarkobaModelFromJson(jsonString);

import 'dart:convert';

List<ListSuratNarkobaModel> listSuratNarkobaModelFromJson(String str) =>
    List<ListSuratNarkobaModel>.from(
        json.decode(str).map((x) => ListSuratNarkobaModel.fromJson(x)));

String listSuratNarkobaModelToJson(List<ListSuratNarkobaModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListSuratNarkobaModel {
  ListSuratNarkobaModel({
    this.noSurat,
    this.noRawat,
    this.tanggalsurat,
    this.kategori,
    this.keperluan,
    this.nmDokter,
  });

  String? noSurat;
  String? noRawat;
  String? tanggalsurat;
  String? kategori;
  String? keperluan;
  String? nmDokter;

  factory ListSuratNarkobaModel.fromJson(Map<String, dynamic> json) =>
      ListSuratNarkobaModel(
        noSurat: json["no_surat"],
        noRawat: json["no_rawat"],
        tanggalsurat: json["tanggalsurat"],
        kategori: json["kategori"],
        keperluan: json["keperluan"],
        nmDokter: json["nm_dokter"],
      );

  Map<String, dynamic> toJson() => {
        "no_surat": noSurat,
        "no_rawat": noRawat,
        "tanggalsurat": tanggalsurat,
        "kategori": kategori,
        "keperluan": keperluan,
        "nm_dokter": nmDokter,
      };
}
