import 'package:ALPOKAT/app/modules/halaman_booking/controllers/halaman_booking_controller.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

class MLAppointmentDetailList extends StatefulWidget {
  @override
  MLAppointmentDetailListState createState() => MLAppointmentDetailListState();
}

class MLAppointmentDetailListState extends State<MLAppointmentDetailList> {
  final controller = Get.find<HalamanBookingController>();
  // List<MLTopHospitalData> topHospitalList = mlHospitalListDataList();

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
    return SingleChildScrollView(
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
            Image.asset(
              ('images/reservation.jpg').validate(),
              width: double.infinity,
              height: 170.0,
              fit: BoxFit.cover,
            ).cornerRadiusWithClipRRect(8.0),
            16.height,
            Text(('${controller.setting.value.data?.namaInstansi}').validate(),
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
            Text('${DateFormat("dd-MM-yyyy").format(controller.selectedDate.value)} ${controller.selectedJam.value}',
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
    );
  }
}
