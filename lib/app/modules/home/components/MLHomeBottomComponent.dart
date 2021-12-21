import 'package:epasien/app/data/MLDepartmentData.dart';
import 'package:epasien/app/data/MLTopHospitalData.dart';
import 'package:epasien/app/modules/home/components/MLHomeDetailBooking.dart';
import 'package:epasien/app/modules/home/controllers/home_controller.dart';
import 'package:epasien/app/modules/riwayat_booking/components/MLAppintmentDetailScreen.dart';
import 'package:epasien/app/modules/riwayat_booking/controllers/riwayat_booking_controller.dart';
import 'package:epasien/app/routes/app_pages.dart';
import 'package:epasien/app/utils/MLColors.dart';
import 'package:epasien/app/utils/MLDataProvider.dart';
import 'package:epasien/app/utils/MLString.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class MLHomeBottomComponent extends StatefulWidget {
  static String tag = '/MLHomeBottomComponent';

  @override
  MLHomeBottomComponentState createState() => MLHomeBottomComponentState();
}

class MLHomeBottomComponentState extends State<MLHomeBottomComponent> {
  final controller = Get.put(HomeController());
  final cBooking = Get.put(RiwayatBookingController());
  List<MLDepartmentData> departmentList = mlDepartmentDataList();

  List<MLTopHospitalData> tophospitalList = mlTopHospitalDataList();

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
    return Column(
      children: [
        8.height,
        Row(
          children: [
            Text('Booking', style: boldTextStyle(size: 18)).expand(),
            Icon(Icons.refresh).onTap(() => controller.onRefreshBooking()),
          ],
        ).paddingOnly(left: 16, right: 16),
        Obx(
          () => controller.listBooking.value.isNotEmpty
              ? Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 8.0),
                      decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: Colors.grey.shade50,
                        borderRadius: radius(12),
                      ),
                      child: Column(
                        children: [
                          20.height,
                          Row(
                            children: [
                              Container(
                                height: 75,
                                width: 75,
                                decoration: boxDecorationWithRoundedCorners(
                                    backgroundColor: controller
                                                .listBooking.value[0].status ==
                                            'Terdaftar'
                                        ? Colors.green
                                        : controller.listBooking.value[0]
                                                    .status ==
                                                'Belum'
                                            ? mlColorDarkBlue
                                            : Colors.red,
                                    borderRadius: radius(12)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        (DateFormat('dd').format(controller
                                                .listBooking
                                                .value[0]
                                                .tanggalPeriksa!))
                                            .validate(),
                                        style: boldTextStyle(
                                            size: 32, color: white)),
                                    Text(
                                        (DateFormat('MMMM').format(controller
                                                .listBooking
                                                .value[0]
                                                .tanggalPeriksa!))
                                            .validate(),
                                        style:
                                            secondaryTextStyle(color: white)),
                                  ],
                                ),
                              ),
                              8.width,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          (controller
                                                  .listBooking.value[0].nmPoli)
                                              .validate(),
                                          style: boldTextStyle(size: 18)),
                                      8.height,
                                      Text(
                                          (controller.listBooking.value[0]
                                                  .nmDokter)
                                              .validate(),
                                          style: secondaryTextStyle()),
                                      8.height,
                                      // Text('Patient: ' + (e.patient).validate(),
                                      //     style: secondaryTextStyle()),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.topCenter,
                                    padding: EdgeInsets.all(8.0),
                                    decoration: boxDecorationWithRoundedCorners(
                                      backgroundColor: Colors.transparent,
                                      borderRadius: radius(30),
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.1)),
                                    ),
                                  ).paddingBottom(16.0)
                                ],
                              ).expand(),
                            ],
                          ).paddingOnly(right: 16.0, left: 16.0),
                          8.height,
                          Divider(thickness: 0.5),
                          8.height,
                          Row(
                            children: [
                              Text(
                                  'No. Antrian : ' +
                                      controller.listBooking.value[0].noReg!,
                                  style: boldTextStyle(color: mlColorDarkBlue)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Detail booking',
                                      style: secondaryTextStyle(
                                          color: mlColorDarkBlue)),
                                  4.width,
                                  Icon(Icons.arrow_forward,
                                      color: mlPrimaryColor, size: 16),
                                ],
                              ).onTap(() {
                                controller.selectedRiwayatBooking.value =
                                    controller.listBooking.value[0];
                                MLHomeDetailBooking().launch(context);
                              }).expand()
                            ],
                          ).paddingOnly(right: 16.0, left: 16.0),
                          16.height,
                        ],
                      ),
                    ).paddingBottom(16.0),
                  ],
                ).paddingOnly(right: 16.0, left: 16.0)
              : Text("Data Booking Kosong", style: boldTextStyle()).center(),
        ),
        Row(
          children: [
            Text('Informasi', style: boldTextStyle(size: 18)).expand(),
            // Text(mlView_all!, style: secondaryTextStyle(color: mlColorBlue)),
            // 4.width,
            // Icon(Icons.keyboard_arrow_right, color: mlColorBlue, size: 16),
          ],
        ).paddingAll(16.0),
        Obx(
          () => HorizontalList(
            padding: EdgeInsets.only(right: 16.0, left: 8.0),
            wrapAlignment: WrapAlignment.spaceBetween,
            itemCount: controller.listWeb.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(left: 8),
                width: Get.width * 0.9,
                decoration: boxDecorationRoundedWithShadow(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                            (controller
                                    .listWeb
                                    .value[index]
                                    .betterFeaturedImage!
                                    .mediaDetails!
                                    .sizes!['medium_large']!
                                    .sourceUrl!)
                                .validate(),
                            height: Get.height * 0.25,
                            width: Get.width,
                            fit: BoxFit.fill)
                        .cornerRadiusWithClipRRectOnly(topLeft: 8, topRight: 8),
                    8.height,
                    Text(
                      (controller.listWeb.value[index].title!.rendered!)
                          .validate(),
                      style: boldTextStyle(),
                      overflow: TextOverflow.ellipsis,
                    ).paddingOnly(left: 8.0),
                    4.height,
                    // Text((tophospitalList[index].subtitle).validate(),
                    //         style: secondaryTextStyle())
                    //     .paddingOnly(left: 8.0),
                    10.height
                  ],
                ),
              ).onTap(() => Get.toNamed(Routes.WEBVIEW,
                  arguments: controller.listWeb.value[index].link));
            },
          ),
        ),
      ],
    );
  }
}
