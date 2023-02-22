import 'package:get/get.dart';

class ImageViewController extends GetxController {
  var url = "".obs;
  // final state = ImageViewState();
  // ImageViewController();

  @override
  void onInit() {
    super.onInit();
    var data = Get.arguments;
    if (data["url"] != null) {
      url.value = data["url"]!;
    }
  }
}
