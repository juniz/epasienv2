import 'package:epasien/app/modules/profile/models/StatistikPasienModel.dart';
import 'package:epasien/app/modules/profile/providers/profile_provider.dart';
import 'package:epasien/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final pasien = GetStorage().read('pasien');
  ProfileProvider _provider = GetInstance().put(ProfileProvider());
  var statistikPasien = <StatistikPasienModel>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    _provider.fetchStatisticsPasien(
        {'no_rkm_medis': pasien['no_rkm_medis']}).then((value) {
      // print(value.bodyString);
      statistikPasien.value = value;
    });
    super.onReady();
  }

  @override
  void onClose() {}

  logOut() {
    GetStorage().remove('pasien');
    Get.offAllNamed(Routes.LOGIN);
  }
}
