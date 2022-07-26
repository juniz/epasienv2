import 'dart:convert';

import 'package:ALPOKAT/app/api/url.dart';
import 'package:ALPOKAT/app/modules/home/models/Homevisite.dart';
import 'package:ALPOKAT/app/modules/home/models/WebModel.dart';
import 'package:ALPOKAT/app/modules/home/providers/web_provider.dart';
import 'package:ALPOKAT/app/modules/riwayat_booking/models/RiwayatBookingModel.dart';
import 'package:ALPOKAT/app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../api/login_session.dart';
import '../../../api/rest_api.dart';
import '../../../utils/setting.dart';
import '../../surat_sakit/models/setting_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final _restApi = Get.put(RestApi());
  final session = Get.find<LoginSession>();
  var listWeb = <WebModel>[].obs;
  var listBooking = <RiwayatBookingModel>[].obs;
  var selectedRiwayatBooking = RiwayatBookingModel().obs;
  final homevisite = HomeVisiteModel().obs;
  final setting = Setting().obs;
  var loadBooking = true.obs;
  var loadHomevisite = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    WebProvider().fetchWeb().then((value) {
      listWeb.value = value;
    });
    _restApi.getService(urlSetting).then((value) => {
          if (value.statusCode == 200)
            {
              setting.value = settingFromJson(value.bodyString!),
            }
        });
    onRefreshBooking();
    super.onReady();
  }

  @override
  void onClose() {}

  onRefreshBooking() {
    loadBooking(true);
    Future.delayed(Duration(seconds: 1), () {
      _restApi
          .getService(urlRiwayatBooking + '?no_rkm_medis=${session.rkm.val}')
          .then((value) {
        if (value.statusCode == 200) {
          listBooking.value =
              riwayatBookingModelFromJson(json.encode(value.body['data']));
        }
      });
      loadBooking(false);
      if (homeVisite) {
        getHomevisite();
      }
    });
  }

  checkin() {
    try {
      Future.delayed(
        Duration.zero,
        () => DialogHelper.showLoading('Loading.....'),
      );
      var body = {
        'no_rkm_medis': session.rkm.val,
        'tanggal': DateFormat('yyyy-MM-dd')
            .format(selectedRiwayatBooking.value.tanggalPeriksa!),
        'status': selectedRiwayatBooking.value.status,
        'kd_dokter': selectedRiwayatBooking.value.kdDokter,
        'kd_poli': selectedRiwayatBooking.value.kdPoli,
        'kd_pj': selectedRiwayatBooking.value.kdPJ,
        'no_reg': selectedRiwayatBooking.value.noReg,
      };
      _restApi.postService(urlCheckin, body).then((res) {
        // print(res.bodyString);
        DialogHelper.hideLoading();
        bookingDetail();
        var statusCode = res.statusCode;
        var message = res.body['meta']['message'];
        if (statusCode == 200) {
          onRefreshBooking();
          Get.back();
        }
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
        () => DialogHelper.showLoading('Sedang memproses data.....'),
      );
      var body = {
        'no_rkm_medis': session.rkm.val,
        'tanggal': DateFormat('yyyy-MM-dd')
            .format(selectedRiwayatBooking.value.tanggalPeriksa!),
        'status': 'batal',
        'kd_dokter': selectedRiwayatBooking.value.kdDokter,
        'kd_poli': selectedRiwayatBooking.value.kdPoli,
        'kd_pj': selectedRiwayatBooking.value.kdPJ,
        'no_reg': selectedRiwayatBooking.value.noReg,
      };
      _restApi.postService(urlCheckin, body).then((res) {
        // print(res.bodyString);
        DialogHelper.hideLoading();
        bookingDetail();
        var statusCode = res.statusCode;
        var message = res.body['meta']['message'];
        if (statusCode == 200) {
          Get.back();
          onRefreshBooking();
        }
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
      _restApi
          .getService(
            urlBookingDetail +
                '?no_rkm_medis=${session.rkm.val}&tanggal=${DateFormat('yyyy-MM-dd').format(selectedRiwayatBooking.value.tanggalPeriksa!)}&kd_dokter=${selectedRiwayatBooking.value.kdDokter}&kd_poli=${selectedRiwayatBooking.value.kdPoli}&kd_pj=${selectedRiwayatBooking.value.kdPJ}&no_reg=${selectedRiwayatBooking.value.noReg}',
          )
          .then(
            (res) => selectedRiwayatBooking.value =
                selectedRiwayatBookingModelFromJson(
                    json.encode(res.body['body'])),
          );
    } catch (e) {}
  }

  postHomevisite(DateTime date) {
    Future.delayed(
      Duration.zero,
      () => DialogHelper.showLoading('Loading.....'),
    );
    var body = {
      'no_rkm_medis': session.rkm.val,
      'tanggal': DateFormat("yyyy-MM-dd").format(date),
    };

    _restApi.postService(urlDaftarHomeVisite, body).then((value) {
      DialogHelper.hideLoading();
      var statusCode = value.statusCode;
      var message = value.body['meta']['message'];
      Get.snackbar(
        statusCode == 200 ? 'Berhasil' : 'Gagal',
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
  }

  getHomevisite() {
    loadHomevisite(true);
    // print(loadHomevisite);
    Future.delayed(
      Duration(seconds: 1),
      () {
        _restApi
            .getService(urlHomeVisite + '?no_rkm_medis=${session.rkm.val}')
            .then((value) {
          homevisite.value =
              homeVisiteModelFromJson(json.encode(value.body['data']));
          loadHomevisite(false);
        });
      },
    );
    loadHomevisite(false);
    // print(loadHomevisite);
  }
}
