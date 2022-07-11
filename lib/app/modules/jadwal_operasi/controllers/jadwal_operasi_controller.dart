import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../api/rest_api.dart';
import '../../../api/url.dart';
import '../models/jadwal_operasi_model.dart';

class JadwalOperasiController extends GetxController {
  final _restApi = Get.put(RestApi());
  final jadwalOperasi = JadwalOperasi().obs;
  final isLoading = true.obs;
  final isEmpty = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getJadwalOperasi();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getJadwalOperasi() {
    Future.delayed(
      Duration(seconds: 1),
      () => _restApi.getService(urlJadwalOperasi).then(
        (value) {
          isLoading(false);
          if (value.statusCode == 200) {
            jadwalOperasi.value = jadwalOperasFromJson(value.bodyString!);
          } else if (value.statusCode == 201) {
            isEmpty(true);
          }
        },
      ).catchError((error) {
        isLoading(false);
        isEmpty(true);
        Get.snackbar(
          'Error',
          error.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }),
    );
  }
}
