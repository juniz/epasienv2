import 'package:epasien/app/modules/fasilitas_tarif/models/radiologi_model.dart';
import 'package:epasien/app/modules/fasilitas_tarif/providers/radiologi_provider.dart';
import 'package:get/get.dart';

class RadiologiController extends GetxController {
  //TODO: Implement RadiologicontrollerController

  var listRadiologi = <RadiologiModel>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    RadiologiProvider()
        .fetchRadiologi()
        .then((value) => listRadiologi.value = value);
    super.onReady();
  }

  @override
  void onClose() {}
}
