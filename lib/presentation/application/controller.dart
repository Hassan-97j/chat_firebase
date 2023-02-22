import 'package:chat_firebase/app/config/values/values.dart';
import 'package:flutter/material.dart';

import 'index.dart';
import 'package:get/get.dart';

class ApplicationController extends GetxController {
  ApplicationController();
  final state = ApplicationState();

  late final List<String> tabTitles;
  late final PageController pageController;
  late final List<BottomNavigationBarItem> bottomTabs;

  //handle navigation controller
  onPageChage(int index) {
    state.page.value = index;
  }

  //on item tap navigate to page
  onNavigationBarItemTap(int index) {
    pageController.jumpToPage(index);
  }

  @override
  void onInit() {
    super.onInit();
    tabTitles = [
      'Chat',
      'Contact',
      'Profile',
    ];
    bottomTabs = [
      //1
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.message,
          color: AppColors.thirdElementText,
        ),
        activeIcon: Icon(
          Icons.message,
          color: AppColors.secondaryElementText,
        ),
        label: 'Chat',
        backgroundColor: AppColors.primaryBackground,
      ),
      //2
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.contact_page,
          color: AppColors.thirdElementText,
        ),
        activeIcon: Icon(
          Icons.contact_page,
          color: AppColors.secondaryElementText,
        ),
        label: 'Contact',
        backgroundColor: AppColors.primaryBackground,
      ),
      //3
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          color: AppColors.thirdElementText,
        ),
        activeIcon: Icon(
          Icons.person,
          color: AppColors.secondaryElementText,
        ),
        label: 'Profile',
        backgroundColor: AppColors.primaryBackground,
      ),
    ];
    pageController = PageController(
      initialPage: state.page.value,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
