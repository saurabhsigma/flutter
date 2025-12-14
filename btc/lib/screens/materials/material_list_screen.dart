import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dummy_data/providers.dart';
import '../../theme/app_colors.dart';

class MaterialListScreen extends ConsumerWidget {
  const MaterialListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final materials = ref.watch(materialsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Study Materials')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: materials.length,
        itemBuilder: (context, index) {
          final material = materials[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryViolet.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.picture_as_pdf, color: AppColors.primaryViolet),
              ),
              title: Text(material.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${material.subject} • PDF'),
              trailing: IconButton(
                icon: const Icon(Icons.download_rounded),
                onPressed: () {
                   ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Downloading ${material.title}...')),
                  );
                },
              ),
            ),
          ).animate().fadeIn(delay: Duration(milliseconds: index * 100 + 100)).slideX(begin: 0.05, end: 0);
        },
      ),
    );
  }
}
