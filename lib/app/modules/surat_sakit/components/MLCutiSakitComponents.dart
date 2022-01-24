import 'package:ALPOKAT/app/modules/surat_sakit/controllers/surat_sakit_controller.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/src/extensions/int_extensions.dart';

class MLCutiSakitComponents extends StatelessWidget {
  const MLCutiSakitComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SuratSakitController>();
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
              Text('Surat Cuti Sakit', style: boldTextStyle(size: 24)),
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
                        DataColumn(label: Text('No. Surat')),
                        DataColumn(label: Text('Dokter')),
                        DataColumn(label: Text('Tgl Mulai')),
                        DataColumn(label: Text('Tgl Selesai')),
                        DataColumn(label: Text('Lamanya')),
                      ],
                      rows: controller.listSuratSakit
                          .map(
                            (e) => DataRow(
                              cells: <DataCell>[
                                DataCell(
                                  // Container(
                                  //   margin:
                                  //       EdgeInsets.only(bottom: 10, top: 10),
                                  //   child: Text(
                                  //     e.noSurat!,
                                  //     style: primaryTextStyle(color: white),
                                  //   )
                                  //       .center()
                                  //       .paddingOnly(left: 5, right: 5)
                                  //       .cornerRadiusWithClipRRect(10),
                                  //   color: mlPrimaryColor,
                                  // ),
                                  // onTap: () =>
                                  //     controller.suratSakitPDF(e.noSurat!),
                                  AppButton(
                                    color: mlPrimaryColor,
                                    child: Text(
                                      e.noSurat!,
                                      style: primaryTextStyle(color: white),
                                    ),
                                    onTap: () =>
                                        controller.suratSakitPDF(e.noSurat!),
                                  ).cornerRadiusWithClipRRect(10).paddingAll(2),
                                ),
                                DataCell(Text(e.nmDokter!)),
                                DataCell(Text(e.tanggalawal!)),
                                DataCell(Text(e.tanggalakhir!)),
                                DataCell(Text(e.lamasakit!)),
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
