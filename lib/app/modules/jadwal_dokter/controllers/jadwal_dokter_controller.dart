import 'package:epasien/app/modules/halaman_booking/models/jadwal_poliklinik_model.dart';
import 'package:epasien/app/modules/jadwal_dokter/providers/jadwal_dokter_home_provider.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class JadwalDokterController extends GetxController {
  //TODO: Implement JadwalDokterController
  JadwalDokterHomeProvider _jadwalProvider =
      GetInstance().put(JadwalDokterHomeProvider());
  var selectedIndex = 0.obs;
  var selectedDate = DateTime.now().add(Duration(days: 1)).obs;
  var selectedKdPoli = "".obs;
  var selectedPoli = "".obs;
  var selectedKdDokter = "".obs;
  var selectedDokter = "".obs;
  var listPoliklinik = <JadwalPoliklinikModel>[].obs;
  var selectedJam = "".obs;

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
    try {
      Future.delayed(
        Duration(seconds: 3),
      );
      var body = {
        'tanggal': DateFormat('yyyy-MM-dd').format(selectedDate.value),
      };

      _jadwalProvider.fetchJadwalDokter(body).then((value) {
        listPoliklinik.value = value;
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
      });
    } catch (e) {
      print(e);
    }
  }
}
