import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../data/quiz_data.dart';
import 'quiz_result_screen.dart';

class QuizActiveScreen extends StatefulWidget {
  final QuizModel quiz;
  const QuizActiveScreen({super.key, required this.quiz});

  @override
  State<QuizActiveScreen> createState() => _QuizActiveScreenState();
}

class _QuizActiveScreenState extends State<QuizActiveScreen> {
  int currentQuestion = 0;
  int score = 0;
  bool answered = false;
  int? selectedOption;

  final options = ['Option A', 'Option B', 'Option C', 'Option D'];
  final correctIndex = 1; // Fake correct answer

  void _handleAnswer(int index) {
    if (answered) return;
    setState(() {
      selectedOption = index;
      answered = true;
      if (index == correctIndex) score++;
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      if (currentQuestion < widget.quiz.questionsCount - 1) {
        setState(() {
          currentQuestion++;
          answered = false;
          selectedOption = null;
        });
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => QuizResultScreen(quiz: widget.quiz, score: score)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quiz.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (currentQuestion + 1) / widget.quiz.questionsCount,
            backgroundColor: AppColors.surfaceAlt,
            valueColor: AlwaysStoppedAnimation<Color>(widget.quiz.color),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 60, height: 60,
                    child: CircularProgressIndicator(value: 0.7, strokeWidth: 6, backgroundColor: AppColors.surfaceAlt, color: widget.quiz.color),
                  ),
                  Text('20', style: AppTextStyles.h3),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Text('Question ${currentQuestion + 1}', style: AppTextStyles.bodyMedium.copyWith(color: widget.quiz.color)),
            const SizedBox(height: 8),
            Text('Ceci est une question exemple très intéressante sur le sujet ?', style: AppTextStyles.h2, textAlign: TextAlign.center),
            const SizedBox(height: 48),
            ...List.generate(options.length, (index) {
              Color bgColor = AppColors.surface;
              Color borderColor = Colors.white.withValues(alpha: 0.08);
              if (answered) {
                if (index == correctIndex) {
                  bgColor = AppColors.success.withValues(alpha: 0.15);
                  borderColor = AppColors.success;
                } else if (index == selectedOption) {
                  bgColor = AppColors.error.withValues(alpha: 0.15);
                  borderColor = AppColors.error;
                }
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: () => _handleAnswer(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: borderColor, width: answered && (index == correctIndex || index == selectedOption) ? 2 : 1),
                    ),
                    child: Text(options[index], style: AppTextStyles.bodyLarge),
                  ),
                ).animate(target: answered && index == selectedOption && index != correctIndex ? 1 : 0).shake(),
              );
            }),
            if (answered)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(selectedOption == correctIndex ? '🎉 Bonne réponse !' : '❌ Mauvaise réponse', style: AppTextStyles.h3.copyWith(color: selectedOption == correctIndex ? AppColors.success : AppColors.error)),
              ).animate().fadeIn().slideY(begin: 0.5),
          ],
        ),
      ),
    );
  }
}
