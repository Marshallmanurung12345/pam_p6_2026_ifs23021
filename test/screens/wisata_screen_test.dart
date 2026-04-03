// test/screens/wisata_screen_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:pam_p6_2026_ifs23021/core/theme/app_theme.dart';
import 'package:pam_p6_2026_ifs23021/core/theme/theme_notifier.dart';
import 'package:pam_p6_2026_ifs23021/data/dummy_data.dart';
import 'package:pam_p6_2026_ifs23021/features/wisata/wisata_screen.dart';

Widget buildWisataTest() {
  final notifier = ThemeNotifier(initial: ThemeMode.light);
  final router = GoRouter(routes: [
    GoRoute(path: '/', builder: (_, __) => const WisataScreen()),
    GoRoute(path: '/wisata/:nama', builder: (_, __) => const SizedBox()),
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
  group('WisataScreen', () {
    testWidgets('merender tanpa error', (tester) async {
      await tester.pumpWidget(buildWisataTest());
      await tester.pumpAndSettle();

      expect(find.byType(WisataScreen), findsOneWidget);
    });

    testWidgets('menampilkan judul "Wisata" di AppBar', (tester) async {
      await tester.pumpWidget(buildWisataTest());
      await tester.pumpAndSettle();

      expect(find.text('Wisata'), findsOneWidget);
    });

    testWidgets('menampilkan tombol search di AppBar', (tester) async {
      await tester.pumpWidget(buildWisataTest());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('menampilkan wisata pertama dari DummyData', (tester) async {
      await tester.pumpWidget(buildWisataTest());
      await tester.pumpAndSettle();

      final wisataList = DummyData.getWisataData();
      expect(find.text(wisataList.first.nama), findsOneWidget);
    });

    testWidgets('menampilkan list wisata menggunakan ListView', (tester) async {
      await tester.pumpWidget(buildWisataTest());
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('fungsi search memfilter wisata berdasarkan nama',
        (tester) async {
      await tester.pumpWidget(buildWisataTest());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Parbaba');
      await tester.pumpAndSettle();

      expect(
        find.descendant(
          of: find.byType(ListView),
          matching: find.text('Pantai Parbaba'),
        ),
        findsOneWidget,
      );
      expect(find.text('Danau Sidihoni'), findsNothing);
    });

    testWidgets('menampilkan pesan saat tidak ada hasil pencarian',
        (tester) async {
      await tester.pumpWidget(buildWisataTest());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'xyzabc999');
      await tester.pumpAndSettle();

      expect(find.text('Tidak ada data!'), findsOneWidget);
    });

    testWidgets('menutup search mereset daftar wisata', (tester) async {
      await tester.pumpWidget(buildWisataTest());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Parbaba');
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.text(DummyData.getWisataData().last.nama),
        500,
      );

      expect(find.text(DummyData.getWisataData().last.nama), findsOneWidget);
    });
  });
}
