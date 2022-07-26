import 'dart:convert';

import 'package:ALPOKAT/app/api/url.dart';
import 'package:ALPOKAT/app/modules/riwayat_booking/models/BillingModel.dart';
import 'package:ALPOKAT/app/modules/riwayat_booking/models/ResumeModel.dart';
import 'package:ALPOKAT/app/modules/riwayat_booking/models/RiwayatBookingModel.dart';
import 'package:ALPOKAT/app/modules/riwayat_booking/models/RiwayatPemeriksaanModel.dart';
import 'package:ALPOKAT/app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../api/login_session.dart';
import '../../../api/rest_api.dart';
import '../../surat_sakit/models/setting_model.dart';

class RiwayatBookingController extends GetxController
    with SingleGetTickerProviderMixin {
  //TODO: Implement RiwayatBookingController
  final _session = Get.find<LoginSession>();
  final _restApi = Get.put(RestApi());
  final setting = Setting().obs;
  late TabController tabController;
  var riwayatBooking = <RiwayatBookingModel>[].obs;
  var selectedRiwayatBooking = RiwayatBookingModel().obs;
  var listRiwayatPemeriksaan = <RiwayatPemeriksaanModel>[].obs;
  var dataResume = ResumeModel().obs;
  var listBilling = <BillingModel>[].obs;
  var totalBilling = 0.obs;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void onReady() {
    _restApi.getService(urlSetting).then((value) => {
          if (value.statusCode == 200)
            {
              setting.value = settingFromJson(value.bodyString!),
            }
        });
    getRiwayatBooking();
    riwayatPemeriksaan();
    super.onReady();
  }

  @override
  void onClose() {}

  getRiwayatBooking() {
    try {
      Future.delayed(
        Duration.zero,
      );
      _restApi
          .getService(urlRiwayatBooking + '?no_rkm_medis=${_session.rkm.val}')
          .then((res) {
        riwayatBooking.value =
            riwayatBookingModelFromJson(json.encode(res.body['data']));
      });
    } catch (e) {}
  }

  checkin() {
    try {
      Future.delayed(
        Duration.zero,
        () => DialogHelper.showLoading('Loading.....'),
      );
      var body = {
        'no_rkm_medis': _session.rkm.val,
        'tanggal': DateFormat('yyyy-MM-dd')
            .format(selectedRiwayatBooking.value.tanggalPeriksa!),
        'status': selectedRiwayatBooking.value.status,
        'kd_dokter': selectedRiwayatBooking.value.kdDokter,
        'kd_poli': selectedRiwayatBooking.value.kdPoli,
        'kd_pj': selectedRiwayatBooking.value.kdPJ,
        'no_reg': selectedRiwayatBooking.value.noReg,
      };
      _restApi.postService(urlCheckin, body).then((res) {
        DialogHelper.hideLoading();
        bookingDetail();
        var statusCode = res.statusCode;
        var message = res.body['meta']['message'];
        Get.snackbar(
          statusCode == 200 ? 'Checkin berhasil' : 'Checkin gagal',
          message,
          icon: Icon(
              statusCode == 200
                  ? Icons.check_circle_outline
                  : Icons.cancel_outlined,
              color: Colors.white),
          snackPosition: SnackPosition.TOP,
          backgroundColor: statusCode == 200 ? Colors.green : Colors.red,
          colorText: Colors.white,
          borderRadius: 20,
          margin: const EdgeInsets.all(15),
          duration: const Duration(seconds: 3),
          isDismissible: true,
          dismissDirection: SnackDismissDirection.HORIZONTAL,
          forwardAnimationCurve: Curves.easeOutBack,
        );
      });
    } catch (e) {
      DialogHelper.hideLoading();
      Get.snackbar(
        'Checkin Gagal',
        e.toString(),
        icon: Icon(Icons.cancel_outlined, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 20,
        margin: const EdgeInsets.all(15),
        duration: const Duration(seconds: 5),
        isDismissible: true,
        dismissDirection: SnackDismissDirection.HORIZONTAL,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    }
  }

  batalCheckin() {
    try {
      Future.delayed(
        Duration.zero,
        () => DialogHelper.showLoading('Loading.....'),
      );
      var body = {
        'no_rkm_medis': _session.rkm.val,
        'tanggal': DateFormat('yyyy-MM-dd')
            .format(selectedRiwayatBooking.value.tanggalPeriksa!),
        'status': 'batal',
        'kd_dokter': selectedRiwayatBooking.value.kdDokter,
        'kd_poli': selectedRiwayatBooking.value.kdPoli,
        'kd_pj': selectedRiwayatBooking.value.kdPJ,
        'no_reg': selectedRiwayatBooking.value.noReg,
      };
      _restApi.postService(urlCheckin, body).then((res) {
        DialogHelper.hideLoading();
        bookingDetail();
        var statusCode = res.statusCode;
        var message = res.body['meta']['message'];
        Get.snackbar(
          statusCode == 200 ? 'Batal checkin berhasil' : 'Batal checkin gagal',
          message,
          icon: Icon(
              statusCode == 200
                  ? Icons.check_circle_outline
                  : Icons.cancel_outlined,
              color: Colors.white),
          snackPosition: SnackPosition.TOP,
          backgroundColor: statusCode == 200 ? Colors.green : Colors.red,
          colorText: Colors.white,
          borderRadius: 20,
          margin: const EdgeInsets.all(15),
          duration: const Duration(seconds: 3),
          isDismissible: true,
          dismissDirection: SnackDismissDirection.HORIZONTAL,
          forwardAnimationCurve: Curves.easeOutBack,
        );
      });
    } catch (e) {
      DialogHelper.hideLoading();
      Get.snackbar(
        'Batal checkin Gagal',
        e.toString(),
        icon: Icon(Icons.cancel_outlined, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 20,
        margin: const EdgeInsets.all(15),
        duration: const Duration(seconds: 5),
        isDismissible: true,
        dismissDirection: SnackDismissDirection.HORIZONTAL,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    }
  }

  bookingDetail() {
    try {
      Future.delayed(
        Duration.zero,
      );
      var body = {
        'no_rkm_medis': _session.rkm.val,
        'tanggal': DateFormat('yyyy-MM-dd')
            .format(selectedRiwayatBooking.value.tanggalPeriksa!),
        'kd_dokter': selectedRiwayatBooking.value.kdDokter,
        'kd_poli': selectedRiwayatBooking.value.kdPoli,
        'kd_pj': selectedRiwayatBooking.value.kdPJ,
        'no_reg': selectedRiwayatBooking.value.noReg,
      };
      _restApi
          .getService(urlBookingDetail +
              '?no_rkm_medis=${body['no_rkm_medis']}&tanggal=${body['tanggal']}&kd_dokter=${body['kd_dokter']}&kd_poli=${body['kd_poli']}&kd_pj=${body['kd_pj']}&no_reg=${body['no_reg']}')
          .then((res) => selectedRiwayatBooking.value =
              selectedRiwayatBookingModelFromJson(
                  json.encode(res.body['data'])));
    } catch (e) {}
  }

  riwayatPemeriksaan() {
    try {
      Future.delayed(
        Duration.zero,
      );
      var body = {
        'no_rkm_medis': _session.rkm.val,
      };
      _restApi
          .getService(
              urlRiwayatPeriksa + '?no_rkm_medis=${body['no_rkm_medis']}')
          .then((res) => listRiwayatPemeriksaan.value =
              riwayatPemeriksaanModelFromJson(json.encode(res.body['data'])));
    } catch (e) {}
  }

  Future<void> resume(String? noRawat) async {
    try {
      Future.delayed(
        Duration.zero,
      );
      var body = {
        'no_rawat': noRawat,
      };
      _restApi.getService(urlResume + '?no_rawat=${body['no_rawat']}').then(
        (res) {
          dataResume.value = resumeModelFromJson(json.encode(res.body['data']));
        },
      );
    } catch (e) {}
  }

  Future<void> billing(String? noRawat) async {
    try {
      Future.delayed(
        Duration.zero,
      );
      var body = {
        'no_rawat': noRawat,
      };
      _restApi.getService(urlBilling + '?no_rawat=${body['no_rawat']}').then(
        (res) {
          totalBilling.value = 0;
          listBilling.value =
              billingModelFromJson(json.encode(res.body['data']));
          listBilling.value.forEach((e) {
            if (e.empat != '') {
              totalBilling.value += int.parse(e.empat!);
            }
          });
        },
      );
    } catch (e) {}
  }
}
