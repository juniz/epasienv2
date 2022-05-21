import 'package:ALPOKAT/app/modules/pengaduan/models/jawaban_pengaduan_model.dart';
import 'package:ALPOKAT/app/modules/pengaduan/models/pengaduan_model.dart';
import 'package:ALPOKAT/app/modules/pengaduan/providers/pengaduan_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nb_utils/nb_utils.dart';

class PengaduanController extends GetxController {
  //TODO: Implement PengaduanController
  final _provider = GetInstance().put(PengaduanProvider());
  late TextEditingController messageController;
  var listPengaduan = <PengaduanModel>[].obs;
  var listJawabanPengaduan = <JawabanPengaduanModel>[].obs;
  final pasien = GetStorage().read('pasien');

  @override
  void onInit() {
    messageController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    pengaduan();
    super.onReady();
  }

  @override
  void onClose() {}

  kirimPengaduan() {
    try {
      Future.delayed(
        Duration.zero,
      );
      var body = {
        'no_rkm_medis': pasien['no_rkm_medis'],
        'pesan': messageController.text,
      };
      _provider.kirimPengaduan(body).then((res) {
        if (res.statusCode == 200) {
          toast(
            res.body['message'],
            textColor: Colors.black,
            gravity: ToastGravity.TOP,
          );
          pengaduan();
        }
      });
    } catch (e) {}
  }

  pengaduan() async {
    try {
      Future.delayed(
        Duration.zero,
      );
      var body = {
        'no_rkm_medis': pasien['no_rkm_medis'],
      };
      _provider.pengaduan(body).then((res) {
        listPengaduan.value = res;
      });
    } catch (e) {}
  }

  Future<List<JawabanPengaduanModel>> jawabanPengaduan(String? id) async {
    Future.delayed(
      Duration.zero,
    );
    var body = {
      'id_pengaduan': id,
    };
    // print(body);
    //listJawabanPengaduan.clear();
    var data = await _provider.jawabanPengaduan(body);
    // listJawabanPengaduan.value =
    //     jawabanPengaduanModelFromJson(data.bodyString!);
    return jawabanPengaduanModelFromJson(data.bodyString!);
  }
}
