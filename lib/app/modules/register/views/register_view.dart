import 'package:ALPOKAT/app/modules/register/components/MLDetailBookingPeriksa.dart';
import 'package:ALPOKAT/app/modules/register/components/MLRegisterComponent.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:ALPOKAT/app/utils/MLCommon.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mlPrimaryColor,
        body: Obx(
          // ignore: deprecated_member_use
          () => controller.bookingPeriksa.value.isNull
              ? Stack(
                  children: [
                    Container(
                      decoration: boxDecorationWithRoundedCorners(
                          borderRadius: radiusOnly(topRight: 32)),
                      height: double.infinity,
                      padding: EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            60.height,
                            Text('Pasien Baru', style: boldTextStyle(size: 24))
                                .paddingLeft(30),
                            32.height,
                            controller.isLoading.value
                                ? Center(child: CircularProgressIndicator())
                                : MLRgisterComponent(),
                            42.height,
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        top: 55, child: mlBackToPrevious(context, blackColor)),
                    Positioned(
                      bottom: 8,
                      left: 16,
                      right: 16,
                      child: AppButton(
                        height: 50,
                        width: Get.width,
                        color: mlPrimaryColor,
                        onTap: () {
                          controller.postPasienBaru();
                        },
                        child:
                            Text('Daftar', style: boldTextStyle(color: white)),
                      ).cornerRadiusWithClipRRect(10),
                    ),
                  ],
                )
              : MLDetailBookingPeriksa(),
        ));
  }
}
