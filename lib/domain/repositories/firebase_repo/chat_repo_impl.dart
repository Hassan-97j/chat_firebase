import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../app/services/service_handler/user.dart';
import '../../../data/repositories/firebase_repo/chat_repository.dart';
import '../../interface/msg_con_model.dart';
import '../../interface/user_model.dart';

class ChatrepositoryImpl implements ChatRepository {
  @override
  get db => FirebaseFirestore.instance;

  @override
  get userId => UserStore.to.token;

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
  Future<String?> getLocationFromDB(String id) async {
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
        return location;
      }
    } catch (e) {
      // ignore: avoid_print
      print('error: $e');
      rethrow;
    }
    return null;
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

  @override
  Future<String?> getFCMTokenFromDB(String id) async {
    try {
      var userFCMToken = await db
          .collection("users")
          .where("id", isEqualTo: id)
          .withConverter(
            fromFirestore: UserDataModel.fromFirestore,
            toFirestore: (UserDataModel userData, options) {
              return userData.toFirestore();
            },
          )
          .get();
      var token = userFCMToken.docs.first.data().fcmtoken;
      if (token != '') {
        return token;
      }
    } catch (e) {
      // ignore: avoid_print
      print('error: $e');
      rethrow;
    }
    return null;
  }
}
