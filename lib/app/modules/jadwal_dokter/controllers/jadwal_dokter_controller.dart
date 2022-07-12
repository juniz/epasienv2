import 'dart:convert';
import 'package:ALPOKAT/app/modules/halaman_booking/models/jadwal_poliklinik_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../main.dart';
import '../../../api/rest_api.dart';
import '../../../api/url.dart';

class JadwalDokterController extends GetxController {
  //TODO: Implement JadwalDokterController
  final _restApi = Get.put(RestApi());
  final photo = Get.find<SettingsService>().read('photoDokter');
  var selectedIndex = 0.obs;
  var selectedDate = DateTime.now().add(Duration(days: 1)).obs;
  var selectedKdPoli = "".obs;
  var selectedPoli = "".obs;
  var selectedKdDokter = "".obs;
  var selectedDokter = "".obs;
  var listPoliklinik = <JadwalPoliklinikModel>[].obs;
  var selectedJam = "".obs;
  var loadJadwal = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getPoliklinik();
    super.onReady();
  }

  @override
  void onClose() {}

  getPoliklinik() {
    loadJadwal.value = true;
    // print(loadJadwal);
    try {
      Future.delayed(Duration(seconds: 1), () {
        var body = {
          'tanggal': DateFormat('yyyy-MM-dd').format(selectedDate.value),
        };

        _restApi
            .getService(urlCariPoli + '?tanggal=${body['tanggal']}')
            .then((value) {
          listPoliklinik.value =
              jadwalPoliklinikModelFromJson(json.encode(value.body['data']));
          if (listPoliklinik.value.isEmpty) {
            selectedKdDokter.value = "";
            selectedKdPoli.value = "";
          } else {
            selectedKdDokter.value = listPoliklinik.value[0].kdDokter!;
            selectedDokter.value = listPoliklinik.value[0].nmDokter!;
            selectedKdPoli.value = listPoliklinik.value[0].kdPoli!;
            selectedPoli.value = listPoliklinik.value[0].nmPoli!;
            selectedJam.value =
                '${listPoliklinik.value[0].jamMulai} - ${listPoliklinik.value[0].jamSelesai}';
          }
          loadJadwal(false);
        });
      });
    } catch (e) {
      print(e);
    }
  }
}
