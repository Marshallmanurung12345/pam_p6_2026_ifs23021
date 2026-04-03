// lib/app.dart

import 'package:flutter/material.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_notifier.dart';

class WisataSamosirApp extends StatefulWidget {
  const WisataSamosirApp({super.key});

  @override
  State<WisataSamosirApp> createState() => _WisataSamosirAppState();
}

class _WisataSamosirAppState extends State<WisataSamosirApp> {
  final ThemeNotifier _themeNotifier = ThemeNotifier(initial: ThemeMode.light);

  @override
  void dispose() {
    _themeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      notifier: _themeNotifier,
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: _themeNotifier,
        builder: (context, themeMode, child) {
          return MaterialApp.router(
            title: 'Wisata Samosir',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            routerConfig: appRouter,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
