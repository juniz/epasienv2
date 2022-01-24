import 'package:ALPOKAT/app/modules/riwayat_booking/controllers/riwayat_booking_controller.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class MLBillingDetailList extends StatelessWidget {
  const MLBillingDetailList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RiwayatBookingController>();
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(bottom: 80),
        decoration: boxDecorationWithRoundedCorners(
            border: Border.all(color: mlColorLightGrey),
            borderRadius: radius(12)),
        child: Obx(
          () => controller.listBilling.value.isNotEmpty
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DataTable(
                        columns: <DataColumn>[
                          DataColumn(label: Text('')),
                          DataColumn(label: Text('')),
                          DataColumn(label: Text('')),
                          DataColumn(label: Text('')),
                          DataColumn(label: Text(''), numeric: true),
                        ],
                        rows: controller.listBilling.value
                            .map(
                              (e) => DataRow(
                                cells: <DataCell>[
                                  DataCell(Text(e.no!)),
                                  DataCell(Text(e.nmPerawatan!)),
                                  DataCell(Text(e.pemisah!)),
                                  DataCell(Text(e.dua!)),
                                  DataCell(Text(
                                    e.empat!,
                                  )),
                                ],
                              ),
                            )
                            .toList()
                          ..add(
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text('TOTAL BILLING',
                                    style: boldTextStyle())),
                                DataCell(Text(':')),
                                DataCell(Text('')),
                                DataCell(Text('')),
                                DataCell(Text(
                                    controller.totalBilling.value.toString(),
                                    style: boldTextStyle())),
                              ],
                            ),
                          ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ),
      ).paddingAll(16.0),
    );
  }
}
