import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../app/services/service_handler/user.dart';
import '../../../data/repositories/firebase_repo/fcm_repo.dart';

class FCMRepoImpl implements FCMRepo {
  final token = UserStore.to.token;
  final db = FirebaseFirestore.instance;
  @override
  Future<String?> getFCMToken() async {
    try {
      final fcmToken = FirebaseMessaging.instance.getToken();
      // ignore: unnecessary_null_comparison
      if (fcmToken != null) {
        var user =
            await db.collection("users").where("id", isEqualTo: token).get();
        if (user.docs.isNotEmpty) {
          var docId = user.docs.first.id;
          await db.collection("users").doc(docId).update(
            {
              "fcmtoken": fcmToken.toString(),
            },
          );
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print('getFCMToken() method failed: $e');
      rethrow;
    }
    return null;
  }
}
