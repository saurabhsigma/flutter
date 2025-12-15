import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/test_model.dart';
import '../models/content_models.dart';
// ...existing code...
import '../repositories/test_repository.dart';
import '../repositories/video_repository.dart';
import '../repositories/material_repository.dart';

// Live data providers using Firestore
final testsProvider = StreamProvider<List<TestModel>>((ref) {
  final repo = ref.watch(testRepositoryProvider);
  return repo.getTests();
});

final videosProvider = StreamProvider<List<VideoModel>>((ref) {
  final repo = ref.watch(videoRepositoryProvider);
  return repo.getVideos();
});

final materialsProvider = StreamProvider<List<MaterialModel>>((ref) {
  final repo = ref.watch(materialRepositoryProvider);
  return repo.getMaterials();
});

// State for fetching specific items
final testProvider = FutureProvider.family<TestModel?, String>((ref, id) {
  final repo = ref.watch(testRepositoryProvider);
  return repo.getTest(id);
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
