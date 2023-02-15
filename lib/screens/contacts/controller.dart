import 'dart:convert';

import 'package:chat_firebase/common/entities/entities.dart';
import 'package:chat_firebase/common/store/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'index.dart';
import 'package:get/get.dart';

class ContactsController extends GetxController {
  final state = ContactsState();
  ContactsController();

  final db = FirebaseFirestore.instance;
  final token = UserStore.to.token;

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
  goChat(UserData toUserData) async {
//////////////////////////////////////////
    var fromMessages = await db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) {
              return msg.toFirestore();
            })
        .where("from_uid", isEqualTo: token)
        .where("to_uid", isEqualTo: toUserData.id)
        .get();
//////////////////////////////////////////
    var toMessages = await db
        .collection("message")
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) {
              return msg.toFirestore();
            })
        .where("from_uid", isEqualTo: toUserData.id)
        .where("to_uid", isEqualTo: token)
        .get();
//////////////////////////////////////////
    if (fromMessages.docs.isEmpty && toMessages.docs.isEmpty) {
      String profile = await UserStore.to.getProfile();
      UserLoginResponseEntity userData =
          UserLoginResponseEntity.fromJson(jsonDecode(profile));
      var msgData = Msg(
        from_uid: userData.accessToken,
        to_uid: toUserData.id,
        from_name: userData.displayName,
        to_name: toUserData.name,
        from_avatar: userData.photoUrl,
        to_avatar: toUserData.photourl,
        last_msg: '',
        last_time: Timestamp.now(),
        msg_num: 0,
      );
      db
          .collection("message")
          .withConverter(
              fromFirestore: Msg.fromFirestore,
              toFirestore: (Msg msg, options) {
                return msg.toFirestore();
              })
          .add(msgData)
          .then((value) {
        Get.toNamed("/chat", arguments: {
          "doc_id": value.id,
          "to_uid": toUserData.id ?? "",
          "to_name": toUserData.name ?? "",
          "to_avatar": toUserData.photourl ?? "",
        });
      });
    } else {
      if (fromMessages.docs.isNotEmpty) {
        Get.toNamed("/chat", arguments: {
          "doc_id": fromMessages.docs.first.id,
          "to_uid": toUserData.id ?? "",
          "to_name": toUserData.name ?? "",
          "to_avatar": toUserData.photourl ?? "",
        });
      }
      if (toMessages.docs.isNotEmpty) {
        Get.toNamed("/chat", arguments: {
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
    var userBase = await db
        .collection("users")
        .where("id", isNotEqualTo: token)
        .withConverter(
          fromFirestore: UserData.fromFirestore,
          toFirestore: (UserData userData, options) {
            return userData.toFirestore();
          },
        )
        .get();
    for (var doc in userBase.docs) {
      state.contactsList.add(doc.data());
    }
  }
}
