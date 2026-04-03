// lib/features/wisata/wisata_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/route_constants.dart';
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

  void _onSearchQueryChange(String query) {
    setState(() {
      _searchQuery = query;
      _wisataList = DummyData.getWisataData()
          .where((w) => w.nama.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
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
      body: _WisataBody(
        wisataList: _wisataList,
        onOpen: (namaWisata) {
          context.go('${RouteConstants.wisata}/$namaWisata');
        },
      ),
    );
  }
}

class _WisataBody extends StatelessWidget {
  const _WisataBody({required this.wisataList, required this.onOpen});

  final List<WisataModel> wisataList;
  final ValueChanged<String> onOpen;

  @override
  Widget build(BuildContext context) {
    if (wisataList.isEmpty) {
      return Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Tidak ada data!',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: wisataList.length,
      itemBuilder: (context, index) {
        return _WisataItemCard(
          wisata: wisataList[index],
          onOpen: onOpen,
        );
      },
    );
  }
}

class _WisataItemCard extends StatelessWidget {
  const _WisataItemCard({required this.wisata, required this.onOpen});

  final WisataModel wisata;
  final ValueChanged<String> onOpen;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => onOpen(wisata.nama),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Gambar wisata
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  wisata.gambar,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 80,
                    height: 80,
                    color: colorScheme.primaryContainer,
                    child: Icon(Icons.landscape, color: colorScheme.primary),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Nama, kategori, dan deskripsi
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      wisata.nama,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Badge kategori
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        wisata.kategori,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      wisata.deskripsi,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
