import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../app/services/service_handler/user.dart';
import '../../../data/repositories/firebase_repo/chat_repository.dart';
import '../../interface/msg_con_model.dart';
import '../../interface/user_model.dart';

class ChatrepositoryImpl implements ChatRepository {
  File? _photo;
  // ignore: prefer_typing_uninitialized_variables
  // var docId;
  set photo(File? value) => _photo = value;

  @override
  get db => FirebaseFirestore.instance;

  @override
  File? get photo => _photo;

  @override
  get storage => FirebaseStorage.instance;

  @override
  get userId => UserStore.to.token;

  @override
  Future<String> getImgUrl(String name) async {
    try {
      final spaceRef = storage.ref("chat").child(name);
      var str = await spaceRef.getDownloadURL();
      return str;
    } catch (e) {
      // ignore: avoid_print
      print('there is an error with getting image url: $e');
      rethrow;
    }
  }

  @override
  Stream<TaskSnapshot> uploadFile(String fileName) {
    try {
      final ref = storage.ref("chat").child(fileName);
      var eventSnapShot = ref.putFile(photo!).snapshotEvents;
      return eventSnapShot;
    } catch (e) {
      // ignore: avoid_print
      print('there is an error with file upload: $e');
      rethrow;
    }
  }

  @override
  Future<DocumentReference<MsgcontentModel>> addMessage(
      String sendContent, String type, var getDocID) async {
    try {
      final content = MsgcontentModel(
        uid: userId,
        content: sendContent,
        type: type,
        addtime: Timestamp.now(),
      );

      var addMsg = await db
          .collection("message")
          .doc(getDocID)
          .collection("msglist")
          .withConverter(
            fromFirestore: MsgcontentModel.fromFirestore,
            toFirestore: (MsgcontentModel msgcontent, options) {
              return msgcontent.toFirestore();
            },
          )
          .add(content);
      return addMsg;
    } catch (e) {
      // ignore: avoid_print
      print('error with addMessage() metthod in chat repo: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateMessage(String lastMsg, var getDocID) async {
    await db.collection("message").doc(getDocID).update(
      {
        "last_msg": lastMsg,
        "last_time": Timestamp.now(),
      },
    );
  }

  @override
  Future<void> getLocationFromDB(
    String id,
    String tolacation,
  ) async {
    try {
      var userLocation = await db
          .collection("users")
          .where("id", isEqualTo: id)
          .withConverter(
            fromFirestore: UserDataModel.fromFirestore,
            toFirestore: (UserDataModel userData, options) {
              return userData.toFirestore();
            },
          )
          .get();
      var location = userLocation.docs.first.data().location;
      if (location != '') {
        tolacation = location ?? "Unknown";
      }
    } catch (e) {
      // ignore: avoid_print
      print('error: $e');
    }
  }

  @override
  Query<MsgcontentModel> orderMsgByLastTime(var getDocID) {
    try {
      var mesaaseg = db
          .collection("message")
          .doc(getDocID)
          .collection("msglist")
          .withConverter(
            fromFirestore: MsgcontentModel.fromFirestore,
            toFirestore: (MsgcontentModel msgcontent, options) {
              return msgcontent.toFirestore();
            },
          )
          .orderBy("addtime", descending: false);
      return mesaaseg;
    } catch (e) {
      // ignore: avoid_print
      print('error with orderMsgByLastTime() method: $e');
      rethrow;
    }
  }
}
