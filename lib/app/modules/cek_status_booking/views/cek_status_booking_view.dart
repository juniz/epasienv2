import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/cek_status_booking_controller.dart';

class CekStatusBookingView extends GetView<CekStatusBookingController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.height,
              Text('Cek Status Booking', style: boldTextStyle(size: 25))
                  .center(),
              32.height,
              Text('Nomor Booking', style: primaryTextStyle())
                  .paddingOnly(left: 16),
              AppTextField(
                controller: TextEditingController(), // Optional
                textFieldType: TextFieldType.PHONE,
                decoration: InputDecoration(
                    labelText: 'Nomor Booking', border: OutlineInputBorder()),
              ).paddingAll(16),
              Text('Nomor HP/Telp', style: primaryTextStyle())
                  .paddingOnly(left: 16),
              AppTextField(
                controller: TextEditingController(), // Optional
                textFieldType: TextFieldType.PHONE,
                maxLines: 2,
                decoration: InputDecoration(
                    labelText: 'Nomor HP/Telp', border: OutlineInputBorder()),
              ).paddingAll(16),
              AppButton(
                color: mlPrimaryColor,
                width: Get.width,
                onTap: () {},
                enableScaleAnimation: true,
                child: Text('Cek Status', style: boldTextStyle(color: white)),
              ).paddingAll(16)
            ],
          )),
    );
  }
}
