import 'package:ALPOKAT/app/modules/fasilitas_tarif/models/operasi_model.dart';
import 'package:ALPOKAT/app/modules/fasilitas_tarif/providers/operasi_provider.dart';
import 'package:get/get.dart';

class OperasiController extends GetxController {
  //TODO: Implement OperasiController

  final _apiProvider = GetInstance().put(OperasiProvider());
  var listOperasi = <OperasiModel>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    _apiProvider.fetchOperasi().then(
          (value) => listOperasi.value = value,
        );
    super.onReady();
  }

  @override
  void onClose() {}
}
