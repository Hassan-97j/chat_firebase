import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/interface/msg_con_model.dart';

abstract class ChatRepository {
//////////////////
  FirebaseFirestore get _db;

  String get _userId;
//////////////////////
  FirebaseFirestore get db => _db;

  String get userId => _userId;

  Future<DocumentReference<MsgcontentModel>> addMessage(
      String sendContent, String type, var getDocID);
  Future<void> updateMessage(String lastMsg, var getDocID);
  Future<void> getLocationFromDB(String id, String tolacation);
  Query<MsgcontentModel> orderMsgByLastTime(var getDocID);
}
