import 'package:epasien/app/modules/riwayat_booking/models/RiwayatBookingModel.dart';
import 'package:get/get.dart';

class BookingProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<List<RiwayatBookingModel>> fetchRiwayatBooking(dynamic body) async {
    final response = await post(
        'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/riwayatbooking',
        body);
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return riwayatBookingModelFromJson(response.bodyString!);
    }
  }
}
