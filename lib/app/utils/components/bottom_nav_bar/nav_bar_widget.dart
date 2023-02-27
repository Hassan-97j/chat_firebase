// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBottomNavBar extends StatelessWidget {
  MyBottomNavBar({
    required this.items,
    required this.currentIndex,
    this.onTap,
    super.key,
  });
  List<BottomNavigationBarItem> items;
  int currentIndex;
  Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: items,
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: onTap,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedItemColor: Get.theme.colorScheme.secondary,
      selectedItemColor: Get.theme.colorScheme.onPrimary,
    );
  }
}
