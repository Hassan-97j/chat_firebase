import 'controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../app/config/app_config.dart/ap_borders.dart';
import '../../app/config/app_config.dart/app_assets.dart';
import '../../app/config/app_config.dart/app_paddings.dart';
import '../../app/config/app_config.dart/app_strings.dart';
import '../../app/config/app_config.dart/app_textstyle.dart';
import '../../app/config/app_config.dart/app_shadows.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(
      init: SignInController(),
      builder: (_) => Scaffold(
        body: Center(
          child: Padding(
            padding: AppPAdding.horizontal24,
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(height: Get.height * 0.1),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: AppBorderRadius.circ35BRG,
                        boxShadow: [Shadows.primaryShadow],
                      ),
                      width: Get.width * 0.30,
                      height: Get.height * 0.15,
                      child: Image.asset(
                        AppAssets.launchIcon,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: AppPAdding.top12,
                      child: Text(
                        AppStrings.letsChat,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.onSecondary18TextStyle,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        await controller.handleSignIn();
                      },
                      icon: const Icon(FontAwesomeIcons.google),
                      label: const Text('Google Login'),
                    ),
                    SizedBox(height: Get.height * 0.12),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
