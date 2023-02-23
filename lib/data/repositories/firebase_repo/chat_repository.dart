import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../domain/interface/msg_con_model.dart';

abstract class ChatRepository {
//////////////////  
  FirebaseFirestore get _db; 
  get _docId;
  File? get _photo;
  FirebaseStorage get _storage; 
  String get _userId; 
//////////////////////  
  get docId => _docId;
  FirebaseFirestore get db => _db;
  File? get photo => _photo;
  FirebaseStorage get storage => _storage;
  String get userId => _userId;

  Future<String> getImgUrl(String name);
  Future uploadFile(String fileName);
  Future<DocumentReference<MsgcontentModel>> addMessage(
      String sendContent, String type);
  updateMessage(String lastMsg);
  getLocationFromDB(String id, String tolacation);
  Query<MsgcontentModel> orderMsgByLastTime();
}
