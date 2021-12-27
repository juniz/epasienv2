import 'package:epasien/app/modules/jadwal_dokter/components/MLCalenderDokter.dart';
import 'package:epasien/app/modules/jadwal_dokter/controllers/jadwal_dokter_controller.dart';
import 'package:epasien/app/utils/MLColors.dart';
import 'package:epasien/app/utils/MLImage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/src/extensions/int_extensions.dart';

class MLJadwalDokterComponent extends StatelessWidget {
  const MLJadwalDokterComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JadwalDokterController>();
    return SingleChildScrollView(
      child: Column(
        children: [
          16.height,
          MLCalenderDokter(),
          8.height,
          Obx(
            () => controller.listPoliklinik.isEmpty
                ? Column(
                    children: [
                      Lottie.asset('lottie/search-not-found.json')
                          .flexible(flex: 3),
                      Text(
                        'Jadwal tidak ditemukan',
                        style: primaryTextStyle(),
                      ).flexible(),
                    ],
                  ).withSize(width: 300, height: 300).center()
                : ListView.builder(
                    padding:
                        EdgeInsets.only(right: 16.0, left: 16.0, bottom: 70),
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: controller.listPoliklinik.length,
                    itemBuilder: (context, index) {
                      return Obx(
                        () => Container(
                          margin: EdgeInsets.only(bottom: 16),
                          padding: EdgeInsets.all(8.0),
                          decoration: boxDecorationWithRoundedCorners(
                            border: Border.all(
                              color: controller.selectedIndex.value == index
                                  ? mlColorBlue
                                  : mlColorLightGrey100,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                          ('images/hospital.png').validate(),
                                          height: 75,
                                          width: 75,
                                          fit: BoxFit.fill)
                                      .paddingAll(8.0)
                                      .expand(flex: 1),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          (controller.listPoliklinik
                                                  .value[index].nmPoli)!
                                              .validate(),
                                          style: boldTextStyle(size: 18)),
                                      8.height,
                                      // Text((departmentList[index].subtitle).validate(),
                                      //     style: secondaryTextStyle()),
                                      // 8.height,
                                      Text(
                                          (controller.listPoliklinik
                                                  .value[index].nmDokter)
                                              .validate(),
                                          style: boldTextStyle(
                                              color: mlColorDarkBlue)),
                                    ],
                                  ).expand(flex: 3),
                                ],
                              ),
                              8.height,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Icon(
                                              Icons.watch_later_outlined,
                                              size: 14),
                                        ),
                                        TextSpan(
                                            text: ' Jam pelayanan',
                                            style: secondaryTextStyle()),
                                      ],
                                    ),
                                  ),
                                  Text(
                                      '${controller.listPoliklinik.value[index].jamMulai} - ${controller.listPoliklinik.value[index].jamSelesai}',
                                      style: secondaryTextStyle(
                                          color: Colors.black87)),
                                ],
                              ).paddingOnly(left: 8, right: 8),
                              8.height,
                            ],
                          ),
                        ).onTap(
                          () {
                            // print(
                            //     controller.listPoliklinik.value[index].nmDokter);
                            controller.selectedIndex.value = index;
                            controller.selectedKdDokter.value = controller
                                .listPoliklinik.value[index].kdDokter!;
                            controller.selectedDokter.value = controller
                                .listPoliklinik.value[index].nmDokter!;
                            controller.selectedKdPoli.value =
                                controller.listPoliklinik.value[index].kdPoli!;
                            controller.selectedPoli.value =
                                controller.listPoliklinik.value[index].nmPoli!;
                            controller.selectedJam.value =
                                '${controller.listPoliklinik.value[index].jamMulai!} - ${controller.listPoliklinik.value[index].jamSelesai!}';
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
