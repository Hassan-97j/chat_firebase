import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Shadows {
  static BoxShadow get primaryShadow => BoxShadow(
        color: Get.theme.colorScheme.shadow,
        offset: const Offset(0, 5),
        blurRadius: 10,
      );
}
