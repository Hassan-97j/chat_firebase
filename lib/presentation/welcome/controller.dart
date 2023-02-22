import 'package:chat_firebase/routes/routes.dart';
import 'package:chat_firebase/app/services/service_handler/config.dart';

import 'package:get/get.dart';

class WelcomeController extends GetxController {
    var index = 0.obs;
  // final state = WelcomeState();
  // WelcomeController();

  //contoll page view 
  pageChange(int index) async {
    index = index;
  }

//navigate to sign_in screen
  handleSignIn() async {
    await ConfigStore.to.saveAlreadyOpen();
    Get.offAndToNamed(AppRoutes.signin);
  }
}
