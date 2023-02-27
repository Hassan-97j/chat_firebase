import '../../app/utils/components/bottom_nav_bar/nav_bar_widget.dart';
import 'controller.dart';

import '../contacts/view.dart';
import '../message/view.dart';
import '../profile/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplicationPage extends GetView<ApplicationController> {
  const ApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => MyBottomNavBar(
          items: controller.bottomTabs,
          currentIndex: controller.page.value,
          onTap: (index) {
            controller.onNavigationBarItemTap(index);
          },
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        onPageChanged: (index) {
          controller.onPageChage(index);
        },
        children: const [
          MessagePage(),
          ContactsPage(),
          ProfilePage(),
        ],
      ),
    );
  }
}
