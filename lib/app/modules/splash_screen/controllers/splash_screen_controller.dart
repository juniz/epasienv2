import 'package:ALPOKAT/app/routes/app_pages.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:get/get.dart';
import '../../../api/login_api.dart';
import '../../../api/login_session.dart';

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController
  final restApi = Get.put(LoginApi());
  final session = Get.find<LoginSession>();
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
    final username = session.rkm;
    final password = session.password;
    final body = {
      'username': username,
      'password': password,
    };
    Future.delayed(Duration(seconds: 3), () {
      restApi.login(body).then((value) {
        if (value.body['message'] == 'OK') {
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
