// To parse this JSON data, do
//
//     final resumeModel = resumeModelFromJson(jsonString);

import 'dart:convert';

ResumeModel resumeModelFromJson(String str) =>
    ResumeModel.fromJson(json.decode(str));

String resumeModelToJson(ResumeModel data) => json.encode(data.toJson());

class ResumeModel {
  ResumeModel({
    this.kdDokter,
    this.nmDokter,
    this.kondisiPulang,
    this.keluhanUtama,
    this.jalannyaPenyakit,
    this.pemeriksaanPenunjang,
    this.hasilLaborat,
    this.diagnosaUtama,
    this.kdDiagnosaUtama,
    this.diagnosaSekunder,
    this.kdDiagnosaSekunder,
    this.diagnosaSekunder2,
    this.kdDiagnosaSekunder2,
    this.diagnosaSekunder3,
    this.kdDiagnosaSekunder3,
    this.diagnosaSekunder4,
    this.kdDiagnosaSekunder4,
    this.prosedurUtama,
    this.kdProsedurUtama,
    this.prosedurSekunder,
    this.kdProsedurSekunder,
    this.prosedurSekunder2,
    this.kdProsedurSekunder2,
    this.prosedurSekunder3,
    this.kdProsedurSekunder3,
    this.obatPulang,
  });

  String? kdDokter;
  String? nmDokter;
  String? kondisiPulang;
  String? keluhanUtama;
  String? jalannyaPenyakit;
  String? pemeriksaanPenunjang;
  String? hasilLaborat;
  String? diagnosaUtama;
  String? kdDiagnosaUtama;
  String? diagnosaSekunder;
  String? kdDiagnosaSekunder;
  String? diagnosaSekunder2;
  String? kdDiagnosaSekunder2;
  String? diagnosaSekunder3;
  String? kdDiagnosaSekunder3;
  String? diagnosaSekunder4;
  String? kdDiagnosaSekunder4;
  String? prosedurUtama;
  String? kdProsedurUtama;
  String? prosedurSekunder;
  String? kdProsedurSekunder;
  String? prosedurSekunder2;
  String? kdProsedurSekunder2;
  String? prosedurSekunder3;
  String? kdProsedurSekunder3;
  String? obatPulang;

  factory ResumeModel.fromJson(Map<String, dynamic> json) => ResumeModel(
        kdDokter: json["kd_dokter"],
        nmDokter: json["nm_dokter"],
        kondisiPulang: json["kondisi_pulang"],
        keluhanUtama: json["keluhan_utama"],
        jalannyaPenyakit: json["jalannya_penyakit"],
        pemeriksaanPenunjang: json["pemeriksaan_penunjang"],
        hasilLaborat: json["hasil_laborat"],
        diagnosaUtama: json["diagnosa_utama"],
        kdDiagnosaUtama: json["kd_diagnosa_utama"],
        diagnosaSekunder: json["diagnosa_sekunder"],
        kdDiagnosaSekunder: json["kd_diagnosa_sekunder"],
        diagnosaSekunder2: json["diagnosa_sekunder2"],
        kdDiagnosaSekunder2: json["kd_diagnosa_sekunder2"],
        diagnosaSekunder3: json["diagnosa_sekunder3"],
        kdDiagnosaSekunder3: json["kd_diagnosa_sekunder3"],
        diagnosaSekunder4: json["diagnosa_sekunder4"],
        kdDiagnosaSekunder4: json["kd_diagnosa_sekunder4"],
        prosedurUtama: json["prosedur_utama"],
        kdProsedurUtama: json["kd_prosedur_utama"],
        prosedurSekunder: json["prosedur_sekunder"],
        kdProsedurSekunder: json["kd_prosedur_sekunder"],
        prosedurSekunder2: json["prosedur_sekunder2"],
        kdProsedurSekunder2: json["kd_prosedur_sekunder2"],
        prosedurSekunder3: json["prosedur_sekunder3"],
        kdProsedurSekunder3: json["kd_prosedur_sekunder3"],
        obatPulang: json["obat_pulang"],
      );

  Map<String, dynamic> toJson() => {
        "kd_dokter": kdDokter,
        "nm_dokter": nmDokter,
        "kondisi_pulang": kondisiPulang,
        "keluhan_utama": keluhanUtama,
        "jalannya_penyakit": jalannyaPenyakit,
        "pemeriksaan_penunjang": pemeriksaanPenunjang,
        "hasil_laborat": hasilLaborat,
        "diagnosa_utama": diagnosaUtama,
        "kd_diagnosa_utama": kdDiagnosaUtama,
        "diagnosa_sekunder": diagnosaSekunder,
        "kd_diagnosa_sekunder": kdDiagnosaSekunder,
        "diagnosa_sekunder2": diagnosaSekunder2,
        "kd_diagnosa_sekunder2": kdDiagnosaSekunder2,
        "diagnosa_sekunder3": diagnosaSekunder3,
        "kd_diagnosa_sekunder3": kdDiagnosaSekunder3,
        "diagnosa_sekunder4": diagnosaSekunder4,
        "kd_diagnosa_sekunder4": kdDiagnosaSekunder4,
        "prosedur_utama": prosedurUtama,
        "kd_prosedur_utama": kdProsedurUtama,
        "prosedur_sekunder": prosedurSekunder,
        "kd_prosedur_sekunder": kdProsedurSekunder,
        "prosedur_sekunder2": prosedurSekunder2,
        "kd_prosedur_sekunder2": kdProsedurSekunder2,
        "prosedur_sekunder3": prosedurSekunder3,
        "kd_prosedur_sekunder3": kdProsedurSekunder3,
        "obat_pulang": obatPulang,
      };
}
