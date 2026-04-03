// test/widget/bottom_nav_widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pam_p6_2026_ifs23021/core/theme/app_theme.dart';
import 'package:pam_p6_2026_ifs23021/core/theme/theme_notifier.dart';
import 'package:pam_p6_2026_ifs23021/shared/widgets/bottom_nav_widget.dart';

Widget buildNavTestApp(String initialRoute) {
  final notifier = ThemeNotifier(initial: ThemeMode.light);
  final router = GoRouter(
    initialLocation: initialRoute,
    routes: [
      ShellRoute(
        builder: (context, state, child) => Scaffold(
            body: child,
            bottomNavigationBar: BottomNavWidget(child: child)),
        routes: [
          GoRoute(
              path: '/', builder: (_, __) => const SizedBox(key: Key('home'))),
          GoRoute(
              path: '/wisata',
              builder: (_, __) => const SizedBox(key: Key('wisata'))),
          GoRoute(
              path: '/profile',
              builder: (_, __) => const SizedBox(key: Key('profile'))),
        ],
      ),
    ],
  );

  return ThemeProvider(
    notifier: notifier,
    child: MaterialApp.router(
      theme: AppTheme.lightTheme,
      routerConfig: router,
    ),
  );
}

void main() {
  group('BottomNavWidget', () {
    testWidgets('merender tiga item navigasi', (tester) async {
      await tester.pumpWidget(buildNavTestApp('/'));
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Wisata'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('menampilkan ikon home aktif di halaman home', (tester) async {
      await tester.pumpWidget(buildNavTestApp('/'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.home), findsOneWidget);
    });

    testWidgets('menekan Wisata menavigasi ke halaman Wisata', (tester) async {
      await tester.pumpWidget(buildNavTestApp('/'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Wisata'));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('wisata')), findsOneWidget);
    });

    testWidgets('menekan Profile menavigasi ke halaman Profile',
        (tester) async {
      await tester.pumpWidget(buildNavTestApp('/'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('profile')), findsOneWidget);
    });

    testWidgets('menampilkan NavigationBar sebagai bottom bar', (tester) async {
      await tester.pumpWidget(buildNavTestApp('/'));
      await tester.pumpAndSettle();

      expect(find.byType(NavigationBar), findsOneWidget);
    });
  });
}
