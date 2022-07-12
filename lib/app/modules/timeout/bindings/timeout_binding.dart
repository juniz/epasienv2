import 'package:get/get.dart';

import '../controllers/timeout_controller.dart';

class TimeoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimeoutController>(
      () => TimeoutController(),
    );
  }
}
