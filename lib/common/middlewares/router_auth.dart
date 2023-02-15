import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/names.dart';
import '../store/user.dart';

class RouteAuthMiddleware extends GetMiddleware {
  @override
  // ignore: overridden_fields
  int? priority = 0;

  RouteAuthMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    if (UserStore.to.isLogin ||
        route == AppRoutes.signin ||
        route == AppRoutes.initial) {
      return null;
    } else {
      Future.delayed(const Duration(seconds: 1),
          () => Get.snackbar("login again", "session expired"));
      return const RouteSettings(name: AppRoutes.signin);
    }
  }
}
