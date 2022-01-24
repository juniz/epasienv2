import 'package:ALPOKAT/app/modules/riwayat_booking/components/MLAppointmentDetailListComponent.dart';
import 'package:ALPOKAT/app/modules/riwayat_booking/components/MLRiwayatPemeriksaanComponent.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:ALPOKAT/app/utils/MLString.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/riwayat_booking_controller.dart';

class RiwayatBookingView extends GetView<RiwayatBookingController> {
  // final controller =
  //     Get.lazyPut<RiwayatBookingController>(() => RiwayatBookingController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: Column(
          children: [
            Row(
              children: [
                Text('Riwayat', style: boldTextStyle(size: 20, color: white))
                    .expand(),
                // Text(mlHistory!, style: secondaryTextStyle(color: white))
                //     .paddingRight(8.0),
                Icon(Icons.refresh, color: white, size: 30)
                    .onTap(() => controller.riwayatPemeriksaan()),
              ],
            ).paddingAll(16.0),
            8.width,
            Container(
              decoration: boxDecorationWithRoundedCorners(
                  borderRadius: radiusOnly(topRight: 32)),
              child: Column(
                children: [
                  16.height,
                  TabBar(
                    controller: controller.tabController,
                    labelColor: mlColorBlue,
                    indicatorColor: mlColorBlue,
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: primaryTextStyle(size: 14),
                    tabs: [
                      Tab(text: 'Booking'),
                      Tab(text: 'Pemeriksaan'),
                    ],
                  ),
                  TabBarView(
                    controller: controller.tabController,
                    children: [
                      MLAppointmentDetailListComponent(),
                      MLRiwayatPemeriksaanComponent(),
                      // MLAppointmentDetailListComponent(),
                      // MLDeliveredDataComponent(),
                      // MLMedicationComponent(),
                    ],
                  ).expand(),
                ],
              ),
            ).expand()
          ],
        ),
      ),
    );
  }
}
