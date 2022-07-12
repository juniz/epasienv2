import 'dart:async';

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
      if (response.statusCode == 200) {
        final data = response.body['data'];
        session.rkm.val = data['no_rkm_medis'].toString();
        session.password.val = data['password'].toString();
        session.nama.val = data['nm_pasien'];
        session.nip.val = data['nip'];
        session.email.val = data['email'];
        session.telp.val = data['no_tlp'];
        session.tmpLahir.val = data['tmp_lahir'];
        session.jk.val = data['jk'];
        session.noPeserta.val = data['no_peserta'];
        session.token.val = response.body['token'];
        // log(session.rkm.val);
      }
      return response;
    } catch (e) {
      if (e.toString().contains('SocketException')) {
        return Future.error('Koneksi ke server gagal');
      }
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
      if (e.toString().contains('SocketException')) {
        return Future.error('Koneksi ke server gagal');
      }
      return Future.error(e);
    }
  }
}
