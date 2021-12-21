import 'package:epasien/app/modules/riwayat_booking/controllers/riwayat_booking_controller.dart';
import 'package:epasien/app/utils/MLColors.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/src/extensions/widget_extensions.dart';

class MLResumeDetailList extends StatelessWidget {
  const MLResumeDetailList({Key? key}) : super(key: key);

  Widget mOption(var value) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Icon(Icons.location_searching, size: 12).paddingRight(8),
          ),
          TextSpan(
              text: value, style: secondaryTextStyle(size: 12, color: black)),
        ],
      ),
    );
  }

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
          () => controller.dataResume.value.diagnosaUtama == null
              ? Container()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResumeWidget(
                      controller: controller.dataResume.value.nmDokter,
                      header: 'Dokter DPJP',
                    ),
                    ResumeWidget(
                      controller: controller.dataResume.value.diagnosaUtama,
                      header: 'Keluhan Utama Riwayat Penyakit Yang Positif',
                    ),
                    ResumeWidget(
                      controller: controller.dataResume.value.jalannyaPenyakit,
                      header: 'Jalannya Penyakit Selama Perawatan',
                    ),
                    ResumeWidget(
                      controller:
                          controller.dataResume.value.pemeriksaanPenunjang,
                      header: 'Pemeriksaan Penunjang Yang Positif',
                    ),
                    ResumeWidget(
                      controller: controller.dataResume.value.hasilLaborat,
                      header: 'Hasil Laboratorium Yang Positif',
                    ),
                    ResumeAkhirWidget(
                      controller: controller,
                      header: 'Diagnosa Akhir',
                    ),
                    ResumeWidget(
                      controller: controller.dataResume.value.obatPulang,
                      header: 'Obat-obatan Waktu Pulang/Nasihat',
                    ),
                  ],
                ),
        ),
      ).paddingAll(16.0),
    );
  }
}

class ResumeWidget extends StatelessWidget {
  const ResumeWidget({
    Key? key,
    required this.controller,
    required this.header,
  }) : super(key: key);

  final String? controller;
  final String? header;

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    hasIcon: false,
                    tapHeaderToExpand: true,
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Container(
                    width: Get.width,
                    color: mlPrimaryColor,
                    child: Text(
                      header!,
                      style: boldTextStyle(color: white),
                    ).paddingAll(16),
                  ).cornerRadiusWithClipRRect(10),
                  collapsed: Container(),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        controller!,
                        style: primaryTextStyle(),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ).paddingAll(10),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResumeAkhirWidget extends StatelessWidget {
  const ResumeAkhirWidget({
    Key? key,
    required this.controller,
    required this.header,
  }) : super(key: key);

  final RiwayatBookingController controller;
  final String? header;

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    hasIcon: false,
                    tapHeaderToExpand: true,
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Container(
                    width: Get.width,
                    color: mlPrimaryColor,
                    child: Text(
                      header!,
                      style: boldTextStyle(color: white),
                    ).paddingAll(16),
                  ).cornerRadiusWithClipRRect(10),
                  collapsed: Container(),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Text('Diagnosa Utama', style: primaryTextStyle())
                              .expand(flex: 2),
                          Text(':').expand(),
                          Text('${controller.dataResume.value.diagnosaUtama!} (${controller.dataResume.value.kdDiagnosaUtama!})',
                                  style: primaryTextStyle())
                              .expand(flex: 3),
                        ],
                      ).paddingAll(5),
                      Row(
                        children: [
                          Text('Diagnosa Sekunder 1', style: primaryTextStyle())
                              .expand(flex: 2),
                          Text(':').expand(),
                          Text(controller.dataResume.value.diagnosaSekunder!,
                                  style: primaryTextStyle())
                              .expand(flex: 3)
                        ],
                      ).paddingAll(5),
                      Row(
                        children: [
                          Text('Diagnosa Sekunder 2', style: primaryTextStyle())
                              .expand(flex: 2),
                          Text(':').expand(),
                          Text(controller.dataResume.value.diagnosaSekunder2!,
                                  style: primaryTextStyle())
                              .expand(flex: 3)
                        ],
                      ).paddingAll(5),
                      Row(
                        children: [
                          Text('Diagnosa Sekunder 3', style: primaryTextStyle())
                              .expand(flex: 2),
                          Text(':').expand(),
                          Text(controller.dataResume.value.diagnosaSekunder3!,
                                  style: primaryTextStyle())
                              .expand(flex: 3)
                        ],
                      ).paddingAll(5),
                      Row(
                        children: [
                          Text('Diagnosa Sekunder 4', style: primaryTextStyle())
                              .expand(flex: 2),
                          Text(':').expand(),
                          Text(controller.dataResume.value.diagnosaSekunder4!,
                                  style: primaryTextStyle())
                              .expand(flex: 3)
                        ],
                      ).paddingAll(5),
                      Row(
                        children: [
                          Text('Prosedur Utama', style: primaryTextStyle())
                              .expand(flex: 2),
                          Text(':').expand(),
                          Text(controller.dataResume.value.prosedurUtama!,
                                  style: primaryTextStyle())
                              .expand(flex: 3)
                        ],
                      ).paddingAll(5),
                      Row(
                        children: [
                          Text('Prosedur Sekunder 1', style: primaryTextStyle())
                              .expand(flex: 2),
                          Text(':').expand(),
                          Text(controller.dataResume.value.prosedurSekunder!,
                                  style: primaryTextStyle())
                              .expand(flex: 3)
                        ],
                      ).paddingAll(5),
                      Row(
                        children: [
                          Text('Prosedur Sekunder 2', style: primaryTextStyle())
                              .expand(flex: 2),
                          Text(':').expand(),
                          Text(controller.dataResume.value.diagnosaSekunder2!,
                                  style: primaryTextStyle())
                              .expand(flex: 3)
                        ],
                      ).paddingAll(5),
                      Row(
                        children: [
                          Text('Prosedur Sekunder 3', style: primaryTextStyle())
                              .expand(flex: 2),
                          Text(':').expand(),
                          Text(controller.dataResume.value.diagnosaSekunder3!,
                                  style: primaryTextStyle())
                              .expand(flex: 3)
                        ],
                      ).paddingAll(5),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
