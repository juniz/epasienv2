import 'package:ALPOKAT/app/components/MLBottomNavigationBarWidget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          backgroundColor: white,
          body: controller.widgets[controller.currentWidget.value],
          floatingActionButton: FloatingActionButton(
              child: Image.asset('images/whatsapp.png'),
              // tooltip: 'Telehot',
              onPressed: () => controller.whatsAppOpen()),
          bottomNavigationBar: Container(
            color: Colors.white,
            child: showBottomDrawer(),
          ),
        ),
      ),
    );
  }

  Widget showBottomDrawer() {
    return MLBottomNavigationBarWidget(
      index: controller.currentWidget.value,
      onTap: (index) {
        controller.currentWidget.value = index;
      },
    );
  }
}
