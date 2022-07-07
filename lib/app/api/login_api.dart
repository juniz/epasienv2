import 'package:get/get.dart';

import 'login_session.dart';
import 'url.dart';

class LoginApi extends GetConnect {
  final session = Get.put(LoginSession());
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    httpClient.baseUrl = urlBase;
    httpClient.timeout = Duration(seconds: 30);
  }

  Future<Response> login(Map body) async {
    try {
      final response = await post(urlLogin, body);
      if (response.hasError) {
        return Future.error(response.statusText!);
      }
      if (response.body['message'] == 'OK') {
        final data = response.body['data'];
        session.rkm.val = data['no_rkm_medis'];
        session.password.val = data['password'];
        session.nama.val = data['nm_pasien'];
        session.nip.val = data['nip'];
        session.email.val = data['email'];
        session.telp.val = data['no_tlp'];
        session.jk.val = data['jk'];
        session.noPeserta.val = data['no_peserta'];
        session.token.val = data['token'];
      }
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> register(Map body) async {
    try {
      final response = await post(urlRegister, body);
      if (response.hasError) {
        return Future.error(response.statusText!);
      }
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }
}
