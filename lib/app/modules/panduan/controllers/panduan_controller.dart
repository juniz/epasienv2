import 'package:ALPOKAT/app/modules/panduan/models/PanduanModel.dart';
import 'package:ALPOKAT/app/modules/panduan/providers/panduan_provider.dart';
import 'package:get/get.dart';

class PanduanController extends GetxController {
  //TODO: Implement PanduanController
  final _provider = GetInstance().put(PanduanProvider());
  var listPanduan = <PanduanModel>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getPanduan();
    super.onReady();
  }

  @override
  void onClose() {}

  getPanduan() {
    Future.delayed(
      Duration.zero,
    );
    _provider.fetchPanduan().then((value) => listPanduan.value = value);
  }
}
