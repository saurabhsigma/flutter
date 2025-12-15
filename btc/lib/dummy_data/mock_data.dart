import '../models/test_model.dart';
import '../models/content_models.dart';

class MockData {
  static const List<TestModel> tests = [
    TestModel(
      id: 't1',
      title: 'General Knowledge 101',
      subtitle: 'Basic GK for beginners',
      questionCount: 5,
      durationMinutes: 10,
      difficulty: 'Easy',
      questions: [
        QuestionModel(
          id: 'q1',
          question: 'What is the capital of France?',
          options: ['Berlin', 'Paris', 'Madrid', 'Lisbon'],
          correctOptionIndex: 1,
        ),
        QuestionModel(
          id: 'q2',
          question: 'Who wrote "Hamlet"?',
          options: ['Charles Dickens', 'Jane Austen', 'William Shakespeare', 'Mark Twain'],
          correctOptionIndex: 2,
        ),
        QuestionModel(
          id: 'q3',
          question: 'What is the largest planet in our solar system?',
          options: ['Earth', 'Mars', 'Jupiter', 'Saturn'],
          correctOptionIndex: 2,
        ),
         QuestionModel(
          id: 'q4',
          question: 'Which element has the chemical symbol "O"?',
          options: ['Gold', 'Orange', 'Oxygen', 'Osmium'],
          correctOptionIndex: 2,
        ),
         QuestionModel(
          id: 'q5',
          question: 'How many continents are there?',
          options: ['5', '6', '7', '8'],
          correctOptionIndex: 2,
        ),
      ],
    ),
    TestModel(
      id: 't2',
      title: 'Reasoning Drill',
      subtitle: 'Sharpen your logic',
      questionCount: 3,
      durationMinutes: 15,
      difficulty: 'Medium',
      questions: [
        QuestionModel(
          id: 'r1',
          question: '2, 4, 8, 16, ?',
          options: ['30', '32', '24', '18'],
          correctOptionIndex: 1,
        ),
        QuestionModel(
          id: 'r2',
          question: 'If CAT = 3120, then DOG = ?',
          options: ['4157', '4120', '3210', '4050'], // Arbitrary logic for dummy
          correctOptionIndex: 0,
        ),
         QuestionModel(
          id: 'r3',
          question: 'Blue is to Sky as Green is to?',
          options: ['Water', 'Grass', 'Fire', 'Cloud'],
          correctOptionIndex: 1,
        ),
      ],
    ),
    TestModel(
      id: 't3',
      title: 'Math Challenger',
      subtitle: 'Advanced Algebra',
      questionCount: 4,
      durationMinutes: 20,
      difficulty: 'Hard',
      questions: [
        QuestionModel(
          id: 'm1',
          question: 'Solve for x: 2x + 5 = 15',
          options: ['5', '10', '2.5', '7.5'],
          correctOptionIndex: 0,
        ),
        QuestionModel(
          id: 'm2',
          question: 'What is the square root of 144?',
          options: ['10', '11', '12', '13'],
          correctOptionIndex: 2,
        ),
        QuestionModel(
          id: 'm3',
          question: '15% of 200 is?',
          options: ['20', '30', '40', '25'],
          correctOptionIndex: 1,
        ),
        QuestionModel(
          id: 'm4',
          question: 'Meaning of Pi (approx)?',
          options: ['3.14', '3.41', '3.12', '3.16'],
          correctOptionIndex: 0,
        ),
      ],
    ),
  ];

  static const List<VideoModel> videos = [
    VideoModel(
      id: 'v1',
      title: 'Integration Basics',
      duration: '12:45',
      thumbnailUrl: 'https://img.youtube.com/vi/5p2Q-Z18Zss/0.jpg', // Dynamic YT thumb
      description: 'Learn the fundamentals of calculus integration.',
      youtubeId: '5p2Q-Z18Zss', // Example: Calculus
    ),
    VideoModel(
      id: 'v2',
      title: 'Modern History Overview',
      duration: '45:00',
      thumbnailUrl: 'https://img.youtube.com/vi/HP7L8bw5FvE/0.jpg',
      description: 'A deep dive into the industrial revolution.',
      youtubeId: 'HP7L8bw5FvE', // Example: History
    ),
    VideoModel(
      id: 'v3',
      title: 'English Grammar Tips',
      duration: '08:30',
      thumbnailUrl: 'https://img.youtube.com/vi/1X_IAaNPvKU/0.jpg',
      description: 'Quick tips to improve your writing.',
      youtubeId: '1X_IAaNPvKU', // Example: Grammar
    ),
  ];

  static const List<MaterialModel> materials = [
    MaterialModel(
      id: 'm1',
      title: 'Formula Sheet - Physics',
      subject: 'Physics',
      description: 'All important physics formulas in one place.',
    ),
    MaterialModel(
      id: 'm2',
      title: 'History Timeline',
      subject: 'Hisory',
      description: 'From 1800 to 1947.',
    ),
    MaterialModel(
      id: 'm3',
      title: 'Vocabulary List',
      subject: 'English',
      description: 'Top 1000 words for competitive exams.',
    ),
  ];
}
