import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/routes.dart';
import '../../app/services/service_handler/user.dart';

class WelcomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void onInit() {
    animationInitilizeAndRun();
    waitAndNavigate();
    super.onInit();
  }

////////////////////////////////////
//dispose state
  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  animationInitilizeAndRun() {
//initialize
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
//run
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInSine,
    ).obs.value;
    animation.addListener(
      () => update(),
    );
    animationController.forward();
    update();
  }

  waitAndNavigate() {
    Timer.run(() {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          if (UserStore.to.isLogin == true) {
            Get.offAndToNamed(AppRoutes.application);
          } else {
            Get.offAndToNamed(AppRoutes.signin);
          }
        },
      );
    });
    update();
  }
}
