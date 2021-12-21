import 'dart:io';

import 'package:epasien/app/modules/surat_sakit/models/data_surat_sakit_model.dart';
import 'package:epasien/app/modules/surat_sakit/models/surat_sakit_model.dart';
import 'package:get/get.dart';

class SuratSakitProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<List<SuratSakitModel>> fetchSuratSakit(dynamic body) async {
    final response = await post(
        'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/suratsakit',
        body);

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return suratSakitModelFromJson(response.bodyString!);
    }
  }

  Future<DataSuratSakitModel> fetchDataSuratSakit(dynamic body) async {
    final response = await post(
        'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/datasuratsakit',
        body);

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return dataSuratSakitModelFromJson(response.bodyString!);
    }
  }

  Future<Response> fetchBarcode(dynamic body) async {
    final response = await post(
        'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/barcode',
        body);

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response;
    }
  }
}
