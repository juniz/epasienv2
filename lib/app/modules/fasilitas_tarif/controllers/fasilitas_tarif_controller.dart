import 'dart:convert';

import 'package:ALPOKAT/app/api/url.dart';
import 'package:ALPOKAT/app/modules/fasilitas_tarif/models/kamar_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/rest_api.dart';

class FasilitasTarifController extends GetxController
    with SingleGetTickerProviderMixin {
  //TODO: Implement FasilitasTarifController
  final _restApi = Get.put(RestApi());
  var listKamar = <KamarModel>[].obs;
  late TabController tabController;
  @override
  void onInit() {
    tabController = TabController(length: 4, vsync: this);
    _restApi.getService(urlKamar).then(
          (value) => listKamar.value =
              kamarModelFromJson(json.encode(value.body['data'])),
        );

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
