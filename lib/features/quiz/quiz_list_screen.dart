import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/xp_badge.dart';
import '../../data/quiz_data.dart';
import 'quiz_active_screen.dart';

class QuizListScreen extends StatelessWidget {
  const QuizListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Sports')),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: mockQuizzes.length,
        itemBuilder: (context, index) {
          final quiz = mockQuizzes[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: AppCard(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => QuizActiveScreen(quiz: quiz)));
              },
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: quiz.color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(16)),
                    child: Icon(quiz.icon, color: quiz.color, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(quiz.category, style: AppTextStyles.bodySmall.copyWith(color: quiz.color)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(color: AppColors.surfaceAlt, borderRadius: BorderRadius.circular(8)),
                              child: Text(quiz.level, style: AppTextStyles.bodySmall),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(quiz.title, style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        if (quiz.progress > 0)
                          LinearPercentIndicator(
                            padding: EdgeInsets.zero,
                            lineHeight: 6,
                            percent: quiz.progress,
                            backgroundColor: AppColors.surfaceAlt,
                            progressColor: quiz.color,
                            barRadius: const Radius.circular(4),
                          )
                        else
                          Row(
                            children: [
                              Text('${quiz.questionsCount} questions', style: AppTextStyles.bodyMedium),
                              const Spacer(),
                              XpBadge(xp: quiz.xpReward, color: quiz.color),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
