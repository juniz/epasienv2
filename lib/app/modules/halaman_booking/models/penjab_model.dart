// To parse this JSON data, do
//
//     final penjabModel = penjabModelFromJson(jsonString);

import 'dart:convert';

List<PenjabModel> penjabModelFromJson(String str) => List<PenjabModel>.from(
    json.decode(str).map((x) => PenjabModel.fromJson(x)));

String penjabModelToJson(List<PenjabModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PenjabModel {
  PenjabModel({
    this.kdPj,
    this.pngJawab,
    this.namaPerusahaan,
    this.alamatAsuransi,
    this.noTelp,
    this.attn,
  });

  String? kdPj;
  String? pngJawab;
  String? namaPerusahaan;
  String? alamatAsuransi;
  String? noTelp;
  String? attn;

  factory PenjabModel.fromJson(Map<String, dynamic> json) => PenjabModel(
        kdPj: json["kd_pj"],
        pngJawab: json["png_jawab"],
        namaPerusahaan: json["nama_perusahaan"],
        alamatAsuransi: json["alamat_asuransi"],
        noTelp: json["no_telp"],
        attn: json["attn"],
      );

  Map<String, dynamic> toJson() => {
        "kd_pj": kdPj,
        "png_jawab": pngJawab,
        "nama_perusahaan": namaPerusahaan,
        "alamat_asuransi": alamatAsuransi,
        "no_telp": noTelp,
        "attn": attn,
      };
}
