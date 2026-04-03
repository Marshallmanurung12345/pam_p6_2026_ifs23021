// lib/shared/widgets/top_app_bar_widget.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/route_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_notifier.dart';

class TopAppBarMenuItem {
  const TopAppBarMenuItem({
    required this.text,
    required this.icon,
    this.route,
    this.onTap,
    this.isDestructive = false,
  });
  final String text;
  final IconData icon;
  final String? route;
  final VoidCallback? onTap;
  final bool isDestructive;
}

class TopAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const TopAppBarWidget({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.withSearch = false,
    this.searchQuery = '',
    this.onSearchQueryChange,
    this.menuItems = const [],
    this.transparent = false,
  });

  final String title;
  final bool showBackButton;
  final bool withSearch;
  final String searchQuery;
  final ValueChanged<String>? onSearchQueryChange;
  final List<TopAppBarMenuItem> menuItems;
  final bool transparent;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<TopAppBarWidget> createState() => _TopAppBarWidgetState();
}

class _TopAppBarWidgetState extends State<TopAppBarWidget> {
  bool _isSearchActive = false;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeNotifier = ThemeProvider.of(context);
    final isDark = themeNotifier.isDark;
    final isTransparent = widget.transparent;

    return AppBar(
      backgroundColor: isTransparent ? Colors.transparent : colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: isTransparent ? 0 : 2,
      shadowColor: isTransparent ? Colors.transparent : colorScheme.shadow.withValues(alpha: 0.3),
      leading: widget.showBackButton
          ? GestureDetector(
        onTap: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go(RouteConstants.wisata);
          }
        },
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isTransparent
                ? Colors.black26
                : colorScheme.surfaceContainerHighest.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.arrow_back_rounded,
            color: isTransparent ? Colors.white : colorScheme.onSurface,
            size: 22,
          ),
        ),
      )
          : null,
      title: _isSearchActive
          ? Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: _searchController,
          autofocus: true,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: 'Cari destinasi wisata...',
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
            prefixIcon: Icon(Icons.search_rounded, size: 18, color: colorScheme.primary),
            prefixIconConstraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
          onChanged: widget.onSearchQueryChange,
        ),
      )
          : Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isTransparent) ...[
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [kBatakGold, kBatakGoldLight],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.landscape_rounded, color: kDeepToba, size: 16),
            ),
            const SizedBox(width: 8),
          ],
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: isTransparent ? Colors.white : colorScheme.onSurface,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
      actions: [
        // Theme toggle
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => RotationTransition(
            turns: animation,
            child: FadeTransition(opacity: animation, child: child),
          ),
          child: GestureDetector(
            key: ValueKey(isDark),
            onTap: themeNotifier.toggle,
            child: Container(
              margin: const EdgeInsets.only(right: 4),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isTransparent
                    ? Colors.black26
                    : colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                size: 20,
                color: isTransparent
                    ? Colors.white
                    : isDark
                    ? kBatakGoldLight
                    : kBatakAmber,
              ),
            ),
          ),
        ),
        if (widget.withSearch) ...[
          _isSearchActive
              ? GestureDetector(
            onTap: () {
              setState(() => _isSearchActive = false);
              _searchController.clear();
              widget.onSearchQueryChange?.call('');
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.errorContainer.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.close_rounded, size: 20, color: colorScheme.error),
            ),
          )
              : GestureDetector(
            onTap: () => setState(() => _isSearchActive = true),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.search_rounded, size: 20, color: colorScheme.onSurfaceVariant),
            ),
          ),
        ],
        if (!widget.withSearch) const SizedBox(width: 8),
        if (widget.menuItems.isNotEmpty)
          PopupMenuButton<TopAppBarMenuItem>(
            icon: const Icon(Icons.more_vert),
            color: colorScheme.surface,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            itemBuilder: (context) => widget.menuItems
                .map(
                  (item) => PopupMenuItem<TopAppBarMenuItem>(
                value: item,
                child: Row(
                  children: [
                    Icon(item.icon, size: 20, color: item.isDestructive ? colorScheme.error : colorScheme.primary),
                    const SizedBox(width: 12),
                    Text(item.text, style: TextStyle(color: item.isDestructive ? colorScheme.error : colorScheme.onSurface)),
                  ],
                ),
              ),
            )
                .toList(),
            onSelected: (item) {
              if (item.route != null) context.go(item.route!);
              item.onTap?.call();
            },
          ),
      ],
    );
  }
}