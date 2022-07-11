// To parse this JSON data, do
//
//     final suratKontrolModel = suratKontrolModelFromJson(jsonString);

import 'dart:convert';

List<SuratKontrolModel> suratKontrolModelFromJson(String str) =>
    List<SuratKontrolModel>.from(
        json.decode(str).map((x) => SuratKontrolModel.fromJson(x)));

String suratKontrolModelToJson(List<SuratKontrolModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SuratKontrolModel {
  SuratKontrolModel({
    this.noRkmMedis,
    this.diagnosa,
    this.rtl1,
    this.tanggalDatang,
    this.noAntrian,
    this.nmDokter,
    this.tahun,
    this.kadaluarsa,
  });

  String? noRkmMedis;
  String? diagnosa;
  String? rtl1;
  DateTime? tanggalDatang;
  String? noAntrian;
  String? nmDokter;
  String? tahun;
  String? kadaluarsa;

  factory SuratKontrolModel.fromJson(Map<String, dynamic> json) =>
      SuratKontrolModel(
        noRkmMedis: json["no_rkm_medis"],
        diagnosa: json["diagnosa"],
        rtl1: json["rtl1"],
        tanggalDatang: DateTime.parse(json["tanggal_datang"]),
        noAntrian: json["no_antrian"],
        nmDokter: json["nm_dokter"],
        tahun: json["tahun"],
        kadaluarsa: json["kadaluarsa"],
      );

  Map<String, dynamic> toJson() => {
        "no_rkm_medis": noRkmMedis,
        "diagnosa": diagnosa,
        "rtl1": rtl1,
        "tanggal_datang":
            "${tanggalDatang!.year.toString().padLeft(4, '0')}-${tanggalDatang!.month.toString().padLeft(2, '0')}-${tanggalDatang!.day.toString().padLeft(2, '0')}",
        "no_antrian": noAntrian,
        "nm_dokter": nmDokter,
        "tahun": tahun,
        "kadaluarsa": kadaluarsa,
      };
}
