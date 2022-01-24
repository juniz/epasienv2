import 'package:ALPOKAT/app/modules/jadwal_dokter/components/MLJadwalDokterComponent.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:ALPOKAT/app/utils/MLCommon.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/jadwal_dokter_controller.dart';

class JadwalDokterView extends GetView<JadwalDokterController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: Column(
          children: [
            Row(
              children: [
                mlBackToPreviousIcon(context, white),
                8.width,
                Text('Jadwal Dokter',
                        style: boldTextStyle(color: whiteColor, size: 20))
                    .expand(),
              ],
            ).paddingAll(16.0),
            Container(
              width: Get.width,
              decoration: boxDecorationWithRoundedCorners(
                  borderRadius: radiusOnly(topRight: 32)),
              child: Column(
                children: [
                  16.height,
                  MLJadwalDokterComponent().expand(),
                ],
              ),
            ).flexible()
          ],
        ),
      ),
    );
  }
}
