import 'package:epasien/app/modules/fasilitas_tarif/models/laborat_model.dart';
import 'package:get/get.dart';

class LaboratProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<List<LaboratModel>> fetchLaborat() async {
    final response = await get(
        'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/laborat');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return laboratModelFromJson(response.bodyString!);
    }
  }
}
