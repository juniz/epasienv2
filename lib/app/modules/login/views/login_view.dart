import 'package:epasien/app/utils/MLColors.dart';
import 'package:epasien/app/utils/MLImage.dart';
import 'package:epasien/app/utils/MLString.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mlPrimaryColor,
      body: Stack(
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
                  60.height,
                  Text(mlLogin_title!, style: secondaryTextStyle(size: 16)),
                  16.height,
                  AppTextField(
                    textFieldType: TextFieldType.PHONE,
                    controller: controller.username,
                    decoration: InputDecoration(
                      labelText: 'NRP/Nomor Rekam Medis',
                      labelStyle: secondaryTextStyle(size: 16),
                      prefixIcon: Icon(Icons.credit_card),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: mlColorLightGrey),
                      ),
                    ),
                  ),
                  16.height,
                  AppTextField(
                    textFieldType: TextFieldType.PASSWORD,
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
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(mlForget_password!,
                            style: secondaryTextStyle(size: 16))
                        .onTap(() {
                      // MLForgetPasswordScreen().launch(context);
                    }),
                  ),
                  24.height,
                  AppButton(
                    color: mlPrimaryColor,
                    width: double.infinity,
                    onTap: () {
                      if (controller.username.text.isEmpty) {
                        toast(
                          'NRP/Nomor Rekam Medis tidak boleh kosong',
                        );
                      } else if (controller.password.text.isEmpty) {
                        toast('Password tidak boleh kosong');
                      } else {
                        controller.login();
                      }
                    },
                    child: Text(mlLogin!, style: boldTextStyle(color: white)),
                  ).cornerRadiusWithClipRRect(10),
                  22.height,
                  Text(mlLogin_with!, style: secondaryTextStyle(size: 16))
                      .center(),
                  22.height,
                  // MLSocialAccountsComponent(),
                  22.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        mlDont_have_account!,
                        style: primaryTextStyle(),
                      ),
                      8.width,
                      Text(
                        mlRegister!,
                        style: boldTextStyle(
                            color: mlColorBlue,
                            decoration: TextDecoration.underline),
                      ).onTap(() {
                        // MLRegistrationScreen().launch(context);
                      }),
                    ],
                  ),
                  32.height,
                ],
              ).paddingOnly(left: 16, right: 16),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 75),
            width: Get.width,
            child: Image.asset(
              'images/rsbnganjuk.png',
              alignment: Alignment.center,
              width: 150,
              height: 150,
            ),
          ),
        ],
      ),
    );
  }
}
