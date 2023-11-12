import 'package:flutter/material.dart';
import 'package:futrah/controller/resources/theme/text_manager.dart';

import 'colors_manager.dart';

class ThemeManager {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      primaryColorLight: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Ubuntu',
      brightness: Brightness.light,
      platform: TargetPlatform.iOS,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.bgColor,
        elevation: 0.0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontStyle: FontStyle.normal,
          fontFamily: 'Ubuntu',
          fontWeight: FontWeight.w700,
        ),
        iconTheme: IconThemeData(size: 30, color: AppColors.primaryColor),
      ),
      iconTheme: const IconThemeData(size: 30, color: AppColors.primaryColor),
      textTheme: TextManager.textStyle,
      colorScheme: const ColorScheme(
        background: AppColors.bgColor,
        brightness: Brightness.light,
        primary: AppColors.primaryColor,
        onPrimary: AppColors.primaryColor,
        secondary: AppColors.blue,
        onSecondary: AppColors.blue,
        error: AppColors.red,
        onError: AppColors.red,
        onBackground: AppColors.bgColor,
        surface: AppColors.bgColor,
        onSurface: AppColors.bgColor,
      ),
    );
  }
}
