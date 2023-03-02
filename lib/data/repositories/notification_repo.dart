import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class NotificationRepo {
  FirebaseMessaging? get _messaging;
  FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;
  FirebaseMessaging? get messaging => _messaging;
  FlutterLocalNotificationsPlugin? get flutterLocalNotificationsPlugin =>
      _flutterLocalNotificationsPlugin;

  requestPemission();
  initInfo();
  sendPushNotification(String fcmToken, String body, String title);
}
