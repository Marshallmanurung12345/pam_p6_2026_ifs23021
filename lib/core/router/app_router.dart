// lib/core/router/app_router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/home_screen.dart';
import '../../features/wisata/wisata_detail_screen.dart';
import '../../features/wisata/wisata_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../constants/route_constants.dart';
import '../../shared/widgets/bottom_nav_widget.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteConstants.home,
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainShell(child: child);
      },
      routes: [
        GoRoute(
          path: RouteConstants.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: RouteConstants.wisata,
          builder: (context, state) => const WisataScreen(),
        ),
        GoRoute(
          path: RouteConstants.wisataDetail,
          builder: (context, state) {
            final namaWisata = state.pathParameters['nama'] ?? '';
            return WisataDetailScreen(namaWisata: namaWisata);
          },
        ),
        GoRoute(
          path: RouteConstants.profile,
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavWidget(child: child),
    );
  }
}
