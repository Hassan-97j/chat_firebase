import 'package:chat_firebase/data/repositories/firebase_repo/message_repo.dart';
import 'package:chat_firebase/domain/interface/msg_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../app/services/service_handler/user.dart';

class MessageRepoImpl implements MessageRepo {
  final db = FirebaseFirestore.instance;
  final token = UserStore.to.token;

  @override
  Future<QuerySnapshot<MsgModel>> getFromMessages() async {
    try {
      var fromMessages = await db
          .collection('message')
          .withConverter(
              fromFirestore: MsgModel.fromFirestore,
              toFirestore: (MsgModel msg, options) {
                return msg.toFirestore();
              })
          .where("from_uid", isEqualTo: token)
          .get();

      return fromMessages;
    } catch (e) {
      // ignore: avoid_print
      print('getFromMessages() method in message repo: $e');
      rethrow;
    }
  }

  @override
  Future<QuerySnapshot<MsgModel>> getToMessages() async {
    try {
      var toMessages = await db
          .collection('message')
          .withConverter(
              fromFirestore: MsgModel.fromFirestore,
              toFirestore: (MsgModel msg, options) {
                return msg.toFirestore();
              })
          .where("to_uid", isEqualTo: token)
          .get();
      return toMessages;
    } catch (e) {
      // ignore: avoid_print
      print('getToMessages() method in message repo: $e');
      rethrow;
    }
  }

  @override
  updateLocationToDB(String myAddress) async {
    try {
      var userLocation =
          await db.collection("users").where("id", isEqualTo: token).get();
      if (userLocation.docs.isNotEmpty) {
        var docId = userLocation.docs.first.id;
        await db.collection("users").doc(docId).update(
          {"location": myAddress},
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print('updateLocationToDB() method in message repo: $e');
      rethrow;
    }
  }
}
