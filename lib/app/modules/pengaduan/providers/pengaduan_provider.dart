import 'package:ALPOKAT/app/modules/pengaduan/models/jawaban_pengaduan_model.dart';
import 'package:ALPOKAT/app/modules/pengaduan/models/pengaduan_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nb_utils/nb_utils.dart';

class PengaduanProvider extends GetConnect {
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

  Future<Response> kirimPengaduan(var body) async {
    final response = await post("apm/kirimpengaduan", body);
    print(response.bodyString);
    if (response.status.hasError) {
      toast(response.statusText!);
      return Future.error(response.statusText!);
    } else {
      return response;
    }
  }

  Future<List<PengaduanModel>> pengaduan(var body) async {
    final response = await post("apm/pengaduan", body);
    if (response.status.hasError) {
      toast(response.statusText!);
      return Future.error(response.statusText!);
    } else {
      return pengaduanModelFromJson(response.bodyString!);
    }
  }

  Future<Response> jawabanPengaduan(var body) async {
    final response = await post("apm/jawabanpengaduan", body);
    print(response.bodyString);
    if (response.status.hasError) {
      toast(response.statusText!);
      return Future.error(response.statusText!);
    } else {
      return response;
    }
  }
}
