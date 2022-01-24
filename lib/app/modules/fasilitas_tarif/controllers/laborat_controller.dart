import 'package:ALPOKAT/app/modules/fasilitas_tarif/models/laborat_model.dart';
import 'package:ALPOKAT/app/modules/fasilitas_tarif/providers/laborat_provider.dart';
import 'package:get/get.dart';

class LaboratController extends GetxController {
  //TODO: Implement LaboratController
  final _apiProvider = GetInstance().put(LaboratProvider());
  var listLaborat = <LaboratModel>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    _apiProvider.fetchLaborat().then(
          (value) => listLaborat.value = value,
        );
    super.onReady();
  }

  @override
  void onClose() {}
}
