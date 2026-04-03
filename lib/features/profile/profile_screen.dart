// lib/features/profile/profile_screen.dart

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/top_app_bar_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const TopAppBarWidget(title: 'Profile', transparent: true),
      body: const _ProfileBody(),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Column(
        children: [
          // ── HEADER ────────────────────────────────────────────────────
          _ProfileHeader(colorScheme: colorScheme, isDark: isDark),

          const SizedBox(height: 24),

          // ── BIO CARD ──────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _BioCard(colorScheme: colorScheme, isDark: isDark),
          ),

          const SizedBox(height: 20),

          // ── SKILLS ────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _SkillsCard(colorScheme: colorScheme, isDark: isDark),
          ),

          const SizedBox(height: 20),

          // ── APP INFO ──────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _AppInfoCard(colorScheme: colorScheme, isDark: isDark),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

// ── PROFILE HEADER ────────────────────────────────────────────────────────────

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.colorScheme, required this.isDark});
  final ColorScheme colorScheme;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [kDeepToba, kMidnightLake, const Color(0xFF0E3050)]
              : [const Color(0xFF0D4F73), kCrystalWater, const Color(0xFF3BADD4)],
        ),
      ),
      child: Stack(
        children: [
          // Decorative
          Positioned(
            top: -30,
            right: -20,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          Positioned(
            bottom: -10,
            left: 30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kBatakGold.withValues(alpha: 0.1),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(24, 110, 24, 40),
            child: Column(
              children: [
                // Avatar with gold ring
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [kBatakGold, kBatakGoldLight, kBatakAmber],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: kBatakGold.withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/profile.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 100,
                        height: 100,
                        color: kCrystalWater,
                        child: const Icon(Icons.person_rounded, size: 56, color: Colors.white),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Name
                Text(
                  'Nama Mahasiswa',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 6),

                // NIM badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.badge_outlined, size: 14, color: Colors.white70),
                      const SizedBox(width: 6),
                      Text(
                        'NIM: ifs23021',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Program
                Text(
                  'Teknik Informatika',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.7),
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

// ── BIO CARD ──────────────────────────────────────────────────────────────────

class _BioCard extends StatelessWidget {
  const _BioCard({required this.colorScheme, required this.isDark});
  final ColorScheme colorScheme;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      colorScheme: colorScheme,
      isDark: isDark,
      icon: Icons.person_outline_rounded,
      iconColor: kCrystalWater,
      title: 'Tentang Saya',
      child: Text(
        'Saya adalah mahasiswa yang tertarik pada pengembangan aplikasi mobile '
            'dan teknologi informasi. Aplikasi ini dibuat sebagai tugas praktikum '
            'Pemrograman Aplikasi Mobile dengan topik Wisata Samosir.',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
          height: 1.7,
        ),
      ),
    );
  }
}

// ── SKILLS CARD ───────────────────────────────────────────────────────────────

class _SkillsCard extends StatelessWidget {
  const _SkillsCard({required this.colorScheme, required this.isDark});
  final ColorScheme colorScheme;
  final bool isDark;

  static const _skills = [
    _SkillData('Flutter', 0.85, kCrystalWater),
    _SkillData('Dart', 0.80, kEmeraldHill),
    _SkillData('Mobile Dev', 0.75, Color(0xFF7B1FA2)),
    _SkillData('UI/UX', 0.70, kBatakGold),
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      colorScheme: colorScheme,
      isDark: isDark,
      icon: Icons.code_rounded,
      iconColor: kEmeraldHill,
      title: 'Keahlian',
      child: Column(
        children: _skills.map((s) => _SkillBar(skill: s)).toList(),
      ),
    );
  }
}

class _SkillData {
  const _SkillData(this.name, this.level, this.color);
  final String name;
  final double level;
  final Color color;
}

class _SkillBar extends StatelessWidget {
  const _SkillBar({required this.skill});
  final _SkillData skill;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skill.name,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${(skill.level * 100).toInt()}%',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: skill.color,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: skill.level,
              minHeight: 8,
              backgroundColor: colorScheme.outline.withValues(alpha: 0.15),
              valueColor: AlwaysStoppedAnimation<Color>(skill.color),
            ),
          ),
        ],
      ),
    );
  }
}

// ── APP INFO CARD ─────────────────────────────────────────────────────────────

class _AppInfoCard extends StatelessWidget {
  const _AppInfoCard({required this.colorScheme, required this.isDark});
  final ColorScheme colorScheme;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      colorScheme: colorScheme,
      isDark: isDark,
      icon: Icons.apps_rounded,
      iconColor: kBatakGold,
      title: 'Tentang Aplikasi',
      child: Column(
        children: [
          _InfoRow(icon: Icons.phone_android_rounded, label: 'Platform', value: 'Flutter (Android & iOS)', color: kCrystalWater),
          _InfoRow(icon: Icons.place_rounded, label: 'Topik', value: 'Wisata Samosir & Danau Toba', color: kEmeraldHill),
          _InfoRow(icon: Icons.school_rounded, label: 'Mata Kuliah', value: 'Pemrograman Aplikasi Mobile', color: const Color(0xFF7B1FA2)),
          _InfoRow(icon: Icons.calendar_today_rounded, label: 'Tahun', value: '2026', color: kBatakGold),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
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
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 16, color: color),
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
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
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

// ── REUSABLE SECTION CARD ─────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.colorScheme,
    required this.isDark,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.child,
  });
  final ColorScheme colorScheme;
  final bool isDark;
  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.12),
        ),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black : colorScheme.primary).withValues(alpha: isDark ? 0.3 : 0.07),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
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
                  color: iconColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}