import 'package:ALPOKAT/app/modules/login/providers/login_provider.dart';
import 'package:ALPOKAT/app/routes/app_pages.dart';
import 'package:ALPOKAT/app/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final box = GetStorage();
  final bookingPeriksa = Map<String, dynamic>().obs;
  final _provider = GetInstance().put(LoginProvider());
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
    bookingPeriksa.value = box.read('bookingPeriksa');
    super.onReady();
  }

  @override
  void onClose() {}

  login() async {
    Future.delayed(
      Duration(seconds: 3),
      DialogHelper.showLoading('Loading...'),
    );
    final status = await OneSignal.shared.getDeviceState();
    final String? osUserID = status?.userId;
    _provider.login({
      'username': username.text,
      'password': password.text,
      'app_id': osUserID
    }).then((value) {
      // print(value.bodyString);
      if (value.statusCode == 200) {
        DialogHelper.hideLoading();
        toast('Data Pasien Ditemukan');
        GetStorage().write('pasien', value.body);
        Get.offAllNamed(Routes.DASHBOARD);
      } else {
        DialogHelper.hideLoading();
        Get.snackbar(
          'Peringatan',
          value.body['message']!,
          backgroundColor: white,
        );
      }
    });
  }
}
