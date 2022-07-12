import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/api/rest_api.dart';
import 'app/api/url.dart';
import 'app/routes/app_pages.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ByteData data = await PlatformAssetBundle().load('ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());
  await initialConfig();

  runApp(
    GetMaterialApp(
      title: "ALPOKAT",
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [
        const Locale('en'),
        const Locale('id'),
      ],
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

Future<void> initialConfig() async {
  await Get.putAsync(() => SettingsService().init());
}

class SettingsService extends GetxService {
  final _restApi = Get.put(RestApi());

  Future<SettingsService> init() async {
    await GetStorage.init();
    final response = await _restApi.getService(urlSettingEpasien);
    if (response.statusCode == 200) {
      var data = response.body['data'];
      write('pasienBaru', data['pasien_baru']);
      write('homeVisite', data['homevisite']);
      write('photoDokter', data['photo_dokter']);
      write('telephone', data['telephone']);
      write('maintance', data['maintance']);
      write('informasi', data['url_informasi']);
      write('appVer', data['app_ver']);
      write('buildVer', data['build_ver']);
      return this;
    }
    return this;
  }

  void write(String key, dynamic value) {
    GetStorage().write(key, value);
  }

  dynamic read(String key) {
    return GetStorage().read(key);
  }
}
