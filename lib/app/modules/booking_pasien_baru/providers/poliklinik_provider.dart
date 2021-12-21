import 'package:get/get.dart';

class PoliklinikProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl =
        'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/poliklinik';
  }
}
