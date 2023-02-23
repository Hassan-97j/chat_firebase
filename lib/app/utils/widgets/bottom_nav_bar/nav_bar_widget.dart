// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../config/values/colors.dart';

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
      items: items, //controller.bottomTabs,
      currentIndex: currentIndex, //controller.page.value,
      type: BottomNavigationBarType.fixed,
      onTap: onTap,
      // (index) {
      //   controller.onNavigationBarItemTap(index);
      // },
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedItemColor: AppColors.tabBarElement,
      selectedItemColor: AppColors.thirdElementText,
    );
  }
}
