import 'package:ALPOKAT/app/modules/surat_sakit/controllers/surat_sakit_controller.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/src/extensions/int_extensions.dart';

class MLSuratKontrolComponents extends StatelessWidget {
  const MLSuratKontrolComponents({Key? key}) : super(key: key);

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
              Text('SURAT KONTROL/SKDP', style: boldTextStyle(size: 24)),
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
                        DataColumn(label: Text('Diagnosa')),
                        DataColumn(label: Text('Rencana Tindak Lanjut')),
                        DataColumn(label: Text('Kembali')),
                      ],
                      rows: controller.listSuratKontrol.value
                          .map(
                            (e) => DataRow(
                              cells: <DataCell>[
                                DataCell(
                                  AppButton(
                                    color: mlPrimaryColor,
                                    child: Text(
                                      e.noAntrian!,
                                      style: primaryTextStyle(color: white),
                                    ),
                                    onTap: () => controller.suratSKDP(
                                        e.noAntrian!, e.tahun!.toString()),
                                  ).cornerRadiusWithClipRRect(10).paddingAll(2),
                                ),
                                DataCell(Text(e.nmDokter!)),
                                DataCell(Text(e.diagnosa!)),
                                DataCell(Text(e.rtl1!)),
                                DataCell(Text(DateFormat("dd/MM/yyyy")
                                    .format(e.tanggalDatang!))),
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
