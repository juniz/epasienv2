import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:ALPOKAT/app/utils/MLImage.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class MLBookedDialog extends StatelessWidget {
  String? desc;
  MLBookedDialog({this.desc});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(''),
      content: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(ml_ic_appointment_booked.toString(),
              width: 250, height: 200, fit: BoxFit.cover),
          Text(desc!, style: boldTextStyle(size: 20)),
          // 4.height,
          // Text(desc!,
          //     style: secondaryTextStyle(size: 12), textAlign: TextAlign.center),
          16.height,
          AppButton(
            height: 50,
            width: context.width(),
            color: mlColorDarkBlue,
            child: Text("Tutup", style: primaryTextStyle(color: whiteColor)),
            onTap: () {
              finish(context);
              finish(context);
            },
          ),
          // 16.height,
          // Container(
          //   alignment: Alignment.center,
          //   height: 50,
          //   width: context.width(),
          //   decoration: boxDecorationWithRoundedCorners(
          //     borderRadius: radius(12),
          //     border: Border.all(color: mlColorBlue),
          //   ),
          //   child:
          //       Text("Tutup", style: primaryTextStyle(color: mlColorDarkBlue)),
          // ).onTap(() {
          //   finish(context);
          //   finish(context);
          // }),
        ],
      )),
      actions: <Widget>[],
    );
  }
}
