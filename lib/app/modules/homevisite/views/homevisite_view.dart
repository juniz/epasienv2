import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/homevisite_controller.dart';

class HomevisiteView extends GetView<HomevisiteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomevisiteView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'HomevisiteView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
