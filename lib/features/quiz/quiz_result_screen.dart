import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/progress_ring.dart';
import '../../data/quiz_data.dart';

class QuizResultScreen extends StatefulWidget {
  final QuizModel quiz;
  final int score;

  const QuizResultScreen({super.key, required this.quiz, required this.score});

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    final percentage = widget.score / widget.quiz.questionsCount;
    if (percentage > 0.8) {
      _confettiController.play();
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final percentage = widget.score / widget.quiz.questionsCount;
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              colors: const [AppColors.primary, AppColors.secondary, AppColors.accent, AppColors.purple],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Quiz Terminé', style: AppTextStyles.h1),
                  const SizedBox(height: 8),
                  Text(widget.quiz.title, style: AppTextStyles.bodyLarge.copyWith(color: widget.quiz.color)),
                  const SizedBox(height: 48),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ProgressRing(
                        progress: percentage,
                        size: 200,
                        activeColor: percentage > 0.5 ? AppColors.success : AppColors.accent,
                        strokeWidth: 16,
                      ),
                      Column(
                        children: [
                          Text('${widget.score}/${widget.quiz.questionsCount}', style: AppTextStyles.h1),
                          Text('Score', style: AppTextStyles.bodyMedium),
                        ],
                      ),
                    ],
                  ).animate().scale(duration: 800.ms, curve: Curves.easeOutBack),
                  const SizedBox(height: 48),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star_rounded, color: AppColors.primary, size: 32),
                        const SizedBox(width: 12),
                        Text('+${widget.quiz.xpReward} XP', style: AppTextStyles.h2.copyWith(color: AppColors.primary)),
                      ],
                    ),
                  ).animate().slideY(begin: 0.5, end: 0, delay: 500.ms).fadeIn(),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          text: 'Partager',
                          isPrimary: false,
                          icon: Icons.share_rounded,
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AppButton(
                          text: 'Retour',
                          onPressed: () => context.go('/quiz'),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 800.ms),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
