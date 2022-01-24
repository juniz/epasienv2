import 'package:ALPOKAT/app/modules/riwayat_booking/components/MLBillingDetailList.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:ALPOKAT/app/utils/MLCommon.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class MLBillingScreen extends StatelessWidget {
  const MLBillingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: Container(
          decoration: boxDecorationWithRoundedCorners(
              borderRadius: radiusOnly(topRight: 32)),
          child: Column(
            children: [
              8.height,
              Row(
                children: [
                  mlBackToPreviousWidget(context, black),
                  Text('Billing Perawatan', style: boldTextStyle(size: 24)),
                ],
              ).paddingAll(16),
              Flexible(
                child: MLBillingDetailList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
