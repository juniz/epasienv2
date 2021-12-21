import 'package:get/get.dart';

class BookingProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl =
        'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/';
  }

  Future<Response> postBooking(String path, Map<String, String> body) =>
      post(path, body);
}
