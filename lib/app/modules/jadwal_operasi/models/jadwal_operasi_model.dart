// To parse this JSON data, do
//
//     final jadwalOperas = jadwalOperasFromJson(jsonString);

import 'dart:convert';

JadwalOperasi jadwalOperasFromJson(String str) =>
    JadwalOperasi.fromJson(json.decode(str));

String jadwalOperasToJson(JadwalOperasi data) => json.encode(data.toJson());

class JadwalOperasi {
  JadwalOperasi({
    this.meta,
    this.data,
  });

  Meta? meta;
  List<ListJadwalOperasi>? data;

  factory JadwalOperasi.fromJson(Map<String, dynamic> json) => JadwalOperasi(
        meta: Meta.fromJson(json["meta"]),
        data: List<ListJadwalOperasi>.from(
            json["data"].map((x) => ListJadwalOperasi.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ListJadwalOperasi {
  ListJadwalOperasi({
    this.noRawat,
    this.noRkmMedis,
    this.nmPasien,
    this.tanggal,
    this.jamMulai,
    this.jamSelesai,
    this.status,
    this.kdDokter,
    this.nmDokter,
    this.kodePaket,
    this.nmPerawatan,
    this.umur,
    this.jk,
  });

  String? noRawat;
  String? noRkmMedis;
  String? nmPasien;
  DateTime? tanggal;
  String? jamMulai;
  String? jamSelesai;
  String? status;
  String? kdDokter;
  String? nmDokter;
  String? kodePaket;
  String? nmPerawatan;
  String? umur;
  String? jk;

  factory ListJadwalOperasi.fromJson(Map<String, dynamic> json) =>
      ListJadwalOperasi(
        noRawat: json["no_rawat"],
        noRkmMedis: json["no_rkm_medis"],
        nmPasien: json["nm_pasien"],
        tanggal: DateTime.parse(json["tanggal"]),
        jamMulai: json["jam_mulai"],
        jamSelesai: json["jam_selesai"],
        status: json["status"],
        kdDokter: json["kd_dokter"],
        nmDokter: json["nm_dokter"],
        kodePaket: json["kode_paket"],
        nmPerawatan: json["nm_perawatan"],
        umur: json["umur"],
        jk: json["jk"],
      );

  Map<String, dynamic> toJson() => {
        "no_rawat": noRawat,
        "no_rkm_medis": noRkmMedis,
        "nm_pasien": nmPasien,
        "tanggal":
            "${tanggal?.year.toString().padLeft(4, '0')}-${tanggal?.month.toString().padLeft(2, '0')}-${tanggal?.day.toString().padLeft(2, '0')}",
        "jam_mulai": jamMulai,
        "jam_selesai": jamSelesai,
        "status": status,
        "kd_dokter": kdDokter,
        "nm_dokter": nmDokter,
        "kode_paket": kodePaket,
        "nm_perawatan": nmPerawatan,
        "umur": umur,
        "jk": jk,
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
