// lib/features/plants/plants_detail_screen.dart

import 'package:flutter/material.dart';
import '../../data/dummy_data.dart';
import '../../data/models/plant_model.dart';
import '../../shared/widgets/loading_widget.dart';
import '../../shared/widgets/top_app_bar_widget.dart';

class PlantsDetailScreen extends StatefulWidget {
  const PlantsDetailScreen({super.key, required this.plantName});

  final String plantName;

  @override
  State<PlantsDetailScreen> createState() => _PlantsDetailScreenState();
}

class _PlantsDetailScreenState extends State<PlantsDetailScreen> {
  PlantModel? _plant;

  @override
  void initState() {
    super.initState();
    // Simulasi async data loading
    Future.microtask(() {
      final result = DummyData.getPlantsData()
          .where((p) => p.nama == widget.plantName)
          .firstOrNull;
      if (mounted) {
        setState(() => _plant = result);
        // Kembali jika data tidak ditemukan
        if (result == null && mounted) {
          Navigator.of(context).pop();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_plant == null) {
      return Scaffold(
        appBar: TopAppBarWidget(
          title: widget.plantName,
          showBackButton: true,
        ),
        body: const LoadingWidget(),
      );
    }

    return Scaffold(
      appBar: TopAppBarWidget(
        title: _plant!.nama,
        showBackButton: true,
      ),
      body: _PlantsDetailBody(plant: _plant!),
    );
  }
}

class _PlantsDetailBody extends StatelessWidget {
  const _PlantsDetailBody({required this.plant});

  final PlantModel plant;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Gambar dan nama
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Image.asset(
                  plant.gambar,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 250,
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: Icon(
                      Icons.eco,
                      size: 80,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  plant.nama,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Section Deskripsi
          _InfoCard(title: 'Deskripsi', content: plant.deskripsi),
          const SizedBox(height: 16),

          // Section Manfaat
          _InfoCard(title: 'Manfaat', content: plant.manfaat),
          const SizedBox(height: 16),

          // Section Efek Samping
          _InfoCard(title: 'Efek Samping', content: plant.efekSamping),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

/// Widget reusable untuk menampilkan info card
class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 4,
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Divider(height: 16),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}