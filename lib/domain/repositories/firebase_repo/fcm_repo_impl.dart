import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../app/services/service_handler/user.dart';
import '../../../data/repositories/firebase_repo/fcm_repo.dart';

class FCMRepoImpl implements FCMRepo {
  // final token = UserStore.to.token;
  // final db = FirebaseFirestore.instance;
  @override
  get db => FirebaseFirestore.instance;

  @override
  get token => UserStore.to.token;

  @override
  Future<String?> getFCMToken() async {
    try {
      final fcmToken = FirebaseMessaging.instance.getToken();
      // ignore: unnecessary_null_comparison
      return fcmToken;
    } catch (e) {
      // ignore: avoid_print
      print('getFCMToken() method failed: $e');
      rethrow;
    }
  }
}
