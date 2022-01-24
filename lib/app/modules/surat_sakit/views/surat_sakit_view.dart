import 'package:ALPOKAT/app/modules/surat_sakit/components/MLCutiSakitComponents.dart';
import 'package:ALPOKAT/app/modules/surat_sakit/components/MLNarkobaComponents.dart';
import 'package:ALPOKAT/app/modules/surat_sakit/components/MLRujukanComponents.dart';
import 'package:ALPOKAT/app/modules/surat_sakit/components/MLSuratKontrolComponents.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/surat_sakit_controller.dart';

class SuratSakitView extends GetView<SuratSakitController> {
  final controller = Get.put(SuratSakitController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: Column(
          children: [
            Row(
              children: [
                // mlBackToPreviousIcon(context, white),
                // 8.width,
                Text('Permintaan Surat',
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
                  TabBar(
                    controller: controller.tabController,
                    labelColor: mlColorBlue,
                    indicatorColor: mlColorBlue,
                    unselectedLabelColor: Colors.grey,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: primaryTextStyle(size: 14),
                    tabs: [
                      Tab(text: 'Cuti Sakit'),
                      Tab(text: 'SKBN'),
                      Tab(text: 'SKDP'),
                      Tab(text: 'Rujukan'),
                    ],
                  ),
                  Flexible(
                    child: TabBarView(
                      controller: controller.tabController,
                      children: [
                        MLCutiSakitComponents(),
                        MLNarkobaComponents(),
                        MLSuratKontrolComponents(),
                        MLRujukanComponents(),
                      ],
                    ),
                  ),
                ],
              ),
            ).flexible()
          ],
        ),
      ),
    );
  }
}
