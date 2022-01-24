import 'package:ALPOKAT/app/modules/kedersediaan_kamar/providers/ketersediaan_kamar_provider.dart';
import 'package:get/get.dart';

import '../controllers/kedersediaan_kamar_controller.dart';

class KedersediaanKamarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KetersediaanKamarProvider>(
      () => KetersediaanKamarProvider(),
    );
    Get.lazyPut<KedersediaanKamarController>(
      () => KedersediaanKamarController(),
    );
  }
}
