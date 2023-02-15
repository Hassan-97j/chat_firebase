import 'package:chat_firebase/screens/contacts/index.dart';
import 'package:chat_firebase/screens/message/index.dart';

import '../profile/controller.dart';
import 'index.dart';
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
