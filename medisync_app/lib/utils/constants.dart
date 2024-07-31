import 'package:flutter/material.dart';

class AppColors {
  static const primary = Colors.blue;
  static const secondary = Colors.indigo;
  static const background = Colors.white;
  static const text = Colors.black87;
}

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        color: AppColors.primary,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        headline6: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold),
        bodyText2: TextStyle(color: AppColors.text),
      ),
    );
  }
}