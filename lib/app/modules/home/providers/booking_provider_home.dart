import 'package:ALPOKAT/app/modules/home/models/Homevisite.dart';
import 'package:ALPOKAT/app/modules/riwayat_booking/models/RiwayatBookingModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingProviderHome extends GetConnect {
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

  Future<List<RiwayatBookingModel>> fetchRiwayatBooking(dynamic body) async {
    final response = await post('apm/riwayatbooking', body);
    if (response.status.hasError) {
      Get.snackbar(
        'Error',
        'Koneksi internet lemah, silahkan ganti koneksi internet anda',
        colorText: white,
        backgroundColor: Colors.red,
      );
      return Future.error(response.statusText!);
    } else {
      return riwayatBookingModelFromJson(response.bodyString!);
    }
  }

  Future<RiwayatBookingModel> fetchRiwayatBookingDetail(dynamic body) async {
    final response = await post('apm/bookingdetail', body);
    if (response.status.hasError) {
      Get.snackbar(
        'Error',
        response.statusText!,
        colorText: white,
        backgroundColor: Colors.red,
      );
      return Future.error(response.statusText!);
    } else {
      return selectedRiwayatBookingModelFromJson(response.bodyString!);
    }
  }

  Future<Response> checkin(dynamic body) async {
    final response = await post('apm/checkin', body);

    return response;
  }

  Future<Response> batalCheckin(dynamic body) async {
    final response = await post('apm/checkin', body);
    if (response.status.hasError) {
      Get.snackbar(
        'Error',
        response.statusText!,
        colorText: white,
        backgroundColor: Colors.red,
      );
      return Future.error(response.statusText!);
    } else {
      return response;
    }
  }

  Future<Response> postHomevisite(var body) async {
    final response = await post("apm/daftarhomevisite", body);
    // print(response.bodyString);
    return response;
  }

  Future<HomeVisiteModel> fetchHomevisite(var body) async {
    final response = await post("apm/homevisite", body);
    print(response.bodyString);
    return homeVisiteModelFromJson(response.bodyString!);
  }
}
