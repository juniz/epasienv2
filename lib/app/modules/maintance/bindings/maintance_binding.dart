import 'package:get/get.dart';

import '../controllers/maintance_controller.dart';

class MaintanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MaintanceController>(
      () => MaintanceController(),
    );
  }
}
