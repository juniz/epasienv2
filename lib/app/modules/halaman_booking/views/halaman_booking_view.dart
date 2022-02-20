import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/halaman_booking_controller.dart';

class HalamanBookingView extends GetView<HalamanBookingController> {
  @override
  Widget build(BuildContext context) {
    final navigatorKey = GlobalObjectKey<NavigatorState>(context);
    String titleNumber =
        controller.data[controller.currentWidget.value].id.validate();
    String titleText =
        controller.data[controller.currentWidget.value].title.validate();
    double progress =
        controller.data[controller.currentWidget.value].progress.validate();
    return WillPopScope(
      key: navigatorKey,
      onWillPop: () async {
        if (controller.currentWidget != 0) {
          if (navigatorKey.currentState!.canPop()) {
            controller.currentWidget--;
            navigatorKey.currentState!.pop();
            return false;
          }
          return true;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                decoration: boxDecorationWithRoundedCorners(
                    borderRadius: radiusOnly(topRight: 32)),
                child: Column(
                  children: <Widget>[
                    8.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Icon(Icons.arrow_back_ios, color: blackColor, size: 24)
                            .onTap(() {
                          controller.currentWidget == 0
                              ? Navigator.of(context).pop()
                              : controller.currentWidget--;
                          // controller.index == controller.currentWidget;
                        }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => Text(
                                'Langkah ${controller.data[controller.currentWidget.value].id.validate()} dari 3: ',
                                textAlign: TextAlign.center,
                                style: boldTextStyle(color: mlColorDarkBlue),
                              ),
                            ),
                            Obx(
                              () => Text(
                                controller
                                    .data[controller.currentWidget.value].title
                                    .validate(),
                                textAlign: TextAlign.center,
                                style: boldTextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.assignment, color: blackColor, size: 24)
                            .onTap(() => Get.toNamed('/riwayat-booking')),
                      ],
                    ).paddingAll(16.0),
                    8.height,
                    Obx(
                      () => LinearProgressIndicator(
                        minHeight: 2.0,
                        backgroundColor: mlColorLightGrey,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(mlColorDarkBlue),
                        value: controller
                            .data[controller.currentWidget.value].progress
                            .validate(),
                      ),
                    ),
                    8.height,
                    Obx(
                      () => controller
                          .data[controller.currentWidget.value].widget
                          .validate()
                          .expand(),
                    ),
                  ],
                ),
              ),
              AppButton(
                height: 50,
                width: Get.width,
                color: mlColorDarkBlue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => Text(
                        controller.currentWidget.value == 2
                            ? "Booking"
                            : "Lanjut",
                        style: boldTextStyle(color: white))),
                    8.width,
                    Icon(Icons.arrow_forward_ios, color: whiteColor, size: 12),
                  ],
                ),
                onTap: () {
                  if (controller.currentWidget.value == 0) {
                    if (controller.selectedKdDokter.value == "") {
                      snackBar(
                        context,
                        title: 'Silahkan pilih poliklinik',
                        backgroundColor: Colors.red,
                      );
                    } else {
                      // print(controller.currentWidget.value);
                      controller.getPenjab();
                      controller.currentWidget.value++;
                    }
                  } else if (controller.currentWidget.value == 1) {
                    controller.currentWidget.value++;
                  } else if (controller.currentWidget.value > 1) {
                    showConfirmDialog(
                      context,
                      'Anda yakin ingin melakukan booking ?',
                      onAccept: () {
                        controller.postBooking();
                      },
                    );
                  }
                },
              )
                  .cornerRadiusWithClipRRect(10)
                  .paddingOnly(right: 16, left: 16, bottom: 16),
            ],
          ),
        ),
      ),
    );
  }
}
