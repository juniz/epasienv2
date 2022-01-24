import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:ALPOKAT/app/utils/MLCommon.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/src/extensions/int_extensions.dart';

import '../controllers/kedersediaan_kamar_controller.dart';

class KedersediaanKamarView extends GetView<KedersediaanKamarController> {
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
                Text('Ketersediaan Kamar',
                        style: boldTextStyle(color: whiteColor, size: 20))
                    .expand(),
              ],
            ).paddingAll(16.0),
            Container(
              width: Get.width,
              decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: mlColorGreyShade,
                  borderRadius: radiusOnly(topRight: 35)),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.height,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: boxDecorationWithRoundedCorners(
                                  backgroundColor: mlColorGreyShade,
                                  borderRadius: radius(8)),
                              child: Obx(
                                () => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                        columns: <DataColumn>[
                                          DataColumn(
                                              label: Text('Kelas Kamar')),
                                          DataColumn(
                                              label: Text('Jumlah Bed'),
                                              numeric: true),
                                          DataColumn(
                                              label: Text('Bed Terisi'),
                                              numeric: true),
                                          DataColumn(
                                              label: Text('Bed Kosong'),
                                              numeric: true),
                                        ],
                                        rows: controller.listKelasKamar
                                            .map(
                                              (e) => DataRow(
                                                cells: <DataCell>[
                                                  DataCell(
                                                    Text(e.kelas!),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                      e.total!.toString(),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(e.isi!.toString()),
                                                  ),
                                                  DataCell(
                                                    Text(e.kosong!.toString()),
                                                  ),
                                                ],
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1.0,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                        columns: <DataColumn>[
                                          DataColumn(label: Text('Nama Kamar')),
                                          DataColumn(
                                              label: Text('Jumlah Bed'),
                                              numeric: true),
                                          DataColumn(
                                              label: Text('Bed Terisi'),
                                              numeric: true),
                                          DataColumn(
                                              label: Text('Bed Kosong'),
                                              numeric: true),
                                        ],
                                        rows: controller.listBangsalKamar
                                            .map(
                                              (e) => DataRow(
                                                cells: <DataCell>[
                                                  DataCell(
                                                    Text(e.nmBangsal!),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                      e.total!.toString(),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(e.isi!.toString()),
                                                  ),
                                                  DataCell(
                                                    Text(e.kosong!.toString()),
                                                  ),
                                                ],
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ).flexible(),
          ],
        ),
      ),
    );
  }
}
