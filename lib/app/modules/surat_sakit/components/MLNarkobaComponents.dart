import 'package:ALPOKAT/app/modules/surat_sakit/controllers/surat_sakit_controller.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class MLNarkobaComponents extends StatelessWidget {
  const MLNarkobaComponents({Key? key}) : super(key: key);

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
              Text('SURAT KETERANGAN BEBAS NARKOBA',
                  style: boldTextStyle(size: 24)),
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
                        DataColumn(label: Text('Tanggal')),
                        DataColumn(label: Text('Kategori')),
                        DataColumn(label: Text('Keperluan')),
                      ],
                      rows: controller.listSuratNarkoba
                          .map(
                            (e) => DataRow(
                              cells: <DataCell>[
                                DataCell(
                                  AppButton(
                                    color: mlPrimaryColor,
                                    child: Text(
                                      e.noSurat!,
                                      style: primaryTextStyle(color: white),
                                    ),
                                    onTap: () =>
                                        controller.suratSKBN(e.noSurat!),
                                  ).cornerRadiusWithClipRRect(10).paddingAll(2),
                                ),
                                DataCell(Text(e.nmDokter!)),
                                DataCell(Text(e.tanggalsurat!)),
                                DataCell(Text(e.kategori!)),
                                DataCell(Text(e.keperluan!)),
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
