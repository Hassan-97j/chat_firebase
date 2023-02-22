
import 'package:chat_firebase/domain/interface/msg_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MessageState {
  var msgList = <QueryDocumentSnapshot<MsgModel>>[].obs;
}
