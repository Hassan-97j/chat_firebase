import 'dart:convert';

import 'package:chat_firebase/data/repositories/contacts_repository.dart';
import 'package:chat_firebase/domain/interface/msg_model.dart';
import 'package:chat_firebase/domain/interface/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../app/services/service_handler/user.dart';

class ContactRepoImpl implements ContactsRepository {
  final db = FirebaseFirestore.instance;
  final token = UserStore.to.token;

  @override
  Future<List<UserDataModel>> loadAllContacts() async {
    final userBase = await db
        .collection("users")
        .where("id", isNotEqualTo: token)
        .withConverter(
          fromFirestore: UserDataModel.fromFirestore,
          toFirestore: (userData, options) => userData.toFirestore(),
        )
        .get();

    return userBase.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future<List<MsgModel>> getFromMessages(UserDataModel toUserData) async {
    final fromMessages = await db
        .collection("message")
        .withConverter(
            fromFirestore: MsgModel.fromFirestore,
            toFirestore: (MsgModel msg, options) {
              return msg.toFirestore();
            })
        .where("from_uid", isEqualTo: token)
        .where("to_uid", isEqualTo: toUserData.id)
        .get();

    return fromMessages.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future<List<MsgModel>> getToMessages(UserDataModel toUserData) async {
    final toMessages = await db
        .collection("message")
        .withConverter(
            fromFirestore: MsgModel.fromFirestore,
            toFirestore: (MsgModel msg, options) {
              return msg.toFirestore();
            })
        .where("from_uid", isEqualTo: toUserData.id)
        .where("to_uid", isEqualTo: token)
        .get();
    return toMessages.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future<DocumentReference<MsgModel>> saveMessage(
      UserDataModel toUserData) async {
    String profile = await UserStore.to.getProfile();
    UserLoginResponseEntityModel userData =
        UserLoginResponseEntityModel.fromJson(jsonDecode(profile));
    var msgData = MsgModel(
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
    var messages = db
        .collection("message")
        .withConverter(
            fromFirestore: MsgModel.fromFirestore,
            toFirestore: (MsgModel msg, options) {
              return msg.toFirestore();
            })
        .add(msgData);
    return messages;
  }
}
