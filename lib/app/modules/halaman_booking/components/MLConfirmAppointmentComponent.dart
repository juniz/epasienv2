import 'package:ALPOKAT/app/modules/halaman_booking/controllers/halaman_booking_controller.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import 'MLAppointmentDetailList.dart';

class MLConfirmAppointmentComponent extends StatelessWidget {
  // final controller = Get.find<HalamanBookingController>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.height,
              Text('Verifikasi Booking', style: boldTextStyle(size: 24))
                  .paddingLeft(16),
              8.height,
              // Text('Find the service you are', style: secondaryTextStyle())
              //     .paddingLeft(16),
              // 16.height,
              MLAppointmentDetailList(),
            ],
          ),
        ),
        // Text(
        //   'Add Voucher',
        //   style: boldTextStyle(
        //       color: mlColorDarkBlue, decoration: TextDecoration.underline),
        // ).paddingOnly(bottom: 70, right: 16).onTap(() {
        //   MLAddVoucherScreen().launch(context);
        // }),
      ],
    );
  }
}
