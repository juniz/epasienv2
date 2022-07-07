import 'dart:convert';

import 'package:ALPOKAT/app/api/url.dart';
import 'package:ALPOKAT/app/modules/register/models/ListPoliklinikModel.dart';
import 'package:ALPOKAT/app/routes/app_pages.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:ALPOKAT/app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../api/rest_api.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController
  final _restApi = GetInstance().put(RestApi());
  final tglLahir = "".obs;
  final tglLahirSelected = DateTime.now().obs;
  final tglBooking = "".obs;
  final tglBookingSelected = DateTime.now().add(Duration(days: 1)).obs;
  late TextEditingController namaController;
  late TextEditingController emailController;
  late TextEditingController tglLahirController;
  late TextEditingController tglBookingController;
  late TextEditingController hpController;
  late TextEditingController alamatController;
  late TextEditingController pesanController;
  final listPoliklinik = <ListPoliklinikModel>[].obs;
  final valuePoli = ''.obs;
  final kdPoli = ''.obs;
  final nmPoli = ''.obs;
  final box = GetStorage();
  final bookingPeriksa = Map<String, dynamic>().obs;
  @override
  void onInit() {
    _restApi.getService(urlPoliklinik).then((value) {
      if (value.statusCode == 200) {
        kdPoli.value = value.body['data'][0]['kd_poli'];
        listPoliklinik.value =
            listPoliklinikModelFromJson(json.encode(value.body['data']));
      }
    });
    namaController = new TextEditingController();
    emailController = new TextEditingController();
    tglLahirController = new TextEditingController();
    tglBookingController = new TextEditingController();
    hpController = new TextEditingController();
    alamatController = new TextEditingController();
    pesanController = new TextEditingController();
    tglLahirController.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
    tglBookingController.text =
        DateFormat("dd/MM/yyyy").format(DateTime.now().add(Duration(days: 1)));
    super.onInit();
  }

  @override
  void onReady() {
    bookingPeriksa.value = box.read('bookingPeriksa');
    if (bookingPeriksa.isNotEmpty) {
      cekStatusBooking();
    }
    super.onReady();
  }

  @override
  void onClose() {
    namaController.dispose();
    emailController.dispose();
    tglLahirController.dispose();
    hpController.dispose();
    alamatController.dispose();
    pesanController.dispose();
  }

  void cekStatusBooking() {
    Future.delayed(
      Duration.zero,
      () => DialogHelper.showLoading('Loading.....'),
    );
    _restApi
        .getService(urlStatusBooking +
            '?no_booking=${bookingPeriksa.value['no_booking'].toString()}&no_hp=${bookingPeriksa.value['hp'].toString()}')
        .then(
      (res) {
        // print(res.bodyString);
        // print(res.statusCode);
        DialogHelper.hideLoading();
        if (res.statusCode == 201) {
          if (bookingPeriksa.isNotEmpty) {
            box.remove('bookingPeriksa');
            bookingPeriksa.value.clear();
          }
          Get.offNamed(Routes.LOGIN);
          Get.snackbar(
            'Notifikasi',
            res.body['meta']['message'],
            icon: const Icon(Icons.add_alert_outlined, color: Colors.white),
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
        } else if (res.statusCode == 200) {
          if (res.body['meta']['message'] == 'Diterima') {
            Get.defaultDialog(
              title: "Booking Anda diterima",
              content: Column(
                children: [
                  Table(
                    children: [
                      TableRow(
                        children: [
                          Text('No. RM', style: boldTextStyle()),
                          Text(':', style: primaryTextStyle()),
                          Text(res.body['no_rkm_medis'],
                              style: boldTextStyle()),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text('Password', style: boldTextStyle()),
                          Text(':', style: primaryTextStyle()),
                          Text(
                              DateFormat('ddMMyyyy').format(DateTime.parse(
                                  bookingPeriksa.value['tgl_lahir'])),
                              style: boldTextStyle()),
                        ],
                      ),
                    ],
                  ),
                  8.height,
                  Text(
                      'Silahkan login dengan No Rekam Medis dan Tanggal Lahir Anda'),
                ],
              ).paddingAll(16),
              onConfirm: () => Get.offNamed(Routes.LOGIN),
              confirmTextColor: Colors.white,
            );
          } else {
            Get.snackbar(
              'Notifikasi',
              res.body['meta']['message'],
              icon: const Icon(Icons.add_alert_outlined, color: Colors.white),
              snackPosition: SnackPosition.TOP,
              backgroundColor: mlColorBgErrBottomSheet,
              colorText: mlColorBottomSheetText,
              borderRadius: 20,
              margin: const EdgeInsets.all(15),
              duration: const Duration(seconds: 5),
              isDismissible: true,
              dismissDirection: SnackDismissDirection.HORIZONTAL,
              forwardAnimationCurve: Curves.easeOutBack,
            );
          }
        }
      },
    ).catchError((e) {
      DialogHelper.hideLoading();
      Get.snackbar(
        'Notifikasi',
        e,
        icon: const Icon(Icons.add_alert_outlined, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        backgroundColor: mlColorBgErrBottomSheet,
        colorText: mlColorBottomSheetText,
        borderRadius: 20,
        margin: const EdgeInsets.all(15),
        duration: const Duration(seconds: 5),
        isDismissible: true,
        dismissDirection: SnackDismissDirection.HORIZONTAL,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    });
  }

  setTglLahir(DateTime date) {
    tglLahir.value = DateFormat("yyyy-MM-dd").format(date);
    tglLahirController.text = DateFormat("dd/MM/yyyy").format(date);
    tglLahirSelected.value = date;
  }

  setTglBooking(DateTime date) {
    tglBooking.value = DateFormat("yyyy-MM-dd").format(date);
    tglBookingController.text = DateFormat("dd/MM/yyyy").format(date);
    tglBookingSelected.value = date;
  }

  getNamaPoli(String? kdPoli) {
    listPoliklinik.value.forEach((element) {
      if (element.kdPoli == kdPoli) {
        nmPoli.value = element.nmPoli!;
        print(nmPoli.value);
      }
    });
  }

  postPasienBaru() async {
    Future.delayed(
      Duration.zero,
      () => DialogHelper.showLoading('Loading.....'),
    );
    var body = {
      'nama': namaController.text,
      'alamat': alamatController.text,
      'hp': hpController.text,
      'email': emailController.text,
      'tgl_daftar': tglBooking.value,
      'tgl_lahir': tglLahir.value,
      'pesan': pesanController.text,
      'kd_poli': kdPoli.value,
    };
    _restApi.postService(urlRegister, body).then((value) {
      DialogHelper.hideLoading();
      print(value.bodyString);
      if (value.statusCode == 200) {
        var data = {
          'no_booking': value.body['no_booking'],
          'nama': namaController.text,
          'alamat': alamatController.text,
          'hp': hpController.text,
          'email': emailController.text,
          'tgl_daftar': tglBooking.value,
          'tgl_lahir': tglLahir.value,
          'pesan': pesanController.text,
          'kd_poli': nmPoli.value,
        };
        box.write('bookingPeriksa', data);
        Get.offNamed(Routes.LOGIN);
        Get.snackbar(
          'Notifikasi',
          value.body['meta']['message'],
          icon: const Icon(Icons.add_alert_outlined, color: Colors.white),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          borderRadius: 20,
          margin: const EdgeInsets.all(15),
          duration: const Duration(seconds: 5),
          isDismissible: true,
          dismissDirection: SnackDismissDirection.HORIZONTAL,
          forwardAnimationCurve: Curves.easeOutBack,
        );
      } else if (value.statusCode == 201) {
        Get.snackbar(
          'Peringatan',
          value.body['meta']['message'],
          icon: const Icon(Icons.add_alert_outlined, color: Colors.white),
          snackPosition: SnackPosition.TOP,
          backgroundColor: mlColorBgErrBottomSheet,
          colorText: mlColorBottomSheetText,
          borderRadius: 20,
          margin: const EdgeInsets.all(15),
          duration: const Duration(seconds: 5),
          isDismissible: true,
          dismissDirection: SnackDismissDirection.HORIZONTAL,
          forwardAnimationCurve: Curves.easeOutBack,
        );
      } else {}
    }).catchError((e) {
      Get.snackbar(
        'Error',
        e,
        icon: const Icon(Icons.add_alert_outlined, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        backgroundColor: mlColorBgErrBottomSheet,
        colorText: mlColorBottomSheetText,
        borderRadius: 20,
        margin: const EdgeInsets.all(15),
        duration: const Duration(seconds: 5),
        isDismissible: true,
        dismissDirection: SnackDismissDirection.HORIZONTAL,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    });
  }
}
