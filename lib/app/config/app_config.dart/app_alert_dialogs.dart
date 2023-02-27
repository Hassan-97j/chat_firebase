import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dialogs {
  static void showSnackbar(String title, String msg) {
    Get.snackbar(
      title,
      msg,
      backgroundColor: Colors.blue.withOpacity(.8),
    );
  }

  static void showProgressBar() {
    Get.dialog(
      Center(
        child: CircularProgressIndicator(
          color: Get.theme.colorScheme.surface,
        ),
      ),
    );
  }

  static void hideProgressBar() {
    Get.back();
  }
}
