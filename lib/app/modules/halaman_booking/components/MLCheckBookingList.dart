import 'package:ALPOKAT/app/data/MLTopHospitalData.dart';
import 'package:ALPOKAT/app/modules/halaman_booking/controllers/halaman_booking_controller.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:ALPOKAT/app/utils/MLDataProvider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/src/extensions/int_extensions.dart';

class MLCheckBookingList extends StatelessWidget {
  const MLCheckBookingList({Key? key}) : super(key: key);

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
    final controller = Get.find<HalamanBookingController>();
    List<MLTopHospitalData> topHospitalList = mlHospitalListDataList();
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.height,
              Text('Verifikasi Booking', style: boldTextStyle(size: 24))
                  .paddingLeft(16),
              8.height,
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(bottom: 80),
                  padding: EdgeInsets.all(12.0),
                  decoration: boxDecorationWithRoundedCorners(
                      border: Border.all(color: mlColorLightGrey),
                      borderRadius: radius(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset((topHospitalList[0].image).validate(),
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
                      mOption('Poliklinik'),
                      4.height,
                      Text(controller.selectedPoli.value.validate(),
                              style: primaryTextStyle(color: mlColorDarkBlue))
                          .paddingLeft(18.0),
                      16.height,
                      mOption('Dokter'),
                      4.height,
                      Text(controller.selectedDokter.value.validate(),
                              style: primaryTextStyle(color: mlColorDarkBlue))
                          .paddingLeft(18.0),
                      16.height,
                      mOption('Tanggal Rencana Periksa'),
                      4.height,
                      Text(controller.selectedJam.value,
                              style: primaryTextStyle(color: mlColorDarkBlue))
                          .paddingLeft(18.0),
                      16.height,
                      mOption('Jenis Bayar'),
                      4.height,
                      Text(controller.selectedPenjab.value,
                              style: primaryTextStyle(color: mlColorDarkBlue))
                          .paddingLeft(18.0),
                    ],
                  ),
                ).paddingAll(16.0),
              )
            ],
          ),
        ),
      ],
    );
  }
}
