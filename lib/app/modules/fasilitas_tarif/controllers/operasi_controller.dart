import 'package:epasien/app/modules/fasilitas_tarif/models/operasi_model.dart';
import 'package:epasien/app/modules/fasilitas_tarif/providers/operasi_provider.dart';
import 'package:get/get.dart';

class OperasiController extends GetxController {
  //TODO: Implement OperasiController

  var listOperasi = <OperasiModel>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    OperasiProvider().fetchOperasi().then(
          (value) => listOperasi.value = value,
        );
    super.onReady();
  }

  @override
  void onClose() {}
}
