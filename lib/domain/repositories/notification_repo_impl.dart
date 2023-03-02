// ignore_for_file: avoid_print

import 'package:chat_firebase/data/providers/apis/fcm_api.dart';
import 'package:chat_firebase/data/repositories/notification_repo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationRepoImpl implements NotificationRepo {
  @override
  FirebaseMessaging? get messaging => FirebaseMessaging.instance;
  @override
  FlutterLocalNotificationsPlugin? get flutterLocalNotificationsPlugin =>
      FlutterLocalNotificationsPlugin();
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
  initInfo() {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializeSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin!.initialize(
      initializeSettings,
      onDidReceiveNotificationResponse: (details) {},
    );
    ////////////////////////////
    FirebaseMessaging.onMessage.listen((RemoteMessage myMessage) async {
      print('...........on Message.........');
      print(
          'on Message: ${myMessage.notification?.title}/${myMessage.notification?.body}}');
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        myMessage.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: myMessage.notification!.title.toString(),
        htmlFormatContentTitle: true,
      );
      AndroidNotificationDetails androidPlatformSpecificChannel =
          AndroidNotificationDetails(
        'xyz',
        'xyz',
        importance: Importance.high,
        styleInformation: bigTextStyleInformation,
        priority: Priority.high,
        playSound: true,
      );
      NotificationDetails platformSpecificChannel = NotificationDetails(
        android: androidPlatformSpecificChannel,
      );
      await flutterLocalNotificationsPlugin!.show(
        0,
        myMessage.notification?.title,
        myMessage.notification?.body,
        platformSpecificChannel,
        payload: myMessage.data['title'],
      );
    });
  }

  @override
  sendPushNotification(String fcmToken, String body, String title) async {
    FCMAPI.sendNotification(fcmToken, body, title);
  }
}
