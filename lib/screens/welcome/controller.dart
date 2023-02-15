import 'package:chat_firebase/common/routes/routes.dart';
import 'package:chat_firebase/common/store/config.dart';

import 'index.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  final state = WelcomeState();
  WelcomeController();

  //contoll page view 
  pageChange(int index) async {
    state.index.value = index;
  }

//navigate to sign_in screen
  handleSignIn() async {
    await ConfigStore.to.saveAlreadyOpen();
    Get.offAndToNamed(AppRoutes.signin);
  }
}
