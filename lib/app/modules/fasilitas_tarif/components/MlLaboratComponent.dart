import 'package:ALPOKAT/app/modules/fasilitas_tarif/controllers/laborat_controller.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/src/extensions/int_extensions.dart';

class MLLaboratComponent extends StatelessWidget {
  const MLLaboratComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LaboratController>();
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.height,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tarif Laborat', style: boldTextStyle(size: 24)),
              16.height,
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: boxDecorationWithRoundedCorners(
                    backgroundColor: mlColorGreyShade, borderRadius: radius(8)),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(
                    () => DataTable(
                      columns: <DataColumn>[
                        DataColumn(label: Text('Nama Pemeriksaan')),
                        DataColumn(label: Text('Kelas')),
                        DataColumn(
                            label: Text('Tarif Radiologi'), numeric: true),
                      ],
                      rows: controller.listLaborat
                          .map(
                            (e) => DataRow(
                              cells: <DataCell>[
                                DataCell(Text(e.nmPerawatan!)),
                                DataCell(Text(e.kelas!)),
                                DataCell(Text(
                                    NumberFormat.currency(locale: 'id')
                                        .format(int.parse(e.totalByr!)))),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          32.height,
          // MLCovidTopRegionComponent(),
          16.height,
        ],
      ).paddingAll(16.0),
    );
  }
}
