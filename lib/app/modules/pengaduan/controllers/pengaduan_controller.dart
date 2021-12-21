import 'package:epasien/app/modules/pengaduan/models/jawaban_pengaduan_model.dart';
import 'package:epasien/app/modules/pengaduan/models/pengaduan_model.dart';
import 'package:epasien/app/modules/pengaduan/providers/pengaduan_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class PengaduanController extends GetxController {
  //TODO: Implement PengaduanController
  late TextEditingController messageController;
  var listPengaduan = <PengaduanModel>[].obs;
  var listJawabanPengaduan = <JawabanPengaduanModel>[].obs;

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
        'no_rkm_medis': '165056',
        'pesan': messageController.text,
      };
      PengaduanProvider()
          .post(
              'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/kirimpengaduan',
              body)
          .then((res) {
        toast(
          res.body['message'],
          textColor: Colors.black,
          gravity: ToastGravity.TOP,
        );
      });
    } catch (e) {}
  }

  pengaduan() async {
    try {
      Future.delayed(
        Duration.zero,
      );
      var body = {
        'no_rkm_medis': '165056',
      };
      PengaduanProvider()
          .post(
              'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/pengaduan',
              body)
          .then((res) {
        listPengaduan.value = pengaduanModelFromJson(res.bodyString!);
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
    //listJawabanPengaduan.clear();
    var data = await PengaduanProvider().post(
        'https://webapps.rsbhayangkaranganjuk.com/api-rsbnganjuk/api/v1/apm/jawabanpengaduan',
        body);
    // listJawabanPengaduan.value =
    //     jawabanPengaduanModelFromJson(data.bodyString!);
    return jawabanPengaduanModelFromJson(data.bodyString!);
  }
}
