import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewController extends GetxController {
  //TODO: Implement WebviewController

  final count = 0.obs;
  @override
  void onInit() {
    print(Get.arguments);
    if (GetPlatform.isAndroid) WebView.platform = AndroidWebView();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
