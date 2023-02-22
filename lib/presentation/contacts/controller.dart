import 'package:chat_firebase/domain/interface/user_model.dart';
import 'package:chat_firebase/domain/repositories/firebase_repo/contacts_repo_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../data/repositories/firebase_repo/contacts_repository.dart';

class ContactsController extends GetxController {
  //ContactsController();
  final ContactsRepository contactRepo = ContactRepoImpl();
  final db = FirebaseFirestore.instance;
  //final token = UserStore.to.token;
  RxList contactList = <UserDataModel>[].obs;

  @override
  void onInit() {
    loadAllData();
    super.onInit();
  }

  @override
  void onReady() {
    loadAllData();
    super.onReady();
  }

// take all arguments and navigate to chat screen
  goChat(UserDataModel toUserData) async {
    var fromMessages = await contactRepo.getFromMessages(toUserData);
    var toMessages = await contactRepo.getToMessages(toUserData);

    if (fromMessages.docs.isEmpty && toMessages.docs.isEmpty) {
      await contactRepo.saveMessage(toUserData).then((value) {
        Get.toNamed('/chat', arguments: {
          "doc_id": value.id,
          "to_uid": toUserData.id ?? "",
          "to_name": toUserData.name ?? "",
          "to_avatar": toUserData.photourl ?? "",
        });
      });
    } else {
      if (fromMessages.docs.isNotEmpty) {
        Get.toNamed('/chat', arguments: {
          "doc_id": fromMessages.docs.first.id,
          "to_uid": toUserData.id ?? "",
          "to_name": toUserData.name ?? "",
          "to_avatar": toUserData.photourl ?? "",
        });
      }
      if (toMessages.docs.isNotEmpty) {
        Get.toNamed('/chat', arguments: {
          "doc_id": toMessages.docs.first.id,
          "to_uid": toUserData.id ?? "",
          "to_name": toUserData.name ?? "",
          "to_avatar": toUserData.photourl ?? "",
        });
      }
    }
//////////////////////////////////////////
  }

//load all data
  loadAllData() async {
    contactList.value = await contactRepo.loadAllContacts();
    // contactList.assignAll(await contactRepo.loadAllContacts());
    update();
  }
}
