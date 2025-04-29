import 'package:advanced_app/core/color/colors.dart';
import 'package:flutter/material.dart';

// Define a class for light mode theme
class LightTheme {
  static ThemeData get theme {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: AppColors.white,
      ),
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.white,
      textTheme: const TextTheme(),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      // Add more customization for light mode here
    );
  }
}

// Define a class for dark mode theme
class DarkTheme {
  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.blueGrey,

      textTheme: const TextTheme(),
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.blueGrey,
        textTheme: ButtonTextTheme.primary,
      ),
      // Add more customization for dark mode here
    );
  }
}
