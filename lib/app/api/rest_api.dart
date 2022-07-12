import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'login_api.dart';
import 'login_session.dart';
import 'url.dart';

class RestApi extends GetConnect {
  final _loginRest = Get.put(LoginApi());
  final _session = Get.find<LoginSession>();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    httpClient.baseUrl = urlBase;
    httpClient.timeout = Duration(seconds: 30);

    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Content-Type'] = 'application/json';
      request.headers['Authorization'] = 'Bearer ${_session.token.val}';
      return request;
    });

    httpClient.addAuthenticator<dynamic>((request) async {
      final body = {
        'username': _session.rkm.val,
        'password': _session.password.val,
      };
      final response = await _loginRest.login(body);
      final token = response.body['token'];
      // Set the header
      request.headers['Authorization'] = "Bearer $token";
      return request;
    });
    httpClient.maxAuthRetries = 3;
  }

  Future<Response> postService(String url, Map body) async {
    try {
      final response = await post(url, body);
      if (response.hasError) {
        return Future.error(response.statusText!);
      }
      return response;
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        return Future.error('Koneksi ke server gagal');
      }
      return Future.error(e);
    }
  }

  Future<Response> getService(String url) async {
    try {
      final response = await get(url);
      if (response.hasError) {
        return Future.error(response.statusText!);
      } else {
        return response;
      }
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        return Future.error('Koneksi ke server gagal');
      }
      return Future.error(e);
    }
  }
}
