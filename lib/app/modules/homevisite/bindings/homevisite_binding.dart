import 'package:get/get.dart';

import '../controllers/homevisite_controller.dart';

class HomevisiteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomevisiteController>(
      () => HomevisiteController(),
    );
  }
}
