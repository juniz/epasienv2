import 'package:ALPOKAT/app/modules/home/models/WebModel.dart';
import 'package:get/get.dart';

class WebProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<List<WebModel>> fetchWeb() async {
    final response = await get(
        'https://rsbhayangkaranganjuk.com/wp-json/wp/v2/posts?per_page=5');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return webModelFromJson(response.bodyString!);
    }
  }
}
