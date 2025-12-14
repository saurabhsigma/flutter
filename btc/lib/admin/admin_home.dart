import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/gradient_card.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Portal')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          GradientCard(
            title: 'Create New Test',
            subtitle: 'Add questions, set timer, publish.',
            icon: Icons.add_task,
            gradientColors: const [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
            onTap: () => context.push('/admin/create-test'),
          ),
          GradientCard(
            title: 'Upload Study Material',
            subtitle: 'Upload PDFs and Notes.',
            icon: Icons.upload_file,
            gradientColors: const [Color(0xFF00B4DB), Color(0xFF0083B0)],
            onTap: () => context.push('/admin/upload-material'),
          ),
        ],
      ),
    );
  }
}
