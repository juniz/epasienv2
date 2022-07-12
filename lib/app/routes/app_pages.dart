import 'package:get/get.dart';

import '../modules/booking_pasien_baru/bindings/booking_pasien_baru_binding.dart';
import '../modules/booking_pasien_baru/views/booking_pasien_baru_view.dart';
import '../modules/cek_status_booking/bindings/cek_status_booking_binding.dart';
import '../modules/cek_status_booking/views/cek_status_booking_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/fasilitas_tarif/bindings/fasilitas_tarif_binding.dart';
import '../modules/fasilitas_tarif/views/fasilitas_tarif_view.dart';
import '../modules/halaman_booking/bindings/halaman_booking_binding.dart';
import '../modules/halaman_booking/views/halaman_booking_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/homevisite/bindings/homevisite_binding.dart';
import '../modules/homevisite/views/homevisite_view.dart';
import '../modules/jadwal_dokter/bindings/jadwal_dokter_binding.dart';
import '../modules/jadwal_dokter/views/jadwal_dokter_view.dart';
import '../modules/jadwal_operasi/bindings/jadwal_operasi_binding.dart';
import '../modules/jadwal_operasi/views/jadwal_operasi_view.dart';
import '../modules/kedersediaan_kamar/bindings/kedersediaan_kamar_binding.dart';
import '../modules/kedersediaan_kamar/views/kedersediaan_kamar_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/maintance/bindings/maintance_binding.dart';
import '../modules/maintance/views/maintance_view.dart';
import '../modules/panduan/bindings/panduan_binding.dart';
import '../modules/panduan/views/panduan_view.dart';
import '../modules/pengaduan/bindings/pengaduan_binding.dart';
import '../modules/pengaduan/views/pengaduan_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/riwayat_booking/bindings/riwayat_booking_binding.dart';
import '../modules/riwayat_booking/views/riwayat_booking_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/surat_sakit/bindings/surat_sakit_binding.dart';
import '../modules/surat_sakit/views/surat_sakit_view.dart';
import '../modules/timeout/bindings/timeout_binding.dart';
import '../modules/timeout/views/timeout_view.dart';
import '../modules/webview/bindings/webview_binding.dart';
import '../modules/webview/views/webview_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_PASIEN_BARU,
      page: () => BookingPasienBaruView(),
      binding: BookingPasienBaruBinding(),
    ),
    GetPage(
      name: _Paths.CEK_STATUS_BOOKING,
      page: () => CekStatusBookingView(),
      binding: CekStatusBookingBinding(),
    ),
    GetPage(
      name: _Paths.HALAMAN_BOOKING,
      page: () => HalamanBookingView(),
      binding: HalamanBookingBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT_BOOKING,
      page: () => RiwayatBookingView(),
      binding: RiwayatBookingBinding(),
    ),
    GetPage(
      name: _Paths.PENGADUAN,
      page: () => PengaduanView(),
      binding: PengaduanBinding(),
    ),
    GetPage(
      name: _Paths.JADWAL_DOKTER,
      page: () => JadwalDokterView(),
      binding: JadwalDokterBinding(),
    ),
    GetPage(
      name: _Paths.FASILITAS_TARIF,
      page: () => FasilitasTarifView(),
      binding: FasilitasTarifBinding(),
    ),
    GetPage(
      name: _Paths.KEDERSEDIAAN_KAMAR,
      page: () => KedersediaanKamarView(),
      binding: KedersediaanKamarBinding(),
    ),
    GetPage(
      name: _Paths.WEBVIEW,
      page: () => WebviewView(),
      binding: WebviewBinding(),
    ),
    GetPage(
      name: _Paths.SURAT_SAKIT,
      page: () => SuratSakitView(),
      binding: SuratSakitBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.PANDUAN,
      page: () => PanduanView(),
      binding: PanduanBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.HOMEVISITE,
      page: () => HomevisiteView(),
      binding: HomevisiteBinding(),
    ),
    GetPage(
      name: _Paths.JADWAL_OPERASI,
      page: () => const JadwalOperasiView(),
      binding: JadwalOperasiBinding(),
    ),
    GetPage(
      name: _Paths.MAINTANCE,
      page: () => const MaintanceView(),
      binding: MaintanceBinding(),
    ),
    GetPage(
      name: _Paths.TIMEOUT,
      page: () => const TimeoutView(),
      binding: TimeoutBinding(),
    ),
  ];
}
