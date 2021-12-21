// To parse this JSON data, do
//
//     final pengaduanModel = pengaduanModelFromJson(jsonString);

import 'dart:convert';

List<PengaduanModel> pengaduanModelFromJson(String str) =>
    List<PengaduanModel>.from(
        json.decode(str).map((x) => PengaduanModel.fromJson(x)));

String pengaduanModelToJson(List<PengaduanModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PengaduanModel {
  PengaduanModel({
    this.id,
    this.dateTime,
    this.username,
    this.message,
  });

  int? id;
  DateTime? dateTime;
  String? username;
  String? message;

  factory PengaduanModel.fromJson(Map<String, dynamic> json) => PengaduanModel(
        id: json["id"],
        dateTime: DateTime.parse(json["date_time"]),
        username: json["username"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date_time": dateTime!.toIso8601String(),
        "username": username,
        "message": message,
      };
}
