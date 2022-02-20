import 'package:ALPOKAT/app/modules/register/models/ListPoliklinikModel.dart';
import 'package:ALPOKAT/app/modules/register/providers/register_provider.dart';
import 'package:ALPOKAT/app/routes/app_pages.dart';
import 'package:ALPOKAT/app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController

  final tglLahir = "".obs;
  final tglLahirSelected = DateTime.now().add(Duration(days: 1)).obs;
  late TextEditingController namaController;
  late TextEditingController emailController;
  late TextEditingController tglLahirController;
  late TextEditingController hpController;
  late TextEditingController alamatController;
  late TextEditingController pesanController;
  final listPoliklinik = <ListPoliklinikModel>[].obs;
  final valuePoli = ''.obs;
  final kdPoli = ''.obs;
  final box = GetStorage();
  final bookingPeriksa = Map<String, dynamic>().obs;
  RegisterProvider _provider = GetInstance().put(RegisterProvider());
  @override
  void onInit() {
    _provider.fetchPoliklinik().then((value) {
      kdPoli.value = value[0].kdPoli!;
      listPoliklinik.value = value;
    });
    namaController = new TextEditingController();
    emailController = new TextEditingController();
    tglLahirController = new TextEditingController();
    hpController = new TextEditingController();
    alamatController = new TextEditingController();
    pesanController = new TextEditingController();
    tglLahirController.text =
        DateFormat("dd/MM/yyyy").format(DateTime.now().add(Duration(days: 1)));
    super.onInit();
  }

  @override
  void onReady() {
    bookingPeriksa.value = box.read('bookingPeriksa');
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

  setTglLahir(DateTime date) {
    tglLahir.value = DateFormat("yyyy-MM-dd").format(date);
    tglLahirController.text = DateFormat("dd/MM/yyyy").format(date);
    tglLahirSelected.value = date;
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
      'tgl_daftar': tglLahir.value,
      'pesan': pesanController.text,
      'kd_poli': kdPoli.value,
    };
    _provider.postPaienBaru(body).then((value) {
      DialogHelper.hideLoading();
      //print(value.body['message']);
      if (value.statusCode == 200) {
        var data = {
          'no_booking': value.body['no_booking'],
          'nama': namaController.text,
          'alamat': alamatController.text,
          'hp': hpController.text,
          'email': emailController.text,
          'tgl_daftar': tglLahir.value,
          'pesan': pesanController.text,
          'kd_poli': kdPoli.value,
        };
        box.write('bookingPeriksa', data);
        Get.offNamed(Routes.LOGIN);
      } else if (value.statusCode == 201) {
        Get.snackbar(
          'Peringatan',
          value.body['message'],
          icon: const Icon(Icons.add_alert_outlined, color: Colors.white),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.black,
          colorText: Colors.white,
          borderRadius: 20,
          margin: const EdgeInsets.all(15),
          duration: const Duration(seconds: 5),
          isDismissible: true,
          dismissDirection: SnackDismissDirection.HORIZONTAL,
          forwardAnimationCurve: Curves.easeOutBack,
        );
      } else {}
    });
  }
}
