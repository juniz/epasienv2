import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class SplashScreenProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl =
        'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/';

    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Accept'] = 'application/json';
      return request;
    });
  }

  Future<Response> rumkit() async {
    final response = await get('apm/rumkit');
    if (response.status.hasError) {
      Get.snackbar(
        'Error',
        'Koneksi internet lemah, silahkan ganti koneksi internet anda',
        colorText: white,
        backgroundColor: Colors.red,
      );
      return Future.error(response.statusText!);
    } else {
      return response;
    }
  }

  Future<Response> getToken(var body) async {
    final response = await post('token', body);
    return response;
  }
}
