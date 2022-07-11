import 'dart:convert';

import 'package:ALPOKAT/app/modules/kedersediaan_kamar/models/BangsalKamar.dart';
import 'package:ALPOKAT/app/modules/kedersediaan_kamar/models/KelasKamar.dart';
import 'package:ALPOKAT/app/modules/kedersediaan_kamar/providers/ketersediaan_kamar_provider.dart';
import 'package:get/get.dart';

import '../../../api/rest_api.dart';
import '../../../api/url.dart';

class KedersediaanKamarController extends GetxController {
  //TODO: Implement KedersediaanKamarController
  var listKelasKamar = <KelasKamarModel>[].obs;
  var listBangsalKamar = <BangsalKamarModel>[].obs;
  final _restApi = Get.put(RestApi());
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    _restApi.getService(urlKelasKamar).then((value) => listKelasKamar.value =
        kelasKamarModelFromJson(json.encode(value.body['data'])));
    _restApi.getService(urlBangsalKamar).then((value) => listBangsalKamar
        .value = bangsalKamarModelFromJson(json.encode(value.body['data'])));
    super.onReady();
  }

  @override
  void onClose() {}
}
