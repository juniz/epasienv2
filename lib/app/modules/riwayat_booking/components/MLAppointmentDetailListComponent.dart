import 'package:ALPOKAT/app/data/MLAppointmentData.dart';
import 'package:ALPOKAT/app/modules/riwayat_booking/components/MLAppintmentDetailScreen.dart';
import 'package:ALPOKAT/app/modules/riwayat_booking/controllers/riwayat_booking_controller.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:ALPOKAT/app/utils/MLDataProvider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class MLAppointmentDetailListComponent extends StatefulWidget {
  static String tag = '/MLAppointmentDetailListComponent';

  @override
  MLAppointmentDetailListComponentState createState() =>
      MLAppointmentDetailListComponentState();
}

class MLAppointmentDetailListComponentState
    extends State<MLAppointmentDetailListComponent> {
  final controller = Get.find<RiwayatBookingController>();
  String? time = 'Today, 9:30 PM';
  List<MLAppointmentData> data = mlAppointmentDataList();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
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
              children: controller.riwayatBooking.value.map((e) {
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
                                    backgroundColor: e.status == 'Terdaftar'
                                        ? Colors.green
                                        : e.status == 'Belum'
                                            ? mlColorDarkBlue
                                            : Colors.red,
                                    borderRadius: radius(12)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        (DateFormat('dd')
                                                .format(e.tanggalPeriksa!))
                                            .validate(),
                                        style: boldTextStyle(
                                            size: 32, color: white)),
                                    Text(
                                        (DateFormat('MMMM')
                                                .format(e.tanggalPeriksa!))
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
                                      // Text('Patient: ' + (e.patient).validate(),
                                      //     style: secondaryTextStyle()),
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
                              Text('No. ' + e.noReg!,
                                  style: boldTextStyle(color: mlColorDarkBlue)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Detail booking',
                                      style: secondaryTextStyle(
                                          color: mlColorDarkBlue)),
                                  4.width,
                                  Icon(Icons.arrow_forward,
                                      color: mlPrimaryColor, size: 16),
                                ],
                              ).onTap(() {
                                controller.selectedRiwayatBooking.value = e;
                                MLAppointmentDetailScreen().launch(context);
                              }).expand()
                            ],
                          ).paddingOnly(right: 16.0, left: 16.0),
                          16.height,
                        ],
                      ),
                    ).paddingBottom(16.0),
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
