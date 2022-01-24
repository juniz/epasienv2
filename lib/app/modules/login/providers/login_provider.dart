import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginProvider extends GetConnect {
  final rumkit = GetStorage().read('rumkit');

  @override
  void onInit() {
    httpClient.baseUrl =
        'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/';

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

  Future<Response> login(var body) async {
    final response = await post('apm/login', body);
    return response;
  }
}
