import 'package:get/get.dart';

import '../controllers/pengaduan_controller.dart';

class PengaduanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PengaduanController());
  }
}
