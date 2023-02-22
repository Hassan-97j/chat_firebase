import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../presentation/application/bindings.dart';
import '../presentation/application/view.dart';
import '../presentation/chat/bindings.dart';
import '../presentation/chat/view.dart';
import '../presentation/contacts/bindings.dart';
import '../presentation/contacts/view.dart';
import '../presentation/imageview/bindings.dart';
import '../presentation/imageview/view.dart';
import '../presentation/profile/bindings.dart';
import '../presentation/profile/view.dart';
import '../presentation/sign_in/bindings.dart';
import '../presentation/sign_in/view.dart';
import '../presentation/welcome/bindings.dart';
import '../presentation/welcome/view.dart';
import 'routes.dart';
import '../app/middlewares/router_welcome.dart';

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
