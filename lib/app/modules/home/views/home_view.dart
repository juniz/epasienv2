import 'package:ALPOKAT/app/modules/home/components/MLHomeBottomComponent.dart';
import 'package:ALPOKAT/app/modules/home/components/MLHomeTopComponent.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/src/extensions/int_extensions.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MLHomeTopComponent(),
            16.height,
            MLHomeBottomComponent(),
            64.height,
          ],
        ),
      ),
    );
  }
}
