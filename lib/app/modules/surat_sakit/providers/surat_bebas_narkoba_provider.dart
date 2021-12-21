import 'package:epasien/app/modules/surat_sakit/models/DataSuratSakitModel.dart';
import 'package:epasien/app/modules/surat_sakit/models/LIstSuratNarkobaModel.dart';
import 'package:get/get.dart';

class SuratBebasNarkobaProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<List<ListSuratNarkobaModel>> fetchListSuratNarkoba(
      dynamic body) async {
    final response = await post(
        'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/suratnarkoba',
        body);

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return listSuratNarkobaModelFromJson(response.bodyString!);
    }
  }

  Future<DataSuratNarkobaModel> fetchDataSuratNarkoba(dynamic body) async {
    final response = await post(
        'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/datasuratnarkoba',
        body);

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return dataSuratNarkobaModelFromJson(response.bodyString!);
    }
  }
}
