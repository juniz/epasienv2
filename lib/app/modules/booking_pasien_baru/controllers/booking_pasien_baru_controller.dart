import 'package:get/get.dart';
import 'package:smart_select/smart_select.dart';
import '../models/poliklinik_model.dart';
import '../providers/poliklinik_provider.dart';

class BookingPasienBaruController extends GetxController {
  //TODO: Implement BookingPasienBaruController
  var listPoliklinik = <PoliklinikModel>[].obs;
  var providers = new PoliklinikProvider();
  var value = '-'.obs;
  var options = [
    S2Choice<String>(value: '-', title: '-'),
  ].obs;

  @override
  void onInit() {
    getPoliklinik();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  getPoliklinik() {
    try {
      Future.delayed(
        Duration.zero,
      );
      providers
          .get(
              'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/poliklinik')
          .then((value) {
        listPoliklinik.value = poliklinikModelFromJson(value.bodyString!);
        options.value = listPoliklinik.value
            .map((e) => S2Choice<String>(value: e.kdPoli, title: e.nmPoli))
            .toList();
      });
    } catch (e) {
      print(e);
    }
  }
}
