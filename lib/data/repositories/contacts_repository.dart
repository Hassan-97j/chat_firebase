import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/interface/msg_model.dart';
import '../../domain/interface/user_model.dart';

abstract class ContactsRepository {
  Future<List<UserDataModel>> loadAllContacts();
  Future<List<MsgModel>> getFromMessages(UserDataModel toUserData);
  Future<List<MsgModel>> getToMessages(UserDataModel toUserData);
  Future<DocumentReference<MsgModel>> saveMessage(UserDataModel toUserData);
}
