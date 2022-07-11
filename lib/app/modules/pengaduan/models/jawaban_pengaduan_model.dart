// To parse this JSON data, do
//
//     final jawabanPengaduan = jawabanPengaduanFromJson(jsonString);

import 'dart:convert';

List<JawabanPengaduan> jawabanPengaduanFromJson(String str) =>
    List<JawabanPengaduan>.from(
        json.decode(str).map((x) => JawabanPengaduan.fromJson(x)));

String jawabanPengaduanToJson(List<JawabanPengaduan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JawabanPengaduan {
  JawabanPengaduan({
    this.id,
    this.dateTime,
    this.pengaduanId,
    this.username,
    this.message,
  });

  String? id;
  String? dateTime;
  String? pengaduanId;
  String? username;
  String? message;

  factory JawabanPengaduan.fromJson(Map<String, dynamic> json) =>
      JawabanPengaduan(
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
