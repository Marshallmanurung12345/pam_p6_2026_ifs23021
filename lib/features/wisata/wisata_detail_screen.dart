// lib/features/wisata/wisata_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../../data/dummy_data.dart';
import '../../data/models/wisata_model.dart';
import '../../shared/widgets/loading_widget.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/route_constants.dart';
import '../../core/theme/theme_notifier.dart';

class WisataDetailScreen extends StatefulWidget {
  const WisataDetailScreen({super.key, required this.namaWisata});
  final String namaWisata;

  @override
  State<WisataDetailScreen> createState() => _WisataDetailScreenState();
}

class _WisataDetailScreenState extends State<WisataDetailScreen> {
  WisataModel? _wisata;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final result = DummyData.getWisataData()
          .where((w) => w.nama == widget.namaWisata)
          .firstOrNull;
      if (mounted) {
        setState(() => _wisata = result);
        if (result == null && mounted) Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_wisata == null) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: const LoadingWidget(),
      );
    }

    return _WisataDetailBody(wisata: _wisata!);
  }
}

// ── FULL DETAIL BODY ──────────────────────────────────────────────────────────

class _WisataDetailBody extends StatelessWidget {
  const _WisataDetailBody({required this.wisata});
  final WisataModel wisata;

  Color _kategoriColor() {
    switch (wisata.kategori) {
      case 'Pantai & Danau': return kCrystalWater;
      case 'Bukit & Alam': return kEmeraldHill;
      case 'Budaya & Sejarah': return const Color(0xFF7B1FA2);
      case 'Air Terjun': return const Color(0xFF00695C);
      case 'Pulau & Danau': return const Color(0xFF1565C0);
      case 'Danau & Alam': return kSamosirGreen;
      default: return kCrystalWater;
    }
  }

  String _kategoriEmoji() {
    switch (wisata.kategori) {
      case 'Pantai & Danau': return '🏖️';
      case 'Bukit & Alam': return '⛰️';
      case 'Budaya & Sejarah': return '🏛️';
      case 'Air Terjun': return '💧';
      case 'Pulau & Danau': return '🏝️';
      case 'Danau & Alam': return '🌿';
      default: return '📍';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final katColor = _kategoriColor();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeNotifier = ThemeProvider.of(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        body: CustomScrollView(
          slivers: [
            // ── HERO SLIVER APP BAR ──────────────────────────────────────
            SliverAppBar(
              expandedHeight: 320,
              pinned: true,
              stretch: true,
              backgroundColor: katColor,
              leading: GestureDetector(
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
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                ),
              ),
              actions: [
                // Theme toggle
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: GestureDetector(
                    onTap: themeNotifier.toggle,
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [StretchMode.zoomBackground],
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Image
                    Hero(
                      tag: 'wisata_${wisata.nama}',
                      child: Image.asset(
                        wisata.gambar,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [katColor, katColor.withValues(alpha: 0.6)],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              _kategoriEmoji(),
                              style: const TextStyle(fontSize: 80),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Gradient overlay
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.0, 0.5, 1.0],
                            colors: [
                              Colors.black.withValues(alpha: 0.2),
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.7),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Bottom info overlay
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(
                                color: katColor.withValues(alpha: 0.85),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${_kategoriEmoji()} ${wisata.kategori}',
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              wisata.nama,
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                shadows: [
                                  const Shadow(blurRadius: 10, color: Colors.black54),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── CONTENT ─────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Column(
                children: [
                  // Quick info cards
                  _QuickInfoSection(wisata: wisata, katColor: katColor),

                  const SizedBox(height: 24),

                  // Description
                  _DescriptionSection(wisata: wisata, colorScheme: colorScheme, isDark: isDark),

                  const SizedBox(height: 24),

                  // Practical info
                  _PracticalInfoSection(wisata: wisata, colorScheme: colorScheme, katColor: katColor),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── QUICK INFO ────────────────────────────────────────────────────────────────

class _QuickInfoSection extends StatelessWidget {
  const _QuickInfoSection({required this.wisata, required this.katColor});
  final WisataModel wisata;
  final Color katColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Transform.translate(
      offset: const Offset(0, -20),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: (isDark ? Colors.black : katColor).withValues(alpha: isDark ? 0.4 : 0.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            _QuickInfoItem(
              icon: Icons.access_time_rounded,
              label: 'Jam Buka',
              value: wisata.jamBuka,
              color: kCrystalWater,
            ),
            Container(width: 1, height: 50, color: colorScheme.outline.withValues(alpha: 0.2)),
            _QuickInfoItem(
              icon: Icons.confirmation_number_rounded,
              label: 'Tiket',
              value: wisata.tiketMasuk,
              color: colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickInfoItem extends StatelessWidget {
  const _QuickInfoItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ── DESCRIPTION ───────────────────────────────────────────────────────────────

class _DescriptionSection extends StatelessWidget {
  const _DescriptionSection({
    required this.wisata,
    required this.colorScheme,
    required this.isDark,
  });
  final WisataModel wisata;
  final ColorScheme colorScheme;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 22,
                decoration: BoxDecoration(
                  color: colorScheme.secondary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Tentang Tempat Ini',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? kDarkSurfaceVariant : kLightSurfaceVariant,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.15),
              ),
            ),
            child: Text(
              wisata.deskripsi,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── PRACTICAL INFO ────────────────────────────────────────────────────────────

class _PracticalInfoSection extends StatelessWidget {
  const _PracticalInfoSection({
    required this.wisata,
    required this.colorScheme,
    required this.katColor,
  });
  final WisataModel wisata;
  final ColorScheme colorScheme;
  final Color katColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 22,
                decoration: BoxDecoration(
                  color: colorScheme.secondary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Informasi Praktis',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _PracticalRow(
            icon: Icons.location_on_rounded,
            iconBg: katColor,
            label: 'Lokasi',
            value: wisata.lokasi,
          ),
          const SizedBox(height: 12),
          _PracticalRow(
            icon: Icons.access_time_rounded,
            iconBg: kCrystalWater,
            label: 'Jam Buka',
            value: wisata.jamBuka,
          ),
          const SizedBox(height: 12),
          _PracticalRow(
            icon: Icons.confirmation_number_rounded,
            iconBg: colorScheme.secondary,
            label: 'Tiket Masuk',
            value: wisata.tiketMasuk,
          ),
        ],
      ),
    );
  }
}

class _PracticalRow extends StatelessWidget {
  const _PracticalRow({
    required this.icon,
    required this.iconBg,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final Color iconBg;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBg.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconBg, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}