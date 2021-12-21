import 'package:epasien/app/modules/kedersediaan_kamar/models/BangsalKamar.dart';
import 'package:epasien/app/modules/kedersediaan_kamar/models/KelasKamar.dart';
import 'package:epasien/app/modules/kedersediaan_kamar/providers/ketersediaan_kamar_provider.dart';
import 'package:get/get.dart';

class KedersediaanKamarController extends GetxController {
  //TODO: Implement KedersediaanKamarController
  var listKelasKamar = <KelasKamarModel>[].obs;
  var listBangsalKamar = <BangsalKamarModel>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    KetersediaanKamarProvider()
        .fetchKelasKamar()
        .then((value) => listKelasKamar.value = value);
    KetersediaanKamarProvider()
        .fetchBangsalKamar()
        .then((value) => listBangsalKamar.value = value);
    super.onReady();
  }

  @override
  void onClose() {}
}
