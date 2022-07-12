import 'package:get/get.dart';

import '../../../../main.dart';
import '../models/WebModel.dart';

class WebProvider extends GetConnect {
  final informasi = Get.find<SettingsService>().read('informasi');
  @override
  void onInit() {}

  Future<List<WebModel>> fetchWeb() async {
    final response = await get(informasi);
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return webModelFromJson(response.bodyString!);
    }
  }
}
