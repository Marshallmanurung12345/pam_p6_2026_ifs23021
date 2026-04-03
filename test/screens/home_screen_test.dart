// test/screens/home_screen_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pam_p6_2026_ifs23021/core/theme/app_theme.dart';
import 'package:pam_p6_2026_ifs23021/core/theme/theme_notifier.dart';
import 'package:pam_p6_2026_ifs23021/features/home/home_screen.dart';

Widget buildHomeTest() {
  final notifier = ThemeNotifier(initial: ThemeMode.light);
  final router = GoRouter(routes: [
    GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
  ]);

  return ThemeProvider(
    notifier: notifier,
    child: MaterialApp.router(
      theme: AppTheme.lightTheme,
      routerConfig: router,
    ),
  );
}

void main() {
  group('HomeScreen', () {
    testWidgets('merender tanpa error', (tester) async {
      await tester.pumpWidget(buildHomeTest());
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('menampilkan judul "Home" di AppBar', (tester) async {
      await tester.pumpWidget(buildHomeTest());
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('menampilkan teks "Wisata Samosir"', (tester) async {
      await tester.pumpWidget(buildHomeTest());
      await tester.pumpAndSettle();

      expect(find.textContaining('Wisata Samosir'), findsWidgets);
    });

    testWidgets('menampilkan minimal satu Card', (tester) async {
      await tester.pumpWidget(buildHomeTest());
      await tester.pumpAndSettle();

      expect(find.byType(Card), findsWidgets);
    });

    testWidgets('menampilkan teks "Tentang Samosir"', (tester) async {
      await tester.pumpWidget(buildHomeTest());
      await tester.pumpAndSettle();

      expect(find.textContaining('Tentang Samosir'), findsOneWidget);
    });

    testWidgets('menampilkan teks "Kategori Wisata"', (tester) async {
      await tester.pumpWidget(buildHomeTest());
      await tester.pumpAndSettle();

      expect(find.text('Kategori Wisata'), findsOneWidget);
    });

    testWidgets('tombol toggle light mode tersedia di AppBar', (tester) async {
      await tester.pumpWidget(buildHomeTest());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);
    });
  });
}
