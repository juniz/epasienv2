import 'package:ALPOKAT/app/modules/register/controllers/register_controller.dart';
import 'package:ALPOKAT/app/modules/register/models/ListPoliklinikModel.dart';
import 'package:ALPOKAT/app/utils/MLColors.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
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
          textCapitalization: TextCapitalization.sentences,
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
              onConfirm: (date) => controller.setTglLahir(date),
              currentTime: controller.tglLahirSelected.value,
              locale: LocaleType.id,
            );
          },
        ),
        16.height,
        Text('Tanggal Booking', style: boldTextStyle()),
        AppTextField(
          controller: controller.tglBookingController,
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
              minTime: DateTime.now().add(Duration(days: 1)),
              maxTime: DateTime.now().add(Duration(days: 15)),
              onConfirm: (date) => controller.setTglBooking(date),
              currentTime: controller.tglBookingSelected.value,
              locale: LocaleType.id,
            );
          },
        ),
        16.height,
        Text('Poliklinik', style: boldTextStyle()),
        genderDropDown().fit().withWidth(Get.width),
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
        Text('Pesan', style: boldTextStyle()),
        AppTextField(
          controller: controller.pesanController,
          textFieldType: TextFieldType.NAME,
          maxLines: 2,
          decoration: InputDecoration(
            labelText: 'Isikan Pesan Anda',
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
        Obx(
          () => DropdownButton<String>(
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: mlColorBlue,
            ).paddingOnly(left: 16.0),
            iconSize: 24,
            elevation: 16,
            style: secondaryTextStyle(size: 16),
            value: controller.kdPoli.value,
            onChanged: (newValue) {
              controller.kdPoli.value = newValue!;
              controller.getNamaPoli(newValue);
              //print(controller.kdPoli.value);
            },
            items: controller.listPoliklinik.value
                .map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                value: value.kdPoli,
                child: Text(
                  value.nmPoli!,
                  style: secondaryTextStyle(size: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
          ),
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
                .paddingOnly(left: 16.0),
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

class MealSelector extends StatelessWidget {
  final buttonPadding = const EdgeInsets.fromLTRB(0, 8, 0, 0);

  final List<ListPoliklinikModel> data;
  final String label;

  MealSelector({required this.data, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: AlignmentDirectional.centerStart,
            margin: EdgeInsets.only(left: 4),
            child: Text(label)),
        Padding(
          padding: buttonPadding,
          child: Container(
            decoration: _getShadowDecoration(),
            child: Card(
                child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                    child: DirectSelectList<ListPoliklinikModel>(
                      values: data,
                      defaultItemIndex: 0,
                      itemBuilder: (value) => getDropDownMenuItem(value),
                      focusedItemDecoration: _getDslDecoration(),
                    ),
                    padding: EdgeInsets.only(left: 12)),
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: _getDropdownIcon(),
                )
              ],
            )),
          ),
        ),
      ],
    );
  }

  DirectSelectItem<ListPoliklinikModel> getDropDownMenuItem(value) {
    return DirectSelectItem<ListPoliklinikModel>(
        itemHeight: 56,
        value: value,
        itemBuilder: (context, value) {
          return Text(value.nmPoli!);
        });
  }

  _getDslDecoration() {
    return BoxDecoration(
      border: BorderDirectional(
        bottom: BorderSide(width: 1, color: Colors.black12),
        top: BorderSide(width: 1, color: Colors.black12),
      ),
    );
  }

  BoxDecoration _getShadowDecoration() {
    return BoxDecoration(
      boxShadow: <BoxShadow>[
        new BoxShadow(
          color: Colors.black.withOpacity(0.06),
          spreadRadius: 4,
          offset: new Offset(0.0, 0.0),
          blurRadius: 15.0,
        ),
      ],
    );
  }

  Icon _getDropdownIcon() {
    return Icon(
      Icons.unfold_more,
      color: Colors.blueAccent,
    );
  }
}
