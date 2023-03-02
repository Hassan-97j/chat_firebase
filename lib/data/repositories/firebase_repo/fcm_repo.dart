import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class FCMRepo {
  ///
  String get _token;
  FirebaseFirestore get _db;
  FirebaseMessaging? get _messaging;
  FirebaseMessaging? get messaging => _messaging;

  ///
  String get token => _token;
  FirebaseFirestore get db => _db;
  Future<String?> getFCMToken();
}
