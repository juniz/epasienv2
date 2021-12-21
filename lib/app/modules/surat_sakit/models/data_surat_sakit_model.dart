// To parse this JSON data, do
//
//     final dataSuratSakitModel = dataSuratSakitModelFromJson(jsonString);

import 'dart:convert';

DataSuratSakitModel dataSuratSakitModelFromJson(String str) =>
    DataSuratSakitModel.fromJson(json.decode(str));

String dataSuratSakitModelToJson(DataSuratSakitModel data) =>
    json.encode(data.toJson());

class DataSuratSakitModel {
  DataSuratSakitModel({
    this.noSurat,
    this.noRawat,
    this.noRkmMedis,
    this.nmPasien,
    this.jk,
    this.pekerjaan,
    this.umur,
    this.tanggalawal,
    this.tanggalakhir,
    this.lamasakit,
    this.alamat,
    this.nmDokter,
    this.kdDokter,
    this.diagnosa,
  });

  String? noSurat;
  String? noRawat;
  String? noRkmMedis;
  String? nmPasien;
  String? jk;
  String? pekerjaan;
  String? umur;
  String? tanggalawal;
  String? tanggalakhir;
  String? lamasakit;
  String? alamat;
  String? nmDokter;
  String? kdDokter;
  String? diagnosa;

  factory DataSuratSakitModel.fromJson(Map<String, dynamic> json) =>
      DataSuratSakitModel(
        noSurat: json["no_surat"],
        noRawat: json["no_rawat"],
        noRkmMedis: json["no_rkm_medis"],
        nmPasien: json["nm_pasien"],
        jk: json["jk"],
        pekerjaan: json["pekerjaan"],
        umur: json["umur"],
        tanggalawal: json["tanggalawal"],
        tanggalakhir: json["tanggalakhir"],
        lamasakit: json["lamasakit"],
        alamat: json["alamat"],
        nmDokter: json["nm_dokter"],
        kdDokter: json["kd_dokter"],
        diagnosa: json["diagnosa"],
      );

  Map<String, dynamic> toJson() => {
        "no_surat": noSurat,
        "no_rawat": noRawat,
        "no_rkm_medis": noRkmMedis,
        "nm_pasien": nmPasien,
        "jk": jk,
        "pekerjaan": pekerjaan,
        "umur": umur,
        "tanggalawal": tanggalawal,
        "tanggalakhir": tanggalakhir,
        "lamasakit": lamasakit,
        "alamat": alamat,
        "nm_dokter": nmDokter,
        "kd_dokter": kdDokter,
      };
}
