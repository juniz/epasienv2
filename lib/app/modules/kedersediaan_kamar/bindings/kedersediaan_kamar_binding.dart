import 'package:get/get.dart';

import '../controllers/kedersediaan_kamar_controller.dart';

class KedersediaanKamarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KedersediaanKamarController>(
      () => KedersediaanKamarController(),
    );
  }
}
