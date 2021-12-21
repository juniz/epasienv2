import 'package:epasien/app/modules/fasilitas_tarif/models/operasi_model.dart';
import 'package:get/get.dart';

class OperasiProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<List<OperasiModel>> fetchOperasi() async {
    final response = await get(
        'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/operasi');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return operasiModelFromJson(response.bodyString!);
    }
  }
}
