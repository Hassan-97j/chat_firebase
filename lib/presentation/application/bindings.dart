import 'package:chat_firebase/presentation/application/controller.dart';
import 'package:chat_firebase/presentation/message/controller.dart';

import '../contacts/controller.dart';
import '../profile/controller.dart';
import 'package:get/get.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(() => ApplicationController());
    Get.lazyPut<ContactsController>(() => ContactsController());
    Get.lazyPut<MessageController>(() => MessageController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
