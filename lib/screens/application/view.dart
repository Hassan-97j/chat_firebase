import 'package:chat_firebase/common/values/values.dart';
import 'package:chat_firebase/screens/contacts/view.dart';
import 'package:chat_firebase/screens/message/view.dart';
import 'package:chat_firebase/screens/profile/view.dart';

import 'index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplicationPage extends GetView<ApplicationController> {
  const ApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: controller.bottomTabs,
          currentIndex: controller.state.page.value,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            controller.onNavigationBarItemTap(index);
          },
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: AppColors.tabBarElement,
          selectedItemColor: AppColors.thirdElementText,
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
