import 'index.dart';
import 'package:get/get.dart';

class ImageViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImageViewController>(() => ImageViewController());
  }
}
