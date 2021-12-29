import 'package:epasien/app/modules/home/models/WebModel.dart';
import 'package:epasien/app/modules/home/providers/booking_provider_home.dart';
import 'package:epasien/app/modules/home/providers/web_provider.dart';
import 'package:epasien/app/modules/riwayat_booking/models/RiwayatBookingModel.dart';
import 'package:epasien/app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  BookingProviderHome _bookingProvider =
      GetInstance().put(BookingProviderHome());
  final pasien = GetStorage().read('pasien');
  var listWeb = <WebModel>[].obs;
  var listBooking = <RiwayatBookingModel>[].obs;
  var selectedRiwayatBooking = RiwayatBookingModel().obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    WebProvider().fetchWeb().then((value) => listWeb.value = value);
    onRefreshBooking();
    super.onReady();
  }

  @override
  void onClose() {}

  onRefreshBooking() {
    _bookingProvider.fetchRiwayatBooking({'no_rkm_medis': '165056'}).then(
        (value) => listBooking.value = value);
  }

  checkin() {
    try {
      Future.delayed(
        Duration.zero,
        () => DialogHelper.showLoading('Sedang memproses data.....'),
      );
      var body = {
        'no_rkm_medis': '165056',
        'tanggal': DateFormat('yyyy-MM-dd')
            .format(selectedRiwayatBooking.value.tanggalPeriksa!),
        'status': selectedRiwayatBooking.value.status,
        'kd_dokter': selectedRiwayatBooking.value.kdDokter,
        'kd_poli': selectedRiwayatBooking.value.kdPoli,
        'kd_pj': selectedRiwayatBooking.value.kdPJ,
        'no_reg': selectedRiwayatBooking.value.noReg,
      };
      _bookingProvider.checkin(body).then((res) {
        // print(res.bodyString);
        DialogHelper.hideLoading();
        bookingDetail();
        var statusCode = res.statusCode;
        var message = res.body['message'];
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
        'no_rkm_medis': '165056',
        'tanggal': DateFormat('yyyy-MM-dd')
            .format(selectedRiwayatBooking.value.tanggalPeriksa!),
        'status': 'batal',
        'kd_dokter': selectedRiwayatBooking.value.kdDokter,
        'kd_poli': selectedRiwayatBooking.value.kdPoli,
        'kd_pj': selectedRiwayatBooking.value.kdPJ,
        'no_reg': selectedRiwayatBooking.value.noReg,
      };
      _bookingProvider.checkin(body).then((res) {
        // print(res.bodyString);
        DialogHelper.hideLoading();
        bookingDetail();
        var statusCode = res.statusCode;
        var message = res.body['message'];
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
      var body = {
        'no_rkm_medis': '165056',
        'tanggal': DateFormat('yyyy-MM-dd')
            .format(selectedRiwayatBooking.value.tanggalPeriksa!),
        'kd_dokter': selectedRiwayatBooking.value.kdDokter,
        'kd_poli': selectedRiwayatBooking.value.kdPoli,
        'kd_pj': selectedRiwayatBooking.value.kdPJ,
        'no_reg': selectedRiwayatBooking.value.noReg,
      };
      _bookingProvider.fetchRiwayatBookingDetail(body).then(
            (res) => selectedRiwayatBooking.value = res,
          );
    } catch (e) {}
  }
}
