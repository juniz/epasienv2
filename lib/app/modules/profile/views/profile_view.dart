import 'package:ALPOKAT/app/modules/profile/components/MLProfileBottomComponent.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:ALPOKAT/app/utils/MLImage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 225,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: mlColorDarkBlue,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.logout,
                          color: white,
                          size: 30,
                        ).onTap(() {
                          showConfirmDialog(
                            context,
                            'Anda yakin ingin keluar dari aplikasi?',
                            positiveText: 'Ya',
                            negativeText: 'Tidak',
                            onAccept: () {
                              controller.logOut();
                            },
                          );
                        }),
                      ).paddingAll(10),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                child: controller.session.jk.val == 'P'
                                    ? Image.asset(ml_ic_profile_picture!)
                                    : Image.asset('images/profile.png'),
                                radius: 40.0,
                                backgroundColor: mlColorCyan),
                            8.height,
                            Text(controller.session.nama.val,
                                style: boldTextStyle(color: white, size: 20)),
                            4.height,
                            Text(controller.session.rkm.val,
                                style:
                                    secondaryTextStyle(color: white, size: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == 0) {
                    return MLProfileBottomComponent();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
