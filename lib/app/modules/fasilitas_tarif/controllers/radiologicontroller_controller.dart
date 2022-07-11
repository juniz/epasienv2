import 'dart:convert';

import 'package:ALPOKAT/app/api/url.dart';
import 'package:ALPOKAT/app/modules/fasilitas_tarif/models/radiologi_model.dart';
import 'package:get/get.dart';

import '../../../api/rest_api.dart';

class RadiologiController extends GetxController {
  //TODO: Implement RadiologicontrollerController
  final _restApi = Get.put(RestApi());
  var listRadiologi = <RadiologiModel>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    _restApi.getService(urlRadiologi).then((value) => listRadiologi.value =
        radiologiModelFromJson(json.encode(value.body['data'])));
    super.onReady();
  }

  @override
  void onClose() {}
}
