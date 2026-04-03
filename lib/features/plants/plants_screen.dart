// lib/features/plants/plants_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/route_constants.dart';
import '../../data/dummy_data.dart';
import '../../data/models/plant_model.dart';
import '../../shared/widgets/top_app_bar_widget.dart';

class PlantsScreen extends StatefulWidget {
  const PlantsScreen({super.key});

  @override
  State<PlantsScreen> createState() => _PlantsScreenState();
}

class _PlantsScreenState extends State<PlantsScreen> {
  List<PlantModel> _plants = DummyData.getPlantsData();
  String _searchQuery = '';

  void _onSearchQueryChange(String query) {
    setState(() {
      _searchQuery = query;
      _plants = DummyData.getPlantsData()
          .where((p) => p.nama.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBarWidget(
        title: 'Plants',
        withSearch: true,
        searchQuery: _searchQuery,
        onSearchQueryChange: _onSearchQueryChange,
      ),
      body: _PlantsBody(
        plants: _plants,
        onOpen: (plantName) {
          // Navigasi ke detail dengan path parameter
          context.go('${RouteConstants.plants}/$plantName');
        },
      ),
    );
  }
}

class _PlantsBody extends StatelessWidget {
  const _PlantsBody({required this.plants, required this.onOpen});

  final List<PlantModel> plants;
  final ValueChanged<String> onOpen;

  @override
  Widget build(BuildContext context) {
    if (plants.isEmpty) {
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
      itemCount: plants.length,
      itemBuilder: (context, index) {
        return _PlantItemCard(
          plant: plants[index],
          onOpen: onOpen,
        );
      },
    );
  }
}

class _PlantItemCard extends StatelessWidget {
  const _PlantItemCard({required this.plant, required this.onOpen});

  final PlantModel plant;
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
        onTap: () => onOpen(plant.nama),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Gambar tanaman
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  plant.gambar,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 70,
                    height: 70,
                    color: colorScheme.primaryContainer,
                    child: Icon(Icons.eco, color: colorScheme.primary),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Nama dan deskripsi
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plant.nama,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      plant.deskripsi,
                      style: Theme.of(context).textTheme.bodyMedium,
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