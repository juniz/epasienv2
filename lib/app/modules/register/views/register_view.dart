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
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 24.0),
            decoration: boxDecorationWithRoundedCorners(
                borderRadius: radiusOnly(topRight: 32)),
            height: double.infinity,
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  54.height,
                  Text('Buat Janji/Booking', style: boldTextStyle(size: 24)),
                  32.height,
                  MLRgisterComponent(),
                  42.height,
                ],
              ),
            ),
          ),
          Positioned(top: 30, child: mlBackToPrevious(context, blackColor)),
          Positioned(
            bottom: 8,
            left: 16,
            right: 16,
            child: AppButton(
              height: 50,
              width: Get.width,
              color: mlPrimaryColor,
              onTap: () {
                // finish(context);
                // finish(context);
                // finish(context);
                // finish(context);
                // return MLDashboardScreen().launch(context);
              },
              child: Text('Daftar', style: boldTextStyle(color: white)),
            ).cornerRadiusWithClipRRect(10),
          ),
        ],
      ),
    );
  }
}
