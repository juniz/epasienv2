import 'dart:io';

import 'package:ALPOKAT/app/modules/surat_sakit/models/data_surat_sakit_model.dart';
import 'package:ALPOKAT/app/modules/surat_sakit/models/surat_sakit_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SuratSakitProvider extends GetConnect {
  final rumkit = GetStorage().read('rumkit');
  @override
  void onInit() {
    httpClient.baseUrl = rumkit['urlBase'];

    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = "Bearer ${GetStorage().read('token')}";
      return request;
    });

    httpClient.addAuthenticator<dynamic>((request) async {
      final response = await post("token",
          {'username': rumkit['username'], 'password': rumkit['password']});

      final token = response.body['data']['token'];
      // xtoken.value = token;
      GetStorage().write('token', token);

      // Set the header
      request.headers['Authorization'] = "Bearer $token";
      return request;
    });

    //Autenticator will be called 3 times if HttpStatus is
    //HttpStatus.unauthorized
    httpClient.maxAuthRetries = 3;
  }

  Future<List<SuratSakitModel>> fetchSuratSakit(dynamic body) async {
    final response = await post('apm/suratsakit', body);

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return suratSakitModelFromJson(response.bodyString!);
    }
  }

  Future<DataSuratSakitModel> fetchDataSuratSakit(dynamic body) async {
    final response = await post('apm/datasuratsakit', body);

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return dataSuratSakitModelFromJson(response.bodyString!);
    }
  }

  Future<Response> fetchBarcode(dynamic body) async {
    final response = await post('apm/barcode', body);

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return response;
    }
  }
}
