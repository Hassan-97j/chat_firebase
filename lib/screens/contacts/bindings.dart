import 'index.dart';
import 'package:get/get.dart';

class ContactsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactsController>(() => ContactsController());
  }
}
