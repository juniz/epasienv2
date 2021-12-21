import 'package:get/get.dart';

import '../controllers/halaman_booking_controller.dart';

class HalamanBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      HalamanBookingController(),
    );
  }
}
