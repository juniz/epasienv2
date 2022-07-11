import 'dart:convert';
import 'package:ALPOKAT/app/api/url.dart';
import 'package:ALPOKAT/app/modules/pengaduan/models/jawaban_pengaduan_model.dart';
import 'package:ALPOKAT/app/modules/pengaduan/models/pengaduan_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../api/login_session.dart';
import '../../../api/rest_api.dart';

class PengaduanController extends GetxController {
  //TODO: Implement PengaduanController
  final _session = Get.find<LoginSession>();
  final _restApi = Get.put(RestApi());
  late TextEditingController messageController;
  var listPengaduan = <PengaduanModel>[].obs;
  var listJawabanPengaduan = <JawabanPengaduan>[].obs;

  @override
  void onInit() {
    messageController = TextEditingController();
    pengaduan();
    super.onInit();
  }

  @override
  void onReady() {
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
        'no_rkm_medis': _session.rkm.val,
        'pesan': messageController.text,
      };
      _restApi.postService(urlKirimPengaduan, body).then((res) {
        if (res.statusCode == 200) {
          toast(
            res.body['meta']['message'],
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
        'no_rkm_medis': _session.rkm.val,
      };
      _restApi
          .getService(urlPengaduan + '?no_rkm_medis=${body['no_rkm_medis']}')
          .then((res) {
        log(res.bodyString);
        listPengaduan.value =
            pengaduanModelFromJson(json.encode(res.body['data']));
      });
    } catch (e) {}
  }

  Future<List<JawabanPengaduan>> jawabanPengaduan(String? id) async {
    Future.delayed(
      Duration.zero,
    );
    var body = {
      'id_pengaduan': id,
    };
    var data = await _restApi.getService(
        urlJawabanPengaduan + '?id_pengaduan=${body['id_pengaduan']}');

    return jawabanPengaduanFromJson(json.encode(data.body['data']));
  }
}
