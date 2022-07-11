import 'package:ALPOKAT/app/data/MLProfileCardData.dart';
import 'package:ALPOKAT/app/modules/profile/controllers/profile_controller.dart';
import 'package:ALPOKAT/app/utils/MLDataProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class MLProfileBottomComponent extends StatefulWidget {
  static String tag = '/MLProfileBottomComponent';

  @override
  MLProfileBottomComponentState createState() =>
      MLProfileBottomComponentState();
}

class MLProfileBottomComponentState extends State<MLProfileBottomComponent> {
  List<String> data = <String>[
    'Membership card',
    'Dependents',
    'Health care',
    'Refer friends and family'
  ];
  List<String> categoriesData = <String>[
    'Kunjungan',
    'Rawat Inap',
    'Rawat Jalan',
    'Bulan Ini'
  ];
  List<Color> customColor = <Color>[
    Colors.blueAccent,
    Colors.orangeAccent,
    Colors.pinkAccent,
    Colors.cyan
  ];
  List<MLProfileCardData> mlProfileData = mlProfileDataList();

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
    final controller = Get.find<ProfileController>();
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: boxDecorationWithRoundedCorners(
          borderRadius: radiusOnly(topRight: 32)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Kunjungan Pasien', style: boldTextStyle(size: 18)),
              // Text('04', style: secondaryTextStyle(size: 18)),
            ],
          ),
          16.height,
          StaggeredGridView.countBuilder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            itemCount: mlProfileData.length,
            itemBuilder: (context, index) {
              return Obx(
                () => Container(
                  padding: EdgeInsets.all(16),
                  decoration: boxDecorationWithRoundedCorners(
                    backgroundColor: mlProfileData[index].color!,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(mlProfileData[index].img!,
                              height: 50, width: 50, fit: BoxFit.cover)
                          .cornerRadiusWithClipRRect(12.0),
                      16.height,
                      Row(
                        children: [
                          Text(mlProfileData[index].name.toString(),
                                  style: secondaryTextStyle(color: white),
                                  textAlign: TextAlign.start)
                              .expand(),
                          controller.statistikPasien.value.isNotEmpty
                              ? Text(
                                  mlProfileData[index].name.toString() ==
                                          'Kunjungan'
                                      ? controller
                                          .statistikPasien.value[0].kunjungan
                                          .toString()
                                      : mlProfileData[index].name.toString() ==
                                              'Rawat Jalan'
                                          ? controller
                                              .statistikPasien.value[0].rajal
                                              .toString()
                                          : mlProfileData[index]
                                                      .name
                                                      .toString() ==
                                                  'Rawat Inap'
                                              ? controller.statistikPasien
                                                  .value[0].ranap
                                                  .toString()
                                              : controller.statistikPasien
                                                  .value[0].bulan
                                                  .toString(),
                                  style: secondaryTextStyle(color: white),
                                )
                              : Text(
                                  '0',
                                  style: secondaryTextStyle(color: white),
                                ),
                        ],
                      )
                    ],
                  ),
                ).onTap(
                  () {
                    toasty(context, mlProfileData[index].name);
                  },
                ),
              );
            },
            staggeredTileBuilder: (index) => StaggeredTile.fit(1),
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
          ),
          16.height,
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 16.0),
                padding: EdgeInsets.all(12.0),
                decoration: boxDecorationRoundedWithShadow(8),
                child: Row(
                  children: [
                    Icon(Icons.card_membership, size: 24, color: Colors.blue),
                    8.width,
                    Text(controller.session.noPeserta.val,
                            style: secondaryTextStyle(color: black, size: 16))
                        .expand(),
                    Icon(Icons.arrow_forward_ios,
                        color: Colors.grey[300], size: 16),
                  ],
                ),
              ).onTap(() {
                toasty(context, controller.session.noPeserta.val);
              }),
              Container(
                margin: EdgeInsets.only(bottom: 16.0),
                padding: EdgeInsets.all(12.0),
                decoration: boxDecorationRoundedWithShadow(8),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, size: 24, color: Colors.blue),
                    8.width,
                    Text('${controller.session.tmpLahir.val}',
                            style: secondaryTextStyle(color: black, size: 16))
                        .expand(),
                    Icon(Icons.arrow_forward_ios,
                        color: Colors.grey[300], size: 16),
                  ],
                ),
              ).onTap(() {}),
              Container(
                margin: EdgeInsets.only(bottom: 16.0),
                padding: EdgeInsets.all(12.0),
                decoration: boxDecorationRoundedWithShadow(8),
                child: Row(
                  children: [
                    Icon(Icons.person, size: 24, color: Colors.blue),
                    8.width,
                    Text(
                            controller.session.jk.val == 'L'
                                ? 'Laki-Laki'
                                : controller.session.jk.val == 'L'
                                    ? 'Perempuan'
                                    : 'Lainnya',
                            style: secondaryTextStyle(color: black, size: 16))
                        .expand(),
                    Icon(Icons.arrow_forward_ios,
                        color: Colors.grey[300], size: 16),
                  ],
                ),
              ).onTap(() {
                toasty(
                  context,
                  controller.session.jk.val == 'L'
                      ? 'Laki-Laki'
                      : controller.session.jk.val == 'L'
                          ? 'Perempuan'
                          : 'Lainnya',
                );
              }),
              Container(
                margin: EdgeInsets.only(bottom: 16.0),
                padding: EdgeInsets.all(12.0),
                decoration: boxDecorationRoundedWithShadow(8),
                child: Row(
                  children: [
                    Icon(Icons.mail, size: 24, color: Colors.blue),
                    8.width,
                    Text(controller.session.email.val,
                            style: secondaryTextStyle(color: black, size: 16))
                        .expand(),
                    Icon(Icons.arrow_forward_ios,
                        color: Colors.grey[300], size: 16),
                  ],
                ),
              ).onTap(() {
                toasty(context, controller.session.email.val);
              }),
              Container(
                margin: EdgeInsets.only(bottom: 16.0),
                padding: EdgeInsets.all(12.0),
                decoration: boxDecorationRoundedWithShadow(8),
                child: Row(
                  children: [
                    Icon(Icons.phone, size: 24, color: Colors.blue),
                    8.width,
                    Text(controller.session.telp.val,
                            style: secondaryTextStyle(color: black, size: 16))
                        .expand(),
                    Icon(Icons.arrow_forward_ios,
                        color: Colors.grey[300], size: 16),
                  ],
                ),
              ).onTap(() {
                toasty(context, controller.session.telp.val);
              }),
            ],
          ),
        ],
      ),
    );
  }
}
