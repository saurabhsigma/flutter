import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../dummy_data/providers.dart';
import '../../theme/app_colors.dart';

class TestDetailScreen extends ConsumerWidget {
  final String testId;

  const TestDetailScreen({super.key, required this.testId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTest = ref.watch(testProvider(testId));

    return asyncTest.when(
      data: (test) {
        if (test == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('Test not found')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(test.title),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Hero Icon
                 Center(
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.quiz, size: 80, color: AppColors.primaryBlue),
                  ),
                ),
                const SizedBox(height: 30),
                
                // Title & Info
                Text(
                  test.title,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  test.subtitle,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Stats Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildInfoItem(Icons.question_answer, '${test.questionCount} Questions'),
                    _buildInfoItem(Icons.timer, '${test.durationMinutes} Mins'),
                    _buildInfoItem(Icons.bar_chart, test.difficulty),
                  ],
                ),
                const Spacer(),

                // Instructions
                const Text(
                  "Instructions:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                const Text(
                  "• Read all questions carefully.\n• No negative marking.\n• Click submit once done.",
                  style: TextStyle(height: 1.5),
                ),
                const SizedBox(height: 30),

                // Start Button
                ElevatedButton(
                  onPressed: () {
                    context.push('/home/tests/$testId/attempt');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  child: const Text('Start Test'),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, s) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }

  Widget _buildInfoItem(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primaryViolet, size: 28),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
