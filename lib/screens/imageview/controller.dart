import 'index.dart';
import 'package:get/get.dart';

class ImageViewController extends GetxController {
  final state = ImageViewState();
  ImageViewController();

  @override
  void onInit() {
    super.onInit();
    var data = Get.arguments;
    if (data["url"] != null) {
      state.url.value = data["url"]!;
    }
  }
}
