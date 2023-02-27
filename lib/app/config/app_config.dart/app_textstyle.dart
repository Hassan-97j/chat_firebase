import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTextStyles {
//*****// Normal //*****//
//*****// Bold //*****//
//*****// W600 //*****//
  static TextStyle get surface16TextStyle => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Get.theme.colorScheme.onPrimary,
      );

  static TextStyle get onpPrimary26TextStyle => TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: Get.theme.colorScheme.onPrimary,
      );
  static TextStyle get onSecondary18TextStyle => TextStyle(
        color: Get.theme.colorScheme.onSecondary,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      );
  static TextStyle get onTertiary14TextStyle => TextStyle(
        color: Get.theme.colorScheme.onTertiary,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      );
}
