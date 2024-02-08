import 'package:flutter/material.dart';
import 'package:price_watcher/themes/app_colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light() => ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
        ),
      );

  static ThemeData dark() => ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: AppColors.primary,
        ),
      );
}
