import 'package:flutter/material.dart';


class NavBarData {
  static List<String> get tabTitles => [
        'Messages',
        'Contact',
        'Profile',
      ];

  static List<BottomNavigationBarItem> bottomTabs = [
    //1
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.message,
        //  color: AppColors.thirdElementText,
      ),
      activeIcon: Icon(
        Icons.message,
        // color: AppColors.secondaryElementText,
      ),
      label: 'Messages',
      //backgroundColor: AppColors.primaryBackground,
    ),
    //2
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.contact_page,
        //color: AppColors.thirdElementText,
      ),
      activeIcon: Icon(
        Icons.contact_page,
        // color: AppColors.secondaryElementText,
      ),
      label: 'Contact',
      
      // backgroundColor: AppColors.primaryBackground,
    ),
    //3
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.person,
        // color: AppColors.thirdElementText,
      ),
      activeIcon: Icon(
        Icons.person,
        //color: AppColors.secondaryElementText,
      ),
      label: 'Profile',
      //backgroundColor: AppColors.primaryBackground,
    ),
  ];
}
