import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/widgets/app_card.dart';

class MiniJeuxScreen extends StatelessWidget {
  const MiniJeuxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lobby Mini-Jeux')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Jeux Disponibles', style: AppTextStyles.h3),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _GameCard(
                  title: 'Puzzle Drapeau',
                  icon: Icons.extension_rounded,
                  color: AppColors.primary,
                  delay: 0,
                ),
                _GameCard(
                  title: 'Quiz Chrono',
                  icon: Icons.timer_rounded,
                  color: AppColors.accent,
                  delay: 100,
                ),
                _GameCard(
                  title: 'Gestion Village',
                  icon: Icons.location_city_rounded,
                  color: AppColors.purple,
                  delay: 200,
                ),
                _GameCard(
                  title: 'Choix & Destin',
                  icon: Icons.alt_route_rounded,
                  color: AppColors.secondary,
                  delay: 300,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GameCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final int delay;

  const _GameCard({required this.title, required this.icon, required this.color, required this.delay});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.15), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 36),
          ),
          const SizedBox(height: 16),
          Text(title, style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(color: AppColors.surfaceAlt, borderRadius: BorderRadius.circular(8)),
            child: Text('+XP', style: AppTextStyles.stats.copyWith(fontSize: 12, color: color)),
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: delay)).scaleXY(begin: 0.9, end: 1.0);
  }
}
