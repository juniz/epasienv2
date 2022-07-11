import 'package:get/get.dart';

import '../controllers/jadwal_operasi_controller.dart';

class JadwalOperasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(JadwalOperasiController());
  }
}
