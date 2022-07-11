import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
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
              ],
            ).paddingAll(16.0),
            8.width,
            Container(
              decoration: boxDecorationWithRoundedCorners(
                  borderRadius: radiusOnly(topRight: 32)),
              child: Obx(() => SingleChildScrollView(
                    child: Column(
                        children: controller.listPanduan.value
                            .map((e) => ResumeWidget(
                                controller: e.deskripsi, header: e.judul))
                            .toList()),
                  )),
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
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: GFAccordion(
          titleChild: Text(
            header!,
            style: boldTextStyle(color: white),
          ),
          content: controller,
          collapsedIcon: Icon(Icons.add, color: white),
          expandedIcon: Icon(Icons.minimize, color: white),
          collapsedTitleBackgroundColor: mlPrimaryColor,
          expandedTitleBackgroundColor: mlColorCyan,
          titleBorderRadius: BorderRadius.all(radiusCircular(10)),
        ),
      ),
    );
  }
}
