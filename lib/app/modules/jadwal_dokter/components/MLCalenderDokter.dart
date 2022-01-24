import 'package:ALPOKAT/app/modules/jadwal_dokter/controllers/jadwal_dokter_controller.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class MLCalenderDokter extends StatefulWidget {
  MLCalenderDokter({Key? key}) : super(key: key);

  @override
  _MLCalenderDokterState createState() => _MLCalenderDokterState();
}

class _MLCalenderDokterState extends State<MLCalenderDokter> {
  final c = Get.find<JadwalDokterController>();
  DateTime selectedDate = DateTime.now().add(Duration(days: 1));

  int currentDateSelectedIndex = 0;
  ScrollController scrollController = ScrollController();

  List<String> listOfMonths = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  List<String> listOfDays = ["Sen", "Sel", "Rab", "Kam", "Jum", "Sab", "Min"];
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 0);
        },
        itemCount: 7,
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          var day = index + 1;
          return Container(
            height: 70,
            width: 60,
            alignment: Alignment.center,
            decoration: boxDecorationWithRoundedCorners(
              backgroundColor:
                  currentDateSelectedIndex == index ? mlColorBlue : white,
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  listOfDays[
                          DateTime.now().add(Duration(days: day)).weekday - 1]
                      .toString(),
                  style: secondaryTextStyle(
                    size: 16,
                    color:
                        currentDateSelectedIndex == index ? white : mlColorBlue,
                  ),
                ),
                4.height,
                Text(
                  DateTime.now().add(Duration(days: day)).day.toString(),
                  style: boldTextStyle(
                      size: 22,
                      color: currentDateSelectedIndex == index ? white : black),
                ),
                4.height,
              ],
            ),
          ).paddingLeft(8.0).onTap(() {
            setState(() {
              currentDateSelectedIndex = index;
            });
            c.selectedIndex.value = 0;
            c.selectedDate.value = DateTime.now().add(Duration(days: day));
            c.getPoliklinik();
          });
        },
      ),
    );
  }
}
