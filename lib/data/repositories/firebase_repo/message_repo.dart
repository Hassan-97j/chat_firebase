import 'package:chat_firebase/domain/interface/msg_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MessageRepo {
  Future<QuerySnapshot<MsgModel>> getFromMessages();
  Future<QuerySnapshot<MsgModel>> getToMessages();
  updateLocationToDB(String myAddress);
}
