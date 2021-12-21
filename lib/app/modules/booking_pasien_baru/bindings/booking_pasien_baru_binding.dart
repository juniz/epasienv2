import 'package:get/get.dart';

import '../controllers/booking_pasien_baru_controller.dart';

class BookingPasienBaruBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<BookingPasienBaruController>(
    //   () => BookingPasienBaruController(),
    // );
    Get.put(BookingPasienBaruController());
  }
}
