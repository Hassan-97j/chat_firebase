import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_config.dart/app_strings.dart';
import '../storage_service.dart';

class ConfigStore extends GetxController {
  static ConfigStore get to => Get.find();

  bool isFirstOpen = false;
  bool get isRelease => const bool.fromEnvironment("dart.vm.product");
  Locale locale = const Locale('en', 'US');
  List<Locale> languages = const [
    Locale('en', 'US'),
    Locale('zh', 'CN'),
  ];

  @override
  void onInit() {
    super.onInit();
    isFirstOpen =
        StorageService.to.getBool(StorageStrings.store_DeviceFirstOpenKey);
  }

  Future<bool> saveAlreadyOpen() {
    return StorageService.to
        .setBool(StorageStrings.store_DeviceFirstOpenKey, true);
  }

  void onInitLocale() {
    var langCode =
        StorageService.to.getString(StorageStrings.store_LanguageCode);
    if (langCode.isEmpty) return;
    var index = languages.indexWhere((element) {
      return element.languageCode == langCode;
    });
    if (index < 0) return;
    locale = languages[index];
  }

  void onLocaleUpdate(Locale value) {
    locale = value;
    Get.updateLocale(value);
    StorageService.to
        .setString(StorageStrings.store_LanguageCode, value.languageCode);
  }
}
