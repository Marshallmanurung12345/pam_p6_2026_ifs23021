// lib/shared/widgets/bottom_nav_widget.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/route_constants.dart';
import '../../core/theme/app_colors.dart';

class _NavItem {
  const _NavItem({
    required this.label,
    required this.route,
    required this.icon,
    required this.activeIcon,
  });
  final String label;
  final String route;
  final IconData icon;
  final IconData activeIcon;
}

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({super.key, required this.child});
  final Widget child;

  static const List<_NavItem> _items = [
    _NavItem(
      label: 'Home',
      route: RouteConstants.home,
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
    ),
    _NavItem(
      label: 'Wisata',
      route: RouteConstants.wisata,
      icon: Icons.explore_outlined,
      activeIcon: Icons.explore_rounded,
    ),
    _NavItem(
      label: 'Profile',
      route: RouteConstants.profile,
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
    ),
  ];

  String _getCurrentRoute(BuildContext context) =>
      GoRouterState.of(context).uri.toString();

  int _getSelectedIndex(String location) {
    if (location == RouteConstants.home) return 0;
    if (location.startsWith(RouteConstants.wisata)) return 1;
    if (location.startsWith(RouteConstants.profile)) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final currentLocation = _getCurrentRoute(context);
    final selectedIndex = _getSelectedIndex(currentLocation);
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.08),
            blurRadius: 24,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              final isSelected = selectedIndex == index;
              return _NavBarItem(
                item: item,
                isSelected: isSelected,
                onTap: () => context.go(item.route),
                isDark: isDark,
                colorScheme: colorScheme,
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
    required this.colorScheme,
  });
  final _NavItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: Key(item.label),
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 20 : 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
            colors: [
              colorScheme.primary.withValues(alpha: 0.15),
              colorScheme.primary.withValues(alpha: 0.08),
            ],
          )
              : null,
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(color: colorScheme.primary.withValues(alpha: 0.2))
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isSelected ? item.activeIcon : item.icon,
                key: ValueKey(isSelected),
                size: 22,
                color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              child: isSelected
                  ? Row(
                children: [
                  const SizedBox(width: 8),
                  Text(
                    item.label,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}