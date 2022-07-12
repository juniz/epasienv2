import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/timeout_controller.dart';

class TimeoutView extends GetView<TimeoutController> {
  const TimeoutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TimeoutView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TimeoutView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
