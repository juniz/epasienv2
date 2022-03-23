import 'package:ALPOKAT/app/modules/register/controllers/register_controller.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:ALPOKAT/app/utils/MLCommon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class MLDetailBookingPeriksa extends StatelessWidget {
  const MLDetailBookingPeriksa({Key? key}) : super(key: key);
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
    final controller = Get.put(RegisterController());
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
                          Text(('Rumah Sakit Bhayangkara Nganjuk').validate(),
                              style: boldTextStyle()),
                          16.height,
                          Divider(thickness: 0.5),
                          16.height,
                          mOption('No. Booking'),
                          4.height,
                          Text(controller.bookingPeriksa.value['no_booking'],
                                  style:
                                      primaryTextStyle(color: mlColorDarkBlue))
                              .paddingLeft(18.0),
                          16.height,
                          mOption('Nama'),
                          4.height,
                          Text(controller.bookingPeriksa.value['nama'],
                                  style:
                                      primaryTextStyle(color: mlColorDarkBlue))
                              .paddingLeft(18.0),
                          16.height,
                          mOption('No. HP'),
                          4.height,
                          Text(controller.bookingPeriksa.value['hp'],
                                  style:
                                      primaryTextStyle(color: mlColorDarkBlue))
                              .paddingLeft(18.0),
                          16.height,
                          mOption('Tanggal Lahir'),
                          4.height,
                          Text(
                                  DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(controller
                                          .bookingPeriksa.value['tgl_lahir'])),
                                  style:
                                      primaryTextStyle(color: mlColorDarkBlue))
                              .paddingLeft(18.0),
                          16.height,
                          mOption('Pesan'),
                          4.height,
                          Text(controller.bookingPeriksa.value['pesan'],
                                  style:
                                      primaryTextStyle(color: mlColorDarkBlue))
                              .paddingLeft(18.0),
                          16.height,
                          mOption('Poliklinik'),
                          4.height,
                          Text(controller.bookingPeriksa.value['kd_poli'],
                                  style:
                                      primaryTextStyle(color: mlColorDarkBlue))
                              .paddingLeft(18.0),
                          16.height,
                          // mOption('Dokter'),
                          // 4.height,
                          // Text(
                          //         controller
                          //             .selectedRiwayatBooking.value.nmDokter
                          //             .validate(),
                          //         style:
                          //             primaryTextStyle(color: mlColorDarkBlue))
                          //     .paddingLeft(18.0),
                          // 16.height,
                          mOption('Tanggal Rencana Periksa'),
                          4.height,
                          Text(
                                  DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(controller
                                          .bookingPeriksa.value['tgl_daftar'])),
                                  style:
                                      primaryTextStyle(color: mlColorDarkBlue))
                              .paddingLeft(18.0),
                          16.height,
                          // mOption('Jenis Bayar'),
                          // 4.height,
                          // Text(
                          //         controller
                          //             .selectedRiwayatBooking.value.pngJawab!,
                          //         style:
                          //             primaryTextStyle(color: mlColorDarkBlue))
                          //     .paddingLeft(18.0),
                          // 16.height,
                          // mOption('Status'),
                          // 4.height,
                          // Text(controller.selectedRiwayatBooking.value.status!,
                          //         style:
                          //             primaryTextStyle(color: mlColorDarkBlue))
                          //     .paddingLeft(18.0),
                          // 16.height,
                          // controller.selectedRiwayatBooking.value.status ==
                          //         'Belum'
                          //     ? Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           AppButton(
                          //             height: 50,
                          //             width: Get.width / 3,
                          //             color: mlColorDarkBlue,
                          //             child: Text(
                          //               "Check In",
                          //               style: boldTextStyle(color: white),
                          //             ),
                          //             onTap: () => showConfirmDialog(
                          //               context,
                          //               'Anda yakin ingin melakukan check in booking?',
                          //               onAccept: () {},
                          //               positiveText: 'Ya',
                          //               negativeText: 'Tidak',
                          //             ),
                          //           ).cornerRadiusWithClipRRect(10),
                          //           AppButton(
                          //             height: 50,
                          //             width: Get.width / 3,
                          //             color: Colors.red,
                          //             child: Text(
                          //               "Batal",
                          //               style: boldTextStyle(color: white),
                          //             ),
                          //             onTap: () => showConfirmDialog(
                          //               context,
                          //               'Anda yakin ingin membatalkan booking?',
                          //               onAccept: () {},
                          //               positiveText: 'Ya',
                          //               negativeText: 'Tidak',
                          //             ),
                          //           ).cornerRadiusWithClipRRect(10)
                          //         ],
                          //       )
                          //     : Container(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AppButton(
                                height: 50,
                                width: Get.width / 3,
                                color: mlColorDarkBlue,
                                child: Text(
                                  "Check",
                                  style: boldTextStyle(color: white),
                                ),
                                onTap: () => controller.cekStatusBooking(),
                              ).cornerRadiusWithClipRRect(10),
                              // AppButton(
                              //   height: 50,
                              //   width: Get.width / 3,
                              //   color: Colors.red,
                              //   child: Text(
                              //     "Batal",
                              //     style: boldTextStyle(color: white),
                              //   ),
                              //   onTap: () => showConfirmDialog(
                              //     context,
                              //     'Anda yakin ingin membatalkan booking?',
                              //     onAccept: () {},
                              //     positiveText: 'Ya',
                              //     negativeText: 'Tidak',
                              //   ),
                              // ).cornerRadiusWithClipRRect(10)
                            ],
                          ),
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
