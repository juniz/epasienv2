import 'package:ALPOKAT/app/routes/app_pages.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:ALPOKAT/app/utils/MLImage.dart';
import 'package:ALPOKAT/app/utils/MLString.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/setting.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mlPrimaryColor,
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 250),
              height: Get.height,
              decoration: boxDecorationWithRoundedCorners(
                  borderRadius: radiusOnly(topRight: 32)),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    30.height,
                    Text(
                      'LOGIN',
                      style: boldTextStyle(size: 24),
                      textAlign: TextAlign.left,
                    ).center(),
                    16.height,
                    AppTextField(
                      textFieldType: TextFieldType.PHONE,
                      controller: controller.username,
                      decoration: InputDecoration(
                        labelText: 'NRP/Nomor Rekam Medik',
                        labelStyle: secondaryTextStyle(size: 16),
                        prefixIcon: Icon(Icons.credit_card),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: mlColorLightGrey),
                        ),
                      ),
                    ),
                    16.height,
                    AppTextField(
                      textFieldType: TextFieldType.PHONE,
                      controller: controller.password,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: secondaryTextStyle(size: 16),
                        prefixIcon: Icon(Icons.lock_outline),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: mlColorLightGrey),
                        ),
                      ),
                    ),
                    8.height,
                    24.height,
                    AppButton(
                      color: mlPrimaryColor,
                      width: double.infinity,
                      onTap: () {
                        if (controller.username.text.isEmpty) {
                          toasty(
                            context,
                            'NRP/Nomor Rekam Medis tidak boleh kosong',
                          );
                        } else if (controller.password.text.isEmpty) {
                          toasty(context, 'Tanggal lahir tidak boleh kosong');
                        } else {
                          controller.login();
                        }
                      },
                      child: Text(mlLogin!, style: boldTextStyle(color: white)),
                    ).cornerRadiusWithClipRRect(10),
                    22.height,
                    22.height,
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Panduan',
                              style: primaryTextStyle(),
                            ).onTap(() => Get.toNamed(Routes.PANDUAN)),
                            6.width,
                            Icon(
                              Icons.announcement_outlined,
                              color: mlColorBlue,
                            ),
                          ],
                        ),
                        8.height,
                        controller.pasienBaru == "true"
                            ? Column(
                                children: [
                                  Text(
                                    'Belum punya Nomor Rekam Medik?',
                                    style: primaryTextStyle(),
                                  ),
                                  8.height,
                                  Text(
                                    'Klik Pasien Baru',
                                    style: boldTextStyle(
                                      size: 16,
                                      color: mlColorBlue,
                                      // decoration: TextDecoration.underline,
                                    ),
                                  ).onTap(() {
                                    Get.toNamed(Routes.REGISTER);
                                  }),
                                ],
                              )
                            : Container(),
                      ],
                    ).center(),
                    32.height,
                  ],
                ).paddingOnly(left: 16, right: 16),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 75),
              width: Get.width,
              child: Image.asset(
                'images/alpokat.png',
                alignment: Alignment.center,
                width: 150,
                height: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
