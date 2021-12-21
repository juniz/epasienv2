import 'package:epasien/app/modules/surat_sakit/models/SuratKontrolModel.dart';
import 'package:get/get.dart';

class SuratKontrolProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<List<SuratKontrolModel>> fetchSuratKontrol(dynamic body) async {
    final response = await post(
        'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/suratkontrol',
        body);

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return suratKontrolModelFromJson(response.bodyString!);
    }
  }
}
