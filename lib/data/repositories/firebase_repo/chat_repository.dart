import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../domain/interface/msg_con_model.dart';

abstract class ChatRepository {
//////////////////
  FirebaseFirestore get _db;
  File? get _photo;
  FirebaseStorage get _storage;
  String get _userId;
//////////////////////
  FirebaseFirestore get db => _db;
  File? get photo => _photo;
  FirebaseStorage get storage => _storage;
  String get userId => _userId;

  Future<String> getImgUrl(String name);
  Stream<TaskSnapshot> uploadFile(String fileName);
  Future<DocumentReference<MsgcontentModel>> addMessage(
      String sendContent, String type, var getDocID);
  Future<void> updateMessage(String lastMsg, var getDocID);
  Future<void> getLocationFromDB(String id, String tolacation);
  Query<MsgcontentModel> orderMsgByLastTime( var getDocID);
}
