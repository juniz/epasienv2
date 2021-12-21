// To parse this JSON data, do
//
//     final jawabanPengaduanModel = jawabanPengaduanModelFromJson(jsonString);

import 'dart:convert';

List<JawabanPengaduanModel> jawabanPengaduanModelFromJson(String str) =>
    List<JawabanPengaduanModel>.from(
        json.decode(str).map((x) => JawabanPengaduanModel.fromJson(x)));

String jawabanPengaduanModelToJson(List<JawabanPengaduanModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JawabanPengaduanModel {
  JawabanPengaduanModel({
    this.id,
    this.dateTime,
    this.pengaduanId,
    this.username,
    this.message,
  });

  int? id;
  String? dateTime;
  int? pengaduanId;
  String? username;
  String? message;

  factory JawabanPengaduanModel.fromJson(Map<String, dynamic> json) =>
      JawabanPengaduanModel(
        id: json["id"],
        dateTime: json["date_time"],
        pengaduanId: json["pengaduan_id"],
        username: json["username"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date_time": dateTime,
        "pengaduan_id": pengaduanId,
        "username": username,
        "message": message,
      };
}
