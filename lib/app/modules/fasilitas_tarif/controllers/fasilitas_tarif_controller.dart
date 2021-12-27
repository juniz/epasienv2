import 'package:epasien/app/modules/fasilitas_tarif/models/kamar_model.dart';
import 'package:epasien/app/modules/fasilitas_tarif/providers/kamar_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FasilitasTarifController extends GetxController
    with SingleGetTickerProviderMixin {
  //TODO: Implement FasilitasTarifController
  final _apiProvider = GetInstance().put(KamarProvider());
  var listKamar = <KamarModel>[].obs;
  late TabController tabController;
  @override
  void onInit() {
    tabController = TabController(length: 4, vsync: this);
    _apiProvider.fetchKamar().then(
          (value) => listKamar.value = value,
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
