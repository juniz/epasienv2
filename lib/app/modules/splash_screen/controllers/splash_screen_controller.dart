import 'package:ALPOKAT/app/routes/app_pages.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:get/get.dart';
import '../../../../main.dart';
import '../../../api/login_api.dart';
import '../../../api/login_session.dart';
import '../../../utils/setting.dart';

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController
  final restApi = Get.put(LoginApi());
  final session = Get.find<LoginSession>();
  final isMaintance = Get.find<SettingsService>().read('maintance');
  // final session = Get.put(LoginSession());
  @override
  void onInit() async {
    await splashInit();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  splashInit() async {
    if (isMaintance == "true") {
      Future.delayed(Duration.zero, () {
        Get.offAllNamed(Routes.MAINTANCE);
      });
    } else {
      final username = session.rkm.val;
      final password = session.password.val;
      final body = {
        'username': username,
        'password': password,
      };
      Future.delayed(Duration(seconds: 3), () {
        restApi.login(body).then((value) {
          if (value.statusCode == 200) {
            Get.offAllNamed(Routes.DASHBOARD);
          } else {
            Get.offNamed('login');
          }
        }).catchError((e) {
          Get.offNamed('login');
          Get.snackbar(
            'Error',
            e,
            colorText: mlColorBottomSheetText,
            backgroundColor: mlColorBgErrBottomSheet,
          );
        });
      });
    }
  }
}
