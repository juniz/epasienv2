import 'dart:convert';

import 'package:ALPOKAT/app/api/url.dart';
import 'package:ALPOKAT/app/modules/fasilitas_tarif/models/laborat_model.dart';
import 'package:get/get.dart';

import '../../../api/rest_api.dart';

class LaboratController extends GetxController {
  //TODO: Implement LaboratController
  final _restApi = Get.put(RestApi());
  var listLaborat = <LaboratModel>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    _restApi.getService(urlLaborat).then(
          (value) => listLaborat.value =
              laboratModelFromJson(json.encode(value.body['data'])),
        );
    super.onReady();
  }

  @override
  void onClose() {}
}
