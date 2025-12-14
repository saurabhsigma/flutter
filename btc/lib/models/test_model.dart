class TestModel {
  final String id;
  final String title;
  final String subtitle;
  final int questionCount;
  final int durationMinutes;
  final String difficulty; // Easy, Medium, Hard
  final List<QuestionModel> questions;

  const TestModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.questionCount,
    required this.durationMinutes,
    required this.difficulty,
    required this.questions,
  });
}

class QuestionModel {
  final String id;
  final String question;
  final List<String> options;
  final int correctOptionIndex;

  const QuestionModel({
    required this.id,
    required this.question,
    required this.options,
    required this.correctOptionIndex,
  });
}
