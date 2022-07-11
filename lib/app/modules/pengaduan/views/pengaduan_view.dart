import 'package:ALPOKAT/app/data/MLInboxData.dart';
import 'package:ALPOKAT/app/modules/pengaduan/models/jawaban_pengaduan_model.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:ALPOKAT/app/utils/MLCommon.dart';
import 'package:ALPOKAT/app/utils/MLDataProvider.dart';
import 'package:ALPOKAT/app/utils/MLImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/pengaduan_controller.dart';

class PengaduanView extends GetView<PengaduanController> {
  @override
  Widget build(BuildContext context) {
    List<MLInboxData> data = mlBotChatDataList();
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: Stack(
          children: [
            Positioned(
              top: 8.0,
              child: Row(
                children: [
                  8.width,
                  mlBackToPreviousWidget(context, white),
                  8.width,
                  8.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pengaduan',
                          style: boldTextStyle(color: whiteColor, size: 20)),
                      4.height,
                    ],
                  )
                ],
              ).paddingAll(16.0),
            ),
            Container(
              width: Get.width,
              height: Get.height,
              margin: EdgeInsets.only(top: 70),
              decoration: boxDecorationWithRoundedCorners(
                  borderRadius: radiusOnly(topRight: 32)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    8.height,
                    Obx(
                      () => ListView.builder(
                        padding: EdgeInsets.all(16.0),
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.listPengaduan.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              8.height,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    decoration: boxDecorationWithRoundedCorners(
                                        backgroundColor: Colors.blue.shade500,
                                        borderRadius: radius(12.0)),
                                    padding: EdgeInsets.all(12.0),
                                    child: Column(
                                      children: [
                                        Text(
                                            (controller.listPengaduan
                                                    .value[index].message)
                                                .validate(),
                                            style: primaryTextStyle(
                                              color: white,
                                            )),
                                        // 5.height,
                                        // Text(
                                        //   DateFormat('dd/MM/yyyy H:m:s').format(
                                        //       controller.listPengaduan
                                        //           .value[index].dateTime!),
                                        //   style: primaryTextStyle(
                                        //     size: 10,
                                        //     color: white,
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                  8.width,
                                  CircleAvatar(
                                    backgroundColor: mlColorCyan,
                                    child: Icon(Icons.person)
                                        .cornerRadiusWithClipRRect(30.0),
                                  ),
                                ],
                              ),
                              FutureBuilder(
                                future: controller.jawabanPengaduan(controller
                                    .listPengaduan.value[index].id
                                    .toString()),
                                builder: (context, snap) {
                                  print(snap);
                                  if (snap.hasData) {
                                    var data =
                                        snap.data as List<JawabanPengaduan>;
                                    return Column(
                                      children: data
                                          .map(
                                            (e) => Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor:
                                                      Colors.yellow,
                                                  child: Image.asset(
                                                          ml_ic_doctor_image!,
                                                          fit: BoxFit.fill)
                                                      .cornerRadiusWithClipRRect(
                                                          30.0),
                                                ),
                                                8.width,
                                                Container(
                                                  decoration:
                                                      boxDecorationWithRoundedCorners(
                                                          borderRadius:
                                                              radius(12.0),
                                                          backgroundColor:
                                                              mlColorLightGrey100),
                                                  padding: EdgeInsets.all(16.0),
                                                  child: Text(
                                                    e.message.validate(),
                                                    style: primaryTextStyle(
                                                      color: black,
                                                    ),
                                                  ),
                                                )
                                                    .paddingOnly(
                                                        right: 42.0,
                                                        top: 8,
                                                        bottom: 8)
                                                    .expand(),
                                              ],
                                            ),
                                          )
                                          .toList(),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ).paddingTop(8.0),
          ],
        ),
        bottomNavigationBar: Container(
          padding: MediaQuery.of(context).viewInsets,
          decoration: boxDecorationWithRoundedCorners(
            backgroundColor: white,
            borderRadius: radius(0.0),
            border: Border.all(color: mlColorLightGrey100),
          ),
          child: Row(
            children: [
              8.width,
              AppTextField(
                controller: controller.messageController,
                textFieldType: TextFieldType.OTHER,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Tulis pengaduan disini ...',
                  hintStyle: secondaryTextStyle(size: 16),
                ),
              ).expand(),
              Icon(Icons.send_outlined, size: 24, color: Colors.blue)
                  .paddingAll(4.0)
                  .onTap(() {
                controller.kirimPengaduan();
                controller.pengaduan();
                controller.messageController.clear();
              }),
              8.width,
            ],
          ),
        ),
      ),
    );
  }
}
