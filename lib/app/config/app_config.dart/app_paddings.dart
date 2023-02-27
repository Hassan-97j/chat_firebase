import 'package:flutter/material.dart';

class AppPAdding {
//*****// all //*****//
//*****// only top //*****//
  static EdgeInsets get top12 => const EdgeInsets.only(top: 12);
//*****// only bottom //*****//

  static EdgeInsets get bottom12 => const EdgeInsets.only(bottom: 12);
  static EdgeInsets get bottom30 => const EdgeInsets.only(bottom: 30);
  static EdgeInsets get bottom50 => const EdgeInsets.only(bottom: 50);
//*****// only left //*****//
  static EdgeInsets get left5 => const EdgeInsets.only(left: 5);
//*****// only right //*****//
  static EdgeInsets get right10 => const EdgeInsets.only(right: 10);
//*****// vertical //*****//
//*****// horizontal //*****//
  static EdgeInsets get horizontal24 =>
      const EdgeInsets.symmetric(horizontal: 24);
  static EdgeInsets get horizontal15 =>
      const EdgeInsets.symmetric(horizontal: 15);
//*****// vertical and horizontal //*****//
  static EdgeInsets get left10TB5 =>
      const EdgeInsets.only(left: 10, top: 5, bottom: 5);
  static EdgeInsets get top30LRB15 =>
      const EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 15);
  static EdgeInsets get left10bottom5 =>
      const EdgeInsets.only(left: 10, bottom: 5);

  static EdgeInsets get vert10hor15 =>
      const EdgeInsets.symmetric(vertical: 10, horizontal: 15);
}
