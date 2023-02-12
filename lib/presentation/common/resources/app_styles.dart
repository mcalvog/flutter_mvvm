import 'package:flutter/material.dart';
import 'package:flutter_mvvm/presentation/common/resources/app_colors.dart';

class AppStyles {
  // App Theme
  static ThemeData appTheme = ThemeData(
    brightness: Brightness.light,
    colorSchemeSeed: AppColors.brandColor,
    useMaterial3: true,
  ).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  static ThemeData appDarkTheme = ThemeData(
    brightness: Brightness.dark,
    colorSchemeSeed: AppColors.brandColor,
    useMaterial3: true,
  ).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  // Text Styles
  static const TextStyle bigTextStyle = TextStyle(fontSize: 18);
}