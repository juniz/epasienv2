import 'package:ALPOKAT/app/modules/login/providers/login_provider.dart';
import 'package:ALPOKAT/app/modules/splash_screen/providers/splash_screen_provider.dart';
import 'package:ALPOKAT/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController

  final _provider = Get.put(SplashScreenProvider());
  final _loginprovider = Get.put(LoginProvider());
  @override
  void onInit() async {
    await getDataRumkit();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  getDataRumkit() async {
    Future.delayed(
      Duration(seconds: 3),
    );
    final status = await OneSignal.shared.getDeviceState();
    final String? osUserID = status?.userId;
    _provider.rumkit().then(
      (value) async {
        print(value.body);
        if (value.statusCode == 200) {
          var token = await _provider.getToken({
            'username': value.body['username'],
            'password': value.body['password']
          });
          // print(value.bodyString);
          GetStorage().write('token', token.body['data']['token']);
          await GetStorage().write('rumkit', value.body);
          var pasien = GetStorage().read('pasien');
          if (pasien != null) {
            final status = await OneSignal.shared.getDeviceState();
            final String? osUserID = status?.userId;
            var loginRes = await _loginprovider.login({
              'username': pasien['no_rkm_medis'],
              'password': pasien['tgl_lahir'],
              'app_id': osUserID,
            });
            if (loginRes.statusCode == 200) {
              GetStorage().write('pasien', loginRes.body);
              Get.offAllNamed(Routes.DASHBOARD);
            } else {
              Get.offNamed('login');
            }
          } else {
            Get.offNamed('login');
          }
        }
      },
    );
  }
}
