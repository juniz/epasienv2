import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:ALPOKAT/app/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../api/login_api.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final bookingPeriksa = Map<String, dynamic>().obs;
  final _restApi = Get.put(LoginApi());
  late TextEditingController username;
  late TextEditingController password;
  @override
  void onInit() {
    username = new TextEditingController();
    password = new TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  login() async {
    Future.delayed(
      Duration(seconds: 2),
      DialogHelper.showLoading('Loading...'),
    );
    _restApi.login({
      'username': username.text,
      'password': password.text,
    }).then((value) {
      log(value.bodyString);
      if (value.statusCode == 200) {
        DialogHelper.hideLoading();
        toasty(Get.overlayContext!, value.body['meta']['message']);
        Get.offAllNamed(Routes.DASHBOARD);
      } else {
        DialogHelper.hideLoading();
        Get.snackbar(
          'Peringatan',
          value.body['meta']['message']!,
          icon: Icon(LineIcons.bell, color: mlColorBottomSheetText),
          backgroundColor: mlColorBgErrBottomSheet,
          colorText: mlColorBottomSheetText,
        );
      }
    }).catchError((e) {
      DialogHelper.hideLoading();
      Get.snackbar(
        'Error',
        e,
        icon: Icon(LineIcons.bell, color: mlColorBottomSheetText),
        backgroundColor: mlColorBgErrBottomSheet,
        colorText: mlColorBottomSheetText,
      );
    });
  }
}
