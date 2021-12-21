import 'package:epasien/app/modules/fasilitas_tarif/models/radiologi_model.dart';
import 'package:get/get.dart';

class RadiologiProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<List<RadiologiModel>> fetchRadiologi() async {
    final response = await get(
        'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/radiologi');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return radiologiModelFromJson(response.bodyString!);
    }
  }
}
