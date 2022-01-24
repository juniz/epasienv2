import 'package:get/get.dart';

import 'package:ALPOKAT/app/modules/fasilitas_tarif/controllers/konsultasi_controller.dart';
import 'package:ALPOKAT/app/modules/fasilitas_tarif/controllers/laborat_controller.dart';
import 'package:ALPOKAT/app/modules/fasilitas_tarif/controllers/operasi_controller.dart';
import 'package:ALPOKAT/app/modules/fasilitas_tarif/controllers/radiologicontroller_controller.dart';

import '../controllers/fasilitas_tarif_controller.dart';

class FasilitasTarifBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KonsultasiController>(
      () => KonsultasiController(),
    );
    Get.lazyPut<KonsultasiController>(
      () => KonsultasiController(),
    );
    Get.lazyPut<OperasiController>(
      () => OperasiController(),
    );
    Get.lazyPut<OperasiController>(
      () => OperasiController(),
    );
    Get.lazyPut<LaboratController>(
      () => LaboratController(),
    );
    Get.lazyPut<LaboratController>(
      () => LaboratController(),
    );
    Get.lazyPut<RadiologiController>(
      () => RadiologiController(),
    );
    Get.lazyPut<FasilitasTarifController>(
      () => FasilitasTarifController(),
    );
  }
}
