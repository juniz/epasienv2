import 'dart:convert';

import 'package:ALPOKAT/app/api/url.dart';
import 'package:ALPOKAT/app/modules/fasilitas_tarif/models/operasi_model.dart';
import 'package:get/get.dart';

import '../../../api/rest_api.dart';

class OperasiController extends GetxController {
  //TODO: Implement OperasiController

  final _restApi = Get.put(RestApi());
  var listOperasi = <OperasiModel>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    _restApi.getService(urlOperasi).then(
          (value) => listOperasi.value =
              operasiModelFromJson(json.encode(value.body['data'])),
        );
    super.onReady();
  }

  @override
  void onClose() {}
}
