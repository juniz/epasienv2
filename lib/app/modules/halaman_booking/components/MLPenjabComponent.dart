import 'package:ALPOKAT/app/components/MLEmptyWidget.dart';
import 'package:ALPOKAT/app/modules/halaman_booking/components/MLCalenderComponent.dart';
import 'package:ALPOKAT/app/data/MLDepartmentData.dart';
import 'package:ALPOKAT/app/modules/halaman_booking/controllers/halaman_booking_controller.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:ALPOKAT/app/utils/MLDataProvider.dart';
import 'package:ALPOKAT/app/utils/MLImage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

class MLPenjabComponent extends StatefulWidget {
  @override
  MLPenjabComponentState createState() => MLPenjabComponentState();
}

class MLPenjabComponentState extends State<MLPenjabComponent> {
  final controller = Get.find<HalamanBookingController>();
  static String tag = '/MLPenjabComponent';
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
                  Text('Pilih Jenis Bayar', style: boldTextStyle(size: 24)),
                  8.height,
                ],
              ),
              // mlRoundedIconContainer(Icons.search, mlColorBlue),
              // 16.width,
              // mlRoundedIconContainer(
              //     Icons.calendar_view_day_outlined, mlColorBlue),
            ],
          ).paddingOnly(right: 16.0, left: 16.0),
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
                : controller.listPenjab.isEmpty
                    ? Column(
                        children: [
                          Lottie.asset('lottie/search-not-found.json')
                              .flexible(flex: 3),
                          Text(
                            'Penjab tidak ditemukan',
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
                        itemCount: controller.listPenjab.length,
                        itemBuilder: (context, index) {
                          return Obx(
                            () => Container(
                              margin: EdgeInsets.only(bottom: 16),
                              padding: EdgeInsets.all(8.0),
                              decoration: boxDecorationWithRoundedCorners(
                                border: Border.all(
                                  color: controller.selectedIndexPenjab.value ==
                                          index
                                      ? mlColorBlue
                                      : mlColorLightGrey100,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                              ('images/insurance.png')
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
                                              (controller.listPenjab
                                                      .value[index].pngJawab)!
                                                  .validate(),
                                              style: boldTextStyle(size: 18)),
                                          8.height,
                                          // Text((departmentList[index].subtitle).validate(),
                                          //     style: secondaryTextStyle()),
                                          // 8.height,
                                          Text(
                                              (controller.listPenjab
                                                      .value[index].attn)
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
                                              child: Icon(Icons.home, size: 14),
                                            ),
                                            TextSpan(
                                                text: ' Perusahaan',
                                                style: secondaryTextStyle()),
                                          ],
                                        ),
                                      ),
                                      Text(
                                          controller.listPenjab.value[index]
                                              .namaPerusahaan!,
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
                                controller.selectedIndexPenjab.value = index;
                                controller.selectedKdPenjab.value =
                                    controller.listPenjab.value[index].kdPj!;
                                controller.selectedPenjab.value = controller
                                    .listPenjab.value[index].pngJawab!;
                                //controller.currentWidget.value = index;
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
