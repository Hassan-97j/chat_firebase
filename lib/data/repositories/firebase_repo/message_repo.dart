import 'package:chat_firebase/domain/interface/msg_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MessageRepo {
  FirebaseFirestore get _db;
  String get _token;
  FirebaseFirestore get db => _db;
  String get token => _token;

  Future<QuerySnapshot<MsgModel>> getFromMessages();
  Future<QuerySnapshot<MsgModel>> getToMessages();
  updateLocationToDB(String myAddress);
}
