import 'package:chat_firebase/app/services/storage_service.dart';
import 'package:chat_firebase/routes/routes.dart';

import 'package:chat_firebase/app/services/service_handler/config.dart';
import 'package:chat_firebase/app/services/service_handler/user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'app/themes/app_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync<StorageService>(() => StorageService().init());
  Get.put<ConfigStore>(ConfigStore());
  Get.put<UserStore>(UserStore());
  await Firebase.initializeApp(
    name: "firebase-chat",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(fireBaseMessagingBackGroundHAandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatBox',
      theme: AppTheme.light,
      initialRoute: AppRoutes.initial,
      getPages: AppPages.routes,
    );
  }
}

Future<void> fireBaseMessagingBackGroundHAandler(
    RemoteMessage myMessage) async {
  // ignore: avoid_print
  print('handle the back ground message ${myMessage.messageId}');
}
