import 'package:epasien/app/utils/MLColors.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/panduan_controller.dart';

class PanduanView extends GetView<PanduanController> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PanduanController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: Column(
          children: [
            Row(
              children: [
                Text('FAQ', style: boldTextStyle(size: 20, color: white))
                    .expand(),
                // Text(mlHistory!, style: secondaryTextStyle(color: white))
                //     .paddingRight(8.0),
                // Icon(Icons.refresh, color: white, size: 30)
                //     .onTap(() => controller.riwayatPemeriksaan()),
              ],
            ).paddingAll(16.0),
            8.width,
            Container(
              decoration: boxDecorationWithRoundedCorners(
                  borderRadius: radiusOnly(topRight: 32)),
              child: Obx(() => Column(
                  children: controller.listPanduan.value
                      .map((e) => ResumeWidget(
                          controller: e.deskripsi, header: e.judul))
                      .toList())),
            ).expand()
          ],
        ),
      ),
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
                        style: primaryTextStyle(size: 12),
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
