import 'package:ALPOKAT/app/modules/fasilitas_tarif/components/MLKamarComponent.dart';
import 'package:ALPOKAT/app/modules/fasilitas_tarif/components/MLOperasiComponent.dart';
import 'package:ALPOKAT/app/modules/fasilitas_tarif/components/MLRadiologiComponent.dart';
import 'package:ALPOKAT/app/modules/fasilitas_tarif/components/MlLaboratComponent.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:ALPOKAT/app/utils/MLCommon.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/fasilitas_tarif_controller.dart';

class FasilitasTarifView extends GetView<FasilitasTarifController> {
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
                Text('Fasilitas & Tarif',
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
                      Tab(text: 'Kamar'),
                      Tab(text: 'Radiologi'),
                      Tab(text: 'Laborat'),
                      Tab(text: 'Operasi'),
                    ],
                  ),
                  Flexible(
                    child: TabBarView(
                      controller: controller.tabController,
                      children: [
                        MLKamarComponent(),
                        MLRadiologiComponent(),
                        MLLaboratComponent(),
                        MLOperasiComponent(),
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
