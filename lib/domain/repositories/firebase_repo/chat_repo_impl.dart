import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../app/services/service_handler/user.dart';
import '../../../data/repositories/firebase_repo/chat_repository.dart';
import '../../interface/msg_con_model.dart';
import '../../interface/user_model.dart';

class ChatrepositoryImpl implements ChatRepository {
  final db = FirebaseFirestore.instance;
  // ignore: prefer_typing_uninitialized_variables
  var docId;
  File? photo;
  var storage = FirebaseStorage.instance;
  final userId = UserStore.to.token;

  @override
  Future getImgUrl(String name) async {
    final spaceRef = storage.ref("Chat").child(name);
    var str = await spaceRef.getDownloadURL();
    return str;
  }

  @override
  uploadFile(String fileName) async {
    // if (photo == null) return;
    // final fileName = getRandomString(15) + photo!.path;
    // try {
    final ref = FirebaseStorage.instance.ref("chat").child(fileName);
    ref.putFile(photo!).snapshotEvents;
    // .listen((event) async {
    //   switch (event.state) {
    //     case TaskState.running:
    //       break;
    //     case TaskState.paused:
    //       break;
    //     case TaskState.success:
    //       String imgUrl = await getImgUrl(fileName);
    //       await sendMessage(imgUrl);
    //       break;
    //     case TaskState.canceled:
    //       break;
    //     case TaskState.error:
    //       break;
    //   }
    // });
    // } catch (e) {
    //   // ignore: avoid_print
    //   print('there is an error $e');
    // }
  }

  @override
  Future<DocumentReference<MsgcontentModel>> addMessage(
      String sendContent, String type) async {
    try {
      final content = MsgcontentModel(
        uid: userId,
        content: sendContent,
        type: type, //"text",
        addtime: Timestamp.now(),
      );
      var addMsg = await db
          .collection("message")
          .doc(docId)
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
  updateMessage(String lastMsg) async {
    await db.collection("message").doc(docId).update(
      {
        "last_msg": lastMsg, // sendContent,
        "last_time": Timestamp.now(),
      },
    );
  }

  @override
  getLocationFromDB(String id, String tolacation) async {
    try {
      var userLocation = await db
          .collection("users")
          .where("id", isEqualTo: id) //state.toId.value)
          .withConverter(
            fromFirestore: UserDataModel.fromFirestore,
            toFirestore: (UserDataModel userData, options) {
              return userData.toFirestore();
            },
          )
          .get();
      var location = userLocation.docs.first.data().location;
      if (location != '') {
        // state.toLocation.value
        tolacation = location ?? "Unknown";
      }
    } catch (e) {
      // ignore: avoid_print
      print('error: $e');
    }
  }

  @override
  Query<MsgcontentModel> orderMsgByLastTime() {
    try {
      var mesaaseg = db
          .collection("message")
          .doc(docId)
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
      print('erroe with orderMsgByLastTime() method: $e');
      rethrow;
    }
  }
}
