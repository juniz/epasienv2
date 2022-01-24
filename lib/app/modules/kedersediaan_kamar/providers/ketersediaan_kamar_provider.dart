import 'package:ALPOKAT/app/modules/kedersediaan_kamar/models/BangsalKamar.dart';
import 'package:ALPOKAT/app/modules/kedersediaan_kamar/models/KelasKamar.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get_storage/get_storage.dart';

class KetersediaanKamarProvider extends GetConnect {
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

  Future<List<KelasKamarModel>> fetchKelasKamar() async {
    final response = await get('apm/kelaskamar');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return kelasKamarModelFromJson(response.bodyString!);
    }
  }

  Future<List<BangsalKamarModel>> fetchBangsalKamar() async {
    final response = await get('apm/bangsalkamar');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return bangsalKamarModelFromJson(response.bodyString!);
    }
  }
}
