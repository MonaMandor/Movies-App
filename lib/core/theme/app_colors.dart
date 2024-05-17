// core/theme/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  static  Color primaryColor = Color(0xFF2F3142);
  static  Color secondaryColor = Color(0xFF7F00FF);
  static  Color scaffoldBackground = Color(0xFF2F3142);
  static  Color primaryTextColor =   HexColor("#FFFFFF");
 static  Color fourthTextColor =  HexColor("#FFB319");

  

  
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
