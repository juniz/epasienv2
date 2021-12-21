import 'package:epasien/app/modules/home/views/home_view.dart';
import 'package:epasien/app/modules/riwayat_booking/views/riwayat_booking_view.dart';
import 'package:epasien/app/modules/surat_sakit/views/surat_sakit_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  //TODO: Implement DashboardController
  var currentWidget = 0.obs;
  List<Widget> widgets = [
    HomeView(),
    RiwayatBookingView(),
    SuratSakitView(),
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
}
