import 'package:get/get.dart';

import '../controllers/cek_status_booking_controller.dart';

class CekStatusBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      CekStatusBookingController(),
    );
  }
}
