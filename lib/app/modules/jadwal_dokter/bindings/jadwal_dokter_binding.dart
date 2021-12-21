import 'package:get/get.dart';

import '../controllers/jadwal_dokter_controller.dart';

class JadwalDokterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JadwalDokterController>(
      () => JadwalDokterController(),
    );
  }
}
