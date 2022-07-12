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
    this.id,
    this.pasienBaru,
    this.homevisite,
    this.photoDokter,
    this.telephone,
    this.maintance,
    this.appVer,
    this.buildVer,
  });

  String? id;
  String? pasienBaru;
  String? homevisite;
  String? photoDokter;
  String? telephone;
  String? maintance;
  String? appVer;
  String? buildVer;

  factory SettingData.fromJson(Map<String, dynamic> json) => SettingData(
        id: json["id"],
        pasienBaru: json["pasien_baru"],
        homevisite: json["homevisite"],
        photoDokter: json["photo_dokter"],
        telephone: json["telephone"],
        maintance: json["maintance"],
        appVer: json["app_ver"],
        buildVer: json["build_ver"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pasien_baru": pasienBaru,
        "homevisite": homevisite,
        "photo_dokter": photoDokter,
        "telephone": telephone,
        "maintance": maintance,
        "app_ver": appVer,
        "build_ver": buildVer,
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
