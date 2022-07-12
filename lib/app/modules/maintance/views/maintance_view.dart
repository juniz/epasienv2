import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../utils/MLColors.dart';
import '../controllers/maintance_controller.dart';

class MaintanceView extends GetView<MaintanceController> {
  const MaintanceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mlPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('lottie/maintenance.json'),
            Text(
              'Aplikasi Sedang Dalam Perbaikan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: white,
              ),
              overflow: TextOverflow.clip,
            ),
          ],
        ),
      ),
    );
  }
}
