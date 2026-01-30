import 'package:flutter/material.dart';

class AppColors extends MaterialColor {
  const AppColors(super.primary, super.swatch);

  // Text & Background Colors
  static const appThemes = Color(0xFF00123C);
  static const email = Color(0xFF747476);
  static const hintColour = Color(0xFF6E6D86);
  static const create = Color(0xFF0B6990);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF); // --White
  static const Color grey = Color(0xFF9E9E9E);  // Grey added

  static Color selectedBgColor = const Color(0xFFE7DCF7);
  static Color selectedIconColor = Colors.black;
  static Color unselectedIconColor = AppColors.black;

  static const Color selectedPillColor = Color(0xFFE8E0F5); // Light lavender pill
  static const Color textColor = Color(0xFF4A4A4A);


}
