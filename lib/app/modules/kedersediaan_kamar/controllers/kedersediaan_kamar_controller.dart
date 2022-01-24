import 'package:ALPOKAT/app/modules/kedersediaan_kamar/models/BangsalKamar.dart';
import 'package:ALPOKAT/app/modules/kedersediaan_kamar/models/KelasKamar.dart';
import 'package:ALPOKAT/app/modules/kedersediaan_kamar/providers/ketersediaan_kamar_provider.dart';
import 'package:get/get.dart';

class KedersediaanKamarController extends GetxController {
  //TODO: Implement KedersediaanKamarController
  var listKelasKamar = <KelasKamarModel>[].obs;
  var listBangsalKamar = <BangsalKamarModel>[].obs;
  KetersediaanKamarProvider _kamarProvider =
      GetInstance().find<KetersediaanKamarProvider>();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    _kamarProvider
        .fetchKelasKamar()
        .then((value) => listKelasKamar.value = value);
    _kamarProvider
        .fetchBangsalKamar()
        .then((value) => listBangsalKamar.value = value);
    super.onReady();
  }

  @override
  void onClose() {}
}
