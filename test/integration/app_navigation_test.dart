// test/integration/app_navigation_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pam_p6_2026_ifs23021/app.dart';

void main() {
  group('Navigasi Aplikasi (End-to-End)', () {
    testWidgets('aplikasi berjalan dan menampilkan HomeScreen', (tester) async {
      await tester.pumpWidget(const WisataSamosirApp());
      await tester.pumpAndSettle();

      expect(find.widgetWithText(AppBar, 'Home'), findsOneWidget);
    });

    testWidgets('navigasi dari Home ke Wisata via BottomNav', (tester) async {
      await tester.pumpWidget(const WisataSamosirApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Wisata'));
      await tester.pumpAndSettle();

      expect(find.text('Wisata'), findsWidgets);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('navigasi dari Home ke Profile via BottomNav', (tester) async {
      await tester.pumpWidget(const WisataSamosirApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();

      expect(find.text('Tentang Saya'), findsOneWidget);
    });

    testWidgets('toggle dark mode mengubah tema aplikasi', (tester) async {
      await tester.pumpWidget(const WisataSamosirApp());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);

      await tester.tap(find.byIcon(Icons.light_mode_outlined));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.dark_mode_outlined), findsOneWidget);
    });

    testWidgets('toggle dark mode tetap aktif saat berpindah halaman',
        (tester) async {
      await tester.pumpWidget(const WisataSamosirApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.light_mode_outlined));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Wisata'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.dark_mode_outlined), findsOneWidget);
    });

    testWidgets('pencarian di halaman Wisata dapat menemukan destinasi',
        (tester) async {
      await tester.pumpWidget(const WisataSamosirApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('Wisata')));
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
    });

    testWidgets('navigasi kembali ke Home dari Wisata menggunakan BottomNav',
        (tester) async {
      await tester.pumpWidget(const WisataSamosirApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('Wisata')));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Wisata Samosir'), findsWidgets);
    });
  });
}
