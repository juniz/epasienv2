import 'package:ALPOKAT/app/modules/fasilitas_tarif/models/radiologi_model.dart';
import 'package:ALPOKAT/app/modules/fasilitas_tarif/providers/radiologi_provider.dart';
import 'package:get/get.dart';

class RadiologiController extends GetxController {
  //TODO: Implement RadiologicontrollerController
  final _apiProvider = GetInstance().put(RadiologiProvider());
  var listRadiologi = <RadiologiModel>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    _apiProvider.fetchRadiologi().then((value) => listRadiologi.value = value);
    super.onReady();
  }

  @override
  void onClose() {}
}
