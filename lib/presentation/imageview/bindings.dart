import 'package:chat_firebase/presentation/imageview/controller.dart';
import 'package:get/get.dart';

class ImageViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImageViewController>(() => ImageViewController());
  }
}
