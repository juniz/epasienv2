import 'package:epasien/app/data/MLBookAppointmentData.dart';
import 'package:epasien/app/modules/booking_pasien_baru/providers/poliklinik_provider.dart';
import 'package:epasien/app/modules/halaman_booking/components/MLBookedDailog.dart';
import 'package:epasien/app/modules/halaman_booking/components/MLCheckBookingList.dart';
import 'package:epasien/app/modules/halaman_booking/models/jadwal_poliklinik_model.dart';
import 'package:epasien/app/modules/halaman_booking/models/penjab_model.dart';
import 'package:epasien/app/modules/halaman_booking/providers/booking_provider.dart';
import 'package:epasien/app/utils/MLDataProvider.dart';
import 'package:epasien/app/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class HalamanBookingController extends GetxController {
  //TODO: Implement HalamanBookingController

  var currentWidget = 0.obs;
  var selectedIndex = 0.obs;
  var selectedKdPoli = "".obs;
  var selectedPoli = "".obs;
  var selectedKdDokter = "".obs;
  var selectedDokter = "".obs;
  var selectedIndexPenjab = 0.obs;
  var selectedKdPenjab = "".obs;
  var selectedPenjab = "".obs;
  var selectedJam = "".obs;
  List<MLBookAppointmentData> data = mlBookAppointmentDataList();
  var listPoliklinik = <JadwalPoliklinikModel>[].obs;
  var listPenjab = <PenjabModel>[].obs;
  var selectedDate = DateTime.now().add(Duration(days: 1)).obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    // cekBookingReg();
    getPoliklinik();
    getPenjab();
    super.onReady();
  }

  @override
  void onClose() {}

  getPoliklinik() {
    try {
      Future.delayed(
        Duration(seconds: 3),
      );
      var body = {
        'tanggal': DateFormat('yyyy-MM-dd').format(selectedDate.value),
      };

      PoliklinikProvider()
          .post(
              'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/poliklinik',
              body)
          .then((value) {
        listPoliklinik.value = jadwalPoliklinikModelFromJson(value.bodyString!);
        if (listPoliklinik.value.isEmpty) {
          selectedKdDokter.value = "";
          selectedKdPoli.value = "";
        } else {
          selectedKdDokter.value = listPoliklinik.value[0].kdDokter!;
          selectedDokter.value = listPoliklinik.value[0].nmDokter!;
          selectedKdPoli.value = listPoliklinik.value[0].kdPoli!;
          selectedPoli.value = listPoliklinik.value[0].nmPoli!;
          selectedJam.value =
              '${listPoliklinik.value[0].jamMulai} - ${listPoliklinik.value[0].jamSelesai}';
        }
      });
    } catch (e) {
      print(e);
    }
  }

  getPenjab() {
    try {
      Future.delayed(
        Duration(seconds: 3),
      );

      PoliklinikProvider()
          .get(
              'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/penjab')
          .then((value) {
        listPenjab.value = penjabModelFromJson(value.bodyString!);
        selectedKdPenjab.value = listPenjab.value[0].kdPj!;
        selectedPenjab.value = listPenjab.value[0].pngJawab!;
      });
    } catch (e) {
      print(e);
    }
  }

  postBooking() {
    try {
      Future.delayed(
        Duration.zero,
        () => DialogHelper.showLoading('Sedang memproses data.....'),
      );
      var body = {
        'no_rkm_medis': '165056',
        'tanggal': DateFormat('yyyy-MM-dd').format(selectedDate.value),
        'kd_poli': selectedKdPoli.value,
        'kd_dokter': selectedKdDokter.value,
        'kd_pj': selectedKdPenjab.value
      };
      print(body);
      BookingProvider()
          .postBooking(
              'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/booking',
              body)
          .then((res) {
        print(res.bodyString);
        DialogHelper.hideLoading();
        if (res.statusCode == 200) {
          Get.dialog(
            MLBookedDialog(
              desc: res.body['message'],
            ),
          );
        }
      });
    } catch (e) {
      print(e);
      DialogHelper.hideLoading();
    }
  }

  // cekBookingReg() {
  //   try {
  //     Future.delayed(
  //       Duration(seconds: 3),
  //     );
  //     var body = {
  //       'no_rkm_medis': '165056',
  //     };
  //     BookingProvider()
  //         .post(
  //             'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/cekbookingreg',
  //             body)
  //         .then((res) {
  //       if (res.statusCode == 200) {
  //         selectedJam.value = res.body['data']['tanggal_periksa'];
  //         selectedDokter.value = res.body['data']['nm_dokter'];
  //         selectedKdPoli.value = res.body['data']['nm_poli'];
  //         selectedPenjab.value = res.body['data']['png_jawab'];
  //         BuildContext context = Get.context!;
  //         MLCheckBookingList().launch(context);
  //       }
  //     });
  //   } catch (e) {}
  // }
}
