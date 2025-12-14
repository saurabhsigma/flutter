import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../theme/app_colors.dart';

class TestResultScreen extends StatelessWidget {
  final String testId;
  final int score;
  final int totalQuestions;
  final Map<String, int> answers; // Pass answers mainly for review navigation if state management was deeper

  const TestResultScreen({
    super.key,
    required this.testId,
    required this.score,
    required this.totalQuestions,
    required this.answers,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = score / totalQuestions;

    return Scaffold(
      appBar: AppBar(title: const Text('Test Result')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Spacer(),
            CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 15.0,
              percent: percentage,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${(percentage * 100).toInt()}%",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
                  ),
                  const Text("Score"),
                ],
              ),
              progressColor: percentage > 0.7 ? AppColors.success : (percentage > 0.4 ? AppColors.warning : AppColors.error),
              backgroundColor: Colors.grey[200]!,
              circularStrokeCap: CircularStrokeCap.round,
              animation: true,
            ),
            const SizedBox(height: 40),
            Text(
              "You scored $score out of $totalQuestions",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
             const SizedBox(height: 10),
            Text(
              percentage > 0.7 ? "Excellent job!" : "Keep practicing!",
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // In a real app we'd pass the actual answers/result ID to the review screen
                  // Here we just navigate to a general review route
                  context.push('/home/tests/$testId/review'); 
                },
                child: const Text('Review Answers'),
              ),
            ),
            const SizedBox(height: 16),
             SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.go('/home');
                },
                child: const Text('Back to Home'),
              ),
            ),
             const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
