import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData = MediaQueryData();
  static double screenWidth = 0.0;
  static double iconSizeSCP = 0.0;
  static double drawerItemTextSize = 0.0;
  static double screenHeight = 0.0;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    iconSizeSCP = screenWidth * 0.2;
    drawerItemTextSize = SizeConfig.screenWidth * 0.042;
  }
}


//Only login screen has been modified.
//HomePage cleared.
//Appointment Screen cleared.
//All screens cleared.
