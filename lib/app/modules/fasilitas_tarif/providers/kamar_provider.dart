import 'package:epasien/app/modules/fasilitas_tarif/models/kamar_model.dart';
import 'package:get/get.dart';

class KamarProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<List<KamarModel>> fetchKamar() async {
    final response = await get(
        'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/kamar');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return kamarModelFromJson(response.bodyString!);
    }
  }
}
