import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';
import '../../app/config/app_config.dart/app_assets.dart';
import '../../app/config/app_config.dart/app_paddings.dart';
import '../../app/config/app_config.dart/app_strings.dart';
import '../../app/config/app_config.dart/app_textstyle.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WelcomeController>(
      init: WelcomeController(),
      builder: (_) => Scaffold(
        body: Center(
          child: Padding(
            padding: AppPAdding.horizontal24,
            child: AnimatedOpacity(
              opacity: controller.animation.value,
              duration: const Duration(milliseconds: 1000),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: Get.height * 0.25),
                  Container(
                    height: Get.height * 0.18,
                    width: Get.width * 0.40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppAssets.launchIcon),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.25),
                  Text(
                    AppStrings.app_Name,
                    style: AppTextStyles.onpPrimary26TextStyle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
