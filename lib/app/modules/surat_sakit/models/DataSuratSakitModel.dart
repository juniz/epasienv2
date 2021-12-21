// To parse this JSON data, do
//
//     final dataSuratNarkobaModel = dataSuratNarkobaModelFromJson(jsonString);

import 'dart:convert';

DataSuratNarkobaModel dataSuratNarkobaModelFromJson(String str) =>
    DataSuratNarkobaModel.fromJson(json.decode(str));

String dataSuratNarkobaModelToJson(DataSuratNarkobaModel data) =>
    json.encode(data.toJson());

class DataSuratNarkobaModel {
  DataSuratNarkobaModel({
    this.noSurat,
    this.noRawat,
    this.noRkmMedis,
    this.nmPasien,
    this.pekerjaan,
    this.umur,
    this.hari,
    this.tanggalsurat,
    this.tanggal,
    this.bulan,
    this.tahun,
    this.keperluan,
    this.jk,
    this.alamat,
    this.nmDokter,
    this.kdDokter,
    this.kategori,
    this.tmpLahir,
    this.namaSukuBangsa,
    this.tglLahir,
    this.agama,
    this.opiat,
    this.ganja,
    this.amphetamin,
    this.methamphetamin,
    this.benzodiazepin,
    this.cocain,
  });

  String? noSurat;
  String? noRawat;
  String? noRkmMedis;
  String? nmPasien;
  String? pekerjaan;
  String? umur;
  String? hari;
  String? tanggalsurat;
  String? tanggal;
  String? bulan;
  String? tahun;
  String? keperluan;
  String? jk;
  String? alamat;
  String? nmDokter;
  String? kdDokter;
  String? kategori;
  String? tmpLahir;
  String? namaSukuBangsa;
  String? tglLahir;
  String? agama;
  String? opiat;
  String? ganja;
  String? amphetamin;
  String? methamphetamin;
  String? benzodiazepin;
  String? cocain;

  factory DataSuratNarkobaModel.fromJson(Map<String, dynamic> json) =>
      DataSuratNarkobaModel(
        noSurat: json["no_surat"],
        noRawat: json["no_rawat"],
        noRkmMedis: json["no_rkm_medis"],
        nmPasien: json["nm_pasien"],
        pekerjaan: json["pekerjaan"],
        umur: json["umur"],
        hari: json["hari"],
        tanggalsurat: json["tanggalsurat"],
        tanggal: json["tanggal"],
        bulan: json["bulan"],
        tahun: json["tahun"],
        keperluan: json["keperluan"],
        jk: json["jk"],
        alamat: json["alamat"],
        nmDokter: json["nm_dokter"],
        kdDokter: json["kd_dokter"],
        kategori: json["kategori"],
        tmpLahir: json["tmp_lahir"],
        namaSukuBangsa: json["nama_suku_bangsa"],
        tglLahir: json["tgl_lahir"],
        agama: json["agama"],
        opiat: json["opiat"],
        ganja: json["ganja"],
        amphetamin: json["amphetamin"],
        methamphetamin: json["methamphetamin"],
        benzodiazepin: json["benzodiazepin"],
        cocain: json["cocain"],
      );

  Map<String, dynamic> toJson() => {
        "no_surat": noSurat,
        "no_rawat": noRawat,
        "no_rkm_medis": noRkmMedis,
        "nm_pasien": nmPasien,
        "pekerjaan": pekerjaan,
        "umur": umur,
        "hari": hari,
        "tanggalsurat": tanggalsurat,
        "tanggal": tanggal,
        "bulan": bulan,
        "tahun": tahun,
        "keperluan": keperluan,
        "jk": jk,
        "alamat": alamat,
        "nm_dokter": nmDokter,
        "kd_dokter": kdDokter,
        "kategori": kategori,
        "tmp_lahir": tmpLahir,
        "nama_suku_bangsa": namaSukuBangsa,
        "tgl_lahir": tglLahir,
        "agama": agama,
        "opiat": opiat,
        "ganja": ganja,
        "amphetamin": amphetamin,
        "methamphetamin": methamphetamin,
        "benzodiazepin": benzodiazepin,
        "cocain": cocain,
      };
}
