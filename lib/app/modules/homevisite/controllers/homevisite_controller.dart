import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomevisiteController extends GetxController {
  //TODO: Implement HomevisiteController
  final pasien = GetStorage().read('pasien');

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  daftarHomevisite() {}
}
