import 'dart:convert';

import 'package:ALPOKAT/app/api/url.dart';
import 'package:ALPOKAT/app/modules/profile/models/StatistikPasienModel.dart';
import 'package:ALPOKAT/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../api/login_session.dart';
import '../../../api/rest_api.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final _restApi = Get.put(RestApi());
  final session = Get.put(LoginSession());
  var statistikPasien = <StatistikPasienModel>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    _restApi
        .getService(urlJumlahKunjungan + '?no_rkm_medis=${session.rkm.val}')
        .then((value) {
      if (value.statusCode == 200) {
        statistikPasien.value =
            statistikPasienModelFromJson(json.encode(value.body['data']));
      }
    });
    super.onReady();
  }

  @override
  void onClose() {}

  logOut() {
    session.rkm.val = '';
    session.password.val = '';
    Get.offAllNamed(Routes.LOGIN);
  }
}
