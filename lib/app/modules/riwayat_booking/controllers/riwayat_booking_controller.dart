import 'package:epasien/app/modules/riwayat_booking/models/BillingModel.dart';
import 'package:epasien/app/modules/riwayat_booking/models/ResumeModel.dart';
import 'package:epasien/app/modules/riwayat_booking/models/RiwayatBookingModel.dart';
import 'package:epasien/app/modules/riwayat_booking/models/RiwayatPemeriksaanModel.dart';
import 'package:epasien/app/modules/riwayat_booking/providers/riwayat_booking_provider.dart';
import 'package:epasien/app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RiwayatBookingController extends GetxController
    with SingleGetTickerProviderMixin {
  //TODO: Implement RiwayatBookingController

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
      var body = {
        'no_rkm_medis': '165056',
      };
      RiwayatBookingProvider()
          .post(
              'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/riwayatbooking',
              body)
          .then((res) {
        print(res.bodyString);
        riwayatBooking.value = riwayatBookingModelFromJson(res.bodyString!);
      });
    } catch (e) {}
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
      RiwayatBookingProvider()
          .post(
              'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/checkin',
              body)
          .then((res) {
        print(res.bodyString);
        DialogHelper.hideLoading();
        bookingDetail();
        var statusCode = res.statusCode;
        var message = res.body['message'];
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
      RiwayatBookingProvider()
          .post(
              'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/checkin',
              body)
          .then((res) {
        print(res.bodyString);
        DialogHelper.hideLoading();
        bookingDetail();
        var statusCode = res.statusCode;
        var message = res.body['message'];
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
      RiwayatBookingProvider()
          .post(
              'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/bookingdetail',
              body)
          .then((res) => selectedRiwayatBooking.value =
              selectedRiwayatBookingModelFromJson(res.bodyString!));
    } catch (e) {}
  }

  riwayatPemeriksaan() {
    try {
      Future.delayed(
        Duration.zero,
      );
      var body = {
        'no_rkm_medis': '165056',
      };
      RiwayatBookingProvider()
          .post(
              'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/riwayatperiksa',
              body)
          .then((res) => listRiwayatPemeriksaan.value =
              riwayatPemeriksaanModelFromJson(res.bodyString!));
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
      RiwayatBookingProvider()
          .post(
              'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/resume',
              body)
          .then(
        (res) {
          dataResume.value = resumeModelFromJson(res.bodyString!);
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
      RiwayatBookingProvider()
          .post(
              'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/billing',
              body)
          .then(
        (res) {
          totalBilling.value = 0;
          listBilling.value = billingModelFromJson(res.bodyString!);
          listBilling.value.forEach((e) {
            if (e.empat != '') {
              totalBilling.value += int.parse(e.empat!);
            }
          });
          print(totalBilling.value);
        },
      );
    } catch (e) {}
  }
}
