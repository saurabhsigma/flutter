import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/test_model.dart';

final testRepositoryProvider = Provider((ref) => TestRepository());

class TestRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'tests';

  // Fetch all tests
  Stream<List<TestModel>> getTests() {
    return _firestore.collection(_collection).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => _fromFirestore(doc)).toList();
    });
  }

  // Fetch single test
  Future<TestModel?> getTest(String id) async {
    final doc = await _firestore.collection(_collection).doc(id).get();
    if (doc.exists) {
      return _fromFirestore(doc);
    }
    return null;
  }

  // Create test
  Future<void> createTest(TestModel test) async {
    await _firestore.collection(_collection).doc(test.id).set(_toFirestore(test));
  }

  TestModel _fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TestModel(
      id: doc.id,
      title: data['title'] ?? '',
      subtitle: data['subtitle'] ?? '',
      questionCount: data['questionCount'] ?? 0,
       durationMinutes: data['durationMinutes'] ?? 0,
      difficulty: data['difficulty'] ?? 'Medium',
      questions: (data['questions'] as List<dynamic>? ?? []).map((q) {
        return QuestionModel(
          id: q['id'] ?? '',
          question: q['question'] ?? '',
          options: List<String>.from(q['options'] ?? []),
          correctOptionIndex: q['correctOptionIndex'] ?? 0,
        );
      }).toList(),
    );
  }

  Map<String, dynamic> _toFirestore(TestModel test) {
    return {
      'title': test.title,
      'subtitle': test.subtitle,
      'questionCount': test.questionCount,
      'durationMinutes': test.durationMinutes,
      'difficulty': test.difficulty,
      'questions': test.questions.map((q) => {
        'id': q.id,
        'question': q.question,
        'options': q.options,
        'correctOptionIndex': q.correctOptionIndex,
      }).toList(),
    };
  }
}
