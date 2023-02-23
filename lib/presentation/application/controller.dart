import 'package:chat_firebase/app/utils/widgets/bottom_nav_bar/nav_bar_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplicationController extends GetxController {
  var page = 0.obs;

  late final List<String> tabTitles;
  late final PageController pageController;
  late final List<BottomNavigationBarItem> bottomTabs;

  //handle navigation controller
  onPageChage(int index) {
    page.value = index;
    update();
  }

  //on item tap navigate to page
  onNavigationBarItemTap(int index) {
    pageController.jumpToPage(index);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    tabTitles = NavBarData.tabTitles;
    bottomTabs = NavBarData.bottomTabs;
    pageController = PageController(
      initialPage: page.value,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
