import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/interface/msg_con_model.dart';

abstract class ChatRepository {
  Future getImgUrl(String name);
  uploadFile(String fileName);
  Future<DocumentReference<MsgcontentModel>>addMessage(String sendContent, String type);
  updateMessage(String lastMsg);
  getLocationFromDB(String id, String tolacation);
  Query<MsgcontentModel>orderMsgByLastTime();
  
}
