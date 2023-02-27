import 'package:flutter/material.dart';

class AppBorderRadius {
//*****// circular //*****//
// circular 20 border radius geometry
  static BorderRadiusGeometry get circ20BRG =>
      const BorderRadius.all(Radius.circular(20));
   static BorderRadius get circ20BR =>
      const BorderRadius.all(Radius.circular(20));
  static BorderRadiusGeometry get circ35BRG =>
      const BorderRadius.all(Radius.circular(35));
  static BorderRadiusGeometry get circ54BRG =>
      const BorderRadius.all(Radius.circular(54));
//*****// bottom circular //*****//
//*****// top circular //*****//
}

class Borders {
  static BorderSide get primaryBorder => const BorderSide(
        color: Color.fromARGB(255, 230, 230, 231),
        width: 1,
        style: BorderStyle.solid,
      );
}
