import 'package:get/get.dart';

import '../controllers/surat_sakit_controller.dart';

class SuratSakitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      SuratSakitController(),
    );
  }
}
