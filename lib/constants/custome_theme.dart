import 'package:flutter/material.dart';
import '../gen/colors.gen.dart';

final class CustomTheme {
  CustomTheme._();
  static const MaterialColor kToDark = MaterialColor(
    0xFF071112, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xFF071112),
      100: Color(0xFF071112),
      200: Color(0xFF071112),
      300: Color(0xFF071112),
      400: Color(0xFF071112),
      500: Color(0xFF071112),
      600: Color(0xFF071112),
      700: Color(0xFF071112),
      800: Color(0xFF071112),
      900: Color(0xFF071112),
    },
  );
  static ThemeData get mainTheme {
    return ThemeData(
      primaryColor: AppColors.allPrimaryColor,
      primarySwatch: CustomTheme.kToDark,
      scaffoldBackgroundColor: AppColors.c000000,
    );
  }
}
