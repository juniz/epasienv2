// To parse this JSON data, do
//
//     final suratKontrolDataModel = suratKontrolDataModelFromJson(jsonString);

import 'dart:convert';

SuratKontrolDataModel suratKontrolDataModelFromJson(String str) =>
    SuratKontrolDataModel.fromJson(json.decode(str));

String suratKontrolDataModelToJson(SuratKontrolDataModel data) =>
    json.encode(data.toJson());

class SuratKontrolDataModel {
  SuratKontrolDataModel({
    this.noReg,
    this.tahun,
    this.noRkmMedis,
    this.nmPasien,
    this.diagnosa,
    this.terapi,
    this.alasan1,
    this.alasan2,
    this.rtl1,
    this.rtl2,
    this.tanggalDatang,
    this.tanggalRujukan,
    this.noAntrian,
    this.kdDokter,
    this.nmDokter,
    this.status,
  });

  String? noReg;
  String? tahun;
  String? noRkmMedis;
  String? nmPasien;
  String? diagnosa;
  String? terapi;
  String? alasan1;
  String? alasan2;
  String? rtl1;
  String? rtl2;
  DateTime? tanggalDatang;
  DateTime? tanggalRujukan;
  String? noAntrian;
  String? kdDokter;
  String? nmDokter;
  String? status;

  factory SuratKontrolDataModel.fromJson(Map<String, dynamic> json) =>
      SuratKontrolDataModel(
        noReg: json["no_reg"],
        tahun: json["tahun"],
        noRkmMedis: json["no_rkm_medis"],
        nmPasien: json["nm_pasien"],
        diagnosa: json["diagnosa"],
        terapi: json["terapi"],
        alasan1: json["alasan1"],
        alasan2: json["alasan2"],
        rtl1: json["rtl1"],
        rtl2: json["rtl2"],
        tanggalDatang: DateTime.parse(json["tanggal_datang"]),
        tanggalRujukan: DateTime.parse(json["tanggal_rujukan"]),
        noAntrian: json["no_antrian"],
        kdDokter: json["kd_dokter"],
        nmDokter: json["nm_dokter"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "tahun": tahun,
        "no_rkm_medis": noRkmMedis,
        "nm_pasien": nmPasien,
        "diagnosa": diagnosa,
        "terapi": terapi,
        "alasan1": alasan1,
        "alasan2": alasan2,
        "rtl1": rtl1,
        "rtl2": rtl2,
        "tanggal_datang":
            "${tanggalDatang!.year.toString().padLeft(4, '0')}-${tanggalDatang!.month.toString().padLeft(2, '0')}-${tanggalDatang!.day.toString().padLeft(2, '0')}",
        "tanggal_rujukan":
            "${tanggalRujukan!.year.toString().padLeft(4, '0')}-${tanggalRujukan!.month.toString().padLeft(2, '0')}-${tanggalRujukan!.day.toString().padLeft(2, '0')}",
        "no_antrian": noAntrian,
        "kd_dokter": kdDokter,
        "nm_dokter": nmDokter,
        "status": status,
      };
}
