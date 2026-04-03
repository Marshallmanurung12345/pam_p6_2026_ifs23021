// lib/features/home/home_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/route_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/top_app_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const TopAppBarWidget(title: 'Home', transparent: true),
      body: const _HomeBody(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Column(
        children: [
          // ── HERO SECTION ──────────────────────────────────────────────
          _HeroSection(isDark: isDark, colorScheme: colorScheme),

          // ── STATS ROW ─────────────────────────────────────────────────
          const _StatsRow(),

          const SizedBox(height: 28),

          // ── SECTION TITLE ─────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    color: colorScheme.secondary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Jelajahi Kategori',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: colorScheme.onSurface,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── CATEGORY GRID ─────────────────────────────────────────────
          const _CategoryGrid(),

          const SizedBox(height: 28),

          // ── ABOUT SECTION ─────────────────────────────────────────────
          const _AboutSection(),

          const SizedBox(height: 28),

          // ── CTA SECTION ───────────────────────────────────────────────
          _CtaSection(colorScheme: colorScheme),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

// ── HERO SECTION ──────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.isDark, required this.colorScheme});
  final bool isDark;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 340),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
            kDeepToba,
            kMidnightLake,
            const Color(0xFF0E2E48),
          ]
              : [
            const Color(0xFF0D4F73),
            kCrystalWater,
            const Color(0xFF3BADD4),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -60,
            right: -40,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.04),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: -30,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kBatakGold.withValues(alpha: 0.12),
              ),
            ),
          ),
          Positioned(
            top: 100,
            right: 30,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kMistBlue.withValues(alpha: 0.15),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 120, 24, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: kBatakGold.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: kBatakGold.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kBatakGoldLight,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Sumatera Utara, Indonesia',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: kBatakGoldLight,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Main title
                Text(
                  'Pesona',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w300,
                    height: 1.1,
                  ),
                ),
                Text(
                  'Pulau Samosir',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  'Danau Toba & Keindahan Budaya Batak\nyang Menakjubkan Dunia',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.75),
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 28),

                // CTA Button
                GestureDetector(
                  onTap: () => context.go(RouteConstants.wisata),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [kBatakGold, kBatakGoldLight],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: kBatakGold.withValues(alpha: 0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Mulai Jelajahi',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: kDeepToba,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward_rounded, size: 18, color: kDeepToba),
                      ],
                    ),
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

// ── STATS ROW ─────────────────────────────────────────────────────────────────

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Transform.translate(
      offset: const Offset(0, -1),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withValues(alpha: 0.12),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            _StatItem(
              value: '10+',
              label: 'Destinasi',
              icon: Icons.place_rounded,
              color: colorScheme.primary,
            ),
            _divider(colorScheme),
            _StatItem(
              value: '6',
              label: 'Kategori',
              icon: Icons.category_rounded,
              color: colorScheme.secondary,
            ),
            _divider(colorScheme),
            _StatItem(
              value: '∞',
              label: 'Kenangan',
              icon: Icons.favorite_rounded,
              color: kEmeraldHill,
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider(ColorScheme cs) => Container(
    width: 1,
    height: 40,
    color: cs.outline.withValues(alpha: 0.3),
  );
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// ── CATEGORY GRID ─────────────────────────────────────────────────────────────

class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid();

  static const _categories = [
    _CategoryData(emoji: '🏖️', label: 'Pantai\n& Danau', gradient: [Color(0xFF1565C0), Color(0xFF42A5F5)]),
    _CategoryData(emoji: '⛰️', label: 'Bukit\n& Alam', gradient: [Color(0xFF1B5E20), Color(0xFF66BB6A)]),
    _CategoryData(emoji: '🏛️', label: 'Budaya\n& Sejarah', gradient: [Color(0xFF6A1B9A), Color(0xFFBA68C8)]),
    _CategoryData(emoji: '💧', label: 'Air\nTerjun', gradient: [Color(0xFF006064), Color(0xFF4DD0E1)]),
    _CategoryData(emoji: '🏝️', label: 'Pulau\n& Danau', gradient: [Color(0xFF1A237E), Color(0xFF5C6BC0)]),
    _CategoryData(emoji: '🌿', label: 'Danau\n& Alam', gradient: [Color(0xFF1B5E3B), Color(0xFF4CAF7D)]),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return _CategoryCard(data: _categories[index]);
        },
      ),
    );
  }
}

class _CategoryData {
  const _CategoryData({required this.emoji, required this.label, required this.gradient});
  final String emoji;
  final String label;
  final List<Color> gradient;
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.data});
  final _CategoryData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: data.gradient,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: data.gradient[0].withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(data.emoji, style: const TextStyle(fontSize: 28)),
            Text(
              data.label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── ABOUT SECTION ─────────────────────────────────────────────────────────────

class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [kDarkSurfaceVariant, const Color(0xFF1A3550)]
              : [kLightSurfaceVariant, kLightPrimaryContainer],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.info_outline_rounded,
                  color: colorScheme.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Tentang Samosir',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Pulau Samosir adalah pulau vulkanik yang berdiri megah di tengah '
                'Danau Toba — danau kaldera terbesar di dunia. Terletak di jantung '
                'Sumatera Utara, pulau ini menyimpan warisan budaya Batak Toba yang '
                'kaya, alam yang memukau, dan panorama yang tak tertandingi.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _InfoChip(icon: Icons.straighten, label: '630 km²', colorScheme: colorScheme),
              const SizedBox(width: 10),
              _InfoChip(icon: Icons.water, label: 'Danau Toba', colorScheme: colorScheme),
              const SizedBox(width: 10),
              _InfoChip(icon: Icons.people, label: 'Batak Toba', colorScheme: colorScheme),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label, required this.colorScheme});
  final IconData icon;
  final String label;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: colorScheme.primary),
          const SizedBox(width: 5),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ── CTA SECTION ───────────────────────────────────────────────────────────────

class _CtaSection extends StatelessWidget {
  const _CtaSection({required this.colorScheme});
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () => context.go(RouteConstants.wisata),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [kBatakAmber, kBatakGold, kBatakGoldLight],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: kBatakGold.withValues(alpha: 0.35),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Siap Berpetualang?',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: kDeepToba,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Lihat semua destinasi wisata\nSamosir yang menakjubkan',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: kDeepToba.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: kDeepToba.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.explore_rounded,
                  color: kDeepToba,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}