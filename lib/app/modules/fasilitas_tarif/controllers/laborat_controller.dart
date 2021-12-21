import 'package:epasien/app/modules/fasilitas_tarif/models/laborat_model.dart';
import 'package:epasien/app/modules/fasilitas_tarif/providers/laborat_provider.dart';
import 'package:get/get.dart';

class LaboratController extends GetxController {
  //TODO: Implement LaboratController

  var listLaborat = <LaboratModel>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    LaboratProvider().fetchLaborat().then(
          (value) => listLaborat.value = value,
        );
    super.onReady();
  }

  @override
  void onClose() {}
}
