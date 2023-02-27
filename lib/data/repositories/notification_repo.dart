import 'package:firebase_messaging/firebase_messaging.dart';

abstract class NotificationRepo {
  FirebaseMessaging? get _messaging;
  FirebaseMessaging? get messaging => _messaging;
  requestPemission();
}
