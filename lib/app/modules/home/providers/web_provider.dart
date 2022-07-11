import 'package:ALPOKAT/app/api/url.dart';
import 'package:ALPOKAT/app/modules/home/models/WebModel.dart';
import 'package:get/get.dart';

class WebProvider extends GetConnect {
  @override
  void onInit() {}

  Future<List<WebModel>> fetchWeb() async {
    final response = await get(urlInformasi);
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return webModelFromJson(response.bodyString!);
    }
  }
}
