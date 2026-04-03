// lib/shared/widgets/loading_widget.dart

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with TickerProviderStateMixin {
  late AnimationController _rippleController;
  late AnimationController _rotateController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();

    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _rippleController.dispose();
    _rotateController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 160,
            height: 160,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer ripple 1
                AnimatedBuilder(
                  animation: _rippleController,
                  builder: (_, __) {
                    final v = _rippleController.value;
                    return Opacity(
                      opacity: (1 - v).clamp(0.0, 1.0) * 0.5,
                      child: Container(
                        width: 50 + v * 110,
                        height: 50 + v * 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: colorScheme.primary,
                            width: 1.5,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // Outer ripple 2 (delayed)
                AnimatedBuilder(
                  animation: _rippleController,
                  builder: (_, __) {
                    final v = ((_rippleController.value + 0.45) % 1.0);
                    return Opacity(
                      opacity: (1 - v).clamp(0.0, 1.0) * 0.4,
                      child: Container(
                        width: 50 + v * 110,
                        height: 50 + v * 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: kBatakGold,
                            width: 1.5,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // Inner gradient circle
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (_, child) {
                    return Container(
                      width: 70 + _pulseController.value * 8,
                      height: 70 + _pulseController.value * 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            colorScheme.primary.withValues(alpha: 0.3),
                            colorScheme.primary.withValues(alpha: 0.05),
                          ],
                        ),
                        border: Border.all(
                          color: colorScheme.primary.withValues(alpha: 0.4),
                          width: 1,
                        ),
                      ),
                      child: child,
                    );
                  },
                  child: Center(
                    child: RotationTransition(
                      turns: _rotateController,
                      child: ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: isDark
                              ? [kMistBlue, kBatakGoldLight]
                              : [kCrystalWater, kBatakGold],
                        ).createShader(bounds),
                        child: const Icon(
                          Icons.landscape_rounded,
                          size: 36,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Memuat destinasi...',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          AnimatedBuilder(
            animation: _pulseController,
            builder: (_, __) {
              return Opacity(
                opacity: 0.4 + _pulseController.value * 0.6,
                child: Text(
                  '✦ Samosir ✦',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: kBatakGold,
                    letterSpacing: 2.0,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}