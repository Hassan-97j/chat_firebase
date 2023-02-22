import 'package:chat_firebase/presentation/sign_in/controller.dart';

import 'package:get/get.dart';

class SignInBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
  }
}
