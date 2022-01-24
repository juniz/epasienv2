import 'package:ALPOKAT/app/modules/register/controllers/register_controller.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:ALPOKAT/app/utils/MLString.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class MLRgisterComponent extends StatefulWidget {
  MLRgisterComponent({Key? key}) : super(key: key);

  @override
  _MLRgisterComponentState createState() => _MLRgisterComponentState();
}

class _MLRgisterComponentState extends State<MLRgisterComponent> {
  final controller = Get.find<RegisterController>();
  String dropdownValue = 'Female';
  String bloodGroupValue = 'None';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nama Lengkap', style: boldTextStyle()),
        AppTextField(
          controller: controller.namaController,
          decoration: InputDecoration(
            hintText: 'Isikan nama lengkap',
            hintStyle: secondaryTextStyle(size: 16),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: mlColorLightGrey),
            ),
          ),
          textFieldType: TextFieldType.NAME,
        ),
        16.height,
        Text('Email', style: boldTextStyle()),
        AppTextField(
          controller: controller.emailController,
          textFieldType: TextFieldType.EMAIL,
          decoration: InputDecoration(
            hintText: 'Isikan Email',
            hintStyle: secondaryTextStyle(size: 16),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: mlColorLightGrey),
            ),
          ),
        ),
        16.height,
        Text('Tanggal Lahir', style: boldTextStyle()),
        AppTextField(
          controller: controller.tglLahirController,
          textFieldType: TextFieldType.OTHER,
          readOnly: true,
          decoration: InputDecoration(
            hintText: 'DD/MM/YYYY',
            hintStyle: secondaryTextStyle(size: 16),
            suffixIcon: Icon(Icons.calendar_today_outlined, color: mlColorBlue),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: mlColorLightGrey),
            ),
          ),
          onTap: () {
            DatePicker.showDatePicker(
              context,
              showTitleActions: true,
              minTime: DateTime(1910, 3, 5),
              maxTime: DateTime.now(),
              onConfirm: (date) => controller.setTglLahir(date),
              currentTime: controller.tglLahirSelected.value,
              locale: LocaleType.id,
            );
          },
        ),
        16.height,
        Text('No. HP', style: boldTextStyle()),
        AppTextField(
          controller: controller.hpController,
          textFieldType: TextFieldType.PHONE,
          decoration: InputDecoration(
            labelText: 'Isikan No. HP',
            labelStyle: secondaryTextStyle(size: 16),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: mlColorLightGrey),
            ),
          ),
        ),
        16.height,
        Text('Alamat', style: boldTextStyle()),
        AppTextField(
          controller: controller.alamatController,
          textFieldType: TextFieldType.NAME,
          maxLines: 2,
          decoration: InputDecoration(
            labelText: 'Isikan Alamat',
            labelStyle: secondaryTextStyle(size: 16),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: mlColorLightGrey),
            ),
          ),
        ),
        16.height,
      ],
    );
  }

  Widget genderDropDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Poliklinik', style: boldTextStyle()),
        DropdownButton<String>(
          value: dropdownValue,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: mlColorBlue,
          ).paddingOnly(left: 74.0),
          iconSize: 24,
          elevation: 16,
          style: secondaryTextStyle(size: 16),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: [
            'Female',
            'Male',
            'Other',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: secondaryTextStyle(size: 16)));
          }).toList(),
        ),
      ],
    );
  }

  Widget bloodGroupDropDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Blood Group', style: boldTextStyle()),
        Container(
          constraints: BoxConstraints(minWidth: Get.width / 2.5),
          child: DropdownButton<String>(
            value: bloodGroupValue,
            icon: Icon(Icons.keyboard_arrow_down, color: mlColorBlue)
                .paddingOnly(left: 74.0),
            iconSize: 24,
            elevation: 16,
            style: secondaryTextStyle(size: 16),
            onChanged: (String? newValue) {
              setState(() {
                bloodGroupValue = newValue!;
              });
            },
            items: <String>[
              'None',
              'A+',
              'A-',
              'B+',
              'B-',
              'O+',
              'O-',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: secondaryTextStyle(size: 16)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
