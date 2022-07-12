import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import '../../../utils/MLColors.dart';
import '../../../utils/MLString.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smart_select/smart_select.dart';

import '../controllers/booking_pasien_baru_controller.dart';

class BookingPasienBaruView extends GetView<BookingPasienBaruController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.height,
                Text('Buat Janji/Booking', style: boldTextStyle(size: 25))
                    .center(),
                16.height,
                Text('Nama', style: primaryTextStyle()).paddingOnly(left: 16),
                AppTextField(
                  controller: TextEditingController(), // Optional
                  textFieldType: TextFieldType.NAME,
                  decoration: InputDecoration(
                      labelText: 'Nama Anda', border: OutlineInputBorder()),
                ).paddingAll(16),
                Text('Alamat', style: primaryTextStyle()).paddingOnly(left: 16),
                AppTextField(
                  controller: TextEditingController(), // Optional
                  textFieldType: TextFieldType.ADDRESS,
                  maxLines: 2,
                  decoration: InputDecoration(
                      labelText: 'Alamat Anda', border: OutlineInputBorder()),
                ).paddingAll(16),
                Text('Nomor HP', style: primaryTextStyle())
                    .paddingOnly(left: 16),
                AppTextField(
                  controller: TextEditingController(), // Optional
                  textFieldType: TextFieldType.PHONE,
                  maxLines: 2,
                  decoration: InputDecoration(
                      labelText: 'Nomor HP', border: OutlineInputBorder()),
                ).paddingAll(16),
                Text('Email', style: primaryTextStyle()).paddingOnly(left: 16),
                AppTextField(
                  controller: TextEditingController(), // Optional
                  textFieldType: TextFieldType.EMAIL,
                  decoration: InputDecoration(
                      labelText: 'Email Anda', border: OutlineInputBorder()),
                ).paddingAll(16),
                Text('Tanggal Booking', style: primaryTextStyle())
                    .paddingOnly(left: 16),
                DateTimeField(
                  format: DateFormat("dd/MM/yyyy"),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        context: context,
                        locale: Locale('id'),
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                  },
                ).paddingAll(16),
                Obx(
                  () => SmartSelect<String>.single(
                    title: 'Poliklinik',
                    modalType: S2ModalType.fullPage,
                    modalFilter: true,
                    modalFilterAuto: true,
                    value: controller.value.value,
                    choiceItems: controller.options,
                    onChange: (state) => controller.value.value = state.value,
                  ),
                ),
                Text('Tambahan Pesan', style: primaryTextStyle())
                    .paddingOnly(left: 16),
                AppTextField(
                  controller: TextEditingController(), // Optional
                  textFieldType: TextFieldType.EMAIL,
                  decoration: InputDecoration(
                      labelText: 'Tambahan Pesan',
                      border: OutlineInputBorder()),
                ).paddingAll(16),
                16.height,
                AppButton(
                  width: Get.width,
                  color: mlPrimaryColor,
                  textColor: white,
                  enableScaleAnimation: true,
                  onTap: () {},
                  child: Text(mlRegister!, style: boldTextStyle(color: white)),
                ).paddingOnly(left: 16, right: 16),
                25.height
              ],
            ),
          ),
        ),
      ),
    );
  }
}
