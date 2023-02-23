import 'dart:convert';
import 'package:chat_firebase/domain/interface/msg_model.dart';
import 'package:chat_firebase/domain/interface/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../app/services/service_handler/user.dart';
import '../../../data/repositories/firebase_repo/contacts_repository.dart';

class ContactRepoImpl implements ContactsRepository {
  @override
  get db => FirebaseFirestore.instance;

  @override
  get token => UserStore.to.token;

  @override
  Future<QuerySnapshot<UserDataModel>> loadAllContacts() async {
    try {
      final userBase = await db
          .collection("users")
          .where("id", isNotEqualTo: token)
          .withConverter(
            fromFirestore: UserDataModel.fromFirestore,
            toFirestore: (userData, options) => userData.toFirestore(),
          )
          .get();
     // var list = userBase.docs.map((doc) => doc.data()).toList();
      //  return list;
      return userBase;
    } catch (e) {
      // ignore: avoid_print
      print("loadAllContact() metthod failed: $e");
      rethrow;
    }
  }

  @override
  Future<QuerySnapshot<MsgModel>> getFromMessages(
      UserDataModel toUserData) async {
    try {
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

      return fromMessages;
    } catch (e) {
      // ignore: avoid_print
      print("getFromMessages() metthod failed: $e");
      rethrow;
    }
  }

  @override
  Future<QuerySnapshot<MsgModel>> getToMessages(
      UserDataModel toUserData) async {
    try {
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

      return toMessages;
    } catch (e) {
      // ignore: avoid_print
      print("getToMessages() metthod failed: $e");
      rethrow;
    }
  }

  @override
  Future<DocumentReference<MsgModel>> saveMessage(
      UserDataModel toUserData) async {
    try {
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
      var messages = await db
          .collection("message")
          .withConverter(
              fromFirestore: MsgModel.fromFirestore,
              toFirestore: (MsgModel msg, options) {
                return msg.toFirestore();
              })
          .add(msgData);
      return messages;
    } catch (e) {
      // ignore: avoid_print
      print("saveMessage() metthod failed: $e");
      rethrow;
    }
  }
}
