import 'package:ALPOKAT/app/data/MLTopHospitalData.dart';
import 'package:ALPOKAT/app/modules/home/controllers/home_controller.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:ALPOKAT/app/utils/MLCommon.dart';
import 'package:ALPOKAT/app/utils/MLDataProvider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class MLHomeDetailBooking extends StatefulWidget {
  static String tag = '/MLAppointmentDetailScreen';

  @override
  MLHomeDetailBookingState createState() => MLHomeDetailBookingState();
}

class MLHomeDetailBookingState extends State<MLHomeDetailBooking> {
  final controller = Get.find<HomeController>();
  List<MLTopHospitalData> topHospitalList = mlHospitalListDataList();
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

  Widget mOption(var value) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Icon(Icons.location_searching, size: 12).paddingRight(8),
          ),
          TextSpan(
              text: value, style: secondaryTextStyle(size: 12, color: black)),
        ],
      ),
    );
  }

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
                  Text('Detail Booking', style: boldTextStyle(size: 24)),
                ],
              ).paddingAll(16),
              Flexible(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 80),
                    padding: EdgeInsets.all(12.0),
                    decoration: boxDecorationWithRoundedCorners(
                        border: Border.all(color: mlColorLightGrey),
                        borderRadius: radius(12)),
                    child: Obx(
                      () => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('images/reservation.jpg',
                                  width: double.infinity,
                                  height: 150.0,
                                  fit: BoxFit.cover)
                              .cornerRadiusWithClipRRect(8.0),
                          16.height,
                          Text(
                              ('${controller.setting.value.data?.namaInstansi}')
                                  .validate(),
                              style: boldTextStyle()),
                          16.height,
                          Divider(thickness: 0.5),
                          16.height,
                          mOption('No. Antrian'),
                          4.height,
                          Text(
                                  controller.selectedRiwayatBooking.value.noReg
                                      .validate(),
                                  style:
                                      primaryTextStyle(color: mlColorDarkBlue))
                              .paddingLeft(18.0),
                          16.height,
                          mOption('Poliklinik'),
                          4.height,
                          Text(
                                  controller.selectedRiwayatBooking.value.nmPoli
                                      .validate(),
                                  style:
                                      primaryTextStyle(color: mlColorDarkBlue))
                              .paddingLeft(18.0),
                          16.height,
                          mOption('Dokter'),
                          4.height,
                          Text(
                                  controller
                                      .selectedRiwayatBooking.value.nmDokter
                                      .validate(),
                                  style:
                                      primaryTextStyle(color: mlColorDarkBlue))
                              .paddingLeft(18.0),
                          16.height,
                          mOption('Tanggal Rencana Periksa'),
                          4.height,
                          Text(
                                  DateFormat("dd-MM-yyyy").format(controller
                                      .selectedRiwayatBooking
                                      .value
                                      .tanggalPeriksa!),
                                  style:
                                      primaryTextStyle(color: mlColorDarkBlue))
                              .paddingLeft(18.0),
                          16.height,
                          mOption('Jenis Bayar'),
                          4.height,
                          Text(
                                  controller
                                      .selectedRiwayatBooking.value.pngJawab!,
                                  style:
                                      primaryTextStyle(color: mlColorDarkBlue))
                              .paddingLeft(18.0),
                          16.height,
                          mOption('Status'),
                          4.height,
                          Text(controller.selectedRiwayatBooking.value.status!,
                                  style:
                                      primaryTextStyle(color: mlColorDarkBlue))
                              .paddingLeft(18.0),
                          16.height,
                          controller.selectedRiwayatBooking.value.status ==
                                  'Belum'
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppButton(
                                      height: 50,
                                      width: Get.width / 3,
                                      color: mlColorDarkBlue,
                                      child: Text(
                                        "Check In",
                                        style: boldTextStyle(color: white),
                                      ),
                                      onTap: () => showConfirmDialog(
                                        context,
                                        'Anda yakin ingin melakukan check in booking?',
                                        onAccept: () {
                                          controller.checkin();
                                        },
                                        positiveText: 'Ya',
                                        negativeText: 'Tidak',
                                      ),
                                    ).cornerRadiusWithClipRRect(10),
                                    AppButton(
                                      height: 50,
                                      width: Get.width / 3,
                                      color: Colors.red,
                                      child: Text(
                                        "Batal",
                                        style: boldTextStyle(color: white),
                                      ),
                                      onTap: () => showConfirmDialog(
                                        context,
                                        'Anda yakin ingin membatalkan booking?',
                                        onAccept: () {
                                          controller.batalCheckin();
                                        },
                                        positiveText: 'Ya',
                                        negativeText: 'Tidak',
                                      ),
                                    ).cornerRadiusWithClipRRect(10)
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ).paddingAll(16.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
