import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../dummy_data/providers.dart';
import '../../models/test_model.dart';
import '../../theme/app_colors.dart';

// Local state for the current attempt
class TestAttemptState {
  final Map<String, int> answers; // questionId -> selectedOptionIndex
  final int currentQuestionIndex;

  TestAttemptState({this.answers = const {}, this.currentQuestionIndex = 0});

  TestAttemptState copyWith({
    Map<String, int>? answers,
    int? currentQuestionIndex,
  }) {
    return TestAttemptState(
      answers: answers ?? this.answers,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
    );
  }
}

class TestAttemptScreen extends ConsumerStatefulWidget {
  final String testId;

  const TestAttemptScreen({super.key, required this.testId});

  @override
  ConsumerState<TestAttemptScreen> createState() => _TestAttemptScreenState();
}

class _TestAttemptScreenState extends ConsumerState<TestAttemptScreen> {
  TestAttemptState _state = TestAttemptState();
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _selectAnswer(String questionId, int optionIndex) {
    final newAnswers = Map<String, int>.from(_state.answers);
    newAnswers[questionId] = optionIndex;
    setState(() {
      _state = _state.copyWith(answers: newAnswers);
    });
  }

  void _nextQuestion(int totalQuestions) {
    if (_state.currentQuestionIndex < totalQuestions - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      setState(() {
        _state = _state.copyWith(currentQuestionIndex: _state.currentQuestionIndex + 1);
      });
    }
  }

  void _previousQuestion() {
    if (_state.currentQuestionIndex > 0) {
      _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      setState(() {
        _state = _state.copyWith(currentQuestionIndex: _state.currentQuestionIndex - 1);
      });
    }
  }

  void _submitTest(TestModel test) {
    // Calculate score
    int score = 0;
    test.questions.forEach((q) {
      if (_state.answers[q.id] == q.correctOptionIndex) {
        score++;
      }
    });

    // Save result
    final result = TestResult(
      testId: test.id,
      score: score,
      totalQuestions: test.questionCount,
      date: DateTime.now(),
      answers: _state.answers,
    );
    ref.read(testResultsProvider.notifier).addResult(result);

    // Navigate to Result Screen
    context.go(
      '/home/tests/result', 
      extra: {
        'testId': test.id,
        'score': score,
        'totalQuestions': test.questionCount,
        'answers': _state.answers,
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final test = ref.watch(testProvider(widget.testId));

    if (test == null) return const Scaffold(body: Center(child: Text('Error')));

    return Scaffold(
      appBar: AppBar(
        title: Text(test.title),
        automaticallyImplyLeading: false, // Prevent back button during test
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(child: Text("Q: ${_state.currentQuestionIndex + 1}/${test.questionCount}")),
          )
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Disable swipe
        itemCount: test.questions.length,
        itemBuilder: (context, index) {
          final question = test.questions[index];
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Question ${index + 1}",
                  style: const TextStyle(color: AppColors.primaryViolet, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  question.question,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 30),
                ...List.generate(question.options.length, (optIndex) {
                   final isSelected = _state.answers[question.id] == optIndex;
                   return Card(
                      color: isSelected ? AppColors.primaryBlue.withOpacity(0.1) : null,
                      elevation: isSelected ? 0 : 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: isSelected ? const BorderSide(color: AppColors.primaryBlue, width: 2) : BorderSide.none,
                      ),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: () => _selectAnswer(question.id, optIndex),
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                           padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                           child: Row(
                             children: [
                               Container(
                                 width: 24,
                                 height: 24,
                                 decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   border: Border.all(
                                     color: isSelected ? AppColors.primaryBlue : Colors.grey,
                                     width: 2,
                                   ),
                                   color: isSelected ? AppColors.primaryBlue : Colors.transparent,
                                 ),
                                 child: isSelected ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
                               ),
                               const SizedBox(width: 16),
                               Text(question.options[optIndex], style: const TextStyle(fontSize: 16)),
                             ],
                           ),
                        ),
                      ),
                   );
                }),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0, -5))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_state.currentQuestionIndex > 0)
              TextButton.icon(
                onPressed: _previousQuestion,
                icon: const Icon(Icons.arrow_back),
                label: const Text('Previous'),
              )
            else
              const SizedBox(width: 100), // Spacer
            
            if (_state.currentQuestionIndex < test.questionCount - 1)
              ElevatedButton.icon(
                onPressed: () => _nextQuestion(test.questionCount),
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Next'),
              )
            else
              ElevatedButton.icon(
                onPressed: () => _submitTest(test),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.success),
                icon: const Icon(Icons.check_circle),
                label: const Text('Submit'),
              ),
          ],
        ),
      ),
    );
  }
}
