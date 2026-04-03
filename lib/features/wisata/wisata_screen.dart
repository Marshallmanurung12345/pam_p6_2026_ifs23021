// lib/features/wisata/wisata_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/route_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../data/dummy_data.dart';
import '../../data/models/wisata_model.dart';
import '../../shared/widgets/top_app_bar_widget.dart';

class WisataScreen extends StatefulWidget {
  const WisataScreen({super.key});

  @override
  State<WisataScreen> createState() => _WisataScreenState();
}

class _WisataScreenState extends State<WisataScreen> {
  List<WisataModel> _wisataList = DummyData.getWisataData();
  String _searchQuery = '';
  String? _selectedKategori;

  static const _allKategori = [
    'Pantai & Danau',
    'Bukit & Alam',
    'Budaya & Sejarah',
    'Air Terjun',
    'Pulau & Danau',
    'Danau & Alam',
  ];

  void _onSearchQueryChange(String query) {
    setState(() {
      _searchQuery = query;
      _applyFilter();
    });
  }

  void _onKategoriSelected(String? kategori) {
    setState(() {
      _selectedKategori = kategori == _selectedKategori ? null : kategori;
      _applyFilter();
    });
  }

  void _applyFilter() {
    _wisataList = DummyData.getWisataData().where((w) {
      final matchSearch = w.nama.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          w.lokasi.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchKategori = _selectedKategori == null || w.kategori == _selectedKategori;
      return matchSearch && matchKategori;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBarWidget(
        title: 'Wisata',
        withSearch: true,
        searchQuery: _searchQuery,
        onSearchQueryChange: _onSearchQueryChange,
      ),
      body: Column(
        children: [
          // Filter chips
          _FilterChipRow(
            selected: _selectedKategori,
            onSelected: _onKategoriSelected,
            categories: _allKategori,
          ),
          // List
          Expanded(
            child: _WisataBody(
              wisataList: _wisataList,
              onOpen: (namaWisata) {
                context.go('${RouteConstants.wisata}/$namaWisata');
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── FILTER CHIPS ──────────────────────────────────────────────────────────────

class _FilterChipRow extends StatelessWidget {
  const _FilterChipRow({
    required this.selected,
    required this.onSelected,
    required this.categories,
  });
  final String? selected;
  final ValueChanged<String?> onSelected;
  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.surface,
      child: Column(
        children: [
          SizedBox(
            height: 52,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, i) {
                final cat = categories[i];
                final isSelected = selected == cat;
                return GestureDetector(
                  onTap: () => onSelected(cat),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected ? colorScheme.primary : colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: isSelected ? colorScheme.primary : colorScheme.outline.withValues(alpha: 0.3),
                      ),
                      boxShadow: isSelected
                          ? [BoxShadow(color: colorScheme.primary.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 4))]
                          : [],
                    ),
                    child: Text(
                      cat,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: isSelected ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(height: 1, color: colorScheme.outline.withValues(alpha: 0.15)),
        ],
      ),
    );
  }
}

// ── WISATA BODY ───────────────────────────────────────────────────────────────

class _WisataBody extends StatelessWidget {
  const _WisataBody({required this.wisataList, required this.onOpen});
  final List<WisataModel> wisataList;
  final ValueChanged<String> onOpen;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (wisataList.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 64,
              color: colorScheme.outline.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 16),
            Text(
              'Tidak ada destinasi\nyang ditemukan',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      itemCount: wisataList.length,
      itemBuilder: (context, index) {
        return _WisataItemCard(
          wisata: wisataList[index],
          onOpen: onOpen,
          index: index,
        );
      },
    );
  }
}

// ── WISATA ITEM CARD ──────────────────────────────────────────────────────────

class _WisataItemCard extends StatelessWidget {
  const _WisataItemCard({required this.wisata, required this.onOpen, required this.index});
  final WisataModel wisata;
  final ValueChanged<String> onOpen;
  final int index;

  Color _kategoriColor(String kategori) {
    switch (kategori) {
      case 'Pantai & Danau': return kCrystalWater;
      case 'Bukit & Alam': return kEmeraldHill;
      case 'Budaya & Sejarah': return const Color(0xFF7B1FA2);
      case 'Air Terjun': return const Color(0xFF00695C);
      case 'Pulau & Danau': return const Color(0xFF1565C0);
      case 'Danau & Alam': return kSamosirGreen;
      default: return kCrystalWater;
    }
  }

  String _kategoriEmoji(String kategori) {
    switch (kategori) {
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
    final katColor = _kategoriColor(wisata.kategori);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.12),
        ),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black : colorScheme.primary).withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => onOpen(wisata.nama),
          splashColor: katColor.withValues(alpha: 0.08),
          highlightColor: katColor.withValues(alpha: 0.04),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Image
                Hero(
                  tag: 'wisata_${wisata.nama}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      wisata.gambar,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [katColor.withValues(alpha: 0.6), katColor],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _kategoriEmoji(wisata.kategori),
                            style: const TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: katColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${_kategoriEmoji(wisata.kategori)} ${wisata.kategori}',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: katColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        wisata.nama,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: colorScheme.onSurface,
                          height: 1.2,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Row(
                        children: [
                          Icon(Icons.location_on_rounded, size: 12, color: colorScheme.outline),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              wisata.lokasi.split(',').first,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      Row(
                        children: [
                          Icon(Icons.confirmation_number_outlined, size: 12, color: colorScheme.secondary),
                          const SizedBox(width: 4),
                          Text(
                            wisata.tiketMasuk,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: colorScheme.secondary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Arrow
                Icon(
                  Icons.chevron_right_rounded,
                  color: colorScheme.outline.withValues(alpha: 0.5),
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}