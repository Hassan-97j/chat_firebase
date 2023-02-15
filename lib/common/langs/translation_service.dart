import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'en_us.dart';
import 'zh_hans.dart';
import 'zh_hk.dart';

class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static const fallbackLocale = Locale('en', 'US');
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_us,
        'zh_Hans': zh_hans,
        'zh_HK': zh_hk,
      };
}
