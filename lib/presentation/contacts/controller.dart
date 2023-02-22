import 'package:chat_firebase/domain/interface/user_model.dart';
import 'package:chat_firebase/domain/repositories/contacts_repo_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/repositories/contacts_repository.dart';
import 'package:get/get.dart';

class ContactsController extends GetxController {
  //ContactsController();
  final ContactsRepository contactRepo = ContactRepoImpl();
  final db = FirebaseFirestore.instance;
  //final token = UserStore.to.token;
  List<UserDataModel> contactList = [];

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
//////////////////////////////////////////
    var fromMessages = await contactRepo.getFromMessages(toUserData);
    // var fromMessages = await db
    //     .collection("message")
    //     .withConverter(
    //         fromFirestore: MsgModel.fromFirestore,
    //         toFirestore: (MsgModel msg, options) {
    //           return msg.toFirestore();
    //         })
    //     .where("from_uid", isEqualTo: token)
    //     .where("to_uid", isEqualTo: toUserData.id)
    //     .get();
//////////////////////////////////////////
    var toMessages = await contactRepo.getToMessages(toUserData);
    // var toMessages = await db
    //     .collection("message")
    //     .withConverter(
    //         fromFirestore: MsgModel.fromFirestore,
    //         toFirestore: (MsgModel msg, options) {
    //           return msg.toFirestore();
    //         })
    //     .where("from_uid", isEqualTo: toUserData.id)
    //     .where("to_uid", isEqualTo: token)
    //     .get();
//////////////////////////////////////////
    if (fromMessages.isEmpty && toMessages.isEmpty) {
      // String profile = await UserStore.to.getProfile();
      // UserLoginResponseEntityModel userData =
      //     UserLoginResponseEntityModel.fromJson(jsonDecode(profile));
      // var msgData = MsgModel(
      //   from_uid: userData.accessToken,
      //   to_uid: toUserData.id,
      //   from_name: userData.displayName,
      //   to_name: toUserData.name,
      //   from_avatar: userData.photoUrl,
      //   to_avatar: toUserData.photourl,
      //   last_msg: '',
      //   last_time: Timestamp.now(),
      //   msg_num: 0,
      // );
      // db
      //     .collection("message")
      //     .withConverter(
      //         fromFirestore: MsgModel.fromFirestore,
      //         toFirestore: (MsgModel msg, options) {
      //           return msg.toFirestore();
      //         })
      //     .add(msgData)
      contactRepo.saveMessage(toUserData).then((value) {
        Get.toNamed("/chat", arguments: {
          "doc_id": value.id,
          "to_uid": toUserData.id ?? "",
          "to_name": toUserData.name ?? "",
          "to_avatar": toUserData.photourl ?? "",
        });
      });
    } else {
      if (fromMessages.isNotEmpty) {
        Get.toNamed("/chat", arguments: {
          "doc_id": fromMessages.first.id,
          "to_uid": toUserData.id ?? "",
          "to_name": toUserData.name ?? "",
          "to_avatar": toUserData.photourl ?? "",
        });
      }
      if (toMessages.isNotEmpty) {
        Get.toNamed("/chat", arguments: {
          "doc_id": toMessages.first.id,
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
    contactList = await contactRepo.loadAllContacts();
    update();
  }
}
