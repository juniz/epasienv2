import 'package:epasien/app/modules/kedersediaan_kamar/models/BangsalKamar.dart';
import 'package:epasien/app/modules/kedersediaan_kamar/models/KelasKamar.dart';
import 'package:get/get.dart';

class KetersediaanKamarProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<List<KelasKamarModel>> fetchKelasKamar() async {
    final response = await get(
        'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/kelaskamar');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return kelasKamarModelFromJson(response.bodyString!);
    }
  }

  Future<List<BangsalKamarModel>> fetchBangsalKamar() async {
    final response = await get(
        'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/bangsalkamar');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return bangsalKamarModelFromJson(response.bodyString!);
    }
  }
}
