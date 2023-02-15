import 'package:chat_firebase/common/entities/entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MessageState {
  var msgList = <QueryDocumentSnapshot<Msg>>[].obs;
}
