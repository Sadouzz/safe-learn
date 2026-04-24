import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/widgets/gradient_card.dart';
import '../../core/widgets/app_card.dart';
import '../../data/user_mock.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Profil'),
        actions: [
          IconButton(icon: const Icon(Icons.settings_outlined), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 100, height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 3),
                      color: AppColors.surfaceAlt,
                    ),
                    child: Center(child: Text(mockUser.avatar, style: const TextStyle(fontSize: 48))),
                  ),
                  Positioned(
                    bottom: 0, right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                      child: const Icon(Icons.edit_rounded, color: AppColors.background, size: 16),
                    ),
                  ),
                ],
              ),
            ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
            const SizedBox(height: 16),
            Text(mockUser.name, style: AppTextStyles.h2),
            Text('${mockUser.role} • ${mockUser.country}', style: AppTextStyles.bodyMedium),
            const SizedBox(height: 32),
            GradientCard(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Niveau ${mockUser.level}', style: AppTextStyles.h3),
                      Text('${mockUser.xp} XP', style: AppTextStyles.stats),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: 0.6,
                    backgroundColor: AppColors.background.withValues(alpha: 0.3),
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 8),
                  Text('400 XP avant le niveau ${mockUser.level + 1}', style: AppTextStyles.bodySmall.copyWith(color: Colors.white70)),
                ],
              ),
            ).animate().slideY(begin: 0.2, end: 0, duration: 400.ms),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: _StatBox(title: 'Quiz', value: '12', icon: Icons.psychology_rounded, color: AppColors.primary)),
                const SizedBox(width: 16),
                Expanded(child: _StatBox(title: 'Missions', value: '5', icon: Icons.eco_rounded, color: AppColors.secondary)),
                const SizedBox(width: 16),
                Expanded(child: _StatBox(title: 'Pays', value: '2', icon: Icons.public_rounded, color: AppColors.purple)),
              ],
            ).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 32),
            Align(alignment: Alignment.centerLeft, child: Text('Badges Récents', style: AppTextStyles.h3)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _BadgeIcon(icon: Icons.local_fire_department_rounded, color: AppColors.accent, label: 'En feu'),
                _BadgeIcon(icon: Icons.star_rounded, color: AppColors.primary, label: 'Parfait'),
                _BadgeIcon(icon: Icons.recycling_rounded, color: AppColors.secondary, label: 'Écolo'),
              ],
            ).animate().fadeIn(delay: 400.ms),
          ],
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatBox({required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 8),
          Text(value, style: AppTextStyles.h3),
          Text(title, style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}

class _BadgeIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const _BadgeIcon({required this.icon, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(shape: BoxShape.circle, color: color.withValues(alpha: 0.15), border: Border.all(color: color.withValues(alpha: 0.5))),
          child: Icon(icon, color: color, size: 32),
        ),
        const SizedBox(height: 8),
        Text(label, style: AppTextStyles.bodySmall),
      ],
    );
  }
}
