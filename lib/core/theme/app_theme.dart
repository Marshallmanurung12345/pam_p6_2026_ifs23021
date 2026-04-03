// lib/core/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: AppTypography.textTheme,
    colorScheme: const ColorScheme.light(
      primary: kLightPrimary,
      onPrimary: kLightOnPrimary,
      primaryContainer: kLightPrimaryContainer,
      onPrimaryContainer: kLightOnPrimaryContainer,
      secondary: kLightSecondary,
      onSecondary: kLightOnSecondary,
      secondaryContainer: kLightSecondaryContainer,
      onSecondaryContainer: kLightOnSecondaryContainer,
      tertiary: kLightTertiary,
      onTertiary: kLightOnTertiary,
      error: kLightError,
      onError: kLightOnError,
      errorContainer: kLightErrorContainer,
      onErrorContainer: kLightOnErrorContainer,
      surface: kLightSurface,
      onSurface: kLightOnSurface,
      surfaceContainerHighest: kLightSurfaceVariant,
      onSurfaceVariant: kLightOnSurfaceVariant,
      outline: kLightOutline,
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      filled: true,
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme: AppTypography.textTheme,
    colorScheme: const ColorScheme.dark(
      primary: kDarkPrimary,
      onPrimary: kDarkOnPrimary,
      primaryContainer: kDarkPrimaryContainer,
      onPrimaryContainer: kDarkOnPrimaryContainer,
      secondary: kDarkSecondary,
      onSecondary: kDarkOnSecondary,
      secondaryContainer: kDarkSecondaryContainer,
      onSecondaryContainer: kDarkOnSecondaryContainer,
      tertiary: kDarkTertiary,
      onTertiary: kDarkOnTertiary,
      error: kDarkError,
      onError: kDarkOnError,
      errorContainer: kDarkErrorContainer,
      onErrorContainer: kDarkOnErrorContainer,
      surface: kDarkSurface,
      onSurface: kDarkOnSurface,
      surfaceContainerHighest: kDarkSurfaceVariant,
      onSurfaceVariant: kDarkOnSurfaceVariant,
      outline: kDarkOutline,
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}