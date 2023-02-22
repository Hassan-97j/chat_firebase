import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../routes/names.dart';
import '../services/service_handler/config.dart';
import '../services/service_handler/user.dart';

class RouteWelcomeMiddleware extends GetMiddleware {
  @override
  // ignore: overridden_fields
  int? priority = 0;

  RouteWelcomeMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    // ignore: avoid_print
    print(ConfigStore.to.isFirstOpen);
    if (ConfigStore.to.isFirstOpen == false) {
      return null;
    } else if (UserStore.to.isLogin == true) {
      return const RouteSettings(name: AppRoutes.application);
    } else {
      return const RouteSettings(name: AppRoutes.signin);
    }
  }
}
