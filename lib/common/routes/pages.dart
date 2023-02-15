import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes.dart';
import '../../screens/application/index.dart';
import '../../screens/contacts/index.dart';
import '../../screens/imageview/index.dart';
import '../../screens/profile/index.dart';
import '../../screens/sign_in/index.dart';
import '../../screens/welcome/index.dart';
import '../middlewares/router_welcome.dart';
import '../../screens/chat/index.dart';

class AppPages {
  static const initial = AppRoutes.initial;
  static const application = AppRoutes.application;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.initial,
      page: () => const WelcomePage(),
      binding: WelcomeBinding(),
      middlewares: [
        RouteWelcomeMiddleware(priority: 1),
      ],
    ),
    GetPage(
      name: AppRoutes.signin,
      page: () => const SignInPage(),
      binding: SignInBindings(),
    ),

    // // check if needed to login or not
    GetPage(
      name: AppRoutes.application,
      page: () => const ApplicationPage(),
      binding: ApplicationBinding(),
      // middlewares: [
      //   RouteAuthMiddleware(priority: 1),
      // ],
    ),

    GetPage(
      name: AppRoutes.contact,
      page: () => const ContactsPage(),
      binding: ContactsBinding(),
    ),

    // GetPage(
    //     name: AppRoutes.Message,
    //     page: () => MessagePage(),
    //     binding: MessageBinding()),

    GetPage(
      name: AppRoutes.me,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),

    GetPage(
      name: AppRoutes.chat,
      page: () => const ChatPage(),
      binding: ChatBinding(),
    ),

    GetPage(
      name: AppRoutes.photoimgview,
      page: () => const ImageViewPage(),
      binding: ImageViewBinding(),
    ),
  ];
}
