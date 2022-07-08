// To parse this JSON data, do
//
//     final setting = settingFromJson(jsonString);

import 'dart:convert';

Setting settingFromJson(String str) => Setting.fromJson(json.decode(str));

String settingToJson(Setting data) => json.encode(data.toJson());

class Setting {
  Setting({
    this.meta,
    this.data,
  });

  Meta? meta;
  SettingData? data;

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
        meta: Meta.fromJson(json["meta"]),
        data: SettingData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data?.toJson(),
      };
}

class SettingData {
  SettingData({
    this.namaInstansi,
    this.alamatInstansi,
    this.kabupaten,
    this.kontak,
    this.email,
  });

  String? namaInstansi;
  String? alamatInstansi;
  String? kabupaten;
  String? kontak;
  String? email;

  factory SettingData.fromJson(Map<String, dynamic> json) => SettingData(
        namaInstansi: json["nama_instansi"],
        alamatInstansi: json["alamat_instansi"],
        kabupaten: json["kabupaten"],
        kontak: json["kontak"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "nama_instansi": namaInstansi,
        "alamat_instansi": alamatInstansi,
        "kabupaten": kabupaten,
        "kontak": kontak,
        "email": email,
      };
}

class Meta {
  Meta({
    this.code,
    this.message,
  });

  int? code;
  String? message;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}
