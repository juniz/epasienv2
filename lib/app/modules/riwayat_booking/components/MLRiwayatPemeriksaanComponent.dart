import 'package:ALPOKAT/app/modules/riwayat_booking/controllers/riwayat_booking_controller.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import 'MLBillingScreen.dart';
import 'MLResumeScreen.dart';

class MLRiwayatPemeriksaanComponent extends StatelessWidget {
  const MLRiwayatPemeriksaanComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RiwayatBookingController>();
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.height,
          Obx(
            () => Column(
              children: controller.listRiwayatPemeriksaan.value.map((e) {
                return Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 8.0),
                      decoration: boxDecorationWithRoundedCorners(
                        backgroundColor: Colors.grey.shade50,
                        borderRadius: radius(12),
                      ),
                      child: Column(
                        children: [
                          20.height,
                          Row(
                            children: [
                              Container(
                                height: 75,
                                width: 75,
                                decoration: boxDecorationWithRoundedCorners(
                                    backgroundColor: mlColorDarkBlue,
                                    borderRadius: radius(12)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        (DateFormat('dd')
                                                .format(e.tglRegistrasi!))
                                            .validate(),
                                        style: boldTextStyle(
                                            size: 32, color: white)),
                                    Text(
                                        (DateFormat('MMMM')
                                                .format(e.tglRegistrasi!))
                                            .validate(),
                                        style:
                                            secondaryTextStyle(color: white)),
                                  ],
                                ),
                              ),
                              8.width,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text((e.nmPoli).validate(),
                                          style: boldTextStyle(size: 18)),
                                      8.height,
                                      Text((e.nmDokter).validate(),
                                          style: secondaryTextStyle()),
                                      8.height,
                                      Text((e.statusLanjut).validate(),
                                          style: secondaryTextStyle()),
                                      8.height,
                                    ],
                                  ).expand(),
                                  Container(
                                    alignment: Alignment.topCenter,
                                    padding: EdgeInsets.all(8.0),
                                    decoration: boxDecorationWithRoundedCorners(
                                      backgroundColor: Colors.transparent,
                                      borderRadius: radius(30),
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.1)),
                                    ),
                                    // child: Icon(
                                    //   Icons.notifications_none,
                                    //   color: e.department == 'General Care'
                                    //       ? mlColorBlue
                                    //       : Colors.grey.shade400,
                                    //   size: 24,
                                    // ),
                                  ).paddingBottom(16.0)
                                ],
                              ).expand(),
                            ],
                          ).paddingOnly(right: 16.0, left: 16.0),
                          8.height,
                          Divider(thickness: 0.5),
                          8.height,
                          Row(
                            children: [
                              Text(
                                e.noRawat!,
                                style: boldTextStyle(color: mlColorDarkBlue),
                              ).flexible(flex: 2),
                              4.width,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  AppButton(
                                    child: Text(
                                      'Resume',
                                      style: secondaryTextStyle(color: white),
                                    ),
                                    color: mlPrimaryColor,
                                    onTap: () async {
                                      await controller.resume(e.noRawat);

                                      MLResumeScreen().launch(context);
                                    },
                                  ).cornerRadiusWithClipRRect(10),
                                  4.width,
                                  AppButton(
                                    child: Text(
                                      'Billing',
                                      style: secondaryTextStyle(color: white),
                                    ),
                                    color: mlColorRed,
                                    onTap: () async {
                                      await controller.billing(e.noRawat);
                                      MLBillingScreen().launch(context);
                                    },
                                  ).cornerRadiusWithClipRRect(10),
                                ],
                              ).flexible(flex: 4)
                            ],
                          ).paddingOnly(right: 16.0, left: 16.0),
                          16.height,
                        ],
                      ),
                    ).paddingBottom(16.0),
                    // Positioned(
                    //   left: 16.0,
                    //   child: Container(
                    //     padding: EdgeInsets.all(2.0),
                    //     decoration: boxDecorationWithRoundedCorners(
                    //         backgroundColor: mlColorDarkBlue,
                    //         borderRadius: radius(20)),
                    //     child: Text((e.service.validate()),
                    //             style: secondaryTextStyle(color: white))
                    //         .paddingOnly(right: 10.0, left: 10.0),
                    //   ),
                    // ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
