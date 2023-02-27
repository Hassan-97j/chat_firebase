import 'package:chat_firebase/app/config/app_config.dart/ap_borders.dart';
import 'package:chat_firebase/color_schemes.g.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const horizontalMargin = 16.0;
  static const radius = 10.0;

  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightColorScheme.primary,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    colorScheme: lightColorScheme,
/////////////////////////////////////////////////////
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: lightColorScheme.primary,
      iconTheme: IconThemeData(
        color: lightColorScheme.onPrimary,
      ),
      titleTextStyle: TextStyle(
        color: lightColorScheme.onPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      toolbarTextStyle: TextStyle(
        color: lightColorScheme.onPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
/////////////////////////////////////////////////////
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      // selectedIconTheme: IconThemeData(
      //   color: lightColorScheme.surface,
      //   size: 24,
      // ),
      backgroundColor: lightColorScheme.primary,
      // unselectedLabelStyle: const  TextStyle(fontSize: 12),
      // selectedLabelStyle: const TextStyle(fontSize: 12),
      unselectedItemColor: lightColorScheme.secondary,
      selectedItemColor: lightColorScheme.surface,
    ),
/////////////////////////////////////////////////////
    // tabBarTheme: TabBarTheme(
    //   indicatorSize: TabBarIndicatorSize.label,
    //   labelColor: lightColorScheme.onPrimary,
    //   unselectedLabelColor: lightColorScheme.secondary,
    // ),
/////////////////////////////////////////////////////
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightColorScheme.onTertiary,
        textStyle: TextStyle(
          fontSize: 18,
          color: lightColorScheme.tertiary,
        ),
        elevation: 9,
      ),
    ),
/////////////////////////////////////////////////////
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: AppBorderRadius.circ20BRG,
      ),
    ),

/////////////////////////////////////////////////////
    snackBarTheme: SnackBarThemeData(
      actionTextColor: lightColorScheme.onTertiary,
      backgroundColor: lightColorScheme.tertiary,
      shape: RoundedRectangleBorder(
        borderRadius: AppBorderRadius.circ20BRG,
      ),
    ),
  );
}
