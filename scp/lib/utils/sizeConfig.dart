import 'package:flutter/material.dart';

class SizeConfig{
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double iconSizeSCP;
  static double drawerItemTextSize;
  static double screenHeight;

  void init(BuildContext context){
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