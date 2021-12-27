// To parse this JSON data, do
//
//     final suratRujukanDataModel = suratRujukanDataModelFromJson(jsonString);

import 'dart:convert';

SuratRujukanDataModel suratRujukanDataModelFromJson(String str) =>
    SuratRujukanDataModel.fromJson(json.decode(str));

String suratRujukanDataModelToJson(SuratRujukanDataModel data) =>
    json.encode(data.toJson());

class SuratRujukanDataModel {
  SuratRujukanDataModel({
    this.noRujuk,
    this.noRawat,
    this.noRkmMedis,
    this.nmPasien,
    this.rujukKe,
    this.tglRujuk,
    this.jam,
    this.keteranganDiagnosa,
    this.kdDokter,
    this.nmDokter,
    this.katRujuk,
    this.ambulance,
    this.keterangan,
    this.tglRegistrasi,
    this.alamat,
    this.inap,
    this.lab,
    this.rad,
    this.operasi,
    this.obat,
  });

  String? noRujuk;
  String? noRawat;
  String? noRkmMedis;
  String? nmPasien;
  String? rujukKe;
  String? tglRujuk;
  String? jam;
  String? keteranganDiagnosa;
  String? kdDokter;
  String? nmDokter;
  String? katRujuk;
  String? ambulance;
  String? keterangan;
  DateTime? tglRegistrasi;
  String? alamat;
  String? inap;
  String? lab;
  String? rad;
  String? operasi;
  String? obat;

  factory SuratRujukanDataModel.fromJson(Map<String, dynamic> json) =>
      SuratRujukanDataModel(
        noRujuk: json["no_rujuk"],
        noRawat: json["no_rawat"],
        noRkmMedis: json["no_rkm_medis"],
        nmPasien: json["nm_pasien"],
        rujukKe: json["rujuk_ke"],
        tglRujuk: json["tgl_rujuk"],
        jam: json["jam"],
        keteranganDiagnosa: json["keterangan_diagnosa"],
        kdDokter: json["kd_dokter"],
        nmDokter: json["nm_dokter"],
        katRujuk: json["kat_rujuk"],
        ambulance: json["ambulance"],
        keterangan: json["keterangan"],
        tglRegistrasi: DateTime.parse(json["tgl_registrasi"]),
        alamat: json["alamat"],
        inap: json["inap"],
        lab: json["lab"],
        rad: json["rad"],
        operasi: json["operasi"],
        obat: json["obat"],
      );

  Map<String, dynamic> toJson() => {
        "no_rujuk": noRujuk,
        "no_rawat": noRawat,
        "no_rkm_medis": noRkmMedis,
        "nm_pasien": nmPasien,
        "rujuk_ke": rujukKe,
        "tgl_rujuk": tglRujuk,
        "jam": jam,
        "keterangan_diagnosa": keteranganDiagnosa,
        "kd_dokter": kdDokter,
        "nm_dokter": nmDokter,
        "kat_rujuk": katRujuk,
        "ambulance": ambulance,
        "keterangan": keterangan,
        "tgl_registrasi":
            "${tglRegistrasi!.year.toString().padLeft(4, '0')}-${tglRegistrasi!.month.toString().padLeft(2, '0')}-${tglRegistrasi!.day.toString().padLeft(2, '0')}",
        "alamat": alamat,
      };
}
