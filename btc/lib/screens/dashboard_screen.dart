import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Progress')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Cards
            Row(
              children: [
                Expanded(child: _buildStatCard('Tests Taken', '12', Icons.task_alt, Colors.green)),
                const SizedBox(width: 16),
                Expanded(child: _buildStatCard('Avg. Score', '85%', Icons.analytics, Colors.orange)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildStatCard('Videos', '5', Icons.play_circle_outline, Colors.blue)),
                const SizedBox(width: 16),
                Expanded(child: _buildStatCard('Materials', '3', Icons.download_done, Colors.purple)),
              ],
            ),
            
            const SizedBox(height: 30),
            const Text("Performance History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            // Bar Chart
            Container(
              height: 300,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
              ),
              child: BarChart(
                BarChartData(
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                     leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                     rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                     topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                     bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            switch (value.toInt()) {
                              case 0: return const Text('GK');
                              case 1: return const Text('Math');
                              case 2: return const Text('Eng');
                              case 3: return const Text('Sci');
                              default: return const Text('');
                            }
                          }
                        )
                     ),
                  ),
                  barGroups: [
                    _makeGroupData(0, 8, AppColors.primaryBlue),
                    _makeGroupData(1, 10, AppColors.primaryViolet),
                    _makeGroupData(2, 6, AppColors.accentPink),
                    _makeGroupData(3, 9, AppColors.accentCyan),
                  ],
                ),
              ),
            ),
             const SizedBox(height: 30),
             Container(
               padding: const EdgeInsets.all(20),
               decoration: BoxDecoration(
                 color: AppColors.primaryBlue.withOpacity(0.1),
                 borderRadius: BorderRadius.circular(16)
               ),
               child: const Row(
                 children: [
                   Icon(Icons.lightbulb, color: AppColors.primaryBlue),
                   SizedBox(width: 16),
                   Expanded(child: Text("Keep practicing! You are in the top 10% of students this week."))
                 ],
               ),
             )
          ],
        ),
      ),
    );
  }

  BarChartGroupData _makeGroupData(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 20,
          borderRadius: BorderRadius.circular(4),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 10,
            color: Colors.grey[200],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 10),
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        ],
      ),
    );
  }
}
