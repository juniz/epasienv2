import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:ALPOKAT/app/utils/MLImage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/src/extensions/widget_extensions.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mlPrimaryColor,
      body: Image.asset(
        'images/logo.png',
        height: 150,
        width: 150,
        fit: BoxFit.fill,
      ).center(),
    );
  }
}
