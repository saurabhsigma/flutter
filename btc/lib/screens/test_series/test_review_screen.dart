import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dummy_data/providers.dart';
import '../../theme/app_colors.dart';

class TestReviewScreen extends ConsumerWidget {
  final String testId;
  // In a real app, we would pass the specific attempt ID to fetch selected answers.
  // For this mock, we will just show the correct answers.

  const TestReviewScreen({super.key, required this.testId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTest = ref.watch(testProvider(testId));

    return asyncTest.when(
      data: (test) {
        if (test == null) return const Scaffold(body: Center(child: Text('Test not found')));

        return Scaffold(
          appBar: AppBar(title: const Text('Review Answers')),
          body: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: test.questions.length,
            separatorBuilder: (c, i) => const Divider(height: 30),
            itemBuilder: (context, index) {
              final question = test.questions[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    "Q${index + 1}: ${question.question}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ...List.generate(question.options.length, (optIndex) {
                    final isCorrect = optIndex == question.correctOptionIndex;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isCorrect ? AppColors.success.withOpacity(0.1) : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: isCorrect ? Border.all(color: AppColors.success) : null,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isCorrect ? Icons.check_circle : Icons.circle_outlined,
                            size: 20,
                            color: isCorrect ? AppColors.success : Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            question.options[optIndex],
                            style: TextStyle(
                              color: isCorrect ? AppColors.success : Colors.black,
                              fontWeight: isCorrect ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              );
            },
          ),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, s) => Scaffold(body: Center(child: Text('Error: $e'))),
    );
  }
}
