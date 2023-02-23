import 'package:get/get.dart';

class ImageViewController extends GetxController {
  var url = "";

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() {
    var data = Get.arguments;
    if (data["url"] != null) {
      url = data["url"]!;
    }
    update();
  }
}
