// ignore_for_file: avoid_print

import 'package:chat_firebase/data/repositories/notification_repo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationRepoImpl implements NotificationRepo {
  @override
  requestPemission() async {
    NotificationSettings settings = await messaging!.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('user granted provisional permission');
    } else {
      print('user declined or has not accepted permission');
    }
  }

  @override
  FirebaseMessaging? get messaging => FirebaseMessaging.instance;
}
