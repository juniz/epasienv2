import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MLEmptyWidget extends StatelessWidget {
  const MLEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 100,
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 20,
                  color: Colors.white,
                ),
                const SizedBox(height: 6),
                Container(
                  width: Get.width * 0.5,
                  height: 20,
                  color: Colors.white,
                ),
                const SizedBox(height: 6),
                Container(
                  width: Get.width * 0.25,
                  height: 20,
                  color: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
