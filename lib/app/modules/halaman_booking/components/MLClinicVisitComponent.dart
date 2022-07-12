import 'package:ALPOKAT/app/components/MLEmptyWidget.dart';
import 'package:ALPOKAT/app/modules/halaman_booking/components/MLCalenderComponent.dart';
import 'package:ALPOKAT/app/data/MLDepartmentData.dart';
import 'package:ALPOKAT/app/modules/halaman_booking/controllers/halaman_booking_controller.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:ALPOKAT/app/utils/MLDataProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../api/url.dart';
import '../../../utils/MLCommon.dart';
import '../../../utils/setting.dart';

class MLClinicVisitComponent extends StatefulWidget {
  @override
  MLClinicVisitComponentState createState() => MLClinicVisitComponentState();
}

class MLClinicVisitComponentState extends State<MLClinicVisitComponent> {
  final controller = Get.find<HalamanBookingController>();
  static String tag = '/MLClinicVisitComponent';
  List<MLDepartmentData> departmentList = mlServiceListDataList();
  // int? selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          16.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pilih Poliklinik Dan Dokter',
                      style: boldTextStyle(size: 24)),
                  8.height,
                ],
              ).expand(),
            ],
          ).paddingOnly(right: 16.0, left: 16.0),
          MLCalenderComponent(),
          8.height,
          Obx(
            () => controller.isLoading.value
                ? GFShimmer(
                    child: Column(
                      children: [
                        MLEmptyWidget(),
                        MLEmptyWidget(),
                        MLEmptyWidget(),
                        MLEmptyWidget(),
                      ],
                    ),
                  )
                : controller.listPoliklinik.isEmpty
                    ? Column(
                        children: [
                          Lottie.asset('lottie/search-not-found.json')
                              .flexible(flex: 3),
                          Text(
                            'Jadwal tidak ditemukan',
                            style: primaryTextStyle(),
                          ).flexible(),
                        ],
                      ).withSize(width: 300, height: 300).center()
                    : ListView.builder(
                        padding: EdgeInsets.only(
                            right: 16.0, left: 16.0, bottom: 70),
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: controller.listPoliklinik.length,
                        itemBuilder: (context, index) {
                          return Obx(
                            () => Container(
                              margin: EdgeInsets.only(bottom: 16),
                              padding: EdgeInsets.all(8.0),
                              decoration: boxDecorationWithRoundedCorners(
                                border: Border.all(
                                  color: controller.selectedIndex.value == index
                                      ? mlColorBlue
                                      : mlColorLightGrey100,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      controller.photo == "true"
                                          ? waCommonCachedNetworkImage(
                                              urlBaseImage +
                                                  controller.listPoliklinik
                                                      .value[index].photo
                                                      .validate(),
                                              fit: BoxFit.cover,
                                              alignment: Alignment.topCenter,
                                              height: 100,
                                              width: 75,
                                            ).paddingAll(8.0).expand(flex: 1)
                                          : Image.asset(
                                                  ('images/hospital.png')
                                                      .validate(),
                                                  height: 75,
                                                  width: 75,
                                                  fit: BoxFit.fill)
                                              .paddingAll(8.0)
                                              .expand(flex: 1),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              (controller.listPoliklinik
                                                      .value[index].nmPoli)!
                                                  .validate(),
                                              style: boldTextStyle(size: 18)),
                                          8.height,
                                          // Text((departmentList[index].subtitle).validate(),
                                          //     style: secondaryTextStyle()),
                                          // 8.height,
                                          Text(
                                              (controller.listPoliklinik
                                                      .value[index].nmDokter)
                                                  .validate(),
                                              style: boldTextStyle(
                                                  color: mlColorDarkBlue)),
                                        ],
                                      ).expand(flex: 3),
                                    ],
                                  ),
                                  8.height,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Icon(
                                                  Icons.watch_later_outlined,
                                                  size: 14),
                                            ),
                                            TextSpan(
                                                text: ' Jam pelayanan',
                                                style: secondaryTextStyle()),
                                          ],
                                        ),
                                      ),
                                      Text(
                                          '${controller.listPoliklinik.value[index].jamMulai} - ${controller.listPoliklinik.value[index].jamSelesai}',
                                          style: secondaryTextStyle(
                                              color: Colors.black87)),
                                    ],
                                  ).paddingOnly(left: 8, right: 8),
                                  8.height,
                                ],
                              ),
                            ).onTap(
                              () {
                                // print(
                                //     controller.listPoliklinik.value[index].nmDokter);
                                controller.selectedIndex.value = index;
                                controller.selectedKdDokter.value = controller
                                    .listPoliklinik.value[index].kdDokter!;
                                controller.selectedDokter.value = controller
                                    .listPoliklinik.value[index].nmDokter!;
                                controller.selectedKdPoli.value = controller
                                    .listPoliklinik.value[index].kdPoli!;
                                controller.selectedPoli.value = controller
                                    .listPoliklinik.value[index].nmPoli!;
                                controller.selectedJam.value =
                                    '${controller.listPoliklinik.value[index].jamMulai!} - ${controller.listPoliklinik.value[index].jamSelesai!}';
                              },
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
