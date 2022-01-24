import 'package:ALPOKAT/app/modules/surat_sakit/models/SuratRujukanDataModel.dart';
import 'package:ALPOKAT/app/modules/surat_sakit/models/SuratRujukanModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:get/get_connect/http/src/request/request.dart';
import 'package:nb_utils/nb_utils.dart';

class SuratRujukanProvider extends GetConnect {
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

  Future<List<SuratRujukanModel>> fetchSuratSakit(dynamic body) async {
    final response = await post('apm/suratrujukan', body);

    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return suratRujukanModelFromJson(response.bodyString!);
    }
  }

  Future<SuratRujukanDataModel> fetchDataSuratRujukan(dynamic body) async {
    final response = await post('apm/datasuratrujukan', body,
        headers: {'Accept': 'application/json'});
    // print(response.statusCode);
    if (response.status.hasError) {
      Get.snackbar(
        'Error',
        response.statusText!,
        colorText: white,
        backgroundColor: Colors.red,
      );
      return Future.error(response.statusText!);
    } else {
      return suratRujukanDataModelFromJson(response.bodyString!);
    }
  }
}
