// test/widget/screens/plants_screen_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pam_p6_2026_ifs18005/core/theme/app_theme.dart';
import 'package:pam_p6_2026_ifs18005/core/theme/theme_notifier.dart';
import 'package:pam_p6_2026_ifs18005/data/dummy_data.dart';
import 'package:pam_p6_2026_ifs18005/features/plants/plants_screen.dart';

Widget buildPlantsTest() {
  final notifier = ThemeNotifier(initial: ThemeMode.light);
  final router = GoRouter(routes: [
    GoRoute(path: '/', builder: (_, _) => const PlantsScreen()),
    GoRoute(path: '/plants/:name', builder: (_, _) => const SizedBox()),
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
  group('PlantsScreen', () {
    testWidgets('merender tanpa error', (tester) async {
      await tester.pumpWidget(buildPlantsTest());
      await tester.pumpAndSettle();

      expect(find.byType(PlantsScreen), findsOneWidget);
    });

    testWidgets('menampilkan judul "Plants" di AppBar', (tester) async {
      await tester.pumpWidget(buildPlantsTest());
      await tester.pumpAndSettle();

      expect(find.text('Plants'), findsOneWidget);
    });

    testWidgets('menampilkan tombol search di AppBar', (tester) async {
      await tester.pumpWidget(buildPlantsTest());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('menampilkan semua tanaman dari DummyData', (tester) async {
      await tester.pumpWidget(buildPlantsTest());
      await tester.pumpAndSettle();

      final plants = DummyData.getPlantsData();
      // Cek nama tanaman pertama tampil
      expect(find.text(plants.first.nama), findsOneWidget);
    });

    testWidgets('menampilkan list tanaman menggunakan ListView', (tester) async {
      await tester.pumpWidget(buildPlantsTest());
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('fungsi search memfilter tanaman berdasarkan nama',
            (tester) async {
          await tester.pumpWidget(buildPlantsTest());
          await tester.pumpAndSettle();

          // Buka search
          await tester.tap(find.byIcon(Icons.search));
          await tester.pumpAndSettle();

          // Ketik query
          await tester.enterText(find.byType(TextField), 'Wortel');
          await tester.pumpAndSettle();

          // Hanya Wortel yang tampil
          expect(
            find.descendant(
              of: find.byType(ListView),
              matching: find.text('Wortel'),
            ),
            findsOneWidget,
          );
          expect(find.text('Tomat'), findsNothing);
        });

    testWidgets('menampilkan pesan saat tidak ada hasil pencarian',
            (tester) async {
          await tester.pumpWidget(buildPlantsTest());
          await tester.pumpAndSettle();

          await tester.tap(find.byIcon(Icons.search));
          await tester.pumpAndSettle();

          // Query yang tidak ada hasilnya
          await tester.enterText(find.byType(TextField), 'xyzabc123');
          await tester.pumpAndSettle();

          expect(find.text('Tidak ada data!'), findsOneWidget);
        });

    testWidgets('menutup search mereset daftar tanaman', (tester) async {
      await tester.pumpWidget(buildPlantsTest());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Wortel');
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      // Scroll ke bawah sampai data terakhir
      await tester.scrollUntilVisible(
        find.text(DummyData.getPlantsData().last.nama),
        500,
      );

      // Pastikan data terakhir tampil
      expect(
        find.text(DummyData.getPlantsData().last.nama),
        findsOneWidget,
      );
    });
  });
}