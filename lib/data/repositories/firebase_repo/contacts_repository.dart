import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/interface/msg_model.dart';
import '../../../domain/interface/user_model.dart';

abstract class ContactsRepository {
////  
  FirebaseFirestore get _db;
  String get _token;
////
  FirebaseFirestore get db => _db;
  String get token => _token;
  Future<List<UserDataModel>> loadAllContacts();
  Future<QuerySnapshot<MsgModel>> getFromMessages(UserDataModel toUserData);
  Future<QuerySnapshot<MsgModel>> getToMessages(UserDataModel toUserData);
  Future<DocumentReference<MsgModel>> saveMessage(UserDataModel toUserData);
}
