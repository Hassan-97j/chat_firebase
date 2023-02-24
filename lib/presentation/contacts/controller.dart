import 'package:chat_firebase/app/utils/dialogs.dart';
import 'package:chat_firebase/domain/interface/user_model.dart';
import 'package:chat_firebase/domain/repositories/firebase_repo/contacts_repo_impl.dart';
import 'package:get/get.dart';

import '../../data/repositories/firebase_repo/contacts_repository.dart';

class ContactsController extends GetxController {
  final ContactsRepository contactRepo = ContactRepoImpl();
  List contactList = <UserDataModel>[];
  bool isLoading = true;

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
    Dialogs.showProgressBar();
    var fromMessages = await contactRepo.getFromMessages(toUserData);
    var toMessages = await contactRepo.getToMessages(toUserData);
    update();
    if (fromMessages.docs.isEmpty && toMessages.docs.isEmpty) {
      await contactRepo.saveMessage(toUserData).then((value) {
        Dialogs.hideProgressBar();
        Get.toNamed('/chat', arguments: {
          "doc_id": value.id,
          "to_uid": toUserData.id ?? "",
          "to_name": toUserData.name ?? "",
          "to_avatar": toUserData.photourl ?? "",
        });
      });
    } else {
      if (fromMessages.docs.isNotEmpty) {
        Dialogs.hideProgressBar();
        Get.toNamed('/chat', arguments: {
          "doc_id": fromMessages.docs.first.id,
          "to_uid": toUserData.id ?? "",
          "to_name": toUserData.name ?? "",
          "to_avatar": toUserData.photourl ?? "",
        });
      }
      if (toMessages.docs.isNotEmpty) {
        Dialogs.hideProgressBar();
        Get.toNamed('/chat', arguments: {
          "doc_id": toMessages.docs.first.id,
          "to_uid": toUserData.id ?? "",
          "to_name": toUserData.name ?? "",
          "to_avatar": toUserData.photourl ?? "",
        });
      }
    }
    update();
//////////////////////////////////////////
  }

//load all data
  loadAllData() async {
    isLoading = true;
    var data = await contactRepo.loadAllContacts();
    for (var doc in data.docs) {
      contactList.assign(doc.data());
      update();
    }
    isLoading = false;
  }
}
