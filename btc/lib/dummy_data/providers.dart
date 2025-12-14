import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/test_model.dart';
import '../models/content_models.dart';
import 'mock_data.dart';

// Read-only data providers
final testsProvider = Provider<List<TestModel>>((ref) {
  return MockData.tests;
});

final videosProvider = Provider<List<VideoModel>>((ref) {
  return MockData.videos;
});

final materialsProvider = Provider<List<MaterialModel>>((ref) {
  return MockData.materials;
});

// State for fetching specific items
final testProvider = Provider.family<TestModel?, String>((ref, id) {
  final tests = ref.watch(testsProvider);
  try {
    return tests.firstWhere((t) => t.id == id);
  } catch (e) {
    return null;
  }
});

// --- User Progress State ---

class TestResult {
  final String testId;
  final int score;
  final int totalQuestions;
  final DateTime date;
  final Map<String, int> answers; // questionId -> selectedOptionIndex

  TestResult({
    required this.testId,
    required this.score,
    required this.totalQuestions,
    required this.date,
    required this.answers,
  });
}

class TestResultsNotifier extends StateNotifier<List<TestResult>> {
  TestResultsNotifier() : super([]);

  void addResult(TestResult result) {
    state = [...state, result];
  }
}

final testResultsProvider = StateNotifierProvider<TestResultsNotifier, List<TestResult>>((ref) {
  return TestResultsNotifier();
});
