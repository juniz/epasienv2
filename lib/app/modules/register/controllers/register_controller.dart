import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController

  final tglLahir = "".obs;
  final tglLahirSelected = DateTime.now().obs;
  late TextEditingController namaController;
  late TextEditingController emailController;
  late TextEditingController tglLahirController;
  late TextEditingController hpController;
  late TextEditingController alamatController;
  @override
  void onInit() {
    namaController = new TextEditingController();
    emailController = new TextEditingController();
    tglLahirController = new TextEditingController();
    hpController = new TextEditingController();
    alamatController = new TextEditingController();
    tglLahirController.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    namaController.dispose();
    emailController.dispose();
    tglLahirController.dispose();
    hpController.dispose();
    alamatController.dispose();
  }

  setTglLahir(DateTime date) {
    tglLahir.value = DateFormat("yyyy-MM-dd").format(date);
    tglLahirController.text = DateFormat("dd/MM/yyyy").format(date);
    tglLahirSelected.value = date;
  }
}
