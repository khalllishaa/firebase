import 'package:flutter/material.dart';

class AppStyles {

  // color
  static const Color textColor = Color(0xFF000000);
  static const Color backGroundColor = Color(0xFFFFFFFF);
  static const Color higlightColor = Color(0xFFF44336);
  static const Color success = Color(0xFF5CB338);
  static const Color error = Color(0xFFFD1200);

  // padding & margin
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 12.0;
  static const double paddingL = 16.0;
  static const double paddingXL = 20.0;

  // Border Radius
  static const double radiusS = 10.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 20.0;
  static const double radiusXXL = 25.0;

  // text
  static TextStyle heading1 = TextStyle(fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.bold, color: AppStyles.textColor,);
  static TextStyle caption = TextStyle(fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.bold, color: AppStyles.textColor,);
  static TextStyle text = TextStyle(fontSize: 12, fontFamily: 'Poppins', color: AppStyles.textColor);
  static TextStyle button = TextStyle(fontSize: 16, fontFamily: 'Poppins', color: AppStyles.backGroundColor);
  static TextStyle inkwell = TextStyle(fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.bold, color: AppStyles.higlightColor,);

  // Spacing
  static const double spaceXXS = 2.0;
  static const double spaceXS = 5.0;
  static const double spaceS = 10.0;
  static const double spaceM = 16.0;
  static const double spaceL = 20.0;
  static const double spaceXL = 30.0;
  static const double spaceXXL = 50.0;

  // Icon Sizes
  static const double iconS = 12.0;
  static const double iconM = 20.0;
  static const double iconL = 24.0;
  static const double iconXL = 28.0;

}

