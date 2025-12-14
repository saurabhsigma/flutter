import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';
import '../widgets/gradient_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beat The Competition'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome Back, Student!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              "What would you like to learn today?",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 30),
            
            // Test Series Card
            GradientCard(
              title: 'Test Series',
              subtitle: 'Practice with mock tests & quizzes',
              icon: Icons.quiz,
              gradientColors: const [AppColors.primaryBlue, AppColors.primaryViolet],
              onTap: () => context.go('/home/tests'),
              delay: 0.1,
            ),

            // Videos Card
            GradientCard(
              title: 'Video Lectures',
              subtitle: 'Watch high-quality study videos',
              icon: Icons.play_circle_fill,
              gradientColors: const [AppColors.accentPink, Color(0xFFC24D2C)],
              onTap: () => context.go('/home/videos'),
              delay: 0.2,
            ),

            // Free Material Card
            GradientCard(
              title: 'Free Materials',
              subtitle: 'Download PDFs and notes',
              icon: Icons.description,
              gradientColors: const [Color(0xFF11998E), Color(0xFF38EF7D)],
              onTap: () => context.go('/home/materials'),
              delay: 0.3,
            ),
          ],
        ),
      ),
    );
  }
}
