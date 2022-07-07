import 'package:ALPOKAT/app/data/MLServiceData.dart';
import 'package:ALPOKAT/app/modules/home/controllers/home_controller.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:ALPOKAT/app/utils/MLDataProvider.dart';
import 'package:ALPOKAT/app/utils/MLImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class MLHomeTopComponent extends StatefulWidget {
  static String tag = '/MLHomeTopComponent';

  @override
  _MLHomeTopComponentState createState() => _MLHomeTopComponentState();
}

class _MLHomeTopComponentState extends State<MLHomeTopComponent> {
  int counter = 2;
  List<MLServicesData> data = mlServiceDataList();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Container(
      height: 240,
      width: Get.width,
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: boxDecorationWithRoundedCorners(
        backgroundColor: mlColorDarkBlue,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(Get.width, 50.0),
        ),
      ),
      child: Column(
        children: [
          16.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                      child: Image.asset(controller.session.jk.val == 'P'
                          ? ml_ic_profile_picture!
                          : 'images/profile.png'),
                      radius: 22,
                      backgroundColor: mlColorCyan),
                  8.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Selamat Datang',
                          style: secondaryTextStyle(
                              color: white.withOpacity(0.7))),
                      4.height,
                      Text(
                        controller.session.nama.val,
                        style: boldTextStyle(color: whiteColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  // Icon(Icons.search, color: white, size: 24),
                  // 10.width,
                  Stack(
                    children: [
                      Icon(Icons.shopping_bag_outlined, color: white, size: 24)
                          .visible(false),
                      Positioned(
                        top: 0.0,
                        right: 0.0,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: boxDecorationWithRoundedCorners(
                              backgroundColor: mlColorRed),
                          constraints:
                              BoxConstraints(minWidth: 12, minHeight: 12),
                          child: Text(
                            counter.toString(),
                            style: boldTextStyle(size: 8, color: white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ).onTap(() {
                    // MLAddToCartScreen().launch(context);
                  }),
                ],
              )
            ],
          ).paddingOnly(right: 16.0, left: 16.0),
          Container(
            margin: EdgeInsets.only(right: 16.0, left: 16.0),
            transform: Matrix4.translationValues(0, 16.0, 0),
            alignment: Alignment.center,
            decoration: boxDecorationRoundedWithShadow(12),
            child: Wrap(
              alignment: WrapAlignment.center,
              direction: Axis.horizontal,
              spacing: 8.0,
              children: data.map((e) {
                return Container(
                  constraints: BoxConstraints(minWidth: Get.width * 0.25),
                  padding: EdgeInsets.only(top: 20, bottom: 20.0),
                  child: Column(
                    children: [
                      Image.asset(e.image!,
                          width: 28, height: 28, fit: BoxFit.fill),
                      8.height,
                      Text(e.title.toString(),
                          style: boldTextStyle(size: 12),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ).onTap(() {
                  if (e.title == 'Home Visit') {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime.now().add(Duration(days: 2)),
                        maxTime: DateTime.now().add(Duration(days: 9)),
                        onConfirm: (date) {
                      controller.postHomevisite(date);
                    }, currentTime: DateTime.now(), locale: LocaleType.id);
                  } else {
                    Get.toNamed(e.widget!);
                  }
                });
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
