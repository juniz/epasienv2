import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/MLEmptyWidget.dart';
import '../../../utils/MLColors.dart';
import '../../../utils/MLCommon.dart';
import '../controllers/jadwal_operasi_controller.dart';
import '../models/jadwal_operasi_model.dart';

class JadwalOperasiView extends GetView<JadwalOperasiController> {
  const JadwalOperasiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: mlPrimaryColor,
          body: Column(
            children: [
              Row(
                children: [
                  mlBackToPreviousIcon(context, white),
                  8.width,
                  Text('Jadwal Operasi',
                          style: boldTextStyle(color: whiteColor, size: 20))
                      .expand(),
                ],
              ).paddingAll(16.0),
              Container(
                width: Get.width,
                decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: mlColorGreyShade,
                  borderRadius: radiusOnly(topRight: 35),
                ),
                child: Container(
                  height: Get.height * 0.84,
                  padding: EdgeInsets.all(16.0),
                  decoration: boxDecorationWithRoundedCorners(
                    backgroundColor: mlColorGreyShade,
                    borderRadius: radius(8),
                  ),
                  child: Obx(
                    () => controller.isLoading.value
                        ? GFShimmer(
                            child: Column(
                              children: [
                                MLEmptyWidget(),
                                MLEmptyWidget(),
                                MLEmptyWidget(),
                                MLEmptyWidget(),
                              ],
                            ),
                          )
                        : controller.isEmpty.value
                            ? Column(
                                children: [
                                  Lottie.asset('lottie/search-not-found.json')
                                      .flexible(flex: 3),
                                  Text(
                                    'Jadwal Operasi Kosong',
                                    style: boldTextStyle(size: 20),
                                  ).flexible(),
                                ],
                              ).withSize(width: 300, height: 300).center()
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    controller.jadwalOperasi.value.data?.length,
                                itemBuilder: (context, index) {
                                  return Material(
                                    elevation: 10,
                                    child: GFListTile(
                                      margin: EdgeInsets.all(0),
                                      padding: EdgeInsets.all(0),
                                      color: white,
                                      avatar: Container(
                                        color: mlPrimaryColor,
                                        width: 90,
                                        height: 80,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              DateFormat('d').format(controller
                                                  .jadwalOperasi
                                                  .value
                                                  .data![index]
                                                  .tanggal!),
                                              style: boldTextStyle(
                                                  color: white, size: 16),
                                            ),
                                            Text(
                                              DateFormat('MMMM', 'id').format(
                                                  controller.jadwalOperasi.value
                                                      .data![index].tanggal!),
                                              style: boldTextStyle(
                                                  color: white, size: 20),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '${controller.jadwalOperasi.value.data![index].jamMulai!.substring(0, 5)} - ${controller.jadwalOperasi.value.data![index].jamSelesai!.substring(0, 5)}',
                                              style: boldTextStyle(
                                                  color: white, size: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                      titleText: controller.jadwalOperasi.value
                                              .data![index].noRawat ??
                                          '',
                                      subTitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.jadwalOperasi.value
                                                    .data![index].nmDokter ??
                                                '',
                                            style: primaryTextStyle(),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            controller.jadwalOperasi.value
                                                    .data![index].nmPerawatan ??
                                                '',
                                            style: primaryTextStyle(size: 15),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                      .cornerRadiusWithClipRRect(10)
                                      .paddingBottom(10);
                                },
                              ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
