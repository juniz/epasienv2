import 'package:ALPOKAT/app/modules/home/views/home_view.dart';
import 'package:ALPOKAT/app/modules/panduan/views/panduan_view.dart';
import 'package:ALPOKAT/app/modules/profile/views/profile_view.dart';
import 'package:ALPOKAT/app/modules/riwayat_booking/views/riwayat_booking_view.dart';
import 'package:ALPOKAT/app/modules/surat_sakit/views/surat_sakit_view.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../main.dart';

class DashboardController extends GetxController {
  //TODO: Implement DashboardController
  var currentWidget = 0.obs;
  final telephone = Get.find<SettingsService>().read('telephone');
  List<dynamic> widgets = [
    HomeView(),
    RiwayatBookingView(),
    SuratSakitView(),
    PanduanView(),
    ProfileView(),
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void whatsAppOpen() async {
    //bool whatsapp = await FlutterLaunch.hasApp(name: "WhatsApp");
    await launch("https://wa.me/$telephone}/?text=");
    // if (whatsapp) {
    //await FlutterLaunch.launchWhatsapp(phone: rumkit['telp'], message: "");
    // } else {
    //   toast('Gagal membuka aplikasi whatsapp');
    // }
  }
}
