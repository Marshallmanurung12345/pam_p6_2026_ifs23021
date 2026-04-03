// lib/core/theme/app_typography.dart

import 'package:flutter/material.dart';

class AppTypography {
  AppTypography._();

  static const TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -2.0),
    displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w300, letterSpacing: -1.0),
    displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w400, letterSpacing: -0.5),
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: -0.5),
    headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: -0.25),
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: 0.3),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.15),
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.1),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15, height: 1.6),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, height: 1.6),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4, height: 1.5),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.5),
    labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.6),
    labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.7),
  );
}