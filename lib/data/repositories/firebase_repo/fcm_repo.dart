import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FCMRepo {
  ///
  String get _token;
  FirebaseFirestore get _db;

  ///
  String get token => _token;
  FirebaseFirestore get db => _db;
  Future<String?> getFCMToken();
}
