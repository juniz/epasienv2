import 'package:ALPOKAT/app/modules/register/models/ListPoliklinikModel.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RegisterProvider extends GetConnect {
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

  Future<List<ListPoliklinikModel>> fetchPoliklinik() async {
    final respone = await get('apm/listpoliklinik');
    //print(respone.bodyString);
    return listPoliklinikModelFromJson(respone.bodyString!);
  }

  Future<Response> postPaienBaru(var body) async {
    final response = await post('apm/pasienbaru', body);
    return response;
  }

  Future<Response> cekStatusBooking(var body) async {
    final response = await post('apm/statusbookingperiksa', body);
    return response;
  }
}
