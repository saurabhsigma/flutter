import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../dummy_data/providers.dart';
import '../../theme/app_colors.dart';

class TestListScreen extends ConsumerWidget {
  const TestListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tests = ref.watch(testsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Series'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tests.length,
        itemBuilder: (context, index) {
          final test = tests[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: InkWell(
              onTap: () {
                // Navigate to detail screen
                context.push('/home/tests/${test.id}');
              },
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            test.difficulty,
                            style: const TextStyle(
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.timer_outlined, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text('${test.durationMinutes} min', style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      test.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      test.subtitle,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.quiz_outlined, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text('${test.questionCount} Questions', style: const TextStyle(color: Colors.grey)),
                        const Spacer(),
                        const Text(
                          'Start Test',
                          style: TextStyle(
                            color: AppColors.primaryViolet,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(Icons.arrow_forward, size: 16, color: AppColors.primaryViolet),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ).animate().fadeIn(delay: Duration(milliseconds: index * 100 + 100)).slideY(begin: 0.1, end: 0);
        },
      ),
    );
  }
}
